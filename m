Return-Path: <netdev+bounces-35086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A283B7A6E7C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5747C281514
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886E3AC1F;
	Tue, 19 Sep 2023 22:14:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E2374DD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:14:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F79E70
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtkMc8q7/mYbY0LxuOOzLC3M5oJVdD0oRngbgfSzVHy74Zb+i1LTT3nxBpi59t9GbBjJFmWtqNdG4WjGw8/A/+7JRCbMlgxZqJebZXvIIFvfF5QXcjTOzLmKBlSK/fMTxViz0j64gbV3UtlDrhB+TJsjbHsG5Q1QoJ60dFvaC0C96IT7Pc5xWaNvJFmua8I6AswJ9Si9cGiMYeOV+PcHtfCNUA1SFiHztOCfsX4nMx3NNU9nteH5oiaGKoGzh1FGM/HiC4KC92Uzsh1P7+XMeBKqjnCu4ROtgtpObs1JfBXKAijmRdJRYMCTvAnD+OCmJLLAScO9F6gDRTg8XbZvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOJ5EXwmU0+Y6WLDVWSpacxIB/zH5jjk8q2yZBP9GOU=;
 b=jNynbxR2Ef2GgU1KzYY4DEw4CRUlyj05Ay6tw88AGnK9ak0J2t9O1LSmQI5CrJZcNvZfCHmDcFiI0lXCIP/IgslZK00lDpR1+LUdwMfSkTbPBaqHsoz7xnlo+NQvP1UpU5Z9mo+lAJ6zMyGovTCX7Z2PstEIjJLcHkkADOBzzW46Gk+XoW/Hzfhl4hghn5MCz/9KK2i4g4UVrDmpjg5y3OPdiaBCGT6aiZjUEVBsfA+Fr1TYfa/VKIyL9uluLkj+oDoMqyitGEWMjyfyC80qHRfiuXh+tf2oOy/rzwimbPUTeQ6XdS4KnYfcFBNQmPYUaD7RMOobo5c9cNgXRDv9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOJ5EXwmU0+Y6WLDVWSpacxIB/zH5jjk8q2yZBP9GOU=;
 b=hwbvRZN3Y1SdItElImqR0LUtW6ODQa5h+P5PaJE2RI+fCDSYjN5ILAyGYDHm5410Ameru3i8sEMij/3EXblpsRQqsQhKz4UEvlYvSs3Tpo3/nXJiKJcb+eXX5GdgrUYuYE+hpr3bQctLa4yPVpsLrOuRI2bfWm2825EzW4Xe3y5WIXGpafzjYAwOm/YM+O+mWj1yFMVeyCQQI4NPQI8lG9sT5kc5WKZvD6rV4Efzcu9KVVra395cgDZzcAyIjub/ay6NBCjcsu7MYafZ/ulmZdXDWG6ObH8LrjrwEK3MTW6sCjfSZYJBSNWjuZ9lrcM4MP6j2O25r1Q2EJ4P06Wbbw==
Received: from SA1P222CA0042.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::16)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 22:13:24 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::84) by SA1P222CA0042.outlook.office365.com
 (2603:10b6:806:2d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 22:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 22:13:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 15:13:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 15:13:14 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Sep 2023 15:13:13 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v1 1/3] mlxbf_gige: Fix kernel panic at shutdown
Date: Tue, 19 Sep 2023 18:13:06 -0400
Message-ID: <20230919221308.30735-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230919221308.30735-1-asmaa@nvidia.com>
References: <20230919221308.30735-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: e475f842-3b47-4d2a-31d0-08dbb95da3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P/ZmxZhYFwPAM/OEMGx5Ubo3jkAaKQO4PpeoCiQ53HfJ/9TQqW4imSJdR9cqyEFllQcb9F9hTBRtRurPEHjdpXZaqVUqJu2+26UNs5Q3PRHKVunzCKM8PhEYGjXFt7L06KdUTOHB4fNtL7H9mQMbcUBFZjZB//EzB4kDKUk0qM3B1cag5ewlk9HPyQSXKR62XkZGbUJiWh4Wa9zQRc1VJMupjj3rX/yZBv4SbM9mST5ndeSr//J6Ozg49SIWL16T+tvjy5BHcWVeL2/zZZdXw7mZOd1sQnFVSdf7VXdNilgyYiuz9zY4otmCQKoe/iIlGUjLcJMzymEwSiIZXMPlf/Ij0R9hrMrlJ/aO+mNz55ApLMFIS79NLskRulYisJGEdK0Lm+xWIhIkbtWnwK5XzhWvIqR/aKk8IaiCFo8Gux0g/QuSGkkSnQ6mh8WdIKLO4UvYKLDWqMwukfVGXCY+J5kHCeKTN58pu5UFVD0sLhWJRW8reUyDKtz1o+CdhPLGhYM7uoe+pLflyaGgWGbjf/cQjfwvmtckQA93jyeunmPhFTPlMnvfIzaso2DlXLkG93JCCqRFgTeBm1YlNTrl3OrePZ9hzIeWN0LKVP0XMnEHDpqdpqcqiXXMyS5sYq0+9Fr/lUBz3vzMNygcMA+SqNZOYl6xXYDBhi1y/dgaSbdMNA4879+geNiE0E8pMSXugL+Dl8zdEIH9fNKnNWGUpbWHQR78PTeI5FwOjbJlGpIyl5JBS5ktGZ9aVKZ30Rrw
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(110136005)(41300700001)(83380400001)(5660300002)(478600001)(40480700001)(6666004)(2906002)(70206006)(70586007)(54906003)(8936002)(8676002)(4326008)(316002)(7696005)(1076003)(2616005)(26005)(107886003)(40460700003)(426003)(336012)(47076005)(36860700001)(36756003)(86362001)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 22:13:23.5659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e475f842-3b47-4d2a-31d0-08dbb95da3f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a race condition happening during shutdown due to pending napi transactions.
Since mlxbf_gige_poll is still running, it tries to access a NULL pointer and as a
result causes a kernel panic:

[  284.074822] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
...
[  284.322326] Call trace:
[  284.324757]  mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
[  284.330924]  mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
[  284.335876]  __napi_poll+0x40/0x1c8
[  284.339353]  net_rx_action+0x314/0x3a0
[  284.343086]  __do_softirq+0x128/0x334
[  284.346734]  run_ksoftirqd+0x54/0x6c
[  284.350294]  smpboot_thread_fn+0x14c/0x190
[  284.354375]  kthread+0x10c/0x110
[  284.357588]  ret_from_fork+0x10/0x20
[  284.361150] Code: 8b070000 f9000ea0 f95056c0 f86178a1 (b9407002)
[  284.367227] ---[ end trace a18340bbb9ea2fa7 ]---

To fix this, return in the case where "priv" is NULL.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 0d5a41a2ae01..cfb8fb957f0c 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -298,6 +298,9 @@ int mlxbf_gige_poll(struct napi_struct *napi, int budget)
 
 	priv = container_of(napi, struct mlxbf_gige, napi);
 
+	if (!priv)
+		return 0;
+
 	mlxbf_gige_handle_tx_complete(priv);
 
 	do {
-- 
2.30.1


