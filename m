Return-Path: <netdev+bounces-30318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C67B786DD3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21E42815A2
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718DDF6B;
	Thu, 24 Aug 2023 11:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E9DF69
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:28:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D2C10FA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlO8ppDl+v7eLMaCBDUfQg2DqmpyyQIhJrEC8EjK7VR9H7x1ftrva9sEJbfTJiVj7O8MpUedy34l3ETqVEeYWq3cvgIkhOdrheO/uUCT3r1zqoglgS3XiKM1fd+KeTX8B19CN7tpLAPCfAEjwCYOoYeiC9ijNCSTtsBGTzpyvQxcbRd25bXGS2kSxz5cFkdedWmbVrb2stJiNb+gEs8PN9AB4X/4YIuwbozzBzvlGsO7TyRr9M2MuKkLZUP8UTNUS0bOkiQePy2sltf9cx/E7ERpfRDP4REXKBFrxcWLI8F4/MmL1BMVWDFGwZcWOGxhgMjznhypjor20CRcphCFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6GCCB8vFmzwH3aFo5B8BeG8Eywb03SFp19YqM/gSgM=;
 b=KSgAyTWxt+tqL2edOqOQNBzjRmmLVI2pnVZ2kb8NpX9Zur/WHaDstVFKxYEswVDcz15pNYmZIYNF+R9vCYPArCl3zEF726ysZ5lgcs1CoFE9ff+3H4B24PABcomNYFfgwckOSmBYPKbglDdIUZm7SZzOPcseu3lCpmcyz1Y2GKUYgExX3NYoDp/a4G8snrTttCF+eu+cBS/Ms0XQnJYOIhwj+IwN4Mi8ORpLUTATzz1vUgKicTq5H5fHwjgkMwZ0qcAPSyxwnjU37Wud488vnzCy+zNgJz5BYNMiZb+cXuBpHgdYgEUqmr6CQQTUinrE5xs2Hn4fVum7cVOgeIxwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6GCCB8vFmzwH3aFo5B8BeG8Eywb03SFp19YqM/gSgM=;
 b=0FqYBSZi891jVRhdlKgVaqxGUIXoprWqO450gNdXzKXqCenHZQtAa9E8eXzOFhqzyUzohgZRnATIBvRH0Br56D9DeQaaaB91qW2nmuKe0xz4hdnP7kfLcAEsPWa17WkuXqnbc+JXL/uJiZcrMzfNLU0z8kOkmVePnDA6Sud+JRM=
Received: from CYZPR05CA0002.namprd05.prod.outlook.com (2603:10b6:930:89::20)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:28:54 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::9f) by CYZPR05CA0002.outlook.office365.com
 (2603:10b6:930:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Thu, 24 Aug 2023 11:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:28:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:28:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:28:53 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:28:51 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next v2 1/6] sfc: introduce ethernet pedit set action infrastructure
