Return-Path: <netdev+bounces-195882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DBAD28ED
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4183B316D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447122370F;
	Mon,  9 Jun 2025 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EG3MxoK8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753EBA45;
	Mon,  9 Jun 2025 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505637; cv=fail; b=Ff0jo0kUBxEvWPyqeYPfEHXZtalIOlscg+pdfuIIvAmZz2H5eTQdG4KCmdMJ96Tb51QZCvH66eWyqKc2p8xci9TSiOJgRbxreE4XG/0OoRiRaImOKjv/yGX3D7qRPXI/6JxIQKOgbm4Xc652eectgIqU8uSAy18ilWrH4BfWoPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505637; c=relaxed/simple;
	bh=qu+dm8eHTWz4s2Zt6ev2KDXMSspp8ZucqDCBOo9Y2BQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3XLl9BKtkD7v7HwhZAFUgajU1pIIa4tPYKQ0qBEJfcgGDq5FAY083rP5SD7EFwpiz6Yw29hQ0y2xS+40IVP/fF2h/8xAT5WubYPn2exXQ46Jx30Z7TBVhY748u0HmaoSWGPkudYzDLZCWp0YWMjOI41AJWTFZC5yZNelgGAMwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EG3MxoK8; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHLDGciAxRpYzsVfBlDqVVq0HAmGYzUTfLU82Rc2+DRMaNEgQh7N5khAxhACjfEKNoGnDi1VVcjVefDcfV2+2tUdRqSstwrgcfdODpcGxOM6wo+fY+08PERB4bzkD7QuFuektgSS3X/9IxpwezOUpnOPUwThZ2lvHnAOXrqLCThBWXWvWRhCjB+lWjehR4DAheiiITYUey58HpJW0dJtOAkRs3rhJbMpjYaDHgE/zRK3sWs9UgXRvQ3ksSFR0xxazWMgx2ZCbTmGQKi9icC0hp0nA0hU9RPinE1MWKx0YiFMqUEH0WAzaP2TsFb2H0No2Dx5lLJKgH85fH5IjtV8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6qTRn5EqK20qh6JRTcBEB1DPIaLWPEOJ4EPeapqfnI=;
 b=OUWMD6ZCjSHxatsVq/D/36TVlg65uszBuA4Idal4XXYi025cMeeZs91RdPBNJ4kcLvXX4zSNvz6Tx6Ji010J9PbpB6tqQWACctRWQk7pSei+iPg9XcadZMO5Ae4lvm0MREyAwKX3stLlTDP/bLa6YbF5TCcq1MccQwd/xfdPEiehz5t6jrUXbw8JbAUwP9n7rS8VsepfEeWscG1eIOAEvsAjnQpvFElEEmi4/N4pwBMeWF6m9PmvxLNIoWcQjeutwEufeHdVWWTRsYnLGytSp0IYCyUgDmweOMNd4NkwGaE0kM9V5nCd2AA9Ax5ikBCEV2vw1Om0rG6QGjVhHvXcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6qTRn5EqK20qh6JRTcBEB1DPIaLWPEOJ4EPeapqfnI=;
 b=EG3MxoK8zx67mIbVJejBPWSbTCgKlqiTrrxKH/2zmxtdNfNwBGaUourwI38DAIWvwyUATiVGWNkLMc6Eom2AyXb4lruGvkZkwUM85Hc4graIDLklY3yMxHNF4WO8YqEcZVsXKOfHW6ilPbXSM6nnKm9PX9tG5qss9KG8IKG1xcM=
Received: from BL0PR02CA0109.namprd02.prod.outlook.com (2603:10b6:208:35::14)
 by DS5PPFDBFC954F7.namprd12.prod.outlook.com (2603:10b6:f:fc00::664) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 9 Jun
 2025 21:47:12 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:35:cafe::ae) by BL0PR02CA0109.outlook.office365.com
 (2603:10b6:208:35::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 21:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Mon, 9 Jun 2025 21:47:12 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 16:47:11 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 2/3] ionic: clean dbpage in de-init
