Return-Path: <netdev+bounces-145963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3A9D15B6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9EF285A8B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC931C9B65;
	Mon, 18 Nov 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="27XpEAnb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A31C8787;
	Mon, 18 Nov 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948329; cv=fail; b=SlmV0Zq3uqMai8XQFrZtlTvCH2PG5OiaQLpPEhple6lh+2HEPnt5WmciaS01WnaFyyt9vzvczgWBijRrLFKmJmGs3MkmFRwL/enGa3r2qXI5U/rKGFhve7pODwz0Cyiuj9HDDr//37H7lIS0QDCfv4ey+wEsTMC42gSfhPo8tn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948329; c=relaxed/simple;
	bh=4jvtnNPmQRjcvhAqQx06eEXtXtNNaKnb8jPTgrFk1/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PflQtyqot1K7GpL1qmp1FTpaiz7HE4I/N/8X93jz6/aHYWfYjgMyQQzPEySrnOME9C8UOht/wD/UWZZCSITXv74h13Y9KEHInXY9VCUr5c/8sfuvG6578F5WI0PWeYIcTLkhY1OcCTcNSAOWfLRr7ZFzeXaxhlMx3viwv81igog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=27XpEAnb; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/37I9hRii3frSKFskVfcAl8qtWYC6ZRLDQcddPOMn9FE0G2p4eK2rjEtB7nxWMMPER/Ddih7rrgjvtPMlpQ43x9DsQQj4rl5E8MiT7ORqo0rOJOy+uHXe+Doga7B8C8ATqk7FjuyXKMlmX6l5Rc7jcbqMqDk42IRX6l+kElN13YsZfg6hMCdEbPRUcifsFgHUclh3GT3urM+HyDepvXmNZH3J0cEhEUuJVFLM53OyvUQFols3VztMbolPVq8JLTw80DKbs5wKSuqdpS8SF8Vu32GRWG8L5gjRTjt4AXdfshX0rhfjMtgDBAjV+DE5Ea71AqCEw530SeXGj0tzdn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79hlLTJJd1P/6vWj5FZZHjmqyNFCQNg5tCJh8Gxe9Dk=;
 b=LCZDW9LuG8bx4Ny0VfwUaBjDtuphCtuFoywH08nQYQa6Mho3zNM78vHLIGAfRcYzBCs6TcrcJZ4448luY1XlFc2F6bPChFLCnIsiEYeVY6oR2eOUZjgCqic3A97XTWsyeTMYwL+XkND79zYINAkrPVPFRE06ByFHR82T6MnTXsi8lcSkW0TtFYvyDTJrPCXAoHG/NHZwk8CQ/NMoWD5sABSOfyIc48KhxtQOYwc967JsKveIRdg0OvonOgND2ibQqRL0S9+32t024gVQKtfGGqwYbE2Mya4noWnI1KiHG6Q6PJWzBGoHmMsZ39hhdEvI5GD+dSvcYfENTfVu2jLFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79hlLTJJd1P/6vWj5FZZHjmqyNFCQNg5tCJh8Gxe9Dk=;
 b=27XpEAnbpCnLBh0ygoU7VTP2j40SCwvQA1spRIIATgceegXGTPBbew01pE4BwOMVN2Kea19I7jiebI1vKFLr1kUhBSRQNAITWGUC/s3apoK6mxSpnSGQg3Jjsgg/Y9XoqQCNxLWkaPCldz+b51Ll85Uyl3rlQmmL/mjgHqYjRP4=
Received: from BYAPR06CA0046.namprd06.prod.outlook.com (2603:10b6:a03:14b::23)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:24 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::b6) by BYAPR06CA0046.outlook.office365.com
 (2603:10b6:a03:14b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:20 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:19 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 26/27] cxl: add function for obtaining params from a region
