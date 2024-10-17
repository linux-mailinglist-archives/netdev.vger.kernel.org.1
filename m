Return-Path: <netdev+bounces-136667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB89A2A7A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABF6B30397
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2EF1EABD8;
	Thu, 17 Oct 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oligiGor"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C501E0B61;
	Thu, 17 Oct 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184010; cv=fail; b=SFUOQJQGipZIQn0UXv03TQcqvynV3vVtMXvqiRr/Z4juqIZB+az+n/i7C+CMD6pYDUCt0ExoHCY/uwTBG2pCtaerL0JhPMP4Nv+OGH323lITIOXGzUBUWzZS3qdEBDusSnGmnCmInbF6G+kAUzkqFZvV0aVOGbJxPn/2OpnDlds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184010; c=relaxed/simple;
	bh=32+FTR8e7P6rxlvWPqvp0bmnw0i0I2BlpMPc/QWrxc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0VbX8fp8vne5KK9fY0konPZsDAxZbIE2eV3PO2wBsHw325i7FldLrtr/YZ4paV43Sx2lDa8appkS0KESHdrlggL8RyGemA2KjpZwjr5U5sKSYV8cZnHh6hBkWOzVbYTHx1msTHfLOagKWnoqu4v22rnp277pmkb0I4pu9TlWDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oligiGor; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/9kJQHjYdVY0eL/gn+uoYdJpyq/vZXS3pWlTKrjJ6BnVlzD1I6gxq2B1tpbBi3ptr2UFy2sXVBeD76d9JXxVamEFG8kwGPxkTov9eHKUH5fMDEyHyvr9slbAdiPsGGrld75W/Nl5XZjy4E2aT8tTb9SPYM7KxqupRc8HC89nUJXAJcgufUl0Oae3Oz1Xp6lWZRKzJ6yHbqcUwcOEEgKmoBLu+KNFiZrHxRrloTViaKAwMbL31S3LkdJwEqDx9hZxow48gCy67UvGDVgm3l/vIj3Co2QAlrpTnZTE8p5rI96aRGGazDYXCxFDkPFBS8DXBY96ZFcjZkt13D5xy2NAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jqc/Yl4Rljn1gTC6MPfbh7nvnnOV+97BQj9ElzGccw=;
 b=IgR4q459QiBAU7FCAuEbbgxpVs9nvjvuHY9fkdqFLXHyxBKEYZFQIg5r6uP5JctyGGRCPEgpe6fJfD+CcjUaQVch8WVitBE+lEFRy1PSuN3mnOdXbwddOjRB9mf15w8OTlC6riOlmbgwU4Ng905S9KJhvlpdQybKPI2g/ZQab/5FW6V0b4sg+YucyzL8FVzm4DYneIzoOCcJlcMguIWIOPP/HU56y8P1IZ/E3I9j4fPl1M5w2T2pQApOEm3o0vfieEZwIwlDOFDBH0VWZVF77dWPxNxDl4+qAK6lrTHeHaEXFCFyj+InGsLumlo0R0jKihj+mHkecGBNjBXCPwIRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jqc/Yl4Rljn1gTC6MPfbh7nvnnOV+97BQj9ElzGccw=;
 b=oligiGorXzinMa0OBhEMKYQcUuJZ9pFC5uLPAkfO5kCr783CJn/tsKWQCpCkE2pABJpOa0dAYOQyCgqxv5y98/lLnf1KEPjXm/uxMg9iFwHBSILpVGKFSSY1ai1CDJL6Hehss+DYp7zwRZzkJkPRwf+BEhZH3Rwpm7w6eNRruuM=
Received: from MN2PR20CA0026.namprd20.prod.outlook.com (2603:10b6:208:e8::39)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:23 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::8f) by MN2PR20CA0026.outlook.office365.com
 (2603:10b6:208:e8::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:21 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:20 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 07/26] sfc: use cxl api for regs setup and checking
