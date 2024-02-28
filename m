Return-Path: <netdev+bounces-75712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDB86AF9D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80531F22C63
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F79149DEA;
	Wed, 28 Feb 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bp1WI+cD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10763149DE1
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125095; cv=fail; b=NFf0tXuwTdxBN2/m1qBoZ+vyRLVhbkF/7KItASI/dwkmvhNJoSdHCRFndwnbrC5ZviIf1iNhqcXxeC83eSN2xsOOeJOle/oi/VRCHGkqQUdGyBb3DsfzbPM5D9mvdnSRo/da50yu2W6a8ve67UEePqNZO0a4Is1dSi18FCj35A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125095; c=relaxed/simple;
	bh=x+ojbMqS+nBq3Ig5KQM98i56xaJzbLwn+0iLQIi4/4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvQVnvWEpI/ZFE6jl3vg9pcHuNzb5bNAwvQSHa8RkTed/4+BGAOiuaW+1m+CQ8sgbfshfDbpQWUcVmsv5TXmXhuzs7VeDaGPaJGc1HbedMuzz5MjTx/2K+MXw5/Wx+7CNAWNuXHE9VgKAhYoOcv7gfuZEH9E4UDIPnNzYNOCXug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bp1WI+cD; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVDsl/oHpNKSc00C3i8cZuegZxSWR9etI3H9WZyJLG9468vOZjXu0+g4PY1QKbqLBYA1doW+u79Enu7Z36KQY4O5oSXjetAuRMb6Dp2uKDMw7gQXVVVs0uYkv3yj2gtZNlYEMm4i5B/hAeLmq36Mqag8ZQIpWzzNCzCpb1/+0jUTrxcWJXjunJKzJz1rTEou1Jbw1LLzEDVyFGoIZmAbfaEUHzfcBNiYHfb0DNNOsCy93JOCwx+OCod32v9Qy4jA3wuTvcX9OCgvHP0T5NF18g+M/yxFrpERtMsCoIfHlGJJNqJtCsQ1lntuvn1stbYEoz5ZcFNaS3aFhLlbFGKSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfqBOtuDeJTu7qfzs8wYEaS66yZiic1CbmyP5u2Ot2I=;
 b=aiOJ3bK5mDXk2zmv+ZyEBiaQLqhyxvIpn3odftntbzaWM828kpiiyJYyySH/QrkoLeq12E4IkZvKVlY6y3KDW2rJe6bVTjsW2X2n+P9mvArgZ0sw0RIpVgFS9XvkJZWMNpAlaMcytENMlW67TEn1KUZDTqUryuFBP9McimrWbmCIW6oHYEppCw+Mo6yCdWIOuKbNNqcW1p3nXpQYFiW6F3FVzYpExbXwDeyShT6/Q8WGoh4OmvRZq4vKZAB8EOZk2/tlBX0yFaaDJLXY582P9ZnnbCgQpje+wmxRFhSYV08D1NB6OlLrgiTjBKi8cZUpGanSZ24oOGKZuxNpoqghaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfqBOtuDeJTu7qfzs8wYEaS66yZiic1CbmyP5u2Ot2I=;
 b=bp1WI+cDvetio2hbE7NpARMBXij7Kp4ys7h1OI+D55s026pox/+S9bcHpXEQTwTKU2zK/sdyuULDA/z4HuCyzIjriP/ENICXJdvjcYT12hNUH9WX+az00p2YqkyLai376LP0XBTuoq1FSF5SCnKAFelpR/EaRNLYV6n5PNI8J9LsfKN/joo3AfGqd/BWVy0vw5UqvD8Dl1XdIUgVgebF4H94TeOCYNyY2NFtH78RgIkOaKFCUyONe1GwzclrmedYDeE0IUrcZnyM8Xvj1cJ48pSGyvZvT1A0uRaRGyUEeqbQsJqIK4c8XkqQS2WWHVvZ/TOC/KNAgKRCdvCiS+NqSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:58:11 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:11 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH v23 04/20] net/tls,core: export get_netdev_for_sock
