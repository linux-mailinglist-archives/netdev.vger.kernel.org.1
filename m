Return-Path: <netdev+bounces-305188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uTRoLjQFTGqjewEAu9opvQ
	(envelope-from <netdev+bounces-305188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:42:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443A7151A9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:42:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="H MEMPuZ";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=VOi10Mt5;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305188-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305188-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BE78315445B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E99437843;
	Mon,  6 Jul 2026 18:20:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C8436BDA
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:20:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362054; cv=none; b=deABTst701tZcca5wuQLlYTOKLnJw79YxeX2v57a4Opv7vLtvGjSInKS5xm19t3xnmp3XQSVBaRrWts0PiNdhSLQwmZd4CA5EcmM/CBpEo/LygVnLHi04v405nFvS43z3ME2hNL+4YYEMDwIYz7J8tuEfh8fGD2KQ0JPzoEb0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362054; c=relaxed/simple;
	bh=BpMU/KQZxIQhJJ019dQAS3ORZw04v9Z1KJIt1fkVI2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWFe6wWvGFC+TUvDe+nBKs7BTkH85jvON/gZaRs+A1iSdeOtuXmBu4gAXWpa8ivIu2Sk8j0ah2vwMeH8UOTFz16MYkHzYcwovWrm6wE39uPJZxbAIdxIojx/T3UK5OWWltxgXuMF4qF5Vy2gOi+VZhzG9/dZFnle80Y/Z2zXQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=HMEMPuZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOi10Mt5; arc=none smtp.client-ip=103.168.172.152
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDA2F1400114;
	Mon,  6 Jul 2026 14:20:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jul 2026 14:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783362051; x=
	1783448451; bh=iezIZhXVpeSc8eAq7auxerJW6WGW3QxsYHckVvIqEJ8=; b=H
	MEMPuZdFgUFRN0TAlBs5TngMYyHlRTCzsCgxejzEeqGpwZcYCiBrEmLeLGBXS1K1
	ImO4E1kvfQOJjRF+fDrY9yiXL817obo0boPtYqKfrQehjlA0oNwnDgNZ2ipVwMKv
	j3STAUbY/CA932uEISsn2Jpcto5qv8pCKvJdJkIzOcfFDnxrBy93VvqCfRj+zHv0
	7V/wMH2Ect4+1Nj/goTBfHqZc7yi7pKOALloy+EBj3IdYaCc9G9iSnP/t7SVrSJ8
	b1DcBT2ErN7H1ZryMW7HqorDX11KsRMuDrFsYv96D27eqkfA5R2PQTqCYY4ZyuU5
	PChL0P7X3TelH0wGtl8ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783362051; x=1783448451; bh=i
	ezIZhXVpeSc8eAq7auxerJW6WGW3QxsYHckVvIqEJ8=; b=VOi10Mt5RrmBPS6ox
	2ePW1m20ZpZ6632DkEpGxo8sXiq6MNgzh7dlmGG+X7cFIZStP1Eq3d9fImGbQEtS
	f02kp/ziAEKjBmFkdkW65KWnbFA5DCzAQih0ArPi5RsPnonSE5uMK0KTMQ2r/c7f
	yDLccGzM27zbdK+B6mYon19BKn1RMXlUFjshr93In1JwXLlXLIg8XLZYI8NyckCI
	pI6W7v/rq2NgFiJX3gaAouQX/XCvXud1lXOtX3Oul5ZrDuxzV8IT6JJNR3s0CZ3g
	WlnNxo3PB+9C/mlVVsqnm10iVQ5XRw81ixWh44Okbmz4D5GZiJeRdz5V1bjYCq+U
	w7d8Q==
X-ME-Sender: <xms:A_JLagS-u9jnTVv4V0zpIQHKMUQBRql1D9nZ9membTGH2jSauIx9nQ>
    <xme:A_JLasS93XeWSNjsUugDgr6hYJRWHVEBf_Yv-9OKFUo0XcaHQj5HB-zhTnqUABLZa
    iToKrS6PfQ7YRzBCuIJKPHgWSSPshfs6smgZXsAssMdXZ7Xxfr36iI>
X-ME-Received: <xmr:A_JLakoAlKCjxCBJpEWTuO28MCk0EigJsy03XAQ1ftthDc_q3SPijU8zWTE>
X-ME-Proxy-Cause: dmFkZTEGTPv5OkKcjprW8/I9eo6u4pwgzYOjg6KFhqQqPhEcE15CLvyHfw+KtOGuruiqIO
    RNBEfkqjE6n9+N680knhEUuD69YEJHEnuIz9rN1Z3nsMpcwWxLrhFq8Y3mO7NKw8IU0Xda
    6lObyyPoWVV45JHUZI+DXDDPStMSyKm6G7gmBL/I49XwlNAfrDK9JFzvXaGy1kqeYjVqcI
    7dmMZaut61MQOINjUZvHvPGjhzlZQt1yHbk9JExXHi4aAGmELWRRwleBjY7O4shNeF472R
    iV0vQw/w1/u72oscJfGNj5WiGzXLuavT9H5l8k5y2FM5sILMEpSAYwjnjAGUg6Papuu7Qu
    gVST0p/505JW3VYbFF8kgszCI7KPobOKXlZoZ5oEnAmQsScQF2EQcee/9RfAI+RovL5hAI
    UsBv98sIUn638+ow8es2MSL02AbPCsMDL4FmtY05zIyLMYVz/bze3/8sb5br1E1VbGm4rU
    QNlDirgNgDewi2dOsPI+nIOPIV1gE0VVOVwE0n+4z/rzGW3vOpRrhm7DJBbfITlC/9hspC
    mX3fZtEsb78OWIfuYad79IQoYZ7qBosaGIOcEZwxDY/gkHlEQfRo9l19RCGlDbsWFURL1X
    RwJXG5llta8aa47qMND0zIQx3jZclkt/WjCIHDqYusjOYMOGkG8rPMPBMyaA
X-ME-Proxy: <xmx:A_JLakDn5Jhv2IFAbHya1xke-HEsofyfps8qDgjBodjdtgrK19Hv7w>
    <xmx:A_JLahs0OUBiBrdTf3YBS1QlexekmA0_voIqwU1IS5h7brRWL_ozDw>
    <xmx:A_JLarbvR2yxRzKp9lWpG42Mab0ENE4gZNnvLEqWwuIYsNMzKAlmyQ>
    <xmx:A_JLalGac2p9VEOBlNfwONFxsVhzQsm0Gpjh9EX3nerRE5XbQtjadQ>
    <xmx:A_JLatMF5tATv4TVljtXfxm48LMQwmmlOsUSoLuP5z2d68BO4mrN4ocs>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:20:50 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v8 3/9] udp: Support BIG TCP GSO packets where they can occur
