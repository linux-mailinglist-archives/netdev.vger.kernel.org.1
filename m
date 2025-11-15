Return-Path: <netdev+bounces-238836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE9C5FEE8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF2B33582CD
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F361F4615;
	Sat, 15 Nov 2025 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qbS/RYYf"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D513A244
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175123; cv=fail; b=N/+4JWT8yoBF7MZSndPQyWXX44jELUrU2Y9+3+pM6BuSe+k0byDwHYPkTyKITtgd5ZiZXm+KQ94QD6iqg2ZkCn4ahC6xBHxS3ReS+/2rsGdFf9o2YddnjskmMKHIUewEXyW8npCyadIhtJLu0SpKH1JlcBUEMhL/aKliFNliWss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175123; c=relaxed/simple;
	bh=ZdjMa1nXV6NFlJi575m7bwAQqk5v3FtEg4bfzWRqixQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AM7pPScMWG2RoDs8ni6c6OZhEVfqb1uup/kzbci9jkqgOoHZsvZQqkaIJeocRl/EJKFOWfY+tdpwjBU3RvXx4W4JotYFphgZyzwT5/b3qIVqmnzp/4Zcrqy/CCnB/WHGM0q5Q3yPHxErlD4AhDT6c+7UfP1IRhbA6awDnsnd9G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qbS/RYYf; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVeD1qtgQwbFE/bVagYnnJW9AC+5Y65ZJBiKe2zMy6VdOVM+AyvS92tr7tQ/5hx6ahoLQFayUbCdWQo6JqBC/GPccjahlJyxP1qDL8mJOnO/xUBjPPjTaWm5Lxma6MbDb0RiZVNzXpwnG61i8+x+h5IZAuVGKRsFIRdx7ZuC/Pujb6NhmMmNNkjmrpVFzW6uCBB4H+kZH7s8EVqLeNRWP/m/zSZNpy8115uXDBLovlX7WG7fCJkkIAXaMSdj/PKD6LUY74kPwvKKJt8qNrT6iAtP8znOWSUxRsDoPNZXl4byRgXh7rCF2fzH6gNB0pVYcKSwfj9U9mmIyxguj1maLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r350hrM5zOJXG5mFEE9FvelRBz95ASQDtWf573uOKvI=;
 b=HS3c1/bFs8gLplMN46/MFB/Q2fwVuTjVzE+RsZDEwLRn6Kjbt+T6TGymK6WIElbtJmhpt6S5kQFrPeVreLXHy3V2hRkI3MnQbD47GGIqC7q1Xd80x7bAnMhcL2kBrH6GVqOVg5KpbK9EVW0OM3mehVu2PzZGpoUDdym5wY4TDfb+9wgt/d/vVU4N/SBt/bRL3BDT4TapgHd0ulyVWlDMTrfm+3lLn5HyLQ5kRvDQzB7V6aBC6Dfe7o+FngxxU4OZbDsQosn8ETQvazqmJEsWw2jQHUhBCvJCT9i1jVUm8nl+O7IxORR3oMmWBF989wDxZiteEyB+rl2bYTlXchRf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r350hrM5zOJXG5mFEE9FvelRBz95ASQDtWf573uOKvI=;
 b=qbS/RYYf55CKCTEuYh4UK0iU5ViKS72pl4SVi1JZkPj+SZ+svDq998FXm7KFDIRCjbQ2lBkRukO+wd2SrvXJ3isIszrcWqIbCKK1nevsJ0W+fdiRvQVFNYeT092HD2cGDiGoekGMlkaUPUEqQKKyB7S2PhdZulT738fCLJZKbKb9m+iCf3ge+wSYLlH4XWRbnD7kGIqWXUufhjeqhAQp++2On/nYzDJ+PMbUKoYiFNEav6rkLco9bdERoISc2aiJTBlGX58slfjT5QUsd3a4zKZt9W4eeHHMLQZUPs3nwPaxZM03SX2G4tNSGOyjhdFTNtCmk93cQFnvnnOJcdAn2g==
