Return-Path: <netdev+bounces-205747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AD1AFFF49
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCBD1C86768
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3B2E763A;
	Thu, 10 Jul 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HCK2S4QP"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7D2E5B13;
	Thu, 10 Jul 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143237; cv=none; b=Ypnpea+jdRRf2MEv5HmuE4XV+ZR/2IUuvU9WWgriSklrQ64Y5ya6i5PgM4eyCfinpk6u6UKuXbZvFjiQkp4VC/LhDSce93lcbPB9JiWJyqAh2Z98sJmKEYoxU3RTzaStK0F917kZhqdKq2JsiQ88Y62O0AfEWp+nR52HzeIgrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143237; c=relaxed/simple;
	bh=7/9imShxUWV2j7e1Dds7bGVkk++VkobjkiHuGilplNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqHgg2yoW0HhoE7BIaJVxaj3J2XzT2vTsFnGhbSoXG1hhq9x7Q4u0Xt++ci9m2i94oX5fW7FwmfLzDeWW+shkAFtsYhpTRDOJ5rU0rSSMCs4Kkaf9KtbXAWZQsGq/V7P1g5jNOMRqE3hiChfZXwiwtXXn0NarKFNFD/EeXIRVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HCK2S4QP; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gC
	mZPOJXf4vSfwRl47UYWa98GUAKgdHSUDNq8kWpIDA=; b=HCK2S4QP15bTo3bstN
	4B1VFKhoFWYI1BDJuE2j9qTAzPiwaHgvZteOPdlRIHXl/Rd7SXtcCC4NfFc4rf83
	aF3+vmDl93y+DohXna6Qcg1WGDZElLUdpCNJYCPSdT/t4WYZt0TkDYoReWsLbB/U
	pa/dTt7CcL8MgkyzafpZaNLJw=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAXowFflW9oGKJ1Dw--.26998S5;
	Thu, 10 Jul 2025 18:26:42 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] af_packet: optimize the packet_read_pending function called on tpacket_snd()
Date: Thu, 10 Jul 2025 18:26:39 +0800
Message-ID: <20250710102639.280932-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710102639.280932-1-luyun_611@163.com>
References: <20250710102639.280932-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXowFflW9oGKJ1Dw--.26998S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1DWF43CFW5ArykuFWxWFg_yoW8ur13pa
	yF9r92qwn8Xr17tw4xAF1kJF1Yvw48JFZ5J395X3WaywnxJ3sYvryIyrWj9Fy8uFWxX3W2
	qF90yr15Cw1UtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jPnYwUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQxqGzmhvkAiYvQABsq

From: Yun Lu <luyun@kylinos.cn>

Now the packet_read_pending() may be called twice in the do-while loop,
and this function is super expensive on hosts with a large number of cpu,
as it's per_cpu variable. In fact, the second call at the end can be
removed by reusing the ph to continue for the next iteration, and the ph
will be reassigned at the start of the next iteration.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 net/packet/af_packet.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 581a96ec8e1a..ea7219e0c23a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2846,12 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
+			/* Note: packet_read_pending() might be slow if we
+			 * have to call it as it's per_cpu variable, but in
+			 * fast-path we don't have to call it, only when ph
+			 * is NULL, we need to check pending_refcnt.
+			 */
 			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
 					goto out_put;
 				}
+				/* Just reuse ph to continue for the next iteration, and
+				 * ph will be reassigned at the start of the next iteration.
+				 */
+				ph = (void *)1;
 			}
 			/* check for additional frames */
 			continue;
@@ -2943,14 +2952,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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
+	} while (likely(ph != NULL));
 
 	err = len_sum;
 	goto out_put;
-- 
2.43.0


