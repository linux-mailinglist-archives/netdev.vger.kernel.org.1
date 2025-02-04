Return-Path: <netdev+bounces-162597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08357A274EC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0D31882869
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80F2139B6;
	Tue,  4 Feb 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVpPXkUN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB22139DC
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680997; cv=fail; b=p1Tf6wI5nQt66y9vWTMONSP9Lm/1vIeTL9hEl9CgaXT3aLnJm0WL0tLoX8b8aSGVhVkJRNcS4CQ2FGwj33jXTfmaQas7mYRml4OQvo3wSPoUzTTnAQygm4A2fUuaOTurRECLhTsJqokEN/BJN3avdxkTm4qcTgJ8yynYpoyWXyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680997; c=relaxed/simple;
	bh=cVwv1ulMFKFnjpBykI94qljcd4qWtTq/A98Icn35O4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VaBynnOLckrJEmVd+WG9dSYyMBMKtpe7t/0d/G6v8NQ+ohs/7xIIt3jeUiF2xYeympYnLHxiJYkjb6U0lbK042Uk3s+PnhvEnDqCBAGeUXiW1U3axB74SZFT8mbxjmUzDAMU4SzOoWDsMGF6JiqVy3uw4bw4Q51b+uZcT/5Uafk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVpPXkUN; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lwj5KSIEjX9zS/kvxfgXrdGbt6h6bU3IAo8xtaz9hcarECzY4Hc/dNqhQ8IRI+4J3aZ80aRAXyH34rrSMSeJ3tLQXA9SIhRgXO4pn0AakZMsMmNiKOCimieDikPW13+7eWeF5Z0Y0raodyBlok3goHpcTBOOpL0zerBRmnvpkcUNJkpF3ifDP+oh+pIyumWoLvG2yLNMS847MFLz3mjUjXjGUhxj3eHaHWQQ83BnrwD/97Vf+O172e/tKXOZH2rVEK1T180lQhyuW/dbDDXNDEJe9uAxx7Io7CU+HMYzdE8HmuLYm9LOcdJmHAy/VaP8yvKOWIUP18WWjknYnlGmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65n93jbNtVZO11HPWKoBu7LkVWYa/OMjF0Q0zFFkwhw=;
 b=i5gx3ljsbRLez9LP/ibZ8MlA+w2QCKf6tVdaXjwFSjyxVQzwvCoK2ROxjvk9WC2dtAHXP0vumfeXwriTPgH/9rl7bQauKwwbZuVxBbxKVb1SmYqfdY2RZnHGVioyLrJu+Li7iS+Z009w+7WtCUd5F6HM8CZhkHFNTEfxMC4bqr2sGEAo5nyWKAEgbieicxF6s0wUubPWh6L8tOjsRGfzxnDdB6yGw82Q3wfpnFtrXXez3TI2aT9emhnI2X4gvzvJnUVxdw9vtx+YgR+0ZWr9MNbI5n6i4vIpmTfVJEYQq0unXcFTGRl/H93KMURnmLL1OkKTSDGJ0h8mkxQ51i9meA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65n93jbNtVZO11HPWKoBu7LkVWYa/OMjF0Q0zFFkwhw=;
 b=UVpPXkUN6BVFYcuKBq2Nzk+rT+MdmXv+mjTabACBovc8aTPM4cZ6nZP3CtsN9GSD1tAlr/KL+G6NZ+0J/ZFZRiKRu8nDYIPSazcpAS8bZInFJSOeQXChswkEWRSIXIVWJ/LvXDsmWrcCc9TUfu7p2N37QbOAQCfLkHLHXs1tlPYnArf7j0aQ9eLZHY1R922KUcdtP6An2Ne407Cur0PcwX/MAgW3hIPJZ0J0wktoBHMr+K9yNOA4Un1dyQvYIRYwV+kVkrKXfpaHitng6WeUjRS6PNCIBbkOeR0jNaSQ9S1vjPO5nRh5iQNhqOGioCjDPuP1R8MR1zZx4psE5luU5g==
Received: from PH7P220CA0178.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::17)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 14:56:32 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::b) by PH7P220CA0178.outlook.office365.com
 (2603:10b6:510:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 14:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 14:56:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:11 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:08 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/8] vxlan: Age FDB entries based on Rx traffic
