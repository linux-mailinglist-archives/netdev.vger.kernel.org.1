Return-Path: <netdev+bounces-306571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jrXmCAL4UGrS9AIAu9opvQ
	(envelope-from <netdev+bounces-306571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4073B65B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="X q4C/0H";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Ihd8teGD;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306571-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306571-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB6FD307EAC3
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEED420E7D;
	Fri, 10 Jul 2026 13:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476B425CFB
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:43:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691005; cv=none; b=cnM249u75DCKprnZkiuIOvsSucrdBDmiCe4htcAn4P+tBPhWz4kdmFL8rlKp/d4gRCi+jOgdAmTaNH3oH/riVWxPuJGoUuSLYJ2Ix4otGMpYVeXSgjoR9zRqBO4CRO91PpeDW1NPfyENlO14qn21xBJgqPuktfvvkKk7TVqP8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691005; c=relaxed/simple;
	bh=4cLp3Nd9t/h63ncK3R8vGWIBlvjRKzd2ACmlTxtnpx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnwVCLsKU6u7wD1LgnkdVLsfeSOeAVAtGHHGknzcT8kXZEb0uElUbctE2A15CacMtdN0VSOrQv2jmpQIQVIRARRLhWI3AutXRKo9S7uMPG+uHwNrCdTxR9fzMauajGqfESw69m/IGIkEtApqbGLqWF4JmCJUik0Ew5Pqcw6sY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Xq4C/0HY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ihd8teGD; arc=none smtp.client-ip=103.168.172.153
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DAB81400114;
	Fri, 10 Jul 2026 09:43:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Jul 2026 09:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783691002; x=
	1783777402; bh=rZycrF6WDGMO95sKOxHtdI13cNDx2yfbCfkeAW9bNyI=; b=X
	q4C/0HY2X/MwveSEKOC9iYKs5WA2OkflqewtgSO9ZG3n47PAONevcJgMk8kJfUkx
	3Zl2ljQK056lb5Rxfrk5ug1kg2kBrws3DtDZeVZyyynXIUtM3zeOkelEprtyg11n
	xIuo8N3WGAR9NMrzjUeMvpw0x3tG0NKgqFPvkYyWzW5a1Ee3DX48tHCVaiumxKUk
	g0Y54UcWC56Y0TCM2sDnM/QjRZYJZ+JfY0UGGhdGHowl2zDLuXdPnY1B/tnJ3Sd9
	HVUmUvIk+Jr8hei9evD4lZFs9p6bhcQlvrj5IH22h+2jxL9YCuoAWU981Ev8+T0T
	rOnvoKCFd0yzLaZgeIKoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783691002; x=1783777402; bh=r
	ZycrF6WDGMO95sKOxHtdI13cNDx2yfbCfkeAW9bNyI=; b=Ihd8teGD9pKkUAoc8
	E719HrBPaevI9otaiRL5M0ZwgguG2uzwFEt3mq5rgJlaeO0sNr+tSIVhyV+xTJ6O
	C0S6bgcpVZWjCaKUlwsZIyB5Cqw1sRjLeDaMVeqW5KYr+dejwMBt1zXZTm+xKGIa
	wOiTfQsK97NmkOCHHoZkGqA2zDoaU2ipimqqsLK2pjdF2iB258qT6NmIV39pl0Ls
	DjRqyZ4jowBZTg5us+4sw4IbrARhGdalU6ukXzcmmRrbLYpm7GB2i9Xg/iYx/0Fn
	jKnvFniEz7i84DLes61ufxQz9mIhQyc+B+GMGK/1Fkxpf48DZ5cqlSzA0WfadKvc
	ljHWQ==
X-ME-Sender: <xms:-vZQav5D4XunuQiP4BmKagnX1ex0STMe0uYqZwUPVdkRAt4Az7GVFA>
    <xme:-vZQajZlrvNvmWfSVdNqC1JgUEilJVqLRxLPo-tV-6j2eDRouXS_J-nsn3-F5svcP
    _NPPzrsfQBs0WisnnkBm1Gv0wPxFmbHL9UetGXSMCS-F0_PXJh8uQ>
X-ME-Received: <xmr:-vZQatS38wctL-z4gFVZ-DmAdmYe17rklEsafhTvMV7e1qq7HDjhAo2uKTfGb5owEQiGXMJAAH3Mcyx2KIF7ivd9Ym9hewtVcFxx7g>
X-ME-Proxy-Cause: dmFkZTF72YfS5r1mylfmIlm4FifvbvgC0eZx86fs9AXzgUCHP73ulN+7kC910SC0JbsRIb
    /+BXN/YV1fze9RMM8yLB0XnGM3WKuIlmk/D13XAvMZEKZRgWju9AjyUhtdpPo+zoqIqJGy
    UrGDMHrrAAZCjPwYOc5VrU7zwC+c9eLuV6hSL2JEDVU/15D+g9/gf7mOupw2OQao2JotTG
    FVUl0ZFORUdW6me0RDUNotRzg0ZFbe4bevzSnKqmepRdXNqJzEfvW/a9PV/Ll6KIZley+T
    BnO+ae8TeN20Efco71q2aOf1/WXo0BWkQMIvx/WDpt6g3j6Ss+IWtC0FKFfpI2TWtXRYqm
    bvBTr21f3Gkv6WpWFKjC2fn+7SVHupskHPEaG0fiHZAnoOO2T88NcrfXgc4vMT4wt7qc12
    U/N/hpwMv5YfCHNfUmi7zZ+PTXKQt1Fk2TVHnf0w5RxuX5R47oVIWHjN7BnTSmIDUVjM4k
    oGaCR9pC+QN2vD0MjBROUuYFrCsk2w3Bk89td7rN3sK8HkpG6gXkhG+ZZ6PCTTEqflIElR
    5SutScjwARkwfcCmJ1yprTlt1c3Z4Xs5VoKGnlrWRGJDrgNtV2PZkZ5GZgfavGX+vyegvS
    /5EATEVgCVQIS+d/aOF9C1up1LsAEdztMYViihGzWnyoWVliBTMQMY99TxwQ
X-ME-Proxy: <xmx:-vZQagIJxHpAH2ihvLaiPtNfPHak1uL6Ka7L73obMdk9M1sPnSB8SQ>
    <xmx:-vZQarXfZj-S4aViginn35nhck1OjUikqSzhtea2PmX-UQwwONzu4Q>
    <xmx:-vZQakhc3thzAcedxaZpkihrkmGJZ5vSNRZ0W1HVNZiHSxsas_tF0A>
    <xmx:-vZQansAo34IebRg5ChzMwYIz_um4DG9t5UWsj0qVXZtIl2WrliNAw>
    <xmx:-vZQalXvGXVBf1ADbmQ43YCCmuR650Ysrd8vchFnLkTMHf38oP7wFBBR>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 09:43:21 -0400 (EDT)
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
Subject: [PATCH net-next v9 4/9] udp: Support gro_ipv4_max_size > 65536
Date: Fri, 10 Jul 2026 16:42:37 +0300
Message-ID: <20260710134242.216538-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306571-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,vger.kernel.org:from_smtp,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82C4073B65B

From: Alice Mikityanska <alice@isovalent.com>

Currently, gro_max_size and gro_ipv4_max_size can be set to values
bigger than 65536, and GRO will happily aggregate UDP to the configured
size (for example, with TCP traffic in VXLAN tunnels). However,
udp_gro_complete uses the 16-bit length field in the UDP header to store
the length of the aggregated packet. It leads to the packet truncation
later in udp_rcv.

Fix this by storing 0 to the UDP length field and by restoring the real
length from skb->len in udp_rcv. IP GRO already can store 0 to the IP
length field, and iph_totlen()/ipv6_payload_len() are capable of
restoring the real length, because the relevant packets (BIG TCP
tunneled in UDP tunnels) will have skb_is_gso_tcp == true.

Additionally, restrict handling uh->len=0 in udpv6_rcv to BIG TCP and
jumbograms only by using the udp_get_len helper.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c         | 4 ++--
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp.c         | 4 ++--
 net/ipv6/udp_offload.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cb86124fd963..2b9b55a14758 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2592,8 +2592,8 @@ int udp_rcv(struct sk_buff *skb)
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
-	unsigned short ulen;
 	__be32 saddr, daddr;
+	unsigned int ulen;
 	struct udphdr *uh;
 	bool refcounted;
 	int drop_reason;
@@ -2607,7 +2607,7 @@ int udp_rcv(struct sk_buff *skb)
 		goto drop;		/* No space for header. */
 
 	uh   = udp_hdr(skb);
-	ulen = ntohs(uh->len);
+	ulen = udp_get_len(skb, uh, 0);
 	saddr = ip_hdr(skb)->saddr;
 	daddr = ip_hdr(skb)->daddr;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 493e2b9e16fb..4f9a3922937c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	struct sock *sk;
 	int err;
 
-	udp_set_len_short(uh, newlen);
+	udp_set_len(uh, newlen);
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
@@ -956,7 +956,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8bbd55546b6e..02272466f4c2 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1081,12 +1081,12 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 	daddr = &ipv6_hdr(skb)->daddr;
 	uh = udp_hdr(skb);
 
-	ulen = ntohs(uh->len);
+	ulen = udp_get_len(skb, uh, 0);
 	if (ulen > skb->len)
 		goto short_packet;
 
 	/* Check for jumbo payload */
-	if (ulen == 0)
+	if (ulen == 0 && inet6_is_jumbogram(skb))
 		ulen = skb->len;
 
 	if (ulen < sizeof(*uh))
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index c92cf5ee3e6a..7370bcb80332 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -171,7 +171,7 @@ int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
-- 
2.54.0


