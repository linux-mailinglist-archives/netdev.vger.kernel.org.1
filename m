Return-Path: <netdev+bounces-83718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A438937FD
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 06:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5424FB20FD4
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 04:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D4B749F;
	Mon,  1 Apr 2024 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HcNqsiZL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1D8F5D
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711945119; cv=none; b=vDA2cfT69Nzrky5c/XUk1NVE5TvEXF0BueJOizjkj3PSH8a8qNJRL8EzgrjglolyHNJoTaHCN/Y6kz270peayOENPjswSiEO+tGIvCnNkewI2AV3LWUmO5Z97XNNVA5sRp0YglsBnVn0EB7nhsx4rwr32+XaBsJUsWZ595/oMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711945119; c=relaxed/simple;
	bh=V5s0F38KFqCBsS+AJtRAqdV7JUSqcQgBZ099t8q+dUE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnBJqUCWkgVEzP11W5DMPAImE2JFMFeX11JmOami2Y049cB+raX/UZcAiQolDwnh+Ti326S/umSuRvhym85Q9cLnW8aBfeLjpzrtr9C0aJkN+DGOGRYdOAx97aH3GN0FFWrNsSUAduD23wKiLsZgIZ/I53cDv44sY2N0vCRCCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HcNqsiZL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4311muqH017402;
	Sun, 31 Mar 2024 21:18:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pfpt0220;
	 bh=7Ru/fkW5cyWdfdJ46vsJxkMQdTtu1+h9T0Ywckdp0+I=; b=HcNqsiZLCObp
	vFWG2BJOOTMvZBMlLGIf4Z3WyPzAlQwyxZ9F6ng+xpIS6zwFNQGkg9NNhXQiSTXc
	CuLpj12FKHOOU4+L7mIxUbcWjvJef5TTU3jR0sDme5ovaeg6BDrwqTJzatvndr21
	CFAEA8wF9wenpUfNeanU4FMq+4cSW4TbGH9HDzy6vlMX53pGLyQ0aIuHZpSgWSsb
	1hfFmck1dIA6EIv88F2aJvOLCFC9GYQKjrZDWHlOfkvXLBM3Sd0qa/toRvQqvgAI
	Btkf166Wz5XFGDIK8daOoEndLHXjs5ttBGCUQjzr4Kx7yRiQkJMbuZfQgKK5PsT9
	dTevmxBz6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x7kkcg9xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 21:18:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 31 Mar 2024 21:18:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 31 Mar 2024 21:18:15 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D61603F7051;
	Sun, 31 Mar 2024 21:18:11 -0700 (PDT)
Date: Mon, 1 Apr 2024 09:48:10 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Mark Brown <broonie@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Ronald Wahl <ronald.wahl@raritan.com>,
        Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ
 thread to fix hang
Message-ID: <20240401041810.GA1639126@maili.marvell.com>
References: <20240331142353.93792-1-marex@denx.de>
 <20240331142353.93792-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240331142353.93792-2-marex@denx.de>
X-Proofpoint-GUID: WwQBC43Z3B1z1LD0h9yKUB5jCDq1Sfk6
X-Proofpoint-ORIG-GUID: WwQBC43Z3B1z1LD0h9yKUB5jCDq1Sfk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_01,2024-03-28_01,2023-05-22_02

On 2024-03-31 at 19:51:46, Marek Vasut (marex@denx.de) wrote:
> The ks8851_irq() thread may call ks8851_rx_pkts() in case there are
> any packets in the MAC FIFO, which calls netif_rx(). This netif_rx()
> implementation is guarded by local_bh_disable() and local_bh_enable().
> The local_bh_enable() may call do_softirq() to run softirqs in case
> any are pending. One of the softirqs is net_rx_action, which ultimately
> reaches the driver .start_xmit callback. If that happens, the system
> hangs. The entire call chain is below:
>
> ks8851_start_xmit_par from netdev_start_xmit
> netdev_start_xmit from dev_hard_start_xmit
> dev_hard_start_xmit from sch_direct_xmit
> sch_direct_xmit from __dev_queue_xmit
> __dev_queue_xmit from __neigh_update
> __neigh_update from neigh_update
> neigh_update from arp_process.constprop.0
> arp_process.constprop.0 from __netif_receive_skb_one_core
> __netif_receive_skb_one_core from process_backlog
> process_backlog from __napi_poll.constprop.0
> __napi_poll.constprop.0 from net_rx_action
> net_rx_action from __do_softirq
> __do_softirq from call_with_stack
> call_with_stack from do_softirq
> do_softirq from __local_bh_enable_ip
> __local_bh_enable_ip from netif_rx
> netif_rx from ks8851_irq
> ks8851_irq from irq_thread_fn
> irq_thread_fn from irq_thread
> irq_thread from kthread
> kthread from ret_from_fork
>
> The hang happens because ks8851_irq() first locks a spinlock in
> ks8851_par.c ks8851_lock_par() spin_lock_irqsave(&ksp->lock, ...)
> and with that spinlock locked, calls netif_rx(). Once the execution
> reaches ks8851_start_xmit_par(), it calls ks8851_lock_par() again
> which attempts to claim the already locked spinlock again, and the
> hang happens.
>
> Move the do_softirq() call outside of the spinlock protected section
> of ks8851_irq() by disabling BHs around the entire spinlock protected
> section of ks8851_irq() handler. Place local_bh_enable() outside of
> the spinlock protected section, so that it can trigger do_softirq()
> without the ks8851_par.c ks8851_lock_par() spinlock being held, and
> safely call ks8851_start_xmit_par() without attempting to lock the
> already locked spinlock.
>
> Since ks8851_irq() is protected by local_bh_disable()/local_bh_enable()
> now, replace netif_rx() with __netif_rx() which is not duplicating the
> local_bh_disable()/local_bh_enable() calls.
>
> Fixes: 797047f875b5 ("net: ks8851: Implement Parallel bus operations")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/micrel/ks8851_common.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
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
>
>  				ks->netdev->stats.rx_packets++;
>  				ks->netdev->stats.rx_bytes += rxlen;
> @@ -325,11 +325,15 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>   */
>  static irqreturn_t ks8851_irq(int irq, void *_ks)
>  {
> +	bool need_bh_off = !(hardirq_count() | softirq_count());
IMO, in_task() macro would be better.

>  	struct ks8851_net *ks = _ks;
>  	unsigned handled = 0;
>  	unsigned long flags;
>  	unsigned int status;
>
> +	if (need_bh_off)
> +		local_bh_disable();
This threaded irq's thread function (ks8851_irq()) will always run in process context, right ?
Do you need "if(need_bh_off)" loop?

> +
>  	ks8851_lock(ks, &flags);
>
>  	status = ks8851_rdreg16(ks, KS_ISR);
> @@ -406,6 +410,9 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>  	if (status & IRQ_LCI)
>  		mii_check_link(&ks->mii);
>
> +	if (need_bh_off)
> +		local_bh_enable();
> +
>  	return IRQ_HANDLED;
>  }
>
> --
> 2.43.0
>

