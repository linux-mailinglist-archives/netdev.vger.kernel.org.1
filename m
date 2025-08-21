Return-Path: <netdev+bounces-215552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383ACB2F302
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F094189363D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADB22ECEBF;
	Thu, 21 Aug 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="StSKpPO1"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935021FF28;
	Thu, 21 Aug 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766448; cv=none; b=ljGmuTFr4hdc4nwkbnQ+6E+ma03y5TuMYrj0HQ5CdbvG4HV3Qe90IiUOlJ+TM9urPK5sdX4N9QKBEtRAJ600mVt1JmTjGUzKs3mTNW2wRE2lYlzMRgSsXVUCAGkiXBfDPcYtKx8+WpS5mHPIfdKVbI+uQgiP/3SjOMFC0gH+pMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766448; c=relaxed/simple;
	bh=E7wlCF/qd5NHjG6mOLnD7yWZl9+qK0uQRNNENYmY0Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2hZwffA6KqNLSt/Ms6jR14YiMS8zYGYsUIyWUCggbEmbAILne9b1vH9HVFwRDI1yFH8g6If54BBoG7TS6fgoyau8w3Jg6VG+4LziygwSbfzT9SXE75Tit+tj9VDFH1crtYeOa2maJZ5ON6vMmXIfDblKkvmde6KoPxJFaSCQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=StSKpPO1; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0f
	VX8rrkuXOhydTNOOC17PpoylVUri3YXUcQETlaG2U=; b=StSKpPO1BqXZ1EbCzE
	4SjM1j9IeoMJSa/CGV9gx/kmN7HFO+qXonw51vOwwae5hzSV3fbuy6Bu3JdNxx8X
	UJqD6VsD+uf9CGWC8ddps/IPEW/u+BEwTYjRdBa3VjAUyEiPqKjd5LTKMwTXLgWx
	/hyApvVDz+WJwGxNAaJWjYLWg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3MPF+3qZocU0tAA--.6833S2;
	Thu, 21 Aug 2025 16:53:19 +0800 (CST)
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
Subject: Re: [PATCH net-next v6] net: af_packet: Use hrtimer to do the retire operation
Date: Thu, 21 Aug 2025 16:53:18 +0800
Message-Id: <20250821085318.3022527-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3MPF+3qZocU0tAA--.6833S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF17ZF4xZr4kZFyfGr4UArb_yoWxuF1UpF
	Wjg347twn7JFsF9FyxXa1kXFyUJw43Ar45Grn3Jryjy3sxGFy2qFW2gFWFqFWIkr4ktwn2
	vr18trZ8Aw1DCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul1v-UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiowiwCmim1fPhmAAAsA

On Wed, 2025-08-20 at 19:15 +0800, Willem wrote:

> > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> > +					     bool start)
> >  {
> > -	mod_timer(&pkc->retire_blk_timer,
> > -			jiffies + pkc->tov_in_jiffies);
> > +	if (start && !hrtimer_is_queued(&pkc->retire_blk_timer))
> > +		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> > +			      HRTIMER_MODE_REL_SOFT);
> > +	else
> > +		hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
> 
> Is the hrtimer still queued when prb_retire_rx_blk_timer_expired
> fires? Based on the existence of hrtimer_forward_now, I assume so. But
> have not checked yet. If so, hrtimer_is_queued alone suffices to
> detect the other callstack from tpacket_rcv where hrtimer_start is
> needed. No need for bool start?
> 
> >  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> >  }


Since the CI tests have reported the previously mentioned WARN_ON situation within
hrtimer_forward_now, I believe we should reevaluate the implementation of the
_prb_refresh_rx_retire_blk_timer function, which is responsible for setting the
hrtimer timeout, and establish the principles it should adhere to. After careful
consideration and a detailed review of the hrtimer implementation, I have identified
the following two principles:

1. It is essential to ensure that calls to hrtimer_forward_now or hrtimer_set_expires
occur strictly within the hrtimer's callback.
2. It is critical to ensure that no calls to hrtimer_forward_now or hrtimer_set_expires
are made while the hrtimer is enqueued.


