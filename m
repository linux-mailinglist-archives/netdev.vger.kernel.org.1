Return-Path: <netdev+bounces-162661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC11A278BE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9165318871A7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2281721639D;
	Tue,  4 Feb 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G698hjjY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC3215F7A
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690683; cv=fail; b=GAAnwJfplb+UMqMe3HXhm6g/LFqmGEt5g2ad8iR5E8cGZtWCvyOqVubzltKBARVgGbXuHhv/dPNpmfMuIt26F3KwATbTpOfaas00BfZqm0+MtUvvYu36EtOAXhoCUbsDe+sMcH9a9B3DcfxvYftg7dH+YB9iDjPV6KoifHyPzXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690683; c=relaxed/simple;
	bh=h29hso7LjtJqm7twdQWuYiokaCjmH4NpaXgL1nyHi8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWnWXd393ioNy0AEPoot4GXhWNBKDCmbGiOPRDMwOc2UjdN4eKvxIxIBMIT88TzVMtNpz7SCcirH0YbEqZPXhQP5rfXmiHBI4C+HLpY8l5k3TRshMtupetXoknnZo1zrvU9LZDK8eA+UO3bEJAC6XMScEWkYEeTGychxSqwAJug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G698hjjY; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdxBEfw2kx9G1BkYvJK40fibXCLYh9+uxR5AkVxevpi/t0Lor+UGjHQGr1LUKp+u8KUrZeBBGiqN2bQbTr5d3194sDhGQ+pXl5szCQrZT17L3lTde0WmTd/RdNUBUzvYkOKjQoN/H41brL1+qxIJBc6a3c1sfU+3nsVvTjwkYS94BE3AmZM8kwgtSp3JWr2haB2nEtWx2pI48EOcTIZKZYWALKctX0Z4QvMudnCY6a52GvcGVFgGtdPpv+oC8D3klphpJ6SaEI6be53jYOSqxBY5Ht6B0KDTZMtg46U6VCQVyNZiAoyM8R8p7tAz1xMoRgLgSH2IovmYLcBKTGOsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yPWitqygITVi0DG06q79cfPdCY0BrhYVZWvhuZ4lss=;
 b=cOBsTr8eCZDeZM5X4t2rxhrtzfPN9Lwx1L+L9kjzpZRb1fGJliWNw7t14NzmHES0GteSzapvYbVGTWZge3ODd6FDozq6e1UeXvjiG3AQ17X3WNfcc2tlN5OqH3EibVsVtBcLEFPlW2hBA08jBovekxn9FrRVceVlLs32czf2GNGnn3IwQjGj7nTVu5ah/mhKQuEaggvJ8acWvIH1l+IbdKiMkHTUI0MEU0FZ1HEcAqBuTby7dGtvTpEZ4oWFHGt1y28hvVliHtvFN9cuiwie/EVDJG1r17LgOeOovxnLRpFxo4E1/6xuprP0+0G8wnCoz35sSIYrNyoeKrt4Bh+IUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yPWitqygITVi0DG06q79cfPdCY0BrhYVZWvhuZ4lss=;
 b=G698hjjYOd+fPZLtER67uRz+fwfV/Zz861EfihZqClotRR34PtF+4W9FO8vOjWN3ZSen6BejIwNRtDe0fky00iNU1onMTeVfWOS5JAsE7hEoSYn9kDThKeFTMm3FpWS/ekHf/JMrokEBGM4sZvfrkGwFAhvCt9iUPH30cK7Vn1d9j2K3ljVzHAeds/cl4wycA5d80FXZRHVuvBDvig1uH4/tbdUOXr/KwfYdVx5VGl9OgZndQjFKLy67NVLQxPUgfid9Kmaed3rpNic7lvjyf9rVOw0uc+EmJd0aI3v7V5baSySAHwjd9uJWyS78dk3afXDm8HbYT4S59gYtMuTLeQ==
