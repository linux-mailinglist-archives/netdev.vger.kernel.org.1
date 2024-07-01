Return-Path: <netdev+bounces-108262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08991E8F0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A841F2329D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9F16FF5F;
	Mon,  1 Jul 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="RMm9xFaO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208916F905
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863735; cv=none; b=A6nk1uGr+7bAMUR1BxvPz2vLQ1y+bT7oVODQQWCZnlMkvJ+3nbh1PdEGVAiu9T5o4A4WRTVTfb5EhYg5gq96c33t7CdJJOoxIZToIcu9OIZSVjSBImQLB3S6Xz9oBHAckBYP8CfGbICn7zMa1zSgNp6bV7KPKCU033ahd7cRyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863735; c=relaxed/simple;
	bh=+I2/H+WJhavlhOXr4uDGCdGSKZXUSOd+/m6LjuxMsM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1uehszx4umEw1p1U+5GJU6UdG6r61/mvFMBkaMiEgMJRA2Z89SoQ4H+fbLmif2DoSnXRlVIz/fbY9wcnp/i05vQd+NgaYb+wuHG8MozL0bSqZ9HJ25KC54y5B2RNhz6RfQO53S2rWTWqUc+tXtBGPVlr4Mg/e1XrkcZju4biVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=RMm9xFaO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4a5344ec7so24412715ad.1
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863733; x=1720468533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7RY/2ZPfAZhnMIlpD+xpnoHxw6CGzgcRYJgOQLBHx8=;
        b=RMm9xFaOnFEK42JbfNdhBcc7TMqsetoliJz+TbByOUJk+m926vdaPWNMiHe/LV9Wuc
         9OK22RDsq/Oo4b9yWQUv1D/gV4MnB/UIXGL6bsQC62xh8BnDn9v/WI2aE4raZVA6Tv9G
         MkSvxb2FdUZ5p5gUf1T4ZIItZjL6UbPEiIpObilKpEP+EAsSiux1FgB4P6AeLHfXo+wx
         fFYdXSaax1fYVmHTUQ5eOqe88PrC3ybPOwokCUMcqbWMPIiDUWDkDGa30iccrzmYjKSb
         SFuKJc+x7ouUqGEjq7oOXyKWtKngirCfoRlxpiA6kaNSfK7+UY7Px9vcQLfxi3/R1ooj
         OkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863733; x=1720468533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7RY/2ZPfAZhnMIlpD+xpnoHxw6CGzgcRYJgOQLBHx8=;
        b=aHUCAZgChKfMzsKD3uOSR13Yo8yjeh/vG5gzVHUVYOJkZu+Oa6ziiwuFlbUUgj5AY0
         3OnNi12ZI55J/h1PZ5tCMY/Y8gxmaTCHu43CejBGZSz+GebsOjR2P3IOg7btkAFz7JwC
         MOwXDuSS2IZD/s1x5GOc22htSDhGhlqMdGOb9C07SVYK4WHXcRjk4fFzwfoUP7gPerXp
         KdXXhRxFEp9PDFKxXZgN1T12Y8j68DhgFKm9eYoYIxjolHiwcnoOjwICI95yPzQONR5Y
         CcwQfPJ9DujT6QnH+vvV92++p0ubjJLfN9n2+IhrbBz1khbVkZWWiuY+EdXN1zZ9w1qG
         yraA==
X-Forwarded-Encrypted: i=1; AJvYcCWyqyg7tDDCSTNJpLlU+htbJSe+OfIChQUNrM6vTUg/m2FhCQF7VT7OdyBdlAqnR54Q0DvUDqkOP+LuSat+4U2Bsr/5mDan
X-Gm-Message-State: AOJu0YxUmSbQUGPLlieNItZbM3tNqcaju5xMv0swIwC2cd9VIlpi5pGe
	LIiIDDM1XQ6TLPMV0NNznC8wWqFJczfJ0bI9ZRMEt5u8IklL2RYISXvM7UTJ3htBIXNb0U8RUD8
	=
