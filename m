Return-Path: <netdev+bounces-32891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C079AAB5
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B5B2812A5
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE58156E5;
	Mon, 11 Sep 2023 18:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905C154B4
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:08:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207E103
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnwfws7lpPWCliH38N9pYvgxhwGvridMbxaxuidFU3TNxd3J+CtGRP6BNi36CRet9wcbNittZRO6KxHKsHxhMI0GkVQrQbWShygkkP+qRfJy1UFAJ7RlllJfRiS3ljGsurbhyhXSGPT4tTP5OiE1Z8VpD8kH1W23m1nquqAGXAIIYaP66faONQ3nSgHPgZOCBzKrCcs5qCs7WYGtnJpaS1OOyyqaD1fDeTjpyXxYkB8pb5gGD04Y6Hc938NwhqWEEkLU3m2Qpk68UH8dBFBEMFB8ocylQL9tK4qxeHgE2Wqh+AQHQJmyESBu1ypB1p4PNU/JlOXiGcNf/0pvPm/ckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYADXVh8AoDrBaOSCw4BG1YtLJ4KlKykx/FaHOrKAOk=;
 b=dKEuy/LkyOppsROduW4/Fifa9k5NXbLLbcrDBLbw04UH1NVX0DzUbzirxJbuBcwytz3MlnQXKmOG63nTLOnVW+ss2UK1OR922Lqs8mlyjwiQy+qSe5bjB7530R8qZqLoRc88HcEPyWcN3JtCvXlTjv7WH+8bO4tRyAXVynD+aLGiF9cvKBmSgx8pqf34paxKOypkDG+DeQYQmGX6GkmVJHKWOntzVOR7DKBqj50CpVvMhbkmtkUYEugQQRF6Yqy7LaxTJt9WYmWZqH3H39Zi1g9h+Z3iFU1al3lCMVrPCEdMxzyjps+UD9qDF3LMrbP5Qvwr++I1k89CI2z4VQvXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYADXVh8AoDrBaOSCw4BG1YtLJ4KlKykx/FaHOrKAOk=;
 b=Y6HCRWor6C6HD2wX6xz+W7SZxnCEKsLRAjKr3RlCuvyEDORmA6wW9/BmIsG9nK+3BD8FjPAGFW0NptKDEtBSoyTR/GZEKqmHSZHJIbTSAJChurNVw2nVqvtNa63/Fo/QFSnPvnANV7tkaX8PvGNZREa8K6jDIZwirEHWvtFaEho=
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 18:08:42 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::97) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 18:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 18:08:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 13:08:40 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
	<mst@redhat.com>, <jasowang@redhat.com>, <si-wei.liu@oracle.com>,
	<shannon.nelson@amd.com>, <allen.hubbe@amd.com>, <drivers@pensando.io>
Subject: [PATCH iproute2] vdpa: consume device_features parameter
Date: Mon, 11 Sep 2023 11:08:15 -0700
Message-ID: <20230911180815.820-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 5532a399-ccb8-45e1-6476-08dbb2f22214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mYuBiOCTIV3/xmFo44X9mBmnBV2FTII6Skx+tQni4IXqvj9+g84UwhCi0JXX/89a1X4EXmSjgPakbThrH8O2HwnATM+G+gQOQm2zx3d6eeDRAMAH7DbCl9+/pU44+v1Xu6fJq7NtJvbIy7wbtgnPNFZETSQmACbm4SLT3nOFNfJDWGLf1/Z3jnw6jSEPcmxPr40SMLEYVUOIaAVU7+58EuHuIHrYKclxfMp3COS5BhPslmwzq1XMiFg8I7RZjNpIjNEmdFzsY/jk9nPv2ajeEklY/W+lh7d3GlNnXsqNPXqIiRIy5bq4oLTpWktyFF9YAVCiwHSJxiT1fWt8eEGtOzdvgc7/G/UOCkOTDycedRu80/ZOisvj1xxiDWzEZr5WpbnSSmn+Jvj2JDscKmwIdkwLvWmSJ4ieASqZz1PymQ6t5v9D5b4hCbyGGDsCtB2IIhrPE8hxSZgFkn92wWXFt40LNf7kbDPyBPgr76Qj57FhnzdTwe7bA7zvQGu1lMJ9QS9j7ej00bLNXjcQdx/jsTHh0T01jW7lUH1XtdGR/5nZtXzxD/rbI+nkmvMgi74oGpOOptUwdo9bA3vltfRzLG/K9mUy4hhI9E8NFYeSCHegHwHVLhh5juJZH50vGVZCmAIvN8whneu+cPtXwS9+LnjyZynJ0h8q8zm3yLtxLWnOdEphtsfE6KLQCeM6qttoPFY2d3/oj3onCpGuhmX/huwBgDy7JUfHTYqho/7Ak9lbJLRSzhYdC73Z7TYB/LDSLd3wKyksTxIeIJahtg+J7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(8676002)(54906003)(41300700001)(44832011)(8936002)(70206006)(316002)(6916009)(70586007)(40460700003)(81166007)(47076005)(478600001)(36756003)(40480700001)(2616005)(6666004)(86362001)(4744005)(16526019)(336012)(26005)(426003)(1076003)(2906002)(82740400003)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 18:08:42.5086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5532a399-ccb8-45e1-6476-08dbb2f22214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Allen Hubbe <allen.hubbe@amd.com>

Consume the parameter to device_features when parsing command line
options.  Otherwise the parameter may be used again as an option name.

 # vdpa dev add ... device_features 0xdeadbeef mac 00:11:22:33:44:55
 Unknown option "0xdeadbeef"

Fixes: a4442ce58ebb ("vdpa: allow provisioning device features")
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 vdpa/vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index 8bbe452c..6e4a9c11 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -353,6 +353,8 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
 						&opts->device_features);
 			if (err)
 				return err;
+
+			NEXT_ARG_FWD();
 			o_found |= VDPA_OPT_VDEV_FEATURES;
 		} else {
 			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
-- 
2.17.1


