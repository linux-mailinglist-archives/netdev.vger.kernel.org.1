Return-Path: <netdev+bounces-121222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392E95C39B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858BAB22CB5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43836AEC;
	Fri, 23 Aug 2024 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K3wbv8sY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59943364AE
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382687; cv=fail; b=baI8hOZHBsq+qDADwFZTCQERaojH/KBujYspugIpviKV4CdOEZvSDFY+xQTaOL98O2tiu4/lM0++NUVVwyNB7FFACZy/jMtekM+GL8jADGacKWzUe8qzl4J6Qp6QduJwmeqzCRngnpjC+EukrbGTy881POtYQfhV/FJ2pp9/tBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382687; c=relaxed/simple;
	bh=vRMWuNcLxkCUhI6UNnxSoqdsqQniE77aFLYHR9qsCV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lUdMYa89wXraMARwLm0ijkjaNC2xZvUYa/Th2zUKyBjZPYnKanjh4+sVztJCqxJjTit/zeDiDWTh0Q1NfDylr0s4/0zEb5uDUOyV2CKoZvpT2NqoI0JkZE+mw19EfZ/EkGaLfxG8FXei92bQAbLy/ys8xMrETT1C51trLYyWPmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K3wbv8sY; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VycWsCUADbkPwtAf4yhdDZTJAN70qVfHo+zosdLe/yKEaTI3/Bc7BX9ZnyWozJnW7NKjUrnWD1z9WqBnYt6QdcPS3NJhWgaTWMpJbdWE8JqrcyUlnJBo4Ro4I8SMquuS2YD9r5J5OnqUG17hYasKSJA4b4uZuSjWj9iW0TO+SczgpIEkaZafjtT7LGP1eOh/BNUrz+pOA+nMWEXho0kVcRu04JMhDufh4Wcy42k/+qh1X4gBye4JAptmydnOfW791OC0WyBIdIzjk8nT8UdU/UvUKoX9+ZDK55l6oel7zayACmxWx2M9jzbHx6HDImiPybM7JaWa0+1PBIEbTh2x3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hayjxQsAOiw17iePe2HzG3+ZWsl19T60KmXvQ5zBUHE=;
 b=cBCdFdOTB2xRudyl0JZ2J7aF5Z6qFXwkMWJJT+cCybWeObmywA4ORqTFQJ7B6El8fc+/PY0f5+tZrt/vTR+1WEjVNJKKh2GeUKk4nuVH7y8UMlTL9KtSNIxgs+QezUG17Ej6jmsvcp9kDHuUZ986bm9fisI/beB3gSCnHPsrskrHWAFgtOgIkJSYbWKayPKWAJL96wrLgID54wPMIQeZ+SnY1A+ureMjp5EwcXNZP0h3jpTESo6F2L7ZIPFKLuUHULv1m/iWvv9ysIlmpSTHcso/mi6+xWBTTKv77Yj+tu6ELGqn2wZezvei6Kr7JTrBqaJXTEry+3YoT2HXTJ7GLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hayjxQsAOiw17iePe2HzG3+ZWsl19T60KmXvQ5zBUHE=;
 b=K3wbv8sY7+S5dUHm9tamTWp69biBXHaVC9SGCGzRwpvLw0QPEPTVYK2dtrneAJvKDulYLCpfUM4/kpcdkGy7GdtYbLOW2TBeW0DX4COIYoy+gKPlzdKcvoLWicECQlTCO+W3PQ3v7lTHzPYWmyKK3ZoWX2O7Y+4hrMip/eDd4eO95yjiIzK8AqFEXb69Zb3d2pm4Qic+GkBIuNzboUs3TTMWuKYTalV7Rhuuli31Yq/zBvKZ03242wZ4u/X2fMRBPr9/EF2e4+Bsi9sGYEf2L3LV/8N1P+w8nw+R/g/47TBDuEhFhMPzzQCu22QzGrZ+AQfWvesBjhUwiUjVnHFKUg==
Received: from BN0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:141::9)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 03:11:22 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::c2) by BN0PR07CA0019.outlook.office365.com
 (2603:10b6:408:141::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 23 Aug 2024 03:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 03:11:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 20:11:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 20:11:10 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 Aug 2024 20:11:07 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net V6 0/3] Fixes for IPsec over bonding
