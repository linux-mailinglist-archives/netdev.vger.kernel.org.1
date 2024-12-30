Return-Path: <netdev+bounces-154582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DF9FEB21
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFE07A18D6
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B79E1ACEAE;
	Mon, 30 Dec 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ogVv+Df"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63319DF44;
	Mon, 30 Dec 2024 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595123; cv=fail; b=oq62PeJD6NEuww3zfZ39fXAcheJhpxznP+m9QHGBbO9hJ86jnekOm2xylvDmbMvL0vwdpiF1l2bu3W6BpoUtqqJVJM1/Kf4V8e05UsJE6PNuEIfJAIYEJG6HE3HrK6j45AusIbSk5trvejWlt3TWH0kMCNW/fHikR32wf/QvnzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595123; c=relaxed/simple;
	bh=npycsmhKSb1ntjXf8AanA6K7xcHN52KJxSu849rtFuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhGmiKxC3AIhTfYt8ZdaUOJP4kkdqxuQx50tz2ORi+/yQ38sgvXUg2yBVwt1L3iLObbtADIY0gN8vNop0oHdF9ho8UhJUanDySGpadwSu9GHVNUZ/xX2W17F7Aja44l2dXV70X0TVq9/QXahUSHMUEpz0am8WjtC7Ej2HkjbBiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ogVv+Df; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9LuH1cTryEiGbQN1ylGo6edz+3HBU/q8qrR65IyF73BhzU48JruqFxpDOm4e7LaPKwMm8PJ4HXBWerajSWudfK0ZWp+kWP55n4frusjHDMrs3pTGWUH/+9A+p4C40CnQ5vLj3QIjs7HtJLQRNiM/jZwD2wXOEitW238x4J3AO0v1M9Jk9eOPa9LNBcXLS9Vwir9+PZk9CoWP9qyhLZEjGMAm5sRg8WqztqQ0uH+msmO5s92Mrj8e+NgzUsIxYbRjXp4A+ZnOquypIvvnXiBtH6d/rscRyzEsT+K6/p/oGzpAGV1aElKpEKwFiKqeaz1mWAo1E8kLmmrDZUNTXPzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFtKXcx+hK4mab68m1wnJBA55eQeGpMmLdad7iJbvFs=;
 b=tb/TrL5gs03aodXZFdAoHDjvFp24svvC8FEkP2/j4ytVAk//cta3sgQLm+FSdTMoV+gpabkMCvRQHOcPxrQGdY49iWvdSlRpALWkk+dlIOCHu3cdiEcdwoRiZdCayjS1p9r5oRZY7FihjiZA5w0qnkT+YBgjVlEOUihTxky8+v464bFSjHpR+LsgwEdKFyhvCnPCaWvw3X6YM06SOaCqKhzeK7zXFaIogT1R+idPQDGwE8K8ZSUYpRGhqUxlz2Px6POH/62pzANSeVvJp5/Z0lOseYhPr86tCVfNNb2obK+Nl6t01MGfvJesorFmD5ZyEop+NP3lfpyn9Q4Nnhpddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFtKXcx+hK4mab68m1wnJBA55eQeGpMmLdad7iJbvFs=;
 b=1ogVv+DfQ1mQGvpK0N0q4aYVmJwO2GGIEOP6ZIMwFRB277bEONcjCd0MxF/1p3YmNL1DD0bGfbHd/SJQ5pRXUHTr7f7UPZnUr24BS/uabeJ76WaioFQ3zGjjJVvBW2opmXUDa12J12pCxPNuv5tFHFTWzSwvfhOjw/VY7rr9I00=
Received: from SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:15 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::8c) by SJ0PR13CA0007.outlook.office365.com
 (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.11 via Frontend Transport; Mon,
 30 Dec 2024 21:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:13 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:12 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 14/27] sfc: create type2 cxl memdev
