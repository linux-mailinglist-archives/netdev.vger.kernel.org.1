Return-Path: <netdev+bounces-217893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FAAB3A4F1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F2F1C82CE1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A038251795;
	Thu, 28 Aug 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gluQwc12"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09BA250BF2;
	Thu, 28 Aug 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396330; cv=none; b=PWXEiUSIWIpP/94VPiwSg9wFIWbbv11CkCg8uhmZhdp3gLXjNe2tcSCJNeXgNJZGWrEVAl728DWO4qXLGbwRn8dvmdMCHqj3X5W2ebdQ8R9j2H7/dkNia1EglYX/GKfaxQuytdM0v5kEgaXNx61RpfdTugRwhSr8kvNeGfBds6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396330; c=relaxed/simple;
	bh=7PTJ60F0hXGL/Cy1sxPmApsJTcueTJTVccGoihJKpfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d597Hu+wpEwdveigtJa8CmaymsBujYJoQ61fMOHyYCVymKLO4LFP3mp9ts9LDbWnCqXlwYGQ98TkdRTPD7VObaqqLuB08kJ4N+ZlUSplcUkM3UahoF1ytMb3+DbDNRk9w7xTNvtGO1ZFpaefotiTrgeHRgoyybhgbdyl+r+2r08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gluQwc12; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+N
	JJwFEySXnHLIO/gLLEMLqgGsW9CtHSaYY1s2KdTHQ=; b=gluQwc12EEMo1qglwm
	dOzQr8ZLbdTAo/wtoZ18BqU+Bz7NWhEI9UjhZwJvjJWmTv8zgmdMnFi3LpJmpDzp
	ysCp19tZl8erosomgTPYD2n3Q8SAMuGhJB+ht6/NDYyMzw5yQAGLaB1NZOIfGMQT
	bgJLu6j0/tvh+8wVa6AQcns9M=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBXsuMAe7BoUqSqAw--.8799S2;
	Thu, 28 Aug 2025 23:51:29 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH net-next v9] net: af_packet: Use hrtimer to do the retire operation
Date: Thu, 28 Aug 2025 23:51:27 +0800
Message-Id: <20250828155127.3076551-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBXsuMAe7BoUqSqAw--.8799S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Kw4xtFyxCFWfAryfJryUtrb_yoW8XrW7Co
	Z3XrZ8Cr4kAFyDA3ykCFy0kFy3W3yqqr1UJr4F9r1ku3Z2vr15Wr1xAay3Z3yfuw1Skw1q
	yFy8W347XF1DKr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRajg3UUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRx+3CmiweZ8XSQAAsF

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

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

---
Changes in v9:
- Remove the function prb_setup_retire_blk_timer and move hrtimer setup and start
  logic into function init_prb_bdqc
  as suggested by Willem de Bruijn;
- Always update last_kactive_blk_num before hrtimer callback return as the origin
  logic does, as suggested by Willem de Bruijn.
  In tpacket_rcv, it may call prb_close_block but do not call prb_open_block in
  prb_dispatch_next_block, leading to inconsistency between last_kactive_blk_num
  and kactive_blk_num. In hrtimer callback, we should update last_kactive_blk_num
  in this case.
- Remove 'refresh_timer:' label which is not needed while I change goto logic to
  if-else implementation.

Changes in v8:
- Delete delete_blk_timer field, as suggested by Willem de Bruijn,
  hrtimer_cancel will check and wait until the timer callback return and ensure
  enter enter callback again;
- Simplify the logic related to setting timeout, as suggestd by Willem de Bruijn.
  Currently timer callback just restarts itself unconditionally, so delete the
 'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_forward_now
  directly and always return HRTIMER_RESTART. The only special case is when
  prb_open_block is called from tpacket_rcv. That would set the timeout further
  into the future than the already queued timer. An earlier timeout is not
  problematic. No need to add complexity to avoid that.
- Link to v8: https://lore.kernel.org/all/20250827150131.2193485-1-jackzxcui1989@163.com/

Changes in v7:
- Only update the hrtimer expire time within the hrtimer callback.
  When the callback return, without sk_buff_head lock protection, __run_hrtimer will
  enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expires while
  enqueuing a timer may cause chaos in the hrtimer red-black tree.
  The setting expire time is monotonic, so if we do not update the expire time to the
  retire_blk_timer when it is not in callback, it will not cause problem if we skip
  the timeout event and update it when find out that expire_ktime is bigger than the
  expire time of retire_blk_timer.
