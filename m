Return-Path: <netdev+bounces-189315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0333AAB1972
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DBA4C5A76
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6B235340;
	Fri,  9 May 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hRIioSPb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B63235072;
	Fri,  9 May 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806053; cv=fail; b=dKY0Q5ADkzQ+4dBqcZvQwkNyu/+1WgGuSY/LYSCG+WEJsHl5yc1UPP01RtN/8CY2HpkWUapXJqKpdxUzecphIu2kVgD+Dwq7VyQcz1LYin3Ra8ET80WLqOHGVz9uQUlLPLOYTeNRX08Eo8N9NhnbW/85j2ICQc7r5mKubCYuLLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806053; c=relaxed/simple;
	bh=RFJ4hVQD5aXRs4DmdYwUBgxhIdKpwqb1cRj9BfD8bXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn4abbOmd/94oNXtsjen3SH5qAbe9IQg9OgwQOjieiqYr1e1cuZSjotuVf79sFCJ2Ut2Pt78WdTmIFFFfVKpGUgr1gtv0CxzFz8hrt9Oe0m3G/ILDSRHRznG7nr3qF+6vvKd8gRcz1n6d+hD+L5OgV8efGqF3cNFZ6cbp0gJANw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hRIioSPb; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7BC8xCCGwQ0mMXKYEr50fYMYfIsJWx0u6XX9tGtUK1ms5tG/tRzHNqylfhk8VBCXa6OnizR+xHYsS7YftmOq5AgJOHZZ4SciBe2RvuyYW0LXaIl/dpx7NUCxBrRU1px09GaDNwYdpeLTVn2mVysO/Jp7bf3MFlTMw5vS7gUwWVjjRUyfOvH+OY4jAMaNlcLRfu2xy6oFP/MFjcdJJnc0fCRRRzRjma8drfBWyIWhPjgGuYugWd+OicvGbmmAnz5IzKy372pF72tdF0tOs6Xwijx+WDD3gnXN4C1c5qJ7PqhXHGpTuZ86sh/FCUTXHIQ6dbvTW9Uux3f76cSTDpYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi2jvWxnEFE6LJfsHyc+cxcxxUcudINwoObWqx/9bHY=;
 b=ZtModoiD8je4q1LZLW2GhC9iiCPYdYTEiHhXeuS0bE2Z3fUY4t8kN3Wtw+HWaCTayOfjHHGNb4Wb8ql1ZpN8bWcI6g1XZs1NqxISeCdhzFYVUsuMpyoPzjhvjdSAT6HnuKWt05kn0ovYxx0Pjx2ALfzyfcWcWbwusHJDsl03Y9BfWoXpV+0DjS4xTCrQ74K2v3659LV3G/+J99xjck/Fq0+O+TS8Vj3tvWmqamzlPSUmA/DscGpvcr6EBW7chd5bzugewqEMEZD42k81MPuLtQdjbn2oBzgk/OwQvbdlD8a9pf663L8Qs4Vv7UEUDQUzCSS6nC4t0B89yVA2iygl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi2jvWxnEFE6LJfsHyc+cxcxxUcudINwoObWqx/9bHY=;
 b=hRIioSPbLKRAGZhp+uf65mpf2Za5ERc/BjxHoA8TOx4IpUH1HhxDcJjJ4F67SZdgGEoo3NLRLbmA3Y/YDDTSNmZyc96Xk+KuYjPlxtBzgCMN5hGcK5vx+gl1tsEQD2lIHHgiGbT2ANKOS+8XqTx3bZ7f+wba8wtsTxrdT7ZRO48=
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 9 May
 2025 15:54:07 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::31) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Fri,
 9 May 2025 15:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:54:07 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:54:01 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <horms@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 2/5] amd-xgbe: reorganize the xgbe_pci_probe() code path
