Return-Path: <netdev+bounces-71720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4484D854D4C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1A51F231DF
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F155D900;
	Wed, 14 Feb 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1+rDkMPF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964325D49E
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925766; cv=fail; b=L3uh9EgulRK4WzGrd0WkVOXxvw2osgMEo+DehUiyAzxbPpHK/1zVKFiSG5WG4HRsmLS+y5LwkyflNpodAYE2Bzx73Y8RHgbCK+LaTMYPUXZQVKigF7n5Dxyrk/UM4Cvj6P68YglgMPc15QyqFwPwKhkgqSGqg8fpeOodOQOZEtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925766; c=relaxed/simple;
	bh=yG5SdOA3BqPvGFo7HdOAEsN0ErRZQLtsZUi1etYCHKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIe0afDB2WOgjACQsQzCfDdm9W3kAg/ggAIEI/fN1D5hpwKwUyQAGfMo7H7HbMczCrVPnhedrnZhn3y7E/uvOE4cglzbZBzl/vuIZGlGhBuFn4KdHNVTq/meQIelvkMJDFljUKjdFC+i7s5zdPkpSgTqRllBTXCW/MpLugqRZVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1+rDkMPF; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f65t3BTgJm1+xmiKf+W6Ig8FmQjd+Ygk7KM+e/1Ybxe7oYJWT4OTH2IguPZKKd98CwaiOMZv50GapKLF7iIHlWpEEkD95a6KZaPSuqOfE+U5KQqnPuE6DmGJXk/ZfuZKI/thPk+wl0LAGsADo/4cB3xd6A1e9m1hLaLW571bGoKFOKws6RQw+n99Zbx/Iw3/6K6iyoWsGsM0pZ4wW6upTDIP3z8OhIbB5n7v08ILYjV36UNIjEO0rdZEfKyZOX59FM3syWPSUXFd+l4rWH9SyWT6Dys8CH4fJedTSaPNpDV6WKnArxTeVNwFQgrk4uwuSarW1MeV7tl8fA37ie7Imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86eolWj/Rzm6zZ6j4iVS7wk9Hws0j7qmaD2fXKxLtmk=;
 b=V2POTPUJO17caAywxIwBGY2oub9doX8gkmwvN5r20+6ivKYBee0dO4ha20E6HN5cgSXOrAgFL3Pdt+tUz6nPVKfrZyuDq07LcLIQOHadmC3em1XvESMQxw9YriqkKwTvhZOEpF+1vXvokyO2S8jK/lpqcmmC8DK20Ye8TVFS6nxRpmfKJ+q9BABG5toojUyyl7hns+BEVVQRv3FL250VAvyHRGY88N/bPklRvxKCJnCX39dwMgy6iFApVZZTF0x6X/uSHv/z6UwhKOV/EhC3R0FgASuQblzHl6V3Ol96VW/6Lij8zPffwT1gd48wOQNmqwNMVbv0T2wVMHOvqax9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86eolWj/Rzm6zZ6j4iVS7wk9Hws0j7qmaD2fXKxLtmk=;
 b=1+rDkMPFol+rxiSALSxQ9NdVa1COHF5gidMmV9vcvVJLwZPD8D+oqw8r/DndRe+aszQPtqiYrNrZmQhAeIyN+4rSA3JiAvWns4fIfylDRn2s9jRHupSQ5rsBLzIL6WREfxsZ58U1vY0zZRIMUf35gdDllThZ9osiqxvtsc15dJo=
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 15:49:20 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::72) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 15:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 15:49:20 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 09:49:18 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v5 net-next 1/5] amd-xgbe: reorganize the code of XPCS access
Date: Wed, 14 Feb 2024 21:18:38 +0530
Message-ID: <20240214154842.3577628-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 9400e254-0b40-46d9-52a0-08dc2d748272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JAx11I7fSUsKJ/LZbckM36gyssT5JzUVJUhxdbTRlgE1CF0SytFlQ8fZrMVUznQ28KOrqx2fhuZjKgPSburToKCgtuf4wiB3tvZ7G9k45bsYXdGLGIjCHODGDQmpxUd2G0jCeY/rsiODgGxoXE+ShtVaW1dK2ry5tUxPrgudXf0l1nMhGYBl1VIVW1jMu3bCmmTHErV8sQV22V0EPQVbGFd4j4dD9+lDqavCXk5OtSGe49K6zcN6OPPUx5MHmGJCFDfmZzdgkLmMBAKlHPglwpmd5ALw4MwHKf4oJ9x65NXR903Gdvjza86P7QGyXrblagVTYEc1zfCzu4SHDHpblC7ztMv4mgpyZVG3y4vwl0H/AEiDM1nYL1uknrvegCZPgsgpC2pNpIaI0P43KOuL/bnqMtuPP95mN1CmlLup0uJgsfOjcWi+4WxFnrwkV+yny0pbnGRfzdBifqzNErv4OMSqVgRe8Md5QTHX3JXusMUfIXtACjXAMMHQSjzEOoFinagr2kmU1Cso5iJd2R4XJS5OLX32opIDVd/AfVBlf6Kr06rWQ7UCz7D9qFpQfSBDSYey6nC+XSorVHQQWvgVSWZz/WSN28+8Ozcdp4oOWA0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(8936002)(8676002)(4326008)(5660300002)(2906002)(426003)(336012)(2616005)(83380400001)(81166007)(16526019)(26005)(1076003)(36756003)(82740400003)(356005)(70586007)(6916009)(7696005)(86362001)(316002)(6666004)(54906003)(70206006)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:49:20.6973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9400e254-0b40-46d9-52a0-08dc2d748272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

The xgbe_{read/write}_mmd_regs_v* functions have common code which can
be moved to helper functions. Add new helper functions to calculate the
mmd_address for v1/v2 of xpcs access.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 63 ++++++++++--------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f393228d41c7..197da2993471 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1150,18 +1150,17 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
 	return 0;
 }
 
-static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
-				 int mmd_reg)
+static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
 {
-	unsigned long flags;
-	unsigned int mmd_address, index, offset;
-	int mmd_data;
-
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	return (mmd_reg & XGBE_ADDR_C45) ?
+		mmd_reg & ~XGBE_ADDR_C45 :
+		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+}
 
+static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
+				     unsigned int mmd_address,
+				     unsigned int *index, unsigned int *offset)
+{
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
 	 * register sets. This requires accessing of the PCS register in two
@@ -1172,8 +1171,20 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	 * offset 1 bit and reading 16 bits of data.
 	 */
 	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	*index = mmd_address & ~pdata->xpcs_window_mask;
+	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+}
+
+static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned long flags;
+	unsigned int mmd_address, index, offset;
+	int mmd_data;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1189,23 +1200,9 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	unsigned long flags;
 	unsigned int mmd_address, index, offset;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
-	/* The PCS registers are accessed using mmio. The underlying
-	 * management interface uses indirect addressing to access the MMD
-	 * register sets. This requires accessing of the PCS register in two
-	 * phases, an address phase and a data phase.
-	 *
-	 * The mmio interface is based on 16-bit offsets and values. All
-	 * register offsets must therefore be adjusted by left shifting the
-	 * offset 1 bit and writing 16 bits of data.
-	 */
-	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1220,10 +1217,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	int mmd_data;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
@@ -1248,10 +1242,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	unsigned long flags;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
-- 
2.34.1


