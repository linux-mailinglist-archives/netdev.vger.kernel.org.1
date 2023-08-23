Return-Path: <netdev+bounces-29976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4307856A8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F001C20C74
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E59BE5E;
	Wed, 23 Aug 2023 11:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381DBE52
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:17:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D109E60
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3Wu0czs26HBQvHKBPyZPBFXj8w+MWCMQQFsiVgM0jHMA30o3Mtga8jRCdD6ZD//PMwIHG5YA5H9Jerne8CS1KiCTdpViiTiFr/8OsBrvxSzdn5XQDd8O44l0e8LyiEMcNIr5m71gwHtFfjiWRfkr3vPlTmVWYHSP45MfZUNfaq2gzm+7KSv1Zw5cpiAwyipTNv/nRc5Q+uMUqZHwJcgb2V3d0Wj8l/xVO66qJp4mOLgXwoPqCqsFKavKIbN/3623kYRERZ3LSHrkZtlrdfTA2dShJknFz6gd/ZwW/Iq5ROf0eLndgckidHry1HgL5W/bjBPhPpav8004ijEzXXh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngql0KQ02xmcQOzcaS8hACt8J1ca4Zu5V3Z6EiKl7zU=;
 b=bzkgMCNucGO+tshiD5j2OtXam8iuClVeR467MnqtQZgjtYH7tnx5KMAmDGlic8nK9kbC/2qRNHefrz5tjPqJDtmx8GdLwpfXEzPzJyoCMIPajwHeoHXQSWsUtMzV3Ww+qIpKHj2U1gXU8z/UYR9eRaR2Kd6E9RFEpkLeCq2qBr8VL8d/swg3o5zU8x7UrxW+ZsD6l6Z2f6+M8B8ChgMwc1aH9kVX0j0Dqsx1FAF7mwkcWGWgGFXWCEUmjr7IzaRNgJoUPpwvK+L51HjL2cx9/L1PMMZ9DsIUDPK8ClKNXUe3ZvHtz9mlL4DWoXho2bItiQXZx3vu1rujgA56PXryug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngql0KQ02xmcQOzcaS8hACt8J1ca4Zu5V3Z6EiKl7zU=;
 b=WlN8XLyCDS7h/E150IABuO3NaWODKq43949sgydL0oqEfD3/xZucocWwKrtuzMNHZe4+ftafKl6ay86CZ9+OzA3L7basx3ljOCepgvr2xJcvUSWzKu3xe4rntWNxLo0B7DBfgdnT/dkO5BZPMXe3F1m7abQTUujdo6qUUbakqLw=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 11:17:43 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::87) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 11:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 11:17:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 06:17:37 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 06:17:36 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 3/6] sfc: add decrement ttl by offloading set ipv4 ttl actions
