Return-Path: <netdev+bounces-24016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C276E785
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38260281DB4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036F1E50F;
	Thu,  3 Aug 2023 11:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6191DDF6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:57:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D682D72
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JISunXj8VBnyPSlb9JrRjisY5QVAKJ1Za1o/quPIYWdpwASMvPw/ZJkcCATCzLd5kxHn9trIIgrxfohO7LWD8L983QE1QLSkwKWQ5tjgtxEOqPpGMY4q6M7XuBgNsLAlQkNz/TOWVqfrsGUl5WYwDqogj+GUL9JUelSImM9SXvnNZUtsy4dvDwxomum7W5Drjwn4027XV8SGGSO7Kaz5dOhNJeQE/rkKUgwWrDUSPluCUsCybbPSpV+WQ9m448oR1rYXubQ+cox8Tx4SCEqZ/7w+dg6ldwJJr487Bsm5ekMFNhRtu8+5ViEtAaWWQ5mExvnh47aCNrRii1QIrF8Viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgdyQ38kyaj41U7KDaEggS0rGFDFL8703Dr2rVjGfZo=;
 b=GcOaVaa4cd/OzqXIfYlGWKmMifp6F23qaFwxdOep7gKBw0z4XfrBuJDoQ/Ei6l0XxcWy/Ob57J8R31N698pxXmbBlZhpH1I5fGuz9o3x2g7cmCmqVZuBpl2rl3KbtxRnvGS80vYc7rpAm9QK51KhDozi/d8pHRfKh1xbpoDsg+yqSWoRKP90C6zq79lhmquEKWegYhhDcERXx3S7DhsNPUXrow/WtD+ava0wRIVvE5O05UrRzruF6aQK4ZPG21fjFUBKU3/oBp7iDrm3WwoPx0HQ35Y9/jJBaMS/iJNlvfcscJZMk+qR5H3lxG/4F2DFbWrhTsfGqvbcGBK5UspfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgdyQ38kyaj41U7KDaEggS0rGFDFL8703Dr2rVjGfZo=;
 b=u6ZGDy23GnRju2oUMY0ro3HsqgFfee2V0528XWXlSaO3aNh3UvCva2lPS2DnsY83mRazLGlE4rUY8WsPqdyRy67m/ySfEUwtG9KiJeiYsBpCyHWk1BlA8ELamW98ExuSfKM/w518xy+VodakCNTgtbnny5s7DWhij3oOm/nDXOQ=
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Thu, 3 Aug
 2023 11:57:32 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::8a) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 11:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 11:57:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 06:57:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 04:57:30 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 06:57:29 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 2/7] sfc: functions to register for conntrack zone offload
