Return-Path: <netdev+bounces-36863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C47B2094
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8311C282652
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3884C87C;
	Thu, 28 Sep 2023 15:11:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70EF4D8E6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:11:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D131B6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JazB6uGpU/upxliqdI9pelY+dhxeg/hHKJW2OWLGF4VohTdKNTEJ44Ra7Cu0CZZ1Q1Giyhxv+hmT5nOBfTY6Ja3EB4O5X9XBqph1q5gN5A6YLxUtVT6C+6c7ptj6tc7NluROjAcuCRKUb7Umn+82bfH1qYr/fyjSyy/U7hLsRdryPVngKzOBFvM/gf6byb2vfsXwyKIhqzD0I47rbuaPL3MOqAA6/RKWJT+v0XpE1hREV5tfRnvt9rBAo4ilo2+y5+Z8FJOSdPq4mXrSEqCxgFek7wFuEtRZlYSRcPJd2BEwEBTgmeD+O0SAT85TksJ03g0jU77+/2GDDuDiBiHrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwL0zXrEmgJTQEZs5C2U6XlTUfZvvLmWNNYhiSz9ozg=;
 b=CKgc7bZyXmdqXNpJY/a/8M4xvR20ilinEIvtLWuxB9qRIXj7fN2ppLAr1gaoK0oXRGnnx3FaBJNIWQBpUbs75fjM2JHBvLqTcz8gjVy7SImBFCbBVghcGi1zs7inwlaaoRjslKoxKUS3T32nqsRlT+2ginDWSkqxyEd3F3xtljWFDEyHrPHI90FNqLNUCw4cQClvN85uX0J/O2azeTLbTvVfCZC/YYcz2chrByut4hGm2dfE3BxUTxNLhHqQoS/8PACuSlgJropR6Lfz5TCa1KKsyQ+MUJuUvVhloA3StCt47M7bx7JapQrfz1/1mtqX410cH8dxLAY4lYBESkbxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwL0zXrEmgJTQEZs5C2U6XlTUfZvvLmWNNYhiSz9ozg=;
 b=G5rGzo/H/kppZUckvXputQmuHb4aUPGsMknaOhktxsliOaqoDWLUoBx6t0omUJqmiOJnWw4o0TRWZ/0VsGdJAzKxc2+J9rafLls9e4Gj5uaAzi/m+E9q5aBWFuMg+P5Rr4rgZ30EQKGnVZlai9rVJ4hyMBgL5VQUOXB+IRulxOCDipUC5YtlMF0cpFd7MpB2zapfwLc4g0zNTj1xPXDx6r1FgalWmUVXa3clXEaRVycNOpwVo/0ThAgvFUz5TPT5SpnCTUtz0J+KX4zdR65v9tj7gX0auoe1sAwbcL4EoDCYtRimYtovWvx4rCBTQaMUDAy3R9dAHnev6qt5Sa3+3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 15:10:57 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:57 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v16 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Thu, 28 Sep 2023 15:09:42 +0000
