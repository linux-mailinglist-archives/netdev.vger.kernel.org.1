Return-Path: <netdev+bounces-225525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B4B9519A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA05C2E2AA6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933BE31E0FB;
	Tue, 23 Sep 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVd5AUfK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97631FEF7
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617971; cv=none; b=UA84eL8N4tNG8ap7rIY0i8yJVWIXmrUM3pTd7TFNezon8sboNnKalmehEfrVo1vpvOe80bXXtkcXLkDGi2/vxt4kdFdg9tkpv6v0FeAegdyENw2cACTauCTUW/79hb6uu5K2UDpO4Or45ZVS+5EUPcTbkGckSaF6F20aGPBk1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617971; c=relaxed/simple;
	bh=4TByKul6egSJk+HaKyldDbHrnF64wZfAJH9KQXUP8mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnRIMYo1NV7G/TDtPu5z2Gjk7XtWuRwN8gBFfSdmDYFfB9VCX9YT/KoToRer8hpEcfwSv2m8SiiQu1V7gwAycZ3IC30FwGgu8o14vnHV1istCHhYmU1jMQ8x62w1VeFYvGqNOtOb5QkO2VEaIjH1AnVpHit3+Obyh57oUxsph+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVd5AUfK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso4078605f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617968; x=1759222768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMBCEfnu+kmymytri3ZOW4zfHFjEkdcPm1fze6NbWnw=;
        b=BVd5AUfKJRjtDti8vvslh16JowuJ7AnqhpCpMYhl3XJR4b8iDlCNv7RsmGOe3f4CF+
         hvpbfDTVqYFMa3WGxkbYMSOQj+qzhbSnjfLdzni+nRq+GThuGO3wM79Tp0vhTogVQpmh
         k63urCQQ32xsE+p/f3BfuVKa80tzo2XJPLLaMXbEYSJs4/gA6o9HhHA2VFyOO788u/Xo
         JTKHxCuqoh0i9pzoEN9s/CMYeqHyK8MWlre9tbkNYUe0iwtvrFodefLA8UCtvp+7f5mu
         cKDz9a224RO2FquQV3X/q10NpvXfU3544DByD/0KTUrbaSDTN4+jYsEIHjtfLJWi++bx
         porw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617968; x=1759222768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMBCEfnu+kmymytri3ZOW4zfHFjEkdcPm1fze6NbWnw=;
        b=LYq9vnHlHzErd+VB69Aiw/+bbCCZkpl+Ks8RHH9zwJFK6/4uzgS3vWcnq/v+f15jzu
         48lpzkbF8vUXuhIzg/9aKLDfENdZq4kUJBdIdz1qOc87wrgBiNtjPxw4XF5WFkHr3tds
         7k3uasIT0Aw3IRyCzD+hJh1gVscYPypKlTW7ePbvHMgdOc0ClCYy3s+5oqLPBt3ZNvue
         xGRDozZGAACIvRnI2e9FgL6PUHkwZvoiLiXtGmgShZPT5xKStHw+wtHkCe/O5UizoZCU
         T8VE2vyrOmKh0xe2rUbz2RZPgwfzwzKQO8S6JhWhsge4FR0//RbUXKPFmtfB8GPqX4AO
         4fXQ==
X-Gm-Message-State: AOJu0Yy1ubgDgCC4kJpVctkokPLKD2tIvreFV4ejP9KftputmVMqEkP+
	hGcEZ3ORxYpWTGCQ0NXDLb8SN83ATugSdxthHuFEyzpUdxUY3uE7ftS6kXPDrQ==
X-Gm-Gg: ASbGnct736rXGH1og/UQ9s7K/H/p1JaXJVkPJ6YCk/rt1IKpIET9Tc6qxM75CUeIF8q
	PuecLOl6XakgO7dv0hWlA3I4mS5FDQNfQIYWccYrTclI721w4S7+IKd22LDWnmLotmNs6q4PDoM
	pMpfGvCGZABbfND4Ff9v67PBFZRc9wPuB9pmM7NfOT8aQgSwaxgpCTK30MJUS+/eTR0pr7dIgy+
	SsnBz4b3kEkEtMg22TfK8iP+sYYpqQGs7h6lp/HNExeh5okyEK0/zcFL02SohB1To6RDN5/pZlf
	qGOXa1R4Pqvm7U79LfbvVBG2TCB1W+nZE/K0f+qlWDl55PrZAKZvYCAxchIG2vLHxDKyesx55+8
	jl3lcIQ6IdvhZJPprrC7Q9eo=
X-Google-Smtp-Source: AGHT+IGOqHyX4WKDfvB1rmoMNtxtsxlSY9mdxEHxCQRn3i1HhC5BqsYZLOZG2J1bOy+2bSjoZ9fRlg==
X-Received: by 2002:a5d:64e8:0:b0:3eb:4681:acbc with SMTP id ffacd0b85a97d-405c523c244mr1529592f8f.23.1758617967928;
        Tue, 23 Sep 2025 01:59:27 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm23531696f8f.60.2025.09.23.01.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:59:27 -0700 (PDT)
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
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Tue, 23 Sep 2025 10:59:05 +0200
Message-Id: <20250923085908.4687-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923085908.4687-1-richardbgobert@gmail.com>
References: <20250923085908.4687-1-richardbgobert@gmail.com>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/gro.h      | 26 +++++++++++---------------
 net/ipv4/tcp_offload.c |  5 ++++-
 2 files changed, 15 insertions(+), 16 deletions(-)

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


