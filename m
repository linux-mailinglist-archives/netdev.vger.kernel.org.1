Return-Path: <netdev+bounces-205358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7125BAFE4AA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588E61896C9F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8DA2877E2;
	Wed,  9 Jul 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WKgHHShu"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46102874F3;
	Wed,  9 Jul 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055038; cv=none; b=b2OTkFEsIPWeH5GJzJyqMvGpK37fGK/7OhJLcq8HDu31BiJz5kruz2T0Sr99BdBLHBSmuRwrKOxGD1pJXZuAR2uVkMbIFEkz0VHvyXvEEPzpx8+/6Y6ZhUB2xStkt7ADx8ePFJM4bbGL32WWnTG5cL+iESYqx2WZjaNEBDUptVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055038; c=relaxed/simple;
	bh=H3ATC8Kv9kchxPcXEljkmXkfeaLLF1dxEOQTkpIXJRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnxlAWK6da9eQ/SUvwwjscsTdClaIHjdBsFtUERBOpDG8moPmPXtBlEE5luKaZYflzX+3BtcOp2fuPoygyMqA485oKM5jrKvg6EUP0bqKk7Pg8NcAQlv96RI9hfeD8aGSBsRtBJP0fOR4WkYHHNW+M+lPBPMWnGypPCpRaIfz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WKgHHShu; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SL
	JGjCoU+vCEWt5IYZov7Eqv0Dsa9t8J9ap2ePfV8EA=; b=WKgHHShu8PkDwPRULO
	JYL0TA2P7pTTcYHryEghY1TLXgu8T+zI0p15u2pH9wTEdfPbkAzWHz85zMDtwQAR
	s3y/2ZFNKk3FTXaOvXdNyGT/eXovYf+twSVUHfuv0zxHAJdyogY43XeCecdPmwET
	DC+BXyfFz7wUgtcw0rC1RzjwY=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBn08jlPG5oBz4hBA--.440S4;
	Wed, 09 Jul 2025 17:56:55 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by tpacket_snd()
Date: Wed,  9 Jul 2025 17:56:53 +0800
Message-ID: <20250709095653.62469-3-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709095653.62469-1-luyun_611@163.com>
References: <20250709095653.62469-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBn08jlPG5oBz4hBA--.440S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1xXFy7Zr4rKw17Aw1rtFb_yoWrXrykpa
	yYg3sIv3WDJr1xtw4fGa1kXr12vw4rJFs8GrWvq34Sywnxt3savrWIkrWj9Fy8uFWktaya
	vF4qvr4UCw1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6q2NUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQw6FzmhuNPn8YgAAsT

From: Yun Lu <luyun@kylinos.cn>

When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
pending_refcnt to decrement to zero before returning. The pending_refcnt
is decremented by 1 when the skb->destructor function is called,
indicating that the skb has been successfully sent and needs to be
destroyed.

If an error occurs during this process, the tpacket_snd() function will
exit and return error, but pending_refcnt may not yet have decremented to
zero. Assuming the next send operation is executed immediately, but there
are no available frames to be sent in tx_ring (i.e., packet_current_frame
returns NULL), and skb is also NULL, the function will not execute
wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
will enter a do-while loop, waiting for pending_refcnt to be zero. Even
if the previous skb has completed transmission, the skb->destructor
function can only be invoked in the ksoftirqd thread (assuming NAPI
threading is enabled). When both the ksoftirqd thread and the tpacket_snd
operation happen to run on the same CPU, and the CPU trapped in the
do-while loop without yielding, the ksoftirqd thread will not get
scheduled to run. As a result, pending_refcnt will never be reduced to
zero, and the do-while loop cannot exit, eventually leading to a CPU soft
lockup issue.

In fact, as long as pending_refcnt is not zero, even if skb is NULL,
wait_for_completion_interruptible_timeout() should be executed to yield
the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, move
the penging_refcnt check to the start of the do-while loop, and reuse ph
to continue for the next iteration.

Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
Cc: stable@kernel.org
Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
Changes in v3:
- Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
- Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/

Changes in v2:
- Add a Fixes tag.
- Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
---
 net/packet/af_packet.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7089b8c2a655..89a5d2a3a720 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2846,11 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
-			if (need_wait && skb) {
+			/* Note: packet_read_pending() might be slow if we
+			 * have to call it as it's per_cpu variable, but in
+			 * fast-path we don't have to call it, only when ph
+			 * is NULL, we need to check pending_refcnt.
+			 */
+			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
 					goto out_put;
+				} else {
+					/* Just reuse ph to continue for the next iteration, and
+					 * ph will be reassigned at the start of the next iteration.
+					 */
+					ph = (void *)1;
 				}
 			}
 			/* check for additional frames */
@@ -2943,14 +2953,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 		packet_increment_head(&po->tx_ring);
 		len_sum += tp_len;
-	} while (likely((ph != NULL) ||
-		/* Note: packet_read_pending() might be slow if we have
-		 * to call it as it's per_cpu variable, but in fast-path
-		 * we already short-circuit the loop with the first
-		 * condition, and luckily don't have to go that path
-		 * anyway.
-		 */
-		 (need_wait && packet_read_pending(&po->tx_ring))));
+	} while (likely(ph != NULL))
 
 	err = len_sum;
 	goto out_put;
-- 
2.43.0


