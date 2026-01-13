Return-Path: <netdev+bounces-249600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A5D1B662
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D6330124DA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2A329E4E;
	Tue, 13 Jan 2026 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="VDXe/1sa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NtHlG48+"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E8346E5D
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339686; cv=none; b=GpgrZYvKbSOGhFYuEjID5MRzZP51UbCZrtpZPGmCemfn2wHpBflVYgQpcRo8Gix/zWq6BG+6CAzpEMUxwyB1BTy8d3O61E0hPKE/UshtVeY0sEADyMuL71RVQkVi//3ipNGCTVuGe0w/jshJiDqQXMwZXbUOk41AO/7iT7bC37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339686; c=relaxed/simple;
	bh=HmNZZHPnu1GpLH5DOlfNw1WkySlEL6fvbagz8JYkG/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiHDfZTtKknfkCt0nnM2/bfoed1/t8STZ/9/HHSySuSdxJMt/ZrYzFmtAg7PMol44EbrL0Fx+o9AP44pxk6m0nedMh11ImPliew8ABqYRSMYNrxZhUwhNOUHjgTdde4OKyaOYqLTO1RLd4k2+km5TiHDnIw3rklIynXqme+AbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=VDXe/1sa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NtHlG48+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 000CC140011C;
	Tue, 13 Jan 2026 16:28:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 16:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339682; x=
	1768426082; bh=5g5pifFRiK8bhQWxl12/uac4Ak48MuSG5XI8vK1p3nU=; b=V
	DXe/1saCl+g0Cxyg4keCeg2al+O+Ld+Bgoz3VOVbrEHxhLAxsoyo+lQmYsn4dphe
	lSQxNdpOSbaEZbemrsVyPkxoBGgPgYTc+OQnG62hl7oggHOg5PZp+xoD7N8/gChb
	Z5hlqF1ns34gd7H5DTvco2mqXOaGT/SRgD1gEZCtBYH9U51qhGaitbkM4oo3WC3G
	72BP0Ctf6llpmsIxScAG68bE+0tVcqe4j6aIvS3wcY8/p/eK7w7bQnCbZCdOppr8
	XpqpxpGWeL9jHJ5qqOPL5eNXHHZst4ZtVM0A4cfGw7rVvvF/8Rl5ZOJMD2R51gQV
	lllBJe/X8zFyF73tAqcww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339682; x=1768426082; bh=5
	g5pifFRiK8bhQWxl12/uac4Ak48MuSG5XI8vK1p3nU=; b=NtHlG48+P9ow0pADY
	tD+g7SKeFvrmsUcndLfG1W4JlEeiG+Xlwk8EX/OWnKiC94zRYaODfNAzAleAdpcH
	BUpFvIB6gCNNYCIhRGE33TfmGuGQta/Zt9S1ouA8ECptQaT4WNC+C3WAFPEdRhJh
	0DDPdAaVYXALD9d7zgwzzZjhLImWTGlAy8ydXVLIcBBDqlqQTr4UvSMUSqpxb/V4
	UWLAsY/QXXRtQeS2hgwvPH7ho9furwMj/Suow4DVdcyrIqf+LYEzBo2tVcniyIew
	Qvx2pT56JHZraI4ODaxc7GOUJxHzXWh/1CsRclotjkr2adHjcuR+0Hu3tK+Rg2X9
	tXu2Q==
X-ME-Sender: <xms:4rhmaSERChxUW8RWrXkvI7ZFdAiTGVelUbpHTZnCuPZWcnNWY88pBA>
    <xme:4rhmaZtvg7Y78Ul-m57r0B-vTdSoa6X9T9Qo8fhPh7vEBmZguc9SksicWdTqqUN67
    Vy2X5JoRfuUWwOOo8TNwSRKZhmTxyMxBs_hvN0TSU3MOBN9VfEOgg>
