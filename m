Return-Path: <netdev+bounces-30320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E5786DD6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AB11C20D78
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840D9100C0;
	Thu, 24 Aug 2023 11:29:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F443100BB
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:29:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0310FA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4RF9LYB3WO4tDBJYRJ4amoocsgy7UWueeqULSIk9Nz6r6/VbXXpLlcxnBdwSZYx3YXEg8/H2Hj2tDMg87gZIbx7QKj7Pcal26IgYyT5fm2AJt/UIVYNRg2/7RK4utXH1gGEGSYlk0CbCeRLY/t7ToxfFmMJpfCgbXa8EKQ9+V0WQpQf6BX7ArHHy33obbKVyxxGfM59Wpwc76UzJprvhqTPbQ07BouyyQ/D32a9zkNCd4KZG0utO4BbECdgGlSJpWS+e2hvjL4qXgcJRmr+YFosE05diLWteroIlSmYU0wdtVAxDK4NSkh5z1tUmeLecvW9r+CHxsosHac5LP0C3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQIs9+0qmEVqKLc/P8pm225JNiaXzWI8I4NqbiHoFFs=;
 b=mzql4ZOAtoOMsuIbCLv5eDzKaA/SJrvDKuIzk3b+DR8xs448miCATLtb8O6AAOqgayVWPv9/VQX09CJuZ5xWNp/J1Xm/rWp3398I0U55DccQt5GXMLdbNIGGW8YVSaIToyasPPvuWRBdnuRrud5bzMoYXi9wzhqYs0sHoYr7KptyD8pAWOo/LWaLnxJh25n9NhhirkPbNwAG6WjpU0WPIxdy8oc6rzfPwnSSSlM/Iv2aIawALb29iUFBh7UuYtmBtbYGzYHGq+PQsOLzf+WGDLJdHO0VNbj3FQVj6Tuc2R2LkybDZWv0ytW5SXV6zbYIIdXGtkwQJIjPKnjbZNozDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQIs9+0qmEVqKLc/P8pm225JNiaXzWI8I4NqbiHoFFs=;
 b=30OwRHz3n6O+Em/rMN6jEaRadEfVwf+n4s8P7szlSfaJCg7KrKAgnOyLSesrdJkh2WqvkLUHHhyhT4SYx4udXpyTdVyUYqDGBKwRwNJ7ZLvYnuH7cO0nD7NwoIX4BU9s2vG/0ebzpsrre/+ZRgat/TQnyKInJ1NjURpey19wY8A=
Received: from CY5PR13CA0054.namprd13.prod.outlook.com (2603:10b6:930:11::18)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:28:59 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::56) by CY5PR13CA0054.outlook.office365.com
 (2603:10b6:930:11::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Thu, 24 Aug 2023 11:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 11:28:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:28:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 04:28:56 -0700
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:28:54 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next v2 3/6] sfc: add decrement ttl by offloading set ipv4 ttl actions
Date: Thu, 24 Aug 2023 12:28:39 +0100
Message-ID: <20230824112842.47883-4-pieter.jansen-van-vuuren@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: ca163615-89ac-48b8-c4c6-08dba4954fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D2+VeMazNzE/z91EHR5x2fJC9fEWxgW1KD5TYbJ5ADdBgHgn2+qWxM6rJeE2khlV2WKKrvEGtgex9kN17AIdfQpXe5OLGN+RXcdkOo5OeyUH0FaZacKf9xQT54sIee6pNOepg0bcQpR8LxR6wSuj9Jn6KnXKiumcNHCVn2dexi41Igo3szLLRrZrdjwqG9EOP+qtfpj8iVoA+JZ1aap5f7bVsJdZQbUZJsSS11OaZpSMOv19e1KDQl12IB1NmjyBgjRYpWefFenrhE790rgh3YcIzWZkT3LDAJnfOvl8dkD42BDz2jIMnGNTjbzhJ9/8pEB1pXxGqqwwRWnm5IGpIyJa2Mj6acSpdZZuvbF3nQzW16wOC54hHD4XJ/7v1zZsHOHdUTCeQZRK79uHcTpzoh9T4wcVZKgjHOlheUibWoa+0BMtscR9seUjHk4bAgcRvM8hgV4WPADiZqp2qncUdsu7x3Oj+wlP+cYlO5PkBPFWI5O1wTYzWdqa5Z3xA9LUsFP1vb3Zd7YT3UBLrWvaJQ4DJcDPJelEAfIHIARUv7mK5FsVAVHmqPD4m0P21DR0lVaX3acdHtevmI9b3gVQspkbuQJPzswV73xkuR0I2uq3LQ5sz1NYdUY90auLDvVDQ35dt+ykLjpaMgCA+m969+K7vX17BpQHKFnBcbze0/vu1Ac3eCg+HTKNNbv1ia9iWWsxepMNUwaLsWYWzYulfMFcD+31gYavKd/xz/F+MgP7DMGivimyHV/X21+JNQZATLcvluS6uWBn0vW6acJy4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(6636002)(70206006)(70586007)(316002)(81166007)(478600001)(110136005)(26005)(36860700001)(356005)(6666004)(82740400003)(40480700001)(41300700001)(86362001)(2906002)(4326008)(8676002)(8936002)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:28:59.5662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca163615-89ac-48b8-c4c6-08dba4954fa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Offload pedit set ipv4 ttl field, where the ttl field has already been
matched and the new value is one less, by translating it to a decrement.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/mae.c |  6 ++-
 drivers/net/ethernet/sfc/tc.c  | 75 +++++++++++++++++++++++++++++++++-
 drivers/net/ethernet/sfc/tc.h  |  2 +
 3 files changed, 79 insertions(+), 4 deletions(-)

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
index b9d7c4bb7e69..57bdd56b7113 100644
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
@@ -1049,6 +1059,7 @@ static int efx_tc_complete_mac_mangle(struct efx_nic *efx,
  * @fa:		FLOW_ACTION_MANGLE action metadata
  * @mung:	accumulator for partial mangles
  * @extack:	netlink extended ack for reporting errors
+ * @match:	original match used along with the mangle action
  *
  * Identify the fields written by a FLOW_ACTION_MANGLE, and record
  * the partial mangle state in @mung.  If this mangle completes an
@@ -1059,10 +1070,12 @@ static int efx_tc_complete_mac_mangle(struct efx_nic *efx,
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
@@ -1119,6 +1132,64 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
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
@@ -1885,7 +1956,7 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 			act->vlan_push++;
 			break;
 		case FLOW_ACTION_MANGLE:
-			rc = efx_tc_mangle(efx, act, fa, &mung, extack);
+			rc = efx_tc_mangle(efx, act, fa, &mung, extack, &match);
 			if (rc < 0)
 				goto release;
 			break;
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 7b6a6a3d8e4c..4dd2c378fd9f 100644
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


