Return-Path: <netdev+bounces-250715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CFD38FE1
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B99A30049E9
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCB222587;
	Sat, 17 Jan 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HCNMdXSP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D7246BB2;
	Sat, 17 Jan 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768668964; cv=none; b=KMYlBpYcVIIQ/QhfinWfAISwMJGyMUr2zWFMhmqvSb/EfA9unhnTQlq33faoSgdIGjbXNviZoWGeH5F8ujLBvCarh/3ppK7fuZ4O2RQYG0n7S+pI592LF+r+xP+Ul1YKWDv+H++efTNw/L4qzVeEy6WQuQ4ThZbKJ8Fa3YhuXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768668964; c=relaxed/simple;
	bh=mCHuL2E7iACf7ljMTMFV6O0iEhnxRNwfyFKt665dIUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVNPXYqb22BqxNUeHeGuCU/d2crM6/Ib+kYBycGzC+f+Nu4yp4Qjk8E5PavMIkORCQMk26R4tRue/4pV+TbD0Yc5NnlOSUM1GQrotalTlEncQ3Fn2rFOytG8E6/8SJs7a1n8Je7RJzbW1A8PBEkJ3BZiDxJjNc/PLaTvOdRXb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HCNMdXSP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60HGSYxi1468552;
	Sat, 17 Jan 2026 08:55:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
	kcA/KcQytYhfdgHGeWAVEXxfElDZYf0OZ+enX5Sywg=; b=HCNMdXSPlqVq4QoGr
	6lFbVQWIew72LJDcjQJxxc2JJG0xnosw/vehhrekXgGrQczxkK9Qimnq18rhUhP7
	0OpIK9ZNaSVV9ai2mScOVUx8bMDPNjvLT+dw5GEdqg+InTq3EJ/v0zG8Rm1ObPyb
	CUSlfZ3+1RmZZooenhikQUbV31Ey7zzLNvJigZm0ZQu3zZoCn+Bw5UtTygMcGuTN
	uvJVYmF5MK9itMxYGepW1SsLw2OJnyG8+66X2vX4ZkWt06BbyH4KgOlYV4N3Vvn4
	c2j9snQkWr0csfcGHvw1ODQp3a6oA2C7orM03qc1h0RS3esJR5T5LrPXywDqezje
	pHZUw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4br2yvrsfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 08:55:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 17 Jan 2026 08:55:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 17 Jan 2026 08:55:34 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 9A1F23F70C5;
	Sat, 17 Jan 2026 08:55:30 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV2 2/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Sat, 17 Jan 2026 22:25:20 +0530
Message-ID: <20260117165520.2215073-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260117165520.2215073-1-hkelam@marvell.com>
References: <20260117165520.2215073-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=WckBqkhX c=1 sm=1 tr=0 ts=696bbf08 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=fdgcc8vwWq-MLF2QXq0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: eI3vds2grBNMdf9_rCd67zUio8IzrWlz
X-Proofpoint-ORIG-GUID: eI3vds2grBNMdf9_rCd67zUio8IzrWlz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDE0MSBTYWx0ZWRfX/UlHZAQLORVx
 raXHTqw//AmtgKtfwECKsT0CeFdrucIkc18sA1pSZnmLlIW2ikrQiyMtVZSCH9hpBBvQ3Pbv2XH
 q4b/tk5tVs29P3qb2DWuNU6FZFAaC/MU0dwUNi+1hS405LeFJkQXG8AqpTPGygQz039SHwxul8H
 oZS+KNLBhygez+dYOYlc1/8mki90/sRgXd7dIlNu47t+WyWGv0oC3R179c1l2+71zTFcyfYuW7R
 SXpTxDnKlJSDIFx5uokXYu7gWC3FXgM5y3SgwIIOm22C2VuVf+9fMLgDpW+evFO8Z8iavLdzRcb
 9x16JP8ALGOMLocmAJ/r6KcF6AvFUrvGl9gdLYyuURNGUZugtRBcE8oXrrPPsz4gVgnYu2y6+qv
 wmoxWde2BRFk332/GmmllVEqeNVFyiKB1gci1xfCm3blvXp59MxrG7vB/oF18mKnO9UeEzELgBR
 67alZGQ21VItv0DgDNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_02,2026-01-15_02,2025-10-01_01

This patch adds support for DMAC_FILTER trap.

devlink trap show
pci/0002:02:00.0:
  name otx2_dmac_filter type drop generic false action trap group l2_drops