Date: Fri, 23 Aug 2024 06:10:53 +0300
Message-ID: <20240823031056.110999-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: b135ee5b-bc97-4e1c-fba6-08dcc32143d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZu+WH/pjZFeaSSYjOe9z58VO8GLaStXhFPc8I2De2SQhc6igBSw8Q1aSPqo?=
 =?us-ascii?Q?2nVtK3bznRIwjbpbScyrgDUe2NZfwfwP3bZ77N9h5LJuWlBT2bJZ4oh7gnze?=
 =?us-ascii?Q?iR38UUxHZ0duLtEetkiBJkqRxWE+k8yxzX7OBzp9BMFnytLh+OYPdSOroMhK?=
 =?us-ascii?Q?1ynAZ4hymauYzDInfsmYWXG0ruuCnFL1EeDBvdovWcKWyITfPwkyR1hI8jLt?=
 =?us-ascii?Q?oNzykwFcRUo6VC6mwV1OiarrocOJRnfjFs151IYkqmod/Pqd9MnEQOY4hLAx?=
 =?us-ascii?Q?26Mjit7lefcP2KiH7MPjhu9yuUsyE4iUraUxCAKRJLzd1bQr3vF2Ftr30pSH?=
 =?us-ascii?Q?bFLKqjTuJur4N5KZNXxM0tSMXFzCwOCJNpNZGiFyHUjoftl2oR9h04ezkBAD?=
 =?us-ascii?Q?FJn+mH8Nf6GQpntNpLFqV25SBWersw+rm2s0hEOqqlJZHjaQiEbihRc2VLJF?=
 =?us-ascii?Q?5mKwH3SEQJsUSGc03rtrAwd0RAgBVATBFhTNXmbEpe7pNCEZj/No7ZxH6jbq?=
 =?us-ascii?Q?0QgfyvPNeFrbpzB3gUrC1DdRqpKiGtjEytFS+oIxbznMabHZrZk5g/n3cCZ8?=
 =?us-ascii?Q?bjXJ3n0e1lIoP7pnuuGMH5Ue+WDwK5s54VEs84YIh9nBuXEPXa6V5pRPlftc?=
 =?us-ascii?Q?CqDYfXxcOdRp/Yg5HdeeuOxkl4DKTMMwiGHS9Ccon9PyOLP2nYYyFMoHC1Bc?=
 =?us-ascii?Q?k3caWt/P15Jz5yjW2yZpmyJACqczbQDSRDeQwp6/DXbRNgwOBa9lNmVd/ZB8?=
 =?us-ascii?Q?Q7xinirThhcm+5UDYKJbCOwQrtoHnXPee9CW7e2R/4MKif0BTu61V5IKxsL3?=
 =?us-ascii?Q?iujCr7OPX8uKT8y63mxQ9mbckHgvzEG/Zf1kfUtcZr4K52KtLeIykOKp71+X?=
 =?us-ascii?Q?bTZnS//9q6HrTDT/ejNcGlzwa8G7uJ1uDTHnjptUCBYycRuBW7oiXbiXTpMM?=
 =?us-ascii?Q?3t+x0G5AwAvYj53FGNwKed/KNrIrBwbMEWU0/b3sMfpXxNc7nWGhyqtzl4as?=
 =?us-ascii?Q?tD0T8EZpKC/xK4xXUEBiW+pPPAKjVh87Emoklzw7r92wclvYv3BvczUl0LfI?=
 =?us-ascii?Q?kCKHZUx0XmIjj+YXO0WQmqvoIUmOm729fxpOGwkWo/lfnLt2IHRL6LDnZv9L?=
 =?us-ascii?Q?Trh/MRtL892v0vvMgyCaz9kV64Ff4nDWSxKUOIlClErH/mZ3oijmzDwN2HcI?=
 =?us-ascii?Q?Vh7AoRgaMVKwNY95nSuS5RqjnlJTU8IYWDi2kEqxFrgOWLKVcbFSCK3PhVDn?=
 =?us-ascii?Q?yyhwz2fhiaNEsCIfV1cpHSPUd4xTdAx78UcOs7prKCLxDFzAOksWZJFx2c+h?=
 =?us-ascii?Q?OP25a5I/NDSqqyN/Mocoay0J9HmaVYFdxiyU8EJrQ8pY06VDr6ZnOd7uctaj?=
 =?us-ascii?Q?QeClYbWnPrGlKejGGPUUNfxEpB7qHg0XvshXxDqVUIVxLoQKHXxL5upM7wCI?=
 =?us-ascii?Q?PUpuzRPxCTTG/JT0/Ms1NQEODb0V+wfI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 03:11:21.7392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b135ee5b-bc97-4e1c-fba6-08dcc32143d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

Hi,

This patchset provides bug fixes for IPsec over bonding driver.

It adds the missing xdo_dev_state_free API, and fixes "scheduling while
atomic" by using mutex lock instead.

Series generated against:
commit c07ff8592d57 ("netem: fix return value if duplicate enqueue fails")

Thanks!
Jianbo

V6
- Add netdev_hold/netdev_put to prevent real_dev from being freed for
  bond_ipsec_add_sa, bond_ipsec_del_sa and bond_ipsec_free_sa.

V5:
- Rebased.
- Removed state deletion/free in bond_ipsec_add_sa_all() added before,
  as real_dev is not set to NULL in Nikolay's patch. 

V4:
- Add to all patches: Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>.
- Update commit message in patch 1 (Jakub).

V3:
- Add RCU read lock/unlock for bond_ipsec_add_sa, bond_ipsec_del_sa and bond_ipsec_free_sa.

V2:
- Rebased on top of latest net branch.
- Squashed patch #2 into #1 per Hangbin comment.
- Addressed Hangbin's comments.
- Patch #3 (was #4): Addressed comments by Paolo.

Jianbo Liu (3):
  bonding: implement xdo_dev_state_free and call it after deletion
  bonding: extract the use of real_device into local variable
  bonding: change ipsec_lock from spin lock to mutex

 drivers/net/bonding/bond_main.c | 159 +++++++++++++++++++++-----------
 include/net/bonding.h           |   2 +-
 2 files changed, 106 insertions(+), 55 deletions(-)

-- 
2.21.0


