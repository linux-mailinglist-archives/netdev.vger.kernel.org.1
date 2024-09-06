Return-Path: <netdev+bounces-125790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF7496E997
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576A528345A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3258D139CE2;
	Fri,  6 Sep 2024 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AixbkX3b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831AD13699A;
	Fri,  6 Sep 2024 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602256; cv=fail; b=BRYJvhpn0iYMqB1fDmaicl53ihahJXiEZ5Fvcp7+RJyBwGjaU6/TlfSoi8VToJ7xZyPMFKU0g4E3VZSxrpgTLRXMWi0d7bjWlWOub53QaSFMHwRi9x/GcqbnefADhItJZ3JHrgka8GLY8oqnYaPQLpTY6Y65NROCuHuHa2WD8zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602256; c=relaxed/simple;
	bh=3ckJjisMtMRe6BaAJWvrvDLAMPe9hPt/Bv3lv2WOqHs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SN+v+B40VjeOK5K3SB7EPGfUDMOw8Nk8nJbCN6Ne5VdeHK8ePYLDFDzlyPmkQ1F/2EjpGsRV7bum/DbFmHF+WsS9W4V3PW5UDqs42SbA5aUJJT0aGJ5TDwjS/1d1w+2F0zR+frncEneUaKxFDagu9t3mNZhGtLnvMA+gNMgbP3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AixbkX3b; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfJE1bQRI7nDsKrvYH4ts3+P0JmJqpbPWs5E6OrMWUlcMDW56blFtVgzlPyIjcOE/Q1f0KHADke7KIzF7M2aYDlCFQDEhKpVW+c5AJXRg/rR8puGQDFS8yHZ7YdCzR6qiBcQSAk0/QMHs8WC9SvpvxOrQPUjhc8ZWuPEvglmoMWIA/zxBCGy8BRCILntSjGuJ+tJlNU/1GxCVaXdpSNkOisY+sqq1FRuHo01QrigRRKZOisdAICOy4Uf5Lt8YEgJM1iUVt1AzagJo5co1aIMA7I/Pt2OqUJ0QybBUsLRKt51jEf6zelrdCjyBY6JmncjX4e2T7WriBUubZqCuCUHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DojMEP2FN8gnTQUaCVk+1LvgGFwtSgls20SJaFudy8k=;
 b=d81djje562XgIqgp0PU2lCS0TCrQ1PrbA1WDD1mREwMyNMIqU8xfSICJo2G+uJZby8gSNfVpR7dLn4irnd8VhcDG/h0BtJqe8Kj7lDWCRxqXfgB9HMrlwvJzMxwrZe1CJxL9MhTxPbaGrpnWuU//HRvXrzxL2jFHpIq9u5XOVS2EZdpKydxkTjw/b4aSRPrwUebiIOYrm8LC/eFsbpxIXekv87j85IA3J2ct/1BqXEFEPTl58xE4WuN5Wq30DEn1L0QwaJQKuqa0C0HWb+vMBU4wSVkNVoi157RIAXqj/sUOC5gof4SgSQqCmYsFOVBe0lCgG+41Dn8ImbMAqHVmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DojMEP2FN8gnTQUaCVk+1LvgGFwtSgls20SJaFudy8k=;
 b=AixbkX3bL9kVneMq0qWEhsVUgit/EnbgignF/XNJV9GIHowZJ4SHHKVyAVccix0hrOGJEsZEsuwC/sWn+bt8i5RVVg66sLtxtDp8qRvtURvgAEeP6ImQBvnODP9e9F63ZY1mYuXZyqv2kpesbyH1Y6OCXC+5awMQPk41dLfbZqa0p443dIOr6EQNXOH1pHgGz40tHYrR/CYV+4IK1P1To3LwtkO4jK+C2kATM7OvUyiQp26nmNvpZ5E9jM+0hjgWrXBn+1FZPN86R8Mwg43qp9oPANfNM6MZXCMM8KEUyTYgS+C8Nsy1y92cu6xCjosIiQJSv6EVAsQsr4xfGsXTuw==
Received: from BYAPR02CA0051.namprd02.prod.outlook.com (2603:10b6:a03:54::28)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 05:57:30 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::9b) by BYAPR02CA0051.outlook.office365.com
 (2603:10b6:a03:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 05:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 05:57:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 22:57:20 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 22:57:17 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
	<petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next 0/2] ethtool: Add support for writing firmware
