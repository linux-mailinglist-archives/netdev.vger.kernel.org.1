Return-Path: <netdev+bounces-256199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDuWIma5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CDFD6836
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1F8F3006205
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C11B6527;
	Tue,  3 Feb 2026 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="eKCjVQH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCeIfrgi"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6892C1584
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109247; cv=none; b=WgY7jqpASolg48qIJxZXp46HMA0gLwCg7nsv9pqsvJPkqa4zqN0LpvIQp1Bv9u/V1SndGRTU7wdxoqHLz0aIm5FPB6ZWTZpXvSvMBEfReroLLigczTurFtdBSJVB6X16t4qHBvpIr0AAaQWgnRApGt+ysnLwJ7MVruj+u+3qQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109247; c=relaxed/simple;
	bh=XfBbUtdeCOggmzFbfGPly0dwGJZ1OAJ7o89hXKkLigQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy6R8ZzKT0Ci1u6fPKOGnbFlEhTYQW+Gu/uZD6UhnsJG0JB4QBF0H041Qr99ceiLWIbxmUrz2zMCiieRfMxci7H503cATBQNceEvcRJHhemSYUU0SAtY++CWjAWw4o6VieATezIzzGe1XHPVTH9olAbMfibBXpWjmFlJ90Qo67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=eKCjVQH+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCeIfrgi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 344AB1D000E1;
	Tue,  3 Feb 2026 04:00:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 04:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109245; x=
	1770195645; bh=rGfOmO6KX34ilrrYaNc0cDucv8I4Mz/2rVVgkjb+kdw=; b=e
	KCjVQH+wwLBeYKekPrwjQ5sSfyXLl6KvCT+tl+TElBidsc7bgyDL65/VA5/g4V5F
	GsRvt+tml/3CmtKDV/4YtrhWJ2cCHgwMNGTHmCVc5vF9F8Vspw7u7EAaEIZEvWG0
	sIvClkxD/xqmVER+I98sSESJByvRTIje96TOw3c2v65H6YBJG6pcikKdYdtjhaCg
	nq0THfr6UJ2Z+4RT052uh/AwbYPF1tnu4Wbk/Zs2nEFafKS74l5I4n5bbMK4jNtj
	XA+5jX1UmAmTrkk3k+BrD5to15PtK73cv0SW32UeBP1xugl/1qdzlPixw0XpZaZL
	+0M1+KCuuW1tK/N/65/HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109245; x=1770195645; bh=r
	GfOmO6KX34ilrrYaNc0cDucv8I4Mz/2rVVgkjb+kdw=; b=UCeIfrgiz3ZbuNrtW
	Pz/ian6WtSPwa7wkowioR0HDHppG/CfMnipVwVP2g9cqebsbgNqPnImpN2ywBPUB
	Hk7g9FNRhGYZ4Pe68XeFSSuSkO81vueLFYN2hYT+3PNdfaqh7iZNhQUWOrV7MqdD
	qqIN172nSeXhOxDnqC0ti/o4d/+hkFIcfniJzGFChhDKrdGO5Ls8mjWUN9AjEF2v
	T1ty/2myK4jU0KZ4iy1ayN9tPg6P4Qp0G1AXct0l2jCczIKsKtwCS3aQqeam299M
	+yzloEf7aZGH0IxsP5VQ345UkRvdmJrlkmc9FtZ1apmJptOoFCdnMi2z0RNAfjOF
	jlCYw==
X-ME-Sender: <xms:PLmBaXTI0aG_EapjuCS0KNFt3suUZ4ZcB6zcAdjkyFlmV4Cd3OYxAQ>
    <xme:PLmBafIPxRVoRLKbEDdU6xCvMalvRJGIOI9AS3bnufD_md-0JUGCYbuGaq-zEpMdv
    0zzDAIAmHr3dS7vMOB_irPhTvHB5c0DzoRjicEN_d59r5q6KYojELs>
X-ME-Received: <xmr:PLmBaZFXQ12MRYk5o45Btekb6KT3vz5LJuymfNtjiXLIjELkuHAAz1nWGVe0>
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
X-ME-Proxy: <xmx:PLmBaU0uchPoSxjnocJOkNGT4ZKhTeRVdZeTpOFDTfVK3gT0PU2x9A>
    <xmx:PLmBaZLvHOu5DLwI82so--mU3SLimj4JSM6MpYOIQAmJPEXa7K_FdA>
    <xmx:PLmBaR150Z4O7cTX4FlfgmY1P6UGHEnejlVm8mn98jyHDvpf0YA1-A>
    <xmx:PLmBaVmCqhhpNkk_oKcZsPUrNTvZLXtl9vnWGI9pJMA7KQMm0CjU6Q>
    <xmx:PbmBadP9YXnMDhjM6G7p67rC9w_-2wn27H_0pl58zfGH2YgtLdpZxdX->
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:44 -0500 (EST)
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
Subject: [PATCH net-next v4 03/12] net/ipv6: Drop HBH for BIG TCP on RX side
Date: Tue,  3 Feb 2026 10:59:33 +0200
Message-ID: <20260203085942.2477583-4-alice.projects@fastmail.im>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256199-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:query timed out];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17CDFD6836
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Complementary to the previous commit, stop inserting HBH when building
BIG TCP GRO SKBs.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


