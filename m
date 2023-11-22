Return-Path: <netdev+bounces-50052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFCB7F4822
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C07B20F48
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E825560;
	Wed, 22 Nov 2023 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUWF0uWA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46616D50
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAcEAurIS1kzbT2BEWxrjdDCqAKHdl8fJBOnv3kH3IzW5eSj5rWb9ag3Wy96f7Z8gt64AphRkzXlkdbVOL4qkjVOHVLCEfK6H+DT8cv9YPdkckI6bt1AHuwzpRn2teib6KRc/waScIojMm9ZA95ahtGCA1/cmiDPhuxuey7mpMCn6w39KxJJFwGD+n7GuOihZ2k9Zp5yUOY0tle4Sn1/DneCYaMJOjrMVw9DF7DAS3VTeclDJx/n6VS0/SO+RHAKFplDWAH5mRx7eUr+PZWRoKKd1hbw+qUziI9SDDQjOFCjYyh+4X8Sfj0IXm8es0YfYeW3rCDEJ5aH53xloObn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9yZ5Rgqig83c3RKI32YOrFCSt99QwL5qNFDJPDMEHo=;
 b=Y/b7cAOuajRkNZLkUe+oOA6oouFtstPq3ueucz//Wf7gSGvqe7GU3Foi39/vhI89u2b/EF1Fzvn5wbYWQhFstlVae+lyKkMyxb5qpNDnxtwpRXQoZ5HPY3+DD95+0o4nkkjNRUBK5jW/+sfFBDSXL+cB8MkkZhyszJkha1QUX/s0dhvfIFkkEiI8vUM6LyGGG7HviH81auSoUhb2Dr/SXFAEYEkX0vE2JkLNFFpWFSEOpwjgBYwD/M+crkAf5Dy1BrXm0Pb2hGr00UZfEOFFTQBBss9lDDnEebUtgv9MUI/YzQgsc96IJKqC3z7PsOaz1KkPH1lq4hu6z526XHv+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9yZ5Rgqig83c3RKI32YOrFCSt99QwL5qNFDJPDMEHo=;
 b=oUWF0uWA3bcCHcm25qed1BhbBx5rf18WJ5mjCXUceeies2B+OO+t176b+H+mUbcdv95YlCLNzZDPHIRLkXmJUbTNg+8EMt3wudphI8aCjbmNYwdme8SlOQra1Hr7vIJoqw+jVbY4BH/4l3iZhjU5H/pdZ8r6RzMnd8t41wv5dT+8E/e1A/uzKBAySTW+yb2DVt664tZL8LCA5bRUcgDg4ePXje1e2R/7yry+ZVJCZGpO+SEVYqRHn092Vl3uw8mwPxD9EGjmbX7EaYK4+1IZa9gqDhp6fD2KIHvd4rAW52L1xce7Y7qSiqokvkgvdhgljP4w5kcTQktY9jmp5VeJ+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:00 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:00 +0000
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
Subject: [PATCH v20 04/20] net/tls,core: export get_netdev_for_sock
Date: Wed, 22 Nov 2023 13:48:17 +0000
Message-Id: <20231122134833.20825-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: d081bff4-39f5-4d81-1d59-08dbeb61c801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a/lkMgYtZLjS+6U3lxEnSRH1n+o8ObNye+mO6xvDgNPPSe7aTw4kFrF3HThFPTyGONVcPx7D7E613Pd1nGkIlLETX5RhQoPg2qCAjdvHcXuQJhdmNBexfu/k9Ut4ukBC0/f24YAyGR77T37Sd6lRJs5z5RvJFISYkyaZ9JlyAFjFvS88143KVLUqMs8CThApLaC4r3x6PocAezyRyikCFbOlL6XR7+0RTg0lLXmpwjkL7xF4IoMr5bhyobg8mx3+dOqW6u9YnDFfo0P2p14g00I83LHwFSEQ3cPXFS4IhxcGk6JXIR3OP4pg8mIIg3I/wVaOpT/E597A17HdhlyiaaWRkJvvF16h6R70bjdbTVR98j6wmojdm2BNTMuf1q5vilIMsWvah6XSL2eDbVN4s1JtBQAOzwQxrUGnJAvhR40pOthFlOqD6ZGfOUPI5YERfJI4Ex/jKhqG40mVWyB+iyn2VzCHQdlWbLANED05c0yV4RyzNN1BNJE/r+cK4oj8YllLk6+QKqyEnTSmk3SQd5COZvNTh9iLQAuTaXhwO30Xx4DGWVHasfzo58wUCLb3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(5660300002)(4326008)(86362001)(8676002)(38100700002)(8936002)(7416002)(41300700001)(36756003)(6512007)(2616005)(1076003)(26005)(6666004)(6506007)(83380400001)(478600001)(66556008)(66946007)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nm1imj03j/XcG6J6PjBp1Om1q7Onvrdcef12bqz3xhtf/KGzKK1ZPqBYKf14?=
 =?us-ascii?Q?c20J5cXNAqyX4FuqejwB/Qz/RqkytB1lCZJMzdZ2EnCE8Ir/7XY4Q6OpPLdd?=
 =?us-ascii?Q?8gjCEV1TVSA1+UbwlzRkmAUrEo6U5F5tF74POZJn8CMB0Q4KjFoNyhT0Yqvd?=
 =?us-ascii?Q?qNb1MtcjHWy2zWKFWa1HtvZkYP82AP/wREdCtx8Ti9nq3s5sDUZp3PZRiBHE?=
 =?us-ascii?Q?hoXAw+rw2m6T+xBs7KWg6r1vVaoR5CWT0DCNecuqamXJqnJwda+8LqPCxLay?=
 =?us-ascii?Q?hcaffStW9d80ztKjWwGLMDzxmOgtPcu5Cd1t43CikIWdrdKL4nvuTkLoXqL5?=
 =?us-ascii?Q?UdS4kwQu44HwE9s8HLCweiKMWKkQuFFG7JGnktaT2LP+su64J1iSKHh6eA9/?=
 =?us-ascii?Q?K21Mec6qi2wKRv+SRrLIvGFFYOP872WDfC5wYSQ4fQ7PNlV0LR819y0gBu/T?=
 =?us-ascii?Q?iC3+RsEg49rbdjuiQTotpTeyptOVvlAhQOw1e2p1Xth/ZX7huYmDmSauEIfV?=
 =?us-ascii?Q?9OB85a+jnHIyIYOAVh5kwQYodSWO7hT/fqWmeSCWBiPcsJy+3P5i7UQXhci4?=
 =?us-ascii?Q?5EnkwUheuk9QNre2onmQ9jrQznU8zENAIg4ftPp23DTl7ekByCZT+bZNUdzJ?=
 =?us-ascii?Q?n8cE6dBaWBYcLq1jtYkbvO4iGiIHyZ0Vgtd6gX5CkiQn2wPKhra0yHsvGqtN?=
 =?us-ascii?Q?pb8f9CHtvn+UEUpfAxuuQ6xDS+1r+ftFdaPnRRo3vHjNiFOwmhpXsgD6h4Lx?=
 =?us-ascii?Q?i6oDs3T+0HIoYIjvONh+R807U51jaY7QFLKVPCjnsmTQZLP7lpGFGmC6ccXt?=
 =?us-ascii?Q?/5H8+I/FyX9ncNLKADMDppf0gWoRs08njJFJ33pJKDymPrJJmWLISNq3DKjm?=
 =?us-ascii?Q?pI/Ocp96GoZxUd+AMopr7Vku8+/t9awwm47g7shWVBAd5Dw6XehZjuF5yN2M?=
 =?us-ascii?Q?+ffpkQEhUava91tK5rPXuQotDbdHuiaftelfv9AxAmmhaULn7SYagq67aFY7?=
 =?us-ascii?Q?S73WhWdDwsqZG+RZF6oWQKXuqpH8AuPFL/5TYfPYwRCbnczpE4o6h04zkPE5?=
 =?us-ascii?Q?vzl0/1qbfuVYqemtQ2Ee55VGPnZ0UJkSTdkEqCqMV4vP7536zSZptZdQHEsw?=
 =?us-ascii?Q?QoBua3o/npPGpWw5WeXrqFjj6ZU7R6pINZqIpzeGz2tqf2lNOdc/6VjJzEnr?=
 =?us-ascii?Q?H9IQG3G/COw+NGqHv1lMtAEt5dAaQvX3G1uoDff2uvZw5EP9KGggvugF2mKb?=
 =?us-ascii?Q?VoBfDjc2DKRGBLJH/nTxhYVMEuJ2zR/Z2F9z+gvSdHvrC1XD40NbqhgvHNsc?=
 =?us-ascii?Q?Z7223WdCpx1RDRn1skb69wG55WLrJOjNFLvZxFxBIdqrZGcqoYmJRjzCmMkd?=
 =?us-ascii?Q?H0TCi5cCzTvx0/M8J1XDwPtoqyN8IMJUdQ4F7MBOLhD5yzDcxMArifRK2kPz?=
 =?us-ascii?Q?IbFYEGOC3JZR+qgx8b8/rsg2QDcBeslhD+ufTr5+FmpBRPDMOdTYEYsnyhUG?=
 =?us-ascii?Q?yNJ4kElhetLW8Be1DDgFbaM3Y+ma1rePwxteZLpLC+/kYTjsGFOyd4TrVUqH?=
 =?us-ascii?Q?sdDABRnoiGDVLUHqft49uRmNti1ekNf1mjRxL5Qg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d081bff4-39f5-4d81-1d59-08dbeb61c801
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:00.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5whX/TKHh8XoovRRiybRB7+Umhnpxgujcz3RUPzl3YXMvbXe6jnasXffYXCOzxoszw3SpSdv1/6uE4OUF6+pWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h |  3 +--
 net/core/dev.c            | 26 +++++++++++++-------------
 net/tls/tls_device.c      | 16 ----------------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 228ba67d3378..29230cdc2907 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3149,8 +3149,7 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index af53f6d838ce..4f6ce4b59072 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8226,27 +8226,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk)
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
+	dev_hold(dev);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..fb94b3e777aa 100644
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
-- 
2.34.1


