Return-Path: <netdev+bounces-148165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6E9E0C95
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A00B63862
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AE1DB52A;
	Mon,  2 Dec 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmUdnG2e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB591DDC18;
	Mon,  2 Dec 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159575; cv=fail; b=I8AmH0P8dWd6Ab/JLs5MubybSPSqSej7G3PoGRhtX6WodO4hHu84TR0gcVgCUesEQDToP538L0B516Hu2KpNs3qU/DKOJQ/BC8SlxtVPKYg1MReV2HcE0mpD5HGDM00frsdXpngRECkpXxNsxUDuUmrG26SsmC3T8BuXuNl4Pm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159575; c=relaxed/simple;
	bh=2XvrDUCB0i889nlfDi0LG3J5Zbfc78YrYtWicXTFBFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNa1ewc+z0Gp1drhRowlBMSG62VDpJt8VCXFt5OYDywR6+eJB3MDOKd8t+Qk6QpPqXIhyegdPz47wNMLp01mDK5a2QFsHlU5rOWh72K8jAS44kJlpgf5EMzA54Id0+o/PsshLmpzVMute6vdjH+DZ1pJ4m7wOeje1wqeJyJWKqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MmUdnG2e; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB4al7QszeO4mefIvR3vMGD5t7/BvQwnpR0vP6mrxdnP7KankZGfkrdw5kt2b4sDQV0DMGGWKSJtSihsQkFwPKSbUEO7Cn1nTo/xTBPLu0nhrczM0m9X45grzLjFrzioQ8Mx3d0FKeOGnDS11GvLbpUDzh+g8cPIDHBE2VLJM/j4G59TSWY6qSyH7fyRaEsAI8jflniLnGbOi7FLbZGJ3m09E9bOrAudXve92+sxaQxI276dGaSDUxTK4swlvvgktrRYZ6OOQT9HokDPCRrEQ1cJQaxZuqjUCOL2W8dJDYWD+TRFETtpQ8dlnhsUyjMLpTKYELcugY390tiVlBdKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orItKLFx034VtEFCkwdOcq3hacYAY4sDJNIno6KUeOE=;
 b=Wm2SR7J8mEr/Sg6NCJTJFVvHx6TXi0bcFPTADu+323j6GnNELGQ/5x3eA4SLXEZo9mgxp9GysAfusJTIZ2x75G1d08rjU00KISs+sKkxXM1rkUwdtIAUHzayk9inmHx6Hvd32d+5pR00MbpK4/06wAdpgbtcvlqNjzN53f9i1geOaHSFrpqHTvZwBARfW65xpnTA12EvbveVdpMLpn1iRl23AfExGqzTIlsOcKF2Z6yuNEKsas4CU3AkyCPSrKeDY0rQiDUputR3ik09Pou1nfQvNCBtwfYwNcixYleN8r+u+OElBcQzEfUt1RfG4YgxtrVmjzsDVLRSa2eIcDjmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orItKLFx034VtEFCkwdOcq3hacYAY4sDJNIno6KUeOE=;
 b=MmUdnG2eWyhpyokPwHBp9kvZc9oqFWV9F/3L3QatL7kdNFEb+LVXTuC/tsX83ycdQ2kCW3h+F6lPvB+9u4wH8rlvVsB2dKnNb0MxgQ+IeFSKacB4A2KV8rrcLiki8p3eiQ+tVwi/PHxGjQRk7w0ayBRJWWtDtl66ubQz3e+Qdo0=
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:12:48 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6b) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Mon, 2
 Dec 2024 17:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:47 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:45 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 10/28] cxl: harden resource_contains checks to handle zero size resources
