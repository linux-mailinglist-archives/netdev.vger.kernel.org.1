Return-Path: <netdev+bounces-220610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC502B475DA
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F66B56679E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE25C2F0C51;
	Sat,  6 Sep 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DDL+Ec0w"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28991EB193;
	Sat,  6 Sep 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757179849; cv=none; b=On8Dl42LLeqZdYwkxLt/k+B6o5mUb9i+TLxi5nmIjbEvsg72VMStFAADfvm3clZIZK1IOAXX56TnwYMaB1iP5f0/1Ogr779PXlqXlIiQFDb/Oilj69Bn+PpGyJjRQ8ixd7tzcxdnyX4qJ3zl3tkzruPyEvJGL/u910luKzv39SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757179849; c=relaxed/simple;
	bh=k/e+GxLzaLWHXW4ybilZi/DyVV97aJCPpbq+l5+E5pM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIgrA2L7yjDvFZ8HKGorhT3t56f9ba96FkEvzxfw4iHe8UhqlrHMWca5+QPj7XYMIvht7RBpGLzZ2dnA2xaiedPL5CeDdNIo08b2hLu0WXJ34xO1s+a6hI/UY5aWLJrSBKID+XNC0E1SXNe3kJZW0zkDPXxF+W/6GHcXUwg4lNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DDL+Ec0w; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JJ
	aR7eeM4R1xw7uwZoMzi6TmSyd6BYr9d5jerFk/sIU=; b=DDL+Ec0wWWOGi0407M
	YZnQOwGRQHs7YJyvTm545MPjwoGJ4Ol8cv2gw7sph7+Hj5wLSw5PHJQOVRC/Efe2
	B9xLPNjqlFmq1sPznKRWp7xnDvs/F5UwUtrsKZHrn9nE5Bu1gSC4CszoDE25oxY8
	qk4MXTZ3sCNyN57eVedbO6new=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3f+Wbb7xoubfqGQ--.36512S3;
	Sun, 07 Sep 2025 01:30:07 +0800 (CST)
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
Subject: [PATCH net-next v11 1/2] net: af_packet: remove last_kactive_blk_num field
Date: Sun,  7 Sep 2025 01:30:00 +0800
Message-Id: <20250906173001.3656356-2-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906173001.3656356-1-jackzxcui1989@163.com>
References: <20250906173001.3656356-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+Wbb7xoubfqGQ--.36512S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWUJrWxAFWkXFW5Ar1kZrb_yoWruF4xpF
	WYkw13Gw1DGr42gw4xZwnrZr15Ww45XFyUGr98Jw4fAasxJryaya9F9ry7WFyFyFZ3Zay2
	qrs5t345Cw1DJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_E_MUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiJQ3ACmi8a+ReEgABs0

kactive_blk_num (K) is only incremented on block close.
In timer callback prb_retire_rx_blk_timer_expired, except delete_blk_timer
is true, last_kactive_blk_num (L) is set to match kactive_blk_num (K) in
all cases. L is also set to match K in prb_open_block.
The only case K not equal to L is when scheduled by tpacket_rcv
and K is just incremented on block close but no new block could be opened,
so that it does not call prb_open_block in prb_dispatch_next_block.
This patch modifies the prb_retire_rx_blk_timer_expired function by simply 
removing the check for L == K. This patch just provides another checkpoint
to thaw the might-be-frozen block in any case. It doesn't have any effect
because __packet_lookup_frame_in_block() has the same logic and does it
again without this patch when detecting the ring is frozen. The patch only
advances checking the status of the ring.

Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://lore.kernel.org/all/20250831100822.1238795-1-jackzxcui1989@163.com/
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


