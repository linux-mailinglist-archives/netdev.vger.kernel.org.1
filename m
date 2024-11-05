Return-Path: <netdev+bounces-141796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14879BC439
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28ED3B2182C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CE1B0F34;
	Tue,  5 Nov 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="jp4VZN+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkBG7mDi"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91B18EAD;
	Tue,  5 Nov 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780020; cv=none; b=gepOA+lPW6VUFU0TWjkYkmfCF8reCiNU5aoGj8diDXju/1OYmj0KESsKc0OU0vz8EbKpKE+oyCNHuyEm6+v4eNpfxhQbxg//X2RhugY05O8kply5Bkf9yjcOk22y4P/NyEdh2KnoJ4wU9Pm7+d1ohHYkH/mA4gDDO3MZ73EBPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780020; c=relaxed/simple;
	bh=Hflc0+87JnlcBytWKU2fU70vEYi2iKcTuzCeoN0jK5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+66vU02ynSBUwS9GW5nEE4sWeDeITH4lVTnqIMFW6gxJx28qaGeRvM29iZyZJs4VHTwpvaSvt9cwsuVSrJEImBQJeLNHWEgWD+sNE5A/7coLZXM7ecO7Q8uw/jSpwFzwGxL7jL4huEg1w5UiJrSBUD4PDgm9msBr7rzRM6vHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=jp4VZN+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkBG7mDi; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C3E911401A9;
	Mon,  4 Nov 2024 23:13:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 04 Nov 2024 23:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730780017; x=
	1730866417; bh=poszZiaDkROESBL/jBPL7xnIY1ZaNbC2N5EHfoJIcPg=; b=j
	p4VZN+iP6XHh7n5Q4DrKfqS1D/UvWdlMYPubBHaU47d9HWdaHfn4K6oLoiCIYN5L
	GLCpsbBDfpx0IZbn0mccl87KCmkFSwfANVWIXRdIpcRwCTVU/o77Ail+3WhMCAjm
	A/5aaefdyfJKuzPqFsL/24ux7bv88BuyCGHLK/ueJiY2PTuuN+bxAKByjFddo1V3
	+hbjD8ZSSwyVFZPTn4N0h7ugwxl6KD/uNe7Xs0xh1aHliY2Gm4KHzlLf+BqRm9BF
	/tAW8al+OaplviwnQUZfyqA+jkHunsqTUl0MfJjMWMgkGoFoy8Zz290DOLa7jLgY
	z0EidlhanWmZ7Ks/TGHng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730780017; x=1730866417; bh=p
	oszZiaDkROESBL/jBPL7xnIY1ZaNbC2N5EHfoJIcPg=; b=nkBG7mDi84vlQZX6d
	apZ8ohRcQUF0VM1+O5J7IkUpbf/NXwR4lNdV1jA+X2exDi2zZhkknXSiwOF0fN2s
	2NZiVFfOhOOoYPso3ffb7uby0xQ+Xy99jEb+QYkxmKFZywkIwdvL58AUHr//kfJF
	JQ5erWWU4twc7SG823WDvETtzqIJ2zasN6dVdwiKufQEWirwwzmg6EDhD8XAYjXW
	WuFuGKbOYpNO+51reIvH84iP4abEMI0MicDYrgtvxON43EW6VrxYdz8XckoA93jd
	CUJ/Pc4/qoPgVSTsXtOVTyn790jrzcH8wAtzc2bgsxVfjhwtPVrGQWS51dcJiXGV
	pkXnw==
X-ME-Sender: <xms:cJspZ1c4YMq4RE016PBjvFcM8MJwlIXL-LF3Bfw-0vqOJrlsGwj7fg>
    <xme:cJspZzNDwEfNqbfDraKOonsZn_ObFAKBmFm5AwPJZJ88x4OtykzT5zqUWsFIl88CZ
    XwqWWiyycO9VJrPNQ>
