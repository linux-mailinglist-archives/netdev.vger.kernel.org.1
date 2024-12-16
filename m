Return-Path: <netdev+bounces-152288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AFA9F357E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420917A37F5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52198206F0A;
	Mon, 16 Dec 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJyKz+37"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2438204563;
	Mon, 16 Dec 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365474; cv=fail; b=AyyPWv+afJsKrAT/TeyYXXkELHH24lU4SvciPp5TeNZaQUKbUZQZgaQbSmjh4WVfn4NrD20DZBmgMGJMrxsLtYQ4ivwXuwjQ8hpMsRKz/hifVJIzzCEndAAgW24vBrCyMGTyo9TKlslB22KYYa9TU0lYPM1GKMYclxakEwqs0Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365474; c=relaxed/simple;
	bh=SBktf+O1HL1llmuQXTza6TpomAcDKYjNe04l/7IubNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajFnrhkXy5uHoyILW+s+JXbqycn8b0jIszqGzr351LY+6rbhBltQQHs5fUanuCXLbVi57QEV0Vveh0z3JsfMSUQlHkdiayLV+etnD4ypa/lSMKSVFY8DRNGAp8I0J92AsUNfTvPcTkhfsjUa2wwAhRvAoRIgv1tzfs7LG+GBuV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJyKz+37; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUgigXIoAWYZGlSw4sj1+G4nmbQTL2WJsCwaf6JgQgnUQ1QCAbtNPVaqpbj1NmTona/Vi3HWUtPzv6ZVTUWClirq50HmRSa6O+jzx59s4zjcRZFs9VuBURqPadfuBWHTg3cfeGZWe1hTVR1EQdbZMK3m56bt7vkPzC842mpt6+hbAjk7zb77sE+cjhN7R9G3H0j+slfjPQ/8JsEMwGvR/vPu1S67I1icdLW1pkKzQJIF8JQ504xtSL9jwNhSfVPoYHgipvoAILHzTgDsmV2r0ssIBj6jLul8pcyuOt0PWpW/57ofHvlviPGAs//EBmycRfJF4A5+2L4WEEkYdPUnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y1Yswsx27rhVh3kIKnpme2N5P7pTPK4xAK8ek3z+oo=;
 b=MEUjnXopSzf8qKRaMUygxm5GZDc/FmfLrZ6ISlGewdirhv/eEeLO3i2wTWZpzbmw3k0T/+QKD3wpiooyDTTnT8lD0ptc+lSgBTL1EVHvjYliCQgdri0K8oN16HJHmwxD0ZTbDYxd/JOK7Irew+HiBnGbH/HYO9X06UmANjT81Lu5YOTEv/bRMvQRbsQ9V6sB94ByhL8lqEc2ix83p47UJUbKhqsS/C8rJBmbOJrYMFyAhnt0iJJUCKkw/SyVD8hXw2YmthG7edPWvsideSrpNK1qRmOegsx7We8Nc4xPJluQxZimfEL5iRa74p6+Wqpskvpf2eg6v/LtkxC9ygno+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y1Yswsx27rhVh3kIKnpme2N5P7pTPK4xAK8ek3z+oo=;
 b=GJyKz+37h3wu+yeNrEELiUqaBfi/8tviXjr7NT6iyxlyIrCL2dbhmnRh5XNYd/hy3viBy6BAAhsK8cFVEQgf41RRbp2XgyEuYgQmANh6fI4/qupbAI/7RtaZH2X/MUaO7akqHKJEp+MIPYwrGzSU2UyC+enZodwWLmhL+Yk25fI=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 16:11:08 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::d6) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 16:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:07 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:06 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 11/27] cxl: add function for setting media ready by a driver