Regarding these two principles, I would like to add three points:
1. In principle 1, if hrtimer_forward_now or hrtimer_set_expires is called outside of
the hrtimer's callback without triggering the timer's enqueue, it will lead to the
hrtimer timeout not being triggered as expected (this issue is obvious and can be
reproduced by writing a kernel object and setting a short timeout, such as 2ms).
2. Both principles above are aimed at preventing scenarios where hrtimer_forward_now
or hrtimer_set_expires modify the timeout while the hrtimer is already enqueued, which
could lead to disarray in the hrtimer's red-black tree (after all, the WARN_ON check
for enqueue in the non-inlined hrtimer_forward_now interface exists to prevent such
situations). It is also important to note that apart from executing the hrtimer_start
series of functions outside the hrtimer callback, the __run_hrtimer function, upon
returning HRTIMER_RESTART after executing the hrtimer callback, will also enqueue the
hrtimer.
3. The reason for principle 2, in addition to principle 1, is that when setting the
timeout using hrtimer_forward_now in the hrtimer's callback, there is no protection
provided by the lock for hrtimer_cpu_base, meaning that if an hrtimer_start action is
performed outside the hrtimer's callback while simultaneously updating the timeout
within the callback, it could cause disarray in the hrtimer's red-black tree.

The occurrence of the WARN_ON enqueue error in the CI test indicates that
hrtimer_forward_now was executed in a scenario outside the hrtimer's callback while
the hrtimer was in a queued state. A possible sequence that could cause this issue is
as follows:
cpu0 (softirq context, hrtimer timeout)                             cpu1 (process context, need prb_open_block)
hrtimer_run_softirq
  __hrtimer_run_queues
    __run_hrtimer
      _prb_refresh_rx_retire_blk_timer
        spin_lock(&po->sk.sk_receive_queue.lock);
        hrtimer_is_queued(&pkc->retire_blk_timer) == false
        hrtimer_forward_now
        spin_unlock(&po->sk.sk_receive_queue.lock)                 tpacket_rcv
      enqueue_hrtimer                                                spin_lock(&sk->sk_receive_queue.lock);
                                                                     packet_current_rx_frame
                                                                       __packet_lookup_frame_in_block
                                                                         prb_open_block
                                                                           _prb_refresh_rx_retire_blk_timer
                                                                             hrtimer_is_queued(&pkc->retire_blk_timer) == true
                                                                             hrtimer_forward_now
                                                                             WARN_ON

In summary, the key issue now is to find a mechanism to ensure that the hrtimer's start
or enqueue, as well as the timeout settings for the hrtimer, cannot be executed
concurrently. I have thought of two methods to address this issue (method 1 will make the
code appear much simpler, while method 2 will make the code more complex):

Method 1:
Do not call hrtimer_forward_now to set the timeout within the hrtimer's callback; instead,
only call the hrtimer_start function to perform the hrtimer's enqueue. This approach is
viable because, in the current version, inside __run_hrtimer, the state of the timer is
checked under the protection of cpu_base->lock. If the timer is already enqueued, it will
not be enqueued again. By doing this, all hrtimer enqueues will be protected under both
sk_receive_queue.lock and cpu_base->lock, eliminating concerns about the timeout being
concurrently modified during enqueueing, which could lead to chaos in the hrtimer's
red-black tree.

Method 2:
This method primarily aims to strictly ensure that hrtimer_start is not called within the
hrtimer's callback. However, doing so would require a lot of additional logic:
We would need to add a callback parameter to strictly ensure that hrtimer_forward_now is
executed within the callback and hrtimer_start is executed outside the callback. The
occurrence of the WARN_ON in the CI test indicates that the method of using
"hrtimer_is_queued to make the judgment" does not cover all scenarios. The fundamental
reason for this is that the hrtimer_is_queued check must be precise, which requires
protection from cpu_base->lock. Similarly, using hrtimer_callback_running check would not
achieve precise judgment either. It is necessary to know on which CPU the hrtimer is running
and send an IPI to execute hrtimer_forward_now using local_irq_save on that CPU to satisfy
the aforementioned principle 2), as it is inappropriate to acquire the cpu_base->lock within
the af_packet logic; the only way to ensure that the hrtimer_forward_now operation is
executed without enqueueing the hrtimer is by disabling IRQs.

Since strictly ensuring that hrtimer_start is not called within the hrtimer's callback leads
to a lot of extra logic, and logically, I have also demonstrated that it is permissible to
call hrtimer_start within the hrtimer's callback (for the hrtimer module, the lock is
cpu_base->lock, which is associated with the clock base where the hrtimer resides, and does
not follow smp_processor_id()), it does not matter whether hrtimer_start is executed by the
CPU executing the hrtimer callback or by another CPU; both scenarios are the same for the
hrtimer module. TTherefore, I prefer to use the aforementioned method 1) to resolve this
issue. If there are no concerns, I will reflect this in PATCH v7.


Thanks
Xin Zhao


