Return-Path: <netdev+bounces-66927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5C84184A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DA5B2138A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB16433CE9;
	Tue, 30 Jan 2024 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w0FQt68b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDB364A3
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578267; cv=fail; b=KSfadqKi3VD3yt+muiw+P42fh3pUFZI9BkBX8JXZLDRktyDxreQ5IzrYwwz3dXGOetZmymR/3Vib4DmkqwnFkD7SH3xWaz0bXPpVtxp9C3taGfg+35l3UOhBc4a7j738JqKD5Jw4fecC+VfkBpDFwXAAr0Rf9olns2NxWDQ9YNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578267; c=relaxed/simple;
	bh=sNszYVzy97tZvq6Lf4y5DUNzPnBJqXe4AyLe/nUH2S0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDd11i73NCDN6RUTjs6AId1tffadXy6JU8gLfpUyvlSb1lEWpMfGCzVLaOQUurIGIS+eArGr8RLmKUJEQjlUvep9Zf6F0l4t9AgIrghGw3UH1Lno6hrj22Bcbi2pCWED2KQeYuGXb4joVAVELpJefylGxLUSYk9vbGhyQP0cj8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w0FQt68b; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYcuXzbgnIPbY1qpfBWDXN5hCsu4P+haAgpu28c7gnx/qMefS6XW8B0kfi9kGQ7MtdCFeKgJ2OLIzuAsVpjzPR80fk81l4MI0iCN7HI1M2m+mIzjhAy+cYNkCCjNT9A1q8Sl5l6AQYtl1AcJI+WSwvpmG3Sbs1aTDHFPoSHb8V7RZXXQVClBXqiCe4phSTsC1NY20xVz/oUGt3TqVTNTIp7/UZzD5q08VJk2yeCHEbx61pu4BbPO+mRyATie4FM0s7wAixFKb6mi6lx0aaKVw1eIqD4UxhvegiZgJN6X2xb+JEKK6Ku5jw4vKNkXnLfjRoDVO1RY9QOuSgo0zP423w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iuqd0UJRY/8Pef92ox+L6iZYimdz3aw3Vpdb8kHYg9I=;
 b=Y2MUlnvWVGtpRD6Lwik+anZZdRq0IwpSKnRJPVh7FkgaGMyS3w6sIbojX1jHxY5KO1xcxrN3Eq2ZC+awPkSYyPlIzs5i8VsIkEqXAxNmnGGLtH3dR6yj08JsAu5EJYwMqqPLeT/MyGU5HylprcEiyFlTSADSJGFv+zMCzaLkl7W5/1WvQdQl5uQHUtarDVdr7z6iYXZ0z3sG4/zTFIjVgwx4jQE44Cg5m9kG+3izSJvfrEWowdUItmb5bD5+wjSGFe+S3ABVn9ja+s+bvXAcItOHONTixqJVKZuKzcuUiWjr4RSzRPn4Ag9GZA1IXVTWI3QtxlvmUD9qNukpivydeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iuqd0UJRY/8Pef92ox+L6iZYimdz3aw3Vpdb8kHYg9I=;
 b=w0FQt68bxL3F3MYLJHaxOnRNLMcBM0M13P3c/88/ScYQfq+6+6ynQ87bzLoXQAvI0dAX+SFgkuXsDKfNEe+KZ2CSVBYUyxyDxv26a1kp2N24ygIPwqwCNaH+iFU+yg8FlBk+IhdV09okJyOv64e5LMoZvmqx8vLarMQ2QEIUtxQ=
Received: from BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::33)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:31:02 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9d) by BL1P223CA0028.outlook.office365.com
 (2603:10b6:208:2c4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:01 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 1/9] ionic: set adminq irq affinity
Date: Mon, 29 Jan 2024 17:30:34 -0800
Message-ID: <20240130013042.11586-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130013042.11586-1-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f52653-90f4-4e46-76fe-08dc21331f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ClGYvpO7GaehkLkVAoU4ik10iA3Fx/ZdZan1EuCfxNFDt1yblV0grHQeM+5yB+dxk/i8qaA8n7XIHWniUGslW2/1qMaqHnrbrRxnWsLrRVN3BBJlVtx8/h8YlXzxzRpGwdSuavrvKFWMFa19pkvlE4tF5QwQYmwv+ovzG9vpL5AmrfRN+k7mt3jDH+vF2/y0weyceevESwdaZAazVUlvC8M9oNnBGFK68PiuSlmKkEA/z0NwNuIYzVrciT1uYzpqoLPDyCDCKaRATQJBbQDqvol/9k2e4ukLfkiVqgyqqxF7wgBnxN1ixml/6VNKbf7dazyemlDTwHOOU/sJEsOZTG6+ZU+Yr1cL1ktH+oiAKVcY9J+wOFWQ19uCMUJTH72ZyVE0EMMyIMCYidOuc6xWgmM+UGBNyuDufUjELkZyXTaaU3iHUsZp89fkRd1qQxkueTAo5m96r9sOfrBh3maR5JU++QfUf4ejji60SII+P2D5f1Zc0uYjUtMlcs5H8sQIbggorahd454PdF4l9soqKhAqPiSTBpOCnuWHre4kGIw67oqEKi2/JQLRcYVIwCUOLMoXh4+nWTEhTp7dj/0VWS4tVNl/6p3MPAymWhpXc6oUhdtXJv/RtlRNSXq40br+MSQKQcl+IvTgU9ysVyW8uuHKNzT/3oIEkRMDqnTzmN8gVJm8199WgDT655VAC4QxuvSZFfh9QiyQjBDsBH8Jft84eFQM3N/+wMIHydTFzKKgAkRzayj8B9nx6+RkHWkvGBV0EmsfYsOdlbQFfafF+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(4326008)(336012)(426003)(36860700001)(47076005)(478600001)(41300700001)(36756003)(86362001)(82740400003)(83380400001)(81166007)(356005)(8936002)(2616005)(110136005)(316002)(70206006)(1076003)(44832011)(70586007)(26005)(4744005)(54906003)(2906002)(6666004)(8676002)(16526019)(5660300002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:02.7717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f52653-90f4-4e46-76fe-08dc21331f13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

We claim to have the AdminQ on our irq0 and thus cpu id 0,
but we need to be sure we set the affinity hint to try to
keep it there.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
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


