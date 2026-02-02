Return-Path: <netdev+bounces-255987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB/4OOv5gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CFD07CF
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 529B4301A86F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BE30149E;
	Mon,  2 Feb 2026 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="CUF9LwUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rs2yJZT/"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B592301702
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060249; cv=none; b=VLLe9YCjwRKyTwoBNNyY8LLe6IOZMD+kegfBCiuALb7qPcOIeT8HYgWArS3ofg6CIi/POVu0RauqQW2NOPemeulzSFhKzGWY5TweYL4FnX/5FRioqhdfViGNVnC+hMla2UMJiEPrDLXNKlx142Xq+LeY7NFzBk2XYWMq6PZa4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060249; c=relaxed/simple;
	bh=meNHIeposXCjUubv5TWlm3npDnkVGYLPTiFPkR+HS90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVUxz41VPY/72oqrH1gdK+gtbICDc+zye/HmJjbz87bvFshW5RqEepRIgMBY+cvXhBf0DzO+G+jqN/dyjuIavJZBQPFjk55qzLIQaQZOEeFCkrNQF1nFrzWfYpR96+ZDN/T2UZrjjbLhkcTMhakSi50oDNNTospF9CmDVEtyiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=CUF9LwUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rs2yJZT/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A9791D00077;
	Mon,  2 Feb 2026 14:24:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 02 Feb 2026 14:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060247; x=
	1770146647; bh=l3IEk7ow+Rw+68kmp4DOFBN+X/0wiwg+8X2m6zlCOr8=; b=C
	UF9LwUNpRTLQ/GflcwlEmvoCknnlIUR8RzmybTTFrWeFoI8IvkBk2k+NKoCo8hnX
	dO+muxGNoMZVMjvjW6iPJs76+vJ5YeS1GpHqHnX9azHf4ucrmy1YXnr2BzWFJQJU
	UmRLzo07DuDkeGsKbKnFlmHYKDxg6vVAFM8BDOWJ97DRJ/d+z1VzLxQcYfegjX4G
	84Uh/d99zD4CdqDhdPFZTS8rm98vIPweinVV8U3ac2tk2yBD24hcNKUn/KgQU7ZJ
	/JOmFriUS7bK1YG5lME6Ql8/FyAnaenL6f1CBRbgYZpzCIliJOFbt5deAV4vN900
	WuhqYQ+yZczAQykUl5TIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060247; x=1770146647; bh=l
	3IEk7ow+Rw+68kmp4DOFBN+X/0wiwg+8X2m6zlCOr8=; b=Rs2yJZT/UvFq/GJP7
	v+IrtbR/7QcprksRKE4ZZF4JZEOjR3fpBaARIy7xK1aHC7gaZ1vlZ7eM/iNp7RRC
	vg3z4T9tAbTl8p/nsFCaT8hYdSBA1fdoW8cO1iA1A7y/yTOhSEfEDDmx77Bi8fvS
	owQSFu3kxjBXHOwfp1R9q8B/SXToQ1ONGU5oMAAGhPMNeH81dKWO96D7u+8nccxb
	EzjabIt1AE+KcJOZ2qfEy1NQUScsaHDkLjrHY/r+r6v6vB0RWVcJ6ua9M6wLIbOt
	/ApCQbcSdsV1/CTiKOmoVrXmLlahXdR0I46X3UWdcjAeJHXWj0xygb1vilNiAcd8
	BO2Kw==
X-ME-Sender: <xms:1_mAacPlc2nb74dte-DlQeZ5G3K6NwPuJ32yhyGDLEWw3XAXBbktqA>
    <xme:1_mAaZWE9EKAj6Jf_haZDEBfFFa08RFU6cx7Ea4ZfR8jMd7ylUnH9q91jzz9FaW-x
    gYhL_5lUEbjfsPOpbae5p2AkRYrqFX2431gfZ1R8KpidSjTaxWoyiU>
X-ME-Received: <xmr:1_mAafhyhh0U4dS-45JkYwyn3EsDR15HuocQK3-d1HgBiK1r_bH0PrNwO6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:1_mAaShjl88JhfxD9j_BwBLd5-WBQfFxrfPcuGC22v-1UZi6ujcNOA>
    <xmx:1_mAadEyVRhQ-tzeEz5MQjeBC8ykD0EZFgoCHc9pjRa2TsEzDpXyXw>
    <xmx:1_mAafC0RAyOeyOYBoWORzUPABlTZk20-3yRgItR4rMLtClLkVaA5w>
    <xmx:1_mAaTCN_lp70RyukJp7aa4JJ5rhOGOunHYHOcGMH-SM2v-hkpJ6OQ>
    <xmx:1_mAaYYsFrB-_C25_sslmve2ScyHOh-litnzeru-jFwpm5fSUg67PL99>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:06 -0500 (EST)
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
Subject: [PATCH net-next v3 05/11] net/mlx5e: Remove jumbo_remove step from TX path
Date: Mon,  2 Feb 2026 21:23:32 +0200
Message-ID: <20260202192338.2373930-6-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255987-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: 8D3CFD07CF
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx5e and mlx5i TX path, that used to check
and remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
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


