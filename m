Return-Path: <netdev+bounces-155185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D56A0160B
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 18:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434A63A2EF2
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EED5823DE;
	Sat,  4 Jan 2025 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx/CTFSt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B21A270;
	Sat,  4 Jan 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736010067; cv=none; b=VnR5pSpa+2xS/jouqdAXYHOa3bZSK1FeTe+OJIvNlt/vj84BL/z72ink9l88iDPNhxwNrsgu8vkolRVTOEajgICEJ2F2WeRE5KGNw0GpSZj/1vlY3C+pjIM/dx32wlTbPodty65SL/dKcFHtgGz1M0fsnwm/w3ld/thJlmQju1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736010067; c=relaxed/simple;
	bh=Z0a0bpgSH12eBWltuQq6d7OIovq+Yt+1MHS3Vg3nwEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZglwCPYITgTEIArdVDZ9u2ijbG7N/5UYqQeGR625J4w3wCcbyzBmTmn5RarIaY81vYRcFn14Rtf8QA5DJS+8Y2k+HsaKpBJEteO5avVvjiZFaMnpaWhJCLBsER3ddK+dHqOHJYz80ge7uYke2kR7iVoi7YjWRpEEq+Dn66SPONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx/CTFSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A58C4CED1;
	Sat,  4 Jan 2025 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736010067;
	bh=Z0a0bpgSH12eBWltuQq6d7OIovq+Yt+1MHS3Vg3nwEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nx/CTFStsao019EzwLuxd8kwUm6iXfTRYu0DEiUVbjnrVIItDg54zkde0qucV0Rhs
	 vtN3HU8ijCUHha8uUh1/g+uKCU+Zay+rQlq9mwER+lOMCgHW0vqFtciRUvU07spak1
	 hYER9mZe+/q+RQ4Ukx0ms4zpaeipCWf0v1OObMv/l2wTrR2tUcVk423TpA52gVicNg
	 cZ68U81J9t9o99RHCH4/1u+T1mlOk7xeF02PLDkraHC56FS++PrfPUY3iocvC9gO3S
	 QhQeLkdoD6f1KDRiuP5uc7ZfA20wKdvaonUuY9JrskSLkT9iYktIFrKLxWa5X6QEXI
	 usrpkOh4VUg/g==
Date: Sat, 4 Jan 2025 09:01:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Abhijit
 Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>
Subject: Re: [PATCH net v4 1/4] octeon_ep: fix race conditions in
 ndo_get_stats64
Message-ID: <20250104090105.185c08df@kernel.org>
In-Reply-To: <20250102112246.2494230-2-srasheed@marvell.com>
References: <20250102112246.2494230-1-srasheed@marvell.com>
	<20250102112246.2494230-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 03:22:43 -0800 Shinas Rasheed wrote:
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 549436efc204..a452ee3b9a98 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -995,16 +995,14 @@ static void octep_get_stats64(struct net_device *netdev,
>  	struct octep_device *oct = netdev_priv(netdev);
>  	int q;
>  
> -	if (netif_running(netdev))
> -		octep_ctrl_net_get_if_stats(oct,
> -					    OCTEP_CTRL_NET_INVALID_VFID,
> -					    &oct->iface_rx_stats,
> -					    &oct->iface_tx_stats);
> -
>  	tx_packets = 0;
>  	tx_bytes = 0;
>  	rx_packets = 0;
>  	rx_bytes = 0;
> +
> +	if (!netif_running(netdev))
> +		return;

So we'll provide no stats when the device is down? That's not correct.
The driver should save the stats from the freed queues (somewhere in
the oct structure). Also please mention how this is synchronized
against netif_running() changing its state, device may get closed while
we're running..
-- 
pw-bot: cr