Date: Mon, 2 Dec 2024 17:12:04 +0000
Message-ID: <20241202171222.62595-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: cad140d4-7e75-45c8-dbf6-08dd12f48baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n/2H9MljBb/0Sbxux6+l1EnpB9yXgMQpnBmaHogoqy/JCaOFJPB3ZWT+nhJ1?=
 =?us-ascii?Q?vwTru4dYYrxZss6hklWBf9iUmAUWtntBHXdlQ8vyFJJEultm1EpRd3NDNSG+?=
 =?us-ascii?Q?ImJDSwZeYOBw4aDjFqrRcHFjk64VHzKuTDc7K2lPe5OIyA4I20BDIYKAabT3?=
 =?us-ascii?Q?KafS7S0jGWqksJ7vuis6sFgRUUXLCxcMOXeUblyYYgULIT/rK37l9RA2YEvJ?=
 =?us-ascii?Q?rQA8LNh3keA2lfgb7ANv1fLdNeonVig+P9d0KzbQxmgcdqImo9rS+yKLl3SX?=
 =?us-ascii?Q?hcuJw8MogQijKhKmve57a24f6dUkMjXtSjhymwpCtK5VJd4TdrsfX1x5cs0Y?=
 =?us-ascii?Q?+cHsbGhi4F9KDvfy9dIds/YlkYvvg2/Esg4/o12ST0gSPA5xQrpbGs0MNO1C?=
 =?us-ascii?Q?nWA5d9E1qjVAZg/QSXFzkjpgJexLwrjr8aUYR0AcqAh5+g7T5kyXLFmQhUs6?=
 =?us-ascii?Q?QOrtP+GRIPQaPQbr/VlYNHBs21cYDLtXyIFpt6GeLLuDb7C0isZr/Z+FaiWS?=
 =?us-ascii?Q?CQ4g8KuojSURh1nESxvd2DWiP93l4UeIGlrV+bmHClZqd4xxXH1QIbB6594C?=
 =?us-ascii?Q?TeVcLPYNELb7fT/WD10eGq5Bh487yMIZo4O+tDXZiwaKv154fGmQWaLBvpLW?=
 =?us-ascii?Q?CS5mQK24d0I4N8JhN2VvM/0SFkyBBlUb/Uv4s1bMU3xvTOGw22zf7sh7KoIr?=
 =?us-ascii?Q?L/CjNTKg3OWYuPF3GL+akJaEdtbityJ1VdwfZLTbbHhvdq2HJ0o220nAAq9s?=
 =?us-ascii?Q?W78mFr/KOFMYEWspM4MoOOIdbRgw3DHK01+DxHGxmU1qsJAio916Slvn20RN?=
 =?us-ascii?Q?HoLZEArP8SZ5Lja3VxSwG9h8Fcex1h2nYFuOts5LHJbgolwcir+azc/RPftz?=
 =?us-ascii?Q?oGwyIQKwP2HGBl2t0a8x2CRYyEFRhI+LRTxx875P0TlQeq6PmWqH1mo2eNSy?=
 =?us-ascii?Q?QPWtTTeNTZenzCP3mG7osVbN8HM5Q236/+i2Ue6k5coovYgkM77CkyObRRrl?=
 =?us-ascii?Q?a8lMjBjUzVE9ylbFkDT+ikq6Eedwb/ISkPLz1dsJ/Q/0eIWtf9bOfAsu4b3M?=
 =?us-ascii?Q?GZRmNbjyQ4Eu4R13xhpFJAyi1DoKCub/ca48xrWndQldVvFVUUQ9YZNj0nha?=
 =?us-ascii?Q?5x8QxDWHd7lB1lVdeb2oxBwbn1+mEl+xZj3RxfY9pd4ly2RgQBBZOuOfOqaZ?=
 =?us-ascii?Q?HLSzf5Wgqqn9LcZVUiRqFE0RZSIkSbHK8gveZdAkTcFqkJX7HZvPT/92qW+N?=
 =?us-ascii?Q?8gBhpxMHrhx7guR+SVdu2lEb3MglMnB57Q6ULigr6o1egOviFErKgD3WI25u?=
 =?us-ascii?Q?VuPAYGauyYb7Ze2IjFMvS2ab/uirI/kjte8xhcsSPUypkwFDxYjg8ArkqwfO?=
 =?us-ascii?Q?lyrjs5cfgWlonvbuMIslHawtL1Vp8D7DLgUxlRa3ez75Dh5/2nFQhm+3MOn3?=
 =?us-ascii?Q?0ugMODrsthlh6uokb1NWyVLTIZQlV0VWSs3NxtOBN4RTEkudw5gcug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:48.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad140d4-7e75-45c8-dbf6-08dd12f48baa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

From: Alejandro Lucero <alucerop@amd.com>

For a resource defined with size zero, resource_contains returns
always true.

Add resource size check before using it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ff0c96ade241..fef6f844a5c3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -327,11 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
-	if (resource_contains(&cxlds->pmem_res, res))
+	if (resource_size(&cxlds->pmem_res) &&
+	    resource_contains(&cxlds->pmem_res, res)) {
 		cxled->mode = CXL_DECODER_PMEM;
-	else if (resource_contains(&cxlds->ram_res, res))
+	} else if (resource_size(&cxlds->ram_res) &&
+		   resource_contains(&cxlds->ram_res, res)) {
 		cxled->mode = CXL_DECODER_RAM;
-	else {
+	} else {
 		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
 			 port->id, cxled->cxld.id, cxled->dpa_res);
 		cxled->mode = CXL_DECODER_MIXED;
-- 
2.17.1


