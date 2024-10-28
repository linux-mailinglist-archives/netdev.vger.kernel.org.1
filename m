Return-Path: <netdev+bounces-139464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB49B2B15
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E2C7B21F45
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CABE192B98;
	Mon, 28 Oct 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mSCOkdUs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272318C929;
	Mon, 28 Oct 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106747; cv=fail; b=cxiTU2tC4OvMai2vJCu+EpG0x4WHCSbqP5r+K9CBCYjnVU1Ggs4uy+qh+iWsgO/nRG+EmF9CZUOu+2TvRmnS6gufHG6+sIkjZxHL+FQmCmkPps+0CDfJBFcz9rKQu7iIeq8IdGSYfH2mDarSxG7U2imD/VLsyeUyZurROiUf34k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106747; c=relaxed/simple;
	bh=FV4Tr9bUI7hiSZWxJeyZUf3lX7D4Irtugaeaj/eVrbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gt2HPk607lDy9v4gUUYm5+ENDWqrqSzmnZ+O87199WWyl+U17bMq2uyfX9aoOumnB8LH3UgvgLtIKZRBhBQKyepXBnI0tGcjXazgDsjlqf5RjdqmKtWRZpKX5y2THxB4CNmD1NHHR+ACbL9mFb98vijkkWq5puWXC6l+Q1bGQn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mSCOkdUs; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBX+MCGZKumF0PqTIhtY6hbXeF017ldcvY3ZK6SdQ487Sk6WAIV11eLfYVzZllUq/nf+2lb4LBKCddY9Bfhj7LJA5itxHvAfBZZg/NKgJpyGaP8i7rsaCwISu/E4l0x8weZEpIVqFiLxK4/QS2jNO0vLJTxC/jRY0jOi4zl/uZYy95LVJAGM2ejHNshxEbE4JDtnZfLL8zZpchcWaEk70pV9wW5/RySXdzROHCdqWEJP36zrOr9lBaQkgka1gNzIcyK3ysu4i5Zau2jAQU9j0yfzoq3qwv6mKrVL6qzYDxYCEtcNZg9GBTUUASI0tTDglMoGYJ+/2A1m4IdTbuh+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AuR8X18923nEMkF2ZRoiT0KiluUbKk0CdZyiLWFLp0=;
 b=zQ6leJJFfFS7+JJrNkCDf4dR6FShVeCbSpthTiU3GFtxEJwnWOl76OGYbP14gbXaOCVYETnU0M2qV76Jh1rcGAy+InQ8n28NbBkqd2JemuvUC3G9APSuREQdT7o5UwQTdqXCcImRvy+hvbsRN/FoKWCTFIGxkf7Ooj2MmLynRI4yVTR0UYEmi6HmgLdKTumfx5PgsTfWQVCKPO4bbcazVUa2QrDtC0qisSt+BQivAEfDfS4mBwi1f/PV5DBpg7FPPWqphHT5f2NBtfQCdk1JbWtKwhD4pX0OaomrvRXSCkEYFGRzEIoPYwXDpXYXbGDYf5UuIeh7atyYj3rM7Dr4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AuR8X18923nEMkF2ZRoiT0KiluUbKk0CdZyiLWFLp0=;
 b=mSCOkdUsbmQ5XUgkHjH+OAHSavNNawdGuQHPLb4dGvU2wZdApRiFNe7cq7bstQpZ5xrQcwZIw2thiL+Qm2bhRVOh1FFUfXrvcsxnAzqloMzdZqcP1xU4gJaF7isQ9urgtpWj1YQEqrH5fAUyb1K4KqbO1TxafeNOWYbCwuPeWSA=
