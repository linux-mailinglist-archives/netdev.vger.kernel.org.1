Return-Path: <netdev+bounces-178315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9FA768EB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C43188CF9F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0E221D3FB;
	Mon, 31 Mar 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zr87pcTm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2229.outbound.protection.outlook.com [52.100.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF021D3D2;
	Mon, 31 Mar 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.157.229
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432384; cv=fail; b=R+/jvLelmJFwNeSkjrZ5PuoMUXz2tDycoJqJ8uwu0SBLjZyNWUnmNgPf44IDvZ9+uHEzogJq1r7QZA6+VOGA6GwxT8LfgKEy0z4LxuKMz5Dz+2ZzmjAGJNWRe99U1mMS6jzmk25twSvToVsKE5KAZfFxcIuO4H3LZI4oyrdjVz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432384; c=relaxed/simple;
	bh=XNMCR6DQPZ8hxTfrRDXzzanzGDrjfBSTOnDQRnhd4hM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0p6EYLCDIdvHZggjO75rbERryy+PheDyu0hGo1HTnbTuf2O1FQ7KYB0VXRPyblkRdnzR5syB49fgKyvSLPLSZ18AAsei++fY4XEyXPfX1k8FITBecYNfSLotwvJeGuIeRI9JT3jU5gFWSqahIpSBZl1Dn0Lv7LElTqzeSmmvqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zr87pcTm; arc=fail smtp.client-ip=52.100.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyXGcVfQ7BONhqSdgULf4EJFLE75tVO4UwpDJzMS3N3NfAAQSiZJ/Vv7t94D4kST07ushqACxXnbGms7zkA8K8dKnjFTtJURPABnYjCLMoK8SjPekGgEmgbZCX1u5IQPGFlqWUl/eI7KcKBcFv7nWm99WadRMkVR29EmYygD2vAE038Y7oEi/uRtN/Kd20sxdYZPHi4P94v7awE7j+XQo8E9CFbVpWpOfXOaNP4BGy5MlNhv1Lj95o1PEyHnslOA8bgLpZb54oEiNF2fX2Fe7fordCBtnDB6KYxoRPnm3sDlm5jAMSYXjQy+mHn6Sraq7OKUp3+2dreS6vQbWF9W0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsApbEVtJBDNSvf+pD+J1xfV+ZbcZEDYMJDMzEXLRaM=;
 b=ftfA+5KNe/kuwgts2AxWpKq8efasz9x64Cc5yV7oaGn9Y+dpltPnOB4KTdjIwPfWj4MeAuAhX9eX+cOBu9yVB7pEwGJ6x5fxvdMRPoAoVOObXA3Qj88JNHD35Bqpc6NnITuKkDxokIdW99WhutFzlTO6kmbaZWyoQvkJ3SDsM8ZXI3gHFBgNSiDJof5NsLX/z57A2g2tcw4vz79EssTJQ0Xa0zL0Sz/zKuJu4mfW8aGjEbDqMcIXVkMw0EmZGh2bdJIz2oX3IWRwc3hMJDmzKM/uBFVvQB1xzjxN5YLrhp7WxV6ZLElOp7tWTUW96w6RKOTFXsTHl1zsUZ8YtKmMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsApbEVtJBDNSvf+pD+J1xfV+ZbcZEDYMJDMzEXLRaM=;
 b=zr87pcTmaoNaphV1PZ2XHZhLmU1xbrnnGa1N2BJXmQ5mG9SDdjFEgBuy5bAAeC+r+FY2ibQPhWk+KEJrJCuvdacuzxbPFqgkSzsmzWo6RAaGCrbuDuZ13TUw8iT5SKIUDPO32EDRVbgBHbRNZ4ppTV5HW0zWGVSIhhT5V8yMBOY=
Received: from CH2PR12CA0018.namprd12.prod.outlook.com (2603:10b6:610:57::28)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:19 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::ba) by CH2PR12CA0018.outlook.office365.com
 (2603:10b6:610:57::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 31 Mar 2025 14:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:19 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:17 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 06/23] sfc: make regs setup with checking and set media ready
