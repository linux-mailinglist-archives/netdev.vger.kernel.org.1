Return-Path: <netdev+bounces-111576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A4931950
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BEB1C21764
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB48120A;
	Mon, 15 Jul 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HFqTMk9Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F44D8B1;
	Mon, 15 Jul 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064553; cv=fail; b=rV64B//3DS35k06378TaJvmuucTzLF0RHVZhdhbVo8MQZBmMJYd/josNYQU5Go6CJQ0oXIBYssKRFJ9p/ewTLZ82++Z/OZg72X2yVY2Bh38uTgpYsf91gL43uM8NzjYwRy5XWspiWCAa1JI/wsAFnpt2n59yGbQX2DZ4jMu/5Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064553; c=relaxed/simple;
	bh=pPvdLyUcZvGHXVqIIg6J0VgU0IqwiNdrrcApl/+iJiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRQsMeBmJai0q6Q7C5GiStijcIDFjRnZnn4TGE8l9rbrbryZuunRAxqqc4hgZyA55nzmeUGd/hbm0PWULKzb4bzEjtEgbK0VzST2JqXDLUxbTGeHTLSYZZOiQHN4OFB1iJEAWvHPDLVKiVdt0LIaF25H04fZyHDvPyktSXB4KX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HFqTMk9Y; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkF6PcS4ZkRsU46lcTB3g23YhpiMsomhZ2jr191TfaTNFklQagI/N4vUXNKxe8d8Du3ixybeIM5JAbHVkqAxgQmulw5vENttJ2iLw0xPA2VYir7r/rTsmkBTHitsFvr4qKurlbLkXQVlc8Wv3KWBEcZR92FFni5iU5ymIM7D4qE/vMvF213IpibUNyMO7AOWa7ViOinGlhp6veZVauLeE5xdxnJfnSfyq0Rw/Q8xU+1JizMSoO64NZH5tpaawrWBDK1iTzXLYDJr7PfWHjBHEgx5S+MhevqqLJpUHAOOaO6+Z0ehD1ioIMiY7CdESvCb1SEX+jwUZTmihzv+5ctTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGyrIBQHmZoiBbIwHpDxe4I8NUNz2zk037VCCPCvC+I=;
 b=MfmK1tE7IyKSylHBFl51Tc/vJUY+Xv4SZHo4Db4Wb3cJETwDorE/fUeoJ0mXqhhtYzv+UN7wM3sPb/2jp7CCMBcYYjk8ruKb9bkYk9Sajo2UMVJpEwlbeGer2DdtVlOgsJbRDlyUEZA4MZvu0fZInxUj/nce+70vkIC7JhBcRRE8jKWE8GVIJqyatW9Z2m44+mSwPdyj2Z2zqXZ7qZGJ1XlfaerK9Pm3EenxvGtlW/MrgGdtWhCfiFi4gPlbruEs+yAeOidBOcvUDxsoFtgqf1Q1gadur1rr8rCSjmuakIzGwr03e+NeKB2JmTpkj78QOMBUA6IOZXh53nV/KO6fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGyrIBQHmZoiBbIwHpDxe4I8NUNz2zk037VCCPCvC+I=;
 b=HFqTMk9Y8CvElFh9FtKGnlvUiEOK5No3fcHUoM9DciaWLxWe2KxxnPuYntQGjErm4l73M39VHFMMvlH5wejpnMSBwldXm/nINwXvHQumRnI4YzwPdnv0eKUis7to49PP3joxCl5m+xe+NYrXMspgWFDlOYU5gOdRLVBHcf6BmQk=
Received: from CY8PR12CA0045.namprd12.prod.outlook.com (2603:10b6:930:49::16)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:29:08 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::ce) by CY8PR12CA0045.outlook.office365.com
 (2603:10b6:930:49::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:29:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:29:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:29:05 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:29:04 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 15/15] efx: support pio mapping based on cxl
