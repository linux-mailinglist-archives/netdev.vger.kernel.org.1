Return-Path: <netdev+bounces-182291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3ADA8871D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C996F562E95
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592B253938;
	Mon, 14 Apr 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UJhchRvL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34019275102;
	Mon, 14 Apr 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643646; cv=fail; b=V3M7yjPY5h44hwWZDDgW38g/Jo2rV0LR07ZUjT4weDV7izX00InPg8WpQ17802dvrUCfyFiRXfjNgPp5wJboYG/7JDAhtAYYw2j3VdsARTWYcxvazUS0hF51ta6Ll8J5jHBvGsSPWPvjSO72wYC9xbVDbPV1Rmk+KG3WXOJZI7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643646; c=relaxed/simple;
	bh=j0DU4jmImrH7CVEelKFGXy0sl79bp3mK0Z5wY3pUsPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqFhnq7hmZmUZ6byw8HQDMBePpJC/Yaz4b3FISN5Jwtzk5Hpi/8BXgdPeUKgVmG3hm9W2KHnPAlzTQRuUpb2C/t3hrZLnjsq+TSkIjORSZJWL/ohJowLEwUZvTSs+fyEnB8ihZ414CnIDQ2U5aSonAOOOxz7hO9Q9stZHFL+zgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UJhchRvL; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4Nm+/djmZ3FaVv/0GPF9t0lBwupaOT0Zb92sx3gUn5/jAZe7c2GwK0oWJIPLBiYKdiyTYX3YdY8AxkAQCsaYasPOoDn2AI8as9oQY/oQW64/1wZnHUlBJiqdkxCEECgHSLfwAVjqpdOc4h6fryslliPk2lQ25rhpNEuKMLxFbrTmzJYFyL11Ca9o2GBaeCjkIZR+CmDpBsowtuL5GDd9TqCKd8P7Tw5TROquagvzEuC5YoDyBKzgLlcEgBSR3QgiiC36sm//gxYQaWj8cITWCKf3Nr9KaaQD8IvCXqZybKuw3irOj+82A46PoxKurmNuH4+9s+IXAs9U9wxupGTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXtJQYJVjG3tgB5hsNrlS8uIMTuAP8Lm4z89px+dJX4=;
 b=DMzAu74gMwWRqTwaRtlsW+6jcpBpQO3EeiWAV7Z9LKqMmLMMmhx2ai3ifni5AFa7xs1xdcptIySM+nruKwGXOZxkTpgaDDsHguyavLe8bJC9nxNfoIQY7diYY89hgo0bUJg/18twVK+ugTNCcPbFDksMJT0xRw4AVFKpOgekKIcwXfNN+OVADld5d8+5EU0kimBsuQ0CHwVlT0UjAUvsUdjLRdK3md4vydN0dc4aTcghCHM4WCyPhDqn3iF8GM8cdMxmiOb8RgANhMzuMwdkBSX45Zc7GLWx5oCh20KbSg7QdlJyvDxHaW49EJG+7HcLEcf//NsdHKJ03hCjqdlTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXtJQYJVjG3tgB5hsNrlS8uIMTuAP8Lm4z89px+dJX4=;
 b=UJhchRvL+rn7CEm3nyeb6Rkke8EoX0pQj38WikL/UksLfZw/fl3Jzw7LM2tcuo/cgG9087il4JjBvGG57MWJ732QgmU1LWT6VRDvviCIz/IhnHe5xKXNSof/Y8ViG8F8nlYXMivQmRV/afpbZPoiPgBf3JRCrI4Whab+slf1qYs=
Received: from PH7P220CA0091.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::10)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:14:02 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::4f) by PH7P220CA0091.outlook.office365.com
 (2603:10b6:510:32d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:01 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:59 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 10/22] sfc: create type2 cxl memdev