Message-Id: <20230928150954.1684-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fab989e-1a6a-42a0-6f8a-08dbc0351e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GPRq/+XtBKccP6POyKqT2G1GrhxVS7K0YDFL28WuPzZNWQUZx4pDIvNBOIhvaEVfGX0sr1cvC53jBewOH87KVSs1Nqz8yh2vTUFxcBTvkkdhmba1aVTuz0Gc8yh7pkt65RSAiYeh4OEWLa3GyNMA6pHXZgN7Q66UUNj6kGUvNSRGFOWfU+UHTHp/5Kabnnga92/WeDthPcd1TaTHGNDWfJMBRetfxq5crGhNh45rLdbktc6GSQVo6bAhnq3JXGKVZUE/wdks9uSxS3BNv8NXaMc3cT+chPcqRpblszCoJmhK6pfnmfbm+DNB3biFz+T9yJhiBnG07EyxXBfQMcwIJZFZdxxx9ZshwIXkyaUqc2nDEfIuVErNQCbf3YJRakL1tATSm5AMc/8nb7QPfvE/qMRVqwnFdsAd+bxSQJnNhmHIBefVfBuO0Zyu51vDQuHIwjtxB+ou5VIMl9SjnFCSFm0OOWeAZd5z4TeiU4kNArBxpcU/r74F2VZmnDKIEqBDf+GEEYX42oWVOcfCVQqSd7ZTLrTwmRhJfV21x1rYUJd7ruA79nZLOWE1DU4V56yx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6666004)(38100700002)(478600001)(66556008)(316002)(66476007)(66946007)(6512007)(107886003)(2616005)(1076003)(6486002)(26005)(6506007)(8676002)(36756003)(7416002)(8936002)(41300700001)(2906002)(4326008)(5660300002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPUfgX8rg+Cd86/H4hiZBJf2m99LzR6gyDRT5IghkRShthbnaMEzjc0v1b18?=
 =?us-ascii?Q?iKa1MY4f5ygIQQeQ441p/yFnELtn+2WCtn6YRG1KsFfDwBtNVPBp9Z94j09r?=
 =?us-ascii?Q?MRoPoSdpLsuCeldgWg52bd35iGG1frZ55okTmf5yeWMyBchQpz7EiTpJpFM1?=
 =?us-ascii?Q?9orjVcVKZLjl13L6lxOZ6Wvah5rLPtVssbq8h225NdMigpsuNHZIIHdjkFjM?=
 =?us-ascii?Q?YJQHqugb/kzkRmMJVDLtjoZGk+otPKivJJYur/VKyIE91i2X7B3wSqaXvOZW?=
 =?us-ascii?Q?v6Lc6KpqkwZDqzKTEu9JvvieIeKNNUFWNp97tUd2cAbOpk2bF61+cJiXalrX?=
 =?us-ascii?Q?wwytsoHUm4r3O3+NsqJwCdiV7YzRpcjCTlK2PYY5E/38NNTg9B1tIYYGbcFB?=
 =?us-ascii?Q?zOqZRVU3yu78yZwDUEXbNEIAjIuaM5idwIYVigGq/DL1g+rIQIbWRKB2XS8G?=
 =?us-ascii?Q?RsCLOfuzlla0hfDZp4+px40NoZgO0UPmf/hYeMZrrDDl4TIXX3UB3guOAWG3?=
 =?us-ascii?Q?YCBMjjIdpCYXHXXpdx6b8jIpk5UHc6c2kUhI7RIDFmEMtl5PFWCekVKFv36Z?=
 =?us-ascii?Q?F/yRAN1bqCHnzvBoBJoRE8FR/xiWjFz8VyWJz0RKiXaAgLxy9UWn96jfFmo4?=
 =?us-ascii?Q?nPAtvobg+6abcpINXTEqftmm99P1WpO4HV8dTMwZtrDO4xmckepSKnYd2XFv?=
 =?us-ascii?Q?me+/ll031BYN3LbKPicJvec5oYJp3kW3CE/7hwhr0NS4Mjis1Yplh1/MwbvD?=
 =?us-ascii?Q?7I8weEFM1vUnUHfkezqxE5npgLVgvtPnuZMlEAzjyM7AyRtGm+1adzk+RXLy?=
 =?us-ascii?Q?5LxN04bZwzRcCEa+QN3sX2mXEeHQyl4TAesn9Uyqpq7T11BEEO6UduhHW90g?=
 =?us-ascii?Q?vLSOReDl7a66LJEQ3tLR7k/UCp9w9h7jy694JLETLWBG7N2Hn6iKtMQrD0/2?=
 =?us-ascii?Q?M0saBpzKxoGHfman1dr7t46XJMQOxfJadTIkfxHMapBvRPCJGDJGVmArxOtp?=
 =?us-ascii?Q?0EyoUNACd0EjVe5hI0qjlYfZzzugzRC0SkAey3avsh8+b2elq6tlwtFIif6+?=
 =?us-ascii?Q?cE9kdb8EaT3pvwZWMiWxyJ94kafpreYNXO30wumxPXtNhUXqoXUYi9H9t4Wt?=
 =?us-ascii?Q?mXEaoB/Znia1d2MlU4qNBInQxuq9aOpQJgx/mLxt+xax0WfKoQKfyG9Hhe3Y?=
 =?us-ascii?Q?H4D5JsGoWt21yyNXbjuPU6MkzV7qyLAVUMGmCWlCx/UPGdbuw72SuPPM/PZg?=
 =?us-ascii?Q?JqPskOlqocit4kx6iCj647swYTR/9zppBtM6Q6jR1ofdGNqBpmnBiiZRVrfg?=
 =?us-ascii?Q?CMk1Iu6R21+1OKJVrSS6TN2wAVVr+8gAEfImfJmq+b9Xdp+4t1L7tdHtdpWl?=
 =?us-ascii?Q?sdWIabgng1d74EfAMCfsfW/d37dMKNd2EZvPb4Fj+tOq6k0ZlmiKesNh1cxW?=
 =?us-ascii?Q?JopEL7qAFzSki8ZIUXFNuXbBnU9foszPmIrzmfYCzNVW2R80kNR8udw7k4vC?=
 =?us-ascii?Q?7eqADZy8R+DrTiSls0DqwnxmW1K/kT5+57DJ8aRkzO18TwwzHrdIu3Gw0W1g?=
 =?us-ascii?Q?KcGRH7IPHjLEG0cow3sq1Q3ZFM70otaFJzicKjN9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fab989e-1a6a-42a0-6f8a-08dbc0351e38
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:57.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnajaTjKdlX33mrEGx1VEo+vWIuiEVXU3e9iYroJAceJ++mvq3pXa6AW1EOSpSJ63wGVoErasleYYtPJQBw+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Or Gerlitz <ogerlitz@nvidia.com>

For ddp setup/teardown and resync, the offloading logic
uses HW resources at the NIC driver such as SQ and CQ.

These resources are destroyed when the netdevice does down
and hence we must stop using them before the NIC driver
destroys them.

Use netdevice notifier for that matter -- offloaded connections
are stopped before the stack continues to call the NIC driver
close ndo.

We use the existing recovery flow which has the advantage
of resuming the offload once the connection is re-set.

This also buys us proper handling for the UNREGISTER event
b/c our offloading starts in the UP state, and down is always
there between up to unregister.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 49975e8e7cde..783e51b0e178 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -216,6 +216,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3021,6 +3022,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int nvme_tcp_netdev_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+#ifdef CONFIG_ULP_DDP
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct nvme_tcp_ctrl *ctrl;
+
+	switch (event) {
+	case NETDEV_GOING_DOWN:
+		mutex_lock(&nvme_tcp_ctrl_mutex);
+		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+			if (ndev == ctrl->ddp_netdev)
+				nvme_tcp_error_recovery(&ctrl->ctrl);
+		}
+		mutex_unlock(&nvme_tcp_ctrl_mutex);
+		flush_workqueue(nvme_reset_wq);
+		/*
+		 * The associated controllers teardown has completed,
+		 * ddp contexts were also torn down so we should be
+		 * safe to continue...
+		 */
+	}
+#endif
+	return NOTIFY_DONE;
+}
+
 static struct nvmf_transport_ops nvme_tcp_transport = {
 	.name		= "tcp",
 	.module		= THIS_MODULE,
@@ -3035,6 +3062,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3049,8 +3078,19 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	nvme_tcp_netdevice_nb.notifier_call = nvme_tcp_netdev_event;
+	ret = register_netdevice_notifier(&nvme_tcp_netdevice_nb);
+	if (ret) {
+		pr_err("failed to register netdev notifier\n");
+		goto out_free_workqueue;
+	}
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
+
+out_free_workqueue:
+	destroy_workqueue(nvme_tcp_wq);
+	return ret;
 }
 
 static void __exit nvme_tcp_cleanup_module(void)
@@ -3058,6 +3098,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


