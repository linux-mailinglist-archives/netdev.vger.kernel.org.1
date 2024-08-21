Return-Path: <netdev+bounces-120732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95995A67F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515621F238CD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5952217B505;
	Wed, 21 Aug 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="aqdMvCXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF559176FA7
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275374; cv=none; b=DOOhTmRikoV76ncnUx5QTjLpBa40WIS+pFyZan6Y9+qtiApiBGvnh3Lqi4cluG/HWRTelmem257/oo2vvpg6JsZ8Fe9CWk2SWBU43obJKOMsvKWICNPGPzi0rOi9DOl4sh5q6APZFx1ZcTqEibi6Ucrs6VCTMAIACS2CVDe/oME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275374; c=relaxed/simple;
	bh=0dAjiSIzgpkWEbT6ZjWDA//wTx8HCHscYHZ/Jdych2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzuQIq7u6QGtWOBuPQ5ToScTRqaS93mA38aUShp4JjenZtzpmqPOjv2e59S/J30+rM/W8IEOnhMmgrEMAMNgeJDAE+j2d5r7o13PSHFRAUTKeyDzMktDb55kZU1kYbTWOVY8U7++fuoTRJJmTy/HKxZxzQv8178nb0ZJ06wQcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=aqdMvCXt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201e64607a5so923325ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275372; x=1724880172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAgVId2zqzrrH8Q5BmxNDksKhXoxgP0QIUZ2Htbs0Hw=;
        b=aqdMvCXtYTsCkPHKJbaWJ7ZaHAYmBz0RXnONE8WTIW9eJGPI9u/H9PGHFLUU0pXNNG
         7eB9JuVKi7ZOFZgM2meUhkZ0LOf6IDitONwnsqCV9IRsG+SiBGyO6hoPKchDIEPxPgGG
         BbVZhGpgo9z28eOJLJLIChbCpTIxJdw29/fzwWut2lMbb90GtWovSksJQDTtM3BOg/9C
         xqH/3QrhmQU0HT0c4gc8rL6NWDdAhwnv9x8PEntz5htkFkuFi0+GDxzRdFgWMl87is68
         zS2M4ag3WwcGSr9/BpkoRsnEM4fxu2x7wb0CtfSbKaJ64b5xv2ohKm0ArExVWO0HTKs6
         VKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275372; x=1724880172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAgVId2zqzrrH8Q5BmxNDksKhXoxgP0QIUZ2Htbs0Hw=;
        b=m8vlLltjjtKuoWP7oIBInvv7Uqvg0r1vsc8LzZBHJbpcWnWyFmIkYOA84rc/XGQ3oQ
         uJz6V1NPaWc0UxYR28o5f/yx8Py8rcxLysuE3L3ESV/TE6NlqhHNv9V2T0k7w53MJ1G9
         lF5usfi8fFHaV+jqYXSTaSbEDc8nNrtTYItmtRhgrccZauY1AXhUF3/S4R/mawBAiChU
         Ufyn2XQL2hANfdDoHw3hwq7m/CGp7F9860jqwBg4p/paRfMT70hqoM3WRgDak97Jh2ZH
         Mx/FnmnGILB+WkyFPY4Vu4li7NXzI4Bm/rqmMab38n+HQQcdpPtq6u7O8szfFplWz/Nc
         jIHA==
X-Forwarded-Encrypted: i=1; AJvYcCUupm6XdZbrAtfd3upMyoMBb4qdRuf/gY4ViTvSrmnvpig1gB0eHZHejh2LEs95aTqEgivUe0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86q42+UuUf5rDrWRieSdtPRrSMrhPkgpGrPSWdf9Vww9EVoI1
	0Jof4Jehsf+KkGW6pxfm5/dLCyNmtLTVrTEPsAAVvUVrAwIif8QwqKGuoBqbxw==
X-Google-Smtp-Source: AGHT+IFnmVuZScdusA+0lWWCTqusQ6sHvH/oY4WaXXXqc985alefrTEgPioEYnVR46Tw70tBiR9UuQ==
X-Received: by 2002:a17:902:f68e:b0:1fa:2e45:bcb8 with SMTP id d9443c01a7336-20367bfcb3bmr48738025ad.2.1724275371871;
        Wed, 21 Aug 2024 14:22:51 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:51 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 11/13] gtp: Move gtp_parse_exthdrs into net/gtp.h
Date: Wed, 21 Aug 2024 14:22:10 -0700
Message-Id: <20240821212212.1795357-12-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
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
index 0696faf60013..259c7043d20c 100644
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