Received: from MN2PR16CA0047.namprd16.prod.outlook.com (2603:10b6:208:234::16)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 02:51:58 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::6e) by MN2PR16CA0047.outlook.office365.com
 (2603:10b6:208:234::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Sat,
 15 Nov 2025 02:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 15 Nov 2025 02:51:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 18:51:43 -0800
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Nov 2025 18:51:42 -0800
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next] devlink: Notify eswitch mode changes to devlink monitor
Date: Sat, 15 Nov 2025 04:51:25 +0200
Message-ID: <20251115025125.13485-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc97863-acb5-4d78-bd0b-08de23f1f19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nt+0yVAHGkzCyuHqWgVl06V5zb9s/NuKjpqrpur9gdI4rNuPD3Q2ySIfjDpU?=
 =?us-ascii?Q?FdOaa2xtIxTPhJ0GcBGJ2gkUfmWY0mm+ZKDXkGENRyCbdkCv0XleQxEya/J1?=
 =?us-ascii?Q?DSUe6CRIjU3F/uDGta8bcq+iIfR909yHYyQaw9pwsfNFoplRJPDcYheQcC+G?=
 =?us-ascii?Q?JBT1igENQbB+Y5HKx7+ln8vM/qG7qA8AEkuj6Z9MM/xLNuVrPAThnl5FMXB4?=
 =?us-ascii?Q?QrEaVFwvmOYtYtg5IiOg3bAvAjuNFOiyPyp/qgZTLp4kzUXfLoJqXD6JKi0t?=
 =?us-ascii?Q?Mnl+BxhdjvLdsLBfgX6jj6ubor0WPg/q2bHCKer7Wva+tzmcGYcBZ9a079L0?=
 =?us-ascii?Q?xVRlCvviVLbF9kk2nw9g6Um4/gpwr+5KsQAk64q7PphKAvcsMHJivmFbkgL7?=
 =?us-ascii?Q?BiUXlll5deQzPRIWLIcoZlMfnCroTnDew0hhcRIiwwfpoM0sYxtgApSYj5hw?=
 =?us-ascii?Q?hlJOQx6Fbt6/Lp5KWvGQ9xUbGxNzgjYQifOQ6YgypMYcsyLEkheQu+EQbCCJ?=
 =?us-ascii?Q?f1GtneOizwrLS2vb0c/t/lS5m3s+n33GHcHku2EFVZu5ty4Z3f2JBImzm62R?=
 =?us-ascii?Q?i8BHx2DSCTYCrnY8cr6alYdfHGT9i19E0pFk95J8jevGndnkXtJvL93kJbf7?=
 =?us-ascii?Q?L21voWVAkXj5g/oadSGcjAfxj5NJ6+LrnbBpCXgjHuzsRyAjrCSmxiHdICFs?=
 =?us-ascii?Q?Cfy21hji07rGs93iliPgExVq5LYNJNr6A6XSgD2VZHUQUiLaf5ZiCJzzkXFO?=
 =?us-ascii?Q?n/gU7gXeU8keEwE+j2X4vmbybghDZPvHDvlTyEWS2pTgLS0OpjI+/b+OzF4o?=
 =?us-ascii?Q?4VmVp78D8mE9TT6/HRvIKWo71N6pxlOEn6advpGvo2xeR61iB3WL94id5j2R?=
 =?us-ascii?Q?lV3l3SYtl30Agz6QS30jKNOK0ykugWcyapQ34q83TCD5/4hUqNrMvLv6A/TL?=
 =?us-ascii?Q?jz1K1pLtUoT8tgn/FXnMihmtZiO2pAChjtwJc1M8zLoXHhfYsbew/faUXSaI?=
 =?us-ascii?Q?CEjlzuSS38EvGRnmwjQFhMIBmDuUs/7VR0tYHGVmYTi22CX4YhMiYPlj7ZMX?=
 =?us-ascii?Q?jLTCc92Ksu+Ahudrh8s2tY/WPIEvuQ9+SPPb8XeL1GbGO0cwShL3w7qm3lJp?=
 =?us-ascii?Q?kThl8fj0ty31cfbQVe9QMlN4/zWDQTfMOEuEql7zjd3AADpbIfSlzD/rX6jx?=
 =?us-ascii?Q?KRn4CG2DvlijaajUrW/ughyZwfxpSW5IuGOuLUne9iEuGG6sZu8wA9eFgZw/?=
 =?us-ascii?Q?tOCB62kj6bV/rja9Tgp+ouExvWRAEpYtkXmgujKp4CPfuXTFjCdmYj0aaJJJ?=
 =?us-ascii?Q?JMs0mZw8eGPKeAt4V15Fe6jz8f+M1ejgnaJlR2CDmTN1Y+1WgqXtZvgs2+kj?=
 =?us-ascii?Q?epDjz3jdq9h4sJnJ9qJzwsKhi63lElR6imE9OeQte8t9tozUgtRApNMXXmTP?=
 =?us-ascii?Q?WKhX9LE/bMSPt09+4UaO7Z9Ao0yaUsKYH1oqOVP5wk6K2N5tyCZfqRGrDWJN?=
 =?us-ascii?Q?x2XbNfyM6GteahnpJYy8COGCToloQ1maCOhasgbtLenPwEL9WhmO0bsme+sl?=
 =?us-ascii?Q?IUzTtsebuQHFGLDhBz0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 02:51:57.9149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc97863-acb5-4d78-bd0b-08de23f1f19f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68

When eswitch mode changes, notify such change to the devlink monitoring
process.

After this notification, a devlink monitoring process can see following
output:

$ devlink mon
[eswitch,set] pci/0000:06:00.0: mode switchdev inline-mode none encap-mode basic
[eswitch,set] pci/0000:06:00.0: mode legacy inline-mode none encap-mode basic

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 net/devlink/dev.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 02602704bdea..012211455f97 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -701,6 +701,30 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static void devlink_eswitch_notify(struct devlink *devlink)
+{
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON(!devl_is_registered(devlink));
+
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_eswitch_fill(msg, devlink, DEVLINK_CMD_ESWITCH_SET,
+				      0, 0, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	devlink_nl_notify_send(devlink, msg);
+}
+
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
@@ -742,6 +766,7 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	devlink_eswitch_notify(devlink);
 	return 0;
 }
 
-- 
2.26.2