Date: Mon, 15 Jul 2024 18:28:35 +0100
Message-ID: <20240715172835.24757-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 562b48ef-12ae-491d-450b-08dca4f3a20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCDPWET5iNheMoZRwCq0M7jcwO/xrnGScXe1OkUxn+AOBdv1+ZbF9KG9lpCj?=
 =?us-ascii?Q?vxzIBjXyEjxGEge1iitHP1IMbUBU6J6c+bchulrk5CK+Aut3aPegkD23b0gK?=
 =?us-ascii?Q?eBek3CU6buZ+iQZrwOZEox8DLVQB7eiDyf7rT4MY/+OI1OV1PlMXIVXwtPXP?=
 =?us-ascii?Q?parztCCRJk/aTFBBiRmnKU+aOLTTUxDN0KMMv+w5HURD/RGmXHSQmee+XmQp?=
 =?us-ascii?Q?JP6M6RzpYgB1hcoqyCkTnMniQ+p54cq10ZSx4TIeDf2SxwAxAkPMOdrDSPYy?=
 =?us-ascii?Q?R8CusD4v9cXlauWqwntPdLpuqTbbzQlD5QkLp7lbo2zsqCddFYLr4lY0/Cvx?=
 =?us-ascii?Q?mSdhwdw19z0lpdtaKReBjFleJj8T1anO2yJZ8r0scDLvqwHMXom5GFrGjMns?=
 =?us-ascii?Q?b491j/yqxnAmYmrGFs59Y/kuhmwWjK+sv1wEShH1oteInJNLkUQVdieZMP3a?=
 =?us-ascii?Q?SokyNcLpmUT9HIXxEUBG2wKrkmNvu21op/byJdmNi24OA+zHP/CoqtWgxlTw?=
 =?us-ascii?Q?haEiTAAxYsdKTfRxE56D0N8XbODInOe6PNMlQWVSpUjuuezvDFfyWSmT3s+H?=
 =?us-ascii?Q?jg8BeSve+ySTYOBVnoBr1azM41+jf1V6awfMgIbORAVMbUvQaQc1upx/RqeI?=
 =?us-ascii?Q?aBgD/rUv7s2kQuGfHzs5nxpNJsxr2wBq3rjoMX0TrVCzkxT3mYHUWA5JMmP7?=
 =?us-ascii?Q?hmr3M3soktaAeWT0nJlWuIAJ37Clz9W34T0J2PIm2uuoH5tP711PAEfPKvr+?=
 =?us-ascii?Q?eiozDdbx10aNmwM4G9MgEbhoTCip1ppCoJzCzzrCgNhhqEwXWie8ysKaHpqC?=
 =?us-ascii?Q?H4H0lnkwVAhgBeo6I+oMH4s8gpvNl74fklZQFwil98lleCmCk1whyU2ROlkS?=
 =?us-ascii?Q?BMlJUgaI3UV73yQBkiqStI58O4qq154HTVv5fg4xRPw/OhBRtxCf44BlELYf?=
 =?us-ascii?Q?KrCtVCPmgvfwLjQi95KujQb5P2JEIWBbzNsI6NY28c2hNFBt87cmd+dXFEN1?=
 =?us-ascii?Q?lArCf6JKYz2KpolaR46X1v3JH/I8vKu9eyS/LT5cCHsJeu6hAcljsPMo7yqm?=
 =?us-ascii?Q?knk9CBkQrqvn30BxfN+jf632WsTPhlcA2Ev8SavvAVBx3cRVqLAR8gvmbmx6?=
 =?us-ascii?Q?fIEu9YzSxummx6C5bJzadZTaNOAqoJ4zIVllZ3/iTx5tUtcIfF1v0uOYzhe4?=
 =?us-ascii?Q?j/Jqt8/xr7mLEbadxi40IyMY+8EpkotrEpQDTKDa1/8jeklsgQy6A+tADkNy?=
 =?us-ascii?Q?QAZsfS4GmPW4YfHurUvvhoGGnLxwIfhb4PcsHy3YPhXSEXP2qyeB289RNXWS?=
 =?us-ascii?Q?VLTgU2ydL8cbuqNxjpbSaWBkpMg4F3sPQDhi9RqWxVdRtucj8mWjVsw1eWzB?=
 =?us-ascii?Q?XgdIMXu3bJo37Kfugoo0MBZEmBFbL/rx1xLvQvh5jhgxLLfUPLchqanNjcz/?=
 =?us-ascii?Q?5GVGoWgP6BE/nYE8WI7C9zAzhmG2FbBfozD1mVcqzcB1ec4tGy8aqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:29:08.1370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562b48ef-12ae-491d-450b-08dca4f3a20e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c      | 25 +++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c   | 12 +++++++++++-
 drivers/net/ethernet/sfc/mcdi_pcol.h |  3 +++
 drivers/net/ethernet/sfc/nic.h       |  1 +
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 8fa6c0e9195b..3924076d2628 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/udp_tunnel.h>
+#include "efx_cxl.h"
 
 /* Hardware control for EF10 architecture including 'Huntington'. */
 
