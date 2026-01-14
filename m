Return-Path: <netdev+bounces-249729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D70D1CC0C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5B9300549A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF2376BDE;
	Wed, 14 Jan 2026 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ejGTxOBa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C6374197;
	Wed, 14 Jan 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373902; cv=none; b=YKVbmhMktp8OLS2EUMB4CSGwAOuORFbeO27f0De/vmGm/3tm4nOxsXOSzNl7esJbv1LI0NS7gBOoKh2HgYiPIqkLvUoEBSv9UMH7SVZ2qK4oWJBKfV4kosKFLdubu7eO3GNTvJ+mddyCTxGdu6IQsKfQBUS3CRnowgYjIDVJFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373902; c=relaxed/simple;
	bh=MN0bHbwRkZTdtkAe1tltu5qGl0IBBpvrY9HUzJopfGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZ0Gs/sT2XAysaqtDAWgrDLWx2EydXrviiDVFpJPoHUVNgbKYWH3e1V/xBp+pMU38E34TjtM0+ZvMmZu5gFtZg3g0qMh0dNF6XNtDe6FsaiHc420k1OuQP2FvrCfz7Y3NOuJgKvr6a6d/QCm83V8pOApxhcIjOt4EGaKhQ5Iq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ejGTxOBa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E6bUBB2027559;
	Tue, 13 Jan 2026 22:57:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
	84dzF5mkQgt+yZZzQwhjeODkWNkIJ/DRrdmdiUsRGM=; b=ejGTxOBal6/65xQS8
	NUnmlaiEdtaBs8YSsb+cqRyFMUabkzryEuNUgQAYnKVWMTKYl1izvyqbOIeFZ72N
	al03D86fsc/jMlQ6jrBOI3IfvUTSTCceEUKoioFX2fDpGsDkmHBBGbhvkfnACCkJ
	ooaZkEfXC8JnrKhknp9P1qQ77uXR59C0cxcEUS27KQ6lzdJqCCHopzX9L2zvDiJd
	F7oRpqiAJTmiFCO4MxVOrDsx2xlC1k7Oz/LNtu5npgJN62qazBb70Ahjk1hFo4+T
	BQICv3Qf+KP+UrBPThujfNlidlRYwGYhXIaUYyYe0G704IxwNAol6lzRgHcEVbDm
	2o2JQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bngnqb661-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 22:57:58 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 22:57:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 22:57:57 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 164453F7043;
	Tue, 13 Jan 2026 22:57:52 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 2/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Wed, 14 Jan 2026 12:27:43 +0530
Message-ID: <20260114065743.2162706-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114065743.2162706-1-hkelam@marvell.com>
References: <20260114065743.2162706-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DLeCIiNb c=1 sm=1 tr=0 ts=69673e76 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=fdgcc8vwWq-MLF2QXq0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: dtg8ShsF5QKojek5yDMHXuJWsKNyU0sz
X-Proofpoint-ORIG-GUID: dtg8ShsF5QKojek5yDMHXuJWsKNyU0sz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA1MiBTYWx0ZWRfXwA8mTev0lFav
 jWxENSn/isQvPgT9G7eQXcHEzpwCgHEXhcus9RVcOpJI09fue3G7ZHbHyDyy/xRHati3HmAtFcT
 6ZSH4TG/tdmdyTAvsYU9OE+4H0WQ+EyyjagCLwYDzoU5ecW7QRJqKDi/snhXwpSdLFj+/JadzNj
 eQ2sKJr03PW9MDCa2UBCuwSP1hFVUTPz+0s4VikuxpwI+AidxGY3qbQudS2gEjBaHfQzWjMoYBL
 BGiRmdEQd2rNNiyou9CyZy+8aH3HwhzrqgcOXm/J6isfO6BUsubLMqb/0Pogw6Fs0ak9xS8uI50
 o4wFUGSga+MV8pZOUu36u7hFOMYpX+FaiC/jtvfX59SoVQFU1gWVoWwuChl8ReT8AfmxepmREiL
 j1PQbq4p1YmZ2HY1dv6QmixfW1a4zG4Aub+3CM8SUvFjlH0Zudqjs8HudvYVyfwTmQHDsvL8GHc
 dpIYOwrhVOCUJZlYAMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01

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
 .../marvell/octeontx2/nic/otx2_devlink.c      | 160 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_devlink.h      |  28 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   7 +
 3 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index a72694219df4..98b835e66479 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -6,6 +6,12 @@
 
 #include "otx2_common.h"
 
+struct otx2_trap otx2_trap_items_arr[] = {
+	{
+		.trap = OTX2_TRAP_DROP(DMAC_FILTER, L2_DROPS),
+	},
+};
+
 /* Devlink Params APIs */
 static int otx2_dl_mcam_count_validate(struct devlink *devlink, u32 id,
 				       union devlink_param_value val,
@@ -189,11 +195,93 @@ static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
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
@@ -242,3 +330,75 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
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
index c7bd4f3c6c6b..70608e8937b8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
@@ -8,13 +8,39 @@
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
+static const struct devlink_trap_group otx2_trap_groups_arr[] = {
+	/* No policer is associated with following groups (policerid == 0)*/
+	DEVLINK_TRAP_GROUP_GENERIC(L2_DROPS, 0),
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


