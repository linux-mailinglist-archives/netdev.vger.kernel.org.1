Return-Path: <netdev+bounces-220220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A76B44C8C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 06:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14C71BC8A1D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475761F5423;
	Fri,  5 Sep 2025 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wm9Nca2b"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1117E1A9F90;
	Fri,  5 Sep 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044875; cv=none; b=pUHkr1bVv/PyMCuGGRhLRa/xmxH1pqY8k5Sralhfrt0Qiab9YiBdfbjufMVRAfagdBJYAaq6TPql4Lfv3mUfTQluu8YJn/89xfLH5sIfJK+77uDPlOtBJg0Fx8Ky9TxCNCBqS2ffHLRwbp24WHv4Py9JbLIaPE5qi8IAqGxslFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044875; c=relaxed/simple;
	bh=W5kE2AgCsGzW+2u+PZx2LUVNYcq8RpF2NI14kGV6Apk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rlyulPf6Y8iV5EAq5CM3j+FYaIS3yDgISK8ee9K1iG7R8D1sTvIJh1B7FwsLvsROz9fR+2po2gX3ISvcojTH8eKBRe3iKFzX9gp/z0oQm7OJdhFwg8d6/jRvB8iUY31XIvxrw9W9DtjdrfuW7pIGGdS+PTsZYWgBm+V/CJ+/kvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wm9Nca2b; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=kBpC1Ipw5nLY7H+V6xpivhpgJYlQ2dQtXeH3Howu9/w=;
	b=Wm9Nca2bxxV9HDoB6H3faWf5Be8G3n9IoHaq2YZgvigN/X5tsRphggh5Jf7aIC
	Y+80qci3VjfvKJlb5/r2q/rDgCuhzf1hp0f+q2mlChwT0395La80PG6C8tqltsWh
	xfZ5BagGJay9iJTH6qT5M/BvGU97pSbqpOIiCxbr/4iP4=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3zZBVYLpouCuFGA--.5S2;
	Fri, 05 Sep 2025 12:00:23 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: kerneljasonxing@gmail.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the retire operation
Date: Fri,  5 Sep 2025 12:00:21 +0800
Message-Id: <20250905040021.1893488-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3zZBVYLpouCuFGA--.5S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw4DCF4fXr1kZFWkZFWfAFb_yoWxWF45pa
	yYq347tr1kJr12vF47Zan7XFy5Aw4rJr15Grn3Gry2k3sxWFyxtFWI9ayFgFW7CF4kKw12
	vF48trsxAw1DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UX2-5UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibhS-Cmi6HujWaQABsV

On Thu, Sep 4, 2025 at 11:26 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> > In the description of [PATCH net-next v10 0/2] net: af_packet: optimize retire operation:
> >
> > Changes in v8:
> > - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
> >   hrtimer_cancel will check and wait until the timer callback return and ensure
> >   enter enter callback again;
> 
> I see the reason now :)
> 
> Please know that the history changes through versions will finally be
> removed, only the official message that will be kept in the git. So
> this kind of change, I think, should be clarified officially since
> you're removing a structure member. Adding more descriptions will be
> helpful to readers in the future. Thank you.

I will add some more information to the commit message of this 2/2 PATCH.



> > Consider the following timing sequence:
> > timer   cpu0 (softirq context, hrtimer timeout)                cpu1 (process context)
> > 0       hrtimer_run_softirq
> > 1         __hrtimer_run_queues
> > 2           __run_hrtimer
> > 3             prb_retire_rx_blk_timer_expired
> > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > 5               _prb_refresh_rx_retire_blk_timer
> > 6                 hrtimer_forward_now
> > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > 8             raw_spin_lock_irq(&cpu_base->lock);              tpacket_rcv
> > 9             enqueue_hrtimer                                    spin_lock(&sk->sk_receive_queue.lock);
> > 10                                                               packet_current_rx_frame
> > 11                                                                 __packet_lookup_frame_in_block
> > 12            finish enqueue_hrtimer                                 prb_open_block
> > 13                                                                     _prb_refresh_rx_retire_blk_timer
> > 14                                                                       hrtimer_is_queued(&pkc->retire_blk_timer) == true
> > 15                                                                       hrtimer_forward_now
> > 16                                                                         WARN_ON
> > On cpu0 in the timing sequence above, enqueue_hrtimer is not protected by sk_receive_queue.lock,
> > while the hrtimer_forward_now is not protected by raw_spin_lock_irq(&cpu_base->lock).
> >
> > In my previous email, I provided an explanation. As a supplement, I would
> > like to reiterate a paragraph from my earlier response to Willem.
> > The point is that when the hrtimer is in the enqueued state, you cannot
> 
> How about tring hrtimer_is_queued() beforehand?
> 
> IIUC, with this patch applied, we will lose the opportunity to refresh
> the timer when the lookup function (in the above path I mentioned)
> gets called compared to before. If the packet socket tries to look up
> a new block and it doesn't update its expiry time, the timer will soon
> wake up. Does it sound unreasonable?


