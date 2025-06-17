Return-Path: <netdev+bounces-198673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF66AADD065
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370BF188A182
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C502EA49C;
	Tue, 17 Jun 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLonJtNk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C862E92DE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171364; cv=none; b=iVlENxNveFG6qiZQ2Wy597k12nL5GzECcYPRMeaPKH1e7hpd/6DYll1ylW/du+o/sxGBPCR/Zf8aklBDt5P+fOgIe1Yk3uxKzX064cijAFfdfN0bOuwxCPqwwiUqkRYQkDa/JdbXRcShdjUVoZBVjnHmA1F0tW4463+anZisFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171364; c=relaxed/simple;
	bh=ts8zpbOE5dz/Z2Merb/hbx55izpaUw2dCUwvZ4+OvIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY/Q1gg9gjDchc5H1wON5E1/8XpOs1mKKq37TicxwLXH+gD3R1GkyKk0ELjDaFYOzlPEJ5I+U7LkrQkTqs+w29VKFzTpcAAAVWAdPcZspghJxs7O4fuX1fNQ/Ekjjy/Z3Db1fpBMQD9mjDAakbohYXG0QUqLzRIxmEg8LWWtpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLonJtNk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso1073876466b.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171359; x=1750776159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgnQitPx589T/W1yiw2S2s9LYUQwGPiU89AWtWkuV6A=;
        b=NLonJtNkWdnmJrA0SEI682RNFxAJc2a6pAAvuQIhX+G2uFnJTcAdFsICBpDYtpUrbC
         lTuZOQuUmnC49CqvFRl6CPRtZY7U3i01nuQhOJ0HlShGADraHTyKulKXkYbxOmc+gwxn
         3qDvVtkQtfIqdAB2wMd3q4uev7bTUUdCww6lWAlCj0IjRb+NDfZ0bj66Yj4inIbiQFCq
         N27uSXDa1xNNMhPeUCukCuMSihI2gufP9LsJ/PUg3ErkwpVthGS1P7c9g+z9jUw4ZMzt
         uWUDk/OvqJkyWqq7OLdFX3R0ih+wr/wL2zlX+Zhw6Vc5c8T9T9rclkPCTsGoiTU5K/b4
         4vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171359; x=1750776159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgnQitPx589T/W1yiw2S2s9LYUQwGPiU89AWtWkuV6A=;
        b=owB9hR6DBGVCF+Fc50RaGogjA55iNS4uqvNC0sws95/KxVvpszDUlFWktvoeaMXudW
         C6PC5PVMpXduYzKJ2nenh5PCsuv1xUtw91oEQnN1WQn+1dGBawUzroPbuHIpksSEPb5O
         ywvN2au1FDs6H52/GTq50fruuJj4j+YUYdzQ3yEFBENvX88BBpWH+e1H14b2MjAjteof
         xcH2XMuQl72rTLCsI3dI7w8/Ct7X/4M0CKv42fpE16/3mQRD2XUnhDXxYUCz8zlc3AAS
         wGzdlf/5e9tBMSHA9S8KjcVQTkEtZjR3DPfi+yR407domUVhwWbE0VmVDBQkPAvVNkMN
         MOsg==
X-Gm-Message-State: AOJu0YzyVXIEEiXHQTIjvcQ/KHfmt7qnO8XYFZaR1T66di4hzmqMz2GG
	FQVgqUZZ5oYV/i4xKrTXPDPMMa0RYHyTkOR8O2H7ChMKnIg855RfNadp
