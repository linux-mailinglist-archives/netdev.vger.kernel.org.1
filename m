Return-Path: <netdev+bounces-294118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO7qEMymHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:47:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CCE62BD81
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE03C30E1AD5
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9BB3D170B;
	Tue,  2 Jun 2026 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="fX6O8Eoc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SxnZeUAc"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9813D170E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393260; cv=none; b=X+FEiajxNP2SnNQnt290km9lDwq7cvP/nXBYn8kjDN4mP0IQWoFl8rXlUIxs6XWNrlbJmZ6HyfAnh5lEPtq7RpiLZWpBbWwjYSYZKrRASwO9nHiGu+VCXls/WiSM22y/jv6JbkSFptX4kYhwKfFqlTap9aqvUNeyFKVamHMrKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393260; c=relaxed/simple;
	bh=rUZrbdwHAwb7qWJQb4BsVCIuGGGQAGGDIxyzU2HxUiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FijsmWTNLqrYlsRiV8jx4ATuojawqZRKvtRgIFShYBMbHW5wYJLz0NuRCGDHrA/mm5YwZJuyLSCOzSmA7x/9ruSnueAG5zkMfSEkqj/fMGHEEzzfylIs++C3s0EUSCpWY5y6YLnQtZfusT+WUGXBc1Zjoyh0MpJYQXi0djQRl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=fX6O8Eoc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxnZeUAc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FD247A0071;
	Tue,  2 Jun 2026 05:40:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 05:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393257; x=
	1780479657; bh=rfFyIvJs81dzmkJ3vIBIPvSyawjdHVpKW9tl4634oqU=; b=f
	X6O8EocFj5ZYSZ45U8SbVit7TrxFicdXZtzxLmmxtLaZFOuEaWLVsqgE7dQ/Wj6N
	RMlr88jakXhkvzQk0C+GP6+EbNv/+8d5WQLbGxHKlPZqI+thvE/fo1RQtf7hW02h
	eha55YBnCAk4ju+0XzwGqSxif5rDpifHGNr2bXZjkaQlW0DjCbxsThrK6G0R6IKA
	bxeuaCkPxLrHAS3rkB8JtPtMEmizwhCYxFiJiTsm3HgckS89T3UCbxkoG30unULV
	WyK2ucacapMP81jZKIT9dF83Twr8FgM7peyqZnLShrNTtfoVorQZSGLFw0EcJkLc
	gA8B8cLHD1rcu0iR7QpAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393257; x=1780479657; bh=r
	fFyIvJs81dzmkJ3vIBIPvSyawjdHVpKW9tl4634oqU=; b=SxnZeUAcs4laBkyH6
	eUViVQnK2uaHCvEsm11M2XeYJp+UMn80gzrIgT2TeRt5UtnKX2QQaDXOivX46QZ6
	j36QbNpTSNatb3HcTNDWV7BnkbyNS0BBFT8A7mlpW6tIftz/KkXA3b+Huvkw4eRp
	gOo1/wAUFnhgwCXLIPqX3qlBb5XMCvb7x5W5MsjSUXt4rhr9cqJxNX7sfQiNKP5J
	iwdqSTOgTLyqIJSEfpcMh/kGZm8tHtZZjGKebjVAssFGGXFZd74kWHekN5t6vkj+
	EhDblBvSSluYnJU6aeCOoyuNfa+wnvNDekWJPlhdTAWbcxUIj3yPzt4kdCww3oEW
	906fA==
X-ME-Sender: <xms:KaUeasAQOpN3-VsOrTarc2Qd1OL4fO-3Y5bOcUrWVTifX-qGtdG0VQ>
    <xme:KaUeatDfS6uww0rhNde1m5eUz4FD_bfFVeMHeuE27VMxBllvt2-MTzuAMSowd5zM0
    1p5YMSXZ3xYh2DAFRs7CER96KLxcw_MMV8wLh4cJsDG5UcAWUuymrAb>
