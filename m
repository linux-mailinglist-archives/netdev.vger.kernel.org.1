Return-Path: <netdev+bounces-240154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD5AC70CAA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4EE1E23F3E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0FC37377D;
	Wed, 19 Nov 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fp+eRXyd"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0553730EC;
	Wed, 19 Nov 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580217; cv=fail; b=L5j/F1mwFNKD3I2MKlMAxUz62HeT/zKJts8WsVLOp6K1c81z8Ew1KizYddgqQdo209U0Xk534V0sMeXFe19XJhzkOmPLoG7TcgGvygZExMceNankkrhm8Md9BGXn2zIzDRJ0mI1Ox4h1cOZ2M0HgLtE/DrCVnt6QuPQxcUti+oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580217; c=relaxed/simple;
	bh=LwvDOkgddVEBPexZsBotWmQMaL5clmk+iSA8lQuMlg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOUPYx1MuI5LNggatdrIFG9AGR9xP86qzX1/vZkC9oFSPZN3+ZaRj/M5rFOhxcCkEtKyNc+NA9qkajBsyNEk66mlBZ3MfRyYr+D+HuUYjFgen6cRvBAoto0zrW7Nw8N20tZRFq584QAvgzQm2Lu1StUVMYw7WeFmt6G0ZZyd79I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fp+eRXyd; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhhBFpFOva7oLZifx3dfu7QPqo/kGdKgy6jIyld9U+2v81E/5WCSwWeg+tpvB9fzZRu0BZ3TMYGSqgbaaocEWtDf5twzLG6N/MQmd/arsXNEbW7pvVwcgQixzbDcWfxM00gspFsUV5ZjvItKnbD3HJECKEQ3IQoCWzZwPJ6UX6lUDRPNB3hCkn1q0BHOPFhJj2uThx2l3/QQEhqVUlLyBqulST0GUO86Fcph6O1oBh3eUXph6qjLbjrcN/QWaxj7ZgzBXG6GPFbZBnKkJ/TiY3Mj6to5e8TDP3grFftwU9QngKHwXoQY1p9CYihrNBhqyVxb/6BThTrU6Td0HgKxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDHzldF8PeWMDh6D1mTmsT9q0ZQpLaoa21nrpPPZBL4=;
 b=X2qN9vVIw3AKwTs7FlWFOTUklmaN5xAtgzKmc/4JraB1s1+c6W1Xs2m97mrNTn97rlqiXF8dtOK8aZ3fyoOCrf4pbO99atq9S6ff6NvXEM81rQtQAoBbYObwyFxOrJgHfzYS97PQZlm+TNuvzLrwVw08Pg5UsnHqJwOmtSJRC31sFC453woz0eslAS9GfF5f8p1gbZXRqIaqx7TqJobTIPDiJGip+x4YojySEBldEqtoUGUyrKpzsBKQB7D4uptBa5PcqzHgsg+RdJbswydG6rMgm+OEdHEpHbFJqVTdk1B7J6wzoWz67uYHX0vfMaTeIpb3WuqvlYLJfRzeb62AKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDHzldF8PeWMDh6D1mTmsT9q0ZQpLaoa21nrpPPZBL4=;
 b=fp+eRXydvnJ7/nV8pMgiGnPUQuPS3OfJPNmzInnvyt+rboDAYG9Of4J14KbgS+00MtQEURvh97vt3EblSKcsno7ArpKchuQ2jD9y5hKY5r+CP9EagjmIVvyYDjQ8svH+6AFY+gsecKYwQPVgFMYvkV5T3ffUnAGQHSJeBlAbDfU=
Received: from BL1PR13CA0440.namprd13.prod.outlook.com (2603:10b6:208:2c3::25)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Wed, 19 Nov
 2025 19:23:19 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::bf) by BL1PR13CA0440.outlook.office365.com
 (2603:10b6:208:2c3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:18 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:18 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:16 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v21 20/23] cxl: Avoid dax creation for accelerators
