Return-Path: <netdev+bounces-51035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5D27F8C74
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CFF1C20AB5
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1532946F;
	Sat, 25 Nov 2023 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jg/FK7mb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CAAD57;
	Sat, 25 Nov 2023 08:35:55 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3APGOmAn027133;
	Sat, 25 Nov 2023 08:35:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=9ko12hy6RH7NAQXfAVgeMRqXNaNI7sh28jkGvrWea2A=;
 b=jg/FK7mb4S1Zq4Qaz061Lw0Hz5/ZW7jyykuO26l1Xu/KEJ8yOz8MRxQmDglkIGvdE1/r
 UAxe+84qMTdDApVNdagajWXRUnqw0IzJheYdZYhMR/P+rnMr9gd42O9ZjKK8JkQx9H7b
 lxwG4WG4YdbnCDJF47jn51zviljNe3gZPG2n8dVz4bWRB0FefpyxQMrbBagQaKb+Fn7Y
 DH1oj/prkNqANDPemjoxGbqZkH4ELfYCdLdxFx893c159zwO2VQy+9e9D1/3W5v6/5BJ
 kE7AAJqShRk3lKwzuOhOtGOJ9lx2tEnYwE/YxlvODuiUbsWB99ZtX7OmpnDFq5fbzujp NA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ukhauga8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sat, 25 Nov 2023 08:35:48 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 25 Nov
 2023 08:35:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 25 Nov 2023 08:35:46 -0800
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id F102C5C68EA;
	Sat, 25 Nov 2023 08:35:42 -0800 (PST)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
Date: Sat, 25 Nov 2023 22:05:41 +0530
Message-ID: <1700930141-5568-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cue_y-qazPCNjCi9FU_TAdMK1cJo0UhR
X-Proofpoint-GUID: cue_y-qazPCNjCi9FU_TAdMK1cJo0UhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_16,2023-11-22_01,2023-05-22_02

All the mailbox messages sent to AF needs to be guarded
by mutex lock. Add the missing lock in otx2_get_pauseparam
function.

Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 9efcec5..53f6258 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -334,9 +334,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	if (is_otx2_lbkvf(pfvf->pdev))
 		return;
 
+	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_cgx_cfg_pause_frm(&pfvf->mbox);
-	if (!req)
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
 		return;
+	}
 
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pause_frm_cfg *)
@@ -344,6 +347,7 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 		pause->rx_pause = rsp->rx_pause;
 		pause->tx_pause = rsp->tx_pause;
 	}
+	mutex_unlock(&pfvf->mbox.lock);
 }
 
 static int otx2_set_pauseparam(struct net_device *netdev,
-- 
2.7.4


