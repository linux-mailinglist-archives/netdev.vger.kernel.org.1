Return-Path: <netdev+bounces-169361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB51A43921
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08153BD5D3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CB26658B;
	Tue, 25 Feb 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RkR3rzEb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB25241696
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474659; cv=fail; b=Lb9ct+fQkFL1dVUEWXSQH7dE6kY7M4Bg8FSWXCkIBLFEVIbOWMI8wNwq1TLMKfXew+q4ep6BPhIBx7Tkb56ndobxxTF8c8D2fdLuIa79AErA+HYkjvpXolcIMRIAKe0f9UdNmNmT9ad11Kr61MNYhWWkk6rD2g9jT+IECk6jbU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474659; c=relaxed/simple;
	bh=t2TLS5+Cc6Uqq4Pa0MJ7mOFR0Bl69VBYUOPAukcnaZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rIL8WwiFgb9CU5QQUhjABo/un1PBLruuBSe6eUokOOtNr99qJj2KgYxXfLAV3UD88rgffuAHp7IR6xfxNKpInkZEwKVj+V373wM+WW3PziWcEfHmzWFI1L431XAs+6TVfQbmd7zytZR3qaIXf5SEyVrBjPRbKHdpIcCavE6z92w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RkR3rzEb; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsIuzLPM9qO2mXsrvtN+zZedBUt5/b47Ti3JVyYGDmG2WUn/ISurdCrWRWuvdIhqIDBw/Q5YDn3QW3qD+3kceSJjhvtKFHgxjEWSUe9FXPq9hlXTBg5N4V9CsjNxb2NHHgaJ95aJgLAlS6fVsFo+XsfcZAXqci4bu7NSnSmNRvooBtbZFsNNSueQf9OHrlGJb2GCd/CFJCXPS+7H7BgLxwPqql6x0rRF8sFPvy8TBlWzzj0DAXmK4X396UzbX7mA5PZ0L45OcpakLHmKef4x5zT3vaU7sGoInlKn7QwKmsk4SYvfKzXxiitHgPjEvawAIax+F/3VSbVgysItJnsyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu3zTYg8Llf+dc+eJ69dbpWHbiYkK3w5Bv/eeuZJKdA=;
 b=j6Zk5iZm8nrTDlLZP4bTDqdCxTyakdWUQpvS9GVEx9531+W7w6WMXmBwv2ROJyqfZ4tt2sFygew9eDIp6LrYv6nqIraSTk++KjvZ5iSnZwiVKjDTk+c0Mc2FywXJhwHMqjvRvEtTUljay5kDmZi8SEwOu03cUqX7mMFD82u37CO+XiBMeROwK1if3ZRRFd9oMXotRcofMzFfaTZysWs4EIgaBZnZpEpwbk3YfL+wW2Z8qghYJM+Xizh5O3Otdcyzjj32uWxvkL6EFPgxYxAaPYhqo9q4Fqye6ydxYFtASIawVJw5+8ecGrsPVJrG0dJmfITlJzZlmpkzMPP9h3Gvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu3zTYg8Llf+dc+eJ69dbpWHbiYkK3w5Bv/eeuZJKdA=;
 b=RkR3rzEb3BEkbNjt9lMSQm0dZo8cm4MfVa+HQ5Gt1ogMpKLXLGBwRNl+n+AfEJ+I4Hb+xsHRwtCPLLQOjBvzzylRTYtRveAopdaoxWqipL+sfu7mrLmEryGV8jYXnanNOZfSgRZgEGMQ4pzbOhBtG0pBq4m5+RwAwGpLu68tkQMkX3fj72+4Qxe0FJi4exGgcBeimYxStOOciACbXYhd598hL6+psgEPbymCFPiMCOuX7s8sp9xxNheureQw+YSilYJLSE9MKI8j4bkbOxVvV6JDNLYsVVyMXYVsonAOy9NDvBGHkHH1nwc0NNwRCMszMQh4KAfN8BIexLLCN+oCPg==
Received: from BL1PR13CA0395.namprd13.prod.outlook.com (2603:10b6:208:2c2::10)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:10:53 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::45) by BL1PR13CA0395.outlook.office365.com
 (2603:10b6:208:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 09:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:10:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:10:38 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:10:35 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 0/5] iprule: Add mask support for L4 ports and DSCP
