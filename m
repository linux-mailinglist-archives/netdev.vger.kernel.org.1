Return-Path: <netdev+bounces-47972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C7F7EC213
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D8EB20B6C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520C182BF;
	Wed, 15 Nov 2023 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dl9Qx8iS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF8182AA
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:19:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F511D
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8+tpwTsamVKMfP2x0mhWs11GN+aMwUdlnWb/6VVY12KwAnZVpp0zEpQxVO5tCV2pYwTlz7rkWX4JVz8oDwZPcrxiMRKu5wpWzOqeZFkA0UjzAq1wg5s2y3KILlVkWOo64CzlSfY9iaiKtGtyMOewQZzMa90Y2TkOCkfpBwGuHR/FTJzi1t3m5xpjegu7VqAtJB/FBtg7dt87mK4YlUoWEv/AJAmQyMSM2Df3FTqauasebEt660dWKEN5z5N5l6buCF/6nEr7s/01+422L0uRzJZwpZEyr7XWAiPLETd9o+8zfv9myujUibegkdqeDuxkuz88D8OCbZ1GzxhnSMFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVBh0x13Tg4nPu6Wvm17lkmiOgXEE8Gax2MuGqWXkd0=;
 b=lLCPShKyNenUnXL1ceEqLQUTxwCoI/9eE2qv/vJ/dZbAunLNCkHe6docdyStSYGdQB1zldlIji5AC8FPBcXLdZFX4ONWkguE7e9lO8mtV6sIFdXUGY/0Vmmw3EfoB5n1Ato2CMtjCf73gduU5G1s0DZWjjfyzw4EHB6ZZiSMP/NJOgCYtzGy8jvFBzpnpzvPKXyo4b5mzupGi4MQNFx4r0JfqTotE24z+8dVCnuzvrmuNX74a3PTrRrZneu7h7fq8VGX5a6wDCQUc15GGID0xw4qy2VLbZt0hnZ3nUQP3BbD0Y8W5JSOqvC+eaVTrXD8nL6Zs6Y9T9fZ5nxr+VVgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVBh0x13Tg4nPu6Wvm17lkmiOgXEE8Gax2MuGqWXkd0=;
 b=Dl9Qx8iSxvivzqF0xEW9ExXjJ1ySNZVB4s3MMOCCpZjRoZu8qDKOGEMio2G4xYeCOjCCvPuxJXraj443cuvAjPAYM2oQZ8CKXM91I73Zb0WDEErMQhpjHz2QX+IqliHe7O2IQTvCXsM9TJF6s0jeiX4gFnIa8XOB97HVuMWi37+6zc5pI5BWckiXMLxI2XNF3AVDJR+wQ2OFNB+RmzFN4TqL0eIhufGaoueHOAM9tJxBrvhkeCxwUzgBaAtdZszkcjQ4Hq+7o3W+aSR53KvYczqqEm++PoROb2gzT72EwLnV7Av91mPdoGQ6RFHZg7HpCC4uLMV2N8ln04v9Un272A==
Received: from CYZPR10CA0019.namprd10.prod.outlook.com (2603:10b6:930:8a::28)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 12:19:44 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::85) by CYZPR10CA0019.outlook.office365.com
 (2603:10b6:930:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:19:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:33 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:31 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 03/14] devlink: Enable the use of private flags in post_doit operations
Date: Wed, 15 Nov 2023 13:17:12 +0100
Message-ID: <63d7e04fdfaf44a33d683270d95627afbf90e932.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cdfb19-7281-4ed6-f8b1-08dbe5d526ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BzsFf+9UeiWj/a6pcLL7A26kE3TdMH+i+XLWZMWulhwgYixAYBmVU/EO3Yoq0QQ0RdRtFzEir68Ghz7Hp5Bo/5dXcG/sg/ewjjHPgDdguEQFtUNPajtxzNLSbnTuClPQ1CACTrucpGBqvzKWAgrNV3IyBZtkO9DdfiNmp89xjUaZjt6rjlwebF/mQQgpGk/ZPFD2LbSSjEImxuzi7liZjmoQcFZ0rjSIt28KOyJSGkRF2fPVGYZfHlefX5IPQ6RwTAGQNzUBEOw/1XB+b3+Ns5NGQec/HzPjgq2YDMusZY0KRmAH6Z1+/I2snFokOLFpgncO7gB58FHl++pyh/HJJrtLGdvmWdo61KNnBIKFX937PNoI+FWEHxCv1SE8jSHwEoWqNODdJtFBuwWBwECZrXAFVRYWzWbs1Yu1El0LL+TWdSPTpIMorK4v4r0WjVWzBJynf+O7DVJk+Xv2A2zzYVX/r1smr2eLKjg28cS5R8BTQpbnazza0eYKYhO3A7oMoxMgXnWn+iqD5APBl7X3Gn4vJXU4crfLjfzMjxBNc0Lggg/OBHqbLptni9i+2LM2H147AtA/ux9XQf1jkLf8U0qPJSxgsWKoADBDz65ZC4Dnr0sLk25OPGUQBRb81mNrEthDfqJW6wdHdDcIobkEJDC5mMSU9tWa6338pYgfuTQq5jWRiCsr+mXhjti79cPmR5IfJLBE/+5JVajHSXDpvhthVOYuj8MkKywSMZNzm6ydL1KoxADU9RDzX9jM9P0S
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(70206006)(70586007)(110136005)(7636003)(356005)(82740400003)(36756003)(54906003)(86362001)(478600001)(36860700001)(336012)(83380400001)(426003)(16526019)(26005)(6666004)(2616005)(2906002)(316002)(107886003)(8676002)(4326008)(8936002)(5660300002)(47076005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:44.3700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cdfb19-7281-4ed6-f8b1-08dbe5d526ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101

From: Ido Schimmel <idosch@nvidia.com>

Currently, private flags (e.g., 'DEVLINK_NL_FLAG_NEED_PORT') are only
used in pre_doit operations, but a subsequent patch will need to
conditionally lock and unlock the device lock in pre and post doit
operations, respectively.

As a preparation, enable the use of private flags in post_doit
operations in a similar fashion to how it is done for pre_doit
operations.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/devlink/netlink.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 7350138c8bb4..5bb6624f3288 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -141,14 +141,20 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
+static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
+				   u8 flags)
+{
+	struct devlink *devlink;
+
+	devlink = info->user_ptr[0];
+	devl_unlock(devlink);
+	devlink_put(devlink);
+}
+
 void devlink_nl_post_doit(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink;
-
-	devlink = info->user_ptr[0];
-	devl_unlock(devlink);
-	devlink_put(devlink);
+	__devlink_nl_post_doit(skb, info, 0);
 }
 
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
-- 
2.41.0


