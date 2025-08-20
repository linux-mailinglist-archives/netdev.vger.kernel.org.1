Return-Path: <netdev+bounces-215165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03AB2D4BE
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F021586DD7
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E62D3EC2;
	Wed, 20 Aug 2025 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VFT3rWmZ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBDD2BE658;
	Wed, 20 Aug 2025 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674418; cv=none; b=Z62WnVGMXmR4hg4yPo6a4w7bvmHFplYEfY970MZ/SFU0WROGz3L6r15n+8aJII9XI3iOl5fCyvKnpW/b9AG0+m9anrKwoMcxGEmtlr6T7yKeq7izBSq9UmOknNqlmADhOB40Aogok3S9jtBf3ckjo3AqO5PRLUNpQ8EkJ2KcGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674418; c=relaxed/simple;
	bh=7HOKxrUvKplKKgaLnwZQmnZ4VX8STqhKTZ87oHVht8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UwFkn/P9wWdnmMCecNfyx+pNPyRun+oph7GhcY04qusMVOJcHPBoPpLqsZJMCLazwuOHjc+/PkcVb5Lma7kd6PSKr4580VI0BBT1nvOEU7/Hij1vq7Sub4VuuG01156HbT57Yt8iNsSxxQ0QpnvcW7GkaxLUIUzGBptWmeJ69FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VFT3rWmZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s/
	qhnnF0QCVTdmgfy6Wvgvf/fzbup9g9nnRAWERCjc0=; b=VFT3rWmZc/mvIpct7n
	U7F5phtQgPAQ/3j0QZs9iiUfx/VbR3SQDf30NTheJuvcOVtcNizvmlJXtw7EM8li
	trZQp9aJuGAtuJaYfGg7N2ARHU3nlPFr9WA7p1OIDVTScmBzuthI6Ebn9AMyf3XA
	fYDaNjuPC7VVniXiC5+ZTfs2E=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnb1bydqVo+uL0DA--.5809S2;
	Wed, 20 Aug 2025 15:19:15 +0800 (CST)
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
Date: Wed, 20 Aug 2025 15:19:14 +0800
Message-Id: <20250820071914.2029093-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb1bydqVo+uL0DA--.5809S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1xZrWUKr4fWF47Ar4kXrb_yoW5ZFW7pF
	W2gFyfGr4kJF1S9wnFya10q3WFqr4rtFyUGws5JryfArZxursxJFW7trWa9ay2vF4vg3y2
	vFsYqFZrAw1qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG385UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwqvCmilb+O1qAAAs0

On Tue, 2025-08-19 at 22:18 +0800, Willem wrote:

> > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> > +					     bool start, bool callback)
> >  {
> > -	mod_timer(&pkc->retire_blk_timer,
> > -			jiffies + pkc->tov_in_jiffies);
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> 
> The two environments that can race are the timer callback running in
> softirq context or the open_block from tpacket_rcv in process context.
> 
> So worst case the process context path needs to disable bh?
> 
> As you pointed out, the accesses to the hrtimer fields are already
> protected, by the caller holding sk.sk_receive_queue.lock.
> 
> So it should be sufficient to just test hrtimer_is_queued inside that
> critical section before calling hrtimer_start?
> 
> Side-note: tpacket_rcv calls spin_lock, not spin_lock_bh. But if the
> same lock can also be taken in softirq context, the process context
> caller should use the _bh variant. This is not new with your patch.
> Classical timers also run in softirq context. I may be overlooking
> something, will need to take a closer look at that.
> 
> In any case, I don't think local_irq_save is needed. 

Indeed, there is no need to use local_irq_save. The use case I referenced from
perf_mux_hrtimer_restart is different from ours. Our timer callback does not run in
hard interrupt context, so it is unnecessary to use local_irq_save. I will make this
change in PATCH v6.



On Wed, 2025-08-20 at 4:21 +0800, Willem wrote:
 
> > So worst case the process context path needs to disable bh?
> > 
> > As you pointed out, the accesses to the hrtimer fields are already
> > protected, by the caller holding sk.sk_receive_queue.lock.
> > 
> > So it should be sufficient to just test hrtimer_is_queued inside that
> > critical section before calling hrtimer_start?
> > 
> > Side-note: tpacket_rcv calls spin_lock, not spin_lock_bh. But if the
> > same lock can also be taken in softirq context, the process context
> > caller should use the _bh variant. This is not new with your patch.
> > Classical timers also run in softirq context. I may be overlooking
> > something, will need to take a closer look at that.
> > 
> > In any case, I don't think local_irq_save is needed. 
> 
> 
> 
> 
> I meant prb_open_block
> 
> tpacket_rcv runs in softirq context (from __netif_receive_skb_core)
> or with bottom halves disabled (from __dev_queue_xmit, or if rx uses
> napi_threaded).
> 
> That is likely why the spin_lock_bh variant is not explicitly needed.

Before I saw your reply, I was almost considering replacing spin_lock with
spin_lock_bh in our project before calling packet_current_rx_frame in
tpacket_rcv. I just couldn't understand why we haven't encountered any
deadlocks or RCU issues due to not properly adding _bh in our project until
I saw your reply.
I truly admire your ability to identify all the scenarios that use the
tpacket_rcv function in such a short amount of time. For me, finding all the
instances where tpacket_rcv is assigned to prot_hook.func for proxy calls is
a painful and lengthy task. Even if I manage to find them, I would still
worry about missing some.


Thanks
Xin Zhao


