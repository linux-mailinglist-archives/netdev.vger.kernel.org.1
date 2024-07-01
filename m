Return-Path: <netdev+bounces-107978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71191D5B5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411811C20CA7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856D522F;
	Mon,  1 Jul 2024 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="OJzG4RPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687C20ED
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796886; cv=none; b=oeeDL0OwV5F/Ttmw/UCPxfiKGdx6whbvIorlb6NQgCEp7EAUtbz5fgY78dJAGc1N8E0kOSJ996Teh50eKLt2bdk4lusqqQYY7EaaIWJRKpv1E23uomGNqqlHRQGoKXq6uwCAtVTzOvPeEA8hPLiEtML0dv45ZWqsNFpcg1/+9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796886; c=relaxed/simple;
	bh=PppSQNZYsQHHBG81aCM04B44meaAEKdFuq5DL7hv1CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ma/z/6QE+HPSE9gEI+MwXaqMEQ56ZwI7/yscfQXkSuV8cCIVmDIID0ukKwwvhTg7IR5chxKGt8UqMTYvwgrCmpbJP1zWEXoBBF5dICmKmuNtsXTuoBV1ood//gO3hcXQyYQgHYGzY0mzyNYiYW/+IBSMAHxV1W9vU7VHQSU/Szo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=OJzG4RPA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c8dc2bcb78so1767679a91.1
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796884; x=1720401684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqRQz2F3DBtU5/2MleOTBJUdczyOZMma4TaNBmROD4A=;
        b=OJzG4RPAErCTf2ytrmWVFIW2NBqmToHfnGRTAk9bS0OP2dlvLvI2D4CFQ+X2SUCK8T
         WFbHzhvNk+9/StCM6yy4BRnJANPYP8GBS6WbZAaf3rkuNMlaRLWvCxGg06sTUt6Xa386
         +pSgC9mVHgjZe2MSkOubaOZpyoZH7NYeL0K3B4ylFSTVMExXKboYmPAiBHxs9lNfXBNG
         /yfCUK38t8vBLvvzyYnY1DIS796IS5ISjgMiQlX1gbseVxkmVbt2EojOV8YUCSdv3wAa
         si5ZAW2u9gUBrYLqDtROkapPJyuBGut4Ne3FSa/5iYKDOoW0KEWMt6jDPMRtc7+Ph7Zm
         2ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796884; x=1720401684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqRQz2F3DBtU5/2MleOTBJUdczyOZMma4TaNBmROD4A=;
        b=CjLadyXwziPdEcVSPIBGjid7t/4AgPXHToJc508D9XMjG1nFEXiWHtRR9TQZZHvkTA
         GfvPBVfW/GzyvcGIdMGZn2UY7nbsqg300xJUjWy8sIQtfpHO5lldOCoxQU1BqWTU7Lqe
         lCj4y/5bLj8qEKTRZG/nnMoNQSkUPxKNoMh2Ay8uUv1suRn5akui0hMg4GxgOJQ3cHRX
         VCFqZhUyewcZewUt9NiH8ehce9ACTE3UGhT0B/yjQ41YOKLHBQxrEYRirDAK/giiixHS
         Zokkdg2NuBFw2suMEpEHEoqDNmyr7Zh3x8dIFo4fINov1S6XCmv90oBp+igCxBEsS6QH
         80pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxHa2fSLiAr95P4bVIlUEtV0gCCy9ubZE2wnLYBMUyP8aNoZd3H19L/0k39z3DHWzFsoFahDmhnT2stBIpfRDwhOXHsYX
X-Gm-Message-State: AOJu0YxQlXDB1DtIE1yEmbRdE46+oiQhvOncpbOc1OTsqti1HYJa8wzn
	GoOVFR/OiR7W/e8u65X0xTgp9t77vm74jlPRE3GbyB+t7oMAbPPpjIJYfc/HNQ==
X-Google-Smtp-Source: AGHT+IEf5Dfqpg1b34Yf5VMcdxe5M2k1cZxJQh79suSZvOqp+g2kB9aro/HjG+IqypoLrMet0yiE2A==
X-Received: by 2002:a17:90b:1bc5:b0:2bf:9566:7c58 with SMTP id 98e67ed59e1d1-2c93d78e1c6mr3336932a91.41.1719796884040;
        Sun, 30 Jun 2024 18:21:24 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:23 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@sipanda.io>,
	Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next 1/7] ipv6: Add ipv6_skip_exthdr_no_rthdr
Date: Sun, 30 Jun 2024 18:20:55 -0700
Message-Id: <20240701012101.182784-2-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701012101.182784-1-tom@herbertland.com>
References: <20240701012101.182784-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Herbert <tom@sipanda.io>

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
 net/ipv6/exthdrs_core.c | 22 ++++++++++++++++------
 2 files changed, 31 insertions(+), 8 deletions(-)

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
index 49e31e4ae7b7..e08f9fb7c0ec 100644
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
@@ -99,10 +100,19 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 			if (ntohs(*frag_offp) & ~0x7)
 				break;
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
@@ -111,7 +121,7 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 	*nexthdrp = nexthdr;
 	return start;
 }
-EXPORT_SYMBOL(ipv6_skip_exthdr);
+EXPORT_SYMBOL(__ipv6_skip_exthdr);
 
 int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 {
-- 
2.34.1


