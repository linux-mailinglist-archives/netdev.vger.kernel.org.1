Return-Path: <netdev+bounces-256201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBA2DbG5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:02:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C2D68A5
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2836B3082DBD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1F83090CD;
	Tue,  3 Feb 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="hf6PM974";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IXBP1ijW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101741B6527
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109253; cv=none; b=t/efRHJ8CAAiEH7RJOF1Kx/5OLPLeWhmBR6HaPoJx/YeiYyYTXszY25V543osWNqYgXvtnuFyPZn3GGZ2+uKR91EIgFJcFzMl0du93ftPnhX+EGvRcMeOWUjRu7TnMt0gKSCtEQUensUQo0KLGZw5SvY1Vv3FZGp3IsBcpsSZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109253; c=relaxed/simple;
	bh=bAs60iqMozKxDYQorKRnDklAWrtMX0pvGNXICpLkDGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0yDaibuL24rsK0jb4L3+NfNNoMSUmZPcewHz7OvX5Rh3GaA6EPqCd2eyqRqneSt0DtuBn/2H7f6GNqkEUW+mIhDMK27ll4gpfRJ5X2W2qC5lTiS5v9dQpmFXH3XLjsLZfxBF1ksql27wwVDrrVmbKEXGeIR1Ty65fcAnEiKhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=hf6PM974; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IXBP1ijW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F9C51D000E2;
	Tue,  3 Feb 2026 04:00:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 04:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109251; x=
	1770195651; bh=np+pOrfzOqwiHTa57KKoSJERIzhAmYoXn+QiSon9kog=; b=h
	f6PM974n8Rlwffqwge5MreFhR8Z7Kot2MN6DutNy6/QpUckbdX+JoV/zf5NYoGkN
	jcwGIvvQ8nanaa4sWJfmRoYyE3esHlBuyFSF6pbZsQ/+ja2DtqNPxw4RKS/jfR4M
	FFeMryvGRlCfOeU6F1PPqsWtq5m27RHlMIg4NSMfOab6Hx3NaXOUraheZHUz1mf5
	b9Ml4ZgMNly7keW/MmbGbXtHX8p65yE7iG7/yvAb5Ju7e2koiOOfH5lxW5dspTT1
	+p9+K9rK6CwIHLD6aUC5OOv2xdLdXWHV9UIHxg1bsNXf46oTKriXRD1n7vtGd8+b
	vs5VnVbeoJBk8cLHAVyyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109251; x=1770195651; bh=n
	p+pOrfzOqwiHTa57KKoSJERIzhAmYoXn+QiSon9kog=; b=IXBP1ijWhhZgE0lVL
	riXrmlEqGbHPpS7CT0mLw1mE2oiQEcX1wdoynrWDZO/84quMy+Yv2ZYqbczjBbap
	bWP82oIUjIgoaT2JOqbhl+G8YHMi8dgnnLggrO2GzRhNX6eRJZlS5rhOEZy9k71Y
	dns/K1UtVgt4ChXHel0pb4PL54vc4rLUErDyfiUnV79Bsq07ixosHURgZ3Ui5StX
	SXpsqvAeLscPmpE/v7yrUfyWy0kKzy3MoILCAbVdzrlsqGZceWGWGMlXCrfkEqea
	KLBsxkRTvA4pD3TFxEdko1FCPSfZI5vlfG5OoMAfe5eGYnU2nI3uHVPLgHWNLEPD
	1yC/A==
X-ME-Sender: <xms:QrmBaYAh7Zxul9MBZ9qaXmFBzkDn8UhkIxA6rvRxKDn5gnTXwR4Qbg>
    <xme:QrmBaQ7CehGmDJhABzgZzgkhPRtwY58OKZIAlzrkoQLlHRPAjlRv_JiqBVf-5D16M
    xIGfixaGibAUCKcG_wmwhaIQ95u7gC9mOrhB8fNGXIQz7gfduAFATk>
X-ME-Received: <xmr:QrmBaX1VdUEchz5tvCSuB9e9STC2iAB5e1Y3NI9YswuYvAow0sm-CE1_b9ob>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:QrmBaclTbeTqj3-SsfP5Cs_Ej8GO8_HFl8AsGO9AyAYmyb8rQiq_kg>
    <xmx:QrmBaV5NCaDBesuJLdnoamS-ZBvIt7e788b8Ot4tIvsxWw6uH9lbWA>
    <xmx:QrmBafmwymNes13rz5ceZ8PtkYp0aBStoSOSyxnn9I1GWYL0dRkY1g>
    <xmx:QrmBaQXzxiWOClEsxoNItJGhSdJZ3TW213QcGjLDaQ64v69CanUsdQ>
    <xmx:Q7mBaS8rXNTCEowlTH-bbbq-m4SOO22Xe342rMKaWFK-UQ-PPkJReiXP>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:50 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
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
Subject: [PATCH net-next v4 05/12] net/mlx5e: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:35 +0200
Message-ID: <20260203085942.2477583-6-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203085942.2477583-1-alice.projects@fastmail.im>
References: <20260203085942.2477583-1-alice.projects@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-256201-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,isovalent.com:email,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: 7C8C2D68A5
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx5e and mlx5i TX path, that used to check
and remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


