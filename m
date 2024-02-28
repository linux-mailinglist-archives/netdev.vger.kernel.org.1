Return-Path: <netdev+bounces-75715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C686AFA0
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF48FB25ED7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB28149006;
	Wed, 28 Feb 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C69d6aPF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0C149DEC
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125112; cv=fail; b=Esf1IHJVqKDKpzYnaqkB2dX7z3r0OMb0TJybu5Nj7wUXOjluc8W6oS/6yRqDpTZMKhgFD4xQv83W3ug+SXQY54FoyT1O/MVmGzMiWM9PF5R9stbdroZFpZGB4V/5C0+TboDvtpx6MRco4kp0bdvrFJjV/BUM0lAhBxoK2wm0U+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125112; c=relaxed/simple;
	bh=PsLyU4x7dsXA6pVaXwccjfcPAqyvroMDtK+Aqj+iV3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YJqmNnrDO1dJUjstS9u6gHYocLRE14L8lK2sReynd81L0k06TC20oUDpOFgFlcC/VwDbKtpFDaf2Rop4tAYbmUQoF6A2eiuJU89vJOcpRKCBKoluRfAoEl7IS12YvjE2gJDGLF46hBRqFFVXCVu4aHbZ0iziu0/I4OESO8fGUes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C69d6aPF; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGTkXSlQTpTdWcy+sWnJX5CdyS363n7Toqn1c3pja6T3Cnd0aBVYwD5pLXnaqhuhTjx1x42wYkMI+doDv1bfW+cwDIOKkSbVYSK5QbWKC0gn/yVjUZ+Mt5hmlSKasWk4UqlbDxiwPEglM5nU4rLwqiDIxWBL2wmmJeD0gvT90s29xAa60bQjCuxn6yv36ecwlj/AgM8qIprTgGsk/8jaF44eoBIS/CVmQmKPeBlftXh7CrmPVcwGbJhVvu8w5h720qFx/aBPbZQz2vIBlEBrZsnbPNiSzbBQfk+iue6yC3yklo5BkrHnURaaqnB7+MBN0+cN0lDY0Z/w17u+RndFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbZy5ypvOMWfXq+TYtOLM9WnQXjn/iQB/XiSZBGluoA=;
 b=Sn6VTHJkpEfVioaoqwfFWlZaSZgvZwCrQiSU5Bl8wGyyhxv6mj5qUW/B69s230i8cfb7AA9/P6bmBVzpg4SlX4GGxRhSGatdY/skAliPzXzIhGdvG77oHd54UmNFrWbTSgByU9dpa7pI1LsXiaeKH8v2heQvY1cau/ROEd3tbRXIo8pOnhnzXNzazYyi8lTReH/jfKN7MHBwukR7y3Ztd08A82mN2IDQDJ4XcX84OAusRY3lPGVJLvObxVaJ5rD+YQ4Ax/vwbn9dfpNcVUhVEujmeyoy9FTCuilAq7Tm/y7A6y/d7fAvVD8BwMWIYTyohtbnlsGAjSNQtLPvZrF8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbZy5ypvOMWfXq+TYtOLM9WnQXjn/iQB/XiSZBGluoA=;
 b=C69d6aPF7edPuQJpWr+pj5pDjHEUzPrJRbCRPgiP9KYveSy7grCjeJI23nuXAri447t2M0Jgg2f6v/qCRrcMXz4MdU8pHvjKRAvHVubxfPuvDShmz5JHDzW8shFQBGQogQW9wl+LacUaSzRf1hLYBidyFEv+vI1gKo4Bqt/i8dkaxzgGuNqRfGNPpMlACt+crq+diOKP8rZrRuvEMK2w1xbxnze60bKxzIj0McywadM6/jroIFEtddRg/a1qA4+3g6KLFqmubczG8QbEP44+gvrF/MGxolf8ATlcR8BZNG9z7diRn0+LME6m1ripaeFaix8hiROl/aMGq2AUwjGyDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:58:25 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:25 +0000
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
Subject: [PATCH v23 07/20] nvme-tcp: RX DDGST offload
Date: Wed, 28 Feb 2024 12:57:20 +0000
Message-Id: <20240228125733.299384-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b64482-5bf9-45db-90d1-08dc385cf369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/3wvx+eqvawXDDLTYMyYEn6Lf5VpUEt2nGMsynCVphLyhqGDIh3ZCiw0J7WhX81XZGNq/4bC1nFZmuzeXshmHSDmGWW/VbIsbeHbZGrDri8FS5e4jxmzA87khx0V0Xov6S41OR0myCyGlrZlCqd9GFbLKcpSbt86NzTkgAYsGISwChl+XN1qSVxVzRlLe5ddpB01z/VkSsL3vDsS5AJzGDgHV4/SdG4oD1LwWcF7DwlBEzwanE4UfAc3J3dY+McnrDL5/eBVIm8Q5p/y/pBMoBEpCP8buxgJmtHmzWxu+7u84J9FzbsbtDX6zRENTUhWASJa8bDgQMNHiat9KWemjzV7DGkT4rjQwBk66KyP+gqrUPM12OVIPK1kTCz3PamaFcp0KvsmWanLni1d//+eGa/1vpINfjJpv/qouEMiAgSdaEhbSTUM2qmWcss+1aB+JEvYLf0htAh3otB9A9WOIoxWH6xt3owG1QvY8/IF2ED3mW9Fb4nPc613qK3A8/rv+Sev5n5mBk13NDdXgsBrbAmvKis+pJiL5gNA9eycuimzFD7PQDKhNGSHfcrdbAKF/BY0H/7T9GhJ1PPlGnXy7c36HBDnx2+shS6FUEubEkAQNIBCuwCtZ4y/OSFOzJg4iLqH+KFri1aFyhQMe0WEkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ediq95VLpXvjVdQpxgZJUyRd9QqRKux1tX3vbjULbRpUQynIl9B0ZWn+Ob0V?=
 =?us-ascii?Q?cLRafffZb2vJcLZR3bAQ3q3nYdPQLN/r66p1a5T4sA2zyDOTVVXLpf2khTRK?=
 =?us-ascii?Q?20MDaz73zJ2m9VKxdf+hxO/vqnNqCZcjP0tyr7Z44w01pxA9c3Ytt96YuNcs?=
 =?us-ascii?Q?7fL3XISc3l3oPQi8vLlUTenV+es0lUN/iRz9QGZxtVo0y1dWWTsxLEhtu22V?=
 =?us-ascii?Q?GEJ9gH9S/xechTENUCQ+P9qmCGsNwGwpgH5NyiaSimCIVSahQYQxFwpDbc9s?=
 =?us-ascii?Q?p4uGXJndzg9tBmWhXZE497+w6PLlgNVjgubvX07hNwzmmH7KWWaj8Xj4JOIW?=
 =?us-ascii?Q?Cn25+xo8TXk1Z9vlRNGGaVIHo09bQmsJUnVAIm/73aIMctayaIc9NuJiK1gB?=
 =?us-ascii?Q?0JzXRySH0JPELcPY+fqyml1FzNp8Ijqri/CrYmJfiMCKDeS7r00cKB8Q2UDR?=
 =?us-ascii?Q?5mP2ctX5u2vljCzQqBZDM5oVL+ZzNRgKx/OE7tQhtVYcnQMgvvwzQHhqTdJh?=
 =?us-ascii?Q?xLVizGGBVdMoLiCK3UZOYMA5Y/dDl1cqPq0mJTRu3PwAznN5nH3UQg03y7/+?=
 =?us-ascii?Q?7MWey55zIBhC8jhzEiRteqcat+Rj3g03LWqY/IGRrUxTeLHoxq4V5O489fEP?=
 =?us-ascii?Q?jkiTUO83E7OES3Ut5rF+dFznlr7LZfSZ0Obb+OfGLdxF2ScQcl3RNPdd6jSb?=
 =?us-ascii?Q?U9R0oEkTW7F68u+9j+l0zUjh+DyXt8da0VNLsnIqCjSliguEffwlm+vv7eNE?=
 =?us-ascii?Q?zC1FtX2t6oHZW+RzfHTldWo+Pte+N9ow+w2EdUNpo0qL/MQHDAQWszFfnvZu?=
 =?us-ascii?Q?A5RCMJ/o22SOb1gTUZVPPbZmLmfFQ/tcr7ka8RHQdGEgP4TAbGYeXX6R1ouu?=
 =?us-ascii?Q?tS3rjtawDqmEYmYDDqhu2szBbx+nOM53EPWPas52x0T1705eyIbnnjPrNT8w?=
 =?us-ascii?Q?T4UOT4RXemEChFPRbw7sWMX0mM7CbJ/KJP5rzdGyfaWrQQJXw55prnRDMBam?=
 =?us-ascii?Q?nU3I+ekNvR8eFbLE3ruy8fmqSrh7CjHTDYheZxAhO5+PUmMZyDQbUp0Tc/N0?=
 =?us-ascii?Q?BmsGES95Y2ZmT8A5LDLhR7kzouF/XxQO5oZ5W95THJt8MZQFkHCZ/GRGlMNG?=
 =?us-ascii?Q?NKs1AKJprMBc4bdVk61GsStplTgOJPT2E2NQfge9BnwvYDSnNvsPMRmT0SG9?=
 =?us-ascii?Q?m1Z1Xo39dtJmonacuhkBBlyY8/7Hdo9nu36xqykAuInfRtcVuI/NkbEF54JN?=
 =?us-ascii?Q?t5PgQWiGxmfQ3hM5/0xbn6m8TVWy14xjvOKZJ6Ey7EUUwQDZAVfQRJYokahN?=
 =?us-ascii?Q?7Rmmo4C5cExgk/LmJc/SzwCCoGCUQCjZTP7H/gk3hx4bpU+o73qp+SOOt1n5?=
 =?us-ascii?Q?aTj5DCA6Hu4iDC2Ng12ljA9/NeLNvfdgc7XhVuQ5fB5MOPCHeczCAHwVkrul?=
 =?us-ascii?Q?dB8wa35fkIWf41pikn1rf4/dMhLwxqOvI1uVE6lu/znyFJ3IBr2H6cwAtERN?=
 =?us-ascii?Q?hcBE0Us2wbjQZr/TpIxVU+Pp3eGYKEKSB/HsukKoaRLT/ZQlqTZ1wjJqVnD8?=
 =?us-ascii?Q?e0OU0FU/hEVZJesZiJnif9CM5TQMZMWaQQ/Al07j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b64482-5bf9-45db-90d1-08dc385cf369
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:25.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt391SguxA2g79OLQTld6c9VhY2HCeSiD+lNdxWzrorlMn0LcKj58YHV7V00ESzfeanvx+Lieso2jj5nM6QvLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

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
---
 drivers/nvme/host/tcp.c | 96 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b7cfe14661d6..2eebd9d2aee5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -143,6 +143,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -180,6 +181,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -393,6 +395,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
@@ -478,6 +520,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -485,6 +531,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -593,6 +640,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
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
@@ -853,6 +914,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1118,6 +1182,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1146,7 +1213,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1188,8 +1256,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1200,9 +1271,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
+			goto out;
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
@@ -1213,9 +1300,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+out:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


