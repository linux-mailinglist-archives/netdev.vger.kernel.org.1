Return-Path: <netdev+bounces-168444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E2A3F105
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB75C188B55C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E351F5849;
	Fri, 21 Feb 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJopRVra"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B820458B
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131605; cv=fail; b=Q193730AS6b7DO5Sfl+0sYWq4pTD+YFzTmfw6mv2S1ner9x9qvMF/eECuepcie0rkhaPF4pvo4vJY1ruyUQsNkdeR2rBJbEpJ+aSOx2jd3sghPsRBWRg6hYXqN9cN7eIigxBL+T6CqIMLiv7MBAfngj41m+ksB7SYlig0GXGn/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131605; c=relaxed/simple;
	bh=Cm647xx9jyiJakup2NvDWNIHIRoe+4O5Mbyb9IdaayA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH9IUK/x3eJ7+Wfnvi5urjMa7sv6IkAet8QZPSKe2zHLbLtPvqrrir2aeI6h75gCut7sGodx81Fd72kutdlBFTBQbA4DIWSrJSlRQKBN6SQPWFTgJvTCpoux7ElYBcTCrRB88VGTpjG7UeiBuD9/kFK7dv+LFEzkSS/Vlxk4bn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJopRVra; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2DzMvXl3hYimkq9lEd5ZKjRxmYQeYLqzRcfcgZubpHf3Hwj0gAWbIOaKQ5A6Z1L6t3gQbgIhMqKJgZGKxNxTyLXPxZfjQP8iuFxg/gyD6qJ8gUb6OyhDHMG+/hXlQoHwSfv1JwIdQGj1XaGmR/LNSCENZnu/gxDENmehhmn2s92Hr/0QXh5vYvwAV8A8l6QTEVphtAnb75/41OtFkyQTWE+Zwv38/ezh4NVLRB9fJ0Wpm/SlTSgyKmlpXQi2yWhd9H/F/8xVUzB14FraB86IvyGNFVBBIXKT9RWHOkRewP2qMmd+Ms1WdpoZSgsodhQTxH8/8MzNL27QgG9xziGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcWndTpIogUKjef+pM25Yy+3y5Ibc1ypbbELaSqY/1c=;
 b=DV3A8ex2jX2uhzZ/wrtj8CorgQkkbNzwfJlrJXDo2imNliDMH8cxJoOQWCRsz52okEbPBzxoR1/ARLxva1K2cjzodfqHHM8NDM8q0TH/c5afpbXQ5P+WiGW2NabuTb+etI+RhH64MCUq3yZ5Hu68/eXZEGeIPS6/NS9JFm9eMGItYBaOP8al+HYJ+qOmUNeBcy5oQWD9bKyNd9IwCWqOHl40bJe0Qqo0jKwXwIb9WH+OnCgQwULV4/PJPM6y89AiFNUHQQHnOCnvJ80/26m9wO8ZVmndjsLuFbL+lgdvxqMOkHBcITnzF+mBb/If9Ne5uSbtLVhHLWU+1VP9FvuJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcWndTpIogUKjef+pM25Yy+3y5Ibc1ypbbELaSqY/1c=;
 b=KJopRVra7uuoVFyjypFYXQ7G5pgJ2UsqVrmnS7g9n0cuR/Hj0XR5ODfeHPWYmU1ibp8Eu+5Z1mbfDCZ/FCEda8Fd+uKp65/0M+S2pcrTNyewx/ENhS1gal86VQwUJ5Y1J3UYRDnb7zuQxQzuZLpKEmZw9Zp2bLyb/mXdj4Ywt1LKhEJ0hlcYePzX4iTdBCN9tdiI+A47kpd7cJ0q1VPzc82ZhC5HoX3FpZtNFcCvvvoqQfo31E3VnpqrHxJ0PL5CAlDRRd2kOQHw7RWnsjnkMqdkYldO7ERfCEs7ycOUAeV9aBKUsGWjeW91uaBN28t4jQuu+Qfv5SVuoCrukJukjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:15 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:15 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v26 06/20] nvme-tcp: Add DDP data-path
