Return-Path: <netdev+bounces-240153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC35C70CAD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 814112935D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC237377A;
	Wed, 19 Nov 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oVCVizM8"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B5430EF91;
	Wed, 19 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580216; cv=fail; b=X8WCglZgEDnEJTQ3XU5tLUd0TmCDCB8cXIN2gfy0xwAYBFl8xNXKuHGtHe1dUXQiyAJV4mCQ8klid/MLPtqXrMBc76/RkTZ4t9guiZRs8eQBxMzLj4ih0Cil5soisqZsleRLLcTSBXXz3FQPDVcHMmdmcpL/91+nm3AUpGfRfyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580216; c=relaxed/simple;
	bh=Alrc0hOVKpxaD3hgNhkucJLGgrY5u4dxzp+cxZXUs50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pokRUi5zo/whCN+JtnqgLeN5CNhbUDyA4MtAr6rrlxp3SpBOJ0Jb7OavIopzCsEdFjCt26xU8l7MlvASejB7Eko2PPU0k6BYkTHRLkHuwjpMFZ4z9l86iu4j1RMTuDoTu4N/U25neTaoYOmW9wQsAYEAZAOXqRIm4IwqVOtI8Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oVCVizM8; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT+hvd+807ICEjRUytf2RXFHxX5wa12ULL4YmRnA+WvG2oDwmO/ub5sJ6ZQKajvi6MFUXl9x1nZM2H7QCZXSzGQjN38QWh86MFjXk8LVlmp+bAhqsY71BvLTwB0FfnUWdifiXy+AV9kCzX4uCDXFUpxPdt5kr2slh8MlJ85EvRw0ABkXl6zyDV9NyePETMrOWKffuclgkho5URMnAVoUoTrWJVk5P95v0FyXE0N/eJE+MI6zFiA5wwTh2BbHehR0GwAHoEnKaIh8v/gyrdmJ/HuTd8g7BhRiY+A59IRkcYM7lxEtFJsYB0H4quw8oNQrlbhT43aOzTA1Mz5/EmkAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRvF8zYsbZaykC4+DEGvrNqk2RS4a7QMDUqKwAbLdVU=;
 b=x3yLj841L3C7dXOmcPYSoDK0+8VBst7th9o0cgvcctol1RD6/Vvb5ZNqdxTZ2KbIZ7wQ4g6axc3uYNtn7uALLbvNfbwUuKkKLYpyRel0zsoBGh9PANm5COwoq6DqV04P6iPLZ0rFrWAGHvcNJZWH7kEO3/LRbsYLNpi+Q7gi1hB8scSpClUuWIQrwswmL4zfQorLhXuZ7vR9wHqA00v9Rx7Dsbhea2LxMWTnHzVsJbJs7woECRLlSNC7RWCR6IY6TBPzc8e8e+mgZehBYsNptrIJEH11Se45jQnGmzktME+P1io1NJpKOdCBeufoi5Yte9eLzKbUk0MDtXqufXf4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRvF8zYsbZaykC4+DEGvrNqk2RS4a7QMDUqKwAbLdVU=;
 b=oVCVizM8Wr0qcrSX2+0v7cwWyrWR2b4/5hXFM8u9IchVLUtFSxLUIeVY+uYyOTB96oTRPETRkjs/u0XTXCG25T0H6PvB9zgAW8ZXGWJ7LUBYcuo6ChrWrlLAUVQ1anqlNbmtKdAPk++0fJ0kzHhfG3uFOhEG4Jyle/qPYDE53Jw=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:17 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::4b) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:15 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:14 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:13 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v21 18/23] cxl/region: Factor out interleave granularity setup
