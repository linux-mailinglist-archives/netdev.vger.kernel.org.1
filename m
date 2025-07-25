Return-Path: <netdev+bounces-209963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3912BB118A2
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 08:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DB53A46B9
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2432882C1;
	Fri, 25 Jul 2025 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kA2Ca1VE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABF1DED4A;
	Fri, 25 Jul 2025 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426104; cv=none; b=K+v7Jf7aW84WFQ+C25msUM5qvDFiipbF+piHhDfk23lq/hXbA9iAxnAu68Hvy8QA6HYc0O8kgTTSH3CjiRlhWzxMebuU98JB32CNWq8nTip780uaox2r4QqTvKa56kP80rMf2UFfmIh9nfXlm3SAJD4gjmdikY7mz/jTm4KVCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426104; c=relaxed/simple;
	bh=t0RQOIyBqE3YmbOxC7nuqmE3vvZwBy0YVSfo71KW9WU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q94wEITm+7KZBfYyFPGLZBaljIcBilIGDogm2pzDtG3JmExbrUgBvkxmAd5Tv+f74X555menmh1k2tW7m8JeQr83ONKafwDHzWvNsZvxxIWvnqk2WoZHSs3SVhfJkxbCRTsL36iWTbU23X9wi+b2YnrcWOhPPOio+2Ou0raBhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kA2Ca1VE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ONWTB4017766;
	Thu, 24 Jul 2025 23:48:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=VsdCnqeVtcIXjji2Xkezl2I
	6NJ1McmMUj7UlVEQ76G8=; b=kA2Ca1VEaMhvE2d+7wWN0tSiZENq3xKr8NvZxP9
	ARixdWCZZeXl7i/bffrOrfpSgo0XLm7KZtlrLzI9YRXNJi9J5DhUXojuiwbNNoxM
	g6XC2QAD8e19r/YFqxu9LsOV91XejU3FNXUlgTGzgj+iJNjyZoAB9S3xvQEbHIsV
	csYwi/ONQQQ3OdhIQB064Ah24qiM8HBv3CnlnfDy2wJwSM56iTQP3txx06diYFJo
	e4q/iNfPoz0KZqTibbcqeaxIccMol3ujhiTdfJ2Lm0lvZTo/aFyTAj70vjM3kiyj
	2X0vJAdr3qS4JQVysYBV3VZveC9czUDudiG3B6lHyiSNx8Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 483xk90nys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 23:48:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 23:48:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 23:48:11 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id CA93C3F7092;
	Thu, 24 Jul 2025 23:48:05 -0700 (PDT)
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
Subject: [net] Octeontx2-af: Skip overlap check for SPI field
Date: Fri, 25 Jul 2025 12:18:02 +0530
Message-ID: <20250725064802.2440356-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bK8WIO+Z c=1 sm=1 tr=0 ts=688328ab cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=-rsMC5T0QWJERi4EvSYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qIvzkw-eXah94ZhvdJXv8hf2SVHcX-Jv
X-Proofpoint-GUID: qIvzkw-eXah94ZhvdJXv8hf2SVHcX-Jv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA1NiBTYWx0ZWRfX5/IbVUuLQIcd bIqS3wBA5PpsIYtVZjlwwoXZwot2W+rweyu2Yln7NnobtvGVzUaJ3WNTEaG3sFaRT6tFQW/O6dN T6yBErlIsxt1JPo4+zTrCGKB05HIVu28Eovp40XZQ7AvBxJ2hoc6S/kad3K652hM8LfmjmcLLBN
 NFz/usIUJOG/IavVhJgCMe2hxPHVvsFf2WpqZAwALGhECGAgUqFq4F1VkiORIi8qR45PQ3NU/LP +mxyC1vAghgL09VZq+tnAgggJvKu5xlNKw/m0T+7A05YkC0kP4Mq3qVQz/BA12cnE8+gRbuHepz yxY3wd3mDjsjoHUC1/Ihbr3EBw1vCm2POo7j+3b5+RHDKlbazZ97FUZ5WOWoDnQi5Jo/wkEOESp
 cQonXKNLPW1qIG4ooSSV63re/ll9vCtGKqwlYbatIvJ8AB2vxLxUPHRMixJ6P1yGyX3loNV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01

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
ipsec packet will be having either AF(LD) or ESP (LE). This patch
relaxes the check for the same.

Fixes: 12aa0a3b93f3 ("octeontx2-af: Harden rule validation.")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 1b765045aa63..d8d491a01e5b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -607,7 +607,7 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
 	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
-	if (npc_check_field(rvu, blkaddr, NPC_IPSEC_SPI, intf) &&
+	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
 	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
 		*features |= BIT_ULL(NPC_IPSEC_SPI);
 
-- 
2.34.1