X-ME-Received: <xmr:cJspZ-jGoG3UPRalr1O1MOAlsoI-D0o3a7Fw2g-sNRYm5oSh4pArYblhnUvQx7-K2J6g9stwdxAXbGTOxOUYbW4zRfBhORYQwWWmhbVUBw9Gc4fy9g0i>
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
X-ME-Proxy: <xmx:cJspZ--M7PJzjmXYTYny65P-5pp-RJiTW-crqSrmE1l3UB0N2wk8Nw>
    <xmx:cJspZxuA7l_Nx_HrO2pxQRKABXDJBwJ4oUG62NA2EjrseeG08gdmvA>
    <xmx:cJspZ9FpbyPC2CntvmkwaFSdRX8a6FulmjARWI0NVHSwkVDTrWJ7Ow>
    <xmx:cJspZ4Nly2wYaK91BXl4WQINsQloDGDvMIppt-M487ATQOidFoJyTg>
    <xmx:cZspZylPMfWB3x8Ng5gRLrPdWM1UBkTw1qBYJO26-jEmqDVdGp4jWt31>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 23:13:35 -0500 (EST)
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
Subject: [PATCH net-next v3 1/2] bnxt_en: ethtool: Remove ip4/ip6 ntuple support for IPPROTO_RAW
Date: Mon,  4 Nov 2024 21:13:19 -0700
Message-ID: <a5ba0d3bd926d27977c317efa7fdfbc8a704d2b8.1730778566.git.dxu@dxuuu.xyz>
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

Commit 9ba0e56199e3 ("bnxt_en: Enhance ethtool ntuple support for ip
flows besides TCP/UDP") added support for ip4/ip6 ntuple rules.
However, if you wanted to wildcard over l4proto, you had to provide
0xFF.

The choice of 0xFF is non-standard and non-intuitive. Delete support for
it in this commit. Next commit we will introduce a cleaner way to
wildcard l4proto.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 6ef06579df53..41160aed9476 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1124,14 +1124,10 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	fkeys = &fltr->fkeys;
 	fmasks = &fltr->fmasks;
 	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
-		if (fkeys->basic.ip_proto == IPPROTO_ICMP ||
-		    fkeys->basic.ip_proto == IPPROTO_RAW) {
+		if (fkeys->basic.ip_proto == IPPROTO_ICMP) {
 			fs->flow_type = IP_USER_FLOW;
 			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
-			if (fkeys->basic.ip_proto == IPPROTO_ICMP)
-				fs->h_u.usr_ip4_spec.proto = IPPROTO_ICMP;
-			else
-				fs->h_u.usr_ip4_spec.proto = IPPROTO_RAW;
+			fs->h_u.usr_ip4_spec.proto = IPPROTO_ICMP;
 			fs->m_u.usr_ip4_spec.proto = BNXT_IP_PROTO_FULL_MASK;
 		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
 			fs->flow_type = TCP_V4_FLOW;
@@ -1153,13 +1149,9 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 			fs->m_u.tcp_ip4_spec.pdst = fmasks->ports.dst;
 		}
 	} else {
-		if (fkeys->basic.ip_proto == IPPROTO_ICMPV6 ||
-		    fkeys->basic.ip_proto == IPPROTO_RAW) {
+		if (fkeys->basic.ip_proto == IPPROTO_ICMPV6) {
 			fs->flow_type = IPV6_USER_FLOW;
-			if (fkeys->basic.ip_proto == IPPROTO_ICMPV6)
-				fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_ICMPV6;
-			else
-				fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_RAW;
+			fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_ICMPV6;
 			fs->m_u.usr_ip6_spec.l4_proto = BNXT_IP_PROTO_FULL_MASK;
 		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
 			fs->flow_type = TCP_V6_FLOW;
@@ -1285,7 +1277,7 @@ static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
 	if (ip_mask->l4_4_bytes || ip_mask->tos ||
 	    ip_spec->ip_ver != ETH_RX_NFC_IP4 ||
 	    ip_mask->proto != BNXT_IP_PROTO_FULL_MASK ||
-	    (ip_spec->proto != IPPROTO_RAW && ip_spec->proto != IPPROTO_ICMP))
+	    ip_spec->proto != IPPROTO_ICMP)
 		return false;
 	return true;
 }
@@ -1295,8 +1287,7 @@ static bool bnxt_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
 {
 	if (ip_mask->l4_4_bytes || ip_mask->tclass ||
 	    ip_mask->l4_proto != BNXT_IP_PROTO_FULL_MASK ||
-	    (ip_spec->l4_proto != IPPROTO_RAW &&
-	     ip_spec->l4_proto != IPPROTO_ICMPV6))
+	    ip_spec->l4_proto != IPPROTO_ICMPV6)
 		return false;
 	return true;
 }
-- 
2.46.0


