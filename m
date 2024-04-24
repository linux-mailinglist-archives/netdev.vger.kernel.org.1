Return-Path: <netdev+bounces-90847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008178B0741
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 12:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F0F1F224D4
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951B159576;
	Wed, 24 Apr 2024 10:25:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256A159564
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954358; cv=none; b=f1upXK58cQYmDPjsdhzz+OLvvCrpb+L4E/inAiD6ZcR5XmYQ2VgrignyqCcZlsHQNoQYq41IYJCLTC+orykQDscvrfQg3S3iTeqBp05MBe7R+5cpVSZxywBB0grkAmKV09d6jlpjJuy4Yfs+ItW3kMu783RYQq5P3EerW/+bcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954358; c=relaxed/simple;
	bh=FWHiednQjU4kARUBpZDZqKwtgPotMYVlf3yumHpaBvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R50oe6EI7NzSqUGIKa7XlXKgri3ozA0ZvPJ/zN8dobvoHWQ/ebTbRX7kQX2YVLWPqp0dthFpZn8wP81lbo7Vj1g1X18bG6D18RONRaUXVA9+qt2z9suhLkLq95kdc6loY2vZrASVMYtGwbIVC/MTCrTE96FTZP7YgX6Vk/aEJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43BCBE000C;
	Wed, 24 Apr 2024 10:25:49 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] tls: fix lockless read of strp->msg_ready in ->poll
Date: Wed, 24 Apr 2024 12:25:47 +0200
Message-ID: <0b7ee062319037cf86af6b317b3d72f7bfcd2e97.1713797701.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

tls_sk_poll is called without locking the socket, and needs to read
strp->msg_ready (via tls_strp_msg_ready). Convert msg_ready to a bool
and use READ_ONCE/WRITE_ONCE where needed. The remaining reads are
only performed when the socket is locked.

Fixes: 121dca784fc0 ("tls: suppress wakeups unless we have a full record")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h  | 3 ++-
 net/tls/tls.h      | 2 +-
 net/tls/tls_strp.c | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 340ad43971e4..33f657d3c051 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -111,7 +111,8 @@ struct tls_strparser {
 	u32 stopped : 1;
 	u32 copy_mode : 1;
 	u32 mixed_decrypted : 1;
-	u32 msg_ready : 1;
+
+	bool msg_ready;
 
 	struct strp_msg stm;
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 762f424ff2d5..e5e47452308a 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -215,7 +215,7 @@ static inline struct sk_buff *tls_strp_msg(struct tls_sw_context_rx *ctx)
 
 static inline bool tls_strp_msg_ready(struct tls_sw_context_rx *ctx)
 {
-	return ctx->strp.msg_ready;
+	return READ_ONCE(ctx->strp.msg_ready);
 }
 
 static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index ca1e0e198ceb..5df08d848b5c 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -360,7 +360,7 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 	if (strp->stm.full_len && strp->stm.full_len == skb->len) {
 		desc->count = 0;
 
-		strp->msg_ready = 1;
+		WRITE_ONCE(strp->msg_ready, 1);
 		tls_rx_msg_ready(strp);
 	}
 
@@ -528,7 +528,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 	if (!tls_strp_check_queue_ok(strp))
 		return tls_strp_read_copy(strp, false);
 
-	strp->msg_ready = 1;
+	WRITE_ONCE(strp->msg_ready, 1);
 	tls_rx_msg_ready(strp);
 
 	return 0;
@@ -580,7 +580,7 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 	else
 		tls_strp_flush_anchor_copy(strp);
 
-	strp->msg_ready = 0;
+	WRITE_ONCE(strp->msg_ready, 0);
 	memset(&strp->stm, 0, sizeof(strp->stm));
 
 	tls_strp_check_rcv(strp);
-- 
2.43.0


