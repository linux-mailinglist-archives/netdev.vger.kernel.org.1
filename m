Return-Path: <netdev+bounces-173663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF2A5A587
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4563ABF23
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6161C5F1B;
	Mon, 10 Mar 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CWJnqTsq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149D1E51E3;
	Mon, 10 Mar 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640651; cv=fail; b=D8C8cWpQ4QFZMp//MwXgqDfqhsKZZvPTfoDLdonVSEqpmaXWh91QWCGfdYF55Ypge7R5AMDJAU7fDP16af9qTrCidvM9JIEScgULcgQ3TiVwsN86nLqVIxI7XmTCaZHPUQP/ZYsWUx58vaGtvvw5e7UIS52mYPkfGHvYNrt4e+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640651; c=relaxed/simple;
	bh=3A21JOJTHylN1Bfg7zcNOSiJOMEFjUYI0Za1CEpoPbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIor2XClOSR98Xv4i2qlzIjcQ4p4wCnDoU+qYQmrF6Pt2yrcIkRDfOKzDzhTY98M7mOxYyIVU/s+k0xRxRbv7GDWOL1N/Aw8ypxtm7CQg/K8HFCuJAJb4LWVaNmnm0MVHF3hWLTYgUTNlzV/S3d5JFK2Foznscy0tJft5V7pqkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CWJnqTsq; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGtR8Eqdq2s3YygRsu+IeCqfhKXyXuUMgKircAk7R3lCEkrrPbbSvdDEAUkmHcJWOVEqM057PHc+tCLLbU5tPaQyrZYY0lxwqnopw8ml3e5ZxHxIFj16Tu4P3+me86rLQMvyxCwbZtL1p02pl33Gv5YJf1oTinQX/nIDbQZFa6bZ5IowkDawCYOCGDDRZ9QkaLmZfiQCZ1fUdSagMDuO2KkOLjW1XDVKyva1mZz0mNnoxC4FZMeizz4I2RQ5E9dV+UTdmEtHcyON8pxsSSn4LMdvto+Pg3zj4mq1gHL0kSgVA01Cf542LPZX4yVnt9N2mlLgkmO3xlmNnIgOmLUqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyaGEkNWsope9oMYgpTiJcC+KGxnW/JhIOX68oDTQnY=;
 b=UvfC9Z+FXGr+oVheYP4LNSGsglewesavkeNB6MZNVKDDcMqp5+1s6oleeq64wheqTS3Eim5QDONn4pUhTnSYa4RIPE8NkzPdezywuWXSt4W20u0yVjBZTQsAYYpwsX4hjJdeDBNfV2PqZ0HuSWIl3DRc5BWgvHD0SvyRS4eg5ZAnpo6gD/+4pmNJgmoEdXKzSwSAQ0GvQtS7+gbFTvbhwjXlt44VJ5mHoQH3oegOsWo0T6iAutrIxkjPE+PZjOE87o9Q/lZwnxUnVBvr6lVfHylRVaXPMPXAhhZI3li15xbEIxpaUSeLx1tYdDTZ5LIcVRVBzMAwV+wCqq0SDnE8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyaGEkNWsope9oMYgpTiJcC+KGxnW/JhIOX68oDTQnY=;
 b=CWJnqTsqARGZEHOEWpEpJRU91Wy/CrkQORw3zD3QRYVm4yHumnUHvHISTizSkpR1E3Ypq+pZpAnoV286ixh11ZpaVaTFfEDglhkTJRnC6dUzwWTVWqkNaguIm1xuciS5twAlFK3XDS0zp3IDRFZQeRIarIqBQUpY900CP2D8l7k=
Received: from MW4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:303:16d::27)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:06 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::39) by MW4PR02CA0008.outlook.office365.com
 (2603:10b6:303:16d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:04 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 10/23] sfc: create type2 cxl memdev
