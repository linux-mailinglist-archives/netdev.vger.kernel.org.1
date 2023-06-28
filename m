Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4272D7416E2
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 19:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjF1RBL (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 13:01:11 -0400
Received: from mail-bn1nam02on2070.outbound.protection.outlook.com ([40.107.212.70]:2118
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbjF1RBK (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 13:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjD+p6umgK/HBrCYE6NZEwMQz3yYLQUa13QIajKiawxzM+G6Uk95W0jfAbqnvhZcMV3ySZ1uFJMCP978chIg246FR3rxeWGEj9n/y+39ZAGmuofYh1SYCzBeI30m7dI8Fad19p6KrPE+8QgQORtrM87yg5NmKKUzIrvqY6JAgR9i7iv4AWharg9hZL7Pn8foKIcmeUj/vTAoMeq9lmef5C0bp3rmwNyI88P1QFuXq/NJOEoOpBpRqdBvLuEHLuISqFDSe8RlH9/9GQ4NASvVMj0uX99ypCO6NmWLkagGK1OMxX8idYvxhjSOn0kLORAYEmbZlRsLTi8nBeJA07/uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtsNmeWErRor7rnPOuI1iLIitm3CxZBE0qVFgOmXb2g=;
 b=A8fF/yNN7yu5GAW2NedN37o+0KOu/D/N2HbOkdQ3zgGvM9aJc3JieSWDOYMfgkgOLm6Ryeu6cDmhGrM8eCgxdqU5qgSpyGNcLo6lD4CeMeQ6UqeloVjHFF0/ATyEWsR+GQKRL3DKAC8WuAtrhLdgNlm3BWkxX1VMqwp35xQBuDom6dn9ZAQReD7ik7wXyj+0WKgOOzR6A/2GNuCpMAlmD8nRq2XwKGyyRUAadPLAvw5grou/rK33sPV0DcsgXpL1mp7Re+irbe1gvH07BSEfzq9uDHNxYc4pJ3x2ZYqxZCSr4YbU6R5E2eKMzls1swJ1LQn+S6Y+jUixqN4HScw+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtsNmeWErRor7rnPOuI1iLIitm3CxZBE0qVFgOmXb2g=;
 b=oDGVJdRz8SqepR/MV5JSCbP6JCaoKtlyhu50jbncBQCenPniNug57co6Tv6BqNAHumg7Tw7PfS8gu5kgUDYksWZCNVDNaNtcATwL+0iQWfbPEM4PJmAKoR54pHZltEtkaxMUTLkX7qkyO4kluGqiDwsZv38jQYt+yqTM/fZ6LFw=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 17:01:07 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::47) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 17:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 17:01:07 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 12:01:05 -0500
From:   Shannon Nelson <shannon.nelson@amd.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <brett.creeley@amd.com>, <drivers@pensando.io>,
        <nitya.sunkad@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
Date:   Wed, 28 Jun 2023 10:00:50 -0700
Message-ID: <20230628170050.21290-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT100:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 205802e1-c95a-4a99-b4ad-08db77f94423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iSQJR6DB6r6bz3d1OwZQ3wIWUOeNosMZ7VZraMiKiEkYUVU6aGRF/AEwdCqkVDb/T68RzLGJyxQlkzJJFVvPnnObcyKZmXtjNijRBpkhvj7CLEuWiCdUOEocBZnNGMDntO+/a4HkG+FquZbahXm9D9R4HFEA6cQelsq4voTGVRmNks7LVD988Q/HBmpeal/UJ50/LMJHfWcJBinhgOIUEOUvx1J7J2u4w6cd21mwQZVYNH1M7i/9Gj2tO+IBRdZTvF+gfXWukPfKCdjugBR8QF1GxeEWGl8LUju6GVLIORB0ZWD/TNlCO1Fc5cvxlkr4GKAWVoFa5MqTwxGxeDdIXO8pOMslWabdb8OIBYUdHKCVyGNuP24L3L3f57Pa+4JN9oX7olng82cSeCiiUIcB+hKDw45GVXTk9YAJ78+VkJi/Yg/blg0Suu2yDeGjFQHzuVv0DrAMUaIO6thCT/5t5W9JXHzr2ufrLrkurSV6+aBWW7P6WUFEtd+3rMnNywwScusignzMSHQI62v4jxRmqxZYHReinifiQURkuH2AiG69UPB79bX7fsHSbDh0fY1V7/eHTdtNVpzjSSMp6oBT1zLAoFJNXF8njYDyglR1TCBA8dRMLcdQXO5UkJw+YaZEiudc7hLcY2CIlEiXwR+5U4YSkqEspp2HKctULF0fRY2lQSfZ1g61+KgMndR/jhrp7ILfoYtNp7sDlL1D69mPW/7xS8lLbk9Xs52dVN+WV3xWIxSZzfaAwTQ9lzH1fMn6uFsxHPAAhbor49rxev6bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(186003)(40480700001)(82310400005)(82740400003)(83380400001)(81166007)(2616005)(16526019)(47076005)(6666004)(26005)(336012)(86362001)(426003)(1076003)(356005)(36860700001)(110136005)(41300700001)(54906003)(70206006)(478600001)(316002)(36756003)(4326008)(70586007)(44832011)(5660300002)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 17:01:07.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205802e1-c95a-4a99-b4ad-08db77f94423
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

From: Nitya Sunkad <nitya.sunkad@amd.com>

Remove instances of WARN_ON to prevent problematic panic_on_warn use
resulting in kernel panics.

Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7c20a44e549b..d401d86f1f7a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -475,7 +475,9 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
 static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 				      struct ionic_qcq *n_qcq)
 {
-	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
+	if (n_qcq->flags & IONIC_QCQ_F_INTR) {
+		dev_warn(n_qcq->q.dev, "%s: n_qcq->flags and IONIC_QCQ_F_INTR set\n",
+			 __func__);
 		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
 		n_qcq->flags &= ~IONIC_QCQ_F_INTR;
 	}
-- 
2.17.1

