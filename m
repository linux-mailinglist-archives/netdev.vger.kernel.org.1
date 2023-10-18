Return-Path: <netdev+bounces-42275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D17CE052
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AC6281C97
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE0347B6;
	Wed, 18 Oct 2023 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mJxK4BpO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171B341B7
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:46:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDFB94
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btT9qdZXAGHFbTNaO28jTZXhZJw4i7l/P5PdCdxiuf5sa8RyXfqRC+prtITwlvPLxmAE3YydyqOtcWRlEkQnhcJJ8Erpa5M5HVJVqIVflzYhMzT0JE98ARtgeZCM6TTWKp5YeynAtfJCKhsou+bR1Vt2ZTiq0F2llvroBvMHQYm0ckl8zH2ieeRn79cx9QTX9mUOFLofM++A5Yy+H00jtZB076B8o/mr5ObVU5BPSdCm5z7a/uFpb0J7pYL+A5zmCVLOIkV2Dih0fho8rW8DYGOdo1mUjHodea4Ch4H00UyM2nascmN2GJmrsPLnzMowyTu+BxiFTl86yngXosbqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IHKfxHrVSKk6ZoQqVUP6lt3GjVVvHY0tJ3i917L05U=;
 b=Ui+WlO4Y9olmrmiUcsXXNJMGIX2TtMj0V+chwYMV3ZbmCWiScuL9K+irxiEoORgxXzlMu1gxRG7Qqx1Oe650zlIKGtWAwCmoIp3xUTBymlIM4u4JcOUQjvYHOJvO3pV+CBFrsZcsn3+ahx7dD9kVqNvge/7UaMAJUjcr672JMaUMkeROanMtfNvdoO4/xWMZTQ8SwYYY864cvJlLzKEw9HFbXCdgWLWmWiFfvNwoPv8sVCLoV8bPG5198elFaVTbRu5qneYltVvsZXRP5wIkOea0+e0ttlxhIRB9N/GSdK8JamSMluD1QnzQmK41Zn8rhNi9xNdRh7gajtY2oMCH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IHKfxHrVSKk6ZoQqVUP6lt3GjVVvHY0tJ3i917L05U=;
 b=mJxK4BpO9WyRs8f7V8Atux/bObDc8Pw4byLW/9tDyFR8ZJ4IDe80qn9qI9nnVagm2o8nPgZLlX3+DueB/hT79DW5dYpLpV+JxjeMsWRUkQG5Zrm2jtf/0ka+wzXT+geM32n6kOLuviiaMTvhiHSBwMl6236+RTd98uFimn6LqjU=
Received: from MW3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:303:2b::32)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 14:46:15 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::e2) by MW3PR05CA0027.outlook.office365.com
 (2603:10b6:303:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Wed, 18 Oct 2023 14:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.4 via Frontend Transport; Wed, 18 Oct 2023 14:46:14 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 09:46:11 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: [PATCH net-next 1/2] amd-xgbe: add support for new pci device id 0x1641
Date: Wed, 18 Oct 2023 20:14:49 +0530
Message-ID: <20231018144450.2061125-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
References: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH0PR12MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f49b29c-df3a-4a6a-3b8e-08dbcfe8fadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ItQJBQRaWp68PnUWANSozssGFvt38UwM8SJi8Jq3AV2nTRrpMOohPlS9eCoCkwY1eQOB3Ir3IsyinqiEaBtmafdgE57Cr0rB1p3InKduOLuA+GYGRhxjKbaObsSwmsv9vmmKfJIyLXCBemMqBG2Xq70iPU4OIG9cDNIQ59l6VW1zPPyxcyNcrIZTBl5x5nBZgXSL/RSyE5yXbxz81eLnLahtr0QahiQL4flkzKfN/lkPvQOr04sDmUvcLiSt6zGwouY90+Uq4nBLWTqssgIgkDLjSLZFYl2y23dtM8OfRM0QiXwQSKS7qPHv7u7GA4YpS4rvTDH0LJRnXySj2FnPsEABPX/jtEct/egdIqv8yb2LBsOk0hIxy7lN3tXmOQgi3c0wkyfYn07bPgaOmchpLHfEqQr+bSjJ2mwkfW3OPXHGQFCH1jYPzbBTTnrrnTYArGXzy6tX6UKdKMewfpEkCc+b/xyp3JSXDhrLDCtuJJYADwu0SvEXWAr/0+Dahr0DOoI+wvAy4RvQ2iaqhc2BlWSCaswD7sZRazr/8ScqikLqDlKhcqT3L29Z/+T0B4pGnqBOcWDFIpFDS8TM8wveRRfetNolsqk8J3HTbn4U4gNAwQ750h56ynDiTblhd49tksJmiC7MZ7xZ+RJ+dFAhVdPqzdvOptBjyZTHFj9bto/cCS+hy1Mg0gSll7PVKquoe5Mf7G+NwoZfPudaI5ckdEjq0rsAl3Eoe+5GSMURBYzxpXsqOXCyIXJCy4Kk/+3Ql53RnnFS19Itb9FjC9knjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(478600001)(5660300002)(70586007)(70206006)(6916009)(4326008)(8676002)(8936002)(86362001)(2906002)(41300700001)(6666004)(54906003)(7696005)(316002)(336012)(40480700001)(47076005)(2616005)(81166007)(1076003)(16526019)(26005)(356005)(426003)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:46:14.9372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f49b29c-df3a-4a6a-3b8e-08dbcfe8fadb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for a new AMD Ethernet device called "Crater". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices.

Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f409d7bd1f1e..a17359d43b45 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -510,6 +510,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.25.1


