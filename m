Return-Path: <netdev+bounces-193005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE00AC21F5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF9A1C0051A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E04022DA14;
	Fri, 23 May 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZYav1w1b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA82183CC3;
	Fri, 23 May 2025 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999634; cv=none; b=jJdANRWifpfyVSO7860XayLQp1/Ob+XcMt2wFhnxCQRF3ToVNWjB/cfttJqKKRNeUOWFb281eoQsBpsP/CJOc8yYQiRD/sow18zhOE4gXEqydE6f9lAkFfqso24OvDw5HHI9pM5VKWSgSRVp74898M0EcogBPQ8xLq2qdoZMDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999634; c=relaxed/simple;
	bh=jfYtZ2CH8xYCrT2P5uGtit6vLo5mNXn1vw3XbgqPmpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CnrpdUSQZBh0uDAxOryno2RN06ipr4KCp4uZ3mxhkAiTtfE6UQg8Jpz8GfmSwl4jk729OCe5/+eo06f3xaDH4HnQQJygT0V4VoJD6KcR8l+KoxO6ti5392gHE9pAet35onrVIWqUdNwPrCPs9FOV8K9MG5OHkNiW4eZdeeGbiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZYav1w1b; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9rEks016918;
	Fri, 23 May 2025 04:26:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ihSw8cMuTTEpL372fhXdwPZ
	zTu7nd63knMyoe7B5fgo=; b=ZYav1w1bjnXEg5VWBsiGL+3rLcCqKn6ui4qYoaY
	aXSclbWSoJmMPk1S5Rwi7T4mun0UhiJB64VeMWReVxMx3EsrwRaDYNNPRYwccIro
	s1A5sMKoZQUjEAo7+rqrd2VZDMbvj2vFVp2hHvBiGaEyafz4YAr55LxlustAOsEC
	V14ZtASTdLGcu8k+9Uc7yTBSvbhqsaB4DdCeWjfjg6onfKLFLJetBrz9nArgZVSR
	r1dQdE/UQLFT84D6dmKljWUecksKRcJh200MWVTNw/EKV6HLaXzQvoPSmHZaUgpU
	m8SGc9rQyFY+WrqCo3D8gMiEulH13FIXT/fcj7EZc6deYAA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tmgp8hdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 04:26:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 04:26:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 04:26:49 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 4BCF43F7078;
	Fri, 23 May 2025 04:26:44 -0700 (PDT)
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
        Paolo Abeni <pabeni@redhat.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>
Subject: [net-next PatchV2] octeontx2-pf: ethtool: Display "Autoneg" and "Port" fields
Date: Fri, 23 May 2025 16:56:38 +0530
Message-ID: <20250523112638.1574132-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _UlBT_vEH8X1VkZ3nNTG_yPyHhnz3LMX
X-Proofpoint-ORIG-GUID: _UlBT_vEH8X1VkZ3nNTG_yPyHhnz3LMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEwMCBTYWx0ZWRfX1HNVcsRTTByp OZBc3/0dEZE53uMAWGBmtEQb1oykuGh9ID0XVMnMzn2KUpGoAGDm8IK+hYeqe6luY0p/i5IdN2i R9+pCfOf2tLcBjRD8gBTixlt4zLb/PJ6tk70oyzjjgFcMNlG6VY9W1cNKAbzRViFFsInu7Sp8wL
 CP6vAiBNDDnHOG3Vmv1KbUs932p6JOesZOZhN+nqhmSo9UaQhvj5OGeQXL140g5Z9LJNLzDzd4M LiRqgwOCvfJGSHfZBND0F9Tx4mOfeXQ9XJFGbw/OfTwClgRiQN+UvHJgzW681JG1f+p7oKkLKeM VuPZnibSCxIqTkYc4fpPu4upbCMCwMGjc1s1oNw89TtEdjcCRecS17RaKwGBLC5SBnixw18DmOR
 76+2IQOOBa2fa/wisi9/hUVjwgMbHvaZ/huAgrb1MbcYZVHAqj1v3sMuW/oh24PgU6yuWOlE
X-Authority-Analysis: v=2.4 cv=KYPSsRYD c=1 sm=1 tr=0 ts=68305b7a cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=0S1FJScdx-pYxljRKJoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01

The Octeontx2/CN10k netdev drivers access a shared firmware structure
to obtain link configuration details, such as supported and advertised
link modes.

This patch updates the shared firmware data to include additional
fields like 'Autonegotiation' and 'Port type'.

ethtool eth1

Settings for eth1:
        Supported ports: [ ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
                                10000baseT/Full
                                10000baseKR/Full
                                1000baseX/Full
                                10000baseSR/Full
                                10000baseLR/Full
        Supported pause frame use: No
        Supports auto-negotiation: Yes
        Supported FEC modes: BaseR
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: BaseR
        Speed: 10000Mb/s
        Duplex: Full
        Port: AUI
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Current message level: 0x00000000 (0)

        Link detected: yes

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
V2* Add validation for 'port' parameter
    include full output of ethtool ethx

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 +++-
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 24 +++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 005ca8a056c0..4a305c183987 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -652,7 +652,9 @@ struct cgx_lmac_fwdata_s {
 	/* Only applicable if SFP/QSFP slot is present */
 	struct sfp_eeprom_s sfp_eeprom;
 	struct phy_s phy;
-#define LMAC_FWDATA_RESERVED_MEM 1021
+	u64 advertised_an:1;
+	u64 port;
+#define LMAC_FWDATA_RESERVED_MEM 1019
 	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 45b8c9230184..5482a9a1908a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1174,11 +1174,13 @@ static void otx2_get_link_mode_info(u64 link_mode_bmap,
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
@@ -1200,6 +1202,11 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 						     supported,
 						     Autoneg);
 
+	if (rsp->fwdata.advertised_an)
+		ethtool_link_ksettings_add_link_mode(cmd,
+						     advertising,
+						     Autoneg);
+
 	otx2_get_link_mode_info(rsp->fwdata.advertised_link_modes,
 				OTX2_MODE_ADVERTISED, cmd);
 	otx2_get_fec_info(rsp->fwdata.advertised_fec,
@@ -1208,6 +1215,15 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 				OTX2_MODE_SUPPORTED, cmd);
 	otx2_get_fec_info(rsp->fwdata.supported_fec,
 			  OTX2_MODE_SUPPORTED, cmd);
+
+	switch (rsp->fwdata.port) {
+	case PORT_TP:
+	case PORT_AUI:
+		cmd->base.port = rsp->fwdata.port;
+		break;
+	default:
+		cmd->base.port = PORT_NONE;
+	}
 	return 0;
 }
 
-- 
2.34.1


