Return-Path: <netdev+bounces-30319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898AC786DD5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4C61C2030D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE132DF68;
	Thu, 24 Aug 2023 11:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C3100AD
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:29:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6DE59
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3mdneGfHnpWwF3rRBFHLImPb+h0D+XY5a93j9YoBOhZ+CQfm0WZKp62QNjTNh+WG6Hh+zdp6U7s9Bwy5Cis5bA2/58J1R+9JO6Vp26By2XsmelvwJvaC6/Q130FDAY9TsNtMQLnhDPkeEDpWDaMMTvdCfsnMtPnK3niF7sxbFStvALFKQkgycEWOsvF8LZKJx/BrCc6YZzk5ZeYbslgniyC6bEoAB/hZc7gi3epzOgvm5ECBFeGGYx3ag0e08ERymacF11vd/QgzPLj3MLMO1nHh7p1mrL5bLFMYhcjj/iSQwq36hb8g2ZKXBfPLGie+ZQ3UQTe2+kPDZ/1lzQs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S86LvVyYkLKw6o3mbwAcJgsdfyXmTBAUaZRi/42iVIc=;
 b=N8xf5kQCGr0jLjqrL4DoaaDH484L0i3zUSmR83o4wXDJjtb5O0ppWGUjoiTstqqbSsuIZfnor1fMbJzieM8sgZKZISo9BYkrjE5qRbZCyn3NIttDI6h09uHfyBCaDz4lpe19MIOCNif2AhtFrdwabnfbWioRhr74VKSEp+9ApiNKfaweJ18md6u/ttvIOf3nuHykU+onvzKhybjAysGUqFN+8ucOS8F8N15DGyohqJVASbU8BHdGk3x+UyWfoikyY7WoMk8c0FJRz+6XQ2kcT7njl4az1QHugms42eaX73wpV3iZ2xnamjdYm+NOW0VG7LRLdF8buj9TOXvLn5if6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S86LvVyYkLKw6o3mbwAcJgsdfyXmTBAUaZRi/42iVIc=;
 b=0vS5GCzHVhnd5d04ej7uQDdkZCSzjnv3bUYloYUSxJjgeCf9VwLg5Ki2+vIzzVYeRK7vNLgLMEx4nXQDWvoqJRnxDraEQVglehirqK8hi//nq1nn39s2Uujc3c43WBwNYeqeRGTvoVQPqlEf5yu3Pz98lYTTERU2vWxDjYkT2HY=
Received: from BYAPR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:c0::48)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:28:58 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::1a) by BYAPR05CA0035.outlook.office365.com
 (2603:10b6:a03:c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.16 via Frontend
 Transport; Thu, 24 Aug 2023 11:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:28:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:28:54 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:28:53 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next v2 2/6] sfc: add mac source and destination pedit action offload
