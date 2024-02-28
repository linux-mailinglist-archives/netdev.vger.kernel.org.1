Return-Path: <netdev+bounces-75714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A23086AF9F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BFDB26568
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23FE14CACC;
	Wed, 28 Feb 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKvw7jdY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017414831E
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125104; cv=fail; b=jUHVanRgda9wFDkHi7Z+1ZDHBC796xtVG/xkY6FfRN9SExLgy7Zv5yN2edRXQJ5rNEPfS3w3kzimkqmzUzRt7qlySdIvtdcPTLuwoCs18g0EmhkQiXb/WADmIRPQEUqETCNZYBui1ZZoPTSMxlExqopFSMJHpLuDbAu8fww0yfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125104; c=relaxed/simple;
	bh=ptyiAxTp40aWmX7G0+W96ImxZAoDnZqHWpMMS1Nb1+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJqTCcCLLyD9Sn/2ppof7GdEYbnzccWr2aGrFUcpMhwmUbXrJfcS9ya3SyHZg9MPL1mHKorI7QH8uPOgofsYGHdxkR0SbQbcfFwnU0WhkZxYusc1TGimGKOFYm7wxndsLj4fjuSMcqbPqhknNMz7UZprfaM+E8ifMIz3W6TeQlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKvw7jdY; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/qf8qqcXub4RLn8ksSxVRn8BKaIaN4fGULAMjUlF1ylt2nyYzLafr0FZ9LAhirFEMojCCAdmldqE4c24TlWbI8d5vVFeQ3uLfp/+jAeN9JT3fk1T1Pbz4KXoO6DUgJZv/A9qBo4Mgk0upzaJRojA1Fu5O6gzrjF+dMlyBwTNHamuEorlcDRRgQu7sjxSdjRHjQHLboxr/SztcrJa/aIeJikBXRgLEoiFyroHIvnj5845Pj5XnMS37NrQ2COzxe+bCcq/lTarTHPR2wpAIgbBIWKBgySjoYwh4ZXTdB4XlxMe4BhmmqbtzMOXhezLyUHzFDnR1XCpWW4T38yZEp+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph4u3VPfStZG2Hoxuob/umOC9c4fCOgcYeVo8bJ7QTI=;
 b=UCEW9cfWufsO2QUqYk4f/UDGLYbCFUgVeVL5CPSEU4T9O6Sge14SAWpCNfuw3yLo6TZwu2T+BY5r1JZjpDM8PyUMi2lE8RxRWNLwLri+Add62/tc6F/EDXyF/9l12PFBzCka0mE/fuN0+jHqJXL2U+vvJNoYItMeaxEbg83DMKqrZaT0QdzOzXbSqIBRXkyMGf8L6Z2/61MZWH2qJ7TblTGpwVLMbtLRVjGpSeL8zhXwpPQbu3W3AStTGVuEafdj226FJhzkq3EQtbgNhr/MrRD+xzM2rhKB8vJ3XieUeg/yDAqEwvEmZPOe8/9EIksJdl3Tw+D8/CIx65AuekVNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph4u3VPfStZG2Hoxuob/umOC9c4fCOgcYeVo8bJ7QTI=;
 b=CKvw7jdYSTKwPVdwUUTYSQgpKgytpahXdpy9TP3SMWPJYcaxz5bAjYXp9hPbYLdcXbk76RBHoLjzgK7CJElJgLJwH4ohnZEBPCeOlnHiW0KK5tUyXcLjoEps6VhBkQICYcrGb6u27FP7k92FaYbc+kU3/T2kxt0+b8Ix0ez2EhW6bt8B3RIYGvaoKJ/1CXKkgz2Qr+FcolH9xybMmBOY41GVvM2m6iVtu+2ViS9ZUuvyXoN5FWSXJkA11hj4wKTPgvBwDOV2M8Rp5inY9FSjaS69d15JhKwf7xtX1sAMxohOtumFHgzAikTx6FW1TRUPrN8Bl/wLBH4fe5TyIIOPwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:58:20 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:20 +0000
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
Subject: [PATCH v23 06/20] nvme-tcp: Add DDP data-path
Date: Wed, 28 Feb 2024 12:57:19 +0000
Message-Id: <20240228125733.299384-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 400e71a1-cb66-427f-e010-08dc385cf05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9B7iDORmyCUHM4MbZt2x2XqNsAqfbbRCpyQ74PcEptYj6as4NdzKenv7jU4RGqMfQl3e47aIQ3ig81T8xlbIiFT4h74hLwpAtcoW1NOpwZNr67teytSlvQlQ7X+AE7KfBQ+ADcZowcxiVPAOSKeAvHtxkc0d83BsmpfkayI/zFSIFaNHSQM9X+BeQduVrYCsBTM5B84n1tqpjvSdUFG1OVJGOATfnlufenGYdtk1vmZsXoiPQIW+s4MZjPrFVSrTaIkr9zoliLe1G+YsAO4J4Z1bmumBY36sOXFyeT4BYa2Nysj4rqQEHr0OCzNjb74jrAnFaY75JfvBWsaI3SebO5e2Kda2LKMp+lMBz9kPM9v3mwuYr2S0O+2QFqcfQ+XB5Eo2XZiUvk4PkUObQXqi2Z9DPzMUq2x6N3g68p6jch48GUdlHZkVPtVpunYeQqPlIQm7L2C+ZRPLsLUuqJYfpN/TMYbLAQqSso4k+ezCBloBIIxBoTZZ3CTqE/Di9JyBeFwdXqbrU4i7ZvRsUGxtxRmL3hVU2eU3zKCmX+GvaVQ2AXlg0u3prj9hePxq707S7pkC97HQ8OnGMYSDxCFkgMa/L+XdltsUP3Na3eJ6VgcU8d3At8d7pDKuYCQkRzig
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+RwkT2koFUktHL8Eo1TplB/6/AB3iPZqHDxv36aPUXYy22Em6tRcBv8TetTG?=
 =?us-ascii?Q?ZxEPFjKtL2BiMuECS0wolCJMfiJyVlSc7GegzjSVQRHmm6lDO3fl8zEkmvAb?=
 =?us-ascii?Q?5DlMkxgrZingijPHAFoABV/TVgLiwdb/MQ9JpQz/q74GVtqJAXEzVEHlPfWV?=
 =?us-ascii?Q?XLegCzoTKQh9yIjD3k8BZra26O3+3lMLPU7Jg1HSweLhqIMoYJv785/F2fDH?=
 =?us-ascii?Q?VBcIqGqr7y9/+M77U7fCrzvi9GYINNHoogc3PncrKoxqj0IXszmSOyeMiu6X?=
 =?us-ascii?Q?2OVCOhPJiGcwrguvMAUe3YwFBKy5pwhDzDmlY5VyOiO4p6SL2HxYCucqCU7j?=
 =?us-ascii?Q?cOV7BY/U3K0pYx3RzSR2I8c++W/W2CsYJoW3+j4GfAhLcONYjyuTZ0tzxb3e?=
 =?us-ascii?Q?CRARSiwoG8fKxZKtTh0aKGNx3hILP3LuAv2U01Vd/ZGC4N2+Br48ZiUpSnnD?=
 =?us-ascii?Q?SG7DT1rLlqVOr52QnwKrKDyHwhusL7MN7e2kdLg1mpcQotQa3sjraCCUjVbv?=
 =?us-ascii?Q?Jjfqujg9AjnU9UiBorn5EO73nMImuqcZTlRU9LJBLUAtVvJwcw28W/SsCf6i?=
 =?us-ascii?Q?1S4V3AaWTiGPM+zHOu4K0PLFvbivAz9lPh0UhVX16ADIWglM4K66Q524HC+7?=
 =?us-ascii?Q?9ELS+3Ghj83v3TZhPnntH/B4GlGqGm8wXHmTMh32j9kCNlocHSrs+opDWtUV?=
 =?us-ascii?Q?OzNI3sZmamysZ8CrRAwPkVH1SfkRNK6HkTu1BYOUgYp4XUY/ZXGLdP3pye6e?=
 =?us-ascii?Q?oSjaaUfo7vyXqFS6O3f78CqWwAGBl8AjgNgGD3YHfM2tlVPZfhVJNDsHLsy5?=
 =?us-ascii?Q?3uJRZn/8kU7FjatMVlyUkKoTtijanb/b+N0/O6RpprEYkBH8kBdbYkfftOiv?=
 =?us-ascii?Q?u529VTnNbz+e7H7Dldr5w3IO0JSsffP8iMm5Ci8WoHndr5MLikYLiGBnhaGI?=
 =?us-ascii?Q?mevndjlS1syr1WcNEU6lW6DWv0UvTfMU2GMdef5WiEfrnB1VNXiOOoUdQRBC?=
 =?us-ascii?Q?cKd3pw6nQ0i9IV4b6trA18ChJDVTGbasvkM+ikun8WX82RO9QJIFWDJjvz8R?=
 =?us-ascii?Q?ALyuRgW42k3quGIg37AdGfo6wGYq1HIvVzPPDIOaWdPSV3uy1s6biUo4rKPP?=
 =?us-ascii?Q?IcNOUwCt/a4VbU+TkWGGxl8rZYaUJYiQmTQ/Z59OqBnDg4O7prxLfna0Rneg?=
 =?us-ascii?Q?uIyNDH2TlbemAC4s/gQtk7/fiHsUZ5GTe0uaubrsEpsCQkBLzgraPmzuAvzo?=
 =?us-ascii?Q?dngvEwGr0tAvLQNqp+0pIytFRGWLikcf3aWKithO9mo+TDVd0OtrlvEnVgr1?=
 =?us-ascii?Q?Yd0nJdmp5z9ehKfP9JnReFefqfAPqZSIStG0h7DV6ltI3QdO3fswXGamgHzc?=
 =?us-ascii?Q?yhCErJFR1IL8DkvrYHf7Xec6L42RaG4nIQg+kFGXyiVE2pwMOK89HG9zz8ot?=
 =?us-ascii?Q?EVv4SihqhsbkkZOK0X5kJ+iTn9ZgKpLpJqEmmHaMsbzLERLADyguH56Ypf3n?=
 =?us-ascii?Q?sGipmha8v3Ao/rmk2O+hTC7jmCr+FvhvpOiCzHMll03hAANmrlGXKYs/eqtx?=
 =?us-ascii?Q?Z6xQjnBONUOwCIMnH9Legk7Qfa3Dy8ZEvR/LpF0g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400e71a1-cb66-427f-e010-08dc385cf05d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:20.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07caNy38IqZ+r2b+B5E9GT/vgCZmj2wJ/OKNu/F7DSP4W77vQ3+qYDrstL08scTnVcoyD6M+8AniTfcs4p0SrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

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
---
 drivers/nvme/host/tcp.c | 135 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 86a9ad9f679b..b7cfe14661d6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -120,6 +120,10 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	__le16			nvme_status;
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -127,6 +131,11 @@ struct nvme_tcp_request {
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
@@ -333,6 +342,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
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
@@ -366,10 +394,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
+	if (!nvme_try_complete_req(rq, req->nvme_status, req->result))
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
@@ -473,6 +559,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -490,6 +581,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
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
@@ -765,6 +864,24 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (nvme_tcp_is_ddp_offloaded(req)) {
+		req->nvme_status = status;
+		req->result = result;
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
@@ -784,10 +901,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -985,10 +1101,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -2734,6 +2853,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2772,6 +2894,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


