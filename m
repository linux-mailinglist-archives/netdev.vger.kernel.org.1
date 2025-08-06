Return-Path: <netdev+bounces-211861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82EB1C018
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 07:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505DD1809A5
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B31DEFD2;
	Wed,  6 Aug 2025 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EPY7Sshd"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B223273FE;
	Wed,  6 Aug 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459572; cv=none; b=Ux++VAL63iSVPafK8T0ZDLsDYWW88oayZXbBZDjDVrmUPS9HO+z8EFWaLeCQuhnhKyAlXWSN9OCllDebHRlX3otHBHdxTBa6BwUWa/d8umP/81+C6DUB9Kbz33lWMKD8tzmwoQs821RdMqnbEVQ46s7a9vFyyTKqsATtQ+BmdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459572; c=relaxed/simple;
	bh=YSRcS+dgRhVhp4dFl1VEUiNmKk0BAkoubIC6cIWnVo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtobHYqihRFJiM0o4DjaZxpqMHhQLvC9fVpfbDe6/at6lBxOg+ZKnIomI4vLQnGxbP7a8ZTK8BDjqzTAzYrGTXwJatEQsOljkpLuhgv0WpKik1au5LPojlW9wR/8HHm/tGTOMl2EhbWI5B+C6yi6ogapab/CpKwl+zgOhKFzaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EPY7Sshd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ao
	iFMQ50QbQOJteD++Wvjhr3mOpBX4MMEoWbs5t9s3E=; b=EPY7Sshd9Aoc3wQ2CA
	bZLW/b6cGYHa7dBHecWaF5cOiDBasmK/u4V6O4pkRDX474r5/8s3vZzKoB+ue1gU
	Mjx5lShT2kAGudx/26sZNuh9smHuMDP32XYVT3A0LvnmZiKlDd90cSxNoafdVb1D
	97FDzy5vGJ1+Dr2e+ZmRvV2j4=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3f36N7ZJoRYI3AA--.9978S2;
	Wed, 06 Aug 2025 13:52:14 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] net: af_packet: add af_packet hrtimer mode
Date: Wed,  6 Aug 2025 13:52:10 +0800
Message-Id: <20250806055210.1530081-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f36N7ZJoRYI3AA--.9978S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF1fAF17ZFy5WFykCr15urg_yoW7Zw45pa
	y5GryxGw43J3Wagw4xJrn7AFyagwn5Ary5W393Xw1Sy3Z3try5t3Wj9F909FWfJFZrJ3y7
	Ar4vqF15Cr1DX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piiSdfUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRxyhCmiS5LpRoQABsl

In a system with high real-time requirements, the timeout mechanism of
ordinary timers with jiffies granularity is insufficient to meet the
demands for real-time performance. Meanwhile, the optimization of CPU
usage with af_packet is quite significant. Add hrtimer mode to help
compensate for the shortcomings in real-time performance.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 net/packet/Kconfig     | 10 ++++++++++
 net/packet/af_packet.c | 39 +++++++++++++++++++++++++++++++++++++++
 net/packet/internal.h  |  8 ++++++++
 3 files changed, 57 insertions(+)

diff --git a/net/packet/Kconfig b/net/packet/Kconfig
index 2997382d5..5e77ce08e 100644
--- a/net/packet/Kconfig
+++ b/net/packet/Kconfig
@@ -23,3 +23,13 @@ config PACKET_DIAG
 	help
 	  Support for PF_PACKET sockets monitoring interface used by the ss tool.
 	  If unsure, say Y.
+
+config PACKET_HRTIMER
+	tristate "Packet: use hrtimer instead of timer"
+	depends on PACKET
+	default n
+	help
+	  Support hrtimer mode for PF_PACKET sockets to improve real-time
+	  performance. The default timeout mechanism with jiffies granularity
+	  is insufficient to meet the demands for real-time performance.
+	  If unsure, say N.
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index bc438d0d9..5c7e4ef89 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -203,7 +203,11 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *,
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
 		struct tpacket_block_desc *);
+#ifdef CONFIG_PACKET_HRTIMER
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *);
+#else
 static void prb_retire_rx_blk_timer_expired(struct timer_list *);
+#endif
 static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
 static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hdr *);
 static void prb_clear_rxhash(struct tpacket_kbdq_core *,
@@ -581,7 +585,11 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
+#ifdef CONFIG_PACKET_HRTIMER
+	hrtimer_cancel(&pkc->retire_blk_timer);
+#else
 	timer_delete_sync(&pkc->retire_blk_timer);
+#endif
 }
 
 static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
@@ -603,9 +611,16 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
 	struct tpacket_kbdq_core *pkc;
 
 	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
+#ifdef CONFIG_PACKET_HRTIMER
+	hrtimer_init(&pkc->retire_blk_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	pkc->retire_blk_timer.function = prb_retire_rx_blk_timer_expired;
+	if (pkc->tov_in_msecs == 0)
+		pkc->tov_in_msecs = jiffies_to_msecs(1);
+#else
 	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
 		    0);
 	pkc->retire_blk_timer.expires = jiffies;
+#endif
 }
 
 static int prb_calc_retire_blk_tmo(struct packet_sock *po,
@@ -676,7 +691,11 @@ static void init_prb_bdqc(struct packet_sock *po,
 	else
 		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
 						req_u->req3.tp_block_size);
+#ifdef CONFIG_PACKET_HRTIMER
+	p1->tov_in_msecs = p1->retire_blk_tov;
+#else
 	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
+#endif
 	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
 	rwlock_init(&p1->blk_fill_in_prog_lock);
 
@@ -691,8 +710,15 @@ static void init_prb_bdqc(struct packet_sock *po,
  */
 static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
+#ifdef CONFIG_PACKET_HRTIMER
+	hrtimer_start_range_ns(&pkc->retire_blk_timer,
+				ms_to_ktime(pkc->tov_in_msecs),
+				0,
+				HRTIMER_MODE_REL_SOFT);
+#else
 	mod_timer(&pkc->retire_blk_timer,
 			jiffies + pkc->tov_in_jiffies);
+#endif
 	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }
 
@@ -719,8 +745,15 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
  * prb_calc_retire_blk_tmo() calculates the tmo.
  *
  */
+#ifdef CONFIG_PACKET_HRTIMER
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
+#else
 static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
+#endif
 {
+#ifdef CONFIG_PACKET_HRTIMER
+	enum hrtimer_restart ret = HRTIMER_RESTART;
+#endif
 	struct packet_sock *po =
 		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
 	struct tpacket_kbdq_core *pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
@@ -787,9 +820,15 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 
 refresh_timer:
 	_prb_refresh_rx_retire_blk_timer(pkc);
+#ifdef CONFIG_PACKET_HRTIMER
+	ret = HRTIMER_RESTART;
+#endif
 
 out:
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+#ifdef CONFIG_PACKET_HRTIMER
+	return ret;
+#endif
 }
 
 static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 1e743d031..d9f2b2492 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -47,10 +47,18 @@ struct tpacket_kbdq_core {
 
 	unsigned short  retire_blk_tov;
 	unsigned short  version;
+#ifdef CONFIG_PACKET_HRTIMER
+	unsigned long	tov_in_msecs;
+#else
 	unsigned long	tov_in_jiffies;
+#endif
 
 	/* timer to retire an outstanding block */
+#ifdef CONFIG_PACKET_HRTIMER
+	struct hrtimer retire_blk_timer;
+#else
 	struct timer_list retire_blk_timer;
+#endif
 };
 
 struct pgv {
-- 
2.34.1


