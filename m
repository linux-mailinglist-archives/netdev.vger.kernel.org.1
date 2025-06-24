Return-Path: <netdev+bounces-200669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E13AE6828
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E76B3AD522
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9572D542D;
	Tue, 24 Jun 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dck6WgrY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEA2D1F68;
	Tue, 24 Jun 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774468; cv=fail; b=OZ6NcwKbrvk6wU1fis+ftFhhQJnLV0b8rasBPrfarVY79dbZm/kydJkVKct8gA/CSuLAsiyGEjZUqVydh2QlZAaYh+aZK5b9ptHV+E+RxeK48kJrpdgY2jKVTDuH1a/SGSYW2sGBRs4yeS2KHQ5im1yvRUldkOP7OVnlesZ6xzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774468; c=relaxed/simple;
	bh=yJ0uApyCOOyRXiEWcrL0jrCZADxZ/yBJABnUDHA2CTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdMRGzw+6VMtDGVeuyB2TqYnzRlO1uHfGMiJ0AvgaG5hwy++AthZBZ61DiQIB29AAlkuc8VQlkFzXTN7UJ8or0OY1U4GGCvDaKPlIH6rTDuPV68u3IY+rpb/uhVmFJ8/0xirvIjVRYONPYGzUmXukCUN/xssWWpl8Cw9cf01dCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dck6WgrY; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksSt/T48+1PYW0iLR6X+OM2bcniXYMmPUkYK9I9jR/RAbichF43rJ4vlCOd3k3/mUcDM2/ucr/XaX0KwIxH7MlwPTESxJdU+/mUsXaTwjTl6KAwqtDR2+Jf7vm9FoDnkAelcVQTrTnBKveycrRpSdDoM9vgvQcvRU5LF41yfIoatus8U6rcis1RS00Yf2qFhsubtKLS1Xz7AriSVKJ0PzMYtfUbJylHVjIE7FpYy2YCLguYoFmrhVMfTW73XhasG47hWZ9i0QleBMDE76qFrFdJUV5/j6NJTIZfvQMjrLNrZtZU1MP3R9duGFDRYJmnjpjckC4ySPwE+rzSiqczDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BswwpRCkGMkHWYPYwrivMnOqf4iXBTZcBpcXqPcMmfU=;
 b=trxHaiHicgpkhRMOpuq5Pz391MHrfLlnvun77GaXhK5dgS4u+2xcWDOehcNbBuyP5zV1ERbOeeu5Hdb45fE1edj6yZP5YxwdEoxMH38V+qX/jUAvpe9C5ltAA9270nJwwCqKkx+mPEXLfSjcmMpdKwoKcoKSDzlrAY67Ik90alxGDipDgs0xVvSxNzSGA4JFoiDo7AJUTYpIXEE4JLQGpwfPUEqfQlQteXp8tqoOBVv2w7KVl/lTGrYyRWNRfIog8/vJlTxehoXlnu0GEHRV5vQ5wgK2PtTT8MNh6lIuAjU8z72YGsF2pVNKZE0MjdD/c8B+oJ5iZKWshnk3+j/tQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BswwpRCkGMkHWYPYwrivMnOqf4iXBTZcBpcXqPcMmfU=;
 b=dck6WgrYf/5J3KLrDXVl3cC4pVU9N5mqVN+5vRnTP+WcmDBK/RGE8E2PqRO22FE11Zyo1M4cT2QEjRRmwww2nfxebVCzYCyKbL6kp3LdMHolXEjQggRHspFtM5+nqYmP9hJRFqw1IwEzZWAkYJaC6EtMXUcdINj3zxBU6Lo0VyQ=
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 24 Jun
 2025 14:14:24 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::35) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:21 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:20 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 06/22] cxl: Support dpa initialization without a mailbox