X-Gm-Gg: ASbGnctH/PeGIWiN/hNOQ8EZj9JpNFQJaPMOdCFUBUbN2b9yl5Y5SwbaL6l1+xri1DD
	aYB4QKzjZD6Ngt7FEfh/SEpbwudyRogP8mExl0Lo2uDMJG8ImtYjehEQab9eiFbpwimxeQDyj3W
	abobBCqQDuImnFeQjVZaq3vgZ2UQKftz7dZu8CXarC1364UJ9OY9UwBx+8T3iXcNFYESagqt+UU
	N/Z/yzsuNbE0fIRUBgTVUPqME2OgL83YIdWNMAQscGXYnXndaFi90sG5iSNOX22G9qhPB496vSV
	KaHADs2YxX5+EwZjEoIBsIWJ6jx692up6kk5qeh+weHy3t17cJXVV1x4cErevXGz2EoOIfAEtOF
	GVMv+lfhrBOlv
X-Google-Smtp-Source: AGHT+IHAvfDe7cmY1jM/kpkrUHuH8mG7ErZ4Mmp4rocPss+gv3KMNewT55KpXnmqN+0y1+XuHKkQ0g==
X-Received: by 2002:a17:907:930b:b0:adb:4523:90c6 with SMTP id a640c23a62f3a-adfad4cf64dmr1440933066b.54.1750171359205;
        Tue, 17 Jun 2025 07:42:39 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec892b8e7sm878802466b.132.2025.06.17.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:38 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 05/17] net/mlx5e: Remove jumbo_remove step from TX path
Date: Tue, 17 Jun 2025 16:40:04 +0200
Message-ID: <20250617144017.82931-6-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx5e and mlx5i TX path, that used to check
and remove HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 75 +++----------------
 1 file changed, 12 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 55a8629f0792..a4f78152e8f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -146,12 +146,11 @@ mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
  * to inline later in the transmit descriptor
  */
 static inline u16
-mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb, int *hopbyhop)
+mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb)
 {
 	struct mlx5e_sq_stats *stats = sq->stats;
 	u16 ihs;
 
-	*hopbyhop = 0;
 	if (skb->encapsulation) {
 		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 			ihs = skb_inner_transport_offset(skb) +
@@ -161,17 +160,12 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb, int *hopbyhop)
 		stats->tso_inner_packets++;
 		stats->tso_inner_bytes += skb->len - ihs;
 	} else {
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 			ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
-		} else {
+		else
 			ihs = skb_tcp_all_headers(skb);
-			if (ipv6_has_hopopt_jumbo(skb)) {
-				*hopbyhop = sizeof(struct hop_jumbo_hdr);
-				ihs -= sizeof(struct hop_jumbo_hdr);
-			}
-		}
 		stats->tso_packets++;
-		stats->tso_bytes += skb->len - ihs - *hopbyhop;
+		stats->tso_bytes += skb->len - ihs;
 	}
 
 	return ihs;
