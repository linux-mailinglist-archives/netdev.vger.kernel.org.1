Return-Path: <netdev+bounces-99103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F208D3BAD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E81A1F26A35
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A224D1836DB;
	Wed, 29 May 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R8f306z+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7D181CFA
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998520; cv=fail; b=XgXjqXrTLP+0me0T5g4sW3SQarwKC/lBLWAczEEv/+AAfe2CPS9SfP7zImq3EzzIIV9sriU/rGe9CEyKpBp2PyVwBPTDHJD7/aMHMHG2QFaTRwYsl+pFlKtpDTUMoVNWoaRd2I4X6kuTy7M+XvfJftK8L4JJzA4Jocp4ZXa09ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998520; c=relaxed/simple;
	bh=Oueeed4MRQ/40lQqi7DFtyXSyj07a3mwx56qTX4ucbI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLZinJFbloJj5Tf3OLxhsUI+iWdhjDojPrYc0Rkcvv6rO3UanhlDqay5b6tuDLwMqSO+ewwl0aHLsIXpRZecY3zquiqGek0si+i/p7f+iAtm2V0QnIAeOgHeFAmrfu7hl5XFwSTiEKzFiXb0fi9RKxVCSgdw83J5y+ylGjkEEI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R8f306z+; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtkVMcul1LVYjdi599l0dgB445t+vTF+OT17Zz4qs+Et2lyMOs0qX+Yrl4Lcnz85TeX/YqCQMAEPtdZ9c0sltTfOvk0RmoYLq9fb6UpC28Scmkh3wxEbbxyjS8TJZcOdk0UZ3gk3p5mkYwMn7LyrSuvqa+nuih0Jln673yay1ZdTkKrEqhx/ZWik7b2mnT8lXm2dcsh+qXxDJuc/c/LzGhUNYSy+E21K5/PAw5Gb+TCwyukRIWnOFs4PDjDN96Pe0KzUziREO6uFJim+Mjzk5TwkRgzUYjpiYngBnR0fG8agYD4xJWTgf81dwLhbjVoELOKKaOIVeCWXLBvwPsQhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6+ldoeAB164vnJ/XG9UUMN3FARhXCpQCB2sljB/tKM=;
 b=TOHUoCDEAL/ZnOKsUljM+sANwdQPEDe1uHE1GJW2LJrxx8GEmuUkk00Qgtp7TQwNZO5nPbmBg+SfR1apHLkLslVzs5mpH6tNvjQ6AxRPcuJftUlsGW5uoT5+nHENbGlxT94wJLyWGOoP2xNJyeBcsY0pLiUpDmt687EATwBNQnoHPOSqxBkU+AdCe32wk+FpBWCprRW/Fu+cA+h8nO6cG6w4s12TS503RVytURSFUtTS3oNUNCoEwz/ia/BmrJbh2mOHHtRnJE5pWXf2hSpYcm2d8wGV2oeWHXkNRKjX1ZqaafrBvKL4frmoPbt/TB9P4H+0qLXdtVEe2AWw3K1vQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6+ldoeAB164vnJ/XG9UUMN3FARhXCpQCB2sljB/tKM=;
 b=R8f306z+vr8B3lZRwdlYb0xSyk+pXvZeXp5J8x3Ly6t3/v2TXSRx3z7Ca1LvBxatLa1yXgG5rEHm5w7xwJXFdav0frHTBpOSsKmkFQCZsaOwQt84Zes6NxuMF3shRyMEO1p21ZMb7FuNXelV2Qfy5VBurJmnXQunnzl2hV9kDjGHb3IpXWqXUvqlK6QJs3EyUU0mnc6+9dLZhaxTMJqqoASYBstZH7rt9J48ziWWTiGHsXM6R9v5J7lMEGyAtte1mgPF4jfmmLmKaYoh0YNlhoMBw2reRl9mpmubLHjVEPvGHHXusB2yZEJgl9pxHbVyF8Jwe6U3toWXnv1ZLxuzHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:33 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:33 +0000
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
Subject: [PATCH v25 06/20] nvme-tcp: Add DDP data-path
Date: Wed, 29 May 2024 16:00:39 +0000
Message-Id: <20240529160053.111531-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbe9d5a-24c9-458b-7911-08dc7ff89c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WwdVzgOrJpFeEXL3TNcKvpEXve0Ey3JLh2To5gUWfAJl13TfZVMXePYbmTQ2?=
 =?us-ascii?Q?gCD3Mb0dtKeoNsj9+3FFyA0zbLfDEl9kERduhIzBAuH8DEPfVBh3MC+YjpU0?=
 =?us-ascii?Q?z5azyDC/sdGfn1o2cUDXSoWoaTAv90e07fgS4DpzSyIYIP8dEeI+4PZLcvzV?=
 =?us-ascii?Q?kT2fx8zGQC8pRPbXABuJ6whQ38weypRAVmfYIQWPkuKGXSQRKxPUtThK8c1N?=
 =?us-ascii?Q?9qrVEyr1XiON8o+mU6kcVvrYN7NnNi64A85sJGSZgJEFy8wJXBal/P3Or5Yw?=
 =?us-ascii?Q?TGpjpJrw8EG09dFz6GjMjofAOZamx8ugUb+uMLF+ek06yk1fLgmfbu8gnbrM?=
 =?us-ascii?Q?9tiot5fUEThl2BSPoR0Pe9IsCDuHN/L3HHRoC7XZpuMdSSpxxgAVjAhTWH4B?=
 =?us-ascii?Q?Ca8Wa8WnOLkzzPE/isJi+Jsa411LHf9kOdVstkLpVX5rWkbaPtrUgzkV+Xyb?=
 =?us-ascii?Q?j2I5Q5uY9KzXHBRxT9F26s246R/lhUJ9x95ezkqJv068XCv12e9oVz3Bv1uM?=
 =?us-ascii?Q?rIEcKjO1eoFhSo4h1IIH4zpbpGQkseZCgI18uOkWFqunLN+/2oolTQRDPuoj?=
 =?us-ascii?Q?fS3Fh1TfbtnqSqQ6W+RcY6mvzLIxrNBBY5WYDBC3GOqv9yqkaxIKMovsf4fc?=
 =?us-ascii?Q?CzCyETQV4ymguDM1FliIuAlRGs2Pk9vqXMeRHz1syo3AUG4yV/cS96Eb6Xei?=
 =?us-ascii?Q?WZfGPqwikBm88IckPio618zo/61gwzzsrcyLXfPbjIEXlx2wnAjNF40t9DhF?=
 =?us-ascii?Q?1ldaVdRxSAIExtiYx795fO8+E+LOXy2r+NvYgkCnfod4g33c8SeVEYODic3v?=
 =?us-ascii?Q?IrOzmlAW+oZ1AAsaFzvVwz7CkQ+a/y8TjWueRYMxI3T3y6RGUBJpwtpppOnH?=
 =?us-ascii?Q?xn2g9cQiwQSKlOE5rpGiia4OoskVeEss8ONXXfGRkxocTS/blH6DHhIjpHld?=
 =?us-ascii?Q?VGWvr8RJmCpYtmfqTtF7thB/04VQP8n1NGoRFtxPypSIZYmblN3bS05cJkHm?=
 =?us-ascii?Q?b4tJVHG4wjj7/x7WP8fCGAoM4DaMZOLD1phb91A9GL2Q7c+Yfpo4f0QwXg5o?=
 =?us-ascii?Q?Atd5Y20AW8xGM2aLKgBeArQes1n10r8fmx8jsS9nq0KCp8vkdLWD1DsH9op5?=
 =?us-ascii?Q?8CgO0zLsrCHrqXvIKBYpvZRoaimGFht2ePKXJL0a8O3hZUEA9SKy7oMddjnj?=
 =?us-ascii?Q?queFdlllrZJpBrdsjOQCQD5sNN9AdRh2WjVFgtO+t66gQ5YfrW3FXCwJn5Ag?=
 =?us-ascii?Q?aT0OJ1pJwffhGVXB5L5gFC2nvmb8kmD9t9A6e9aIrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bsZSqGgoBcX/DmfIp3Bxek+Vj6AHL6aeTGx1LAXBaUyqc/Fa9oNi4aJYSzb6?=
 =?us-ascii?Q?WrDClQMzsdPN7/egKptEn8LFEdcJ+9vbmnyUw48QBnrxIwRCLKgGoAI+vXPq?=
 =?us-ascii?Q?zwdH+BUoBT3Qw2rQ1XbJYlXp2f0KrvZ7vVKcgiUv9PeQzC0dA8Ae6girvzvV?=
 =?us-ascii?Q?dGsFRH4FOqw6Dc+4T/lSONe5o73nGdJmpizDeANJ5LfKerO/7v5o9+ZPkR4D?=
 =?us-ascii?Q?KsQtTWDMtnvewp++m43kiEi26T6+6vMud7F9qOXbwdq0Ci0g/Nwpg2WaNbpw?=
 =?us-ascii?Q?s3hDPJa1zL3/LHgB3bp1U8/CpZDR07iDdWBKpN3cmWOraJcF05dUPQA83PQI?=
 =?us-ascii?Q?/ocOGNYVo43tg/rdzfm2ludBMRxJ2O37ka1iTvjyPdWHvs/YAkk/I07fwBwh?=
 =?us-ascii?Q?sIjNSrnJ0xtuA9WAzJKPqquVtCcS0V0TxpIBpHI+95zU7JPQlN4e3D1BN/QD?=
 =?us-ascii?Q?TnUIitLY+XI2smzfxW2c9Qn415+LyYPoOqmMvtlBoMgPhBHTFGT8plMkO4cY?=
 =?us-ascii?Q?ZMvPh7LXRsmFQOrG2bFWs5GXEqBaMvoRxRr1qEjLoTQ+FAqDxEEpISohQUpS?=
 =?us-ascii?Q?xMPPcHKWLya/B+ZrGpHIB0qJw+2EBSnAJ7/ektB3t4bZ2pEkq6OnvI7PAuzN?=
 =?us-ascii?Q?P1gTz+nuHlQ1jOfJDmn6N3jRvuauh7tpKn2oQIlXNu6eFLxf1ZdU71oVcrv8?=
 =?us-ascii?Q?j6D+Zqp5N1CPBmE8nD6vPxgx9ezqunAA2W5CT1LMFUbmBGrSx9rdiVOLZWQg?=
 =?us-ascii?Q?8abG4kssVkhJaKL7givDOrmvzzeEYcb/dMzJVFZBUcnMZrrh+2eFU17FgTC9?=
 =?us-ascii?Q?yzfNftmVyWTC/a4qpcUrSqbe4KQYPP/xtrvQhKM0agip+WG6BgBLV+8cl5Es?=
 =?us-ascii?Q?oS5/OZ8hp8naxhpMC2tttZ2G6afuPgese3MbfD6CbvZJm89aSwfP21/kLozx?=
 =?us-ascii?Q?oQXBZVIa3hAipOhqSFxqwIRL9VMx6m6JUjOXp3heXfUvu6mxLvwFJCbeZ4VI?=
 =?us-ascii?Q?2T+Fg92CBPZc+3bbawVayKdW2D5ZwW1tmQ/PgTrdfSkwbruojrnVCG8o1jN5?=
 =?us-ascii?Q?gUKKd8dMTt6p3Vv3pR/RHQ+BjQBSG4Wf7GGvOalkZPAiY7a+bVzhFMrJgOI5?=
 =?us-ascii?Q?Ux/gRdKgdWEAIs5IYeGZsUnX/w/XwUIhM4OuODVsWhRNwm24rut7RPijWosR?=
 =?us-ascii?Q?TawGpwDrGbJy+q/oNcuRfc6+/MqBgYv6Pjy6sD7qu1JlSci4XG5/299Iw+8X?=
 =?us-ascii?Q?sQkijMB88esMzQOzCBIEfQK2siWWbqI3VqvXKnvh6r3+VrHFrEPpXjfm4HY3?=
 =?us-ascii?Q?EEYhkMSdcphLn7caFMO6SNdfkD4TaRd9FeI03HEtxQ4aOmhZ6v5XB7R+ocoU?=
 =?us-ascii?Q?lcosqXMq9/K0XUyasiq/XGHU6BRdUND7wdoyQ/S0YS5qh6stkW6QwOhu75k6?=
 =?us-ascii?Q?IQKCj0RIL2oohF9Mmc8a01rih+OxyUI9y2HErv9T+cT1BcXEwZ85FHos75zj?=
 =?us-ascii?Q?C19rIFze42CHLHlSPkC53e8GO8omftUATXltD2pJX6WJe1QGcKkdd0eDLks3?=
 =?us-ascii?Q?MMIm8G2gPNJj1rD8YwbX3Or+J+/yh7qbFnUfOvcJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbe9d5a-24c9-458b-7911-08dc7ff89c4b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:33.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQThTJwCx5mTkU+0ey35+iP9vZ6ZnYUyle47VyYxn2AGNxdvEjnFz6Y38BmwRtGjGLb2iC/MGJQDNIdfhoJEAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

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
index 95a36b48fd0c..2f5baeae01b9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -128,6 +128,9 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -135,6 +138,11 @@ struct nvme_tcp_request {
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
@@ -341,6 +349,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
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
@@ -376,10 +403,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
@@ -484,6 +569,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -501,6 +591,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
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
@@ -782,6 +880,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -801,10 +919,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -1002,10 +1119,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -2749,6 +2869,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2787,6 +2910,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


