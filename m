Return-Path: <netdev+bounces-207351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5933B06BDC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 05:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E52016D4A5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24326FA4E;
	Wed, 16 Jul 2025 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="RRlgct5/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444F522F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635042; cv=fail; b=I3b1ycx5RNqwNPniKhXxm80V2xlP92C74xoCBD6WWNN5ISGGIZLBWMWr7+/FD20x0qf17+ghQls/ie1ve9YmLc5Sh45bOUTg4eLisWqZILmlmnCbrhb5RPSY9x+qbremWR/u9iBTsDPW7N4ReIVZZFJRnH/MCX3ffwatQL3GOkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635042; c=relaxed/simple;
	bh=C7525OWD5Ck5y5yiD23m6QyYdDn/ckamMc1d/R098uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMDY7OqTHW1QQVYjYnbfoUTR4HOg61DO4QMcfa0iieLzk0j9ULXgEPaFOYpR+gumstvyQC858wAytsYCik2V6KOHIcCRuJiCv5pADwXEtdWqaD6/vN6QMPOfYxvVoOvCosV1IRfqZtpejfAehK3fVVVEqI1tXL6GSHjpWW7nmU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=RRlgct5/; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSz6IJlznYkvAy6EaF4ZXsMtMQ9+QTTkp+gnrGBBUAhTOvsa5yNHiVrRVAIRLBBHowYLUN9kwggpTUmgPU69J/rHcsN0y1ibBjLvw18WVk7Z+X5PdTBPTT5kb2WMwdZhHAQYtKLbS1omorrMZZLHad+Dr+WJH7p2ntAOlF1vDSvQIe7OXPP8lm1VTPRCL6vFdX5vpZsAoCywsP2s+EqjBsO1Fz2D/BE9uAbSvzO6PpLs4lItBcI9orEuMLFKY2alY4r33yYhpV9OF7I5PhyXTudhECy+oIN8qubK5vCTTQnSgH7XeuKBUbOW9tsHgrjWblNEJTjhETcF20V5LFx38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYbw7PFB1ylwgl6LPz/FoY6JJZ/MNPgI2KhnR0WKAS0=;
 b=dNL6YNMWNtQyoP7dzDHrNYkwbK4fPDLlq37mez6mAN6gPxQQStSOs/ObB+qGCis30mEdZQ3TRXnHgycxXANpzI7lq9LDdBcFAPAzj/YxSrpgmJhenuEsNtxFF+k6PM1ZFgMryLOe47ZSrc1ZxIYZw8Zfp2eFrKx8royAZ0suZJm4TYfPcHyRfc8hZ26wZnsUpIonvGM68xHJhNBHP8n7iBnxModyUHDcgsu7DLISkyXpUAIQfs24QJyBTI3yJacoJ6kK/GfV1EFirhteaPKqXHh2sM3fDlE58MdOQ70wPBUqlPMaGtNz3905wqh0DCidbdEnZdhRlG584c5WiRMNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYbw7PFB1ylwgl6LPz/FoY6JJZ/MNPgI2KhnR0WKAS0=;
 b=RRlgct5/sapCGpkEBCn9XSalGLh6fZcBZ0ybzljQwSkafE0R7ojfkUGYC8mH7lfgSXZ19x2KeyFPyfJdGgsoLgd4RnitenYt+7GESZqje1HAjT3FC0LOlg0+w7qpMTkJl/bCOsfERVv+XtwloKrIn2omSseYrUoHFIkUVNbJcGIlKeNiSJz7FWgjNq2aBuMYTB+QCFe8A4uNClLKLjwInN79OuwmY5uWNYQPaud61CCLq+rLHBwqjXlajFIyPoW4R2XP80L7hA4VTLGYzgmj8AnPc69ug1YwELwSIq6yYCnKxDG6rDP1D8SkIHbXZyCNHyhTHMvgMQPoQn5KiDdYdg==
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 SJ1PR19MB6380.namprd19.prod.outlook.com (2603:10b6:a03:455::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 16 Jul
 2025 03:03:56 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::3b) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 03:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 03:03:55 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Tue, 15 Jul 2025
 20:03:52 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <fancer.lancer@gmail.com>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next] net: pcs: xpcs: mask readl() return value to 16 bits
