Return-Path: <netdev+bounces-306570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JWWFF/X3UGrH9AIAu9opvQ
	(envelope-from <netdev+bounces-306570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:47:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B983E73B655
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:47:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="k i5OQ/t";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=o3b4Tp2q;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306570-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306570-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C27903020FE6
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FB3F2117;
	Fri, 10 Jul 2026 13:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2B42882C
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:43:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691001; cv=none; b=c1/HcGUdIOGGuEBHwuHxx+9crhEKimcar/lfU+yuVOgJxe8IKhkRaPBRjTKS9/X9tYHzpxr+0qllwaPiR+N26LJhiyD6eqwRKFCmQ5+eRKLhP0hnl8b25iGo7ndjJGuKwer3Z8UCdclQWKuNEmcF4YpRgBOenYO4rO3csGZvarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691001; c=relaxed/simple;
	bh=BpMU/KQZxIQhJJ019dQAS3ORZw04v9Z1KJIt1fkVI2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofs5SWi7ccGWdHtcZUSZuPWJ/Y+pLTSI+Z2n25aQ/VAshlS/3z2mCYZ5rnk9iJ1gOKiRm0pcQtUoyoTTF1VWaKDpgYVKdeeLnAxvNA98/yEQlYJBocMMhJ9Aksy+Dvo71h0w/QckNqe5AOpnXzr5ZXY0770xH7sELWUWgVw94yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ki5OQ/tu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3b4Tp2q; arc=none smtp.client-ip=103.168.172.148
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 21C79EC01CD;
	Fri, 10 Jul 2026 09:43:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 09:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783690999; x=
	1783777399; bh=iezIZhXVpeSc8eAq7auxerJW6WGW3QxsYHckVvIqEJ8=; b=k
	i5OQ/tuYQeMjmVy5Jlv80YJtzYTI9TsW7PO7g7BeoTyraHBhKtzuCpeoLxQAjnQi
	oNpdmrfS6dA7cxKQAGOvzg9KpnnoIMRHHBdo9KwhpbUHqZNArRGxsQx6Uk8tr+vm
	mKBOGw99fu4xk11XY/3qfQ/yMZ+aSVqBgvSVYcnUmTNK/zVwvriQ0IOkObqYWZB9
	mXBvpumlsDs9VPght2W8yl8wGqjfTz0H1DlalX49FzrCeq3JFIwq71LUlZ1iGl7U
	BiR8HHYLW6l9jXQGFJYGtfY4xP2eXaztCgUcCWZgrssrlIbYBS8cZT2I541wzj5f
	icIxYMurYQjmxK0jsunTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783690999; x=1783777399; bh=i
	ezIZhXVpeSc8eAq7auxerJW6WGW3QxsYHckVvIqEJ8=; b=o3b4Tp2qQDTUqzVxh
	bqTYfYIl27CD7LZ12zpimXj0JSEbHBiE2OXltDIkJlfX76qOmsb2OzoaAfGuMYyk
	Y5kH3/UX4UrH+m3Z/KPMaDEt1nernOCS3BRNuFDwK/nxIHTYL3VerBobQ8ZlX2xY
	91/GMLIXIaDRPlmFrz5tYHrAKpVNN2xmxyNK6VeF+rsTCB/SuFS8EvPqNQBIyuCM
	yiV0e/yg3oDV7BaubL5c3V0t6LvqNE1Vl8k9Hh1lqVR1C1SKF3TB7z8darGoR1bh
	Gin05A4brmJGmE5iMQjOAuCzNYgaBygNWHMukoK/eyN04jt47X5L0KWbrmuk4ASW
	T8UxQ==
X-ME-Sender: <xms:9vZQalm2ytO9me9PoqbRgBvXlnvFeq3ZgYQlspfortPCMdM9DhoOXg>
    <xme:9vZQavXXtXR5kbBuwZQzafQdbfwCiySxDzsNgtaFCdl7_LP1AJ3fHGUdaXse2wM3a
    VSNHpsNYmsitfdyxieRE2DpkOFXbqecWR9pKaNoPoBLCpqqRty-nlM>
X-ME-Received: <xmr:9vZQaictSxNLCH0MsSc6-CBF0pR_tDsZEcd4x26uujE0DqsusxlmIe_vuNwcSkQnNHMpi4N3BB18_ob61ghPJscC5wdiEegMRQ2jag>
X-ME-Proxy-Cause: dmFkZTEFIDtJybMkhSz+aoCbMXzoIhducNEuhAb0UsdKW5vcb9RmME7tTBBbX+IAN6HHwY
    jY7/HMSMdSWiW5jJB1rcMXZzIQ4BMvX7Tr0yaCVUph3WHVV4fbiicPZHUJdcrlrp7295Cp
    LreCLwrcwqFxVNkzCtLJGVDhvn6zUcFiNQ5fMd+1s1CO9ZZzUPogPBJybRzncs3ZWPs6wa
    TxqPh3N4CWqJSN34wr2B+PIx8mJmH3CcYKvVADIrsqMwDX3woDS9gF3a3eIm4aesJrm7/T
    31W50qtne2kH9Ab0cGetb1iVvNTWqi9GzFymzVT0XTWgFFtDCNjAcOKQnyb1MyGsC8dSlt
    Phk1jgHqsLsi7+M6bVNCQZMgVaa9ridDsh8H5MxU/EeiTeH1nnIK/HedjR+HdC+JC+qYkZ
    edzNIqTcqimDtZ73rPCGARlwGu62pEhSSqPpiZLt4YGs33SDhEw17dd5HJ5pCWxMdUixsM
    Dj7NjWhnjgOYJj8LOUiLQhj6IP5YLpzk36tYNjHkTWskgCZ2gZjpjWQXLIgPxHrrkHdNjq
    NGgxs4UEJpv47U/rWbl1Fk3V99U6/5THxk1fVjU9EBlJy4Z1X4XeND3gFJLmeb6HOzddkv
    bk3xot1OYsVENwTQUwF0afdMpvv/l58ZNqlnergGG+YeP5VAwOTJ3dB+QSgQ
X-ME-Proxy: <xmx:9vZQalmP7QSLTYVxbTE3cj2PrZ7V1S6Sn3IMsemSLCbM8PmFd-1z8Q>
    <xmx:9vZQasA8-6u7_osTqrT19Eyw9S9igim32djn4nTMbrJk_p7Gj-1z8Q>
    <xmx:9vZQavfbxa_z9fkwy96L8lWkHWU9oQZDH153nxhmz_rakDodJRN8zA>
    <xmx:9vZQav6XP3Og_tGIOuMxVHJu-6w160PwMzTcSqWRuNfFYX0x2UdJlg>
    <xmx:9_ZQaswqMsSyHD_tNmEQ-ViiLb5KdQmzho6D4R33yOMSZgXOJwFwn3C6>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 09:43:18 -0400 (EDT)
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
Subject: [PATCH net-next v9 3/9] udp: Support BIG TCP GSO packets where they can occur
Date: Fri, 10 Jul 2026 16:42:36 +0300
Message-ID: <20260710134242.216538-4-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306570-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,isovalent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B983E73B655

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


