Return-Path: <netdev+bounces-53668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CAD8040C7
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647B31F21335
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A0374E5;
	Mon,  4 Dec 2023 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="euRTwB3z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC92B6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:10:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRk8mrCXdEPnjhV0/IZgnQYkYq3bLl+z9ERLOydYDZoN7FQ6VHW2AzcOCzf2j1t3B2yBRinAYxbpldUyqcJdiZJUakriRYJQuEankEjq6Y+vMHRJ1AIH/zyqi5rL4xb2ve0km4dPL3/G0hb7tgYfBxF+kMWWX1B3woRJGE6zacx7rIDfzzTPm2mTDaqigd1hobKBJ8GCyQs/qPeAPO3aVBlgrmmg5Q9xXGAhyuAISyNm7TWrc+SSSgLXfteyBPdVUiLzTZ1dyv4aHUeHL4Y+J/Nhoq1lExoiqnZ/ui55xw1ctGehMVOmwIRrAqivjx6KLuQxRnEKw1jlQeqcJuUZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdsb2qldqyt+Yv+mwcWKMYKOYtUzvMnmWSRDP1g75pQ=;
 b=eQ4ByMXpvPdeyVr/gbmFvne6X9i31PU42/WRX9aEhBY+isMRpKEo0asqh1LF+AdvwKPNZkitO4K0ZBoBRMklP0Rhzz/eHlcoT3A4DoAqeRxwTSM1qblDZUO8lS7XD8RU/wLZR2VRjp9av2CsROmpL0/GNFREz17hl1euFjVl9aPEpZuaLjllyG1yVdWJdzgr+eM9oeosfton6H4nRhFqZC8TGr2OLRy7SJsuVnKY3xGLEgJcy/ff/jKjvfIhig+Si5BRJ9t5NUWIJ73gJOeY0+LV8dIdS29RlvNTNCyGbn0H21H/yVO6MifuU315Cr5wLb6BaexB6UeFPSqDKDD8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdsb2qldqyt+Yv+mwcWKMYKOYtUzvMnmWSRDP1g75pQ=;
 b=euRTwB3ziGQu+mftK0dEW9EjxW7Pe4M6nRcwOCSd1qOEXjrYXiOtyeGCYvhajrdKMV3d8gQXtmaIcryup0N1uANk04Y+Srf4oNsU7x1RWueN85OTLcSSmm+D+WKEN9W4cZb5me8UhXZwXEoki63qGpKJuu51Aq03IZ5wOBIz+Uo=
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 21:10:04 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::2) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 21:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:10:04 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:10:01 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 3/5] ionic: Don't check null when calling vfree()
Date: Mon, 4 Dec 2023 13:09:34 -0800
Message-ID: <20231204210936.16587-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204210936.16587-1-shannon.nelson@amd.com>
References: <20231204210936.16587-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY5PR12MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ecd3fa-05f4-4263-fc30-08dbf50d62f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/2HBw7O61l29WN6SnH/kcGwcIqq58w1FFlcxwzyV/259v3GwtGoz4iZFFt3zbcZPKfXEMGdfv4iL0bcvNisLi4GoUPBBK5t2Vw4h50j6tanpnk5N6NZYAyCiNUqKBXHCGxyQjJGTIrFhe1IJ8KJTsMS5tapOWRUaaK/SwJ2lCpgXWJ8CuC7GP7X2iOlMocKb775UWWIrLTs5eYYUgiLGCNpkVktmiewF2/zPHzuglW2wl4bVhonkRp5AsNduQNXGUqk00uXEMp0nUv8c6lmnF5rKYl3tztb4SbC0OpS3SUTqnJS2/ieAPHEKaPKES51nUNTHuNbpVaKcAkRKRZfKqJukEdN8vO1jhtej5iBpLqRiRjo68SmHC2Uyusp5N39S6WOL2rncOFkivI7nYi7nfUDEQbbHzFXDYTtNrx/fd3cs75xOv/dFugJ6Hjil8KsgDKonAHtIGPX38QuLIR1htoh4UE7saSRBotCwgfDBCaj+/Hdjokll4JifaYWxvONf4NnUqyc75/+7cBRBWaP+V1w/bbmnIH39ucDwCELg2XLrT0wBzG+xc1Yzk5pbkoOwDZnsbWZUHHJXmt82jBQDOa0F7cbvl598j/+NxdCZtC9lqZAeAjh7/Kw19K9KJl6jeKoKAxJ6lur/QyafdJyPvBbKwu/Xts7sMsBStONp0TBaUpl2ENfWeTvHL/jX5A/lM5rsj5sV67rHdb1H/ivh2dZcSDBY/LE1yQpRMDZlr/2VRDaiM6pBI2ri9k5APkbfEcTGTJoObUP2/Akrs+k5NA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(36860700001)(356005)(47076005)(81166007)(5660300002)(2906002)(82740400003)(83380400001)(1076003)(336012)(426003)(6666004)(2616005)(26005)(16526019)(110136005)(478600001)(36756003)(41300700001)(70206006)(54906003)(4326008)(8936002)(70586007)(44832011)(316002)(86362001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:10:04.5203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ecd3fa-05f4-4263-fc30-08dbf50d62f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967

From: Brett Creeley <brett.creeley@amd.com>

vfree() checks for null internally, so there's no need to
check in the caller. So, always vfree() on variables
allocated with valloc(). If the variables are never
alloc'd vfree() is still safe.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index a5e6b1e2f5ee..6842a31fc04b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -424,14 +424,10 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 
 	ionic_qcq_intr_free(lif, qcq);
 
-	if (qcq->cq.info) {
-		vfree(qcq->cq.info);
-		qcq->cq.info = NULL;
-	}
-	if (qcq->q.info) {
-		vfree(qcq->q.info);
-		qcq->q.info = NULL;
-	}
+	vfree(qcq->cq.info);
+	qcq->cq.info = NULL;
+	vfree(qcq->q.info);
+	qcq->q.info = NULL;
 }
 
 void ionic_qcqs_free(struct ionic_lif *lif)
-- 
2.17.1


