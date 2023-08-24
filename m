Return-Path: <netdev+bounces-30322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7459786DDA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD61B1C20E3C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDCDDF5E;
	Thu, 24 Aug 2023 11:29:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9511193
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:29:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C22910FA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrQP/iBbKyQSNtoW9TwpKCTKjqT4GJt+y2QqWaVBQ2NCs7cXRprZwYp6ubHqbDOOvlWBDQJycPvQGEqEtccr0uUhcFfX/D1gSD2M/0ygIyQfL3rTZetaRiFBD/deMZz8yC9UUu8Bcpx29VWJdx2icThpbLpVR3xghVTrN2xeZfLppDD4RfQsWPu7vJ/Rcpurq2IP+Ywu+Fhbe3nWw5/zJ5tre9MZ4VelVCiWrtHDkTTOoHdMg9v3T5uDMMFMSFcKvub4qj3S9f6Jq5PAt40NCQjATijQ4YEeUtcmIYIYxOqurdO5FMe/ejp/ArnqL4BVQzBUT/78cqSMeRN/hvNd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+CxP/TuYMUKG1UnEVxobptqz8Z6a9nlTIJ8Tq+Tnrs=;
 b=TRKjBAeXL6Wcp/QPQ1ktzb6zNG+I2ZDhI17CaTAUfyO/WkU3JGuPnf+I++TbCffGIgibVPsc4686MUk2c9879R15HsfMnCvvEJ62gXHJ5BQGX85NTZVqbGBKO95rpM+ZFOWeHT1VMEWLVtAEPVFQfhizmE/NDTsaQRcD3gMimn87emeSVkaw3/8E6R20HfFcGHU4VamaJxS1fxNQiBE6BABC7s5TENMIi9RRSJrDNwnfdyJEnRnpByEV8cs/TnPR64/tsM7XvHXfKcYXiuWhYKfyI1ITqJgtJ2e9CjrowkaweJZRunncQ9ibSKzTd/DUx8lmtJzfg/qaTu81KXlczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+CxP/TuYMUKG1UnEVxobptqz8Z6a9nlTIJ8Tq+Tnrs=;
 b=mfwCmJ/IffqXkEn8/BNmUaWjn2SIUS0s9r7gWfFaeHCVi1JbtyQQWNaz3Np+CWfa5Oq2osBT8wOf+kw88F2vixg2gOa/xsf947Q008U2ibq/j66bE52Iy8ImY3rVdyblt6NctD4mijIe/mWdWfCHBYajhex3fxEBRZ9ETIalvIc=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:29:01 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::54) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 11:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:29:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:28:57 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:28:56 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next v2 4/6] sfc: add decrement ipv6 hop limit by offloading set hop limit actions
