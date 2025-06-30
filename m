Return-Path: <netdev+bounces-202457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C055DAEE02B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F0B3A685C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC8028C004;
	Mon, 30 Jun 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSj68EAs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F528B7FF
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292506; cv=fail; b=CZKUCxlMftp2X5gjx1VnqlQqY56/Qk74SGeiwf2Dz9q7vv1rACpk5wNGyjkyohRm4HwlyF6bNKUARe/56htOYEjCqcAxL68UXC8YBvR3KJI/GGy2c1GDvzQSo4F6aUE10R5bd9yuWDc8DCvXgpIXWjRNAQUO3daE5dhkQ38S9PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292506; c=relaxed/simple;
	bh=rrCO74zJyeGRJhiVzeoidRvXYiuPrNNQ+ZITXNanpaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bhQNNXp4ihnrauQq/1uN4KDo3NSSU0Akimz4Bpn/ERfT7aCSnNKLDyaUaG7QP3+bvGhqbbf0VBWWu0zVPrC3h42mK9q1lJNpwVB7HtE8iC/kK4YzgBw2sE5OtmJAtIBC4DjcR6jNQkkJRWslSmGq5Ns9mFEX1/JbKL9w2CvTb2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSj68EAs; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLa/+sUKIQexU40IYiTgEm2491+LhxV4/p1ZJMSAe1EoG0NzX3FU2w85RBreWHsg2L4lwTJi2hUYr4SJMeiYqDSaksq2gm6GZFRu8e1UQsOqk/invIo83APRkv9mCizNYiofGvfPmBNwOItWl2mGuIdh3hKtS1q2M52BlMT8mP2hzsAPInJbZ4l+c1zMr4MinJOJJT1dzg64eGpd2uODkqx5wYCOpCi5JhuKbMlrDYpMj5LZs/KTbf5jb2fjA4uzuG6ATGaXc8K9vC6DcyqiYraDtKtbKYcEVCHLs5efg8ff3JUg+rEZJA7J4M9viVKEk2+AVbzL5D70Xp1pCNP7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlLpGdVYIRN+U4jMtUb39hIVs6XqmD2Iug+NnICEYdA=;
 b=IraExGYayaSpETIB8dC4rEVKMGJXpF3RMgDk9hCvaDkOK4BwdU+C19wRyZYVT/utgEzipCp66WtysQsmlXhvfHdNGlvQkFUpJsm5GTA53F06FpKLC2n6vhVu6DV5kVVmhzvnquE+XcMEZqC549/nLUwG/tBV/2wkHmIFZMKTXIvSO1CPMyxpgiVMtVnxAEOL9rQr6le8pZaUiQRtGcHMu2gDyEjdggaDogU/KGG/elrhAIP6mJDAwz4Ay6JL2nUgGVMsuCi9GvU/8Ch/+ewaza6W0+Q77LP1foEih62z0p7ggonTKnv0V5dt3jSpAmOJB/hpxyS8CukbH7ftL7d7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlLpGdVYIRN+U4jMtUb39hIVs6XqmD2Iug+NnICEYdA=;
 b=kSj68EAs7e1Ze1qmmnWC/tUl9X0/yU2k1ILzB+UUaQPP1wEMeBCR1yC9Oc7GuLT9kRm6a/vHvs6Y4jQDlG7zq/RcpbIzbjdJ2pXi4cNKM7IO16VAThkcOVUxqrX+7ONxPAswrj0B2AIcOr89gaQYkyfLe+DgLssPc1+lvXTCP1jKw0VRuewclwWjdW+i5/iaUhtl8wb+EcUHx300POZjar6kgJVE/GE83+Xry5FB1iFSnHCffaBUp73qIZrwSNmAU0sgDwbzdKOa5Cmg4Mb4WRJFpI0KLtLNio8Z8Q/u2nyW8aWGlJd7rjsoAELUkkHzV3brpdk5+Dk4k3pR0KPxeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:21 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:21 +0000
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
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 07/20] nvme-tcp: RX DDGST offload
Date: Mon, 30 Jun 2025 14:07:24 +0000
Message-Id: <20250630140737.28662-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e80110b-966f-49d5-e318-08ddb7df91db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6OaLEnBpoTO+oLU5hQd0q477QmSautjkUQhce3jBg8K7vI6gyX0u60v/nB5?=
 =?us-ascii?Q?MJGGy7/KcXqSVp9y94aforhuE5k7x/disPDkMszWAqaLle2xQz6Qf3vtmyP+?=
 =?us-ascii?Q?seH6P4T6NJ0UKA7/DTy5nXH5tTPDkPwTF6KcGAtYs9uPph2kGawL79kel9n5?=
 =?us-ascii?Q?Q9At2epDSDAJ/vdlmB8Af2laGYp83osgUj5y15ASbHaRCDl39H+BpOhwHS4D?=
 =?us-ascii?Q?EC97PVCvCR9mg4ctdkV0VcT2n9uwCDRB2qpdjRTbn0a/NM6ZK7nSmMO/DblV?=
 =?us-ascii?Q?ehmYMN628r3HJIuK5SBzjn9fqholC49OWpJJeIPzsB0jN+wSmzQi7J17tmfU?=
 =?us-ascii?Q?j+LHmyc2G/7cbNe5XyvRkWACRCWdim9M3yKsyQBvfe+0mndYsuPFk+MxN2Eb?=
 =?us-ascii?Q?6mtSuBWWs9qtnPI+KVrDERIbaBQaPhgeVfGmWZzcEBuhO58ORQlmbpfda4xG?=
 =?us-ascii?Q?8oyGvHX34Vp9dzw9zCj8IwSNH3ubTC4629s8PTiGeolWVflVRbQ+EdP+VnkO?=
 =?us-ascii?Q?y6R58KZCvxMoJgtbqI7KMgidA5RoXDnuR3LgYfJRSLUW5hY/5B/+nODyZuWs?=
 =?us-ascii?Q?DR6roiD506wbHGP2JV3O4NyITAUF1H8+BXxJWyqeZlNd6aDiPqWfkPCbqMr3?=
 =?us-ascii?Q?kuRPUe3IvB+zRlOkHCpdOfJY6I7OJ4oi2dfW72T60PvMqJkLt8wf1fJztJk+?=
 =?us-ascii?Q?0ylAlq9jq7g3cbqUSbcbpPJXddEvpWzZJGaHgfalHQFSiJ083M2L/r2SuFVm?=
 =?us-ascii?Q?+hdckuHacnsBgoZMRzurDig3jUCM37419X29Q8qDLq5z9e1kWnaFGzGh7u8+?=
 =?us-ascii?Q?KOGsVBQdi3kh52y73n0CxhviXByGh8zNYxC7tm+9L+nbF34xls3OD3Ac6EJj?=
 =?us-ascii?Q?h/IpTwGyjsv6rv0Ijp7wSZ9+5fAhtu8zP1Mu5s/fm1qDKapu0+Y5FwnqjzL3?=
 =?us-ascii?Q?pZcx5kNo+uYyMIDjmn/KR1HyxMdOw4nJ/AinEILfou7bLnD+3PQDI/KNAsDd?=
 =?us-ascii?Q?PfbDwChxvgvRBI7RkaP8gAXWsPq9XtDo999d3SwRCvj/3bF1Qa5Lb2K8Jgvm?=
 =?us-ascii?Q?aM1g/2De15sogbgFLkYfrfPlL57f2dMWLNtzImIspl3mj6YZ0SJY4F/kcsQ1?=
 =?us-ascii?Q?+b6etDi2wimFMeLQ8UP+P0JK7cHhCF9tKo4qDltIrHtYaEAHwrKozAJB5Tpz?=
 =?us-ascii?Q?/GXgdgvJnGuC2Z+O+7lIy05yEWGykFZIx5l+X4dkPGxu6XzmLgM0uG4Wo7TC?=
 =?us-ascii?Q?9tP85qLk4mmKEM/YJx2agDOMV/NvpA0rpphqQg/9qzf6bnXa9c3JiYNpUAjo?=
 =?us-ascii?Q?6XLF1GrBbLHoPwNwoiD0ZzGIGRI0IrdX4H9NdvSnIv4q63hWB+ztjJBPhZ17?=
 =?us-ascii?Q?fA9Izplxptrsjy7I2Y4RmLrPK3s+M031FEmfqm1WbyM7LBdxBVh01HH7wAkf?=
 =?us-ascii?Q?REPoT3p3+SQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tDTuBYwpE8UL9tluDsnQPiCHRn3mA6AQ+fW5Kx8bgynuHPk/ioKQUmIPMtE4?=
 =?us-ascii?Q?wIn6NZzVddJL3OJaqEoDU23vWmjHLJZUVAFDTWmLX8IJkwcBSoFFaz0/C1Dh?=
 =?us-ascii?Q?Ht790B5TL4+hX2A3pzXMuVrHFyek2KHeYYrokCJyDmzAqUlbxL1NOiCp4AxD?=
 =?us-ascii?Q?qFXHomfaq+DHcKFfaA/0jKdDp2X3SnPe8FwwMaRWROHZEvumghooi58CSKZT?=
 =?us-ascii?Q?Qja1YsWNOrtI1NP6ihKLhaESlPcRl4Lrn1i5SDpPZIUJQAqm9bA0WqaXsgRZ?=
 =?us-ascii?Q?va/eYPDiCbxIehye6CPFke2gsqjrjBlDbJ1UWFZmHpmIjnOQc1EwrArpzKYe?=
 =?us-ascii?Q?ZSOUG2eeg5Z7rv5fD7poP8fh3v+sWH4x18WhSa4ZCuRhcoV1fPAdrD1WUnds?=
 =?us-ascii?Q?OS/TmdAma05SFdU2vSOqtRrzDYZsXRa76DagTtQrAjrMcAsZUoX0w33RQhEK?=
 =?us-ascii?Q?ukrbUR7IkzHJ2xpNqe9ArpbfMH8JyNnlt5on60qMKtt3HIH+GDA/U0Rb0Meh?=
 =?us-ascii?Q?O0TQoZtfurlzT8T8EwoRLRq+yTuw2N/ELXTLliQAegyHotRwae/z9UwQOPCh?=
 =?us-ascii?Q?39ekxdmG8aD6oGd+hIiT9G5WUH7nK5A/Ef0RGRlk/BxbBH+XLAkP1DmZYi/B?=
 =?us-ascii?Q?jblh2iJn7c5IWaK1c1VpqPaXj5NlGsydOXa2WSnIroV415D4+zslv/kFb9Tk?=
 =?us-ascii?Q?Rurlez6U0liDZu4T699OI0SDSN6N14f3BBTWbkjYF7DRWFHPinfw5aK1xcmU?=
 =?us-ascii?Q?cTovhjFY9c4kvyVMsWJWWZU3rvNZ42pga44GCkYSJNiyuMwC+o/KmXwBrCQv?=
 =?us-ascii?Q?WsvR1uMMSy+unv4Wyxne3n3ZqkMdSBlS+ta+dVF8S41JqGEtQCio5Bmwo5OQ?=
 =?us-ascii?Q?Ktgqn8eNntl2LDY1aZSpqIgASNTwJEeXb5ezQdfmN/rfSCojNo0NLgFd28Ls?=
 =?us-ascii?Q?7Vm61bIfV6+JIubJTGw5l3A3zcr11MIiU7x06ysZO/oFM4Fbq/laRqhRmaM5?=
 =?us-ascii?Q?hATbTXWW3OwRfhBpd50lApLIO6T6+16j4t9s0IdeR9+cZvb6KMIdP+HMfKKT?=
 =?us-ascii?Q?HO96Rp5/XoGfg5XrblOpR8BMgA7hAO9aSWQMVS2js1xR55X0Ps1iYLqlTumd?=
 =?us-ascii?Q?3CypYwHUaf5ZFulbp9pvgN8U5IbELvMQovzr8OAiYGqxUzVs7J2rCytq+eIi?=
 =?us-ascii?Q?qmQN/71olxqTRhpRXcVVU3BnQA1W/5g0EAlD87kvT83jSHBOIHExwKegQiNZ?=
 =?us-ascii?Q?LQXkadraGlBzLAWY3yYncXkNav85XMDhOiw6Wd3/wHdtkAZ8ochS/c+40HJv?=
 =?us-ascii?Q?vAgtGDkykhOL2oFOBXvkoX0j1OTSSw5Qusq7Zeqyj8smMd66zmBPbj6ZT492?=
 =?us-ascii?Q?gWRj8hszhyhU0NYA9Gy996IOEsNWyOttDKthmVkfPEX/iG8E9h3rh12Zipza?=
 =?us-ascii?Q?QfYXAFovw6aHvaJmCe16iGGTEQf0RCtlV4HKYQ32F7Nj1Lrkn5mMdwOm/nLq?=
 =?us-ascii?Q?Z/SaSsRv5/N+buE2c3lkMV6diH/xydJXRKffv5cRFyAWW9scfBsS448/egJr?=
 =?us-ascii?Q?ulb/asbv1Qm2tmy8EGTmnP3gIefSfibonL+Ar8J2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e80110b-966f-49d5-e318-08ddb7df91db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:21.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGW7LyDFvtcFnYUQ+8EkicK1N8tvB2jyVmOp2iSuH3pkQjn+9aiROcSnFI83ks14Khw0IZxJrfWas8n9NF53LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

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
 drivers/nvme/host/tcp.c | 117 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5ad71185f62f..efea6d782d8a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -152,6 +152,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 	NVME_TCP_Q_OFF_DDP	= 4,
