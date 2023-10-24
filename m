Return-Path: <netdev+bounces-43856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED607D5066
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4957B20DA6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDC6273D0;
	Tue, 24 Oct 2023 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ejreFpfx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316033F1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:55:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F4D7E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djxnYQeLdeV9TtVt54Ro/XS7l47U9ryc/Ww8QxygsZsExL910E+ObfPPyNu1BxBREcfn2R0l+bqPhoWMbFcJRcALTlc7aHFU4spoj2t43c2Mc/44iuW/fsK3SyY/A3qK7EhT63I7kUivCMa0jFdQZLE7LJ3xpUrHKArjWJvJmY3bHeDj6r0y0/2HAyoRQUW1N/RDXhrHZoVSFYd5JqoBM5hosZw4QTiyh5JvL2e8AhrVXL9UwpcXPDL4JdsKZlRyRh5btD8b3v0+b0/rw4CMOvBGS2OD9LBvNrd6E/1lE1jZX7Hbr+nwUc3uu6/WPPYdchf9Zwv2MrbJiMG7obF5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cQdW+kVPFopf+4GEvx4+hSS2f3jeQxmTh2Emy1k7Xs=;
 b=MSOIPYmo9dS9RfPRpHbVJNLSqq7vG6sfVmZtoekxsP1iqDA8lJ9WM3bTBXHFmW0JtP+jKWeWPhfPN2BhFdz1vNTytcpiEZz3Xb5zL69Y5bUBsdCHKHN3vnXAfkIv/TgFgsz5YPwFjkqfdDVQj1qV7ooViyXFWLMcXr4cAU7+9HPQIHPD9oxUThvaHebeNKIXreoDar/372g/2cPy6u1iWLgMKSmpEBkEK0wT+ompEPZggZFwfTci56BrM6Inhzgvszk1hHrsj28PF1CgEHvlxoNCfN6I+yqdzv7uEslO2jG/0hWuJVYeBjnWI6Y+vKf+HXHZKN7fCTmR2gdT42Jb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cQdW+kVPFopf+4GEvx4+hSS2f3jeQxmTh2Emy1k7Xs=;
 b=ejreFpfxMDk1iJ9XdmKXDUiSK/Wx/PAPb608VOCjWfKLUvvGgEzhxe589F3fMo8ck5POODiJXLdn6YVk3N+UW8jG2qX8TJ3MnPMQh/qGQ5jJixdAxrlJYReTcHpdQIiETxs70dMc5aPa05T44X09+cEJ9s4iSBsthEAejCLlQt9xOqwlxCXQ3TZGMwgufwFlB2w3AuNPvlFC8YYsG50u1lPT3vpI3RWklqf7lkZ1lK3TiNyJVumWNuke11O+R1QBBsSQg7IjBOZFUGJz+DzKaz2qRuHUC74cuc3iD1LftSK38AZ6U6yMWy3Jcx038Chn0CaYoOfF+l99+eAaOK260g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:40 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:40 +0000
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
Subject: [PATCH v17 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Tue, 24 Oct 2023 12:54:33 +0000
Message-Id: <20231024125445.2632-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a9f51a-cc10-45dd-5af4-08dbd4908662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c4oYsRy9WAl5wruRXBNFJZUie3tv1ZwZbIha3xgT6LX2F6bl/H6aMY5nxGX7fU51M5i9KtYBa4LIaJri9y5Jt7I/yEuHKjvZA0Yix28DVEohlJDPmpg03V58YVO5cyH/gKO09/nFOW8SGDSv5WkLAFzz6cF9j6t8F4WHptr/lRbCBShX3TOvQRwUIaANxZytDqnIgCTZRy0r1FkeKO8Lc35+CF04SLpmesoWy7XQLY/71PT1ynvmnIlwU4gWAJqXNm5gKN+DO76D9PHK+TmRHWiskVn1mNXQz2vmsVJ/SragTOq2rsveIffpgAirw0PIyON/hybZCQ1j3jxsGUzLiDI+f8H7ag8EtK/clq8KSUpYSko51y0PXlH8Y8MBpIhLh7tbpKhiXb6x+X81U4W67TlVibw7Tv7no7OlcTQNbRVl4jYHZG3ioujx660fVCKg7WaSE2mbPylHe/oBbsI2jQxX3RjTtKJROVV5pjJiqlNwv4Tm4WiwPUY6OA7k2cdR0VlIdLJlQY2ch41Bgft4KofK8sUy7jwt7PXa3V64APE1PGh7ax6EzC3se2rV11Ej
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KkV/0FG0F/TQxmyel5fjnSml4jeHPsxgt0seFjlrAUREE7rw6Vvw/a0Gi5Mp?=
 =?us-ascii?Q?YhNGLueyCVdPIvCRu6b2yhr4Y/3OEgM10Yj+wqP+hOD41IHX3M2htJGVvKaL?=
 =?us-ascii?Q?4fCanA2L0rMFYlvtjKzKOMrkQZwmshj+vlc0zP5/X3wOU3ERGo8HljMRaNcV?=
 =?us-ascii?Q?DHL7qskguzkusZJlaR5sfhWld7+dLqr+Rs38RfdywrMNRqCz0SWxLTFfu/Za?=
 =?us-ascii?Q?9MRN0SvhfP+KWtBKY+vgE6QWNGNpj6UMF9Hm0laXSjiYtkENAelxxl5diNEP?=
 =?us-ascii?Q?CxarX7bkHRQgEHaxL1/AGw8kCRLn28VPn7c3IcjVi37CmAYnG63XDAI8M0Ix?=
 =?us-ascii?Q?2hqiFmI9/RmIftk6U1VGtfZsB/WI5HvnEdcEDtFM5zPjWj+xP1SIfPuw39Qx?=
 =?us-ascii?Q?+JNMR/+63d4KNTdEOHKDYGcAG0KoKVq4FKxcgl90uG4mTEyaV7LBN19XIysr?=
 =?us-ascii?Q?66JJGc1MJI0N8CIxuzTLj7O9M+PbOJohW6f7jNrFTqHIjFdMJZMp/GBnrPkS?=
 =?us-ascii?Q?JnwZXrgFfCtQx0iTNoLVdASwqaEb9kQBAthmdd6aqE8PWPscPz3Syr+dnpdf?=
 =?us-ascii?Q?890Z2TojYcsjFuL35gAo4S+EEZfGHID6la+nJpWaEbLFGiRULxHfbTaIplTD?=
 =?us-ascii?Q?RCvGxykv+5vAflO20LQFmSLwG0KkN8TYxn+2UeK58QBNZmChufMd19lTADN4?=
 =?us-ascii?Q?zNrha2XqTczwbKgfcBjLnmEJ1wx9NaoTo3Gsk/h1Wrp1vOCFU8zNqojWnJhd?=
 =?us-ascii?Q?za1SZj8BoXak99xFD+hJGYqCvjquhps7HwVX1lI2w6rMEBTcGq2zVUHm2qlG?=
 =?us-ascii?Q?nCy4zlPiZH6ZAvemAeoGaeRV41yZxQIwOU5trRE3Vjnzv25lQcaPefDNAyhn?=
 =?us-ascii?Q?HOZ9yTLV0s41oGCBQLrvAFyTrtE47O1DWGGxYEKO/1eY/ydBtjsldPwdz2uJ?=
 =?us-ascii?Q?cQNyFFSMZBXv2/FgDF1cGASZtVahByScogXoGVlU7Juhyd29uo5AQg4Y8o9A?=
 =?us-ascii?Q?jAFj7bHYK1g3/uxNYpE7ExTg9pHi8JnZH8mWv0ZpfFTrL3NNCyPFVosG/wb4?=
 =?us-ascii?Q?6y6zypJF7GBwj3Sx9IgShnDURddKypvipkMlMiX9mRKrMfxuCVFUdQM0m7+i?=
 =?us-ascii?Q?9Sdz+i0sTp+HoevouTLLUHa5loz1UZ4R4+5uN43hBMkTZz6jNGD5Pu2D0qGV?=
 =?us-ascii?Q?XW3waPM2cuKloWbtDPd2JYCj9CBcGfiJ4ajrc8TIEfQDt5XgJmyIlGdtNFIE?=
 =?us-ascii?Q?THR3ROJH+9cYHoI5QkLc8TfI157BH4gQO1uROeb9wRQBxJSF2VbF5/c1JL3u?=
 =?us-ascii?Q?b2IuiorF6FUH0r65hE+YQ4eg/603WetFMVIjVJh6sf8T0fJ2RBZBLrIe/KKb?=
 =?us-ascii?Q?hq+Xw9Ln3wQF90EfWQjZHzN3cH448F+0IVmyQIBqjJzHGIKSdZAhpiUf/hML?=
 =?us-ascii?Q?DqzbwFvABO2SA+tzatnd3TZv9c69H17dqQxwT2mMi3AgZe3+NX53FQJ9fel2?=
 =?us-ascii?Q?yNQ5unzZlAKLqzCRXIPW08ZpucpcGCncUi38xObJQgw+2TP8D4PWbm3JJdwe?=
 =?us-ascii?Q?n5UQMDj4Fex8xI7vs+qzBGxwA9IOoq+BfpQCsuSr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a9f51a-cc10-45dd-5af4-08dbd4908662
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:39.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+bOMuJbTzfAPFDhQTJQZLyNHrJQVq7WUkftjZHvGDMtqeOACnrtZNaMZgFTgCmRWqRxnRFqr7xZDCruvYVeMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
index 97fdb2d83208..1eabf8c27fe9 100644
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


