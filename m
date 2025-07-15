Return-Path: <netdev+bounces-207112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C7B05CF4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB1E4A0DA9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA42E2F18;
	Tue, 15 Jul 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WUKw2mqA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9282E2F1E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586129; cv=fail; b=ZsDuNeDqt+NCR1gi4TBSVNMnL1vV2rPkBrwEl9e6afua0uzN7FElpuzTf8khGfn2cAwSlSNc30CPYc7JuvQBrUrBlRQirKvfuRtJOApRGRXVrc7gBbLSXBwuWLQ+O7nCnVWvAKQwQdGwLwJuY//CpPdZ9fc1Sn0Sw+o7vbiiEtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586129; c=relaxed/simple;
	bh=kqrb6inR64fiBK+Jb6xs8/UaM41PqtUYJuAw90AN/0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sbk37zo9LFrYUJL6mjOi3HWp9RuzrqF+hVo7dgvJd6mkwNOFf2St4Ls6VGSFbC0FHG2o//CpRWTGEY62Dj24m6Yaan+aKOgaEddKP3w5pVFScaK+PnQ/YvhwOl+Xn9/r5Xnbp7QSg36Zpk2qh5tNLZJxm17orHDXlqLwl8DtYMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WUKw2mqA; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+5izG7xujHWL6iT1vrghwebPd1fJQXXWUOxkQbwrgCXOcsgAXPZYbwH0SOHSQ0TNIrkdbymcp1e+2y1PoD+igjJbSE3Nnutkifi8sYHHaX+jeB+1ikl2gIc3CV6dwjuSQ3/emcr5yVBPr9eFPWDfandG25HqyyEL+QYJEPB1c8CpEvcpqugcEV2C2UcBwx7c9mSUNhUX8oC+JlOR8eUCQy1dLa9YmBwOs9sSC4Tg5PJfOlwtZpdqipwVpmnM4vh3f/xuz/kLNSCQtKJJBTDJ47uHoKK1pVdAmw+7iDDs2dRphW63lFJsPxh5lKJktCdZNMBDiTCH8V23R9NHxLXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYWo2Bb7IkmsPC4dilQyIcRrxSjM9zcD/lFDasC6F1M=;
 b=DXPkG5M+ATpI1xsQoDyoInYnAANam3j+4iSLTDFyLUXvzNQ24WQGmQUHgZ279awdvMrRibCJlnCAU7uxB24cHBHOGzg4whQKYfe2WbV0KfMWOKzyfAMUhfZFqXjeVtbhwdfo+++/M0liLvNF1Dw0Iw7+1KwTbF7RBu9Sr/LL71XdrxVJ8ltpvmVn8X48kB4SPhAwEopnb3XUEHnowgbEL/t7NlWuHmlyqvIJvekBC89AYg1NaWBBlKVA5eqikJcc+F8lk9wmVjG42cdr/vLxFniMH9SxK/0JlvggMICfCxwGrqW0I/ueE8r87qb8fsvy/ODP8nLlbmndn4S06tu7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYWo2Bb7IkmsPC4dilQyIcRrxSjM9zcD/lFDasC6F1M=;
 b=WUKw2mqAkVqDWppnPg9BY/basSGj+Mtl22zE18PCmc9C7/y8/SX3CiEHmt8GG9BAskHFMzLZ5T9p+HNQtHzOREIMzscNLXvZWL0Fa9autyE6LvvLqU4ZGIbY+h/IKaneFY7/BWRJ0wmTtcJEa+9rIIeMVhZZPUyShOgbGqCDWl7VaQdnwgRhhoq4btlbWdhQP1Wj3uKRzOljQCjFvAMyVGv9XeUzjp03meh6+oXkeagFLgqmUHBmfA2OdT0PuVTuNOXe7pMF1zdcPBDJn3sjtQDmX1heH/cxaoH5doIbKaG5fyMPCh3/oavmhsH2votvgBEC6WyVYf8z8ZZ7JjA3KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:28:45 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:45 +0000
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
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v30 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Tue, 15 Jul 2025 13:27:37 +0000
Message-Id: <20250715132750.9619-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c674a74-c089-44e9-bf1c-08ddc3a385e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T36v6DYGVZqV6nYyrEwvTfsDY4jde4E5YKhk1YEFNP9Wetq/z35Adn8sSluL?=
 =?us-ascii?Q?QJ/lMZevO8KXNnj7ADMk5oK19uxxNmkuaGbu+eejZ2ThcQXc6rmFforlNaA5?=
 =?us-ascii?Q?avQJJAoR1z+nmexqBkRvT62iZh/DwCqNYE+53h3m34mO/1DMdSNPE26yT1Uh?=
 =?us-ascii?Q?n5AZy/kGpSWX5jsaNOVnqvOYZeGcfuovg51T8vqD2Dr7+AFlQTpKpI6hAJ86?=
 =?us-ascii?Q?CJ/kdMw0NtoGXS5l5bGcFtywS0uq0NHpnIugypPWxP0Er6M4haGXIcNjd0bm?=
 =?us-ascii?Q?1QJWSMy8LlwJ6HMSOfh5tp+VNjArGvGo2bxVQQIvmS+I44LwInh1DxaHixOP?=
 =?us-ascii?Q?tGEFO7dyzwqTR8TokaZrr6tIheozNYfRU9yjooQod6gveug6JiL4ckAOaFMY?=
 =?us-ascii?Q?rW8bYvHNmiYen61XAD0SOA+QAVG0L3FqHT/FCQy3Lbrez7O7lGJCLHuPFODm?=
 =?us-ascii?Q?hnFo8hIKhsNqQemxwwXSRzdSuGiAYGKfDfBvBexrdMr1xzWIp5mCw0Q0fHaA?=
 =?us-ascii?Q?pnfvigVs4cvPy2MtPPHRqBLobwmMvY4TCz36EpN4efF+KElQi5WkRxLCQWM4?=
 =?us-ascii?Q?dtHpDIYcJ474l7jORkHecTZRNK17c3NEio0Mo8dhC9y7O5vT8El5SvXA38di?=
 =?us-ascii?Q?2R0X7sJ3KxGZHp87fdnYbp12L4jZZ5jYegi4T9AyUvuWfafR+Wj81HSQTYrX?=
 =?us-ascii?Q?941LczFCwaDZ8mnF0WjtpCywo5sS4pq5ldgah816X7cA1WcUJDhmAMWD2YYx?=
 =?us-ascii?Q?VdnK0OUj7I33/4CGy2IqzbmklTgRgEqWmvzvOXnLRoG/7cGOkQl7Z1vSjgRu?=
 =?us-ascii?Q?M2pjpOKxdR98732TFbh59+viEVPEbb9NOWa4Zs/4Yv4PEqQAf28+XwifGACY?=
 =?us-ascii?Q?I3PkvdWJPC46BwMTCvby5RQqoVCPcLTaF5yiJZViP12U+n7t87i4C1zWPRYH?=
 =?us-ascii?Q?COEzvQJMuOlG/Iow+EmT59VhbNGL7NyRaEUUQOltmDHJxXwlaXXy1NqsACMg?=
 =?us-ascii?Q?JgomTrreXIPhXPB2buHo2mJQu/lbFFqlCY1I0bH+gPg4rgFFqzxR5O8YQGRm?=
 =?us-ascii?Q?XQYsJKf/O7nwc7GfTOOnhgClehH9VwiYWabce20r2PEpYa0WrhlapTlETRj6?=
 =?us-ascii?Q?zsgCNjBCMzG07I8/0QWvu/yyQbuBRmTYrBU15421ZxUlJ7Sv4rwKTQMy7cvb?=
 =?us-ascii?Q?2PvDKSGv8u17THQpCwVAXP98bp7Nle9s1lJRgmHwY1q8sNkn4c7ne4EFwy4m?=
 =?us-ascii?Q?SD7R+6PbwUZArq51dD+8zDQ1ISrgfv8MPDEsP24LgOSAnv3/+0KwJdrYN4Vt?=
 =?us-ascii?Q?b0g+mOWO7klQl+jWYINBbgT4cSP+53GIRUqv1ViY6A2kgDX9HiViYx1ZvuCy?=
 =?us-ascii?Q?Quh4XDJST8OQxoItr4FAPIttJd2NfWM+dLebeyjjXa9niz1BOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iU1iYBBzJfGulOdPV83MXJUKOCSKAviPcgZ8y6NfyZLc7PMS6gpgyL0wQSgA?=
 =?us-ascii?Q?0StQHIAM4W3FJLIRyI1XRQ0WiRrFaF2bHq1/pM2h5pu1UnqsSm00q4NCKlHe?=
 =?us-ascii?Q?5DfMGDOWpsWO0TFPToFazCUAuyre53xbYjlknONszUJk2Bn66kqqTKvo92hB?=
 =?us-ascii?Q?iIHJDCSqFhIXGLomDOI/0WnWexrsuYbtSi28uR3svlKCHamEDeajonFvKshX?=
 =?us-ascii?Q?ijR8l1ZdqVo7hbvrTlXay5p4pl94BK0q0/nGg4/puCngY1yWTYpSVnOZY1nR?=
 =?us-ascii?Q?tJqgej+X6+Qhd2QK0SaSM/R2lEI2cy79xtCNBPcCMpu8RVlTJHUDTpYnXB/l?=
 =?us-ascii?Q?QJomnL8L3GP8cri8TZZRRar+NVpBD2+YMNIK4c5e96cRRT4a2LWYP9lULkCW?=
 =?us-ascii?Q?UptRudu9ccO6FVS2syPhStQQOa34SApzcFQgawi6kLu4I5ndlIbTlZ6T1haD?=
 =?us-ascii?Q?+nLFN3rpv+UBlPJ2VPrNET0hBDU9t9FfMhes+UkH3tTzqN5q+wUcY8Tfq7kh?=
 =?us-ascii?Q?+psINj0m5w5ff5P3LvnxInhOujCKOhSK3EKcWtdhtYuYGybLsBJF1qbRoDAt?=
 =?us-ascii?Q?gTbPGDThMfSg8B6h08s3rN9Q4lhVsZCQnC6YExRGEyl3vuYpQKFHBcibSuN0?=
 =?us-ascii?Q?97da7ZI+pWFEonU5VzC5RkWDDETMSJevMjkjX5kqUyWXG/EU61vW1YmPc/vA?=
 =?us-ascii?Q?zN/aXqTxNnUeMwlXW5g6K3ncr4ms0qc26za8T0nipPeKi8oPGcMN/re3bm1h?=
 =?us-ascii?Q?bKLM4pSJrNMXFseLzOTB/Fg/4UPaPMJlngi3HIeU3tyTwbKH2eHTA8Xen/WM?=
 =?us-ascii?Q?bvK/9+r1zU+7OoZcVr2P+0+s1Jz+krI8WBftsWn4mNy9c/ZMPAvgTlOV1i9m?=
 =?us-ascii?Q?uKkLUNy8t6RUg7kXDJITP7c5GbZ+URzVL1BDlR2Vh24UMeXw3f0BIuMpPG7b?=
 =?us-ascii?Q?zc3NAzfwC8l5bnW3FNkkxriS1j1V1U2nOmAsuoOPZlMtBjAlnlW7Q93YFXyE?=
 =?us-ascii?Q?Ad51JpJ4LRDzEdprATHlwRZnl0crQW0R0pq4n/U8199WWuJCZewX4R/7VcLw?=
 =?us-ascii?Q?vFWnf00/jYifgE05yqDABZCsd7pcLKEBM8MxxadvPicnAwJhYs9LJ4EjKGJ/?=
 =?us-ascii?Q?WbHbgcaqYGNs2cAPCkLJ0rxdpDKAQW06JOpDVozguegX7Cn/YbOnB5ShO+Fv?=
 =?us-ascii?Q?aVAEYwDJNrcXe8hJOPmGkpjsautRgFl2UC3bj+WHYirxvWJZ+72E11rhnD4L?=
 =?us-ascii?Q?A6OFCUq4hIPO/RjRMJ1Q7OXp9Bud/DJji9brklDUVJeAZOiZgh6OIpDMZZ/u?=
 =?us-ascii?Q?v7ybFrOkl2CCzv2sPZ9rVlKM54t50JONAf9HC2bgUEPGDEL6o+QEmb6iEF6A?=
 =?us-ascii?Q?d954Om0IWWrnSEIFbTjbgf4eFU1CiaeQTirp405aHqBv3y99OgJ7JBqykXWf?=
 =?us-ascii?Q?pYmezTaQJqfAyZPT5MDPBTwZzEi+95F32GvrpChNV6IoF+mYR+mhaIbsIPhQ?=
 =?us-ascii?Q?0cvzVRU8Hj0pRfzMoToZhoSp0lQyOT4Z1c3kmyfI97v0t8XVNs0/qo0cwV5D?=
 =?us-ascii?Q?8ddFm30xoD+AEsIdiBCT6UNvsInVNJAqtLUczKyk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c674a74-c089-44e9-bf1c-08ddc3a385e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:45.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCPPQoF5J1LP8aeo0JGc878swaVqMaYMVvkeH56tr/Pr028LJslzqXgou66N7UYKCa8Hk+4ZGA67wXoCPT8WTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

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
index efea6d782d8a..f9ac575e1b66 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -246,6 +246,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3463,6 +3464,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3480,6 +3507,7 @@ static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int cpu;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3499,9 +3527,19 @@ static int __init nvme_tcp_init_module(void)
 
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
@@ -3509,6 +3547,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