Date: Mon, 10 Mar 2025 21:03:27 +0000
Message-ID: <20250310210340.3234884-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 639c1aca-79e2-45a1-458b-08dd601717cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D0iS2yMWXEVGUo3mGuewtBF2HBr4BLUIeRJB18pMmtQXRwrfYYJmSR/jvQSm?=
 =?us-ascii?Q?OvI2kHGyXZofy3dUViLrAgCk6DFk+mgczKcaC2+h9Lwyt8AbQrdw6LwZLEl0?=
 =?us-ascii?Q?Ztg3kRSFsQaVzvmbbgSrjOy+r3BeleZfnvSz3wEKt82gMRM+aitFFraG5Lrq?=
 =?us-ascii?Q?FN1ixAGlV2Fm5vLufQVfzxbWcCfZq3zshoruphOsyEK1npRnzHws4KxPdsf6?=
 =?us-ascii?Q?iEjm47nsOdosWBzAh97hJ81SgLHR6XAHUN4cabeKvOY16Z8lu0ctJjSpSmjc?=
 =?us-ascii?Q?JdK4ZjNnKN8lvm8tp88NLOiCyRHyU3v3qHJnHAT374d+HXQuxsiGhdQADwU1?=
 =?us-ascii?Q?Npf42BPo1jg6/eXK6lOlLYIoOcWDqxsERhTz3m7eaqAbcDjOhMnY6LRkDYhx?=
 =?us-ascii?Q?6GLt8h4l7xBgzw4NF2WDRk3TlGonmDCltU08YBgNq0qlCkh4pXT85ykhf1oo?=
 =?us-ascii?Q?OUCtIveX1uQZomrIibOdSp5xuUbiJwXLiCcDYg47YxTZ+KU/fdFuo20CIABZ?=
 =?us-ascii?Q?s9SwYljWke2OZXEl9Af55kkZMvJTQv8Kpa8NKkrjrQDn3sBfbbOw6f+86UrX?=
 =?us-ascii?Q?PkJgGhX318pRaFHeWuk0ncmmPLBffsnCYx+cvMms4kpwUiO2AMfotbeAMZgp?=
 =?us-ascii?Q?wdEwwBPY23ud8LjRNHonYUkJ35dWJfzgNtQMiMaUcGhnQqAZjxZiwGlQZknX?=
 =?us-ascii?Q?PRFeALeCoJs3l6GMFWF//moCM3jtLc8ZKZPbWBSo9fA9+J7a8lnHkll/xvlP?=
 =?us-ascii?Q?mc4+n0D8F9sOyebUUs65GAoUOxb1BhKOZN6+hAd5gJzV3u77QkCDVVAhI6nO?=
 =?us-ascii?Q?6lqIr+kLcf6IcD+yzNS39aFlpaF1RCeT8H9C4qidAILPAc+R/d7Snac0UodO?=
 =?us-ascii?Q?15unypONScDJQ673DZbgvjUiWqfNIYks9GOdH6Bdgl+jIDgbZi3JU+BRrxk8?=
 =?us-ascii?Q?QDqDny8g+x98W9/W2D3aScE1IuIGZwL3VUV9b1aVN27jOLR/Ut+b4oXM/UiQ?=
 =?us-ascii?Q?ORwijrJkw4s/YS3f2ARn7/yQyIFvgLSY+JfY7qthvv2Ns1izIOIezTQhhYE7?=
 =?us-ascii?Q?agmjlOEaFTphhdFc8SHkogvZHBadiqS8nkTv1eibnMNCUsSMz8qR2QX773/j?=
 =?us-ascii?Q?i9dDdOOnEcp/NggWgaNFe/3WmhX3/PnUxRUHTuUM2z9WiAb4TrgvAfly/qPv?=
 =?us-ascii?Q?M6DtGGjA9RR/rATJgqCu8YjIQpjwwFatXqIXvrBUlOpCOALjMYiHMs7HkBal?=
 =?us-ascii?Q?cKCbE/FXgw26ddbUfzAo8xmZPqhvQ/yfpYk9M3t0efe0YDRFg/EdhLHtfvPN?=
 =?us-ascii?Q?ioEjxh1+cRk7ULBT1jj2DiecSbIWqjM9+fPuz/JYsUKPhr2faaKJBnxHjPca?=
 =?us-ascii?Q?NhWrIUINUdgor49/NzaPhVtgYL9PrZEzHFMfrlDkAnsrjbfRgARj40w3EEBl?=
 =?us-ascii?Q?sbzR/1oc/6UYlgcTei7ix7R/DXIu8HujMueliivavUK9Xz9QiL62oqmw+Iu8?=
 =?us-ascii?Q?4qs56Df552lWlD4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:05.4602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639c1aca-79e2-45a1-458b-08dd601717cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 2c942802b63c..5a08a2306784 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -81,6 +81,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (rc)
 		return rc;
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds);
+
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		return rc;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


