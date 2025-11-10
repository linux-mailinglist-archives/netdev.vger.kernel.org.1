Return-Path: <netdev+bounces-237240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE77C479B6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9F684F19C5
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE79315772;
	Mon, 10 Nov 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zdNyioBM"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93216314D1B;
	Mon, 10 Nov 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789060; cv=fail; b=Gv9XE8L5mfvnug66kCKlWjTRX1AXbA4zMc68HY013QR5fYSKPL5Py+3yCfLy5WmF06YG5EpijUjo0x4qLodkTV2VELnzACG4TTJU3jML6N+3485ypMZw4siNMGDyLsYFDS41gCoCFJ8gLGzMbelK20jn9KvwYxNk+dPDojK1OmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789060; c=relaxed/simple;
	bh=sDB2g2KJG9u/u4Rl2fX1Ry4Q8D/2IzuNg4m0r76Tdds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHpO9+wMqomPRaDybG3IumxBAhskuUVd0iXzz9wRoCksYNGcaOPdS7QwYcq7AQPwlfJi83cFUZ80gwpKFzFUWvXBdm4HFA3fJ+2aYa2NTqP4ISZLirkS4709efCdfko6k5uZ0Iq24r2vKl2GUelUZ35d6LsebIfYsnmFgkQSKPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zdNyioBM; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcAo+AJ2OHPWq+r8rvRIu2Nvo/pR1QozQ0WFt0FbBm8A82Q1AZ8K3deRg11SEz1QiHTkD5lQmUx3R77kNtdc5nP6VRSVoihTNbxoSI/46YKcyOKUWEO84S/hDLJSRZKpldMB1HSudjPVdrLLzeO5y8r82Pg2DNL/H/JN6EtZFzOtiqORYtEz9Ed01vcGqXT3cDix72fzkKJuBn9AnG3+9VOs26bUBdk1TBJU1aVztr6DUb/be+NA4Lxke01sP5ZRKY+unIkP3FlZuWX1mZsqb69WygaE7E6egKVSRYoYL0A+nxAw6JlHwKHGSn+XI+vURMytkUhGJxNUOX16y/dF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=ZmlDQZHPF6CEtq+Ue0Hg20FnzSInL479VYHqv9suG4NlKuFgq7GL1ob2hN85Vu10fJQ13ZS0Lie2Zz/d2R57WwKFtS1rLz7pygm0fvVVp+7mHxx1BdgLLIhUc+O/z/pRTbzgrnIKBiR8xJJSlf2LHR2OUWa8klBE0vBYSvoCTp2ya0kfYAusVUU+Bb6APAzudgAfbLuILexk2wMgackWbaUejhFPjmdbaodxX8eqUfIBc2kzmeMAu3YCMLzX69pSoZRDmfpbUSwg5flSsEGu03hyhk5915+KMp1ZNm03qiz7Vuvdv71MLqK8robEPOwkGWyLb2gAcWIcbiIKG9n2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=zdNyioBM9PUbK5i96S6Jha3er/atkaBzovc/86tKyOptwvnwfUvkRnewYbdvQRz66DxhK1mD1X/CZjnaSzjYttEjUG+54Vca+xuQkCZQorEhVJYwQIJYZHGz0yoOh+vZDHxikfH8aI3kCPJGMQJ84S0P2pBIZ8uq3TFPy7jP7BY=
Received: from PH8P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::29)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:35 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::cd) by PH8P220CA0023.outlook.office365.com
 (2603:10b6:510:345::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:21 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:21 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:19 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v20 10/22] sfc: create type2 cxl memdev
