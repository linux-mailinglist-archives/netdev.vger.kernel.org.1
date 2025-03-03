Return-Path: <netdev+bounces-171150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DCA4BB3E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1D21709BF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026B1F131C;
	Mon,  3 Mar 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QLWrdS+K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB621F151A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995633; cv=fail; b=lWxFhXVllfMVBgdDfORkLgg7SWe7w4XRTFhu2bVk3M0sbPKIoYiugapt2xLI3/Xb+OnaetqzLcoGWePF8N9PNWmItranyWG8Kl01zPXV2n92UXpBbyjBVuMXEbtFppEYuZ1pgubdNJMkiS0O8obkaNl9o+1RJWsHHNW1RX32MSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995633; c=relaxed/simple;
	bh=lloS5r/iAR4Su64gZl88AbCeuqhkUZBkEX22eEMJM2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djrCvxLiWlZ5s32jpppLF1SNad75X6k+dbx9yGFlZwE9v3gKjsERZwcDqdce18O3pRw9b3/Ihce4CFtIzN+4SQ27RDpYYLgylLEaljWSk6RVqUw3FeKNdX3By9SPex4JcqRoWZwca0hEY4+jhl8UXuHySnPp3v/Uoe/ZKXSF7qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QLWrdS+K; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTwhO1XzZH0pNkFTK4ch4N3+WicqFwrHu8aupI4daFqeyGTDQd/xNQDdkG8J7OZq0SivaJCLvEY9MEyGC/2fY74b7mhQKaf3uoP8crZScumoNKV2uGJcffTxVUk1opczA7AJqrqB9dhnBBMwEDctN+fQjeS9xrucp59+Dbzg/pNp1212LL/R3zzp+YkG1lUozfZogKbfA0RjIuNEOyS6hKxLQrakNeKsF5Cnj4c2SBjLUsKLurgT7HSa64MmtFhlS+Ttd4Xr3GtauZKkyHIfNQq9xFD9arsB6CblowBhSPyQq9WtvRcpU+Vn+ECOZHXXmVDFRoKqQiZjL32ZxZClNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnmOD4foSeitjHMWHu8l9WhGHQbUKYkbENrOIuxv2UY=;
 b=Rva50ACAd3Pat2TJJl4/KEICWv7av1hK7+4dsHM68kR2zVdTvL9PAS/tNwS5UJ4wfH1KpQFTl1o5qF2FRmmUzEpkXTGHVZdXhAsuhcvHa4Edp+rg22+Qsx1zwTVykv8HgTp9JeDPJUDUqE7HgugF2U0BqH3bupCmFnFbf3nZdO/CEAH+a+mga2IA+SmMqaHP1HEopNox2Cakpq1SaarFofyH0bmHvAMyzfZaaFy4ppEZ6v+OgP16ZmD9k4RzPtkTmFE6fsgMjfO6t7oFMl0j1J0Ud0sLC8b39UqrZ6UHyRspx3yHrTvAph6gC8XjpB0rD+7oi1hSDBwkLSFyB+USOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnmOD4foSeitjHMWHu8l9WhGHQbUKYkbENrOIuxv2UY=;
 b=QLWrdS+KKV1eNO1nEYHA2MSh9kbUAHKg2ba2KRmICUbjSz9yJ6eukQtBpeSF+xuOwO+KLChSv4HFVKNzkjhK9mbXJ1tvjlBIDJsnQO1KEijUgyi/PZMbzW0zvW/1+8PkyEotVAMrBzKME/j9d59jlOkihlsuYcw+V6UqM32/ByCuVBG8QFaSM9GiRj4EimQq/5QOSTDNjU7lFHydMTfg8jgJK0aBabJ59u2KTZJcGPDDrootyLG2VDxftalY/fmVxl17d9ow544906S6HH+yAtW7UNZp+hjYfcBnMb2fC5T9u0aV4YoqS85+eVT6v9/WG3ZiwOvsOyPaJxNIs17gjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:49 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:49 +0000
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
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 07/20] nvme-tcp: RX DDGST offload
Date: Mon,  3 Mar 2025 09:52:51 +0000
Message-Id: <20250303095304.1534-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0529.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::6) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d66b24-0010-491c-f18b-08dd5a394c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2gfNaTsPS0j0VWnw9b2iM+xqxVzk8VOMMXScinbgYli8X0Cp6B01TF4jJg2B?=
 =?us-ascii?Q?St9oRGZH7F/Gremta74dpHcYV2/RTPSEMgawoOgVZOV+8QQaIZ6d4QBn0lQl?=
 =?us-ascii?Q?cXNzlITNJMdojFV3cbS712Yx2exLQ3/+8y5YKH5QXsR9gmDTME/iPZPVgKPL?=
 =?us-ascii?Q?HDw27aLtdbkPk43KZXrtptsS9j3fMZM76WAGnv3iGnIbeBkafShcvIayIcl7?=
 =?us-ascii?Q?w/8IfH3XfZuIAcfTAlqaqbc5jb6N2mBWBe6ntiTAQmuIsAArjiVS9oeZgmee?=
 =?us-ascii?Q?3V3/V5PPFIEG++qN6InXKOTzE4DEAk5iQfvqVdA0cHDmBsyVJfTY+qOS9SCj?=
 =?us-ascii?Q?vSFafRu/fLFE7NE9iide0tp+6cnL7EsmpKmqvSgeiJi6Qvmu2agbqBaT6c1d?=
 =?us-ascii?Q?hbSOJieM3wJ1NrKqEr1Yvk93Q7GalNnVZ5zZyfg7ZbYyjaG3NqPRdFk0QMNV?=
 =?us-ascii?Q?cj5gKFJerFyBCD8ysriXvIvhT0pYX9n9JmrFiZi92zDpUCESWputhJMqdomS?=
 =?us-ascii?Q?THmn2Ux9bB5+MPWvVFb2DK2eCx5PwvnIqWrmIy92BDh29EMaJesabP+NsKI5?=
 =?us-ascii?Q?Vtqj2MZrvtsTRAkqAr84+e1FuziDw845EJ5A0guiZQo0ibEUMg9wPYiGZKu8?=
 =?us-ascii?Q?YaOF2SiCJcKZK1sDUR0pcjMf+L38uutCEJ3+QF1MV2GKWqAjtM8zskPAmkeZ?=
 =?us-ascii?Q?8FPlBbOgx47nzkcUdoHoI7s+Iru6y4CfVKZd0C7/F6VGlhRvjaGZBqoiWWN8?=
 =?us-ascii?Q?3m/HUfyGdKA4VYBe6Z/zUNHNwsIQxPoTW8vYiAs+NuicyZMZgJrNvEtIgdxU?=
 =?us-ascii?Q?nMtjMbNdTbq1mVtpiOgygBTqIIvcjtqwWz8KG5CFELlFI7mzu3hTyrGcv8HQ?=
 =?us-ascii?Q?NLJe+rwAK/9aMWISkTFCW5c4FvL42qxMcYy9hSjBSjwiUv/U+B8jaeBm9nyl?=
 =?us-ascii?Q?Kk5WM8mvakB7EyiRM/9iJjrRViQ75pfmS/bhprSmQuP+sOC1goOoUrrBUhEf?=
 =?us-ascii?Q?fNY23n6UodTszn3G6kBZfBCQc183hSpNKRpGhV26CSurfiCXf0aV6xaeruCi?=
 =?us-ascii?Q?jJ54k27Uc2OlvGdt9jCE5K4h41VUpg95xew6xRfRHz8buxlky3EJn8xRkg1O?=
 =?us-ascii?Q?MtuPTWkhNA4EqNXW0PkR12VLd4eyyPQGYSZSYm73I03bewRB6DTGDTKBHG7+?=
 =?us-ascii?Q?RwNfSASZ30wzL3KOcaIABDoFGqMqhTn79/41YHvT9DdUjDfbBfm7T/G2x1IJ?=
 =?us-ascii?Q?c02kpLkSdzNzXfI4SCbqCJnn1Pa3OvbT9PiU9Thh5URpvaXywzntSXYOhmxR?=
 =?us-ascii?Q?cX7xKoQjzj6xJOgb8a9ofhErlA9E1DEH4qHPqt4z++aQBdiDrrzB8GHpnbIa?=
 =?us-ascii?Q?hLDB8rK/3PFt9st+rZ2+bR1XRwV/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IqVEkMJZ7GdRJNrPwmWhkaxLly1lf3uzrpfmW4johOiJwJS5byo3M4jGk4dh?=
 =?us-ascii?Q?Zs/Wb5mMQIbUH/xNURhkxZQpWgb1o704C49L39aUsVfplhv79CR3EShpqp1k?=
 =?us-ascii?Q?WEPOePTWGwjPK0PHyAbXB2nqRSqSRTpU6GhqXhY1okPpuL+9XP00KgCqi5Fg?=
 =?us-ascii?Q?4/g9m97FiF6FRjeAwuhYf36H2CCAuVVutkFZTHaoE5G/7mXcqETbdyOa6LRm?=
 =?us-ascii?Q?jWBifPr5Af1u6ag7bnjg+CbcbIE0AECJTri+wj3N+xpPBqWl2pBYFL152Ysn?=
 =?us-ascii?Q?H90K/RGy4HZ8bbYji4L3bkirNstkeKG3aRNfJuXuNrv8FmAIU4c3pEglHLHt?=
 =?us-ascii?Q?EHU4CyLaY98by/Lj6nq+HLjuwShPpd42Z3de+ZPS2yPIXkvPTdRAgOTKP5La?=
 =?us-ascii?Q?V61WvrBtwCsMlcstuJS9gNEQaMvczXXWNHQQZCHCtLoW1ukm/upqTW4a+rFq?=
 =?us-ascii?Q?SY2SPquWAcLGtlKGnSPICv3yrdLsEFjqycNH5OUA0wjMCG32xbj/+XMQx15I?=
 =?us-ascii?Q?MVLcVraJ9p5b6Ah0d/0vEP/STk+a24N722TevtagJAhCmlnY0b01glSjOUY+?=
 =?us-ascii?Q?eUDgZFSnq1YPUhkp9NJNOTUtsqZIf8h82d8uKSTI8aaiTRSvq6kmaXfh7V42?=
 =?us-ascii?Q?q05hpYSfdJafW9fE0QuiWRqtBvxroyo4oRce6LFMzkeH3LOqZsMwVMJNZqln?=
 =?us-ascii?Q?DCacG3HPNd1NTv7GmxjmRmewdQf/bqRB0Om23DcVB5HY27BFSpKCxCh641HY?=
 =?us-ascii?Q?NBePLjwfrm4p+omqmUkC00ilk15DJQ+/KAHphjov1WgJyCRQd/XVGvs0pNvF?=
 =?us-ascii?Q?jXD23X7vS9/WdFdZbs4XV7bVzqi81qgKMCEqtHP2SbI5RcNPQ9xF2JU8NinW?=
 =?us-ascii?Q?zZu2kJ0ii99MZ1bZBS0OSE/m250ExCQgoATveyfwwquU8iFPSEb8c2HPEmPu?=
 =?us-ascii?Q?J7UrKBUhFbNweHz755yhSPqFXnVW+voNCb+Y72ZaM+EcwWl0d53S5k2nEJDF?=
 =?us-ascii?Q?YqaMS6n04n7cCnIS9BJti8GGH4FQFQ+uvapQV/7Wi2SA078ur0jilofm4Z/V?=
 =?us-ascii?Q?OKOOWvcdneKEvNXqbQkFGfwRcCjiyOqH841MSj7xVD6s0/m7d4zME9EuVjb+?=
 =?us-ascii?Q?DMDN2D0ShWB7fNMIBRbHuCw6EayW+7TrajUdGOtiS38Is5wsxYmDiAJXSuts?=
 =?us-ascii?Q?D0EiN8nz2UnLhO2u0XrhJ1hK1JXre7Bqv05wc0bZgYmg4RfscJavpazTCjO5?=
 =?us-ascii?Q?IIdgtIaR9dRP9NkAZ2MaLdb/jw5lpY+wNwEn9IBEmxYhBcwvi0Xki/GEJnaG?=
 =?us-ascii?Q?KayQSdxFELycpMT/F2pA+znpBRW5/H5SYBj1X6JJgSRAlyMuYMZwEfBsi0Tu?=
 =?us-ascii?Q?eID9XMJSbdCDJp27zv/QIY6Xen0WTdLlE+gONDP8X4ms53zqWuIQt8IWJ829?=
 =?us-ascii?Q?BbqHj/OpqlTRYEajx0z2bJI0LmNAZ7SClMQfkMUENrnWbjcB144kI9oeAINg?=
 =?us-ascii?Q?X+7g80AUvN2ueIEF8l1c4kPWDPjJ3kCLVx47ls3XqXOiPWY1JsLBBk2jrimT?=
 =?us-ascii?Q?Cg6YfJwi1vA6ZpWzKhtLS+NbNPEgqI2XGePcVNnR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d66b24-0010-491c-f18b-08dd5a394c2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:49.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpVGAQYS/jnnRDfy4nZJIFRFjc4uiBEj+amo6vHTf6xQEOAZ7ttZaTT+JMMkGDFCybCYP4kFbr8uchkeazlEZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 96 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ddb35429b706..c978034774c9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -153,6 +153,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 	NVME_TCP_Q_OFF_DDP	= 4,
+	NVME_TCP_Q_OFF_DDGST_RX = 5,
 };
 
 enum nvme_tcp_recv_state {
@@ -190,6 +191,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -421,6 +423,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
 }
 
+static bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+				      struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+
+	req = blk_mq_rq_to_pdu(rq);
+	if (!req->offloaded) {
+		/* if we have DDGST_RX offload but DDP was skipped
+		 * because it's under the min IO threshold then the
+		 * request won't have an SGL, so we need to make it
+		 * here
+		 */
+		if (nvme_tcp_ddp_alloc_sgl(req, rq))
+			return;
+	}
+
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+	if (!req->offloaded) {
+		/* without DDP, ddp_teardown() won't be called, so
+		 * free the table here
+		 */
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	}
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -509,6 +551,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -516,6 +562,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
 		       &queue->ctrl->netdev_ddp_tracker,
 		       queue->sock->sk);
@@ -626,6 +673,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+				      struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -892,6 +953,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1159,6 +1223,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1187,7 +1254,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1229,8 +1297,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1241,9 +1312,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto ddgst_valid;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
+					  &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1254,9 +1341,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+ddgst_valid:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


