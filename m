Return-Path: <netdev+bounces-186975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F609AA4620
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A459A795A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698A21D3F8;
	Wed, 30 Apr 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbr6eW2H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9521B180
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003517; cv=fail; b=NFSCQr6OhE1RGdHnUCE0x6usXYKrb5Yiulp4lDmgDR9KGtFxzeIX5RE26HOCMxBBsejetZ9KhyDErRN3QQndktm4n31YmRdLAQbcx6VK1c7Pbe57uh2BBk9bbEIOAxezpO5lF57pQYwx17egcHLbTVjRkMQXoBQ7ujwtLIcukXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003517; c=relaxed/simple;
	bh=kO1by1soAckspardptaioZ+mSEmpVqqLdO+c8Ag0h1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsnC/1lz+lh1UBXOunE0JLVVTl+fLJ9lA/VMCEsDgFBB3kINisBhg/aeSu8MaRDPjN4Y8xZpl43MxLt0J6lphv/dTcK3vdlx5JmuoVtAhzkORfk1mk/8kOPmHRwCYWaYOKQtffwAAIw/qKjlHnoLMmJtRiO4FdFku91ervLyHAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lbr6eW2H; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnUKm8Z1cn8Z610x6mYNBJ21sXr6o4n0keIq+jqqmZuZRtOX2RgcIn6c/DJiRb7GBsSGeNvkUjwVD3Ok83Jw/VXHnjrjUdKvcuxYOrFn3kkRaQFHDa4uysBAmm42L5TdL3eGrG1nlIm2akTFOgXC4rAWIteStSFCA70uN33Mh+aPRAIuISPQTmuL/6hxIAPxo8Lb6DZZnt3bygUseFDBlMgxc/8gQQ44oV2CzbYsNDpKevyz21hMMm5pE9PKBsGUbLkq7kfXJYh0UUXclUmOsLblruwhpZtTnWNv2Hl/b5vY0WSUx/dPPcjAiLE7Cd56OeOZBx4WsoaIZ7FeFs6O1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4oof7wfAQ3S19hghm8QC7Dd8lifmQTQ8fLPUTLNOjc=;
 b=I7ACMaoSevLFTxz5ufL5q4s1ajT/dVJ3wJjP+U4V4aD5NML4kdjjF/U76JBbiLFLko1eq3sPLtS14SX74yvq3twyn6SXI+/BEQGTv43Ofadk/Fw9w7hebgkFSO6ja89072zEF7JlFMhLlMTK1I7xg1OlULKVD1X5tDXhmgS0XfDwrFd1uGwA8VIhFsi65ZUkDFPLqaWSJCxz0ma/lNdStjwHpy23D1p41W1DHwP1EC0dlwtUUOXvm/CIT5PJgWAplJauI8geM9mUUvRKoebZXDmGlvVV25e2JvC2Dfy72GAfUrKCjN4Hi6D9RIEfk4uZSYwTYWumIwgyPvH59t3BaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4oof7wfAQ3S19hghm8QC7Dd8lifmQTQ8fLPUTLNOjc=;
 b=lbr6eW2Hx8oZAxFG68G5ZwLgF4PDkNlDxbJDcH7fHeByclrBtSYqgp2NEQhdouDCc4y8l8quMgx9bDi10YYEC34t5kyWOICYV/zE7keKN356dMbuch9FNgwprzHETr9Y6eX+IKoKoRRdljKmV+PlhdwOaUEumMEh8MwUAbPbNlrBFBLLG1AYQmBVDhzOGhlZCJDc8l400pCixEVSKxUTOjD8ml7htS2nGjOHmMgqogfWKQxcrUze/KCIBzowMQmGwNXmr+o8NNbo6aY4lhAkjqkdxh0algt92qWBVfRSD03y6Bjn1FigCkv8BnXutmGfjfKKPLuDqUAWIyvlc57EbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 08:58:33 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:33 +0000
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
Subject: [PATCH v28 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Wed, 30 Apr 2025 08:57:29 +0000
Message-Id: <20250430085741.5108-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e6e0fd-fe77-4d96-beee-08dd87c52f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YLmT4yNjFVGGyN5IHBh58ux8Pz++VnKaKB0I4Rap2keLSR1Hu+3xdEQpIsgm?=
 =?us-ascii?Q?2Bbrz9bJqIcFEFo/oVDtfrqPzjO04pqs5FOnkKan23hY/kDf6ykQnopyf8b9?=
 =?us-ascii?Q?rFT8kSJV2BpTEac/dg6QGnW4M9gKiGquqeuAYgWFbNk7rz3E5ThAD9px87db?=
 =?us-ascii?Q?st6c6NPedjWfUr4+/AymDRO09tVrTO8yyhL2cKgMptWOxrEoOszImLP6Swez?=
 =?us-ascii?Q?4X7d2Y58gEvBIFFuCOZi37ws6rYE12789vLTqTENCkSMAMOJytx+o3/mMdgz?=
 =?us-ascii?Q?IoYqfmXVol8IJZBBaVo16HCPuX+OZ+WnGvyeOKi5DbcKPy1ADZptSfVTSerS?=
 =?us-ascii?Q?y0kBKQ4KvQuabZP1JhMkypT5r3OWYHe7A73w3u88Sl2l7CuoIWodohLY/h9w?=
 =?us-ascii?Q?GdFuLQ8ttxp8OSZq4SgjJJ9Qbg9w5rrogGt8oZWN/MmAL/ZWvcdQsKTTkCKv?=
 =?us-ascii?Q?A0uqIXDTDWy3ZIfWtFVUTE5FpJKS0wIp+B7PGSIV2w1AWhG8x2G7B0KTFPcg?=
 =?us-ascii?Q?xCPWYnBAOmgAChb2Lctym1ABQ9wY8aYWLI7LFGcG9VTWZHN755lb2lp7agrO?=
 =?us-ascii?Q?Z+WrZBSGvHMpYAIb6qHED4tZeuudpTkEfcsXF8hQd0evHc/aDAJRl4CBi1rL?=
 =?us-ascii?Q?eLUQOu//O/dtQPBtSMV/OeRFOrOylZnrYozsWJLosCXqzqgtIekU3efHjX5B?=
 =?us-ascii?Q?cP4OyGAU1gxGh0JVuLjmBVkjR+XAClk2inb6RdDnlWVrddVC8KUiJqLeJjCo?=
 =?us-ascii?Q?0OhmVdyBzF/RNc8kbhs3xXBQSHohXiPIbX3V8PISyKbBSBEKx1v5IKi5eg0t?=
 =?us-ascii?Q?d3QXVAGHHSjO0/Xxrnh2YixcTOn1smICWMzCjvelk8KSVHZBzY4wAOPKqadJ?=
 =?us-ascii?Q?u9DxaJiMwfvXpKs6mH+47lJt38IEEiE7KKaHODS77vsMq+T1iuAvgvhpMcOR?=
 =?us-ascii?Q?QXMYjHdO28ZQJ/YWyvMXPUDWsiBG8HSzx/l6XyfiyIig9BcAk0R0Ij5Gj7cj?=
 =?us-ascii?Q?QZTrs542/3KyNr/Diz38Yh1qinWdMtcGb4DLgESWcdoWhyOwQnli6pGEHM9w?=
 =?us-ascii?Q?7Ra6OXRgCpuIDHQUjr1FK1CiBg0/IMGVxojJlcch0t2/wJoUGyTgaS7KNS81?=
 =?us-ascii?Q?WhKjjr4jAwTDRYiA0GnnFgSBUUGKKlaQu/ZpRs2TM0wx5Xlv07z6R96KtM4E?=
 =?us-ascii?Q?3V6Atneoa3KFqxssIFgkNZIT28x/wTPxb4bt7pzpOH8lcRQhZUsqm3IvUw4R?=
 =?us-ascii?Q?huUCmDZwKaqfL76AZGb93YoOmlz3M71g8hALhhHj2XBtaghslgqRokuK9Fzs?=
 =?us-ascii?Q?TL8ozMTEzo1vv8VY9hk9I/TuaxHnUU13iZHE51klLrCZb/3OZk8H6NRTrHJC?=
 =?us-ascii?Q?zuOe5Ny0oS0D00gOFdt7g7gim/YOTtsF+K5czOL2uhvU76mrDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6KyhlZ0kJVvY7m4i/9UFUxpd9F/MHtbzkYaWeAL9GTC4DNNDukwaSlB1cvDM?=
 =?us-ascii?Q?w6g4PasUzXwg21/qEg4ehJBU0o+UqAza60FlOSoOtPgJ5Zv2y/rZhzE8RwO3?=
 =?us-ascii?Q?zl7VaYxUyIvmLlx01lEKIPGI113/tbIMV8TRVzXGQsCrjs/QIMJ/DJrt8ylJ?=
 =?us-ascii?Q?21pgK+LDrtAE0fYN2F200Hvib3y+z+1zAJ6Z6UfaMT0eos0+qfgI18t8oU5U?=
 =?us-ascii?Q?0PtdgHpf0OSTqnnfC3YUlWDnjZB2BdfW5J6YmJ6hrRz2BqLQgCK57EkQywY9?=
 =?us-ascii?Q?U9KSpmlPUV29NOCRt4bnWSLDXGIBvnQ6fjeyVQGsJJa4BDrOr+94RRmkk10I?=
 =?us-ascii?Q?tZGmq+UdYXWI3ZWrUO5UZtis8mDP3DLAyj+i2T0pXltA9PEdZPnMeGzMVXCD?=
 =?us-ascii?Q?uzKBCkvODXZHN9CjNKZ/oANCk5kqV2KEGNH0h5BRo8Q7V8ScYsUW8T6ISBj8?=
 =?us-ascii?Q?p3sOy3G3eyRlewUiezvrnvFIViczyGwW+CM+PZOcPlTcpGgZDKTeLgBHE0DF?=
 =?us-ascii?Q?GpDwBtyT8QE9NUAKymdhCPuDQjHRH8h4UzjajFZNAVIS5rZTW6Sak3xjsqIL?=
 =?us-ascii?Q?7p//1ktu3qlNTmH8l+wE/crvKDpa/pwssMW5tkyu9JnaqNfafnysz9bi7mTk?=
 =?us-ascii?Q?iuLYHI3KN2siklIQWayo7079xxAo6F2D6y/t/IkDWgylhctzJAOdmWenCsPe?=
 =?us-ascii?Q?4CcIUNoNkeTNl22g3GmN5vBMbeFCiinSJT/LFgw3ze4puHbszRwMuETX4eKy?=
 =?us-ascii?Q?kxtKd3n1GZUz3wMcSauoxBVn6gVQkQkxelKXuzuAt7K4VF2fOPlTZtFpb3Mc?=
 =?us-ascii?Q?zLRoD18TyWmLpWvLoWwqtQzLNm/zwfClV+CLmpZRSLC74VKP3knGV/FPDziy?=
 =?us-ascii?Q?/rp3GWm8dftwZdlGatVecU77tValDQGaessu/uLC0i4InVKuPZqlsmCbvl31?=
 =?us-ascii?Q?P/G7UCIRrtYAnKwGyH4gqkdPV+O0y0Fve4C9/PXmH2Di0RgoXnlWQXWNioGJ?=
 =?us-ascii?Q?5lJDn8RVKJz3JDpDdNh4GRsQjtiSb1zk+7OOPm/eaVIGNA2OReXme4mG5rS7?=
 =?us-ascii?Q?HvdJNPGuy/+TMab66n99YS5X6wMWFlhRPvJ8JAMDzeoz7CKRdTDqmeGkgAu3?=
 =?us-ascii?Q?HNNi3Se139b3lhOuX1EiYBmXYrLX0dotHgKwB3eDFLxHHYnfK7QWe+8XiI2J?=
 =?us-ascii?Q?+3zC0gnJ1yIdnFYpEX7n2QKbDBNzQCS5rJmtbqHh+alBp7wkup/SONisuO+c?=
 =?us-ascii?Q?Nb7fUO6mZfLvygf2kJDCwOW3nVH8VMmSnx+p3Z26mN1ZpJJvKMAE5WQ9JPQY?=
 =?us-ascii?Q?lSkkhPn1pdedFmPeqY9L3IjZRHAbnLunhqw1nGJEe/qghtzscyeiH0tnd46G?=
 =?us-ascii?Q?9HUMBHObMxAsDarxjNSYJasdHgwgbTgKVn/RIKl6s2ztEUdO2I1FVNNOHb1g?=
 =?us-ascii?Q?4SxsrBetXk+DUlQHXO82SWTjCACViUBXZD6UIqJ6tYc4yvEfAFepx+b+Fch7?=
 =?us-ascii?Q?8QknIBkh9QRJxaUrS3NXGBFsfiv1Il4YGAXsAUO0BH0K/a7EO+cKQIVjMS0b?=
 =?us-ascii?Q?cR3ObThedpsT8SFM2A5ucdDvEK5mw2itrXsYmH0M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e6e0fd-fe77-4d96-beee-08dd87c52f80
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:33.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBFKoPczsCEhYwnsrnTfeqd7ZvgbEMchUiYJJHdzZcDYRpYWij/hzOBDVLMEHDEZ8I/BUMQfqq1x99pTfNhOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

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
index 81d97fe5b2c8..bf57a88a984b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -246,6 +246,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3454,6 +3455,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3471,6 +3498,7 @@ static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int cpu;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3490,9 +3518,19 @@ static int __init nvme_tcp_init_module(void)
 
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
@@ -3500,6 +3538,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


