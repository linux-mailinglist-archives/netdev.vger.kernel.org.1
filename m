Return-Path: <netdev+bounces-171151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE8A4BB3C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B46F7A4853
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41D1F1313;
	Mon,  3 Mar 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MqJb8gng"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D91F151A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995638; cv=fail; b=kKnHNg/2E/I03lqJ541BZ4fuqXX2jRwu6UqoZyitK1DP+LWO43+2WJiJwOlySvngq+Yfwm/+1+aXid9yuskHZR62jSpLHP6JyG7NFtgpDFd2K7bcZuMxTeTm0qTopzp0eyIosb0ipd0hoSBhtD+H9LMiN/Odyyj5XK7jfidTq54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995638; c=relaxed/simple;
	bh=//NjZxEfGH7rXpIrO9ryriPAcgGtmHT1nkFfHZYIBDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kekdmNL4PCVJuz+CzJXQr3MIrYQwyDsbS9T/sHfJQajKCK43FxyuUqlasnfZPlMScR7UOlwUwSrQ6SYOirLGU8har/yXV8s5I43p0vEYQPxwo/nuZlj/iBUYbWnn6tSe5XrmCFunQoE2b0CJcp7WSIw7hgizNrfjOMm/U6zAw6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MqJb8gng; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3cEvo4b14/8cJ/dAS/wgJSuJXeuOs1J3aTCJiCCKO5iznPJ3pvOBm5uJ/wIaD4i+jBEUZUWpFZm/PrJx/g3vGlkr/VkWiTFu03Vcz8U8EMptY6uAFBftzj9KQGLXx4uxug0SrqIMG1RcAlHotYuhY5smrI6YBqIBqNywZBB7vqGqlac3ObTgLc8T6beXAeRPcS86rcwf0m/BOdlDh6wr/k3+NKDAqW/3gLFpFXoa3ayxyZ3i6V/kL5/vB5f1wmASQBJ8XS8W4g8AGtj434mGppKU4Wm92G1wsgDQfOuW7OuoD3aWWc1DsV52B3HserhSmqbsmHs54Gh0m5ka5jSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxqr2zGrzwF0qJJCcFn3YKOHpZzWSknzmt37coLGmjQ=;
 b=mtKipJzEggRcP/G/aXdoO3P1II3se7E0YHtvJyl28BhrN8Fz3hAWCwC+U3bievt7UCU1vSOMRplijLRauVxqUxhgJnll7lqtgzmuFpLcDslw5aM6opNzYuAzuOLwF76eEyWKEPfWajAJWpQAM6RZE1c8s/uiyc6j2LgtrRFDR3OfDJn6upHw9NokkQqrv9r92Xr/oJNk+Jri/5lqItOfbub4FkxYeNEXzo/JbDlYUqazDgC+fpHwKeh/VMqHkSO8kDMXuQL/hl/lssDc/QOnDp7lwNAze+GXo2c9WMiF478zciyzuBJbqIK1KkjOTkqLqDpddOBZ6HnjLDghEFPKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxqr2zGrzwF0qJJCcFn3YKOHpZzWSknzmt37coLGmjQ=;
 b=MqJb8gngWcRzacg4Qo+B26GmCjxBpsSXiNezCzhaw5UxqE/5m58rbHJgip0L7VvrPciIZDqts9Xf4Lsa3g9I315WABpfJH4IqkQi29nF1UsP46UxgOD8yBd0UA+fBa4LXYptDW0SCxaJWWd/rLwRCoy+TxwP7PKhtqrEQ5KiqXuLDVcintnknkQ0pTNhQc+y6r01PyOW6q3EDJvihE/Nz8GPHAmZAOlIXvHFfBzFZV5LPDrd11Bspo/JUAn3OarOpggm2shLBUh05OmsZkzLexMdKDEordR/PxIFSdk+GnqPkn/w738eqCTHNZYRcmXkZXrNAWglaYfip4i70VaQaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:54 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:54 +0000
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
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Mon,  3 Mar 2025 09:52:52 +0000
Message-Id: <20250303095304.1534-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::27)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: d26225d9-71c2-4358-5d2d-08dd5a394ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbSCKPd/SyXh6EHtDTkrjsizjUyzWssG1PyJ5Ygk/gVB7JxvshKQcpfB5oHN?=
 =?us-ascii?Q?gVT6on3QxZP3F/p53p31ydgs5d4lvkdHyn2eEyElbxEIPRFtQFxePakJhRBL?=
 =?us-ascii?Q?xufxKwOgkXVyJmvq0OECkJ2fAe7pb6aItY7S7FFy8yOopF6CI3BQiVQ2+bBN?=
 =?us-ascii?Q?NQLw3Ob2qFRKLgOw1WIsNQcC2DFlKOIHqIauTIstyt1YK5feWaCNooU6XVIL?=
 =?us-ascii?Q?Lq3RV8Yj2xHWppGVdujLgda3tw6OOKwEULHT+Hjtri8RKVZAsg9cwMNEILZu?=
 =?us-ascii?Q?s2/ZwgXyDRuvL0tpZlpr1EwShPzCaTx1GUZ3qpROBGDYjsYxrZ0fi+7gTnT9?=
 =?us-ascii?Q?xgQHEQaoTabkgSf99T9yLsivXbdEanpxK9xYS19UKeWYZyuSGumCEHeKLA5v?=
 =?us-ascii?Q?RRPrC8F4pyM9s8PVslZ4ZIAxPdNj6vt95BFLrTL+aDuuJT1/Ym/nMNjq4O9V?=
 =?us-ascii?Q?5QaogFHwzhXx9oF5rwAsDWVv2o8ZTL/NAFyHn0tM8Jl5TXITvyBi4rIbA5AY?=
 =?us-ascii?Q?sIKPbKmRKs96xK2mefdxJ6BMgy/iZtlHg9skWTNUZlo2v6GhlZndM+QGVIpl?=
 =?us-ascii?Q?se075/KJQVaaByc/s86tieMcaqGZvDRp9AioeCyDt3TQUsQ7RhLvZyP4N6yV?=
 =?us-ascii?Q?fHOvVpXzlLSqWRNxd2rhk9y4r3RgJXTuVvKJn+JY0J2TGMsWnmPFF6xyIgEO?=
 =?us-ascii?Q?f+hPMOGP4cAOeYuPekvhDTRu6rLHCHBwKglABapUdUQKHIkhnNJz38TANbMF?=
 =?us-ascii?Q?arN82/zfhi94P7w/MqJgWs541LTnMJ8UB7IzTj5HKDDFD5PoHcseW4pKj+YH?=
 =?us-ascii?Q?fVyllCsGo428/3xRPNSMN68maEb3BMQ+FPO8aSvJyAlyGDr08Cx4bHrEHIzJ?=
 =?us-ascii?Q?RhM/qoUjUwyTu5rtXQ7yKah0bUfc41Nf7jl8WyrrB5JkDHdwEL4/E/lSna3z?=
 =?us-ascii?Q?C4oDLWm0XYBqu5FxitrU3hppSlqNRtMG9HQibzuDrYUAkVCLhtJ2I2vjsElK?=
 =?us-ascii?Q?3j5PpXrQhgzdDh2Ebgs+HGDzpzpgFm3Wh6uMEMpuDlb1dgilWo62wQmYUclN?=
 =?us-ascii?Q?Dp50uKUe9ejWPLAnqAQ5FuWr/cPWAO1YXcexVJHehO3B8HJfmfHPvbAjZETU?=
 =?us-ascii?Q?KC7Xc+k6snq3PDUT4yMi+OrKi8sP05yjtkDcEqqb+juP2xUUcJuV+E97QAjP?=
 =?us-ascii?Q?xPRYLVi+WYt9NRHLL+cYJyxJKj4YQ3Rgrqu0kDoPoWFIT431KlZhmcMBw641?=
 =?us-ascii?Q?rXNifLXlPAWmqnhaY74rqXew5riQB6pmiUFUjKNf+pBDBOOOi2jfJcBhFnu+?=
 =?us-ascii?Q?/jer1gluuwWzchmu9E2YkPlEqdtEITygR6Rm/ezp0TaOQ+N5IXlyD7driokZ?=
 =?us-ascii?Q?Nv7M5v1QF/nP/1wUJZqQg4/3/w5f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i610srPzc1F6lgLl7HFL81c0seIjbBvX+6ph8CWv4tnW+pu+fEJpfwFthIDD?=
 =?us-ascii?Q?9Okd+vpzdA5nyrjTg8laUvbF5W1M1wdYEqr1DwCBREz1EilxFPKNdA+xZHPZ?=
 =?us-ascii?Q?AD3i/GVW3aFoVsDe3mEMmKrgqdNMeqWjZt5wwZNipKL+6fHRja9fJheD0Xq1?=
 =?us-ascii?Q?Wj2kvUrqbt50mFlaV8o6V+Eb9tl0V+xO2toKmOnOXBBlSyrPu8T6N+EjRHVm?=
 =?us-ascii?Q?94cPZ8XW+daXJ1wsztl/kcHSZqvYeo6Go0hRWVtb7EQQpRBPK8FDnzptYorb?=
 =?us-ascii?Q?SjGmdXH4BKCSM051GHhkLgykRjPivFQcSwTrtHPaJlTQXS+pJQrEk/3f3g3i?=
 =?us-ascii?Q?U7dxuOMBeQy4nTwBsZcXvqKLQhZzt+ab60qBXJeyjc034XbjGxhDvc0Roeex?=
 =?us-ascii?Q?eQOzWdqjGt1cDgcxj9jiozEALekJ9auy3IbuEAtJQFCb/+rtv3lR2Fo+SAM5?=
 =?us-ascii?Q?tuxNSvQVfJFDE1ZdJCn/hMoCpIMZDtA7ZK+J7s6ZkM3EGPk3MDk99JKiauvK?=
 =?us-ascii?Q?H7PBtN/XJc1Teh9zgFmDzXOvlA4k6to+ER9PprEqmypBxmtYGoxCHZGStax3?=
 =?us-ascii?Q?+GJBz397JFUzwja8UtaNks3rBxEK/MKg1Nn73qfSx/SxOdw2/bro3jajZcdG?=
 =?us-ascii?Q?v6cggPVMdcEOjAKoVVq9vlOSZt10kyNMkkkD6cNM/y9orMDqu+SlD39GlNP1?=
 =?us-ascii?Q?xHA3fMeSu2sn/9Kc6RbBi3nZFFJVIJ0jeJ+30+pua8YVycBsC7kglxfH32P8?=
 =?us-ascii?Q?U2FdKCQStBjQC/kRV9pAV2hkkhyOWRnUonFSzIC0iPFNISOeluEU/8N/xaE1?=
 =?us-ascii?Q?RqDShGMt8GAutqJOnYrdiUbqdaZb0nRct1Gs/abLjRpNdULSAgysc5eQcByD?=
 =?us-ascii?Q?vkFJQm8T4z89pII7EpwE8p6n5KFBJCIROIDxMeLzGnTBMCFQWUx18Ru4QmIQ?=
 =?us-ascii?Q?X5uR9ralxgr8twJ19GIqxljKp/q5jpNfs8tWNczljJy4HdhbvLhhfWDgOhF5?=
 =?us-ascii?Q?Put+S31Orw+svBRSshQ6JOsmN4ZOCyCrcDmSyQxTRqjcd5cOesORpgBfza33?=
 =?us-ascii?Q?SUNTeBiW881ucizjLCCm3xrRJG/ersD8GlZH3TC794ACnb5h6JmkGrKs5rgI?=
 =?us-ascii?Q?CMeuU9s3lXYjsO98D+SzuOS3iRq5L69dOxfMsKbzZP6dnfpmj6QB1VXNdhBv?=
 =?us-ascii?Q?8lRGPPpTwDXtxxuY14Pv1/veCWkw8pZrk81P3Lxe3SA8seYzJ9DYFQRgYtgu?=
 =?us-ascii?Q?sl/KJYUsNBM8XWrjQs2NVu7PKyLtMqiQI9mRQrJbw0fGz1DFdplGjxayRoG/?=
 =?us-ascii?Q?4lao8aD5kfTaU2zsH9wAdMZogjRaoOeqfh5lDCLHknf8VQGK5NXMzEEpDx2G?=
 =?us-ascii?Q?goHkrMGNHxn4+bzpQ8aWGYP/+VuPoFvqKijTBGmLxj7eH+fLHA2LtnsE5m+J?=
 =?us-ascii?Q?7lqwFWweYY79NBzU42dg0aekWiC/mRllBYC/mfInS7UsRAC9gUW8u41oku+q?=
 =?us-ascii?Q?L2vmyHF/fydW0qi62lUM1xAZCyg954q1yPLl4zbMzW3XeP0EgXJcjuyN1+du?=
 =?us-ascii?Q?+eNymKN2XeW54J7IYEDt3d21CkrbtOWNSUyDlNoF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26225d9-71c2-4358-5d2d-08dd5a394ed3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:54.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCkcLb8nqNKlQARRul/fr2B6gr+tlcWeUFwEfTCMT65pYYwOZQ7BjaYFc4VBF1DYsU/TDyXFkmss02w8UcRxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

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
 drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c978034774c9..ed02397b9a43 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -247,6 +247,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3328,6 +3329,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3345,6 +3372,7 @@ static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int cpu;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3364,9 +3392,19 @@ static int __init nvme_tcp_init_module(void)
 
 	for_each_possible_cpu(cpu)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+	nvme_tcp_netdevice_nb.notifier_call = nvme_tcp_netdev_event;
+	ret = register_netdevice_notifier(&nvme_tcp_netdevice_nb);
+	if (ret) {
+		pr_err("failed to register netdev notifier\n");
+		goto out_free_workqueue;
+	}
 
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
+
+out_free_workqueue:
+	destroy_workqueue(nvme_tcp_wq);
+	return ret;
 }
 
 static void __exit nvme_tcp_cleanup_module(void)
@@ -3374,6 +3412,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


