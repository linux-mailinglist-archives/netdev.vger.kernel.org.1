Return-Path: <netdev+bounces-214247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0137B28A1C
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 04:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F3C5C633B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548C2E659;
	Sat, 16 Aug 2025 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CgmbxXuR"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4038B;
	Sat, 16 Aug 2025 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755312558; cv=none; b=RB/Kiospmw//Yu2aadU1Elzc7ogHeeB8Qx4JYGPTj+GIXvDmvqsXpZ+EMPme5aI7A15oCqHsxJrSL5HBvedEdwzaK7jEZKwlpW7mdGsPFXvuDc2mhHPmwqr9JqzQk2XUoF/xeNAgHtP7go09MKsXUe9OYIK8RZUUOrZt8l7WW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755312558; c=relaxed/simple;
	bh=hyFoRJfR+/+dfufmADJJETGSdWS8oikKKEtoGRU+TX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jr2FVT6Z3nbcDDFOXfJYiObl00cMIPP+TPYEtY3D+z4VryJmxemESOwpwJPIE2TIV8w3Riz+pwK90Xspg8odBI2GLLT5NYL4ZZRIopyjrofTfiQr1ZQa4mYqBujKuV4W8ih9tyIMRWQVSHs0UiUUmRhTGKBy15yx85iTNt+EFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CgmbxXuR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3A
	DGn3+EY0cLRTbPVPUMRLpsDFaJI1jPaAcL8kcj18g=; b=CgmbxXuRFzH/7BCps2
	APh3WrgqCi6swzU+OcrW1cZchvTNJnjmgwBQVFnPnof1V5k5qGkAsaoLczZAA/YP
	A0f96GWzTfe+8xFNFOcF0MZh0SIKTJmFmOcoacWdtefvtSltTfdAuZJ+o3zoKHPC
	AB2snqpXY1qDNqqV+jnnjAJ28=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3b+eA8Z9oAufhCA--.21748S2;
	Sat, 16 Aug 2025 10:48:33 +0800 (CST)
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
Subject: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire operation
Date: Sat, 16 Aug 2025 10:48:31 +0800
Message-Id: <20250816024831.1451167-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3b+eA8Z9oAufhCA--.21748S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrWDWr1rAF1fGr48AFWUJwb_yoWxXry8pa
	y5WryxGw47Za1agw48Jrs7ZFyYgw1jyryUG393Xwsay3ZxtryrJa1j9r90gFWftFZFkw47
	ArsYqF15Cw1ktrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMnQUUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiMAGrCmif8MwNDgAAsY

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
Changes in v3:
- return HRTIMER_NORESTART when pkc->delete_blk_timer is true
  as suggested by Willem de Bruijn;

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
---
 net/packet/af_packet.c | 24 ++++++++++++++----------
 net/packet/internal.h  |  3 +--
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a7017d7f0..763b0c968 100644
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
+	hrtimer_start(&pkc->retire_blk_timer, ms_to_ktime(pkc->retire_blk_tov),
+		      HRTIMER_MODE_REL_SOFT);
 }
 
 static int prb_calc_retire_blk_tmo(struct packet_sock *po,
@@ -676,7 +677,6 @@ static void init_prb_bdqc(struct packet_sock *po,
 	else
 		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
 						req_u->req3.tp_block_size);
-	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
 	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
 	rwlock_init(&p1->blk_fill_in_prog_lock);
 
@@ -691,8 +691,8 @@ static void init_prb_bdqc(struct packet_sock *po,
  */
 static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
-	mod_timer(&pkc->retire_blk_timer,
-			jiffies + pkc->tov_in_jiffies);
+	hrtimer_set_expires(&pkc->retire_blk_timer,
+			    ktime_add(ktime_get(), ms_to_ktime(pkc->retire_blk_tov)));
 	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }
 
@@ -719,8 +719,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
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
@@ -732,8 +733,10 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 	frozen = prb_queue_frozen(pkc);
 	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
 
-	if (unlikely(pkc->delete_blk_timer))
+	if (unlikely(pkc->delete_blk_timer)) {
+		ret = HRTIMER_NORESTART;
 		goto out;
+	}
 
 	/* We only need to plug the race when the block is partially filled.
 	 * tpacket_rcv:
@@ -790,6 +793,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 
 out:
 	spin_unlock(&po->sk.sk_receive_queue.lock);
+	return ret;
 }
 
 static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 1e743d031..9812feb3d 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -47,10 +47,9 @@ struct tpacket_kbdq_core {
 
 	unsigned short  retire_blk_tov;
 	unsigned short  version;
-	unsigned long	tov_in_jiffies;
 
 	/* timer to retire an outstanding block */
-	struct timer_list retire_blk_timer;
+	struct hrtimer  retire_blk_timer;
 };
 
 struct pgv {
-- 
2.34.1


