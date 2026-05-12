Return-Path: <netdev+bounces-287245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC8vDFVcA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:59:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A365F52548E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A9EE3051EBA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC23D649A;
	Tue, 12 May 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="U8TQWrBV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c90EFjjC"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968EB3D9670
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605096; cv=none; b=End/d8LkBYFmwe62do6EwQXR6QcpbeJxf2WlJcPzqh0F26WpWafTTty1BcmnZpEifibXalNxHMR+WwtcaFBnFzkeR+b95FbV73wmsIo/0B35VoaLeRWXObDOs7e57MRSjRLTYtzO0YZFj7qQgMNOpH+36wbVkbiG+VJIqiR8gsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605096; c=relaxed/simple;
	bh=hH8xDMECW/fEhQWQl0BD0CBVVHdPha29BqTgbOfF8xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIkXVgqapehamczGQIXYUJqiMFtF1ZBiR1AU8a9/a2LvQX509ZeU9gzMO3Jwkm1xy6STdXY+pLNrEyKgCY0g+YMWHU2dYXEyvczFdH3jhdXgLR6SvgX+n6nh+9iFGrNJ7rZ+TSRDKDaxDWCmo4/8oIqRWiyacXPpIxpesjrWx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=U8TQWrBV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c90EFjjC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB0F414000A2;
	Tue, 12 May 2026 12:58:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 12:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778605093; x=
	1778691493; bh=iBGaLdiFiGGZ2IDyp/NQ/f3pVsoq4KIs4s/fdV1SCPM=; b=U
	8TQWrBV3Cmm1gCpzf6p8et9FCYW9CjtGcOProl7Njx6X0ciygQqD5pvTKD2kpva0
	1gSqUxP5pJwwSkm0+1DTg6W9k4IaNGgA5/NB0ZLm0UbKRtWTEHI/aFrp7j7mTsPI
	ODGZQJXQianQ+Pobiuq2TH1YdcMjc6dIPNI3AXC/7y8BgfingYiKJphQxlyrDXHy
	Qvh8SESRKBH7vB0XyL7/sm8rrykZFUgP0DU/gwbMoAs3ieoG96T9+voSDGFzsqCy
	WDCV2cu4IIWetLOqkt6SpDWQ3K4cN1Lc+JRH5yafBZJTW0/lHI7n9rAksa5LaXPa
	MY/8x/Igc7FEPvDdHYnbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778605093; x=1778691493; bh=i
	BGaLdiFiGGZ2IDyp/NQ/f3pVsoq4KIs4s/fdV1SCPM=; b=c90EFjjCCl/53vWn2
	boqy1SyrbbByHZfNr+O2dAKSu1/JzPIU0v3eZjvQ8RGsbh5MX7ndfUyKkIpN8QpY
	rD+gd5m+GGTp2z7uDmG27Q3WY5k9Sayw8/Eh14rNQDDtr2eZSiqr2SM3zHr4JsLO
	r6t5hK4pJkDyUYtOy71TmpblPtIDA3Cb5TEXrsXVHTMVDHmA22aXw+ZX33V4/0bh
	LsOVGLNniGtV/QQs3noWJE7COxZu9coZysKKxx6Ns9YRJ7ENfUxZUA5m0UukmlWc
	r87ZXyYSP0ADfPEHCUv5CPUlO91osTFSm2HC2kS04qoHdbgitlSnEGistcSfBNo7
	0jkZA==
X-ME-Sender: <xms:JVwDajtMm39EGY3V-rjuYxbjfygW3if6GmwlTuYG_tukfL2s82u1mg>
    <xme:JVwDai-1hivmuYrUh8NLpgk95t4q_oxBQ5o89eHgB9A1G7vH1BItb1iiNnYyTHN3i
    s2zUHndP43h3KqlrwI2wSMxekxOiA0z2Ycdd4RBe6c0WRdEFVZX_OE>
X-ME-Received: <xmr:JVwDatl6c84uXPJz6anY18HkesHvNbz3W-1rSPvke-o8O38F1R5_1i0b1bgEtG6NFtXLRucbjR_5Ee5pjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JVwDaiOQ_Obc4G1EXOYMaRLVyl4TMHmMET9gjct9UYt2ZAPWo5jNSg>
    <xmx:JVwDasIOTE2CcIbhVAzIqCBG5WWC3LK1fZv7dYy9FcXT3bc5pYkF4w>
    <xmx:JVwDatEStVFB7xWfWFJTCFZCN5MMQbnaMsZkUjOinFQ7Hu02Cop46w>
    <xmx:JVwDatDOWe40VGfVHjMpIh4b56UjOJqXsXvw5TOnzYoi-nCunPQVlw>
    <xmx:JVwDalYSfifnl5A57w96_SsVZlJHfRRLFewT8q9OVMZ15A4W4ZzA5PT8>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:58:12 -0400 (EDT)
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
Subject: [PATCH net-next v4 06/12] udp: Support gro_ipv4_max_size > 65536
Date: Tue, 12 May 2026 18:56:42 +0200
Message-ID: <20260512165648.386518-7-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512165648.386518-1-alice.kernel@fastmail.im>
References: <20260512165648.386518-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A365F52548E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-287245-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Action: no action

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c         | 5 ++++-
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp_offload.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3e92575f1d55..856c23b9d6dd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2583,8 +2583,8 @@ int udp_rcv(struct sk_buff *skb)
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
-	unsigned short ulen;
 	__be32 saddr, daddr;
+	unsigned int ulen;
 	struct udphdr *uh;
 	bool refcounted;
 	int drop_reason;
@@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
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
2.54.0


