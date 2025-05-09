Return-Path: <netdev+bounces-189313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A5AB1954
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1797D1B632B1
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779D232368;
	Fri,  9 May 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qSwZ1W6x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944B231A24;
	Fri,  9 May 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806041; cv=fail; b=Syz19iRjyPwX66bHCqtb/QaKqWOCGSd0x+DGbrguI06fiwST2FKREwcXLJ3PWLptYyoQH57xY8Bbv45Z0bMcSXaUiT4pyduLDZvaSFohzkVbt0CK0KCjG/IlQNDXMfyjIqOHbri+iB6BhFmVLEY/it90Hfw2bwX2aWpIlzEWTR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806041; c=relaxed/simple;
	bh=R5y/XK/6UbyWrhZDCw2bsR+ZnvdjRUTwDTHEJEf16/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BPMdH+68nmUJ/sIlDOAVgIWsMcouCwGQunf3nmrSIMsBcOXJEtO164kkxk9eqB5zHAzJ9t+52hGT2oQP9w4qBzfBw2y++J5RSCq2UP2343Q/k1JRlWH2KlUBSiji0kG8pSLeFMPxlyNVjUcP3zwVC9NV0kcxu9mHvXMibXqGCYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qSwZ1W6x; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6URQ861bQCluDVI5ojIkhOO5K2Zv8JZ6Ln8+fB7uIPwvsQgucouzRrlRljIZOml0QqMeZNmcziv8liwM+7iEolUvMEj0w+jNiMqJkjgPzA+VuM9FMst6LUVpTNXh09rB4X1/bs1Liv1EGBJFR10rSIKtJqRtnyaAl+DIFDLAc28bQihJoyBSPIYEwSrUGFJRlAbNr87nxhaEyVtuVV1aS42gcqIzCa2b1JMW4+QygdfX17XDb36XUKmMTkZxmA2kXYK1c32RTCa/fFekUNy9vJ43BZhcet15uWkpAo+M1lcQpqq5/6dKUkOZGEb43k2qAFiiY5ywxtijpmmnu+3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYrfHX3uFmRGpnN9b+oHPIwMr9dMYM5CC0N4WedWugk=;
 b=X4p3e0BwYN0bttN9CA48z7x3H2lJaRrMGANDBWwP3S5czrazVswUhWRjL63doiKQwONAzDOpSDqS9gd5JCyTWZdLbE6K9cYlcRwuqdOZ09sj0TlPUdsl27PQytqYC+dRB4gUhw5BQr6yr9LxZ2xyzP/R3sgZMXKR0uegfsiNPy4MTQ0QTanbWX8XG8WxkCZVtLGjHESKMnZyU+Wt3eXwuCgPwex4InceslL0lLhP6rE5WMJ9woz7yXI7VIiecXsDIPwx1SmTj1oxZjJxe3ybYiYwvp9yuql//jOKPLKUYGDIYED/YjMrs3/Lx32fFfXSslphRHwh+YLh+vjkcOpA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYrfHX3uFmRGpnN9b+oHPIwMr9dMYM5CC0N4WedWugk=;
 b=qSwZ1W6x9hBLJIu1iCMPUT6VC29Ddx+wdnTvClqv0QzOhdQbxKmH61LpHlTxN0527sIb5KTruENdULacHhL66xwnyUOsyQmuxg9ZpUzOGUfdfTMozfhNfXoj56Apx2ug11IBcacfQcw2MyQyrcKecB/EjocIexvLrMndPyy+Jgk=
Received: from SJ0PR13CA0198.namprd13.prod.outlook.com (2603:10b6:a03:2c3::23)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 15:53:57 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::7a) by SJ0PR13CA0198.outlook.office365.com
 (2603:10b6:a03:2c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 15:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:53:57 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:53:50 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <horms@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 0/5] amd-xgbe: add support for AMD Renoir
