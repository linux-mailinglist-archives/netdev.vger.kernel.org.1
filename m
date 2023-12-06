Return-Path: <netdev+bounces-54626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E4807A7F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5990E1F21A34
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36B70976;
	Wed,  6 Dec 2023 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="db+AD2k6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC2098
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV2otWi5BA/Cgco7H14gsqM8c+LHwUM+izBh87E0EUe8QsmkSoBSzOBNXog9nSQv13+WGcJy8Plpfwgw9LPC0ExunStuJo6CV4i1STi2U8LMbZkjMHs3AZkV6Lsagpidf6p60BTBdJ1xpQUo108EuD/1t8EaPmpCq9X5faIrYGk8GS9oPrKYWCTsozlv8nyXFljoqWHOm/SX/Hcym3OPrC5q6WSOvwC+bBRIClETGNriuaBdeh3EyeMjBoK6f57AbJsMTeVk4J/hsuzoUrBwT0cpRxf48/NWxdpWBTwvc67KRlagD+4cQzcXwDCZ7WGs+ShYv3ziOxiI5P2cBUfTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFEKabW/l8jcC9fOGQzIFv6fjvqRD0doRDI59oS4TL0=;
 b=i7UXF12ZoTWVuZLOoKrkzBVZCOpm0gNUB9SiOakcaD5mY6hm8ckvIWZwvg6AX65Jr7RkroZ/W7fHM80rbrcesqJLBrhkJ2uzCYr1hT2GvdG73fWQrOoR3T/WaDN9/JGNJr5ueAtRJEoiNM+Y4SffvZnWivYBSJl/NfxgJCN8GFIOOGzMwimx8SgLHNQHsg7sAosuBZ2P04ApyhDfym9566IFbf2Ml4R/s/z8zKjtezHs6RNie2U+eCMI0yoxq4VVWXBSuxRiLEXQClz/3/s53SbSvQSjvju5ioWswd32wM7RKRQQ9QGy6jozyMeqQkuAQ+iCC/2iEVivq1b0ctLwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFEKabW/l8jcC9fOGQzIFv6fjvqRD0doRDI59oS4TL0=;
 b=db+AD2k6Q4Rc1zLhqjU6Jg1a7CobMBIJSNaB7xZCP3XuD7/4ifGJTbzdMuet7NrrFLpQv2V2nQirq03K+xNe54RGh5+BpNz3CCWsiVYtD9KdVabeoC0HQzzewsrczws9raBuwGGbdfFFguujfugCHJMa+g4WtYTt3cwignhFrgANx9Sf7zalbKFA/ZRGj4h15TAsvvqThNmpedE9zXTR0fTJ8b5y+17LHivauZm4GrtsH3bBvWeqPfwu4l3y/Rmx2s5Z2AMw8y9ESgqYfYX+cH/GJFhFVkoDTphI88x0dqH7ZjQJNVNvDed/QBEPiUG7s8VwC2ifdMuoOqQK/bjeVA==
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 21:33:11 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::c4) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 21:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 21:33:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 13:32:53 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 6 Dec 2023 13:32:49 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<jiri@resnulli.us>, <johannes@sipsolutions.net>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <andriy.shevchenko@linux.intel.com>, <jhs@mojatatu.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group
Date: Wed, 6 Dec 2023 23:31:02 +0200
Message-ID: <20231206213102.1824398-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206213102.1824398-1-idosch@nvidia.com>
References: <20231206213102.1824398-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 4942b99f-4de4-4dbc-bea5-08dbf6a2f23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GZxZtvtnER4JSZCMPyzS78athwsFmvJdIfz2zVMRfb7cWlb7lJpHR3NaRIAP6kvoVYiMp+x/GvF3u6DTYNCz9igfdrpf9abVe2pc9BAKQOpGCaBaDxMaLB6eDGT3pN50/+4X9eH7CX9yBz4s/LIfVQ0nxjBUAi5cIlhkBEZVffAuRCX93d1TFIqFhpobF1cgb1VknTNtvbvWrrPE49eDoRU31tczfO/x+gf2nKzdTemK8qRone+vdc+cLE5XrFbUZH2iPVDppP2Avm8EoSKhmE63UIU8KX/5dUIBxY7gp1PuJ3LKtz8xH9EYwqyS7RN1/20PkO4J/VeYTsnsTO7/cu5/V+4d6TcMFItrUTR/gyvymk7KpJZKqKJsGx/Pm4Ns2Xn/1Sm8tw/aq13+x8VEJRr9qaOaXfiimkaXoSSQ1OTHFyWVN2NSs4ATG47JsAwixpURXT61yGaP+Wy0GNGbYcULj1XZ5b1vlzJH3zkBLTX6arKCE4QS1jfyqghG+uQubf6ihfabuoypiuBm/0sjqq3KcK7WW2QnSysVA8Jknss4RTZMbET+vv04u1G+iABJsYAKc2oHkowLe4iy4ceetCf0CZwTgAjbPC8Bt7cvhWwfFJnYHwMFRM54FeZY1mFCO2hlnQkMdbnwI7Oa9EVLEy9pE22I10ORHEe6H9iV9UPk/KoVLCOihvbP+bwRUty3mJYYBZcgxF8isbjXkcEE28tIxggAlD2uo7v131BC7Ym0SPCqr/fwpcfnWOQn4YMD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(478600001)(316002)(54906003)(4326008)(86362001)(8676002)(6916009)(70586007)(8936002)(70206006)(41300700001)(36756003)(7416002)(2906002)(5660300002)(7636003)(47076005)(356005)(2616005)(16526019)(26005)(1076003)(36860700001)(6666004)(107886003)(83380400001)(82740400003)(426003)(336012)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:33:11.0762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4942b99f-4de4-4dbc-bea5-08dbf6a2f23d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