Date: Mon, 31 Mar 2025 15:45:38 +0100
Message-ID: <20250331144555.1947819-7-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2c5546-b023-400b-29da-08dd7062cc95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|34020700016|36860700013|376014|82310400026|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nl/ez29ObjPtkHqymoZe6YxFDDM+KPJfcaUf3NMuMpEVqtDqDYPh64EQzNbB?=
 =?us-ascii?Q?5Uh5/H158F3ZbsDE7frMaJ9H3fgJAsIgUw0AOpf/k8hSZ9Pz9cRKFR1NSg/n?=
 =?us-ascii?Q?uzlq1K/BKMJcCIaVaFmB8W/ioE7qaeXbX9bWI76XFtUbh5UberkuU8NU8URp?=
 =?us-ascii?Q?/PX8QhoyBDdsP04C4sWjvcjNDNMclTX4tDKqEpx96kR28vsQwGYynkNwvMH2?=
 =?us-ascii?Q?rW4/tPCSYQAA8BsTPo/a/cA/xDCL0Q1bBcmUHlY8vbqgzPCUuAZscsEEvGyA?=
 =?us-ascii?Q?Fcb6O9hFeO7GNrQltTaIBuFtNJyjDF6M2DXIn4Sry+vj7vyhRb8rsDL/ibTZ?=
 =?us-ascii?Q?TggBOxL9HQ/bsNqYoyNnyrD9o1Wo1xKjiToNmgAMSlgvRg90lNfOHOPN/1I0?=
 =?us-ascii?Q?QX2/FPXF0pPLkfthaYEC6ony0v35vtv9mtqOFao1uBo7nEvf2Zrhq88nz9a6?=
 =?us-ascii?Q?HtPovc4KkuJAoj6ToNRBdlvNzGM2CzSoIzS5lAnfetriMXYtaN5sHJsQu25Z?=
 =?us-ascii?Q?PrvxxqyZ0TASypfRUXYRVYlJiu5Rc2H/32m6lgRAcKQ0F3riBAnlpa93qx2Z?=
 =?us-ascii?Q?J4L8OQOgw4jNQARMAqQ1jOylE5kKVzxrH/QOxHwYmRoPn+OmQmXnyX3jCITR?=
 =?us-ascii?Q?Ao0r3aqC2q0F+4TDVYsNAFmtGxK9PGMxzcmitSo4lysQAyRLwm4p6Pu6PVAg?=
 =?us-ascii?Q?OSKME1vHmHSXBEcSoLrwtZdyKWQOEgUfbIHF97R6ogcD4JGnFEVeZ1nOwplD?=
 =?us-ascii?Q?R58tuUUm5IAVSKegXcrcUVGLVzlUtQCmUDE+4FCIp5kLugyEiNbBSM+8I1F4?=
 =?us-ascii?Q?32BTx3v10fsumTtLX/9gKRiz6kzDyjHrUMXUF4gHE/+PeWGSGJvAUPHqwQ8p?=
 =?us-ascii?Q?yDtAdxgR3aQokQlWHGV5Bxa6O95PQS0F6iXpvbpYlzNqkTrF1xVK5t9zkPYw?=
 =?us-ascii?Q?AvGSdra/xZLlODp7ChTeVCmTGifXnWCk5oy2EEDOGcK6O9hapdSWsgGYbKt2?=
 =?us-ascii?Q?OM1UgtuCfU45B8b/SFbL9ySzBSsTxhdS8/fmRmQwj7Tz0+CG/+n5LGDKv1PV?=
 =?us-ascii?Q?moZRI7/nRr+MZKg8UiLnZGSOPLVr87N+3jzNHLWmmthTtwrkOD7bZ9ZiaJrb?=
 =?us-ascii?Q?e+c/5/N8jm25pKcvNeOnHnTss/7qOeTYzhmd/6rKhjfALQTVuwPyFR1Paahz?=
 =?us-ascii?Q?4tZCPUHoCaFKLHM9un5ONGSU5P1g1Q36YacOOqCqTdHh3xcjcLDN/toqaUuR?=
 =?us-ascii?Q?RV30M41mPg+vJtFRr7TUZ+Cacc319XSoxx37rYYV2BZp0zHNdqNlHtfGdLs9?=
 =?us-ascii?Q?BQgcJSBgcwo/5Evb7n6Z8PciVaHfITaQVVIzjZa4lFLysdiOnjJLCUGJhDCB?=
 =?us-ascii?Q?65DOAk8ijRM/C/I6pt+MlDmzoM6PzjRHp0ONtMNOMXJ+dRBHrdtktezfxSze?=
 =?us-ascii?Q?WQ6ctl06NerIo7YDzxYmN2qnznLT8ySEESKmTW10D6mBp68bkTwoHItIufOC?=
 =?us-ascii?Q?Mos3MnAFOKsonOY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(34020700016)(36860700013)(376014)(82310400026)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:19.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2c5546-b023-400b-29da-08dd7062cc95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Set media ready explicitly as there is no means for doing so without
a mailbox and without the related cxl register, not mandatory for type2.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 753d5b7d49b6..3b705f34fe1b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -21,8 +21,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -43,6 +46,35 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_RAS, expected);
+
+	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		return rc;
+	}
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
+		pci_err(pci_dev,
+			"CXL device capabilities found(%*pbl) not as expected(%*pbl)",
+			CXL_MAX_CAPS, found, CXL_MAX_CAPS, expected);
+		return -EIO;
+	}
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both no mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


