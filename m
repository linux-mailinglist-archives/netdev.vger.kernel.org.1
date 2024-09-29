Return-Path: <netdev+bounces-130238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F205E989562
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 14:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF3BB22F04
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0B179954;
	Sun, 29 Sep 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s8q59sSZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9816F851
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613443; cv=fail; b=bH+VTGPBg4dJW24DQgegJq7sut3xj8GW193VKzMZkUW7lPJKXfR2TGRD3YJNqkG/O0PEPcMFOuP0hFLS2S8tESMMkFb/BHkg1B2kka/s9KVvAW99qG+0HnwSuarQy6LpazK/b8p6/0hixq7XKeXqAziniYMj4Do1FTXL0q8icGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613443; c=relaxed/simple;
	bh=xozYNy1KOnOoYNTGcitbSOTfARDzOyfo94hlMMiiq/s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JNDp9bOXrQg/mcvb1FCgrkdTH5TpqRU2bmCUcMd4LWdQVKy3/+rnHc5HwcZZKpAc8eesJmnLlw5MjZSkKRv3NR2oPY9gvSu/cdA1AfUlulq28DhtBoqxX7YIV0uFGJpWQx3JH0EF/66IqEi6xloku4nfs6rTiC/MK55aMn4uvsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s8q59sSZ; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twZGJmRQr3/XcB1lOfD90k2pm7W6jQ4dvkk+zuCJztmIefh6VpRClh8Vb8udiymF3qiXcFJhfAQoH7mZeiWMwcidsJjml1zgYk7z66bP/KggHxf/qLLp9f0eLmYNg/2OFoN3RR9X/eGyxQPszFErhPtq8gNJLosakMSSRQWr5jJ8DogjHjbwNsvaKwAWAGlCP7sQFRIEuCeZWEEiXPTwESUjn0YFNe6yoSrHfpkwebaUNGVnrtJaQLQAR3GNq75y1UylVGBZnxONnmpRrNqf2RhLTyKvqd8XDxZs7kq0k2aMKP982uCoRd0iERuQWWzB6wn6yJkiNtfL0ExW7ET5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atfclzYkj5kpQWMqle75FcavfPVhXUKVByhgk4AqosA=;
 b=qUZKRaed1ChNtiJezpa5t5GB97MT96kR6KCIcKhCYRap2wdUiF5N58+gSUMfcBNU5BiWOnEK8jrg4c6EBmiqiNoB5NiAgH0ECYA09u7EFtse7L9rwGkFxPVJTfkcBP73S3U/UZPwL510xSaw+MP84/2bxBGFhVNpZ3KA3NZ0TOQZ18wYpDrSSqNJp9rxW8OujeUyBdFKUt8E5gphdsl+ax75Nh7+1s4hen5M424ezYwuWZkXB4Nzf98UusZ/Mc81IVrVEIyhlL4YYb6jHkHXbwvxamtE5BNWwnfzbFhEq8/41mBOqtnIzBR+w7WMwgqAZy0qWI7KmL15UQRge1fCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atfclzYkj5kpQWMqle75FcavfPVhXUKVByhgk4AqosA=;
 b=s8q59sSZLLX/tDVhOy95DQO6j7soSZ5jmdWYMCmhXbT07ytQviWtqYgN+tT1Dvk5QnGs/oNe81f/hpWtD7ynnvN4SFg9sWW24/oDkPJW7jn0ITaMDPC3PI/MaIsYf5MAWicx4gwiirFh8FtavCNm6dCkAyKr2mADZWhOicIXZAVQgPJ9ibPsCtGrdOfVRbpYKKZeVKgONrvAYnqBWI93Yg8SBOVgp55zTNglfibdDU7M7Q0Mjc+X2nR2DMBXgj/4HieOC7dqAOCROqBgH/JyfstexyB9E6QBGi1WfiQkmSLPtP+MUltzL6FxWpzNxB7KQxqjxyOC41KAJAKAEW6dfw==
Received: from CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Sun, 29 Sep
 2024 12:37:18 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:74:cafe::ee) by CH0PR04CA0083.outlook.office365.com
 (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Sun, 29 Sep 2024 12:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.1 via Frontend Transport; Sun, 29 Sep 2024 12:37:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Sep
 2024 05:37:08 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Sep
 2024 05:37:05 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<bridge@lists.linux.dev>, <jamie.bainbridge@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net] bridge: mcast: Fail MDB get request on empty entry
