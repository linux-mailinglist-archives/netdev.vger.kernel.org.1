Return-Path: <netdev+bounces-261574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLJiCG2roGlulgQAu9opvQ
	(envelope-from <netdev+bounces-261574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:22:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A21AF080
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848E13072D8F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73793453491;
	Thu, 26 Feb 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="EZmRRfJP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUqJqp02"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221D42885D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137017; cv=none; b=lABY600n5dmJioLXxYqWpAjwEO8EGBVzj2RvPEaldhAE+8gpras81I4QF2j2djQdwIlNLen6kkd05dqtuw1++RENhiyipKQNiZZXbnoqsWsFZgObpMuZZAntasHMzmAek2xc7xvwK9BvYNhC9kpOAVqgUHHGSU6jhVIjcI6e8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137017; c=relaxed/simple;
	bh=o6dzHTL63Dkh9vz0VrZBggCB4ldOZEOlX1uVEeDPl3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvZDPsOn4XqWsm4yUi1dFljAdI9SOI6OI07xeAUSxecGvvQG8rtQIoKnpVTXlW6KHoxcf/xJjfdchE/lmw2en+TpM8m5skEOiXG9wjtK6xjvq8AxGRVY8GwF0zt84F7QZugnS/6V35NcnL/EUGnALhs+G150oXnL9x0To7qp9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=EZmRRfJP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUqJqp02; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0962A1D0012B;
	Thu, 26 Feb 2026 15:16:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 15:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137014; x=
	1772223414; bh=XpqGbxyADcc6X3q5CaVz4i2HgnicCQck69O+EO7nb+Y=; b=E
	ZmRRfJPRJ8ZNao4Qcak57AqIDExb7b3sy1EGtBCgEP5FgOjuP9h46irIIn6j0oSx
	fqjtH19lfNtH0DCd9ng9vfu4gSw/FjuZggcNGrAWAIHy0U+8tc4eVwBVWjzidvni
	8cv8zWhM+NGXGofNKH+z87cOlX5BWdU1XxDhu5kOUeeXZ/+VbDLmli3PSMAgonOw
	4g9KAQl9XQYy9aBCvd6MxYILkvpiCgO45/kcNjTZjZxrlwV06ZhEK8I4KzlsAI3I
	NHyB23iUc82+J/voZvQ1o990ZwTXsqATPTSJMuyJLZoVMluSuN3o6X1hLNlBsl7G
	PMKG5njxNjCPxqtfDW3SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137014; x=1772223414; bh=X
	pqGbxyADcc6X3q5CaVz4i2HgnicCQck69O+EO7nb+Y=; b=lUqJqp024gOvqQ075
	JrRQuhb5JWHopzxSyIHdNqcQicPmy/7Kme9ZjLQluf2ge9TuRQBo4v1vN5uyNpH/
	wG5+OD8KVyYZqOnFOur4DGohcgXKoB48noGON+M2rFYhv9JaFg4hVM+hf77w8B0l
	02nkqpadg3djEg890/EMTT8kD53pjIbQWSKyFXIhmtDIwByLueDtrOOika/D46cS
	drsgGUgaq42djNvGbGny6JN/bq937+5AFN+N49pasn2rekyDpE6t7J6CxP1AOSWf
	zqfSZpIQBpUy1VCJmqDKeKWvtHMJ9ssjXWHZFtr7oXkB+fPGrVXtlgO23SXk+amG
	it3Vg==
X-ME-Sender: <xms:NqqgaWdrZ4XRBa2seBPpHg3I6oGYAiit0PgOxCn1jjceBApgNmUYyg>
    <xme:NqqgaQq4JUARoBy9vot_QtJsxEsq3Zw5NE-Rs6D3JstmbVTVNPSGq36BYbnPcClcc
    hm86at21X2okA8HT0uhI5s-We8c9cDAql_VQiHIB1mFqcjtE2WBDA>
X-ME-Received: <xmr:NqqgaXTIg-mfXZQBRlySgBZFZxGs6niGrfHmfmyA3WzH3UkK88MrTlDepZlekg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:NqqgaQVhtowxHu_A1ztkGNd0EiWYQyNIhXGdJkBjsMtujUvRtgnSbw>
    <xmx:NqqgacfXGKbFdU8U7Qq8sFmxGIKSMdUzgE17ueUstKweRDbCWgfaAQ>
    <xmx:NqqgaTwJmDu9eqw3y8vyJNlYgkrAuGnhuy0Bo0dzk2j5cM34tTVQ7w>
    <xmx:NqqgaXFeqZcNe71Gkl8E4WaJHL9IasYkWR91-bSLaosjt2QLyrKntA>
    <xmx:NqqgaUVvS3Qzyd_kPF3djA7rb-1MpG3jOh57jVwf6JkQ6uxV4PcGsMhO>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:16:54 -0500 (EST)
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
Subject: [PATCH net-next v2 06/12] udp: Support gro_ipv4_max_size > 65536
Date: Thu, 26 Feb 2026 22:15:54 +0200
Message-ID: <20260226201600.222044-7-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226201600.222044-1-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,fastmail.im:server fail,isovalent.com:server fail,messagingengine.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261574-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,isovalent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 455A21AF080
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
---
 net/ipv4/udp.c         | 5 ++++-
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp_offload.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 345ef93001fc..870b35107ede 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2690,7 +2690,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 {
 	struct sock *sk = NULL;
 	struct udphdr *uh;
-	unsigned short ulen;
+	unsigned int ulen;
 	struct rtable *rt = skb_rtable(skb);
 	__be32 saddr, daddr;
 	struct net *net = dev_net(skb->dev);
@@ -2714,6 +2714,9 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		goto short_packet;
 
 	if (proto == IPPROTO_UDP) {
+		if (!ulen)
+			ulen = skb->len;
+
 		/* UDP validates ulen. */
 		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
 			goto short_packet;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 2f35b485ff40..780df257a8d9 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -920,7 +920,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	struct sock *sk;
 	int err;
 
-	udp_set_len_short(uh, newlen);
+	udp_set_len(uh, newlen);
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
@@ -958,7 +958,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index bfe0d7104e8a..37b90ad9f9b2 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -172,7 +172,7 @@ int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
-- 
2.52.0


