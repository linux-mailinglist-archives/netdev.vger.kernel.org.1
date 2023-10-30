Return-Path: <netdev+bounces-45175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C8C7DB42F
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D59B20BC3
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D687523A;
	Mon, 30 Oct 2023 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdFHuA9v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BE4C7F
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:25:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0A3EA
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 00:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWT2H89p2i579D5wAkAR/zM3IHidXZx48Dw1jxjudeqpbgijV0fy6Wdz96RV/1jsbzIhhl/fy4luPp1O8w02DxFAB7uKaRgZC8vpiw35bdi0r/gkcajHfGKKqJi35V8dsVGVBNYNlZuePJhrvZ+r0eeUehNFuJw7prFQ9aJVQT+p8tRzT4dTLE7gDuKlRiZwoi2f0qWiARsokxXK7/+/eF6Ctog6pkrMNL3OnXEgcham+72nG8VpkRa2Ev3IGz8DT2x1Wxy1Vm36B7jitIk/PMJTwfvAToO211ZRGzCSndkIsCYUCkhNjAsQqsenseSellBhkogbQgZ47AVxRFHQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07umMMh5k62yZiyeA6IvK/kAHioUq+vPsGUSjjisM/E=;
 b=GJVrBpyYp7qMh+8oSHawtJ1AfQijj4Zm8UtnlL49c2DaYNGWteMTLvr3kFnuvFGLlfFACE6o3tQCslyBHH2eU9hAucN7sto/ygI9NxCoZ81+WEGFmdLsY7VmyyVkpKBd7sqlvApJi/GVFW6VIkXixmL0fS14vE3yCkMEHpYo9iCTNXlKnTkngglSqKLGgojj0wHBwFvnvbxU1ItTMrUzP+c2Q+G7PM87rE6BG2s6OW5YoMV4KtixlvJL+SmXoW0GwZYYwv30bVZPLWARRO8ejo1F+lGGNRvwhZeyKK29R7hEUJylUVof66okd9ZlTnEBlaAmytaWKyXNI346Z6GUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07umMMh5k62yZiyeA6IvK/kAHioUq+vPsGUSjjisM/E=;
 b=tdFHuA9vCa2nbPRazygHn4hdiXpJBMYQvFbozD4R316BH/okO25ivF/7uqpgmzfZowBg6iGX+wAYj8LEodwl7g9ga+Ss4V5yPQFLUWIfeIyWBSROd20RQRFhepHyaeer7vMMpIOvR3UwwaYv7VlHrcQBUXK/3FI1JdANcM3BNzKPuTdEI++EK21McMGqA5y8zlie72CIyDRBWHehkWz3ZdcaWCW/BRhfTdm4FNUBYwSeJVc+TX+VyqQ5Ycm5ezYSexL6pOBe13ZgzEaAaJg7ByofIXJzs+hPeh8m3nKZUYz4TmyaqoeUO8JUgJ9GGJfNYD1lEJzhXkn3Fg2jvZg2bQ==
Received: from DM6PR07CA0106.namprd07.prod.outlook.com (2603:10b6:5:330::15)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 07:25:06 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::9d) by DM6PR07CA0106.outlook.office365.com
 (2603:10b6:5:330::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 07:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 30 Oct 2023 07:25:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 00:24:57 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 30 Oct 2023 00:24:54 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <markwang@nvidia.com>, <mlxsw@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH ethtool-next] ethtool: Add support for more CMIS transceiver modules