X-Google-Smtp-Source: AGHT+IF4lQOo5FUWLGEi/j0bXfdAzJF8lWVn5oLjpBpEM1ucwGAlXtPQZrfW1GRTDDYuPmy78JHeBA==
X-Received: by 2002:a17:902:f688:b0:1f9:f6e6:5ada with SMTP id d9443c01a7336-1fac7eec818mr162565495ad.22.1719863733222;
        Mon, 01 Jul 2024 12:55:33 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:32 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 1/7] ipv6: Add ipv6_skip_exthdr_no_rthdr
Date: Mon,  1 Jul 2024 12:55:01 -0700
Message-Id: <20240701195507.256374-2-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701195507.256374-1-tom@herbertland.com>
References: <20240701195507.256374-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_skip_exthdr_no_rthdr will be called by drivers that support
protocol specific transmit checksum offload with extension headers.
Protocol specific checksum offload doesn't work with routing headers
since the destination address in the IPv6 header is not the one used
in the pseduo checksum for TCP or UDP. This is not a problem with
protocol agnostic checksum offload.

If a routing header is present then ipv6_skip_exthdr_no_rthdr returns
a value less than zero, this is an indication that the driver should
call skb_checksum_help instead of offloading the checksum which  would
be doomed to cause a packet drop at the receiver due to a bad checksum.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6.h      | 17 +++++++++++++++--
 net/ipv6/exthdrs_core.c | 25 ++++++++++++++++++-------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 88a8e554f7a1..6581fabd1e1e 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1157,8 +1157,21 @@ void ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
 void ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
 			 u8 *proto);
 
-int ipv6_skip_exthdr(const struct sk_buff *, int start, u8 *nexthdrp,
-		     __be16 *frag_offp);
+int __ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
+		       __be16 *frag_offp, bool no_rthdr);
+
+static inline int ipv6_skip_exthdr(const struct sk_buff *skb, int start,
+				   u8 *nexthdrp, __be16 *frag_offp)
+{
+	return __ipv6_skip_exthdr(skb, start, nexthdrp, frag_offp, false);
+}
+
+static inline int ipv6_skip_exthdr_no_rthdr(const struct sk_buff *skb,
+					    int start, u8 *nexthdrp,
+					    __be16 *frag_offp)
+{
+	return __ipv6_skip_exthdr(skb, start, nexthdrp, frag_offp, true);
+}
 
 bool ipv6_ext_hdr(u8 nexthdr);
 
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 49e31e4ae7b7..25501777ae05 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -69,8 +69,8 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
  * --ANK (980726)
  */
 
-int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
-		     __be16 *frag_offp)
+int __ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
+		       __be16 *frag_offp, bool no_rthdr)
 {
 	u8 nexthdr = *nexthdrp;
 
@@ -85,7 +85,8 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -1;
-		if (nexthdr == NEXTHDR_FRAGMENT) {
+		switch (nexthdr) {
+		case NEXTHDR_FRAGMENT: {
 			__be16 _frag_off, *fp;
 			fp = skb_header_pointer(skb,
 						start+offsetof(struct frag_hdr,
@@ -97,21 +98,31 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 
 			*frag_offp = *fp;
 			if (ntohs(*frag_offp) & ~0x7)
-				break;
+				goto out;
 			hdrlen = 8;
-		} else if (nexthdr == NEXTHDR_AUTH)
+			break;
+		}
+		case NEXTHDR_AUTH:
 			hdrlen = ipv6_authlen(hp);
-		else
+			break;
+		case NEXTHDR_ROUTING:
+			if (no_rthdr)
+				return -1;
+			fallthrough;
+		default:
 			hdrlen = ipv6_optlen(hp);
+			break;
+		}
 
 		nexthdr = hp->nexthdr;
 		start += hdrlen;
 	}
 
+out:
 	*nexthdrp = nexthdr;
 	return start;
 }
-EXPORT_SYMBOL(ipv6_skip_exthdr);
+EXPORT_SYMBOL(__ipv6_skip_exthdr);
 
 int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 {
-- 
2.34.1


