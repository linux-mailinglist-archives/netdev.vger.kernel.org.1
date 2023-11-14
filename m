Return-Path: <netdev+bounces-47702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E07EB007
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B675B20B96
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E5A2110D;
	Tue, 14 Nov 2023 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pLDyoEQj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA73C060
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:43:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC8A130
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSsgjZNvmJHhZACdSO83MCII2JWp3W1qeu/5UZBjjhWrhSj1J2rG0gJTN8/0woTK99ePHwm9UlXDOP9t+EjXTzQQy2ON0lq+HfbQ+yyxyvKyn9g08dng5811uIXubXaimoQDsBpg8Zuuop6SirbuyfdSwaw+wV6Al1UVPuOd42ipvA+nM7aAw6tktQuqrEUyKZMRpUZRirtX0jnNe343nXzyLGg/xpmc6vbm8ZCSypaAv/gNVlLHxmOtxe2HUArpA9cP/h8T6QazXRE6GDhW5v6wRCL93mwOBaSFlW0afx+/ZhcmHvTOwjabogdiETvTH5GTVlQqWCyx0+HmKPR8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSf8PCs7k/PYe8yxAM42fR9jZJok9RxNDt2eQDO79AU=;
 b=CQQvwvbpLLBkbECMUCbmHCLx0i8Xs8cU62Ls4tyBpXim1x3NGI3cq3Ot1xTzrzvuz00p68G7nHLh6bYn1jb/02VqdgCDbGq67FLhWvn18c1p2C2mX5ItSJVJYk68pGNmphzRvP4oRyfUsMnhPT1u29s41uoL2+V/M4msiC2nxI8MamvSL3WmSZnC4BU74WNYrJ0YkKiPVIIGgsNTbOM/NXjqJ87sbZAbVY/8gtE+qIRB69c85ktyvoEBieCFe/LrORsCwB7vgy6g/AwuFBs1WlR4A+D8qjOeVdrX5Oy+VgGEdRotOkJPLh+Hn8xyEkn5cxNo0KDvVypeo6KpjxpeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSf8PCs7k/PYe8yxAM42fR9jZJok9RxNDt2eQDO79AU=;
 b=pLDyoEQjbjbaIm7bmmRvowme5KB92h9JxBOvlwXYhrTj1Ht9lUp/+/E92MtAyLnqe0ePYYC0OFbrHGubbT3kn/TJmtm85F4Ttt4MFctHxg+EJ/+9jsmm3Y5yCdTzjuUTv7APY8SDAOnHW/S5vvG3E4TZwdZ9zXYeMXSmmwVAanHbpHDC5ZA+Ky3E7b5SSNORWDfdaNIIEwjSPbfgJY7GfDKLD/HAtZ/v3AQEabzadBoqInts+ab5E9wAT7Ow4Gyx9+eFt1sBQk/LHnEEbNgV2pv6N+j035xJe50qRGWPHhxVKdJoLwzs9hgCvj0espbofWtDTawExfCwbfbyF7y7eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:43:29 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:43:29 +0000
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
Subject: [PATCH v19 04/20] net/tls,core: export get_netdev_for_sock
Date: Tue, 14 Nov 2023 12:42:38 +0000
Message-Id: <20231114124255.765473-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 621d46c3-5915-4a01-e1bf-08dbe50f4d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WCE3EoAmXFoXs4UUapBvJ9Bs6ienhCEsgaT6bf+ckGOwyMYJ7J54Z0i+oiAmp1ogE/1PFsNrEtKfPpPddkAhDl0rORYU1m/7zElamvTa5C4G+qZz2PiKitUrPQxfOYNFsgofqt9DboucQI8I+X1A6nbP1bjyz7cyymjbWZd59aRF/ql0ODBpTSpTPDD5n+FwtFDZtbN5xAxOF6hpEwaw4D2iBkJSEC+VJmNSb0O9hkgucmUs9Wk/M1aTu7O2d4aZYM0z+ypKkyRCqIXzRJimERIKgG9655LRwDG2hxEWLJepVBslCZjch7H4GHtg4Uvd8lDXAOMVhrDPOdd+na9qWftgYm8dTk850yqLPFerVIt9cKNmPCVnV7a5YYljvtEeRBSpJSRS0s1XJrbvJuQu/0u11LhdlElfXsChPMcP0XLJaTTomzxxgsF2LTTy932ZXhkbWTlRJbJGVDWWC3zryOIJeDe1IPqO9q7ZQmhbvRxrH4NXxT/6hYledPUyK7T1Q7MWIop3I5FI82PRtV7Px3ZiyE4XKzcRC3LtM0OfIUuCMt5gqPf7TZrrMajS6Mg3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(86362001)(1076003)(2616005)(2906002)(6506007)(6666004)(6512007)(83380400001)(8936002)(8676002)(4326008)(7416002)(41300700001)(5660300002)(6486002)(316002)(478600001)(66946007)(66476007)(66556008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ETvXjWjwNuclYwRJGRxlN9C5uXiINScdMErKTIKMkfWqyG3NqdENvOhVJk6?=
 =?us-ascii?Q?a0pK5ZE6g3JSRgVE7fcsSX2kLWb29qWyeI3d4aHtMIPrYIfKRkO+F3ZUTkon?=
 =?us-ascii?Q?7jYAltbB2FOjhLtHAo0mfF9hO48pcpR3aURPM2rW2eH6Jbc3Nz1ZPddCnGHd?=
 =?us-ascii?Q?VI1pwEF2MrGGw0OIMgRU9QMxsWVjjhwM7uxHDpgZluGDjWCjh43UVT0oBrC0?=
 =?us-ascii?Q?Z5BK1+nBwSbS5yDgZ25gPFB8Jd2p+2u65PHDeApUdgxVBLdhs4eIlAVa4kSQ?=
 =?us-ascii?Q?am6O0hAypsEMs+hojDYMN2fg1owIIIV3UXL3ACU5+0pDwg/qQFM4gD2qDSpE?=
 =?us-ascii?Q?xgCzygCyTr3XCJRvolIT7HUDl3kRNfaMgok7or+W5WVwznmPV2NoU6NWiGn4?=
 =?us-ascii?Q?ztGhx1m3uPJTLXgijvvqNg4+nL2ifjBV7IKZHnh5UKSNb51TBOGWCW8Rjaya?=
 =?us-ascii?Q?eO/9V8NZXuxS7ZgEOQWiOQMFa0LdTbLh+KPPw/HBzddUQbfjqCqvmpvzsR0h?=
 =?us-ascii?Q?jb/ML+n8mOL4M01ce+VIf8OI+wgJFCQ0+gzbWN2fnGX9KE47fOgdHklXMwUF?=
 =?us-ascii?Q?8uCGHkm+C9WFJxLAes0eS2l14dxIoR6eRrr9X1y8ob3yN6msmipqEUQHQzyk?=
 =?us-ascii?Q?aCRodCwUbTIRsB7yphC4eeuUZVwPiSeCkN9/VSxg/kE443bFcWUDRoxXnygz?=
 =?us-ascii?Q?4nZIsPD7z7x5BvwDMo30Wh117IN3CHNaeM7IC9eEKQG4e/HYeG3zvT3UOWyn?=
 =?us-ascii?Q?2omYHeyuFBLde2giVd847F9ue/YhTWKXB9N7vYSA2IvfwC0IzlwYgrgN1gIR?=
 =?us-ascii?Q?QgBeNu6M7bYFHst+HRbe9WTHBqHjgJc5iBwPjLXHhSPU4hbp9/o7hrIfZgDR?=
 =?us-ascii?Q?ByfhihFyI7W+fHIJDhFakE22Hl6gHG3iqHCjykPIK/yrIYwSnnnh1HG6GipD?=
 =?us-ascii?Q?Evv5VbGP3Oil1rvxVE+2hfiNG6faOfAhttW3pzxSF5IEQvQKW83L2Q0bouZA?=
 =?us-ascii?Q?Mgb5Ng7x4WmycOIFwFtx0LZncQXb1XJ/shfKDuJ4pdLzMgSar73ICjhG9aL4?=
 =?us-ascii?Q?9DKYhH/rk6ODWw45z0P1EJ3GLhhRg2mm66jLN8D+9lWnV3HmrX3/8JCZ47Et?=
 =?us-ascii?Q?ecIEa4h3IJ8V6SqDo2cDxmFl3VrrqN5VxbP7jyZqY17QSLLy9iHL4Ek8xTEk?=
 =?us-ascii?Q?LECXAgn0MF6JIvlPBR6GL5UKc9rPUijSKzv6MmWoZM0AgTRAPFAD1gwcmsU9?=
 =?us-ascii?Q?/bPETVYXVHQgXPihxOZJT12kmtKnGGIm0YfSz3rGXx8PnKvjfRPPJfqXigTR?=
 =?us-ascii?Q?U/vaH5NJ6v2kgdysDzOM7MHQlUYBkRXmYou+grzMC4LLbsEpaW9IRc/Ng+dX?=
 =?us-ascii?Q?TgiKRqihDbeWHaBeyeLbGMsxnbWqhABjEdTKAB5wpK5xE5bMcvhnaAOwWd10?=
 =?us-ascii?Q?nkTY5rv7txaO3BOthqpfVCPnoWFX7tOAPGFD9WGFL2YMSAF8tkRLb6I0/Nae?=
 =?us-ascii?Q?7e2iA4D0CzT2gdRkycuoz2XWn/dnbTZbbckw8tSBnAomZh27vlsSkA/Bu7qE?=
 =?us-ascii?Q?xiUsdd+jsRXpiABFQrV/rPOPjVmuXMmKeztYqwuR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621d46c3-5915-4a01-e1bf-08dbe50f4d94
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:43:29.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1NOkpLm4oE/Dv5K1sv3DBV9jNWNYbGkd2Mm57njtoVkq9Pzx2NYVnCZ7N/NOnvf1YRlL3sIu+qs/JWSIatCCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

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
index e905ba276f56..140dc00c9ed5 100644
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
index 0d548431f3fa..5055b77b60e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8224,27 +8224,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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


