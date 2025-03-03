Return-Path: <netdev+bounces-171149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EDA4BB3F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B48E1889C24
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08D1F1510;
	Mon,  3 Mar 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qsei1828"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8601F12F4
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995629; cv=fail; b=A9HTFCXC7XhaNOuD9s7L65Q6Ygz30a4rGiBzrpOE4MCD1SQpFvVt/XAiWW1MccssUXbtzeWkKUorYoT7rnCzpuCXxSqyUk05k7Xvh6NvvBqyr/liMql8mIhsqgxy2LOrGWA/rK2v/KrFBh+zifFaVvAIgnb2DVARhFKLZWRegv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995629; c=relaxed/simple;
	bh=xMOXM1OlKwaEykreAG4QeAzH1w3uxGOozQoZci1Bol0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jmN+wrRmXIxrL0voZwMJzduh5GIJPokLhS4lL8tVmWnfgIZYI6y+S5EI4vel3SyFwRyZ6URU/vf2WTq/FRazx7Q1fBz7uCctXVrQJaap4KtFJ625PTstZqpMExIkXdwSk8dn5AEV07QVsppg3LzE64AcWG1/DyIN35Pn7MC+qMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qsei1828; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+AjHdgoBJ7wLBsZ7G7pbHe3QWhY8gc+FwVR06I3Yokw0pObyaPGdZfCLar6soZuZ1BxRvwsNMUGin3rmXKz1dl55wi2lkHqaMi7Y96aZdlQ6MkqBhPqqkuIr8rhuyJSkVey2o8IcHR48ZpuooaWM5gKiUxR9p/WVov6mxrio+RzWPMNapoHpQE8Fshs8LBlZ+DhDPRFd++g3NlS1QYbjPjvuAibm3N0pog+rAeILVoO43vkhWIwwm2+q8Um0q4rGQ/96pTRcEAgne5q/M1EYiRlcmwg34VL9Mb+g7vaRJfzPPIMtr45ARPS7NepdaQQcvNHqjvCXYVhGNkuIpOwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRbDmmigHL9fqpkaX25X1JN13cbDmLop2bpEKa4M7jI=;
 b=l+GW7EsbF+4kclp4AX4LbnactmT8IxFHTpibYurv9eLEwp1UnoznYgdZdwA1lKFTfMGfbxS+SH9jmnE3ORnJQ1+nPRbOy3YM4xIGde3tRqjNYrSCcJgY341jAiqbTDv4Mk9nK3MvTtOiL12kZ07Lx1vqEg1BNmBUsCucJirfqN1aru3yVpBmbRubRMc1/R68+YtFaIfF32vKw2PLZQZrKg2E3zdsoruS7gI34ZM54To7NTULf+5lr6Whg8VOnH79FR3Gc+R4xCIEMRvj2XCGHTOOegser7rbLuVyV/IfojTWKIxGG9jcNU6pVcTABRG6Om1lKmyZvqLYFsrWb+9tDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRbDmmigHL9fqpkaX25X1JN13cbDmLop2bpEKa4M7jI=;
 b=qsei1828U4g0E2CWVBk9jH5ml9EhdJft9l/om9kWQ9H+RmSfq/oIPV6bCefsChmyAKj0OS5cSd4uP97t6II8R9fsHZPhPtWtS14DMLmkbJ8eWw8kg+oY+EbPv/zR4CtkrJBuFqxkiZe0MpAsX7HASVWLHT07bgqHCvQDcuHzFN6vh2+vivOBns9fo6CVuMco0xwbrEoSwhRt1Kkqql8za6fBG8sAG73ydEKeYH5/rVPFg5pD2vHU5jrREhNAE7qxo6PT63C+zRXkPD1Y+04g8ahp9Vy5LxLlyiRvPhMWcBW1igN0n7MkmwlOELzf8qy/yePIPBWsM82s9B3w+xTbVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:45 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:45 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 06/20] nvme-tcp: Add DDP data-path
