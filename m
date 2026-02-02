Return-Path: <netdev+bounces-255985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALQvCPL5gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515BD07DD
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 037F13007298
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90064301702;
	Mon,  2 Feb 2026 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="S4rAQnkV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3r5XBOV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74B3016F1
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060243; cv=none; b=ihHzD9mmaW5TcuFebeP0X7Pk+qa+8G+dYOFb2x8QNKkNHUqTteJoO6BwUKuwKbVk/LDYZgv1F5Nw659odjBOce567G6AYKYXeC+Mh3i08IxoNI/n34JUWj15TzC80rkEIAQ2Icmk1c7NREnm6c2lUVXQqEdZHcARjampWt/QFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060243; c=relaxed/simple;
	bh=uTnmPqYB8vb4TgaFRVG/MjQMla9jEuZ9rLNIO/B77ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+Yp9B88RQzn8shkNWpaiepAqWssLf44uRvBeLAZ6kUamB+vvw8HiJXjD2fX4KTw/N7GQDfqYgmAYgfrgiMTf9Jpc3KNA7SQk6Ioif5asxlAijXd8k09zyzcyZ6CWTOMgGA9uf8Q3T8W9Uu4WIqD1YjUU5fyUmPN8kSHaZ1U8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=S4rAQnkV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3r5XBOV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C3121D00072;
	Mon,  2 Feb 2026 14:24:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 14:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060241; x=
	1770146641; bh=CHW4sFQi/AriOIv/3qGgI+2p5nmlNqpXyTdv9aIgmwM=; b=S
	4rAQnkVQkfDpfkejRcOO5UGRHEdbq0m0TIbAzYYRD3pwnf88hrYIhCAX7Fhi8cdU
	LgJV6icjc7bRda6H6Xa421eXY7h9hMLlqBwjIEvCaeMKfYwdle2D9ofBO8ToTB75
	aItSDlTW1ESYsX+3GVJ2eEfYSQXt6imtR2rDLpx84kQOw9TK0f+hdUB0fJ1HDHU0
	eqMYD7taZChLr/3PHz/QRLAvrYhXm3xOQy5wP7Bmffx1ocaH86j0HBTo5LfNu8jO
	h4tRof0wxXEClx7wPwxYNU/FJVKlAT2+6g0tH4jETSYjw50nmBJsBSeU5GCextum
	aH4Yq2SDNJfGntErBb/gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060241; x=1770146641; bh=C
	HW4sFQi/AriOIv/3qGgI+2p5nmlNqpXyTdv9aIgmwM=; b=b3r5XBOVyuD553AW6
	29C9E5gRY2/SbQ3LrWR4usdZdjuDTFm6DzaouvYSSXe0QWT/kPwaONGzpMw72Ex4
	MLwRLoAvlJEyHLyYv1iP5qMv8NOfn63JuNmgeYMSwIA7dbrGgwV01KyvQLz0mmQ+
	XbxS43YMO6wNEiCeU2UIFSD/kvmucMHqjKRtGVOwT2VilbDYBwlZnks2LR35qQKS
	K3Nl4Ft47QAY3+y2jh/xdcwTmq0RD3GsPplu+BXSIuDP3KK22W/bc+QHpYOLu9Tq
	ee6CTGcMkO56Ho+gQ7xkNaqvExfbbwGxsO/SRkJp5BvjGI3y/NgvQwVGJO0Rx8ND
	ZeI6A==
X-ME-Sender: <xms:0fmAaQBErPX09OhtumrWihzGzFOmvnCco4zaXT49RjHP_OZQVLbibQ>
    <xme:0fmAaY5y22G-BP6YVjibneBIouTs4Alzr4DbkdgN519Um0Kns-dgf-u4Z6OCEGsFW
    c9Qg_Cdtn-jL0KfqpaCtqMAdgdNbZr5nYrskyscXPEijC7TkgMgmJk>
X-ME-Received: <xmr:0fmAaf17Mw-5zJHNpP2Wh6YG2KUlIeUvYj-JV_MKLNDyl_799lfkH8j0LVE>
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
X-ME-Proxy: <xmx:0fmAaUm4-tI7fkkgNSiWme_4d_LOeQpaYDm0F14jleqkoNHEF6lqnQ>
    <xmx:0fmAad4XiOCxyLrZNnyW39Y2xfD2RiYVBj9Ut-cmgyKeKJZW2XqLzA>
    <xmx:0fmAaXnptXHw-jRPKH6tWxVCEAAPFAeJ5oovI_Hdz1bk42AzQ910RQ>
    <xmx:0fmAaYUBsX3iJW4z-tKktxlk27WNVHlVK7xU1GbKAka-SihVh0k06Q>
    <xmx:0fmAaUHNYgV7El3ONzSdpUe0XGNk31-mQQYvIJ7CJb03r1diYSzPH1gK>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:00 -0500 (EST)
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
Subject: [PATCH net-next v3 03/11] net/ipv6: Drop HBH for BIG TCP on RX side
Date: Mon,  2 Feb 2026 21:23:30 +0200
Message-ID: <20260202192338.2373930-4-alice.projects@fastmail.im>
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
	TAGGED_FROM(0.00)[bounces-255985-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 5515BD07DD
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Complementary to the previous commit, stop inserting HBH when building
BIG TCP GRO SKBs.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/gro.c         |  2 --
 net/ipv6/ip6_offload.c | 28 +---------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index ad326c7cdc0a..2241d9c2c140 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -115,8 +115,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
 		if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
-		    (p->protocol == htons(ETH_P_IPV6) &&
-		     skb_headroom(p) < sizeof(struct hop_jumbo_hdr)) ||
 		    p->encapsulation)
 			return -E2BIG;
 	}
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index ceb4752a5358..c44bb5812484 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -336,40 +336,14 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	const struct net_offload *ops;
 	struct ipv6hdr *iph;
 	int err = -ENOSYS;
-	u32 payload_len;
 
 	if (skb->encapsulation) {
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
 		skb_set_inner_network_header(skb, nhoff);
 	}
 
-	payload_len = skb->len - nhoff - sizeof(*iph);
-	if (unlikely(payload_len > IPV6_MAXPLEN)) {
-		struct hop_jumbo_hdr *hop_jumbo;
-		int hoplen = sizeof(*hop_jumbo);
-
-		/* Move network header left */
-		memmove(skb_mac_header(skb) - hoplen, skb_mac_header(skb),
-			skb->transport_header - skb->mac_header);
-		skb->data -= hoplen;
-		skb->len += hoplen;
-		skb->mac_header -= hoplen;
-		skb->network_header -= hoplen;
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		hop_jumbo = (struct hop_jumbo_hdr *)(iph + 1);
-
-		/* Build hop-by-hop options */
-		hop_jumbo->nexthdr = iph->nexthdr;
-		hop_jumbo->hdrlen = 0;
-		hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
-		hop_jumbo->tlv_len = 4;
-		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
-
-		iph->nexthdr = NEXTHDR_HOP;
-	}
-
 	iph = (struct ipv6hdr *)(skb->data + nhoff);
-	ipv6_set_payload_len(iph, payload_len);
+	ipv6_set_payload_len(iph, skb->len - nhoff - sizeof(*iph));
 
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 
-- 
2.52.0