Date: Wed, 19 Nov 2025 19:22:33 +0000
Message-ID: <20251119192236.2527305-21-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3fec8c-15d1-42cb-af0b-08de27a1189e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sgKEU7utKdnkAXItV/GJCEOCNznFDOGM0Lr3YPC4/MGUbvC0WAz7ncTl4h6v?=
 =?us-ascii?Q?LPwKxDUAWT44yiWdKsHWYGAv5k9VYMD2tPdiTeZ2Y7D1bdh01S5//hIrfKIU?=
 =?us-ascii?Q?A34kIVGT4jrI5Apg2sogEgDGMysHZ1efyc8D6KlcyLCvqUOtcs/D3C38XF3t?=
 =?us-ascii?Q?irYLvjawqNdFzuSkayVtqt+9mEW0bZm9U4yoJJ85lj7ZIkThFj1UxaoOFmFK?=
 =?us-ascii?Q?nhfB4dKDGqJ7LWEWJLi2RTD0CV6743SegIzSxsLMnrC/2lUluqbGzSINkYs7?=
 =?us-ascii?Q?/krhr/FImB1Wu5vNi6NT7YMdEBwI9M79gS3L6fbyj8j3hcJGyb7q/GGL3r2n?=
 =?us-ascii?Q?B8CS3azxi1zxxeuG0OOiIEtjeZdUlPGscwKzAWd/Eeb8R4yeH5xUtWeaZ4ED?=
 =?us-ascii?Q?4y6xzrToM9dVdlr/RIJIreUXD0VwDzsXodlRJyb2608E06rF7421gWoXjWsd?=
 =?us-ascii?Q?nufe+kLQmcKxycmkrRxbppvbgpHLwJAl3uJ3BP5kt+niXCKFYPchGNpmZp6L?=
 =?us-ascii?Q?20eCHW/RCqjE0TealMNv0gok7B5CI4jQzCnwyCxEvaf1C15StYSSqWaoCcUi?=
 =?us-ascii?Q?xJvW/5+eaZ7w3HP44B4YDHjHhv+Tw8F89TZPXF6Xe2ocGd/jyfH+4rsMtLJx?=
 =?us-ascii?Q?vlZErKZmDDvtwMzXxQEjqcoZ1Rqr8xZ1YO6A0Z8EWV7+HM2k4KNoCvInWu+j?=
 =?us-ascii?Q?5a5LP+tKiqKO/xVruIBR1GR5Mq7m9LILP/O/UElqSVDWtz2pL7kec7oX8V1j?=
 =?us-ascii?Q?kvz8MHBFYLuScUYDkz/LBc8imKR+99aPKzDbEKDHkVzuGaf760qxflfS6Nq8?=
 =?us-ascii?Q?k4zZJcCVBK03vVhfrULkYFS8tS1EUmactSR9BTA7FnnKqteQgZxD+pu0CMMR?=
 =?us-ascii?Q?5BW3ZWDYa/78+S6Ftank+6IMJwFjuYtlMTevILgF0giK3UN6YMfd5Nu+8Ceg?=
 =?us-ascii?Q?V/0p8bgIvIuw9lwtuk/IL/Kcy7LzIZSdU23uNxzMIsVDpTXS8/5qSP3kzRhP?=
 =?us-ascii?Q?njNI6wRgJPKJdghOuTICK1N2JuSpaLie2elIvjLujVMdZ2vS+cm5U9eWCvgc?=
 =?us-ascii?Q?VUOmLksdO6v2PbOQcopzjmfR+VOmhKPKWJQqeUjscHLg2HGzztqsyRev1+MH?=
 =?us-ascii?Q?ab16bK4tUCB47fEeUlRYNSbaie44sLs7B2xAhF9FdIl1V8yqYe/Ss8HJyTye?=
 =?us-ascii?Q?mGB+51W+GhdbC/g2cBn8GHsYNY9uWUoycDtmesvr+uwoqTaww0JJnYthAmqO?=
 =?us-ascii?Q?cGfeP24GyCC5GjBuERxoyphP0W2WavrodGUv6x63k/1G98aSQcQPtLxvjO+v?=
 =?us-ascii?Q?P4MLkHaxex89em8MP+XVQZDKsS5Q21KOg9Oyhn4brz+pSNE6dDGuI8cR24dR?=
 =?us-ascii?Q?f5OoIYldhkXJ3BhKKxQAT7VHLCC8lLJQjb8Cr8ZlQX3rHNpB7dEfa/hE+Yjh?=
 =?us-ascii?Q?CN0o+KEvEEHyMkVgovdd+r4g+lnMQ8hjNTOH3IGpKHhAr8ks9o+u4SLCSgQi?=
 =?us-ascii?Q?k56z6UWvEVQpap7KC1fdkJyXFV97EGUtMEWSCIRp4huyQOB5579SapXOM56u?=
 =?us-ascii?Q?azK7fvUzgbWcP49kGlw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:18.9018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3fec8c-15d1-42cb-af0b-08de27a1189e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3af96c265351..4f56d1ad062b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4128,6 +4128,13 @@ static int cxl_region_probe(struct device *dev)
 			return rc;
 	}
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		rc = devm_cxl_region_edac_register(cxlr);
-- 
2.34.1