Date: Fri, 9 May 2025 21:23:20 +0530
Message-ID: <20250509155325.720499-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 72395653-6ef8-4225-1a6f-08dd8f11b550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WhCwzYj7oMDOjd/ZcYr68w1ivFO1svd4Z7Lb//5GgOHVZhG/w2sBwl9ze6ZI?=
 =?us-ascii?Q?gqXs1BOfIzZwmvQfO1Zj8l0Nd1tJ+WdmvuxDB85pDp+SAmo8RUqRnCou2Yf6?=
 =?us-ascii?Q?JV/OYkOjjC4F8SoBiey/0vQmdBtAFEwq9pM1EoNmUFRWhKqEO0WXCCXcri2x?=
 =?us-ascii?Q?NhDzlEwDPbTACJOHH0rCm2MSHjdwgkAY6Q2Rsrk1DZyW2Cva0Hr7JAL6ajaE?=
 =?us-ascii?Q?WGDYwpANd1pOCWnKRW9fzO/Wq28cwZrkNjWGI0ad2YHGSN4LrAt3bxN0qWEw?=
 =?us-ascii?Q?Qg9tmqHb+EXGE4kWurO46/Ue0idF3URCzQQSp7YUUg3NiBuADg09UYBJwDxZ?=
 =?us-ascii?Q?0PfzOIwrcWco3R3YdNBdvC5JMCbxVu7yOjM3ISSnOuGbt3dTnrKoKR9qiakA?=
 =?us-ascii?Q?6Wp9yQKoQ7Kybb82DRf7W4eIuN5m1wkXGl7TGKfy8qkmfF7zE/9E2ZqYxzUz?=
 =?us-ascii?Q?iy4Ju3QcB6Qk7yNl0dU85n7vuB4+X8M+EDFit9kRHK+Ce2Kw9wcGCwtulx65?=
 =?us-ascii?Q?BgscgVhZJYqqGoQFd0/5szcaJGudyjlp+Wg7GmKB/qoXtG44WKr26ch7nimt?=
 =?us-ascii?Q?4Cwbqbp+HH0+0N8e+SPFzJsMwgKUqheCootXiD9vLiI2CLTOZKg+pWcupzOL?=
 =?us-ascii?Q?yMJd9On55MRaJ4frYBE8SRzA3Ock1ZsVGNGarjJlXPqW/95o6NK/h1iSVaiN?=
 =?us-ascii?Q?G2tF7CZgv31e0W3LVHLd427e7r+vhYGnb9vIhE3FN5HEExIFgI+pIURjwAfb?=
 =?us-ascii?Q?wUQlll9VszpH2G16H810it86joDa/dzGSypJQLA8JdY8eIGrb+o1+Hif31Sj?=
 =?us-ascii?Q?KqnayFLZZkuTqW2tOUqgLCABE3ByHLAJdSB2Jec/7RHlKkvh6T0CFoz9u1GT?=
 =?us-ascii?Q?NaLNmpaSMocZqk6DzlEcTDiNdGhEOye7OX4wMfy8Bz9cWgbpsBlX4amvoddT?=
 =?us-ascii?Q?5fJ+pnJE97X+mE+Oa3ArgnoEKN26Er1e1zOMLF+WhFEBzAB3m0wJLSelkK/S?=
 =?us-ascii?Q?ouu0GAQF/L7utDrRfPxBZhyjgM9U1WRs6DkCJ4K0//CoRO7W8cA1ZZARPWzO?=
 =?us-ascii?Q?iJ+trxs1Lx5IVJH+CCMARkpfg6oubM+uSGhs+j8WNrNH9wXXrTHbafzFX7Eo?=
 =?us-ascii?Q?GmJu8GAr3rTpxGfXK9y54D5pFxuED6xNS4dEBvjpqnXZd6dHEY7boTkggfwa?=
 =?us-ascii?Q?9v8i0xepvdN+QjdiMQ6G+JYJmuOB65WrALsRoxevXW4i+556H5ZQ1evmWoyz?=
 =?us-ascii?Q?4gjLgLfMOOGXSaeV0snmKhHz6LFMyaBx5o7K7MsAiIrdf92ggfpw3ZKtSzi+?=
 =?us-ascii?Q?nxyaQjc26M+drZbOgqzkDoDJSOMj80WlWtiYXpu7yMlLUWowVdhcyJ+5bRd7?=
 =?us-ascii?Q?Onz3y4+FhVVCHsdOQlYOyZaZP5I10PLSMJ5TiyKk2lz8kgYJ7TowdU2R8Pde?=
 =?us-ascii?Q?+aZ/rRUflNRWAEpdavAGuxkIv62WQyij+xuJ24CIv8IABFanQHe4q/EMB70F?=
 =?us-ascii?Q?I8v4ZayQ/5c/LQ0o1P/cDcuyOgGwEC7aAKNt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:53:57.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72395653-6ef8-4225-1a6f-08dd8f11b550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

Add support for a new AMD Ethernet device called "Renoir". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices. Also, the BAR1 addresses cannot be used to access the
PCS registers on Renoir platform, use the indirect addressing via SMN
instead.

Changes since v2:
- include linux/pci.h in xgbe-dev.c to ensure pci_err() is defined
- line wrap to 80 columns wide 
- address Checkpatch warning "Improper SPDX comment style"
- use the correct device name Renoir instead of Crater
- follow reverse Xmass tree ordering

Changes since v1:
- PCI config accesses can race with other drivers performing SMN accesses
  so, fall back to AMD SMN API to avoid race.
- add the xgbe_ prefix to new functions
- follow reverse Xmass tree ordering 

Raju Rangoju (5):
  amd-xgbe: reorganize the code of XPCS access
  amd-xgbe: reorganize the xgbe_pci_probe() code path
  amd-xgbe: add support for new XPCS routines
  amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
  amd-xgbe: add support for new pci device id 0x1641

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 151 +++++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  87 ++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h    |  30 ++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  11 ++
 5 files changed, 227 insertions(+), 57 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

-- 
2.34.1


