Return-Path: <netdev+bounces-218550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6AB3D200
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 12:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807DE17CE78
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A53254B09;
	Sun, 31 Aug 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nibyk53m"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABA25333F;
	Sun, 31 Aug 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756634954; cv=none; b=hu3y0qgXtiDQepo09N46ms2UDL8vmuQ/AzBT99elBKTcTRClKFhTe216HPAHL90udkSEhNMVcBanrY2TGVTxLk+ZlnhXEtFmaXN2xcxVFKpu5j3sUmXB+m5L3bxW1vNKXBu6cFgRfKBNg+oyH11dCpKcOqYmsCMOL1WrdBviAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756634954; c=relaxed/simple;
	bh=7qmMCrSvCXWBzVLmm00fIfxsMF1iK91xEagZCY5Y4J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hY7AE2Gypdcz+wcV/UFYtZR4Rj2Jwvtrmzg1+6JZwyeQCjXlfVWOMfJpPHZpzmMhgOO6qrX0hzCKgVfPVq/LYN1o45oN5bBFXoCuc1l6/dvJdhOVrNlG9h/qTAlomwNVscU65xmfymbWL75oA2mbLcPhQI2hzbcWFIKxdkcwV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nibyk53m; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1q
	7nt1GgkLAOlvi8QWZdSXDrk74zprU57mw7aZ4nq+8=; b=Nibyk53mILxrfsU6Kr
	5oXQGwa6c36O3fpq/mKTkxgqnEAXOvOvYkzbbWOKfCspZkB5JjuZGGj2BfqnMzJ9
	cbzuUIajDSEF+yUGD2NN9IrS4Ad/dnkDloa5HRB3JuMZhEQ5ZJMttxLREd37ydlM
	eZSc83z69h4ANFEB1mykLZAOA=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBH7U4YH7RoR1JrFA--.61212S4;
	Sun, 31 Aug 2025 18:08:37 +0800 (CST)
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
Subject: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the retire operation
Date: Sun, 31 Aug 2025 18:08:22 +0800
Message-Id: <20250831100822.1238795-3-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250831100822.1238795-1-jackzxcui1989@163.com>
References: <20250831100822.1238795-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH7U4YH7RoR1JrFA--.61212S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wry5Kr1fAF45JFy5Ar15CFg_yoW3tF1Dpa
	y5W34xGwsrXF4Ygw48Jrn7ZFyFgw1DAry5GrZ3Xwsayas3try3tF1j9FyYgFWftFZ2vw47
	JrsYqrZ8Cr1DXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRIJmUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbioxy6Cmi0EKHNJgAAsJ

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
Changes in v8:
- Simplify the logic related to setting timeout.

Changes in v7:
- Only update the hrtimer expire time within the hrtimer callback.

Changes in v1:
- Do not add another config for the current changes.

---
 net/packet/af_packet.c | 79 +++++++++---------------------------------
 net/packet/diag.c      |  2 +-
 net/packet/internal.h  |  6 ++--
 3 files changed, 20 insertions(+), 67 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d4eb4a4fe..3e3bb4216 100644
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
@@ -671,29 +650,22 @@ static void init_prb_bdqc(struct packet_sock *po,
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
-}
-
 /*
  * Timer logic:
  * 1) We refresh the timer only when we open a block.
@@ -717,7 +689,7 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
  * prb_calc_retire_blk_tmo() calculates the tmo.
  *
  */
-static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
 {
 	struct packet_sock *po =
 		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
@@ -730,9 +702,6 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	frozen = prb_queue_frozen(pkc);
 	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
 
-	if (unlikely(pkc->delete_blk_timer))
-		goto out;
-
 	/* We only need to plug the race when the block is partially filled.
 	 * tpacket_rcv:
 	 *		lock(); increment BLOCK_NUM_PKTS; unlock()
@@ -749,26 +718,16 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
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
@@ -777,15 +736,12 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
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
@@ -917,7 +873,6 @@ static void prb_open_block(struct tpacket_kbdq_core *pkc1,
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
index d367b9f93..f8cfd9213 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -20,7 +20,6 @@ struct tpacket_kbdq_core {
 	unsigned int	feature_req_word;
 	unsigned int	hdrlen;
 	unsigned char	reset_pending_on_curr_blk;
-	unsigned char   delete_blk_timer;
 	unsigned short	kactive_blk_num;
 	unsigned short	blk_sizeof_priv;
 
@@ -39,12 +38,11 @@ struct tpacket_kbdq_core {
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


