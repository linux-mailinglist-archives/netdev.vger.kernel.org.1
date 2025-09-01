Return-Path: <netdev+bounces-218731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6DCB3E1CD
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3253B908F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F63320387;
	Mon,  1 Sep 2025 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ZZux3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36C31E10E;
	Mon,  1 Sep 2025 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726741; cv=none; b=qlvAeK5zXoiULi4T/wIC0v3gaMtTPKXwdsdXoss8+l4Gie0R0k90Ah+Vi/QnaEKmT+wdxNL04C/FLuveTkd7lCA42ta88YGDuI/NztgnQ4Ip+6tIa2+WRQcVUReMNcpihhieC/Gdf4O7rqtjZe4FR1wuvtpCJ3bkoPIMeCSTv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726741; c=relaxed/simple;
	bh=9qI/jNzmR0M56MPtZTnHdaMUPhBDm7DOfjKta+ZJLpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfOQoFH3705LKEF6C2YMqdxELcGgKB0WTi1xIBNfJxbpcSVg3lqAnaF4NR2uGUo+412kreFHe1rUg2EfDKZZyWl08IzOtIjeEoPphwBTP1qIh0A8QwaDEWPNey0VyvHl1SYOVojHJwGOVK3kg/hnzZXS6lx9MSThL66WYAqSr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4ZZux3V; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso10107125e9.2;
        Mon, 01 Sep 2025 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756726738; x=1757331538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsJrHVffa43loKUZ4WEfyub4VECQsCXi/R/aIc5vbIE=;
        b=e4ZZux3VI/JRVDqUpYNdsU7MKI3484I57vFPPe4t4MA0B6ZLExyGHCwAu/dy0ZtLe7
         FBaZm4TIugwR7qcBArXxogveqoYgtOSE5k0tz2x9eDVHfHExfeX8vkNTadMrdlV76Z2W
         wW0KNVMxhvxyolHEvT6dqABir/dUrYOYOywV0tNBXAm8nfirlBz1qEPrUvdeMm+CadsM
         d0hw42SaAyro5hL6Nj9LjFe5R2z6w2t4QjI8BsBmf5Y3qB+FihWbkwcArOc8U1Im3p69
         J2LhOxjd3cN/QdpIFZ1yaUd1l3q1D1LZbYTo2Zb1vi+ZfvJQ8RZMfXBHung4oDAfkwvI
         FlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726738; x=1757331538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsJrHVffa43loKUZ4WEfyub4VECQsCXi/R/aIc5vbIE=;
        b=WKxrz3EngkaqYudmJeduG1WmtUV92sT+CvdvZq6ieuI7Lu06szwnzOqAw5GubD5mOC
         AchL60BR735LZ0yfoARtj2WunCk1BsoDXkIjYg5QWYTS/iw4uOY83DnnKVwlm6ghrDNO
         AIOOr4Kb+tR6s/C1dsx7+0XtNX3SC9ItPEv4qq5qZAzsYd9cVZWgaGEerBfInc5V1Pdg
         +oGHAZB30SiQDz3N6wfXPuO8WPKVJ1NpGB9kYpMWJVaKcxP8fk5g3aUvBPsoKHY+EYlC
         jtY5pBLn6ESoOJ1EVeQ+ncXggo/D1gYp1DC+ZJxPp0GQ5K9BO6GCKwazz5JUxHfvrDHj
         mJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU702p68i5BRW2Ms/xvFiZ44i942h14qNr+wpjaDzC4AjVrVPdyTt8RmX2C2DKednL1klzuluWJ9nPgojw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9siPqD68J1c7x0PJOhPTR5NgdszAewsRsI0423mc7cdoYREYU
	mtCU3Uc3r62QIJGq8v2PlU3RfHcmu+wQbnqEnZuUVlcZw5AG/75HVOfpNCbOgP9SaUU=
X-Gm-Gg: ASbGnctcqqVzVGA528/X/tFQNvR+ycncb6pYIjgBvyh/3SK1WLiRSdK11kCMFMgZJT5
	CRmQJjoyegKOGNX+n9EEKMwOCA/X42yVv3C+rooPzFsHMDq6b4W0Be+l1ObnapOCkR3itAnL7qk
	88mCuxIR2lBFMJJtHbmLRSc+qxBS0ITotzXLmhTlr14jJtnI3OZr1IEEO0PgVKfHnrrFN0SfNLO
	blHtw+hRcJLI428vLS3bEDOaSiCTUDAurAfC7XyZ2DvLkCgFTy/XwciRInDgEea8cmRKtmanXgt
	CLX7GYNmrSgAh1jz3/ROieG7LXbZ0U2IL2Vo0dtEKQE7BpR+eUeMjvc7NKBNabSyUPdncVoQfgM
	s8Xbe5wDLy/DTXku77xgCEVYW3uh9hgOkH0JbSg==
X-Google-Smtp-Source: AGHT+IFz891wS8J1A33VMWK5f8JYhTeHrwpv+22qogo1WZnnwwfkKuKR0dqE4aHanIOoRseAhrfbRg==
X-Received: by 2002:a05:600c:3545:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-45b855261f1mr62257385e9.3.1756726737536;
        Mon, 01 Sep 2025 04:38:57 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8876c9sm154403975e9.11.2025.09.01.04.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:38:57 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Mon,  1 Sep 2025 13:38:23 +0200
Message-Id: <20250901113826.6508-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901113826.6508-1-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
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
 include/net/gro.h      | 30 +++++++++++++++---------------
 net/ipv4/tcp_offload.c |  5 ++++-
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 87c68007f949..322c5517f508 100644
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
@@ -487,19 +484,22 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
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
+	int diff;
 
-	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
-	if (encap_mark)
-		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
+	diff = off - NAPI_GRO_CB(p)->network_offset;
+	flush = __gro_receive_network_flush(th, th2, p, diff, false);
+	if (NAPI_GRO_CB(p)->encap_mark) {
+		diff = off - NAPI_GRO_CB(p)->inner_network_offset;
+		flush |= __gro_receive_network_flush(th, th2, p, diff, true);
+	}
 
 	return flush;
 }
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e6612bd84d09..1949eede9ec9 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -471,6 +471,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
+	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -484,8 +485,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
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


