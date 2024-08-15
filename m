Return-Path: <netdev+bounces-119007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245F9953CE6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B711F25643
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166A715574D;
	Thu, 15 Aug 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Hq3RQMeC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93930155730
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758388; cv=none; b=BX2UkBYh3aYkB9BRifClXenMFmyuagstksLR2CQLpiG55R8V+LO+9cKDZovh49yglaZpS7E2bFP40JKrvtTOkJngnJFAQL01k/IOW1evfdj4agzBjOEvRaVsdq+A7YAuR8MRM7WHFQHjEuL4V9NGfuaj7PQ8Z3SnKikZOUcsDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758388; c=relaxed/simple;
	bh=VSaUriivj9kHl2ATci4Yrkr8UVaJCANZPPFfenBzm7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/wtPMwpTMPRwjqKA3i9a3UGexEBogZpw7ItYxHm61209seZen62KJM9dIeAj1UD6D6GSbpN9wcvuaVrh8LEEiNc28FbGON7rnyFp9RfPhjzZwXk1S11vIdzMRV+WhmoljATAhlU07i0OZYmCPPMROLI6MLjBt56LWjQewd50yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Hq3RQMeC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1040982a12.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758386; x=1724363186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr0BLhj/kH1I2bfmAdGzcmYGGYBiHhQ0koclENsRg7Y=;
        b=Hq3RQMeCTZPX47j5jXZ3OGhgKoxv/hpwOLqyzoGCxWVHQj853M1W/g5qBKC/AUxmg9
         /g2/5RRkXOkruzdzZm0TlZ12FHCO+7mbQPV2L9sSbGigdXRnK9vI5697ABkKtUJw24l4
         eX9LqUHGJVDVc8Iw7VpHbBZeaTGxcWrPYxbwYYmWSLXc+Q3k6/Uhp1Dosiq6blbzOFHZ
         ruZtFlkzF+SINx77kJMaC9oRcWq4tIAEQPaIVyS0cc4dNxUWtoldZh/k+bV4GVw9wtQr
         pRwPuDlpfZtcK1qUByGMpenEqylBrhd99xmJQWK2+g9Iu6U8i1gyjHONKVFAdTkXhkT8
         pnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758386; x=1724363186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr0BLhj/kH1I2bfmAdGzcmYGGYBiHhQ0koclENsRg7Y=;
        b=cBmtYQXhmtVaLdG/ZT1U5za4rLbM+FVKsolYt9QPM8qhpkeuONB9/stqDMBr19J22M
         xiwMghds8SPrf9ZorP96jZKzYdXEhA8Dj7B2qCfGzFapGELYfYm4uHm0cdS+HxazWzvP
         fucqB4ieIJKz8GlQGWfVdOf2N6bsuQ2VDWigHl2b2tT56Iwc+Mr7k2BkUrboiooiN3ch
         h3yYDzAmTRBwG0xYgLlb+TYWb2rvjZWMA3Uk3diqbrVPtjZDPjcF3KyUIIY899OSko3w
         HKx1VmoZoKmKRbj7vC2p/hVwPdWX5z5Hwj8ll4WkROvOgRkZv1/ilDXIiWD7fDUaltpo
         mxug==
X-Forwarded-Encrypted: i=1; AJvYcCVVYlYrjJboKKVfbcq8MZgE++Ie+vbCWQtMmLHN4BWPCjp7KfsJyHUyuVhSRmeYnCT+69XQMENDJOSWEuWzxKoJT6QNPNBQ
X-Gm-Message-State: AOJu0YwEyRjanHcfg3DydW6MoiT8RSON5XIf6/ORbhotsuB50B3DV8uo
	IHosUZZHu/GkXu+wypiq+dgn4g2FR7/RDA3wr9fj2fOb39ckUiSl5gmjfoicZH3prgQpCgIdJ0s
	=
