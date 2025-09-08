Return-Path: <netdev+bounces-220791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA9DB48AE9
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2D474E1740
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDD226D1F;
	Mon,  8 Sep 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qIlyWWDS"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD712225415;
	Mon,  8 Sep 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329323; cv=none; b=S4QpWHqQRjcXPatWhL5EBd5FUPDF5+Zwbd5XftST6KaSNR30VfUBSnAGdBdfJHpPPS8F7FBrRgJIMW6Qtr1DmlCyrhtyWwMmrbJVY/vy1BLNBPRyDvwnwj0gBl/ZtAkMVktREv6z0jZjvrfGL2WzbhJTDKrWckV+CfcFFiKzyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329323; c=relaxed/simple;
	bh=fZqFTPG6CUlhtmvjqcvjm50M1ZGWHUi5eeV9jdi5gXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrlQnbqDV+oENWdnVX0iVcidXXcCtlo8pSZrY88qcGV3fmfN3A6Ib88eCQiasx6N3KSyz6e0Dh0GLS4QzPtQ0gYsGGQDVDWpP7Is6DxayhfbgbP7NeHW5rajF2Ui7/LzxYtKQZXAj5qUdcVxd4/QwIOVdUgpLoChHGyN6J4HJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qIlyWWDS; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TW
	LZemOGq5QEnnAEqQzmvX/rwUuoGqFLalDFRcVQT6s=; b=qIlyWWDSAXfCQnHptv
	HCbND2fY0ufyZPRuv9nsabM5Nsjmm4NELicLwp6SBCPFYAxYWtB19kXlLA11hxXi
	p/aEhB+h70EncrDN96MEl18220hg9OdbnFdUeyj/NKlGDNEM3Mp+JGFD3OgRxVez
	XWJODEiAuT/qYqPl7Kh1FaXAM=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnDz_es75oFd0YCQ--.33755S4;
	Mon, 08 Sep 2025 18:45:56 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH net-next v12 2/2] net: af_packet: Use hrtimer to do the retire operation
Date: Mon,  8 Sep 2025 18:45:49 +0800
Message-Id: <20250908104549.204412-3-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908104549.204412-1-jackzxcui1989@163.com>
References: <20250908104549.204412-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnDz_es75oFd0YCQ--.33755S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3Zw48ur1kAFyDArWUuF4xtFb_yoW8GryxGo
	Z3XrZ8Cr4ktry7A397Cry2kFy7W3yDtr15Jr4F9rWkW3Z0vr15uw1fJay3u3yfuw1Skw1k
	AFy8Ww1rXF1Dtr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RWNtxDUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiowrCCmi+scg3ugAAsD

In a system with high real-time requirements, the timeout mechanism of
ordinary timers with jiffies granularity is insufficient to meet the
demands for real-time performance. Meanwhile, the optimization of CPU
usage with af_packet is quite significant. Use hrtimer instead of timer
to help compensate for the shortcomings in real-time performance.
In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
enough, with fluctuations reaching over 8ms (on a system with HZ=250).
This is unacceptable in some high real-time systems that require timely
processing of network packets. By replacing it with hrtimer, if a timeout
of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
3 ms.

Delete delete_blk_timer field, because hrtimer_cancel will check and wait
until the timer callback return and ensure never enter callback again.

Simplify the logic related to setting timeout, only update the hrtimer
expire time within the hrtimer callback, no longer update the expire time
in prb_open_block which is called by tpacket_rcv or timer callback.
Reasons why NOT update hrtimer in prb_open_block:
1) It will increase complexity to distinguish the two caller scenario.
2) hrtimer_cancel and hrtimer_start need to be called if you want to update
TMO of an already enqueued hrtimer, leading to complex shutdown logic.

One side effect of NOT update hrtimer when called by tpacket_rcv is that
a newly opened block triggered by tpacket_rcv may be retired earlier than
expected. On the other hand, if timeout is updated in prb_open_block, the
frequent reception of network packets that leads to prb_open_block being
called may cause hrtimer to be removed and enqueued repeatedly.

