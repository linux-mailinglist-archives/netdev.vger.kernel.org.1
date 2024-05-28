Return-Path: <netdev+bounces-98403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC68D1448
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAE1B21FDB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA84F207;
	Tue, 28 May 2024 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fXxQM+Q8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6D4F1F2;
	Tue, 28 May 2024 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877219; cv=fail; b=hdi0loV8yUFH9664P1WixyeztWdCQfJp/GpGrxlDs2K5sA6RSHSb1sWXPf0N22r543J98BgVoKVqjAcQWL6gkcJ0WGXEc+Ug6GHdJRWafzpVsxlkn7YUD0KbtLYqdz1l5D/356XLAUEkrFtRcDOLRne0iWVUhOJFOnT4IH59K5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877219; c=relaxed/simple;
	bh=/84PmwcWiAsWnEJj3aKV6aU/LHtp+0b1uN9hc3uizyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/7Hh6CBBgrVkAwAVHTOCfDSbqCmQTMMn8EVS7b7+6ttqr9aIOFlFD4VMLKp3YvBhBuzgn0E5R2VbXRxQxqK/PEFYJQERwYiDa6Vjl7uWlU5KcRb6FukY8jhfgPVSTKNdCf1OqhyofsL6j/3tu+HWThHm1UHp8lX4PTH0dqV6DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fXxQM+Q8; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv9zZqxF3czDXsgKcqx5oaIB/stM0VumGuw1W8MjzACBGkRIFX8vvAcKeXdKg2FS5IoVXNeuTcbYYF5C3ZLw08wV3KicPtpqvNVbrByQm86KobsOqFg3S4D6CtHOMW0+Ep2go9nllYO+9J3qbHk8UwWEQg7QGIku8n3/B6V7ejTjQ2uBh7Yfp6b60XARycq4IPhAzXGrhNdPA+zULx0RkvR2UHYVkc4IxRFheo8hJHJwanpGwIoIYuqBNU9J/dMsOTXBBoEnnzNr/TJ2j7OBeW6BkCVmxLtCR4DlxLtqOoPY3frfYP4+a/ov2NZ/eYI1lcsrU8vF2BRU7QCJAe1/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ50y166iv4tVd9uWOqirP3JXv2hZ4dczk3bgD6PVMM=;
 b=Eih8mI3YpHHxH//fV/ZL0dp1kpJ+Xxf+0O9PxFwKVcT0FIf7KY0n6SyWrwljiJBQKc0BdRF/NYo/V5u5BmHCwh3DJijxKtzrL2QPc02QDvt0zrKm/BJp6KYWRWC6v8guqNnU1JkvlTCCAG3ZbaNjD6i+UvG7AqSi3szKxIEpcYpSR8C9VobyoXTq7I2eugg2lIBE6WWsRFmDffrCYZzdA4w7u//VvapJNQ9LiJeC3thGmilpCCsCUMEk4f1TN63/Xq+YEk/yU48Q2FaiIn+xw+eSJEIfdCQUHluP/Tr7sDd9kT2CgwDuhUG5BZMOXG6OecsAx89zfPNCbpQzx65nKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ50y166iv4tVd9uWOqirP3JXv2hZ4dczk3bgD6PVMM=;
 b=fXxQM+Q8ne+LgPASKEeGvFKUsH0EnSJi+vcwB8ayW1i685XqnTq+HRY1LoJRkSpAgUsB+M03Q8/Ib9xa9uoAUMu3BQp7Vj+ic5mjuzDTORD+cnDlRmEB970dpQ3PPDwhwfm31o9HIJHFIfUHKNBxrxiIWfmLUBJvICyp2xZ7tlc=
Received: from MW2PR16CA0072.namprd16.prod.outlook.com (2603:10b6:907:1::49)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 06:20:15 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::3b) by MW2PR16CA0072.outlook.office365.com
 (2603:10b6:907:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 06:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Tue, 28 May 2024 06:20:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 01:20:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 01:20:13 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 28 May 2024 01:20:09 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v3 0/2] net: xilinx_gmii2rgmii: Add clock support 
