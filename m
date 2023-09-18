Return-Path: <netdev+bounces-34828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350DC7A55B4
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352691C20A15
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDFE450FA;
	Mon, 18 Sep 2023 22:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B8328C5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 22:22:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D90BC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5xLZ2QjP8jEPjDBz2SFTY1zoJcpN7qlyS/73/pDvYVHKi/yf+eqVoPaSTAXhY4aT+2DdwjGATi1knSo47EG4QtVBUe2yTXOH9B9+CyjP3uEM/2PcypdKwqf36XbOMb7jrLR9dFSxIONpHcI+YYLbbEiZ+4x3m8hMiYkCR7jjnfvoPUfV1+CRdt52FAX53qaBsQtASlT6hK66pdANqn99+HeuBSCy4URF2kvFxYV/Yhv51MYZVd6ALXNSsR1csO/sb5ERWaAbA5h+nrVrGRlLAOsBw604W2TOkRrRAs2YHrs4QHPP/BbNFfi1Z/wIRDGKVXqGv7xfJWKh2bfoV4M/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHq9duAalZcU0Rn3n8vpMhj7je2hvyzr98EshXXOGnY=;
 b=K9CiP2/Utl/78HFqMHbSI7S8tcDpiDc8JZXYxrGg5LVQVuZ/VxRyfU8JJcjdIF1vu7hffFrBa48yX+g2Gk3aiy/CqdPxzoXz9r6H51oDFigWLwEH7RtMkqIC13d5qhlT6Rgx4RRHVp/WUQdGg8byAfr9blbrSJ3qlkkSqkqbEEv2lC3PZWr9KeYWJ3W7IbLjMEW8G8eeXQxHO1mvcdZxFKEHLNsLpIQ6eRJAhEsBqX6jL/9hJSl3bVw0n3HvZzyT1hSvgyr5USOwycO+PkIThRGihhHGRyrFqiCF2BkSxOSHrUEIaI4zlGzMMLGUIzbF7dhXBGdxYSM/VN+yRz8NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHq9duAalZcU0Rn3n8vpMhj7je2hvyzr98EshXXOGnY=;
 b=Yf1Mwb/blAvWgn+36mTOh+rWgnjK47X+NL7rO5JJPVDgTATblDqdWhXBRFH6ZCbYFTe6QDbxNVBC6TA6tvUOEXAVEuhX35zSpEG0ZmtRcmsIDD3fPA7ny9NeOimE0ols2OI49wSizpmA3jQOBTA6VZD/NPl0ypPHK8/LOKgKWrg=
Received: from MN2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:208:1b4::42)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 18 Sep
 2023 22:21:59 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::17) by MN2PR15CA0029.outlook.office365.com
 (2603:10b6:208:1b4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 22:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 22:21:58 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 17:21:57 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 3/3] ionic: expand the descriptor bufs array
Date: Mon, 18 Sep 2023 15:21:36 -0700
Message-ID: <20230918222136.40251-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918222136.40251-1-shannon.nelson@amd.com>
References: <20230918222136.40251-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fdc4cc-4a84-43aa-ccff-08dbb895ac55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iMdoMlM3Sy9iTie3gi5tYNe5S92ORsO4XbOdllb1qR/UKoh3Zdem5nBz+WAqEpvRLDF34xsyBciu38Sqw/B/VrtubDi36r0tI52L001VFmDBywe81sez0aaAyu8TDoth2t9t4Ad5e5WdNy0BhLzcnfZtms9dqX3HRWpGTES5TAqYSBKVFzq8LRgX5pJTYn0F9NwrpbPjpCyS0T6jmfmn1QiDmcm62nwU2MSUHhwJBwgJu/HyicJ31CjYJYRTep7lfMy/mUD1yH0vHDkfYVuctHjpoBRVvvXatsrgiwmUJqocLer8zo2ZnGt8XemcVm+pC1bHTIdN1ySzva0kIaFUDVxOyCcBE6FJtSQRkM2vS4QXj7vP8LzGR2BQbZP1lTzKQAwMY4OJmOiuibttSLdKQ2wwIlpF5nz0pJPsKi6hdIS0aKPhxlPK0GvL8K6i1wzp8Kc5r+8TzSKrBhAD5RBfipkCtUBcC39+JlhTE4LW4Cz8n+bhdhhg6QRGF2Af4SKFWFATRKHYNl1R9LBceDRmlsBYsw5Aqp432roq7u8Ff3naeTInrkkou2nbg49iK6R+TJRyf5Br9yeZDUsuowO6QL80Q/qoHQHirm+2FGdHXAUFGCykO3iPNrK52Ij0gG9KbTC7tBypypWM8CZVrbmV0n/ZV9pVXl4lsDKVr1ibhV1l8g6OtLbEILjfepbFVs1Jyi9PKxX+8BhJDIs7ktGTOFTt1de3HN2pdoVS5QKG+rlCFL65KjRhnbNEi886J48Z99KIr/Igy9vJSLZ89IY3pA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(26005)(54906003)(316002)(70586007)(110136005)(70206006)(336012)(1076003)(36756003)(2616005)(83380400001)(6666004)(82740400003)(36860700001)(356005)(86362001)(40480700001)(478600001)(40460700003)(16526019)(81166007)(2906002)(426003)(47076005)(5660300002)(41300700001)(4326008)(8676002)(44832011)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 22:21:58.3530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fdc4cc-4a84-43aa-ccff-08dbb895ac55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When processing a TSO we may have frags spread across several
descriptors, and the total count of frags in one skb may exceed
our per descriptor IONIC_MAX_FRAGS: this is fine as long as
each descriptor has fewer frags than the limit.  Since the skb
could have as many as MAX_SKB_FRAGS, and the first descriptor
is where we track and map the frag buffers, we need to be sure
we can map buffers for all of the frags plus the TSO header in
the first descriptor's buffer array.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 6aac98bcb9f4..b51febf86504 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -7,6 +7,7 @@
 #include <linux/atomic.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <linux/skbuff.h>
 
 #include "ionic_if.h"
 #include "ionic_regs.h"
@@ -216,7 +217,7 @@ struct ionic_desc_info {
 	};
 	unsigned int bytes;
 	unsigned int nbufs;
-	struct ionic_buf_info bufs[IONIC_MAX_FRAGS];
+	struct ionic_buf_info bufs[MAX_SKB_FRAGS + 1];
 	ionic_desc_cb cb;
 	void *cb_arg;
 };
-- 
2.17.1