- Use hrtimer_set_expires instead of hrtimer_forward_now.
  The end time for retiring each block is not fixed because when network packets are
  received quickly, blocks are retired rapidly, and the new block retire time needs
  to be recalculated. However, hrtimer_forward_now increments the previous timeout
  by an interval, which is not correct.
- The expire time is monotonic, so if we do not update the expire time to the
  retire_blk_timer when it is not in callback, it will not cause problem if we skip
  the timeout event and update it when find out that expire_ktime is bigger than the
  expire time of retire_blk_timer.
- Adding the 'bool callback' parameter back is intended to more accurately determine
  whether we are inside the hrtimer callback when executing
  _prb_refresh_rx_retire_blk_timer. This ensures that we only update the hrtimer's
  timeout value within the hrtimer callback.
- Link to v7: https://lore.kernel.org/all/20250822132051.266787-1-jackzxcui1989@163.com/

Changes in v6:
- Use hrtimer_is_queued instead to check whether it is within the callback function.
  So do not need to add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer
  as suggested by Willem de Bruijn;
- Do not need local_irq_save and local_irq_restore to protect the race of the timer
  callback running in softirq context or the open_block from tpacket_rcv in process
  context
  as suggested by Willem de Bruijn;
- Link to v6: https://lore.kernel.org/all/20250820092925.2115372-1-jackzxcui1989@163.com/

Changes in v5:
- Remove the unnecessary comments at the top of the _prb_refresh_rx_retire_blk_timer,
  branch is self-explanatory enough
  as suggested by Willem de Bruijn;
- Indentation of _prb_refresh_rx_retire_blk_timer, align with first argument on
  previous line
  as suggested by Willem de Bruijn;
- Do not call hrtimer_start within the hrtimer callback
  as suggested by Willem de Bruijn
  So add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer to indicate
  whether it is within the callback function. Use hrtimer_forward_now instead of
  hrtimer_start when it is in the callback function and is doing prb_open_block.
- Link to v5: https://lore.kernel.org/all/20250819091447.1199980-1-jackzxcui1989@163.com/

Changes in v4:
- Add 'bool start' to distinguish whether the call to _prb_refresh_rx_retire_blk_timer
  is for prb_open_block. When it is for prb_open_block, execute hrtimer_start to
  (re)start the hrtimer; otherwise, use hrtimer_forward_now to set the expiration
  time as it is more commonly used compared to hrtimer_set_expires.
  as suggested by Willem de Bruijn;
- Delete the comments to explain why hrtimer_set_expires(not hrtimer_forward_now)
  is used, as we do not use hrtimer_set_expires any more;
- Link to v4: https://lore.kernel.org/all/20250818050233.155344-1-jackzxcui1989@163.com/

Changes in v3:
- return HRTIMER_NORESTART when pkc->delete_blk_timer is true
  as suggested by Willem de Bruijn;
- Drop the retire_blk_tov field of tpacket_kbdq_core, add interval_ktime instead
  as suggested by Willem de Bruijn;
- Add comments to explain why hrtimer_set_expires(not hrtimer_forward_now) is used in
  _prb_refresh_rx_retire_blk_timer
  as suggested by Willem de Bruijn;
- Link to v3: https://lore.kernel.org/all/20250816170130.3969354-1-jackzxcui1989@163.com/

Changes in v2:
- Drop the tov_in_msecs field of tpacket_kbdq_core added by the patch
  as suggested by Willem de Bruijn;
- Link to v2: https://lore.kernel.org/all/20250815044141.1374446-1-jackzxcui1989@163.com/

Changes in v1:
- Do not add another config for the current changes
  as suggested by Eric Dumazet;
- Mention the beneficial cases 'HZ=100 or HZ=250' in the changelog
  as suggested by Eric Dumazet;
- Add some performance details to the changelog
  as suggested by Ferenc Fejes;
- Delete the 'pkc->tov_in_msecs == 0' bounds check which is not necessary
  as suggested by Willem de Bruijn;
- Use hrtimer_set_expires instead of hrtimer_start_range_ns when retire timer needs update
  as suggested by Willem de Bruijn. Start the hrtimer in prb_setup_retire_blk_timer;
- Just return HRTIMER_RESTART directly as all cases return the same value
  as suggested by Willem de Bruijn;