Date: Fri, 21 Feb 2025 09:52:11 +0000
Message-Id: <20250221095225.2159-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a5a060-a3ad-4737-2eae-08dd525d8f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zvp8MnZogZ+KyxSbeG2TwQMboVZaj/jkzRNtRr/0qZsHWQAP0KO/V/0tixs2?=
 =?us-ascii?Q?fMxO4CZwnD0BrUvsZmwkLxW4KFCW3suplKFliz4RGQWILxW503BkDvWmEjK7?=
 =?us-ascii?Q?ZrZRBpBoYUHGggatd0+whEZUH875t/tIK0pSqcjDpagg5OsKbNhciyts/UH3?=
 =?us-ascii?Q?gTvo1jpn+iVELYNpHdjZMsYXaBp3j0eHPam1hlZlI0IPAqBSDUzu46l+IYTb?=
 =?us-ascii?Q?QV0TzLiNJXpjIToEkrt7wrJ313wqefodOBq9ctXy3R81fWbOuWkrNaxl/plR?=
 =?us-ascii?Q?6HH5yB9oIjWKE6TipauKeEZv8S7Xwr0xlsdZ7mWAAVDmG039fEbsjyVgHKYg?=
 =?us-ascii?Q?L7FJ+UGLFhZY+jNrezZPw5bt2oZ6JbvITPFkUrKRbuF22IVFSZjr40Yao4Yk?=
 =?us-ascii?Q?IJHYd6obRxXfc29nsUzpC76I3hyeba3zT2WWcZjyc9As+h6DXdCHCFJDGvV8?=
 =?us-ascii?Q?ffp2mFsN6JzO93MbSRSrI+aHfaQhrmVLQyyxz2BoRWYJ5FqempJtW900do17?=
 =?us-ascii?Q?M4xPSTTMzZ2UR/P7BQpH27J6jRp5XIwthwdDlTdOOsLB70FHn4hiqpEIbiND?=
 =?us-ascii?Q?VHBt48vOvF4cEj/Ild5aTDxzUa2V6cW3j2ERQDCNu+5yQ8HjElb1/jDhna47?=
 =?us-ascii?Q?BkQIcEYymuxehZPJw1Nuutci1yhaFEe7Z5J/iLLDTOowahCL6xF0umayGlML?=
 =?us-ascii?Q?ZAWi6dCU7VPBLMU+VbH5n1AI2FkA1oWwh6uWBrP8ibp8zxbUAOJZQaznggCh?=
 =?us-ascii?Q?cZjDXA9/HK4oSrzaYfrKmF+NmUJjLYKr5jJst5pMfVpAtZOrDiH0a5kvRhil?=
 =?us-ascii?Q?QIQv/tijMvH1P/UAzKtAcn1xW2IT6A+XYyI8i/myFUPlgLBqpv1BNk8YVfTJ?=
 =?us-ascii?Q?7oW9/AtxQguDpmnXe8FuuaGr6c0Kx2zopggzyAEmxymULJLPwZ78V9zvnRtn?=
 =?us-ascii?Q?WyGXGdRzUcg6mOAl+eiZ4AaFPMOfZ4Q4K8tmSciyKFE1C9TpuphCzCUenfdH?=
 =?us-ascii?Q?sK0N7F8pbcfFOep4gxu/fyXNGClKQ7RZyMjCS7BZKe5XXmq8hZQSTwNRZkPM?=
 =?us-ascii?Q?kmPiPXqYiKBWeFvd6rwIiiV23rGyL1WHB3f4ClEdb/tYB8TsUT61i7AIz5Qf?=
 =?us-ascii?Q?ANa4N8FTt+x8QumRup0qbACP15YVQzrTePoUiPznT7gTgTqLQOr/hmwHAX+m?=
 =?us-ascii?Q?aEwB4kg70t1o8Vfn4xaSc6q7UuJlyAOVCqnFT/iydLGtk19nBK86y6xB42nm?=
 =?us-ascii?Q?78ckzN+9EhkFfJa6oIg6BarE8qZuTmfP4BoyxuzKmnsaXj0BW/fbrXXlBuiI?=
 =?us-ascii?Q?vy1kMLdpuNhQHmDYvSSV/5z1yjm4btgLh+XbITFOUDlYJUCgLRuKJTvHNoGH?=
 =?us-ascii?Q?eT1SIoQDR/hpsHwvOEuxQBOHNOXR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ES8HpFe9b/3BgVLsU3kG/PFCbnBwwVLfqAb2BUv63/aelGtyS01Gqs4dvrE?=
 =?us-ascii?Q?Z3P3EsmgPCIt1Vq2SvZ5s8LJk+VEtT1m3sUoCTofuJcqeyzqJpjsL6WQWFBJ?=
 =?us-ascii?Q?Ts0rkRJ12GTLNo5/fGfGGCGBTJJZJAS1pJvgBoowFUl5Fa8SknesofT43S1p?=
 =?us-ascii?Q?jG6E0cbzWMIlK80PRW7AO1QwRfqZSkvahUzySBMDJ5lioGfpRNXovplAOhFV?=
 =?us-ascii?Q?pAbJ790iDfGUdrj7qbOJTA5mp01qjdtzyDNUDCYEVsgbcv+KMV6iMZqm0y+k?=
 =?us-ascii?Q?5wDeQXxKsJKGJYqCRHvsiNc8ar51Dc2LoGoKZjkyceS3zV0Miedcit3etGuX?=
 =?us-ascii?Q?oDGGHl3r2yM+FqoVCFzR6RZbYXrL9NiwGhTJEYJ4ey//4HshAuma/XF5qZvL?=
 =?us-ascii?Q?k5TZgMYxp7BYlaxjk0gFXRLqVnm6oyrl21I3eK/oPm0XuqJc53xSRjqjCDb1?=
 =?us-ascii?Q?UQ7HQN+8CGYX8MPJhX1j4oNdiBWPbYUWB/zogvXjmHA7qiwYNtXVyucenHJe?=
 =?us-ascii?Q?kB8SyYVXTSS1yYI8yjkdUhPs/25sbDAOzQj9kblYrbTsTdBkCgn07Yf7RCWD?=
 =?us-ascii?Q?uTRhZY30ceLS3+lRcpxmd8A7dqrsuAvrS7cHKHRerTf1Zfj1k07RXkVh++38?=
 =?us-ascii?Q?C/l+iI0tws7SaJglDKOZN+bAdmNqPh3cuMCg2nHx8SKPMv+vqXSR4anmakzR?=
 =?us-ascii?Q?F+c17bzBk1xzbEgckpZFSLc/NKdRzSR74PTZA/zEqKPJQUAax7Ba+dfALqXe?=
 =?us-ascii?Q?3mXkC9NYug62bWZeJD2/sQ1YJfrzzMAhpgANMT0qYMtexN3pEVBHdK3lq5M8?=
 =?us-ascii?Q?2uo3SZo5dyj/+WrWNYI0fPrAXHgSGLPqApffjo6SgxTN0uaYxkKUveFjSnLP?=
 =?us-ascii?Q?yC1+4+GKiQ4Cqj0etGIzcFBSqcgL1sWatYTttJ4RD8zlIneLYRCQM7JDZVGR?=
 =?us-ascii?Q?Q9dmDfAy69sqYkdwQbDROZMEoxhDb9RISl4XpDWRR7QQwUfu/N9Ryd9Ii5Kj?=
 =?us-ascii?Q?j60FCrexZzpHZbbpYlXxFItrswLCvX0PO14SBTY2q0cELcli6rQxwIxXSy+k?=
 =?us-ascii?Q?Sq2rW45pUg60eOeOZggTZe/NMy6HvjRWao5TXvrMI/Pk6gNAOZTu4ee1kfwG?=
 =?us-ascii?Q?CpqLUOHJIHzp7DRlG2FDrRtlv7T6jD0LKD5sNejLjk9u8q4H0EtpppRiv/AY?=
 =?us-ascii?Q?9OvB4Dnl5n1pJc0UuLw/jSw6Sj2Evi/Y2JOW7G3Z+c29p/p6f+wDGYV3aZc0?=
 =?us-ascii?Q?VktGO9AUhpuWUJ7e/VoQms/ODgJHaADhK8kQ0TPOTgqdNbED9gtkEViKMK1K?=
 =?us-ascii?Q?KGHmN1rc7eyCNStoyL6+hh0sN7OWSsbGCunFhEAjZWsIROkVnQzJ8fjfO8MU?=
 =?us-ascii?Q?yVAW7YPD2xJfAXLiuK5Vq+E3SmKKXqgIOVo1x9lR67pDJ6fwh5TPjcvkn/lD?=
 =?us-ascii?Q?v0sj92ZLmqkiVKyo0N7k2BHzf/vhtxfJgOTTPOIcoYBwYrGMvw9lhYRH/jIq?=
 =?us-ascii?Q?9PKlsWMiWJrOCDNM21Kc9RfLdRariTDZ6a60TKOwF7C7IHPN1z6kIWYZ8Xl0?=
 =?us-ascii?Q?IPvTMqgEiN0IUfIM/FaQiMcqMCH2XR8wkJiVBicB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a5a060-a3ad-4737-2eae-08dd525d8f77
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:15.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8C3omFdipgpPrXt7N51HMuT0evCiamoa3o+S8qSr46h6kkyzxBAQ7HK/oH1kb8P2zPtXifX5nE+kUm9Z+728w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

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
index 656dc4b6c6d7..c16b8f9fad57 100644
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
@@ -359,6 +367,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
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
@@ -394,10 +421,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
@@ -502,6 +587,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -519,6 +609,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
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
@@ -800,6 +898,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -819,10 +937,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -1020,10 +1137,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -2811,6 +2931,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2849,6 +2972,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


