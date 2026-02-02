Return-Path: <netdev+bounces-255983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAsOHtf5gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5AFD07C1
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6627E301A91F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C023033E2;
	Mon,  2 Feb 2026 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Ifmjry0S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uc4cl+31"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D3303A37
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060237; cv=none; b=efpD35erLoDX5INdzB3zzx64HVIIC/8nSWl7ogxHTf0Jh/uYcFQdJSLnSQZkkNuooKG8kCNxY+4lEUvBPwmLs0ZbEGzMDC9pbTRfL1k9SU6NjdIZYrUYYYINPbcjezJIkxhZbzjOu+XcaHPFabZq3JDAnqqOXWRRuasftEtvYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060237; c=relaxed/simple;
	bh=MaFmchUAUFkE6fFK5honubpd8jcZaLBkaMFubqe07YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1EG+SQ2yeE/LWsNcQy0kFd7dc5j6TwN+o8bRZ9+I0MrQ898pd/bav3kg3cYl1WP+cbfIyeRrsQ6km+gtopcSnafHbxKwIGthFcqBX+X3u8ycuz5erla79djkhWFLxA3gA0ekE9wiV6PCz1ScCju1/lKfPVvgNE8C5R5hFzhBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Ifmjry0S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uc4cl+31; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44E937A0085;
	Mon,  2 Feb 2026 14:23:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 02 Feb 2026 14:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060235; x=
	1770146635; bh=yTaYqYulCB3l0YchCtlHx84KaiFBqORMjaSKTIeb5Zo=; b=I
	fmjry0S2JOyxiJIaN3GPBz5DpQSRmP9Ci51yRWS3AxU0J50vE04Gf69QKm5duThG
	Iq79uC2eWU0ydOSbcnA2XB2RuMGN6hK9KhQK32LJU1+/rRzwvaamDmSeAzraruqA
	mKw2zFxa+r47b2YVUZVvG2OxSHvpNn/px5wf2qPouRfqzWP2s2MFWKLqwxRytF0L
	nXGKvaiLTu06CBYMFKw6ydHNFYhODHRLvEnzfr/VeazodyLgVbEydF9uZv/N8Pkv
	trQkTxEbOBCpAHpGlFV1HlAu6mEIVGnDiap4vZINM/PCaWVBkJoxfLX5pFRRqIRi
	sWx2dVEVXgk/eHQZig/Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060235; x=1770146635; bh=y
	TaYqYulCB3l0YchCtlHx84KaiFBqORMjaSKTIeb5Zo=; b=Uc4cl+31l2HAdeD6m
	6oEy35D1jZca4gItfMeazBkKs4RPWpM2OtvtuJ54eydNK/yJF9PB5HJdFTB9vxMa
	QcJxHITDRG4esv353tsHtO6PcR19gGjYFtiYqwPqnA1nHMOqunJtFVjMpi5X1lmV
	B8qqZKqfIpNdRMFj/0oYiqw1hKzffU1f6/N5hdFC52WGdT7NUoJNL+S5LvxgEAQg
	i83+h2yWD2Xt9NsxmSxhz2/31Dx7mBOvkSqKz7lADniiECgjOErlJioW3uxiw6sQ
	M7LdWfL5Lc0Fr3CJiD4DOV0REOMMSrGL7EopkiFKBm2XVkddeR7xmZvmEolzIAMv
	6Dvnw==
X-ME-Sender: <xms:yvmAaaVHVMMUYDd_lb210aCOB5qe0BjNDh0RkEuYZ-RmFk1lESqGvg>
    <xme:yvmAacjgTIKf10SoFxnpyXEV1_x05mGyJxfFruuP6F_u-F-mRW9mCYVs-JaLMsWrD
    np6aBvI0q9_ID6NOaIbgJdSwMagUu5OOguIvG0AKU0b0Bnpl-gBOKQ>
