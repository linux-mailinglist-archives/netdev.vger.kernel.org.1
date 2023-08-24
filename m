Return-Path: <netdev+bounces-30441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B0B787516
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399E12815B9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032D14287;
	Thu, 24 Aug 2023 16:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1682891D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:19:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A31FCE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuLjovAWJ4LqYcjiG8Dl9sw5+qTAsenau4OwVHzyv7Fr6H5OzhWJq7hR13aZaTo7YshcbrvkOCgfZBFfFp1OFeOf/5FVwRMevP6CpPLMrRkDKE4a6UBo9rKbzNKTeKHvtmid/5rGJtc0SkFGzBS8AUlvuF9OlrV1kQVXYCw7wYBVU4RdfWGlVX9k2zpHitc2va+tdu3e1uA8e7CBX4qR4ou31OAbkY+QwNnkQ4KQdze0a9RrUHUJnrZKJNHFDR7TfoCxtvd9WKbVIIj9x+rxJ0E6NbVli1mjUI/u4+Vsh+KewoQXz7zeKAPLtq2yKigcF4sR4bxpo0nGRi0A132Bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtpWN1mY5adwU3J5iNC7caeagtnmqXpAZr/WTuueZRc=;
 b=CJL9fTMc2wlG3mKilVnjsRon6B7lrZ2OG4xVAsdYEtMeNNEM7TacZRvUjfyKMGWFfUkfRrdyL1a69uxsUj0UYB7sMSwHiy6TwGiYD6OK5Y1/IJGX32g7DMLMPNaeF9Qzd/4CWk7FX1A+JFZJ4YOEma4ePQsA5wLODSAZfrICl0eA0XYyXJ34OrHtDUCCnq9ukdjkEfeZntHf6ZDrAQ+9QGRhSAwzMyWk3uXaLHP5dh3+ITYd0jeHm1eVibZcciAHmvQ+mEum4CMTl9VaEbhK+2uAVIva6Rr/wmRhvf9S+Si6PeG0j7Fh0oRxBOuu9nbH/jJVbm0fAv3DjaJR/Omq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtpWN1mY5adwU3J5iNC7caeagtnmqXpAZr/WTuueZRc=;
 b=smeEHvyx4FbohMpDXoQSQqBcX0tCsEBJ8LIy2ve9/g+Dg8ZNPCXxfdqzWP8LbrTh9/Kpo6FwQblzFlJ5QVantGiVvf0GfrRgEl9A6krVF4CpVkXoUWFNi1J6Gwu/ErSIZ5AF6CwoLSJ77kXfhIlED1ulPFIuEGMOM9g/c7C6RJ4=
Received: from SN7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::6)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:18:23 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::78) by SN7P222CA0021.outlook.office365.com
 (2603:10b6:806:124::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 16:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 16:18:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:18:21 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH net 1/5] pds_core: protect devlink callbacks from fw_down state
Date: Thu, 24 Aug 2023 09:17:50 -0700
Message-ID: <20230824161754.34264-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824161754.34264-1-shannon.nelson@amd.com>
References: <20230824161754.34264-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ac6fa9-8ca1-4955-de7e-08dba4bdbcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lTuy0+4mUq6fwXQly0ta4iJkt2KrCA8YJIxMhjWKZYyQJedQia5jyxD967UmGThO0U8aOiLnoUUkPN+ld39DmudgK6ZSZ+ME/pVGYQMawUHBnSHK/XOqhfulZun5rntk/ASoLWc0EpWwLIYRSyF1jHQHWcU/dr6dQb0dGBaOCAplxDggNcZR5JBrWYfnujdpTdy6Tn+dXP3WBItI8riGI7Ud5qpfRADuB2i5jFTgDi/K/2sgTbMY5+Y4SFUg7JEDz1RFa8TFpqETQ9AALeAKRtuDY3CrBUDE4BS6Ba+u3VEIw/YUfjZ9fBfM4SyPRmkIXn0KMSRx61Rycr4lRIIgoJCZUAlal3CUnWvQngLC8Epua53d0opNeJcM/qAQ/6+UW1bF/aIcHbZ7E9QauyWSTJf1GZEyEO1bjZ89Kk0DTUq2tFfkhCmRSXZweHLUjZcaQPgc7lf3b4lIABnWKfQmvtj+9pqPEzvsXdZVCKh6OHeIW/hMQ2cn5a0hlp98HM4qxLEGtoJ5bsskaBnoVa2y5CQ7Sbcc4J1YHXEv2Q/EO5PQ2I0UlzZA3ix6ft9YveD+daPiSlIOu2QNUP6ua6g19ffmlpNSIGQVGATQIt2xp0oKtVmnS+o353fuFCMxFSsaTkY0I2cpD9pYMzwuufjvfGOQ3a9paowwCxZuZyTlh4MYz6kYNa3MrKyOD1kcyzpcGXNMIcw0DMlm1auBHji15ktpaIWmBnN3R9oj0wHXjBMrS1zcLXvqIblKGvdvnlBBMFwylLiwCbXtkPRBIU5sQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(2616005)(5660300002)(8676002)(8936002)(4326008)(426003)(336012)(47076005)(36756003)(83380400001)(44832011)(36860700001)(26005)(16526019)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(40480700001)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:18:22.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ac6fa9-8ca1-4955-de7e-08dba4bdbcc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Don't access structs that have been cleared when in the fw_down
state and the various structs have been cleaned and are waiting
to recover.  This caused a panic on rmmod when already in fw_down
and devlink_param_unregister() tried to check the parameters.

Fixes: 40ced8944536 ("pds_core: devlink params for enabling VIF support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 9c6b3653c1c7..d9607033bbf2 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -10,6 +10,9 @@ pdsc_viftype *pdsc_dl_find_viftype_by_id(struct pdsc *pdsc,
 {
 	int vt;
 
+	if (!pdsc->viftype_status)
+		return NULL;
+
 	for (vt = 0; vt < PDS_DEV_TYPE_MAX; vt++) {
 		if (pdsc->viftype_status[vt].dl_id == dl_id)
 			return &pdsc->viftype_status[vt];
-- 
2.17.1


