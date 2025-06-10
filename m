Return-Path: <netdev+bounces-195948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD6AD2DEA
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A644A16457A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C54225C83E;
	Tue, 10 Jun 2025 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s1ZhNL+I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6813790B
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749536810; cv=fail; b=svDDIoQgciAT0DcidLWyPbHGhVoIVcczETKl28T0X+xhKa1q730h36Mqwa0ziKXETUch5nqkA2KKlB7oNzkBfiemFUtVlq22IP0kn/eH01rVLLfjspqf2hbsjkDh2dpZy67C1uPs5r4taaP0JJAC8PGa5nB1TWEAVa8Q0M25sz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749536810; c=relaxed/simple;
	bh=ByZBVQ/GotGn7rmjrGphWsBtrmUXag7Icnyd9u+g9YA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kjlmkuQwZjK8LM+NEnZ2JxK0Sopg/+rqzsJcdYSeRAV3x2tfNiy+NhuKmljckxAYn403uY3xlD/NU9j+dPmO82iv5MOZYItOI5SOCtqRCHve0+qY8c+PBTbm8zi43TN0K0c9pTAgVv/l9O2RoDvdSIkOSBWpXPBsSLVUOVP/Pfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s1ZhNL+I; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/3LGT28XXn3kqTPULWBM2PBe+rcPLQ7TzKhNEDPGLxQdbi/IrAaIOt4Sxa9MvlFXVQcPqLZBNwCdzYevB7xmN4EaELjDMrg6HsnWjQGmACsniREi5dOwDtSrlENGuGxQRokoB1ZdXpwmlgPuXALSg/Z7vmqo48+y56msemMo+KmTImoopfT/n5qnu+feQHAoiSJS/AvkKJMAUlNXQ7IAthvCWF6rOfyEgnvH8/cXI7L0JgdZOUKXIKRN6lzLRa0RaHaezuk2aTze5U4T3ddRWPFLjfoxg1g0Hq0NbMQGz71GwqBb5e2KsYK1tHSy7Ix6wDLJ8loENM5ln8tnGhrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z29CufsftP0gsMjLb6r0ria2Hhqz6jzEaK86K+An1zs=;
 b=eIFM26lVPWmWutXMbLwsWPXzud+drVzxGzCQ9rVt1VZkYzhz7dCiLvkDIxAn8lnAnv+AWhcnqW3XkwBPvxi6L3UisNf1wFtOdMrSmEpsRzV95FoDDHrIeOMBnuJwd4436wtE7/5dnFRD1Ulm8sQHRQaCwG7MNKqnGmFpWxA+5i/S4gHlG1t073j+YKNcm0hfGGpJsQBkrzEJSBPKet/0y3QfueHwV3rwr/aPanuO2gdbtAfbg2ZvcghMVlyjiAiZRQPSpfynVsqFAcJU31xNl8vNlTw+glZHMHZHQyFX9tc8FhanZVRN0Mn/G4pmcDUDmqYnKgyg7uknIeSzZbET3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z29CufsftP0gsMjLb6r0ria2Hhqz6jzEaK86K+An1zs=;
 b=s1ZhNL+IXFki8zeadDu9CVYViV3MMBuVoQUhQ+4lLBOh0hybkKSGKLTJeIMZaiKwGYSo7ES1z0gBgqyQA/di87WJDwdhFF0g8QAXmmY6HzgGfD13r03qfo77w/mK54V7IHyaM4qE+ORz7sNIluBxNoCWwlX3R2F74i6oHHlVZL02bA6cDwGfRUHNa4gMZD+z4EKRNB2FJHihm5bXTq6e/CPH+t3o136iw8CRFJUpFFGI9hmqTpwR0rTk5FvEvMUb8CUeR0Ub3DGIlQfIL/Msh5iH9UHDuQOvaNkqAB7KVH4V9Ce+0+BaqYYkNTpE39iuAeWzc4T9+sKFOI/t+q5xoA==
Received: from SA0PR12CA0012.namprd12.prod.outlook.com (2603:10b6:806:6f::17)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Tue, 10 Jun
 2025 06:26:45 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::16) by SA0PR12CA0012.outlook.office365.com
 (2603:10b6:806:6f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 10 Jun 2025 06:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 06:26:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 23:26:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 23:26:33 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 23:26:29 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	<dev@openvswitch.org>, <linux-rt-devel@lists.linux.dev>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net 0/3] Revert openvswitch per-CPU storage
