Return-Path: <netdev+bounces-214874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2104AB2B976
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EFC1BA5D68
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABAF26A0C7;
	Tue, 19 Aug 2025 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5IwroRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2226D4C6;
	Tue, 19 Aug 2025 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585177; cv=none; b=CI3xjhgAJKtSuAF/KEGb1lCyapGFO4lDBmltJ5BXtMSw6ZHRX1hSVA5yGJm44wDiPBEs7wary/t+YD8136A+Ls4OlX5G72c/WDheaIiO2hnH2vjIgCPv0aYVFT2Df+wTNiAYhPCnseK5i1uMK2DFqUf2ChT47nrMCApKfWogb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585177; c=relaxed/simple;
	bh=kUrenFG87YWzm25TOBbzZcKcuHImxpugKXwDvaYI9w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQVTbJIPRvXqnvAuUUUyYbaoo4sLe/sxwkKfSjX4tVixDfLD4U0MlN2NxBREJgi8zaaEVwdej4mqL/yKaudVcjlRZq+plKhb5HrBdQZZ63P2wpobuOcuY9Pj1q760WuSnPL7oaoMyi8VaBHB4Hu1wPQerVuzGyBjviir49NHlSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5IwroRu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e4106460so3901425f8f.2;
        Mon, 18 Aug 2025 23:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755585174; x=1756189974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32/S4IqfOpUydKeSRhvHvpvUd1ekQaBREl//8hnY74M=;
        b=V5IwroRulzttVcFbMBa6Hzxt4K/uL0yrQHCPv/LEmPJCLaBqwuUdF+mu5CH9zjnQkZ
         kB6j2sBf+LH6+EkzqX3wFDn1s/Zy/3wefIjfAYFwD9jJG9YTnq8oiSSD+vXo2ubhSqtx
         z3R7WGtL8iBX8c+xsVsYZhjOD/rtwOQRucm0sPkRKNkVVuHgOisUpc3tS8DQFrt2hb08
         q8NwF+mhYwZCPu1vtvWRGQg+2HG6NDmAXDEpuqim1RXEkTQEg14uvv37lsKOlqrlDP1/
         AAJKmX2Ukrvx22wtAiB+e1JjJ/ys0RIE+ZS0BD0zIy/WSN592bsPL+AemaNic3xssF/N
         iNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585174; x=1756189974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32/S4IqfOpUydKeSRhvHvpvUd1ekQaBREl//8hnY74M=;
        b=gicwNfy4kqvUymNIouDrFu67T+gum7EXpeSL7kGV2RZ2/6U8V4dfxRHMn/oyv1pwnq
         U8LoLtrC5yebRufpyrik0177ak4hN0r3IQJ8IRUakB81KCfPdC+GZuCCzP1sP/XWfpLP
         MG14iYfQl0v9V7R4L93fVI1/GS/mZGVBk/nt9X3lzVTqvSZxM2I3BM9p3y0HL+qDeiDB
         AKHiTpbGNuvhuYI+zcaD3cPP4IRSsM3N1JJbT6zW3VmTrOxOvdz72Vm8YXNxV9avc8iU
         Ce+7/P5kxy7ZW+Pc+xb62zK3Pvl72wYnB9l2kxmoGckZaaXO2GNzH0PjwcJomCsE2mZf
         jpvA==
X-Forwarded-Encrypted: i=1; AJvYcCVnsPPo85uWjaN6zY1lsjCl1WkDk2NzvUxA4h7NUb5N4+0O9fJPhQjwFDU/Qnp5nronRgZdL+7VVxL7MVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnW7IDXF5YKe8NJySPbtsRv9xFDNZt71f5h1KjDiRZjkVDxyp/
	639htbZfSM1Dej3iBp3aeUiN4M4kzN4PpV9MOFGGdtYZpI+VrKCNOpHaRkxmKFBlTJc=
