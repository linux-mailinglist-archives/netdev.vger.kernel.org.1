Return-Path: <netdev+bounces-35051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6187A6ACD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6052817CF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83081863B;
	Tue, 19 Sep 2023 18:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474AA4E
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 18:41:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45709D
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYYfiBEJdVaZBRSRrb3fIvnHte3bsHzdTYvvahfaSIimIGURi19hD8ljxn1LfuBm7R/2++rS+VZZHBvGJIUP9DuoBii4peNNjStBRp16zTLZqi3Fef3LF0iukjsVriW682gbTUhgbitjYSnmeuxW1o9uguh34Y1lB91TzvhLVA8sO2sE3RnfRdLoIwgD1pFt8nzIOSdjshQbXqI+nbnXL1jjdPue+aZlIeJvEuBG1aYLwThdVr87N9mTcpL/QU408P1qTBlF6lQtgMA+jY9zEph9A0bhsjOPdEdyOLbGKNr1PloYiVgcv8c/RrJ9GfjhHGShaLHj26dDtorA8liNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06Hm8LbadHEk1x3AMWzrR1SiqlmQygfmxsXCBn1rz00=;
 b=nwnu20YXDK0k1GR6Wxa2qoeqY41MIUn5Gy7BXqNCDZqmj50r6pNl0V4TnVIJT8kB0AGRZBBiKoY3pda3vr3bhG9UqUCmxbztPTIB+MneiUt0sSWrsG9Pg7pCIjch+Bpw8eQajokerLQ7DaCYx/PUuRs9S1us20ZuhH2Z+qymjB0jVSgpOxVy6ElqwLH91gNJUpYJmsvpnV7i4O9Qv9NZitQ20T6XuBFd8LqNPdeekKnV0uWqU2XPoDaQQbpAYcnva7tiApqJy1+/anY0sWJ91mUCJIBuhJFW8M9pisvqeL53sIV7zW7EHNVBjQcHAKgIlJZr7+8SNRj6wanf3xJJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Hm8LbadHEk1x3AMWzrR1SiqlmQygfmxsXCBn1rz00=;
 b=Jww6hHJtiM+FQOwpHtx31uK+zuHzpXOSvUyPKbTeFsLvMcG9tm36wArAEggKFw+El1+iXX7APuxRvFb6JwGSZnLZHWCrcyiTV0zXSfxSPh8B3/38IBSKoRTvUWcnBy0OkW5slUwNsdEylUhbb/KPymaZA5g1eMw+hmQOltDX9iQ=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 18:41:33 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:b8:cafe::3b) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 18:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 18:41:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 13:41:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 13:41:31 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 13:41:30 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <dan.carpenter@linaro.org>
