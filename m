Return-Path: <netdev+bounces-150344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C49E9E93
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7594B164D81
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD619F43A;
	Mon,  9 Dec 2024 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JRRLKm4l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C941A00D6;
	Mon,  9 Dec 2024 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770503; cv=fail; b=qe+ZbROo/K6YL9p6pKGxNCz1mNL2EkH+WAb3hqHgPGsJJB1UZ6KdGPKal4UoPQz1y51Fm595zHBtZKzsNJ2dumSKrex52+BzpY03KobwHbgIMWFBmr35BLK6LqnKNA7l1QboNFokNrZmw4GO50HQRIUdw+RGLgVvpGVq03iWb6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770503; c=relaxed/simple;
	bh=qxHyGcyH0wbJE0yh9CZTHwdm4Zte2HjahBQYPdzLEac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNZF0gyfP6qpjwf9sSmhBGPsgtfQDAqpH8owxzstoJU5AxltM1A9/ON35lIc3/DbPC/eeu2NRfZqxwNc9m3ynUaIMZoPxWsp10el6fUQAZcho2FtUFqioo/Ya4eUQcRA11xkzWw+npmOuQ5S1WIEFHyMYohZJxbI/BM2bsU4N0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JRRLKm4l; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMbJWCKXbABQO29OBIW9T5Q62vvHoOFk04zXRzmVpbA9x7EV4wXGWsM01/AoklthLl/PmmT7eOrXOWxX88OELfBltpB/fnoJtt2zglkQp6a734Omg9/xoVd1VW7vBW1ioek+uMBfeBfQOFfTTBwXCrHr8bMhat/YFprOMEouRuk/vBftRBY3VWIRcgPCE7E69LOo/epbEUf1R/X2lz1jK3KEHgeLpZLKVrSl8SGVLsv90YhGCiJKGGluoumPiMSff+m1Wp1DufhABbpvg2PFLlpt/KvkCowVu3/9T3M27h9IlXCfLDqxYZ/kO+1ZsHcpzhjpvV5LbCm0gKL+YeNKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axHuBV8KCq/PQRSqxDwW6/CsshDUfaeMi+M9uBWz/hs=;
 b=F5WIZimCmrsvG28eCBOYfRvBwhJEuKi44fYZbNXmlwg8hymma29h0SMc6+egF8GeIbX2DbdH4FjbSC3luHdd49ywbHZrEKJrl3dxkWIGm9HwXQx1kgq2lx/ffp5tBd7ezlLQLFnl1OTpkhjeCSc5wOJWKsMTaS6RXyPY3xcJVTJoV4fbJJngJ7FB3bNDR8V3/QcybYG3/889pcBnaIlaKfS6FzpDUttnh7ulW/Dlu4HURMzWcvzoR39j8mpBoptTyCgOqcI+iF2O1HPxGx73lzPqVtXqM1xo/ifpmGJNVWT/W6uQ/AO/6LFJfvVGAuNoPKienS3xXAxz9wyrIV00Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axHuBV8KCq/PQRSqxDwW6/CsshDUfaeMi+M9uBWz/hs=;
 b=JRRLKm4lKKJVBEqasksc0CxHxRHQsNG3ccA1vGfV3onnB9by0X7BEeFI7XERAqYMYQUm1WIQNUoYYOKun09mKyrPXyb2dq+NEi/rUtb+YOsT7JM9TUr/oV8llBPhVAdqdZVT6QApVA1/0vIJ12wyBW1LuhiocwwvMEOclYzunY0=
Received: from BN0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:408:e5::25)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 9 Dec
 2024 18:54:57 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::17) by BN0PR02CA0050.outlook.office365.com
 (2603:10b6:408:e5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:55 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:54 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 12/28] sfc: set cxl media ready