X-Gm-Gg: ASbGncva0RSddpZS/sfljhnbKrDiWZpFGXvuXU/S3qlcP0iDFBa+N3LTZRLuM2W4rTO
	9c4fuiNMaxWPxgizbwCNl3WpgLZoBl7tmOZfwAoYEOpgG6ZXzgwLQJLSrIlWObrE0wr5ZGbwrjg
	tMzyN+XSptxlPeGcWy03Tahw6QVKXYA71aas2zDIcdRqLvprHZ/t/2+5ntGy4bOlMVsOMGhy7tk
	exaFQIz4cqqBI3aceezSuhuWhq+1yx/+GxE0fUQS4C7lztHBOxWsX5x7Vzott7M8I5NocnEJVZp
	EtYdn+5rA99t/hqHsEHjTHw9XYPy6I75CukzVVHlx33omEO1at3a8RDO1W2hvpFObdJmn3Bw8QP
	jd0a6VXnAF3/TQTO6DkuVh5B+/F07iw+9h0YNWu6SpUYRQtMgx2zdedg=
X-Google-Smtp-Source: AGHT+IG8kdPAyjBwXOM8zA9O/MnZNRknHXdXvW+YxW/KE9AqTSsSEyMyXZ4A2di1+HomO6RXH7g/1w==
X-Received: by 2002:a05:6000:250c:b0:3b6:1a8c:569f with SMTP id ffacd0b85a97d-3c0ea3cf143mr913405f8f.1.1755585173570;
        Mon, 18 Aug 2025 23:32:53 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a771d1sm25996795e9.7.2025.08.18.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:32:53 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Tue, 19 Aug 2025 08:32:20 +0200
Message-Id: <20250819063223.5239-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819063223.5239-1-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only merge encapsulated packets if their outer IDs are either
incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
packets.

Add another ip_fixedid bit for a total of two bits: one for outer IDs and
one for inner IDs.

This commit preserves the current behavior of GSO where only the IDs of the
inner-most headers are restored correctly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 26 +++++++++++---------------
 net/ipv4/tcp_offload.c |  4 +++-
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 87c68007f949..e7997a9fb30b 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -75,7 +75,7 @@ struct napi_gro_cb {
 		u8	is_fou:1;
 
 		/* Used to determine if ipid_offset can be ignored */
-		u8	ip_fixedid:1;
+		u8	ip_fixedid:2;
 
 		/* Number of gro_receive callbacks this packet already went through */
 		u8 recursion_counter:4;
@@ -442,29 +442,26 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
 }
 
 static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
-				 struct sk_buff *p, bool outer)
+				 struct sk_buff *p, bool inner)
 {
 	const u32 id = ntohl(*(__be32 *)&iph->id);
 	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
 	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
 	const u16 count = NAPI_GRO_CB(p)->count;
 	const u32 df = id & IP_DF;
-	int flush;
 
 	/* All fields must match except length and checksum. */
-	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
-
-	if (flush | (outer && df))
-		return flush;
+	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
+		return true;
 
 	/* When we receive our second frame we can make a decision on if we
 	 * continue this flow as an atomic flow with a fixed ID or if we use
 	 * an incrementing ID.
 	 */
 	if (count == 1 && df && !ipid_offset)
-		NAPI_GRO_CB(p)->ip_fixedid = true;
+		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
 
-	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
+	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
 }
 
 static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
@@ -479,7 +476,7 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
 
 static inline int __gro_receive_network_flush(const void *th, const void *th2,
 					      struct sk_buff *p, const u16 diff,
-					      bool outer)
+					      bool inner)
 {
 	const void *nh = th - diff;
 	const void *nh2 = th2 - diff;
@@ -487,19 +484,18 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
 	if (((struct iphdr *)nh)->version == 6)
 		return ipv6_gro_flush(nh, nh2);
 	else
-		return inet_gro_flush(nh, nh2, p, outer);
+		return inet_gro_flush(nh, nh2, p, inner);
 }
 
 static inline int gro_receive_network_flush(const void *th, const void *th2,
 					    struct sk_buff *p)
 {
-	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
 	int off = skb_transport_offset(p);
 	int flush;
 
-	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
-	if (encap_mark)
-		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
+	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, false);
+	if (NAPI_GRO_CB(p)->encap_mark)
+		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, true);
 
 	return flush;
 }
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index be5c2294610e..74f46663eeae 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -485,8 +485,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
+	bool is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
+
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
+			(is_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


