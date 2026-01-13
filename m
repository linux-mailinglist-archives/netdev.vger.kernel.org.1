Return-Path: <netdev+bounces-249591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE9D1B656
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A142E302EA22
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44134329E4E;
	Tue, 13 Jan 2026 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="bZSP1Br9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXJ3rbwV"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774803242B5
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339665; cv=none; b=kOqLMsZIjbT+hVT/atSTDiU4/1SrM0dm9pRnJySug64widHMgPhTieY+CWoaPBn+yB7u0ulxso1WSzaPblul7dk5dSUrFpQUuWYbTmU2b0P6oyI01EdWafRdNY/ULOpZMh0+sbHzvAq9kh/vxgx6ZHybi6IMeTiOtvJM4Yb+Uu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339665; c=relaxed/simple;
	bh=GOaC3GFPCYe7EGe9tE80fZK7oF1kspRjiyDRjApM39Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taiOudodC5plsY72c2s8V1+CY1z3meyIYLqPdkVFSpU4oygG79UPZp/Zq2I7W6SRoTzK6NrjktLREYB5Br5jYpDpNLIAXswTRzSyrPDGvN3nfY881ajYNa/AcLq6M3SeaIGDEa8mHaLbPmnLj2CWiQSICvfKk+DAe3QGus9ct4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=bZSP1Br9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXJ3rbwV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE578140001F;
	Tue, 13 Jan 2026 16:27:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Jan 2026 16:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339662; x=
	1768426062; bh=QdynlgnTtZWSH2GJBUkGCtTncNLNXDyX8tztADSxgEk=; b=b
	ZSP1Br9AzVEyMelRvc1mXv+OvzYG9bd7brudUo1bCyXovCTfeqGQFJrUy59iiANm
	c4TCXP6z5zxOdGXEJGo6ho62kMpjtHcdHrlXDqGQJg0TTe1Z95/edBNro8XrFSUP
	iyHUqMhYRt3fwla322IynDUCU/SOp2+SGtIXk/SJNaye5976j6y8aQqoIeRe2BbJ
	fEMUnCYhaL++tVhz92v3fRIlbSRp81D+qSDLS8SLVJE5TePZTW9herIpMcCoAHQj
	XvrqjW/ANE37kQNGf6ynxqU7AJMohu04U0yh+Yf0xDSNXJY8tLgD2S/HLfOJ5mVP
	G2XAlF8f1JIyOH4nqGenQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339662; x=1768426062; bh=Q
	dynlgnTtZWSH2GJBUkGCtTncNLNXDyX8tztADSxgEk=; b=ZXJ3rbwV048XiHqqI
	xY9KJvbdoobjrMLJ6s1X3vAxCltbtHKlW0R9dAyvn65gi7v7Uu6APhTFdalZj9+I
	C+5zmoKi4lSNtLlu8ArnjbSPzO6I7He/5pGQmCAwPy1KG2aihBTLjzqFgD2Sr9E/
	UKGF9B1MsFBQkYm0AzG5CGs1LiWYspIm78ExTYr/rgM6ndewvOGxCeHdvCgWPumi
	j4hBAV1a/5/fmrkFM/ipjRpnn3zxXB/zrJFBP/QYNO5jb4iP52c7P2Mo9WDbCPwA
	5FkB1trWm45mDQ4iESqc4f4EAI576sbBQMXnItqKyurDlQXxtb5DtKuHZcI03m23
	+SfSA==
X-ME-Sender: <xms:zrhmaaEIF02OPQjT0534GI5XUB_k9TV1-guavfg1fLYCkO4w2BunIw>
    <xme:zrhmaRvRZWlbCRPT9qX-1NeYV8_RMS1mXP5jGdpKGOAfruDKymvykjbIe-fiDCXL-
    0lzQb6QcJb0eVr4l-TxFmkMMrqljv33GiZ7HbJZYoEdy2_PNIG1bxE>
X-ME-Received: <xmr:zrhmaQZsDAYdEakFrZ4io9cb_s53vtTAAyHJU40AxVEU5xEIzTPEg7UsWDNv7mN1h5mYoHwIzMN3k4OqsGsUl0dV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:zrhmaR4CTevIr3BEyhD_4ND52H_n6ay-sYRK5Bg9Y2QFJo3rS6fZDg>
    <xmx:zrhmaY_lQvCER3x_Ww1shGbXgj-jdbi32YfF3AHp_wfnFz_32Z8Xsg>
    <xmx:zrhmadaDOBa39dJ7CRAm9Ohk9falQHTsVq3sr4ihBJOzPriOF3Iiow>
    <xmx:zrhmaR5JuNOyu-myQyFgsaKBpO1aTZahBqRK26Yt2LaD_9GiRCTOwg>
    <xmx:zrhmaSypOoVCjb-0TzAXKhXVVFSvk-ySKUJMYQZ9m5FlsbbbSMohjIBG>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:41 -0500 (EST)
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
Subject: [PATCH net-next v2 02/11] net/ipv6: Drop HBH for BIG TCP on TX side
Date: Tue, 13 Jan 2026 23:26:46 +0200
Message-ID: <20260113212655.116122-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113212655.116122-1-alice.kernel@fastmail.im>
References: <20260113212655.116122-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


