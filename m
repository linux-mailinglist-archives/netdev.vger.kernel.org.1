Return-Path: <netdev+bounces-141797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D19BC43C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F211C211EB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F91B6D04;
	Tue,  5 Nov 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NdfwSf6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDlKsNgw"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587181AF0B5;
	Tue,  5 Nov 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780022; cv=none; b=YQBPZPI1kyqzaD4Ziy/vZqzkHD0mBfaok33i1l4BdO2mCVXhe+ddLrTNlcTY74GECczIHLJ1C/fioKRn0NwcJXyd1AfwjRtjEzHZb6fbRM06AaIg2yIpovuF+1YCTW/d4VcXa1WcYjkss5PkHEgNB1L/X0guPvzUdRZsEC7BZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780022; c=relaxed/simple;
	bh=tr4lJVk02n088ptgm1RPgK2itrhiK0fzr9dZLHDpNJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AobMOByogsivaMkkhXTwJdGq5D7iUyCxr2hIirCnieVut5LM5a23HPYaw7JmjKM1DezfoB6vaiitzrzzOGfzqrbssYJk4Z1IPDpx9Yl1n0PQhlNfc09babE4X3pPXvRx36hRDazu1e6Ph/kt4VlIP7Ksl5BoHByXH0MxCZ+HfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=NdfwSf6Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDlKsNgw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DD6411401C6;
	Mon,  4 Nov 2024 23:13:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 04 Nov 2024 23:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730780019; x=
	1730866419; bh=5U8yRCa69z0U5gKhi50bWHdbycRDn44AWGrPvfvbzUg=; b=N
	dfwSf6Y6AG/8Dt9jbTEOQOjufuKyDtGBDnW8Km9AL3k4ZkHtdQdXjiOudNWGnWni
	x1eagZ4Ad87Aw5rniV9UiMI3T/0YTqfn+elUvai0qXPSDhLqhalizFgOJYZlCLNg
	xJnY0ItPCYaBcXQLm3E/rIS1mozG7gZIyRKQ4dJ6uSKc5fuJ92TwT+KFTKXaH0Wr
	1rBgCcMHjrbOzk9TqA2kKMTE3XKpdXypVZ8Q27xpIakNr1Qk0bIz8MdQYUCkSLXR
	VHOwSTHGWg9v+M7kC5b19MZjicc5JwbeYZmjygqDJtSAo/5KhdI7uWhDGIXWUFce
	EAZxGJvr1yy7wrKP3jCbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730780019; x=1730866419; bh=5
	U8yRCa69z0U5gKhi50bWHdbycRDn44AWGrPvfvbzUg=; b=oDlKsNgwMyyAKlKzR
	yo92hZwdBwNhVbrZopj4+IpIKxixDe3XJVCA/wlUBfdhNiiDIEsJ/HCpJnJWiUQd
	Bc407yTPlkJmzJgkBqtYnEBmWxL3zOZmslLLATZV1oHlwHqo0To05/z4BdmJvINw
	q2yH7jhtGTFhMRMaw5dhH4+ebrvjldMNo9bxNfCgNmpebRVOXVQUlZxHUdctxlnZ
	9K4AM3YQDs1LMi9lA0y/Cpjq+OTmsvx8C76/rp3tyCqY5y0W0lf0nPTmOWGhug7o
	ss4tCV6BglpawkLH4LAn9onDn0lhxIf0x6ISJ0nlPIDHf8h6CbplPVnd4OJkOsNb
	bOlgQ==
X-ME-Sender: <xms:cpspZzf2mjBdTjOIcbU4WykSu9-Nhxn4jslQw0Ro8Vgy_8NAnTIMIQ>
    <xme:cpspZ5Nb2t84TjBX4U2Q_QvEdHZ-hfMPljaJSRthCAgq4UVxSBbceqHqJlVuQgYGW
    PEHYT2i34zbO2FdwA>
X-ME-Received: <xmr:cpspZ8hnI1vX4S2SZyQ9Jwu8VySWft4QyYEHrQ2GRXeQsUW0eg08B_a8HA1FHNajEfIqFsUUsdWJKpwBqvlaz2VgPaMLAJDHFaR1xpdg-G1PTvQ6EYMB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmihgthhgrvghl
    rdgthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrth
    hinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cpspZ09MlP6aYT1LSoFgvJaPnWF6GZEC3qzrmaWx2Sik_1cW0PyyHg>
    <xmx:cpspZ_s7y7jJj0J4Q3UTE6NNRw1f4DXU5ppa3cZqzuub2RhQzI4Yxw>
    <xmx:cpspZzGotrxVRV2fEFE9JLSLkyCDqpPt-ZTwo-7qBvPkBBqL6G2fTQ>
    <xmx:cpspZ2M0q3I9QwoXW99_EGkofoQVChQWqV3ON45ISEkwAjU9EmsPNA>
    <xmx:c5spZwnDNGB43mi-WYWWpLxMz-_Btt__FmO478Ke0RcnSOCsN89qT7i9>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 23:13:37 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrew+netdev@lunn.ch,
	edumazet@google.com,
	michael.chan@broadcom.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	martin.lau@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net-next v3 2/2] bnxt_en: ethtool: Support unset l4proto on ip4/ip6 ntuple rules