X-ME-Received: <xmr:KaUeamZHH0SMAWGg6iHdR2XczYB4zt-QCnvzjEPTBcrmH9h0FWMSIamY2Wr-LpDHCc5kK8oPdTGP1DrozKo>
X-ME-Proxy-Cause: dmFkZTEHwjyOWT1zAu1hlyP0tsV1fZWrL6w7Z2Ai0I9QoqXSOIixII2GUNUR9v0bN+rbxz
    YbfPmIBW7jegP4sCmFiXrxd4pBPbb8Wx2DTonuy9/mDe2qBGBiBCfqY8t8kWR7USlsLIN8
    kql2HXUzo25Yb4yS5Z7D1j3SFyoGjT8HMIrQo0Gi4B3Ov5pDriHKriAxeuJ08W5EEEylQh
    6r3UNTuCcPs742Nu/tTFhAlhIPsI35bY89aw6RPhVVHB1RJ1SXt66BhyrHIWAiGRvVkLkx
    CruBw46JHzz6W88ylmi+VPFCFpKk4amjXylyMh1sFFsyQlSssH3OFzptxK0+HTqNBHxQQf
    fkQYCA+laoQ8ukgz6r+f3bk8g9fcnEzhDRb+WwMdHcbirOzYG0ZTJBRxQTKIb7hL/PRsFd
    k3msYIUZ3n/UGJeFd+PR4Ab/I3QEwZCEJhu+9mlrKsFK2y+ytDH60ZjlZn9+bXtR+zKkvy
    31apqkDz7Yk2G74eDuicoH8blm2BXiKJXCAHgwNCd+thNqtmRHEMFtQaQYMmAyolu2jtAO
    +HoH4sjYOoa+bqTlCo0Ql4O73YrJO4Nt61HtfOdJKrcfbeMAR26jfCp/Cnu28XvxOX/zCD
    OaySzTlOY/E/3oh3a5StonHHxi457Hnkloi/VyTD3+OnVpNMqVxYf6uYxJIw
X-ME-Proxy: <xmx:KaUeaixW5TJPIadPptcr_I1LS19ATxVkvBQI3M5qumuk2yH5Jc9MKQ>
    <xmx:KaUeapd2oB9nQSCbOCyM85a_jnHyhS6DtxhMhvTLnUg1BkUi906B4A>
    <xmx:KaUeaoKmSiOhag00aA1Y3K-XlPHIDBOAC4gGr2Q2dJU8kw6UGJ97Yg>
    <xmx:KaUeai235jIOBG0Zc_pkR6fduytw9V2-X-jtJvvlWIk0FiWnqIUQhQ>
    <xmx:KaUeajxDv1RNXm0czLKUI-tBHKFsq6hWH7vblGODeOy1JIiS8sFJXmm8>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:40:57 -0400 (EDT)
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
Subject: [PATCH net-next v6 06/11] udp: Support BIG TCP GSO packets where they can occur
Date: Tue,  2 Jun 2026 11:39:26 +0200
Message-ID: <20260602093931.516281-7-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-1-alice.kernel@fastmail.im>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03CCE62BD81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294118-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Wherever a GSO packet can occur, and its length is used to fill the UDP
header, use udp_set_len that assigns 0 if the length doesn't fit 16
bits, so that the packet can be properly parsed and segmented later,
instead of having truncated length.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/fou_core.c                    | 2 +-
 net/ipv6/fou6.c                        | 2 +-
 net/netfilter/ipvs/ip_vs_xmit.c        | 2 +-
 net/netfilter/nf_conntrack_proto_udp.c | 4 +++-
 net/psp/psp_main.c                     | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

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
index 8a5675983e7c..0854f9e498e7 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -45,9 +45,11 @@ static bool udp_validate_len(struct sk_buff *skb,
 			     const struct udphdr *hdr,
 			     unsigned int dataoff)
 {
-	unsigned int udplen = udp_get_len_short(hdr);
+	unsigned int udplen = ntohs(hdr->len);
 	unsigned int skblen = skb->len - dataoff;
 
+	if (!udplen && skblen >= GRO_LEGACY_MAX_SIZE)
+		return true;
 	if (udplen > skblen || udplen < sizeof(*hdr))
 		return false;
 	return true;
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index ce7a0ade450f..0475e680651d 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -211,7 +211,7 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
 	}
 	uh->check = 0;
-	udp_set_len_short(uh, udp_len);
+	udp_set_len(uh, udp_len);
 
 	psph->nexthdr = IPPROTO_TCP;
 	psph->hdrlen = PSP_HDRLEN_NOOPT;
-- 
2.54.0