Date: Mon, 16 Dec 2024 16:10:26 +0000
Message-ID: <20241216161042.42108-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: a658dfe6-e250-422b-f22c-08dd1dec4054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLn5lHjv0O5JVUa2kW42FEz6rEjPbwhCQaklUGT4SFQYf1AaaQzcgEEueD5j?=
 =?us-ascii?Q?71d+0iYMylOJMZ7V1A65X7mju/R9loJcGWKVNNhzyA5LXQEAQmZHh68zZWMq?=
 =?us-ascii?Q?BVL0rqlZqKzUqUrXkuU9ed4WLKP4GEvVWELBgbSRPWGjyVvkCvLbf4J1jTNE?=
 =?us-ascii?Q?0gJn7MWuoLdLfABHayK9C7E8W9PRklA5QfNs6Dtboz1Bb0DPRntqa6CjdIT3?=
 =?us-ascii?Q?5p8chC1p5EnhhkW3xHJPwXbntlwMqbqNHYDOLQ7DZjEV2RJQqBRtw/hu/PPt?=
 =?us-ascii?Q?TTqRK6bYQdmm0/8EzCSXSf6ig8AxVn9r41My9gaYZkPTURX2zXwywaqhxYHv?=
 =?us-ascii?Q?KdoHNJFgNhotrrahin9WhoL9AlvRLDGB90CHye4KRkJ9uigoABqXST1LRlga?=
 =?us-ascii?Q?aBNYk8KPlYoug3WTVA6Wco0+N4+KlxPFL7TNVZshOIpogs8wnY70FFipBNgS?=
 =?us-ascii?Q?WXYhHEveDSlkerGPlxTHaENe7Bv2ffaB0rIdW20dAruS/JfUupG5am1sdDWR?=
 =?us-ascii?Q?nI86xIOseiqF9sBi/zBAESWx3PuQ1OHVsW04S4IV/XrC/ORtmx40xOvw4cIM?=
 =?us-ascii?Q?pTjdg+Sa1mg2Hrv4ZmTJM2c8JAQZ9UilTWrrnUWPw7LGLC6t31x1vMhUCmVo?=
 =?us-ascii?Q?+lvTnNuhGWWJsz0wvEQ4LC3N6+XMUkMMfcXKJ8sG50a+SJ1FwGx5jmhM50Ci?=
 =?us-ascii?Q?U+yl+sUInK23ZX1Inx/dtcvC0zckFAbv8jFFfiGbnpAGuLUzpN/g4JK2+c+y?=
 =?us-ascii?Q?ruSIbUnEeh8AVuL0stVBSfsUimwThkVkzNxQ9kGAESq39oAQjlYplXgeIuSO?=
 =?us-ascii?Q?FQyX5V4WOsQN1N2smGyrpMoS0p/OmNte2ZzoE4q20rG0m23OotM5+XQQy5sy?=
 =?us-ascii?Q?05C02hBdyxinhMqIwDbvahx2EG7o2yOO4kRPaA91nqiNfy0wdQC5vFkttMu2?=
 =?us-ascii?Q?v1yvYijb97vdTA7xBX4x4oHXhlAIRMdmrE/Uzozv1KOTYWDrAXDtePop/cyT?=
 =?us-ascii?Q?v9bWcfEPoRXOucR0yfd+DQ3Gxt5lNJX7nWlPA+yjkuUAYYSU/RD/M6dgwG+K?=
 =?us-ascii?Q?4STBFdnvNtrVqVrTRtBac44ixWqDEfZcAB1Sg5sjpeLWc0GleddNr6ty+KGv?=
 =?us-ascii?Q?UlNVchVuKSh04CzJ2Dr51dv1DrdtToK3pJqMYCWp+uMgM/mTkfYqSWmSgcrw?=
 =?us-ascii?Q?FnOtEQMefxkK9guWL+SzLxNm0I9eEyYBFuZxrPSHqMdOd7AKSvNV3CZu+Wyu?=
 =?us-ascii?Q?3lpURo4CUoii/td2cOYBwOY2ktsODpYIezK+yrLbitUU4bop2DNE5AyVxdYL?=
 =?us-ascii?Q?6bziD+dANGaz8CwjtSlmilH4X15heyeks1Fby5xaADdsb88ttIV/8yyFN8nA?=
 =?us-ascii?Q?aNZVRrbPmhhnaEdHy5r0GoEUqXZ+Gb/G38rUyEstZBSjyIIYJ2XFSPI/hHeo?=
 =?us-ascii?Q?6+XA15KBkQ7ScS585rqjAZESNU/musSvqCGa7ZRamEc7PbTw4nbXYq7qYYCd?=
 =?us-ascii?Q?Y4JiDhw8joDxhz5bHzNCeGZKPBBVfLqU8hRB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:08.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a658dfe6-e250-422b-f22c-08dd1dec4054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver may be required to set the memory availability explicitly,
for example because there is not a mailbox for doing so through a specific
command.

Add a function to the exported CXL API for accelerator drivers having this
possibility.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/memdev.c | 6 ++++++
 include/cxl/cxl.h         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c414b0fbbead..82c354b1375e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -789,6 +789,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
 
+void cxl_set_media_ready(struct cxl_dev_state *cxlds)
+{
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, "CXL");
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 44664c9928a4..473128fdfb22 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -44,4 +44,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


