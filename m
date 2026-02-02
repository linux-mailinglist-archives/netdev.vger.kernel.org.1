Return-Path: <netdev+bounces-255988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FG1Dg36gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:25:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37DD07EC
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3EC23008092
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F52F2918;
	Mon,  2 Feb 2026 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="YfMuwetT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1yPDVAI"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D33033CE
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060252; cv=none; b=P6cYNse7BGGNGrzj/5UmhTc688oyc88rNqJMKAJr3H24WexoJG0bnMebbkrFTr3Ft0NjgJxWS3oyLDuHHSvEUGOEBEYsPjYuqabxmP9FsMkiMCTM3hVr9/65fPOz9LGn9nUKQ+McxNUdJ2oqWVJUReoXF4kglrlrOX78wj9pWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060252; c=relaxed/simple;
	bh=Ba21zK+xy8whSi1uvypXiPYj/GD4rr0g9y0UmYN6QaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9ZAGQgxfJ2OcT17Hh544ine1BUgTHW+LCN2dqlmKuc4JVK3DrzHVEmoA3UhWOTv/DbKN+P3GShefGcFdeq3xDTMof714aulsmD1QSMxFvyxJ7M6mTvo73zrrDsDHF1c7+BLQWhgxKTafI4tIsxpmpeqGlmrT1N4RJc7QUkrGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=YfMuwetT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1yPDVAI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3BA1D0007D;
	Mon,  2 Feb 2026 14:24:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 14:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060250; x=
	1770146650; bh=ysWQYenW1E5JBD/ZriSc/A9baoyz8/2cvdsp8SufhvA=; b=Y
	fMuwetTzwdppMb9c+q8dPrm1qV3OV49RpZE8hdDXraVOQ2Ftt2Ay7vmovkNhWrkV
	CXE8PrVRkdDB2JtZBdgWltRo1Iwz5mEDWElze9eiBjDzfRBGEuxSGjVGMwLdN2BA
	7fTg3A+2udluTKUOCcLhHXrPaEaqdccsghUVMdfriRnSq+cipGXOjCdJJGP5zv7C
	lcDcX6AZEDHwRX+CCuW4/LpjsBr855i5s3J/vMb6gWWyP2JX7dirV1GQ00hxVE5I
	O9DU749e6tAgRg0mTtPd6FjrcnYqCgYzSWU/YVSCL7QIt4pPZr2Z4yKU1wDKnoCD
	ISZqpLEOC5/TW96nLwzRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060250; x=1770146650; bh=y
	sWQYenW1E5JBD/ZriSc/A9baoyz8/2cvdsp8SufhvA=; b=V1yPDVAIWIheiC/1G
	ggQln+00qz3XnAr3JimMQoAeh4zlBsIHeJ9rZxZ3DZ9xT18bjtujq2v4TMcttJnW
	u7WkWd9juaYJ1xruj48wkQbVIC6Ho/Jw9jaNY5v/gZo2XVaUTgaPUKwaaYWjCsn6
	6TfjRxvQkq2yJCkILS0svxdP41Tu37GIGWwLAorUJRHk5bwP0yyx6ESbV5rQ2e0K
	zJG2OrrTH2hDMeqsexCytg846VoW7jNzQ6eFbQUOCcHjYWblsbinPh+Uxn51WZ56
	2vpzGU15wNdVBjJTFeS6e3jS+lFzXP+IMjYKP0dEmvmucxgsi6D7RRl4VjXgAoqD
	8xjXQ==
X-ME-Sender: <xms:2vmAaUxguSvmuPP02TPdFNhT_83XyY7N7TgzUDmR1aNtW0ZN6hMPyQ>
    <xme:2vmAaerG7CrhBFBMKfpmscZD5Pipm6IRUUIHj-QBeWTeJwMSLHdB9BhaB2OmxKCvZ
    AVqBlYU5JxCnEd0-5_NtSZdmKQIsACqgIvgEJGJ6Yi1gIFb2nD9tXo>
X-ME-Received: <xmr:2vmAaSkPL8q8dafvpaWihfRVBEZuHOSlnGcjdj4m_uv5Q9g93K3UG-1mOM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2vmAaQXq4UpBaFRzmqCbuFJdO_XCu71j91XPxTSHxxdmthacdij6xg>
    <xmx:2vmAaeos94X74DMnmMXICTTAx9I-cs1xWpp5kPcIKDOVtMcEtKZnAg>
    <xmx:2vmAaZWn-n1mwjNlQNbIRwc4E3J1blgvVJj_YpD6a_uwc1xZpXO11g>
    <xmx:2vmAaXEbkwNrEKZGGa1gDyrwXPOafiGyJL-2q9-Tmu-E_YM3ohb6TQ>
    <xmx:2vmAaUsPupbow9u1Nc6XT0LIzg1ftd1Q6H2OHeDDxkQs-ZxGcya8eswI>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:09 -0500 (EST)
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
Subject: [PATCH net-next v3 06/11] net/mlx4: Remove jumbo_remove step from TX path
Date: Mon,  2 Feb 2026 21:23:33 +0200
Message-ID: <20260202192338.2373930-7-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255988-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C37DD07EC
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx4 TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
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


