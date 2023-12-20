Return-Path: <netdev+bounces-59271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B002D81A2F2
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EFB1F2207F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1EE405C6;
	Wed, 20 Dec 2023 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PyQUt+Nw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7D41849
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jryKU7J1q/oPFW1oN2luxDFctNBQKGPW+Qzgql+MygvPnGDee8Kywj+kp37CSTnpciRwq/FbAiAYt2/2XbHB7XRiN35dgK0WvSe3XzRharSoJJR6db8vr7nHx05+geFo0kbQTikSiwP7jIc8iCcgGVPJRtpQrROlb5BMiIa97PN2TR7F6CVsq/1yGRkG+S1R3BxkG4lUaOZyvE5J9GeKpwtKD4XN92zeEFTFl+/XCPVPiZw8rW4YgM/K4I8nrFCR/ny01yshsEkEyIEDjOMwXUmEki123uIhqWJ4jpLF1+OfnS1IlTGVkYuz464Wr2djvE7ug1BsB2wPNyXnvL2ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBTVw/HQIpXGTytmriUlDEa/fMu6JgpMASZWTKwMBFM=;
 b=QD7Pw8Cr8axNj+vCwdo8CWY65RJ3tZROkeq4a6VmQf5Fcg2JQHo9+q26v6emlzhlzvqN/l5a0blRU2sfSZKxPowj94GXr1KnbUVexYcpqdsOxOesVoxVxEtnsA4w4smhqM+3TFtde+XTT74z+SDYk/0bN6qKho/4o2X47GMchpUzCCtKP/alLwWIfk/raYO62kptxL3jwrE7CCDYVVwQ/tg7WR1Gw3Xjhn/7qaVhJvirt3DSiGageAxP3+BVDfcXMUdw8CbJ+s5yvfMEmaahi8kztuTU1jJ5EiMitNyvrIg0UZ7+a4KyCCYMr3QYwCgcO8RFwlTuuukalD2RN7Qwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBTVw/HQIpXGTytmriUlDEa/fMu6JgpMASZWTKwMBFM=;
 b=PyQUt+NwuLgcaE7LOxMJjeuhCMAPYoEYIDImX5Ua0BCQYxIlTSYp3VzUl/qQSeEyiBpWoyEFVWSktD1uOiUXHGCdzkMjCDgqFt5hLkE3Q8dkvHKTIvzQi40gPp+xxIvvryJGscVVJp386qJfrlnC2nNud4Zn6Ocp3RMjUvhyLvpQ27Ahhmw9VvnQhi6DMbTGZwg5FyQ7fFXTipDazSm+AGgFNCw5a/ZKQf1oe9/mdWQgZgJFkVF28aZmV7wtsmTf3UyKyjA4gyK1WtQeXPUeBIqK8JIDptbKvV56IJKUwpqd8zrCXwYcwMlGjQIMTxfSyZiT0TEdxol9A/kYunzdgA==
Received: from CY5PR18CA0059.namprd18.prod.outlook.com (2603:10b6:930:13::22)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 15:45:04 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::b4) by CY5PR18CA0059.outlook.office365.com
 (2603:10b6:930:13::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 15:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 15:45:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Dec
 2023 07:44:55 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 20 Dec 2023 07:44:51 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <matttbe@kernel.org>,
	<martineau@kernel.org>, <yotam.gi@gmail.com>, <jiri@resnulli.us>,
	<jacob.e.keller@intel.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <fw@strlen.de>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2] genetlink: Use internal flags for multicast groups
