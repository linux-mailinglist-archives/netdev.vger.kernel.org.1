Return-Path: <netdev+bounces-214106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98685B284B2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE2817B7CA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B91304BC7;
	Fri, 15 Aug 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j1H1DZO6"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B05304BA8;
	Fri, 15 Aug 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277747; cv=none; b=JEu/tUfxbmpJRGeqSFhYx+O5b+w5yFoXrzNhKTSRu/trTkZ9w+0hV0oMwZ7HFBInIdGpM/qQMJ+8lRwz3ivO4Mt5YbDx3fQWap8rajDthIRRRZxkuwK1qqAPkIR10LtgMdN1CoxlJ9czEKwV4IzGKGRMab6+7WkHim0xIx1xUmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277747; c=relaxed/simple;
	bh=boEF1KxrJYXx9rWPa1UaosMdgC0AncPnn9B8wz5UXW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pCalZpzIwFpDZnIraupQ7OMSEC/57+ae4AanLhyhyzNCC2nQLz0yvdnq5O+NzuXqCNF3dgZL889+NGU33Nsedgq47+ASOF3kZSJC2Q+dd/p3qIcKtViFZ9YfHvjwnHs2GGOmx9A1VQTMJJ4Y9r9dRdyQOMhwnUFbBshMKBQr0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j1H1DZO6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pJ
	xDQfZ/ZCiKpMxGpv2ngGkeJfJGVY+hTDotS3/x6oE=; b=j1H1DZO67ev5AjQ4/p
	Vcmifd+/n0nwt92vPmL5JcSEt92DcZenkfikaZlL/5W9/a5YV7ZJYddUT/YCYFGu
	dC5H74efgXJtsfn99dEKm/+RPcb5N8iYv+ra6/G1F1bdcisUqBWgYgnBNfa+JL0O
	ulz6ECZl4JdtL2fHhbfg78bfo=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3LYSJaZ9o8aVLAQ--.49724S2;
	Sat, 16 Aug 2025 01:08:26 +0800 (CST)
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
Subject: Re: [PATCH v2] net: af_packet: Use hrtimer to do the retire operation
Date: Sat, 16 Aug 2025 01:08:25 +0800
Message-Id: <20250815170825.3585310-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3LYSJaZ9o8aVLAQ--.49724S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4fCr1ruryUuFWkCF4Uurg_yoWrKw1DpF
	W5tF9rGwn7XF4jga1xZr4kZFyruw4DAr98Grs3W343A3sxJryrta929FZ0qFWfGF4qkrsF
	vF4xZrZ8Aw1DJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK-erUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRw6qCmifZlAxoAAAs5

On Fri, 2025-08-15 at 18:12 +0800, Willem wrote:

> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

> Please clearly label PATCH net-next and include a changelog and link
> to previous versions.
> 
> See also other recently sent patches and
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> https://docs.kernel.org/process/submitting-patches.html
> 
> > ---

Dear Willem,

I will add the details in PATCH v3.


> > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> 
> Since the hrtimer API takes ktime, and there is no other user for
> retire_blk_tov, remove that too and instead have interval_ktime.
> 
> >  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;

We cannot simply remove the retire_blk_tov field, because in net/packet/diag.c 
retire_blk_tov is being used in function pdiag_put_ring. Since there are still
people using it, I personally prefer not to remove this variable for now. If
you think it is still necessary, I can remove it later and adjust the logic in
diag.c accordingly, using ktime_to_ms to convert the ktime_t format value back
to the u32 type needed in the pdiag_put_ring function.


> > +	hrtimer_set_expires(&pkc->retire_blk_timer,
> > +			    ktime_add(ktime_get(), ms_to_ktime(pkc->retire_blk_tov)));
> 
> More common for HRTIMER_RESTART timers is hrtimer_forward_now.
> 
> >  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;

As I mentioned in my previous response, we cannot use hrtimer_forward_now here
because the function _prb_refresh_rx_retire_blk_timer can be called not only
when the retire timer expires, but also when the kernel logic for receiving
network packets detects that a network packet has filled up a block and calls
prb_open_block to use the next block. This can lead to a WARN_ON being triggered
in hrtimer_forward_now when it checks if the timer has already been enqueued
(WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED)).
I encountered this issue when I initially used hrtimer_forward_now. This is the
reason why the existing logic for the regular timer uses mod_timer instead of
add_timer, as mod_timer is designed to handle such scenarios. A relevant comment
in the mod_timer implementation states:
 * Note that if there are multiple unserialized concurrent users of the
 * same timer, then mod_timer() is the only safe way to modify the timeout,
 * since add_timer() cannot modify an already running timer.


> > +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
> >  {
> >  	struct packet_sock *po =
> >  		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
> > @@ -790,6 +790,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> > 
> >  out:
> >  	spin_unlock(&po->sk.sk_receive_queue.lock);
> > +	return HRTIMER_RESTART;
> 
> This always restart the timer. But that is not the current behavior.
> Per prb_retire_rx_blk_timer_expired:
> 
>    * 1) We refresh the timer only when we open a block.
> 
> Look at the five different paths that can reach label out.
> 
> In particular, if the block is retired in this timer, and no new block
> is available to be opened, no timer should be armed.
> 
> >  }

I have sorted out the logic in this area; please take a look and see if it's correct.

We are discussing the conditions under which we should return HRTIMER_NORESTART. We only
need to focus on the three 'goto out' statements in this function (because if it don't
call 'goto out', it will definitely not skip the 'refresh_timer:' label, and if it don't
skip the refresh_timer label, it will definitely execute the _prb_refresh_rx_retire_blk_timer
function, which expects to return HRTIMER_RESTART):
Case 1:
  if (unlikely(pkc->delete_blk_timer))
    goto out;
  This case indicates that the hrtimer has already been stopped. In this situation, it 
  should return HRTIMER_NORESTART, and I will make this change in PATCH v3.
Case 2:
  if (!prb_dispatch_next_block(pkc, po))
    goto refresh_timer;
  else
    goto out;
  In this case, the execution will only reach the out label if prb_dispatch_next_block
  returns a non-zero value. If prb_dispatch_next_block returns a non-zero value, it must
  have executed prb_open_block, which in turn will call _prb_refresh_rx_retire_blk_timer
  to set the new timeout for the retire timer. Therefore, in this scenario, the hrtimer
  should return HRTIMER_RESTART.
Case 3:
  } else {
     ...
     prb_open_block(pkc, pbd);
     goto out;
  }
  This goto out clearly follows a call to prb_open_block, and as mentioned in the case 2,
  it will set a new timeout and expects the hrtimer to restart.
Based on the analysis above, I only need to modify the situation described in case 1 in
PATCH v3 to return HRTIMER_NORESTART. If there are any inaccuracies, please provide
further guidance.


Thanks
Xin Zhao