Date: Thu, 3 Aug 2023 12:56:18 +0100
Message-ID: <ae51a4bd631f6f730a5b8be9437ead28a220c7ff.1691063676.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1691063675.git.ecree.xilinx@gmail.com>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 8334d811-95a7-4d08-de36-08db9418d177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MBOdl75YZYQ+ioKtrnKn9JT1Vu8XAOrjKLQZHlESsXhiaa8wQnr4fVRaBWRN2oE7IeYOo28ianuMUmW7o207P7qL3gIfPIVdnnjZdvEtHeyqOkZGB9zmwqkbg22FI9Yg7S9Tqy2xeu3e74VqQuRDUVf+h6no2GwBMoZFrhTzevxhMYKlzKbp4lk+ebPiFUicFhH8xj/WrrtubP+JeQenkpvAWXbKjFAY2Igqf7Qke2SV4kTfONQHC5CpH0nZ6rGMrTrpvEmm3imQJfsnPnQk3yFvElF8spT4c9XuUquXZ6rLHzgu8Zix7D1eqZE8Fij4xeQfFHkxEQTnssGx9mBCWw3rjIPiUdOnJ0oG+YZBwvu3+6gS4TaYkiNFgqo04/lvoBerB1SUmcev6Bt4gYoxW2Ext1axWx6Nfrpl3EuStKMwZT5E/k2erBmx2tGc9xY/knGsI2+RlCpNa0y3i8IJnoNKRGmPrAM34t2WPuzv36ppjphHzcLAqsItlR8Y2RF9UUyYKVERuI+bAbOb/Ei7pAe9cqG+5tMJHvNU7biXRDj7F7kvX17YOaZX/eKWAI/yyY9vzbsXkMi3amUVVe/WmIxnvDj8hvQ/iX9PXkMPOP5zlKAb9F+2jXkIEjqZcYk3UPNah1Hk0uwvTg4sFxNep0KsDd10maI9G3JlWqAbzcP2iOSjPxkMr94wKUdOrYgvlXlIbMPevJQTxonpyMbV32JBuY8SNmzgGiNgXE/DFidqhNgMNhy3/e50i1Xq+Y36k2+KBzQ+iAR5wMsO0tvzphi7b38j6YadLLoki/X+758=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(47076005)(426003)(8676002)(8936002)(2876002)(2906002)(55446002)(83380400001)(86362001)(5660300002)(36860700001)(70206006)(70586007)(36756003)(41300700001)(356005)(4326008)(81166007)(186003)(316002)(336012)(26005)(478600001)(110136005)(40460700003)(54906003)(6666004)(40480700001)(82740400003)(9686003)(2004002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:57:31.6383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8334d811-95a7-4d08-de36-08db9418d177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Bind a stub callback to the netfilter flow table.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/Makefile       |   2 +-
 drivers/net/ethernet/sfc/tc.c           |   7 ++
 drivers/net/ethernet/sfc/tc.h           |   2 +
 drivers/net/ethernet/sfc/tc_conntrack.c | 109 ++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc_conntrack.h |  37 ++++++++
 5 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.c
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.h

diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 16293b58e0a8..8f446b9bd5ee 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -11,7 +11,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
 sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
-                           tc_encap_actions.o
+                           tc_encap_actions.o tc_conntrack.o
 
 obj-$(CONFIG_SFC)	+= sfc.o
 
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 4dc979fdc968..44a6fc30b722 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -15,6 +15,7 @@
 #include "tc.h"
 #include "tc_bindings.h"
 #include "tc_encap_actions.h"
+#include "tc_conntrack.h"
 #include "mae.h"
 #include "ef100_rep.h"
 #include "efx.h"
@@ -1747,6 +1748,9 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	rc = rhashtable_init(&efx->tc->match_action_ht, &efx_tc_match_action_ht_params);
 	if (rc < 0)
 		goto fail_match_action_ht;
+	rc = efx_tc_init_conntrack(efx);
+	if (rc < 0)
+		goto fail_conntrack;
 	efx->tc->reps_filter_uc = -1;
 	efx->tc->reps_filter_mc = -1;
 	INIT_LIST_HEAD(&efx->tc->dflt.pf.acts.list);
@@ -1759,6 +1763,8 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	efx->tc->facts.reps.fw_id = MC_CMD_MAE_ACTION_SET_ALLOC_OUT_ACTION_SET_ID_NULL;
 	efx->extra_channel_type[EFX_EXTRA_CHANNEL_TC] = &efx_tc_channel_type;
 	return 0;
+fail_conntrack:
+	rhashtable_destroy(&efx->tc->match_action_ht);
 fail_match_action_ht:
 	rhashtable_destroy(&efx->tc->encap_match_ht);
 fail_encap_match_ht:
@@ -1792,6 +1798,7 @@ void efx_fini_struct_tc(struct efx_nic *efx)
 				    efx);
 	rhashtable_free_and_destroy(&efx->tc->encap_match_ht,
 				    efx_tc_encap_match_free, NULL);
+	efx_tc_fini_conntrack(efx);
 	efx_tc_fini_counters(efx);
 	efx_tc_fini_encap_actions(efx);
 	mutex_unlock(&efx->tc->mutex);
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 27592f10b536..fc196eb897af 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -196,6 +196,7 @@ struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
  * @encap_ht: Hashtable of TC encap actions
  * @encap_match_ht: Hashtable of TC encap matches
  * @match_action_ht: Hashtable of TC match-action rules
+ * @ct_zone_ht: Hashtable of TC conntrack flowtable bindings
  * @neigh_ht: Hashtable of neighbour watches (&struct efx_neigh_binder)
  * @meta_ct: MAE table layout for conntrack table
  * @reps_mport_id: MAE port allocated for representor RX
