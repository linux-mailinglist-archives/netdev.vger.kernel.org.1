Return-Path: <netdev+bounces-141182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5D9B9D79
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 07:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13781C21816
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496C147C91;
	Sat,  2 Nov 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="XWeXwebb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TuhLkC6J"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D81448E3;
	Sat,  2 Nov 2024 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730529545; cv=none; b=Wzs1Sp5YIcSNmbawI/uSATXHeXrjKpBWfpBD1KEN6xYKXgHanzybg3O4EMSd/xlEmu37GinupB/ahFPd80Es9Ywmt8JWpA8eB2L9BxxqAfAwHA+rbXGS6jP8eA+04+Qlt4RKwgvyQViZQQRh8DSAP2ZHUi/4epzs2lQ+ZRn7x54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730529545; c=relaxed/simple;
	bh=0qbL3Tdj7h8MluOWe1hTR6oaeqAjyindg0/tGLHCweE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6/M2sH7V0ZefIuAWfMJfYY1EAuAjDEZyt+pzsIxGuGMbtrCkmKWm+VTBTaCRO5JKnI8La1dMMqKjF6r9syP8p1KQehNUpkHRl+AvcBgZbNYpdeztjWNzvUbeJTOObEWLDx31axFP5NkN7GyhOBKiqSFiOs808ELlbBLmhXm/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=XWeXwebb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TuhLkC6J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A6F9138025C;
	Sat,  2 Nov 2024 02:39:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 02 Nov 2024 02:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1730529541; x=1730615941; bh=tW5i81dGeS/Tcdwfl+DNK
	gawU6jlm57FrL/Kr1n05gg=; b=XWeXwebbrE8cSmvJacq6sa/TSrccAW+q7tIv1
	0zVB/areTSYULlfmpbaSLz8mwzfwBCcMypo9lh1jOS0RRwf7J87mLB65b7+QWK61
	VhNorRqeUM0ES1tDZ3PBOugQmh6jSxHtGirPiUWEVv0WeXgrSJs52Hf3+sqEVN4x
	YiO4QHPB+SR1/Bubi2FjlnYS/uZ3ZnXzLhkdjvSsweYMsfZevgRYYLzlAocAl4Q8
	AtnSZg46OTgh5UzktsX5Uz6p/Ur1RkUhjDWi8F4eQJsZymIIbbA1uPnOQnJ+0Vj7
	KOi4iOUmkv+yv9G0fP1tEkCQHwAKGnjSQK5VPIg9O8fVjMppQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730529541; x=1730615941; bh=tW5i81dGeS/Tcdwfl+DNKgawU6jlm57FrL/
	Kr1n05gg=; b=TuhLkC6JkwGDr3mVgYyjcVlKObxB5529nZzVy38bOm0fceX1zRN
	rceSE//8MjVPD0kgNtg3DQxlo63xAYYNJN1uk0QODChyGvmAPGodXDbOMAyOCl4P
	1bXKVDcN5oFxb9tFk5Smv0bBYbIWEFUrl6x+LJ15keF9nwQTbFVVDsjdWgI4PZbm
	SXyJRlXlwY/JJETnLpO9qHXW61R2fzRcYlnoihPfE7/rO8a+bS2n+xR8TTQaUGyv
	CClbKteR7vivmDclQ+2/GmSQq2IIxvif1SkCRwFq5FHh10cT4tACjBDGgSLfMXHM
	QIDXGCQ3xZlcaapaIPLUz8iNE2UZJMgI/xg==
X-ME-Sender: <xms:BMklZ3Sih_tdPaRhMvoCSLOlQr_ydDV0QBFLP7Lp7bk_Q5H9v3K79Q>
    <xme:BMklZ4x_mpemKahdNYTzLv40Pp5DaYgtyg9HHzNW-0trM7fH2uJ9ul3smpS1DXwMm
    fuzX1OMz4uckr7u-w>
