Return-Path: <netdev+bounces-212799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B179B22053
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDF0179FBD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E92DECB1;
	Tue, 12 Aug 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bWioCdL0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA72DFA2A
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985987; cv=fail; b=agmdSRXcRzNStAPC0XSz+PsllfccwF/npO2NulbxqkHucYZE2KhC44yUvjjmMKowO9YU9nUqms9lJnDCwMbYgnt2JAZ/5fL4IyWK3Apb9DkqS2wo/jHwJLUD8nQhzCtOKTfn++8Baj5RUfBerxjF1cuXmOGSd2kT3TI43axKYO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985987; c=relaxed/simple;
	bh=qhCDq1z3w/JgrBBXH7cFDFaJCFzXWENMxWaEIztnooU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MP4cbcTEaAomzLUkytql7HuLLJFbMsBdrGrrDMq5v3tqlhnb2qQLzUdWCogLF96FvcSnY/oot+pyvz30gqRsv9Sm9zKiAaxR9MNkyUyhp/7MzRtseeKIS9opeJWRV6YRCYi/v8qF5gpfL4g0NOSpz97viYu0YYt4GSWeOL6s8UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bWioCdL0; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0GmejmNC58lvPqcajbu3ybkbCKPryUBJVEoI7W9Za5K4Gr1MbZqPw0yN4D/vcrgNJIeoeuB/YCV0Fqq00h+35bkLrGXB32AwnQ9VH3I7Enp0qJkQaHbiB4PGR0VNfqHBS9/2n4++oyFl7H9bIjAJBnISpIGZj9muujKno+ra1IxvyWr4UsBk7Q8pIGsIwRw8BKCcBNE+nzLX5nCQmoaTHAzXbCzXFK1tmYH/nxsDrNIvlT3z+PyIlo4/f/MAGsIc4Gs3bFFj95f7xdM7an0kwb5zGlhBstE/Ys0Zc+2vg8/sWGfF9P5CX/k7CrhTDb0+YRwx7Kz2uYOSCl9cL7VUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNhr4l7y5FUlC3FKWkR1WU4GGmsVOF9D1h0WIdlCQdo=;
 b=PEHK1psVHx9Fr+6MG0ikNJNpltAAxKnhlVNEC6rUy8YMGK1JqKAkQnk25b9MihOd898LkubGuNHr1dtJVB89ZfcTvByfNO5ox9dEVWt9aPYFPiBwyDvq1NAUUDrdsfoxPFMc+rCdk2yAWir9vK7qS140BPNQlXhePKKKkQ/+/EOy3QruwlI1hDH2viLgDuPLgaKPf/XU93TvU1vZPxvrPRdkQqCp6zm/5FUprW8gLXiI+vq08uH2C3C81X5hiNEXzoDIKP8RfoKcGC6cEE+BAnT9xsyRedXWh1lB3vQjfDE3kSvi6nz0+Y2n0L4K5EunQQqppFsHKU+J/9/EmIB28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNhr4l7y5FUlC3FKWkR1WU4GGmsVOF9D1h0WIdlCQdo=;
 b=bWioCdL08mDF36qwRRO1eQfH9R9pPlS2rOTF/FZXwXIgp/ugFebNrt1zu6m7DPZHFv6flYeSz7gB3ExcvYD3v/wcNVnJlkHUTYYW0ylxcpsYRLuyWHZz5iVQ6e+5xhaku5et/a+87oop+txefIdmFn/QyK01oAoipWWWW336bLTBSoXNO3laELyNmX3uwrP1dLXlFmNNLG18wdEZ1skaO1RwrDbFAs01Z/9DeSoAyuibMNCfUR5284EXmIuss9OBurrWHOo9gqH/M4H0bQZdqXzaGP0tMYr8aHvDn6EWTTY8LnsdoibLX+KTEjUe+G8BTGgu0zpPaff1Pxdw0yAQKw==
Received: from DM5PR08CA0037.namprd08.prod.outlook.com (2603:10b6:4:60::26) by
 IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 08:06:22 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::8b) by DM5PR08CA0037.outlook.office365.com
 (2603:10b6:4:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 08:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 08:06:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 01:06:07 -0700
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 01:06:03 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <petrm@nvidia.com>,
	<horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/2] bridge: Redirect to backup port when port is administratively down