Date: Wed, 20 Dec 2023 17:43:58 +0200
Message-ID: <20231220154358.2063280-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4d9d4f-0380-4051-45e2-08dc0172a2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VDpFHUt6XMA3F46EyAr6GAypICDJhH9zSXqi277+AfzVU4TXLiNtz25wzExxXBnevNZ5ZGi5lp2iPpuBUwmnqM94x970x2KZp+Rii/ecKqt6QmVXrbU/Lcy+c4FWTeZPotM6QMFgN+RpxHxoYTO0Xk/Il0EDmxMtugjjBp38E8cytkOf2JbNoYtGsn2Tim7RDmXnBvDsXS93B1C6zNb/yw2/3WhvusrzGhaKSPv87jt2dLP6LBw648ZjtzDt8Fp23BZTQST1KithYMYWl7j5xHdF1n2i5L1fSM9P2kI8PMru6TVpRz5LagC+mtwgLGdR02EyJnaACVqa3nQq8x8vwzBOe3dZx4a/bAKPEX9L7rl91eSJTFABXd/z5YO1wNdWoQjrbXQO63PwueaAr6lrx06HFV6pNIsFcyUESm2HodI/4YHuTQlHASt679ohOL5yTBb7VYvO6AtC/1lZCEcjBE/txWPpASLU6BdrgTe3KFbHDPQ2gF0WzdJdjzJhabm9LL6wEi2ZCGME/zaLZVgd/UuK994ngnNBapZHR8UI8gGIjl5gG0JJQ7w3qqcpL/SVp+9lf4YhTSWeQ2TSWy2AIK7rDqpUUAUoN1tTv3KAydPg7BF2DLpCko1Dthk657TgtIpkuroA+J84H49EbEPt3lb91U4hRsVCAdBLkuB4aBfQREutuMLdZn/hxQXVzOo4fmi71Sq6Izd+lrOtsmWT0ZO9FOQAlN3Ivu/MGXkZ7FRXbbaf9jxPowGDwOONVmvH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(40460700003)(107886003)(478600001)(2616005)(8936002)(16526019)(54906003)(110136005)(70206006)(70586007)(316002)(2906002)(4326008)(1076003)(8676002)(426003)(336012)(36860700001)(47076005)(26005)(86362001)(7416002)(5660300002)(41300700001)(7636003)(356005)(83380400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 15:45:04.6231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4d9d4f-0380-4051-45e2-08dc0172a2b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

As explained in commit e03781879a0d ("drop_monitor: Require
'CAP_SYS_ADMIN' when joining "events" group"), the "flags" field in the
multicast group structure reuses uAPI flags despite the field not being
exposed to user space. This makes it impossible to extend its use
without adding new uAPI flags, which is inappropriate for internal
kernel checks.

Solve this by adding internal flags (i.e., "GENL_MCAST_*") and convert
the existing users to use them instead of the uAPI flags.

Tested using the reproducers in commit 44ec98ea5ea9 ("psample: Require
'CAP_NET_ADMIN' when joining "packets" group") and commit e03781879a0d
("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group").

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
v2:
* Add a comment for each flag
---
 include/net/genetlink.h | 9 ++++++---
 net/core/drop_monitor.c | 2 +-
 net/mptcp/pm_netlink.c  | 2 +-
 net/netlink/genetlink.c | 4 ++--
 net/psample/psample.c   | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 85c63d4f16dd..e61469129402 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -8,16 +8,19 @@
 
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 
+/* Binding to multicast group requires %CAP_NET_ADMIN */
+#define GENL_MCAST_CAP_NET_ADMIN	BIT(0)
+/* Binding to multicast group requires %CAP_SYS_ADMIN */
+#define GENL_MCAST_CAP_SYS_ADMIN	BIT(1)
+
 /**
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
- * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
- * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
+ * @flags: GENL_MCAST_* flags
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
 	u8			flags;
-	u8			cap_sys_admin:1;
 };
 
 struct genl_split_ops;
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index b240d9aae4a6..b0f221d658be 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -183,7 +183,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", .cap_sys_admin = 1 },
+	{ .name = "events", .flags = GENL_MCAST_CAP_SYS_ADMIN, },
 };
 
 static void send_dm_alert(struct work_struct *work)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..272e93be1aad 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1100,7 +1100,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 	[MPTCP_PM_CMD_GRP_OFFSET]	= { .name = MPTCP_PM_CMD_GRP_NAME, },
 	[MPTCP_PM_EV_GRP_OFFSET]        = { .name = MPTCP_PM_EV_GRP_NAME,
-					    .flags = GENL_UNS_ADMIN_PERM,
+					    .flags = GENL_MCAST_CAP_NET_ADMIN,
 					  },
 };
 
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index c0d15470a10b..8c7af02f8454 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1829,10 +1829,10 @@ static int genl_bind(struct net *net, int group)
 			continue;
 
 		grp = &family->mcgrps[i];
-		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
+		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
-		if (grp->cap_sys_admin &&
+		if ((grp->flags & GENL_MCAST_CAP_SYS_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
 			ret = -EPERM;
 
diff --git a/net/psample/psample.c b/net/psample/psample.c
index c34e902855db..ddd211a151d0 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -32,7 +32,7 @@ enum psample_nl_multicast_groups {
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
 	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
-				      .flags = GENL_UNS_ADMIN_PERM },
+				      .flags = GENL_MCAST_CAP_NET_ADMIN, },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
-- 
2.40.1


