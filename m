Return-Path: <netdev+bounces-219645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7848FB42796
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32ACF687011
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D52D6619;
	Wed,  3 Sep 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NqSbI2vg"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145E20E023;
	Wed,  3 Sep 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919267; cv=none; b=DMk9+mQiQcU8+5VVIsrFnCm+CJBKg4BaSNgkzsTPsau0mnIzie/az3PswrzxBgqKoAohC+69WcHbGOeez+Np4dXgXgXA/BnmzLr9I2QXLzJrwyrfU8FNoepw04y221IYdVs3Q9QLNE6yJPMg8ZZisbsIdR2ZBw5YYg244GXiQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919267; c=relaxed/simple;
	bh=HS9OamxR/qp0GVg0z0BDu/5U5P2DW4129Qvt3yz689Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C5c8V/EAHJgc7EsQsAAnSJsAdkTk/I7hfI45a/YS/ZxI1Lmsl052GBc3bVnCgN1XATrtbVUQbWUcdrSNbqM3DnzWGT9IixbxKh8mqfzIdshv1ALDGbQ8+49FrJ3dtVlRseBhQ7OVAByLX/Gs4KB8aTt8aNUWT778yITtEfuo4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NqSbI2vg; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=YqsAkqfks+ESyg5bzWwfvDpqveF/tty8rAM7MTmwq3k=;
	b=NqSbI2vgoqfZy3BV3pE6JPYtHMfz6yd2X5v1qFvXwt2Z0uK9p0qlqwc0+IEI5c
	iVB/17v1Md5UPOWR2FqmzJ+R9vJ2mEeg/OQopqeZmNZWGQLsYRjLHTVGBKI82cDY
	hSXo1j32teY3d+gSMMduFY+DEyIOnE6awugBtILCck5Wk=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHDDXFdbhohM27Bg--.4588S2;
	Thu, 04 Sep 2025 01:07:17 +0800 (CST)
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
Date: Thu,  4 Sep 2025 01:07:16 +0800
Message-Id: <20250903170716.595528-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHDDXFdbhohM27Bg--.4588S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrW5Ww1kGw47JrykZF1fWFg_yoW5AryDpa
	yUG347Aw10qF12vanrXw4kAry5Xwn5Jr4UJrs3Wr1ayr9xWFy3JFWI9F4FqFWI9F4vkwn2
	qF48J39Iy3WDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK38nUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibge9Cmi4Y8iRZQABsQ

On Wed, Sep 3, 2025 at 00:42 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> One more review from my side is that as to the removal of
> delete_blk_timer, I'm afraid it deserves a clarification in the commit
> message.
> 
> > > -       spin_unlock_bh(&rb_queue->lock);
> > > -
> > > -       prb_del_retire_blk_timer(pkc);
> > > -}
> > > -

In the description of [PATCH net-next v10 0/2] net: af_packet: optimize retire operation:

Changes in v8:
- Delete delete_blk_timer field, as suggested by Willem de Bruijn,
  hrtimer_cancel will check and wait until the timer callback return and ensure
  enter enter callback again;

I will also emphasize the removal of delete_blk_timer in the commit message for this 2/2
commit. The updated commit message for the 2/2 patch is as follows：

Changes in v8:
- Simplify the logic related to setting timeout.
- Delete delete_blk_timer field, hrtimer_cancel will check and wait until
  the timer callback return.


> I gradually understand your thought behind this modification. You're
> trying to move the timer operation out of prb_open_block() and then
> spread the timer operation into each caller.
> 
> You probably miss the following call trace:
> packet_current_rx_frame() -> __packet_lookup_frame_in_block() ->
> prb_open_block() -> _prb_refresh_rx_retire_blk_timer()
> ?
> 
> May I ask why bother introducing so many changes like this instead of
> leaving it as-is?




Consider the following timing sequence:
timer   cpu0 (softirq context, hrtimer timeout)                cpu1 (process context)
0       hrtimer_run_softirq
1         __hrtimer_run_queues
2           __run_hrtimer
3             prb_retire_rx_blk_timer_expired
4               spin_lock(&po->sk.sk_receive_queue.lock);
5               _prb_refresh_rx_retire_blk_timer
6                 hrtimer_forward_now
7               spin_unlock(&po->sk.sk_receive_queue.lock)
8             raw_spin_lock_irq(&cpu_base->lock);              tpacket_rcv
9             enqueue_hrtimer                                    spin_lock(&sk->sk_receive_queue.lock);
10                                                               packet_current_rx_frame
11                                                                 __packet_lookup_frame_in_block
12            finish enqueue_hrtimer                                 prb_open_block
13                                                                     _prb_refresh_rx_retire_blk_timer
14                                                                       hrtimer_is_queued(&pkc->retire_blk_timer) == true
15                                                                       hrtimer_forward_now
16                                                                         WARN_ON
On cpu0 in the timing sequence above, enqueue_hrtimer is not protected by sk_receive_queue.lock,
while the hrtimer_forward_now is not protected by raw_spin_lock_irq(&cpu_base->lock).

In my previous email, I provided an explanation. As a supplement, I would
like to reiterate a paragraph from my earlier response to Willem.
The point is that when the hrtimer is in the enqueued state, you cannot
call interfaces like hrtimer_forward_now. The kernel has a WARN_ON check
in hrtimer_forward_now for this reason. Similarly, you also cannot call
interfaces like hrtimer_set_expires. The kernel does not include a WARN_ON
check in hrtimer_set_expires to avoid increasing the code size, as
hrtimer_set_expires is an inline function.


Thanks
Xin Zhao