Date: Wed, 23 Aug 2023 12:17:22 +0100
Message-ID: <20230823111725.28090-4-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
References: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f650be-769a-4b50-aeba-08dba3ca9219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2s/3+o1gRGHthCNm01Km2Hy8xu/x9F49rOO6mbHDcDvnslMt5QMli4mRp82uUERHhqbocJMY/os2QteqwDVGOimM9aPrNIuaSySVhfrdrxHzKufZioQxkXvpX/Lduwdy8VvQmCeWG78Wkl5SDDQgOL0n4sSuR/MY+S/p5Q0hokkB9bWxS6k19KqqhKn9/LoKMo6hIpgGInAi58j5Wxq5HaBEqlPXOXw7nr99stbGxHzhofAAt7ITkZ1dYLReT7bxqcKfVmULyf9SG91symrb711EVxqcyT8Yo8fQ7uoAycy7JokBJAuph/caCJyPap6bTv1vzNofoVq2pmp9AeC1W+fdfqJ91XnBhk0RvWMe5jP+6NpQliNiZ/2gx/0GJEyHyVqfo7Tww4UMKp21GYUn7Lq263zsulYCwLz17sBT3SXU3P62wE35DvRhXAg+zFut/2XCBD5OTkBBIGnozGF/y43oCmnCTXxmttp4h8rrQPH+lsH0AE+YOnkZTgD2hSqMNK+dKhGTajYypB7d5X0zHzhrt2+gk+SFRCFxfgcfUcrpwCgNkRkJYgjp9N3vuiZB0KJHSJDzZE2kp9u1cvtObDGVbgyIM2hhzY85NfAgUCrRq/syuWpGKhVaVtEIvnwHLwuCuFcJ/KsySEXxFczeMi+idJuOGX4DSMjs8k998AYkW3x6vUnYMdrWVGBLzcqDRQcs9R31gsrBhAAUud6OctOGfkZhaQ320liSdHsuok5+AGzpyCo2XnAWHBHWbKR+PiZGD3r0F1LmI0JtxOrpQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(6666004)(40460700003)(83380400001)(426003)(336012)(82740400003)(356005)(81166007)(86362001)(36860700001)(36756003)(47076005)(26005)(40480700001)(2616005)(2906002)(316002)(70206006)(70586007)(54906003)(6636002)(41300700001)(110136005)(5660300002)(1076003)(4326008)(8676002)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:17:43.1372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f650be-769a-4b50-aeba-08dba3ca9219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Offload pedit set ipv4 ttl field, where the ttl field has already been
matched and the new value is one less, by translating it to a decrement.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/mae.c |  6 ++-
 drivers/net/ethernet/sfc/tc.c  | 74 +++++++++++++++++++++++++++++++++-
 drivers/net/ethernet/sfc/tc.h  |  2 +
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index a7ad7ab8c5f4..c3e2b4a21d10 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1291,10 +1291,12 @@ int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act)
 	size_t outlen;
 	int rc;
 
-	MCDI_POPULATE_DWORD_3(inbuf, MAE_ACTION_SET_ALLOC_IN_FLAGS,
+	MCDI_POPULATE_DWORD_4(inbuf, MAE_ACTION_SET_ALLOC_IN_FLAGS,
 			      MAE_ACTION_SET_ALLOC_IN_VLAN_PUSH, act->vlan_push,
 			      MAE_ACTION_SET_ALLOC_IN_VLAN_POP, act->vlan_pop,
-			      MAE_ACTION_SET_ALLOC_IN_DECAP, act->decap);
+			      MAE_ACTION_SET_ALLOC_IN_DECAP, act->decap,
+			      MAE_ACTION_SET_ALLOC_IN_DO_DECR_IP_TTL,
+			      act->do_ttl_dec);
 
 	if (act->src_mac)
 		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_SRC_MAC_ID,
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 47bf59529a46..03205789dd6a 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -31,6 +31,7 @@ enum efx_encap_type efx_tc_indr_netdev_type(struct net_device *net_dev)
 	return EFX_ENCAP_TYPE_NONE;
 }
 