The retire hrtimer expiration is unconditional and periodic. If there are
numerous packet sockets on the system, please set an appropriate timeout
to avoid frequent enqueueing of hrtimers.


Reviewed-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://lore.kernel.org/all/20250831100822.1238795-1-jackzxcui1989@163.com/
Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
Changes in v12:
- Add reason why delete delete_blk_timer field in the commit message
  as suggested by Jason Xing.
- Add reason why NOT update hrtimer in prb_open_block in the commit message
  as suggested by Jason Xing.

Changes in v11:
- structure tpacket_kbdq_core needs a new organization
  as suggested by Jason Xing.
- Change the comments of prb_retire_rx_blk_timer_expired and prb_open_block
  as suggested by Jason Xing.

Changes in v9:
- Remove the function prb_setup_retire_blk_timer and move hrtimer setup and start
  logic into function init_prb_bdqc
  as suggested by Willem de Bruijn.
- Remove 'refresh_timer:' label which is not needed while I change goto logic to
  if-else implementation.

Changes in v8:
- Delete delete_blk_timer field, as suggested by Willem de Bruijn,
  hrtimer_cancel will check and wait until the timer callback return and ensure
  never enter callback again.
- Simplify the logic related to setting timeout, as suggestd by Willem de Bruijn.
  Currently timer callback just restarts itself unconditionally, so delete the
  'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_forward_now
  directly and always return HRTIMER_RESTART.
  The only special case is when prb_open_block is called from tpacket_rcv. That
  would set the timeout further into the future than the already queued timer.
  An earlier timeout is not problematic. No need to add complexity to avoid that.

Changes in v7:
- Only update the hrtimer expire time within the hrtimer callback.
  When the callback return, without sk_buff_head lock protection, __run_hrtimer will
  enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expires while
  enqueuing a timer may cause chaos in the hrtimer red-black tree.

Changes in v2:
- Drop the tov_in_msecs field of tpacket_kbdq_core added by the patch
  as suggested by Willem de Bruijn.

Changes in v1:
- Do not add another config for the current changes
  as suggested by Eric Dumazet.
- Mention the beneficial cases 'HZ=100 or HZ=250' and performance details
  in the changelog
  as suggested by Eric Dumazet and Ferenc Fejes.
- Delete the 'pkc->tov_in_msecs == 0' bounds check which is not necessary
  as suggested by Willem de Bruijn.

---
 net/packet/af_packet.c | 104 +++++++++++------------------------------
 net/packet/diag.c      |   2 +-
 net/packet/internal.h  |  10 ++--
 3 files changed, 33 insertions(+), 83 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d4eb4a4fe..f0f8955c0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -203,8 +203,7 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *,
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
 		struct tpacket_block_desc *);
-static void prb_retire_rx_blk_timer_expired(struct timer_list *);
-static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *);
 static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hdr *);
 static void prb_clear_rxhash(struct tpacket_kbdq_core *,
 		struct tpacket3_hdr *);
@@ -579,33 +578,13 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 	return proto;
 }
 