X-ME-Received: <xmr:BMklZ81u0E8XvuNnaG0L306305beajxrPyOBIceVscr2gKVNUohCvuviqPfFNXgoucak9QJzTTBhNiB5PA6k3fTinRaDePwmCrmj--SAgzIeTzhkEtwm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepphgrvhgrnhdrtghhvggssghisegsrhhorggutghomh
    drtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghnughrvgifrdhgohhsphhouggrrhgvkhessghrohgruggtohhmrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehmihgt
    hhgrvghlrdgthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepvhhikhgrsh
    drghhuphhtrgessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:BMklZ3DHKm9aL1X_W8AONPNMyfNbVZdRCF3LYV0gUnxcV8Qz5NLZ-g>
    <xmx:BMklZwhP6fueHGhDQiZsPQkyg3aBggTz6HDMhJMvkVQ9fqo6o1tNxA>
    <xmx:BMklZ7pynis25-3AupC15kPWStDtO_V3qxPXrGbbQqkSD2d5FSrM6g>
    <xmx:BMklZ7iGn299E_Nc3cdl1JX4fFae_gsw4wKiZDszwD3ExHOJlBf9xA>
    <xmx:BcklZ_SJ04jm7_pymXXQvx-I_xgp7oklRC4z7B3vwZjk6NS9X8XmhVD7>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 02:38:59 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	kuba@kernel.org,
	andrew.gospodarek@broadcom.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	vikas.gupta@broadcom.com,
	martin.lau@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net v2] bnxt_en: ethtool: Fix ip[4|6] ntuple rule verification
Date: Sat,  2 Nov 2024 00:38:48 -0600
Message-ID: <6fbf2d80b646ca405bd44ccd54f173f2bb92367a.1730522118.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, trying to insert an ip4 or ip6 only rule would get rejected
with -EOPNOTSUPP. For example, the following would fail:

    ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1

The reason was that all the l4proto validation was being run despite the
l4proto mask being set to 0x0. Fix by respecting the mask on l4proto and
treating a mask of 0x0 as wildcard l4proto.

Fixes: 9ba0e56199e3 ("bnxt_en: Enhance ethtool ntuple support for ip flows besides TCP/UDP")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
Changes from v1:
* Set underlying l4proto to IPPROTO_RAW to fix get path

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f71cc8188b4e..76e62be4f4f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1289,10 +1289,13 @@ static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
 					struct ethtool_usrip4_spec *ip_mask)
 {
+	u8 mproto = ip_mask->proto;
+	u8 sproto = ip_spec->proto;
+
 	if (ip_mask->l4_4_bytes || ip_mask->tos ||
 	    ip_spec->ip_ver != ETH_RX_NFC_IP4 ||
-	    ip_mask->proto != BNXT_IP_PROTO_FULL_MASK ||
-	    (ip_spec->proto != IPPROTO_RAW && ip_spec->proto != IPPROTO_ICMP))
+	    (mproto && mproto != BNXT_IP_PROTO_FULL_MASK) ||
+	    (mproto && sproto != IPPROTO_RAW && sproto != IPPROTO_ICMP))
 		return false;
 	return true;
 }
@@ -1300,10 +1303,12 @@ static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
 static bool bnxt_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
 					struct ethtool_usrip6_spec *ip_mask)
 {
+	u8 mproto = ip_mask->l4_proto;
+	u8 sproto = ip_spec->l4_proto;
+
 	if (ip_mask->l4_4_bytes || ip_mask->tclass ||
-	    ip_mask->l4_proto != BNXT_IP_PROTO_FULL_MASK ||
-	    (ip_spec->l4_proto != IPPROTO_RAW &&
-	     ip_spec->l4_proto != IPPROTO_ICMPV6))
+	    (mproto && mproto != BNXT_IP_PROTO_FULL_MASK) ||
+	    (mproto && sproto != IPPROTO_RAW && sproto != IPPROTO_ICMPV6))
 		return false;
 	return true;
 }
@@ -1357,7 +1362,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 		struct ethtool_usrip4_spec *ip_spec = &fs->h_u.usr_ip4_spec;
 		struct ethtool_usrip4_spec *ip_mask = &fs->m_u.usr_ip4_spec;
 
-		fkeys->basic.ip_proto = ip_spec->proto;
+		fkeys->basic.ip_proto = ip_mask->proto ? ip_spec->proto : IPPROTO_RAW;
 		fkeys->basic.n_proto = htons(ETH_P_IP);
 		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
 		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
@@ -1388,7 +1393,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 		struct ethtool_usrip6_spec *ip_spec = &fs->h_u.usr_ip6_spec;
 		struct ethtool_usrip6_spec *ip_mask = &fs->m_u.usr_ip6_spec;
 
-		fkeys->basic.ip_proto = ip_spec->l4_proto;
+		fkeys->basic.ip_proto = ip_mask->l4_proto ? ip_spec->l4_proto : IPPROTO_RAW;
 		fkeys->basic.n_proto = htons(ETH_P_IPV6);
 		fkeys->addrs.v6addrs.src = *(struct in6_addr *)&ip_spec->ip6src;
 		fmasks->addrs.v6addrs.src = *(struct in6_addr *)&ip_mask->ip6src;
-- 
2.46.0


