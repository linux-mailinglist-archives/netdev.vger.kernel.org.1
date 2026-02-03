Return-Path: <netdev+bounces-256198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKI3IFm5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D848BD6835
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439F43038140
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355A2FE042;
	Tue,  3 Feb 2026 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="bMN1LWLO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9G6QHzU"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0702BE7C3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109244; cv=none; b=qZA8Vwb2HQXCfGJ8f0rBRtUai14Pt9sxe3iCaCkqJsMfGQT8xFBfwC8w+vKKC5XdjchzUZfaIRX9UGe3QiaGGTKhk9rvodttXVQjJsHRNM/PT+wrPgddJ1ztnQQOhy+6n7dRwvBauU6EMrDoahUXOAe2RDFMNbItytV/47jylxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109244; c=relaxed/simple;
	bh=kMDqKn1K5P9Ci6nFQOIURg4x0weYzDT0wWr8zsd7X4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGpcACxU4emRZrgxNK0vOAesZVl/O9EBvxg/ugXn/AwlniG4qZF7Gji/N3UZQLzrVHT9/TdSwB5iCTHKJcbUwoLidN1KgoH5c7djvJeLliJa+QQqxJ7p1bpZrw5w7Yu8/Ye7i3LiCtmeEN8RjCGchjcpl5vvOQcKx/f9dWKCMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=bMN1LWLO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9G6QHzU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 42B641D00095;
	Tue,  3 Feb 2026 04:00:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 04:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109242; x=
	1770195642; bh=6LbdKF4IbwX7bZdr8y6OrSJxFVHoodJg7GBSS61fiX0=; b=b
	MN1LWLO9dMAb514wAlylHeJcDhzifeLZcyGV92cbzpGTizZS8kx8KVjdXdGoAwNy
	gzgtP6km2/qzr48EqyPfiF8BgWAPiUt1TIFatDd1XRLScyo+AbBZP16nOr6wLeME
	+ERd3/kWFsJPqzgp2O/dxdiOqzNPR4HEl0ey1ar/CnV2Z3VwjWThIeGT6Ky9YXeJ
	x7fS2sd9XCI6oPOzDVuu3flK4UXCRKucFMwN9OELv6OLJkMF8YnVRvV1mI5fF+fi
	cx+mVfv1iQ7nP5pcl/0hIkLr14GOBNaFw/IV2UMeb2Rs5GPj+m7bjFVHHIR0hneI
	9lR+GBIYKl6Gl/WwFfFfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109242; x=1770195642; bh=6
	LbdKF4IbwX7bZdr8y6OrSJxFVHoodJg7GBSS61fiX0=; b=e9G6QHzUJERCtRHX+
	8N/ZVcbMaHdGFicpi3grF1dhp5NuFqzi2FJcv8+VSDfxgrwLS+K0N9gDKEG56AdM
	nsqjiWuAz9IZWcElQPYm8mQn8xmlIORArocfXLDK0EHUMSr54Cu5YYMowATET1vF
	amquGRDFp/1Ws5Y4+Ckm3gVHihqv04PO9A2FvT1M3AAeoMbWqp+OEX3AS4ADCRFs
	Kvpo82/gYDS8j6i4l0ba9ziJ1Zo4mA+6bfyHFxOZw+TCdQfZz+FfbYQnA+UucmjU
	EvQNY3Ed2NhHEJ4GPFq8FEOrqwxTgXPVYbZqrsy7z55bq0hxQdFMDWcwGZWII9C3
	dy76Q==
X-ME-Sender: <xms:ObmBaSMEcxt1Ep8A0qfzS265TPc2-0zDDiiY7TpPvm8a2j-D3zGMYQ>
    <xme:ObmBaXWzXoLgzoZk99HP-_1GmEWCLlk9qHetmRuNwohSS7x-Sy7GC8jZXDtPEwzE6
    7GfFgnGVnU1EBNB9-Dfc4S72SBHvTAmJ6eCT5QHyEn_v4Nz2cXPn-A>