-static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
-{
-	timer_delete_sync(&pkc->retire_blk_timer);
-}
-
 static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
 		struct sk_buff_head *rb_queue)
 {
 	struct tpacket_kbdq_core *pkc;
 
 	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
-
-	spin_lock_bh(&rb_queue->lock);
-	pkc->delete_blk_timer = 1;
-	spin_unlock_bh(&rb_queue->lock);
-
-	prb_del_retire_blk_timer(pkc);
-}
-
-static void prb_setup_retire_blk_timer(struct packet_sock *po)
-{
-	struct tpacket_kbdq_core *pkc;
-
-	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
-	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
-		    0);
-	pkc->retire_blk_timer.expires = jiffies;
+	hrtimer_cancel(&pkc->retire_blk_timer);
 }
 
 static int prb_calc_retire_blk_tmo(struct packet_sock *po,
@@ -671,53 +650,34 @@ static void init_prb_bdqc(struct packet_sock *po,
 	p1->version = po->tp_version;
 	po->stats.stats3.tp_freeze_q_cnt = 0;
 	if (req_u->req3.tp_retire_blk_tov)
-		p1->retire_blk_tov = req_u->req3.tp_retire_blk_tov;
+		p1->interval_ktime = ms_to_ktime(req_u->req3.tp_retire_blk_tov);
 	else
-		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
-						req_u->req3.tp_block_size);
-	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
+		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
+						 req_u->req3.tp_block_size));
 	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
 	rwlock_init(&p1->blk_fill_in_prog_lock);
 
 	p1->max_frame_len = p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeof_priv);
 	prb_init_ft_ops(p1, req_u);
-	prb_setup_retire_blk_timer(po);
+	hrtimer_setup(&p1->retire_blk_timer, prb_retire_rx_blk_timer_expired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
+		      HRTIMER_MODE_REL_SOFT);
 	prb_open_block(p1, pbd);
 }
 
-/*  Do NOT update the last_blk_num first.
- *  Assumes sk_buff_head lock is held.
- */
-static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
-{
-	mod_timer(&pkc->retire_blk_timer,
-			jiffies + pkc->tov_in_jiffies);
-}
-
 /*
- * Timer logic:
- * 1) We refresh the timer only when we open a block.
- *    By doing this we don't waste cycles refreshing the timer
- *	  on packet-by-packet basis.
- *
  * With a 1MB block-size, on a 1Gbps line, it will take
  * i) ~8 ms to fill a block + ii) memcpy etc.
  * In this cut we are not accounting for the memcpy time.
  *
- * So, if the user sets the 'tmo' to 10ms then the timer
- * will never fire while the block is still getting filled
- * (which is what we want). However, the user could choose
- * to close a block early and that's fine.
- *
- * But when the timer does fire, we check whether or not to refresh it.
  * Since the tmo granularity is in msecs, it is not too expensive
  * to refresh the timer, lets say every '8' msecs.
  * Either the user can set the 'tmo' or we can derive it based on
  * a) line-speed and b) block-size.
  * prb_calc_retire_blk_tmo() calculates the tmo.
- *
  */
-static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
 {
 	struct packet_sock *po =
 		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
@@ -730,9 +690,6 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	frozen = prb_queue_frozen(pkc);
 	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
 
-	if (unlikely(pkc->delete_blk_timer))
-		goto out;
-
 	/* We only need to plug the race when the block is partially filled.
 	 * tpacket_rcv:
 	 *		lock(); increment BLOCK_NUM_PKTS; unlock()
@@ -749,26 +706,16 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	}
 
 	if (!frozen) {
-		if (!BLOCK_NUM_PKTS(pbd)) {
-			/* An empty block. Just refresh the timer. */
-			goto refresh_timer;
+		if (BLOCK_NUM_PKTS(pbd)) {
+			/* Not an empty block. Need retire the block. */
+			prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
+			prb_dispatch_next_block(pkc, po);
 		}
-		prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
-		if (!prb_dispatch_next_block(pkc, po))
-			goto refresh_timer;
-		else
-			goto out;
 	} else {
 		/* Case 1. Queue was frozen because user-space was
 		 * lagging behind.
 		 */
-		if (prb_curr_blk_in_use(pbd)) {
-			/*
-			 * Ok, user-space is still behind.
-			 * So just refresh the timer.
-			 */
-			goto refresh_timer;
-		} else {
+		if (!prb_curr_blk_in_use(pbd)) {
 			/* Case 2. queue was frozen,user-space caught up,
 			 * now the link went idle && the timer fired.
 			 * We don't have a block to close.So we open this
@@ -777,15 +724,12 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 			 * Thawing/timer-refresh is a side effect.
 			 */
 			prb_open_block(pkc, pbd);
-			goto out;
 		}
 	}
 
-refresh_timer:
-	_prb_refresh_rx_retire_blk_timer(pkc);
-
-out:
+	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+	return HRTIMER_RESTART;
 }
 
 static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
