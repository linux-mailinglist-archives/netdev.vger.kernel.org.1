Return-Path: <netdev+bounces-136677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015879A29C9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CB81F216EC
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311771F4731;
	Thu, 17 Oct 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0dPUchpl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADF1F1303;
	Thu, 17 Oct 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184025; cv=fail; b=lYdT3wYxdGUFzm/edLn/js6O/bWzBetR2qw9jOnD8Pa2RLcnyBEIanliCDkuYIgo43+Di04xCRZARGOy/I/+Gx0TpTlh2OXCKGs16g65PRuLTGymt2/Lc+TvQcIqNpUkz0OBjLqm87jtzqCCfAZfG3U0mvrTa+hoC/X8bcnLoao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184025; c=relaxed/simple;
	bh=Ipqe3wA8z+L52pxyrcKKodzMlgwFyKNu5CqSFW5szRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGNx3EErw7APrWcI6Mj+T8yiXMF3A5spsUIyY+cRBl6yJJ+iWNDzrsnqd0+j3zOhq5opbWv1mJExyLZgN6kUTEf24YLJwZwHgCgFIDCk2PW7K6GdwdGKbPEO1AgOZlsEEbFeXi8Sec8MhorxDqwFCBrXL4yb1E6yUzBcowjmTVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0dPUchpl; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOKPzkzwd8oCedHkgJJgN/VHqrEveW09bmtMQnSiSJ+Y9FVpXia/c7CXg/9/XI/L8idZUNaOym3z3YDi+pJyG31kupctCRuqys7vDi1Raplg0/eXdHuYTHzwK7PpAUvqwcoIXZ3URPtzZtEcO12K35UygnWA1kcy+/MBnPb4KWmsW+EL8qNtR0W5oe2RiZxFP5iRZt2YKFUq2ulPFm7kkZKXUIWUguOEdlsaSIZ6tNdBfq0YahcVAsH822+dKzQ5ieMyrcXhNJYKIlXSXFlvTamciUHp3EYVR39+T9J/X7nGYdeY3/xatbB8K24xqyaqjSJmKVgGEKSWB7lptULu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW86fDaMsv/Hbqo/l4r2emx1bzcUW+4uv6m2r8fczCg=;
 b=lPsetW4/qPsp+N1sBn/KC6JQy6DnWLB6/mO9/aUCFHeNyiKGPt6tL9cCPBkO8D29ynAkoGnrRVS2Fc/KuWpOXAzVaG2LHBNJUI4Y9D7MelREFStgswsWYwPa8rlwar5LAg/bEB2y6WEqZEVCOz/S1jXR7BeQB+W5Wy7OkqkKggoZ0HcAmFGMbbW52MwsGMuLEc0zMKkJbeEpqZEg/7H8/A7yIOosLoA5v6KKxIMRxnYMBcNNUfBDkT6adxcNh2HBJuQXN5vVbV3bUHnUOj9NdeopxKbD0ZbT082LPUO57rmNQgL1eNfIMuMwW8LF4DSC6/QkkKarnI7Wxw8qHUWtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW86fDaMsv/Hbqo/l4r2emx1bzcUW+4uv6m2r8fczCg=;
 b=0dPUchplSxR6Ur/DhF++HmxVuqXFonQpXmieNnyJsnVki53d+SPywYkI1g96yPJZz/83tKjkDLIm2zDNG/hiehwUxAhtbzt4IN3v+BweQlAM9EKFwfM9nkeUK6GaOJvUAccHlrjI/CgGKqIBshpB/qvD6+iI9w3gOLihfRbFhz4=
Received: from SA1P222CA0031.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::11)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:53:39 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::d3) by SA1P222CA0031.outlook.office365.com
 (2603:10b6:806:2d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:38 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 18/26] sfc: get endpoint decoder