Date: Wed, 16 Jul 2025 11:03:49 +0800
Message-ID: <20250716030349.3796806-1-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SJ1PR19MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: fd88a858-9a65-454e-94d8-08ddc41566b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llxqjEYuZ34GAyvwH3FmAhIWLyueoV19R2DR2J2sj5DuPax2SQthCqmsTkY3?=
 =?us-ascii?Q?rYZ/AqEridu7H9TVOqH9m5jAQ2ftKbfoqTVDXZNld+22UWcepValkYKN3SFg?=
 =?us-ascii?Q?0LW2T5m6CJwOcCYFAsA7J/Uf+klPq5xmiyTdns3+FGoklVTwHLU469lWwGxc?=
 =?us-ascii?Q?FyFTS+j9RwaJjmEEjDlLKhq6wFPqFghGDEd2MTi5nwwaPo1tfnBuNC86XFAL?=
 =?us-ascii?Q?YvXBU+DnNBL5KwvpDpMbj003IJoT2aEGXzl1eLJXKT/CoAHYIN7x9DbsUItg?=
 =?us-ascii?Q?+roB09TRkO8IctvkaJDrMLcIl7xCqSwuSpgqwmDBZdDoIkPIg1Omu+9Akywu?=
 =?us-ascii?Q?qyFJf8rCCI30D+BPDfm0qQt/aBImF/5T7pJFc979V0IffKnAS2HzYbps2lWd?=
 =?us-ascii?Q?iYkyA0E6Z3eJVAknnbsaSuVf5tZ39dh0TgEtudCzttr5hJC2I9HFTYwdq8rJ?=
 =?us-ascii?Q?d2bP1H/j7lDQawWZib1/oKtMDRm39hsO0LaJt0AZujiJdkV/693J5S1S3WB8?=
 =?us-ascii?Q?BZ3reqNDJaYdl+EYbnpTbABrJK8uHPZs+HRMO/I/pHci5ZREjm4K1iBJ65PK?=
 =?us-ascii?Q?nuqpYR8FSAdKeDvVWLpz6hf2fhHKbdNXpNAPKameoJAkfL3YUfQJ+CyrIvRA?=
 =?us-ascii?Q?QaJA1XLcYJLlrlzXfyehI2o/zPeuRzDW0TMZuCqI6CHBu2bFl028DF3ar1gP?=
 =?us-ascii?Q?sopiTa8o24WSzxZqYlFWQQpX1eka3qb+/Inq0GnD3tC1es344VlxH2Vm1trx?=
 =?us-ascii?Q?9MxG8oR8ZNtHvgTjvLoLuhXfAi2xv863fQoyjBZS9MU4N5GDJebx5lcZ0BgS?=
 =?us-ascii?Q?jI5fCZxRu5u+eDFqIBYLsXqivWmtj5Lmj4wbHVs3qNwsobn3bGiFHy5dgUP5?=
 =?us-ascii?Q?zX+1aFLwCRE4VPTxF2awcpsg6xxhtQRD7Hpd1UDK1PgAHDtw8jryHq8jwn8B?=
 =?us-ascii?Q?bjGb4q3HFNPUd2raRwD01Oa52UThxOOdtvL7C1DAl/1s7mGVOEB6+Uiaw0N7?=
 =?us-ascii?Q?QUNVMWWpuUgMjoxLC6kEhDJmgz4tXqolF3/+ZniCPrPuWECyAy3t93NMzQMY?=
 =?us-ascii?Q?u5zf36LRyMEa+GSeU/dpul597UX1rD1LIr9SjfjXTWziCWYGnqYxtrNOBZ2G?=
 =?us-ascii?Q?DhKdqPVLy2PQDhhe+Gxo7uY7qXmp5pQHuBWjXbYBZjquj3PuB8QbujFXwD/j?=
 =?us-ascii?Q?5AoBGNlIMEjopWnrgyc5G41t/rmFw57nblazbCsbcKWm3PQDgGe+gVPgHQhB?=
 =?us-ascii?Q?LJK/WSZYE5vKhvAL8CxER0TNFJ6P3SDGd6vQg3dVl56s7IucBZlZw62nq1OZ?=
 =?us-ascii?Q?rif8urS+7tcJAfIaBxgFIBFaBEhXTKKGAiQkKgUM8hpGI/NgMWgI4Y1envrh?=
 =?us-ascii?Q?DDWxTB8IBHZPnvZCNJTZEaFDH/Hxq3KwrgxF9cvYmBHj7Y/eKe2CiY4M99Cx?=
 =?us-ascii?Q?10qzv4hPtiTI5HelFfxOUoHU6lwlld/hxS5LVckc/WutahJ1zN/rygoACoA/?=
 =?us-ascii?Q?zCDZOciB1T+agMIvvclC9aZCQ2h+NnvtIJvL?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 03:03:55.1946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd88a858-9a65-454e-94d8-08ddc41566b8
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6380

readl() returns 32-bit value but Clause 22/45 registers are 16-bit wide.
Masking with 0xFFFF avoids using garbage upper bits.

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index 629315f1e57c..9dcaf7a66113 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -66,7 +66,7 @@ static int xpcs_mmio_read_reg_indirect(struct dw_xpcs_plat *pxpcs,
 	switch (pxpcs->reg_width) {
 	case 4:
 		writel(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 2));
-		ret = readl(pxpcs->reg_base + (ofs << 2));
+		ret = readl(pxpcs->reg_base + (ofs << 2)) & 0xffff;
 		break;
 	default:
 		writew(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 1));
@@ -124,7 +124,7 @@ static int xpcs_mmio_read_reg_direct(struct dw_xpcs_plat *pxpcs,
 
 	switch (pxpcs->reg_width) {
 	case 4:
-		ret = readl(pxpcs->reg_base + (csr << 2));
+		ret = readl(pxpcs->reg_base + (csr << 2)) & 0xffff;
 		break;
 	default:
 		ret = readw(pxpcs->reg_base + (csr << 1));
-- 
2.43.0


