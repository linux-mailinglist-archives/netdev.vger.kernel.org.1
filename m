Return-Path: <netdev+bounces-213451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F032B2503A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4D81AA6846
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F128A71D;
	Wed, 13 Aug 2025 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iXNi7r2k"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE794246BC1;
	Wed, 13 Aug 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103968; cv=none; b=TVR4ba10Wv5DDskItyn1Qn7C9RFVWJxXnNhP77GLVjqLIQqBxWzqYuidQKJ1+7w9Z4wWEYKmrdLQGcEBf6OKuzVwVeiN9aCVZ2lSB6npXc6Gr81se8uxaJ+5AK6jIoRB2wUpRQ3HOK2MSu4iKrHICbADmWLWOHE+csJgDso2aSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103968; c=relaxed/simple;
	bh=9QCc3j7Nu7J1rYdLuLDu6Gu2I3KvelaAd4J5+ojVcH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUJaJEg1+AqdYR3K0zfNW0kn+vKfOyqe9OeL6C1iCLPjoqGRNsse83o7ccQM7LHrAapntr9SPdV5RphPiSdGIchjEMu5mdATC+QlLhLJU8jnZtN48IJ59hkb63pWW8ygG977t7E932YefzdeyyyHWnvF5MqhgeS+sNNg5YrHzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iXNi7r2k; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6d
	ZW97DLwK3hq4Qvj+4tZMAjOl8ZsoVPuweEcUtDLR8=; b=iXNi7r2kHIUX+TZkAC
	yTdlUXN8I7ZVG9uZKthyOK9g2AsL/+GOCg3aFWltubkzMVmrELSl7/phTWaiQapN
	flRvTw4EYZy0ru0iku7HR+cITB/ToPW9QoybaZe+jJY0Go8V4fNSfjAUYAlz6nuj
	yXjh8A6qNqbTTjzkPi9GBLCVg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3f9Czwpxooy_tBA--.18339S2;
	Thu, 14 Aug 2025 00:52:04 +0800 (CST)
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
Subject: [PATCH v1] net: af_packet: Use hrtimer to do the retire operation
Date: Thu, 14 Aug 2025 00:52:01 +0800
Message-Id: <20250813165201.1492779-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f9Czwpxooy_tBA--.18339S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1rAr1kWF4UJF1DXw47Arb_yoWrtF4fpa
	y5W34xGw47Za1agw48Xrs7ZFyYgw1DAry7G393Xwsay3Z3try5ta1j9Fyq9FWftFZFkw43
	Ar4ktFs8Cw1kXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEy8BnUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwqoCmicsxzwmwAAsf

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
 net/packet/af_packet.c | 20 +++++++++++---------
 net/packet/internal.h  |  4 ++--
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index bc438d0d9..636b72bf6 100644
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
+	hrtimer_start(&pkc->retire_blk_timer, ms_to_ktime(pkc->tov_in_msecs),
+		      HRTIMER_MODE_REL_SOFT);
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
+	hrtimer_set_expires(&pkc->retire_blk_timer,
+			    ktime_add(ktime_get(), ms_to_ktime(pkc->tov_in_msecs)));
 	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }
 
@@ -719,7 +720,7 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
  * prb_calc_retire_blk_tmo() calculates the tmo.
  *
  */
-static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
+static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
 {
 	struct packet_sock *po =
 		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
@@ -790,6 +791,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 
 out:
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+	return HRTIMER_RESTART;
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