Date: Wed, 28 Feb 2024 12:57:17 +0000
Message-Id: <20240228125733.299384-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b38e6fa-bb97-4577-b4e7-08dc385ceb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JcC8eJf2+UC5aKlxay2+FbLAmBpUF5IY4TzFAqEg4rTwSPsyxgLVBuPDMqtGafmNdP8xuHhqLz1jBsKi3Z74uzVt+ARfgY9cgyn0xW2rKOH+3J6A4TwS2JBQU/qXJ40ApR4KsXNMgWJBe+55VDc5hzzCPNUxk3lXNDmy7cAkbjC0wZJ1zP4NuDGkUGBEXYNK4bbh/as2tSr94UBp5panNX45xwCbAZMyyyX5NhEAkUGbTNGIjTu3hmsnreM0imFuMLek0Z8wDFqHxxLfuB5Ha2KiaTRHxikZ8qkeXZPOY2kgSTYD/BD1p/JdqnNQFYVtRZ4LM+tjOoRD3uegxvuXlIaS98OiYvkAfsRWlFnW8gjVXPZIa0plaA/+GvACPwxxk28PdNMFXQxj330gLCuUId3qWMbJovhoSQALvvjpGRrii9fNvoAdt+BUoM811gUnDyALhfckrqzdg9Vej5NvOIkSHgSHjNTFldkAEX/s20jZcLmQdn3JvBmM5QV86+hTVbicdmvbEuTRCRcsCk+7xhwA915j7EQ8fJvzQiF019JyFnow3sKvKOU7tz3iWv8/RSSrUsazi8qotiu7mp+Vg9ujuRpIWW9i2npgcCac9LbxE/IzxYBoUrwzB4brV2s3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wZvsRlCTXyC+U8zjAhrhOXi/tr7dsXH/USQkbywkRednvEsNbM6KhNKpPNsf?=
 =?us-ascii?Q?mS4VjzGkuBV5+EalDxGfOmAFPEqoLudyymk5fkwAsInwMln8ElGpPNbhFXTZ?=
 =?us-ascii?Q?w0LVRfxeqz3okabiduvTSjN0YGaUDng/UGVBovYo5yl5LVs2XT6+KdlantL2?=
 =?us-ascii?Q?8UjwbP1EtOKu+R4Ce+O9fhcg3wIIUBd8eTHVFVL7MqZr2uboV//8ZnCEj+DF?=
 =?us-ascii?Q?bWVXkQkGlxnSJrG8cDJ0q7oIDpG3D8kqJnzP6bI5v5qaIQ4RjpqT0TVSVc/P?=
 =?us-ascii?Q?H2vTlqjNcoWOxb5vNoiq92VJzQfyP0s9yjmIIRXcLVUQwxcaGRCJT6mKfduM?=
 =?us-ascii?Q?VIm6TgLA473WwX5fPfEoqQ9hjCm40RAoCAPth+Qj4MGVlS6niyeU58+ircSZ?=
 =?us-ascii?Q?lXuNhPW5EfcJWig49gcqzAv4PBueKvq/f1pTIG0o7PPQ54BecIudgV9WDouQ?=
 =?us-ascii?Q?ELIL7qo8ARy2ul9PVtmw1lDcfgKYrqe729HHjcTiL2hrbVL+bf+1r5OH0Moi?=
 =?us-ascii?Q?5p6aa5R01o60veIby+6AwC67v7oK6CinvQ1j/X3Gg2sFvmbp9ftKjmmBKnuv?=
 =?us-ascii?Q?ZwcmoPyTmw6+Bx2eqQZungU66QPbLwnGANcYUxnvxt2a2wvu3NZHTkjBvbUD?=
 =?us-ascii?Q?eTAJD4c1fR8gkuRP1HN4DfFYEd+RKp+/BKUa568kSlPMqsHMRAW/2DXxinMJ?=
 =?us-ascii?Q?oO+03OG/iJsFxJTJs+vVa0Qy2kIpm2FPmv/bUELtGfz0zhe34LsTPyw1C7N+?=
 =?us-ascii?Q?C0ZcTMa+TvOaCbVYe+0ZPReWKY5QuEJwWTNx14KvuqKeSxiJY4XXDi3lOzCL?=
 =?us-ascii?Q?w8Q0KbANhan5xdwt3XLiWZjHzNxT9ZCRF0i3NjqoTksMqD9/13NGQoZZYPjS?=
 =?us-ascii?Q?FHiJ7R6txkv+LqIL9Y5KUY9axFmDkG6gh7+w4EOmsnN/mlcm3lP9e1lGwjKt?=
 =?us-ascii?Q?jac+TO6jn+cwjFGjb61n5NqTcUqjf3SqNyZSOH1Nd2leWyUKzS98Q3itObKi?=
 =?us-ascii?Q?MRbLQwm53Y4pJ1aV/m7RfjbaIWj+QVqrrmi9qIP0I9wafGtVJ89zw5wfWzDk?=
 =?us-ascii?Q?t9P4lag3hrOeGNlvk1e5om+/XIAG58JTraqf650Emnp0M++o+Uk2CvLW6/PZ?=
 =?us-ascii?Q?RjGFCNNshOV7SetCBicHOF/6rKZAMoAmmZZqirq65iyHNIaiqo4K205fMAvX?=
 =?us-ascii?Q?fuwHbTpUGp1Zk0/HQaQ6aY/8s37AkKUzYRB9xQD1SMaxNNlowPAKAY4GEKrU?=
 =?us-ascii?Q?8FV0tUn0GKiSDTd9OnTAHS6QGkIhInLgHbC2DgZUGVypPz02TJOqgEcZg0WX?=
 =?us-ascii?Q?5WTicHeG5xXskYYDkr7GvL8OGYsrM0sgVGJTvEsjn6kcIhhqtfUDWcveHqEZ?=
 =?us-ascii?Q?EPMVUhGHT9vWSx5QqsKy/2m5wweMSYLWkzw3kkysht39rb1tziL9uWqiZdcx?=
 =?us-ascii?Q?yqCB1wpX48ienfOBgUhhMS6fLJ8flzTM6EWwMhVZ9sWRZjwtxH5RER6UHmHv?=
 =?us-ascii?Q?AOtvn03X5hyhaf51aimRzJzc57oIgErYkLIFwCaCmuYz/9TDVBXK7Q+fcpEF?=
 =?us-ascii?Q?GTvhMcOuuJIFWPqZt1Nxl/H2qvPEBEtqOrpuA/7f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b38e6fa-bb97-4577-b4e7-08dc385ceb33
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:11.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOq6FamHOlqI8URcARgOzzLgESA3fnrbKHjYT0ffUHdqKorchV66+SurrX/fhETrX2Jom06//ako6ABS06cSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core
* update exising users in net/tls/tls_device.c

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 30 +++++++++++++++++-------------
 net/tls/tls_device.c      | 31 +++++++++----------------------
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 610d0530c9f9..9dda1a5f3dbb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3209,8 +3209,9 @@ void init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index cc9c2eda65ac..e839a6b4fdf3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8315,27 +8315,31 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
+ * @tracker: tracking object for the acquired reference
+ * @gfp: allocation flags for the tracker
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp)
 {
-	struct net_device *lower;
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev, *lower;
 
-	lower = netdev_sk_get_lower_dev(dev, sk);
-	while (lower) {
+	if (unlikely(!dst))
+		return NULL;
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
-
+	netdev_hold(dev, tracker, gfp);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..5868daf36ae2 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -119,22 +119,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 		tls_device_free_ctx(ctx);
 }
 
-/* We assume that the socket is already connected */
-static struct net_device *get_netdev_for_sock(struct sock *sk)
-{
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
-
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
-	}
-
-	dst_release(dst);
-
-	return netdev;
-}
-
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -1063,6 +1047,7 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_crypto_info *crypto_info;
+	netdevice_tracker netdev_tracker;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1076,7 +1061,7 @@ int tls_set_device_offload(struct sock *sk)
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1172,7 +1157,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1186,7 +1171,7 @@ int tls_set_device_offload(struct sock *sk)
 free_marker_record:
 	kfree(start_marker_record);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
@@ -1194,13 +1179,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls12_crypto_info_aes_gcm_128 *info;
 	struct tls_offload_context_rx *context;
+	netdevice_tracker netdev_tracker;
 	struct net_device *netdev;
+
 	int rc = 0;
 
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1249,7 +1236,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1262,7 +1249,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
-- 
2.34.1


