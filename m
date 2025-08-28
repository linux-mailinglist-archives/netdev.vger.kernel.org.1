Return-Path: <netdev+bounces-217605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B8B393CA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468521BA33AE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A0327A904;
	Thu, 28 Aug 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cZrdyiRO"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001DA17B425;
	Thu, 28 Aug 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362739; cv=none; b=Q8H0UJDUWHtUh6wiZBIyFTuK2JCW9DqB08qq8lob39qCinfkffUJGed0biVOGEan7gQXMhULqBYEvrDlNZM401WUVTFqfbw6hKDJ+Jn0xPdMR5/7UDhcl7NtSUS16mPwPSE28HOB5LAtbwpyEpNVF4AtoS9iVg3WN5q21R70GQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362739; c=relaxed/simple;
	bh=7rhTBLdOBL1ZcmArUlm9G2/jw6VLrvN/y3W2MZXrteQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ErPUCMY05KpGXp4BPpCGYOZhhKjr+s9qmKjwcDMn3Dwnk+HbC1BHo2e9rMd4V07ZxuD8sxkv5Ia+pcy31X3OhTnx/ZNrLK/llN/rSNQlpPz5vkrZTpaYnAiyA8BE2MQE42DmaPDd4qkUQWSrVk8Mnjw0pZcY/mBTiRhlrW5kMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cZrdyiRO; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h6
	uansIoRh2ttY4nSptlrm8mbudszCdhTQg6STrAZIM=; b=cZrdyiRO3WARmTOoI+
	tHSciq6R1WMYR0eFj1Q5BWy5grjDH5gVoe7Iq2sMMvIHcKl0aPA/w6h6uu2lbRPm
	kDdTbhC0gdSprpJOC9COTRHYcX5ZCxjIOL+wnif1qpXzH757CXPb/YUdy1dpS3aP
	q1qzVZXCoxk7JQuN7gacPffM8=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3__jM969obuQnFA--.34403S2;
	Thu, 28 Aug 2025 14:31:41 +0800 (CST)
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
Subject: Re: [PATCH net-next v8] net: af_packet: Use hrtimer to do the retire operation
Date: Thu, 28 Aug 2025 14:31:40 +0800
Message-Id: <20250828063140.2747329-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3__jM969obuQnFA--.34403S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF1DAw13ZrW5Cr4DXw45Awb_yoW3Gw4Upa
	y5Cry7Gwnrua10gr4xXwnrZr13uws8Ars8Grs5WFn3AF98KryfJay29ry5WFWSyFZxZrZr
	Zr48J3y5A3Z5GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHCJQUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwG3Cmiv8Bq5EgAAs9

On Thu, 2025-08-28 at 5:53 +0800, Willem wrote:

> > Changes in v8:
> > - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
> >   hrtimer_cancel will check and wait until the timer callback return and ensure
> >   enter enter callback again;
> > - Simplify the logic related to setting timeout, as suggestd by Willem de Bruijn.
> >   Currently timer callback just restarts itself unconditionally, so delete the
> >  'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_forward_now
> >   directly and always return HRTIMER_RESTART. The only special case is when
> >   prb_open_block is called from tpacket_rcv. That would set the timeout further
> >   into the future than the already queued timer. An earlier timeout is not
> >   problematic. No need to add complexity to avoid that.
> 
> This simplifies the timer logic tremendously. I like this direction a lot.

Thanks. :)

> 
> >  static void prb_setup_retire_blk_timer(struct packet_sock *po)
> > @@ -603,9 +592,10 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
> >  	struct tpacket_kbdq_core *pkc;
> > 
> >  	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> > -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> > -		    0);
> > -	pkc->retire_blk_timer.expires = jiffies;
> > +	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> > +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> > +	hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> > +		      HRTIMER_MODE_REL_SOFT);
> 
> Since this is only called from init_prb_bdqc, we can further remove
> this whole function and move the two hrtimer calls to the parent.

Okay, I will move hrtimer_setup and hrtimer_start into init_prb_bdqc in PATCH v9.

I do not move the prb_shutdown_retire_blk_timer into packet_set_ring either, because
in packet_set_ring, there is no existing pointer for tpacket_kbdq_core. If move the
logic of prb_shutdown_retire_blk_timer into packet_set_ring, we need to add the
tpacket_kbdq_core pointer conversion logic in packet_set_ring, I think it is not
necessary.

