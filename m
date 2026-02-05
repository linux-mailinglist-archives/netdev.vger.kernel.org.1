Return-Path: <netdev+bounces-257181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE7IJOqdhGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:40:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE46F36AC
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D09243008CB6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651423C516;
	Thu,  5 Feb 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="BhbgDcMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQRCoKJv"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8D23ABA7
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298815; cv=none; b=ROOq+YtMzhGwPjafVPFJMc2R7ABruhGYAYu6gU7Oy3ScOARuASK6MbATp4frDg4sco70r13tJrmuAmo1t8I7iPYvoxCEVPrxHfNyOgB43rhFWHCtaZAbb93dSSGpc1zUXEeX2n/uSRft7ViSsY/UMqT0A4IdQuwmB+kmz89iBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298815; c=relaxed/simple;
	bh=Q+mIO6qutO9lDAePgVY/e9MmKVCrRCLxB8vzQZ1HuZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M673/nODKxKqCCfswUZh+7oFWY4jdaDb1cIQ5VODgjGoQ4a26pAnLuooVPk1w548j4x5Vv365rsVGeGR4ic4hnToQXzhJ/+S5M4zf3wxoINnc6Fze+pJ5HIwLQPcaxEdoaC+gzz4n8PRl3tSy06jbL7F1MmZ693JiVRbPneBVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=BhbgDcMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQRCoKJv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EA851D0012F;
	Thu,  5 Feb 2026 08:40:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Feb 2026 08:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298814; x=
	1770385214; bh=ZH7+XW/eGCQ1cvxstzrnfu5yboqBVPHeMkzTMNxPOVw=; b=B
	hbgDcMq6PZpjzH5bLm9VR7fEyy/gVaivruIC192WSmRb3Mx0hFiPaPcQUfESktj3
	DoEDdanZNjHFfAyijG9Fic+BGenTvb2CSG+/0/4GnC7oKDO9PYj5zCulzbKwYUW2
	zJHI+pqHfvH7hBiquAfEOo9oZCHeFTzFboXI/YfG4ObFAH35sv4WMJiE4/L1mTPy
	MezjCj1Rf/lbAFjxY0vhckjOfyGH/cwyBzkGsMIlLu0rJcgr0MlacdAyfxLykgEx
	1DRwkuGgQGUpZZrFIq2Rs8UTRqiQRhg3QRFz1prqR4oKKW4kI70XJEuXRedZ/h4o
	FMgmoy78A847W2jcR4oeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298814; x=1770385214; bh=Z
	H7+XW/eGCQ1cvxstzrnfu5yboqBVPHeMkzTMNxPOVw=; b=JQRCoKJvCl3ruxYYl
	rsdY0PDeY0BZaksMreJc0fkFZxOtOepg9bG8FEfG9mpYKRcjC3toz7uhol8GXNLK
	2Rq3ivRJOzVZQc52/YRnx7tkCASJxzkkPLH8xqPmpJSfegg9DQhVwwgqfAIiUT8h
	GeMQDyPT1boimpuPTDUiAjEH0rsWTPnY9t78WRcqmH3mKWaRK3hYr28ZoLWnO4+q
	DBgV7r9/O6kKBNs8oKMjlwYk1kxHotTm9F0MIi3LfluZfaoU7ZPq6ztTTSucBd64
	K+DXVDlKa+xFe8FIzaH13XA1uCqK7u1SSs10RQjrWMRh0XQhx81R/2pTESft+Tkb
	roT2Q==
X-ME-Sender: <xms:vZ2EaXUGT_yW1v_P3rs1ved95Az3WW-0GMF0HIFnrUq0RYrYAyHkRg>
    <xme:vZ2EaVj_PlRGIryYwgMGcbqWnEFwyyrZP5JPkutsbElJWBfOa-D4fkXwsqSpvr-xb
    1EEabtyyLj46GHreZgoPV_eVzgKZhaDd_9QydJTieP1jayRzPxCIaWm>
X-ME-Received: <xmr:vZ2EaQhoyZJQ67jz7TPipPeEvZj94lzAkmIZ5MGD2PgzSrvMjDSacycRPkgz19rq2i6AFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:vp2EaTGGguMazHJ4-79DnAZ1MUGnTA_aBr9O5uoX903_MaXledW8KQ>
    <xmx:vp2EadB0-WPns5mEWKeqGmkr-EDj8z2lpMEZslJOmDVQgpXkMXuwig>
    <xmx:vp2EaZB_1zlOZZpN0b9W8wtDNe1nLEUsvWYiNJLvivwPermw9C2DiA>
    <xmx:vp2EabOj4lMl2hgJr2H4c1yLM6AE3g9QcCQGo-_owZdEsDPr6XcjvA>
    <xmx:vp2EaSw59Mcb4YHugnXgk-mWBQBXAkelOXnpedZbc-gj4CJzlFCHiJWT>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:40:13 -0500 (EST)
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
Subject: [PATCH net-next v5 12/12] net/ipv6: Remove HBH helpers
Date: Thu,  5 Feb 2026 15:39:25 +0200
Message-ID: <20260205133925.526371-13-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205133925.526371-1-alice.kernel@fastmail.im>
References: <20260205133925.526371-1-alice.kernel@fastmail.im>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[isovalent.com:query timed out];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257181-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	DBL_FAIL(0.00)[sin.lore.kernel.org:query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: EAE46F36AC
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the HBH jumbo helpers are not used by any driver or GSO, remove
them altogether.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 77 ----------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 1c2d6095b050..cc56e09525d0 100644
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


