Return-Path: <netdev+bounces-277448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE0kEjAT2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:11:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A83D9009
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DA8D30235B5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809A3D9053;
	Fri, 10 Apr 2026 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="E3GYJagb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+QiRDVT"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AF3D9DA9
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833822; cv=none; b=Pm1rXGCOAnzj1si10jbn2U242NuB40D9EylQ5XzFoTM8IRTWBLXMjwmLE9Tzj4oZ/Anb8ZAaE98hUx7AAHvnm+y4nCGOXceYUKuAt3ltTImcjUq2WfNt0BpfawecSweVLqPq1dY0G7JsU7CRKnySeqU0CDuAmmx4AY9ykQrmjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833822; c=relaxed/simple;
	bh=Av+ar3cIwhp4QbIH7RYLy/wFHmkaVmH+agyV74HVEAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5mi7wTT9oxIhhrYLQyT2bAM6gNg6PW9Rwy/T1iD6W3y1fs9VW/dxfRBEWXuA8IwqrCPet6OWi5BxmiFHYVsB0bIufrhcY9wgpQsv0tS+xtDhjYjFF0Iiu1nH0RvjLk0kTWRrcbOU4klADCtdwZ4QR1dxEcrJHcjMTopenSLTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=E3GYJagb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i+QiRDVT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 94632EC0440;
	Fri, 10 Apr 2026 11:10:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 11:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833820; x=
	1775920220; bh=nxAPzjV3+7jR+neBNhh54tWhAjkeOr/5Sn7w4HePiXY=; b=E
	3GYJagbiT5ViEh6NEMan3FqYpfl/rinLPddEC4ISMRlndMp+wfBlyUNVgk3UYMEa
	C6C6ZXPXlssd/hE8zl5YxFLECydiGrvbF2azRLKmlfP2WqymTs8KCx2qWgAeeZjC
	lfJbLwktdrq/nV/Bjatjn4W1kpwM3jqduNYQg7kyYStJPjIAGE8op6A6cmQBQ95y
	OxihaOta/n2DM21WfzX2wqZ5duaxOru+fSm2eD6PAIe65HKRfUa3bw8ToWgHhuqX
	GECvwchxf9DmrmFF75sEf6rMcpLBfNS7d8jiaF8oNJdf6zEvTC743CBR5+2mSDTQ
	2TW2aPGNEUAXtEQ59FjNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833820; x=1775920220; bh=n
	xAPzjV3+7jR+neBNhh54tWhAjkeOr/5Sn7w4HePiXY=; b=i+QiRDVTzLz3WO6N7
	pr/prjdPeNfETzildC9JaFdAv1FVTJT9RiItkSDXwfwc3KEnoxP4+otYws2O+lCe
	bU3oH7Y8iXQCQflxzDOqr2rNNwx8kekSUc8dYTIpqpgRqgaYbAlQlt70dXsY+TlF
	2+8KelOkz1fz/Zvp0L4m6yQRKHCrx3jEFMP1t9UAWlBw9eMOgWSshk1M2TpqUBJU
	o0f/xd7V/g1XxeycUf4qPMvMulZ8/JmDfAbIyO+Eyv8dH4Ip86/AD8eZ6d7pvYBD
	Wd+/7jYTSeunsAm0Z2SIBv03b195bgr1pwLK42vDzCSkS7HMyozZGMr1uJmYXoKR
	AY5Nw==
X-ME-Sender: <xms:3BLZaXH4z87MbcRoMGHQQDMKQF381FOpgGN6o7KxWMQtmRe4Ing-qg>
    <xme:3BLZaUzBmCH4UQC_k7IAXFhG5Polf1z7O4pc_6ZhM96RziknfMVojgd69R8ogwr6H
    ryMeED0uY5rEBEVkDjGBMwtOr-KvQ5_i4pxL0W55ALWkO6U6Mqmo1o>
X-ME-Received: <xmr:3BLZaY4FqAb5bmPuNHNkFfoqXEc-tTRRe7kPDdiNq4GBlMAgwBFFVxXPB_jtcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:3BLZaRfBAWRmw2w5YkvP9fBNt0BmEtM8EhdIyneZBtEZ2lMfVQYDcw>
    <xmx:3BLZaXHrGDbK3uFQGkSyWIaRE_CX1ir7VM6Dfk1zhgi5rCa38BFBKg>
    <xmx:3BLZaZ4kAyqqrLFq1cpmqLHqtxJ99af3mPiLTWmE6rP6EMC3Aew0sQ>
    <xmx:3BLZaSsTNpCyJrWA3p1uVm79tdurY0-np3kf6jtbumAzeVE4hAiNxA>
    <xmx:3BLZaR8J7atXl9VNa2wsDJ8W4NQaKTiCQpoKJn6L9fkVE0SMcqZcEkBx>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:19 -0400 (EDT)
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
Subject: [PATCH net-next v3 06/12] udp: Support gro_ipv4_max_size > 65536
Date: Fri, 10 Apr 2026 18:09:37 +0300
Message-ID: <20260410150943.993350-7-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277448-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Queue-Id: 4E6A83D9009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

Currently, gro_max_size and gro_ipv4_max_size can be set to values
bigger than 65536, and GRO will happily aggregate UDP to the configured
size (for example, with TCP traffic in VXLAN tunnels). However,
udp_gro_complete uses the 16-bit length field in the UDP header to store
the length of the aggregated packet. It leads to the packet truncation
later in __udp4_lib_rcv.

Fix this by storing 0 to the UDP length field and by restoring the real
length from skb->len in __udp4_lib_rcv.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/ipv4/udp.c         | 5 ++++-
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp_offload.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 43e1cf8d32e3..8b23cfd90289 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2582,8 +2582,8 @@ int udp_rcv(struct sk_buff *skb)
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
-	unsigned short ulen;
 	__be32 saddr, daddr;
+	unsigned int ulen;
 	struct udphdr *uh;
 	bool refcounted;
 	int drop_reason;
@@ -2604,6 +2604,9 @@ int udp_rcv(struct sk_buff *skb)
 	if (ulen > skb->len)
 		goto short_packet;
 
+	if (!ulen)
+		ulen = skb->len;
+
 	if (ulen < sizeof(*uh))
 		goto short_packet;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 22acc80b12a4..23653872ca65 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -916,7 +916,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	struct sock *sk;
 	int err;
 
-	udp_set_len_short(uh, newlen);
+	udp_set_len(uh, newlen);
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
@@ -953,7 +953,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
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
2.53.0


