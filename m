Return-Path: <netdev+bounces-249594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A51D1B653
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 331A7300B013
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD19332EC7;
	Tue, 13 Jan 2026 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="LTIX7MqD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6EcQ5Cj"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68890325700
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339673; cv=none; b=i8xLBCnJhx5ohTL7Sw0PW8QqiVnhgccCmHYtzNy5rKs0TjUWswjTA1DwgJp18OVKcoBqTS0fyAeldL4J8NyQ9oWkJh+pmkcYJNWPhmQwtYeA6YqfkB/2PCNdaRGEgXSEcmNYu3IMNiPORBejK5vzaS+EjSa8sOWp2sN1bQdrr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339673; c=relaxed/simple;
	bh=P1xiweHsBic/WyuJb54FBfBCbyN2y+28WBaxYkA6NFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw7j7l+sIFn3Zzt8QruszZHa3Y1PCZtNE1l9ovCfApVcnu3gs7QLMy6/GYDUej4XhJajOBjDYttT/3G4IVoEbYji9RKgjAyaJ8gI10scGbhRHF7LOdqLzvjA3mkEia66ddhh03Va/V92o4Y/QV2RWG4BJmFhQNT42Xay/VX3QAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=LTIX7MqD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6EcQ5Cj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B4618EC011D;
	Tue, 13 Jan 2026 16:27:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 16:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339671; x=
	1768426071; bh=Td/mjP52rfEVP5dVhWN5E+QXGM75E+mZpJ1wIaODJw0=; b=L
	TIX7MqDX+AcebeXx5hEuhX6Suw+GgAMSjUWE3ktajHByYWEEcPrtqRoiLujd3zgs
	CNB5uGjgclQlgxipOBp5gU8DM4iW+sk0P9J7aL1aOmMJbgY1aCv7kQA2YkFn3UyM
	bY3D77N/QJTMI8lsY9wamk8wezZSxC5xTSEydcQHfazfkEsW5dYpudHw4QeHP4a2
	C48N23IClqVZUnTN5IlfvPuzAuUrRhpOzn2ejvdqhAvmSorMf8EKBc2TyY6mpqGl
	1tKKUjir7zHgHB+aXWNemM3olqgWHwZHyFay2fr+JXJBg+f7qFvRq8p8CKryl99n
	Pn5nMyT8oEPXnDGVDSdRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339671; x=1768426071; bh=T
	d/mjP52rfEVP5dVhWN5E+QXGM75E+mZpJ1wIaODJw0=; b=M6EcQ5Cjf/TWvqK6U
	tQOh94qKKpdDmGt6YTUa6uhhzt0xo1lMhapLqL8aegDrXZKZAaWZq5BN527YeL43
	kzlF45uLucN79fgxz+pLB7Yv2CeP41qLCfXjsPZzYYWK/4d9BS5V6D1i6p6mdzGz
	ELvgaznTz4xv8VzNPTlgc+iTArgG08kxfRUs9CfRDZMetHw81Hw7i4+qAlSVpCqe
	mUkrKnrczqzok0RoQnaWSnnEKmMCv2K5k9LN6QT1dZ/XVKBW6q0I/JYX++4A22HS
	oBaFmmxDl+fmOOEQYK8nxr1w8Dp0kL9KQlwoDKJe4hcHv4pbwCy2M4MId5puunyc
	6bmAg==
X-ME-Sender: <xms:17hmaenkRGyOEkx7mg2kruA1WAPv1iFqDSDepmc9DiECq8TrTwcShA>
    <xme:17hmacNLNWZ8dSIogcFUFi6gZliyEbUppyxXNhDDyA1q8yJiK3SlI0n8rOTCjKahZ
    V5QmOVEoYTiB81BC8Bd0XbUZ3DEGJCvQuE-r3YLhUBjwGnOnl9Oxhc>