to get counter
devlink -s trap show
pci/0002:02:00.0:
  name otx2_dmac_filter type drop generic false action trap group l2_drops
    stats:
        rx:
          bytes 0 packets 0 dropped 0

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
V2 * fix warning reported by kernel test robot

 .../marvell/octeontx2/nic/otx2_devlink.c      | 165 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_devlink.h      |  23 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   7 +
 3 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index a72694219df4..9f1b78286695 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -6,6 +6,17 @@
 
 #include "otx2_common.h"
 
+static struct devlink_trap_group otx2_trap_groups_arr[] = {
+	/* No policer is associated with following groups (policerid == 0)*/
+	DEVLINK_TRAP_GROUP_GENERIC(L2_DROPS, 0),
+};
+
+static struct otx2_trap otx2_trap_items_arr[] = {
+	{
+		.trap = OTX2_TRAP_DROP(DMAC_FILTER, L2_DROPS),
+	},
+};
+
 /* Devlink Params APIs */
 static int otx2_dl_mcam_count_validate(struct devlink *devlink, u32 id,
 				       union devlink_param_value val,
@@ -189,11 +200,93 @@ static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 }
 #endif
 
+static struct otx2_trap_item *
+otx2_devlink_trap_item_lookup(struct otx2_devlink *dl, u16 trap_id)
+{
+	struct otx2_trap_data *trap_data = dl->trap_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(otx2_trap_items_arr); i++) {
+		if (otx2_trap_items_arr[i].trap.id == trap_id)
+			return &trap_data->trap_items_arr[i];
+	}
+
+	return NULL;
+}
+
+static int otx2_trap_init(struct devlink *devlink,
+			  const struct devlink_trap *trap, void *trap_ctx)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_trap_item *trap_item;
+
+	trap_item = otx2_devlink_trap_item_lookup(otx2_dl, trap->id);
+	if (WARN_ON(!trap_item))
+		return -EINVAL;
+
+	trap_item->trap_ctx = trap_ctx;
+	trap_item->action = trap->init_action;
+
+	return 0;
+}
+
+static int otx2_trap_action_set(struct devlink *devlink,
+				const struct devlink_trap *trap,
+				enum devlink_trap_action action,
+				struct netlink_ext_ack *extack)
+{
+	/* Currently, driver does not support trap action altering */
+	return -EOPNOTSUPP;
+}
+
+static int
+otx2_trap_drop_counter_get(struct devlink *devlink,
+			   const struct devlink_trap *trap,
+			   u64 *p_drops)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+	struct cgx_dmac_filter_drop_cnt *rsp;
+	struct msg_req *req;
+	int err;
+
+	if (trap->id != DEVLINK_TRAP_GENERIC_ID_DMAC_FILTER)
+		return -EINVAL;
+
+	/* send mailbox to AF */
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_cgx_get_dmacflt_dropped_pktcnt(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	err = otx2_sync_mbox_msg(&pfvf->mbox);
+	if (err)
+		goto fail;
+
+	rsp = (struct cgx_dmac_filter_drop_cnt *)
+			otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		err = PTR_ERR(rsp);
+		goto fail;
+	}
+	*p_drops = rsp->count;
+
+fail:
+	mutex_unlock(&pfvf->mbox.lock);
+	return err;
+}
+
 static const struct devlink_ops otx2_devlink_ops = {
 #ifdef CONFIG_RVU_ESWITCH
 	.eswitch_mode_get = otx2_devlink_eswitch_mode_get,
 	.eswitch_mode_set = otx2_devlink_eswitch_mode_set,
 #endif
+	.trap_init = otx2_trap_init,
+	.trap_action_set = otx2_trap_action_set,
+	.trap_drop_counter_get = otx2_trap_drop_counter_get,
 };
 
 int otx2_register_dl(struct otx2_nic *pfvf)
@@ -242,3 +335,75 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
 	devlink_free(dl);
 }
 EXPORT_SYMBOL(otx2_unregister_dl);
