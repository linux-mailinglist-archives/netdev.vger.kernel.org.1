Return-Path: <netdev+bounces-83861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8B894A3F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D401F229A7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2351757D;
	Tue,  2 Apr 2024 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH2uIQP3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156917BA3
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712030804; cv=none; b=c8KK1pr0gP2mznmd4//E78dGvOCQ3dbqj7lG7S0EvjQxGsTIe8SijC/3uEBgbNarmBVqFJUmj0j1n+qP7xSaqkv1CXJolqdjbbQuvz/1ovX9tNNMSMecIm+J7cevysAO4G6p9VILpL2Ejss0MYGfOQeOEipm8nuHMITjHX9Z+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712030804; c=relaxed/simple;
	bh=5VslpywLra/GypL/oYkwFb1ot2st18eyzTTq+ozwnaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvmAxalgmBvLMrjjQJ2xqQY7XtvbehnwZu/lah0UrYHPZOrEuONKBC9F58qkxz4LNiUMLX4JYzgWwgcFYWpHk2bHCb/qO+H48jCBh3cEOuWyxJq6S6hfwl7+ZPDoX7VKeJeKd4FzQ9SwdeUKhPD/mRCeL8uEA31xvkTNW4mAkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH2uIQP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63804C433C7;
	Tue,  2 Apr 2024 04:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712030804;
	bh=5VslpywLra/GypL/oYkwFb1ot2st18eyzTTq+ozwnaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kH2uIQP3ivLHTZyf17j5gwMTmfEBC6aIpil8wzSZRwwZh/8zwm3XFz4wRPzCdVuiv
	 W0ZYNtV2OD4HOEvyU53Nxfk4HLxTdqIhHVkWElgNCNYFIKmYrdfiBXMNRhna+GL4tV
	 RTH9zcMuF5kJgcpxobMDklN1ewDocTCzsddxHmH0LDWzA8SyQokeALpZ9rlqWWbtdp
	 KVKU8KDQcAP1l2RqgU0lF9NTBhpciAdNSxz1qt3tVi69NGxEFGwAT6H1rIbZwK4hhX
	 uYzNj4gWQ2pKaTOmixS26HyrnKRos1C15dCfdO0ySvKpvXXM00P2DMR1msp1rydLf6
	 6hJTtigTFuzYw==
Date: Mon, 1 Apr 2024 21:06:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Eric Dumazet <edumazet@google.com>, Mark Brown
 <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ
 thread to fix hang
Message-ID: <20240401210642.76f0d989@kernel.org>
In-Reply-To: <20240331142353.93792-2-marex@denx.de>
References: <20240331142353.93792-1-marex@denx.de>
	<20240331142353.93792-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 16:21:46 +0200 Marek Vasut wrote:
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
> index 896d43bb8883d..b6b727e651f3d 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -299,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>  					ks8851_dbg_dumpkkt(ks, rxpkt);
>  
>  				skb->protocol = eth_type_trans(skb, ks->netdev);
> -				netif_rx(skb);
> +				__netif_rx(skb);

maybe return the packets from ks8851_rx_pkts()
(you can put them on a queue / struct sk_buff_head)
and process them once the lock is released?

Also why not NAPI?

>  				ks->netdev->stats.rx_packets++;
>  				ks->netdev->stats.rx_bytes += rxlen;
> @@ -325,11 +325,15 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>   */
>  static irqreturn_t ks8851_irq(int irq, void *_ks)
>  {
> +	bool need_bh_off = !(hardirq_count() | softirq_count());

I don't think IRQ / RT developers look approvingly at uses of such
low level macros in drivers.