Date: Thu, 24 Aug 2023 12:28:40 +0100
Message-ID: <20230824112842.47883-5-pieter.jansen-van-vuuren@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbbc84e-eed8-4233-1265-08dba495508c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9ZTvYKN+tvPAvS6UJiHZVfv2hY7DLYiHsa/bMCVB7INMUOV1cLM0Nfk1aWYYuuL90H80QxrdUHnQyR/GUGwAvjbQ3BFbcspj+v55q6jMtQPK8kL8i9lEGqiMSEInnj0z9X3OGIFLoeZdAqACAj3wsIkudDNtjuij8ElH4e9uMkfNbnfDPPYnAAZQ2lVUGbayOnO7wJQ5OIa3+BVBxGo2aHICKGS/hnWb4/A1j6euH5j5Kow7JP724l7VIEE9VCel+v0LvnsqzI2JLATil620MGFMx4FvO3pcTlaNqQ8A56VK1myaNUd3XSWmHTVypJSj7l0ioVCns6zcuqh7QvJ9NF7OqPL3OQH7sWeMIAUnRM8iRfATbHUsymQYfp5Pb0nmbmywRr2anj5x7ZBjAlS1IHxrJ04UuXCfCYbZEbnsukXXhHjJIUNM0xFuEVK319fxnI8Ax6ym4/v85cpharqBzfOKe+oOJC0D3CtQ9K00rJC0wHEKwT2TImPkGXLLLPZcpPOJr8n8Fw+vpKfGkPzbeolK+VG/7Rj6F67d3pDN/GZzkldHN5nj2YuXSWnPg3E8u84zpBknR5G2yoYH2U66tUzK+qvAyklfxrdJnlQ3WJ1QY5dWj2SWUjrn/uTqbZQTAcfhjss7637pv4WUqWjipUoBBKFL2LLSPNeMXSMCugOmptEnUczIkSVrNZEFDTqj9HhRat1VnpSD+YdgWK5JvK8O8sEXWpK2iOqtiKzX3k6hObXGxnGbFmVYoXdcUWvUDw1uFMYEiemeGtltZOYIsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(1076003)(40460700003)(2616005)(5660300002)(8676002)(8936002)(4326008)(336012)(426003)(47076005)(36756003)(83380400001)(36860700001)(26005)(40480700001)(82740400003)(356005)(6666004)(70206006)(70586007)(54906003)(6636002)(316002)(110136005)(478600001)(81166007)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:29:01.0090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbbc84e-eed8-4233-1265-08dba495508c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Offload pedit set ipv6 hop limit, where the hop limit has already been
matched and the new value is one less, by translating it to a decrement.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/tc.c | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 57bdd56b7113..354c635be59f 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -32,6 +32,8 @@ enum efx_encap_type efx_tc_indr_netdev_type(struct net_device *net_dev)
 }
 
 #define EFX_TC_HDR_TYPE_TTL_MASK ((u32)0xff)
+/* Hoplimit is stored in the most significant byte in the pedit ipv6 header action */
+#define EFX_TC_HDR_TYPE_HLIMIT_MASK ~((u32)0xff000000)
 #define EFX_EFV_PF	NULL
 /* Look up the representor information (efv) for a device.
  * May return NULL for the PF (us), or an error pointer for a device that
@@ -1190,6 +1192,63 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			return -EOPNOTSUPP;
 		}
 		break;
+	case FLOW_ACT_MANGLE_HDR_TYPE_IP6:
+		switch (fa->mangle.offset) {
+		case round_down(offsetof(struct ipv6hdr, hop_limit), 4):
+			/* we currently only support pedit IP6 when it applies
+			 * to the hoplimit and then only when it can be achieved
+			 * with a decrement hoplimit action
+			 */
+
+			/* check that pedit applies to ttl only */
+			if (fa->mangle.mask != EFX_TC_HDR_TYPE_HLIMIT_MASK) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Unsupported: mask (%#x) out of range, only support mangle action on ipv6.hop_limit",
+						       fa->mangle.mask);
+
+				return -EOPNOTSUPP;
+			}
+
+			/* we can only convert to a dec ttl when we have an
+			 * exact match on the ttl field
+			 */
+			if (match->mask.ip_ttl != U8_MAX) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Unsupported: only support mangle ipv6.hop_limit when we have an exact match on ttl, mask used for match (%#x)",
+						       match->mask.ip_ttl);
+				return -EOPNOTSUPP;
+			}
+
+			/* check that we don't try to decrement 0, which equates
+			 * to setting the ttl to 0xff
+			 */
+			if (match->value.ip_ttl == 0) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported: we cannot decrement hop_limit past 0");
+				return -EOPNOTSUPP;
+			}
+
+			/* check that we do not decrement hoplimit twice */
+			if (!efx_tc_flower_action_order_ok(act,
+							   EFX_TC_AO_DEC_TTL)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported: multiple dec ttl");
+				return -EOPNOTSUPP;
+			}
+
+			/* check pedit can be achieved with decrement action */
+			tr_ttl = match->value.ip_ttl - 1;
+			if ((fa->mangle.val >> 24) == tr_ttl) {
+				act->do_ttl_dec = 1;
+				return 0;
+			}
+
+			fallthrough;
+		default:
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Unsupported: only support mangle on the hop_limit field");
+			return -EOPNOTSUPP;
+		}
 	default:
 		NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled mangle htype %u for action rule",
 				       fa->mangle.htype);
-- 
2.17.1


