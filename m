Return-Path: <netdev+bounces-30321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D99786DD8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512901C20DA4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B96101E5;
	Thu, 24 Aug 2023 11:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B501100BB
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:29:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14DFE59
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUhldLgW5WtgPg5tVSvOmUpXcLjIM4zUd83NWlcJr7vvkTNuVuu2Wvt+u+11QIf0sMHPynYwfD61pEW8ofddW7GmMKNEmnak+NnHT2Vlw5Lx5N0BnZmIYMBRrUPD2Zu5jo0FMIPQUlsz4NDWPv1PpVkvC7FG3PP40t8ezyxHZHEIeFRR4urmS0wg7VuUTB9t9DzbfxePIhvhhMmN191cDEmS3d/sEWthp2VSQjGzMNE5bFrr8p4KZ1t50PDnL7YXYZzBhRHGei1E4FQ1qHCSZ7Gi6pIwvIKLMMyWqRXSKIfidumhMfeObx6iCM/SxcDkVJMi3n7IEAGzaNnNXO8vSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUWiLmKxCzT9WCnzr2V0px2oMjlTPC02yARgDA9loZ8=;
 b=hT+TbhH2yzv7MzQdbhj3Cow3mJXsgxab8bhEWRaWa5MIKbA+ZLZtzR76vOgjK0jJmdatCK6yzWp3qbmtLoAhJGYu0Ti9pTXfA30YhHm7FWyXoOTn29v7kIdLNSd/efHZR50WRe0xI6jy56LZqTIOaJJ1CMWK2llz71JVuzX7aBLSX7AspgoEt9IVz6YZmMu7LQOgk7gQ4a3auCcECDnGrEe74b219CNyvEsyJrSJQmUCoAUzaI4BU25yUGUJZ1+Z8NzTSRmletfqxfxu/jnpoLAWG9fQ3tUr70cKmx5ix/6jOJ3RaKUuLeqXW+W6WCO/q6q0eDXGqd3vddxp6W1NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUWiLmKxCzT9WCnzr2V0px2oMjlTPC02yARgDA9loZ8=;
 b=lR2qxh56mdWSBkLdQheCgzt8FrBDFMgMXeF7eerSvoSEc7gQVGbFzLS5XiIR4sHVZgnPeGGGD2GLU62Tgn/qgAh38qxwHVOJ/6kk+A7Yy6GLlxt2dm1zSILOnyPb23+Kv4KrR2XdV4l1W+DurRmTxcUvNtKOPc5GELNLqkM4aH0=
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 11:29:00 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::cb) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 11:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:29:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:29:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:28:59 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:28:58 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next v2 5/6] sfc: introduce pedit add actions on the ipv4 ttl field
Date: Thu, 24 Aug 2023 12:28:41 +0100
Message-ID: <20230824112842.47883-6-pieter.jansen-van-vuuren@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 113ad1bc-c8a5-45eb-a5ea-08dba4955059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0tyQXTB6tl2qnsAl1K871hmz+/zxAlKe18AAYgN1QsSxDUGYree0x+ZUqG+rVHDfvgsixBjDlQVPThZbsokbTF29/hXGsoI0gg9k6uKYBRZSn+sxM9DrnYTtdLmRWPSQwgFwLY9ZGE5g510StT8iHYi3PJs8+WGaI8gtpX2HFj2Up3AFTgsvK+uaOl6tfgE/By/2yfNp4uOSNkY4DCvG1TipCXO17Bet3LN7swJXi+EALTAN/5pFkwrdvPEFB8gWL/XL68hqU1Mp9L2b6VVwXt/GJWBAUlAWn2aiWMNu6jWa8X0hyd0q9uZYIQeD9MEVR0cCVUMa3yN7lLLNBhXWOdEpPwrIEo1WndKMGus7TxOUHLCbolN2gEMXEF/2m3c6AHKkFrVraorFWiATS9+nsrcnyLiI99v89XYdZh855AEs0uWfxiZMtXt2z4X0RiyyvSOkRmv+Dd3pKF/CkdYsJ4gsEdFxWlmi4MdDgUJQN4nyzJPYZeT39cPRrWOvIXgengerbqqndtr7ZBhX4s8hNw4GTBv7ZGDn7ZNoAL95H6mLYcDJ859wcmBtoDvU+ug1ysIUcmA+TWSNoXMfSEjHmUCpac8nsDmlZb1TOXoxjg+ZZgkK21HiTeBpnwWqFtlXwv7fa0nVK0Bk7UOrThSHYG7ISL0uUkars9t+hF2FFYbpHu3pKpH+QDNWpheTU5UlzyVjIz/uhhlySmfPzy6/oHEv42TWGC8bgkrPwzDFaWZNuOSfJo2cK8fyuVHC7klZnDyec8PY0OP3A952m/Fzkw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(426003)(47076005)(36756003)(83380400001)(36860700001)(26005)(82740400003)(356005)(6666004)(81166007)(40480700001)(70206006)(70586007)(54906003)(6636002)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:29:00.7098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113ad1bc-c8a5-45eb-a5ea-08dba4955059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce pedit add actions and use it to achieve decrement ttl offload.
Decrement ttl can be achieved by adding 0xff to the ttl field.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/tc.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 354c635be59f..dfe3a8bf74f0 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1054,6 +1054,47 @@ static int efx_tc_complete_mac_mangle(struct efx_nic *efx,
 	return 0;
 }
 
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
+
 /**
  * efx_tc_mangle() - handle a single 32-bit (or less) pedit
  * @efx:	NIC we're installing a flow rule on
@@ -2014,6 +2055,11 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
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