+
+int otx2_devlink_traps_register(struct otx2_nic *pf)
+{
+	const u32 groups_count = ARRAY_SIZE(otx2_trap_groups_arr);
+	const u32 traps_count = ARRAY_SIZE(otx2_trap_items_arr);
+	struct devlink *devlink = priv_to_devlink(pf->dl);
+	struct otx2_trap_data *trap_data;
+	struct otx2_trap *otx2_trap;
+	int err, i;
+
+	trap_data = kzalloc(sizeof(*trap_data), GFP_KERNEL);
+	if (!trap_data)
+		return -ENOMEM;
+
+	trap_data->trap_items_arr = kcalloc(traps_count,
+					    sizeof(struct otx2_trap_item),
+					    GFP_KERNEL);
+	if (!trap_data->trap_items_arr) {
+		err = -ENOMEM;
+		goto err_trap_items_alloc;
+	}
+
+	trap_data->dl = pf->dl;
+	trap_data->traps_count = traps_count;
+	pf->dl->trap_data = trap_data;
+
+	err = devlink_trap_groups_register(devlink, otx2_trap_groups_arr,
+					   groups_count);
+	if (err)
+		goto err_groups_register;
+
+	for (i = 0; i < traps_count; i++) {
+		otx2_trap = &otx2_trap_items_arr[i];
+		err = devlink_traps_register(devlink, &otx2_trap->trap, 1,
+					     pf);
+		if (err)
+			goto err_trap_register;
+	}
+
+	return 0;
+
+err_trap_register:
+	for (i--; i >= 0; i--) {
+		otx2_trap = &otx2_trap_items_arr[i];
+		devlink_traps_unregister(devlink, &otx2_trap->trap, 1);
+	}
+	devlink_trap_groups_unregister(devlink, otx2_trap_groups_arr,
+				       groups_count);
+err_groups_register:
+	kfree(trap_data->trap_items_arr);
+err_trap_items_alloc:
+	kfree(trap_data);
+	return err;
+}
+
+void otx2_devlink_traps_unregister(struct otx2_nic *pf)
+{
+	struct otx2_trap_data *trap_data = pf->dl->trap_data;
+	struct devlink *devlink = priv_to_devlink(pf->dl);
+	const struct devlink_trap *trap;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(otx2_trap_items_arr); ++i) {
+		trap = &otx2_trap_items_arr[i].trap;
+		devlink_traps_unregister(devlink, trap, 1);
+	}
+
+	devlink_trap_groups_unregister(devlink, otx2_trap_groups_arr,
+				       ARRAY_SIZE(otx2_trap_groups_arr));
+	kfree(trap_data->trap_items_arr);
+	kfree(trap_data);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
index c7bd4f3c6c6b..d127d54941bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
@@ -8,13 +8,34 @@
 #ifndef	OTX2_DEVLINK_H
 #define	OTX2_DEVLINK_H
 
+#define OTX2_TRAP_DROP(_id, _group_id)					\
+	DEVLINK_TRAP_GENERIC(DROP, DROP, _id,				\
+			     DEVLINK_TRAP_GROUP_GENERIC_ID_##_group_id, \
+			     DEVLINK_TRAP_METADATA_TYPE_F_IN_PORT)
+struct otx2_trap {
+	struct devlink_trap trap;
+};
+
+struct otx2_trap_item {
+	enum devlink_trap_action action;
+	void *trap_ctx;
+};
+
+struct otx2_trap_data {
+	struct otx2_devlink *dl;
+	struct otx2_trap_item *trap_items_arr;
+	u32 traps_count;
+};
+
 struct otx2_devlink {
 	struct devlink *dl;
 	struct otx2_nic *pfvf;
+	struct otx2_trap_data *trap_data;
 };
 
 /* Devlink APIs */
 int otx2_register_dl(struct otx2_nic *pfvf);
 void otx2_unregister_dl(struct otx2_nic *pfvf);
-
+void otx2_devlink_traps_unregister(struct otx2_nic *pfvf);
+int otx2_devlink_traps_register(struct otx2_nic *pfvf);
 #endif /* RVU_DEVLINK_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a7feb4c392b3..5da1605a1a90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3282,6 +3282,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_mcam_flow_del;
 
+	err = otx2_devlink_traps_register(pf);
+	if (err)
+		goto err_traps_unregister;
+
 	/* Initialize SR-IOV resources */
 	err = otx2_sriov_vfcfg_init(pf);
 	if (err)
@@ -3314,6 +3318,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	otx2_sriov_vfcfg_cleanup(pf);
 err_pf_sriov_init:
 	otx2_shutdown_tc(pf);
+err_traps_unregister:
+	otx2_devlink_traps_unregister(pf);
 err_mcam_flow_del:
 	otx2_mcam_flow_del(pf);
 err_unreg_netdev:
@@ -3514,6 +3520,7 @@ static void otx2_remove(struct pci_dev *pdev)
 	/* Disable link notifications */
 	otx2_cgx_config_linkevents(pf, false);
 
+	otx2_devlink_traps_unregister(pf);
 	otx2_unregister_dl(pf);
 	unregister_netdev(netdev);
 	cn10k_ipsec_clean(pf);
-- 
2.34.1