Date: Sun, 29 Sep 2024 15:36:40 +0300
Message-ID: <20240929123640.558525-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f872b1-862f-4333-baa4-08dce08374af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kS2Lvj7EiP+l77wEJBoTmfjvAMuqWIuZ8tddpBgdrCXBMdE5XbH6IA1tgrhv?=
 =?us-ascii?Q?LXNbmP3x67Pqs+Ner6xYkpD6zL3c2ZVcXxB5tFrp+tDVFrLay8dG9GL5bZxD?=
 =?us-ascii?Q?c4v94mMXpKCikzXx9jh38PzAWwTxkLmNXo2sR4mMED+GKjcTcHg6UO9mnX39?=
 =?us-ascii?Q?beRPHLo46j1UgQHCUpJhhDAkaplRC2RQTkcgrMbsE4NmdqGTjYO6smzBeAxP?=
 =?us-ascii?Q?c/HO3uvzaFG/2Q+x0men8jJWb7z6Ea7sOo+DcDb9aYRegNZeR6ti94TAbkiJ?=
 =?us-ascii?Q?uygIy58D5Ozko5vcUjjB+obvtpu/TPgOP/YndLUeTJiHx7zs5DiwdrTll22a?=
 =?us-ascii?Q?xHOcCmPw7UhsTdlrxbpEQE9GW2r0MvJKjW9o5tPp1JKGsLcvQ0Gsw8xu0Zw2?=
 =?us-ascii?Q?jdjBLYGndcS2zxISo1YIkVZVukbQ1EAoHEqRtuzfA3Nh3DOJ5JXIXoUFoGXn?=
 =?us-ascii?Q?9oHeiPm0uEaW9IdUkXtPzgxeVz6WhTObDdp085zoBRO5sGGv0bZheFNYvc8O?=
 =?us-ascii?Q?phLfbpIkhfRKlvKl7iUXIGF9S+skbd+sxPBHTnxzjL81PDKEeaMva+uxE+hb?=
 =?us-ascii?Q?8CcSyKnS3lnRQVYhHZ62m1dqxai0mekExtHhQMOXxVAvykhpskoV64QhlQtn?=
 =?us-ascii?Q?eVKx4g8bJX6zDRuBoGTORmVod+pAG9cHfWhQcK60mzfJjBbNiZxAmoPYY+Pp?=
 =?us-ascii?Q?dDrD5f+DzaTLIwGRKaDlxhM4sYNrSAGenxIWmpqNVFgwnEJft+JPx16bYT/O?=
 =?us-ascii?Q?CxBEJbXPF6jkjN/8BTT77pwKqskUvAN1+DZ2c89/arybByXWJqX9oFWTSMBx?=
 =?us-ascii?Q?NrwmFii/8erDG/vQdKP3EOeEemrrD0LbQD1RUlQr7KfVw9nvF+8ebL9Hx0VJ?=
 =?us-ascii?Q?X+S7GXwK4TWTkmHS2mMGQDtkucfh6Z3OVD9BKrRsg9M/B08ot2ws+bx/YSkK?=
 =?us-ascii?Q?u2pr5cXN7tU+pjCGRTRwYmX10u0hSZbogxpqabaNYtC5sWD3s3DVXlQILWYE?=
 =?us-ascii?Q?I4tUdw6wxwENTFcEnvCGfe775hgyub9jYx7+uqTscoVYaKmKWM328LknS5Nt?=
 =?us-ascii?Q?fnmPre+oSoCSOuDpK4Q/eihWBDvZK1M6wJrBw0YR8OfGLH+vGsnKAUJ7rfsA?=
 =?us-ascii?Q?v5YSoNJwLoe00Xp7IjfyyJH2fk3kADvJf+V30KcUoFC2GcP86fLMvTL5iT1R?=
 =?us-ascii?Q?ai2zcFRshbdLbRw73M4di3tNb9lqyFK+u5ZxKmHoo9ZDg8NG1WVWOWt5LP0v?=
 =?us-ascii?Q?wwqf1vug95Tz/RRUVS+ITQsyazl6M0DQGjQBvkzicH+oLTTDH++//mc/HG5o?=
 =?us-ascii?Q?J/QQ3ldbXju74v0o5PPhQG467GZ62rXIDa/Y7fxi4WqU/oLJPS2TmFP7Ox58?=
 =?us-ascii?Q?7EW/Uvri3eC0Y3I1acDdPhi65Y+X?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 12:37:18.0121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f872b1-862f-4333-baa4-08dce08374af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923

When user space deletes a port from an MDB entry, the port is removed
synchronously. If this was the last port in the entry and the entry is
not joined by the host itself, then the entry is scheduled for deletion
via a timer.

The above means that it is possible for the MDB get netlink request to
retrieve an empty entry which is scheduled for deletion. This is
problematic as after deleting the last port in an entry, user space
cannot rely on a non-zero return code from the MDB get request as an
indication that the port was successfully removed.

Fix by returning an error when the entry's port list is empty and the
entry is not joined by the host.

Fixes: 68b380a395a7 ("bridge: mcast: Add MDB get support")
Reported-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Closes: https://lore.kernel.org/netdev/c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com/
Tested-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index bc37e47ad829..1a52a0bca086 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1674,7 +1674,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
 	spin_lock_bh(&br->multicast_lock);
 
 	mp = br_mdb_ip_get(br, &group);
-	if (!mp) {
+	if (!mp || (!mp->ports && !mp->host_joined)) {
 		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
 		err = -ENOENT;
 		goto unlock;
-- 
2.46.1