@@ -879,11 +823,18 @@ static void prb_thaw_queue(struct tpacket_kbdq_core *pkc)
 }
 
 /*
- * Side effect of opening a block:
+ * prb_open_block is called by tpacket_rcv or timer callback.
  *
- * 1) prb_queue is thawed.
- * 2) retire_blk_timer is refreshed.
+ * Reasons why NOT update hrtimer in prb_open_block:
+ * 1) It will increase complexity to distinguish the two caller scenario.
+ * 2) hrtimer_cancel and hrtimer_start need to be called if you want to update
+ * TMO of an already enqueued hrtimer, leading to complex shutdown logic.
  *
+ * One side effect of NOT update hrtimer when called by tpacket_rcv is that
+ * a newly opened block triggered by tpacket_rcv may be retired earlier than
+ * expected. On the other hand, if timeout is updated in prb_open_block, the
+ * frequent reception of network packets that leads to prb_open_block being
+ * called may cause hrtimer to be removed and enqueued repeatedly.
  */
 static void prb_open_block(struct tpacket_kbdq_core *pkc1,
 	struct tpacket_block_desc *pbd1)
@@ -917,7 +868,6 @@ static void prb_open_block(struct tpacket_kbdq_core *pkc1,
 	pkc1->pkblk_end = pkc1->pkblk_start + pkc1->kblk_size;
 
 	prb_thaw_queue(pkc1);
-	_prb_refresh_rx_retire_blk_timer(pkc1);
 
 	smp_wmb();
 }
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 6ce1dcc28..c8f43e0c1 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -83,7 +83,7 @@ static int pdiag_put_ring(struct packet_ring_buffer *ring, int ver, int nl_type,
 	pdr.pdr_frame_nr = ring->frame_max + 1;
 
 	if (ver > TPACKET_V2) {
-		pdr.pdr_retire_tmo = ring->prb_bdqc.retire_blk_tov;
+		pdr.pdr_retire_tmo = ktime_to_ms(ring->prb_bdqc.interval_ktime);
 		pdr.pdr_sizeof_priv = ring->prb_bdqc.blk_sizeof_priv;
 		pdr.pdr_features = ring->prb_bdqc.feature_req_word;
 	} else {
diff --git a/net/packet/internal.h b/net/packet/internal.h
index d367b9f93..b76e645cd 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -20,10 +20,11 @@ struct tpacket_kbdq_core {
 	unsigned int	feature_req_word;
 	unsigned int	hdrlen;
 	unsigned char	reset_pending_on_curr_blk;
-	unsigned char   delete_blk_timer;
 	unsigned short	kactive_blk_num;
 	unsigned short	blk_sizeof_priv;
 
+	unsigned short  version;
+
 	char		*pkblk_start;
 	char		*pkblk_end;
 	int		kblk_size;
@@ -32,6 +33,7 @@ struct tpacket_kbdq_core {
 	uint64_t	knxt_seq_num;
 	char		*prev;
 	char		*nxt_offset;
+
 	struct sk_buff	*skb;
 
 	rwlock_t	blk_fill_in_prog_lock;
@@ -39,12 +41,10 @@ struct tpacket_kbdq_core {
 	/* Default is set to 8ms */
 #define DEFAULT_PRB_RETIRE_TOV	(8)
 
-	unsigned short  retire_blk_tov;
-	unsigned short  version;
-	unsigned long	tov_in_jiffies;
+	ktime_t		interval_ktime;
 
 	/* timer to retire an outstanding block */
-	struct timer_list retire_blk_timer;
+	struct hrtimer  retire_blk_timer;
 };
 
 struct pgv {
-- 
2.34.1