Date: Thu, 24 Aug 2023 12:28:38 +0100
Message-ID: <20230824112842.47883-3-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
References: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: effd56a4-c215-47c4-946f-08dba4954ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	akl3CYGT7V/gOF7kNHzflojo7y/X1hnN/HYPie1XKlPlXmvc09rceVHtEoyAQDo6oI1H0R/aldrmt4mu/HWI/Hq2CfOW/+xEOAaIQI0UKh5ZzC6IGjiZguDxg83ZAAlIQkwwJxGtNMUTG9upLO4q6KyI64gGkWPFvb8QHzwxTIDJJLCurC3yEn8kHtZmBVUnHBz9ARspIakna7hJSQ0ygkkxxUPBjcBSzFL14rybumBvg6jkeVlwtf4sSM7CibeK0YgMyPAz4KmRS5pjubcHh9pt9ive9AODJuLpuAFb5AZ8SfkviMGdlt7DGjVQxGN2+22P2aEBdmpqks4u7fnRuwedfENDS2swg+gtExr5ofSJuiaiZddT0P0IO4v8GFUXElZcMX4SpvlWDS8a5Mayo3ra2QwekP19BbHIOvc5Nb1Gh4zVwvOBZ2uUSuVLs756iB6pnViNLNVx9BhZ+PpQEX+IxYQtaM/wY+NbhWF4mQ+zBszz20ScupJ2eDga4BjvmNiuQEjKq8lvZdlMcAZ2rV8JK9BqNrqCNtrsnSc3n9gKnyzL6oLG1RqFX96c6c0Y8ER9G+X1TTM9b4El4LqscKYOR8cFGQwwzEbR6xOTs7zj7mc6WidlEgfUZibhO4Jg7UwI4Ttzf5TApGa1219Y1lmmGN7gAL+hDG38ygfM3Uuc9t1lwmX4Q38qBexwzZJChgEGD241DHZ7JWz+Ti+yAvCuiXzEO5pQGm7a1SXdSECDmvdPci6cvhxNyOKREvaB12kBWsTldchKf7G5sAhYW7uF6lBZVATmPXDl7VIN0bY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70586007)(70206006)(316002)(81166007)(478600001)(110136005)(26005)(36860700001)(356005)(6666004)(40480700001)(82740400003)(41300700001)(86362001)(2906002)(8676002)(8936002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:28:58.0566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: effd56a4-c215-47c4-946f-08dba4954ec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce the first pedit set offload functionality for the sfc driver.
In addition to this, add offload functionality for both mac source and
destination pedit set actions.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/tc.c | 209 +++++++++++++++++++++++++++++++++-
 1 file changed, 207 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 8a9fc2f47514..b9d7c4bb7e69 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -116,7 +116,7 @@ static const struct rhashtable_params efx_tc_recirc_ht_params = {
 	.head_offset	= offsetof(struct efx_tc_recirc_id, linkage),
 };
 
-static struct efx_tc_mac_pedit_action __maybe_unused *efx_tc_flower_get_mac(struct efx_nic *efx,
+static struct efx_tc_mac_pedit_action *efx_tc_flower_get_mac(struct efx_nic *efx,
 							     unsigned char h_addr[ETH_ALEN],
 							     struct netlink_ext_ack *extack)
 {
@@ -155,7 +155,7 @@ static struct efx_tc_mac_pedit_action __maybe_unused *efx_tc_flower_get_mac(stru
 	return ERR_PTR(rc);
 }
 
-static void __maybe_unused efx_tc_flower_put_mac(struct efx_nic *efx,
+static void efx_tc_flower_put_mac(struct efx_nic *efx,
 				  struct efx_tc_mac_pedit_action *ped)
 {
 	if (!refcount_dec_and_test(&ped->ref))
@@ -191,6 +191,10 @@ static void efx_tc_free_action_set(struct efx_nic *efx,
 		list_del(&act->encap_user);
 		efx_tc_flower_release_encap_md(efx, act->encap_md);
 	}
+	if (act->src_mac)
+		efx_tc_flower_put_mac(efx, act->src_mac);
+	if (act->dst_mac)
+		efx_tc_flower_put_mac(efx, act->dst_mac);
 	kfree(act);
 }
 
@@ -753,6 +757,7 @@ static const char *efx_tc_encap_type_name(enum efx_encap_type typ)
 /* For details of action order constraints refer to SF-123102-TC-1§12.6.1 */
 enum efx_tc_action_order {
 	EFX_TC_AO_DECAP,
+	EFX_TC_AO_PEDIT_MAC_ADDRS,
 	EFX_TC_AO_VLAN_POP,
 	EFX_TC_AO_VLAN_PUSH,
 	EFX_TC_AO_COUNT,
@@ -767,6 +772,11 @@ static bool efx_tc_flower_action_order_ok(const struct efx_tc_action_set *act,
 	case EFX_TC_AO_DECAP:
 		if (act->decap)
 			return false;
+		/* PEDIT_MAC_ADDRS must not happen before DECAP, though it
+		 * can wait until much later
+		 */
+		if (act->dst_mac || act->src_mac)
+			return false;
 		fallthrough;
 	case EFX_TC_AO_VLAN_POP:
 		if (act->vlan_pop >= 2)
@@ -786,6 +796,7 @@ static bool efx_tc_flower_action_order_ok(const struct efx_tc_action_set *act,
 		if (act->count)
 			return false;
 		fallthrough;
+	case EFX_TC_AO_PEDIT_MAC_ADDRS:
 	case EFX_TC_AO_ENCAP:
 		if (act->encap_md)
 			return false;
@@ -956,6 +967,191 @@ static void efx_tc_flower_release_lhs_actions(struct efx_nic *efx,
 		efx_tc_flower_put_counter_index(efx, act->count);
 }
 
+/**
+ * struct efx_tc_mangler_state - accumulates 32-bit pedits into fields
+ *
+ * @dst_mac_32:	dst_mac[0:3] has been populated
+ * @dst_mac_16:	dst_mac[4:5] has been populated
+ * @src_mac_16:	src_mac[0:1] has been populated
+ * @src_mac_32:	src_mac[2:5] has been populated
+ * @dst_mac:	h_dest field of ethhdr
+ * @src_mac:	h_source field of ethhdr
+ *
+ * Since FLOW_ACTION_MANGLE comes in 32-bit chunks that do not
+ * necessarily equate to whole fields of the packet header, this
+ * structure is used to hold the cumulative effect of the partial
+ * field pedits that have been processed so far.
+ */
+struct efx_tc_mangler_state {
+	u8 dst_mac_32:1; /* eth->h_dest[0:3] */
+	u8 dst_mac_16:1; /* eth->h_dest[4:5] */
+	u8 src_mac_16:1; /* eth->h_source[0:1] */
+	u8 src_mac_32:1; /* eth->h_source[2:5] */
+	unsigned char dst_mac[ETH_ALEN];
+	unsigned char src_mac[ETH_ALEN];
+};
+
+/** efx_tc_complete_mac_mangle() - pull complete field pedits out of @mung
+ * @efx:	NIC we're installing a flow rule on
+ * @act:	action set (cursor) to update
+ * @mung:	accumulated partial mangles
+ * @extack:	netlink extended ack for reporting errors
+ *
+ * Check @mung to find any combinations of partial mangles that can be
+ * combined into a complete packet field edit, add that edit to @act,
+ * and consume the partial mangles from @mung.
+ */
+
+static int efx_tc_complete_mac_mangle(struct efx_nic *efx,
+				      struct efx_tc_action_set *act,
+				      struct efx_tc_mangler_state *mung,
+				      struct netlink_ext_ack *extack)
+{
+	struct efx_tc_mac_pedit_action *ped;
+
+	if (mung->dst_mac_32 && mung->dst_mac_16) {
+		ped = efx_tc_flower_get_mac(efx, mung->dst_mac, extack);
+		if (IS_ERR(ped))
+			return PTR_ERR(ped);
+
+		/* Check that we have not already populated dst_mac */
+		if (act->dst_mac)
+			efx_tc_flower_put_mac(efx, act->dst_mac);
+
+		act->dst_mac = ped;
+
+		/* consume the incomplete state */
+		mung->dst_mac_32 = 0;
+		mung->dst_mac_16 = 0;
+	}
+	if (mung->src_mac_16 && mung->src_mac_32) {
+		ped = efx_tc_flower_get_mac(efx, mung->src_mac, extack);
+		if (IS_ERR(ped))
+			return PTR_ERR(ped);
+
+		/* Check that we have not already populated src_mac */
+		if (act->src_mac)
+			efx_tc_flower_put_mac(efx, act->src_mac);
+
+		act->src_mac = ped;
+
+		/* consume the incomplete state */
+		mung->src_mac_32 = 0;
+		mung->src_mac_16 = 0;
+	}
+	return 0;
+}
+
+/**
+ * efx_tc_mangle() - handle a single 32-bit (or less) pedit
+ * @efx:	NIC we're installing a flow rule on
+ * @act:	action set (cursor) to update
+ * @fa:		FLOW_ACTION_MANGLE action metadata
+ * @mung:	accumulator for partial mangles
+ * @extack:	netlink extended ack for reporting errors
+ *
+ * Identify the fields written by a FLOW_ACTION_MANGLE, and record
+ * the partial mangle state in @mung.  If this mangle completes an
+ * earlier partial mangle, consume and apply to @act by calling
+ * efx_tc_complete_mac_mangle().
+ */
+
+static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
+			 const struct flow_action_entry *fa,
+			 struct efx_tc_mangler_state *mung,
+			 struct netlink_ext_ack *extack)
+{
+	__le32 mac32;
+	__le16 mac16;
+
+	switch (fa->mangle.htype) {
+	case FLOW_ACT_MANGLE_HDR_TYPE_ETH:
+		BUILD_BUG_ON(offsetof(struct ethhdr, h_dest) != 0);
+		BUILD_BUG_ON(offsetof(struct ethhdr, h_source) != 6);
+		if (!efx_tc_flower_action_order_ok(act, EFX_TC_AO_PEDIT_MAC_ADDRS)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Pedit mangle mac action violates action order");
+			return -EOPNOTSUPP;
+		}
+		switch (fa->mangle.offset) {
+		case 0:
+			if (fa->mangle.mask) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Unsupported: mask (%#x) of eth.dst32 mangle",
+						       fa->mangle.mask);
+				return -EOPNOTSUPP;
+			}
+			/* Ethernet address is little-endian */
+			mac32 = cpu_to_le32(fa->mangle.val);
+			memcpy(mung->dst_mac, &mac32, sizeof(mac32));
+			mung->dst_mac_32 = 1;
+			return efx_tc_complete_mac_mangle(efx, act, mung, extack);
+		case 4:
+			if (fa->mangle.mask == 0xffff) {
+				mac16 = cpu_to_le16(fa->mangle.val >> 16);
+				memcpy(mung->src_mac, &mac16, sizeof(mac16));
+				mung->src_mac_16 = 1;
+			} else if (fa->mangle.mask == 0xffff0000) {
+				mac16 = cpu_to_le16((u16)fa->mangle.val);
+				memcpy(mung->dst_mac + 4, &mac16, sizeof(mac16));
+				mung->dst_mac_16 = 1;
+			} else {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Unsupported: mask (%#x) of eth+4 mangle is not high or low 16b",
+						       fa->mangle.mask);
+				return -EOPNOTSUPP;
+			}
+			return efx_tc_complete_mac_mangle(efx, act, mung, extack);
+		case 8:
+			if (fa->mangle.mask) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Unsupported: mask (%#x) of eth.src32 mangle",
+						       fa->mangle.mask);
+				return -EOPNOTSUPP;
+			}
+			mac32 = cpu_to_le32(fa->mangle.val);
+			memcpy(mung->src_mac + 2, &mac32, sizeof(mac32));
+			mung->src_mac_32 = 1;
+			return efx_tc_complete_mac_mangle(efx, act, mung, extack);
+		default:
+			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported: mangle eth+%u %x/%x",
+					       fa->mangle.offset, fa->mangle.val, fa->mangle.mask);
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled mangle htype %u for action rule",
+				       fa->mangle.htype);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+/**
+ * efx_tc_incomplete_mangle() - check for leftover partial pedits
+ * @mung:	accumulator for partial mangles
+ * @extack:	netlink extended ack for reporting errors
+ *
+ * Since the MAE can only overwrite whole fields, any partial
+ * field mangle left over on reaching packet delivery (mirred or
+ * end of TC actions) cannot be offloaded.  Check for any such
+ * and reject them with -%EOPNOTSUPP.
+ */
+
+static int efx_tc_incomplete_mangle(struct efx_tc_mangler_state *mung,
+				    struct netlink_ext_ack *extack)
+{
+	if (mung->dst_mac_32 || mung->dst_mac_16) {
+		NL_SET_ERR_MSG_MOD(extack, "Incomplete pedit of destination MAC address");
+		return -EOPNOTSUPP;
+	}
+	if (mung->src_mac_16 || mung->src_mac_32) {
+		NL_SET_ERR_MSG_MOD(extack, "Incomplete pedit of source MAC address");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 					 struct net_device *net_dev,
 					 struct flow_cls_offload *tc)
@@ -1351,6 +1547,7 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 	struct netlink_ext_ack *extack = tc->common.extack;
 	const struct ip_tunnel_info *encap_info = NULL;
 	struct efx_tc_flow_rule *rule = NULL, *old;
+	struct efx_tc_mangler_state mung = {};
 	struct efx_tc_action_set *act = NULL;
 	const struct flow_action_entry *fa;
 	struct efx_rep *from_efv, *to_efv;
@@ -1687,6 +1884,11 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 			act->vlan_proto[act->vlan_push] = fa->vlan.proto;
 			act->vlan_push++;
 			break;
+		case FLOW_ACTION_MANGLE:
+			rc = efx_tc_mangle(efx, act, fa, &mung, extack);
+			if (rc < 0)
+				goto release;
+			break;
 		case FLOW_ACTION_TUNNEL_ENCAP:
 			if (encap_info) {
 				/* Can't specify encap multiple times.
@@ -1726,6 +1928,9 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 		}
 	}
 
+	rc = efx_tc_incomplete_mangle(&mung, extack);
+	if (rc < 0)
+		goto release;
 	if (act) {
 		/* Not shot/redirected, so deliver to default dest */
 		if (from_efv == EFX_EFV_PF)
-- 
2.17.1