Date: Tue, 4 Feb 2025 16:55:41 +0200
Message-ID: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: a73fae02-2e00-4b4d-1e1d-08dd452c1c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6sc4wb0EQHHNcDX2yCW1Eg6R6SonluJ0/rV9y6sEJygldRqPNcr8B5u0jmz?=
 =?us-ascii?Q?3yBDt6dA2uaf/c2rFEjqP07bawskTvxI2q9AWRxLLzF2OugPZPpq2qjm6qCn?=
 =?us-ascii?Q?J1PQiSx9nyTA3PLF6OFcfUFlasT8pEie4A5p76F5IgW4+VnaJugxzYqGeVTV?=
 =?us-ascii?Q?DWoNumfDdWkguB6hThxta9T0yQMHLyn3LVIj3k97jQLXWIr2emwyM+OnYuKC?=
 =?us-ascii?Q?0lhG6AdjO2H6e8BXcv4A/Ovh+r2xPZKtg6GLejMaYpPZOTTsspwCsb9diqm9?=
 =?us-ascii?Q?qwKgXs4bqFxfI7Gk2G4ozXs9VzIaQ+DyyWTySaOA9Nb9djAPZy8yC2lvxD/l?=
 =?us-ascii?Q?qadevokmUR7aYtLOabWfX2C5/dtbQWbCXSDyBu1wk3CtAK4iNf8Z5la7G9RA?=
 =?us-ascii?Q?YB3M2H5uxh5nAKKsIVEeDCyB/TwHvBwnkwuf1nhH2TWHNn3n0y4/oDtYJCIj?=
 =?us-ascii?Q?rEe35TVo2muwEwZEaFme5e5lZZsTzUyQI6AxOuBIifliL57SKRhKXD2AjoiI?=
 =?us-ascii?Q?HByp1jxOfb4w69cmQ6YNwrjv/vrUMRN//wE18pKZ7iKAyJ7xpthtbv13MEDe?=
 =?us-ascii?Q?SU1Gmzz8jaIRUzUUFQEqdacJUDnfrE+nNw73taiRsoK5nAAIvme49H2dkYPh?=
 =?us-ascii?Q?koxMkoCfTKrWOm4y1LnsytVNXRGpOYyxEmk5wUmvj3MER/aCpdeeN6KtrVlE?=
 =?us-ascii?Q?ZFuXq+jvQHBB+UZ06CYWBagEcUc/3TFAYDUiWaaK5cQ5McPfWtL6dq/ORxpd?=
 =?us-ascii?Q?okio3UTkVFp0yt8Y1SXMSTdkAMBa4NsX9u0iLFedgRBx3PD8Xkq5eIWExtjr?=
 =?us-ascii?Q?kN3vHWbpnSAIKBrNW+iBRPNiSyZm/UJiR9X5mhO/Xm3NqauybQsPr6wz6bdZ?=
 =?us-ascii?Q?BNQedD7yu672AbgxhrYDX+jnXK4y+hOdwSZAvyf5NM/rzQMUlGs56C6tyllj?=
 =?us-ascii?Q?U31fVVBVx+8xwZ3zR2UMqAyzF89DvV0sWzPthtBZPIDvvqAGKT9hv6AmaxrY?=
 =?us-ascii?Q?QHr30tLrfdAp5DTxfhLp45ptNGthjDI1rIep1q8LaohBTQ3trQTXUkABME14?=
 =?us-ascii?Q?uFtVoxMnDjjOCT3aSI5KidDA3xvzC2zQ06skm8XJcq0Et2mgujfJPRc4FCA/?=
 =?us-ascii?Q?NjWp9LgrsfsVfIPXPwropLywI9Zwg3XH7SeS29PUrdEpfylM0PrdzefW0eVl?=
 =?us-ascii?Q?GCvkiwf6IiSEDP+alhhvhzKU1cTNhMdafDobSWbJuByv4nqRo3y5Z9tjj2WH?=
 =?us-ascii?Q?odfxDWKV6VDSh7mUbD89HhaKkBCOz87Pofk9XGeBZQ9PLuaCxsiwFRTpueb/?=
 =?us-ascii?Q?1zTfrBpa9lgFhyUeQgiLP/ehnzeQUjZjiPcSgbGouZE3e9uz8O6ggaeM/bPI?=
 =?us-ascii?Q?BD5RNz69mdqTUn3jl9ac4eUVsV9FTMelQgjw8VmDzM3zqmcB9nfmIg1gKfwJ?=
 =?us-ascii?Q?gIKInFZyRcia4kizgrZaun944Rb7DTJM3EtsfQNB3eShmqhDj5mQx21sDxnO?=
 =?us-ascii?Q?cTyZMKUs8FCKkxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:56:31.4355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a73fae02-2e00-4b4d-1e1d-08dd452c1c7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

tl;dr - This patchset prevents VXLAN FDB entries from lingering if
traffic is only forwarded to a silent host.

The VXLAN driver maintains two timestamps for each FDB entry: 'used' and
'updated'. The first is refreshed by both the Rx and Tx paths and the
second is refreshed upon migration.

The driver ages out entries according to their 'used' time which means
that an entry can linger when traffic is only forwarded to a silent host
that might have migrated to a different remote.

This patchset solves the problem by adjusting the above semantics and
aligning them to those of the bridge driver. That is, 'used' time is
refreshed by the Tx path, 'updated' time is refresh by Rx path or user
space updates and entries are aged out according to their 'updated'
time.

Patches #1-#2 perform small changes in how the 'used' and 'updated'
fields are accessed.

Patches #3-#5 refresh the 'updated' time where needed.

Patch #6 flips the driver to age out FDB entries according to their
'updated' time.

Patch #7 removes unnecessary updates to the 'used' time.

Patch #8 extends a test case to cover aging of FDB entries in the
presence of Tx traffic.

Ido Schimmel (8):
  vxlan: Annotate FDB data races
  vxlan: Read jiffies once when updating FDB 'used' time
  vxlan: Always refresh FDB 'updated' time when learning is enabled
  vxlan: Refresh FDB 'updated' time upon 'NTF_USE'
  vxlan: Refresh FDB 'updated' time upon user space updates
  vxlan: Age out FDB entries based on 'updated' time
  vxlan: Avoid unnecessary updates to FDB 'used' time
  selftests: forwarding: vxlan_bridge_1d: Check aging while forwarding

 drivers/net/vxlan/vxlan_core.c                | 32 +++++++++++--------
 .../net/forwarding/vxlan_bridge_1d.sh         |  2 ++
 2 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.48.1


