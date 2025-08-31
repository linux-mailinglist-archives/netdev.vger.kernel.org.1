Return-Path: <netdev+bounces-218551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E527B3D202
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 12:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F7117D220
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE473256C70;
	Sun, 31 Aug 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JB/sXVpk"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5542561A2;
	Sun, 31 Aug 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756634958; cv=none; b=Y5a+xw225j+a7CNjIbdt8c6qu3nbeWs2VoNepCOd/GC+b9TBvXiPNM/47dN1KU3S8aYbApIIYSTMCa4E83HFwHSrFt+a4fJl6cUVvZPG+wGtOaDOKcqy4oeMPZfzDoJ7tOvjCweoERQHYbftpiWs95fVFb0SFbQL+n0tffri2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756634958; c=relaxed/simple;
	bh=MXRPEyMnVIGdQ6y5qQCmjy/Ms0VWdqWsceL1Lo9x8ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrMrpbAyvpjA8s4AJbZ+ZR+qKV2RIX9UcienHCqyUDa/BCKzoJFwa9xX/M9pe/hH3jb2MuRMwP/dD418zHa+EfFu0cgP2oJyLW0Np5VCErvLAQ3i7zyWBh3KrBe7fbjd1uVCdRGvHwtVEOuZ+jSqtAYLEanuak1yucEzm2vf89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JB/sXVpk; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bl
	Yk/xMFukiqktu/30G9TbZdILw5g1q0KR+Rl8F8jJw=; b=JB/sXVpkhIBib7lN7b
	a0Rm+sTwRcKG3rCzq7QQBq6eSJMjoaQ/pQerJm2p6zg5TfvT4bZRxyaYLonMIn+y
	+j8lgJFwfb9oy0w1P1YMW1/3kEFcfy4DbXpYaEkskCgYxhUku0vGn1Yrw2cGpvL9
	yGONqSk10rnJM9Q1uAOMUScOw=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBH7U4YH7RoR1JrFA--.61212S3;
	Sun, 31 Aug 2025 18:08:35 +0800 (CST)
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
Subject: [PATCH net-next v10 1/2] net: af_packet: remove last_kactive_blk_num field
Date: Sun, 31 Aug 2025 18:08:21 +0800
Message-Id: <20250831100822.1238795-2-jackzxcui1989@163.com>
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
X-CM-TRANSID:_____wBH7U4YH7RoR1JrFA--.61212S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1fXFW8tr1rur4kWFWfKrg_yoWrGr43pF
	W3A343Jw4DGr4agw4xZwnrZr15Ww4rWFy8G3sxJw4fA3s3Aryava9F9Fy7WFyrJrZ3Zay7
	Xrs5t345Cr4kJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_F4iUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRxG6Cmi0Dcz5bQAAsv

kactive_blk_num (K) is incremented on block close. last_kactive_blk_num (L)
is set to match K on block open and each timer. So the only time that they
differ is if a block is closed in tpacket_rcv and no new block could be
opened.
So the origin check L==K in timer callback only skip the case 'no new block
to open'. If we remove L==K check, it will make prb_curr_blk_in_use check
earlier, which will not cause any side effect.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 net/packet/af_packet.c | 60 ++++++++++++++++++++----------------------
 net/packet/internal.h  |  6 -----
 2 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a7017d7f0..d4eb4a4fe 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -669,7 +669,6 @@ static void init_prb_bdqc(struct packet_sock *po,
 	p1->knum_blocks	= req_u->req3.tp_block_nr;
 	p1->hdrlen = po->tp_hdrlen;
 	p1->version = po->tp_version;
-	p1->last_kactive_blk_num = 0;
 	po->stats.stats3.tp_freeze_q_cnt = 0;
 	if (req_u->req3.tp_retire_blk_tov)
 		p1->retire_blk_tov = req_u->req3.tp_retire_blk_tov;
@@ -693,7 +692,6 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	mod_timer(&pkc->retire_blk_timer,
 			jiffies + pkc->tov_in_jiffies);
-	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }
 
 /*
@@ -750,38 +748,36 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
 		write_unlock(&pkc->blk_fill_in_prog_lock);
 	}
 
-	if (pkc->last_kactive_blk_num == pkc->kactive_blk_num) {
-		if (!frozen) {
-			if (!BLOCK_NUM_PKTS(pbd)) {
-				/* An empty block. Just refresh the timer. */
-				goto refresh_timer;
-			}
-			prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
-			if (!prb_dispatch_next_block(pkc, po))
-				goto refresh_timer;
-			else
-				goto out;
+	if (!frozen) {
+		if (!BLOCK_NUM_PKTS(pbd)) {
+			/* An empty block. Just refresh the timer. */
+			goto refresh_timer;
+		}
+		prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
+		if (!prb_dispatch_next_block(pkc, po))
+			goto refresh_timer;
+		else
+			goto out;
+	} else {
+		/* Case 1. Queue was frozen because user-space was
+		 * lagging behind.
+		 */
+		if (prb_curr_blk_in_use(pbd)) {
+			/*
+			 * Ok, user-space is still behind.
+			 * So just refresh the timer.
+			 */
+			goto refresh_timer;
 		} else {
-			/* Case 1. Queue was frozen because user-space was
-			 *	   lagging behind.
+			/* Case 2. queue was frozen,user-space caught up,
+			 * now the link went idle && the timer fired.
+			 * We don't have a block to close.So we open this
+			 * block and restart the timer.
+			 * opening a block thaws the queue,restarts timer
+			 * Thawing/timer-refresh is a side effect.
 			 */
-			if (prb_curr_blk_in_use(pbd)) {
-				/*
-				 * Ok, user-space is still behind.
-				 * So just refresh the timer.
-				 */
-				goto refresh_timer;
-			} else {
-			       /* Case 2. queue was frozen,user-space caught up,
-				* now the link went idle && the timer fired.
-				* We don't have a block to close.So we open this
-				* block and restart the timer.
-				* opening a block thaws the queue,restarts timer
-				* Thawing/timer-refresh is a side effect.
-				*/
-				prb_open_block(pkc, pbd);
-				goto out;
-			}
+			prb_open_block(pkc, pbd);
+			goto out;
 		}
 	}
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 1e743d031..d367b9f93 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -24,12 +24,6 @@ struct tpacket_kbdq_core {
 	unsigned short	kactive_blk_num;
 	unsigned short	blk_sizeof_priv;
 
-	/* last_kactive_blk_num:
-	 * trick to see if user-space has caught up
-	 * in order to avoid refreshing timer when every single pkt arrives.
-	 */
-	unsigned short	last_kactive_blk_num;
-
 	char		*pkblk_start;
 	char		*pkblk_end;
 	int		kblk_size;
-- 
2.34.1