Date: Mon, 18 Nov 2024 16:44:33 +0000
Message-ID: <20241118164434.7551-27-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 30500cb4-6d97-452e-d22e-08dd07f0658c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6KCvrCOuEwyiTUCgeB3n/TPjjaaKuUjBjMR6y8xq7mm0mNcd3EW6f45rsSX?=
 =?us-ascii?Q?N5nvy11L4Ef1MX2Ln8CMh79ibGEyBSx+weBV8OM1yWF1emka+wEWezvtUP0j?=
 =?us-ascii?Q?4p1RW8CFWWojDMF0TCwFU0cb8aptqtL4cIK695ql2mF26xHdWgpQRzMUoQms?=
 =?us-ascii?Q?a6aHnhxl8NZG/ruSPxRUT4qToncVMmAuAOv/63UpX0BsbgNeiDvEGyLyIdSN?=
 =?us-ascii?Q?1oQNPSm/7qDwa//2brn2IBA+5JXMtmPxDYzj4EqgSN4UHT9pVQNS8dkZX8FJ?=
 =?us-ascii?Q?UDw7WkTfCB3gt6ebZSsuPnEMpedq3ASfh4kGLMbEPSVhSja9lXuD7XBcXqdN?=
 =?us-ascii?Q?ZsJ7dXmdUX67XrtBWP653fa5P0I583YsAAiqyjCfFW7XxVpd9FJJHxUat9SW?=
 =?us-ascii?Q?jpKCkcNMAJM7SP7qO7m5JGfVezQPQQwV2nd7nT/oiyELzGPiWo00+qeIgXgs?=
 =?us-ascii?Q?ETIXNw1sJaCsZn6ZM+9rK64+c4WHk3uOBDA+B1q9EB+lyXo907H/526gCx6I?=
 =?us-ascii?Q?gbzpu2cWm4Fol63FWXx/RcEuhAACoVj+hV3ztBLm4lOi+yLHhZdpUx5b/vsy?=
 =?us-ascii?Q?g+MdlIUOpM3mBfP0oKqSejItfD1BdSrJBXMMwqbFJ3wEBxOTKrUtAAUDEKKV?=
 =?us-ascii?Q?iVMz2GLo9ZF+uTWq6egThL6061+vw29cfGlgHVOwxjP5rI5Ub1MuK2dB8+mr?=
 =?us-ascii?Q?lQz3EQj8RsZDpPFLoQCesBc9rO+Umvuc0XjpdbzvU02uyVBaXT/zJqkWnJPA?=
 =?us-ascii?Q?vMRr6Kgf/qiyLmzfPbeIhX9HzgcT2Si7ZQcQIMHOlf2hgk8+uNNHL4TEfm0c?=
 =?us-ascii?Q?yBD38eTzkp0Q4nPXy8DsI2w/PqpCwC6TouItsyclAyBdVnjv0/b/JcZcrpAL?=
 =?us-ascii?Q?7h9vGc520KjHMo6zfrmRPyiK4YxpY91WiUzQ72pDZvr9YcSK58NuBk4asAy+?=
 =?us-ascii?Q?zWyezzSOFf/tzzMUmg1aEk6Xu7O3gvTIew3o5mYqleYRLfGsyIkZ09UJgu2C?=
 =?us-ascii?Q?7e6R0UNRIVnLSJhesMnf51TiOsjaIxUKxcM7H0/KTauT+DTTfLeIhSHOpNtZ?=
 =?us-ascii?Q?CazBFmP1FMk2eEsjaUv5KcLsU9iZosFTQFuYzKT2JB4R+9358tt3wlvGU6Kx?=
 =?us-ascii?Q?6/UzoZDLg1ARKOU0Sw2B72wCzrWJQKcUs+diN78W506HiXCG8/nGl48xvk94?=
 =?us-ascii?Q?w6/GmMpuSl8JqDDJVGxq5ffM5CNCuMO8JnvjYfgA23GEc/lt12E3CL1PoNCw?=
 =?us-ascii?Q?UEoLjFzPE3FqDa3soOj/Ct9a3Cmm6GfYNFr7hOI5KsET7PtU1UXTgh8qLGx4?=
 =?us-ascii?Q?oRKSJj3TK+7dr5INCPKnmYHRWqU6/G/Uaq8UpgNsSxBpfhVnPatcVeUHOphL?=
 =?us-ascii?Q?l0OLIE1YkOm+tRGgWTVuNcjwhwyonLrxnpVLOvV29gmgBt+RCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:23.1720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30500cb4-6d97-452e-d22e-08dd07f0658c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for given a opaque cxl region struct returns the params
to be used for mapping such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 16 ++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 include/cxl/cxl.h         |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index eff3ad788077..fa44a60549f7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2663,6 +2663,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end)
+{
+	if (!region)
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	*start = region->params.res->start;
+	*end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ee3385db5663..7b46d313e581 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -913,6 +913,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2a8ebabfc1dd..f14a3f292ad8 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -77,4 +77,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool avoid_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end);
 #endif
-- 
2.17.1


