Return-Path: <netdev+bounces-163048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25889A294AD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E209C189541F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D40919750B;
	Wed,  5 Feb 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uq+m0GXf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E6194C61;
	Wed,  5 Feb 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768822; cv=fail; b=a2gidgl2c+LXISWlBklG/0oADLtZ2hhtkgYStgf4ks5SaoHt6YlSsbAlobYUpm1nUgoYn2fcaIID74WxQzh+2h6reJ0fBxJD0joUWRyObCaOap9D6mriVvJBcGKHkWaUPtntG4XWRsg38+2sIva8jj+YNC+EWSZo2TLVOFIzagQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768822; c=relaxed/simple;
	bh=sBAng8Jk5DHwePJa/QbVGijsybAxW3j5i/YlSc5xoUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS7xjLTT+sV63ufkdhRrOGKBVUfBPcSWNGyG02LUHIFU0qijhQaBZpY8DCwTXvcytFssoiP0zHzaqjVXgWGEk+ALbllovOEu0yj030cQNxRQni02uBxo5YvDb4T3ZntH05RZE8bBcA+HKi1L21k+TEnSTfEMB7rowVkn4mvmeoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uq+m0GXf; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOzY4QtSvnnCVfnS8flELnUd01C10gKk8hBLHd8HqHLPLO984vbd36uz7lSYVk9liDqSTBPQ+oKj9vmKJkxYIDtNOtx37wkX41xl82Vb+1q91mJEImjjPmT+pakJ5Oqy0nLX10T+DEbMyK50P9DqFcJdxEs/tQzr5iQPTAg8YpnbEsCyhlD4GmFIWKx97NbIP5LxQyYc/kP1dvhRaRq9E9VrXq8Dar8tRRZtQUUtpFh7llTAYbZ8Px+mu3CcQVnO8pHDDymSOkpW0vILOPFWdoCTV3q1Gu+0OUl+z+QZ5ZrU6yi9DctxNncESSVP1boH1IktZn7IFl2wpJ7mgnYUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxZ233nJyciPbVXeEDxVY3QO+cuJT9fhi0j1dEB5liQ=;
 b=OTonxSZ3qryfxARq6a3UrMlh9lHqCLoA1LFW+/E5Bfm1bW4cmAgZFmY60cCrm6mkbcOiABVziij44eUlsuUnD2yk2C7NJfvRGrMCEzaKv+VcDzev/nI6hCzHR4q7C/HTEh7KHagNwece2So5paM2fu99dcI9JYw8MI8uMsuiF/xvBNt00FOqdELidLZ1ZvGWTMW4FREJjqb4FQe3BV8E600JfL1JDUJn3i//s5qLXmYyAUKxAmchjeGdXSYP74cjEXxjj+RTdJhZ40SEkh/xSl2sglM/tq5dQm1Ydfi+fRtJNyv5Zj+sYj1uDD3KY+qv7f/QkHPjRIqlzvfLCXhIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxZ233nJyciPbVXeEDxVY3QO+cuJT9fhi0j1dEB5liQ=;
 b=Uq+m0GXfcTV0j8vZXdZq0y1xwOrA+KGrS++WTDEIYCEbb7V7R9H0MN0Nl/NIjoX8oockoUdQC+FEIUNU2TvlmD3wEFQL+h4mUdaQkrox5X6HE4IJveqUPEIf4Qem/mndrKa8RFeBARx8s+0KNIKUJqFWjA+yN6C9Rl6rwmSC+Rw=
Received: from DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) by
 SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 15:20:14 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::7) by DM5PR07CA0102.outlook.office365.com
 (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Wed,
 5 Feb 2025 15:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:13 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:12 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 11/26] sfc: initialize dpa resources
