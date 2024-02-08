Return-Path: <netdev+bounces-70052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD7A84D759
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E138B231EB
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6041172C;
	Thu,  8 Feb 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dh/hZvkG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EB1E535
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353872; cv=fail; b=cPCc7SQ+hapGtF5aBUNpOmKWizAKDmY61KjEm21BEtMwq41Fl/zV0IxPB0Ns/nBUjXb0YF31++C4xF6nQQ1t7sfNdMuZ2aqiILgaAg3tE2F6btAEueP1oldAuFAI9KslKtDMocpfRSo7nqdYh/V2TrqZOwX0O8mECFm+LNzmBOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353872; c=relaxed/simple;
	bh=r9mZdjKxF+ESrjLt7Fo4bL3aM9vW6towQe6iO2M9DIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc9+9f5GrJHn+UmOUazuqseBoHhnRhsoHE9WNKub+KB0Qk6UIlmlvIs1yD+Holctt/2j8VCgFFjei71NchcJgsTAty/HF//8habTS257Fad5uefqKZWWZm0NGKON2vaxWNRQsj4TT71Y4/AlKCcDcLtVnqWBFpyua0wFaLhk3rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dh/hZvkG; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJR06fwGhqsWqTah5rrwKVeGTfsJTYBAR7NOPOBnxB42U+gV47JmfWBuzD/QNBipYrmhdod6ov9j8mnQj4k1Bdn4IIDEziwNFSwgXyWDAQTG2/U5l7zf9CJSsowHl8Kmvv0KGGHPfalLqbPoUTTJcR516Efai+vbF2VY5oP8DdZw2c59c9RdoouhPvELsgeXiH5k4dNWAix1zPQkrv0r0BpcEJmfsrDGFKWhPCnwdnmantxVPPDaoJsikmrvslexjDij/oMhSSVs/CC3jFv/NDjRXtbUldsMHVFCwtAor41b7a+JsWE+Lo1vzGSNh9tr8cKKtZhvuK9jEWJJ3in69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlaePoqD63MkIfC/8xk9mww37KcdFE0/JQKsrH9YqVk=;
 b=jcUoGSwdbw1K4yy9EF+tp63yDaJEEnSKQslZLcTGTnFe3oomxhFYfKh0CI20se06VGyfvoxMGTEfWDAm45ftQGLpj3ThCuMOk2FYrjC2jgNgm7uI91iPc83tCRcLUP/3jUG37uGoFg9Ra5LJU2SLT+MNl/8uJK8bMset6+rHvdtiARKtccE7NK1EGUCG4Aj4O8KzKcOQWBoVE3IpHcfQoh7dHAZyquQeC/Y2YnBR7Nwc3GPuNXCT5BCTaPSUZ+j7Klg96nu6jaqCr7vyUC1yqJaiBrrYdGkoUypZBZO+LRIabbpVsogQm4vZlRSL/akWuyoLnTLYQqO5N43l5GhAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlaePoqD63MkIfC/8xk9mww37KcdFE0/JQKsrH9YqVk=;
 b=dh/hZvkGGLC3r6Ltz2UdJ38P2uAnzK+5HH+PPe7FVMKnVh8IsCqfoz22Mr9X0NtYUl7SeJ88+JMq7F80ZpNWEWwHco6X0TvCzTerPbq3/r5FocgVBDNEyBTUMbiowfBiEd7U8+SOZxD3T6l7dZA8lUXBzG8OaxVN2OrTxQqRzVE=
Received: from DM5PR08CA0029.namprd08.prod.outlook.com (2603:10b6:4:60::18) by
 MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 00:57:48 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::53) by DM5PR08CA0029.outlook.office365.com
 (2603:10b6:4:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:48 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:47 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 02/10] ionic: set adminq irq affinity
Date: Wed, 7 Feb 2024 16:57:17 -0800
Message-ID: <20240208005725.65134-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208005725.65134-1-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: f80fcdb6-26e0-49d6-855e-08dc2840f803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vPHA5g00kTW6+h+VIplnbq6w2UTnT8j40SRNre4mmd+24Yvfc8Nz57ACtNTn181ohcU46V5/Tgsgps2PvzJQTfeH+zso6t7+n+Dtmj3FxosqiXnoKez8YrMn7LnzgZmMSSZBlg6Qx4ACZa6qFSCwN2lqEOVELwuIw8Q4kv3nngyX8uroiiw59nf5n/ZXSBe8LE6PTJfBlOvF6atDa3O5JKq/TTJsAfGiKHkYwi0pltf5Ib6Xt9yzNl0HqOb0TN6/nNiiNMAp5tTaL7D0luFhvcG0zWZffnWHbWEDOTdNkYAz8waeSgjkLXfW2iBislbdS6UBDnRGhO152IBVPWhhEH0k1YPcM6R5lZwl6hVfRh0o3PQcZJMQ78UQrqevS41J3emf+egFhlCIdocPCsWeYShMVtAU7gwaYCfdKPdWFnLgSHP1tbGVz3OzaHDB5W+ecoOHatDqa3YqWAnSp8FbvjVl5B0ifpMmD8HIwTrhKYPLK34IEzXZmZYhkcQ5sZfZHNuvEk26b2j8YW2frQym1GiX+vLW82Gk/QgrDmUipZnRN/4xRuIA2dKz0YA+nkmCHe9db9TuqajpVfMo6s/Ztt8ubtj8nxXZ3c+AKhwV2dk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(8936002)(356005)(81166007)(82740400003)(110136005)(2906002)(41300700001)(70206006)(86362001)(316002)(2616005)(478600001)(8676002)(6666004)(54906003)(16526019)(336012)(4326008)(70586007)(1076003)(83380400001)(44832011)(5660300002)(26005)(4744005)(426003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:48.2984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80fcdb6-26e0-49d6-855e-08dc2840f803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344

We claim to have the AdminQ on our irq0 and thus cpu id 0,
but we need to be sure we set the affinity hint to try to
keep it there.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index cf2d5ad7b68c..d92f8734d153 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3391,9 +3391,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	napi_enable(&qcq->napi);
 
-	if (qcq->flags & IONIC_QCQ_F_INTR)
+	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		irq_set_affinity_hint(qcq->intr.vector,
+				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
+	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
-- 
2.17.1


