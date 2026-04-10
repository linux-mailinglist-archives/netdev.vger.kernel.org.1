Return-Path: <netdev+bounces-277449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APg7EjQT2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:11:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF923D9010
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FDD3056278
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A153D8919;
	Fri, 10 Apr 2026 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Rkwgy6KH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxF0yrTL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC283D9DB1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833825; cv=none; b=AAfAqmpk+OFplQ9duDjsqS2avBzZ5fPl4MMTm0AoFFdVmLJqNaOiGlLmXafzfs+b0vhwURp83A5u7ITyYCQpHgCeAlAjMvYLb7w/xPenWRVOKb3FXr6Uav8p7c7McJCpwn609F6jayFrw+OkjRuAsS72yqR3J90HLwz0Eir8nH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833825; c=relaxed/simple;
	bh=05kZma9TJd4vaRLhT3A4r41/zDKS+nuhZXQ22vVu9R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcgN2VNxIofoW1JGckpFFNk9efX272DoIlkujuYyAUQHMOTIB9ucXNWCjeYe4NIEzDtmAOF/JkThKZWKF7h4ZSeqUSuZAXCF91xAgu6Jr8DheEeg95pePt6wrMHM6Wwqs3zYNe7uV6979gAm6CHrddVRusPscv6a4l65Hl8/6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Rkwgy6KH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxF0yrTL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 414ED140019B;
	Fri, 10 Apr 2026 11:10:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 11:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833823; x=
	1775920223; bh=sU+OoW4t49MbGByngP4wUKu77h/eiJRl9wjwsS33JDs=; b=R
	kwgy6KHNeJ0D8ZLv68tLMsJubdwIiTK3FehvGTRZZtuaU3pzfOpfAEzC7AnucALS
	rxN4ZIrrenIHdISKHwXB0Bc+x3TC1i5fdoCl0aYcahZuCZf7xmF3g3/OLq0JSVU6
	z5hDIFjRQM/THbKgalUxz04cqzQH9VEVaH5dNQaMaCgtu8QVBVaPC9D8Pjo4jkVH
	LfW2iFRjr6W1Utx0cvOSjVs+qtntAKJt0O6FJ1hgpV3L26LEwGT4iQYGeAN/Fs57
	t8yX8OOTZvCgTRWlxu6zxQOWHGh7c99wICp5ipVhDkn50XtT9Xe80YKCRAR6uLQ3
	avG8svFZb5f0vI8LeLKGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833823; x=1775920223; bh=s
	U+OoW4t49MbGByngP4wUKu77h/eiJRl9wjwsS33JDs=; b=fxF0yrTLeZ599LGfp
	+TVMfMitjHL/XJrsv8neE//CwO4G8yXGacmvt9Q7mo6udIuUT5uk32oIjTIDdeZ3
	i/S/UD/5hI8uQT4D5s0jXKg6Lgk+/ygsbZgXZoS/XXNW30tA2RIg0NmGC/CyINzi
	JNNaXP7jKjoTzAZBS99X+2y28/Tg1ZgDEVksleQ6xgcR3stD8DP4XxVRg+9CT/U6
	8Lz4o2Utakvpq5pS9/YiH4ntR1AjvEEqQbH/sqWbLBMjuGiLzUCuDQhxt997+p0H
	Z0g4MklYGqB8wEDMDfcQX3Z8nGHtEV0jw1Hluqnp/YxmXDfqS30RGMfQUW6+ujZo
	xDXcQ==
X-ME-Sender: <xms:3xLZaQo4RMUzNPetT60cSRw-W-ygAIkng6yCV_5s3sOkii89d88H7w>
    <xme:3xLZaXFLR9HXaiPmhJg-4mDzad5xKVjH5DxRiUqu_3y_73Z7OzUrOEEpO5l0Y5CNd
    cyxmGnaKd_m1DXUsN3nKOPo3V9nQO16GAhyIZXwLkJF6AYWJAH_4x0>
X-ME-Received: <xmr:3xLZaU8VMhSwFmpX-cnde0HSpj6T0TTOeDg2v52Goqf-SSje8P6MEgG6lOsALg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:3xLZaUTc3RWmLtlcc6-DrPZg27gYbSPjZVlZJCzkPR4HvmpKizHkUw>
    <xmx:3xLZaZrrtsSXbyVIREfc0dTnx2rrnZajcf08UCYDr9AmVZPdAfwnkQ>
    <xmx:3xLZaRMMOouPJB8yTtQ92MQyPS7IpvUDzMR87y0N_sLS8VangLpDBw>
    <xmx:3xLZafy9ZR7ORNLY42haH2EIwoE5ABJTXa7bJmyXvdx3rGpLAsMyzg>
    <xmx:3xLZacCgQRXwP9cqkK_-4I1ka0LSPT8Ch70taTCKYCqQA8Kiv3O-jseH>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:22 -0400 (EDT)
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 07/12] udp: Support BIG TCP GSO packets where they can occur
Date: Fri, 10 Apr 2026 18:09:38 +0300
Message-ID: <20260410150943.993350-8-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
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
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277449-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Queue-Id: CFF923D9010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

Wherever a GSO packet can occur, and its length is used to fill the UDP
header, use udp_set_len that assigns 0 if the length doesn't fit 16
bits, so that the packet can be properly parsed and segmented later,
instead of having truncated length.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/ipv4/fou_core.c                    | 2 +-
 net/ipv6/fou6.c                        | 2 +-
 net/netfilter/ipvs/ip_vs_xmit.c        | 2 +-
 net/netfilter/nf_conntrack_proto_udp.c | 4 +++-
 net/netfilter/nf_nat_helper.c          | 2 +-
 net/psp/psp_main.c                     | 2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index e66e10a2c33f..d128f0f6e3ae 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -1043,7 +1043,7 @@ static void fou_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
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
index b460998e348e..08b0b5bfe4ec 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1089,7 +1089,7 @@ ipvs_gue_encap(struct net *net, struct sk_buff *skb,
 	dport = cp->dest->tun_port;
 	udph->dest = dport;
 	udph->source = sport;
-	udp_set_len_short(udph, skb->len);
+	udp_set_len(udph, skb->len);
 	udph->check = 0;
 
 	*next_protocol = IPPROTO_UDP;
diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conntrack_proto_udp.c
index e9bd1632304f..ca7d259ded8b 100644
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
diff --git a/net/netfilter/nf_nat_helper.c b/net/netfilter/nf_nat_helper.c
index 3853f41db499..ec34a2f4baa8 100644
--- a/net/netfilter/nf_nat_helper.c
+++ b/net/netfilter/nf_nat_helper.c
@@ -161,7 +161,7 @@ nf_nat_mangle_udp_packet(struct sk_buff *skb,
 
 	/* update the length of the UDP packet */
 	datalen = skb->len - protoff;
-	udp_set_len_short(udph, datalen);
+	udp_set_len(udph, datalen);
 
 	/* fix udp checksum if udp checksum was previously calculated */
 	if (!udph->check && skb->ip_summed != CHECKSUM_PARTIAL)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 47491b0ce4c9..0ccd96ab99ad 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -207,7 +207,7 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
 	}
 	uh->check = 0;
-	udp_set_len_short(uh, udp_len);
+	udp_set_len(uh, udp_len);
 
 	psph->nexthdr = IPPROTO_TCP;
 	psph->hdrlen = PSP_HDRLEN_NOOPT;
-- 
2.53.0


