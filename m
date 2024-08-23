Return-Path: <netdev+bounces-121514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A295D7C0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AB6282364
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182B197548;
	Fri, 23 Aug 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Veoa2R31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FF196C7B
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444187; cv=none; b=K6lnjSEdOePaAYzmnoe9tqQqQ63b9CZ26k+aCpw5lWM6ZBT2CAWoU/WYeAhdtv5U+v6z5X95Ma9YwF+3hPv3z//UtWvto6fQOMy0agEtMMmgRlf1Ku2NvFH6FTU3zIn5WyIoNglunRS0yJoSPO9on2oF9/FWrr6Ki8fFHKOFFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444187; c=relaxed/simple;
	bh=0dAjiSIzgpkWEbT6ZjWDA//wTx8HCHscYHZ/Jdych2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAqlY6tYjyR9uT10/pzS/GQ/n2q0T0UgiqQbHUzn0m/eeSKEDr8ud6OAE/CickTC6mg2wvEqmf3a0HWcC6S1Wz3wNGz6yuwMoPrVNSZdbcVDzwN790xdsk6EZQsGC6mpvdO1PbuU0er08vOz0GDtW1W1Bg2R5m8u1zoEUZa11LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Veoa2R31; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714187df604so2178020b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444185; x=1725048985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAgVId2zqzrrH8Q5BmxNDksKhXoxgP0QIUZ2Htbs0Hw=;
        b=Veoa2R31+6lQjP96blTeW4y3eQ8SHHI6QGBO5kKszw5Ud1qZGOYBdJQMvZqkAnQfve
         GKflufML9O2uIA8Lsa+iVo3n5RXHoizLy9BpTb7vmuKJiRI7vHEbrw7Y5VEEvc4zSn+2
         AwGeT8NHjD5z+g7+bm1ECuRzL7DjgEPokD14oMeDlKVel0fwKxZd6nC5CTNpHPC7yVGg
         gb+HF5gvGUa3Xtnb8QIDJoieaqQKxenaP/GCaATqq3HNc9Bm7+jncgeZLvyHE0CZfYtx
         HwA4UmF6Fsm8kA8HSqjlQbLYD227YvPsYdD6IW0kIUvu0JYYgAEL6xazp5+JcA+mMtRK
         gPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444185; x=1725048985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAgVId2zqzrrH8Q5BmxNDksKhXoxgP0QIUZ2Htbs0Hw=;
        b=l370JDVrSNoBJK5xNkEj7/8HTKihLF2Z3yYU6uf1N7s0mfq2emfz4HmwrIgXvYXf+0
         OEa/PlIUQMJI+2+sSwv8hTRmZxpxScln0sUjSClTKREcLWdGeYa2DnHW3D6L9m/wSjy7
         jm/jQWS2EJ4mpVHvB6BUIZBEBUSHNDDTsFYR/eq2ZjQLiBH08V5Xe0JI2RXROgTFO9at
         ANn80zdcakILIJlM5Vs7KU+We4hOx/EwQJZjxU8fsRlZiENWhAVEKHPJOlvDGiYjapy+
         IFgzM+R9Qyzf+3PYvcwq0GCxjaDiyU0cMDnL0CWFLG/LPIJ+wUGjwXZ5G4UDg27lb3YX
         ifgg==
X-Forwarded-Encrypted: i=1; AJvYcCWazo3NSd0YmVYZIQwQ8qm1rrV3hTlJCYHma1g4BZcQh9r0KzBYhcSUjKNDc8M7hOLW7EZNVYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiVpooV38cS20vZ6ySHH/jOqzfTJCevLuR2gC/oSJKVNOxp5N
	BRtXgZ+UcazIibWBiUvWqeO3Q9WS6GL7zlH/fp2Fp4I+gc6LbMmV3WPNYM94MQ==
X-Google-Smtp-Source: AGHT+IF0xFTQ24IPIcZf7eWJJa8UmgfaoXwrWlXW6ZQuIgRdjUUVflP6DljkS6BZ82QLbzrSAdyG7w==
X-Received: by 2002:a05:6a21:3996:b0:1c4:6e77:71a3 with SMTP id adf61e73a8af0-1cc89d29f30mr6187317637.3.1724444184508;
        Fri, 23 Aug 2024 13:16:24 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:23 -0700 (PDT)
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
Subject: [PATCH net-next v4 11/13] gtp: Move gtp_parse_exthdrs into net/gtp.h
Date: Fri, 23 Aug 2024 13:15:55 -0700
Message-Id: <20240823201557.1794985-12-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
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