Date: Mon, 30 Oct 2023 09:23:53 +0200
Message-ID: <20231030072353.1031217-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c25529-b6b7-4073-555e-08dbd91956f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ctNOeVj7RgTJGvMmX9al7c/1XkyorvR0DcUMuyOynvn+wENmoj4fIiBLqJlXETdPVTIw0779uIW763pERBOdtY7tGRojhHNMgBgzW+6UYYIE6J9Gu4dtPlZAdGZ5YYooRZZnR/6QF6iKom/3+KjTmD2cc/wsm/yWBwkoNKnkYaQiiiBXlE5lDCJ2xZmH6tQYQLEDLBiDajFXJhtyv7Aeoxq634UGICC5kkwRlqag2HsrykzLLMiMgyW7BvhUfQ2drrxjTuwqrdblrmofia0LmQhfQ5xDLytzdaPg6usWUm7btJ1JjfWHIAPICExpZqU2UMC7DBwzrFxK2gjDS38YQZZfvQQJpIhjl8kcyrs1d5imaTthHMC0ZGFyg2hPN9TITxgrbvUrzEbLYz/w6C+2ewnICoEhQy81ivpRP76yc+8BlNdQYQXAufWHOFAAcPkpT2xpo0g2e7odiP+HUP7r5M0BBl8VauCZAUKnD1KyIQkx3fIFTUcH/a2xY3hktObvDd2pGrWjNl917Xh7iGvhhL5tbExkHzCcu89pUtgdtvhNXgtQLMYWCk9WGIwdgxj6qIxQDlQe6v7uI3kf/r9TI3+W7Y8Sb9jBoTWO9OlbUNDcfa1b6wELNsE3MpMoKIVOflmNjdqorxIR1RGu26K91ygPkJA2EP9iJ7HTvhxeBcd63S3f9Z1qeyRFL3hoa2YwTbnY4idXy+LxQ6rSwMK5SGwD6lQh1l4r6T0ZvcQpWVITtRNdvpcay7Icwrb1jf6t
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(82740400003)(83380400001)(40480700001)(40460700003)(47076005)(356005)(7636003)(36860700001)(478600001)(2906002)(8676002)(8936002)(107886003)(4326008)(70586007)(70206006)(316002)(6916009)(54906003)(5660300002)(41300700001)(426003)(1076003)(16526019)(336012)(26005)(2616005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:25:05.7954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c25529-b6b7-4073-555e-08dbd91956f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483

Add three more SFF-8024 Identifier Values that according to the standard
support the Common Management Interface Specification (CMIS) memory map
so that ethtool will be able to dump, parse and print their EEPROM
contents.

Reported-by: Mark Wang <markwang@nvidia.com>
Tested-by: Mark Wang <markwang@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 netlink/module-eeprom.c |  3 +++
 qsfp.c                  | 10 +++++++---
 sff-common.c            |  9 +++++++++
 sff-common.h            |  5 ++++-
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index 49833a2a6a38..09ad58011d2a 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -225,6 +225,9 @@ static int eeprom_parse(struct cmd_context *ctx)
 	case SFF8024_ID_QSFP_DD:
 	case SFF8024_ID_OSFP:
 	case SFF8024_ID_DSFP:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+	case SFF8024_ID_SFP_DD_CMIS:
+	case SFF8024_ID_SFP_PLUS_CMIS:
 		return cmis_show_all_nl(ctx);
 #endif
 	default:
diff --git a/qsfp.c b/qsfp.c
index 5a535c5c092b..eedf6883f7a3 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -977,9 +977,13 @@ void sff8636_show_all_ioctl(const __u8 *id, __u32 eeprom_len)
 {
 	struct sff8636_memory_map map = {};
 
-	if (id[SFF8636_ID_OFFSET] == SFF8024_ID_QSFP_DD ||
-	    id[SFF8636_ID_OFFSET] == SFF8024_ID_OSFP ||
-	    id[SFF8636_ID_OFFSET] == SFF8024_ID_DSFP) {
+	switch (id[SFF8636_ID_OFFSET]) {
+	case SFF8024_ID_QSFP_DD:
+	case SFF8024_ID_OSFP:
+	case SFF8024_ID_DSFP:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+	case SFF8024_ID_SFP_DD_CMIS:
+	case SFF8024_ID_SFP_PLUS_CMIS:
 		cmis_show_all_ioctl(id);
 		return;
 	}
diff --git a/sff-common.c b/sff-common.c
index a5c1510302a6..a412a6ec0a4e 100644
--- a/sff-common.c
+++ b/sff-common.c
@@ -162,6 +162,15 @@ void sff8024_show_identifier(const __u8 *id, int id_offset)
 	case SFF8024_ID_DSFP:
 		printf(" (DSFP Dual Small Form Factor Pluggable Transceiver)\n");
 		break;
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+		printf(" (QSFP+ or later with Common Management Interface Specification (CMIS))\n");
+		break;
+	case SFF8024_ID_SFP_DD_CMIS:
+		printf(" (SFP-DD Double Density 2X Pluggable Transceiver with Common Management Interface Specification (CMIS))\n");
+		break;
+	case SFF8024_ID_SFP_PLUS_CMIS:
+		printf(" (SFP+ and later with Common Management Interface Specification (CMIS))\n");
+		break;
 	default:
 		printf(" (reserved or unknown)\n");
 		break;
diff --git a/sff-common.h b/sff-common.h
index 57bcc4a415fe..899dc5be15b1 100644
--- a/sff-common.h
+++ b/sff-common.h
@@ -64,7 +64,10 @@
 #define  SFF8024_ID_QSFP_DD				0x18
 #define  SFF8024_ID_OSFP				0x19
 #define  SFF8024_ID_DSFP				0x1B
-#define  SFF8024_ID_LAST				SFF8024_ID_DSFP
+#define  SFF8024_ID_QSFP_PLUS_CMIS			0x1E
+#define  SFF8024_ID_SFP_DD_CMIS				0x1F
+#define  SFF8024_ID_SFP_PLUS_CMIS			0x20
+#define  SFF8024_ID_LAST				SFF8024_ID_SFP_PLUS_CMIS
 #define  SFF8024_ID_UNALLOCATED_LAST	0x7F
 #define  SFF8024_ID_VENDOR_START		0x80
 #define  SFF8024_ID_VENDOR_LAST			0xFF
-- 
2.40.1