- Link to v1: https://lore.kernel.org/all/20250813165201.1492779-1-jackzxcui1989@163.com/
- Link to v0: https://lore.kernel.org/all/20250806055210.1530081-1-jackzxcui1989@163.com/
---
 net/packet/af_packet.c | 82 ++++++++++--------------------------------
 net/packet/diag.c      |  2 +-
 net/packet/internal.h  |  6 ++--
 3 files changed, 22 insertions(+), 68 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a7017d7f0..38308b142 100644
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
@@ -672,30 +651,22 @@ static void init_prb_bdqc(struct packet_sock *po,
 	p1->last_kactive_blk_num = 0;
 	po->stats.stats3.tp_freeze_q_cnt = 0;
 	if (req_u->req3.tp_retire_blk_tov)
-		p1->retire_blk_tov = req_u->req3.tp_retire_blk_tov;
+		p1->interval_ktime = ms_to_ktime(req_u->req3.tp_retire_blk_tov);
 	else
-		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
-						req_u->req3.tp_block_size);
-	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
+		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
+						req_u->req3.tp_block_size));
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
-	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
-}
-
 /*
  * Timer logic:
  * 1) We refresh the timer only when we open a block.
@@ -719,7 +690,7 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
  * prb_calc_retire_blk_tmo() calculates the tmo.
  *
  */
-static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
 {
 	struct packet_sock *po =
 		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
@@ -732,9 +703,6 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	frozen = prb_queue_frozen(pkc);
 	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
 
-	if (unlikely(pkc->delete_blk_timer))
-		goto out;
-
 	/* We only need to plug the race when the block is partially filled.
 	 * tpacket_rcv:
 	 *		lock(); increment BLOCK_NUM_PKTS; unlock()
@@ -752,26 +720,16 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 
 	if (pkc->last_kactive_blk_num == pkc->kactive_blk_num) {
 		if (!frozen) {
-			if (!BLOCK_NUM_PKTS(pbd)) {
-				/* An empty block. Just refresh the timer. */
-				goto refresh_timer;
+			if (BLOCK_NUM_PKTS(pbd)) {
+				/* Not an empty block. Need retire the block. */
+				prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
+				prb_dispatch_next_block(pkc, po);
 			}
-			prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
-			if (!prb_dispatch_next_block(pkc, po))
-				goto refresh_timer;
-			else
-				goto out;
 		} else {
 			/* Case 1. Queue was frozen because user-space was
 			 *	   lagging behind.
 			 */
-			if (prb_curr_blk_in_use(pbd)) {
-				/*
-				 * Ok, user-space is still behind.
-				 * So just refresh the timer.
-				 */
-				goto refresh_timer;
-			} else {
+			if (!prb_curr_blk_in_use(pbd)) {
 			       /* Case 2. queue was frozen,user-space caught up,
 				* now the link went idle && the timer fired.
 				* We don't have a block to close.So we open this
@@ -780,16 +738,14 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 				* Thawing/timer-refresh is a side effect.
 				*/
 				prb_open_block(pkc, pbd);
-				goto out;
 			}
 		}
 	}
 
-refresh_timer:
-	_prb_refresh_rx_retire_blk_timer(pkc);
-
-out:
+	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
+	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+	return HRTIMER_RESTART;
 }
 
 static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
@@ -921,7 +877,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pkc1,
 	pkc1->pkblk_end = pkc1->pkblk_start + pkc1->kblk_size;
 
 	prb_thaw_queue(pkc1);
-	_prb_refresh_rx_retire_blk_timer(pkc1);
+	pkc1->last_kactive_blk_num = pkc1->kactive_blk_num;
 
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
index 1e743d031..30ae8979f 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -20,7 +20,6 @@ struct tpacket_kbdq_core {
 	unsigned int	feature_req_word;
 	unsigned int	hdrlen;
 	unsigned char	reset_pending_on_curr_blk;
-	unsigned char   delete_blk_timer;
 	unsigned short	kactive_blk_num;
 	unsigned short	blk_sizeof_priv;
 
@@ -45,12 +44,11 @@ struct tpacket_kbdq_core {
 	/* Default is set to 8ms */
 #define DEFAULT_PRB_RETIRE_TOV	(8)
 
-	unsigned short  retire_blk_tov;
+	ktime_t		interval_ktime;
 	unsigned short  version;
-	unsigned long	tov_in_jiffies;
 
 	/* timer to retire an outstanding block */
-	struct timer_list retire_blk_timer;
+	struct hrtimer  retire_blk_timer;
 };
 
 struct pgv {
-- 
2.34.1


