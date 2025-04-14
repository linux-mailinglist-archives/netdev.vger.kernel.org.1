Return-Path: <netdev+bounces-182296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23CDA886E1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AC65647B3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C72749CC;
	Mon, 14 Apr 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kQgNFqcL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED722797B0;
	Mon, 14 Apr 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643653; cv=fail; b=kfnawQTF/XQLoflDT5Ucv1oEiEVie3qrfpxx20lQr8glEIAayAjMit8J8L6ZNXXuF/7LWcGuqu15H6G877hNYpC/FduD168rh9ZgIHyl0VQ53lAGqLzjUiMkZ1F0dvsk4pcbLC+L6XJjH4U/mc0sUjMiA7U5lRRjivO/5q3NQBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643653; c=relaxed/simple;
	bh=uv6h6Lnetq3AWkukPlX6Wp01RxsTjJ9diGaQ3ioVRoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlqL8DhNMeYZNmx08OzqrckpnM35TgGBI+suZslEzCqdOQvkNzXXvjJ89G25xFt/t4Mku6YRMkZQ+qVq9Lc7ld+YhibrnVyYPN1kbVPXoVa+eKGKWriTUU6ZdainaacpePVN2i8ILG0F7LWEjHuUv/2Ly9PHr9Clo1FK7QnEkSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kQgNFqcL; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq+NGb+xkdwEzrOsJQvn0Kf/aDrB0isrxxW0P/yBHkBzbFd7N15vaLddlj09E0qEydGnTiHo4erJxGk/8JhPr1fwXUI9gj1pKpeeHzJVwSqvSg/P7vjX5xLgtGQRV4kxuKryyHDn1lQbDsZhUhXnTDGqW+xGRGJO62df9PuCN4DN4Bl7QKSWmmlc3urcde8zrBfkGVNBz14KJNqzpQS6UgP5olCYgjmlzWhdVLPeLDoXWXQUL3FgnZMEq/SF18iF+IK0ohk2WqAozsDN2i/ryrFm6Ru6uc4DuB7UdIgXg+24/RpHediNCrtngURrBviys7gbhFkgjU+hzG0Wvh/xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7+bxCDiMI4RfI7xe2YerADfymyr2fUIzaccHzfbC94=;
 b=Pt3oFC/xkJqKZJNb7b0R9Nwh2vQ4jQrHmijM8hpAAHCIQ1M0FXX028CZvOLaK6xxgbwFRonNe52MmC5qOUcN3If33Uu5NLWJrrTqA4fJEpw7sCysiOeak3C6ME5lrtGGEgxA+Mgx4+adGfG3w90yv0Vz9MsjQVPaoBVOGQkz8MJmLd9Yi51nuLam6ULeP5HNq/x6obKD7IuOzMxuW7ilhidl/I7CL06xK55ihlPT+sah7w08bH41t2SIG0yvDr7qr75v1TiDxoS4x77NAeS3I0dvV+qZCuHx7OLEd3R6MVvy8HEPWdCS0R9pRs1CscBmyi3D3xlhIZn9ByLerkxDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7+bxCDiMI4RfI7xe2YerADfymyr2fUIzaccHzfbC94=;
 b=kQgNFqcLNRkXADNUTd0I7KTo509gUWoRnHjts5XWENHy0AI7+F85sZUVdVCAxcmkuCmtFDYndBwpDY3TB4RILPbRvrpQ8a1V2yB/wPDP2iPqFNt9ReVRdFdYl9kmatrd7LIngEpz51ceX0HydkxiJbDrUVdmRV1CuivNqYKmfBY=
Received: from BN9PR03CA0410.namprd03.prod.outlook.com (2603:10b6:408:111::25)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:14:08 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::60) by BN9PR03CA0410.outlook.office365.com
 (2603:10b6:408:111::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:07 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:05 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 14/22] sfc: get endpoint decoder