Date: Wed, 19 Nov 2025 19:22:31 +0000
Message-ID: <20251119192236.2527305-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0603e0-f079-4078-c993-08de27a1179b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7GuxoEeBHM/MbmJxdah65VIfMRqj6gTmfWbt6wiVHWTfTIrAjCTCkw5Hmbjt?=
 =?us-ascii?Q?sdaeZBh6HTWbckXpoZCqiaRkOKtH9nMr772uzc0jLa8oRAjG4cRmrMNtDeGm?=
 =?us-ascii?Q?Iec33xt/oBUrir0EtCcCSP7cj91olmRZCN56HDupgt3cMSLJE//jw8qTnzpp?=
 =?us-ascii?Q?LFOgD3H0OrMquoZVFSSC3vWQbQkuj3ysO9yNJw6Dx9ss1A/UmoTB0MN1Ukyb?=
 =?us-ascii?Q?s6LZqcPvfAoZTcjvl22oQCQkNnLQDn0tEyXeQIpWf31ZenerBOj02Yi0g7eS?=
 =?us-ascii?Q?1ulv1+TmMKOmDyG1m0eqTar/0CJT4bYwdoBNiywtZP8T/i3dXQAFF/beDnxs?=
 =?us-ascii?Q?T5qGjg05wn0XYgAqoy8Ra++Io3zFuS9OjrjFGShvmgKadOj/nrp0TyzL5nfF?=
 =?us-ascii?Q?RrJ/n7HLSGNgf+hwt1IH+iTR61pJZlbBqJF25kLla38zqhBVmkWC7L1qOMgd?=
 =?us-ascii?Q?i1Mucln539qo4g2R4x8bwlEFz7pUbCFyDsiCznuAc17oraC3hSyO+X4tiVFg?=
 =?us-ascii?Q?zyDCuwH+Ku1bYVptgbdmt/pRgaWdBq8EJiCMdLBnefOoHlETpzOx21bT1SmT?=
 =?us-ascii?Q?8Dx/1S3goce4Wh62NSpG8Jlugygnb0lmBxGjWR1B9toTTRWhmC372BrUxGu9?=
 =?us-ascii?Q?2aYujxDC70uUlCirwcaVBjKc+84sHl7XT56ZSaIhlEauM8LqjL9r2EBBKiGt?=
 =?us-ascii?Q?PgPuXY9tw8XEXUzSX0RMp70dILDXPWIdL1xJg1c3RdWkEVMqi0fTiz18MoBw?=
 =?us-ascii?Q?0eM/Pm0zf8Zn04Of+g+5Jg/e8Bn5VXn4YpaVUQcwTsTKN85vvZoyZchuG3MW?=
 =?us-ascii?Q?LbSV8Fwt1IbnUCPKdYqvPPvmc+X+4Y4it/YFbVO03JI6dCnOuv8wjTQWk8OA?=
 =?us-ascii?Q?FfFFKjRCG/tAUc6YMKl4a65FD64QMDrssGkXWQ9LfPtFYGEHgCf/T29THY4M?=
 =?us-ascii?Q?+wR50kg9dVHSTarCGewnPCkclZpsgflzC1COGoq3kLOJfm9DMAR5aShOZhVs?=
 =?us-ascii?Q?JC885rSGyt6vxeZY0AjRaGLWz277JCK81PJ1p9h2enVfaucvw9JlbjjP4RYM?=
 =?us-ascii?Q?7S3PmagPLPCSWh+cgzipnJFSDI3ogsSyPd7IGxNDveSTngKpTU30bSH0C1+h?=
 =?us-ascii?Q?IcU8SizUWEIwc7Eu2qA/GqeZthirTz2hxQyayBHU9FSnuuyqhufx7ZrgHt+4?=
 =?us-ascii?Q?H20ult0+8zX63BuwOWqg9k+b52Jw9oIZzItRgAwgvL6k0c4LTWaV2Scig2HH?=
 =?us-ascii?Q?cTnE9nGF/t0+CukehACFBp7MFVlQwAvQU4zfRszoxBapI38LYh81JycbEYDd?=
 =?us-ascii?Q?PAZsM+2V1jFb8PNBU5Lg4h52XA1xALnm8kggPk7DDEmUnU0cpZVaNgLKzwCx?=
 =?us-ascii?Q?3l8yLYqUDxzDtn1v+8heMG/En8iUY58X+Ol5tcZkhxgxcpy55549KWFXF6Ny?=
 =?us-ascii?Q?0D1ykbEn0vgfUr29ABSqhiXGp4n8JIlkeIeQrzXQ07M29hfMZwQ4hl4U6Jmw?=
 =?us-ascii?Q?e3yoDeENDuFHSYYIzlWawcwfQ4D8bx8wtw4+YOlwkx5lVtoqIu/k5IWK9Swr?=
 =?us-ascii?Q?iMKZPO4lf6GZrxy3w/c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:17.1168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0603e0-f079-4078-c993-08de27a1179b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup forinterleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d618adee94e0..1b0668fec02e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -565,21 +565,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -595,14 +588,32 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
-
+	lockdep_assert_held_write(&cxl_rwsem.region);
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
 
 	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_granularity(cxlr, val);
+	if (rc)
+		return rc;
 
 	return len;
 }
-- 
2.34.1