X-Google-Smtp-Source: AGHT+IH9Hy+zG2DIdFJJ9oxk9WYqurorb9EmdCBBY9VuUOe4fuE174MFR1SM3InslTaXlnyoRTdDCQ==
X-Received: by 2002:a17:90a:c718:b0:2d3:b357:7859 with SMTP id 98e67ed59e1d1-2d3dffc5ccbmr1255483a91.13.1723758385667;
        Thu, 15 Aug 2024 14:46:25 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:25 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 10/12] gtp: Move gtp_parse_exthdrs into net/gtp.h
Date: Thu, 15 Aug 2024 14:45:25 -0700
Message-Id: <20240815214527.2100137-11-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_parse_exthdrs is a generic function, move into a header file
so we can call it outside of the GTP driver (specifically, we can
call it from flow dissector)

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/gtp.c | 37 -------------------------------------
 include/net/gtp.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 427b91aca50d..61d5dfd48c88 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -742,43 +742,6 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
 }
 
-static int gtp_parse_exthdrs(struct sk_buff *skb, unsigned int *hdrlen)
-{
-	struct gtp_ext_hdr *gtp_exthdr, _gtp_exthdr;
-	unsigned int offset = *hdrlen;
-	__u8 *next_type, _next_type;
-
-	/* From 29.060: "The Extension Header Length field specifies the length
-	 * of the particular Extension header in 4 octets units."
-	 *
-	 * This length field includes length field size itself (1 byte),
-	 * payload (variable length) and next type (1 byte). The extension
-	 * header is aligned to to 4 bytes.
-	 */
-
-	do {
-		gtp_exthdr = skb_header_pointer(skb, offset, sizeof(*gtp_exthdr),
-						&_gtp_exthdr);
-		if (!gtp_exthdr || !gtp_exthdr->len)
-			return -1;
-
-		offset += gtp_exthdr->len * 4;
-
-		/* From 29.060: "If no such Header follows, then the value of
-		 * the Next Extension Header Type shall be 0."
-		 */
-		next_type = skb_header_pointer(skb, offset - 1,
-					       sizeof(_next_type), &_next_type);
-		if (!next_type)
-			return -1;
-
-	} while (*next_type != 0);
-
-	*hdrlen = offset;
-
-	return 0;
-}
-
 static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 {
 	unsigned int hdrlen = sizeof(struct udphdr) +
diff --git a/include/net/gtp.h b/include/net/gtp.h
index c0253c8702d0..a513aa1c7394 100644
--- a/include/net/gtp.h
+++ b/include/net/gtp.h
@@ -83,4 +83,42 @@ struct gtp_ext_hdr {
 	__u8	data[];
 };
 
+static inline int gtp_parse_exthdrs(const struct sk_buff *skb,
+				    unsigned int *hdrlen)
+{
+	struct gtp_ext_hdr *gtp_exthdr, _gtp_exthdr;
+	unsigned int offset = *hdrlen;
+	__u8 *next_type, _next_type;
+
+	/* From 29.060: "The Extension Header Length field specifies the length
+	 * of the particular Extension header in 4 octets units."
+	 *
+	 * This length field includes length field size itself (1 byte),
+	 * payload (variable length) and next type (1 byte). The extension
+	 * header is aligned to 4 bytes.
+	 */
+
+	do {
+		gtp_exthdr = skb_header_pointer(skb, offset, sizeof(*gtp_exthdr),
+						&_gtp_exthdr);
+		if (!gtp_exthdr || !gtp_exthdr->len)
+			return -1;
+
+		offset += gtp_exthdr->len * 4;
+
+		/* From 29.060: "If no such Header follows, then the value of
+		 * the Next Extension Header Type shall be 0."
+		 */
+		next_type = skb_header_pointer(skb, offset - 1,
+					       sizeof(_next_type), &_next_type);
+		if (!next_type)
+			return -1;
+
+	} while (*next_type != 0);
+
+	*hdrlen = offset;
+
+	return 0;
+}
+
 #endif
-- 
2.34.1


