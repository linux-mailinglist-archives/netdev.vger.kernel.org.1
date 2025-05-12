Return-Path: <netdev+bounces-189642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C42BAB2F95
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F243C188F0EF
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFC255F2F;
	Mon, 12 May 2025 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EBBLXXnj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE01A23B5;
	Mon, 12 May 2025 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031410; cv=none; b=VbkIF8gKv0wDU89exULhxLbOMIklmTA5Hlo+8HLlBDfzulG0kde0YgMuSX8me9LYrFFshgEvgEdbT6jDbUS5+XjKw1yYPpK8JSo2FX1XgT6QiO6lVLCaCDPhePs+mkOFPnDB/MllabRzz2RGjtPscCARKPDKo91wk+xJdn+hhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031410; c=relaxed/simple;
	bh=IyqEvFnK0atVgTZ4NurvwzVawcVS2qz/Kyx3J5TkbVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5OnPE8FM0B54a1rEpGcrNToylrydAFuHqV9VQKwHuUI0UEl+TugCmqLv9ngYUVtsAzA4Eu2CDZV5rtrfN9TfKoy4QymDJ6rG9pXgalr/vu4LfqdIiuRePejSzJbdn4qfe7sjSFSNMghTGS4JrFqfMhN2vNhZokncLZ+06UMrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EBBLXXnj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C1QBch031626;
	Sun, 11 May 2025 23:29:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=+EB6sJdhVKr4rGBMH4O7DYZ
	xvmnpv++UCvoCoKqxmzM=; b=EBBLXXnjzX+j8UKstKq4D1IbPTWCfnMDjyV0fjr
	JcrC0xewXb/+I1RQOe7UATh3bI1O8hJYDt3iYrvWl8VfJ4P8kipqfgWjvQoiMhpQ
	kOvEnAJhW6RWaA1ZLkEM/516UnRzV1FEZ9VhvESIh5CW7+j/PPOosYsLeWe/4S2K
	+ZvH1y0lMFKWYoTTCeLGBXagXRrBlHCz78ndnRwucHYZs6DLCmhssxCOps9wa2B2
	4UVwwTNs9U1azmFZk0I0Dpzhfp0NHFwEX8MykdF5FddH7J5u6hkM9oQJgId8Btkw
	XGbN8hMf/tNoL/5dQhuq42i8FRblcb9QgfMTM4oIUD7zF9A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46k5rggfjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 23:29:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 May 2025 23:29:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 11 May 2025 23:29:44 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 1F56C3F7093;
	Sun, 11 May 2025 23:29:39 -0700 (PDT)
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
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>
Subject: [net] octeontx2-pf: Fix ethtool support for SDP representors
Date: Mon, 12 May 2025 11:59:01 +0530
Message-ID: <20250512062901.629584-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fBP8RY3Kyw662SSAWEME3Ov0XUoT0Nb6
X-Proofpoint-ORIG-GUID: fBP8RY3Kyw662SSAWEME3Ov0XUoT0Nb6
X-Authority-Analysis: v=2.4 cv=XIkwSRhE c=1 sm=1 tr=0 ts=68219559 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=zsvlLyDedhZcTVAtw6YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA2OCBTYWx0ZWRfX76CBORSCbRAh vsCVfiQ7ApOxMcxwnXtpsHSWrjvmVwA4jmngOvzVovid+bBSd5xFGO7DBfuGzYKmhXJ2v9yjD4X GaumGXt6B9Bac3u0w/AsBVarC+bFMSNvlSO/hJixOIU9D/iSaSZ6Djx3EZIqXtu6D/ZbVJDQ8DS
 3CcbrDichr0RFu6nyhI5LtPAt5MaiVSsbJLMxHX/3cNoFwlWrqZSa5nojmvkvZ7ep4g3o1sP6rX QhmDoe5cUH1ZV2F4PE4YpJcI4rMeK2NiyTwp0Z7cTvqvuzW0+fPg7AA/fwGTRdQm0W5VjgNWS8Q tvh4EADIHmECyccS1SnkNn+FFVsMMontySe+bBWt16SolBHrxqmfG9/nDGGQyX6E8EuREImWyUI
 qlDEoIASmmpMoM0YryRYFcrrGGhaebENIA3EjzO32IXakdnF98m8eqNoFY0ownVN2e+OBa/3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01

The hardware supports multiple MAC types, including RPM, SDP, and LBK.
However, features such as link settings and pause frames are only available
on RPM MAC, and not supported on SDP or LBK.

This patch updates the ethtool operations logic accordingly to reflect
this behavior.

Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors for sdp MAC")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 010385b29988..45b8c9230184 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -315,7 +315,7 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 	struct cgx_pause_frm_cfg *req, *rsp;
 
-	if (is_otx2_lbkvf(pfvf->pdev))
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev))
 		return;
 
 	mutex_lock(&pfvf->mbox.lock);
@@ -347,7 +347,7 @@ static int otx2_set_pauseparam(struct net_device *netdev,
 	if (pause->autoneg)
 		return -EOPNOTSUPP;
 
-	if (is_otx2_lbkvf(pfvf->pdev))
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev))
 		return -EOPNOTSUPP;
 
 	if (pause->rx_pause)
@@ -941,8 +941,8 @@ static u32 otx2_get_link(struct net_device *netdev)
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 
-	/* LBK link is internal and always UP */
-	if (is_otx2_lbkvf(pfvf->pdev))
+	/* LBK and SDP links are internal and always UP */
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev))
 		return 1;
 	return pfvf->linfo.link_up;
 }
@@ -1413,7 +1413,7 @@ static int otx2vf_get_link_ksettings(struct net_device *netdev,
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 
-	if (is_otx2_lbkvf(pfvf->pdev)) {
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev)) {
 		cmd->base.duplex = DUPLEX_FULL;
 		cmd->base.speed = SPEED_100000;
 	} else {
-- 
2.34.1


