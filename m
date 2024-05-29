Return-Path: <netdev+bounces-99100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42158D3BAA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E560B28B38
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485C18734A;
	Wed, 29 May 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PK0Za9/J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7818733F
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998509; cv=fail; b=soxl6iO36Bwl4LUkij6K/+gz1N+lv1r/snVDM50lTCU3NIle0nbxd7Vz8T426kSaP5TrLfbbzwf/eflhv6ylm6uEsLmV9vFFTnOqLiqZVaeKnXVhWDe+digXRNw77JIReSNu6hXHmBJ63psBM2nddxJ4t85mOeT5oC4o+N/eW8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998509; c=relaxed/simple;
	bh=oqNdXkWdY5vt6vsTbQQHUdNYo4QRkenCkiq+kJVQgPI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DaZo+jpgYajSkTH3lUsw9xtLO5Q5RTljIZ5tEmU5/h0CUQXaMA3ymoLR5oN5aXUZEegao/yE2SRrQteK7Oaj/5YjtN1awbOEOMknBxUxskC8l6LPyczvevVnHKNeHlEetKRs5ZQCMh3Uk6OpSXBq9TIjgDQ0w1iRIbQj004Wv7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PK0Za9/J; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMvuBPjj9V9nVxkvnKIZ8fMPKpZ7qPXLg8f+br2NLCXsE0MWUuNiIvqE4H93VOyDRie2TqZWh+ENWIzfWHzP5UhRmIKoUBH/7f/DCCXSJQjv8IYC/v+MKplat9q9JPvXJXGjUOQZO481BDBIIanCnT6s8ppruNTytLdGR5iANsMlA5cCFAwfTUf4519DejnTAdCzLNKYEnkVr0VGudJ4Pa/kAqnwTKyZvZDXMoKJFmXXzIJUo53p9vvdfzkq0UtIGIPwvPXmbeC2aeJg5JV8E0DgTLzjM0weZQfqIc4lOPqW1Ig8DtP6kSX06SRt0OYD5w0vH8YEuN+QhCcr/AJdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0DhXTzTeCsptnlxT0emE07XY17YHik1R5jchsbbFnc=;
 b=floYvv0s+Br8+tuP3hqghtsBYmw9ERblxRvqtOYFxTjuYNyIX2Vs15Nobdx3yg0w0viZ82t65ZlSLepH/+Ulb3wjc3E+gTEhz6lWu0yQhAvIxZAwUzTIiQ13ePlRMVxrjlwqH0+7+JSrCRcf8Hjbnz+mPPVEjvd5NMZJrPBYJFx20EiW80nTysl7jSod4/FKmws5QAYOV1h55fbaf2MUBZl8LWC+Msy717xwt0Nl/Eka5bFp1WFZv7NEPDK+yVt363y0tTMOClsmNd4cdc8oVTL7ubq40MOdoKTEWVjQga488WPiFSnSxESRTgdGQdn1HRezbdBxa+iFJO+MresT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0DhXTzTeCsptnlxT0emE07XY17YHik1R5jchsbbFnc=;
 b=PK0Za9/JDcERE3M/DWqDDOCdasTT9gh1V0yUbLmZyrHd4EoWTHdzdU52Igk51gVzmPBr2ufpcv9wOKJsXkdpuwJRCKVjINzUY6g57rhg5K7mDPXS+FeFn8oDzRkXJsWcguMGx37dzBq1e14rxZT8IF9r2I+rxe+SZpM7C6+l6mvARRIemx6YksFhVMTN73LrjHyXk8Ynj/O0VrEC6EpBrIPpvJrryLapL5UjkJxUQ48wled1K7Zxn9TaDD4M15ZWW0rCQRfZ4oSo7ELpA6XRGvT8HO2FmhlIduyX2bwApytlWqPs5ix7Oe3qB8xSEKYSJdel46/9NCS8vNTYB95oBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:44 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:43 +0000
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
Subject: [PATCH v25 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Wed, 29 May 2024 16:00:41 +0000
Message-Id: <20240529160053.111531-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2ae340-4c67-4fc4-7460-08dc7ff8a2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CupausPo4b+26DVeIP5EEXqy9FzeGDCXtycUvsjndbsh9jhpgaEGYIrfLcw6?=
 =?us-ascii?Q?OlysRSGxfey6PEE/qdrPfL0Gp+INJwQ2+wz8y1X7+nngvUReruJjiDz2aslr?=
 =?us-ascii?Q?Gn0FVYCSxvoNoAtjoOiwtpcNXTWvO/FW0sNOdAA2whgwTTnDt1mW+qeyYS8S?=
 =?us-ascii?Q?X8BubDf5c/gzr1OzMSENG9MGCSqrQhUl0UmFEKAbAfbdbbTKbwUJesOHFwE0?=
 =?us-ascii?Q?3eK/5mJS1Cx2G8LsSVQHARazy7GCSzt2xHu/fNW0SV3qI9smX7Ems9DUxluh?=
 =?us-ascii?Q?jMskn7IKecRqNrW2fAAKl75KCVYkkiRK8LJe9lMq/QW/L2TSvmNZVpLRtKG3?=
 =?us-ascii?Q?E6kHK+TIAoLPip44xka++6IfGNq8nShfzsJzc+WpEtrvdH2vsJHo/o3PyV+Z?=
 =?us-ascii?Q?LQPj1EF7si20zBpEXXVJb0PTuZGCdcampMoD4lFP65WzCX86aJ/FD5f5gDb/?=
 =?us-ascii?Q?xrDyuTYw1ObM8CukmI+/H9K5Rfr+hM6a9qaRBikmVDjpWUowpQAxXbBvlDl2?=
 =?us-ascii?Q?q7u9HufpYcpALUM6LpfhsoRNUxwO526yY9ZkOdjiUiluG6F2hRAKVNix/S0p?=
 =?us-ascii?Q?/wx7H44sQzsUTxHbzAmTYyT4yeSKKo1jHo3FWbbEkSoauGS9PwQvY0/7ZsGM?=
 =?us-ascii?Q?cLsG4ju8mMioFW3EMrQSg+80yRpvtZmg+jzV1Or/LCVbmXkPbqImDteAjT39?=
 =?us-ascii?Q?FomQHPqB3qXE9I56Sn+XLGNVRHvPvZL7GNPzGZC/ssT5dHtORV1lTING8pje?=
 =?us-ascii?Q?OoPySks/HonLGBSR/Yfg7idtZHaL61qqlR2B0py2vVatzN0Lckm+vYVFYQal?=
 =?us-ascii?Q?Ut0r5XezJyBkxQrxmC0wNXan2shcyX8XRhqEne+auFRjhxIlxVxBLLk8JBaU?=
 =?us-ascii?Q?1KBO08lK7yardYagRnQdW82MP3RTv5ew8eCXoSh0YWdnWJLyEFX1Wmk2EJoe?=
 =?us-ascii?Q?3gyJEf/zO9q1zdwAPCv4ZGeHYh1fMpTnPiROzV0Q2KiTc5SY6OKWLrZC+jDo?=
 =?us-ascii?Q?H4LNiLDY/vkM5MMYQtZbpEQEa1SWjedNj5gK26ZVbAjLAxS2sJ5z+efE/Dyl?=
 =?us-ascii?Q?8rW4326abrD0TXd6I0uHwCiS+FB4cZ3vOkRAlbjGDnukwW0HBbAx3CrnY73O?=
 =?us-ascii?Q?MY0elyqBmNinnE5AQQJNRG9zKa6iR4+Z9U83qRnI7OmxWFHHDN4VeMuRdos5?=
 =?us-ascii?Q?ZCymGO90C0mSnmucs1KDsO2Pz1UlBQWwg9Mj7DEGzSWpI/XX/mEkbTkQkN7P?=
 =?us-ascii?Q?U66+6tBwBhUtAk5dr7y3tkjh1ub9HG9+oN8gvJ8a9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C4r3xZhQn9vvLq4qPSY0Q9IWCvbSy+hTb1KohOPLteok20k72lv4BFE7hq4c?=
 =?us-ascii?Q?Rx9/kr7P9VzB6mZYtPEoWkRPUS9xPJ/zGB+WW/7OIc3W3amGL1lJLJz+uD7F?=
 =?us-ascii?Q?ejDDrEWt70BhYoAYG9aMjreBMNtiCtPifjix7/kvdr9tJSlKLzEkSQ4+Cfyb?=
 =?us-ascii?Q?AhPlTSdY7hXv2OpUy/Hn3Tww0WzlpSpD2uxREmJwHIEUyXoNNJbN6kGWQbD7?=
 =?us-ascii?Q?ehcJ2MGE4sUDVgUqYgeqBZ+/KtJbeZiWHqedn/h86BRz9AgaKsdqPeMH9Si2?=
 =?us-ascii?Q?ssEmrTVH3qZLi+VI/fPot7/9NkkcI6J41DZnrRZa42Dfhm3/7BqQGDXAX1OZ?=
 =?us-ascii?Q?DT0XQqCv41XjlsJgTy4wV/9leZqJ55k8GKkbuU4IH6twRJ2e0K5SSqnn9xCq?=
 =?us-ascii?Q?UVmm8f99NFi3cUh9VhFFoa6jBkwrHcXCMQxNNkzjZA4zGBpZn6iHsg9Npay8?=
 =?us-ascii?Q?nw53whd6Boq/zSveBuBFxkNtUSM7/6wEe1IuCJnCVc5n1qEEDbfGOkPHw3PB?=
 =?us-ascii?Q?qbnEsNabmKoM83Jqat27OPzI4W2BNxvqibu4kExhKdm/HmTYGh508UWU7Rkl?=
 =?us-ascii?Q?vW0Mt9cTMHJw1+IRWcAnxwLQtRGtacYS5+XikjHVqYolFZA16ADGJS6+jLoE?=
 =?us-ascii?Q?B5WdJS+QFmieZO4ScCmfq5I6VD3pXPLdHbsfv2INzgiE7qVqhYsdRbqwdtvp?=
 =?us-ascii?Q?kb8eAg6BlZp7Ays+kW7sU7TSUrH0SVxwN9VJcS95YGvzKgOIKgMzslTfN6uG?=
 =?us-ascii?Q?1SEllCsPjrlduidJzb04smHuteqR30oeWVGoQNnOO2DqvTURZRMXdBbRkSXa?=
 =?us-ascii?Q?g977ftiPpIUE4LDpGF+w8HvxNqwsP+2VVsAONr+yY9QSFDOmTb30DhD0Pbxk?=
 =?us-ascii?Q?v2vITdfeg5G9TSbHdHh6CJITvDx30kIw9/Uy/VtRHqaan9GKrFD6xRpTR/Az?=
 =?us-ascii?Q?SGEjLPPG9/B2hpwGTbCvAzLBNhoF+XU61g60e3b/4HBDfy2seo3wC9T3t8Us?=
 =?us-ascii?Q?xNZE6PXcrCevlifZBYuEN5DzPXksv991j8ci0Jqlt+MPm4sGBNA7bO9DxGY1?=
 =?us-ascii?Q?4uYpK0HV5WZlkqjkim/lFgwQr7JcVbUsFx//7Y8d5U78s4io+fUuDe+Jmd0x?=
 =?us-ascii?Q?eCM+KVBpfYHoNffMeB+tRuKTcFOUmSaqKzGv7deih79xW54OGmUGzXMqMqGZ?=
 =?us-ascii?Q?0n/vBPFSk4WQrbRwaIrb5Ak1Fg9q39VHqSGIOIadvKU3oEJblDrnXLq9STMl?=
 =?us-ascii?Q?iwIkWzpFOlORN/gwWaW+Be9SzVv/JL08RmDwClZsmw4XWtPGU+BwxEaoh2zz?=
 =?us-ascii?Q?Xed0KizHWUiZkHVESzSS2qJ+EwZoEKyZSOlaMmdQDp3ioZKDsXwg3/Stj50n?=
 =?us-ascii?Q?EoAL14oHZslRtkiZBjKKPd7IXEV3f3zlPW+YTVdJ1uNmsPIWEBAx9y5h9mUC?=
 =?us-ascii?Q?wEPOwr5Ubh3hjRsloQ3FrVbo2sVEqrmN4RS43fSvwQo7mx2C6xfAJuMUfQC4?=
 =?us-ascii?Q?isIf+bJCj9ig7GBmI4LSd7C+fECaDHIJz191NNj4MKXb0AYsCcld4XNZvd2C?=
 =?us-ascii?Q?C5Dx3JvTSyhkaHKsI6AC+jc3q2l8BYdLFPnGpqPr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ae340-4c67-4fc4-7460-08dc7ff8a2a2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:43.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LJ3IeW3KW5YTG8vF99+4v8aAztDvVmm9QW5I1vjhYvfIMDj0ZHbg2QF3PdR13RN6Mr92cpfu+c4923F9+ghXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

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
index a8c2653608de..51d703741f95 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -242,6 +242,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3241,6 +3242,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3257,6 +3284,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3274,8 +3302,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3283,6 +3322,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


