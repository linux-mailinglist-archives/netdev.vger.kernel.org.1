Return-Path: <netdev+bounces-43852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF67D5061
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974AC1C20C9F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805D273CA;
	Tue, 24 Oct 2023 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDQiXk6I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537B27701
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:55:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBBB6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG/yQ0N/++vn5FHE34ImtYOMuOEsMCM1sYsvn+L+gTFMJ4vJDwPo8EGby5FX1BvvE0eEPaydyAa4tyms5/plAQOlZHSxZLrW8ZkTYcOGaHRO0A9q9vntGEpe4a2RpcY/7BJ98vnqO6ViuwyK0ECojA0eR4rvjFuX1e9qh4ZIxEIPpjuEndGnr22tQCrC3kfdgjGMmlWw/I4BX+1wn+6EVfPhz2yKo33Zy04k/A5u4OtzEpvnhNTqWNjyd1SA6WTKJO/QWR4ZAS+H7Gt25m/Na4Yitk5VX9Lkv+5WOxQZQq3Cj5fyZgyKtJCD3/Qir0NVrCkJW10W2ZQGQpg0X/lbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTyBLeR070VX26D6whc5t3LjpxKGLT7VUTKPZbb6sKc=;
 b=Gdfo050PAQdQFIHfHc2mi/ASGLc9XwsVDDR6OLVbk0rR1JfibzyuQZeg33TGotTW9qb1UsGld8SVrKFHzXdN21pQT0+XzlltyFhuEtSfiaHkYP7qlQTRnoTB0X/AUhX47PeMtuQUPaRNQhccHEsmsJZ2VwdUIRCuCQ5LYYnQdwCnSAJwczi55j+6F+g/HsM/BQdFPhIaIOd3Ikq8p655Hao122n/vtVNJSkvym36D03hDDnoS4pgnOEvhoFLgIbSO6slL0FVnK34Kx77kOprkGDrlITNagbGJAcee/3+bfqkYcQZBj7NlXkFq2k28MPavTkAfWf4oi/9VzMXmth+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTyBLeR070VX26D6whc5t3LjpxKGLT7VUTKPZbb6sKc=;
 b=LDQiXk6IU/5eucSqQ2ug5ZRnFM+yzF17XB0EznJW0Ol49utfWErynUJavkLAMvTQPgAyHfGDoVdmBJzeXDaE2m3p2WPGkGQLbdjGP1zZjcqE/H5FgNpZPRCFsLqsnsAXBYJNTDTPKEKO5vnpshdmE9tUXqGdP8WsIf2oyGnVIGRb73BfTxM39D5OaeUqVXdi41zYmYPLV5aKdn1FTUbSGB2fmO9kChE6DqDqxN9DvrfYKtq++CPdN5ftHao4Lc2Hvky3BAAm2R287dUvpyWX32ht+k1vsaL5Pu62+VxsErIB+qqIcVy0IH2F6Oodb7d8jYZ/RsXVjIW0etDd5Ph1aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:21 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:21 +0000
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
Subject: [PATCH v17 04/20] net/tls,core: export get_netdev_for_sock
Date: Tue, 24 Oct 2023 12:54:29 +0000
Message-Id: <20231024125445.2632-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0062.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::26) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a80cf9-ea24-4167-6073-08dbd4907b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FtxJV+dEeORi1oWPkVaSJgQ0uRf4fZPxb3Y7vXc+ZtQ1Yc1wwD2XlulFNmUXcw74jc3CI7kihUuoNN4dZIoCG4TvIxX0hm4qBroFg/vT0I+vR5FHyQK4/1auL1RrKMbikKDj6AfzrsbrHWudbNSp0hdD2wbG97CiBRoHo2CRH/ZSs/s42KGUAUQQgaHKyt9jgUx6bkNg6r71BtEAoEZEx7w3krvnD4seXNp2TnofFbzS8OhSJwotgBIZ8Zs71Z12n/0CfidAgK9TovidYEqS0mNwJNPB12hUm7XUTNjbrAzgfIREFDUgD53HXWTUN7kgj2DQCndXrAz0hKyDMF5u7k4X2+PLt+5bBnNSV4/fwg1tjHLqhAzJdcrKYi4egV/5RtwFteckMfgdnXLvlufJb2mzl0tbiVNtKr+P6JldLN4pyYk7znqe/wjdvI67Ten7gjWiHzQowarN+cK5VhRSckxdhnDva5UPkaq6g+NWZZ+v1/Q9CdngtEhn9Lgef1opD8mu4YBgtDyW+73snL7qF+TqGNuXpyYBZcDRU1VzBcTXIrMg7R0fC+9nUMaHKG1R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(6486002)(66946007)(6512007)(6506007)(5660300002)(316002)(66556008)(66476007)(83380400001)(41300700001)(2616005)(2906002)(7416002)(1076003)(26005)(36756003)(38100700002)(4326008)(8676002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DiYEjJWIai+V2PMZwVOCEamWNq6f5X3U+EdapoDNkSz8garJ+E0YRmfja5i9?=
 =?us-ascii?Q?QMOddOuW9RENX8UqdXHUud2GIctyTGhkJlG5d6tqKwyZpBMGDqrAM8bG3YJA?=
 =?us-ascii?Q?2wEcLNYUrhYgIiF4dYDD+rc1MDIT+UZ/ncKmhVKAJFkzq2vUn66XMUS+3T/A?=
 =?us-ascii?Q?cy7GIiUTRoUjwgD63z09c33a/Sj9mAl99Q7FMzz2hW7+pUeSeAwDQHxfsDM8?=
 =?us-ascii?Q?kv3VmmATVEcW9H0cBIo7RCgjTlCY9j5/ZPQ/FdTUfZlx2/UE9AkRU9ztCCoy?=
 =?us-ascii?Q?AaQPmwvCjT3AZwkHsmQWmM4ww/8SRgnSojYXiMrBTNor1Tb5g/hpIQwB+BDq?=
 =?us-ascii?Q?L+ZTq/+PAfEDzvRiHlrCshLImWv+K5K5uhWZ3y08srwQ997hpPp+xsWjWFnp?=
 =?us-ascii?Q?VK/GvkjJrxyiFU4hnVxztCo2znIHh/1pAVZwiH8CKA3liEU0UHYw/fCwYGM/?=
 =?us-ascii?Q?ixK79X+AJUNIn7Y+iTxr2x8qt1It0j0qigyergjpbIqMmzHv2t6K5QXJRuJC?=
 =?us-ascii?Q?Yj+TD3O5Kn7DPIrI27BuQ9K19a1qlNIPOR/Dr1nn/RzlgyHH4o10DNA3EPS1?=
 =?us-ascii?Q?hUa5m/lRoFhxkbimARqj1fBj0zO26oqbbesdGw3zf0j+usolllwW480C/snd?=
 =?us-ascii?Q?rPUIGlZ/OeT6mWQ6G5s5YhxMvNMsDAVm5D2C3Gjqk2xF5TV2RSpxakIHDA1C?=
 =?us-ascii?Q?BvQ+l0Tc8ccFE8EIw748JlAdX5WtmO2L//MauemoWu0A67zGMzXyoabmkT5a?=
 =?us-ascii?Q?g+fg8MXabNCNAxNpdtr93RyMhWjhIgm2UTwSQjuyGZgQn1eyNz91SeIazgdB?=
 =?us-ascii?Q?2HHOewIh9v84SnfwFTm4emLOLXkLQEvCmafQBvOYSNRpgYEnYFFV87nWrpf7?=
 =?us-ascii?Q?KirxqCKcbhcsbxyO0lZxmn0A6DIoKZ2wMuvLFsbz87JAELJZQAuJuUULOd0Q?=
 =?us-ascii?Q?mML79qUQpdcZoVkgC0aZ612b8ZKKj6MSni5A6j6isXX2UD9WzJDAeO6U3iRd?=
 =?us-ascii?Q?PljkUfnQLHUiIgldrlYZiIOrFOKxyrfmtnMdbrCKc1Bm38kP6KWvlWupJgXh?=
 =?us-ascii?Q?Q3RcwNW3+yHmKFGSQ5LmjipAr34BPowTF+lkTIyfV9levvdJkwZ1gkjYnv8z?=
 =?us-ascii?Q?FZFZV64OI3ACD3YqB3n5qPbczPje/IQdGzCvpX0IpE4JqwyQiBMx3NEEPzN2?=
 =?us-ascii?Q?yxegcw+bhIW28ol5ZQbMhJQSvWbkTX7ldHLq6ck8agbbrNxPjan+3QjYzM5I?=
 =?us-ascii?Q?NyF4cy9I6dmKuDNtTDAXmWB/eluj9FNg6VLCoFtP3exH+GSV4NWHZEARC3Y5?=
 =?us-ascii?Q?8xgn/3mxXPEB6Suw2Wwo+KSCRZjB7aqivc479xs+pgvWFYjknuR7Tt2wlu06?=
 =?us-ascii?Q?a0kx66F0pzdr0Y844RbZyup+ylEL6ADrWu8Y/8buxWrM29w5SQHzDkNA4PqT?=
 =?us-ascii?Q?oGH2w0sNT69bK1uVRjojwUyXeArgEGzLHKQGpNjK07ereQGPcPUzW/RdzVIK?=
 =?us-ascii?Q?v+9HIzeyaaG0EfmFxvudkVfTcYJv0I062LvRiL5ifla0zDALYze3wmpdGrHx?=
 =?us-ascii?Q?QWDzevJZJTqvn5L1BMQJXIlCBiKGrDliy8H5uPsF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a80cf9-ea24-4167-6073-08dbd4907b29
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:21.1297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzS/ImF/ZebkEpWykZdKpK1JmOQ9Ek8AoEyftjEDHoJPpRxze3DfCT4e5MLaO261B+Ix/VvuI9IXsbtmX8kyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

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
index c97e25e7c622..12ceff5d87d3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3155,8 +3155,7 @@ int init_dummy_netdev(struct net_device *dev);
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
index 1025dc79bc49..6762431e4bd1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8252,27 +8252,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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


