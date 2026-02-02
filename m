Return-Path: <netdev+bounces-255993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO6zLo76gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:27:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC292D082A
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B42F3014880
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E23064AE;
	Mon,  2 Feb 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="DJEOUclV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ybf0y/ky"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B79305064
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060268; cv=none; b=p9/4PIUIyCZs2oOssFjqvVLUXpispudVcy8sqhM0JEPds+piklNjFfSbsYq6ocsRXLBA5mm5n++sCDlL4dHbtV7W0724ZitlBOheSeZVD/bMEpVsFT7jcrsDrnCW3q5t4WWP31YXL62bR/52iHkmrlM7m2RkVgUhyLxc70K1drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060268; c=relaxed/simple;
	bh=VgVO28xCcdCLk3XjS6VgS/UCx90P5pmFqJwSQHVirdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2H0AF2HU462RygbUeMm61HtrRe16ov5BW92gsFSt3YRV98m6RuPhqlRHaRtcA8Xu9O88CnPvAm+vVxLlYRtObjNFv4BRcgMgLsHnikWblz5oOwk6RCswEwKW4hhCHTqJbNMBqIB/PFgZDK0c3TLLNdsGhjG8O1tGUECgjvgRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=DJEOUclV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ybf0y/ky; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 294311D0006A;
	Mon,  2 Feb 2026 14:24:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 02 Feb 2026 14:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060266; x=
	1770146666; bh=OwhRt3wnZ2tKo2u4sJIwTKA7+lFyKDfZ8+RHd2/QFjg=; b=D
	JEOUclVp0NG0DpTnEUl8WT8eeZJbDp3OTfzM04JQ9HqtlEVRmLlHzlTkTqGFuCvt
	ButWbhYl3BhQWuz0R7dGW846g1cuwYg8oSFEpd8s1o4O3jhAimChoWLfY+YfaK64
	N4P11H5qG07pb8ZFNNDsaVSxhV61vloNvNYl0VH9Tj40NJEJUJsRDW1D5Hqw2hRX
	4SpO22apZ1PxMBWc16CGN2eOG7v5sCddJzm92Zgw5E4E4AajZZP/UPU/vvjW43Y4
	vYFAy8qH8zwS1d2QdCyliR+Zk0Z/vb6gadKzWxBKKD+hHDGS7uuQF+67WhFe3VQo
	5CN+0KiQqlQfpTC50rMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060266; x=1770146666; bh=O
	whRt3wnZ2tKo2u4sJIwTKA7+lFyKDfZ8+RHd2/QFjg=; b=Ybf0y/kydoVvKIiPR
	TqpfEhryldeRJN+Udhk9azH2NGf1d+qff6Rn9sJZuaoO8vdfYq9HYirMrS1JgCkD
	Vfam0fAN8uylKAN/mE8MK0eOu/Vkz+b3T3Fu/e2XJwJWoUpHDenSMPNnuWOVfXRS
	397oFlbtL2ozmVaxjjiqKcqdIvzhd5uQjAS/YWT+anG57O6r3Jdo2VDBaFgX+QiV
	+5dtLcvHPXw5FOkgdJMzaBfKb7ck8KAYZfbNMAhh3yvDYzv27BMh4OkP0X7eejN6
	sW9ycfIr9XdYRdJefxvsy6C0eYK0AIJ3+ljiizBG/xnmh9EHOiKrRIHniTtNxxjC
	sT/qg==
X-ME-Sender: <xms:6fmAaWnNV4g-U90cjNaFQzEtIWSxM54UHRYELE4XlToKFx30yLs-AQ>
    <xme:6fmAaUNKJa2HtshuHYLGg8-l1kMN3lL2kO6ttoy3ktbvwvQD_YWQ3zFhtSB7oMUPN
    ovKX7XVTaZXe8Eyo3ctgW3zPOVOwizM9ytD8Wl_tjQnXO65n4dVg78>
X-ME-Received: <xmr:6fmAaQ7yTEZqbugTHv9vB-bnPKFFp6ZMzko7kMGIyJ7HLJTszQhKrtSzTFI>
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
X-ME-Proxy: <xmx:6fmAaYZDkb75Iv6omnQF6Pt6XR9bghe0K-VayVOPg7fmwD9Y5u8dRg>
    <xmx:6fmAadcu9rJncKHHWeVZk_QR9ZmWc85D72E32aNMAeWEP9o7iM7Qmw>
    <xmx:6fmAaX5nxQ5YuQ7KC_Ie6G4Eyvx9dsy_bUnJwvtZl5QLBt4OmRYOfw>
    <xmx:6fmAaaYnHsv_00m-kuuCbvHg4bdS1XVXrJkKBHjLsrPOhZ5SCvXDBQ>
    <xmx:6vmAadSdWN9YHAPMUyw5IMgm-mgFoejvbDo32cerP8lhwu4OCjn6Mdhq>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:25 -0500 (EST)
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
Subject: [PATCH net-next v3 11/11] net/ipv6: Remove HBH helpers
Date: Mon,  2 Feb 2026 21:23:38 +0200
Message-ID: <20260202192338.2373930-12-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255993-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: DC292D082A
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the HBH jumbo helpers are not used by any driver or GSO, remove
them altogether.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/ipv6.h | 77 ----------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 024c2c2784cb..16bc7498c329 100644
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