Date: Mon, 9 Jun 2025 14:46:43 -0700
Message-ID: <20250609214644.64851-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609214644.64851-1-shannon.nelson@amd.com>
References: <20250609214644.64851-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS5PPFDBFC954F7:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a5b059-6bb8-4b26-3776-08dda79f3138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IxLh1Y6U8cmGXLpvTq74g2Cijei/AtyWf0/YHN3Ezb+6SC+SNYFDRpvQ4yib?=
 =?us-ascii?Q?dCBrbojS9Wv74NUTpV1HGbUx1WSrFkJmjY82Ud9de/yEGK0nB8sC/ih4FGO1?=
 =?us-ascii?Q?TaF1BbffrSFBvY2SGQ5dIZf+acSAJbAxj0hligsanzINwY+uaNqmxwrnRw6T?=
 =?us-ascii?Q?H5S5xhxHJPqqP//TP8cIyOAlBka0gPCemVrp9Uj9GWuS9vRI8+RaksCwcx1Y?=
 =?us-ascii?Q?gUgjYWcvx0ryMfCLBTc3WtNgIPRRqg6MyYNqKlMfW11JRm7gyljMH9/lpmCL?=
 =?us-ascii?Q?fEXS4KOES9H4J0zWLRQWUdNphpVSisgZ2gOJiS45clJdcl7JmzdLkrGjkBJu?=
 =?us-ascii?Q?3+z1dTxshmFvGfR+Axr0o8017lg4YuwhmtYWJuDyIDFze7zbizw8JwVpFEPD?=
 =?us-ascii?Q?aoUrnkvQaxbbkx7VF8eoVtfTyrsUjwiEl7k0GynG3BIMYzQD5VvZEK7jKgIc?=
 =?us-ascii?Q?0PAarPX31iKo9zA4VU1QMfVGaEE4lKZcYOlP2lkWazJGImGnGjAl+IOfoQnp?=
 =?us-ascii?Q?VYJ1NhA60LLV6oVwAV4B4K9VUacE5jveAFxW1ZaAgRURAkBTKxX8DeCd+5m6?=
 =?us-ascii?Q?8C0GLEHH0W+RHZPuXpCTXo7qIDVwlYcSxe9NBgsFaSc2TMQOl/OPZ4xdAV/s?=
 =?us-ascii?Q?qjbtGqupg2EZ0V2dJTUeF7uggAFwaqgFCtCbjtj6xAMdiI0ED0etRJ2X4KwK?=
 =?us-ascii?Q?iM2im1IkzY7U3ul7+DcLxr2BxAnw7qvxkWVCWsJV3f6lUpDbh+OanguEWV+K?=
 =?us-ascii?Q?HNIDDlK01BjBLNpVNsnF6sI17Eyj2Oltxpl7obChIImb9EB5I4Mqn/qMnC26?=
 =?us-ascii?Q?HYFvdb7YQvumxrGow04U92m5iy8RHFc+O74gAfvf4lgwyU0zrzSjnA0slAJI?=
 =?us-ascii?Q?bkjAMTYtLlcA/8b8yZhad/4dkGEB4ibTv8vqVRYEfE34bLaj/AO3Z7EurLi5?=
 =?us-ascii?Q?OlzEJmlTQjebQR+ek6XRXFf5Tn5W+hFCdZgoAu6YiXW5lXtLertLMZpk7nzd?=
 =?us-ascii?Q?VJdWonq670Sdf+LzSe+SGieafB/X/iauYSh7akPlACSkBcvE8KlJM+3paoig?=
 =?us-ascii?Q?s+g0HSh1UI69lDLzMTE/CJPBsx24ebOMc8+yvS9hHZSqjicM7REOOaw/OWCU?=
 =?us-ascii?Q?arpSetXoVZB0e8TGwQ59BPU5Fjv1+isl0VowfP68IxX2W5MyQYQ1LTcD0cea?=
 =?us-ascii?Q?w6DGa/u1dCe51p8zOmZ1PsAzzYclPL/TrJPHwAui6hmzxGsmlYfwKTTF+jER?=
 =?us-ascii?Q?WQClyW0xmkEeSdCXjQaV7qWhNRp8ytCebOxqwWJukz2xyVAcyNBIm2dHhVy/?=
 =?us-ascii?Q?MTle48yk9UVsn7TBxlgmVPLImVaKO0nRmmQ0PP6io4HjI354wkvMrUW/kqR8?=
 =?us-ascii?Q?S+oummgzyJ+0qrkneiHtYv7tebYytnqKlXgDrtBwHLx9m7Z6+fykjyOYlImR?=
 =?us-ascii?Q?vLQB/ZQHprL2YEn1BmwK7wI91xpMXXTxmxFvTQURxTu9JjeEpCFUIxoYS54X?=
 =?us-ascii?Q?JUoq91CvGrH4mIstNK16+JS6rQKJuz9ZXmgg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 21:47:12.3428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a5b059-6bb8-4b26-3776-08dda79f3138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDBFC954F7

Since the kern_dbpage gets set up in ionic_lif_init() and that
function's error path will clean it if needed, the kern_dbpage
on teardown should be cleaned in ionic_lif_deinit(), not in
ionic_lif_free().  As it is currently we get a double call
to iounmap() on kern_dbpage if the PCI ionic fails setting up
the lif.  One example of this is when firmware isn't responding
to AdminQ requests and ionic's first AdminQ call fails to
setup the NotifyQ.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7707a9e53c43..48cb5d30b5f6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3526,10 +3526,6 @@ void ionic_lif_free(struct ionic_lif *lif)
 	lif->info = NULL;
 	lif->info_pa = 0;
 
-	/* unmap doorbell page */
-	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
-	lif->kern_dbpage = NULL;
-
 	mutex_destroy(&lif->config_lock);
 	mutex_destroy(&lif->queue_lock);
 
@@ -3555,6 +3551,9 @@ void ionic_lif_deinit(struct ionic_lif *lif)
 	ionic_lif_qcq_deinit(lif, lif->notifyqcq);
 	ionic_lif_qcq_deinit(lif, lif->adminqcq);
 
+	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
+	lif->kern_dbpage = NULL;
+
 	ionic_lif_reset(lif);
 }
 
-- 
2.17.1


