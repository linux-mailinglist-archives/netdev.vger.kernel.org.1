Return-Path: <netdev+bounces-215194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F11CB2D8A0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818E31C80084
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E92DFA5B;
	Wed, 20 Aug 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JvM1j41g"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D12E250BEC;
	Wed, 20 Aug 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682209; cv=none; b=P+L50TlT7KpJ3niS2tjlMT1bWGoy++G7Q265iEGuSDzl2OyO4pFD0bJbfs1avIxnAhGIiSBmM/e3XhNL2qeRpF0Ek0XvDY2jDDheX7iT3QsHf6t/O+tReSTmG5RMIg+MWme7ZQsp4lXXszCFSip0tSNYCm25p3VgIgMsZhdalTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682209; c=relaxed/simple;
	bh=4PjsTaCetj7q05pkNYzuJ4QMTWt2j0IkPWgUewDqPg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AwC1mMvaa7LJ3C4x/oZ4zLGHt1So1j0QwiarN7wc7BCoZp3UpO6hkCBPvIMXJ2fg/Jy38u7Pcgx1eZaBgKeZ4iZ9LmjKAc0LLXdw0mQHePl8rxqHi8QjUJxTyJoe+QWuxv6xfQEvrMZCd6F6xCfeBxY2HYtKCTAj3pPgQvbylyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JvM1j41g; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BG
	EHF+wNQyZT7glh2wflzCq5i3ZWzd6fair4MZBq3vQ=; b=JvM1j41gZrFG97rlXS
	NAu9vBJrj+BE2ebzvmzp2Xp+oV14c/7to7MfbzNnorIOCs7bYJY4jesHDBp0AqmA
	x6Me3mBEMMugaQDEmeXDB4+uuVi3gcSHZkdetYN1uuFYOBJ1bH3GLfk4beXcuK6H
	Q3hrkPfuzKcKNhUzhTpyf38rs=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3p7h5laVoMiYWDQ--.14313S2;
	Wed, 20 Aug 2025 17:29:30 +0800 (CST)
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
Subject: [PATCH net-next v6] net: af_packet: Use hrtimer to do the retire operation
Date: Wed, 20 Aug 2025 17:29:25 +0800
Message-Id: <20250820092925.2115372-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3p7h5laVoMiYWDQ--.14313S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3CFWDXFyxJFyDAF17KFyrtFb_yoWDCry7pa
	y5W34xGw47ZF4agw48Ars7ZFyFgwn8AryUG393Xw4Sy3ZxtryrtF429r90gFWxtFZFk3W7
	Ar4FqF15Aw1DXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEjg4JUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgKvCmilj7mdRwAAso

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
Changes in v6:
- Use hrtimer_is_queued instead to check whether it is within the callback function.
  So do not need to add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer
  as suggested by Willem de Bruijn;
- Do not need local_irq_save and local_irq_restore to protect the race of the timer
  callback running in softirq context or the open_block from tpacket_rcv in process
  context
  as suggested by Willem de Bruijn;

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
 net/packet/af_packet.c | 40 +++++++++++++++++++++++-----------------
 net/packet/diag.c      |  2 +-
 net/packet/internal.h  |  5 ++---
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a7017d7f0..9b13939a6 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -203,8 +203,8 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *,
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
 		struct tpacket_block_desc *);
-static void prb_retire_rx_blk_timer_expired(struct timer_list *);
-static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
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
@@ -603,9 +603,8 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
 	struct tpacket_kbdq_core *pkc;
 
 	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
-	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
-		    0);
-	pkc->retire_blk_timer.expires = jiffies;
+	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 }
 
 static int prb_calc_retire_blk_tmo(struct packet_sock *po,
@@ -672,11 +671,10 @@ static void init_prb_bdqc(struct packet_sock *po,
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
 
@@ -689,10 +687,14 @@ static void init_prb_bdqc(struct packet_sock *po,
 /*  Do NOT update the last_blk_num first.
  *  Assumes sk_buff_head lock is held.
  */
-static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
+static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
+					     bool start)
 {
-	mod_timer(&pkc->retire_blk_timer,
-			jiffies + pkc->tov_in_jiffies);
+	if (start && !hrtimer_is_queued(&pkc->retire_blk_timer))
+		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
+			      HRTIMER_MODE_REL_SOFT);
+	else
+		hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
 	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }
 
@@ -719,8 +721,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
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
@@ -732,8 +735,10 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	frozen = prb_queue_frozen(pkc);
 	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
 
-	if (unlikely(pkc->delete_blk_timer))
+	if (unlikely(pkc->delete_blk_timer)) {
+		ret = HRTIMER_NORESTART;
 		goto out;
+	}
 
 	/* We only need to plug the race when the block is partially filled.
 	 * tpacket_rcv:
@@ -786,10 +791,11 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	}
 
 refresh_timer:
-	_prb_refresh_rx_retire_blk_timer(pkc);
+	_prb_refresh_rx_retire_blk_timer(pkc, false);
 
 out:
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+	return ret;
 }
 
 static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
@@ -921,7 +927,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pkc1,
 	pkc1->pkblk_end = pkc1->pkblk_start + pkc1->kblk_size;
 
 	prb_thaw_queue(pkc1);
-	_prb_refresh_rx_retire_blk_timer(pkc1);
+	_prb_refresh_rx_retire_blk_timer(pkc1, true);
 
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
index 1e743d031..19d4f0b73 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -45,12 +45,11 @@ struct tpacket_kbdq_core {
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


