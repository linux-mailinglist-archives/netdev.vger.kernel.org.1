Return-Path: <netdev+bounces-178322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21176A76921
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D3C3AD7E4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4872153F7;
	Mon, 31 Mar 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XIBExwdm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2240.outbound.protection.outlook.com [52.100.155.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B2220683;
	Mon, 31 Mar 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.155.240
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432396; cv=fail; b=pOHOXhFrYdCY/mlSkkrynZOj5mLR9Lv3iowhSb6oLO4WA8zHwaKjzs3/imyBZPvz46Q0Zin4jOUVsCpwFFL0DvfWNM1uvoTc0JiPjXIhT+E3+dzrwLV/yBsawwzj6eUIL4okB3PlM8v4n3KGaCWS0lTcvrEibzHxFJ07lHDbbVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432396; c=relaxed/simple;
	bh=3A21JOJTHylN1Bfg7zcNOSiJOMEFjUYI0Za1CEpoPbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECADxoEUxh2JsVd8Gh5Y+DQ0aaWabbDf9gTmwgQwmJYYKb0ozLf8bfdxHLjgzlc5rcJDiYricRf8y+X7deVyuZEW3nYN9WXYEtxm+ST20Dk1+N7TklfnXQ4j7+apnzR5DoKi3t/8IzsIswdY0mNN6lN7ORtbsBFe2uaMTQKf0T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XIBExwdm; arc=fail smtp.client-ip=52.100.155.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXH1ey2lU5fHdDHpFhVLNU5THiocYIQ+RRl2bg1p1prvjggfFbYtqXPW4u4JgQhuJvwR64Wt7OMxlU/r/LwWk18ag7+hoB3Cp1J+B99CbmAfEB4IfAhmc/A0aDaKOA3PoqgnLejFVL+NWRRqkLvavO+8DpB2ucT4qKWedjRKuyasJDIYpJieQQ06tRGu4zM7Owt2WakelRnFbSJNOLEn+jbMpZLM4bYt6i6aH7sgxrA3RLlHZILiNQnOnxK7ivTo2DbDn7AsqxqOV/C4SxwrxBpLyP5aV3vkVVZxZLojTzf1SCmaTMfLY+ysHdk3Hobf24ZhJXPa3Bs1OijkDGVFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyaGEkNWsope9oMYgpTiJcC+KGxnW/JhIOX68oDTQnY=;
 b=gkNgNd0eQUtddp7pXKGCobHHqo/qO7/B407KhBwTtnky1d5KDzfrOYmMWK/rf5803QldJ0P6rmwmgjqRKeuiZYlL4URF2Atnone6RIqHlXR0bMnbFLkJI+p+VdNdN6yLR6YvcIab7oiYviRZignBr7QKljulO3680OY7Q+ZNJDYDjDm0IGisIMzdqcA6ZRmu71d3nFrbp8bygyo9nvXuZ5lO9xxYT79nXcMFtcow0rMCmliWe6iK4sD8w/fj+g74sHxFMELTiYWwDuIeX/LULe4XPX14FqzBOOazqQcn/Okv39h195Lxw/uASj9ffCuNK8E5Kj3VKdAX+1Mxzv0ZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyaGEkNWsope9oMYgpTiJcC+KGxnW/JhIOX68oDTQnY=;
 b=XIBExwdmPm1WLqD2qtmUk9WhHeX0/7UQPa7knyEUnJM5mp0WC1Ev1kG09Pw6AuJJQWJJEloADKJt7ftGoofM1Ne7pO8H1YLCHYWnaYoyPZYRlbYMEuBp/BpeVx5uHWv0f+FJCjVHcha6iYQQ7ZM5EV9W4uZf7Go2WvVO0DW+bps=
Received: from SJ0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:a03:331::7)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Mon, 31 Mar
 2025 14:46:29 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::60) by SJ0PR03CA0062.outlook.office365.com
 (2603:10b6:a03:331::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 31 Mar 2025 14:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:24 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 10/23] sfc: create type2 cxl memdev
