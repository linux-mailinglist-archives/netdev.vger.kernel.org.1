Return-Path: <netdev+bounces-29977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03687856A9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C002812B9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8BBBE6E;
	Wed, 23 Aug 2023 11:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD6BE52
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:17:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A72E5A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eujDqtkkISQ9hmt9Ckcegp9V+RFbl15gPKWw6S8sF9Ms66VBcCiM/8AXhPWHBu9XQ/0WberSBOJlKBgkJl5iGfdBhJeyXQWEOJzeltgZvbs596LlUgjQXx1tl4kz3OAbgAj47Aump7fv7Gn2CVJ9UbnWJrEVP9mR1DOy7lZHub3dxVzHNcr5xJXNt1Wal8Q6hucoTQnWPyCxqD+4ystic1ui7h9BfxHud9um9ib7hRUBjSQmuCmmUuJ97SG+1rl15LA/JAxufHRTAtYfFN1/C1XPxKu9sHohiphPn/WcGZXP9hedhgKpPcpMVHy7rAAPQRTIqX3airQiUuqtGOgmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbcb8ne1lehuOe7PHe1S3y3pA+b+VNsfwuldFl2zv14=;
 b=V/LmCneGiV3eOtxcV8S0cq6PwHtRu7FEcd8ndWGo4uIym7HEPV7nojCpyuF0ae+Eq51ZOksGcEw+2oZ+W4Wp77gaZ8+leSxCFh2udyLsjssy6KYhQ0mP7Qt1fkSQC5qfCYJi8EW4lZcX2riduwNbMcE8HYmdC1yTBAkdhphT/7ygYgffgqGw/tDFXUzF0HmifIcr+KcR7OB99xEBYBn85vkrFcrFmwACBKLRtXYOuOp7yvenzHwa5objz4r3GrfOp+x2LVRplM2i0THQr57SYRbqJ3gMwo9bfQSw70htIDJKL5n23D5CoYhpxOc+95Ip63bvBBrlxDdYl4K769dn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbcb8ne1lehuOe7PHe1S3y3pA+b+VNsfwuldFl2zv14=;
 b=EQRWVoKmq0D+6+RaO1H5VHfGAEVNeA3e8rDr6ft/eTF6shaE7AhBE7QkzG9tFqHesilboDl2D+GW4mHSKpkmAfZDRHCIXxEiVdK7xE8vqcquJfANXoKDxt/FGR8alcBmM6NdtsgPzaqRP4wjxyqo/AS+D2J0yOI9eNP94dQA3GA=
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by CH0PR12MB5185.namprd12.prod.outlook.com (2603:10b6:610:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 11:17:43 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::af) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
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
 2023 06:17:39 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 06:17:38 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 4/6] sfc: add decrement ipv6 hop limit by offloading set hop limit actions
Date: Wed, 23 Aug 2023 12:17:23 +0100
Message-ID: <20230823111725.28090-5-pieter.jansen-van-vuuren@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH0PR12MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: de453fde-4476-454d-709a-08dba3ca925c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2mvl8i4BdvREaczjmSabkTNsCSKpSvBH1b0ruxyqZfCFQbV5qI8J8XyMG3K0nDZh73NgypC44clgPnLZBnlWBUofFkYxTmgIhJxk+GiKI0HMSlxA7BSpou2t+qXSwpSGMxGC1bM5+83EbN6ME9ruKfk0vg7jAxBel4ldJWLHsCmZd3Wqne2qBkwF0PsYJX3Xn4YzCKyZUhZB4HSX+8/TUfLCNtt0WpZUnl0PkEGDNLxDRQVUsfa2IKDzcHOm0LJcTQOnE3kOPXhJ4GFa11xvaDAT6NcQ/81E/3JQg1RvpGsotgG25SksvjA3i22oFpxk5iGyCCmiwdo1vP/qiSNrs1cl3cjnsWU4OY89iZ/Zpbm5JZ7RVmC2kyJ+ERxae2y4Wv1lBhtl04a8PTlEETwYb+a/WQJsd0BQJU3polOiD544GBk8FHF1Y5R8u2G6L6UIlIJP7Q6LNXcwdN/pGtAUkb3dmMwGJ/ORxZOCmn+ET6g8bvhTMbBN5rE9TK8BZR41pbj6BNiF6qd+S+6CjZDqk0dFIyFOpteNdTH9q8skR7dJ0qyi8CSw+ikYiSneE5d+sXem5oFmJ1ho7quSsZbr6fc1Vq3TblvvbAP6jxCtPa7GbZHQweEj7vbV5bY5U47maiJ3ey7XtKru2Jys3DbvHouP7qlgmMuhlc98t/ED8UXTDxJUVKfCAoF+StEKSJmIcjkhE8jCeNb4YYqwrt1hwcHsURfd2bWOcjBRvEGRet3KvMjD6EzZubiq4BiJu+BstHgfuEVk4W35Y3mVZrq7bg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(6636002)(316002)(4326008)(8936002)(8676002)(70586007)(54906003)(70206006)(110136005)(40480700001)(41300700001)(336012)(426003)(26005)(1076003)(5660300002)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(86362001)(36756003)(2906002)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:17:43.5747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de453fde-4476-454d-709a-08dba3ca925c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 03205789dd6a..dc6275dee94a 100644
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
@@ -1189,6 +1191,63 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
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


