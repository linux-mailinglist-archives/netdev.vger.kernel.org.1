Return-Path: <netdev+bounces-176559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0CA6AC92
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A8D48428B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67294225403;
	Thu, 20 Mar 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iW8U/xKe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3A1DE3A8
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493514; cv=fail; b=IKrUsFHBUCtzZS2v3FgmMvQStgG3uvvZKz1ObK6uju3a3rNA4e7fFWz7O7x9qvM93qxaz4uX8JyQQgAe3Q/v8tcLVsp3Kp3JkKoEZQwnVd29NuP8E8c4Sd3TLO47hdN9pUHkK9rNX2vKMFr+0W1+3d8+M/9cMi+D5c37ao3zZBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493514; c=relaxed/simple;
	bh=Qd/RwwxSGwUt9EtullJmZmi3ZDhWf8gJlKGPFWIcV1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NDIzmJ1NGTG+qOAnhlwq7mUokK3tIl8zpEWGcBNOCSQ3bLQ60fqVhY07Vh9Xi2F/El/mNFLR6LHK9MyYpHMve/K1XdYRUZJAsuinOgaXr7xy78MPmb9Mcc9BHE59JQt2zRZJOtC/bhAmPMEcuLwYrtpW4j9ck99E2tXV/U4UCu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iW8U/xKe; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf9rKCpqG4U1bs/slLvP6GgdSUnr5uO/OvBHxmoRhwXXYTVySaNKwkAVQ97ePhaw+4brvRU7+OIOuq1mjtQkMqZ7EGCNideBlftEwmCkeWaYkfbaL+WOIMWarv6n/ADR7NY4zfP2ZtJTxmInI+A+lfGXJXAAYf9sGNGEORZLEClDBXy3woXTDNV8F+SSCP6bDkYolyotm2VR47xlZJ8nX+vDIQx9YuTJVFnId1dfg3pwgip1N2ad/aJIQ4kx2Nd+YxYnZtCJ8UoIOqKluE8fZKUJ0o3Sb4547Mwwa2iLymtPMRC/5fIEB2pxlfBZ3OtJ58gBGZ6q3Tp3FJgJGTJcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWIVAMVXHw5igoaaDPZ5r0J0F8Jh3MMN+b07TiGs+fs=;
 b=lZJCy4mk53nQjY34VTdeThAfEtWIsnDX+dfLT7eTE0CmzolckKfbSr2XlqVBCbEy0vWJe9HNPDFAdt1pEQD2F0oe0wOcxQ93RftPGwjmXvDZbj/oaA6OhLPz23mNtZCISVDj6IlPIXN6VAGt8rMYW1DvrqYfN6QFyAsCWEw8A8U6LbS4tCtnSRVNrDYV/YLyUrHoHDhdgH9j1MHA750vQ1i2uuCjX3zdrUheyM5mVqdj4NjZT/ZuQbMeHZ+Its6Sh7HbtE9ftQiJTn3wX79/rniRqIyFsA4Wr3fhSMSEVlH01jgGLZWuJqsyKJmwqIAiMPNXyiO2wzQbdtzAAr/yUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWIVAMVXHw5igoaaDPZ5r0J0F8Jh3MMN+b07TiGs+fs=;
 b=iW8U/xKerL1YhmSRkuSE/CA2pUeiDWxrGeZcYAi3xwjyZ/AhpaVJMUEwOyMw3EPVDRQVHhSfhdr/BiTl3Tmp1z9tCJ1qcHyXAYy6BT7sAQBACQfMUA+bKtLfN5PjVMZ1H4IC92tFq+L24HU530eROtIBqKZ42oudPBow28s+NWw=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 17:58:25 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::af) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 17:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Thu, 20 Mar 2025 17:58:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 12:58:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 12:58:23 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Mar 2025 12:58:22 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/3] sfc: devlink flash for X4