@@ -233,7 +227,6 @@ struct mlx5e_tx_attr {
 	__be16 mss;
 	u16 insz;
 	u8 opcode;
-	u8 hopbyhop;
 };
 
 struct mlx5e_tx_wqe_attr {
@@ -270,16 +263,14 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	struct mlx5e_sq_stats *stats = sq->stats;
 
 	if (skb_is_gso(skb)) {
-		int hopbyhop;
-		u16 ihs = mlx5e_tx_get_gso_ihs(sq, skb, &hopbyhop);
+		u16 ihs = mlx5e_tx_get_gso_ihs(sq, skb);
 
 		*attr = (struct mlx5e_tx_attr) {
 			.opcode    = MLX5_OPCODE_LSO,
 			.mss       = cpu_to_be16(skb_shinfo(skb)->gso_size),
 			.ihs       = ihs,
 			.num_bytes = skb->len + (skb_shinfo(skb)->gso_segs - 1) * ihs,
-			.headlen   = skb_headlen(skb) - ihs - hopbyhop,
-			.hopbyhop  = hopbyhop,
+			.headlen   = skb_headlen(skb) - ihs,
 		};
 
 		stats->packets += skb_shinfo(skb)->gso_segs;
@@ -434,7 +425,6 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	struct mlx5_wqe_data_seg *dseg;
 	struct mlx5e_tx_wqe_info *wi;
 	u16 ihs = attr->ihs;
-	struct ipv6hdr *h6;
 	struct mlx5e_sq_stats *stats = sq->stats;
 	int num_dma;
 
@@ -451,28 +441,7 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	if (ihs) {
 		u8 *start = eseg->inline_hdr.start;
 
-		if (unlikely(attr->hopbyhop)) {
-			/* remove the HBH header.
-			 * Layout: [Ethernet header][IPv6 header][HBH][TCP header]
-			 */
-			if (skb_vlan_tag_present(skb)) {
-				mlx5e_insert_vlan(start, skb, ETH_HLEN + sizeof(*h6));
-				ihs += VLAN_HLEN;
-				h6 = (struct ipv6hdr *)(start + sizeof(struct vlan_ethhdr));
-			} else {
-				unsafe_memcpy(start, skb->data,
-					      ETH_HLEN + sizeof(*h6),
-					      MLX5_UNSAFE_MEMCPY_DISCLAIMER);
-				h6 = (struct ipv6hdr *)(start + ETH_HLEN);
-			}
-			h6->nexthdr = IPPROTO_TCP;
-			/* Copy the TCP header after the IPv6 one */
-			memcpy(h6 + 1,
-			       skb->data + ETH_HLEN + sizeof(*h6) +
-					sizeof(struct hop_jumbo_hdr),
-			       tcp_hdrlen(skb));
-			/* Leave ipv6 payload_len set to 0, as LSO v2 specs request. */
-		} else if (skb_vlan_tag_present(skb)) {
+		if (skb_vlan_tag_present(skb)) {
 			mlx5e_insert_vlan(start, skb, ihs);
 			ihs += VLAN_HLEN;
 			stats->added_vlan_packets++;
@@ -492,7 +461,7 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	}
 
 	dseg += wqe_attr->ds_cnt_ids;
-	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb->data + attr->ihs + attr->hopbyhop,
+	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb->data + attr->ihs,
 					  attr->headlen, dseg);
 	if (unlikely(num_dma < 0))
 		goto err_drop;
@@ -1015,34 +984,14 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	eseg->mss = attr.mss;
 
 	if (attr.ihs) {
-		if (unlikely(attr.hopbyhop)) {
-			struct ipv6hdr *h6;
-
-			/* remove the HBH header.
-			 * Layout: [Ethernet header][IPv6 header][HBH][TCP header]
-			 */
-			unsafe_memcpy(eseg->inline_hdr.start, skb->data,
-				      ETH_HLEN + sizeof(*h6),
-				      MLX5_UNSAFE_MEMCPY_DISCLAIMER);
-			h6 = (struct ipv6hdr *)((char *)eseg->inline_hdr.start + ETH_HLEN);
-			h6->nexthdr = IPPROTO_TCP;
-			/* Copy the TCP header after the IPv6 one */
-			unsafe_memcpy(h6 + 1,
-				      skb->data + ETH_HLEN + sizeof(*h6) +
-						  sizeof(struct hop_jumbo_hdr),
-				      tcp_hdrlen(skb),
-				      MLX5_UNSAFE_MEMCPY_DISCLAIMER);
-			/* Leave ipv6 payload_len set to 0, as LSO v2 specs request. */
-		} else {
-			unsafe_memcpy(eseg->inline_hdr.start, skb->data,
-				      attr.ihs,
-				      MLX5_UNSAFE_MEMCPY_DISCLAIMER);
-		}
+		unsafe_memcpy(eseg->inline_hdr.start, skb->data,
+			      attr.ihs,
+			      MLX5_UNSAFE_MEMCPY_DISCLAIMER);
 		eseg->inline_hdr.sz = cpu_to_be16(attr.ihs);
 		dseg += wqe_attr.ds_cnt_inl;
 	}
 
-	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb->data + attr.ihs + attr.hopbyhop,
+	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb->data + attr.ihs,
 					  attr.headlen, dseg);
 	if (unlikely(num_dma < 0))
 		goto err_drop;
-- 
2.49.0


