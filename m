Return-Path: <netdev+bounces-180418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C310A8146F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB47B1BA3D5A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2076323C8DE;
	Tue,  8 Apr 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3GFje25Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622FB22ACF1;
	Tue,  8 Apr 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136438; cv=fail; b=Z1/+lmjLAyhQQ1sN30dZ8b7rvDyEGh3668oICqEqbfqYefKJJ9EdGAKDSFC4i8n4fox5o0eKXE2SIzyT/A9Bsb4DwPpPZquAraYJaTS4IjdaRsDHmR9DbHHG9tyekLdOfOgRkGns1+BPYE549NTdCffoUq1fDjzNlkazV8SccOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136438; c=relaxed/simple;
	bh=ZEpMhW5iJa6YmzErvZK9Je+TPIp44EnimCMIqHEBJc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d4abFlvpMWM8/MAryhBdZoRoNbu272Aq7FP3RX3Y2eaN/NeNC9COx8gUStrInD8ij0mjp1DchpmxdyChiD3w00nP4dW820u36q6KsyLX7g2YnNLcJE0JZbhpVnqXzXQrVHU7NF81hdwzhhRJMG5FCr8ogbOu2f6foCFgdySOsIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3GFje25Z; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRMuXZZ+LQBKNNVnMm+0rxuaO1CEyCA6ZOj1CycDqNXPt9Q2tI7KMhQkKbgEChCJoDgxLHkpY/KiA5fPmx/1GKdB/1ZFqyWp4MHWLTbAVn/EMZK//rKbwFy5ExsoumL8SPO5C3tS+IICgtlq4F8hRE9pJDOZhpOtDFaAG+YljqoxPkITzU3VJsSX73lJsFB+FzeOZ+ACNP0p2Ny3WVei8ERy0j3oN7uCFAQk1hoo1R1xY+KxQPa6B7NqGasjnhESfLdPTJL/DON1CvIusmBCUYwPDWx5XV2ZWiIB9E3CP6Iq5ktEemp4tMvRzTumVKkSg3EuW/mOTjRpMI+8YLXmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4sZcpUcIwBCYD8dtM40SFu/r6s3C+dTasjj3aNHFdE=;
 b=tvBkW+yiGc53bxe65V91muIjH8+mxwJ3O8FaOIb6VqZS20oXSh10MNjdb9hesDEyqbxHi69OLY5AE/xu+yQJy1UPyZ5aRq+Ex7wYhIVaR4aX6E6FG+gxDyjND2e8PDtSJf4n4KQSzyafFBlFM54zJITNtMPg6eW3GC7WX5eAD235xeCyketxTGhrwbeEoHERkvNhnwWvxtxbY8Fg7n/M8EsD5Zfi8k+KJXM8IMh+gBbVthZIVMiKqJEsMyT4LpoTtb/FPsItUoSld1VYlOImd0EMMBmEaWwFGl1+irAkIxb409wIAWbKeKwF+C3TL8zW5P5GrsPlHV4JT2qBTB2s0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4sZcpUcIwBCYD8dtM40SFu/r6s3C+dTasjj3aNHFdE=;
 b=3GFje25Zp76x8bm/aLDoDxa2oLuWw4eJ76YRxHLNZfmfA2n5oNkwJxeHcJ5rx0UF0yT4NHllRir9iX2AeRj7D1kPmxHDAqZS+dSEgvj2x1RATLeL4X7XjuFq9yCzD/tX8lr9LmQGerSacRnssyIdu6w0YdRr10fGIY+xWLzR5LE=
Received: from MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 18:20:30 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::6a) by MW4PR04CA0341.outlook.office365.com
 (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 18:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 18:20:29 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 13:20:25 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 0/5] amd-xgbe: add support for AMD Crater