Subject: [PATCH net] sfc: handle error pointers returned by rhashtable_lookup_get_insert_fast()
Date: Tue, 19 Sep 2023 19:39:49 +0100
Message-ID: <20230919183949.59392-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|MN2PR12MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0638cb-2f7a-4be3-97af-08dbb9400b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qXREuysAtiXH3bk5d/y93yuM5EDoiepkZVRSyvdoO+tp/tRUf6DXnY9bsgPM+hWvzKCZDF5eASOSzDAG1SeMsJ1Owt8zwzOwUXzDMHAjzrCK3t+oyWUhn9+AC6KC3KdZLxLRjsabZ8m5YlRi1spE/Y1T5ZXGCMyRC8ulIdfcgzQbzF31KJYYq3XakVXQyKzsrVqx61LbmuFhjdr7Jfzg2G40onIARebkMBXkmkWvTNzzJGae4DjA5OnwM4wTo1IMxvbfMvotT+0m1CkPIr4U/o836doVyGTfc035/GM8yga3h/kpo55jlrMfot1gS4UjvKz5y8uP+iXeEVLVybb+wTJYGdiJy4Fhx34IPYYZUcIsdFFe3R/u9UPiqwjYttISuk5IMTY2KczCVI3z4VQI+9dtrFtoTJy4FwX/KS7btPN1UOptWCBU1AqG55cfY4beL1A7ZImFKL2P8ytcGTKyFQMbORa3E2N9KjUXpj366tLfoxo1OtYW8fSo3rIuDjIdV1M7VyDAjyX/JkC9GlFvffkn9nOl45v1Ap3Rr+wmwCXtP7uXHa7xlbFOwQfRk1HENbdm99OeGF7SK9wrWf8DSs99yodKUDEpd6QJMLdHaXkLZBWzxNoYECxb7gRJawyRTfopb9vdD27lJvclE+5VUXa1X48Sf6ai14mtGXVGJlUWHHAgNPGkHJGkvFxE3FA9z7oiyFrpk6aCTsTngIAuXCmMLvqTEKXWl+uFgsnwC24VfHyIBBQv5JnrWQsMYMHiAyJsHaN6izJ/jV3zLS4OrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(70586007)(316002)(54906003)(41300700001)(110136005)(70206006)(2616005)(82740400003)(36860700001)(86362001)(5660300002)(1076003)(4326008)(8676002)(8936002)(478600001)(26005)(426003)(83380400001)(36756003)(40460700003)(336012)(81166007)(356005)(2906002)(2876002)(47076005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 18:41:32.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0638cb-2f7a-4be3-97af-08dbb9400b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Several places in TC offload code assumed that the return from
 rhashtable_lookup_get_insert_fast() was always either NULL or a valid
 pointer to an existing entry, but in fact that function can return an
 error pointer.  In that case, perform the usual cleanup of the newly
 created entry, then pass up the error, rather than attempting to take a
 reference on the old entry.

Fixes: d902e1a737d4 ("sfc: bare bones TC offload on EF100")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c               | 21 ++++++++++++++++++---
 drivers/net/ethernet/sfc/tc_conntrack.c     |  7 ++++++-
 drivers/net/ethernet/sfc/tc_counters.c      |  2 ++
 drivers/net/ethernet/sfc/tc_encap_actions.c |  4 ++++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 047322b04d4f..834f000ba1c4 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -136,6 +136,8 @@ static struct efx_tc_mac_pedit_action *efx_tc_flower_get_mac(struct efx_nic *efx
 	if (old) {
 		/* don't need our new entry */
 		kfree(ped);
+		if (IS_ERR(old)) /* oh dear, it's actually an error */
+			return ERR_CAST(old);
 		if (!refcount_inc_not_zero(&old->ref))
 			return ERR_PTR(-EAGAIN);
 		/* existing entry found, ref taken */
@@ -602,6 +604,8 @@ static int efx_tc_flower_record_encap_match(struct efx_nic *efx,
 		kfree(encap);
 		if (pseudo) /* don't need our new pseudo either */
 			efx_tc_flower_release_encap_match(efx, pseudo);
+		if (IS_ERR(old)) /* oh dear, it's actually an error */
+			return PTR_ERR(old);
 		/* check old and new em_types are compatible */
 		switch (old->type) {
 		case EFX_TC_EM_DIRECT:
@@ -700,6 +704,8 @@ static struct efx_tc_recirc_id *efx_tc_get_recirc_id(struct efx_nic *efx,
 	if (old) {
 		/* don't need our new entry */
 		kfree(rid);
+		if (IS_ERR(old)) /* oh dear, it's actually an error */
+			return ERR_CAST(old);
 		if (!refcount_inc_not_zero(&old->ref))
 			return ERR_PTR(-EAGAIN);
 		/* existing entry found */
@@ -1482,7 +1488,10 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	old = rhashtable_lookup_get_insert_fast(&efx->tc->match_action_ht,
 						&rule->linkage,
 						efx_tc_match_action_ht_params);
-	if (old) {
+	if (IS_ERR(old)) {
+		rc = PTR_ERR(old);
+		goto release;
+	} else if (old) {
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Ignoring already-offloaded rule (cookie %lx)\n",
 			  tc->cookie);
@@ -1697,7 +1706,10 @@ static int efx_tc_flower_replace_lhs(struct efx_nic *efx,
 	old = rhashtable_lookup_get_insert_fast(&efx->tc->lhs_rule_ht,
 						&rule->linkage,
 						efx_tc_lhs_rule_ht_params);
-	if (old) {
+	if (IS_ERR(old)) {
+		rc = PTR_ERR(old);
+		goto release;
+	} else if (old) {
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
 		rc = -EEXIST;
@@ -1858,7 +1870,10 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 	old = rhashtable_lookup_get_insert_fast(&efx->tc->match_action_ht,
 						&rule->linkage,
 						efx_tc_match_action_ht_params);
-	if (old) {
+	if (IS_ERR(old)) {
+		rc = PTR_ERR(old);
+		goto release;
+	} else if (old) {
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
 		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
index 8e06bfbcbea1..44bb57670340 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.c
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -298,7 +298,10 @@ static int efx_tc_ct_replace(struct efx_tc_ct_zone *ct_zone,
 	old = rhashtable_lookup_get_insert_fast(&efx->tc->ct_ht,
 						&conn->linkage,
 						efx_tc_ct_ht_params);
-	if (old) {
+	if (IS_ERR(old)) {
+		rc = PTR_ERR(old);
+		goto release;
+	} else if (old) {
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Already offloaded conntrack (cookie %lx)\n", tc->cookie);
 		rc = -EEXIST;
@@ -482,6 +485,8 @@ struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
 	if (old) {
 		/* don't need our new entry */
 		kfree(ct_zone);
+		if (IS_ERR(old)) /* oh dear, it's actually an error */
+			return ERR_CAST(old);
 		if (!refcount_inc_not_zero(&old->ref))
 			return ERR_PTR(-EAGAIN);
 		/* existing entry found */
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index 0fafb47ea082..c44088424323 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -236,6 +236,8 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
 	if (old) {
 		/* don't need our new entry */
 		kfree(ctr);
+		if (IS_ERR(old)) /* oh dear, it's actually an error */
+			return ERR_CAST(old);
 		if (!refcount_inc_not_zero(&old->ref))
 			return ERR_PTR(-EAGAIN);
 		/* existing entry found */
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index 7e8bcdb222ad..87443f9dfd22 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -132,6 +132,8 @@ static int efx_bind_neigh(struct efx_nic *efx,
 		/* don't need our new entry */
 		put_net_track(neigh->net, &neigh->ns_tracker);
 		kfree(neigh);
+		if (IS_ERR(old)) /* oh dear, it's actually an error */
+			return PTR_ERR(old);
 		if (!refcount_inc_not_zero(&old->ref))
 			return -EAGAIN;
 		/* existing entry found, ref taken */
@@ -640,6 +642,8 @@ struct efx_tc_encap_action *efx_tc_flower_create_encap_md(
 	if (old) {
 		/* don't need our new entry */
 		kfree(encap);
+		if (IS_ERR(old)) /* oh dear, it's actually an error */
+			return ERR_CAST(old);
 		if (!refcount_inc_not_zero(&old->ref))
 			return ERR_PTR(-EAGAIN);
 		/* existing entry found, ref taken */