Date: Thu, 17 Oct 2024 17:52:06 +0100
Message-ID: <20241017165225.21206-8-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 20791f42-b2e2-4899-c276-08dceecc3675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zaQeva03krOsWbhFke7dR3N5fjRB0NeH038ZgQ7y0X3gUBTkjdOrns8BXviQ?=
 =?us-ascii?Q?eUJGCWq2inprHlxE+fKWFk0sp6mGw83kmVRgI2bPqR4pJ0pqq96+/FftMfV2?=
 =?us-ascii?Q?i1O9Y3Nnez1GjIMKqPC4S5ZFz5Yo0yDD7fgwe5CbVxn1jf+9Ou3qD1zYC+TB?=
 =?us-ascii?Q?2n0Ld4AJzDzQyL8/gux4zK7duRfz8u0SDIUgm8j95FSuNviwgPGq0CI3ZRFd?=
 =?us-ascii?Q?CQXyL05t0oWKAJzHDBgoVIsC7HTUwZG5W/5WNwoDq34mN2UgiG9udeUAtePX?=
 =?us-ascii?Q?tbj2ZzJMSp4IDnuvhORUiqv52ogfHSlGWPLnxt9Sn5TXw+8SAFbqvbZYrSLw?=
 =?us-ascii?Q?lTh5dbdhIiKjoSErNxvr2KmnyBp4TZhJXy+V0mg8EsxhPUe4gr7m/gjknbYS?=
 =?us-ascii?Q?gL305MvQyx2rhlXAkwhSE05O+M4inGZiZbryK7BZ0Oa9PoXzP2UF6EgbyRvl?=
 =?us-ascii?Q?Jw+72GRZQ59cUY34RRqDquesR4MVMxJmEtZeAIf+qEpjmVy6spPDJvpY5YWt?=
 =?us-ascii?Q?118AeCDK6rGXG+eUOLVL9BS9pAcgUdw2XW97kZKNmbocO9uA8i5RxInJD4da?=
 =?us-ascii?Q?cvkUhv0xClEmR124n76YD+KkcKFbJqjzdnyPdRX3Cduye2GnRYyCw8bdf2Nf?=
 =?us-ascii?Q?7Su7q/xZCQuWCfSx+pmFKNm8GA3Mtoh89tJq3/l2NGK6qzJDjlmE/4e1v1GO?=
 =?us-ascii?Q?eQWpQo872kCd4DGgZu8IH2r89OCJ2wKvdmilP2ZN1GxrWDoJ5PPOtwlSfKQo?=
 =?us-ascii?Q?xiP7RtSbeIAv9WPMWmDAXBVKo+c7ZvVw13k/MgKdJc03oEt3XTD5jeOdHkXv?=
 =?us-ascii?Q?9pADzWLPGkjqMYA/IZzHCY8MkBE3ZbZswWf5uZQ9yc1t14nxaENn5iodUJ1H?=
 =?us-ascii?Q?b5NMF42tj0e9OGmpe2nTON+nTaajnj5yjGtk5huwhelpXBWXr2MOAaBNocpY?=
 =?us-ascii?Q?RsePifKGF/EC0Em57QIik3efyzYkEo2vDvTiNgl0aUbqU9YXC0CRiAR7UZZf?=
 =?us-ascii?Q?jx7PmTRgp84isKHlXR+LUHdrtVelvnkrugHf0ICqEGifoIxmitJ5M4aGgHo3?=
 =?us-ascii?Q?iZpXxPlls2dRAh4wkqiGyQblLgY92m4Z3ARSeX2UfmsY9Xb52eY7gEC7X0Ay?=
 =?us-ascii?Q?hGYkf3qKqBk7F5aMgNaLKUOzLG18QrahEug1tu4QuECupMZaHHrzio1o7r/d?=
 =?us-ascii?Q?Dz0SAFf7f6Aiy0/p5SkTBvz0W0HJazF+xl0l5bCJDW3+LD1UZZ/FtlwU5A7V?=
 =?us-ascii?Q?hHIWvvV6cbeqoCQJ04ePgdIT+EP+n8UOJCl5h/HkFZPs+OuE12AVkRcETst3?=
 =?us-ascii?Q?ADmQlRVnOzZwZKP7+pX0CXrUU33bFLtfmZu85Fo2SXi8xEfPyMcAymEY/qIc?=
 =?us-ascii?Q?NLrgwgFdPW26pIxubFmBqxHTHBKyfUxUn7sxuGl9OHmuWtNgiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:23.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20791f42-b2e2-4899-c276-08dceecc3675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index fb3eef339b34..749aa97683fd 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -22,6 +22,8 @@ int efx_cxl_init(struct efx_nic *efx)
 {
 #if IS_ENABLED(CONFIG_CXL_BUS)
 	struct pci_dev *pci_dev = efx->pci_dev;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
 	struct resource res;
 	u16 dvsec;
@@ -64,6 +66,23 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err2;
 	}
 
+	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		goto err2;
+	}
+
+	bitmap_clear(expected, 0, BITS_PER_TYPE(unsigned long));
+	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
+	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
+
+	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
+		pci_err(pci_dev,
+			"CXL device capabilities found(%08lx) not as expected(%08lx)",
+			*found, *expected);
+		goto err2;
+	}
+
 	efx->cxl = cxl;
 #endif
 
-- 
2.17.1