Date: Tue, 12 Aug 2025 11:02:11 +0300
Message-ID: <20250812080213.325298-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d8432f-ca0e-410d-1345-08ddd9771ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATOvKqCtgn9UEOKyIE9Lv6Dl2ISuNw92uoMcJg51GF/7ZSavHgYHf1LHRLEg?=
 =?us-ascii?Q?mR+vrI4ktlnEADJG5oaTMpMuG1se7eppxLLZklOxMrbdBmxInoIlft1E/xN5?=
 =?us-ascii?Q?pSleGmxMenFan3fPwZXYnTotsWSAIFPYYWsd4s5yzJ1duV+co7jLn0LqaslU?=
 =?us-ascii?Q?MbsmdbmxkcORHCP6t0KldUp++EE5m3YWJF0KtyMlW99BIjIS3j9ZrIkDBHUN?=
 =?us-ascii?Q?qKYVKHgFcYNBQj4+BdmcRXM1c9f9TbCLJ72UW5pY1kJyT1abJ8pE5rG1LIGY?=
 =?us-ascii?Q?uZ3r0OZG1R7o//PlmVQXESH/BQM83C3BM2HLcVc5wGRY+7z7tySuUaCeZ+mh?=
 =?us-ascii?Q?FbLtQd4IXHZYC6qsUKF+UstzXR2lETwB3m7kjUyIOMADuH/8lg6AMWRBP6Cp?=
 =?us-ascii?Q?TBuyvUiRZrRYyj2T9Kd6Thnxp+o8azoueJhS+VegvEAw9O2JIlZ7DLhJtqIA?=
 =?us-ascii?Q?QLdGsxHp4kTwHi/n1Xp9+jqo0m7Nf2tYsU8cfGWVRJdxRh3tU0tXf46xaFM4?=
 =?us-ascii?Q?ZOvujFqXws8H4fMSXeQoYjNqkQo7CvS6bFj9w9M5+a/marSAQ7rE8Dqc5IX7?=
 =?us-ascii?Q?RTMTqGk60anRVPYolg49eyA5KZoEO5Yk4GZ7jY4CmjXurnDP/kca2UR1TTOW?=
 =?us-ascii?Q?gLi1XPRl5lrcaJ5UdIu9zJI1Yym6/u8xCBac8S/goRC1YPiRuzr7QesVp1UF?=
 =?us-ascii?Q?WC2JlaKpPKea714IMH8g/6XNKllDayJuS1ebnfGv+kbA/8Z+smjN34AzZsC/?=
 =?us-ascii?Q?8BtRurrHEiPcYwK5ctc0V+CNhv/vXY9+z7ijeFio72LyvXPQ9q5yHpZhDQhZ?=
 =?us-ascii?Q?uw28ixdN1tN7y2Il3IDXSXy7bS5Kv7f8zXd6UHvGIawd/hT53IPa4H2CylrY?=
 =?us-ascii?Q?UAWURXlmnBwSDdxElDRC9Zc44PS2L/Z03Mu0dWXfAgC6Mwi5i8ck7U5Dsy/9?=
 =?us-ascii?Q?Bq+y6TxrqfdMD/NZ0zhroByxDvtE8xXOz9r511lnV2G60zk/cHaU3k5l6F+g?=
 =?us-ascii?Q?lVSK+NfaM2Owo3JvlNkERV04kx+qDxXPr3aURQz4L8UiySDPUNldxFF0OGc+?=
 =?us-ascii?Q?u5stl7dZlG6PAaZwl8RVobEWnlVAhQTmjbje+Kpa669bfivrmAVpMY0eYxxL?=
 =?us-ascii?Q?XUuEeGYJWfoGBpS0YqcOyf6zYN6Hes2b63Xyhv0+MvHrpUY+44cLS3rJiT2q?=
 =?us-ascii?Q?Xn+J6NgVJPzepOVVQ0e7gVvJO/mIL03HLQ+80kYw72kefEup/ery9tZ21I/Y?=
 =?us-ascii?Q?f8+35B0ZlCB+YIiDM99pEbr1q/zghuHLm57Y2+jrVA9s+3in8XinyzldYF5P?=
 =?us-ascii?Q?6NXPTUKiiZ+RoU2S9uZbVtltX0U4mOsN/sp8nrozQ71GjRhmgxpj8kzsFCia?=
 =?us-ascii?Q?xVzLAk/BZsNxvCjRR1RLnlai64iqvZeFSHDdyYO4mJmaxRAhYjasBMYgF4Ta?=
 =?us-ascii?Q?O/0WCwvcfoR3cTO+Gb7mrtD8oTEa5vP0etrGPQahjDiowBJMUO77bDyEUNfg?=
 =?us-ascii?Q?Rsk/65QJ2ANLaPJMWXpDL/zMU9RRjXmiqUgz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:06:21.5546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d8432f-ca0e-410d-1345-08ddd9771ff7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329

Patch #1 amends the bridge to redirect to the backup port when the
primary port is administratively down and not only when it does not have
a carrier. See the commit message for more details.

Patch #2 extends the bridge backup port selftest to cover this case.

Ido Schimmel (2):
  bridge: Redirect to backup port when port is administratively down
  selftests: net: Test bridge backup port when port is administratively
    down

 net/bridge/br_forward.c                       |  3 +-
 .../selftests/net/test_bridge_backup_port.sh  | 31 ++++++++++++++++---
 2 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.50.1