Date: Mon, 10 Nov 2025 15:36:45 +0000
Message-ID: <20251110153657.2706192-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ccabaf-83d5-4cc1-6422-08de206f1255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUkiYRUG03tfKDXzOWNKtow7TrNafEEcmNoAhzPhPUS1PWU04zjBiibaa9eV?=
 =?us-ascii?Q?RNoKeWWIz19sg+5zb8DPfxw0fgSUwS11pOtB6XDiOGRszV7edNOsOdmzXHnE?=
 =?us-ascii?Q?1CGJIHbuTQtT2Vno/1n7q/JLDhoWGcY+YgaDUhy55SO0Pig9vSWkKaYIIISO?=
 =?us-ascii?Q?+VOuMF0BATovw1o/3rA9EUk6c72k2ImE3CVvecsHGomWBeaN+KQCzi9YuylX?=
 =?us-ascii?Q?oCzu8J5PYql7GWMgjGOAIJoQAnWURQdY0MTFsYdCHc2rx1gfZmasT62e8sCJ?=
 =?us-ascii?Q?H9zqcf1cfYtavcdY036ClcqVkywIQG+0TSbH2b92CloVaWnK+tlJ3F9t9x90?=
 =?us-ascii?Q?4b41K2uRMqyNQoSFWLMGUOzkh5IHltVPTrZ3HQVXNMHzcZbB1y3gsMIZE0Kv?=
 =?us-ascii?Q?D92KASlRpQkLFONFi60NSO71uaodVuLCOt2db0eengiE6m5zOqJcv6ndtVuA?=
 =?us-ascii?Q?4QiOzfkVggpD3t82nwPgDkDpzsTyP7MeiC+7zKeiyV0KA4Ks4QbRKw9nqHRA?=
 =?us-ascii?Q?LFjReEcVqalYo3BK55UAeQhyn44azfgRp43/Mux2Z02J9+0u2bJsuXn73ho/?=
 =?us-ascii?Q?uGZgyGJ2UU8UAXSjrFCDO7XBebo2GW+u2EtBTCYvDJ3ZWmHGjiizguWIKWhU?=
 =?us-ascii?Q?T9lGDCVS6ib3Rh21ngd8Wvl0r2NWsLApiH6Fi8fhw7YsRB2/cCc2tyUzv6ix?=
 =?us-ascii?Q?mpKTpHUIjEJG5KrzArVLAtah5lFUL4T/b3jZXlO4QBXv4y0CNzd6etkK9fSy?=
 =?us-ascii?Q?QWP1LTDXcfUuvO5dFUvGvoT2C0dxMM2ATbe1HQN5y8krP9kSQ+5RQeC+FEyT?=
 =?us-ascii?Q?L6KxW+5wUIOOx18RVazxIUVvIJp8k+6uTQ0Qf6wBNVWiupSUfCS3D8w6ytVs?=
 =?us-ascii?Q?Hj1AiVNfmc4gXIsqutzMkSoogT/bPLd4FQ62esmr7phEdAMnk/ridElZPJ7i?=
 =?us-ascii?Q?2Lis4HvpxwW1wmNBvDSLLOXKBY6KTQNy22xNWqfeA9dxqoK1s8AxaRrj7p0r?=
 =?us-ascii?Q?eOh72O+8mY3ZZWuBs+jx2nSO7oi1O/7NfDt/sc0iVgDHny3eiebGveYOIBoE?=
 =?us-ascii?Q?QWyFQwps0fDbwkNWwF2tL6c/pJHoXclVnkBlUHOrlFReK54ojpgurOMkBEf5?=
 =?us-ascii?Q?VPlMRUCxKGKUnJk1tX7Di7MEJUZdUgj2kjwoPlKpKFM3U0fn9Ad1m9Jhds3w?=
 =?us-ascii?Q?qPyhNQrMitAHQPW03zHmZPk4bPgMmolXf0JbTlWT1+BGPAls7aAMfCAxt24q?=
 =?us-ascii?Q?Cu/oInUOvCGclto9LZk8f4GRtrmyMBhokY64KXC4BgR6ApjuDjMVmR6SeVWx?=
 =?us-ascii?Q?/bUk/Z/eKzrxcvH10oyOoFZ+UsJGouvzjV7wzQVW0bmqdq+quvWFS5JFv3FJ?=
 =?us-ascii?Q?hFA/4FctKzf2CvV/kep2POV69SFxgYptVn1r3K9kbILApc6hVeeClULSoOpe?=
 =?us-ascii?Q?hjOIgbF3DkVZQzQ3m/f5Jk/u0pIAFFQb33/ptODU5T0XPz3AB7BYaP4DObzl?=
 =?us-ascii?Q?i4dSirfBIKVo7WERrEJmJhaAoAVrYtWNvidYLE+ctKoM9D8hMc7gWW1d1QFz?=
 =?us-ascii?Q?o/lmalTrQn4N7EqVlFo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:35.3588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ccabaf-83d5-4cc1-6422-08de206f1255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 0b10a2e6aceb..f6eda93e67e2 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


