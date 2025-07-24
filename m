Return-Path: <netdev+bounces-209705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3528B1077A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3293C3AAB50
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AEE25FA10;
	Thu, 24 Jul 2025 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ijxS9fxT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B525F99F;
	Thu, 24 Jul 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351898; cv=none; b=ed6IxOp+mREmOXeGmHgEtbM6BnhOlyscxA64A6G9s1e3D7N9mCxbZP2xIlV2BFV1w3rZX6AxNgQDc1DRkN/KJ37C563vp44AOQn3eSQq/EzqkWGCAbuOKIw9nlSjV4fr1G/QsFX/o8K18XCT/yi8bxlAVYycGppRlrARZTEcH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351898; c=relaxed/simple;
	bh=DAQfeQC0jG4xrZVWdpFfPkLxQjD6DzR41cG4qSNbeDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJwwHKYN/GG3m9tMKi8HPmI10Lgwe5eRuc6c8THJWw/f2GFwQkHXY9axDw3KUYjoBG+VEWGJLzaZ/M7CFMFbBUO5eh52kFKowGFLn+jcFjGdIeFV+pmZLJBpKY9pg+2FveQIEuzEzML4jonOawBZ0AoThsr3GsXVZ84lsnlr0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ijxS9fxT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NNT20X002947;
	Thu, 24 Jul 2025 03:11:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ip1EblJiKkhZYWLhItDti03
	7UWJiiJPdv9IzNmLe6cs=; b=ijxS9fxT+WaTxsR1dA7KlbGa/43NO4ujrB3QyY5
	3hB1NN2fB3Z3lK71r2wJdV6zqbGsiyafIKo8zESz87Omfcb7MM/76yEYdeP/HOxj
	uwWiR2tcdn/Vwls77F+wN1Fp8cQZBqAM6KY8tNMjB7GgwccZp6VpXUxoFvAJ5wqY
	lC1kILO5vXUjLy2nlmFlE5e83Jx4J82cczEEoiA+oo4eHxHGBgoTTNc+1gjn+eMJ
	4Dd+Z9g7PbdHlE5e3eQ+Ew6Em1Vewsj8TDjbSygM8miCHqYRVWAimhrtV+HwIIB/
	OTNYSWytjFa0mw894pOckM7bg9N2ZXd6Q62v+cv53R+tpAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4839euh1wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 03:11:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 03:11:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 03:11:08 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 9FDB83F704E;
	Thu, 24 Jul 2025 03:11:03 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [net-next PatchV3] Octeontx2-pf: ethtool: Display "Autoneg" and "Port" fields
Date: Thu, 24 Jul 2025 15:40:57 +0530
Message-ID: <20250724101057.2419425-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VRx4VX0zEwzvcvOS4CebCj8taCJOZNgc
X-Authority-Analysis: v=2.4 cv=SK5CVPvH c=1 sm=1 tr=0 ts=688206bc cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=5rgwPVzteBU-ZFRzDRMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: VRx4VX0zEwzvcvOS4CebCj8taCJOZNgc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NiBTYWx0ZWRfX6Orc3fYY70mx OEVFX7ozJf2o8CASrRAJjPApPiUW1Y04Jc1eWq5k+j46C1gCOyOobh3CgA4UQMAoekIsmEQFBAT EDGlR3T/CweW9TdKrswf16m9+p8PXmjp4/pgQeER3NQ7iOrXDeScy4h3ztEZhr213lhztxrKDdB
 Dm8FQlRNxM8sbSoFdQpDUfXkQPYhhkkpmBy67WOQjDWF6BFRHHVrarI9MaRanDkf1YISBkCZ5pw i5JNEPr46X1nOLpxqoJ7bFd5+AQ8thVVyJm18knmFuX1H9rSAEBLsIEwchAptvgUVgBcAP52uw+ Glr+M1pEOKWaDp4mWvF3NfpvKGjvS7pqYLOF0kLA/h10ygLUrY6Ua0g70gAwIvid2I0SfuBlqW+
 67vt02f8Eo7lbMmuY55vcqEBOHWiZXXquJ3u6GYMXRvz0hZ1zCzBYYjft2RQ+lQy87yWLUuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01

The Octeontx2/CN10k netdev drivers access a shared firmware structure
to obtain link configuration details, such as supported and advertised
link modes. This patch adds support to display the same.

ethtool eth1
Settings for eth1:
    Supported ports: [ ]
    Supported link modes:  10000baseCR/Full
	                   10000baseSR/Full
                           10000baseLR/Full
    Supported pause frame use: No
    Supports auto-negotiation: Yes
    Supported FEC modes: None
    Advertised link modes: Not reported
    Advertised pause frame use: No
    Advertised auto-negotiation: Yes
    Advertised FEC modes: None
    Speed: 10000Mb/s
    Duplex: Full
    Port: Twisted Pair
    PHYAD: 0
    Transceiver: internal
    Auto-negotiation: on
    MDI-X: Unknown
    Current message level: 0x00000000 (0)
    Link detected: yes

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
V3 * Fix port types in firmware 

V2 * Add validation for 'port' parameter
    include full output of ethtool ethx

 .../marvell/octeontx2/nic/otx2_ethtool.c      | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 998c734ff839..95a7aa2b6b69 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1184,11 +1184,13 @@ static void otx2_get_link_mode_info(u64 link_mode_bmap,
 	}
 
 	if (req_mode == OTX2_MODE_ADVERTISED)
-		linkmode_copy(link_ksettings->link_modes.advertising,
-			      otx2_link_modes);
+		linkmode_or(link_ksettings->link_modes.advertising,
+			    link_ksettings->link_modes.advertising,
+			    otx2_link_modes);
 	else
-		linkmode_copy(link_ksettings->link_modes.supported,
-			      otx2_link_modes);
+		linkmode_or(link_ksettings->link_modes.supported,
+			    link_ksettings->link_modes.supported,
+			    otx2_link_modes);
 }
 
 static int otx2_get_link_ksettings(struct net_device *netdev,
@@ -1209,6 +1211,10 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(cmd,
 						     supported,
 						     Autoneg);
+	if (rsp->fwdata.advertised_an)
+		ethtool_link_ksettings_add_link_mode(cmd,
+						     advertising,
+						     Autoneg);
 
 	otx2_get_link_mode_info(rsp->fwdata.advertised_link_modes,
 				OTX2_MODE_ADVERTISED, cmd);
@@ -1218,6 +1224,16 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 				OTX2_MODE_SUPPORTED, cmd);
 	otx2_get_fec_info(rsp->fwdata.supported_fec,
 			  OTX2_MODE_SUPPORTED, cmd);
+
+	switch (rsp->fwdata.port) {
+	case PORT_TP:
+	case PORT_FIBRE:
+		cmd->base.port = rsp->fwdata.port;
+		break;
+	default:
+		cmd->base.port = PORT_NONE;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