X-ME-Received: <xmr:yvmAabgEfZp-kJVGnofVAirh-KnQo9yaAZdEK_XEW0lL-VzD6BIqS1s0MM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:yvmAaSFdApyZtbuF5L4V0DlGC4NGY_sVP0rzS_l4MQsSm3Sw1EUOjQ>
    <xmx:yvmAaQCZwxKdvwSQnsEt5PJ_nQ_lNetff6_ARezBA18KPCYvNZ6KYA>
    <xmx:yvmAaQAIrD6hQO9LpL2YSY9kuhQekDAoN9mysu2w88XuBbUO3y2sig>
    <xmx:yvmAaWNbNTzQNSXX7BuOIN1i3Xw_Mc1CNmICxwDJM6Vlnd_POKb72g>
    <xmx:y_mAaZw3M9GeL1Shpf8fBsUCli1HOYlUzTnCfjbOVCHOmY-BWsttEnn8>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:23:54 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
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
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 01/11] net/ipv6: Introduce payload_len helpers
Date: Mon,  2 Feb 2026 21:23:28 +0200
Message-ID: <20260202192338.2373930-2-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
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
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,isovalent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B5AFD07C1
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

The next commits will transition away from using the hop-by-hop
extension header to encode packet length for BIG TCP. Add wrappers
around ip6->payload_len that return the actual value if it's non-zero,
and calculate it from skb->len if payload_len is set to zero (and a
symmetrical setter).

The new helpers are used wherever the surrounding code supports the
hop-by-hop jumbo header for BIG TCP IPv6, or the corresponding IPv4 code
uses skb_ip_totlen (e.g., in include/net/netfilter/nf_tables_ipv6.h).

No behavioral change in this commit.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/ipv6.h                       | 20 ++++++++++++++++++++
 include/net/ipv6.h                         |  2 --
 include/net/netfilter/nf_tables_ipv6.h     |  4 ++--
 net/bridge/br_netfilter_ipv6.c             |  2 +-
 net/bridge/netfilter/nf_conntrack_bridge.c |  4 ++--
 net/ipv6/ip6_input.c                       |  2 +-
 net/ipv6/ip6_offload.c                     |  7 +++----
 net/ipv6/output_core.c                     |  7 +------
 net/netfilter/ipvs/ip_vs_xmit.c            |  2 +-
 net/netfilter/nf_conntrack_ovs.c           |  2 +-
 net/netfilter/nf_log_syslog.c              |  2 +-
 net/sched/sch_cake.c                       |  2 +-
 12 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 7294e4e89b79..9dd05743de36 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -126,6 +126,26 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
 	       skb_network_header_len(skb);
 }
 
+static inline unsigned int ipv6_payload_len(const struct sk_buff *skb, const struct ipv6hdr *ip6)
+{
+	u32 len = ntohs(ip6->payload_len);
+
+	return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
+	       len : skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr);
+}
+
+static inline unsigned int skb_ipv6_payload_len(const struct sk_buff *skb)
+{
+	return ipv6_payload_len(skb, ipv6_hdr(skb));
+}
+
+#define IPV6_MAXPLEN		65535
+
+static inline void ipv6_set_payload_len(struct ipv6hdr *ip6, unsigned int len)
+{
+	ip6->payload_len = len <= IPV6_MAXPLEN ? htons(len) : 0;
+}
+
 /* 
    This structure contains results of exthdrs parsing
    as offsets from skb->nh.
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index cf2203ff2bfd..024c2c2784cb 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -25,8 +25,6 @@ struct ip_tunnel_info;
 
 #define SIN6_LEN_RFC2133	24
 
-#define IPV6_MAXPLEN		65535
-
 /*
  *	NextHeader field of IPv6 header
  */
diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index a0633eeaec97..c53ac00bb974 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -42,7 +42,7 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		return -1;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
 	if (pkt_len + sizeof(*ip6h) > skb_len)
 		return -1;
