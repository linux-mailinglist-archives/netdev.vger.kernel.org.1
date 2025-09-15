Return-Path: <netdev+bounces-223014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79EB578A7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F551A20640
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CBD2FDC52;
	Mon, 15 Sep 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlGzuOcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBB4207A
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936456; cv=none; b=pC21ET/9OFnn5NFuMY0BAjiNKtqnJD9BtSHtqAUi9Nq/4NexMrpBao3V9Pdj95+Z9k4yozV4ofnRU7errDeGG+hXIi0zRTyV0ksiwjQxwAXiIzGHKMW2g5z39Jp543TeLi6AximXVuhBMEOX46rXEuvk9Mk3r7ToK4P+LsrLKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936456; c=relaxed/simple;
	bh=bNIaNEm4LT6TFP6CWRAKFGRqH4Wptaj+KdxK6aWaJOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+p0gBr5dQeTXI3Gyf6Y31vlTo0p48OaQBvl4bkvazVy8hWE4OXozdtJ63t880hdDIT43ZTIdPlcJbxgOpcRnhBjpfau82kJ1hCTqj8N84xjBnKl7f95fSuQuA7loiF/oKgYKkcCXZyPbittrYOkWsOsvvec3X65Bx315ofZxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlGzuOcP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e9a9298764so1056458f8f.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757936452; x=1758541252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZBtrYTmjnky2Xi391d5zrqPiMva7ofI4h9J6siEdNw=;
        b=YlGzuOcPnZYyCWugYt4EL6oS0oR9FPUkgmBjZSGR/ShLZy130XBReTef48BLMEQbdd
         R77LnJAncDp7nLkCGhH6PBqhyxb082t0axqbi6Y8YOb4NVLHva8groRizjH1Laq9Nhhh
         XWeFJMLdT8QOq4V8BdKhNssEEVQb9C3a51VZXKMruGfPI6XodN1Tc142nFKynBTXqXn6
         iKFwF6a0+1Z8kmrRyla718MLrv9klTtxYm6uftsKS1HrOawha0G5WPK99ioOUrIPUyCW
         CY3zoiDEwXkYaGUXIafSxQXI8VGwDinjviE4VTSobmM0mjflvagPCG2rc3Tukd4reQN7
         bgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936452; x=1758541252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZBtrYTmjnky2Xi391d5zrqPiMva7ofI4h9J6siEdNw=;
        b=KgSHo3cRVDQgYADaDL99lO9BxQSsx6WMLOc3vLe7cE/PQrMgmi+p0g9esd2g/6a7j9
         ajf2eQhn7FiMV7Xu7IPNRHQrPVTCFDjEdSlCqgC6DucGwg1IvIObgAqcuUpl+iB1XzxA
         3AlY7gX4IqPlRthofzl1ex9ke26fjdF0fTu01ZHUTakaLzdZ9RT4pRc0/aAgr91GDWW6
         81PWLiTEsF1qxM8bhe8762LNw1zPCdC+DczBg4lAK8GS6rnA6XB4TUz2IfdN3YCtIqKQ
         fx+iXncqTPTAMcyyamgR9YNoB8f+8jmyU9Rxb+4kYEPAptL0cUFAi8KTIynfvyeYH6fi
         SuVQ==
X-Gm-Message-State: AOJu0YwviDCLU5NPZ+LEUUZkw7ee5xlq/5XajZdkA91Nj5IeHpwFStVo
	xwh6OKB+7FC2dTYL5UtcyhchOrVgyZvFv71mTTdIEsSCjS+p1ykGtLwED/77nQ==
X-Gm-Gg: ASbGncuokUQQqH6c7ItcNVC6+RUA88R6zRFjuOeyJhvP2bS2121B4EwHOVYCPey777L
	H/sp4zzf3A53Ke5F6curTKx2p5lnG3/02aPQ1R37YeKC+VwdF9ZK8BJBEvL3usf/XTZHRGXNHrJ
	sY+6lTDwLjkRWgD91MLw5bLBBXnIHGTitktmxlxfZODEdrAVX9hj6RF2ViFTsGGOsoRf3qDme51
	9ua12sWUjiiDs0eEJQN4OgYA7z29RIpkYoWALutiS4bVwmkLYVO9bNp2P+7LOYyg9QyQMNcEat+
	hUE83GAWEAZ9iIGaBkoNG9v/nBdhrJQf0r24fkfOySKRerCzUHC1V/6C+hpF4HQ4eGujXyOPPDx
	P0VkFRmhIbTbfDdWNqiNx56z+sEr7edgBh+1t9WzcNweM
X-Google-Smtp-Source: AGHT+IEPBDET+aq7aWqMBXc4+ldGUX/PWl3peX+qrYQPG3n1Y29xuY+8jud+W1D227pp/+3seZYrkw==
X-Received: by 2002:a05:6000:2013:b0:3eb:5e99:cbd3 with SMTP id ffacd0b85a97d-3eb5e99ce8cmr1458035f8f.2.1757936452358;
        Mon, 15 Sep 2025 04:40:52 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372bbd3sm172482185e9.10.2025.09.15.04.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:40:52 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Mon, 15 Sep 2025 13:39:30 +0200
Message-Id: <20250915113933.3293-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915113933.3293-1-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
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
 include/net/gro.h      | 27 ++++++++++++---------------
 net/ipv4/tcp_offload.c |  5 ++++-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 87c68007f949..6aa563eec3d0 100644
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
@@ -487,19 +484,19 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
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
+	if (NAPI_GRO_CB(p)->encap_mark) {
+		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, true);
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


