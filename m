Return-Path: <netdev+bounces-84858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F8898804
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0DC1C21A34
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6508A1E485;
	Thu,  4 Apr 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N+xXX6wp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2099.outbound.protection.outlook.com [40.107.93.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD71B952
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234292; cv=fail; b=LKcuoXHtEVw7iVL0eWmt03DgjJ4Im8qSzs8bTt6s9t95Dq2fNKmJuQXvuAGpvOt1wqE2b03Vh58cLYaksEHnwVxVpFMHfdjAxz4xi2SbUSdhPvvAICUgCwUDufrGKIwOrvZiB7dzjZ/dea6Dm+7+qVMGvzmSNt3ASHCKN1azt+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234292; c=relaxed/simple;
	bh=o4r6TCxfvPxR8P03kCp7ZdgibRqDBpA8rmmfklOLrNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHrrj4xjirhtCCjp1KDYpGcRv7kfpR8574dwrOZwXuTBmmhH0TOVS/qx5xoLt0QOUWyZSBjoJ4sOefe5aWxq1/tpf+7w9vPNHKxApi/IpgywQfGhn9Ke7+O7zpfMhKWiEY2Pvr9j+0Ok54H2Nh4eEgeJunWP6I36cn//l5CZgOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N+xXX6wp; arc=fail smtp.client-ip=40.107.93.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY6aOjJFKIwy6MHeF73kovreqHCO4kv477xbUuayfCP5S+jJqDQ3rZVE/t++PUsHKw1xsgSIIsmw3jbwONhH7oBuDa722nk2q6jIW0nayx+TgtcgJukTLnSphjx+ABC+r/HfjQl0ni7qz2+r5T7VC/G7vV09RJRb45UvrEKAOvaB0yK0XIVwMlT9sVOvTNM+Iaf72YPJWwFvNVh3EEM28MGj4DXzoXJ3V8o+Rj68Mv28YKLwQnY0Nu6aZhAheGe01yEZdb8sBYbqGFd7jUb3OxzCOTJvWJy1iV90iDh+j6MzKFAm/tj6K6sGv97BrpgDCxlbtfHgZlO1ZBT6SCIWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyde7NogmfrCY7D+TJ98YDOog9lObxY1htqDHg4z2qo=;
 b=If2fwqJH9d3LnmIKnRLqsKAASjGXhI5v90oKtMx5SRKfnm8WLdNMbMpup3sR4LEyN116j7iirYVRdyhbZCj5BcGllAgPf4NkwyjuYbkEsVhnoqRhNXzBhTi4lwzjYW31zRWyelGhfU2iMvTwXri+8MlbT/6l/8LXhRXHuFGzktW/+s0+yChrIjjP3vJxb9NzlGInzduJsR8WnOtGhbYvmexzPLcctIGaB+sGLbGXpmk9xcVXc4gJw7Zp+bsV9GqeyUC8pgWWRVyfmst6KS9pLmuG/vdU8MWcQEKQ0OOemPJ4Ip011JCM+7SGV2yZcxV74/yFO66XwfVYWciHjQGQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyde7NogmfrCY7D+TJ98YDOog9lObxY1htqDHg4z2qo=;
 b=N+xXX6wptaXxPoRB6j6U86CXeQztLs8/aLlxI2zK33tCMPiH+DkeTyqVhD4xh7Yase3qlrli7uMCVPsU3lnq2SWYno7Xygn3GIE6q507tCzdOdz5u/WurQNYXSN+/+GzUqxIAhMFFHGhxcNRu+NQYS+3K+Trqr7RyfbvjuTlyVKngFKpAbecsa3bgrldEObZGpLid85oihQOARav5G5B4bsSUPED+PMX97InK1NihWeOF4xfS9i1wKpRSRLeXp7uYEH/BVntGM4TMEPlV6vqnua+qELkHtyuaICCHxn0fNmOqgVj1mFW38YnWGKSTmuCSDriRineVGANCpz9KhY3jw==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:06 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v24 07/20] nvme-tcp: RX DDGST offload