Date: Thu, 20 Mar 2025 17:57:09 +0000
Message-ID: <cover.1742493016.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dc99e5-5562-4f55-254b-08dd67d8cf4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgIVZpgY6g3R4OzU2l/ckpAqbjBDqz+5jZpFjyR+RXR3MiyDH023A8XHDRLR?=
 =?us-ascii?Q?C0E2lpbEzVpHGHBvjMJ/vfys4Mm2XSRKIf+B4ucVuddrmXh8eFbdMFLhF7Gu?=
 =?us-ascii?Q?RYPcEdA4W3KZ43MZBws+FgI2AHqcC0YHaF0Y/s7S14P/FI61p4dSPOp6gJ6c?=
 =?us-ascii?Q?KSSUpHBWKihUI5Wru0bZcxA9IEJMxVRmkInZ6iqZk9vs/aoummzYyfZDxpKK?=
 =?us-ascii?Q?PcQtXlEakWJUxZzDT+tUy5JlqcY/5ElS9I+REdjj1MT7RQz/XHibmxKtclm+?=
 =?us-ascii?Q?sD4T+dmHAzXniB/EvX9rfa4Rm5d8gx2LQwLCR5VOo0AEUodO/cmTq/jqxfUW?=
 =?us-ascii?Q?AqxOlbkqeyZWT9G/OBzSQeBy23DeHPMH2Iol8dSEtxt5zSt8Yv5tRrP34NNi?=
 =?us-ascii?Q?byqquLJSKV/g8c0PI0Lvs3qbfHUXvquTHr7/Ybi+kqm9dqKhiql696JH85Sq?=
 =?us-ascii?Q?c+KhO2TzBHvfCiY5BTh5YNnPcq5Yq3mp8GBLqGzcTb0sCqL0k475MgUknCPP?=
 =?us-ascii?Q?u05dV41d0gdYPr2nv0x2Uf0WNjYdQfVQaWhQVv+Z/GBK868ypaH9MB4HLAQ8?=
 =?us-ascii?Q?6VirSKODvnotJKulRDcnD1E9cKTaeSU0wwMsynPyxmfYDoujfbCpfoasEDFF?=
 =?us-ascii?Q?EZc+wNVXSrXfodJC7+UaW5ugzq6u3lDaP8vrsbVm3AeZL0+dWOsP5spfczR0?=
 =?us-ascii?Q?eMCINY/Tp6ZQuHIuo8Kq+JPIHrnUZaSQi1dOt/e1/d8b2CKQEvmB7Bn+negw?=
 =?us-ascii?Q?nIa84jCS//K0zA5TYmzy5N70El7u9Nta/Mu9sFVMdGG5MFxh1MgV8ioinJro?=
 =?us-ascii?Q?D2YY1g1w57hp6rPaon/PFZpunnekbsTfw6i4MSQBUPOGnENjgjA5r0PvHMym?=
 =?us-ascii?Q?LTLCdfTmn7/0di+cpARvb4SNbcqR9qSF0qGS2bdAdK41kD4ilNLyPjv0YSUF?=
 =?us-ascii?Q?Siyfr3TfO7kZHCljHFsHmFe/rgyOYBNZDqB3FJFZVkcE+51LJVEU7T990wyg?=
 =?us-ascii?Q?lBsfj6nAwvjozG0Ou/LhrqDrbqdur9m2ksbXeuCqMz/nWBIpg/lgsI2gi1zq?=
 =?us-ascii?Q?XOaMnM4/HoU45PQFlGAJI3air8hlwgxsYzV5275XjR/wwz5H0edYiZLpraH5?=
 =?us-ascii?Q?UK489ktwlKlMs2AFXkmhrL/ImOeD2oTQCS6VTToshPhMZtDqWedZUqz57FvI?=
 =?us-ascii?Q?KsnnPCSiZZEwECPujcV8dI2qpF7h7gjnEISiyUYWBlZdPegg+RB2Nw60EpWD?=
 =?us-ascii?Q?yRTbhtQW9+PhpESX33fwahY1TubE2/Kx/6dclPBVXZTNe5W3S9TfNQAlTZYK?=
 =?us-ascii?Q?p+iP0xUuU3Gt5n3yEW8FGpkF7j2h1YbQErSbnfbZFrcTPbA5+YPlUJSmxKtd?=
 =?us-ascii?Q?p9Qbmhp9T83eeOn/GbaXlwWnJBgObiyjEj3oEbHzxYiVd7APTHeR6kKaQaKb?=
 =?us-ascii?Q?07rXVC4rleEnLqkyRPkywU1A7HJQBQp9GvfV9IBvB+wYpJ/H71i7cWWdEBti?=
 =?us-ascii?Q?wGTYOvj9z8oHhqA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:58:24.4415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dc99e5-5562-4f55-254b-08dd67d8cf4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557

From: Edward Cree <ecree.xilinx@gmail.com>

Updates to support devlink flash on X4 NICs.
Patch #2 is needed for NVRAM_PARTITION_TYPE_AUTO, and patch #1 is
 needed because the latest MCDI headers from firmware no longer
 include MDIO read/write commands.

Changed in version 2:
* patch #3: fixed lock leak and removed resulting unused label

v1 posting:
Link: https://lore.kernel.org/netdev/cover.1742223233.git.ecree.xilinx@gmail.com/

Edward Cree (3):
  sfc: rip out MDIO support
  sfc: update MCDI protocol headers
  sfc: support X4 devlink flash

 drivers/net/ethernet/sfc/ef10.c             |     1 +
 drivers/net/ethernet/sfc/ef100_netdev.c     |     1 -
 drivers/net/ethernet/sfc/efx.c              |    24 -
 drivers/net/ethernet/sfc/efx_reflash.c      |    52 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h        | 20158 +++++++-----------
 drivers/net/ethernet/sfc/mcdi_port.c        |    59 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c |    11 -
 drivers/net/ethernet/sfc/net_driver.h       |     9 +-
 8 files changed, 8222 insertions(+), 12093 deletions(-)