Date: Fri, 6 Sep 2024 08:56:58 +0300
Message-ID: <20240906055700.2645281-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adfbde4-f2dc-461b-f1dd-08dcce38cafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3XgUtONyioicw2DVps2oqG1o6nyOiTt05+hogYu1au0oXBa4J4P2GU1Ycpt?=
 =?us-ascii?Q?iKLcInzLen8jbkttcCNFmcUYnidfyX3o7yDR9XwtA+ZMGsqsndGevSBSJ6uY?=
 =?us-ascii?Q?Rcwgsfw5LoUGFeIUpcWbdgnI1NGoxG4hhr1xRftQdyg23z7SxbY8mTUeQ6sX?=
 =?us-ascii?Q?pCSDkFIaVSDOVeAbN4+l/w+WKoAOq3GbwR9zMBV3f2MEyN0Nav0W8rmByFEm?=
 =?us-ascii?Q?l/+6lgsTHasqKGM8eBYZRqgWjkFaaEs/7e4LX9XA5IcFR0XvvhVe3wWhFENX?=
 =?us-ascii?Q?j4OZbNk7b9VGKzlp6NgDIE/n89I0NGMpT7itUAHuuVjZ9Agb4jr9DIyX30UA?=
 =?us-ascii?Q?wVaqXgvnRc6vxKfzipLINEYZ8Fkx2KS4rpm5wsDe/ejMKDIo7Vm/kVCBOtgh?=
 =?us-ascii?Q?oFGsADLSe0t7FrdQPtmFqkkhPXQtuO/bncCTFLgMYdsCzHllVMgsbgU1D/jf?=
 =?us-ascii?Q?u3W5JPJUi8aQIQ8piSrMeVy23tZGn29mhJuRmCUWBZT4y9pHfQH8x4rSrQnl?=
 =?us-ascii?Q?X8I7l5b0xT+IBFchBMhGO1jSvV/duFLuyPCRbk3nxLsm4IRHmglKcA2xwJFJ?=
 =?us-ascii?Q?3XjhV3n15lghmpKzv8Kznu/sKYU3mwJ3nhRKK0tAq6UDQmF682A8qmN/5TdP?=
 =?us-ascii?Q?RJwvIwwxrgBX1EVfBylGdpLudasQ0BQG0K8ps13WOwXQy0pkmN3Notj8eG4m?=
 =?us-ascii?Q?2jdkM6MbdMLYZqVelTLOex47vV73+gOg+CSrUndhzLNf2l8bW4/Qhqc5EgVm?=
 =?us-ascii?Q?BRwJurP/inR0LgVx44u16TI7Nft4v09uR15dQvVf3IYSTT7u/pmT24Kl8MUD?=
 =?us-ascii?Q?nufIpLKuGJkUYkP762fNt/vNZvl84jduvUQFk4ntqScTSsJuISK1NLB0UbL5?=
 =?us-ascii?Q?YkcF8/0+cfn5sLRf/6eUM/84bxeuVBTRpJ2mEJMaS1RAfVDmne5CQmpJU/UP?=
 =?us-ascii?Q?u4L2VEZKoW6WLpjo8f4B9cVzV0xrwbtXAULLD/rKr+5Sr432g94pFPr9i61/?=
 =?us-ascii?Q?it93v31oVza8yCY057b9JZzEG2nAxwBqXI1WjjMLXMme73cHGByPArVtO/3Q?=
 =?us-ascii?Q?Jy5R/BpuaQ6W0S3qmaSGtZoSmmpB/SkDz9LJbnP/kqPLDtJXejlN/kiNTvIV?=
 =?us-ascii?Q?BWInG0+lQiuBQzCqcidbBa4wlzDda8dPGM2p3Ai4BvlPAMHuxsMUm7UyTeJL?=
 =?us-ascii?Q?WUc6gLufVUIJKt0Y/SmN7BX4qr25etpzAkXBCFzLla5s+knhZwpqk18+xUcL?=
 =?us-ascii?Q?7/8hr1YqNPN1yx1tC5C53kNuy4eGXNQhwJwq3io/trGh38GLc6aA5F2EL531?=
 =?us-ascii?Q?7mNuVC6zesUsy4TWTeS0MJkNTsCT73H3SV8gs9aRBfZbKzJLro7DYtI+vvLX?=
 =?us-ascii?Q?dGHvw9I/Smg9bKkN4GwOfmuDZfUKV7e3+Yj5B06XkKnUbqU6MJNrnaAbPdaG?=
 =?us-ascii?Q?EGOVfmO/yPD1ImUpIWXrXNVMpQVn7HFT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 05:57:29.8454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adfbde4-f2dc-461b-f1dd-08dcce38cafb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283

In the CMIS specification for pluggable modules, LPL (Local Payload) and
EPL (Extended Payload) are two types of data payloads used for managing
various functions and features of the module.

EPL payloads are used for more complex and extensive management functions
that require a larger amount of data, so writing firmware blocks using EPL
is much more efficient.

Currently, only LPL payload is supported for writing firmware blocks to
the module.

Add support for writing firmware block using EPL payload, both to support
modules that support only EPL write mechanism, and to optimize the flashing
process of modules that support LPL and EPL.

Running the flashing command on the same sample module using EPL vs. LPL
showed an improvement of 84%.

Patchset overview:
Patch #1: preparations
Patch #2: Add EPL support

Danielle Ratson (2):
  net: ethtool: Add new parameters and a function to support EPL
  net: ethtool: Add support for writing firmware blocks using EPL
    payload

 net/ethtool/cmis.h           |  16 ++++--
 net/ethtool/cmis_cdb.c       |  94 +++++++++++++++++++++++++-----
 net/ethtool/cmis_fw_update.c | 108 +++++++++++++++++++++++++++++------
 3 files changed, 184 insertions(+), 34 deletions(-)

-- 
2.45.0