Date: Mon,  4 Nov 2024 21:13:20 -0700
Message-ID: <1ac93a2836b25f79e7045f8874d9a17875229ffc.1730778566.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1730778566.git.dxu@dxuuu.xyz>
References: <cover.1730778566.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, trying to insert an ip4/ip6 ntuple rule with an unset
l4proto would get rejected with -EOPNOTSUPP. For example, the following
would fail:

    ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1

The reason was that all the l4proto validation was being run despite the
l4proto mask being set to 0x0. Fix by respecting the mask on l4proto and
treating a mask of 0x0 as wildcard l4proto.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 31 ++++++++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  1 +
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 41160aed9476..cfd2c65b1c90 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1124,7 +1124,12 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	fkeys = &fltr->fkeys;
 	fmasks = &fltr->fmasks;
 	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
-		if (fkeys->basic.ip_proto == IPPROTO_ICMP) {
+		if (fkeys->basic.ip_proto == BNXT_IP_PROTO_WILDCARD) {
+			fs->flow_type = IP_USER_FLOW;
+			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
+			fs->h_u.usr_ip4_spec.proto = BNXT_IP_PROTO_WILDCARD;
+			fs->m_u.usr_ip4_spec.proto = 0;
+		} else if (fkeys->basic.ip_proto == IPPROTO_ICMP) {
 			fs->flow_type = IP_USER_FLOW;
 			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
 			fs->h_u.usr_ip4_spec.proto = IPPROTO_ICMP;
@@ -1149,7 +1154,11 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 			fs->m_u.tcp_ip4_spec.pdst = fmasks->ports.dst;
 		}
 	} else {
-		if (fkeys->basic.ip_proto == IPPROTO_ICMPV6) {
+		if (fkeys->basic.ip_proto == BNXT_IP_PROTO_WILDCARD) {
+			fs->flow_type = IPV6_USER_FLOW;
+			fs->h_u.usr_ip6_spec.l4_proto = BNXT_IP_PROTO_WILDCARD;
+			fs->m_u.usr_ip6_spec.l4_proto = 0;
+		} else if (fkeys->basic.ip_proto == IPPROTO_ICMPV6) {
 			fs->flow_type = IPV6_USER_FLOW;
 			fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_ICMPV6;
 			fs->m_u.usr_ip6_spec.l4_proto = BNXT_IP_PROTO_FULL_MASK;
@@ -1274,10 +1283,12 @@ static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
 					struct ethtool_usrip4_spec *ip_mask)
 {
+	u8 mproto = ip_mask->proto;
+	u8 sproto = ip_spec->proto;
+
 	if (ip_mask->l4_4_bytes || ip_mask->tos ||
 	    ip_spec->ip_ver != ETH_RX_NFC_IP4 ||
-	    ip_mask->proto != BNXT_IP_PROTO_FULL_MASK ||
-	    ip_spec->proto != IPPROTO_ICMP)
+	    (mproto && (mproto != BNXT_IP_PROTO_FULL_MASK || sproto != IPPROTO_ICMP)))
 		return false;
 	return true;
 }
@@ -1285,9 +1296,11 @@ static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
 static bool bnxt_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
 					struct ethtool_usrip6_spec *ip_mask)
 {
+	u8 mproto = ip_mask->l4_proto;
+	u8 sproto = ip_spec->l4_proto;
+
 	if (ip_mask->l4_4_bytes || ip_mask->tclass ||
-	    ip_mask->l4_proto != BNXT_IP_PROTO_FULL_MASK ||
-	    ip_spec->l4_proto != IPPROTO_ICMPV6)
+	    (mproto && (mproto != BNXT_IP_PROTO_FULL_MASK || sproto != IPPROTO_ICMPV6)))
 		return false;
 	return true;
 }
@@ -1341,7 +1354,8 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 		struct ethtool_usrip4_spec *ip_spec = &fs->h_u.usr_ip4_spec;
 		struct ethtool_usrip4_spec *ip_mask = &fs->m_u.usr_ip4_spec;
 
-		fkeys->basic.ip_proto = ip_spec->proto;
+		fkeys->basic.ip_proto = ip_mask->proto ? ip_spec->proto
+						       : BNXT_IP_PROTO_WILDCARD;
 		fkeys->basic.n_proto = htons(ETH_P_IP);
 		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
 		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
@@ -1372,7 +1386,8 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 		struct ethtool_usrip6_spec *ip_spec = &fs->h_u.usr_ip6_spec;
 		struct ethtool_usrip6_spec *ip_mask = &fs->m_u.usr_ip6_spec;
 
-		fkeys->basic.ip_proto = ip_spec->l4_proto;
+		fkeys->basic.ip_proto = ip_mask->l4_proto ? ip_spec->l4_proto
+							  : BNXT_IP_PROTO_WILDCARD;
 		fkeys->basic.n_proto = htons(ETH_P_IPV6);
 		fkeys->addrs.v6addrs.src = *(struct in6_addr *)&ip_spec->ip6src;
 		fmasks->addrs.v6addrs.src = *(struct in6_addr *)&ip_mask->ip6src;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
index e2ee030237d4..33b86ede1ce5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
@@ -44,6 +44,7 @@ struct bnxt_led_cfg {
 #define BNXT_PXP_REG_LEN	0x3110
 
 #define BNXT_IP_PROTO_FULL_MASK	0xFF
+#define BNXT_IP_PROTO_WILDCARD	0x0
 
 extern const struct ethtool_ops bnxt_ethtool_ops;
 
-- 
2.46.0


