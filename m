Return-Path: <netdev+bounces-257171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBg7JpqehGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:43:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A0F3766
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1212A30680A8
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E322FE11;
	Thu,  5 Feb 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="m2uOijiO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IAfGzhF0"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0A22FE0E
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298784; cv=none; b=vFFAwoC2WTps+WgliEXBRva3gsQOy7nVYGg9gBu4dkpRylbGDyolcn5Ppzu2v8B+OOncGaAnMr4r8+33IjnCWAm8c9lCLJUrSjOaSeBbIhAfXgxPa4xWsl3iVGxW0SmJduLdowK9ZY7DjGdhHdCHJD6Fs54EyEM1G8qTpY2VBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298784; c=relaxed/simple;
	bh=DEWUgcPBWqI6gs4JJz6+dBK6QAA1soX9RSj/rrjd0fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCfE7842fzpya8i9By1fwt4MN5KXmxDNqmQR1ukj3ip/xrQXngN16u7y7+VaxZ0YwkPqnk9DVXav6r6VpMdBwFXLza2wpSThQBx3hxk1lCDHxAD29kGeqSGoolzTmc1zfVh6rVv/UuzEumVPBSAZ9SuuOFvFuIVrrxF9kAZCA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=m2uOijiO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IAfGzhF0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 21CB21D0014E;
	Thu,  5 Feb 2026 08:39:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Feb 2026 08:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298782; x=
	1770385182; bh=bQttmZxCzY2YbkwAx4NT39RFx8+OxZ8oWlgtqEVqERE=; b=m
	2uOijiOtt0yOSLegj1sIDCdrCUL7KwA7Gq+Y3aLGQcY+xpery5w1Ap8pyu1fZJEv
	bPEEwWWPxWoDSA5xeTs/y/9/T4Ux1PYpCanFa1PRS/jvSsjiDyiGKnyQLIhI7ymC
	KR/P4j6MwhugFT/wLBHaquLEclrmxAtYkmVRfTmoD9Y4Tdf9DJi91xbafjiqyP4M
	Gt3QkZcD6hDYQ6BYtDU8ZxWfMTrrLQ9n71o3lQhZu/IK7668LetTd3oQ+FgcXqVR
	GwFQ0mfYwWsN1kZNJMp8DdgMtqH4qzxtonbOqarLIrQ30V3aN2Vdc1NJCOWp9VSD
	XaViJ+OQyqT2X3y2RMdeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298782; x=1770385182; bh=b
	QttmZxCzY2YbkwAx4NT39RFx8+OxZ8oWlgtqEVqERE=; b=IAfGzhF0jWktRj+xI
	XWig4a2/Lzl0+YMUE2SC8dGQu00p6jAt2sFUxAesAS9GEBEMq4C+hwyu+4M3w+/3
	T7ZsdNupZRf/wVAM8N2djRsqxShaa4t/UkovieALR8Hb1fRHmcwFF4qqwhkRlkR6
	86yHNt0cIg+QCaT6/0lXNp5Bh+n1PaX9zhsQgZI5Tt9wKhW6Ss+MqJdl20mtMxbl
	O8Gb9zRtuOXAz0D90ycatPvvFtgi8jCIEFOUsZK+KCvlxHtWthCFQyGOcBaiHEPB
	I1fwSn2UmE7z4WTR0AYnPPwKdq2aaEQeRluQZHiMk3c6/QffM5/u4bSrS+6i790v
	786UQ==
X-ME-Sender: <xms:np2EaRVtjkyjtkUjLuNqP4zgdSNFlk_IeB-PxDX9euG0pC8PODp2wg>
    <xme:np2EaX_Oa6bxFOkg0HySHiY3PbPURz_MCCr_jq2CARF2Y3HfhrEOw_FX-Q9fSklyq
    yxwuxvvxkWHkJy9OU2-6h8EufBFtRSHnNy2wPCaXjTnqOdOU4S_1gHG>
X-ME-Received: <xmr:np2EaZoncbOZVo7J9-TiQJNXVK4KynHgkXQ63fbs1gy95otyzh9c3OeUo0NUJ0PfGHN9Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:np2EaSLYJ4SQ4lOlgvIOy7amkzx5tvRy4h3VlHzQU8K40W7XJs9f0Q>
    <xmx:np2EaUOdZ2V6VtPPWLcwpeLLfm8uNsmI-mtFVdFIbd4lMM0p1HlMbQ>
    <xmx:np2EaXpz1mULb6N1oyAA5ScFjrTSSB-16ueUiG_r5DG2sGkloWBujg>
    <xmx:np2EafKpdMKbq50E-GXZtEmpQKaRMvj6FCozbMpaTfQuMQt2Yxwh8g>
    <xmx:np2EaVDTra2kqysQv-fveTo9AoN1ktcopzBWAi3ZuuvtpGkbUirK7i7J>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:39:42 -0500 (EST)
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
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 02/12] net/ipv6: Drop HBH for BIG TCP on TX side
Date: Thu,  5 Feb 2026 15:39:15 +0200
Message-ID: <20260205133925.526371-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205133925.526371-1-alice.kernel@fastmail.im>
References: <20260205133925.526371-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,isovalent.com:email,fastmail.im:mid,fastmail.im:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E90A0F3766
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
index 54ecd910eb7f..c25565461ca6 100644
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
index e622a9e086cc..769c39fed1f3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -179,8 +179,7 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (unlikely(!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu)))
+	if (unlikely(!skb_gso_validate_network_len(skb, mtu)))
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
 
@@ -313,19 +310,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 						     &fl6->saddr);
 	}
 
-	if (unlikely(seg_len > IPV6_MAXPLEN)) {
-		hop_jumbo = __skb_push(skb, hoplen);
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
 
 	__skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
-- 
2.52.0