Date: Thu, 24 Aug 2023 12:28:37 +0100
Message-ID: <20230824112842.47883-2-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
References: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: f5961641-d2e6-4c6a-bec8-08dba4954c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r+kCko7d4N2CSUZP+15w5bUJBdqOEUL/v/vdSv6T13zWT72RRbcY39XyZkyMFsVMba6ARV10LBFKYN82iW1pbH/NlC1qbL7nNbGMV/aPd5vR7NQaWoWTCOFgjJwJcW8bPZGXQSGHz20A07ysddlrPX/D+o2TdY+VqceIRoL4982D4DynruCnZmNO8JhSzxlfEXI3Renlm7BS5FOAhsYtM5AwIxH3qDZYHBpIl35FZjSmrNgfFJbcOgBOZBUTaRJ6KGw87SgGNTWk7d3pTpAtgNVesZcfgW4CnbwH0kGhA5+XYjPf32ByMVujXFQS5gT759vf1Z4coHIjEJHcn51F5nXfKdOaCsPjn8hujm/UskX5BUMmNgWmPu2TzAJoBRWhsGNShBv5+XksH71f+be3NlZKb8yjbPqow8VvKMjwZWjQiN0sggsNpLLJAN1g2RpaA15YoOGzQI0/4D0ezJQhB/gY8JPdHIqaVCiFc96/4wep8QZVGTN7/gZJ7QXuNnykf5bKvAROLbVkn3jFE7BE/IdDWIpONetzLyhbFQVvm9GSdrqzDr4Qp9J+rStqElx90oDPgWgHPhCHi0X9Vsm/NkRUlOp45FaC5YOH8QQjRfmOQv1cxXsXdcyMwAeZey23/wrVHGYVb8SaEj14eYMuZ04Ric6EH9lLflE8PKU3Js8hT7HOXnxL7T3iLxbHhNaPVBjEm1iHp8CcVMFnWUJcXYKeoUgFRaMWfcVFpPW3gOFnpYoCETJGo87i1zxsksiUBEq4tBPT3uHBG68mcQFiGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(70206006)(70586007)(6636002)(316002)(81166007)(478600001)(110136005)(40480700001)(26005)(6666004)(82740400003)(41300700001)(86362001)(2906002)(356005)(30864003)(4326008)(8936002)(8676002)(83380400001)(2616005)(40460700003)(5660300002)(47076005)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:28:53.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5961641-d2e6-4c6a-bec8-08dba4954c40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce the initial ethernet pedit set action infrastructure in
preparation for adding mac src and dst pedit action offloads.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/mae.c | 83 ++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/sfc/mae.h |  4 ++
 drivers/net/ethernet/sfc/tc.c  | 70 ++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc.h  | 56 ++++++++++++++++++++---
 4 files changed, 202 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 3b8780c76b6e..a7ad7ab8c5f4 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1219,6 +1219,71 @@ int efx_mae_enumerate_mports(struct efx_nic *efx)
 	return rc;
 }
 
+/**
+ * efx_mae_allocate_pedit_mac() - allocate pedit MAC address in HW.
+ * @efx:	NIC we're installing a pedit MAC address on
+ * @ped:	pedit MAC action to be installed
+ *
+ * Attempts to install @ped in HW and populates its id with an index of this
+ * entry in the firmware MAC address table on success.
+ *
+ * Return: negative value on error, 0 in success.
+ */
+int efx_mae_allocate_pedit_mac(struct efx_nic *efx,
+			       struct efx_tc_mac_pedit_action *ped)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_LEN);
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAE_MAC_ADDR_ALLOC_IN_LEN);
+	size_t outlen;
+	int rc;
+
+	BUILD_BUG_ON(MC_CMD_MAE_MAC_ADDR_ALLOC_IN_MAC_ADDR_LEN !=
+		     sizeof(ped->h_addr));
+	memcpy(MCDI_PTR(inbuf, MAE_MAC_ADDR_ALLOC_IN_MAC_ADDR), ped->h_addr,
+	       sizeof(ped->h_addr));
+	rc = efx_mcdi_rpc(efx, MC_CMD_MAE_MAC_ADDR_ALLOC, inbuf, sizeof(inbuf),
+			  outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+	if (outlen < sizeof(outbuf))
+		return -EIO;
+	ped->fw_id = MCDI_DWORD(outbuf, MAE_MAC_ADDR_ALLOC_OUT_MAC_ID);
+	return 0;
+}
+
+/**
+ * efx_mae_free_pedit_mac() - free pedit MAC address in HW.
+ * @efx:	NIC we're installing a pedit MAC address on
+ * @ped:	pedit MAC action that needs to be freed
+ *
+ * Frees @ped in HW, check that firmware did not free a different one and clears
+ * the id (which denotes the index of the entry in the MAC address table).
+ */
+void efx_mae_free_pedit_mac(struct efx_nic *efx,
+			    struct efx_tc_mac_pedit_action *ped)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_MAC_ADDR_FREE_OUT_LEN(1));
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAE_MAC_ADDR_FREE_IN_LEN(1));
+	size_t outlen;
+	int rc;
+
+	MCDI_SET_DWORD(inbuf, MAE_MAC_ADDR_FREE_IN_MAC_ID, ped->fw_id);
+	rc = efx_mcdi_rpc(efx, MC_CMD_MAE_MAC_ADDR_FREE, inbuf,
+			  sizeof(inbuf), outbuf, sizeof(outbuf), &outlen);
+	if (rc || outlen < sizeof(outbuf))
+		return;
+	/* FW freed a different ID than we asked for, should also never happen.
+	 * Warn because it means we've now got a different idea to the FW of
+	 * what MAC addresses exist, which could cause mayhem later.
+	 */
+	if (WARN_ON(MCDI_DWORD(outbuf, MAE_MAC_ADDR_FREE_OUT_FREED_MAC_ID) != ped->fw_id))
+		return;
+	/* We're probably about to free @ped, but let's just make sure its
+	 * fw_id is blatted so that it won't look valid if it leaks out.
+	 */
+	ped->fw_id = MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL;
+}
+
 int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act)
 {
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_ACTION_SET_ALLOC_OUT_LEN);
@@ -1231,10 +1296,20 @@ int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act)
 			      MAE_ACTION_SET_ALLOC_IN_VLAN_POP, act->vlan_pop,
 			      MAE_ACTION_SET_ALLOC_IN_DECAP, act->decap);
 
