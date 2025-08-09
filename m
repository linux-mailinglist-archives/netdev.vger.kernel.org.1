Return-Path: <netdev+bounces-212327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BEB1F49E
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9506280E7
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19F4277031;
	Sat,  9 Aug 2025 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qeOsClHl"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC36A2264D5;
	Sat,  9 Aug 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754743440; cv=none; b=Zb6L9g8MtcjaXr1wop1qQzHxdNZAvG4M86DTy9pfKJ98L27rQ3UxwrZwwc2LP+4FXpCnyqcFr+e8RZD1QPBP5EOlv98gmyc1zCkAwOLiqSmNRrkRImMHt9Kt+eIGNfPtadVCd82AvDDn5Lmt67D8O2N54VlHSqUgPQ+kN7uWNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754743440; c=relaxed/simple;
	bh=Pt5O8cvMa9U1MePkJ0QUXD9z6XOc4WfhKfqOvZW9PwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qAB64x/jiDBwjSBUtP+Ad8hHuSBsACtO3kRtCECy7RWWseO4OL+UU8t8e9gqvH51KCfZ2VB5o+OBJ8VrDxysH91gTMq6/XqqYGcahfsPiRk5rlBhDdago9JlKYSarTcLZhCG/SWhGhkLCLJPshTmRfj8xLa7JD5rWsvq66q9BK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qeOsClHl; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=L4
	JDCVN1Sgu8VRA1475fCrKdfzxlvrn7c2lZmtM9NHM=; b=qeOsClHlqErbyWDQ66
	Ez4nm2EFjg7eYQ0oc5llVdEF5itIy32WcWiaw82/HygAm1KlW/OypvPOkN6Qf4/6
	tfvIRn+N0HEj7tyFPOfOx8kAtIKGvvbwniHDeiOGd4uiM0hDdUXSCWPAFoAy9iVW
	F0LTgSgMJo1lOGd5zfL6zUnt8=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3vwRjQpdoH75TAQ--.57739S2;
	Sat, 09 Aug 2025 20:43:16 +0800 (CST)
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
Subject: [PATCH] net: af_packet: Use hrtimer to do the retire operation
Date: Sat,  9 Aug 2025 20:43:13 +0800
Message-Id: <20250809124313.1677945-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vwRjQpdoH75TAQ--.57739S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1rAr1kWF4UGry7KF4Durg_yoWrKw43pa
	y5W34xGw47Za1agw48Jrs7ZFyYgw1DAry7G393Xwsay3Z3try5ta1j9Fyj9FW3tFZFyw47
	Ars5tFs8Cw1kJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEF1v7UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwCkCmiXOS2S4AAAsw

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
 net/packet/af_packet.c | 22 +++++++++++++---------
 net/packet/internal.h  |  4 ++--
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index bc438d0d9..3b3327544 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -203,7 +203,7 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *,
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
 		struct tpacket_block_desc *);
-static void prb_retire_rx_blk_timer_expired(struct timer_list *);
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *);
 static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
 static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hdr *);
 static void prb_clear_rxhash(struct tpacket_kbdq_core *,
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
+	if (pkc->tov_in_msecs == 0)
+		pkc->tov_in_msecs = jiffies_to_msecs(1);
 }
 
 static int prb_calc_retire_blk_tmo(struct packet_sock *po,
@@ -676,7 +677,7 @@ static void init_prb_bdqc(struct packet_sock *po,
 	else
 		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
 						req_u->req3.tp_block_size);
-	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
+	p1->tov_in_msecs = p1->retire_blk_tov;
 	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
 	rwlock_init(&p1->blk_fill_in_prog_lock);
 
@@ -691,8 +692,8 @@ static void init_prb_bdqc(struct packet_sock *po,
  */
 static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
-	mod_timer(&pkc->retire_blk_timer,
-			jiffies + pkc->tov_in_jiffies);
+	hrtimer_start_range_ns(&pkc->retire_blk_timer,
+			       ms_to_ktime(pkc->tov_in_msecs), 0, HRTIMER_MODE_REL_SOFT);
 	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }
 
@@ -719,8 +720,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
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
@@ -787,9 +789,11 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 
 refresh_timer:
 	_prb_refresh_rx_retire_blk_timer(pkc);
+	ret = HRTIMER_RESTART;
 
 out:
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+	return ret;
 }
 
 static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 1e743d031..41df245e3 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -47,10 +47,10 @@ struct tpacket_kbdq_core {
 
 	unsigned short  retire_blk_tov;
 	unsigned short  version;
-	unsigned long	tov_in_jiffies;
+	unsigned long	tov_in_msecs;
 
 	/* timer to retire an outstanding block */
-	struct timer_list retire_blk_timer;
+	struct hrtimer retire_blk_timer;
 };
 
 struct pgv {
-- 
2.34.1