Date: Tue, 24 Jun 2025 15:13:39 +0100
Message-ID: <20250624141355.269056-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 25960905-4578-44a5-5acf-08ddb3296b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1pNbTZtQ0cybElCTklZOFRRT0dKRHFxN1o0SFZmYW5Ddm5MSTRGM3I0TXBD?=
 =?utf-8?B?K3FXMFNMN1NXTzlzaDM2R3dORHhMU2l4a1Zmbzk5TW40YzE0bXdwSXdUUVpO?=
 =?utf-8?B?MDN4bElNU2tDdk0xS1JIS1JqZlpmUnUrK0VyeW9SR1VQVGZyRU4zYTBOMDgr?=
 =?utf-8?B?OERvUnpuKzNJVlVqRkVSUEZMYkUybTJISE9qVzJVM3ZidCt1azZKcjBkRFdQ?=
 =?utf-8?B?L3FWYlcwcTl6YzMzSzU4cW9GbW13TGhZNmVCWG5VNkVWZU04bExWcGgrQmdJ?=
 =?utf-8?B?NDhMUE8yd1NGSVlwRlpjaDQzKzNWUmhCMC9zeTFkSktNc01Sb1ZUVjA5a1h6?=
 =?utf-8?B?MEE4WktKbFQxT2ZDS0ZtUnNDTDZSRTVlcXA2cVhKZVhPaU8zSTBSSitUTEZk?=
 =?utf-8?B?ellHRkRQc3U5Qzh6dGNGV1I0T21LcVQxM1Z6cWFOZUZNTmlTQysySlo3RnVz?=
 =?utf-8?B?QXFkeUE5bk0zeTJVbVUxdDB0aXJZRzdnSFptcFBidHlDbVhtdW1weVFSemJp?=
 =?utf-8?B?QnUyeHkrZ3Q5SDlLaUU3NnFKMXd2YlY4ajdzS29ETEJpSVdpODlRQm5NbGgx?=
 =?utf-8?B?QjhtYXRrVUo3Qkc5OFgrSE5FbTZEK1pjNXVtVlljd0JWQkcwS3ZiOTZHcTE1?=
 =?utf-8?B?LzhHcUg0bWhVUUtaUVBwYnZELzJUY2M1a2xRMnJrMmQ2ckJIcjJMbERXcm16?=
 =?utf-8?B?OHV6RFA0cDN3Unpad2R6WVY4NFRKcXJuOFJ0Y0RDY0RGSVh5R3Yzbm9ZVjkr?=
 =?utf-8?B?ajRMNmpndHhHaWlnR2NmL2lMOHRlUk1NMHU0WnpGMisyZURkL2d2QSs3ZG5o?=
 =?utf-8?B?WjNpdGx2R1BibGhmUEdleDBmUGViZU1VWVBqN2ZYZDhNR0RxR0VsQURnYndX?=
 =?utf-8?B?OEZJcUsrRnlMdjBRcUVnUU53YVMySlpYd25OQTF3elBHLzBjTURRQU5aQlhU?=
 =?utf-8?B?U1JNWGNFWVFjdkpXOXpadlJuUkU4a00zMElkSlM4U1lkYS9kdjBFcStLVld5?=
 =?utf-8?B?Z21Zd0kyd0NmTmdsV0ZjYVZQSzVBOUt5M0s2L1pwR3pDaDJJVE5hdjZ5aDgz?=
 =?utf-8?B?VElLWXBTdmJldG4xOXZwUmc1cGxQcnZoMEF2Z0NYeDRSNWg4R2FpYUxFZ2tl?=
 =?utf-8?B?ZXI5dkJ4c2xJZzNELzRwc21pTXBBcjJMLy8yU0dBL2M5OXBjaEVlU1IxTTBk?=
 =?utf-8?B?UFFRRk9xZnN5ajlEcEZmRDZHZ3V0UmFpclBtYk1oYy9vQ29wMjhHeVdYRjcr?=
 =?utf-8?B?NThsV3RmZjhKZU8xOTZkNkVLUU5aWTA5S2xGVk1TMGFaa0kwcXlTZFpFTm5k?=
 =?utf-8?B?OTAxcjE0b0V3OHJHTTlpNisxUkgrdFJ2bW5lSFdtaXJzbkpETTJ0NmNxblNq?=
 =?utf-8?B?SWFKZXAvSmN2b0lBYjQyelpTcmVQdmc3NEZHWHdZeDE0TmZFRUlhUmxOWmZp?=
 =?utf-8?B?UmIwYkhucTUzUlljeTNLSkwwZE9mbkZqZnRTSHRldTFYRHo0VHdjVU1aM2tV?=
 =?utf-8?B?ZWMrb2phN3d3L3dGZXlMZVJvSG43QzhJTjJUQ2gwN09DZXhsaUQzUHFOWk1R?=
 =?utf-8?B?NlNFdnRTVVdZek1HWWdxVzcvejRaMno2ODByNnJrMGI0byszYjJTK1NhMkRP?=
 =?utf-8?B?QzN5QUM2VmVNY0prOTZoaUdlRTA4L0pTcFB3c1Z2RE5jQnM1TW04TDFLYzRW?=
 =?utf-8?B?MHdIS1kvZEgvUngza2c2N3FTRWl0OWVBMk9jbjBUb3ZGKytocDRNRVAxbktv?=
 =?utf-8?B?QzhkVk9ZWlhLUlBGOHA1a0lqeUJwQWJ6Zk9qalhacU9LeDBWUjJaNTB4dDhm?=
 =?utf-8?B?Y2xaYmIrSTd2Z3d0dGM4Yk9PTVBHTFlMMUNpbzBodlFjZEQwRWhjWXFBUmU2?=
 =?utf-8?B?Tk5Zd2pnQUg5Q01qN0VLSFM1NkU5bFJsc2dWZXcwQWlDaDRFWU40cWFJN2di?=
 =?utf-8?B?MTdNSmpLWTlhKzJGNnoySzFxeGd6dmJpaGVoYS9yL0ZlT2F0a3MrU2Y3TmRH?=
 =?utf-8?B?OUR1ZVVaYkVjSStJQlQ1QXIvR09OU08zTWh6WW4wRjNGU3JRbFlFY1pldUlB?=
 =?utf-8?Q?OfF6yh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:23.0252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25960905-4578-44a5-5acf-08ddb3296b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
º
---
 drivers/cxl/core/mbox.c | 17 +++++++++++++++++
 include/cxl/cxl.h       |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d78f6039f997..d3b4ba5214d5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1284,6 +1284,23 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 	info->nr_partitions++;
 }
 
+/**
+ * cxl_set_capacity: initialize dpa by a driver without a mailbox.
+ *
+ * @cxlds: pointer to cxl_dev_state
+ * @capacity: device volatile memory size
+ */
+void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
+{
+	struct cxl_dpa_info range_info = {
+		.size = capacity,
+	};
+
+	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
+	cxl_dpa_setup(cxlds, &range_info);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
+
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 0810c18d7aef..4975ead488b4 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -231,4 +231,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
+void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


