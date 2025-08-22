Return-Path: <netdev+bounces-216025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE68B3194F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC011D00C2C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78452FDC47;
	Fri, 22 Aug 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Khpn4c1Y"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134912FDC31;
	Fri, 22 Aug 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868897; cv=none; b=t0CeBSBloNHO8XcnmsVb3m2JvKRXiUu2ZamX3wwmlFgl5bbEPQjjCXA4z6EDd4BCCYuWVixaFykIsUc0QyABA6hy/hq/OOUtcX1f3kYSmiX0HAZ6AJ5Gg+lV3NiyZoHd6COdm+gRBvdnpcN15pDuUsriD0ssXCxlHlXPg78Qe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868897; c=relaxed/simple;
	bh=PWTMMGR2MjK+6b7GVya2OvT/tYdy1uYiKUY6Ty1OG7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kXN64RKkedKDMzLkE1VkqnJOumusmRWrJEVaoEGSyxac1DT40Yz1+AwR+rYIELIIYR/G/8EQK/QLi3UaCritARLuKM0V4LX91Ds1mE7iVvc2wD2y7vLQZUEXi3tNCp7A80KJB56EfpBuoM7WkebQhyH9WJ6ma7jjXGbyhZm8oKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Khpn4c1Y; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=AcfUi9/+Cv+r0AzKkBfbFcLAf2C1x1UuQnrSxezq+5k=;
	b=Khpn4c1YpRgfMKKn7ItcdOPl074ON3YrF/0KvQBQjrRGStbpcS3RZHj0/k+x4p
	2+B/F3fPzbGwrptMHQ5d6VZKBrhfXbN6Gwfbb+ezRfLPQYdlCX+fA5HPFJk/uKsF
	X92/dU/2Y924MxU6DtjXh8eyJfW3oZkLBIqs2vDYOdns0=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3PFi1bqhojcT1Dg--.42185S2;
	Fri, 22 Aug 2025 21:20:54 +0800 (CST)
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
Subject: [PATCH net-next v7] net: af_packet: Use hrtimer to do the retire operation
Date: Fri, 22 Aug 2025 21:20:51 +0800
Message-Id: <20250822132051.266787-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PFi1bqhojcT1Dg--.42185S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfGryfKw17WFWUXr13AF43Wrg_yoW8WryxAo
	Z3XrZ8Cr4ktF97A3ykCF10kFy3W3yDXr15XrsY9ryku3ZIvw15Wr12yay3Z3yfCw1Sywna
	yF18Ww1UXF1DKr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RvhFcUUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibh2xCmioQp0WNAABs0

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
Changes in v7:
- Only update the hrtimer expire time within the hrtimer callback.
  When the callback return, without sk_buff_head lock protection, __run_hrtimer will
  enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expires while
  enqueuing a timer may cause chaos in the hrtimer red-black tree.
  The setting expire time is monotonic, so if we do not update the expire time to the
  retire_blk_timer when it is not in callback, it will not cause problem if we skip
  the timeout event and update it when find out that expire_ktime is bigger than the
  expire time of retire_blk_timer.
- Use hrtimer_set_expires here instead of hrtimer_forward_now.
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
 net/packet/af_packet.c | 93 +++++++++++++++++++++++++++++-------------
 net/packet/diag.c      |  2 +-
 net/packet/internal.h  |  6 +--
 3 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a7017d7f0..654ae65ea 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -197,14 +197,14 @@ static void *packet_previous_frame(struct packet_sock *po,
 static void packet_increment_head(struct packet_ring_buffer *buff);
 static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
-			struct packet_sock *);
+			struct packet_sock *, bool);
 static void prb_retire_current_block(struct tpacket_kbdq_core *,
 		struct packet_sock *, unsigned int status);
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
-		struct tpacket_block_desc *);
-static void prb_retire_rx_blk_timer_expired(struct timer_list *);
-static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
+		struct tpacket_block_desc *, bool);
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *);
+static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *, bool);
 static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hdr *);
 static void prb_clear_rxhash(struct tpacket_kbdq_core *,
 		struct tpacket3_hdr *);
@@ -581,7 +581,7 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
-	timer_delete_sync(&pkc->retire_blk_timer);
+	hrtimer_cancel(&pkc->retire_blk_timer);
 }
 
 static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
@@ -603,9 +603,10 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
 	struct tpacket_kbdq_core *pkc;
 
 	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