Date: Mon, 30 Dec 2024 21:44:32 +0000
Message-ID: <20241230214445.27602-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df30913-28c3-4e9c-7856-08dd291b3ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLEO/0mvut0fbmtF9hnwFuRB+0fIYKKzRqqiaPmOOTKx++pIR0TptH7KlljM?=
 =?us-ascii?Q?esn7+bW7Nv3PjrKHBUhuXQfIsO+ZVWuq9j92GIZGj95vJdc8yewuKDpjA0TZ?=
 =?us-ascii?Q?afSAK38IoV7pwWt+US+K66E6U+4E7HzHyPSDOcAZr13GmFXFMBYMwBHB34zn?=
 =?us-ascii?Q?lYy3gZdp9+nSLVW81sSg1gEApozBNpl0tKQDhFc+lq6d3L3QI1+FVzshR2Am?=
 =?us-ascii?Q?LmZKIEmy/l9lDYMkWZ/ywgkCQdOsi6qgQV9Gbq6xW64/u0MPVFByAKTINHP9?=
 =?us-ascii?Q?klNrzlodZAsvoX2ezX5iCB0fmJ5tsW5RS4rPxRM5GllRCkHLp9RAjj36nfRV?=
 =?us-ascii?Q?QAe3KIPKjyXzW+ds05vd533GLPjCq2ubGsFzQsRCBNCdd7g6qcbSxUCDLo/P?=
 =?us-ascii?Q?ZSEIoE6H9hB7vB8gta7qHusDQPFD5nimSIHtwg5lYqpz429QJpaNEF/1Wf2g?=
 =?us-ascii?Q?bjAbqckvW4CWGk/n8KNsr6S2JWTZfYX5Y9QRiRCWH/m1qcGQbd0DTg2JjGs3?=
 =?us-ascii?Q?GeBXHUVV4wJ7AtFFFB6ONoWLliM71+tWzJwey/VwQyZ6YBGcPyuIJApNFYvg?=
 =?us-ascii?Q?KJvQnFUb958JcQ4AB7Ja/b+9+ezSl1Z40xVNsIC2CEJL/yVbfSIxSqt8KvOS?=
 =?us-ascii?Q?jg4f6sn62iDeaEGXJ9mqIBtQ65hJkrQYe/D8qWhd+IE+5UXmREhuGP3IhkjQ?=
 =?us-ascii?Q?cuqpjVc8afZXsCSh2jksz5iVx/4bzPg1M7geitkaHIQ1eOhQ+5OWcEW4ZAiL?=
 =?us-ascii?Q?YWPPjY4wzKhAGYGyqkjy6bYEa31BmETHPJzHXXEugReEq9tnzReBvRPdBBn3?=
 =?us-ascii?Q?ntsQLHIHpnztmMqB0GoZ9j1CfDvSe/LD2L72alOriDvJ4NZGNdtSKiylBsUf?=
 =?us-ascii?Q?vDCiem3MolsnGBmo80cFhQeElEG8rvZa+DUrYbHH9m2BaZD/9ntju+jTHb4z?=
 =?us-ascii?Q?JOZJ6UMov4cD6p5ei90c9gU0LpSlDkpU1yspPu2EXncrxpwmOyJmK7fPtBmV?=
 =?us-ascii?Q?nWy/F9w4qKL2LDbv6+SIPne2+vTMRQ9o/gpG6q8TSVsvQAjkC+S0Z+17NuiE?=
 =?us-ascii?Q?EVFKTUuyfx5uzdf7Y94vZRNlx2+Zo9hX0jSjX732O9de7qMzgH4T94ci+2gV?=
 =?us-ascii?Q?hQWcUI2v6rCqmP1rk8DLI8Amxo1NVgceKoA/+PxXvdg12SWqO1LX/uamdiRe?=
 =?us-ascii?Q?gF66IfDLthsUOfZyejvP8RRBb5d8bAoI9rv3STaMmfHw5ec1GIHN/KWY45Ry?=
 =?us-ascii?Q?5YNZjj/8BCK5CmTeC1mHeGFlbyNLALZGXcXNUBIWEmf03huParO6LWn9uvmJ?=
 =?us-ascii?Q?xw635O0ut1BSjz5OVZ91AoL6qxp7aAhPiMk9b6s6YF4orRj/yskHDMs6bHuk?=
 =?us-ascii?Q?sU3hLo2dN8BpzqssHnV/mYg8aUOVJegXhr46ff6f5PIQcfZeIhvx+wbufjj3?=
 =?us-ascii?Q?sbIvBdzLzBgyIZAElNVBfiYXVgUMBR2qaM3f1DRZIPArcwv4/xRexCJ5N4T2?=
 =?us-ascii?Q?xhC4Ryle0vXoABw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:14.9949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df30913-28c3-4e9c-7856-08dd291b3ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 911f29b91bd3..f4bf137fd878 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -96,10 +96,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl_set_media_ready(cxl->cxlds);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err_memdev;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_memdev:
+	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err_resource_set:
 	kfree(cxl->cxlds);
 err_state:
-- 
2.17.1


