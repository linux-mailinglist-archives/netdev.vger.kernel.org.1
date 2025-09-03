Return-Path: <netdev+bounces-219628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B93B426B4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC927B97B6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4322D4B77;
	Wed,  3 Sep 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KEu0qlNq"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844C92D1F44;
	Wed,  3 Sep 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916266; cv=none; b=irtgFh7ZxW/9V2+yqtpA0MqpEirR5JbMYytAle964QmKCIWMyS92y9qJmQ5HvTmsGybMp0yf3Em7KZ1w6IXQ02/nqw8YH9DLRfu563NtELyazDOK4/nBxXQh9b9ZLwQ3ez56apDSlzWTSGGYRzAFgYCu0D0hYrIpQgjGuESjPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916266; c=relaxed/simple;
	bh=40lehCKBugHinswqoHnpQqnJORE8caA8xtKHTMajjy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kY+yjRRGtGmtq/eju3ADsCfBgiH6W3gs/cjtBbit368IVnj8T3ttVm2bJWhadJPuK+G/p7w5d9iWuB3uU0O+oBfekQ96J6+bJQ72x0jFk81zdoCvQG6tZ8sUN8PY9UmlQIprFqsxQJWTH4ZxCx3g828Ijadq0QeMiwSxSujic64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KEu0qlNq; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=9cJnPOGanCbByCRx0wy1KMAjtkHYfjJnIkC0w2nhhAk=;
	b=KEu0qlNqxOlS3L2qYTIsYAizqOC4i+XrOGC8kP+hgjPnbX0InWFzoFgyCe+nKQ
	oIQAav3goZqhyrVOsdiB69UAm24fzm9kxaaQ8lIQ5EmNjQ/pybulTzEQqhPPydRT
	5LH2QZqKK3IdRdy6+VTYfw3mRk2kGc4vN4IHtZyKRPips=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXSCYFarhoDW05GQ--.9058S2;
	Thu, 04 Sep 2025 00:17:10 +0800 (CST)
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
Date: Thu,  4 Sep 2025 00:17:09 +0800
Message-Id: <20250903161709.563847-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXSCYFarhoDW05GQ--.9058S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1fAr1fuFWDJw1kGF13twb_yoWrWr4UpF
	WUKa4xGr4kJanFgr1xZws7Ar1Sqw13JFZ8Jrs3X3y5ArWDWFyfJFy29FyYvFWSqF4kWFn2
	vr48GrW5AFs3A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-18PUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibge9Cmi4Y8iRZQAAsR

On Tue, Sep 2, 2025 at 23:43 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> >         p1->max_frame_len = p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeof_priv);
> >         prb_init_ft_ops(p1, req_u);
> > -       prb_setup_retire_blk_timer(po);
> > +       hrtimer_setup(&p1->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> > +                     CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> > +       hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
> > +                     HRTIMER_MODE_REL_SOFT);
> 
> You expect to see it start at the setsockopt phase? Even if it's far
> from the real use of recv at the moment.
> 
> >         prb_open_block(p1, pbd);
> >  }

Before applying this patch, init_prb_bdqc also start the timer by mod_timer:

init_prb_bdqc
  prb_open_block
    _prb_refresh_rx_retire_blk_timer
      mod_timer

So the current timer's start time is almost the same as it was before applying
the patch.


> > @@ -917,7 +873,6 @@ static void prb_open_block(struct tpacket_kbdq_core *pkc1,
> >         pkc1->pkblk_end = pkc1->pkblk_start + pkc1->kblk_size;
> >
> >         prb_thaw_queue(pkc1);
> > -       _prb_refresh_rx_retire_blk_timer(pkc1);
> 
> Could you say more on why you remove this here and only reset/update
> the expiry time in the timer handler? Probably I missed something
> appearing in the previous long discussion.
> 
> >
> >         smp_wmb();
> >  }

In the description of [PATCH net-next v10 0/2] net: af_packet: optimize retire operation:

Changes in v7:
  When the callback return, without sk_buff_head lock protection, __run_hrtimer will
  enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expires while
  enqueuing a timer may cause chaos in the hrtimer red-black tree.

Neither hrtimer_set_expires nor hrtimer_forward_now is allowed when the hrtimer has
already been enqueued. Therefore, the only place where the hrtimer timeout can be set is
within the callback, at which point the hrtimer is in a non-enqueued state and can have
its timeout set.


Changes in v8:
  Simplify the logic related to setting timeout, as suggestd by Willem de Bruijn.
  Currently timer callback just restarts itself unconditionally, so delete the
 'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_forward_now
  directly and always return HRTIMER_RESTART. The only special case is when
  prb_open_block is called from tpacket_rcv. That would set the timeout further
  into the future than the already queued timer. An earlier timeout is not
  problematic. No need to add complexity to avoid that.

This paragraph explains that if the block's retire timeout is not adjusted within
the timer callback, it will only result in an earlier-than-expected retire timeout,
which is not problematic. Therefore, it is unnecessary to increase the logical complexity
to ensure block retire timeout occurs as expected each time.


> The whole structure needs a new organization?
> 
> Before:
>         /* size: 152, cachelines: 3, members: 22 */
>         /* sum members: 144, holes: 2, sum holes: 8 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 24 bytes */
> After:
>         /* size: 176, cachelines: 3, members: 19 */
>         /* sum members: 163, holes: 4, sum holes: 13 */
>         /* paddings: 1, sum paddings: 4 */
>         /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
>         /* last cacheline: 48 bytes */

What about the following organization:?

/* kbdq - kernel block descriptor queue */
struct tpacket_kbdq_core {
	struct pgv	*pkbdq;
	unsigned int	feature_req_word;
	unsigned int	hdrlen;
	unsigned short	kactive_blk_num;
	unsigned short	blk_sizeof_priv;
	unsigned char	reset_pending_on_curr_blk;

	char		*pkblk_start;
	char		*pkblk_end;
	int		kblk_size;
	unsigned int	max_frame_len;
	unsigned int	knum_blocks;
	char		*prev;
	char		*nxt_offset;

	unsigned short  version;
	
	uint64_t	knxt_seq_num;
	struct sk_buff	*skb;

	rwlock_t	blk_fill_in_prog_lock;

	/* timer to retire an outstanding block */
	struct hrtimer  retire_blk_timer;

	/* Default is set to 8ms */
#define DEFAULT_PRB_RETIRE_TOV	(8)

	ktime_t		interval_ktime;
};



Thanks
Xin Zhao


