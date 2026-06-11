Return-Path: <netdev+bounces-298316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RDUXIQsNK2qG1wMAu9opvQ
	(envelope-from <netdev+bounces-298316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E00674C14
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="O et3HBc";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=f3fcHUMm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298316-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9DE31609EA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252829A309;
	Thu, 11 Jun 2026 19:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66D29D27D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206249; cv=none; b=J14ihh+9Stahh8soVEZpjpTaSs4XReR/CdFkJSV/57v3sKXu8X433/X7vNmyaHZSd6VcDN8wcVRMWH/Oq60xK8wqANAyMN9t117aJtsW61aZDt06LbCUIolIYVEo+j+ILa8j3YbpG56KT+Ol3eszsRBfTTPIMyO4uYtM0vuMd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206249; c=relaxed/simple;
	bh=RycTQed2qe7YqMN8Z/FqkpT8XMOEU6MRHLtzd84sB5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXkva3zRg0XlaIDzyc3rdmAGp9tp+ATPWX9Sb/QE3RsShJgOP9ZT3nUtb0lLdpLA9ENBuJzZ6KYN9bppa/i1pF3oSC8wWsEJCMMMHLTz3EN0gmEPDi1u5XsarRy5+ua3kqCT6hlNz7sLnLwDfZAscg00rlcgZ3LoRW+t7amqNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Oet3HBcJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f3fcHUMm; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 587171D0007C;
	Thu, 11 Jun 2026 15:30:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 15:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206247; x=
	1781292647; bh=/zFDrdGt2RoQKbV2SX9yrdSp0RayT1tm2EAry68EegQ=; b=O
	et3HBcJhZ6hVRcBVuNc0p9FTeOUmpdH+6ieD0OLc5H3GvRy4MFvIGMCyPQqxtfAu
	B+PqqWXRAZv5zzIq8zPcLhq/zVhF/GlDxxVi4DIib/0Hk5nq55J0LVv6sBXLJt9U
	prwN50JeFjRR5OzNcikORx0NmhF1r32sidqoQWv3F8clW3O5E6HQk3/1CuePc6Nt
	0a5+axZqR0ZLxndaW1/rh1ybrk3fBiMZIfzamVFfIEQQD6D82zM3ozXu7WH7lZAu
	OFTRKLOWk5P4EHsrZqo+IW4N8ljIzFWToPag0wJxV8Yb4mCRiSI0+5XYAsN2AjQo
	4mXiNFU7MW+Msx6yKNS6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206247; x=1781292647; bh=/
	zFDrdGt2RoQKbV2SX9yrdSp0RayT1tm2EAry68EegQ=; b=f3fcHUMmmKPrj/eyj
	P3SOtVIBI4Wkale8kIymbYT452gt7rsBJODhepAeHsdVbOzfpy2fP1dk77iR4T9Z
	i+PRheZTzgPP+ptgotMxcaLNDW7VvpZWdytdiGjWbMGpLWiX9QMTVPZVYegWCEc9
	DBOSqbhSufKAyKOP+HV0WbA1sL6jtwl51pvJ5+eguGp8JNTmqCKB88cdq/Q1O+5h
	CPOWPy0byMbRqktITpvBKHqXTW3FQLkm0JJY/XEoweS9OvK+YwgXpchgmoQqWrN5
	0tAS6zcsEhQqHr2uNkQfCWGyLriiViYWo4v3+gkxsTg1VxPz77BzI0nNQ3hqLjye
	PsY3g==
X-ME-Sender: <xms:5gwrao1NAu11ciqc0TsZ883DB7UNKsooIW1SkIPQ8uC8wLADSBpj5A>
    <xme:5gwrat_OnzWbdBEgUsorR1KF-6yZUTGbIXwiPc90Yt7wxdhEQAp441CdbAH3n_OEf
    mZtqYjHyc17o83k51J2Dt5-ArKEfqg7y_ODL1u8MkJKVclEgVh4mg>
X-ME-Received: <xmr:5gwrarG64VGy9U64Wtr-HIDjq_9PC3Xsx0kT5ZuRHQYKpm23yx-miWA5YbKuq7ZSLPN12bguZcqUzlJyzEZ7MH4>
X-ME-Proxy-Cause: dmFkZTEiC3WdhRi6lmpvrurG1zsBSCtiqP0WNrqAbghd5WJJ5VA7rTMHapznV9StKJaapp
    RCFRaoACDzmV+WD4oXwzhVyqAYewgJwskY7+pzj89kGgG6Z5gh5qwjqnnl1xPZ9xw9XTL3
    6h0yQhC9JWLW9+mdqRsn8FaDYVGkm04cbHUvo+O2iHxAKiVWkwOc7fmUFydM3Q3w8Zl56u
    v+GK2GCObb3b4V4RDlvLsMODXfS6N+5oUdni3ao7DuI/y5kjlxXKXH9JMIpsen+KUYBZ/y
    QM6GhQcs+90PA2n4UkkP5wtLFs/TKnXuu0mgwtrACzJAoOCVpXiPf0MWRzXp2RALkPmoHA
    RRPiHb3lFcIB5A0QEfckeSWXeS5ielAwyyPMH/80hZXSMyEMPawYa6ZM9MeiAXJ8wWFNbh
    6zQ0XUb8GRcKxb4JnuvdpSjdBda7mb2HKcNQcPZQ0WDNReuIBvuofMyJ85FIH4dsM5HLbW
    s9ixvLab9ueVIg4Nb/7WRyFiWZFN2t/711utHPshqW2yTPzetOgx9Tb3sXDCDMGkEBsAwR
    Ef8JMn4f9Jx0RJoFH2New2MmTKBSvz36HmbNLAPLHWwszlzWxgxpZd17lwpdKtYTHREIoA
    CLQG9IMd1+o6sIC5bCVq7vrfFxbbaeXuqN1bK/Cran80P6p7aDxMuktVjvZQ
X-ME-Proxy: <xmx:5wwrajjBAhSl4yTNlajWSC173k3kh0ElMyVztGalL6z16HiOGvqMeg>
    <xmx:5wwrag8TnepxWlY0ax88nwlZvuHGxW-fo32hD-MkoLXJObU4TgVo_w>
    <xmx:5wwrajadgXa6AlWUfl9t39o43EKT3fEOfZ3ZtrBzY407tWuyomAR3w>
    <xmx:5wwraus9uFd1eLngS19pHXp4N8-evCOgXHEq3VG83obr-EuW3dVDNg>
    <xmx:5wwramNzlTnab680kj68IZFkYChR1a06MYz9yLFOGz3FVI0rTvELUQJq>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:30:45 -0400 (EDT)
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
Subject: [PATCH net-next v7 05/11] udp: Support BIG TCP GSO packets where they can occur
Date: Thu, 11 Jun 2026 21:29:49 +0200
Message-ID: <20260611192955.604661-6-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298316-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6E00674C14

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