The "NET_DM" generic netlink family notifies drop locations over the
"events" multicast group. This is problematic since by default generic
netlink allows non-root users to listen to these notifications.

Fix by adding a new field to the generic netlink multicast group
structure that when set prevents non-root users or root without the
'CAP_SYS_ADMIN' capability (in the user namespace owning the network
namespace) from joining the group. Set this field for the "events"
group. Use 'CAP_SYS_ADMIN' rather than 'CAP_NET_ADMIN' because of the
nature of the information that is shared over this group.

Note that the capability check in this case will always be performed
against the initial user namespace since the family is not netns aware
and only operates in the initial network namespace.

A new field is added to the structure rather than using the "flags"
field because the existing field uses uAPI flags and it is inappropriate
to add a new uAPI flag for an internal kernel check. In net-next we can
rework the "flags" field to use internal flags and fold the new field
into it. But for now, in order to reduce the amount of changes, add a
new field.

Since the information can only be consumed by root, mark the control
plane operations that start and stop the tracing as root-only using the
'GENL_ADMIN_PERM' flag.

Tested using [1].

Before:

 # capsh -- -c ./dm_repo
 # capsh --drop=cap_sys_admin -- -c ./dm_repo

After:

 # capsh -- -c ./dm_repo
 # capsh --drop=cap_sys_admin -- -c ./dm_repo
 Failed to join "events" multicast group

[1]
 $ cat dm.c
 #include <stdio.h>
 #include <netlink/genl/ctrl.h>
 #include <netlink/genl/genl.h>
 #include <netlink/socket.h>

 int main(int argc, char **argv)
 {
 	struct nl_sock *sk;
 	int grp, err;

 	sk = nl_socket_alloc();
 	if (!sk) {
 		fprintf(stderr, "Failed to allocate socket\n");
 		return -1;
 	}

 	err = genl_connect(sk);
 	if (err) {
 		fprintf(stderr, "Failed to connect socket\n");
 		return err;
 	}

 	grp = genl_ctrl_resolve_grp(sk, "NET_DM", "events");
 	if (grp < 0) {
 		fprintf(stderr,
 			"Failed to resolve \"events\" multicast group\n");
 		return grp;
 	}

 	err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
 	if (err) {
 		fprintf(stderr, "Failed to join \"events\" multicast group\n");
 		return err;
 	}

 	return 0;
 }
 $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o dm_repo dm.c

Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementation & Netlink protocol")
Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/genetlink.h | 2 ++
 net/core/drop_monitor.c | 4 +++-
 net/netlink/genetlink.c | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e18a4c0d69ee..c53244f20437 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -12,10 +12,12 @@
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
  * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
+ * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
 	u8			flags;
+	u8			cap_sys_admin:1;
 };
 
 struct genl_split_ops;
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index aff31cd944c2..b240d9aae4a6 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -183,7 +183,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -1619,11 +1619,13 @@ static const struct genl_small_ops dropmon_ops[] = {
 		.cmd = NET_DM_CMD_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_STOP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_CONFIG_GET,
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 92ef5ed2e7b0..9c7ffd10df2a 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1691,6 +1691,9 @@ static int genl_bind(struct net *net, int group)
 		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
+		if (grp->cap_sys_admin &&
+		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
+			ret = -EPERM;
 
 		break;
 	}
-- 
2.40.1


