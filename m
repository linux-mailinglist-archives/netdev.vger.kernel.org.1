Return-Path: <netdev+bounces-291810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIJGGPfHFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469D5D98A3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 349FD304BD16
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C53B0ADD;
	Tue, 26 May 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="pMBta+Xw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dchKqX3d"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF63B0ACA
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812007; cv=none; b=CK9NGNYd9DHH8HvwIdLIVr06OLmiucOCbrWLxmSOdJ1vCssLvVB9JfiYHiSLQTvBKuAUKjYSegtYRRdoRdiWVZJqV/ItLMKaUyhLbPAcS9MahJC8VAlsCUl2AZyVJmof/jsZS9sPWM9EVsmeMW1YrkTvrV8o57fYX2dJBMWV6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812007; c=relaxed/simple;
	bh=rUZrbdwHAwb7qWJQb4BsVCIuGGGQAGGDIxyzU2HxUiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsdKQoyXNgF2bXEj3l9fshkC3HxAvkvMwM6OM6W8gKmJ07Q7HC1FRLxJR8bOlWHUtTINEQ3eEpo7a7ovc1IOnbb4etW34JQDsc0Mxq6RBuIWc/kA8wcWByNP35zn6cTl89BQ50+mQkUpPgvAnLTDnQuLr7ddC+BxklMX39RGQPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=pMBta+Xw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dchKqX3d; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 310777A00C2;
	Tue, 26 May 2026 12:13:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 12:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779812005; x=
	1779898405; bh=rfFyIvJs81dzmkJ3vIBIPvSyawjdHVpKW9tl4634oqU=; b=p
	MBta+XwFuzbikYTPgoifj4hHPxDjl6MwtRbM1Elg0NdnfWvL/gR2jdEyP/rcu74L
	VABDmpAVLijq213KOSb69+iaC02YQe+R3p+45S53BpMnXRwpJxkCPa+oijrSuvp1
	okr7UaDy0gJmoAMeDBEfJN6whBrrpKWT7zJ7cx1VwhjnO7m0/88eZqmR9d9pLLVU
	4ZCKmgtu1+B0hPpeTLZoP2P7d9z6aB3DY26xV/953SCjwXd0FddMjRcsJg7NyzLW
	46LCMssPCFMExqXQUdMoXh+H3Vqm8O9JHFBSzCAJCG+FqAXYKlcB9LMLxX+yJAnH
	8Z1/2I80WbKE0Ihv/sbLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779812005; x=1779898405; bh=r
	fFyIvJs81dzmkJ3vIBIPvSyawjdHVpKW9tl4634oqU=; b=dchKqX3d5Xq2PpQyZ
	SYqKf/lP20IJzb1UXVnCrVHeF+IYJBrAQNP2wZs1JoA/w2cwtTScEFALfZOA9rHN
	HA/czrs7DzdX8FXM0JnxZtV/niGCt/sQZrV19myq9gLhRIEwlIrE2VMBY+rVRXPx
	Oztr26Fybz+M2p06P+MFEqkh/iv9AkTCaUSACPKWdeqRMg+ll/N4geXADpEmFer9
	7/dqbe9+PVtPtepc+7qhSLVHBn4ZievleJO96Veov9N619IheliIb4NqP2Q9uxz1
	5ZmV8kin9ddqIhNA2chCaKiYKMZVi5/HqLo5+qxVGx/omaisl7ibifmCTIov7KQB
	icm8g==
X-ME-Sender: <xms:pMYVaqTcKG99Wf_10d7xAe-KaHgWwnTRZsWiXoCBSnCzGUnp37OQnA>
    <xme:pMYVauSHV4leuFJpkOcQo2UdHOesmvrnyN3ZGQlR2DBnCYwkdxlBeVF7yqv_uVa3-
    LR2l__Oszvt9j01Ry7Wr0f5s3QR_SpR-34JT2WiURMiuKRWNLRLjFE>
X-ME-Received: <xmr:pMYVaurPh5JdJuopUnFN0HqxEskhLXFwJO3IKwuK7RII7Ext8RLGMo6bpu9mgMEr8esbqlOGeESv8GtyTqp9BUewOUqYcXQMIjeSHQ>
X-ME-Proxy-Cause: dmFkZTG4G9zbtpZgR+LIx8EkHbmWKiCUD5lWWjQ7rQgOwm/VyUoO4wynI5PAYAu1dD2VK+
    aE6JARqIKgaU0Q1bOd4rLnkhu7UmRwqeTgvkSV5d7grxG9FOkQ0oQeRmYwxzVcDeyksT5X
    MnuMadVg8leAkVjnwRPLpa+FDPLAPVROlFfmUAgtPHyfk3o9NrypRZ0abuRJIK8O5lp5p8
    tzBD3Olzgd7un01+SJnRGQin/adteeVD2Zbc2V/ul/M6kb/60qayxpEi+pujApdRm0DdBA
    gAhadAA2ZHV1xUAE8cGyD+tUbCqQfxKzuc5eRxGV7Mo52+ocM4y7T5twJ1LOAdcR6Qctcm
    hR6Rl9OAnxbZB5f45L9JG5oVdD11jLWUVDlXu5T2ODFSVimDoLJn4l/xhPNZBipa9XKkpk
    CgP+AjAfofszC+7H1W00OG2QArudscT/GMCCvJfl9nycsiVaNznZXQABJswKtoyj//JzkO
    N45HSNgakXas7VwGwF5fSPUgSGWiY+QUJ3RywvlSfBxAM6tN24Cm+ou//Rij2RdfbzuGc7
    M3LUhyIgZje3A98ls1sdBdluHM/yc61IXr1HF9TTpudlzsmif2JKN7HZ2kSfPUffk1egjc
    jyFOhGpQf7KTn09ds2acmC5CL6vDdnH2Y7Mid7ZUJXkIM/04RfWIC3N8GqKQ
X-ME-Proxy: <xmx:pMYVamAOvtEkR5DA9LXFnde_PwAfxecm1uVcVhfxJyWSxBZEboL_jg>
    <xmx:pMYVarucVV_vt0a0vc5nFr2OsqeyOHfqsgF5lNrbLXGzVw92XMtFMA>
    <xmx:pMYVatY74GRgsbrsZZYS_8CNoObKiBefwevww2f729l6LUlOYdgexQ>
    <xmx:pMYVavHDMAURk7TPpMq8f92dedoereQcAyX6OuhYP55efvrDzzmtPQ>
    <xmx:pcYVavNIqjvBZmedIYxD06ErnR_2sAPLwvDdiP_u9AF8PhN-_YYk72rK>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:24 -0400 (EDT)
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
Subject: [PATCH net-next v5 06/11] udp: Support BIG TCP GSO packets where they can occur
Date: Tue, 26 May 2026 18:11:55 +0200
Message-ID: <20260526161200.1135899-7-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161200.1135899-1-alice.kernel@fastmail.im>
References: <20260526161200.1135899-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291810-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0469D5D98A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