X-ME-Received: <xmr:4rhmaYboD5ZrusVqDvg9gnnNMlXnWTHwTnJOb7Bbvk823Gq2btSXZf-mGp_gc5KtxB87qpQGDsdZTs4-l_a3j3OZ>
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
X-ME-Proxy: <xmx:4rhmaZ4EpCSCsDzgtQIdHi8V2USiCS6WPzpDvai7tWNo76_QChUawQ>
    <xmx:4rhmaQ_2jdRe5AU5nVhZDjcBBwv59-NlUO-cQIb-jHc5XHdo2YzZnw>
    <xmx:4rhmaVaKAfEQ-ZMcgKNXrRQb9X881EMeGINTFpefiIXnrsDZoRVw1Q>
    <xmx:4rhmaZ4NJ5VxidKQ-jolpkbOrBXSJoBeJihiXiQg0OMTZdFMR0vA0A>
    <xmx:4rhmaaw_kLWqWMtGkjFvHfPMxXuPbxLONM3POYRbYK4KT0jhrtBJd1Ns>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:28:02 -0500 (EST)
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
Subject: [PATCH net-next v2 11/11] net/ipv6: Remove HBH helpers
Date: Tue, 13 Jan 2026 23:26:55 +0200
Message-ID: <20260113212655.116122-12-alice.kernel@fastmail.im>
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

Now that the HBH jumbo helpers are not used by any driver or GSO, remove
them altogether.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 include/net/ipv6.h | 77 ----------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index f65bcef57d80..e697e5fd5fc1 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -149,17 +149,6 @@ struct frag_hdr {
 	__be32	identification;
 };
 
-/*
- * Jumbo payload option, as described in RFC 2675 2.
- */
-struct hop_jumbo_hdr {
-	u8	nexthdr;
-	u8	hdrlen;
-	u8	tlv_type;	/* IPV6_TLV_JUMBO, 0xC2 */
-	u8	tlv_len;	/* 4 */
-	__be32	jumbo_payload_len;
-};
-
 #define	IP6_MF		0x0001
 #define	IP6_OFFSET	0xFFF8
 
@@ -462,72 +451,6 @@ bool ipv6_opt_accepted(const struct sock *sk, const struct sk_buff *skb,
 struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 					   struct ipv6_txoptions *opt);
 
-/* This helper is specialized for BIG TCP needs.
- * It assumes the hop_jumbo_hdr will immediately follow the IPV6 header.
- * It assumes headers are already in skb->head.
- * Returns: 0, or IPPROTO_TCP if a BIG TCP packet is there.
- */
-static inline int ipv6_has_hopopt_jumbo(const struct sk_buff *skb)
-{
-	const struct hop_jumbo_hdr *jhdr;
-	const struct ipv6hdr *nhdr;
-
-	if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
-		return 0;
-
-	if (skb->protocol != htons(ETH_P_IPV6))
-		return 0;
-
-	if (skb_network_offset(skb) +
-	    sizeof(struct ipv6hdr) +
-	    sizeof(struct hop_jumbo_hdr) > skb_headlen(skb))
-		return 0;
-
-	nhdr = ipv6_hdr(skb);
-
-	if (nhdr->nexthdr != NEXTHDR_HOP)
-		return 0;
-
-	jhdr = (const struct hop_jumbo_hdr *) (nhdr + 1);
-	if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
-	    jhdr->nexthdr != IPPROTO_TCP)
-		return 0;
-	return jhdr->nexthdr;
-}
-
-/* Return 0 if HBH header is successfully removed
- * Or if HBH removal is unnecessary (packet is not big TCP)
- * Return error to indicate dropping the packet
- */
-static inline int ipv6_hopopt_jumbo_remove(struct sk_buff *skb)
-{
-	const int hophdr_len = sizeof(struct hop_jumbo_hdr);
-	int nexthdr = ipv6_has_hopopt_jumbo(skb);
-	struct ipv6hdr *h6;
-
-	if (!nexthdr)
-		return 0;
-
-	if (skb_cow_head(skb, 0))
-		return -1;
-
-	/* Remove the HBH header.
-	 * Layout: [Ethernet header][IPv6 header][HBH][L4 Header]
-	 */
-	memmove(skb_mac_header(skb) + hophdr_len, skb_mac_header(skb),
-		skb_network_header(skb) - skb_mac_header(skb) +
-		sizeof(struct ipv6hdr));
-
-	__skb_pull(skb, hophdr_len);
-	skb->network_header += hophdr_len;
-	skb->mac_header += hophdr_len;
-
-	h6 = ipv6_hdr(skb);
-	h6->nexthdr = nexthdr;
-
-	return 0;
-}
-
 static inline bool ipv6_accept_ra(const struct inet6_dev *idev)
 {
 	s32 accept_ra = READ_ONCE(idev->cnf.accept_ra);
-- 
2.52.0


