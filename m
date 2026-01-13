Return-Path: <netdev+bounces-249595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFEAD1B64A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34305301267E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC9337105;
	Tue, 13 Jan 2026 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="YxKiZy93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJHa/bYk"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCA32C932
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339673; cv=none; b=b28xN+iwh7rK1gBYXQuAlz/tWEB0hli/yP3yqv1SSJrXdSUGXgkzSP5p4euGFmsgJxzvDeJTAZlqcs5X2y2w7+0gy4pI9DsYziZJaGKdOJV8CNV/Ka0B+U01DBp6fDQ8Paor2DdbrDoT5alo0Zez2lFXki6uE+AiRjJ6BNpOtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339673; c=relaxed/simple;
	bh=cx2VbeoFomadnF3iUhGINjSFTzcXbY5iSFeW+AXxbws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvToQjubl4cN+nY45FAvtZtRZGVokArqdgY3hhwSD2EmWj8VDuNI67jDi+kaGnns7al1ysOm2mVSVhuL+rnqrws2RUKfGmAh0qtphBUCJBk6oK2N9nPsw5EHELDR6aiTw80BoYBhIdpQXyrgcuORgO7rtFkeMMcqTgkh4r6KpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=YxKiZy93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJHa/bYk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 78EC3EC0222;
	Tue, 13 Jan 2026 16:27:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 16:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339669; x=
	1768426069; bh=zxSmJMTpypLtPoA8LJa648HDOD3hb8gW1asha3mOr1w=; b=Y
	xKiZy93ybQuab0DNlHKojELsejF2tadyIABzRPGuWHRbE9m3klDRChmyxlzuaToF
	MjpIizIbWy/ukDYQQfvtVnNvHdYj5bbI5dxyQftiIBmr863v5WbsEzRCAYk7+H5M
	gu2dtVyzaQH5a613hD63DMpzny4ksOtMQq1aiwOLIo2CLrhH5ksZnJ0TbeNDJlXK
	D1uXvht98BcqsoRMpd/cKt45c2T7n8QUSXomPDeQWnjOHMdpgacIIhGK2HB1FjsJ
	VjqCwA7EZtflE0Xpuc0/mxGFkVuZltMq3pWuwIByPVrdtu3T5gi7zTDpVZ3hReJ4
	DQ2vrqC84iBzBtnRHmCcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339669; x=1768426069; bh=z
	xSmJMTpypLtPoA8LJa648HDOD3hb8gW1asha3mOr1w=; b=kJHa/bYkKZgZJT7Y1
	LEvH8q8ItCYZ9ImRnncLWrggMK+14TN/9E05jdwTLMIU+z8baRc3pAd7Yq1/nceu
	X27nMeb+D8bdSd5n11dlOgna34gr6Twk654hRq9BBwYCuC1nvIhNoVVN7nyQ62aE
	Oigl2MiYF2dhGWSQ+J5Ya1W6Kxe7FPuhI4Zh3xBU16cR6hX56q0kUpxpjFr+oU8H
	Pbua1RDMrpVmgLEF8xSSbWkOxo0wu2A7xtT9deqcpCTudBGGC1UXAuwiSBItQJyd
	T/3Gb4LE8OQGz4RxO9T4QwQSEP5IPEZiMolNFQcfmnXzM9mSO91yFFHdpFuR19U6
	4pVYA==
X-ME-Sender: <xms:1bhmacEj9CV1o6cq5eLuQLMKtOGM4lPdQHSBbzFiio2Jvx71QFCoow>
    <xme:1bhmabsdaScXEipOh63Ay-wxDejDqatKxS8q4oZO3wEJIGzCeOyKfMckS7CJxjcuR
    6aRpx1yOKT6KQ5PeSaFj-J1ScXEeXCAs3BivV4Kkuq47h1ct8Xul00>
X-ME-Received: <xmr:1bhmaSbMy0eMY0NOwIReVSpJfG-vPXxFI0-Gj962bjF3vdWUxudhlwVBjMQFLTSKFKliVYzsh6P3gmhjixyElNKR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:1bhmab6vpTesNcMWQepPd70BgtvUYkv75GznQ2xCkvoiaceU3AVLAA>
    <xmx:1bhmaa-Sgu3Ema3rV0MB2yv2hCrM-Qqz--tirhgG2zQZbL0y6E4b_g>
    <xmx:1bhmaXb6X3nHA0GOOoTFsesmevM8eVCcYDmist-LN_UjtLZf2TSfIQ>
    <xmx:1bhmaT6LmZuB3FSRwy0EQ3ct_r7mhc6nrzupLiabvpKfFPCDwrZg6g>
    <xmx:1bhmacxjH8-niZAmZM43C8APol5PTSOEXwuhRbBbjKP_A_kYfaJLFLRR>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:48 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v2 05/11] net/mlx5e: Remove jumbo_remove step from TX path
Date: Tue, 13 Jan 2026 23:26:49 +0200
Message-ID: <20260113212655.116122-6-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113212655.116122-1-alice.kernel@fastmail.im>
References: <20260113212655.116122-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx5e and mlx5i TX path, that used to check
and remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 75 +++----------------
 1 file changed, 12 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index a01ee656a1e7..9f0272649fa1 100644
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
@@ -1019,34 +988,14 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
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
2.52.0


