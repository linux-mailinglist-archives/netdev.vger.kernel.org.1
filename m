Return-Path: <netdev+bounces-58316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D497E815DE9
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0711F220EE
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26251859;
	Sun, 17 Dec 2023 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H3xWSZ3x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867B1849
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2qQ/4jraMB2JT1CrnuLPB47KVXZhK/LPsWume9vfmb9ytea9Dtb9Z1o15N0G+zw+6Yr/s5Gy9BWtkgNZ59P/88cbN7HHtJgb55AeTiLXSSQPZWgMQHQSfK60cou22lI2Po6Prgl7tMzW6ZOi9xb3lx5cMNZ8kGfI/wiK6oycG6usVH3/WMdTFSgyFVbBIJpepQpHQeldJfdcgSsVZXIUdtUcEFpauU6VTACn+OC3fvMxoSBZRD2kOzzQCDrECfdqt4KZv+AakXCYZvqH+TqWAVKa8qgBgsoj6OTzJYZt2QCFfnf04rmP4KFA5FWAV7d6pKy7VAIqcnALiR+TN8s8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDsXfMXDjZqY5zGftlNo5jn8l288IWLcmql9Jb0eMLE=;
 b=h+Ow7yZrisAV3Vg0KDCKoVrTn7AJiYT+ypiHEhwTaAHUvvnTyUCWvZiYpVxiJtb0RIpZBsqe+CDHQtwbMLf0VmK7OyaLaz3vV9XNoQRKecg6591t+6/gz8iC1W8SwUjwfxbIN8oxDx9SILMzMldXkrtwjSasH1V7Edxaq/GhRpTwGQlZyIj16KjE6mKwj48RMXFB236ATYJWYijP/BXjj5imGYgs00swDDFqozQFAZ4GzYg2nKdsrYe0c4+RV2+qK9ir83RO7rK75Tr28fBeq3XzvrBT+exSrfmVI6hZwdycchtJtAfByOV2Cl1Wm1UUQyT2uX/bxvorJXFkHsxNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDsXfMXDjZqY5zGftlNo5jn8l288IWLcmql9Jb0eMLE=;
 b=H3xWSZ3xkXXPFVAHUJGqsew8iUUU2tNNyCzPlipa6GiE7gCdQpHNrfMeAyFtzeGRVRgpji/ipycSQwQ2AvImVT8HLNk+o0HxNFxHy91OY/1fglYjjDomVnJmolZ161ydiMGbTbJ1DEeGT4Bzy5yPcz2SdLb1i0DVAf+CLlZYq4Yrat9X75BZxlb/EFueYq+8+XXsBpCFDgNHufVxHPI3rsOKLHAfv7yU0F0ZBRMglFEH4KTaQzlnaViLRB9AhB6eC9kYWw5wunkFFV3Wajez0aSKlKr7XOxuJCOdgTO4LvNbf8fq2ihyQKQlM9WIl6KjIw2oFXiPDKUkZ69Z2eQQnA==
Received: from BL0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:2d::16)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 07:54:37 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2d:cafe::44) by BL0PR03CA0003.outlook.office365.com
 (2603:10b6:208:2d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sun, 17 Dec 2023 07:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 07:54:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 16 Dec
 2023 23:54:27 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 16 Dec 2023 23:54:23 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <matttbe@kernel.org>,
	<martineau@kernel.org>, <yotam.gi@gmail.com>, <jiri@resnulli.us>,
	<jacob.e.keller@intel.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <fw@strlen.de>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next] genetlink: Use internal flags for multicast groups
Date: Sun, 17 Dec 2023 09:53:48 +0200
Message-ID: <20231217075348.4040051-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 208f091c-cae9-41be-7840-08dbfed56a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kqxxVGz8dnnPhTHcg4O3s+H4ftWlzHYYDmKZbfuRNiRGmVMKiwe2gnAoW70tf7AZkcjL0Pefml9JJYnnSKG2EJ/dfTdawWZOTSxT60UKFY6I3l4vuAOclVekTLnNDCStyt/BnsbAKUjtd8yyefIAIy7JUKTOC8P64HzzI4TU/4xzTdqTsNsOPryo5PEWqEb4P2s0kWIpMGvMCzUm99kprWjyoRHJ4Msj5botbQTp8y/2eofhoadEUHwIqZNCzYLVQkWsDvoGF0mjqAsybWcPQDnrqQHjDatL5f/4l9qi59TsvjD+2uZ/CKNu4pndA6n2s13wSwLg4KfQcF6LOsScd2C/gVsS/XDmLjKEHdE58Ycnd49MU9nIavAFip3qZ8fZX/OsdbhXNsZpt3TcNzc+pSv7oOcokZ0RAXgHdtYj3hi1FiQuy+iJUMcclOBclk1zaPbnYjnFP2DKrro7sYgxR2+Eh3ASGIuEwM3UE73N8ZOdHTE13DHL8P3Tb5VKTqnHcZbap1WK/b59VfP55crS76qQ8MabG88idmjJPzi1K37lMxj9+p+foFr3z4M3pVnuKwgVTEviUjqBYi+gqmI5LjwFnjZwBQhmkVTrh7mxxyYqwvpU7tl+YPGy1DxPewmID8byBxBkT8aHg+RWE0m06JUbwSjErd8aeFiPK0TwPwNZPDWNQEHgb8w5byTCepUpWEpHNTm7eTb0LEEslnOEsoj5O+CI0zP85EC7HPQ4zshIra7Q8X4NxJErRQupfn5w
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(7416002)(5660300002)(41300700001)(36756003)(86362001)(356005)(82740400003)(7636003)(426003)(336012)(16526019)(26005)(1076003)(40480700001)(107886003)(2616005)(83380400001)(110136005)(478600001)(54906003)(316002)(70586007)(70206006)(6666004)(40460700003)(4326008)(8676002)(8936002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 07:54:36.2528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208f091c-cae9-41be-7840-08dbfed56a16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234

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
 include/net/genetlink.h | 7 ++++---
 net/core/drop_monitor.c | 2 +-
 net/mptcp/pm_netlink.c  | 2 +-
 net/netlink/genetlink.c | 4 ++--
 net/psample/psample.c   | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index c53244f20437..5a402fd24817 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -8,16 +8,17 @@
 
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 
+#define GENL_MCAST_CAP_NET_ADMIN	BIT(0)
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
index 9c7ffd10df2a..f6d14c092d24 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1688,10 +1688,10 @@ static int genl_bind(struct net *net, int group)
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


