Return-Path: <netdev+bounces-75716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E586AFA1
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C361C24B8A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59C14AD3B;
	Wed, 28 Feb 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuxvakRZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2814AD07
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125114; cv=fail; b=rTzFUCje7mb0TrSSdv6tnlslCSnn3B44rupvuaN1XDuzSw5Usghw2mWn9wS6NX6LwrGtZRCpETssnbMQaPgOm8fVgC3x/2aSbtiXz2UWCl6hstB5Ow2jvsHKuM+X5SRLmF5VbBnjDGSyx4OVl8fax5bzcHTqrkHKXnkQ35L1QQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125114; c=relaxed/simple;
	bh=UIhyrw0Jhxy1VMiqqHbkQPD36zev1eOqTuR9cVQLXic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqAMl79SP0Iq9vzKi/4rm3DVoDssSR1tVrS5DiwIjUBOzOwckSuImbKCw0lh9cRhZsMAXQuyrW3YxRRcuFZUL2iae3RwpV/L/Xy4Eals9MiLAHCQUz0gf+My73IpigyzowvNHT52ZEAe0LOxhPjHqCDARfbLCHoA+TVdkDeLePw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuxvakRZ; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqYKJemmbTDJ3qd2McFuiNNJQNJC6KYPhELp4iRcnY1EPdcwdy/Cid4ZkqstVjNFH1siYvaeuRkiALubU2x48CRyterwoiYUGut92/+cOpZMvsFY6SSoSmcPr598kNuHJeLiGrUn1LCojL7jAlAC+iJqHQ/jPL+XyyCWFi3jHh7Rq++NVEasZ6dp7Z7pkb+Hz3Dcd1MnGGpSNurzICxKofSeiK+9i3FFU1Cd/NvCXDR7ac4T7n4vkIxQkISFyPXXhG6AkznwPw2kRRhTXe9Bw1sxFPp1FVehQCi1FAjOS3eM37qALyFgg8BUo0e+Pi1TsNqZ5gvcmmfpBAruKHXKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOyesJ4qaII7YLOMCFPJsgmod+GLx8e/QcK9Ea0HJdI=;
 b=eURK8PUn/eTZGSYQc1+XXo61hJHfCjlD6vLcJ8tORZfIC6vlrbL2PtSvQnuY45xQDw8gSi/zGDGslJuDo2uVTlFM7wlW4XqCq+h73RT4nsG/A0grWfY6NrPXEG1QREqCUe1rGFrVDUySwuVnaYvrUg/Ni+YKevnAEYOB34hJNuluMDHD97UC4oAbqMj8a0M94ICrGk7z7eQ14Y7NCm7G6WwROglUAHPIWidf9flsSHzATDmFqxITa2GNJAE7FHmqO0Ieb6itjAYBicuOkPa01fzSL2O2f5XU1qX8k+LH92SkNguu0Nx23v3L/BVegQ8xdXauc2QW4FGn2VwUXnpydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOyesJ4qaII7YLOMCFPJsgmod+GLx8e/QcK9Ea0HJdI=;
 b=QuxvakRZKudeZv5dkDau8YkmXvE12GCJ72H2Kyb9vHtT/HPN+gckvpVwkthF9As2kxycvhk0jWlx1jz0PprfFmkq2oBYJ0KrG5PIOsC6XVTtsMSkimyILSX683rRLLDCxpKyPIX+5m3TWsAVkFp319La9EfqvHc/Bve/CYxfoDBI+zrTf20JWohy0OLDEdWFr1zeAu2GyUZPxaP4aamJF2yhonHyeOhUqTDupqPn8INqlJazMTeO8plfjMMWhm6g6INKxYVi/Qwdw7IoKxAkKUzVliKOod+uCy9jSc9NOv6RIb2W5MXmQdFSgqLkwk4lRjgGFhyNshV0xjp+YMqxlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:58:30 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:30 +0000
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
Subject: [PATCH v23 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Wed, 28 Feb 2024 12:57:21 +0000
Message-Id: <20240228125733.299384-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 395f646a-66ea-4388-1961-08dc385cf62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ig+HhKvonF+4OM8m6uLuuA6NiM7UL/F0UoIrX8Tq9YEtYqCEppT9e8Zbj2CZu8vg1biO9Fowgn9GkeqZzBCoIeYirSKLLEdPOg03TvW88o28Rb3lcdCP+Ah6ODbo2EpgLt6C6cr3K7R/dcBbA6YWAHjeKZqeIr0cC9hvEbOhEYlL1lv0rCLAlA++9ohpuORruScSPv9B4aB/6r3ihdFMc/lpaUUJ4IQwEuQlxoy/5ySBOifUcTL8ohWc9kvKUUJRROhwbShUgm3J7GTM5IrLkuPdlWh9IxYyj+u6SDXn6Je3vzNa1iQP7T2M3b3uzjjVCIz7L3rb2uLubalbm+flQAtskNlAuVDa4k25mUGwfZWu4p+TxsBeosBHfw3mrfzyB/vBe46YJpvuJWdAv3MJEokSZzyoIphoSzSgfduuTsiVOMv3TKJ4UKnVaAvBA5tGuY4noLmbXSvOssYZPDzmkMdYP7ij8ezhzsinCji4wbQy6nFV7BJP8t5KBNPSTUkzAj46X3LPXB2kB8YVToRks1JD78gIkN3c0GoRchpMrfcP40CGXBfgQllDcTxVSIvebgNUOQO6mP5+VUaryJL0oueeawMCZ3qbz0F/6dQthPwwT4i9S0RM1851BHkUaTpt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siPwP3EYUmPg8Jtho8DB4f/B8/AWe7xV8RADRotXk1gnkrsiSQm+zbSpbjZp?=
 =?us-ascii?Q?+LYuO63IB4x+J1XIpE0KMz5oy3/T+7G7oHWHdcGNEtbR+re2l7sDPmamWVC8?=
 =?us-ascii?Q?+MOfwFu2evrJpF6JOVNYoF1rOe80cBnouo79QQOrOWFKegcPFmwUXgltrF0f?=
 =?us-ascii?Q?HbXBQ3f4dCjCXpfeikqX2c2TJ8J2ytmetvUB3N0w0J/VGwPGI2t73lzOggbQ?=
 =?us-ascii?Q?T6IMJANS/oPKQzqnyQfnepy9znBWkAZ3OmoB4V43jOlX4AlkujmgDneTT+2h?=
 =?us-ascii?Q?dHmIbI7plp5EfNwYHiXxoBIyk2EpChPrYIZrk0sE+k40VAiin6YWU58DuyxR?=
 =?us-ascii?Q?EfzULrqlohYQDrA3IaX2Gy4da/ryNmTsdZ5OtKRys+Hql5jmc7mExW9yKK4p?=
 =?us-ascii?Q?538t7YB/IAeE2YlOzPujsiBm4NPk4P614SZx1BWDgFTxtCslW4Y2+mnXxIVD?=
 =?us-ascii?Q?BPT88aimpH6W18cSbIPJXJfpd16Ra/NyH3WTgRGqyVmMiU8hj32rjads4yPX?=
 =?us-ascii?Q?x9m+Rmj9fTrL2KCsmyPwClSDqTBkyzaqAumtvUX3WRkfjGfHdj935HM4vTiM?=
 =?us-ascii?Q?ZduWZQ0I0q1EqXgKc+5tmJjSlKfUoS67Ejc0ZnIyKnB6e/4QLO5J9v4ZhE+S?=
 =?us-ascii?Q?lzpeCl6NHucRTFCiLrUtw2TFHrFpx/uWhNP5DC4QFcx+yccoKxfiliptPFWi?=
 =?us-ascii?Q?nZ/AbMowb533s9VnerrZ728aOqYllej4gtrx0RiewppW1X3EeKFDYRTXqoQy?=
 =?us-ascii?Q?AVYpYN2zcdY4MriipFwhqw2eAFwWNZEOZwj3AprcbNWChxBwJ6F1lrLwC+HA?=
 =?us-ascii?Q?bkOxmSkcl+QjN8vxbXD0T/GNBU7WbzASGyUvXpzdEE2Ke6CBvZ2keVpqtF7d?=
 =?us-ascii?Q?XByggTV76fK2Xm3ltgZX9ziIOEiiDn8CSeBmbpC7F6NxJU2EaD6raKLDx0cR?=
 =?us-ascii?Q?FOL1yXDYJ25g+aLWzQ/CpMSx4nNUb7u77UFy/zl6PRwhvqczaR37Dt6nqcNk?=
 =?us-ascii?Q?9yFZca1ZdM0NNr+nGs2OlSU/X7Pzz1XJYMQ/mkHUGKrOBEBAiqlBd6RCRi5K?=
 =?us-ascii?Q?vWoYlx2bd9lChF3zb6v6pnyCv4/NsgK/FLybi6IxLLYT9ogxBT21cS1sSXSX?=
 =?us-ascii?Q?AL//Y3m7Wx0kxvkD+BxxVH4fWIzx/QGvTqJzmo99HjhFXwH2Upg7PwmLPlER?=
 =?us-ascii?Q?0Q1gGy+KthH2/tdLvUCJLC1MYD20Q3DOlmVfzp6saaA/J8iVrq2aEl4lroFU?=
 =?us-ascii?Q?Ri3MvVqAzVu4oRhWsAGjvkCIM7UotBlC4fkwWYMT7B/tnzGe9ke+r94QSx8k?=
 =?us-ascii?Q?oCIS5WJYQJ7qrqgzFnSz2zbRq3zP6dYXc/TAvGe/dKBJ1kc1DfTtb8D3GleX?=
 =?us-ascii?Q?3+sbHBntPA9rB8Uag7ZB+jW6JxaU9488QR10uiooysSSbluPbjfE9LJRj67b?=
 =?us-ascii?Q?70PjkbqrdXdfdqcEaVJfAmmhE9s1j/eu6nB+QZD3OEjnLT6bobEX9+VNWUcx?=
 =?us-ascii?Q?lWN4cW0wlXCqqxhUHRBCPkagZEE/495enkF/3CQ3a3Y/P5IFtMgxhkq1sNkv?=
 =?us-ascii?Q?SX/2m08n9BaQyJU9nRh/4AJNvgLKR9E4F7TnLiNE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395f646a-66ea-4388-1961-08dc385cf62b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:29.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNfreosOBuFwqPSuKqMiDGFxC/3SYXNdHJqAlzOaWaveB55E+7SEfk97+VjRw2fAYZIKj9pP4yLXX6HeqVFA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

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
index 2eebd9d2aee5..115c14398c2c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -235,6 +235,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3225,6 +3226,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int nvme_tcp_netdev_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+#ifdef CONFIG_ULP_DDP
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct nvme_tcp_ctrl *ctrl;
+
+	if (event != NETDEV_GOING_DOWN)
+		return NOTIFY_DONE;
+
+	mutex_lock(&nvme_tcp_ctrl_mutex);
+	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+		if (ndev == ctrl->ddp_netdev)
+			nvme_tcp_error_recovery(&ctrl->ctrl);
+	}
+	mutex_unlock(&nvme_tcp_ctrl_mutex);
+	flush_workqueue(nvme_reset_wq);
+	/*
+	 * The associated controllers teardown has completed,
+	 * ddp contexts were also torn down so we should be
+	 * safe to continue...
+	 */
+#endif
+	return NOTIFY_DONE;
+}
+
 static struct nvmf_transport_ops nvme_tcp_transport = {
 	.name		= "tcp",
 	.module		= THIS_MODULE,
@@ -3240,6 +3267,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3254,8 +3283,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3263,6 +3303,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


