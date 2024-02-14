Return-Path: <netdev+bounces-71787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A028855175
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD02846C1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0912A148;
	Wed, 14 Feb 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SxTpp8gv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAE128804
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933572; cv=fail; b=hNTitU+qNgMNS0NThsQG9sw12CrVUxcQZgj0u/wXTFQHs/fZWlHBQrT+GmzfUnQjSqu3DuxFjuHw5hWDQ+jFA8QGeLG+vhR5CGuhr1Y7bdzkwePbxulrjjDi9DsNh8r9iQAa5l48q7ApqDRgthrA+yL0sYOn0ZH5xPUXCValf+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933572; c=relaxed/simple;
	bh=r9mZdjKxF+ESrjLt7Fo4bL3aM9vW6towQe6iO2M9DIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoxwJaXGqoZSpeAIjU7C9UfGSCS8THHIzefgXPFJIWsOX5iKppKxxm6kRYPHZJv4VZ4UtjzGU3Kqq0ugylXAM1pJi+XVqqQDUqgZiJbk+rtMdi+w99xVPmffs69TuROBr1qJTecNvaMHS4VysKqMThfnTpfPkjK6O1tcYbyV5fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SxTpp8gv; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av5p0VLZaCtlCDQOL/hdSrV07b1lXEbEttqQQMmDmFHsaXNo4c0JYNDMbQiElFIqtCvea6oRjMSPoZ0t9hG9JFx6dU7MYlebJFcXwd8WaTcHP29cay9X9o1HhMuRcYBdQjaVxHUpuZmHnwn3VzC3EUeK+l2ChZmV+glD/7Qx+CfN3qFL+ySD2/3Jip+REIM7MR4RH6WIm6/pFHDt2NBMqnyNZKgyqr8IqiFKP1OdCjl9esE1nFJM/qgFxvPmAgnN+HHTi5EPDYOLvdIEDGHO0TJhX1PUfJfeKOgkvCM4Qmw4xXpgx7l3GePv97ZZuhC1/2kBMfP8eIUFA6AixP6ADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlaePoqD63MkIfC/8xk9mww37KcdFE0/JQKsrH9YqVk=;
 b=fSAR9Cfcg7kAm1pYiHSZcy2DjbuyuQ7P/4SPDvlVmCdvlqLAgezkkgd3ki3e0FJfTni/JKuvVB8ROhBxYZGyZQwzvCqoAdNFrJmv486CMyViIIkP1/k0B9Wx5tJHXux5I6jX7PI3+DIY+AV+vX3xGTK4uos23hymoE927H5ie/qA5+Tpxx5ljhgGGyWylkPter2keH2+Y5xDfXP08XZJ8O99i8Izc3QvtL0FPQd70uR1/jS2bkegYDvvzgGxE+yl6pJUDnRl1K5wWNgKgoFpdayxCUha3vhnoIvnxRJ1tHbjGWiQ46ay/mlvl5qEAY49bztspF/64VdMYOrA2PX/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlaePoqD63MkIfC/8xk9mww37KcdFE0/JQKsrH9YqVk=;
 b=SxTpp8gveShid35TOOGRwLnb5z6UIQOL7zxtRyrcghjvLCfD5pHQBZqvLXnc8eG0cvJILrIpnbzy5igYKRr72NgdUZlctchInV1V/KEu7a1H1sGKbTgKcgdHZE9Fyxn9ZuH0jaXgYckaBPU4Gtwe+S6SqVFBtApiPspEtT0xfus=
Received: from BL0PR0102CA0036.prod.exchangelabs.com (2603:10b6:207:18::49) by
 IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 17:59:27 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::7) by BL0PR0102CA0036.outlook.office365.com
 (2603:10b6:207:18::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:26 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 1/9] ionic: set adminq irq affinity
Date: Wed, 14 Feb 2024 09:59:01 -0800
Message-ID: <20240214175909.68802-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240214175909.68802-1-shannon.nelson@amd.com>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: caa9ed3c-44d1-437d-3aca-08dc2d86afc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rnu8GQfCLMLzGhuAv7iR3CL4FE7n0s9SaF0oXaWG5jWHdvNYD4TY//Bjp7i+J9nVXP9QGHIRwDQjgDHDM5FkwaD6SKBmBw++1ggayAwBTFPvnb5gSSbse4e5JPJZp+mtwUa3f8hS8fzBz5ATVCSJ0d7+r+0/Ab3Fp8O/SUTeYyMuPTwcFia0oUr8wd80U1MC76XyarPecomqmC1P7sf9dHZz6JFVhLUjL+Brk8kCtQPZInyh70HKJ5MuexsSs2c53OPg4P2p5SGhhvNRfbtGoIqY+0ZpW1QMxYVQ/7uhovyidzbNnuoKKwM/VVZlmRXwtmuDE3Rk/Qz+2caQTzlDcg8PgDhrKoYEmFe9P0Mh7aQtyCRg/UQ8HMSd1xrXakvuyyTBXr4M64s6pOR/JU9GJZMzTNQ2B56cB0TlSv9PQNTDdZGQFObAimF9sRwR0g7Pr/SQpqd+t9CG6+w16zCyv4C8FoKeJwGs4HcfvGYEHsgcXAqUpWTLCpldzsHKUN1e+ybQlaWxtteCKUK4MGmbopiDP8kNs6Ma0mLm+LgBzaWQLMl1lZ2vkR1fZ0OBTERQKRfUHk8VuM/lNAagSY7wdZ3gAAp9jFRDg41Fwb0kBSw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(8936002)(83380400001)(426003)(41300700001)(2616005)(336012)(26005)(70586007)(16526019)(1076003)(70206006)(4326008)(8676002)(316002)(54906003)(6666004)(36756003)(110136005)(478600001)(356005)(86362001)(82740400003)(81166007)(4744005)(2906002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:27.7392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa9ed3c-44d1-437d-3aca-08dc2d86afc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

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


