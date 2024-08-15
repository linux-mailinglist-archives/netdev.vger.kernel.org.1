Return-Path: <netdev+bounces-118936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A659538E8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1AB2822B1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324001A00CB;
	Thu, 15 Aug 2024 17:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652229A1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742517; cv=none; b=CyBPc9C+RLrxkaB0bSn9tVnQ5lLB9BtV38uN5pQwN9ZgSh7HcMEmqHJ8GzUp7ScglxYwFuiP8M3st+BPkaHnyRfEPYImCiecVKREbv/a/eJhTMDRYkm17URLZgjzZMrPprXj9ru5tTmuny+W8YQkPTpQPdXu5G2HFin0/q/MClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742517; c=relaxed/simple;
	bh=zT9VyLMVK1/XGAswxj+/VLR1yotkecG1IGtmyxPRKe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgLQ9dUgSR2RHB/QSnIL3neNw6OqldGTDho0S0zVb3qd3L/HjCc5CLd/NvG97W14HsThqq9AgAhURyLxdStx2WKAk4EwvTyXyaA7QGPTrOK9tQmr+feV0HmnfGDZmazUG0taPEIvt7e4cNZbn2PoEcP6rz9LuBcGrXBsSYfZIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 81CD57D065;
	Thu, 15 Aug 2024 17:21:53 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v4 1/1] net: add copy from skb_seq_state to buffer function
Date: Thu, 15 Aug 2024 13:21:14 -0400
Message-ID: <20240815172114.696205-1-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add an skb helper function to copy a range of bytes from within
an existing skb_seq_state.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
This is used in a followup patchset implementing IP-TFS/AggFrag
encapsulation (https://www.rfc-editor.org/rfc/rfc9347.txt)

Patchset History:

  v1 (8/9/2024)
    - Created from IP-TFS patchset v9

  v2 (8/9/2024)
    - resend with corrected CC list.

  v3 (8/15/2024)
    - removed ___copy_skb_header refactoring

  v4 (8/15/2024)
    - change returned error from -ENOMEM to -EINVAL
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..a871533b8568 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1433,6 +1433,7 @@ void skb_prepare_seq_read(struct sk_buff *skb, unsigned int from,
 unsigned int skb_seq_read(unsigned int consumed, const u8 **data,
 			  struct skb_seq_state *st);
 void skb_abort_seq_read(struct skb_seq_state *st);
+int skb_copy_seq_read(struct skb_seq_state *st, int offset, void *to, int len);
 
 unsigned int skb_find_text(struct sk_buff *skb, unsigned int from,
 			   unsigned int to, struct ts_config *config);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..fe4b2dc5c19b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4409,6 +4409,41 @@ void skb_abort_seq_read(struct skb_seq_state *st)
 }
 EXPORT_SYMBOL(skb_abort_seq_read);
 
+/**
+ * skb_copy_seq_read() - copy from a skb_seq_state to a buffer
+ * @st: source skb_seq_state
+ * @offset: offset in source
+ * @to: destination buffer
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @offset bytes into the source @st to the destination
+ * buffer @to. `offset` should increase (or be unchanged) with each subsequent
+ * call to this function. If offset needs to decrease from the previous use `st`
+ * should be reset first.
+ *
+ * Return: 0 on success or -EINVAL if the copy ended early
+ */
+int skb_copy_seq_read(struct skb_seq_state *st, int offset, void *to, int len)
+{
+	const u8 *data;
+	u32 sqlen;
+
+	for (;;) {
+		sqlen = skb_seq_read(offset, &data, st);
+		if (sqlen == 0)
+			return -EINVAL;
+		if (sqlen >= len) {
+			memcpy(to, data, len);
+			return 0;
+		}
+		memcpy(to, data, sqlen);
+		to += sqlen;
+		offset += sqlen;
+		len -= sqlen;
+	}
+}
+EXPORT_SYMBOL(skb_copy_seq_read);
+
 #define TS_SKB_CB(state)	((struct skb_seq_state *) &((state)->cb))
 
 static unsigned int skb_ts_get_next_block(unsigned int offset, const u8 **text,
-- 
2.46.0