Date: Thu, 17 Oct 2024 17:52:17 +0100
Message-ID: <20241017165225.21206-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: f56c3765-807d-4535-5951-08dceecc3fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kdiFcvNm2Ycl/U7REY2XWanQqXvFsZVKYvGuTOkIBqzv4Mgt/XvG3/SlHXuk?=
 =?us-ascii?Q?h+c6RZRF1A6yMA4QYOPAmODUAlta4fSlGZT1k2m4p/GbzGIMNqxAONSkV92G?=
 =?us-ascii?Q?ehWfkhMy1gT4ILLC9t3QVqOK/kyb+4mwI+ewcg6HFzRPtA8N5Aj8wO2jeYvq?=
 =?us-ascii?Q?4H/rcpsaLVXLM8BfxkqwtjijQbe+fX4jxXfflnkY/SI9YeE8pAgwDdlzARFm?=
 =?us-ascii?Q?RSidKj067WBtvLzyZzt+LMj7h4PAQZ6dHRhMRV/ZV5oForY/0xNK8MHym10o?=
 =?us-ascii?Q?S/GfLjtnYWVGtwcY3aMHMifZiLaQay+c+cLIA5oOOda8oKOoAm8wFlXWPcIr?=
 =?us-ascii?Q?e+4SMAHRFehmVjTJjPaQXpX3PNGU0eawjpsyMJBMiVjDOAb3aBofSUFzG3eq?=
 =?us-ascii?Q?zA/otcK8cSzIRmU+Pj8Dbf6BCJ4QUmYE6FcQ9TfLNC7WFbpSGkwrzlQimS5W?=
 =?us-ascii?Q?Vob9RbvaWUul2rLijO+MmYrFNtKjH9RH4li9r2S9WuFyRCmb5MNaFtwA59d9?=
 =?us-ascii?Q?Qw7koN04nXruTltoN0JQK+7mViiJDIy1tvC6I6CkETSFcLLmCnQw4wCJ9kkj?=
 =?us-ascii?Q?YygHtyJFmkMcDX6IZcnrYdnsrGBbG/83KTiJGjSCJSd2i7V3qOuSxISBa9fi?=
 =?us-ascii?Q?HmMHq4bCHyqK/exFqIeZTsppuV2rpWjtMnEDh9GzlFK7JAN+mTIq20l5/Gpn?=
 =?us-ascii?Q?ygoTc+uahY2urwGki7Ffg3/sfPqg1q5V7FapPYkOi8BzVPllrpC+Bq3H5yq1?=
 =?us-ascii?Q?vc6/bqY5N1i3C8mPZTQ98v0do01fLhjU4eGnq3xt/sKG90e5UQJ7pe21kZoh?=
 =?us-ascii?Q?TGWQNe+M+46QPURNAy7z9YcajVFSlyf1lq4ODQUuzgPN3E53g0V2GFq7aufC?=
 =?us-ascii?Q?h83kfr4quNw7a/vvUbzpkqhUe71zSmH/FjnyH/25BYBLBF4NxFJM+T72y1/b?=
 =?us-ascii?Q?A/Q9bwLiwcdOGsUa3cL5PfAs/S/LEFVWs9Jz24hyyLh/LkLojjr+BKzhp8w5?=
 =?us-ascii?Q?WCu2H7i+l40AM2WXyuoAWcxZy5m5S9xU0SD18PjN+Ii9mpJM8m/olj4gFN21?=
 =?us-ascii?Q?UKjJvfnKbY0hqzdB3sDmKTAz1T7n9+ODMZRfJ16iJPUjVfteoyt/ug4Kelz+?=
 =?us-ascii?Q?Dn3vmFWnkSaXQgo6B13JvBIXjRKdOsEruxrr4iyiuFX9elkj7SvkRVKv1aAP?=
 =?us-ascii?Q?/88PZsImAb/PaJiCeROk1ZV1D06Vot5Mu/adxT9fDDzHWaIcTX+NKAZJwAc4?=
 =?us-ascii?Q?KZQwg0jXdIywf3OS8x9IG1RD4b4uHt734AAUPRE+H0A90Hy3qQ5lsIvO5FGv?=
 =?us-ascii?Q?pSrtjlCl9WskT4nsu5aQ6V12b+2YndYRs6Jl3JXZ8Acx+hQ2jyy4Qr9biGkG?=
 =?us-ascii?Q?o+31DMpxKmnF2TKNhjaRKm50ybOvlMlyGmuz4VJnC55SFv9nSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:38.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56c3765-807d-4535-5951-08dceecc3fbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Phisical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 399bd60f2e40..c0da75b2d8e1 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -119,6 +119,14 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err3;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (!cxl->cxled || IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err3;
+	}
+
 	efx->cxl = cxl;
 #endif
 
@@ -140,6 +148,7 @@ void efx_cxl_exit(struct efx_nic *efx)
 {
 #if IS_ENABLED(CONFIG_CXL_BUS)
 	if (efx->cxl) {
+		cxl_dpa_free(efx->cxl->cxled);
 		cxl_release_resource(efx->cxl->cxlds, CXL_RES_RAM);
 		kfree(efx->cxl->cxlds);
 		kfree(efx->cxl);
-- 
2.17.1


