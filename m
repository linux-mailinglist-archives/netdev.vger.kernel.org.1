Return-Path: <netdev+bounces-191522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2A3ABBC46
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2930D164351
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB932749F2;
	Mon, 19 May 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aHc6JjCu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65443FBB3;
	Mon, 19 May 2025 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653845; cv=none; b=Q4vXA1iMgzeezFzBFSc2bSjfQak5LzlQKstfYz0XwHDtCk56GrGe6uOk+8Tsc7WC4keHpTy25af0LSuq7ML2Q38UMVw0p/1shDZeqpCHJyUSkz38bfS1USFw9FNvqYBo2VJaOz3mg5RTppY701sg55wNZ6csMMlcW8F74XSCQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653845; c=relaxed/simple;
	bh=LzO1XD7mYvYSbwVWT2CfOdBbAsbVCCS83/1axQfjmkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PBRYt8CRwF+r8EeaLAiYbaBur8MMfEJhnqP7QLMxgDdjIYn3iVExple5cc19MJR4RZ0cF7GI5X62KNw7HdDkgtToNWDRT4ElfA2C15ij9AocaHVdaHvDIAtNiwXLWn1R+T8lDI+fTTFlCCp3PJG8UqKR+fre8EnpkZzdV+lEqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aHc6JjCu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J1sZ6g006518;
	Mon, 19 May 2025 04:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=q7m711HS141A+Rrd8PU4EsU
	er2iClsOCzghkt+KfPaw=; b=aHc6JjCujO2DED99iNtuM4kBtnRTkoalCACkHIO
	l/oTkWAvXdvIuwotNbnWpjhkdCG2h3vqH9pjraISKnyB/cHD+xEkY/TnoNuuQ8sj
	bH2jXcUQ4F3p7hH9E5WbyyJtr8aJqBIo29ubwWGcur4t+Bhr1XEQR9E77tklO4U+
	Zt1H3gW/C7a2Hj0pqGa5fRqZ7ggUy5J++g2ylV1O+/V3VF8wXCz1FA1V7zyROIlQ
	ohEePklmPI2gBskjmLbPvxg/+QcBWajCjFEh6ZPaYbwODqIW0F7p5SQ5vT2FQPT0
	JXHE9shepIYuN2QB1loJ2fJVnKgkKhRQ/TdvHxLm+dhCHxQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46q46fa8w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 04:23:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 04:23:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 04:23:51 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 57AAD3F7074;
	Mon, 19 May 2025 04:23:47 -0700 (PDT)
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
Subject: [net-next] octeontx2-pf: ethtool: Display "Autoneg" and "Port" fields
Date: Mon, 19 May 2025 16:53:33 +0530
Message-ID: <20250519112333.1044645-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b8uy4sGx c=1 sm=1 tr=0 ts=682b14c9 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=kqO5N8cHV_PgJFjelC8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: w9seos1GA1TIZ2SbBLwoUZOu9KI3v9MT
X-Proofpoint-ORIG-GUID: w9seos1GA1TIZ2SbBLwoUZOu9KI3v9MT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEwNyBTYWx0ZWRfXxShN2qE23R6Z cMJepqGGMSR0e9B/M39mv7NyJKs7093jjjIv5RK56d6FwYhSBHi6JJ+f1bGFHMEwIu4R6YFwt/1 Itu+QPfcUURPxGd0QkkDsdma1/N2Ipas6t/LDeX7W88Lq02bFIOvklYaudvNp+ljZFH1kt4XdpW
 TyAPXz82VCJwvuA8q5/x3iXbkX82BMRNhobQbpPHRNddMRgsnrdNq+YGRrGZjRx9GCyWjuM1O8m Izezcsdg2nWmM0nTBWupGfuMQ4rBBQ6gbwRNnn5Tx6H7j0IBJioGrSeudMec+pinKiCnscUT0r7 0qGYP27xQFd+RSm5aV9tOnvFckJk11XIQcHsDgv+S19SuU6X1collLUClIARE75S2WjfF09oWcm
 Dvr30QBUstrQ3O4+AYeeSbz9iPsp4bgUcaGC+XBlGMJeQ+pgA8ZKvQtcUTHvGuQGnS9opQFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01

The Octeontx2/CN10k netdev drivers access a shared firmware structure
to obtain link configuration details, such as supported and advertised
link modes.

This patch updates the shared firmware data to include additional
fields like 'Autonegotiation' and 'Port type'.

example output:
  ethtool ethx
	 Advertised auto-negotiation: Yes
	 Port: Twisted Pair

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h    |  4 +++-
 .../marvell/octeontx2/nic/otx2_ethtool.c        | 17 +++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

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
index 45b8c9230184..0ae39cd7d842 100644
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
@@ -1208,6 +1215,8 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 				OTX2_MODE_SUPPORTED, cmd);
 	otx2_get_fec_info(rsp->fwdata.supported_fec,
 			  OTX2_MODE_SUPPORTED, cmd);
+
+	cmd->base.port = rsp->fwdata.port;
 	return 0;
 }
 
-- 
2.34.1