Date: Mon, 14 Apr 2025 16:13:28 +0100
Message-ID: <20250414151336.3852990-15-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 47907b5f-8bcb-41d0-6a8f-08dd7b6700b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ZCCB+URbQ/0zyf1dEXWZx96z/EEIb+Clc44aUSbMHgVDW+eZMYAuBa7ZvWW?=
 =?us-ascii?Q?MliK8BQs97ZEJ6/dCB4LZhrRUKDrLUEZnkxQ1RpvIbg2qZIMMRxxzMdNV/5q?=
 =?us-ascii?Q?mo0SoB5svtNy8K84AEbBaRLhqUWDUDHvzm6rpi5ekwc+7Ih3HN/PmZfdGZvQ?=
 =?us-ascii?Q?j3hFCXmx9qCHK8jtckkboUPGuutuoMcyqKldL5kjS9bPAzVdINXZR0kY6CQy?=
 =?us-ascii?Q?ovYJ33ScdJTi2VSvWK52I2n81vclY73oUnqxho/WQ9SDKyZEsuxdVf+gF3hn?=
 =?us-ascii?Q?HDq/mJwbSeBufORQGlIaT7kOgJvqaWJ1n+eWkWj8V/JehPA8QQzdFxkyqAuS?=
 =?us-ascii?Q?XiD/dy45uQkTGPYC2wV7Cj+Dx5DGmzp+WGFdCz0S3rhs2e1uIXqYIwalfpWn?=
 =?us-ascii?Q?3J4jSqadIVL/D4v12FBKGiZyiw8vyMpQPUGsOEJMNIpWoti983WRdu5fDT2d?=
 =?us-ascii?Q?/36cZi7d14wk31VII0EuOWwRSuvHNWRp/oabNXNToRtgCbjp+0OFqYz8r5J2?=
 =?us-ascii?Q?jESYp+GRAGbAg8qJtBf2N3XNh3FUU5ISwDCrh6e/ujDE0VHrieg9kiW29Yef?=
 =?us-ascii?Q?vmOSRBCf2cfPHmdqur7X305j4UnCfdrx2+Xz0fxbo2ChDrbBh/wJD5PCJhtw?=
 =?us-ascii?Q?4nPu+DR1PSVcCN56Y0wFA5UsN/tFHp/92KWzCPo6gExU3baqPrb4Vkl+QLX+?=
 =?us-ascii?Q?fZG/e7x+/1TmcvfgZxCHZY/zlw7GZHNfyAHXyHxqGjzQiFHByCdJ/DIv5/vW?=
 =?us-ascii?Q?5Gjf28hueJIzJjTjlGm6mBoocK3XTY7KSWehI60QQeQKmdWnCaxK1GAB12ro?=
 =?us-ascii?Q?LDbsQ7n1e7cnjiuZhrvOXn1OQTuo3k0pTUe/g9G5nzn53jARPOcmMHjbZiaD?=
 =?us-ascii?Q?68nKQHXJcYHiBFr9Ils99qwsEi+ucvr2nD67cKaxU/v/00O/cLACCESFpmnK?=
 =?us-ascii?Q?PX50gYFEwVUA/5AN9Ws3ICp8mlTKBtI1+8KpgUAeyWOfRjTdu/ucu2XKtnd9?=
 =?us-ascii?Q?KFy9lDzJn57KASbeaHUBIF4jJpH/HITaV2ibAGOkSkoOSnTrBWxrm1BeVO2p?=
 =?us-ascii?Q?/+0vzK/oiDur+TPb7l1LfZFBjy1WSRc4zHEA6m9yzrRMGj314dDfhmWLZhVG?=
 =?us-ascii?Q?NmRlRTAX7FhoAInqcO5FxU7YBga0z/yQTUM6kZhUT1LJc5XnI13dtZaD/YZD?=
 =?us-ascii?Q?96W0Bnaecri0g91D/d+LEcKD5ZK1f3juqJRdXe/myJW94lzRLrsUe3mJ+BNq?=
 =?us-ascii?Q?e8l80rr16eHFb5PCotrabM6m9EgXxiKiOgBqAH+crq3TJRqLD/PNLNx7n80L?=
 =?us-ascii?Q?N8+QX3i5zwm/4Aimpox0XaNYC44qBVBldOpCJcZ4uzci0r1Hx3uIMMu/mZGc?=
 =?us-ascii?Q?ZgTEDfz4brlJbg4nfB0z2vhnp9mHJ5kXe7iFZZwzqBF0hrtc7vuUENtZOlEQ?=
 =?us-ascii?Q?y07M8lU4DiRD72GEjp2R4DckRnkqBoYtZosSYECXVRPA8Q6zStiNvjuoX3Wu?=
 =?us-ascii?Q?9VF2A5L4ILaQXFMn4g5oCk2yA/SRFcWO0fuN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:07.9615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47907b5f-8bcb-41d0-6a8f-08dd7b6700b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 7236d255e36e..7ad5d05a8e83 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -100,18 +100,33 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
 			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
 		cxl_put_root_decoder(cxl->cxlrd);
-		return -ENOSPC;
+		rc = -ENOSPC;
+		goto sfc_put_decoder;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto sfc_put_decoder;
 	}
 
 	probe_data->cxl = cxl;
 
 	return 0;
+
+sfc_put_decoder:
+	cxl_put_root_decoder(cxl->cxlrd);
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