X-ME-Received: <xmr:ObmBaVioWfrojjF1ptiNTdTzLg01B21u7upXeG5lSCuPxSN_gv3-Q58n69Ik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ObmBaQhd-QuGdFKcOBcxo7Af1Bd0A4_Y_S9z_boZ212-s4kWNMp2QQ>
    <xmx:ObmBaTHXC289dG6DypIUxRkXdtnxyxBqHq0KvsuPtUXb1M8ANihRNQ>
    <xmx:ObmBadDxNtgMYpeoteRCTvPgsssltgu25qWyO4eb4odNhCiUULkfoA>
    <xmx:ObmBaZC4UzKE8KrgWWQF4crOU6fPwW1XKb_WdGR_4zjxWJHq__MsEg>
    <xmx:OrmBaWbVNMj5cx7SlbDxuOfHlm4YMJSvZ_DmAzfPkOTYWBjAw6JreX8B>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:41 -0500 (EST)
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
Subject: [PATCH net-next v4 02/12] net/ipv6: Drop HBH for BIG TCP on TX side
Date: Tue,  3 Feb 2026 10:59:32 +0200
Message-ID: <20260203085942.2477583-3-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203085942.2477583-1-alice.projects@fastmail.im>
References: <20260203085942.2477583-1-alice.projects@fastmail.im>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256198-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: D848BD6835
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

BIG TCP IPv6 inserts a hop-by-hop extension header to indicate the real
IPv6 payload length when it doesn't fit into the 16-bit field in the
IPv6 header itself. While it helps tools parse the packet, it also
requires every driver that supports TSO and BIG TCP to remove this
8-byte extension header. It might not sound that bad until we try to
apply it to tunneled traffic. Currently, the drivers don't attempt to
strip HBH if skb->encapsulation = 1. Moreover, trying to do so would
require dissecting different tunnel protocols and making corresponding
adjustments on case-by-case basis, which would slow down the fastpath
(potentially also requiring adjusting checksums in outer headers).

At the same time, BIG TCP IPv4 doesn't insert any extra headers and just
calculates the payload length from skb->len, significantly simplifying
implementing BIG TCP for tunnels.

Stop inserting HBH when building BIG TCP GSO SKBs.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h  |  1 -
 net/ipv6/ip6_output.c | 20 +++-----------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 9dd05743de36..e9c7127aaef3 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -175,7 +175,6 @@ struct inet6_skb_parm {
 #define IP6SKB_L3SLAVE         64
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
-#define IP6SKB_FAKEJUMBO      512
 #define IP6SKB_MULTIPATH      1024
 #define IP6SKB_MCROUTE        2048
 };
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b9..ed1b8e62ef61 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -179,8 +179,7 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (!skb_gso_validate_network_len(skb, mtu))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -273,8 +272,6 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
-	struct hop_jumbo_hdr *hop_jumbo;
-	int hoplen = sizeof(*hop_jumbo);
 	struct net *net = sock_net(sk);
 	unsigned int head_room;
 	struct net_device *dev;
@@ -287,7 +284,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	rcu_read_lock();
 
 	dev = dst_dev_rcu(dst);
-	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
+	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
@@ -312,19 +309,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 					     &fl6->saddr);
 	}
 
-	if (unlikely(seg_len > IPV6_MAXPLEN)) {
-		hop_jumbo = skb_push(skb, hoplen);
-
-		hop_jumbo->nexthdr = proto;
-		hop_jumbo->hdrlen = 0;
-		hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
-		hop_jumbo->tlv_len = 4;
-		hop_jumbo->jumbo_payload_len = htonl(seg_len + hoplen);
-
-		proto = IPPROTO_HOPOPTS;
+	if (unlikely(seg_len > IPV6_MAXPLEN))
 		seg_len = 0;
-		IP6CB(skb)->flags |= IP6SKB_FAKEJUMBO;
-	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
-- 
2.52.0