X-ME-Received: <xmr:17hmaY6VdtUticF0R7BBV8hacitv6rPFIRTho_3waa9PWvXsy9ibCV7e2S7sarEvGXWfZo0P6Amk2BJR-EeF910n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:17hmaQbhMNYzG7hjuowAcATdi5DxoDxOpValpw1K2SzdAyegrZZs-w>
    <xmx:17hmaVc-bVv-Otlvwt61p4N12vQ1zmBZCy9O1EoB59TSHKtahlN_9A>
    <xmx:17hmaf4AZAvxhlIP_SsW6foVvInera8Ng0L_6zkODxXyDAuJHizztA>
    <xmx:17hmaSaDjlp-r5yMlxURtWYFOeNSRtaW1tQ5ke4-lRQ7_xo1CRlSUg>
    <xmx:17hmaVSnTr8CIsvqabdlKAGC7gbLx1eI9RtGQ6Kq2zR3PI9aXk3-LnAQ>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:51 -0500 (EST)
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
Subject: [PATCH net-next v2 06/11] net/mlx4: Remove jumbo_remove step from TX path
Date: Tue, 13 Jan 2026 23:26:50 +0200
Message-ID: <20260113212655.116122-7-alice.kernel@fastmail.im>
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
unnecessary steps from the mlx4 TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 42 +++++-----------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 87f35bcbeff8..c5d564e5a581 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -636,28 +636,20 @@ static int get_real_size(const struct sk_buff *skb,
 			 struct net_device *dev,
 			 int *lso_header_size,
 			 bool *inline_ok,
-			 void **pfrag,
-			 int *hopbyhop)
+			 void **pfrag)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	int real_size;
 
 	if (shinfo->gso_size) {
 		*inline_ok = false;
-		*hopbyhop = 0;
 		if (skb->encapsulation) {
 			*lso_header_size = skb_inner_tcp_all_headers(skb);
 		} else {
-			/* Detects large IPV6 TCP packets and prepares for removal of
-			 * HBH header that has been pushed by ip6_xmit(),
-			 * mainly so that tcpdump can dissect them.
-			 */
-			if (ipv6_has_hopopt_jumbo(skb))
-				*hopbyhop = sizeof(struct hop_jumbo_hdr);
 			*lso_header_size = skb_tcp_all_headers(skb);
 		}
 		real_size = CTRL_SIZE + shinfo->nr_frags * DS_SIZE +
-			ALIGN(*lso_header_size - *hopbyhop + 4, DS_SIZE);
+			ALIGN(*lso_header_size + 4, DS_SIZE);
 		if (unlikely(*lso_header_size != skb_headlen(skb))) {
 			/* We add a segment for the skb linear buffer only if
 			 * it contains data */
@@ -884,7 +876,6 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	int desc_size;
 	int real_size;
 	u32 index, bf_index;
-	struct ipv6hdr *h6;
 	__be32 op_own;
 	int lso_header_size;
 	void *fragptr = NULL;
@@ -893,7 +884,6 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool stop_queue;
 	bool inline_ok;
 	u8 data_offset;
-	int hopbyhop;
 	bool bf_ok;
 
 	tx_ind = skb_get_queue_mapping(skb);
@@ -903,7 +893,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_drop;
 
 	real_size = get_real_size(skb, shinfo, dev, &lso_header_size,
-				  &inline_ok, &fragptr, &hopbyhop);
+				  &inline_ok, &fragptr);
 	if (unlikely(!real_size))
 		goto tx_drop_count;
 
@@ -956,7 +946,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		data = &tx_desc->data;
 		data_offset = offsetof(struct mlx4_en_tx_desc, data);
 	} else {
-		int lso_align = ALIGN(lso_header_size - hopbyhop + 4, DS_SIZE);
+		int lso_align = ALIGN(lso_header_size + 4, DS_SIZE);
 
 		data = (void *)&tx_desc->lso + lso_align;
 		data_offset = offsetof(struct mlx4_en_tx_desc, lso) + lso_align;
@@ -1021,31 +1011,15 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 			((ring->prod & ring->size) ?
 				cpu_to_be32(MLX4_EN_BIT_DESC_OWN) : 0);
 
-		lso_header_size -= hopbyhop;
 		/* Fill in the LSO prefix */
 		tx_desc->lso.mss_hdr_size = cpu_to_be32(
 			shinfo->gso_size << 16 | lso_header_size);
 
+		/* Copy headers;
+		 * note that we already verified that it is linear
+		 */
+		memcpy(tx_desc->lso.header, skb->data, lso_header_size);
 
-		if (unlikely(hopbyhop)) {
-			/* remove the HBH header.
-			 * Layout: [Ethernet header][IPv6 header][HBH][TCP header]
-			 */
-			memcpy(tx_desc->lso.header, skb->data, ETH_HLEN + sizeof(*h6));
-			h6 = (struct ipv6hdr *)((char *)tx_desc->lso.header + ETH_HLEN);
-			h6->nexthdr = IPPROTO_TCP;
-			/* Copy the TCP header after the IPv6 one */
-			memcpy(h6 + 1,
-			       skb->data + ETH_HLEN + sizeof(*h6) +
-					sizeof(struct hop_jumbo_hdr),
-			       tcp_hdrlen(skb));
-			/* Leave ipv6 payload_len set to 0, as LSO v2 specs request. */
-		} else {
-			/* Copy headers;
-			 * note that we already verified that it is linear
-			 */
-			memcpy(tx_desc->lso.header, skb->data, lso_header_size);
-		}
 		ring->tso_packets++;
 
 		i = shinfo->gso_segs;
-- 
2.52.0