+	NVME_TCP_Q_OFF_DDGST_RX = 5,
 };
 
 enum nvme_tcp_recv_state {
@@ -189,6 +190,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -378,6 +380,13 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#define NVME_TCP_CRC_SEED (~0)
+
+static inline __le32 nvme_tcp_ddgst_final(u32 crc)
+{
+	return cpu_to_le32(~crc);
+}
+
 #ifdef CONFIG_ULP_DDP
 
 static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
@@ -433,6 +442,55 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
+static void nvme_tcp_ddp_ddgst_recalc(struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+	struct scatterlist *sg;
+	u32 crc;
+	int i;
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
+	crc = NVME_TCP_CRC_SEED;
+	for_each_sg(req->ddp.sg_table.sgl, sg, req->ddp.sg_table.nents, i) {
+		void *vaddr = kmap_local_page(sg_page(sg));
+
+		crc = crc32c(crc, vaddr + sg->offset, sg->length);
+		kunmap_local(vaddr);
+	}
+
+	if (!req->offloaded) {
+		/* without DDP, ddp_teardown() won't be called, so
+		 * free the table here
+		 */
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	}
+
+	*ddgst = nvme_tcp_ddgst_final(crc);
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -521,6 +579,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -528,6 +590,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
 		       &queue->ctrl->netdev_ddp_tracker,
 		       queue->sock->sk);
@@ -638,6 +701,19 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
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
+static void nvme_tcp_ddp_ddgst_recalc(struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -762,8 +838,6 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 	return req;
 }
 
-#define NVME_TCP_CRC_SEED (~0)
-
 static inline void nvme_tcp_ddgst_update(u32 *crcp,
 		struct page *page, size_t off, size_t len)
 {
@@ -781,11 +855,6 @@ static inline void nvme_tcp_ddgst_update(u32 *crcp,
 	}
 }
 
-static inline __le32 nvme_tcp_ddgst_final(u32 crc)
-{
-	return cpu_to_le32(~crc);
-}
-
 static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
 {
 	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
@@ -912,6 +981,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1245,6 +1317,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1273,7 +1348,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_crc32c_datagram_iter(skb, *offset,
 				&req->iter, recv_len, &queue->rcv_crc);
 		else
@@ -1315,8 +1391,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1327,9 +1406,24 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
+		nvme_tcp_ddp_ddgst_recalc(rq, &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1340,9 +1434,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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


