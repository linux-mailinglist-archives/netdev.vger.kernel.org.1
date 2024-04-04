Return-Path: <netdev+bounces-84855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57C89880A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E119B26DD5
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F81126F1A;
	Thu,  4 Apr 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1UOz54t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2121.outbound.protection.outlook.com [40.107.93.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B286AFE
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234271; cv=fail; b=qu6a/syx6bAwfQhpqyV3AmQd1LpBmMv2jK5G0EFz6Axbd4D5vWKinCSlu8O/Nqfyss3zX/nIvjaDLSlzxY0dDp5MQd4Wo4GgQBDU4JbqO11wyYaJfAXify8U0JSY4a3haCTZaXnaNxbjAKnoVk51Wi7WZ7OqsapgV3FR/nYr/BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234271; c=relaxed/simple;
	bh=tsUocZ4wfEkVtsXwMwdf5HNGHvhN8HpVWhk/uR4GbYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S9OyLd/HPWtPEOeGV5cKle75XBEW5lXaSJ1MEDhK8N+jiJjEBgWcxWn6LvNpLQHDM9tKNnbmkqt8njWnK5lvi0FrLmgiEHzzI3eYXC3tKr78w42QH16BDuRAkiPTSrZYx3Pz3Tw6Kzq8HrDTvB7Cq8XpdPablWxSr9r+ucmoTGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1UOz54t; arc=fail smtp.client-ip=40.107.93.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsB3V+Pkh5TtlfoKZ5ATS5z5QGDZaKKOUYqalW35MjfPkJmjszHc8++VyQUuCgSl2omBIRjHkVsOb7rgNhr96NPM/33grzGv2e1Fqxf7Oo3N8UeM5jaFOaIzg9A+g1+UmkkoB6AIOPIZq//4PE3Ypi4pxS2pGCQgYWFoJGYJQUMEyQEbyk6KGSkthwFkcmYaWtyHLbMcrgqVfFQqlWjwzjNqLbq5JKJQwSU1i/30W62EdbdC+ER+k+ZvW/HiZv+vGUPt+2YPSqjz2Sy4R2WMBbuTzLsPUZPbwkOVldRqkBpmoifCWDXnnCgvLV79nHj4oWLsOqFbP5krnVur3sKowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDI+CtUhWhntIoaooqcjRWdBmOM1rzlwD0WoGKJY5VI=;
 b=btoYXURcp0vV+3fV+Jkpl8r46Qu63Zw44ka27D9l4kroagrGGPMa0HgaZw/XkEQJE/3g6jtc0XA9+Ivsi4ibMYs9XFIbvQY9BSpakq5fpNDMY4XIgOpe0ypYVx2cI7ygMOMSunxqp0Zr2XohVZtDMFwABrhpTp/CWGpsQQEWK5gX2TD3RLMjQ01s8wKrU9gg0VTTi1+S5VtQiVybnPuHfbDPxBtWq3KpeYst37ni0ecWcOeS/yHjNh6TGIOq7svJy4oLE5sv2XGG9BvZNf1iG0JZczC3ew9sdEeguC5zeybTq9s6O+LlWzBmRqBrdSZ9/AKPcTHJmr9+kMiu3PYViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDI+CtUhWhntIoaooqcjRWdBmOM1rzlwD0WoGKJY5VI=;
 b=Z1UOz54tuX4BxavR89uQ0WFG775F+OjRXCDri1pOkX7jzEPQr9nr7yEPI68gdx3VHz4TJy8nP7LUkY8cj643cc/fxQzCoE60SSb5RPZcwqP19AEIF1gFEtQlfbqQywsrrltxAh662/cSvi5GscSiXoc3tZFI9iZG2CJ0GR0JqGYjDEn9cqiHO9lhiDThi7/OvMS54buTymB/8Ye33HYs+T4RFSe+OjuN1Zb3TezoB+pvbpNTb8Hk98Ywx823Xvgom9t7PB7Fi+cHf62C7cw233sGkxhfjalZPoom13IYtRDmv+/SuRG2YFGPqL5OomZ5XsFwvM0AQMUCWuui3KNGBA==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:37:45 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:37:45 +0000
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
Subject: [PATCH v24 04/20] net/tls,core: export get_netdev_for_sock
Date: Thu,  4 Apr 2024 12:37:01 +0000
Message-Id: <20240404123717.11857-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
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
	G+MhrvGUJyAxDIl4REM1/vHE3p1Ty4NdI8QDPde3mzBw/WYgPA3XnbbnJeXelhb5FwdvIFTdlOEsFvqTds4n+vTCKBqD1g+2/eOIa8TDanbw7YwM/K9q2+d8BRDveSu7jQ+9V18Zb4rFPKUe/DeTTKRjqqjdkYmOpM2q2tq0JtG0uPALZWCNQbWkRyBoqQjZUdH7V7UbeRZ/Q23cEJ0I4rV9d48TANjLmBpxaXbLcsPNjLzc7ZG6U4P+AApVoRVwjAjE4yUJFp6c6cbdh1riMFBSTEBxvSSfEVNFctSsR0PfYi8vqg/7C6EsTPREzOP8Hs5OryFLCO9AZtEYH1yaF7CdrlyEDCGsXXn4Uwxt6RlQxf/ro1i+sQkpI/M2mBk4Wq2HLKBh/y7CQi6nfg4aghc0GVG3RNAW2gULL6mRU4YZzOtGeFiQDqC5vMc9XwAAY2/QUVLD+xdLa0WsjIPckdtak5Vs4JolhZKDcZh2mtzXxxY+wq+IfBUMDpjQhKR01aAuf6h2XxWOpA2H2n1Nr/Ob0gNcwbinVpC7O9YgiROYVyR0cqzdw8T8USBNDRmPRdUjqX6MOcbJBUDkmBVhm/DiOnwxOPBNbV1PZMEganFEG7eKBFB+f1LSwaP6bz/3pFU2UJL0D/secNhEhjtw7xAfvVdtOCP9hszvuBrIRSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VPdM+Gq+MxxmhzO73fsU6MhmySpDwNMHJZ3z0BirUEE+neSbF1ClsVpUPGq?=
 =?us-ascii?Q?jQEBcy9zOYyd7VIzqFsTEsYFSwS0U+jqRZV3T8a080CyE1fd7uIUXJG3fZsd?=
 =?us-ascii?Q?JSbMJ9alWAsbWvMDzA9AOE57EShK6qQzWs5IasuaWaFNIMR5I+5+b+Dy4jkB?=
 =?us-ascii?Q?pPGMnKVrB5Ju9W9F3dRd7l5tyKKIVCqO+w4/F8HPydf0cMOniLAGXn9Rmvm3?=
 =?us-ascii?Q?XeH72HXwsOXmEK9UTzu3d5uFLt4N9z04NLuTgFZfCJ+GfTzT0aPUrnF14hum?=
 =?us-ascii?Q?ZG8nGrUM9qYzodID4w2IO8+rzrWlwk7Su8DVGp7gTPOF8jx4863a7EBJ+qfv?=
 =?us-ascii?Q?ZZdSv29wIRxZVCGVQi9g+gvDtIzH3ScIQ7yYRjqbVdMHji5xjUqAgo95vUs9?=
 =?us-ascii?Q?U3KKBcshJRcTQDph3aN2u3xmToQO1mdKS04DwQ22raXOkhlFgZoxkMZeLv8U?=
 =?us-ascii?Q?8wL+x5R0JyrmCl3G2HSRVDWCxSqPV9vutwH/umCw8acwmk0VJcyhgAjeuXX/?=
 =?us-ascii?Q?mtVtpgxRngnIKexnPJ3miC411EGQIgDzkDQB/UHGLjaCAFyyyPf4/fFzPkSz?=
 =?us-ascii?Q?L+Nee5EESlFweEUhYSPyCzLqsk+8LCGjBAXgy6Rvsi9F7c7rRZoSveomfpsS?=
 =?us-ascii?Q?V8Wbd5iSCpoz+pDBLzOSr1SNWY4nibd/E0xMYJ/a2OGBRRULldjZGdd4s3dh?=
 =?us-ascii?Q?7/siHYg52UZV9MzQL30zSMKXFUNz1uv7PYB8sTBE7ioC2T5yque2fX3wXCvl?=
 =?us-ascii?Q?YlNyuRuu6zoyhNkNHycr2pdGphsUPiRaIqsVOtn6zVPwymvBfe8l4XE0r6Tp?=
 =?us-ascii?Q?+JzDseTwotKgzwbDORCQlajlRRHzjkBnr0rRGs0iaCMb/G4gWaijAuSdU9aQ?=
 =?us-ascii?Q?2FoU/K1NbDaZmLjPhCcOHeJeCgIMzi3446dIOrIrqFHp53Ldu2+pBBqpaQLU?=
 =?us-ascii?Q?G3cQpSULmS/mOlKr3z9biJ5xhZqMxqPn09ihay3QrKwiDuuM0Fi0O/Oo+7SS?=
 =?us-ascii?Q?bYVJ/6lyoNp5eeT+sdA0m3ilUqF5BDZZ4TNzcjY0kybsiSpk5YShLwHLKtdQ?=
 =?us-ascii?Q?v1wCeEkQYUWO6dWvgRquEOh3N8uy5LX3HuphJ/7ur53YIGh7LQcZ0I632m4E?=
 =?us-ascii?Q?6cj/xUZWKI+ZQ4CFkxKbYqv6jkyKT8IZqPCzfXhaL8hfzcpvk/KxgtGyvsyy?=
 =?us-ascii?Q?mSGC2+IW9h9cuG05ywJTzW/E/AlTE7aUIVOiy/iJ0/nw2i7dZ5B/WSlA/o5u?=
 =?us-ascii?Q?iQZsWvYErSIzgj+AlIH0uF6g+/DA1u9G9HH8UQORSpkhE4uF8+CvHaHzMmD+?=
 =?us-ascii?Q?FMZv/had00w/TB49YF8wR0xnVUP6W4n34bDNtAy1/wqhFmGbuFBzeWWJ7B6K?=
 =?us-ascii?Q?3Lnlh8kp0cJTPDZmU2q+uz6YMqBRdHzROR3tf8n+ny6GNbiKyha37aVsxW6O?=
 =?us-ascii?Q?kX3RcLKDS95NlKZQJBoh7K4g+55skeg3Yt1Xupu5PtublnG4tQs6BDymlUyx?=
 =?us-ascii?Q?zOSylw5w6RFw0D9dnCLlC8SQps3/sIMDPT4eFmQ6MZjlI6eOoBFQxWTVD4PR?=
 =?us-ascii?Q?WTbGjypVLhdHOYUkK4OG+5EqGPF21KH8bp/h8zxN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980d2607-f749-42c3-eba5-08dc54a40763
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:37:45.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5HkdOY/pSzxg9jbb9L3HGPublq7VbfJjmyo0CjwK2GG59pDmZ13f1zKHptvglZWZDoXuXT4ki0RcZCgW6UDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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
index 2fc33d9470e5..cd490b6f003c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3129,8 +3129,9 @@ void init_dummy_netdev(struct net_device *dev);
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
index 818699dea9d7..cc01c76f65c6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8376,27 +8376,31 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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


