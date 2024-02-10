Return-Path: <netdev+bounces-70705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABB85014D
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE152816F0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681941FDB;
	Sat, 10 Feb 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cC9JlM5n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E584652
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526128; cv=fail; b=u+6bNbTT1RSnXdmJqdmaUFbAbT0wKpK6YMd7/yeiQZ7e4INkqAg7nguTxctxEkcqbNyZg//u93j2wEcFDSG+bIV07I3hgmuvz0p5i0vEW5WX3/uSufPjGMx/MhuJRNlahKlYNSdRHfMD/oAt7Fbfkjb/+bGvzqFLC9r4p9xHHQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526128; c=relaxed/simple;
	bh=r9mZdjKxF+ESrjLt7Fo4bL3aM9vW6towQe6iO2M9DIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAT5IMDpRDe5/FGi2qr3naldGtFKRiZmi4+LXw0ew4W5bZrk29/UGz968TLT4eBNZtX96UM20C5q3dpxDHJrkBn6v0iIoLRj92WYYgMBFH2ppnuh7va4ePOddc8/ZgfKH85VsEiDU6WRYpNG8gE/kZ+AqOjS6oMRiZ04UE98+DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cC9JlM5n; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDMQIIFpv5Ymu+d6eGAcfcRRsAD04NGSnbLA0xIn5UnwTkVIZA/Jhu70NPxWKaqu2vm8+GZkaL3FLh9IVIn7bp9DM3+wCfPvdkznhh0IdcE4R6oIozLNyCBK171S7EJzBwzXwVEuP1KJzfKaqk+zUXxzUSJEjIEmNU9AIgTHb8p+lwViJ2Lw1yoKGlnWV8ZAwEsDw7VDI1a8VP/9+i0B7birTuKUqs/qqP4Dc6RCJk9DHCzTlTdmFWZh8RYq5ccZXezmmPcU493vNHsRU223yquDXHlhN/g9ugl16Cj1Od6ru3alJ3Oy/D2h3AJ6cAaieOsWyTvMw5FqXBHcZGizzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlaePoqD63MkIfC/8xk9mww37KcdFE0/JQKsrH9YqVk=;
 b=fCVn4SRhrPNNTUL5vSoW6NEgwe865QCiV39pRlgfritRfo5UViltMyf7BcYIE6t8omnjJJttyXo5Yh8yR0okoLctLfEyprGAnOVjUaV9aD3wMaqcfjLH5bVeh0B2B24ZQTavkb1MY8am2GjnHB/jpRI5glc4Zx9l0sAlCueRT6dl2l2no6deDaOT81+cvrnw+8V9F3YPmZWTglK3jQImizgEsDpvr9zV5akL+rk6bsvoIwc0AS2s3Ht5JOH+HQfmm6ZSm/1jgYzOEiHirmB2vNZ6bycIJAK9LxDQPzsMrCGyopRLMQ8RLUttEq5R+G7sRx+BbHGYLGYxplZF6veEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlaePoqD63MkIfC/8xk9mww37KcdFE0/JQKsrH9YqVk=;
 b=cC9JlM5nmspiNaLVfgoY0TcQH1lRHVHs1j8oQ8g67rxz/HIYxN+GBLyPEvb3MLJ6QS9h5rMIL8P+72HfUA+dAIrrqQOQZakKYGh+WwRHLSFDS+VXdw2jboUxTf3vRBP9cPzCykyLejolTVvLyBSGOBH8D7DiQ7iruCCnenHYP1U=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Sat, 10 Feb
 2024 00:48:43 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::8) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 00:48:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:42 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 1/9] ionic: set adminq irq affinity
Date: Fri, 9 Feb 2024 16:48:19 -0800
Message-ID: <20240210004827.53814-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240210004827.53814-1-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 307f6893-fb59-4d4b-ba42-08dc29d20824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8FiVDjiBn6MpBHoJD6BZkdlt154SU8OVeNgRzg/HSJFoog8CbCyDNMOrf4EsKgik5pWD9N9/BY33z3L/WP9swBBv/4Tjy3EKNk+B8fthCOUwsO+cYvOyDJbIP7smmiZei/gnsXVgkrm2ibg7lWSL3S2NrCw4HvU/QvgW2+tkd+hMgQnyfSxxx+pGAkNkN3cwief7T1IzcKGAX0iPCLy+OHjorkT3nvsH3PATjrIGVfMKxJEnOBN/n1pmnZtY8OAZSmzpHhQnkAqPi6oV0jyUoNfG0118ZEb+cIG2U4CsDzooq0373x8pdVRg2526BfWSHpeQkDAex+NLuN3ZNG3BHjJpmK9x6GRD8bYlo2iAnn4yJH4a6VQMIa7jW7BbQNP719DIWGdsXF8OaOgRan2Z3Q6VVWT4UiqIh11CEsGRRitCbR9ELcnW3wdH6vnNLxZepN2EzmctF0AuNaQUk752QvMjcbzqM7ek9R/9QvFXlce7pKeQ/Fyq/hcrsBU9YRbZBqcF1llZzQJZIV2rLflFQSnEj0LdU95WxE7fjAJCFtPQhaMtmRYaxdaSu7LcpgwCk9PwB/zW+FVhyqnx8udfTPkqZbZ6XQT7ZfE5q0nIXtM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(478600001)(316002)(86362001)(426003)(26005)(16526019)(83380400001)(81166007)(2616005)(82740400003)(356005)(1076003)(2906002)(8936002)(54906003)(336012)(70206006)(4326008)(5660300002)(4744005)(8676002)(44832011)(70586007)(6666004)(110136005)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:43.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307f6893-fb59-4d4b-ba42-08dc29d20824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

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


