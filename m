Return-Path: <netdev+bounces-29975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434597856A7
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AB8281276
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04207BA42;
	Wed, 23 Aug 2023 11:17:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE6BE53
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:17:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36542E5C
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqaoCQwrtNpkEmRNxf/4xXQnCPt37sDIlcj2u9bIh3iNE+KebCrSUUxKPRVMx1aPOEoP2jKNkMuFmjqh1EIGu4J2ugwGiaQWi8BmO7OfUGwQr0CJZGUOUZPh9XXc1PDMOy7ckpN6y91JCJtnyNhVpcsyY9lCr5XvMAr1yNVK9bYvvGDHiAX5m5yVPh/ZLpoXWEdFG8nyvituHMdLvc10DInI5nOQyfLTtg8W+VhqGtg0oWNxwLoW57ZqOUIn4KdBrSVwGj6CjCiUIuAOoWcAldJip7SPcUczxrNlEpIn2XZuqzbtf6YDRouUfVwGsOV3LNKK7zlGql3AYKhdWoF+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoUSp2Oft46bGNxy0vWC9gOqJsxtFmioy3A8+jRONCY=;
 b=kC4MxaQTTykNgTjEaQd7aJMi9Kf5hIGX1kpI8oXAGusKM+0dMnRsTol6uJHI74WPTBW19vhnWNbK07/iuEJxiaMZZk7rujrdwXIxAzfZ6Ez/2mQO5AuEJ5agPE9D2NAPdEHG45R0J+eP5hlhel/CCSXB/dWAEKjxPG0OPkvVKHs35LpDF08g6xZ0P7AVTLfQ+YZJD8wHB8zV8uH3UYwXmPwa0QbAJyPZSsHf5BsBiJTC8YwXgCkp4fLeD6lxdzmQkbNC0KV2hJjCM90UwEdpIZxmmazzGtZTdl10eM7slBLYiQSLP88GRz882Ikh2IlWnJ5I4DpnJLy/lTGIVQidRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoUSp2Oft46bGNxy0vWC9gOqJsxtFmioy3A8+jRONCY=;
 b=VeFdSUmyZFXN8WPctjgYX9mVvy/N8pjoRiCHvAT/gTKAUDXgQ7ShrQZg/wnfm4XYZ5LYkoYu78UfS6NYUkYO0wj19yR4MOY9EGJUL4uByuY8JARhy7chF+TEyh3YUK1gGq2xzZw1sSE6Q7dJ9buHR2je0DAfUKGpzR25BBiYtKw=
Received: from SN7PR04CA0081.namprd04.prod.outlook.com (2603:10b6:806:121::26)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 11:17:42 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::d8) by SN7PR04CA0081.outlook.office365.com
 (2603:10b6:806:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 11:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 11:17:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 06:17:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 06:17:40 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 06:17:39 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 5/6] sfc: introduce pedit add actions on the ipv4 ttl field
