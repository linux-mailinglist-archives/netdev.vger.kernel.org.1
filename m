Return-Path: <netdev+bounces-215525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C20B2EFBF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CA51CC551B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955A27FB2D;
	Thu, 21 Aug 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjcNVDLP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B577261A;
	Thu, 21 Aug 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761474; cv=none; b=G06gG1I1y2N5LBZwsPh7Fb2Wo6cZ3Hgy0zhEOZ9ghkCms4lyaYvEl9DFZMp//Iv3K8ye3QD0Mh61/llnECwlhil5yRPMOTqPm/y89DpcEO2a3QZ4iot947HqiQ4tvfhUiZIlHWRkTeYye1xElGGj7D/c054YgSYEje+YHRwvXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761474; c=relaxed/simple;
	bh=mpS/qipLv+bO1nEd7aKzLpLiJA+GofV5+6E0C9v+Ma4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjLbDzN4czl5RM/1SDJ/oaceGCD1qAqSVbi5dYWEPKnlAkEvR6JvSro+08Y7bg8iEnaE6wkizp8vPTPDSRWjs9DTN45QA/HQtazuwIGYVFEGqsqPyDjPDMoypSA5lPfuyxv1NgxdJvLg8j9WmiJRe0FjORXotbPZzJYN2NhoYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjcNVDLP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso3367335e9.1;
        Thu, 21 Aug 2025 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761469; x=1756366269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfJtkCGNRyk1cCu5qIMpJWlFisW0p6hubwQ+QAr2jN8=;
        b=kjcNVDLPUthwx5bxpvy+53Ao1gZ10sGQno2GZHHZCWUv/KLvEAFjKk5FNhb8xtOYV1
         a79D+2cRz16MV9P1Ngr1VJ7UTFHPtucZen47YKv6oWdaZE6HBhZ/Lw1oQH6YR++eXv7Q
         BIkbPKxw3en7S+d7GrxtEOfvT/AcDDzwnywF1ZCMqZJ8vJMour0WEw3INPGc168s82iu
         og+Bp9W+bgqvLOWKsLumVSAembHf5XYwPG/UlihyficAPSfPZvvFIZq87jllV+s/jaYT
         RecBDEJ1S/PYY1FIWigsFuh24f0ofA84bhY4jmPeNd5bS9t+S6plknNAp1ypfHLic6H2
         upog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761469; x=1756366269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfJtkCGNRyk1cCu5qIMpJWlFisW0p6hubwQ+QAr2jN8=;
        b=FAYuC+JPTZ8oeTzN2eYhWm46kqt2xB+B/j5DTICJAibP1L8UCWu6aW4ky4XwilIPah
         hWUpgS8olCjYSeqthu3rbdny6cv7gacCM+zDE+gkaAOAoK8w/Z89amlxWtpm8tzSJ7e3
         QAkoJW4hyPlG5vz+smpzfZpH5lfFdhR8glREQHIwCT7G4q7DBHUPGsvYzdY7kzrRRVfQ
         lI/qmc6NWr0wE47fgbxlpNZ1+lilUFq9lG98c2oDDhGojoJeZdANWVhSuwXJUzD3dhC1
         zkbls9ijxq/5WvCfIa9ixcBDcG6RuADdTPFOOxK277ZuNUVHIBuDLc0LZOy6bXuWnEEY
         q6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRMcntcJ5LXEw2zs/CuZNe/PKp2wa5KlPTj5AK/8JWr34cw+9jwiZyvSKNo/TydL0XtmfXMT5UUU4AzL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgEowbo6QG0rIFMGQy4ykaS8mPYOi87AGWDvkpngRoW1XCqwi
	2mBS3sJECFv0DJDXZVa3flUYi/C80sHsuPxBeAO7wNQ1SuOMmuOrGYcUkvOfjw==
X-Gm-Gg: ASbGncvzDKdum4sNk3VUWit6qaTiTBHo0f50rHC72VzBuimYi0838mKRsTOkmULYUYn
	SzcK6MktrymM8FDoafkVP9+1gk02lMx9AYiXMRy3CIgfuSRA7aowua4a/cJceywe1ShnroBGCan
	KrtVHUXe8NWH7Shj+q4+CwkJ6fYI5nchsPq8xt6rJovoCkUe/haEf0dwud3/11wPVR8xrHFSq3S
	MpqW/cyj5VTtv5pSMjD24bE6slKymR8SsFLBtfYF1pEMwYpT+B0pOmZFBWTXIwBRwwPuY7bn1BI
	RlL48uMb5+WkfkYrFDi+p3XsXGD5CXw3C8KxYUAgsnmeONxknZTSnY9nGzoQE0r8MeTlZTO7hxM
	SEQc4aiMHVZQjPA==
X-Google-Smtp-Source: AGHT+IE1MjyZjqCr88SWvJbcARsR/HejdVf+V7UVEGGZrs1bBEJTq0rt/IUtmws/fa9CHsceXQ+6DQ==
X-Received: by 2002:a05:600c:3b23:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b4d7dc8b1mr15927495e9.16.1755761468775;
        Thu, 21 Aug 2025 00:31:08 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1be26sm16407535e9.5.2025.08.21.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:31:08 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
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
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Thu, 21 Aug 2025 09:30:44 +0200
Message-Id: <20250821073047.2091-3-richardbgobert@gmail.com>
In-Reply-To: <20250821073047.2091-1-richardbgobert@gmail.com>
References: <20250821073047.2091-1-richardbgobert@gmail.com>
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

Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
for unencapsulated packets) and one for inner IDs.

This commit preserves the current behavior of GSO where only the IDs of the
inner-most headers are restored correctly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 37 ++++++++++++++++++-------------------
 net/ipv4/tcp_offload.c |  5 ++++-
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 87c68007f949..4307b68afda7 100644
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
@@ -478,28 +475,30 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
 }
 
 static inline int __gro_receive_network_flush(const void *th, const void *th2,
-					      struct sk_buff *p, const u16 diff,
-					      bool outer)
+					      struct sk_buff *p, bool inner)
 {
-	const void *nh = th - diff;
-	const void *nh2 = th2 - diff;
+	const void *nh, *nh2;
+	int off, diff;
+
+	off = skb_transport_offset(p);
+	diff = off - NAPI_GRO_CB(p)->network_offsets[inner];
+	nh = th - diff;
+	nh2 = th2 - diff;
 
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
-	int off = skb_transport_offset(p);
 	int flush;
 
-	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
-	if (encap_mark)
-		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
+	flush = __gro_receive_network_flush(th, th2, p, false);
+	if (NAPI_GRO_CB(p)->encap_mark)
+		flush |= __gro_receive_network_flush(th, th2, p, true);
 
 	return flush;
 }
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index be5c2294610e..56817ef12ad2 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -472,6 +472,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
+	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -485,8 +486,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
+	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
+
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
+			(is_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


