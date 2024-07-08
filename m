Return-Path: <netdev+bounces-109925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C829192A499
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC9E1C219FD
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858578C75;
	Mon,  8 Jul 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FlHrHbg8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CF13AA5D
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448803; cv=fail; b=AesP5MJI7HfJGfMEdy1Q9rMNAuLiUx+cn9nZMbffP7O8VTgHTiskeRe5y7Mrx7VEoHydtb7W9tD5EHj8dMfiePNgAhDAaOySWrRLmDG5QK00oFvIFNb9Oj1ENAmHEsuepWVl+0Vv2UU8Bbt3pxJaJh9raXEYNL7Yvcb6ovqPPwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448803; c=relaxed/simple;
	bh=ztEmQZ3lzDWAdEp9INziez1Ulo7ZrzEN7cupQhPzUrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pktiXaq2hHLKRmy7Ngc7QIH2+qbsQdlfcqBapF0nzqaz3Sg2iYK5TSwpjbEX4kxQ2J+qgbnb2AFObgX/y/tYKskBfZBkyQe9x27ie0jGMQ7iSJBeu2L5vwGz2zA1N9EWAz4xwlOfoeXOHLbf/f9Wchvak19BjQ0iMcGfm3wmDxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FlHrHbg8; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQxrFbtRH05HowGrf9i40Ub/VJvNCEFRQx0St71kTaBeuGsrKCnrdPHerj8vdDHECdxq7hylQ4OqSi8pxnoHsH0lnRbctMHfDuMw5peXCJqP41gH/Wy2k/mTlKg73JjZdY5Z+vikJZL7IV+oyrYCCb6vqfvi4vEQ+IcM/Zp7Xw9qNvXUhgeeGpGTLYFY1TLLXzvzszXtGtKKiTxdke1wQZQXP2pmld//56va3YfBzFFH3wlhwqf8xBAWAlBrl8XKvoaXaJ8vDJCvLHRCXJM0/zl1f3avUrGsnqZ1IcvbKsIm+kLqVoy576GSEYJJEhmCxikmVV3d6/u7QABrgE3YDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TgcgEDdtaVP0/y6gUxqZQOhnjjP4RKaOis11eyZPRQ=;
 b=VlDfoCIMduxyHtAFK5Gi5DFRh57nqd/NPlfDLluyyRZv19emdCLmCicshCB9+ulMfZUvfm8LmzDt9ooA01i4n2DuYjbQ8oOYWWdyIzXFFMCiphUJ1XFbFyNpI9b5UpEOjG5f/83uTH/HVfXMBejUxToiE8Lg/MdDZTc9bz/VtPpDKpVh3s+IvhUWjiEkM10T3zFVoMiz6GiylQEnfug9B4rFdVxc7OdRXaA1iPEmqeG7Jk9jztwSjDHjeK1gChEip47g31nTrrhuTOcp6iDNBFi8/Qx6IBz1Wi/V91UrBgkmit6leXUSYEPAL1JZhtEtFPdHccQVtjDK9E5XzUb5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TgcgEDdtaVP0/y6gUxqZQOhnjjP4RKaOis11eyZPRQ=;
 b=FlHrHbg8RmZ4u2mdoIQm+PQwUAqzIRTrZGau2XA7uLWyEA7Qcr6gnYtjF464VR/OGb4XzsqC7v2HuhPoFwjbaTwYn+UhTvAUmeao/dR9KU9T6B1fkS0vcLSkw6HxdaIryai8ezha9FJb2QOsx7ti7oW37PmDQN9oIlWNjKgGZ+0/pOifNlU0KFb0CP1a+nO/gz/2ddpaldb1tUBkE94Dc4IzEobV3xqYbLNQCsIzufHkgAtCdw/BP6VCMXdKs8BG+mE3UiZS7ZHVIsvgMUKkkCP2oELtzN4DakKB2658GoE+bLvbd8xloO31GIxRU/L00l0YCGaXhwpLbVXBH9B5FQ==
Received: from BN9PR03CA0802.namprd03.prod.outlook.com (2603:10b6:408:13f::27)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 14:26:37 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::7d) by BN9PR03CA0802.outlook.office365.com
 (2603:10b6:408:13f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:26:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:17 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/3] mlxsw: Improvements
