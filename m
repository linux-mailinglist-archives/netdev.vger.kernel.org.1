Return-Path: <netdev+bounces-215148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17BCB2D424
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4307A329C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3C12C11DA;
	Wed, 20 Aug 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bBS5zmiG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828A3C17;
	Wed, 20 Aug 2025 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671994; cv=none; b=YxrSq1VuYU8Ze77h2UqJjPX2sCchjw2zcfCvMMgD3K+mU8DUWp+xqYxv88uOyOfZ3RrD5XrUB/2SpntK3ROvWGlgnffY3zGqAnk+hBTCsySXCBhJjmm7WFQcyM9INXtvhLfWv1Kx6j8TAdpuE3MlAXtilLCxy5lb4vQE7+6R/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671994; c=relaxed/simple;
	bh=UUBWMtS3hGO6ro3MSdIWsYxBpiRu/KbewFdl/lHwdyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aCJutih6pHGvNMC/mys69vJ/1Q05KvwO+7itdKjZFUU01GUWDL9m/m/xnUQewsfXdbC4ECRZyT39/rSAmB9x2C7nME7BN7+Ofvvb0zk8yplmDS8k8dy9ZOWEYgoplsqjOzBPpiX0I5tc6wsMZvZAXe8hw0cTMdFCV6vKk5qUrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bBS5zmiG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1nx7P011897;
	Tue, 19 Aug 2025 23:39:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=e9VXU8voCr5lX/8JBonq37X
	MLvAdpWWuHhRTy6OBO8g=; b=bBS5zmiGQdOiKP/Psy1MH07pgXjhNSrnEhY2b3G
	CtBVaE0MWSH6TY+VwHvxoAlYwE9FCaBmXUtxDN3hT6Xq4ljubdxnF4B7XzKzlnTA
	CMhjR6sf01MJ360hZjwKokyezspxHNr0XRZGeCD2h0RJgUW+SZHY8pdeXFFLb7wj
	2WSjIbNhMj3Wtq5hx5KcU+LsFHo5toX3wVD+UhZsEkVSKEqFbgzCnUQxF7N9fP4T
	BrBZcgn/PapWPMh4X8oSpTtcIrVWV1BNYrJef7p8UarmAY/y27j1quSCfyNmxvnT
	vBVlHPEAWpHfq/NeSUluPdfqfrkSMC2CmwTbwRr4CN2HRSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48n51urfvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 23:39:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 Aug 2025 23:39:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 Aug 2025 23:39:32 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id AF0773F70B4;
	Tue, 19 Aug 2025 23:39:22 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [net PatchV2] Octeontx2-af: Skip overlap check for SPI field
Date: Wed, 20 Aug 2025 12:09:18 +0530
Message-ID: <20250820063919.1463518-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k1X1ComJbykOcXmb4M2O--Jwsjvx_vrl
X-Proofpoint-GUID: k1X1ComJbykOcXmb4M2O--Jwsjvx_vrl
X-Authority-Analysis: v=2.4 cv=I9E8hNgg c=1 sm=1 tr=0 ts=68a56da0 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=ucxOQ4RWDg5Gs50NsgoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDA1NSBTYWx0ZWRfX2kX9cEgc8jDl TopOJS7bAdQU9Wnx3nflP7YEOWJRDa5ZF+QuUlf9dcmc9HZTaQZp2TteqgRKi1tOwWDH12rN1nU pMi3swKKEzAfEWRd8YdzbtMdMld5+rB8aijP/y+1d1dMqMiMbWQLnn5EV7Sah29TeSJGOtqsMgl
 0YGuKwp/sdjplu6IDS5/ZMOv1C5R0lRIs3KPEp1PtqSPkv7A6pzLkqmEJ5Xocr5+TbdJIV3CsZB 5Rvzw4oFg+1EDncGTTJwMG3/Sz9rKa1Wqh0cSZIPnscIgcaDS5qZn3npwoI4XjiaVvmxgwXRlLu +Hrt18WGKYc/wpQwwDJG8sMjhCt6cswb/gu222+xi69BG0T1AB5HCg4t1AqtJHDQi4rB2z/5kuq
 J3XhyuZkH1sDSd9KJSQlitoJG1K/TBp6aiP3GBzU+SD3BGisga9KIW2ILGDH+OFKRy2lGOKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-14_01,2025-03-28_01

 Octeontx2/CN10K silicon supports generating a 256-bit key per packet.
The specific fields to be extracted from a packet for key generation
are configurable via a Key Extraction (MKEX) Profile.

The AF driver scans the configured extraction profile to ensure that
fields from upper layers do not overwrite fields from lower layers in
the key.

Example Packet Field Layout:
LA: DMAC + SMAC
LB: VLAN
LC: IPv4/IPv6
LD: TCP/UDP

Valid MKEX Profile Configuration:

LA   -> DMAC   -> key_offset[0-5]
LC   -> SIP    -> key_offset[20-23]
LD   -> SPORT  -> key_offset[30-31]

Invalid MKEX profile configuration:

LA   -> DMAC   -> key_offset[0-5]
LC   -> SIP    -> key_offset[20-23]
LD   -> SPORT  -> key_offset[2-3]  // Overlaps with DMAC field

In another scenario, if the MKEX profile is configured to extract
the SPI field from both AH and ESP headers at the same key offset,
the driver rejecting this configuration. In a regular traffic,
ipsec packet will be having either AH(LD) or ESP (LE). This patch
relaxes the check for the same.

Fixes: 12aa0a3b93f3 ("octeontx2-af: Harden rule validation.")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
V2 * Update the comment for SPI field in key scanning logic

 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 1b765045aa63..b56395ac5a74 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -606,8 +606,8 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		if (!npc_check_field(rvu, blkaddr, NPC_LB, intf))
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
-	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
-	if (npc_check_field(rvu, blkaddr, NPC_IPSEC_SPI, intf) &&
+	/* Allow extracting SPI field from AH and ESP headers at same offset */
+	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
 	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
 		*features |= BIT_ULL(NPC_IPSEC_SPI);
 
-- 
2.34.1