@@ -86,7 +86,7 @@ static inline int nft_set_pktinfo_ipv6_ingress(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	if (pkt_len + sizeof(*ip6h) > pkt->skb->len) {
 		idev = __in6_dev_get(nft_in(pkt));
 		__IP6_INC_STATS(nft_net(pkt), idev, IPSTATS_MIB_INTRUNCATEDPKTS);
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index e0421eaa3abc..76ce70b4e7f3 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -58,7 +58,7 @@ int br_validate_ipv6(struct net *net, struct sk_buff *skb)
 	if (hdr->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 	if (hdr->nexthdr == NEXTHDR_HOP && nf_ip6_check_hbh_len(skb, &pkt_len))
 		goto drop;
 
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 3b28b84191be..58a33d0380b0 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -229,7 +229,7 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	if (hdr->version != 6)
 		return -1;
 
-	len = ntohs(hdr->payload_len) + sizeof(struct ipv6hdr) + nhoff;
+	len = ipv6_payload_len(skb, hdr) + sizeof(struct ipv6hdr) + nhoff;
 	if (skb->len < len)
 		return -1;
 
@@ -269,7 +269,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return NF_ACCEPT;
 
-		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
+		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
 		if (pskb_trim_rcsum(skb, len))
 			return NF_ACCEPT;
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 168ec07e31cc..2bcb981c91aa 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -262,7 +262,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	skb->transport_header = skb->network_header + sizeof(*hdr);
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 
 	/* pkt_len may be zero if Jumbo payload option is present */
 	if (pkt_len || hdr->nexthdr != NEXTHDR_HOP) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 32a104ead876..ceb4752a5358 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -366,12 +366,11 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
 
 		iph->nexthdr = NEXTHDR_HOP;
-		iph->payload_len = 0;
-	} else {
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		iph->payload_len = htons(payload_len);
 	}
 
+	iph = (struct ipv6hdr *)(skb->data + nhoff);
+	ipv6_set_payload_len(iph, payload_len);
+
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 
 	if (likely(ops == &net_hotdata.tcpv6_offload))
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 1c9b283a4132..cba1684a3f30 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -125,12 +125,7 @@ EXPORT_SYMBOL(ip6_dst_hoplimit);
 
 int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	int len;
-
-	len = skb->len - sizeof(struct ipv6hdr);
-	if (len > IPV6_MAXPLEN)
-		len = 0;
-	ipv6_hdr(skb)->payload_len = htons(len);
+	ipv6_set_payload_len(ipv6_hdr(skb), skb->len - sizeof(struct ipv6hdr));
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
 	/* if egress device is enslaved to an L3 master device pass the
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 64c697212578..f861d116cc33 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -949,7 +949,7 @@ ip_vs_prepare_tunneled_skb(struct sk_buff *skb, int skb_af,
 		*next_protocol = IPPROTO_IPV6;
 		if (payload_len)
 			*payload_len =
-				ntohs(old_ipv6h->payload_len) +
+				ipv6_payload_len(skb, old_ipv6h) +
 				sizeof(*old_ipv6h);
 		old_dsfield = ipv6_get_dsfield(old_ipv6h);
 		*ttl = old_ipv6h->hop_limit;
diff --git a/net/netfilter/nf_conntrack_ovs.c b/net/netfilter/nf_conntrack_ovs.c
index 068e9489e1c2..a6988eeb1579 100644
--- a/net/netfilter/nf_conntrack_ovs.c
+++ b/net/netfilter/nf_conntrack_ovs.c
@@ -121,7 +121,7 @@ int nf_ct_skb_network_trim(struct sk_buff *skb, int family)
 		len = skb_ip_totlen(skb);
 		break;
 	case NFPROTO_IPV6:
-		len = ntohs(ipv6_hdr(skb)->payload_len);
+		len = skb_ipv6_payload_len(skb);
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP) {
 			int err = nf_ip6_check_hbh_len(skb, &len);
 
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 86d5fc5d28e3..41503847d9d7 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -561,7 +561,7 @@ dump_ipv6_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Max length: 44 "LEN=65535 TC=255 HOPLIMIT=255 FLOWLBL=FFFFF " */
 	nf_log_buf_add(m, "LEN=%zu TC=%u HOPLIMIT=%u FLOWLBL=%u ",
-		       ntohs(ih->payload_len) + sizeof(struct ipv6hdr),
+		       ipv6_payload_len(skb, ih) + sizeof(struct ipv6hdr),
 		       (ntohl(*(__be32 *)ih) & 0x0ff00000) >> 20,
 		       ih->hop_limit,
 		       (ntohl(*(__be32 *)ih) & 0x000fffff));
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index fd56b7d88301..d2bbd5654d5b 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1279,7 +1279,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 			    ipv6_addr_cmp(&ipv6h_check->daddr, &ipv6h->daddr))
 				continue;
 
-			seglen = ntohs(ipv6h_check->payload_len);
+			seglen = ipv6_payload_len(skb, ipv6h_check);
 		} else {
 			WARN_ON(1);  /* shouldn't happen */
 			continue;
-- 
2.52.0