Date: Tue, 25 Feb 2025 11:09:12 +0200
Message-ID: <20250225090917.499376-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: cb98f785-2486-462a-0c2a-08dd557c4e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PNbTnWKStETRreAq/PBgYsox+Hy6UyS5klfzk0o//b3gbevMDw2jKZX6fzu9?=
 =?us-ascii?Q?e65uQJwZPi4IaQTLeL4utJyYOmMmNBrKV+IYGyaxrCnx4feTRVDZPbY96til?=
 =?us-ascii?Q?mB9QUEcNlXVkj1gAOIAY8zGXBXq+rxDJP6w3HmE33ZkJBw/aXUMH1J8IwMNA?=
 =?us-ascii?Q?mGFGbLZMgZqV3fxddn8iu3gY4bGsqOpIVVSB/KXPSIRTFURxXo7kC91vs/Xv?=
 =?us-ascii?Q?LWql13y1jEEvKhHu54qttDuvQ51OY1Xn/HeOUNluKYjjnVap8U4TYReRe8An?=
 =?us-ascii?Q?sWbN/oEIOcNoa9WtdjKzH2mkv2GE5Z4Eq8hETwSjIvbzrBhQCQf1kBRHXzHn?=
 =?us-ascii?Q?4ZbERd4WjvyRmGzWERrpWzh5Jov0P+Y1g7tKs/TwZvSlIdngHIYenyvqNAHC?=
 =?us-ascii?Q?IZqEIRQtnwEmGVZ/Q8DIGHm32oSyHMBc9xyh1s9lYDL4xAP9Z8MWJg24ZiHG?=
 =?us-ascii?Q?5H4vHwL4NvtN2A5eq+GtXi2nShD6miukwIhl9c/wR85ZTLBEd0bPNKr8cEuZ?=
 =?us-ascii?Q?yqh03woEx0GgbAqYbqhvDvA3VXbDZysRuT6pD1RNjzTKvDdIPIhbq3osHW2z?=
 =?us-ascii?Q?oWzTe39Q7ip5BZSTq8Bo0as0XiuQz3Ch7JTknaioBXT2Clb84RIPfzmZL/lZ?=
 =?us-ascii?Q?xVJ1NWgSkXm14MkYc4hC+jDYJIoemrqJdo8S8uYUABfCROp7ja8o+2jFGGFT?=
 =?us-ascii?Q?/qOy5VmQRdmdLPfjsqZqTYBlwdYFVWL44vYFDdZPwF87jyeKxkZlnHtbw5yS?=
 =?us-ascii?Q?TIkX0jAa/lnu0t9+GTC6Phnxf34lHPXNfleF+3wPOq9oGGuGL0uCylWIZtCu?=
 =?us-ascii?Q?2qR50P5EoNFHpaVNGE5utPKj+xy5yNHFKRuZY9bSwgpqKo3wU81tK3S/k0Nv?=
 =?us-ascii?Q?fcgVuhYB3+00sr1PT+loKfb7BUUy8znqkZqy0bvoBrmnho48Ur0VYoxb9RaO?=
 =?us-ascii?Q?oyYxJq4tZevsJ+OdbTV7zkavGpG+XXUI9m4nztAnEvPU9Dlb0nNM10VEziUM?=
 =?us-ascii?Q?KqtnZ+v5utfBq3OkSwQYFqjQh5e53Cfo3+d2YdmSANwYoLvYuAn9G3viL2qB?=
 =?us-ascii?Q?gAXD+RwDrBp281xXp77416+7AZFcyx5SrnRcwhBBgTZ5s1Ih9XCIuQ10P5Xa?=
 =?us-ascii?Q?L2IBqwBiwIpGH29TPaESHlZX38XCDC0xkqVYVjDEeOJqlr7ws2Pzd6+RyUAC?=
 =?us-ascii?Q?tgOCUOBhoWEXuxQQ4FnFYu5SVmElZfokTe8PIcKpCV19hE+jUGQw0AUeNiXJ?=
 =?us-ascii?Q?PmRFN8DIDLgfjHI9fvqVfkQzndroxIqzICD1gbjZzEtPhm20gTyIwamsoKsH?=
 =?us-ascii?Q?xkyc86+jet7xERA4U4o/CWbj1HVvrY7/OksJ3bDieQhc2eorxzfhmegjhiaT?=
 =?us-ascii?Q?tt568Mbye1n9LbB9a1cvy3aCKgScuNTHOWd7ta++BpYrdPZNQ6oEqQcPurXv?=
 =?us-ascii?Q?nCLkxvZBNagzRe8Ja5LLAxzgtardUPM1T6hXGf/SZ5rUjYxHQdbjZBUQkEuw?=
 =?us-ascii?Q?3gs+Ma0AaBP4t4g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:10:52.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb98f785-2486-462a-0c2a-08dd557c4e0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307

Add mask support for L4 ports and DSCP in ip-rule following kernel
commit a60a27c7849f ("Merge branch 'net-fib_rules-add-port-mask-support'")
and commit 27422c373897 ("Merge branch 'net-fib_rules-add-dscp-mask-support'").

Patches #1-#3 are preparations.

Patches #4 and #5 add mask support for L4 ports and DSCP, respectively.
See the commit messages for example usage and output.

v2:

* Patch #4: Do not duplicate port parsing in iprule_port_parse().
* Patch #4: s/supports/Supports/ in man page.

Ido Schimmel (5):
  Sync uAPI headers
  iprule: Move port parsing to a function
  iprule: Allow specifying ports in hexadecimal notation
  iprule: Add port mask support
  iprule: Add DSCP mask support

 include/uapi/linux/fib_rules.h |   3 +
 ip/iprule.c                    | 216 ++++++++++++++++++++++++---------
 man/man8/ip-rule.8.in          |  23 ++--
 3 files changed, 178 insertions(+), 64 deletions(-)

-- 
2.48.1