I actually pointed out the issue with the timeout setting in a previous email:
https://lore.kernel.org/netdev/20250826030328.878001-1-jackzxcui1989@163.com/.

Regarding the method you mentioned, using hrtimer_is_queued to assist in judgment, I had
discussed this extensively with Willem in previous emails, and the conclusion was that
it is not feasible. The reason is that in our scenario, the hrtimer always returns
HRTIMER_RESTART, unlike the places you pointed out, such as tcp_pacing_check, where the
corresponding hrtimer callbacks all return HRTIMER_NORESTART. Since our scenario returns
HRTIMER_RESTART, this can lead to many troublesome issues. The fundamental reason is that
if HRTIMER_RESTART is returned, the hrtimer module will enqueue the hrtimer after the
callback returns, which leads to exiting the protection of our sk_receive_queue lock.

Returning to the functionality here, if we really want to update the hrtimer's timeout
outside of the timer callback, there are two key points to note:

1. Accurately knowing whether the current context is a timer callback or tpacket_rcv.
2. How to update the hrtimer's timeout in a non-timer callback scenario.

To start with the first point, it has already been explained in previous emails that
executing hrtimer_forward outside of a timer callback is not allowed. Therefore, we
must accurately determine whether we are in a timer callback; only in that context can
we use the hrtimer_forward function to update.
In the original code, since the same _prb_refresh_rx_retire_blk_timer function was called,
distinguishing between contexts required code restructuring. Now that this patch removes
the _prb_refresh_rx_retire_blk_timer function, achieving this accurate distinction is not
too difficult.
The key issue is the second point. If we are not inside the hrtimer's callback, we cannot
use hrtimer_forward to update the timeout. So what other interface can we use? You might
suggest using hrtimer_start, but fundamentally, hrtimer_start cannot be called if it has
already been started previously. Therefore, wouldn’t you need to add hrtimer_cancel to
confirm that the hrtimer has been canceled? Once hrtimer_cancel is added, there will also
be scenarios where it is restarted, which means we need to consider the concurrent
scenario when the socket exits and also calls hrtimer_cancel. This might require adding
logic for that concurrency scenario, and you might even need to reintroduce the
delete_blk_timer variable to indicate whether the packet_release operation has been
triggered so that the hrtimer does not restart in the tpacket_rcv scenario.

In fact, in a previous v7 version, I proposed a change that I personally thought was
quite good, which can be seen here:
https://lore.kernel.org/netdev/20250822132051.266787-1-jackzxcui1989@163.com/. However,
this change introduced an additional variable and more logic. Willem also pointed out
that the added complexity to avoid a non-problematic issue was unnecessary.

As mentioned in Changes in v8:
  The only special case is when prb_open_block is called from tpacket_rcv.
  That would set the timeout further into the future than the already queued
  timer. An earlier timeout is not problematic. No need to add complexity to
  avoid that.

It is not problematic, as Willem point it out in
https://lore.kernel.org/netdev/willemdebruijn.kernel.2d7599ee951fd@gmail.com/


In the end:

So, if you agree with the current changes in v10 and do not wish to add the timeout
setting under tpacket_rcv, that’s fine.
If you do not agree, then the only alternative I can think of is to use a combination
of hrtimer_cancel and hrtimer_start under prb_open_block, and we would also need to
reintroduce the delete_blk_timer variable to help determine whether the hrtimer was
canceled due to the packet_release behavior. If we really want to make this change,
it does add quite a bit of logic, and we would also need Willem's agreement.


Thanks
Xin Zhao