Date: Mon, 31 Mar 2025 15:45:42 +0100
Message-ID: <20250331144555.1947819-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 176147ee-03b0-4fe1-39cb-08dd7062d229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|376014|1800799024|82310400026|7416014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHVZSHUDkdc3TJzcDu85Q4JYV0Eu/X4QCUfBkF3xnr8JeZf3TLH2R866CRwl?=
 =?us-ascii?Q?gCizxE0Pd1kObJvsdulwfzaVctcnc1ADxlr/3bwOuHj6Rdqq9toJlc+82ahr?=
 =?us-ascii?Q?ixHZSSL/ZwRyhaS1w6oguZy0c2t36sQWuYCmXa1GlDM8cgJdPByjYQLnPA7A?=
 =?us-ascii?Q?DusObs3eb6va+mmex2BWL3xo+K5ZHYmzLZZ+dZKBscThIOUqMAGYGLw+4Rsv?=
 =?us-ascii?Q?4ExJRhHsb4E4wavKFpIDIH3kyQxMQ47vGkDqq0WVUOto+ZzyHh8zG1nXFYK8?=
 =?us-ascii?Q?H5FfxYvC15RZOkBI/1GbVaJh/vY0yIs+did2XpUS8e600eiGLA0N0yE+71Fi?=
 =?us-ascii?Q?OIm2E6AToU48pDEmYD39pLbDKgL96qULTCGDBpzdp3YakBjIQQwOcJs+0YIN?=
 =?us-ascii?Q?vUIz5JgiTijBu7kINyrYpmLWiftY+zKRuaqDMS74FLehev5KHGjCyAUJj3+K?=
 =?us-ascii?Q?XEj33aoBKlWfK+KMQ9TrsG6T1/AI8brF6S5CCGo3ifGrNwzOoyh9qvZ+M/Jf?=
 =?us-ascii?Q?mlczKF7suc6TG0K1+n0PhlVIdnFbjEUx7qOuv3sWN+VOnCpuzSL8tOmEDMF6?=
 =?us-ascii?Q?v8HtP34F5Vm/6bTPUX+FHEq4K9BfpFsuMJ4MStaZA7ib5vKvj5SxVG3ixTiT?=
 =?us-ascii?Q?Uo+h7UX00QDKWNI3PPZoWRKIVEChYYadiMgmoQ/CwRjsOCOTWIp4vZH5JLO3?=
 =?us-ascii?Q?REc5NvA+wT0N/8BZfMAKKrjuu/rDpTsS8Gp2Obl9LQBH8VvLBMGwCXhwh+Hb?=
 =?us-ascii?Q?2PHkIWZQg/cnFBa0Kdrchsc0oK7w/ez0ZHzgAgm0LCQcGFzfjAmqoyYArTYg?=
 =?us-ascii?Q?VRKsSxHZnxTjcMbK8exfw4caWjat4KY8a4aLAPGLUG9fLYkI7WhTm7XL1SVu?=
 =?us-ascii?Q?CSvjlUjR0zQT4YGDk/XdR5CsAzROtJFXnnbTdjG0b0x/c/yHjV3Y1IBEOal3?=
 =?us-ascii?Q?CZ2lndqTc6Vgl15zbAYVAnq4ewxO4jL2m856Hxg5W6eXRnNHgPvAHbisSL3W?=
 =?us-ascii?Q?SLpdau21b9BG7Ro8lEaN/rJ0e71iGgWKaXWtqZ7RIxwgkN/VzjmE1dDOfcst?=
 =?us-ascii?Q?BXdpIONp8J+Q+YX/RQwD4n7dCiJ0JX4l1vtWj2TwOrkNHoVa4hSx6a9iieUZ?=
 =?us-ascii?Q?OlVeiPWkLUoyf2AywLVY+vFHtta1PLsRGw9JZmIZS45O41DCL5V7mwZtBos9?=
 =?us-ascii?Q?7TRW3DEhiHPhT64Pd08bz6maFS301u+qk2OW3j5+xf2DmqlJxFc7vVc6BC1/?=
 =?us-ascii?Q?4M7mUl2QCQ4ny5TqwHqiA5qVegm0WLiLAgbcFUswVbTaJzZ5c7n3AMoNFrOA?=
 =?us-ascii?Q?pfwGIHJoqmUB3VLfOYm9ol5Nt2p9zRoiFn2SvWtyCwYE2FPXSvGNwLgBRH+Y?=
 =?us-ascii?Q?uXw66v7rEPp8Mcsq6yjrsmsLfo71MlTbAjmhbLPK5mw6X5ZoePwcCg6+4YUW?=
 =?us-ascii?Q?QQwglbhPwPdRoWrqf01dbzcQWoF95sgDaE79Vj6dSGlEtWHA/FHi/oIhoqDf?=
 =?us-ascii?Q?syzahOPTOPromwE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(376014)(1800799024)(82310400026)(7416014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:29.0876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176147ee-03b0-4fe1-39cb-08dd7062d229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132

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


