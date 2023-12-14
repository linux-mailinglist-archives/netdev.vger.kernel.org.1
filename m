Return-Path: <netdev+bounces-57439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B581318B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD0C281D53
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E256770;
	Thu, 14 Dec 2023 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1WMDbmF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA49114
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WriLD9bdrK9ZZQh8gx2ZHyIWG/IetShJMy/qhdbpdXVNXu9Ptj4m9GlHh+YAd5tlvkLDvsCc8mXN+OxrxPY3Fjzd/F6t9DFDRqcDSidLhzpvUKiXTdx4FANbzC3oNOJoduCC2IH0dGYfzSeVKJjkAS20TUFlt3B91PecLYXSU4K77l6p4JQ4keOJab1p13DCzVYcA3IeicPuOAQZzp2iFCUK91hnyc/0NhXBvwB0K9pqEiwKLEuevmG6IKJJZrcij4M+aeEN1gF32lDZMXpBF8Xn3qUW58ZT/XRxxnPWsjACGI7ACsVMd3gfaTlR8LXAPpX+XGn1NzUfxIl87+ywHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebuS7kDl8rbYQhIn4+VpNDwKZz1wrtZGzcgL5ZGEWBI=;
 b=WhEtwm53GotgtuL3PyQihooz10btTK6w5ZtYKohFUh4NpSXlxQQ5y9crqZwK0uArSLtDvKMYi6pO52OI2LL2YUWkzm8bM3RPrl/1kqsYxnWXBKR2crIEOThldsZf99JEA58FoA6bxcAE+701H38NhZiyjWhUENoGJgcdB3e4KgxdEr3PQRVHG8tihReKYc2g/JSmvmSM+ZzIv0Q9ZIAQ+gGBBoBYpMaAFqQFAKmUwSx5AGoXWlgkDwHBXziDHAFhzy7ltiCYNFBST20LtJskFIOKKjoGhl69/hiHhwqbeRhVdk9YafDuN8XL88Fb5n6i+4q6gOu84oCntNOgkhv0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebuS7kDl8rbYQhIn4+VpNDwKZz1wrtZGzcgL5ZGEWBI=;
 b=C1WMDbmFYz4td1uRB8xnc3AQBEP0e3sgKBK8NI44JYif16jU6ILzDdE4Pjoo/qNWSi+G9ITYGwszd6N4h89rOn5bfGBr1y/YWtnAw5dVx0I6pAPH15XXlOProiCTw2/bUTwMPI5RczSkOLBvF82zLRFDfaN82kPr5FzhTC81kPpZDrNkquElPx4YOYfqC55fSL84o6a6EHx1GuXUtTklkDBy90L3320KDWQrWuE98XfAhie1nWtUE75J/EVr6v1bZH6QU5n+XCOc5cymq29cnUuRYtCTmVrPBtQr33+Q7bIBPGHswS35KUHR2nVmyfhuFhP5RjMrFQNh4Zm3kNwE9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:16 +0000
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
Subject: [PATCH v21 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Thu, 14 Dec 2023 13:26:11 +0000
Message-Id: <20231214132623.119227-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: fb897e1c-951b-4340-8c3b-08dbfca863bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xusCr2mWIjX1w/d9uWiIRF4rm8lHGY58UZFT9aNWUQXZQX3WRJj5TsP9mv4uMfIIorbEzcicDktvpVklg3YOxFQrq2v/DgUPiQEBgXrvvkxJEdj8p7ebf3qROHWvmhVyZQocIpSjjOcQj2ifn94uc60AX8cRoepllKDXcnsluGhucxsGOs833Sj1z+maUTBMfVUvj4tt87GWT0NHjzMOH9IsTXRxZadZjnpY0ZXC1JSYDzGDN2GsVdXOCjFH281/aPsEaWLXji/hEzMU0jVGJV9VDLveAzqwo7hvFIXTnUZUOwPzfIVegKNmYlNF3KpuWlSgS/ljUJ39gmKuITQeOC69UsUwsP8LPnyFfSp0YYbPsIRnzm6A295iHcuplunnNfKdL3RYQe3pKLzb/FHHXvlykmNqh7MKZwYlRaaeV8sneJdBuCRw0kwTjhWiaCxlKG8SonHpDxbIOgzgAXxiezo/Pb3PyARwUctCAls3tmrdWn2ub3ijyoAvCes4Tt5UkfMVC9w/idGYoAZ92nzhRvJioZpB1HlG/wyJ5RcwViAsFOLDOHBaDL0llXykQ/cS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AgetDMjWbOT4KTWg/QsiBMKs9Azfb6K8YlgC6kK2Mx0WcHscf4Y/zByucvk3?=
 =?us-ascii?Q?Q36S10kDaKVCHaCzLwfdkNPnutUCiKjyfN0f9EPhTYIUG/8f4N36s0dB59MO?=
 =?us-ascii?Q?daXbNdHJpZY17EissyJOCR0kqOvN07mgq2aYpFCzMAzrTCg1VHj6H1HIa5cO?=
 =?us-ascii?Q?ofUucHDLjhDCgHGKVDKBJ8jH6vLYqMtnBX2EslUAMK8b8Q2HnHy/v4Qka6HP?=
 =?us-ascii?Q?nZ7LuyLzGzpVydpfN+BhM0RyhiSKseysFsWZmjyICeDRy5N/Kr2RHFBVgBPq?=
 =?us-ascii?Q?oc72RctZOMsiqRtzXxbjikSUPdqMHKnx4WuYS9zygx/LO/KksurYy/ttth4D?=
 =?us-ascii?Q?QdvBs7w683GVz4x9bNKiY0wyAwcOYkQWT3V3tbOVQDy4w+ubvzkaHEUnB07F?=
 =?us-ascii?Q?AX/U4w9F0AGx3ctqjGaSDvVIJCXP3v8xJpKN5XIsyYqZD8JuOx23qszQtjUz?=
 =?us-ascii?Q?KaiDfhP5GPh3xAF1Vie5RmsAoqBU1uYBKAYLmqjr3Q+QPdUzL/tZp6GJfhMn?=
 =?us-ascii?Q?mgbEULuJ4I0rCODJTvC2fzRx/PMz4uJh8YNIOPK7ABtvC/zNL40M6SYYTMbh?=
 =?us-ascii?Q?f8RkBmL/IVM9eKOWG63vEtn7FjOSeq/Ri6chVse3s/NkkhISnyGhXlkddHg1?=
 =?us-ascii?Q?HAJoGGT4GbkiT2grDd0KrWd/j1pABucDwjZf029qjS96LuTwYzE93ozmrbqh?=
 =?us-ascii?Q?eJAOTuffieRQOd2sQ78likY6preDKIXCGCzKLn2czxFxrFTwKurnTfNY85oF?=
 =?us-ascii?Q?OFi85um6L2Hs6czVWIK8LZbFf6hTlcODK4x3zTYBmfluMA4el2D3oKV6emop?=
 =?us-ascii?Q?mf/rEvTRIixLckNyi5Vhaz5hbrmponDeveReBwpr3MCgevpfJQjutalHAqTT?=
 =?us-ascii?Q?K+SPDhB+WU6brSBkX7ZofT6C07WukWxmHsIIgLWf7fmUI1pFqjYtQKZyf86I?=
 =?us-ascii?Q?L7IHhj90gZD9d9WrwJe7NZM0SHqBQYlB0K2O3w936uSf1v6NYkJZsvIvTp2k?=
 =?us-ascii?Q?+vqPCREZwqvqCpl5NQCG1WTxmR7E7M+O/ltdeoN3eWVNdpQc0Ubw1br42zLV?=
 =?us-ascii?Q?Gfv93d/T6o851eF/oD9ZTW43icZHZWBOqDFGk936SR95iP3o8mxtzklgjKS5?=
 =?us-ascii?Q?Q271EUA4iV1JeYnWJYkLc9BdbCq307N3DV7uh/tblJeoMlgDDE298jfoxzN6?=
 =?us-ascii?Q?/d8oL7nt+IQBqwJukLU9QNO08FhkrwojWsxHte/GsnJv89bU7z52oGmiQMTg?=
 =?us-ascii?Q?tgjvVSFs0dORGVdBdwNABhxn2MmiJFSVji6655Hs58QpTiOgga7tDFNh1pMl?=
 =?us-ascii?Q?qwWtK1karb/I1G8rNVo5dfhNmQBLA7wL/iCKl05jtoyVNCvbB2OLgWe6VTBB?=
 =?us-ascii?Q?VlH0T0NEC05eketxhSMaul2X7O87ou6N4MiuL2LOtQCkyXiwVgo3TRosczpH?=
 =?us-ascii?Q?5V0xrlNIeqvQr8mxdnE8Y/1RsfVnSViXi/b1ydpo90JA5nPyGgcpn1BOyLQQ?=
 =?us-ascii?Q?9agBNOlnNYUjpkBNQYWRqDqypyf1rOAcUtgYFULdpcCb8PhU9k85qaocst6h?=
 =?us-ascii?Q?tYW1SyDgcCNior+JxnOZfoRNeMiBMcNJ55Ev28al?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb897e1c-951b-4340-8c3b-08dbfca863bb
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:16.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH2HOa8BclKEywvrIpOReIOaRRn6+AGr2pL3tBsOzRM7XunnCGZA+1aCngCkmJ1nH+lSn53leWYv7ffYfG+TDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

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
index a7591eb90b96..bc8040f6f87a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -234,6 +234,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3193,6 +3194,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3208,6 +3235,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3222,8 +3251,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3231,6 +3271,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