> >  }
> > 
> >  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> > @@ -672,11 +662,10 @@ static void init_prb_bdqc(struct packet_sock *po,
> >  	p1->last_kactive_blk_num = 0;
> >  	po->stats.stats3.tp_freeze_q_cnt = 0;
> >  	if (req_u->req3.tp_retire_blk_tov)
> > -		p1->retire_blk_tov = req_u->req3.tp_retire_blk_tov;
> > +		p1->interval_ktime = ms_to_ktime(req_u->req3.tp_retire_blk_tov);
> >  	else
> > -		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
> > -						req_u->req3.tp_block_size);
> > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > +		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
> > +						req_u->req3.tp_block_size));
> >  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
> >  	rwlock_init(&p1->blk_fill_in_prog_lock);
> > 
> > @@ -686,16 +675,6 @@ static void init_prb_bdqc(struct packet_sock *po,
> >  	prb_open_block(p1, pbd);
> >  }
> > 
> > -/*  Do NOT update the last_blk_num first.
> > - *  Assumes sk_buff_head lock is held.
> > - */
> > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > -{
> > -	mod_timer(&pkc->retire_blk_timer,
> > -			jiffies + pkc->tov_in_jiffies);
> > -	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> 
> last_kactive_blk_num is now only updated on prb_open_block. It still
> needs to be updated on each timer callback? To see whether the active
> block did not change since the last callback.

Since prb_open_block is executed once during the initialization, after initialization,
both last_kactive_blk_num and kactive_blk_num have the same value, which is 0. After
initialization, if the value of kactive_blk_num remains unchanged, it is meaningless
to assign the value of kactive_blk_num to last_kactive_blk_num. I searched through
all the places in the code that can modify kactive_blk_num, and found that there is
only one place, which is in prb_close_block. This means that after executing
prb_close_block, we need to update last_kactive_blk_num at the corresponding places
where it should be updated. Since I did not modify this logic under the tpacket_rcv
scenario, I only need to check the logic in the hrtimer callback.

Upon inspection, I did find an issue. When tpacket_rcv calls __packet_lookup_frame_in_block,
it subsequently calls prb_retire_current_block, which in turn calls prb_close_block,
resulting in an update to kactive_blk_num. After executing prb_retire_current_block,
function __packet_lookup_frame_in_block calls prb_dispatch_next_block, it may not
execute prb_open_block. If prb_open_block is not executed, this will lead to an
inconsistency between last_kactive_blk_num and kactive_blk_num. At this point, the
hrtimer callback will check whether pkc->last_kactive_blk_num == pkc->kactive_blk_num,
which will evaluate to false, thus causing the current logic to differ from the original
logic. However, at this time, it is still necessary to update last_kactive_blk_num.

On the other hand, I also carefully checked the original implementation of
prb_retire_rx_blk_timer_expired and found that in the original hrtimer callback,
last_kactive_blk_num is updated in all cases. Therefore, I need to perform this update
before exiting the sk_receive_queue lock.

In addition, in PATCH v9, I will also remove the refresh_timer label and change the only
instance where goto is used, to an if-else implementation, so that the 'refresh_timer:'
label is no longer needed.

The new implementation of prb_retire_rx_blk_timer_expired:

static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
{
	struct packet_sock *po =
		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
	struct tpacket_kbdq_core *pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
	unsigned int frozen;
	struct tpacket_block_desc *pbd;

	spin_lock(&po->sk.sk_receive_queue.lock);

	frozen = prb_queue_frozen(pkc);
	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);

	/* We only need to plug the race when the block is partially filled.
	 * tpacket_rcv:
	 *		lock(); increment BLOCK_NUM_PKTS; unlock()
	 *		copy_bits() is in progress ...
	 *		timer fires on other cpu:
	 *		we can't retire the current block because copy_bits
	 *		is in progress.
	 *
	 */
	if (BLOCK_NUM_PKTS(pbd)) {
		/* Waiting for skb_copy_bits to finish... */
		write_lock(&pkc->blk_fill_in_prog_lock);
		write_unlock(&pkc->blk_fill_in_prog_lock);
	}

	if (pkc->last_kactive_blk_num == pkc->kactive_blk_num) {
		if (!frozen) {
			if (BLOCK_NUM_PKTS(pbd)) {
				/* Not an empty block. Need retire the block. */
				prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
				prb_dispatch_next_block(pkc, po);
			}
		} else {
			/* Case 1. Queue was frozen because user-space was
			 *	   lagging behind.
			 */
			if (!prb_curr_blk_in_use(pbd)) {
			       /* Case 2. queue was frozen,user-space caught up,
				* now the link went idle && the timer fired.
				* We don't have a block to close.So we open this
				* block and restart the timer.
				* opening a block thaws the queue,restarts timer
				* Thawing/timer-refresh is a side effect.
				*/
				prb_open_block(pkc, pbd);
			}
		}
	}

	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
	spin_unlock(&po->sk.sk_receive_queue.lock);
	return HRTIMER_RESTART;
}


Thanks
Xin Zhao