Date: Fri, 9 May 2025 21:23:22 +0530
Message-ID: <20250509155325.720499-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509155325.720499-1-Raju.Rangoju@amd.com>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 634ef5f7-e3b7-4981-3ba3-08dd8f11bb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bfafhcXrJJVuO+kI22nmIk2jZ5OtmL3KYBRtczmXetAMa1p/PV927ahmK1H?=
 =?us-ascii?Q?KQ3UGCTpKnRJ72KC7r9BUDj8t4Jcu5QRJKLisYWsX/0cy+/IT3sIq5sCJ2kG?=
 =?us-ascii?Q?d2Cann+7bsWzUKV4VU+qMgSmZBqQHkokxJFo+YGaQQQXJm8vOIx+kJzFLeQe?=
 =?us-ascii?Q?L60fHGZw1IGQ6UUN0I2iFOVZ8D2jPaVZcWd92QNzhk1dOuTqkhofO3T7faCE?=
 =?us-ascii?Q?wKSFhl37f0qgvU+B7Ntw9manJOrdLp7vJT/95HkBrNKmkc1ISfjS8hE8+06s?=
 =?us-ascii?Q?yt3zc+a7uhT/axBWEjb5nVBVVw+frd66yroKYALYoJhpUkGEGGuYP6S0iLZJ?=
 =?us-ascii?Q?GRl2YHCPAJtJc7QyCVbqMNyZNUgDRjUx5mXHQkbTQqzTGHhnhIvPgJmiFR5B?=
 =?us-ascii?Q?jSptSz78YR/w1u9JrCh8hDVJBrevS0MTu/k41v8oIBbdHDKvzr9+YvrjWtQE?=
 =?us-ascii?Q?HpuhC2XCDf07OtWmyIUYOfzDnoEsmSE0P6CvvOlsIwdjsWKXW4dB4v9QQqx7?=
 =?us-ascii?Q?zfzEbAiOerYPoHM5Suml0oWmT0OqRk3zFkeatG6Gk5fhaNLtwJR81lYEpmE9?=
 =?us-ascii?Q?bGguhUVWKFX3CgONtWrUVScYH1hV9lZlSfkSTZaMqf7o1H/BeOyrnEBGBHiq?=
 =?us-ascii?Q?zU3tekw+wOuVFYrl+YjyeD4UDr/q839ROK6o+jnzE3s0n/JlnAyLp1Nxf2Cs?=
 =?us-ascii?Q?mIjVXKlco8dGxvCNMaFs7cXOLLaxZhH9ukcr4v2t9zLEJl1y3yt59aW0GBco?=
 =?us-ascii?Q?a3KCkfphgIEYZi4jSqQcF+msFdb5Wzut0XLEG8hG5Rr9maa9e3tcQyq4U45U?=
 =?us-ascii?Q?ehyWCjG2rTWXYrRu+7dkDACpWQFwPY0MUjyB/gyU+Z+WP3D7I3RtdTIqxyYX?=
 =?us-ascii?Q?/vU18AIFZxNoPzFzASxqGsppwsj9cT++hTvbuN1YchD1qTa+7+DZnAvBPMUR?=
 =?us-ascii?Q?nV21d9FWe5cmfgA7Fnr5gyOTLwt7s3b0qwT6veqFnL26Uka8Hd+QmtJaBTEL?=
 =?us-ascii?Q?Rr4kWASwkobFh8F9NNFfJkKjfkHouoEoN1SA1tiwITsx0talsiYQ8M2vnmpx?=
 =?us-ascii?Q?F6MsnOkQh/xGcds96YzoPVb9B6zJxk3vHTqHSBBERAnDHDyCJHj9RNvy0lCU?=
 =?us-ascii?Q?dFuhV3i955npKcweXuhF5otjutCEv+T3/Lw/WfMkxo6FPbE224f2B6Nja4eW?=
 =?us-ascii?Q?S3aOgDBLjXCpgeEl2lAVkecuXLLhnFVG3twix8ncixk+kQ+pvKq3ushbvobS?=
 =?us-ascii?Q?M0dlOKEj7rVwdhruWDH2ejuBmHkKs4cBa2pDSrwgGW3NLYqF33h1zEJruGf4?=
 =?us-ascii?Q?k6WEt45kygNU+QfSg88mL2GCmjoa8+6rYSGZI4eVDZv5LjfC6oL4IJtsyoL8?=
 =?us-ascii?Q?bBuBLaIeq7AM569vP2WYhW0rVC+j5K5g5t/FAseX62s6uv+x2KdEttSUR0kt?=
 =?us-ascii?Q?qNYVfIgDJN0ZbDy5WPxIYxBXxkesy2TBPeqHhmc/CIl/HQi13TwFzTL4PyL7?=
 =?us-ascii?Q?KO6fbAzXhFLSgPKvGzp4NkNLPPnSrsGHPvXv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:54:07.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634ef5f7-e3b7-4981-3ba3-08dd8f11bb0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213

Reorganize the xgbe_pci_probe() code path to convert if/else statements
to switch case to help add future code. This helps code look cleaner.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 35 ++++++++++++++----------
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  4 +++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 3e9f31256dce..d36446e76d0a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -165,20 +165,27 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Set the PCS indirect addressing definition registers */
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (rdev &&
-	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
-		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
-	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
-		   (rdev->device == 0x14b5)) {
-		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
-
-		/* Yellow Carp devices do not need cdr workaround */
-		pdata->vdata->an_cdr_workaround = 0;
-
-		/* Yellow Carp devices do not need rrc */
-		pdata->vdata->enable_rrc = 0;
+	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
+		switch (rdev->device) {
+		case XGBE_RV_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
+			break;
+		case XGBE_YC_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
+
+			/* Yellow Carp devices do not need cdr workaround */
+			pdata->vdata->an_cdr_workaround = 0;
+
+			/* Yellow Carp devices do not need rrc */
+			pdata->vdata->enable_rrc = 0;
+			break;
+		default:
+			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
+			break;
+		}
 	} else {
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 8ac0f3a22fb6..37e5f8fad6b2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -238,6 +238,10 @@
 		    (_src)->link_modes._sname,		\
 		    __ETHTOOL_LINK_MODE_MASK_NBITS)
 
+/* XGBE PCI device id */
+#define XGBE_RV_PCI_DEVICE_ID	0x15d0
+#define XGBE_YC_PCI_DEVICE_ID	0x14b5
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
-- 
2.34.1