Date: Mon, 8 Jul 2024 16:23:39 +0200
Message-ID: <cover.1720447210.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b61beec-a0a8-4d68-4899-08dc9f59f9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlT8uz1uPx6hlUYscr/bybWaMG96LAEvNphSw0TUVddhZuwDoa+aoGSxvroa?=
 =?us-ascii?Q?szqbRY/ffPVWluBVC5vvlf0xiJnHSouAwiA4OUqbGTouNBk1wJcPh6q6NDCN?=
 =?us-ascii?Q?aRY6JrII9Nu/qPYUBE3dd9r8HtYXXoSelS1RjX5s81IlrFlN1OBsXzRIdBmE?=
 =?us-ascii?Q?0LXsgcL9di0nGHjjEoVzoleEjfiXfyW8w+4ns9eCHeHBQihVHpKpFUPFbiWk?=
 =?us-ascii?Q?02rpMdSqBLG2YkBktO2Fb1HqaFG33iyYF3/Hy4SlCvk2KyTwN2Kkqf9bEYIM?=
 =?us-ascii?Q?9wCdTnqufX3BlojeZJ4SMsB4Iq37+GZVaT+VDeVV6ZHvuP49X9Opa29HrzKJ?=
 =?us-ascii?Q?2l3EVW8YqcIGdv3RmGVsE8I7uUDJss5SA/qjIL4MJPRk52Y29KGMGzhabWdw?=
 =?us-ascii?Q?XR5DEiV3jp0Whxwx/4tcdAz/cCSfgW9TCkLiWEMQfP2BW2DgpF9zCrZ1yCmp?=
 =?us-ascii?Q?xsFo3tXQkze+F+8NtnmK5EMokzBsH15wDIfa2/dWdJcKZd40Ho26qD0TDGa8?=
 =?us-ascii?Q?g+Rz4HMobJ+yun+El77DUVZvFgoQ3lBMxkx3vczK1O5Vu+wrArNl4MkW7vhX?=
 =?us-ascii?Q?uOKGXwWmyU61Vmxxa3Zgr9iFvT2DRj1G4RXekPCnvppzBnEaHCQi8+xQ+oT2?=
 =?us-ascii?Q?/XMFBMCSvy+WbKbVIhkjVu7WQPuQVhbn3jrN2AsP3bJX4L/Vgq5yhNiLd5/U?=
 =?us-ascii?Q?KgVJpkgyFPCWFnineifvn3Jq46uomWBIdc1huJa2yZHuMzxSatWZoT7nWHFD?=
 =?us-ascii?Q?wxjXgVhpheG9cI7k9Gg7TpG4WGtBAajrGMeIuxyP63inCFN8rD9RMe6kHpe1?=
 =?us-ascii?Q?0x+b3zzH61Ey4qc7jjZi/kJfoEWBs+q9OEuhjlodetW077QNMqVKDKzMau5x?=
 =?us-ascii?Q?MlGKULPxATMIWFyavG1P0FNGL6VaEGFeOZOuBVL1ti8w1sa7G/pX5qGUk22T?=
 =?us-ascii?Q?u2kKQ9K85G2tWliYRzvmk1/zHwtwYhB3bXuonLrqJjPs+uly5h6V6luR2Pvy?=
 =?us-ascii?Q?N5TP8LVQULTfwfr+RBzCD62zOxBMhyOjoEiR8gpl9eyxpCbXfjKoEhQ9kiGE?=
 =?us-ascii?Q?QSp+s/QTp5UbZSmNXBh0IDfIE8pKpJyqq5XD016WEdEJmroyjopUoe3k52+z?=
 =?us-ascii?Q?y4n+tlnRh5YcOocJF+O8toMEEXm/pC5H4mtbmbVB4pny1g98NqmbhPccU7TU?=
 =?us-ascii?Q?O2e7K/pddwItdgfjKNZl/ymgKJZMTR2cl/rAZLLmEdwiSP7kbSUsfwIWLlnN?=
 =?us-ascii?Q?7qs5QyXwAiFXwHZXmTq0PITLJNhhgzq5Sog2xhfsoY4ZHzrRrzPKufM8JrDv?=
 =?us-ascii?Q?XFs6Qbv1PzUqNOf6cAOEtrV+dPU4EKLhkpNv2km7C0Ur791A8p6aeiLli1H5?=
 =?us-ascii?Q?73IGBHNiISD95BX6ciooO0jFXttgosGKGofFnHNWHaRSf/w+t0zolXXNyfKq?=
 =?us-ascii?Q?LPKDQPwh0jLKY5TkiwN98b8RSIDVEwIe?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:26:36.7893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b61beec-a0a8-4d68-4899-08dc9f59f9b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

This patchset contains assortments of improvements to the mlxsw driver.
Please see individual patches for details.

v2:
- Patch #1:
    - changed to WARN_ONCE() with some prints
- Patch #2:
    - call thermal_cooling_device_unregister() unconditionally and mention
      it in the commit message
- Patch #3:
    - reword the commit message to reflect the fact that the change both
      suppresses a warning and avoid concurrent access

Ido Schimmel (2):
  mlxsw: core_thermal: Report valid current state during cooling device
    registration
  mlxsw: pci: Lock configuration space of upstream bridge during reset

Petr Machata (1):
  mlxsw: Warn about invalid accesses to array fields

 .../ethernet/mellanox/mlxsw/core_thermal.c    | 51 +++++++++----------
 drivers/net/ethernet/mellanox/mlxsw/item.h    |  4 ++
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  6 +++
 3 files changed, 35 insertions(+), 26 deletions(-)

-- 
2.45.0


