Return-Path: <netdev+bounces-148182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403119E0C66
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F724B361AF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957651DEFD7;
	Mon,  2 Dec 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dyYwgITv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8981DED47;
	Mon,  2 Dec 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159597; cv=fail; b=F5AUlOBnwgUN5GE2DMk0/k7wSKf63amXjVJ+XecULitwkirFwcBUChkOZLUKPBcAXJnTJG4WCogX7Skkh31ucaU2M3JvDdaQ8TvQy6Z0XCtkSWaPF1AMEPAzepKxDbLyZo0P26hC8evBXr6fUG4LOj5y4v95v0AllB7rpgx7ue0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159597; c=relaxed/simple;
	bh=ZsreA7j9VV6kzC6bZuAdSKLohYV19kUlrN3lzW57P1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8X/kX47uGl1ljcNrzYphi/3loe1m6+G5TRHPTqeK29a8UP4Y2p/ORJx4k1ls2PKUjVCOwultTQCP0Y/iuzx7XDaAKqLdfG8c0phTZX5WZsCdXRz1kT9h/tqlhrZhkDwgJwZ6lh4zsMKYOvWsLXLiG09/VWHvSi/oL/VEqKxvAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dyYwgITv; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVEIYO9PbmJKUc9fYWGyoy2j2sR+mV9GP8XE5u0NOYWSMp9TLvslBU0/Ou/tZD4Gfl4vD0pv+2Sgk6RQFVG04m05EDe5huWQu6oGskMU79iHhWnr+S0biBSWg8ZvgkCjUjaGcjMZaUIl5eySF6zS0pnp8U7vVJ5o1TgntLiGQEWNVUUIX5Eav9g9dWOgbLx21VSph88Un2ZOxETMaq15B/kKxpDNxOmvwmUxOfJH/hXZZ9kI2Reh/E1jtMiVpjTlASq0pujtQT8U/4AfV0AeeWZaqfX1wHWKRYmviIZQWDePuUlHyukLgMHc31M3hmLqoYVk9gGDvj5nsRJ+a62tgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOaqDrkZNa15nsAGcCO16ealWK7BYdOzRCrYd7rpeSU=;
 b=qE3JhQeG4jXXBFmgYZ2Kd80d6hD++wc/7ZS/yQblM18ggtnimXM0d1ITkYadpWnNBfLomum5ymvBW74dQzxa2EE5tj5csLMGiqH+L3Jo8SXGu4/wWKveoGK+vU4wDUgix0yJG731Knd42pd0YkAmuInBMbUvgpXnl3ukrxFZZZYL5imV4SuUlcrOlHuTzC5nG5piOjo4d9Nph72joMCQz6cnpmdzyH6HdZyABou+Zc2A+xZv9zEAallBIOX8TlvkLiOpmM6Uv02ejtwsUgOt2p3E0sze/yAez3eU8dKUDxQZVzqwFD89/7h4HYkZYovclztFHbw6aDjiXMCz7pVLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOaqDrkZNa15nsAGcCO16ealWK7BYdOzRCrYd7rpeSU=;
 b=dyYwgITv3b6QHwUXi0mAFNoZZbzia7lBM1VJ0SRa7+2bi5ImeNO04TBX7IV/x5ZVHcni9D6T3jOJsAtJNxM7ymbfeXY2T+wzPrDG9k83UgqWqv8duM6JRBQcwH+QfQ4d7W8pQjbHSB3jBaxcHbwYt9grezRxUdWzO4Mi7wCMWpA=
Received: from CH0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:610:e7::25)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:13:10 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::ac) by CH0PR03CA0230.outlook.office365.com
 (2603:10b6:610:e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:09 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:13:08 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 25/28] sfc: specify no dax when cxl region is created
