Return-Path: <netdev+bounces-167567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14DA3AF35
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D561894881
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D413C908;
	Wed, 19 Feb 2025 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXJHssyx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBC14F70;
	Wed, 19 Feb 2025 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930222; cv=none; b=c9VnFVveAFfiHUyeZM/ITHeuQIf9xic4eBs2pLG7YpWVzqSzaTut3H0YswFS01z3XGIwLWk4Vt8PSo5SYfuQz9kC2PWJpYbcaVMycA2kOfEgr6PrhwDJ7A6K4fxnbMjxSK2D4h6svcbC/06Pwrrjy6v8/99NcatkfJvd4LcA7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930222; c=relaxed/simple;
	bh=P2bCTM49kWzcXVkhkmaaeprhN/yl8fx/rlVARBMiD04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8rwxG/pJO/NDdBhHxywyuSTklsXEMsyria4A9ruGoAw4hP29zQ9lNrUwhJNukt5B3LIknyYlLynV1vlfYf1ZTriKw+pUSHwY0zE2bIP9hr9djT0d+mjowp7Y53zk7aYcpDIFZL45QPHO1xIBGiEgSZD6F0ZuCnbW7C6HrQjP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXJHssyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A82BC4CEE2;
	Wed, 19 Feb 2025 01:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739930221;
	bh=P2bCTM49kWzcXVkhkmaaeprhN/yl8fx/rlVARBMiD04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXJHssyxDiMYlDJF1P7twCBv3ITsGPDivWPay8d8la+1Cgt9/X48uoRqit6Eptcqn
	 js5FiYg+cqMK1A+rG70NWn7N9OJfD8kEqqeHL4Ak6ATU9KK9LJIZ+tGkeiKYUMOMaB
	 KCnmBIx1mRpIJxJ+0aFIQdex0XNkDaolYD2ZPEZQO/U+83hDWR9a6Mfi7fzmk1TpFF
	 wUiYEp1MK1oyg9MlBwV2/Ix09NSWvTjZVAqisfjYW0mekZ4Vc9xdQ0YS23M0ZCJau5
	 +aPS8G4NLBr1vGW8wIZy+z7fMHNwey4m5Tfn78IZkoxI0yAVIBU2lZVPd5Yr1esQd3
	 nV2r255W3cMDg==
Date: Tue, 18 Feb 2025 17:57:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next] net: cadence: macb: Implement BQL
Message-ID: <20250218175700.4493dc49@kernel.org>
In-Reply-To: <20250214211643.2617340-1-sean.anderson@linux.dev>
References: <20250214211643.2617340-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 16:16:43 -0500 Sean Anderson wrote:
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 48496209fb16..63c65b4bb348 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1081,6 +1081,9 @@ static void macb_tx_error_task(struct work_struct *work)
>  						      tx_error_task);
>  	bool			halt_timeout = false;
>  	struct macb		*bp = queue->bp;
> +	u32			queue_index = queue - bp->queues;

nit: breaking reverse xmas tree here

> +	u32			packets = 0;
> +	u32			bytes = 0;
>  	struct macb_tx_skb	*tx_skb;
>  	struct macb_dma_desc	*desc;
>  	struct sk_buff		*skb;


> @@ -3019,6 +3033,7 @@ static int macb_close(struct net_device *dev)
>  	netif_tx_stop_all_queues(dev);
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
>  		napi_disable(&queue->napi_rx);
>  		napi_disable(&queue->napi_tx);

I think you should reset after napi_disable()? 
Lest NAPI runs after the reset and tries to complete on an empty queue..
-- 
pw-bot: cr

