Return-Path: <netdev+bounces-126827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A369729D7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8601F25468
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B317BEAD;
	Tue, 10 Sep 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xbFimtHs"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A817ADF8
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951326; cv=none; b=H02yY/mV1lMCxqk1dsY6OvJ/bmXR8NJl+kkN1EkNkP3kdpElgceqQaZQKW4yWvAYNc/NzpVzsNhZVz/zVcXXa8smcG45gDrHC2sLiDcKF6loL9fKSfjUaHjEkQRMVG9XHBRLiTaoif09w0r0zanTbtJjPKV5FKSGYKBi5uLbTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951326; c=relaxed/simple;
	bh=C1sQJrysadKVov/BUFBcf14939hvnBcrKQJC1g+2+J4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAH0nw4WzGeWnBOYHHv47NxgzhXY/veSb+dk010DW1t1xzpfx2cDY1UVB5G0xClOnPkCqZV8J82K1eN0xXxBdptDuuXVsPX14cN2MT4kSru1brt6ASS2ZpQ2lKVsO9k1z/+LPacAGD93rwoKYB9hTcg+J+wSvDbbRJdwBHs15Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xbFimtHs; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3F3CB20897;
	Tue, 10 Sep 2024 08:55:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLMIj_M2iXp8; Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 62F582087C;
	Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 62F582087C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951321;
	bh=CH5HoGUf1QaFlflLthiElsDzEZn5T/jbEbFEUzZpNDw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=xbFimtHsvPnJcXgAc9gbsXrE8bsDMn38G6oZXlo01vZU58iDnSHxn0+Ada8zO61+3
	 pP3uCI/TiIRq1ipNytnByXq6BHugwJKHq3arYAQY9ZLfh300wQuzPFpeUQBoJlLPWw
	 29R5BbFWARXpGH3q6kIrCWv33vcmTI8fqAIpx521fiZWN3pp7yeJmd+FBBj6mpmLDu
	 B3yPCr4hpcU+goWuyLIk/Mfjc1gJN99HVx/kdm/GlJwOxK7CpDLxl1FTBwVD3hIjkv
	 ghWZdOwQ6owNCv7TSu4t4T2SwFReXjqOIa0kLMm+xA7l73jr369XlPauRiVoJ9CY69
	 I3qGUNkZ7IZnA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:21 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 28C62318008E; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/13] net: add copy from skb_seq_state to buffer function
Date: Tue, 10 Sep 2024 08:54:56 +0200
Message-ID: <20240910065507.2436394-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065507.2436394-1-steffen.klassert@secunet.com>
References: <20240910065507.2436394-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Christian Hopps <chopps@labn.net>

Add an skb helper function to copy a range of bytes from within
an existing skb_seq_state.

Signed-off-by: Christian Hopps <chopps@labn.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.34.1