Date: Mon, 9 Dec 2024 18:54:13 +0000
Message-ID: <20241209185429.54054-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df8dcd9-f55f-41a0-4923-08dd1882f979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSmKCrqf/MDNAci7ZU1fR6Fy/wrYTzsMazZLzMA61E0n/iYImSKrJUch7ngS?=
 =?us-ascii?Q?oGRNMg8rsF1o5odJ6WGCpZ0iTROV6sDbcpwZkjCZ88UkOGvHKo8XZbt1CW/x?=
 =?us-ascii?Q?CcW7fie7+CQksGP+qj+0AwYO44v/AsfXFyeNtQs32F/LjfyaR8Zf6e5tsdOd?=
 =?us-ascii?Q?64PA7+axiPsyM0iYrfD68P4cBaUMfdr+UmGoWL2anDQMcN+lZtX6/xWSdk0W?=
 =?us-ascii?Q?VxboMJLpfvhqF+91krwe3FVj/IvgP4cP72anBq7tmb0dkQWOdqfzMj35hnTu?=
 =?us-ascii?Q?k7zMYJWUxmMhUb769fj2agtTwCQF65QJsdZKr2iiHT5hyEDwbiSJRAMA5f97?=
 =?us-ascii?Q?1moPOBoiKmhdkv+HiwoEy79DWJ4gKmUSJOCqTPq8zMKLv1W7n0Kf1Jh9Ufdz?=
 =?us-ascii?Q?h7wxhdR0aLWe+IxUoXHTj2GNcmOdZZUhwZHnbl8modRwHvGhliQAEILENPmq?=
 =?us-ascii?Q?RQ6VX01XN8JGXIhh78EFgcO30TenJXUa0LwL691pAlEf8BymL7B2KlMZ7zo/?=
 =?us-ascii?Q?yHQDS5RVGNglFV03xLM3qOuz1HbWw8U2OL31qLfVYszeIiRxyKXMLYzXP1yp?=
 =?us-ascii?Q?SfQaZHiLrFKHwIljSbeK0TymPYpEc4QREOQrvQJANsm2GBuNJQEu/ijCvb3m?=
 =?us-ascii?Q?uM6i/Hu0h6Cwi9o4CaXQtx+SIQfT5AVcReCyRE5JgU3nRAmQHmhX67Ls/PIs?=
 =?us-ascii?Q?4cIC/yQwWZ6960rBIXUa3Sz+N7bq6Nebc7Y0v9fxgXN6rTnvBWTWL4C8K1PQ?=
 =?us-ascii?Q?7OtZuXzxoCFgUjY3CSIMhVhzSupiKISugSpE0P8rEITr3hOpK+37C3WLczEd?=
 =?us-ascii?Q?Du6J7Lp1pRhxpVzZAS7Cy9YBvwZJk/19md6ZMMJe4343si/9gUQ3VvlWDfKT?=
 =?us-ascii?Q?s8dmW/bcHy9jRy9a5ggre2B+4sI8IuTJtidgTVg2vrvVVxHIHRkCKlOAgE/R?=
 =?us-ascii?Q?ByDNhJh3KKLc+hwMgOv5DeXcE8cbNCcILEBbQuR0iKJ4Weo3vZ0dvuAlpW57?=
 =?us-ascii?Q?iM/1RyQqw5VXCsO+ZvE5O5Uw/nBowuKA14SO+0a9Sd9I6XUO1BuLJvV0FuVk?=
 =?us-ascii?Q?2kLBSUcHfzJGNyuhTnLfN66aKZdt/vcPnXuOyS0ER0g6Ei+jY98MK4G0bRgY?=
 =?us-ascii?Q?XX2fIYDShBp0kKAM32AuBX+PoESM6OrovywRAIldc0ShYFp1X/vJ+MNNixtW?=
 =?us-ascii?Q?aajkMMJcheoAldSebryoDqRCh7pkDGU7jIfxDNy2P4XTd7L0rx9x8faHnova?=
 =?us-ascii?Q?HCDGzffhmqsRhzznPQ3p28nueBDE/M0xijODkivCFQP3uGqpQfL9CRk93li7?=
 =?us-ascii?Q?RuBUTdVOl91QU6M/MBI6/S64JtT6w0vbK60r896hFTsxiBM4OTXG6hJ2WBPk?=
 =?us-ascii?Q?N7pEwg0muW07NKRSKlr1YgpZagjy4tGEpURm3HFmvA9etfvJvXyzcwfWcRwX?=
 =?us-ascii?Q?Oj7piUxuGwxp28cBUjTkCkX3XoV4whho9hCU+vwn4xd/6yeHoebJyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:56.5987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df8dcd9-f55f-41a0-4923-08dd1882f979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api accessor for explicitly set media ready as hardware design
implies it is ready and there is no device register for stating so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 6d7a7b38e382..bc1f14690b1c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -90,6 +90,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err2;
 	}
 
+	/* We do not have the register about media status. Hardware design
+	 * implies it is ready.
+	 */
+	cxl_set_media_ready(cxl->cxlds);
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


