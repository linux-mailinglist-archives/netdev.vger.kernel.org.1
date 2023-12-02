Return-Path: <netdev+bounces-53229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D800D801AC4
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91809281A81
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2EE46A4;
	Sat,  2 Dec 2023 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CscYVbRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F03619AD
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF4DC433C7;
	Sat,  2 Dec 2023 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701492435;
	bh=O5MsatmLjCIH3y5kNOZnBieUoRybd+cftsMxmoL19IM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CscYVbReNDZ8qotPJtXbn3qj1nIfd0nib1LkrGYXrSlH0IQWhCasA3wUQo2PtCgDx
	 LLxV6/zA4ZOgwfaUbLigTuToX2MUGt5GjD3MnlLHgxgchFAtcD5idFIQvSnjObXJlp
	 ZDuVpYfXo6HVqZ9cA8Nubuf/6rh78mCNBWirjGzcenUeuDC8IJPpB6jwPgx7tASax5
	 Wzt6+dTi/HIZnFyd3t5P20+9N1opE0mYDp0bsj+aoDtIAq4RW5u2PVKdo4YNjijgGE
	 knxgfhsyuGUX+juGk2jk837F22vWitao0m7fl71b/jz1zEV7mvgTl8mhwyTvZ3sv+D
	 V9YDEZL74lRFA==
Date: Fri, 1 Dec 2023 20:47:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lino Sanfilippo
 <LinoSanfilippo@gmx.de>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] qca_debug: Prevent crash on TX ring changes
Message-ID: <20231201204714.21f7124c@kernel.org>
In-Reply-To: <20231129095241.31302-2-wahrenst@gmx.net>
References: <20231129095241.31302-1-wahrenst@gmx.net>
	<20231129095241.31302-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 10:52:39 +0100 Stefan Wahren wrote:
> The qca_spi driver stop and restart the SPI kernel thread
> (via ndo_stop & ndo_open) in case of TX ring changes. This is
> a big issue because it allows userspace to prevent restart of
> the SPI kernel thread (via signals). A subsequent change of
> TX ring wrongly assume a valid spi_thread pointer which result
> in a crash.
> 
> So prevent this by stopping the network queue and temporary park
> the SPI thread. Because this could happen during transmission
> we also need to call qcaspi_flush_tx_ring().
> 
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Still looks a bit racy.

> diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
> index 6f2fa2a42770..9777dbb17ac2 100644
> --- a/drivers/net/ethernet/qualcomm/qca_debug.c
> +++ b/drivers/net/ethernet/qualcomm/qca_debug.c
> @@ -263,22 +263,29 @@ qcaspi_set_ringparam(struct net_device *dev, struct ethtool_ringparam *ring,
>  		     struct kernel_ethtool_ringparam *kernel_ring,
>  		     struct netlink_ext_ack *extack)
>  {
> -	const struct net_device_ops *ops = dev->netdev_ops;
>  	struct qcaspi *qca = netdev_priv(dev);
> +	bool queue_active = !netif_queue_stopped(dev);

nothing prevents stopped -> running or running -> stopped
transitions at this point, so this check can be meaningful

>  	if ((ring->rx_pending) ||
>  	    (ring->rx_mini_pending) ||
>  	    (ring->rx_jumbo_pending))
>  		return -EINVAL;
> 
> -	if (netif_running(dev))
> -		ops->ndo_stop(dev);
> +	if (queue_active)
> +		netif_stop_queue(dev);

This doesn't wait for xmit to finish, it just sets a bit.
You probably want something like netif_tx_disable().

Also - the thread may still be running and wake the queue up right after
we stop it.
-- 
pw-bot: cr

