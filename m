Return-Path: <netdev+bounces-78174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EA8743EC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9614A1F21A99
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00D1F932;
	Wed,  6 Mar 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="brrVmmCI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DC1D554
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767827; cv=fail; b=ax1RA7v0F/7S8hXoLnF95Eeal54h0CKjPnDBh78pbTBFa10FT0zX3NpqXDdiTfGebyw2hEBSdCklw84y5FbHFhtMwVHGvIvOfzTWCsT0v+jUZEFLHQEYNEvpYIobz9U+lib1QPkHSn4JzXEI8Xb1V1SoFA0Qt+WSNrwa+1ZGxSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767827; c=relaxed/simple;
	bh=n4vS5OWs47o2mmz6IAKZ8K8lyZ0kIuyIXpASiW4Q4kU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRXjhgJtYEMQu2gFaxcq+5xrsDhfDalHoQUVx2b2qrFudHkGaPqv5CdSckB+1z3s04jKBOZgjSLiSKHbp1+6kJA82JzLi/bI7wYa1c3p6TzueMY2RgMMenyWP+QzWVoLmc+f2taa7U7EpsikzscX5JBBrs7eguQwmtCR6mL1xUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=brrVmmCI; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxL7nI/VTzsa0tiG3SRD0eMD2U2pQ2QUxIl9ew4k75uTv2guupwEekDFOxFYDGVXHLVpXqJD6BYX8sgOGDwUJTCvm915dYr8g7NwXNh6fZJbrxs+fjDh0YyPb++yUdDdhbfwDheNG1psyRWIhn3MTJHi1qI7Mj1uqkRWuGJEkpZ5bDbzWx1kH4X4GHQbyE6e7oFS7KWEbodNCl/ygP6q30EaeejHcQg3hvDDmQUdVcwnAqwrZ+celPxHoY1ZUn4sL/HOMuiUnLSztrXN9o619frqCUZQ9xsjeCTKQHM/ev2pgaZ5lZ629kRIxMQ+HSBKTXPWCCYgbXIKKGOTLAD/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLHzhY8vyoTIesg7JdhMUOPGnnh2YozOPLx3V+KMLPU=;
 b=K+tPWaqof38xsvw/5s0+etE23Te2eZDJVj1YZn9FKhbndRC1H9tawBOZaI0QZGZSHyvVxcJPYoNNx6FKFp9sMDHZiGtNl0H9p+NvMvQUkoKQUJzhTsxl+6Yl5IOrddb1WpF9mdhjwo/bUiDV4ODuZ0aGQuq9MXombzy2kHGWRwOk5z/t96kmDhk/DBOdOAOHUNMbMSij4kjMiTh5rp3yrCNAduYClvJXcpyBPiRL1ERtqc+i3WLFDbVrx0loWlNCoiNu+9F4KlubUGboQ4HVAvKugB/OTiXi9GU4qrKjSHd7AqVI8ibPkMTNIuYSkg7ViWKMTVvXWsXs0QHAPzKNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLHzhY8vyoTIesg7JdhMUOPGnnh2YozOPLx3V+KMLPU=;
 b=brrVmmCIJpJ/bOIoVNvTaWKlyhmJyz2xTMpoPm1jzLP8EeVHSmbNvDCYKfe4rpH9Yvxu2DBW04HuA73ejyvqfdvvQ1y0Wj0/W8Xs73uoE/By17P4fDTaGwNMu6S2LdXD3JjdHRYDzqYNYCHRwyLEydB97XX9q5NW3m4kPJCuJRM=
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:23 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::64) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:21 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 07/14] ionic: fold adminq clean into service routine
Date: Wed, 6 Mar 2024 15:29:52 -0800
Message-ID: <20240306232959.17316-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4898dd-5ca4-45ec-8255-08dc3e356518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pqKAecY3BDAsfTBE+T7YrcXiquY399o+rdrCbUZPp2cRPAZ0a5e2RKnNrS4Cp059nskzNw5m49AvNQdF+uteGI50QjCKbsX7lQk/VM4uTXnEl7VRJq4xCfsxYxRZb8SwpVsmqrr/8Cf0vgebTt8dPVkEBtGYVyUFj4bEtJPolbuwaYMNpIUW1cDOmEejQBUGOxlEweAFrEw734m+vPG5grF60ycmZplXE/TQqoAxg7ShcMoRNsBLD1v6TRTfM/NbwQ0EEQ/9rM8mY8bLqtd+H1pFt24Npe4PaIFN3/oubIVpaeSb9ho3qDSAYd/gYVdAFa4f9Y7rZkuleJ5wVMW1exEK6MCu7XNCUnSbkA61Ep3jc5FC/fvUJNPo3E2GL+/1b6nxaCSv+O64XEi5KRDLZKUoz3vQUDjYERbOBe3F1LGHrfJLqpxyhDfmEG55B78qzrf+tc3UsflAgCsgnHt3ZWyLClRFn693Eoxlk4QVg4cVpvXDrA7WVxywbBiymBcZdbLTmF84GmOWpsQXxjCkna9pfpdCWVYn9XXxzbBqk+ARIb0jHSOnDiA6cMXlzNF3Ut+1DOijRvLScPHzVSsWYBBFn1IvaIDlMwX1pEX08fl4jvare54WkIpa7h/VaOGxIjsQqY+loRs9+eeiE4YsH8Q8Etx1h+otyGL4HZHOFZ/rN99IOYD80/9bvgJ4pNghgvUenYbi1O0A+GW5wltUO1uH5nAKp4YtyL/kfhylCz0MdzA4+hGW723oe6WOeRB7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:22.9436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4898dd-5ca4-45ec-8255-08dc3e356518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

Since the AdminQ clean is a simple action called from only
one place, fold it back into the service routine.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_main.c  | 32 +++++++------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index d248f725ef44..c1259324b0be 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -247,24 +247,6 @@ static int ionic_adminq_check_err(struct ionic_lif *lif,
 	return err;
 }
 
-static void ionic_adminq_clean(struct ionic_queue *q,
-			       struct ionic_admin_desc_info *desc_info,
-			       struct ionic_admin_comp *comp)
-{
-	struct ionic_admin_ctx *ctx = desc_info->ctx;
-
-	if (!ctx)
-		return;
-
-	memcpy(&ctx->comp, comp, sizeof(*comp));
-
-	dev_dbg(q->dev, "comp admin queue command:\n");
-	dynamic_hex_dump("comp ", DUMP_PREFIX_OFFSET, 16, 1,
-			 &ctx->comp, sizeof(ctx->comp), true);
-
-	complete_all(&ctx->work);
-}
-
 bool ionic_notifyq_service(struct ionic_cq *cq)
 {
 	struct ionic_deferred_work *work;
@@ -338,9 +320,17 @@ bool ionic_adminq_service(struct ionic_cq *cq)
 		desc_info = &q->admin_info[q->tail_idx];
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		if (likely(desc_info->ctx))
-			ionic_adminq_clean(q, desc_info, comp);
-		desc_info->ctx = NULL;
+		if (likely(desc_info->ctx)) {
+			struct ionic_admin_ctx *ctx = desc_info->ctx;
+
+			memcpy(&ctx->comp, comp, sizeof(*comp));
+
+			dev_dbg(q->dev, "comp admin queue command:\n");
+			dynamic_hex_dump("comp ", DUMP_PREFIX_OFFSET, 16, 1,
+					 &ctx->comp, sizeof(ctx->comp), true);
+			complete_all(&ctx->work);
+			desc_info->ctx = NULL;
+		}
 	} while (index != le16_to_cpu(comp->comp_index));
 
 	return true;
-- 
2.17.1