-	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
-		    0);
-	pkc->retire_blk_timer.expires = jiffies;
+	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
+		      HRTIMER_MODE_REL_SOFT);
 }
 
 static int prb_calc_retire_blk_tmo(struct packet_sock *po,
@@ -672,27 +673,52 @@ static void init_prb_bdqc(struct packet_sock *po,
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
 	prb_setup_retire_blk_timer(po);
-	prb_open_block(p1, pbd);
+	prb_open_block(p1, pbd, false);
 }
 
 /*  Do NOT update the last_blk_num first.
  *  Assumes sk_buff_head lock is held.
  */
-static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
-{
-	mod_timer(&pkc->retire_blk_timer,
-			jiffies + pkc->tov_in_jiffies);
+static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
+					     bool callback)
+{
+	if (likely(ktime_to_ns(pkc->expire_ktime))) {
+		pkc->expire_ktime = ktime_add_safe(ktime_get(), pkc->interval_ktime);
+		if (callback) {
+			/* Three tips:
+			 * 1) Only update the hrtimer expire time within the callback.
+			 * When the callback return, without sk_buff_head lock protection,
+			 * __run_hrtimer will enqueue the timer if return HRTIMER_RESTART.
+			 * Setting the hrtimer expires while enqueuing a timer may cause
+			 * chaos in the hrtimer red-black tree.
+			 * 2) Use hrtimer_set_expires here instead of hrtimer_forward_now,
+			 * because the end time for retiring each block is not fixed
+			 * because when network packets are received quickly, blocks are
+			 * retired rapidly, and the new block retire time needs to be
+			 * recalculated. However, hrtimer_forward_now increments the
+			 * previous timeout by an interval, which is not correct.
+			 * 3）The expire time is monotonic, so if we do not update the
+			 * expire time to the retire_blk_timer when it is not in callback,
+			 * it will not cause problem if we skip the timeout event and
+			 * update it when find out that expire_ktime is bigger than the
+			 * expire time of retire_blk_timer.
+			 */
+			hrtimer_set_expires(&pkc->retire_blk_timer, pkc->expire_ktime);
+		}
+	} else {
+		/* Just after prb_setup_retire_blk_timer. */
+		pkc->expire_ktime = hrtimer_get_expires(&pkc->retire_blk_timer);
+	}
 	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }
 
@@ -719,8 +745,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
  * prb_calc_retire_blk_tmo() calculates the tmo.
  *
  */
-static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
 {
+	enum hrtimer_restart ret = HRTIMER_RESTART;
 	struct packet_sock *po =
 		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
 	struct tpacket_kbdq_core *pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
@@ -732,8 +759,17 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	frozen = prb_queue_frozen(pkc);
 	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
 
-	if (unlikely(pkc->delete_blk_timer))
+	if (unlikely(pkc->delete_blk_timer)) {
+		ret = HRTIMER_NORESTART;
 		goto out;
+	}
+
+	/* See comments in _prb_refresh_rx_retire_blk_timer. */
+	if (ktime_compare(pkc->expire_ktime,
+			  hrtimer_get_expires(&pkc->retire_blk_timer)) > 0) {
+		hrtimer_set_expires(&pkc->retire_blk_timer, pkc->expire_ktime);
+		goto out;
+	}
 
 	/* We only need to plug the race when the block is partially filled.
 	 * tpacket_rcv:
@@ -757,7 +793,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 				goto refresh_timer;
 			}
 			prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
-			if (!prb_dispatch_next_block(pkc, po))
+			if (!prb_dispatch_next_block(pkc, po, true))
 				goto refresh_timer;
 			else
 				goto out;
@@ -779,17 +815,18 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 				* opening a block thaws the queue,restarts timer
 				* Thawing/timer-refresh is a side effect.
 				*/
-				prb_open_block(pkc, pbd);
+				prb_open_block(pkc, pbd, true);
 				goto out;
 			}
 		}
 	}
 
 refresh_timer:
-	_prb_refresh_rx_retire_blk_timer(pkc);
+	_prb_refresh_rx_retire_blk_timer(pkc, true);
 
 out:
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+	return ret;
 }
 
 static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
@@ -890,7 +927,7 @@ static void prb_thaw_queue(struct tpacket_kbdq_core *pkc)
  *
  */
 static void prb_open_block(struct tpacket_kbdq_core *pkc1,
-	struct tpacket_block_desc *pbd1)
+	struct tpacket_block_desc *pbd1, bool callback)
 {
 	struct timespec64 ts;
 	struct tpacket_hdr_v1 *h1 = &pbd1->hdr.bh1;
@@ -921,7 +958,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pkc1,
 	pkc1->pkblk_end = pkc1->pkblk_start + pkc1->kblk_size;
 
 	prb_thaw_queue(pkc1);
-	_prb_refresh_rx_retire_blk_timer(pkc1);
+	_prb_refresh_rx_retire_blk_timer(pkc1, callback);
 
 	smp_wmb();
 }
@@ -965,7 +1002,7 @@ static void prb_freeze_queue(struct tpacket_kbdq_core *pkc,
  * So, caller must check the return value.
  */
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *pkc,
-		struct packet_sock *po)
+		struct packet_sock *po, bool callback)
 {
 	struct tpacket_block_desc *pbd;
 
@@ -985,7 +1022,7 @@ static void *prb_dispatch_next_block(struct tpacket_kbdq_core *pkc,
 	 * open this block and return the offset where the first packet
 	 * needs to get stored.
 	 */
-	prb_open_block(pkc, pbd);
+	prb_open_block(pkc, pbd, callback);
 	return (void *)pkc->nxt_offset;
 }
 
@@ -1124,7 +1161,7 @@ static void *__packet_lookup_frame_in_block(struct packet_sock *po,
 			 * opening a block also thaws the queue.
 			 * Thawing is a side effect.
 			 */
-			prb_open_block(pkc, pbd);
+			prb_open_block(pkc, pbd, false);
 		}
 	}
 
@@ -1143,7 +1180,7 @@ static void *__packet_lookup_frame_in_block(struct packet_sock *po,
 	prb_retire_current_block(pkc, po, 0);
 
 	/* Now, try to dispatch the next block */
-	curr = (char *)prb_dispatch_next_block(pkc, po);
+	curr = (char *)prb_dispatch_next_block(pkc, po, false);
 	if (curr) {
 		pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
 		prb_fill_curr_block(curr, pkc, pbd, len);
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
index 1e743d031..f2df563c7 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -45,12 +45,12 @@ struct tpacket_kbdq_core {
 	/* Default is set to 8ms */
 #define DEFAULT_PRB_RETIRE_TOV	(8)
 
-	unsigned short  retire_blk_tov;
+	ktime_t		interval_ktime;
 	unsigned short  version;
-	unsigned long	tov_in_jiffies;
 
 	/* timer to retire an outstanding block */
-	struct timer_list retire_blk_timer;
+	struct hrtimer  retire_blk_timer;
+	ktime_t		expire_ktime;
 };
 
 struct pgv {
-- 
2.34.1