-	MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_SRC_MAC_ID,
-		       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
-	MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_DST_MAC_ID,
-		       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
+	if (act->src_mac)
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_SRC_MAC_ID,
+			       act->src_mac->fw_id);
+	else
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_SRC_MAC_ID,
+			       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
+
+	if (act->dst_mac)
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_DST_MAC_ID,
+			       act->dst_mac->fw_id);
+	else
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_DST_MAC_ID,
+			       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
+
 	if (act->count && !WARN_ON(!act->count->cnt))
 		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_COUNTER_ID,
 			       act->count->cnt->fw_id);
diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
index e88e80574f15..8df30bc4f3ba 100644
--- a/drivers/net/ethernet/sfc/mae.h
+++ b/drivers/net/ethernet/sfc/mae.h
@@ -103,6 +103,10 @@ int efx_mae_update_encap_md(struct efx_nic *efx,
 int efx_mae_free_encap_md(struct efx_nic *efx,
 			  struct efx_tc_encap_action *encap);
 
+int efx_mae_allocate_pedit_mac(struct efx_nic *efx,
+			       struct efx_tc_mac_pedit_action *ped);
+void efx_mae_free_pedit_mac(struct efx_nic *efx,
+			    struct efx_tc_mac_pedit_action *ped);
 int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act);
 int efx_mae_free_action_set(struct efx_nic *efx, u32 fw_id);
 
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 039180c61c83..8a9fc2f47514 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -86,6 +86,12 @@ s64 efx_tc_flower_external_mport(struct efx_nic *efx, struct efx_rep *efv)
 	return mport;
 }
 
