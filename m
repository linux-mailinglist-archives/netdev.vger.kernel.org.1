Return-Path: <netdev+bounces-202456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF98AEE029
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30163A5A9F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41228BAB5;
	Mon, 30 Jun 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HS0ri/S8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE728C004
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292502; cv=fail; b=TQbKREvVRYs+JmJgr4/QcAfuBigIe8wDEiODleTFnbjvrQwpJ2OCKejSat7KAv5L2Oe7qP5IThHbQvWSRvtihztAYWvLXAnUGy1CIAPHBDy8c6BUFAwN0HzyPygIxZb+iSSzCWzhebsqQ4cls46UXVNYg56AQn4oU1x9O9aK85k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292502; c=relaxed/simple;
	bh=Als/sfrYYCXsnKYLDaGAfX70Cxs2E2wTOmyMpm2bWEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SWepuFIE1L6SCa70E7hOj0i4x4lNRgpmByLois9UwEBNGp/vBVXVDglaeveyEcwzdgIbZ3dXH5/w+5b+Ee34N4OJUlOHqGKjDRLJju7jd6DYjEVMVkGGQCX2nsElO27fbBAIg83Z2E+GosyVmEaowxB8r6zOeps+JhguMFaaXsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HS0ri/S8; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I26tRDwhYmLf9aLLNXIfK+x8mHYT5SGl9kvsgn2k9vmoisIogTbehB1GZIBhTQtbxKyFAiRs7h87iaKv9DcHRIRqL6q/TaBcUdMNdmoNLH0woiBPDl8c0pEtcTHYDWRJo0iNGhwHKyqZnjPEHF32ovDLMUIRTNFl6mjqNMcDwZ0krk2ZsHMOZFQDNxjL5Q3EPMMYdRRZQJllMIAMefP4CJEbpfwBjS5Xp63qdevXU2VpqfEbgb3GHGOp1+4y6ILItwPePeBkwCOJBx1y5zSlt/2qufUdaBejT3gZj8fRMMipfRI33LsrGomTdvY8i/cYoaiE2K52ZKmF1Tf6+Oj52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFa3VlgyU/DRbzv2v8NgT9zC9XCWdw2X1nKO9HCPMBU=;
 b=Mpa8SaeQS4p1gyOlGp6yKQMHTN2BhSGCSXqKyuN3PqxyH3IaPVV1nE0dHi1sS38JVakQFewz5S0+3kcm4rFtJro1N/bJfFOO9fLp3MBse2JZuxIlwqT0Z354sINgxbmO6C/bd9PtiOZa9yZrj61m8/HHrBmrKSxcDCwZePZmEf5Ly5y+OmI5utxXJG/7GS7cTbLBjbKIGv6OrfgcDuWzU61Y9fPNTMDlHw0GIErpQBdxt58mQ/X+42Oh0Duanzt/g0Bdaq1wa7KXwz4S06sCcZyiGTX0hpWeDnmTjWceA8FHl7ei8OTMz0dVsAozAiPzA836BfGinJhbTUhCXV9b+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFa3VlgyU/DRbzv2v8NgT9zC9XCWdw2X1nKO9HCPMBU=;
 b=HS0ri/S8I5hZRRzDOoAf/8UzqdN6H8F5WZOg2EpiVgikdzKY/b3y7mVX6gUsuTx0NdE9aNF6B/yNLktQhiZmC121Vsn0Nase/g0L/EUX53X7qaGYYV3C5HXe1zsC+qIwOOcNOofhUQbFx6szGM4TSzik+XNekaZJQefvzTNxO9JsILMb1/tnmK/XSeh2hGPNrPVCy5CATuUnUGsc0TcNERSkIqMM4agj5SZw9v3VYc/GJ/Pc5UlG+VqUFAZ4ByzxUhBGFHP2axvFl8z3gjc3x9V80feCodbe/YQ3BpB3IBoHKbK+ABwvYd0QyKmcNVXWXh+kmAHlj0KjDafKycpjcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:15 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:15 +0000
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
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 06/20] nvme-tcp: Add DDP data-path
Date: Mon, 30 Jun 2025 14:07:23 +0000
Message-Id: <20250630140737.28662-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2435a1-f9c5-4b1e-699f-08ddb7df8e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/36mzl6BIzMIR3O6h+a2UnG4fM7LQJTGUkXIWLepdenN/SLy7+crdwvZ7h4a?=
 =?us-ascii?Q?f2Six3zCct+RMJjblFAAgndvBBGaPg5dDZgUHskls7nFmkt/YOi6sUfS/rK4?=
 =?us-ascii?Q?uHGljqed1uDrYeJ3q9f5dLA9Sr0+Or0WpzjUUEpNqEiFFFzlTBmQZgFV0xAy?=
 =?us-ascii?Q?8/ha+jNYC5WLpA4Oq560j0Ab29nLH1gMgA8JmWggTlizOv8LmpUfYw6qoKUg?=
 =?us-ascii?Q?KKRF0A9CaimngXHUbgRtubFyI76Rn8xkH4K8jrQjNozrdNWu2fwSAVywCZUc?=
 =?us-ascii?Q?AI3rCHuLagu7FoGafgvYF0/KshHE1vNGhwnAZ8V8sv95aDXgbv3kA2E00c3c?=
 =?us-ascii?Q?L5U9kECF4Ai1a4yENMQs3QlIQSOwppJFt/yQ4E5CxG2ydU6sBSYkd2HIjrI/?=
 =?us-ascii?Q?ZVHwgR/KWczazhYFIEO1lpp0npnWhdDJlGqgbHO4w5HJlxxwkr1UQ421k49H?=
 =?us-ascii?Q?dPzEmKSjDN6WXQIYW7HCjxNq9FjteHgDDvNAJwu3VQ3Hy83178ZekLufwJb8?=
 =?us-ascii?Q?xZbkPHDA8oidAs7fcn60XwWwLAOLxpGslb+lVQGRwpIMC5dNVYamM+fnkMM6?=
 =?us-ascii?Q?zAUPT42yj7EEXHDirJRc/UgC/SsdiN0OKaWmU3d6b/XlxZm3h7gFACaTETeo?=
 =?us-ascii?Q?vtEjcpNB1yp2H3G8Pdflp0e3YtvmXjytyn6eJGGS1EfX1jgNER8at9fIoV5y?=
 =?us-ascii?Q?JHNw2MhGGGAP+ZZR5xysZZA9E53eEu4VUMiM8aOhy6kQzfhQQJ6V5DTGTeqI?=
 =?us-ascii?Q?cJE+Ya2CwR944abgggxqf8ZN/qjFhGZyFJ6bZ/7o29BRChjMFmbRG2dzW2IA?=
 =?us-ascii?Q?BuaObhI1kRdkmNr1YsBYO86EdRWwDcYRoq7HAJtyDjgljYz9yiYjOHxrIC6W?=
 =?us-ascii?Q?kJe7qswH9VQytdlqpCommPykOaAh1NC5PZ7JCjADnEo0smkOjMRO76jKcYjP?=
 =?us-ascii?Q?gtL83yvGptwWGaGA67LR3qj+q5FbBHvTWOOyHFBKldRLHUnVzd0LGLDttAaW?=
 =?us-ascii?Q?cpGG261rP4UQKHoUkoIXm4JCOWoZqWNZ6gAbxHxzBvDyjzd2NFYODumFrWZq?=
 =?us-ascii?Q?j03x21oc3+fzlh+VhH5Cc4yc9CiA3r12GxQximhwA87//7uMrfiX7wOpv+/G?=
 =?us-ascii?Q?/7Sd6t2bdcmwOHrRfswT0yVutt5RaugZCGKVqrsti7/QYethX8yexpxdY++1?=
 =?us-ascii?Q?pQlHl/msXkjo5IEobGkySqV62xmzvbysLobJxexSSq1n7/ebg5Fg/ELizsh6?=
 =?us-ascii?Q?8cy1yVdtQ1pkz6IFovj7ddjhwNJDLUH2u1wTLmX9ET2hdyX4+et8FA5AA7GH?=
 =?us-ascii?Q?payS+mnIa3v6wZXAbQLDDN80g+sfD9+l4Edy46ecZ+6ogj0oRHOu3STHwlMm?=
 =?us-ascii?Q?rjaARplfgjS7FPu7uPKPkk5hm9qM01nd8SIE/Y4OWSDSHxnZ+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDzUkgfT/Jg7m0ZECEoPl8BCK7zbNpaaME5ysEh4tQKTiEI823DU0Prqj9Yy?=
 =?us-ascii?Q?ao+FIiMrN+4hJ5QjIGFZxofh/9oK1HNogBhxCxP80gnl++iNk/nPJPc7zaQA?=
 =?us-ascii?Q?gx7lt4GpyzKWlYz6Ex/24jewqeYE//6AEWsGSt2C+2oZ0el7ap6ELozW/d+4?=
 =?us-ascii?Q?Nfq/r6KdeI9b4pv49+AYVGYpbZPkGne5JluMUFGR+Ybdw6uJqSH5FfI/NiOc?=
 =?us-ascii?Q?juJ4DJfGe77QkNWLxA6Lk7xlXYB7oZgCNfycOEkYsRIWQG+ZLo3VpRsYex4F?=
 =?us-ascii?Q?ygoBgeXZLq/LcLjTVWCzCle3mjKWFrTUuVAd8UjDncBcXkTXzlhdNZklScou?=
 =?us-ascii?Q?hWT3dTfk8KbJAAtDcC4mYYpHG2e68/sUaVzW5yg9iFhLL3ldtAZ17J9ST/DS?=
 =?us-ascii?Q?xrx+JwLyXdib0w/eAMTB3zwiQqVGGukshxsKthdS1luc/153UVIazwo0KQUi?=
 =?us-ascii?Q?P8hhsuIViY6PcG6EX2k6q5TmQgortc5UaYTVovBmmZL5fAvtSvwrqDX0fBy5?=
 =?us-ascii?Q?tzpcWo40VucEhuN/N0N1Si3OmUQNWb7ohs1nqIVjw8Nv15qdB8pv/Q9jDaeQ?=
 =?us-ascii?Q?6tbnihBem0q3Q4U+Zi1x8DG5hdywCcmHlPbrnNF5apPRaj3KlTT0iWE+XiIj?=
 =?us-ascii?Q?4aTx4xAyTANYrd1Kfl2VFp4rYTybaMTo15s0fMOE97hzQl3dLuIZSGz0Uttw?=
 =?us-ascii?Q?AZcgLNgyOsLIod4n9koOGPf4nAoQE9Mc4TWC7vlBIklOtG03wzt3TQSJKMUv?=
 =?us-ascii?Q?DqKSN0CUKyxY2gVhoI/tQ3QJZn5zJpb+yeGrp264VXgycrNJ9KP98G//eNc+?=
 =?us-ascii?Q?pdi/nrbgfKVPVwhV2XR5t3QbyLvuQdixlMhodBZyhbSeraaGJTofCnl5Lh7n?=
 =?us-ascii?Q?kLNjkJ5IC59YkNvgSRa30xiz4ITDIbN0Z5uSswQe+9WFeE0WzjEVUMHSkkZG?=
 =?us-ascii?Q?opc+Oh/sTHR54A/qEUTAKqCk+FxT/AP2TJY76hPukNQ3ObNxhG6BvQe2POjf?=
 =?us-ascii?Q?FKCmzQMOVQvmzcOSe/Q0V/GQ45FB43BR4ElQVPYOhe91JPWwwczA6kFzpU2H?=
 =?us-ascii?Q?8DyQ06wdQkfPXAQx1gHHAbCWS4NJ9QqBVwG59TyXgDAXBAb6nlr11T9PaFIC?=
 =?us-ascii?Q?hyjrOgN+uJJ1cFYIGpTLaV6kfbOuzXfzMVQm9QdqyVZwahssXn7rYCP40+5W?=
 =?us-ascii?Q?UhaEcKsntn+H8gnd5ZuG5PRp2FjjSFTucBN/06PmVZ+PPHmA3Yj3zzRqp0kF?=
 =?us-ascii?Q?VaSWEANrBd/qdKWDZRdFVxFR0OqWzpQLBY++yMhfj7sLrgAV6YGRvOg7ZnZ/?=
 =?us-ascii?Q?fb5+S+XDHIKMT3Z0ql/yiQswa3znofK1pncRgYUDRJbXFssCUiMrlD3bHEV/?=
 =?us-ascii?Q?KvEHb9CVqwz4sKJ4YxTlHToq5akEuemYNqL4oNOpoTf+r9c7CX1fzreKLWRy?=
 =?us-ascii?Q?FrMgt/bP8LavC/SEQoN/B/Evtvm+GFOwIy6YLvHv40hU66kMEIU8/3Im3Lad?=
 =?us-ascii?Q?dq3DDXYMYMz/zsN/VJXDSDq8Mv2H64QllxiAgLBURvLMP+xfuLlSSZZipB+j?=
 =?us-ascii?Q?3W2vgJrexg/6RbvO6S2Yz39DSdYTFtvDX8YmQPn5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2435a1-f9c5-4b1e-699f-08ddb7df8e7d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:15.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngxu/5fYxSZnMNXQWGUH5P8rgK3JJBE0b6RxTZxamyvpXnH5+FU0lARt+GAvUy2us2fZfd6tG5oFNiNuAECWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

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
index 3ef48731ec84..5ad71185f62f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -129,6 +129,9 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -136,6 +139,11 @@ struct nvme_tcp_request {
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
@@ -372,6 +380,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
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
+	req->ddp.nents = blk_rq_map_sg(rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -407,10 +434,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
@@ -519,6 +604,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -536,6 +626,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
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
@@ -825,6 +923,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -844,10 +962,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -1111,10 +1228,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -2943,6 +3063,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2981,6 +3104,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


