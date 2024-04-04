Return-Path: <netdev+bounces-84859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C985898805
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6806285FCB
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76796266D4;
	Thu,  4 Apr 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t2ehCbEP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2095.outbound.protection.outlook.com [40.107.93.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCF347A2
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234296; cv=fail; b=pnANNqFrxutzQlNTfsFn/vwYOx/kYfLgAyyOErpR/BBTNiARGbQ6b/SJ5caElBGjhSFTTCOmLecr2OJN6fE1EaXZMJ0UVgpSFcoTlMGaoeyrqbpDI2S77Bukdu+extOrjKF2JYf7Y2NeAL8VOkTT6wT4Pas6sMJRMqX5zdA0TQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234296; c=relaxed/simple;
	bh=opFhL+qDv4gmpElTyxTMg4wW0negrAtXqfJdOq+ItSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q17YN5TtLfOQ6istG25a9gl2dt4SZZdvYue2mXivaRQBejIf55oHNmK/jaLm5BQ12tgHmnupq2cNnVRDdLCVbVcAzDo0xlGk0V6xuHQJHGIDCGNYHPAaWw6kKbmj2m9UlaeHSQsnKF2m715hk0rPaA0JjMXrZEx6E4pvDjTmG78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t2ehCbEP; arc=fail smtp.client-ip=40.107.93.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eufMvYbUQQsqW8wsdE1WyCkKdxW6Ku/wfAtS/tbKO5FfYsdzXXiSWOjVtJ4jkkSjJXbqjS4ZYzJ0QHD3mAvctKbjXlu4pgkKw63LGTiRf12Gdq8yHC8TOuNiwT+sVBhfxpbqQwbX19fUz+TYaaCOgKT3Cz7m/064QkAv5nPvT7aJVgQV6nj58WjMRqV9zEZgy3O0ZbXd8X7qVDmFHV6PEUhg2rqEtF1zXT0fz7HsEGRr4Na422RvbCxiBUTn+xbaz5WkKFH2M/ww+cSss1owf5KqiHdWbwgQjsuSqiExgytz8i/qrN6shvqKbpUf7XyBJrzjGP/Vog5iu1H4pRMFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idK5dh13Hk/5qZoRdb/vmCrGbZcjkJvuNnf3y1/gihs=;
 b=WOaDF4cjWnLI+WLwCS/zktW82lgJKwxiZfNiz2kLGTcLNbXjNTMIxeCJsYM7PostKiEkUfYHm2na+XCFfNrVafemDs33H8rW50bNFt/5Gzv92+Yb4vWKIQpdvjZNJbRTNjdJFPrQv2jH/IzKkrIn2duV4JtpJN5eM2jUERiwsJjvdiL2DcEn0uGm6MqIp6UhkMWjT5BXSX+VqEkzwSBhg0ZYY3FB3YQgQOWY9EABlv5lNkW8e+6IXU3J6LtqO4A/EZtXn5QXS9amrLISN52idTvW/uPlUwZyZZpWASvSsG9cfAqNiKtjKYM8GWzerWaiI9jHysAepMI689Gq4S4ksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idK5dh13Hk/5qZoRdb/vmCrGbZcjkJvuNnf3y1/gihs=;
 b=t2ehCbEP0xkHX8zyoT110nQgKSw0LNV5azUvJkda7ng4Bls6sLiL2wClrtX4VtqARFTvj3cMmSz8/VjS4cK/Qxq52/MfH1E8rznJ0EbgqPAD58YZPopT5V5/CNNSShBQ+6qC/sOqm4BA8x80C/61JFqOfgYiR8wabl717Ho5pm/RcnfH6uYDhZcCxtYA60jyuoKSTA5BJrEsdFwebhrPFHL4a/A+uFtC2Ao0bt/L1UHz7AmoaionpvjJ2WNB+lFIIc35Jsr142zp8XoSYz9Y47qeTOz9cJp7zFrXwDorO2IarC4r6+morCslpOdeXi37cE0u+JBxmMTkVAatplQZbA==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:11 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:11 +0000
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
Subject: [PATCH v24 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Thu,  4 Apr 2024 12:37:05 +0000
Message-Id: <20240404123717.11857-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VpWYkQRmEOWIZIdQtSAogHLqac0VytSECdUrt5uXFWLsihgijkx952+dwn3zIfrOLRPTcV98bRjFMyHbUGVoJkSzNPQQsxnf/npjub+irFTk4TOqfhl+/L1d3ovlxDeG1AGfPWuwYf5fQ8gcdP82HAN1HmWNJCm1Svpn1zwLdA1nsjOBXoWR3qPlDv0o7L/6fzlrJ0aTmVqFQpmx+X5UpQ3QIcbHqiBoG63oHuZdZBUj+1nxZehMevNAB+QeADSoc6GDMDGyun9O7s5nwrTUbiHUUHYNcIEknkALlJ+BzLtQjEMnt/XO52Ak+JtCaaWrUtwv7BBm85IyfAIi9pPz81FECgn51n+1FCFp8z6Fh5nUpqgZBG4iVtU+wnh5NPmxad63QYUzhxCfRk2+zGzycT/XokVanUBDJpDBVKTA/trk6CyBA/VzztPu4GGfgPSXoKXCBow2UDz0bUXckbCZBvgvUcAhEZ8YN4fuICOMTXhEuLslnhYsaDm9GF5NP9y1nkG1JHRs0FHzERIdjMEZ03+J+Ahzjrma6JlHJD5S9+lRUnzzC5HLCPRMePE7ajrnXLZ+3gq2lSWxKnJPbLBaSZSt67GzKSjL483Fswv58W2lvL30UOYmZ3tRQPtKgB9MdG5/IvI3S3rIKz7cmgZSse4cpIe7GsR28+8v00RbWqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ocMzeRPCH6LKiRbMBGi6tkY0N9ZVMjSRo7x1PdJf1Htdfyt7DChl6Qt1Pcwj?=
 =?us-ascii?Q?PRIzp0KNY6wY/3ZDvRrc+AhfahmUhWTiMNDNpyTaqAnJpqKclpBnxgQOgKa/?=
 =?us-ascii?Q?UxYl875B4bakRmDN7lef4uUkyUoKovMIyV/VYv5tQBOfcORHsUCFUhMW2ikH?=
 =?us-ascii?Q?UFUK0jNiCpy22Vmj194KM/bNbLb2c9KFKzuJI231eL5rfGOIfJmYLkbz6c8V?=
 =?us-ascii?Q?haD2Ul+16CWf+Av3M3/SBShI/PSKykzEfKLAv+lkUcBMfLqxA4d3lly3lBbd?=
 =?us-ascii?Q?mBiuuSNGTl1nAY13Rd0V6RhqHPw4ntL/YKNGmIjhKyDq/a3X03zM7u5WONl5?=
 =?us-ascii?Q?6XVoXi9BdJkfsGr9ORnhBfVp8MwuzAOMPhvPHD84wmbDx8dxx0w2kl1RKf8f?=
 =?us-ascii?Q?XKFQ499f56+ceKGZ0FkhmyW6ylAgWJHiB6hRFAzw5Kl5mwXWtuswqeweWgu6?=
 =?us-ascii?Q?VXAV2RYCjYW3M2Wcfs+tCZMS8Ha3fh8CoOdlSX25Wl4hEpfFoSm02c8g5KRF?=
 =?us-ascii?Q?dqsbe/lODw0k85VP5+Fevi3VkoAsez3VZrko1YBfwHkG+IbTygOB1vLLCQ8+?=
 =?us-ascii?Q?HOuCfbzv6ii/xbZY4tyHkBBmxWldhfNGNyAB6nxjKtBuCKDejPeQuPJ6geuJ?=
 =?us-ascii?Q?dNYLW0q06QAl///n+9GGnovUGqWNWstoWFxbdtvjrs6c0bdMVHUYYksnxC+g?=
 =?us-ascii?Q?c19Bb1ZUksrEIPMM9rslLKOjUuMjlLyRYTy+fFdFn13isMwFOaurjD73WRPJ?=
 =?us-ascii?Q?c0tJps4LRfbE3twNlj9wr/0YToHh8oY1p5P7I8JAfNFzz23dnod47HBOM2a2?=
 =?us-ascii?Q?2ARwFp0sjQpfObpPUs2/8xAbyufz7VQ+W2wj8Y8xa6TOeqaWGJ6IFuBSBIhk?=
 =?us-ascii?Q?Rg+FP/Y0ZEDLrEk2rF/F16ZkABN6Ycw3e0Sq859SxeHSQoAMc2hOp/kJGRjN?=
 =?us-ascii?Q?umot0wMPgamu1s5DUoRplhfFz0Qd0XDY/pE3FDPfh+NJ5yZB0GtkDuwJCLHb?=
 =?us-ascii?Q?ha2pWfqOapg3z8FMLRtqAC5RGlNG6WQGUmMDwghY0Sj+OxSLgZQOPGw8LhVm?=
 =?us-ascii?Q?DrXkeGvrbye/vKCL4MdanwcV3rN0fGN3Xfqc50RbI8Kf1+3z/c+JVeRtCIQu?=
 =?us-ascii?Q?f0+yb74d7/diWslwG9dldy+vkmTuOR4UfIHznpXHAcvSLsos3UabvYFnZrUn?=
 =?us-ascii?Q?RO5KRbfUsHH/za4xoBp4IQ82E4vs1Ni/Gj68EYZDH7Jz8NnJ4zrcn+7nl11n?=
 =?us-ascii?Q?vFkeAS5HK+lCfpfGahrHlTJVAJ5HNqp/gyvw02nUYeGW/NkCK/FnFkhER9BO?=
 =?us-ascii?Q?t7kdfJYrkLi+FQ5QuG5sa+aOeL2++iuYF+YEcLOgT87NP8mgKCHlWqzwPYRV?=
 =?us-ascii?Q?BViHote02bwn4LVqoYctxVFs2yfxmu84kwFEclm/Sdg4wCmGcQCRu586yiDK?=
 =?us-ascii?Q?SwDyCICW9FD5CUYVftxI2GLROy/2Pf3Ulre0Ty3w0t2k6qaIdsO6Z7qXjfw3?=
 =?us-ascii?Q?SsMIngJ9LwwXu97V3hniGaDzt4TmN901hLpvy5Y3FIoh69At/tusJ7bv4yTq?=
 =?us-ascii?Q?/QRNehOwg4jkrl/th2w2GncC+4alKIzEquaNS96n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3b1ead-63b8-44ab-320a-08dc54a416de
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:11.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe5nbYYPtNbCAbSmOYl5ElZewXXChW/UOWQ0vOs60xhlYcID/0sFdCVNrUL7zDDgsa4cHPlMhzz2PpcBTK4jzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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
 drivers/nvme/host/tcp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c9b307137569..723c292dea07 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -242,6 +242,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3231,6 +3232,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3247,6 +3274,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3264,8 +3292,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3273,6 +3312,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