Date: Tue, 28 May 2024 11:50:06 +0530
Message-ID: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc37cb8-4caa-48dd-f4cf-08dc7ede3cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xoy7E0M4ylrGHFOlF0hAgTL2PPlFcIu8ZQHrg9sx6YKq/xiJeeVacgXe4IZD?=
 =?us-ascii?Q?GyS/jQ4NRXYPNRrUHOq2qSCI/RALYdySM7TJI5OajC88UG7pllCfykIST6Fn?=
 =?us-ascii?Q?hLtfSLKXFWH/2fPLFGVrySZJyUr63N4r/0s85evrm2Beh6YP3T0017JSIEAo?=
 =?us-ascii?Q?08BdJX5HkJr3HKp+EJuKg+bevkKRq80jVdxdT3tvUgPdLJB11hVGih5lkxDq?=
 =?us-ascii?Q?MWcqmEDUsDsZx2pod6fManQO8Q2Ky+Lg6Ng2pzFuPKHDG8RsLPCFtM+vjDYO?=
 =?us-ascii?Q?/Qh7n/V0kNLg4hwE/K2e59ZpDLxATDnWgPO55OlxOigjlqtVVBUkSyvBDQzD?=
 =?us-ascii?Q?McDNbOCaqi6C2173hnMJu0lL8hAi3JEv4Mhsn8SF3wgbmoT0+KltTt/tLOyE?=
 =?us-ascii?Q?5zcZWbVxTUBtrNWpDg5Q0/YK/YQOnUlvi2Rvt5wH/Os/cdNILuRlaVnrexSd?=
 =?us-ascii?Q?WKDl1ky4ZZWCBtec8HHM/iS7t/ZjCSqiaDbfMc748vggNCqrT0wano5GWSxm?=
 =?us-ascii?Q?SnjxB2ockNKI7Zrz3jKGd647BMEqSvp0dQ21Q8OGdrMHM+rGTDKT6lcSDFkD?=
 =?us-ascii?Q?CzUjfc48krKMW/KlBTQBoKJHPEOCJMs21nylEDwtGi+iwb17AHRT3H2vMqdF?=
 =?us-ascii?Q?QHmqeT12Bt6vKgyPupRxFXvcpu7d3PyK56fL9yHIdMhjLzTP33ygzIp8AnTq?=
 =?us-ascii?Q?9sodWEsMFduSpk7LJIf15bvmgwaI/KnKDdGSKfBZhdcuwMAm9ao7HpnVi5yK?=
 =?us-ascii?Q?3296LNxPdH2LGtXLl0opMgkyz04uFTd+P+7FE2blYDx7dLnP7ntIN7Y8KV7a?=
 =?us-ascii?Q?hFPhE+ADOeSO4OkTVF+CKV3y9w7exyHuogmjDtwamvzv9RlyXAIkH07SRpic?=
 =?us-ascii?Q?njVTZETYSiSMp3DZtRFOjwNVwTMv6bcP10SzqYum1U4VIB/xqKCKE+lnP7qD?=
 =?us-ascii?Q?GKaL23ydR+s6SWQc0e9d1YaTMW8JbQ6LMMFtD6LcVAARP2hNfZr7urHxxmX+?=
 =?us-ascii?Q?vDB6m0up2Db9ne7jWE/i9KeVe2P1qSPJS300OxiE9GsgWmLwVDkQPtbaWreI?=
 =?us-ascii?Q?QTQsh1IbZGSpDF/zQSvxd4hooo7C6aehO0mBqrekplbdvkGqFivUO/Ohoo9K?=
 =?us-ascii?Q?DFP5RMC69Ri1zP8WL10d9z3i6UGg00pRRTkIxUw1SaShFWBJMy8ALy0JiFT6?=
 =?us-ascii?Q?rErCNgK/LM+8HBU2aY3VQDEhuMqNNHH1TsIGlQT//6BcRK/RbkJ4Lj9qc4B/?=
 =?us-ascii?Q?00g1o25YxcAP7LADNzdbgAz/Km1M5stn5SYcciZ9Vh+rldDAtTEA2jDBj9YZ?=
 =?us-ascii?Q?o8lmC/+35Cikefzo96oKJYi57uQp2oqXmoRm3Nqk14Ivxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 06:20:14.9164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc37cb8-4caa-48dd-f4cf-08dc7ede3cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

Add input clock support to gmii_to_rgmii IP.
Add "clocks" bindings for the input clock.

Changes in v3:
- Added items constraints.

Changes in v2:
- removed "clkin" clock name property.
v2 link : https://lore.kernel.org/netdev/20240517054745.4111922-1-vineeth.karumanchi@amd.com/

v1 link : https://lore.kernel.org/netdev/20240515094645.3691877-1-vineeth.karumanchi@amd.com/ 

Vineeth Karumanchi (2):
  dt-bindings: net: xilinx_gmii2rgmii: Add clock support
  net: phy: xilinx-gmii2rgmii: Adopt clock support

 .../devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml        | 5 +++++
 drivers/net/phy/xilinx_gmii2rgmii.c                        | 7 +++++++
 2 files changed, 12 insertions(+)

-- 
2.34.1


