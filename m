Return-Path: <netdev+bounces-214869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC315B2B959
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4CB1BA3C11
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B45726A0AD;
	Tue, 19 Aug 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hj52rV+/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4E2652B7;
	Tue, 19 Aug 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584786; cv=none; b=o7y9zH7OLq/e5H7QrcGwTdnOjgwS0nlD6jNl8FPjzydugCxy1SFxnryuKfRpcDIctmlLjjealfWqL21t8UTE94iDKYBf75UEweb8tM0imlkCI5l1mg4+A2zMO5t88yotuSoJ4f12WKt0wj6RPiKs2QfpeAMe+8FdtO2WViJggXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584786; c=relaxed/simple;
	bh=jqN7N0XM2l7RQwhd+QZ6BjPYyr1iA/Jzm1WRBpfTrJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=awnqCGjfCigyEayeqvA+NOpSyRCxtqj/jgTThBlTfBzpJ0s+1tXzQP6JiyvxtqugoNH9tRFK18k/yeEC4w5q6ySUUMK3O9NcdqD0jk9WJbKJehZmV1WbLBIl7DKKkdUtS8zbZnvB4TxINZrGvzHzXqKgQI17EUZymdB1gQULjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hj52rV+/; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Sb
	bv5QhPGynHMeq0UXb8e4p39yIC/4/NvEUYT0rkH8E=; b=hj52rV+/7o+bEUxs0C
	o6XIzcwLKBnDdTBayVG4CIwXMjC7wfO972WyS+tiLCfxQTNX0Ayc3UKkODNfeNls
	4FBDrZgged9HNb1fyli596syk6Ol0q9kWRlVJr38iCG6lkA/hvHcuxtHZlkBntz8
	QPrtfiUTTs7tFLu/h/h0S/9ow=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAH6YqzGKRoYzv4Cw--.51505S2;
	Tue, 19 Aug 2025 14:24:52 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: af_packet: Use hrtimer to do the retire operation
Date: Tue, 19 Aug 2025 14:24:51 +0800
Message-Id: <20250819062451.1089842-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH6YqzGKRoYzv4Cw--.51505S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw47ur4fJF4UCr4rJr4ruFg_yoW5Cw1UpF
	W5ZFy7GwsrXw429a1xXr4kZFWSyws3Jrn8Grs5W34Iywn8Gry5tFZF9FWYvFWUKas29F17
	ZF4FvryDAwn8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdUUUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibg2uCmikEt2QHgAAsK

On Mon, 2025-08-18 at 17:29 +0800, Willem wrote:

> "We" don't do anything in the middle of a computation. Anyway, branch is
> self explanatory enough, can drop comment.
> 
> >   */
> > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> > +		bool start)
> 
> Indentation, align with first argument on previous line


> > +	else
> > +		/* We cannot use hrtimer_forward_now here because the function
> > +		 * _prb_refresh_rx_retire_blk_timer can be called not only when
> > +		 * the retire timer expires, but also when the kernel logic for
> > +		 * receiving network packets detects that a network packet has
> > +		 * filled up a block and calls prb_open_block to use the next
> > +		 * block. This can lead to a WARN_ON being triggered in
> > +		 * hrtimer_forward_now when it checks if the timer has already
> > +		 * been enqueued.
> > +		 */
> 
> As discussed, this will be changed in v5.


I will change them in v5. And I will ensure that there is a 24-hour send gap between
each patch.


> >  {
> > -	mod_timer(&pkc->retire_blk_timer,
> > -			jiffies + pkc->tov_in_jiffies);
> > +	if (start)
> > +		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> > +			      HRTIMER_MODE_REL_SOFT);
> 
> It's okay to call this from inside a timer callback itself and return
> HRTIMER_RESTART? I don't know off the top of my head.

Although I have been using hrtimer_start to restart the timer within the callback in
our project and seem to work weill, I found that it seems no one does this in the
current mainline kernel code. Therefore, I will add a boolean parameter to the
callback in version 5 to indicate whether it is within the callback function. If it is
in the callback function, I will use hrtimer_forward_now instead of hrtimer_start.
Additionally, while looking at the historical Git logs of hrtimer, I noticed that it is
possible to call hrtimer_start to start the hrtimer outside of the hrtimer callback, but
it requires the protection of raw_spin_lock_irqsave. When entering the
_prb_refresh_rx_retire_blk_timer function, as noted in the comments, there is already
protection with the sk_buff_head lock, so I only need to add a set of irq save and restore
operations. The reason for this is based on the reference from link
https://lore.kernel.org/all/20150415113105.GT5029@twins.programming.kicks-ass.net/T/#u and
the implementation of the perf_mux_hrtimer_restart function.

The implementation of the _prb_refresh_rx_retire_blk_timer function in PATCH v5:

/*  Do NOT update the last_blk_num first.
 *  Assumes sk_buff_head lock is held.
 */
static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
					     bool start, bool callback)
{
	unsigned long flags;

	local_irq_save(flags);
	if (start && !callback)
		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
			      HRTIMER_MODE_REL_SOFT);
	else
		hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
	local_irq_restore(flags);
	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
}


Thanks
Xin Zhao