@@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 			  efx->num_mac_stats);
 	}
 
+	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
+		nic_data->datapath_caps3 = 0;
+	else
+		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
+						      GET_CAPABILITIES_V7_OUT_FLAGS3);
+
 	return 0;
 }
 
@@ -1275,10 +1282,20 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 			return -ENOMEM;
 		}
 		nic_data->pio_write_vi_base = pio_write_vi_base;
-		nic_data->pio_write_base =
-			nic_data->wc_membase +
-			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
-			 uc_mem_map_size);
+
+		if ((nic_data->datapath_caps3 &
+		    (1 << MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN)) &&
+		    efx->cxl->ctpio_cxl)
+		{
+			nic_data->pio_write_base =
+				efx->cxl->ctpio_cxl +
+				(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
+				 uc_mem_map_size);
+		} else {
+			nic_data->pio_write_base =nic_data->wc_membase +
+				(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
+				 uc_mem_map_size);
+		}
 
 		rc = efx_ef10_link_piobufs(efx);
 		if (rc)
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4012e3faa298..8e65ef42a572 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -21,8 +21,8 @@
 void efx_cxl_init(struct efx_nic *efx)
 {
 	struct pci_dev *pci_dev = efx->pci_dev;
+	resource_size_t start, end, max = 0;
 	struct efx_cxl *cxl = efx->cxl;
-	resource_size_t max = 0;
 	struct resource res;
 	u16 dvsec;
 
@@ -104,6 +104,13 @@ void efx_cxl_init(struct efx_nic *efx)
 		return;
 	}
 
+	cxl_accel_get_region_params(cxl->efx_region, &start, &end);
+
+	cxl->ctpio_cxl = ioremap(start, end - start);
+	if (!cxl->ctpio_cxl) {
+		pci_info(pci_dev, "CXL accel create region failed");
+		cxl_dpa_free(cxl->cxled);
+	}
 out:
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 }
@@ -112,6 +119,9 @@ void efx_cxl_exit(struct efx_nic *efx)
 {
 	struct efx_cxl *cxl = efx->cxl;
 
+	if (cxl->ctpio_cxl)
+		iounmap(cxl->ctpio_cxl);
+
 	if (cxl->efx_region)
 		cxl_region_detach(cxl->cxled);
 
diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
index cd297e19cddc..05fd5e021142 100644
--- a/drivers/net/ethernet/sfc/mcdi_pcol.h
+++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
@@ -18374,6 +18374,9 @@
 #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
 #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
 #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
+#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN 16
+#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 /* These bits are reserved for communicating test-specific capabilities to
  * host-side test software. All production drivers should treat this field as
  * opaque.
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index 1db64fc6e909..cd635f4f7f94 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -186,6 +186,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.17.1