Date: Mon,  3 Mar 2025 09:52:50 +0000
Message-Id: <20250303095304.1534-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::15) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d5d644-1d9e-411c-7c08-08dd5a3949b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Qt/PO96KkmC1kFL9IK4LFOjCsvPNxdA7nO5YNoNWB1builHc/YohiL3mZqm?=
 =?us-ascii?Q?Bdc6SBXUiFfTQQLXJK3tmG3/MKps3qkntqvTuz6xYmFB99ujy9jHUs+jaeZS?=
 =?us-ascii?Q?qC8ZkDqja/q0CdsRSlnm1US9yrecGpeB9jlMmCGINhfYvwh9HYI+MUjRVkul?=
 =?us-ascii?Q?NuwlJXxYNbVAQ6OPi02cpqHqB0nhQoJftybsooq5x6yTikG/EPjPHxPHXCeL?=
 =?us-ascii?Q?naXMYC+CZjf8fYVhPCX1D+6rzS7yImCGamBYJCkIkCjQAGCVIK8l6jMHyiBw?=
 =?us-ascii?Q?YTG2kfyz7P9TbDAq9h4KluInf1QT2z1zXkGqcM34hqL+GAly0MB1o8i1ysdh?=
 =?us-ascii?Q?UGicfkuxW4raKVXLeojhimnXr/1tcHDU7V5+teKdwu1UzS6mbOLB2D2sPqAn?=
 =?us-ascii?Q?CM5cdOgEdR/pGap+s6Y6BcDYgm7vjcqySyRpZLDeVYA4+aTfvqEysRS45mN4?=
 =?us-ascii?Q?ETgnYMZ5LIYJoG6S8XyXbGBNMLp3xT+dPANaesrdgW/V5lVF6CAFzxOcWc30?=
 =?us-ascii?Q?SILF8AZAGF6dXmMGjp8kxxkHi4/a6Ys74JqpzTjdnNlOiHDQPXQW+VO+z3rn?=
 =?us-ascii?Q?F2XloCkdGK8TK2gXcN57nLBT67+nIm+cExWJw8R3dxNLwiXFvFNEMAAw92jE?=
 =?us-ascii?Q?B7aU+e3DS2aizWN6sxpdfEBNp4iq6puYjjwLHj/BUAkE4QjQmtDNdp+G9kUV?=
 =?us-ascii?Q?E4hfkIcEMpXpqbXcvbfs4/h0Pg5stJYvGUMYNxVtuNupPUMXkM2U4s4VoNJJ?=
 =?us-ascii?Q?Sb1fdVHyt5+X8S9Bsl/xzoI1x2AEn9EwrsKwNbezndxSSKZBdM6iiGOokjLP?=
 =?us-ascii?Q?oFVmbtzJHj8qKGjYEGHUSjvqCY1e++KwljrfOFfBy7flwNXF6lXbmnKVX+mQ?=
 =?us-ascii?Q?NQ6NDIPFzhVkRUunXFLdOtv8W+4lUDNIn+7dOJq1RWwufZGtS9prnD5V9OsJ?=
 =?us-ascii?Q?t37dyupvgMCV/tNKHWgh/kXRPlBuoS7kIIgCSZ21TCwhfEuZ89/ur0fWeHhd?=
 =?us-ascii?Q?z4FktYohlJGPiYbn92lwafeQABs2Pl8bWf4z2SwjE8HVXZaCjt3NSUaS3d2M?=
 =?us-ascii?Q?RMXSC4laH383L64TP1tHX/dxGliGdHXeVCNqQk4PvN30sGG+Db/v7zlS5odH?=
 =?us-ascii?Q?teMphkxM8IQGyc6FIIO7KBrady6wy8y65Tl+i14/WnhWdA3jxwn0TJ3/BnH6?=
 =?us-ascii?Q?dpEay+EEfjzdcXJRFHhMOLBTaT6DKzWUMqGi9JD2giSibmjk8bi2u5NgmYGE?=
 =?us-ascii?Q?UCvTnnNG9c3Y530+mX/t/9M2sJMNZ6VcHVWq8bX1ys/diIG7++HOXf9ZAWBZ?=
 =?us-ascii?Q?t197iEjJ+Jk4uPnlpUN3ejXm2yZucpKyoegsGQ7BigwqZPC+t3JQWuKhZFrf?=
 =?us-ascii?Q?Bb1hqgtVP71K1CYH/7xkkMHO5jgH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaeVLkAgxBNFgnUr5eOSNpLgleen5676y4NpMfHF+CPfeY/Gdl3yIOUYn4nQ?=
 =?us-ascii?Q?RxHatGvC8RxM3MYQbpSNErC6ZjoHX1/F7JwIfTf+gYR0nW3gmmCAgbycLI+9?=
 =?us-ascii?Q?l1517i++5NTnxIavmBp//bFkI/+4Rg8PML2IkMQBUGpY4DIPEAPSALWdX7rA?=
 =?us-ascii?Q?P++hoyMi34dC/FN/Gss6HeqkwpF5El4LMc5PZK19rzmw0yrXxgxlxbTab/BC?=
 =?us-ascii?Q?hEG1I0wOL7lYG5Vhcgd8DkohjwHj1aJax66bosYIHj7PU0sLwaD9dP840XWn?=
 =?us-ascii?Q?gkpznDY3lfmWJQBx/MrJyGnKeidogPq6ygQJXN0Yvmslb2tXF6o7daSFfr8X?=
 =?us-ascii?Q?UtewugJ+R3e9LEsaJM2r5Zjl5/kRO2WtBXQmjl/qLr4h3p6NpFHmGouJtZrr?=
 =?us-ascii?Q?aoto1KvYZ7GmIbkKYNuFC5Pb+awKb2BnXQjm4aXqWffWUTcNzi3Da0UzY1Zx?=
 =?us-ascii?Q?wN9ZSGVgMWbAnnljx0SyyifMR+NXKM04HIVNUqYJ8ed/6kiKKVH9a/LgLi9W?=
 =?us-ascii?Q?SNCSeUzeguZdYVQyRTkz+Gwo0KyoZarHfK5czonLHhyHdizsLuvhXB3VwGQ1?=
 =?us-ascii?Q?iq9qgu9MGR7rjib34nlmGH6fZiPWF1lrCrA7jvSKzveAT5WekSrdzT+Q4xTk?=
 =?us-ascii?Q?mMRnnGG7caJTgqy6JYLLCQO0JqMkZrVhyUu1yGqQQNyYPuoiJOtNAFzzqjG6?=
 =?us-ascii?Q?/dgdqowLpJYoh9LDuwp7KiZmc6ij1g6ecoSntts/bXzSzuu1QROgZBNhuJXx?=
 =?us-ascii?Q?Ru7q8h6IUrcjPETQTIDDINdecveNPf5VirXPO7feL368FtSGfr5kryyuC43g?=
 =?us-ascii?Q?NyjlvAaaQggtNp6hPDB2huzZ0MLnydc2sznXMclq7MGOJAdOTa+86kwNcRs2?=
 =?us-ascii?Q?1EujXjH/u1qGI/ZtJ8IPGMAEtlqz0CBQfBWTkcoRjxdyv5X2S3yOhXVY0qq8?=
 =?us-ascii?Q?BVX2E2UEGs8JVW2n508Sv3uXR880rdBO+yfS4bEr1c0FxBlo8w8XBoX4aSTJ?=
 =?us-ascii?Q?reXCqeTt8WUGu3TNOvracO7vyT8IZe+gyxSWv3KzYynfOLgoENv9zgBb6WqG?=
 =?us-ascii?Q?HF0HF03sv3i9jNpV3VJs1kNgK2hYZjFrNhgPNaHceV7syeioTbVTGbNnbhy5?=
 =?us-ascii?Q?CeWUSIkzGDqizc17+K54O+UPWddgiKEHLqWi7ais90IJAAV8FGqh1WXK6MNZ?=
 =?us-ascii?Q?UUnMlPO7U7ZLrIRbEQ7UBACxsV7GyfXfpM1Vw8NJ2aY+Idb3p1BzXFKnE0A1?=
 =?us-ascii?Q?pNvOuhcYFK8EyXERps4Hc43gLQy+dGF1ajk2Rlxy/bQurrMRemLORtiUFunx?=
 =?us-ascii?Q?kh+sm8jH8DsDmObgWXgIcg4ux+d94qa9et73SpKu+7UBd0+/ApItw9yLxxrs?=
 =?us-ascii?Q?PIyozeirrc+MIU6szACBUXG+jfPz+PLPtsuG3XW3T+9up4yU/VFWgGLATxqM?=
 =?us-ascii?Q?ldlgQayu8xzQ31JoZ1xjgqyZbyX0NlRePPYNr36Z0cjJhk19ZdQfDYXyxZBm?=
 =?us-ascii?Q?g4CCGwEOHGGboPzNze7juRm8eIuzpUmmt5Omph51shtFwp5txkOoKeHFbdxR?=
 =?us-ascii?Q?6kIgN7HWt1M+TUZ68f6owpkPJ+heeHVTRCxh0C6i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d5d644-1d9e-411c-7c08-08dd5a3949b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:45.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpTSx+WsVMmaPXfbKJQik9DzOYhCatvHpho7DiTNEeFYXKLMxgmm+GeFnMMMMlyaTOtBxE+42opEv9wWHPT6wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Boris Pismenny <borisp@nvidia.com>

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 136 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 795e2dae3c11..ddb35429b706 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -130,6 +130,9 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -137,6 +140,11 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -360,6 +368,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
 #ifdef CONFIG_ULP_DDP
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return req->offloaded;
+}
+
+static int nvme_tcp_ddp_alloc_sgl(struct nvme_tcp_request *req, struct request *rq)
+{
+	int ret;
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -395,10 +422,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 }
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
+		return;
+
+	/*
+	 * DDP offload is best-effort, errors are ignored.
+	 */
+
+	req->ddp.command_id = nvme_cid(rq);
+	ret = nvme_tcp_ddp_alloc_sgl(req, rq);
+	if (ret)
+		goto err;
+
+	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
+	if (ret) {
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+		goto err;
+	}
+
+	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
+	req->offloaded = true;
+
+	return;
+err:
+	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+		  nvme_tcp_queue_id(queue),
+		  nvme_cid(rq),
+		  ret);
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
@@ -507,6 +592,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -524,6 +614,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -805,6 +903,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	req->status = status;
+	req->result = result;
+
+	if (nvme_tcp_is_ddp_offloaded(req)) {
+		/* complete when teardown is confirmed to be done */
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -824,10 +942,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, req->status, cqe->result,
+				  cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -1025,10 +1142,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
+				  pdu->command_id);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -2816,6 +2936,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2854,6 +2977,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