Date: Tue, 8 Apr 2025 23:49:56 +0530
Message-ID: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e089fd0-30f8-41f0-66e4-08dd76ca0aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fDWNbyZSe1btrSWNEbGhSWZ9BcdZR8U/qoV3d8ai3hGdqp2hxDV+AMdEF7fE?=
 =?us-ascii?Q?xBF4+E7we/DRVf2MPnWUtL2ppn2S1F6bE8VRrB24qO7gT8bC38zxijxhE1VO?=
 =?us-ascii?Q?wOrZlXdEuOoMaggXA8Lw26bCyzy966HvHZPLa8ALJcuJdjN9isfJPx6+SDVO?=
 =?us-ascii?Q?evkrpAlRHzhlQksn7bjextdH8sNaJriWEi4qFjprMAEuRUTViJt/DHYV4mrd?=
 =?us-ascii?Q?dzs+X0RGGvPjarl5MiHG0MAMXUmtSTKKPvvpOdASO9rP01KZwLI8wgR9OLBq?=
 =?us-ascii?Q?No5aSA23xLLdNEFQt7NE44peuBPNolJ6dJQMq+enu0yk5mg1cv/HpIJ2VFh9?=
 =?us-ascii?Q?H5l93yLiwhJXlnR15Q7SOOhCIu7uQWu91gYLJOHHZ2728K/DroyD6KEQhLok?=
 =?us-ascii?Q?xxHqioSWdm5oMlz6eC+KWK7De6QUbo2flyYzSsBS5TSMdC/uvzGh3j+DAxTG?=
 =?us-ascii?Q?WyoqC1UmigNmvWuEAsfa0/1S1aBTvP2mqlKA4fyuIdpq/iA9rYXI/KfreWlO?=
 =?us-ascii?Q?plAY1G7En68zGeAtPcbdPXoWv4fa5U1Wxldu0Q/rWNEUVBJ5mb/P/Exp7f+H?=
 =?us-ascii?Q?jXAh/AljtoZ48XVuwUHqGvm46Z7DtrXZd0DhKRHDgRBz2z5hFZBFDSSOfOCc?=
 =?us-ascii?Q?CrjcwbIVXVXdf0CbvPKerrWiqiCIoiTUJscNxXieEnG0Rf/aqbDZ8/khXRml?=
 =?us-ascii?Q?niGk3BDwo6UlwyxdGuyfSFwZM5G1BdKqvpRjIgKnOyjvfbCqbJus8kVweDWu?=
 =?us-ascii?Q?1qO1OTe5gFmkfzLQvJnUWCnGnu8g4Cs8zXasrx/WomtW+zVJk22/2ValyYaN?=
 =?us-ascii?Q?NiinjUOhO9O+c9uLw0SLycp/9SX2TsK5HV3zxr2lN0ET0/HuRbCnK6VDbvX7?=
 =?us-ascii?Q?qxe6yF/thFgvVv6/4UxZ6p7W2bjg1rmW1MsSfpSyp2cLDLK8l5gR8Nn1bddx?=
 =?us-ascii?Q?uLe5FJeZZulLN11Ts5gaTQlR/71nzN+5YBnqtI1col+Cglo457q/OZHUErjT?=
 =?us-ascii?Q?gtDcTlopzVESXTUz9qVGTD3zD5th/pIkB+qZAZ31CvLA6j/2GvyjZ1sVCxfc?=
 =?us-ascii?Q?Og9iAbJ2luXOJTh3jvgNPHwmO/kORyItn40OOGZFVQWRPHw/l14sQbcqyy+/?=
 =?us-ascii?Q?DChWEcaBHLJ0t2PIYROVpyAIDT6Q0Ec/gcqf3VXJmBYu5PSQueYGCyC9b1hn?=
 =?us-ascii?Q?nPV7Otp/9iAn8EFRoThBeQ4UPS3bqCbGPJ58yQA+kyqDkNVRAx270OVL+dsN?=
 =?us-ascii?Q?bV97mOdfoieJX3yfNhU9/pB9N6QDo3u7WlVPleIgmaOqQunQkihQzbLbwzEt?=
 =?us-ascii?Q?PSCgZktLJzCssGUBLg+OHgbAprukXgsmoOEQyWl2TWUXLTcNWD8xM3frHI4D?=
 =?us-ascii?Q?KZev6jN27CYp6UpzvbIUzdSE4PFaPsmtPwX9ObRFM8mW2khB1eK/8BP0U8eu?=
 =?us-ascii?Q?VkA4Q2NpazDLbveOsNtgYPBCBzlciPAZhqxeFJKNHc3VBTA650SAdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 18:20:29.0531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e089fd0-30f8-41f0-66e4-08dd76ca0aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

Add support for a new AMD Ethernet device called "Crater". It has
a new PCI ID, add this to the current list of supported devices in
the amd-xgbe devices. Also, the BAR1 addresses cannot be used to
access the PCS registers on Crater platform, use the
pci_{read/write}_* calls instead

Raju Rangoju (5):
  amd-xgbe: reorganize the code of XPCS access
  amd-xgbe: reorganize the xgbe_pci_probe() code path
  amd-xgbe: add support for new XPCS routines
  amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
  amd-xgbe: add support for new pci device id 0x1641

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 142 +++++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  85 +++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  11 ++
 4 files changed, 185 insertions(+), 58 deletions(-)

-- 
2.34.1