Date: Mon, 2 Dec 2024 17:12:19 +0000
Message-ID: <20241202171222.62595-26-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ce3bac-a528-44f9-0bb1-08dd12f498da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?btiQcuzZ7QRfcQHei4yq9b7SM82sBUZK1FEL00yVMr/NWIAL2UPThpyHFm6T?=
 =?us-ascii?Q?YcKf7XMSSIkSTHW4bYzQweihcXbigF1FusRLpc4cms0RMnvDALGPZRz6GSM+?=
 =?us-ascii?Q?/AQCT9RfSDs9XWqsMgQpYuxHbn+htJgDbFqYuZeGdirCYkvL0OoZKCbXZDAB?=
 =?us-ascii?Q?jTJbEQ3VqQEUb+FTjiyAzybqvmJhlpRyWCzoSzg7lygZ6vmhe9D152twjIEw?=
 =?us-ascii?Q?a1OPartIk0u+HGmZ85tmr49bKelW5Oa1Iny2b8EAH8CnOgbXPcsjQW00oTwc?=
 =?us-ascii?Q?obXDoKDhN8FBdAxjVf9kMCzifkRQ/ZKci0NUpmynm314fqzZE0hkwOsg1iBh?=
 =?us-ascii?Q?bYiW5NCbRLwZutYV1BCncUDEOl3UhHA6U6SBfRJp1WqtjoGZCKBTPl4eFYdd?=
 =?us-ascii?Q?VJvC9Jsw7EeC5HOh1HgDPIx7cRM5OW7zf5pFN+SaZWZzY0PJqKmS1imtVjcW?=
 =?us-ascii?Q?2MFbV6Ydm1zNSgpjWNI1cnDly/5Kg1bNButsaXqpDSO7FVUeewdnwikwuK2D?=
 =?us-ascii?Q?wMUZHFsDiLYRbDPodwu0g/1roOb+Thz5w651ctVorI3Ecy0ZGlRIZ7BLC09S?=
 =?us-ascii?Q?7EfRJYfRjofHtRKyFe19NIrtv+2gPh9s72VMZge2iRHNElbSw6Gj+Igpq3UK?=
 =?us-ascii?Q?cXFfrVcVRZkPbNIyF0wdqDBUg87kuyS4h0veY0Pim0dOFfQU1lG4voC6Oqxk?=
 =?us-ascii?Q?p/cOZgWA3mmVtr5OEJbhDbD/glxBpUkmHl7QAeusBzU2i9CQSj1n5zbxRkXJ?=
 =?us-ascii?Q?AjJWsygMD8KlK4LmicZmfbT8fk60QLiSyFT+q3pxhfu7QStE6kPzuEkECTvt?=
 =?us-ascii?Q?kFH7wLgNaWu4LrPPAyeakoGwEm6nTfIFuLC1NeSf5PfWwIt832+U2iNb7OSi?=
 =?us-ascii?Q?zqnqW1Uo5rZLfhOyPx/1kJxky1KSbw6ziDhsCILbQR2cr1F92HESVbJ/actp?=
 =?us-ascii?Q?nJLd7qoqTiR2dLr0sOrhSpWq4K9LuAc5flmLLtJpSS/KR0jjxSQua12mFVnU?=
 =?us-ascii?Q?JBlb7ywYE6uvRQt1Omf2W85oplfVahZw9kiXz9USK42oAzF6Y+bI4SOy+N8z?=
 =?us-ascii?Q?1F+lt/GK5kzymo1fRD74Wi50dcG8BpRu6YYtPNLNZ+tp/Wg8kFE9PfVit51j?=
 =?us-ascii?Q?b9BrKnx6EGfRM4lTJUKNKbRi5NpgsZhKQIg6pX74cY4QZus7m0TXI7vp2SD9?=
 =?us-ascii?Q?QGpP3dm/q2D/ab93UGl8Zfl5frHC2MCpPFs0CJpRsPiISgN8V6rcLxEvwBU4?=
 =?us-ascii?Q?QQQ+HUWn1YVlRmEUefwW2Lv8LZcARypE0lMhye3m0bY5GrvNxe9VwOlZcbQ2?=
 =?us-ascii?Q?7zL1V58embMgU/ApNUp4Ey+J3pTpQILS4SxA5OmxW00pJ+sZFywJ6gbt3D9t?=
 =?us-ascii?Q?V39U9LUW7PH6ITVVR7hasUwK1bi8sYUrJ/f4PtEFM7gNti9i26AH1e2OQrNj?=
 =?us-ascii?Q?O+B7xxLILqK23UITDSWBcQC4Z/r7C7oEJVbnRBb8SSHFfhaBPaUxNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:10.1444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ce3bac-a528-44f9-0bb1-08dd12f498da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462

From: Alejandro Lucero <alucerop@amd.com>

The CXL memory should not be used by the host in any case except for
what the driver allows. Tell the cxl core to not create a DAX device
using the avoid dax at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 3e44c31daf36..71b32fc48ca7 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -128,7 +128,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
-	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, true);
 	if (!cxl->efx_region) {
 		pci_err(pci_dev, "CXL accel create region failed");
 		rc = PTR_ERR(cxl->efx_region);
-- 
2.17.1


