Return-Path: <netdev+bounces-213685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886D0B2647F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171171CC4F09
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472012F60AE;
	Thu, 14 Aug 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSDQZx0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62175224AE0;
	Thu, 14 Aug 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171686; cv=none; b=BURBPZ9n5cDHCv9Ib32M2xeSP+TK6iExCCTpUoaD1fe2buzu8Z2UlfIv89QfextKTUbnAKlFCVBvpJqJzNJsBfnk/PZwdf5TmULOYagYlkuKRtk/vifwCTV7JBvumZ6DY5Pv5TkuYxwIpKHfSTO5loWWdmgSKzwggN6ZIhMqPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171686; c=relaxed/simple;
	bh=kUrenFG87YWzm25TOBbzZcKcuHImxpugKXwDvaYI9w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5kXSUEEZr2RD1nqwvjW1QqR/AZGYZWTpQorynyPSp3+yJXxjOQ21R+F4wA9g0AdaAhpbrrimnOiqy2ycTTLVv3Q6pCvjnM8d4iSCQshGrWKdVgIhDpnsLZK1pKTXcx2Jt1+hEGXEhQOzUZLAdWePG5cC8G1i9cZZfOcqaGvI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSDQZx0C; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so3670145e9.0;
        Thu, 14 Aug 2025 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171683; x=1755776483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32/S4IqfOpUydKeSRhvHvpvUd1ekQaBREl//8hnY74M=;
        b=QSDQZx0CkCygG9PoV9929OKVMUmUrf5ZZTPMOKsf9JQdatKgol1GCjc39i7a+Y4ZMJ
         nzSmLF5L+Bqw5RAT5oZtuJxbH80AOwR59A6nik3sqEAQqPxCBKjEi9Zq3u4zCyMAWKKp
         kg1UpsmAOETrbCO95G8ll8euPWpi7iPw0GXTi7HJYW8HGRWiH7qppWu1dT/sYPPzOYGz
         Ncb2nT3wmKpBncCY1zeJ4lgqGExyzznt5+J4nXiBuCyvRi3f5VghOLmr2ja915HEgD4S
         p8H9NMJh7EeWKBJ4Pc1C9lI/4z03BNpvuHyekqDgtyd6+tmkvveHfLv6WrxDmrBFxvXZ
         rNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171683; x=1755776483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32/S4IqfOpUydKeSRhvHvpvUd1ekQaBREl//8hnY74M=;
        b=OL3RimuUm1N9YgatlOBw2x56wBMtrNMt9AMB6juLwm12ZVAVYexJacROJ6XoKPEIFa
         bbHw9T/Xp9Ha5IbUxPxWhhSI1a0LlXewJ0AOWSRUwO43++r2OOIcbvkFQb3J8eD86lAm
         HVFXZPPX5to1EDFC4dsgrzr1Sf3hnJghVmHRxxyOCdhiXmeD7zZH+zv+B94ekNdi/LYy
         pzGyRv6W+8p769CKkpNS9yYKV2RY0cxxnWktag2P/tB33dhe3pQlGFpTdgfm1t2iVG7l
         1vTqWkLHjVzTFsilq4xwQJ5zLt+J6PgTiCSkqIfQh0Fm0gAy48K+veLFqmzU1s8Ps/Mv
         V+wA==
X-Forwarded-Encrypted: i=1; AJvYcCUmQXPbAZX0Hh900ZCwcD+mU0tZ7J0pa6t//poq16w1K0vWRBUtXiLr055F4GqBbRbwL2TunedtX7mU8Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AQBbeU7cUnxTLf9O7vCGx6L4YVt9KSRhXutHFQLlZ9hLS9bs
	Qx52JNVzYZRo+QrSY+lrbs5liyP/lUwYnQddu/TP/9dOSzv5pEqvyIKzA75Rwate/9g=
X-Gm-Gg: ASbGncs7SJCktKwMi15NFkO4jpvKElmsQu/eOjkD7rFc87pTZDlVWtD5aKmDLJbHuzG
	PgM/jzy/KWcuk7RmBe7dVjC6tURXjHU3yKT8rzowz6i266POgE7Rhp0F/O4AWDCQogkM8h62ho5
	PKJK0MvbwjWMzJsoM7yXBurEJ9rKW2r+JfjJGtnMLeDeUdFBmDeXxYIRZ4X4VE0aV0PR66h10RK
	PuVY276jEGOvFbuLu1e3VLxHYgFm3U0/an0/p36tyeghyFVQR5PPfH51pM56pVoFg3qvI+edFXY
	1w6E6byKdAoIo6K8KX/be2LF5jMYbF21YZywqYzGrOLMOxYHbNRbY7+iIC6i24dwl1/gaRCx8MJ
	mSvybxlQSjK4GV58YrZogtJcK6MMVKjOElw==
X-Google-Smtp-Source: AGHT+IEFQCeNBcsu9D4xoWxHw8zO8x4LfIvj6ubvhDpp0OHyHSBnqYgu+14cxY8+0gSIgsGiX44lrw==
X-Received: by 2002:a05:600c:35d3:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-45a1b6554f3mr17936255e9.21.1755171682343;
        Thu, 14 Aug 2025 04:41:22 -0700 (PDT)
Received: from localhost ([45.10.155.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm51073253f8f.42.2025.08.14.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:41:22 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Thu, 14 Aug 2025 13:40:27 +0200
Message-Id: <20250814114030.7683-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814114030.7683-1-richardbgobert@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
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