Received: from PH7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::26)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 17:37:58 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::61) by PH7P222CA0006.outlook.office365.com
 (2603:10b6:510:33a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Tue,
 4 Feb 2025 17:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 17:37:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 09:37:42 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 09:37:37 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <bridge@lists.linux.dev>, <mlxsw@nvidia.com>
Subject: [PATCH net-next] bridge: mdb: Allow replace of a host-joined group
Date: Tue, 4 Feb 2025 18:37:15 +0100
Message-ID: <e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bbcc45-9724-4b84-a393-08dd4542a9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ed1XvIUx5x4ipj4sChWeDR8hV3hdAvCrL6/NsnS78A/1gTPyJrpUa4lYS92?=
 =?us-ascii?Q?eYfc0X2eG4N4sSY7C7tKcJ5f5Q0K0T2t6vz3bHldyyP5gMdGZJLZA3fptXgr?=
 =?us-ascii?Q?oTqCRswUg79oQKwdmHTae/9Ng9Y2PP8czRkNjmGrL1IPp5//CIC4VJqSLqpm?=
 =?us-ascii?Q?zL7DnsSuvc/2ALSP2ANcOkbHpkDoMFD+apgEvBrXTmi11grariCRbw5w4/Zy?=
 =?us-ascii?Q?mezFRa+g4u/a7C05mkcWhG+uy8E8rMzqPEAnQo+/b0a4aEM32AE/IxUlfjZh?=
 =?us-ascii?Q?jor5HogSbxFZ1mODidT2wT8wSlixFSPHpCOkN7VniwiuttuuZQqWxzV/h9u/?=
 =?us-ascii?Q?Eq+Jlkgrb8ItesHlMl22lXbY159TeDGg6d8co5KZijxzldrUEiYmSfkWe0Wf?=
 =?us-ascii?Q?j+MtOblNWDQ5iTrdSJwQvR6UkBO2a/t2ZVzTKNrNQ1AfchN7u7F5ppxpWGSj?=
 =?us-ascii?Q?ZJkVbzpFDljf6bTbEZrLm1UQuylfMhML4jdGDu/4ZSLrQU6yq6c79kUZqDZr?=
 =?us-ascii?Q?jqSbjq4I+4syNUkryMxGKvAEm8Y0rwth5mGxjafPPgvPEb3yjbxbG18f5pTi?=
 =?us-ascii?Q?oC6Y2DUZmwlbAfMDwn7ciI7hNLzLhzEv7UcQfYPpLkMPBWbdMtHA/ekzTFbO?=
 =?us-ascii?Q?TofiQ2iwoVtHA/2FZEj0U0ABDWtBW3z8r/WF6G/ote06tAHaL6fqwjh2G2FR?=
 =?us-ascii?Q?MnTFL3haOiNUtpJXH3mXKMGnzGrpM1571Y0VFAO2zWuM4FroFERhSdg2zRyW?=
 =?us-ascii?Q?UI7KsKkBwUZQISy1VPT0ioAqoLyzuewcRPxCtqOABRh1nC7WiDhxp/53TRrR?=
 =?us-ascii?Q?g8RIuvMR0A08PHK1qiBQGMKWXaZWuiahJE3lmccrk9lbRZzYe09z68v4VqJI?=
 =?us-ascii?Q?6KVmobyUN+7ybuTRR9N/Mr7Muy1xChk0bfjp/xiQElc/t7b8+E0/eO/OQLrW?=
 =?us-ascii?Q?w4Yk+VvVEsT+a6hHU5pGP7/Diih47K/MENvrpM+7wjlOpXSrFqDeLCKBBh4q?=
 =?us-ascii?Q?OW6PZkWGf3GmkPLQSA/oaV2V+cVGxWJv+ax2NdmaC2GEA2FSH4pffT4ccgoC?=
 =?us-ascii?Q?gN82GYb+kIfbQaGD91dIpyRtPm2S/DeLCNinIjp6EYuq7JI4ZSOyepM/CR/h?=
 =?us-ascii?Q?2QiVDQYJKkQPku9JcYUm5Y5lhHXFHq0awL9lFpeNOfdeq5rC47W6Ni8Lu3cv?=
 =?us-ascii?Q?zo92nSuFKsNhge/v+f3XhMbRGq+ZVqM6uBGDiL5kiIHvW3xDymcg/9giFhb2?=
 =?us-ascii?Q?p3Vw4dPlaXfShlmstYQkdQp2vLZUBlZ6aJBPu+ASQqgnYVTZQtyxYrud1B+t?=
 =?us-ascii?Q?fq470PCxhf6BPKv/koA2ZqiSFxaoLq/EXn5e2/NDhjYKW459j8Q/k0MwsuW8?=
 =?us-ascii?Q?xRJjS/frT6iHwXgRa6YdBkHoOnnzhOwoFt7yGz/GKVrzj95PAeeJBIhdH16s?=
 =?us-ascii?Q?TNYSk1BdRJAlKn7SiJH3jcnpCYzCIs5ipl01HYiRk545vCKrkh8eFq7ZBFlL?=
 =?us-ascii?Q?vs8vs802gZBdXbU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:37:57.6113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bbcc45-9724-4b84-a393-08dd4542a9ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

Attempts to replace an MDB group membership of the host itself are
currently bounced:

 # ip link add name br up type bridge vlan_filtering 1
 # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
 # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
 Error: bridge: Group is already joined by host.

A similar operation done on a member port would succeed. Ignore the check
for replacement of host group memberships as well.

The bit of code that this enables is br_multicast_host_join(), which, for
already-joined groups only refreshes the MC group expiration timer, which
is desirable; and a userspace notification, also desirable.

Change a selftest that exercises this code path from expecting a rejection
to expecting a pass. The rest of MDB selftests pass without modification.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c                                  | 2 +-
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 1a52a0bca086..7e1ad229e133 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1040,7 +1040,7 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 
 	/* host join */
 	if (!port) {
-		if (mp->host_joined) {
+		if (mp->host_joined && !(cfg->nlflags & NLM_F_REPLACE)) {
 			NL_SET_ERR_MSG_MOD(extack, "Group is already joined by host");
 			return -EEXIST;
 		}
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index d9d587454d20..8c1597ebc2d3 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -149,7 +149,7 @@ cfg_test_host_common()
 	check_err $? "Failed to add $name host entry"
 
 	bridge mdb replace dev br0 port br0 grp $grp $state vid 10 &> /dev/null
-	check_fail $? "Managed to replace $name host entry"
+	check_err $? "Failed to replace $name host entry"
 
 	bridge mdb del dev br0 port br0 grp $grp $state vid 10
 	bridge mdb get dev br0 grp $grp vid 10 &> /dev/null
-- 
2.47.0


