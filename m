Return-Path: <netdev+bounces-54625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC2D807A7E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702901F219E0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EAF7097C;
	Wed,  6 Dec 2023 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lcXLp4jv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF0F98
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:33:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeTOvplPZmj1ExOBUNHOIrw4gqywHkn5vV95wYLmCyQcJ47df9P7U/tqJDbVaiapipFveDqshZwPpJP0IGsLiGb0wTuxkS18wm8S5jctNdk91I5iIl50yEVwQXtx6BQZo8n0s5IBD39ze5nI0hnSuMFkkayK//cJXhUPjPglmuzbXfdBlJ2YGdxATNxHDe2CkdwiyfxfP6y5Vk36sBGRU9juP/1OkWtzaC2yw9on1VjfJEav25mKsdTiLZ09O8Ey9koJ9D7KmcuoWJ6QdqbCsJEbHss7LkLKsSoReuPa9MhwfwQKnNsBNxYFVyfoMFNyrvHX01HOBe8AEH69hcFYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpltNUfiRSYn3yCB40SK7CBFhX3Nn1WoG7RPVepVuk0=;
 b=KnQooIc2voEtUOnit2Ode6v0rfp/zDGfOWuu2204Oh53zAoXjnreAwCQhgiTdbx6zdRIJZveEomC+dVTF0JW7Jbr+NeNWdu3j4163+KorVQ8R2pm+GOEY1yDWCkd5+QIe3PiM/sjshPrWbVyq3xVtVn8mUjinG5Rcu2PSvzlSZQUTPh14U0mZvcvPCsEzMQIpVHwAIGcwHRJzueQDlb9gY5Cq81vp+NovQUFaurH8Oil50dx6QIdA/6sR6YxcuPhXDQHlp9+WzhsWH8KuTrHxWPZjXWkhUuwG6ZHmRsJSGnS00UpqM8d5m60ikIMt++2YxXkPeEh1agO/cqQO7wqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpltNUfiRSYn3yCB40SK7CBFhX3Nn1WoG7RPVepVuk0=;
 b=lcXLp4jv2rhGwXrJnPhDPLRxO6FtvuPU4b6mSViHNcvx/1m+uZmdEZ2ULfHoKbi1BY1HEeUbyHvxJgFLf7KSU1XnmqQKok4FJ7BBRMdX6DQVMH3NF5F7jxFPyHFT3gEwdWGyKKWvdphoxsnvPIYKwO8CQcvW7CFShMTzpC5e0x/RipOdoGUyXnRQSPbJt6ekYrVmgX3iH/aLGWgB7W6v2yCINsx2qJHBhiDcLC8jDzfx1etDaoSN9ISX2E2xESGiP4+15LLrxMtqE0uWat1nBSyPQrwcCM3K/0dAvQplPbx3gFPYfC5CSePZ2B6md031AZRJ+oUISn6KLdAZBEuLsA==
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 21:33:07 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::bf) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 21:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 21:33:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 13:32:49 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 6 Dec 2023 13:32:45 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<jiri@resnulli.us>, <johannes@sipsolutions.net>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <andriy.shevchenko@linux.intel.com>, <jhs@mojatatu.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] psample: Require 'CAP_NET_ADMIN' when joining "packets" group
Date: Wed, 6 Dec 2023 23:31:01 +0200
Message-ID: <20231206213102.1824398-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 273c4bd1-5fb8-4a1c-ee20-08dbf6a2efe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GBNsJEgqrIlXJyYx2Wvf1qUxnIGL3N05jTS3OWw7odGaqrkEy7uN2TcrB1RlTm/SSea9g+sE8fHKFsuNyiVugxJ9rEeiYMNRTdkG4HDwCY7itkXVh47yVMGBm6Rh09wTGZz+Viytr3ksa06qKJDb/Bx8AfSFJnzicvTrwOQ2QukJPpmj0SiVDFkEDhdnPa4QZJ9y/u5ME3pdwTlLNozQ3sY22M2abqrVlanGJnT9e7fNh3tdXOrzkvBi8wSniVeuIT1kph1jnAJvTFdc6V+IRn7azSsw3u8THlx78bWAS0GiSJBQvGE5B9Cj/aJdupOMJUfr5HSrFea24hK58J9rlAf6YtuNYDtab4KM2tFJcWy8raWHcQixLM2v4PAcJ5SFgz1TeEDIV4MWdUPUK7U2U+NnUhFNlgbdJIZ3YGkWpn/4w/vptj7kh+96GhQihH28sj33FctheO7lCKrFjVPu+YVwihfUgeFPnrvEW7/c9cmpD0Pgoz5NEqfmfSiecx9r2xCA+hoCN3m1ac+5EjKs7+13uesWcejB2C0rZ1OVP1sYfDRn0czNN9mLFRF3MTRs0+VlJZ6LrftJkL4sUaPEmVr3skLy9XmKrkl0VAqnOIwgpPVTT74VcL4IiN1Ih6eueOf5gTR3dlnBe0SChK0+wF7obmuVFpsMJpTCY8wMH1JoN4z0zQK95XsxtXnMU5eQBsRnExOJp8mw7IZ4Uk+Aq9yJpaW9GBq+ttAWQuHDJTyYt4n80kYwelLxNfmOzU0I
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(82740400003)(41300700001)(86362001)(7636003)(356005)(40460700003)(36860700001)(47076005)(83380400001)(426003)(336012)(107886003)(1076003)(2616005)(36756003)(2906002)(6666004)(8936002)(8676002)(7416002)(478600001)(316002)(54906003)(26005)(16526019)(4326008)(70586007)(5660300002)(70206006)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:33:07.1387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273c4bd1-5fb8-4a1c-ee20-08dbf6a2efe4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021

The "psample" generic netlink family notifies sampled packets over the
"packets" multicast group. This is problematic since by default generic
netlink allows non-root users to listen to these notifications.

Fix by marking the group with the 'GENL_UNS_ADMIN_PERM' flag. This will
prevent non-root users or root without the 'CAP_NET_ADMIN' capability
(in the user namespace owning the network namespace) from joining the
group.

Tested using [1].

Before:

 # capsh -- -c ./psample_repo
 # capsh --drop=cap_net_admin -- -c ./psample_repo

After:

 # capsh -- -c ./psample_repo
 # capsh --drop=cap_net_admin -- -c ./psample_repo
 Failed to join "packets" multicast group

[1]
 $ cat psample.c
 #include <stdio.h>
 #include <netlink/genl/ctrl.h>
 #include <netlink/genl/genl.h>
 #include <netlink/socket.h>

 int join_grp(struct nl_sock *sk, const char *grp_name)
 {
 	int grp, err;

 	grp = genl_ctrl_resolve_grp(sk, "psample", grp_name);
 	if (grp < 0) {
 		fprintf(stderr, "Failed to resolve \"%s\" multicast group\n",
 			grp_name);
 		return grp;
 	}

 	err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
 	if (err) {
 		fprintf(stderr, "Failed to join \"%s\" multicast group\n",
 			grp_name);
 		return err;
 	}

 	return 0;
 }

 int main(int argc, char **argv)
 {
 	struct nl_sock *sk;
 	int err;

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

 	err = join_grp(sk, "config");
 	if (err)
 		return err;

 	err = join_grp(sk, "packets");
 	if (err)
 		return err;

 	return 0;
 }
 $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o psample_repo psample.c

Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/psample/psample.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 81a794e36f53..c34e902855db 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -31,7 +31,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
-- 
2.40.1