Date: Thu,  4 Apr 2024 12:37:04 +0000
Message-Id: <20240404123717.11857-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y53Sz/283k5cO5/FTu72zsFikL1KdF3pdljTp/i5YKtU9ggjB2zdDRxTKEQO526KTxOpP7BsX+5oDW/iImcqjpSimYI3iTxj8ZL++wlte1BO3qggwls35r/tAHApkMslJksmslk4fEs/0WxRu1uDij3fLLPQo9E5e/KPWCkT8F42EI9R6VbVcsBhAiN6OiY66DA94zSGiNmRbdPvdZzssO6KE9Zki8Gw5napS28b2O+M8muOPgrIE6yA6OHfXuFT8pVrUKWimNNuh+kdUdj8hnCbXgZGlUdSwEvcXMWmGlLopSxxIbn4wqHU57aJIBMuI3UI212aNSXSb+KYRp3dJUCyTRW2A30rZ0XYbvBXhkV/olO1zXZuAxfrjImIltlznJGPM4RdfdIfQAnhuDrIN4n4M5WfT8HOGgeaEfzllSmcpTKBd6/TrdX9DQT0PE9KLOF/TnoHdczt5NmsE1whNgI+CDNGVtGodO6F2lQMlZIDgfcOAfIjyt5wS7hmSB9WJPN9KR73+BtgY2CeJJdgXsUNXDaZNULy5QaqZYMbPkf65xuwSfN7objLQ+8bMiUSYNoRKVbWAPrNkYAeYNRICTnxFVmW2p1+rrAS6Z073GKxxJskC4jof5iLruf21rRUHHrCR07Gsy6StcBeH3Cky84lmYKqHFhsgsUzsekWFjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAUOcp7vjVDnV3GiEi2xUXEuS1+h6cFIJhQsIAzQ6zMSKor55Mbez2J56eQ+?=
 =?us-ascii?Q?fKYPI1v/WaMq+MeBUF3NXXS2cS5Eii8LE0J1YlV/9OeN7TfekwrV6LODdxlk?=
 =?us-ascii?Q?7Vtt/vgb1QCQ/q4Pz0aXNRcStf3eV2hEwB49T3FYUVp6xbwsPdXlFl2Sz6df?=
 =?us-ascii?Q?01n0OFpG7iJtoaQKUJSMuID1zzDLSWWKUj28rsJowXfHo7ZcKvDtbf+OHhmB?=
 =?us-ascii?Q?ZfJYY/EB/JeqXzlLJQz/dLj2ckHydvwfh0TlhBtXd/ieNBeS2A40XYM5aMk+?=
 =?us-ascii?Q?scMA+QdvSGwXFUAwR5axKBeaIGXHdvG0NzwTGEppjulf3uvNyHvWstPxo+qG?=
 =?us-ascii?Q?glsKujWa0nlb+glahK+Ky7nAJr9zDZA2eeRFbyHCW4inqr+DgH6DXoSXDRz7?=
 =?us-ascii?Q?MsuC0vgy2BVZvq3sihInc5gAAEPl/DNd5e9GRo9NZbeg4RmKkm2MsRm0XcOn?=
 =?us-ascii?Q?J/zkjFYSwbQlQXhUY1PbF9+zTOOUFt803jUOoR/mc4ybLtsI3ojXLI/AfX57?=
 =?us-ascii?Q?pj8UiG4/3KSvRXXH8fqD3zLoMj0r9laA4si5kwgUcPQwrzFuWZrPkWics/TQ?=
 =?us-ascii?Q?Qyx6YG7RRtNzJyr9rpnK5lELbLBD02RPuIZJWdNN/S6OusPf0Ls4NaEZCc+6?=
 =?us-ascii?Q?mRezjhY2/BRu3tOPbb4HZ15PQWV8Eojd91lb5nIbZwnWqJtsg64uoXpobigm?=
 =?us-ascii?Q?EkqO4tz3eOpU+v0ndi7SyVUB3PPzYgxdyPNc/1yzJ7E+vyis4llMBzXAXwun?=
 =?us-ascii?Q?bhMVCPtvGrEn/ngAVhQQF//gF4kjZq6TbYbTQV3/FW19ClO/8IqheTFncqRK?=
 =?us-ascii?Q?lLiZ0oIKEUAIlYnSqEteZ/nzbtiE+hphAImrj7MofcJeW31e62i4LVJqnYIi?=
 =?us-ascii?Q?TU5mNUiI/6bartPa/nG2q2poF5Gj+HspgYdco/ewiVKYwQmyMTHeH6XifdZW?=
 =?us-ascii?Q?HFhVNJ1OmLuLBo3EkUi2dABu/FMuicfshUQQhWqdak6yFW+xZpCLSwUuTQ3T?=
 =?us-ascii?Q?quLidBwTBoQ+MCzE76n2Z+IoJ14r3vaM0LpbDGWDActclfNQTzr0ejpDh7DN?=
 =?us-ascii?Q?IAgHrAIgzT0MRZwglWIA2p1AgoExuiQKGgtm2rSPDOMhJSTSIcIv5cXOXuSd?=
 =?us-ascii?Q?SkvYLXF6t96u02moDxRI9La+weV8BNo64Ob61rjmy54BHb++z8Ks8WVszcu4?=
 =?us-ascii?Q?2LchTYCBAv6DKBw4CHa7SCJq9rQzdSNe2ZVmPIRjQyH8pc2MJS3t5kzAjf9o?=
 =?us-ascii?Q?JgF0q40DvNGCDRiqOGqvt588aqz1tUXrovN5ABIa/TpQMHZk9XBdKNz142kN?=
 =?us-ascii?Q?MPw1mAV13i3ZFrQjOUTcMQLV+gul5fHzip2Pm7BUcv6THQVHoKhstruPRC35?=
 =?us-ascii?Q?JQSmJIWtXXdO2ieNx3pFQwXU1gBtzeZ4fSkA7e8aYZeHnLuJVUA4y8dyvFAU?=
 =?us-ascii?Q?DF3Jz+FEq2M+G69WaIjDAy5BjIItzRktKznnAN4HVprd9+aEV0xJjN1B1frS?=
 =?us-ascii?Q?6YEPUHOevb+ZUFe0n/A5MTluXc0f/7caYsfE1RY9xOrhCGRoJHGTk0gHEob+?=
 =?us-ascii?Q?GYHW9DN06YbEj+tuX4qPYyx1Hu2r3Y1gCYQgAQc1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89ef81e-8278-42ce-364b-08dc54a413e6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:06.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI5sLllrRhsy78YoE7ZGa6kZqp6UbUQSfg2DZrDl9CS9uZKNCNZgHN20KM0q3iHfL+CtEQZQm3FcwEjvf9cVrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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
index 345c7885c476..c9b307137569 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -150,6 +150,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -187,6 +188,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -400,6 +402,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
 }
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
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
@@ -484,6 +526,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -491,6 +537,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -599,6 +646,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -859,6 +920,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1126,6 +1190,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1154,7 +1221,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1196,8 +1264,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1208,9 +1279,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1221,9 +1308,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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