Received: from CH0PR03CA0435.namprd03.prod.outlook.com (2603:10b6:610:10e::9)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Mon, 28 Oct
 2024 09:12:21 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::30) by CH0PR03CA0435.outlook.office365.com
 (2603:10b6:610:10e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 09:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:12:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:12:18 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Oct 2024 04:12:15 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode property value
Date: Mon, 28 Oct 2024 14:42:14 +0530
Message-ID: <20241028091214.2078726-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 3415daa8-7ec7-47d4-d0af-08dcf730a0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+898IQ2KM5u0KXp6H6Do9gHkS7zOTDNtrtQvQ7Jqii7XzesoVR0v4G114jw5?=
 =?us-ascii?Q?6yArINWY+rFXvfGeg/mamTuM3oyOCGjw9Ii1+uuvmTg0hY39gngK5WFOcRG9?=
 =?us-ascii?Q?ClDG3lz5EfTx912XqZDNPsn6N3DZbsCo+vhKhRIYMxJI4KFARicKd4Lwd6Vx?=
 =?us-ascii?Q?NPFCPu8TQWTNIq6hIWkxgR8GpmhLqm0Wzr5LatDsoBiEKtPRMPie7ew18oG8?=
 =?us-ascii?Q?HHrAchxe1w4ierVI0yiyq2H/5c1xTe2FyRjsg579//JWopqhuDIRrCDXj06a?=
 =?us-ascii?Q?mmwfwU5u+V1TfiFV/sat+FhaUERoEqMciAgKLvr+XcShXt2Ajnwo+Dz/2JSV?=
 =?us-ascii?Q?q4+5EmGWT+MoFPGPGgNQzD2lA0+2QWT9UiPKlVe/K/hLEkIuvZ4uWX8wMPxJ?=
 =?us-ascii?Q?MYh9mzu2B8rnU/vRnpkn30FIsgKNiIz9CeOt9OH1Bmp7LhVgOeL2IDvqYlIf?=
 =?us-ascii?Q?kDSY2QjhzhicD05PEOuUFcyV6V70C45/O8P0w/2EO739kFXOEWT3BTwWh4Nl?=
 =?us-ascii?Q?usNEFmQOkfCluTX9vWAGmTFKR7r+rk/n9ol9JZH3KnmT88bGJoPpqmjOrFmZ?=
 =?us-ascii?Q?BAshq2FOzovmxjb3ztOLQ8/NhsM7HXLFOIUDJYacmyJsFUe1PC2nhjgXlNZ4?=
 =?us-ascii?Q?SwQXacOdJMLArQdgR127zbBJijwWMemRyGMm4xDoxbA4KCUZSLZ4j1T0Tnmg?=
 =?us-ascii?Q?coJWeC1j1GOdYbFAPO7reVlVUSq3/mEjlChQY5OisT+eYPOmL6loM/BbZD/D?=
 =?us-ascii?Q?e1UUyADncKaLvpUlBpOPVTBN/kM7IboR2HUpfjY5AIl9ou2j/ezbixDYwMBs?=
 =?us-ascii?Q?POcgOgmHb7hGBD2rJaJz2vg5vzMDw2a32JBZlP/qdQsxXqFktTsgCvOvDmmL?=
 =?us-ascii?Q?gCgDv0QLJNXUTn9UdfZd8HkaHPVC27dWljlkd4yvSKyMB7Ul2V07KHoE4sRP?=
 =?us-ascii?Q?2fBqKZqunbnu1VYmJgDIQ8hTPgTH8cO2GqP88ZoC6aEDrZrBEdCB4iYFRM3G?=
 =?us-ascii?Q?VvsBv5C2uEpVCQ4x7T2imzuQtXBBHbhEf4mDOCg56TwcD1XRPkb47Umi2g5u?=
 =?us-ascii?Q?fqFTPKLDC68FwoUojCofQUKD3bE2F2cIjNb/zLHxqPe0hq1779g+ktilkS06?=
 =?us-ascii?Q?quF3ZuS1RAiJlGIaGF6EZEOPUfwiveanHX0hdu1iheoStp3k9KLK/kmlj5PL?=
 =?us-ascii?Q?KKnbvTt72BL6hfz+34rQRGSAQ4Y8suUMGd2v15xJ7EwaauQsOpJlj8klpdc/?=
 =?us-ascii?Q?hcCU+/s+wrBds2Yck3/EG/qIgUTYgxzNQLLd83asCQk4Yr3SaHO+0LGxeuj9?=
 =?us-ascii?Q?cD2v/+zsUbXo6YfZXp8L2CzFwxYKo725x0a/zjjasqvaNeyFMmscUmEHm3u8?=
 =?us-ascii?Q?Kw7BNof5YsQY4xFZtXhKJ63w+ZjmG49875EsDFTmGRbkZB7PTHPfQjzrp8VN?=
 =?us-ascii?Q?bFIo3akPYNY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:12:21.0375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3415daa8-7ec7-47d4-d0af-08dcf730a0fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809

Correct phy-mode property value to 1000base-x.

Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bindings document to yaml")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index e95c21628281..fb02e579463c 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -61,7 +61,7 @@ properties:
       - gmii
       - rgmii
       - sgmii
-      - 1000BaseX
+      - 1000base-x
 
   xlnx,phy-type:
     description:
-- 
2.25.1


