Return-Path: <netdev+bounces-47706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550C7EB00D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D55B20AF4
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9ED3FB26;
	Tue, 14 Nov 2023 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jXDcEoEE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2B3E475
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:43:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477513D
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqjnMcpRRkvLauVTpAMduG4xtoum5oJJVKTfwVIQVl9S2C1f61JlIHhA0FdGPvoo3z8zW0YXMa0JjNSjuFguFv+Mwe1uCQ6u5H30jK1FL5dQJpWWsPKMp4055/HYnFHdWZdJStfppC5Yr/+Kfh+QbkkZMboDpJY1ad3umnuXmMyMt8lpwCBC5JHxPafAR1I2QEyRrxhYh7Ek6Vi60I//UrekIPWeooDWPdDsgqCL11bfSinWO63aePBVgq/2ByhQTpRtQ48iSnpg4BU4rrltabz2ikAgKHGd1j4BEQaBf9dhn0a99B6mElcalgYbrPEP12ed+3EJOz7cRmpw49MrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZetxWBmcVGh3E3RLVNTKTxjYoQ/Sh4s+m9qsOBEZmIo=;
 b=jsRgsS0GfZnrm1n9AKil0KeJeXDwGV5cno39nGYrRdnblRkhOh2OWIApsOKu+qjcOlHWIfwW0AkzRIU1DB21lDipM9OWPUcDrS04IUae/CekQWp1ZOvf1KM3PMx+lAPngTDOSfbn6UBj7nIyMohteH/X3EH0bDrXS6UJCpy8muL5ZqkSe7t1PZis3byTd6l9E6+tL647yYOjDaow7//Bp2K0QRDbNPcs6Hdotj3LS7ZofXBPnnhqIMGK4ht+il8YlwzDanxBsnRdEYAEajNFWmz3JeckNYVzkcWfgdtLzyztlq4aCW9/sR6m6M46MeZfqFRqZ9/qUscEJY8Jg8JwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZetxWBmcVGh3E3RLVNTKTxjYoQ/Sh4s+m9qsOBEZmIo=;
 b=jXDcEoEEn2X8YOrWL9XPJcALiLnIRVblT9tXHdmPHHHfs4vJyNp+eR+hJyMa83UIZSo5O9f2Zi4ryDwdDT/xt6g9dW7Hz1jSmdnaKdbNH0Fo3IkGVAu8FkvZr8D9+wphTxqKilHe/4iddsZKSdzfY5exl3u1E6OkR1XtzqiTmLBo1+QPwwyu0PmUrqHPNyeP5ntOqFVp8DctIGhqPT6MWpeGpUoHcNggWW/KU8McHEU3bzwV6Dr91nCDUUxXW5y67owxmrpRPItFZs6uW7DtfmhjJn7fvb3uoZd/414zTxz3hw+1Jk+IE5jIzZMD7B58punnHujsXTinjFFOh/KPqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:43:48 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:43:48 +0000
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
Subject: [PATCH v19 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Tue, 14 Nov 2023 12:42:42 +0000
Message-Id: <20231114124255.765473-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: ae91c3f4-1f00-4257-15db-08dbe50f58e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MV3C8wRPkf8fkeKA+XjFzPcNzZbJf57+ErMMMlxHTm54iw0AjorLq4fffTHlrv4jM9hYH+V7o/u79SasfH+hbU32W7pY3COGQEOTmgR5p+iZKew/AaLydoBAO8lGopx4AqEYmCHbyMuMN+j0Pe79nBGcMSW1yEUrJmNRJd+Q6dV3F7xsYcFiPutMTyvHe40R1wEK3GMd9Y4nhJx/z6FBcDDm+w7aaj3XYZaFwPh0uA8vOSkZpIQx24/vvva+kzPBvG+d/lGmAWgqW5BwI+lfYHifoDVQGILkVYw3XnnmdGuB6eJrhh9tvXJC/sQqSlePZJ31PGXMypeXCUWNPaC1T8eETQzdviUkojSsjlWXkDrS1uZwiqjoCm2ntVAl2x3+qQeThapJ2jDwfseGeqC8G9nQbIfXIKD8wfPduvR0V0RZPbSPewa+Z7glDjpcaWHHgDoBoGj9baLwEa98pfbQXYNjJ8WChnyDdC9vguwVr6evAG5BbiFJ8UpEd7S5Xj99qmCktnCLzjoLvAEoiGUyCMxhgFS76t/5h2DIid7K91JgNULhmGxPC9K3XsudDhrg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(86362001)(1076003)(2616005)(2906002)(107886003)(6506007)(6666004)(6512007)(83380400001)(8936002)(8676002)(4326008)(7416002)(41300700001)(5660300002)(6486002)(316002)(478600001)(66946007)(66476007)(66556008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ef+3DP1eLEeDc/VyM+pJXsdGLzrnVtlLX+1BdtVz9kmYqZzhkMCwlDVX6J22?=
 =?us-ascii?Q?O07Vi7gZw46SfDv8mP2FKNxsPHjh++59T3pwWucHXwDYbcHd9pWHxZC2t0jD?=
 =?us-ascii?Q?or0lBCCsfbbT36kI7VXxEpmpBRC/iLXywdQG25s1hGNeBklDQeS8k6Vx0rXz?=
 =?us-ascii?Q?nJQ2bXaymPsv9QULPivsPHQ68n1iLCqvtXS/nF4h9P4WkB9IKiqmKKZB7i5B?=
 =?us-ascii?Q?BBUUNfqCRXExFo6HnmvVBTS+U2AJ9MyC3qyVX4/l/6OsAmTHPT2ybjeoo0zd?=
 =?us-ascii?Q?MYU7YLrHJjcY9CTM7rPWijsfclG5h6jURaoP3EWy1np4xbjoOntcKOkzvouN?=
 =?us-ascii?Q?FAlDEdcGOUOZiHu+36rRvKsfMo+yiRzi2S19oGqCKqi3PoB2lLxwvQb8ez/c?=
 =?us-ascii?Q?XRONlYuItDqj3kjJsKZA7qZgieKYBUutzA/l0I3tGl91XuI3AgQWy4Wm/hMF?=
 =?us-ascii?Q?DktgoV/cuGTZsHXT4jh3hTafHZEJQh+/ogRDW99jF3r3N04b61IQZtHMGnsi?=
 =?us-ascii?Q?c/xD6kpYFrEMtSq/3hcfXZyD3TtUAShUdlvwEYj8N/ZQr0OWgdo/+bmoM+Zx?=
 =?us-ascii?Q?KViukf97KKNRdVgdMMbVTM86JvVmQGcTklogueRZk4U6Vb0cJdj8eK2nymhw?=
 =?us-ascii?Q?XdF2/+TB68UetIOR+3OQNaHK47aGRHFhz2bnjAzKEPl6liRBmzWGJ47DBQw3?=
 =?us-ascii?Q?FDftgLOLSmLnQeTuLXTpby2T0T6geoEGK7zAR6PWLzPfDumKceVWczIw1hgy?=
 =?us-ascii?Q?/0Pv9W8EeoHT4X/OcgTchG660uIHYmPUUQzeX6Qur6XHV/y9ohkb6j8lYfR/?=
 =?us-ascii?Q?GROfXWY1ADG17IqvRIN5fufCCD3kpnFYXlGmnQb2lvlBJn0yFS8TWr9ppL1z?=
 =?us-ascii?Q?pvVTaA4GByJOUgVICuJXotaCCElikOqnGyvCvs7VX/A4SExZOut1UpsQ+fYJ?=
 =?us-ascii?Q?06gRgBryx+QrhjDYYUef9rUlPrkMf4ct7wYlzk83ndjF3XID0RREeq6xQJwF?=
 =?us-ascii?Q?yE8/mA2pJ6byiFT+Grw2e1cS8kilkCb8TykmD0w6pQYW/ucRztGxu61ErR5V?=
 =?us-ascii?Q?PzflIv246YvipTPzHBvvci91+qes37F/T0oPlHrOiFVK5HBIaheLwH3jXy45?=
 =?us-ascii?Q?JOVEoi9uNtDLSFeV+dIQbvbduniUkfWWhsyoPTojOJPdGlIsK+sSv1Yi8PL/?=
 =?us-ascii?Q?AlZgwaeBmyBPMP7D6YL2asY2Ph9gUQqtlCzj7re3olUiYPCoApIrdQJwhNmi?=
 =?us-ascii?Q?5q1PIdlle8m2/AAM336BSS4MSwvf8YaooFg27fS6qunlMOlvlepXqC75mapV?=
 =?us-ascii?Q?I3bv7ufWf8zkhYfg8hxoQZ31LInqpN/sgqmGfKOdVcp20YX2PSNCYgQ4zAwO?=
 =?us-ascii?Q?13prcNXoRaL6Xhlt0mglYnsGShAvySNXqU89G6KUZKOVBb+vwW57IpVBITKc?=
 =?us-ascii?Q?AIvp/l8Gpbvspds8RABUy03iRew03fJ7UP4WVbYqS6ZcxfeRx/TEfxgJDPe2?=
 =?us-ascii?Q?bGnzIj7BjF7X5WR6fClBsGxO9TT7bDR8i4C1EkaLDOPmKyTy3Disp+tXguKG?=
 =?us-ascii?Q?aEc5ty1ifOZU3jx34GO1/wj0ywyU7Q59Qazw6Vf8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae91c3f4-1f00-4257-15db-08dbe50f58e8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:43:48.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CazQcg8SK15CllX+nOQkxQhVwOeI5jZfGKTkqHXnxIhcyRZrAPYxbVdMejUxIbqk8dZexMUNyQ3vV7yDJmBZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

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
index 867d5fac3925..070af94046e7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -234,6 +234,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3182,6 +3183,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3197,6 +3224,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3211,8 +3240,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3220,6 +3260,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