Date: Tue, 10 Jun 2025 09:26:28 +0300
Message-ID: <20250610062631.1645885-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4c484b-f317-4796-0792-08dda7e7c596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJOkcKT48f4o2StulPJlkTXFh+lPsZdyAkA33ql0IBJTu9Ksx7RFGsu953Cq?=
 =?us-ascii?Q?B28DeSOUgNlNBSsBsJ5goJvyl/SiKge484D1X+pnk34j33e7sAPnv4tfgvk7?=
 =?us-ascii?Q?iqtUjj3cc2b1b48g/hffFHaQ/0UK6EjP3QsFI0kU1HA4aXbDqMeBvDtnsXlT?=
 =?us-ascii?Q?O/Yz6NEA6vKSCs+IG3COtoAvLyuLV+kBnDgfh3soWA+hNPzKJ6GnyJMLSXo8?=
 =?us-ascii?Q?ho5ZGo7GTlua4d7MazlZYnWLICzAXDvS+DtgRuBXWSCzLjm41Fa+n8Tnkec1?=
 =?us-ascii?Q?2qN6dVk9JA6aHHEQIeuywS/21tDD/ag4oR9ag0UgO7k8EyQbSIZ0DbpZvfbd?=
 =?us-ascii?Q?TCCVSQO+zNmbNoEsw97pmX/EHrgZV76xTUIn1mtsdPEJJ97tXB9ijZZt+XDf?=
 =?us-ascii?Q?fdnamG/Lgimbg3Qhn8floqg4maWXR6IGYvDeobMjYvgFoUXqo0B21leQ2zCL?=
 =?us-ascii?Q?IjAVTXVsW2ATjXTrOIqHBiqKULcvaskZXOpY9iSuj57cKNEZQi9mkw+6DhX4?=
 =?us-ascii?Q?IowS+z1VgFDqCYlJJpff8EmEWSXNRw1Jjmq/k3G+teOKqvEzOphhejgRpk4Z?=
 =?us-ascii?Q?/YqFjC9+lhP00AR4dCxi+J0FRzmv/Pby7ERkALyzECPMxEnxtglCHzsyRw92?=
 =?us-ascii?Q?f+AvPWUEO4yNQKhPIUs0xEGFP0qZW4YaNCWoU0NqjUGsYtSYn2JIQIsNhF8y?=
 =?us-ascii?Q?DLDc6w/CX342A5FLo2mZ3Iz6pSJpnWC6X6OvSlzkgV2AXdUjzr7OqwNxhp7g?=
 =?us-ascii?Q?peWA4o5I0N8qWLeQLNa1r5p61+wOd8OHeMfjkWeeLq81qg32NfwCIrLSwbqe?=
 =?us-ascii?Q?Y8YtMqM/qwNcRGBT0aLAymLICgaJwQBhOwK7J+uNl3pLIVYYEYKDsj9XMCQ0?=
 =?us-ascii?Q?/WiL1v5wLlUggwx7ryhy1CGjDd43pv7dgpYhndlfg2Kl8Jt/gKT/dt5aGvSc?=
 =?us-ascii?Q?bE0mWu0To36KmGiD+EloCnwnW7n1SnjQviWv7f/TFSuz6MXIzZ7pEh6Szt3B?=
 =?us-ascii?Q?BWCLMziXgm8OqSSvC91qekjZurAWOFwNAOf9P4t5ufU+WBtNqplp4nVdP31G?=
 =?us-ascii?Q?muijs6OIOBbbFvOnk7m/ECkkl6YXh8d7D6bJ7ZH1UEIi5ob5jYYh+7GoJT3Z?=
 =?us-ascii?Q?lIz+OoZcTfp27EJ3RBhlI2RPYGyxq3c5iu5K7gGoE2AjKDjaXBlZYDkUNpTW?=
 =?us-ascii?Q?razHm+HzEb8yTMkySVrWTdL6YdMBHNyYpfmkoZCkmItVHExv/b7ZEXmJpa2N?=
 =?us-ascii?Q?PRe55o+PfQvp6jhGbxMp7zDWTuzzkp0wxqObB9nbSH6YU0rSy0SD8RxFqMnh?=
 =?us-ascii?Q?3iq0TgmJT5Fc/H3nJxA6yCaL7fru60DBPSNI/yDKLa4DVD+KpuG/OLtdyecs?=
 =?us-ascii?Q?t2+d1Twm54XsNVI2LRGgq20f9sY9QWNE5KTm9j82NVofRDLL8TSjb6sZyMee?=
 =?us-ascii?Q?A7mYfcLpL7+4aHV/LNUGUMfK6/Xr63vwceYUjVuSKq7p5ybXp8c5oj0/FgdJ?=
 =?us-ascii?Q?Qq4rs9aqD+sSGK4vjKjl7PiJTE3bUVpIIBTt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:26:44.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4c484b-f317-4796-0792-08dda7e7c596
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

This patch series reverts a set of changes that consolidated per-CPU
storage structures in the openvswitch module.

The original changes were intended to improve performance and reduce
complexity by merging three separate per-CPU structures into one, but
they have changed openvswitch to use static percpu allocations, and
exhausted the reserved chunk on module init.
This results in allocation of struct ovs_pcpu_storage (6488 bytes)
failure on ARM.

The reverts are applied in reverse order of the original commits.

Gal Pressman (3):
  Revert "openvswitch: Move ovs_frag_data_storage into the struct
    ovs_pcpu_storage"
  Revert "openvswitch: Use nested-BH locking for ovs_pcpu_storage"
  Revert "openvswitch: Merge three per-CPU structures into one"

 net/openvswitch/actions.c  | 86 ++++++++++++++++++++++++++++++++------
 net/openvswitch/datapath.c | 33 ++++-----------
 net/openvswitch/datapath.h | 52 ++---------------------
 3 files changed, 84 insertions(+), 87 deletions(-)

-- 
2.40.1