Date: Mon,  6 Jul 2026 21:19:35 +0300
Message-ID: <20260706181941.385672-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181941.385672-1-alice.kernel@fastmail.im>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305188-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1443A7151A9

From: Alice Mikityanska <alice@isovalent.com>

Wherever a GSO packet can occur, and its length is used to fill the UDP
header, use udp_set_len that assigns 0 if the length doesn't fit 16
bits, so that the packet can be properly parsed and segmented later,
instead of having truncated length.

Use udp_get_len in udp_validate_len to treat BIG TCP packets as valid.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/fou_core.c                    | 2 +-
 net/ipv6/fou6.c                        | 2 +-
 net/netfilter/ipvs/ip_vs_xmit.c        | 2 +-
 net/netfilter/nf_conntrack_proto_udp.c | 2 +-
 net/psp/psp_main.c                     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index a50740d0f288..aef3ce1dec7a 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -1040,7 +1040,7 @@ static void fou_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 	udp_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM), skb,
 		     fl4->saddr, fl4->daddr, skb->len);
 
diff --git a/net/ipv6/fou6.c b/net/ipv6/fou6.c
index 588929409241..4b659ca60ba9 100644
--- a/net/ipv6/fou6.c
+++ b/net/ipv6/fou6.c
@@ -30,7 +30,7 @@ static void fou6_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 	udp6_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM6), skb,
 		      &fl6->saddr, &fl6->daddr, skb->len);
 
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index ae3ed2c00ec3..c51ebd83a476 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1100,7 +1100,7 @@ ipvs_gue_encap(struct net *net, struct sk_buff *skb,
 	dport = cp->dest->tun_port;
 	udph->dest = dport;
 	udph->source = sport;
-	udp_set_len_short(udph, skb->len);
+	udp_set_len(udph, skb->len);
 	udph->check = 0;
 
 	*next_protocol = IPPROTO_UDP;
diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conntrack_proto_udp.c
index 8a5675983e7c..a7edfefd6fd1 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -45,7 +45,7 @@ static bool udp_validate_len(struct sk_buff *skb,
 			     const struct udphdr *hdr,
 			     unsigned int dataoff)
 {
-	unsigned int udplen = udp_get_len_short(hdr);
+	unsigned int udplen = udp_get_len(skb, hdr, dataoff);
 	unsigned int skblen = skb->len - dataoff;
 
 	if (udplen > skblen || udplen < sizeof(*hdr))
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 90c7dc4e76a1..c9c1a8826b7f 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -231,7 +231,7 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
 	}
 	uh->check = 0;
-	udp_set_len_short(uh, udp_len);
+	udp_set_len(uh, udp_len);
 
 	psph->nexthdr = IPPROTO_TCP;
 	psph->hdrlen = PSP_HDRLEN_NOOPT;
-- 
2.54.0