Date: Wed, 23 Aug 2023 12:17:24 +0100
Message-ID: <20230823111725.28090-6-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
References: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc68b52-ca9d-49f4-e012-08dba3ca912a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ra1IyfF1VXEaBpw/1ZaWFfE5PqGqCHo3rpTqJAf80j0tabz7UqWuA7nZQGTDjZHS+eH3642Tij6dFn9waod8g4tEEa9JUlbKnkpZBixPIesRL46T92pZ/hzfkA7mmsjchhZoV4e9gZBtxwA5sToelr/hDtvr8ZGh9up4PXuCj5x4hm4iqGCMxdn+76DB37I4CsOo1mwhKbGwUWHmqgrqjKlpWyQOuBVwiHDHJsKeuaHWiuhl4qIQ61WCiilKBQvLejGFN4CDdQ2b7fhb71hS/oI+yk/R6es0aewjfFRYT/qMUISdlF4ZJ2PI/OjdUW5x0IJOt8l9E5loY0bcTL96gXeTrN1+Hq2DdD/BFSZkTUl1QNDaS72AetMPhLWHdhM1rbukXl9nOLgNC+Y2wzDG2RMxrm4XThCozninEO/sVyjFqfV/5LlKBAEhbFRMHgxuNYn1WiTJSBCfBqSJ9mt0d2t+bkwOdC3/AvJKC/lsHAuciVdjggwB9e/h53OdXUmcgpwcgrc0Cavksl1xuIbp24RS4b26/pch2xcFXy3Fx7k/Bl3H+5OJXy6Ne/+Yam4IUNfi0TXlzVZnnWhVEOeTLyLzwy0KKzewblTByNmeCcx1IQT2HxEkF+N7HOuL7/Q/zbkkhEV6POc6PHx9ee2H9uQ8qdN0QI37WFHEbViyS1oPAmzSKWlQ30WyLLITfodLS1ML/r+DrBMKzHWi87GtDmb2i8mtk+Z6KjzTCby4UTntC+S+Ajb61nUjSSi7Fude10f2LQJX/7wmzED7Ee17jQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(40480700001)(5660300002)(426003)(336012)(26005)(86362001)(47076005)(36860700001)(8676002)(2616005)(4326008)(8936002)(70586007)(70206006)(316002)(54906003)(110136005)(478600001)(81166007)(356005)(82740400003)(6666004)(40460700003)(41300700001)(36756003)(1076003)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:17:41.6815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc68b52-ca9d-49f4-e012-08dba3ca912a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce pedit add actions and use it to achieve decrement ttl offload.
Decrement ttl can be achieved by adding 0xff to the ttl field.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/tc.c | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index dc6275dee94a..8ba5816b51f2 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1067,6 +1067,46 @@ static int efx_tc_complete_mac_mangle(struct efx_nic *efx,
  * earlier partial mangle, consume and apply to @act by calling
  * efx_tc_complete_mac_mangle().
  */
+static int efx_tc_pedit_add(struct efx_nic *efx, struct efx_tc_action_set *act,
+			    const struct flow_action_entry *fa,
+			    struct netlink_ext_ack *extack)
+{
+	switch (fa->mangle.htype) {
+	case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
+		switch (fa->mangle.offset) {
+		case offsetof(struct iphdr, ttl):
+			/* check that pedit applies to ttl only */
+			if (fa->mangle.mask != ~EFX_TC_HDR_TYPE_TTL_MASK)
+				break;
+
+			/* Adding 0xff is equivalent to decrementing the ttl.
+			 * Other added values are not supported.
+			 */
+			if ((fa->mangle.val & EFX_TC_HDR_TYPE_TTL_MASK) != U8_MAX)
+				break;
+
+			/* check that we do not decrement ttl twice */
+			if (!efx_tc_flower_action_order_ok(act,
+							   EFX_TC_AO_DEC_TTL)) {
+				NL_SET_ERR_MSG_MOD(extack, "Unsupported: multiple dec ttl");
+				return -EOPNOTSUPP;
+			}
+			act->do_ttl_dec = 1;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	NL_SET_ERR_MSG_FMT_MOD(extack,
+			       "Unsupported: ttl add action type %x %x %x/%x",
+			       fa->mangle.htype, fa->mangle.offset,
+			       fa->mangle.val, fa->mangle.mask);
+	return -EOPNOTSUPP;
+}
 
 static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			 const struct flow_action_entry *fa,
@@ -2013,6 +2053,11 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 			act->vlan_proto[act->vlan_push] = fa->vlan.proto;
 			act->vlan_push++;
 			break;
+		case FLOW_ACTION_ADD:
+			rc = efx_tc_pedit_add(efx, act, fa, extack);
+			if (rc < 0)
+				goto release;
+			break;
 		case FLOW_ACTION_MANGLE:
 			rc = efx_tc_mangle(efx, act, fa, &mung, extack, &match);
 			if (rc < 0)
-- 
2.17.1


