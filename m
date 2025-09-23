Return-Path: <netdev+bounces-225608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215D6B96120
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9447F2E50D3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689601F9F51;
	Tue, 23 Sep 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3cMkmrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D01FA272
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635284; cv=none; b=BaHv+EdClTNDXFPX0EvXMdPE1KkvU+nxrDU47/osSWsvEJxbES/rJ6sfoE901NsLh9Gj1lXnQs+lN3aLAcjlg2JzIholtYxZdq1wpuI5NQokydKtNfnJBXlkpzJwv6SE90rSa7KX0DrPHL5FLFc976CAZQt1k33Algr9vOWOgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635284; c=relaxed/simple;
	bh=wOWM3zvde4VSAfRS2OxgT8HQ3c0Y/Ua6TkgjMC1x3Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKBZTMrCXiHoJE6qJTxNKp05XdpN/mQ+ThbkF23tUZUQVflxXjz05rmF79R1AcjzvBIOa60RHNuE7tUfslo0frM+ECFJ/MTBDZ1TEzwBxReFBj+2tPVUkbg77CdVKXxsjuK86+x3/1eHjYBQt+m9+gAAR1dc/uFjcczsb2QMOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3cMkmrG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so38235225e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635281; x=1759240081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiwjHgiPDomJYFUqke/kMVpRIqpsQLaApqazljOId70=;
        b=P3cMkmrGCVV7zoFK7u56o/hLTok22rADzsmU9YXmHuC/4tfQy295cKOEOZSVbdLKMy
         /IKJv1/KpHucd7YjX+IBF8CYDQZ6cDBLvkXuTIhMLZnnBcLqWNrqKiCzCQvSZy3VGKQm
         oviV8RiUlkPwV6HAFwWq0G2gw0NZD0+Edw+HEoKSALRXr2P6eBM9qNjgL+tHObShqCW5
         +tTS6scrrDhmfttxBzxBIjdlsVx8slPnKV3mcbpMLspmAAKtT/zJsEaTnGEnL4Q3sVcp
         XOlMEDSWwQueRU3VU+wzmQKY0Fspb0yQs0B6v1NdZhEPrr/HiEqmVEbTyhvpRL7g/B6k
         4Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635281; x=1759240081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiwjHgiPDomJYFUqke/kMVpRIqpsQLaApqazljOId70=;
        b=aCC4q47lKnCGn/jWQR3XDgiQ+NchRZ/yBvtNz+CiIyVJgaqinbQyGnqhV7T9CWvlBu
         q6UOml5yrXkFLT7cXX+F00Wfyy0M6+bR4KxfWiAHDzY/wQ9Bo+JTbIXiuoDyZGjRXvFD
         +SXp7OUANrmygSVLZ7G9/FJ9Ob/3o2gBZg3inNtFK496QNkSIvACN1Odo6LB6y3zGpcr
         IsCA0a4ThCQnHahl2gruZZMjmP4buQRUalurlyg3euOyuzBqlw17oovPEGBQ5+V4uEG2
         CjSRkwsx+VFRo+JVDA7KgXXl4obEhjYuC8sj3L9GQ/xawmFJGD9iMqPGtxewNXDE84Fp
         2/Aw==
X-Gm-Message-State: AOJu0Yw3GKDFEx0LE/cITWr40unU7wuqpiHEjom59LVVtNZZDaDFE6T8
	PYhYUqNNxotE4gG9jD71Q4kYh5Lf+jhkCiysIYXbMgFQZwmOKB5syh15
X-Gm-Gg: ASbGncsx303aEXDiSiB8w2TGMgmApa648XkZZ0RSczEHhctqzdpbAbGV40mJG+7K29f
	0YTarnhk72ZBpBNLi/NgfbERtP4i4AsvhQRUJq9XyAeuUpqMQXSwvWbBgsaZFA6CJy42METFu7v
	O9ku4ndVHBdeWHS9dhnUEdAgY5LJw4xOSns6dKcv76jRFkUap0ZMbqS9Kke0MW+biJQ59pqwSyf
	TEajR3tRKVd3HgEN6voRtklkxbncCovKsgE+kRWvL06585/PwEmfEk9tsMOa5wkSXvNi6iyeHYK
	eqzff46Vc92CFUW0C0qd3mrf+M9pis+kipvwPud9UufO9gGJhPNzIh/Ufn2nltlOjfcf/fA6nw3
	apl0n3LI5Cf6e4okjwXpNHmsXJ/iECrAr9zIyof8KFLqiZfXYksv7ne4w2Qc=
X-Google-Smtp-Source: AGHT+IGbZiT5+BCELIFnnwRckjb2K3SdsmGiZftYPgpeoLa/VwnRFQ+nCNcwib5Wwo/BXr2d291YVA==
X-Received: by 2002:a05:6000:3101:b0:3da:484a:3109 with SMTP id ffacd0b85a97d-405ca67b5c2mr2603530f8f.38.1758635280370;
        Tue, 23 Sep 2025 06:48:00 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee1095489asm23214811f8f.24.2025.09.23.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:47:59 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 05/17] net/mlx5e: Remove jumbo_remove step from TX path
Date: Tue, 23 Sep 2025 16:47:30 +0300
Message-ID: <20250923134742.1399800-6-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx5e and mlx5i TX path, that used to check
and remove HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 75 +++----------------
 1 file changed, 12 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index b7227afcb51d..0b15e141567e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -152,12 +152,11 @@ mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
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
@@ -167,17 +166,12 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb, int *hopbyhop)
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
@@ -239,7 +233,6 @@ struct mlx5e_tx_attr {
 	__be16 mss;
 	u16 insz;
 	u8 opcode;
-	u8 hopbyhop;
 };
 
 struct mlx5e_tx_wqe_attr {
@@ -275,16 +268,14 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
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
@@ -439,7 +430,6 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	struct mlx5_wqe_data_seg *dseg;
 	struct mlx5e_tx_wqe_info *wi;
 	u16 ihs = attr->ihs;
-	struct ipv6hdr *h6;
 	struct mlx5e_sq_stats *stats = sq->stats;
 	int num_dma;
 
@@ -456,28 +446,7 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
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
@@ -491,7 +460,7 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	}
 
 	dseg += wqe_attr->ds_cnt_ids;
-	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb->data + attr->ihs + attr->hopbyhop,
+	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb->data + attr->ihs,
 					  attr->headlen, dseg);
 	if (unlikely(num_dma < 0))
 		goto err_drop;
@@ -1014,34 +983,14 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
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
2.50.1


