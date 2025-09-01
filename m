Return-Path: <netdev+bounces-218708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F163EB3DFF4
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F62E174EB7
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673323002B1;
	Mon,  1 Sep 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JcI6dae9"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2F1A2630
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722001; cv=none; b=eu28aqMrm4GxNoMe+75h2+UUXJ7rWEHhTXIrbbOkfz+HJ+O6gBxT8/eVOALmrxPwEB5+WrZAPMHD3dESLaS7pmrJBQMgAXZgApCM+iFRL62gx21GoDNls5y2Tj+/eNuQL3PbU9uHlXR9omDBQ5wiUZ2TEAMSi7sBOYk8naByBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722001; c=relaxed/simple;
	bh=knXCTJ7nXFjg54S0eL5OHETHjxI/3Jvy0mCBTHTFpVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPjXND+mnMHmGA3XbgbmzA1Dlf/VWKx/iunv8Tg64vnXax/kGgPH6cnhsew1wrZlBWt/z3TOimxDHdQ2T0+poFNvWvtHZa+F+unIkSGC6gOOXdd+YKdeMgXDbsnOfOu4tyV6I6W03OCnJ2X/JgqdmVvHtVnsVOySCZygazqbsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JcI6dae9; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbc50956-4aa6-4484-be32-0b091d494bc1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756721987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1Lu4lbZeqTiTSFresTGVSwVmkAv3NGjMih3n+OiEoQ=;
	b=JcI6dae96WznBY5VD12N/7H95FDpyiXve5oImrc0iBROe6QGg7SypcjNkBPm4gTfpaPL2N
	eRgHo66sLUsC/F5s4Bzp7iaQV5ZkEAuRJGJ1K/HRk1Rz+tvcXFof3SopsuxDGgTek21f3b
	pDXcRBklJ5c5+1YZwwh0d0AQwYCeTSQ=
Date: Mon, 1 Sep 2025 11:19:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] phy: mscc: Stop taking ts_lock for tx_queue and
 use its own lock
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com, viro@zeniv.linux.org.uk,
 atenart@kernel.org, quentin.schulz@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901092304.1312787-1-horatiu.vultur@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250901092304.1312787-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/09/2025 10:23, Horatiu Vultur wrote:
> When transmitting a PTP frame which is timestamp using 2 step, the
> following warning appears if CONFIG_PROVE_LOCKING is enabled:
> =============================
> [ BUG: Invalid wait context ]
> 6.17.0-rc1-00326-ge6160462704e #427 Not tainted
> -----------------------------
> ptp4l/119 is trying to lock:
> c2a44ed4 (&vsc8531->ts_lock){+.+.}-{3:3}, at: vsc85xx_txtstamp+0x50/0xac
> other info that might help us debug this:
> context-{4:4}
> 4 locks held by ptp4l/119:
>   #0: c145f068 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x58/0x1440
>   #1: c29df974 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x5c4/0x1440
>   #2: c2aaaad0 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x108/0x350
>   #3: c2aac170 (&lan966x->tx_lock){+.-.}-{2:2}, at: lan966x_port_xmit+0xd0/0x350
> stack backtrace:
> CPU: 0 UID: 0 PID: 119 Comm: ptp4l Not tainted 6.17.0-rc1-00326-ge6160462704e #427 NONE
> Hardware name: Generic DT based system
> Call trace:
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x7c/0xac
>   dump_stack_lvl from __lock_acquire+0x8e8/0x29dc
>   __lock_acquire from lock_acquire+0x108/0x38c
>   lock_acquire from __mutex_lock+0xb0/0xe78
>   __mutex_lock from mutex_lock_nested+0x1c/0x24
>   mutex_lock_nested from vsc85xx_txtstamp+0x50/0xac
>   vsc85xx_txtstamp from lan966x_fdma_xmit+0xd8/0x3a8
>   lan966x_fdma_xmit from lan966x_port_xmit+0x1bc/0x350
>   lan966x_port_xmit from dev_hard_start_xmit+0xc8/0x2c0
>   dev_hard_start_xmit from sch_direct_xmit+0x8c/0x350
>   sch_direct_xmit from __dev_queue_xmit+0x680/0x1440
>   __dev_queue_xmit from packet_sendmsg+0xfa4/0x1568
>   packet_sendmsg from __sys_sendto+0x110/0x19c
>   __sys_sendto from sys_send+0x18/0x20
>   sys_send from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf0b05fa8 to 0xf0b05ff0)
> 5fa0:                   00000001 0000000e 0000000e 0004b47a 0000003a 00000000
> 5fc0: 00000001 0000000e 00000000 00000121 0004af58 00044874 00000000 00000000
> 5fe0: 00000001 bee9d420 00025a10 b6e75c7c
> 
> So, instead of using the ts_lock for tx_queue, use the spinlock that
> skb_buff_head has.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> v1->v2:
> - initialize tx_queue in ptp_probe
> - purge the tx_queue when the driver is removed or when TX timestamping
>    is OFF
> ---
>   drivers/net/phy/mscc/mscc_ptp.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> index 72847320cb652..e866a1d865f8b 100644
> --- a/drivers/net/phy/mscc/mscc_ptp.c
> +++ b/drivers/net/phy/mscc/mscc_ptp.c
> @@ -461,7 +461,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
>   		return;
>   
>   	while (len--) {
> -		skb = __skb_dequeue(&ptp->tx_queue);
> +		skb = skb_dequeue(&ptp->tx_queue);

Now as you switched to use spinlock of tx_queue, it is technically
correct to change skb_queue_len(&ptp->tx_queue) to
skb_queue_len_lockless(&ptp->tx_queue) a couple of lines above this
chunk.

Otherwise LGTM, once skb_queue_len fixed you can add

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


Thanks!

>   		if (!skb)
>   			return;
>   
> @@ -486,7 +486,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
>   		 * packet in the FIFO right now, reschedule it for later
>   		 * packets.
>   		 */
> -		__skb_queue_tail(&ptp->tx_queue, skb);
> +		skb_queue_tail(&ptp->tx_queue, skb);


