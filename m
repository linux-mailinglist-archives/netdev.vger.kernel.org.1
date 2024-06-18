Return-Path: <netdev+bounces-104342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99AE90C354
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754692844BC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5112B95;
	Tue, 18 Jun 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WngEI+ij"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EA81E;
	Tue, 18 Jun 2024 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691100; cv=none; b=fCytyWHluHdUYyzcjvjNdTO1AkyYYkh4eyF8yzkWypVJ3q48c24iblvFbzN5wv2aSMdl5Dzx+1CJbUfFVxtqfuJWQbVmMpfFlPZGyD2zPbsCID+9JUM6qImE4l8v5f0fqakTbxIuIXG6IfB/kGmfPlYU1vlj/UenKUsSsAa4M3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691100; c=relaxed/simple;
	bh=kME9BdtvzC+4KF2BU+0JcBQkX5uvuN2MNShMq84mZBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BobZxPtrsbuHefQdbuP+5NpgVxb0Pm9pTphsG70pE88/Ci/COK4hW0QnGzgJ27asmRTVMuUxR4CfNo9bHagNxgS1iQdPyak7iDI1KKxMO2HD7TxQaoDk+7HCl5eLa5fvj6TFS6LzD8/f/qyIZUEoTkmIFoSXlm9q6Eo9oMVRZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WngEI+ij; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HIkL2a017645;
	Mon, 17 Jun 2024 23:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=CO/bmxZ8gDB4g2Hg2KtGgps+FXjnTZ/iMxrbvKGZ0xM=; b=Wng
	EI+ijvWm08/NwejTHwzNJimcUUzn3/F73SL4Ms2HjKnZDldS5kY2n+5sBJgIE1DQ
	0zm2O8f9jEpvijGBV8mPOBXqTnUU4cUoWloUFHe+/8868byoXwR6SvKrAu1izA+9
	BjcflWmiJqdK73yXsZ+EkXnQFdogJ6ZGSWT1pjKLK9jvHRqtWw4pK5H8zCiQ1t9b
	kP4mBMzcJhKuhLSxZ6FrLeNXWb+6qYamymkVOohM4rb+9ahWwk5sceIhbhndd/7A
	4k02ZA1l1ZYAMUXy/xgkaPRWBTVp1Fr4Z6v/rEnPizxcvKm88zl9hHuhyCxjCZz8
	NQFfeaW84ulS+evijJA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ysafh8drv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 23:11:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 23:11:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 23:11:30 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7A96A3F706D;
	Mon, 17 Jun 2024 23:11:25 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-pf: Fix linking objects into multiple modules
Date: Tue, 18 Jun 2024 11:41:22 +0530
Message-ID: <20240618061122.6628-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lm4U5CH5WfhHlLydH643g_56zZn9gQxe
X-Proofpoint-GUID: lm4U5CH5WfhHlLydH643g_56zZn9gQxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01

This patch fixes the below build warning messages that are
caused due to linking same files to multiple modules by
exporting the required symbols.

"scripts/Makefile.build:244: drivers/net/ethernet/marvell/octeontx2/nic/Makefile:
otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf

scripts/Makefile.build:244: drivers/net/ethernet/marvell/octeontx2/nic/Makefile:
otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf"

Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/Makefile       | 3 +--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 7 +++++++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 5664f768cb0c..64a97a0a10ed 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -9,10 +9,9 @@ obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o
-rvu_nicvf-y := otx2_vf.o otx2_devlink.o
+rvu_nicvf-y := otx2_vf.o
 
 rvu_nicpf-$(CONFIG_DCB) += otx2_dcbnl.o
-rvu_nicvf-$(CONFIG_DCB) += otx2_dcbnl.o
 rvu_nicpf-$(CONFIG_MACSEC) += cn10k_macsec.o
 
 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index 28fb643d2917..aa01110f04a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -54,6 +54,7 @@ int otx2_pfc_txschq_config(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_config);
 
 static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -122,6 +123,7 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_alloc);
 
 static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -260,6 +262,7 @@ int otx2_pfc_txschq_update(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_update);
 
 int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 {
@@ -282,6 +285,7 @@ int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_stop);
 
 int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 {
@@ -321,6 +325,7 @@ int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_config_priority_flow_ctrl);
 
 void otx2_update_bpid_in_rqctx(struct otx2_nic *pfvf, int vlan_prio, int qidx,
 			       bool pfc_enable)
@@ -385,6 +390,7 @@ void otx2_update_bpid_in_rqctx(struct otx2_nic *pfvf, int vlan_prio, int qidx,
 			 "Updating BPIDs in CQ and Aura contexts of RQ%d failed with err %d\n",
 			 qidx, err);
 }
+EXPORT_SYMBOL(otx2_update_bpid_in_rqctx);
 
 static int otx2_dcbnl_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
 {
@@ -472,3 +478,4 @@ int otx2_dcbnl_set_ops(struct net_device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_dcbnl_set_ops);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 99ddf31269d9..458d34a62e18 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -113,6 +113,7 @@ int otx2_register_dl(struct otx2_nic *pfvf)
 	devlink_free(dl);
 	return err;
 }
+EXPORT_SYMBOL(otx2_register_dl);
 
 void otx2_unregister_dl(struct otx2_nic *pfvf)
 {
@@ -124,3 +125,4 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
 				  ARRAY_SIZE(otx2_dl_params));
 	devlink_free(dl);
 }
+EXPORT_SYMBOL(otx2_unregister_dl);
-- 
2.25.1


