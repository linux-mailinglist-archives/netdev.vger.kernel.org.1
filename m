Return-Path: <netdev+bounces-117113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7738E94CC1E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD76CB2374C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6118DF8E;
	Fri,  9 Aug 2024 08:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B1118CBFA
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191889; cv=none; b=uRiB7cZmoIgEfBDYwOntubT3DJPd0SGPuwIGvUpXpo1HVSRCU2Zi+Fq5npmNtAs45I5zhIQ8rSzl/kC1PZ8QImeUN0QaN+tIndWmlEhBZTsSqHdkpRFWPkONZ2N1DuPoLDnUY63QytY5/L4AZk32+Hh+CQDNhQNnt1u2owCS2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191889; c=relaxed/simple;
	bh=nF8EzlxLvMJDyF4wqlbQUAdIv70V4gH1PtJSEMY93Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmwjVLmY4978ITAewtuYFcvLGyYvg6rLYfFQdYsYpcidTYFI8Dj+IVuSZXTwjQkXl0z6iKHGYUynat3qGNt17yPRAwGFfdvgv6y/Pluy7fdwjOMA1FfUZvvJFyTNG8DK/OF0XavAxH2QM/xtjXt6b78OklUVoHwvbcDAVnL0Kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B50BD7D122;
	Fri,  9 Aug 2024 08:24:47 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v1 2/2] net: add copy from skb_seq_state to buffer function
Date: Fri,  9 Aug 2024 04:23:14 -0400
Message-ID: <20240809082314.2810408-3-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809082314.2810408-1-chopps@chopps.org>
References: <20240809082314.2810408-1-chopps@chopps.org>
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
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8626f9a343db..95f80b6d1d7c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1434,6 +1434,7 @@ void skb_prepare_seq_read(struct sk_buff *skb, unsigned int from,
 unsigned int skb_seq_read(unsigned int consumed, const u8 **data,
 			  struct skb_seq_state *st);
 void skb_abort_seq_read(struct skb_seq_state *st);
+int skb_copy_seq_read(struct skb_seq_state *st, int offset, void *to, int len);
 
 unsigned int skb_find_text(struct sk_buff *skb, unsigned int from,
 			   unsigned int to, struct ts_config *config);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index da5a47d2c9ab..2cc2d1b8d356 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4415,6 +4415,41 @@ void skb_abort_seq_read(struct skb_seq_state *st)
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
+ * Return: 0 on success or a negative error code on failure
+ */
+int skb_copy_seq_read(struct skb_seq_state *st, int offset, void *to, int len)
+{
+	const u8 *data;
+	u32 sqlen;
+
+	for (;;) {
+		sqlen = skb_seq_read(offset, &data, st);
+		if (sqlen == 0)
+			return -ENOMEM;
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