+static const struct rhashtable_params efx_tc_mac_ht_params = {
+	.key_len	= offsetofend(struct efx_tc_mac_pedit_action, h_addr),
+	.key_offset	= 0,
+	.head_offset	= offsetof(struct efx_tc_mac_pedit_action, linkage),
+};
+
 static const struct rhashtable_params efx_tc_encap_match_ht_params = {
 	.key_len	= offsetof(struct efx_tc_encap_match, linkage),
 	.key_offset	= 0,
@@ -110,6 +116,56 @@ static const struct rhashtable_params efx_tc_recirc_ht_params = {
 	.head_offset	= offsetof(struct efx_tc_recirc_id, linkage),
 };
 
+static struct efx_tc_mac_pedit_action __maybe_unused *efx_tc_flower_get_mac(struct efx_nic *efx,
+							     unsigned char h_addr[ETH_ALEN],
+							     struct netlink_ext_ack *extack)
+{
+	struct efx_tc_mac_pedit_action *ped, *old;
+	int rc;
+
+	ped = kzalloc(sizeof(*ped), GFP_USER);
+	if (!ped)
+		return ERR_PTR(-ENOMEM);
+	memcpy(ped->h_addr, h_addr, ETH_ALEN);
+	old = rhashtable_lookup_get_insert_fast(&efx->tc->mac_ht,
+						&ped->linkage,
+						efx_tc_mac_ht_params);
+	if (old) {
+		/* don't need our new entry */
+		kfree(ped);
+		if (!refcount_inc_not_zero(&old->ref))
+			return ERR_PTR(-EAGAIN);
+		/* existing entry found, ref taken */
+		return old;
+	}
+
+	rc = efx_mae_allocate_pedit_mac(efx, ped);
+	if (rc < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to store pedit MAC address in hw");
+		goto out_remove;
+	}
+
+	/* ref and return */
+	refcount_set(&ped->ref, 1);
+	return ped;
+out_remove:
+	rhashtable_remove_fast(&efx->tc->mac_ht, &ped->linkage,
+			       efx_tc_mac_ht_params);
+	kfree(ped);
+	return ERR_PTR(rc);
+}
+
+static void __maybe_unused efx_tc_flower_put_mac(struct efx_nic *efx,
+				  struct efx_tc_mac_pedit_action *ped)
+{
+	if (!refcount_dec_and_test(&ped->ref))
+		return; /* still in use */
+	rhashtable_remove_fast(&efx->tc->mac_ht, &ped->linkage,
+			       efx_tc_mac_ht_params);
+	efx_mae_free_pedit_mac(efx, ped);
+	kfree(ped);
+}
+
 static void efx_tc_free_action_set(struct efx_nic *efx,
 				   struct efx_tc_action_set *act, bool in_hw)
 {
@@ -2156,6 +2212,14 @@ static void efx_tc_lhs_free(void *ptr, void *arg)
 	kfree(rule);
 }
 
+static void efx_tc_mac_free(void *ptr, void *__unused)
+{
+	struct efx_tc_mac_pedit_action *ped = ptr;
+
+	WARN_ON(refcount_read(&ped->ref));
+	kfree(ped);
+}
+
 static void efx_tc_flow_free(void *ptr, void *arg)
 {
 	struct efx_tc_flow_rule *rule = ptr;
@@ -2196,6 +2260,9 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	rc = efx_tc_init_counters(efx);
 	if (rc < 0)
 		goto fail_counters;
+	rc = rhashtable_init(&efx->tc->mac_ht, &efx_tc_mac_ht_params);
+	if (rc < 0)
+		goto fail_mac_ht;
 	rc = rhashtable_init(&efx->tc->encap_match_ht, &efx_tc_encap_match_ht_params);
 	if (rc < 0)
 		goto fail_encap_match_ht;
@@ -2233,6 +2300,8 @@ int efx_init_struct_tc(struct efx_nic *efx)
 fail_match_action_ht:
 	rhashtable_destroy(&efx->tc->encap_match_ht);
 fail_encap_match_ht:
+	rhashtable_destroy(&efx->tc->mac_ht);
+fail_mac_ht:
 	efx_tc_destroy_counters(efx);
 fail_counters:
 	efx_tc_destroy_encap_actions(efx);
@@ -2268,6 +2337,7 @@ void efx_fini_struct_tc(struct efx_nic *efx)
 	rhashtable_free_and_destroy(&efx->tc->recirc_ht, efx_tc_recirc_free, efx);
 	WARN_ON(!ida_is_empty(&efx->tc->recirc_ida));
 	ida_destroy(&efx->tc->recirc_ida);
+	rhashtable_free_and_destroy(&efx->tc->mac_ht, efx_tc_mac_free, NULL);
 	efx_tc_fini_counters(efx);
 	efx_tc_fini_encap_actions(efx);
 	mutex_unlock(&efx->tc->mutex);
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 40d2c803fca8..7b6a6a3d8e4c 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -18,6 +18,23 @@
 
 #define IS_ALL_ONES(v)	(!(typeof (v))~(v))
 
+/**
+ * struct efx_tc_mac_pedit_action - mac pedit action fields
+ *
+ * @h_addr:	mac address field of ethernet header
+ * @linkage:	rhashtable reference
+ * @ref:	reference count
+ * @fw_id:	index of this entry in firmware MAC address table
+ *
+ * MAC address edits are indirected through a table in the hardware
+ */
+struct efx_tc_mac_pedit_action {
+	u8 h_addr[ETH_ALEN];
+	struct rhash_head linkage;
+	refcount_t ref;
+	u32 fw_id; /* index of this entry in firmware MAC address table */
+};
+
 static inline bool efx_ipv6_addr_all_ones(struct in6_addr *addr)
 {
 	return !memchr_inv(addr, 0xff, sizeof(*addr));
@@ -25,20 +42,43 @@ static inline bool efx_ipv6_addr_all_ones(struct in6_addr *addr)
 
 struct efx_tc_encap_action; /* see tc_encap_actions.h */
 
+/**
+ * struct efx_tc_action_set - collection of tc action fields
+ *
+ * @vlan_push: the number of vlan headers to push
+ * @vlan_pop: the number of vlan headers to pop
+ * @decap: used to indicate a tunnel header decapsulation should take place
+ * @deliver: used to indicate a deliver action should take place
+ * @vlan_tci: tci fields for vlan push actions
+ * @vlan_proto: ethernet types for vlan push actions
+ * @count: counter mapping
+ * @encap_md: encap entry in tc_encap_ht table
+ * @encap_user: linked list of encap users (encap_md->users)
+ * @user: owning action-set-list. Only populated if @encap_md is; used by efx_tc_update_encap() fallback handling
+ * @count_user: linked list of counter users (counter->users)
+ * @dest_mport: destination mport
+ * @src_mac: source mac entry in tc_mac_ht table
+ * @dst_mac: destination mac entry in tc_mac_ht table
+ * @fw_id: index of this entry in firmware actions table
+ * @list: linked list of tc actions
+ *
+ */
 struct efx_tc_action_set {
 	u16 vlan_push:2;
 	u16 vlan_pop:2;
 	u16 decap:1;
 	u16 deliver:1;
-	__be16 vlan_tci[2]; /* TCIs for vlan_push */
-	__be16 vlan_proto[2]; /* Ethertypes for vlan_push */
+	__be16 vlan_tci[2];
+	__be16 vlan_proto[2];
 	struct efx_tc_counter_index *count;
-	struct efx_tc_encap_action *encap_md; /* entry in tc_encap_ht table */
-	struct list_head encap_user; /* entry on encap_md->users list */
-	struct efx_tc_action_set_list *user; /* Only populated if encap_md */
-	struct list_head count_user; /* entry on counter->users list, if encap */
+	struct efx_tc_encap_action *encap_md;
+	struct list_head encap_user;
+	struct efx_tc_action_set_list *user;
+	struct list_head count_user;
 	u32 dest_mport;
-	u32 fw_id; /* index of this entry in firmware actions table */
+	struct efx_tc_mac_pedit_action *src_mac;
+	struct efx_tc_mac_pedit_action *dst_mac;
+	u32 fw_id;
 	struct list_head list;
 };
 
@@ -220,6 +260,7 @@ struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
  * @counter_ht: Hashtable of TC counters (FW IDs and counter values)
  * @counter_id_ht: Hashtable mapping TC counter cookies to counters
  * @encap_ht: Hashtable of TC encap actions
+ * @mac_ht: Hashtable of MAC address entries (for pedits)
  * @encap_match_ht: Hashtable of TC encap matches
  * @match_action_ht: Hashtable of TC match-action rules
  * @lhs_rule_ht: Hashtable of TC left-hand (act ct & goto chain) rules
@@ -257,6 +298,7 @@ struct efx_tc_state {
 	struct rhashtable counter_ht;
 	struct rhashtable counter_id_ht;
 	struct rhashtable encap_ht;
+	struct rhashtable mac_ht;
 	struct rhashtable encap_match_ht;
 	struct rhashtable match_action_ht;
 	struct rhashtable lhs_rule_ht;
-- 
2.17.1