Date: Wed, 5 Feb 2025 15:19:35 +0000
Message-ID: <20250205151950.25268-12-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5b5b91-c0c9-4e94-c016-08dd45f8970e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4FRib6uwn9m4kFRWd0PMF0GQnOG5pkmO/JxO6dyQ80vZGBa2Gk2IpsRr56DD?=
 =?us-ascii?Q?6cnY3WGTNp2GSkZSynNOSr9Rqaa6mkWU2/tlsuXgs7ruCl+t+oGQ7PCig7v8?=
 =?us-ascii?Q?rJoKha0l/6kAysRONNA5K3sMaswcfK9j65wqQQI/aX0MbqgmC2r4JnFjze1S?=
 =?us-ascii?Q?vZlHekf6nn97R+L4lWaeH+H7foqdV8CCZh1vehkmZGCW9k/s1u62C7LDZAzI?=
 =?us-ascii?Q?Y+VA7lcpAMfKYJ0d1ewIhpPmH/3Cr3QJfSXLkxpyi4xAC29k4GXcRaBjYPgq?=
 =?us-ascii?Q?3Vck9NqqHnbVRaksqLbzXp5zBvD3io3XZkPX7+SC2IZ7JYPK/2VdIfHbp3B7?=
 =?us-ascii?Q?tk3oGJBnhKt/mUE2zW7c6TYA8Iq6b+LnLsgdjb78pisGREAEZs5C9C66iGcB?=
 =?us-ascii?Q?zPPkSehzNlM8tSSLBszHjwZ+cpFytjzVdYByYKbEJvmvNG73a7Lk9Iz0FZBF?=
 =?us-ascii?Q?Wp0VVIEuSF5j+juKjtJCretWUnd3/y2MQ9PkwneOKUKZ49np2ATl1h1CvsEA?=
 =?us-ascii?Q?c9lqQLImndy9oPSzTvlLFvC+iQALgkdgOp2kq+BJ3xVvWvfK/8VhaUOk6HRq?=
 =?us-ascii?Q?Zsat1g3D9pTUGq7fJ/a46w8UqOAluKP3J1vrXnWH+nGS+zwCwU/BSyRPieFX?=
 =?us-ascii?Q?PVlOFQTERkgAQuSUbwrzj5YhSShVRHk7kP7RB2tLymbveOEy/ItIgIPeKI/B?=
 =?us-ascii?Q?1Ntk8GJtzdsvFJIPmirJhT8Lzmcht7ED3BPNPDxTCt7pWkF6IZe/w2C5yGq5?=
 =?us-ascii?Q?S2pSYE9ZOYLi730bLqx4B/mTtALad7GA+umGBn69OSHRE9Ga/dI/ncfkMqVv?=
 =?us-ascii?Q?JqLQ3lIMozEUlTtWbU2yjy+SSuQFh33jv4o4UZV4SWCofkBzUguDApX67ZUf?=
 =?us-ascii?Q?GQGCIOhe1jBp31vwiFWPnumuiSGhqV5awiHv5wS29bWU0l5AH1vLfHhGG2rF?=
 =?us-ascii?Q?kATT64A7VHsDZtgax35+SiZFvleT80w8nbZa0EecnC0bZ9a2hG9bzo2dFU9x?=
 =?us-ascii?Q?TCxjlihe9acQ434+e0Vhx/Av0cWA6I4sCAtE99jO3ERdpMWOGXatrvtjFvhO?=
 =?us-ascii?Q?B1aW+y6AHiTqFgfmhUvnvS0lFCnUVIJKKn1C8vIqOobSWcDlc7qJZ3C3HjVL?=
 =?us-ascii?Q?4wz0GN4iW55z1icHRCZZL1wrQUA5Jela+H5AueweCSrW6dsSw6TeKsZZQuxO?=
 =?us-ascii?Q?NtECIwRdx/1ZwVGmxfQYMISIwBkRtdB1wtd7SNi3k9W7aAVFVHqSWPDf+oZj?=
 =?us-ascii?Q?aBJNnqWp/WyUEOtjawFA3hnQcnCqaja4R3bbO6RkXQ+G1+tVNT+23gDV24bU?=
 =?us-ascii?Q?34iYps3pgT6MVs+XCOZWCTwJnGzg0Io1BBPS/VBDdtjfq/J8r0gm+I0I7JHo?=
 =?us-ascii?Q?HfIDrxLpVwCu/wS6IJndCORcP2rqbG8ajDzoCHBSPnTsGF9FvnJeLzUCAiMW?=
 =?us-ascii?Q?3+BGtpG2bnY4w6hOSaAxoSqF6VgRtAkzwYQLcB5fdH43Ioy8KK+327kmcLai?=
 =?us-ascii?Q?rO4pioIk81Gddhw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:14.3916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5b5b91-c0c9-4e94-c016-08dd45f8970e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675

From: Alejandro Lucero <alucerop@amd.com>

Use cxl dpa setup functions for defining and initializing dpa.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index b44c29efa176..d7279f9ca8fc 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -20,10 +20,12 @@
 
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
+	struct cxl_dpa_info sfc_dpa_info = { 0 };
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	struct mds_info sfc_mds_info;
 	struct efx_cxl *cxl;
 
 	u16 dvsec;
@@ -78,6 +80,20 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl_set_media_ready(cxl->cxlmds);
 
+	sfc_mds_info.total_bytes = EFX_CTPIO_BUFFER_SIZE;
+	sfc_mds_info.volatile_only_bytes = EFX_CTPIO_BUFFER_SIZE;
+	sfc_mds_info.persistent_only_bytes = 0;
+
+	cxl_dev_state_setup(cxl->cxlmds, &sfc_mds_info);
+
+	rc = cxl_mem_dpa_fetch(cxl->cxlmds, &sfc_dpa_info);
+	if (rc)
+		goto err_regs;
+
+	rc = cxl_dpa_setup(cxl->cxlmds, &sfc_dpa_info);
+	if (rc)
+		goto err_regs;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


