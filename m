Return-Path: <netdev+bounces-55195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A31809C9C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 07:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FFEB20E34
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830CAD269;
	Fri,  8 Dec 2023 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ecu7JAtz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B11722;
	Thu,  7 Dec 2023 22:56:29 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B83H1wh017036;
	Thu, 7 Dec 2023 22:56:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=0ZbZa1UixBoOl2+uBtZ0D+1n/eyzGSd63YT0lH0OjD8=;
 b=ecu7JAtz6x9AvyNKFti63a8pzCWpIrZYzKUX/tvz1iHV2slyd6dlfaDolhPuSX70sOFa
 8AMqmQqpM8osUrAi6yQKM67pMh3Js7OKPbYL9RmAjsosF4uObhNTeXbIS7wxkJos5UPL
 deTUnFl/+XGmHxqtzuhkBxev08416HivJEJD+ZQcEilXQDBTgoLGeNCYCjgcOJzVFny+
 pY+z80rW7Fa6HKnGdfxEG5M/Q/Zwt6Gl1eLhShyCCIOukoJ/lKMCiMl1QCnaHxNI3dRy
 rDwaRuMGv5pQ6lff5VOEJ1xzfjBIfdoIRuO6TK/XqFDbo1Kiyit41xHeh5pioy59MGbi kA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uu8qecncr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 22:56:21 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 22:56:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 22:56:20 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 83DBB3F70C3;
	Thu,  7 Dec 2023 22:56:16 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net 1/2] octeontx2-pf: Fix promisc mcam entry action
Date: Fri, 8 Dec 2023 12:26:09 +0530
Message-ID: <20231208065610.16086-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231208065610.16086-1-hkelam@marvell.com>
References: <20231208065610.16086-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Y_tdXlCFjVK0tYOPt1IswN0uPVqUO8BS
X-Proofpoint-ORIG-GUID: Y_tdXlCFjVK0tYOPt1IswN0uPVqUO8BS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02

Current implementation is such that, promisc mcam entry action
is set as multicast even when there are no trusted VFs. multicast
action causes the hardware to copy packet data, which reduces
the performance.

This patch fixes this issue by setting the promisc mcam entry action to
unicast instead of multicast when there are no trusted VFs. The same
change is made for the 'allmulti' mcam entry action.

Fixes: ffd2f89ad05c ("octeontx2-pf: Enable promisc/allmulti match MCAM entries.")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 0c17ebdda148..a57455aebff6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1650,6 +1650,21 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	mutex_unlock(&mbox->lock);
 }
 
+static bool otx2_promisc_use_mce_list(struct otx2_nic *pfvf)
+{
+	int vf;
+
+	/* The AF driver will determine whether to allow the VF netdev or not */
+	if (is_otx2_vf(pfvf->pcifunc))
+		return true;
+
+	/* check if there are any trusted VFs associated with the PF netdev */
+	for (vf = 0; vf < pci_num_vf(pfvf->pdev); vf++)
+		if (pfvf->vf_configs[vf].trusted)
+			return true;
+	return false;
+}
+
 static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 {
 	struct net_device *netdev = pf->netdev;
@@ -1682,7 +1697,8 @@ static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 	if (netdev->flags & (IFF_ALLMULTI | IFF_MULTICAST))
 		req->mode |= NIX_RX_MODE_ALLMULTI;
 
-	req->mode |= NIX_RX_MODE_USE_MCE;
+	if (otx2_promisc_use_mce_list(pf))
+		req->mode |= NIX_RX_MODE_USE_MCE;
 
 	otx2_sync_mbox_msg(&pf->mbox);
 	mutex_unlock(&pf->mbox.lock);
@@ -2691,11 +2707,14 @@ static int otx2_ndo_set_vf_trust(struct net_device *netdev, int vf,
 	pf->vf_configs[vf].trusted = enable;
 	rc = otx2_set_vf_permissions(pf, vf, OTX2_TRUSTED_VF);
 
-	if (rc)
+	if (rc) {
 		pf->vf_configs[vf].trusted = !enable;
-	else
+	} else {
 		netdev_info(pf->netdev, "VF %d is %strusted\n",
 			    vf, enable ? "" : "not ");
+		otx2_set_rx_mode(netdev);
+	}
+
 	return rc;
 }
 
-- 
2.17.1