@@ -228,6 +229,7 @@ struct efx_tc_state {
 	struct rhashtable encap_ht;
 	struct rhashtable encap_match_ht;
 	struct rhashtable match_action_ht;
+	struct rhashtable ct_zone_ht;
 	struct rhashtable neigh_ht;
 	struct efx_tc_table_ct meta_ct;
 	u32 reps_mport_id, reps_mport_vport_id;
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
new file mode 100644
index 000000000000..d67302715ec3
--- /dev/null
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ * Driver for Solarflare network controllers and boards
+ * Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include "tc_conntrack.h"
+#include "tc.h"
+#include "mae.h"
+
+static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
+			     void *cb_priv);
+
+static const struct rhashtable_params efx_tc_ct_zone_ht_params = {
+	.key_len	= offsetof(struct efx_tc_ct_zone, linkage),
+	.key_offset	= 0,
+	.head_offset	= offsetof(struct efx_tc_ct_zone, linkage),
+};
+
+static void efx_tc_ct_zone_free(void *ptr, void *arg)
+{
+	struct efx_tc_ct_zone *zone = ptr;
+	struct efx_nic *efx = zone->efx;
+
+	netif_err(efx, drv, efx->net_dev,
+		  "tc ct_zone %u still present at teardown, removing\n",
+		  zone->zone);
+
+	nf_flow_table_offload_del_cb(zone->nf_ft, efx_tc_flow_block, zone);
+	kfree(zone);
+}
+
+int efx_tc_init_conntrack(struct efx_nic *efx)
+{
+	int rc;
+
+	rc = rhashtable_init(&efx->tc->ct_zone_ht, &efx_tc_ct_zone_ht_params);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+void efx_tc_fini_conntrack(struct efx_nic *efx)
+{
+	rhashtable_free_and_destroy(&efx->tc->ct_zone_ht, efx_tc_ct_zone_free, NULL);
+}
+
+static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
+			     void *cb_priv)
+{
+	return -EOPNOTSUPP;
+}
+
+struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
+					       struct nf_flowtable *ct_ft)
+{
+	struct efx_tc_ct_zone *ct_zone, *old;
+	int rc;
+
+	ct_zone = kzalloc(sizeof(*ct_zone), GFP_USER);
+	if (!ct_zone)
+		return ERR_PTR(-ENOMEM);
+	ct_zone->zone = zone;
+	old = rhashtable_lookup_get_insert_fast(&efx->tc->ct_zone_ht,
+						&ct_zone->linkage,
+						efx_tc_ct_zone_ht_params);
+	if (old) {
+		/* don't need our new entry */
+		kfree(ct_zone);
+		if (!refcount_inc_not_zero(&old->ref))
+			return ERR_PTR(-EAGAIN);
+		/* existing entry found */
+		WARN_ON_ONCE(old->nf_ft != ct_ft);
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Found existing ct_zone for %u\n", zone);
+		return old;
+	}
+	ct_zone->nf_ft = ct_ft;
+	ct_zone->efx = efx;
+	rc = nf_flow_table_offload_add_cb(ct_ft, efx_tc_flow_block, ct_zone);
+	netif_dbg(efx, drv, efx->net_dev, "Adding new ct_zone for %u, rc %d\n",
+		  zone, rc);
+	if (rc < 0)
+		goto fail;
+	refcount_set(&ct_zone->ref, 1);
+	return ct_zone;
+fail:
+	rhashtable_remove_fast(&efx->tc->ct_zone_ht, &ct_zone->linkage,
+			       efx_tc_ct_zone_ht_params);
+	kfree(ct_zone);
+	return ERR_PTR(rc);
+}
+
+void efx_tc_ct_unregister_zone(struct efx_nic *efx,
+			       struct efx_tc_ct_zone *ct_zone)
+{
+	if (!refcount_dec_and_test(&ct_zone->ref))
+		return; /* still in use */
+	nf_flow_table_offload_del_cb(ct_zone->nf_ft, efx_tc_flow_block, ct_zone);
+	rhashtable_remove_fast(&efx->tc->ct_zone_ht, &ct_zone->linkage,
+			       efx_tc_ct_zone_ht_params);
+	netif_dbg(efx, drv, efx->net_dev, "Removed ct_zone for %u\n",
+		  ct_zone->zone);
+	kfree(ct_zone);
+}
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.h b/drivers/net/ethernet/sfc/tc_conntrack.h
new file mode 100644
index 000000000000..f1e5fb74a73f
--- /dev/null
+++ b/drivers/net/ethernet/sfc/tc_conntrack.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for Solarflare network controllers and boards
+ * Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_TC_CONNTRACK_H
+#define EFX_TC_CONNTRACK_H
+#include "net_driver.h"
+
+#if IS_ENABLED(CONFIG_SFC_SRIOV)
+#include <linux/refcount.h>
+#include <net/netfilter/nf_flow_table.h>
+
+struct efx_tc_ct_zone {
+	u16 zone;
+	struct rhash_head linkage;
+	refcount_t ref;
+	struct nf_flowtable *nf_ft;
+	struct efx_nic *efx;
+};
+
+/* create/teardown hashtables */
+int efx_tc_init_conntrack(struct efx_nic *efx);
+void efx_tc_fini_conntrack(struct efx_nic *efx);
+
+struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
+					       struct nf_flowtable *ct_ft);
+void efx_tc_ct_unregister_zone(struct efx_nic *efx,
+			       struct efx_tc_ct_zone *ct_zone);
+
+#endif /* CONFIG_SFC_SRIOV */
+#endif /* EFX_TC_CONNTRACK_H */