+#define EFX_TC_HDR_TYPE_TTL_MASK ((u32)0xff)
 #define EFX_EFV_PF	NULL
 /* Look up the representor information (efv) for a device.
  * May return NULL for the PF (us), or an error pointer for a device that
@@ -757,6 +758,7 @@ static const char *efx_tc_encap_type_name(enum efx_encap_type typ)
 /* For details of action order constraints refer to SF-123102-TC-1§12.6.1 */
 enum efx_tc_action_order {
 	EFX_TC_AO_DECAP,
+	EFX_TC_AO_DEC_TTL,
 	EFX_TC_AO_PEDIT_MAC_ADDRS,
 	EFX_TC_AO_VLAN_POP,
 	EFX_TC_AO_VLAN_PUSH,
@@ -777,6 +779,10 @@ static bool efx_tc_flower_action_order_ok(const struct efx_tc_action_set *act,
 		 */
 		if (act->dst_mac || act->src_mac)
 			return false;
+
+		/* Decrementing ttl must not happen before DECAP */
+		if (act->do_ttl_dec)
+			return false;
 		fallthrough;
 	case EFX_TC_AO_VLAN_POP:
 		if (act->vlan_pop >= 2)
@@ -803,6 +809,10 @@ static bool efx_tc_flower_action_order_ok(const struct efx_tc_action_set *act,
 		fallthrough;
 	case EFX_TC_AO_DELIVER:
 		return !act->deliver;
+	case EFX_TC_AO_DEC_TTL:
+		if (act->encap_md)
+			return false;
+		return !act->do_ttl_dec;
 	default:
 		/* Bad caller.  Whatever they wanted to do, say they can't. */
 		WARN_ON_ONCE(1);
@@ -1059,10 +1069,12 @@ static int efx_tc_complete_mac_mangle(struct efx_nic *efx,
 static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			 const struct flow_action_entry *fa,
 			 struct efx_tc_mangler_state *mung,
-			 struct netlink_ext_ack *extack)
+			 struct netlink_ext_ack *extack,
+			 struct efx_tc_match *match)
 {
 	__le32 mac32;
 	__le16 mac16;
+	u8 tr_ttl;
 
 	switch (fa->mangle.htype) {
 	case FLOW_ACT_MANGLE_HDR_TYPE_ETH:
@@ -1119,6 +1131,64 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			return -EOPNOTSUPP;
 		}
 		break;
+	case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
+		switch (fa->mangle.offset) {
+		case offsetof(struct iphdr, ttl):
+			/* we currently only support pedit IP4 when it applies
+			 * to TTL and then only when it can be achieved with a
+			 * decrement ttl action
+			 */
+
+			/* check that pedit applies to ttl only */
+			if (fa->mangle.mask != ~EFX_TC_HDR_TYPE_TTL_MASK) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Unsupported: mask (%#x) out of range, only support mangle action on ipv4.ttl",
+						       fa->mangle.mask);
+				return -EOPNOTSUPP;
+			}
+
+			/* we can only convert to a dec ttl when we have an
+			 * exact match on the ttl field
+			 */
+			if (match->mask.ip_ttl != U8_MAX) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Unsupported: only support mangle ipv4.ttl when we have an exact match on ttl, mask used for match (%#x)",
+						       match->mask.ip_ttl);
+				return -EOPNOTSUPP;
+			}
+
+			/* check that we don't try to decrement 0, which equates
+			 * to setting the ttl to 0xff
+			 */
+			if (match->value.ip_ttl == 0) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported: we cannot decrement ttl past 0");
+				return -EOPNOTSUPP;
+			}
+
+			/* check that we do not decrement ttl twice */
+			if (!efx_tc_flower_action_order_ok(act,
+							   EFX_TC_AO_DEC_TTL)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported: multiple dec ttl");
+				return -EOPNOTSUPP;
+			}
+
+			/* check pedit can be achieved with decrement action */
+			tr_ttl = match->value.ip_ttl - 1;
+			if ((fa->mangle.val & EFX_TC_HDR_TYPE_TTL_MASK) == tr_ttl) {
+				act->do_ttl_dec = 1;
+				return 0;
+			}
+
+			fallthrough;
+		default:
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Unsupported: only support mangle on the ttl field (offset is %u)",
+					       fa->mangle.offset);
+			return -EOPNOTSUPP;
+		}
+		break;
 	default:
 		NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled mangle htype %u for action rule",
 				       fa->mangle.htype);
@@ -1885,7 +1955,7 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 			act->vlan_push++;
 			break;
 		case FLOW_ACTION_MANGLE:
-			rc = efx_tc_mangle(efx, act, fa, &mung, extack);
+			rc = efx_tc_mangle(efx, act, fa, &mung, extack, &match);
 			if (rc < 0)
 				goto release;
 			break;
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 91705411e5c5..d50f45b444a9 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -48,6 +48,7 @@ struct efx_tc_encap_action; /* see tc_encap_actions.h */
  * @vlan_push: the number of vlan headers to push
  * @vlan_pop: the number of vlan headers to pop
  * @decap: used to indicate a tunnel header decapsulation should take place
+ * @do_ttl_dec: used to indicate IP TTL / Hop Limit should be decremented
  * @deliver: used to indicate a deliver action should take place
  * @vlan_tci: tci fields for vlan push actions
  * @vlan_proto: ethernet types for vlan push actions
@@ -67,6 +68,7 @@ struct efx_tc_action_set {
 	u16 vlan_push:2;
 	u16 vlan_pop:2;
 	u16 decap:1;
+	u16 do_ttl_dec:1;
 	u16 deliver:1;
 	__be16 vlan_tci[2];
 	__be16 vlan_proto[2];
-- 
2.17.1