Date: Mon, 14 Apr 2025 16:13:24 +0100
Message-ID: <20250414151336.3852990-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cce0293-da50-4477-804c-08dd7b66fd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uiRw7OlUXnWlJ5aTWstj1RvttDoj7RSi3c4Qr5oFAWjvHEsMOUHpvVG714o9?=
 =?us-ascii?Q?O0OyLlHv+NjX9vIdwtiLYQ9yCOkSJ5cYiXspoiIdtzK7+v0+OSL30KycCM4J?=
 =?us-ascii?Q?njNjiiJrk+VaZoJ2ly1Km/dtj1XlRBj40OA160IPZaTV/FQtFQdIyhlB6rnU?=
 =?us-ascii?Q?qTweZr3rj7HU1X5ZJTopJ8+NAKYC/rrsCow4vQoacLsXMgYctWqUlPpuiJl0?=
 =?us-ascii?Q?jsVA7NHTos+RHF4UbB5+eBsIamMh6WZarCyuqshpqZIbLmFtk1KcKgpwS6/L?=
 =?us-ascii?Q?XoAcR9kDSof5dunJUxG2/Z1tm4NlWUxMAvzlQpppBxH0UYz0m3gFiQgNfblO?=
 =?us-ascii?Q?bma0erTRTr6Llpei6yQfw6ceW1hztMvWzYsWGD+xsl2bZQirnDD4fWxbD7nB?=
 =?us-ascii?Q?b1O2gfhfOrLGgtaA4rWHROe2ongDi3jkW1/tWIZDsC0ATQ/Is0xLXUhvRioZ?=
 =?us-ascii?Q?bGyS9yy6H5L+X1u54Rn72vhXPKYZu2+nse0eA+c7E4Ewdb+Yssfe8Lgqp+9/?=
 =?us-ascii?Q?G1wok5KiSaG/lU+Jw2Z+EDoMDUTzUBEtZY74CF9U9LxnkHYq5C/CWYhjLlul?=
 =?us-ascii?Q?WLyeut+UYhCh5VnvHtt3ofVFmADMlL81/zOHiZpPu6KsIi1Sw0lRJthMWtWk?=
 =?us-ascii?Q?EIBi7hyUT0eGKxCUFKP5Pl5xZWp+spgoQSzeC27W0eC3oVxW4XHLRjr8HOXO?=
 =?us-ascii?Q?xfuN2chph4VsGIeYHqjyHhyGzeTcQ92KSDG3DP09VB7csCDy9Ex2ZC8Sz2m7?=
 =?us-ascii?Q?ovMjXSCCKML/g86JfoWIjz/fZOgyvvcTVZjcwcDl8ytEinfipGswGdZlyeMO?=
 =?us-ascii?Q?k5k+W271xrqwg2ZpTIFgJpzYbvPEY2sXPmu28xdFLScyCpxepYnJdVZsa1y1?=
 =?us-ascii?Q?uIhkyD/ZXpzpXt9NZD7RSaf7kvm5UQyyRseUju6rVu1ea4pXAH6m2saF+rKK?=
 =?us-ascii?Q?XB7uSoO4F/3AAFPSeGOuxT95NjUWBJsV1Wvm1t3eXxqe74qRkzghX9vqT3I1?=
 =?us-ascii?Q?DSBPldS6dxQSVRniqX6Ap1a5B8HxbPBIqIZC3xcw/X0FjSy1t0jwNTjrLWTc?=
 =?us-ascii?Q?IpJIuENFfhmbA0CxkNctQW4c5AZExWkCARBhcZkkZnIEICQKq1sp/Yd+70xl?=
 =?us-ascii?Q?ZFonyQXIt3cZhyTCu/Ey0jpH0sbNCfK8dEWPzh096SAU/dmnoOCcerk+y4O3?=
 =?us-ascii?Q?z/i2P52mMjnc9QUn7Z745FJfkL/ImjmOabmTVYg0yHI9ynoL1DNjzjqMuzIL?=
 =?us-ascii?Q?SWTOFR5jVbLu/ol51jFnTDPOse5gZuEUMW6pVTQz48tTVX7kcM2B2iFMgFm6?=
 =?us-ascii?Q?g6Hbo3Ry/E4wu5J0PHALg7Dknr63U6Ut+2jOdg/9W5GIF96YRznHmpz0GVKl?=
 =?us-ascii?Q?teFF4eI0sMevGlejFUqr12Z5zMewRZBovaPDp9ppYWgnggzNvDrI/JBDfPhL?=
 =?us-ascii?Q?LxUjmGIRbnIwTIC7P4+tHcONovW19R3xyigmywEMFEjxsUBP55LYudo3rYht?=
 =?us-ascii?Q?DrqJndSmtQfrKbpx7XSGNNo9GngWMlkx/GBB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:02.1380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cce0293-da50-4477-804c-08dd7b66fd4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index a5d072aa95ab..82400dd7e678 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -79,6 +79,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (rc)
 		return rc;
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds);
+
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


