Return-Path: <netdev+bounces-99098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F018D3BA2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C26B25F89
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC5181D1C;
	Wed, 29 May 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eIC3AWSg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E41836D2
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998489; cv=fail; b=HTToBjEQJZDjdbWYS6HB3+PstpdwN0qlc5wcLUwROrC9WavmP0fSQTCQCaPT6tNYE+YD0hBbsGsbKaHK/dAiqmx4JaQAqBSc0SD5FCbFIQfoDCO2lcxggkSbELvtHcUjEupc5NAYd5pclTzY6F/qnUziUUqU1gndiu5jXWW90hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998489; c=relaxed/simple;
	bh=NAYwX6uRT7VD9Q2cQF+/nyuB/GitSQiap4vkgzMis1Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLSpjNwl1N7TUFVo27xSuVI4/GzEu9Z4A+QMFJ0FTeBoeCRY8TRNatRDUwF1mHgthAIc/8L3vMslZjp9HNSA1QMKhMcRBX2ja+NC4h3OOiRi3ZqP2+DmG3+oV1QXwUWkaOjWd0yAq3rOBuucd9dMKszfbkNgj1EKL7hy3JCaJl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eIC3AWSg; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8csykrJ9/HVx5W+pFLNs4YAupD7LWusXYZmU3O+HJWy1dx6NqW0+VgdMuqKhkkcwTC/feWq7cq7JWgbnADqvSwtdu5ZkDzPRqFWH+E2flQ0xy+6U+hiNtfokbs2WfWpRJ2tQfZFQIPHaFaymgw+Ra+7thFNTBMe5w/z34FRHj/l+eazVJ7eSNpQghZKd7oh/ElE/0G8bJhe0Ymhv4FaPMw9nlZZ6W5MShgjZgQ3A56s+pKoAl0i11j7d+OJNt3uJyErzif2xkbwTulUCLS4QP7cChE3jk6VBvk6qZh+WIbPCDR04CIo41fGQAY67OD1KxuKdMdWvhBEks9vIaqgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NZy3E465bP6AdtkTtsqhUwAD4NVcxdYvPPBTfDyMuI=;
 b=C6YIrJ6EShvkFVkRfcFeNroRrcZpOlFILm/LJEx2dE73nQUzXmzuvQ4heCA0DHfmWIo2jGX1FATUnZOinSFMldasut40+q13R74SOq0bvFx9yrE4a4rCleqchPIirzTgAtVCiCWSViNbpgPumwl9zxuMcf7+GaWKndeAUiWS8iZb9btg7WWJ05M+3AESVjIZtKYhf5wwaS+z8nQMY2iYIY8y/GafIDIh+HH5FHr7DAJaAc0q9EdA3mhXax6nhT9RPRHXCb0Wl3X6M4BX7xq5a6SEhR/T7zqyerfl9pU4sA4+/fs/trRPyUOVbbWOFp0QDk6svPNJivOWL2EvlTSMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NZy3E465bP6AdtkTtsqhUwAD4NVcxdYvPPBTfDyMuI=;
 b=eIC3AWSgX0wkme5JkfyfG7nCbo1IBeHJgtEATR5OLd3EWYHbTljjPpjdBbKO6elNroOFBNddCZ4u0B75R9bmJTDMeBmpmkTdYTje/E5xCraYqoQX2x1iAr1xNOw/UQfr5Ms5mjBUUigZoANu1QFOwtnVfD63Mifs2fiVz+rOQnN9CUwWcz8/EemGA+lLLkjU1OMKOi4hG5OOuAQQ2fuRHD6+DfWKVt62b9p2hmPtJ3ldgm8Pb76xDJppgJMtW2b4PGLUCxsoARq31PBiX0WX0BHLcrEA+8K+us4/rCLkwojHrjGHuXF9WKTSM6azx3Mqyr6zmNsSknX5+3mZy4JRdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:22 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:22 +0000
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
Subject: [PATCH v25 04/20] net/tls,core: export get_netdev_for_sock
Date: Wed, 29 May 2024 16:00:37 +0000
Message-Id: <20240529160053.111531-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 7200f948-e919-471d-e542-08dc7ff8961f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZShgDIQHJAkdjzA3Rrnx4P7DhGb7m5I13z6hoHKwvwub5akmrs2MVsvm+cq?=
 =?us-ascii?Q?vWPTXmnIxSvX55x9RF1s6HJk5NstePc5fV+amaht1r7+ZGSh9UGRqWzxLU99?=
 =?us-ascii?Q?uSSDp2zHkePW1eQo2OCYTNShAnzL6BBOCUkHpazm4UIeBexGDCufHKxy5GLT?=
 =?us-ascii?Q?sH/AMqmbCfImRUGyZ/bb9Hy1p4KkaYEeT5cpi3xAXP1U6Fmjb8IJy28xyiCv?=
 =?us-ascii?Q?eLPGKrybncgtZRkOe8ki3f1uR1J9KtkxVP7PeYG7gk1hRyg/3xPCIql6/w9o?=
 =?us-ascii?Q?yrh7/9zofX8EIVePvU190DeEGA5iCbvG3zfjElYddLFw100PnEpebNT7a+8/?=
 =?us-ascii?Q?SJT118GxFtg6kffRgoc4BPlZ5eGIUtzuJVhDtHkgRv+CPoc95xLstXhQC9uj?=
 =?us-ascii?Q?zMUWYXvdhsf6qFxqL3qrMWHyYBlyGb0UzCHwlRyEjI8DoJy6Qf0EIc54R4F+?=
 =?us-ascii?Q?zy79IE0DxJzrZklNUuP9MU/3qVTeM1KhsOkG87cN+3Tgg4pdwlcWrzFg/JEG?=
 =?us-ascii?Q?zENLd5tOHfQkCW2Z/Z3CaaIjnmnwnBQ5KroCpxkhYKoF2sCg7BqBEdkH2h/c?=
 =?us-ascii?Q?SicMiAbhySaraGzwvdnN89PS1xSUxfFOJ4UyV7kWhqA0czF8P2o6mTmq6xFK?=
 =?us-ascii?Q?hR7CQzIT0lKMuWonIg3ti7Nxncd5autScaiol5QICuA8+ObuUf6ByzY/x2+1?=
 =?us-ascii?Q?RWXbRSod/cdbspOvQCzkYqm54zcYPLWj6D6WGlMe7lxwgxFuPHiHmCJr2gG8?=
 =?us-ascii?Q?hHzipLe62jt977wOgh/2721ykfb1eYHz3KY1HQCSesP/7lLPNqzg6HvoCOUV?=
 =?us-ascii?Q?8VhELrEtIM/AnpcKnwEbp9/tIEplQzElquzQtZJNeJvqu1n7vazUi2g9a0Ku?=
 =?us-ascii?Q?TpR0pQN3QLD6HE7+D6eUEbV+eA+qPdxi11kC2EXzL9mxbk9FgQxbycKsZ4Q0?=
 =?us-ascii?Q?+sJ0UbQ5gbf9qTJSEorAE8Mp1NMX17uw+oO6H94mdbZcc5Z8D22+SLpqJ8GX?=
 =?us-ascii?Q?mYWKv2hyP7NrfZaJZYycQTfdHp0GrlSAfug+V3dkY3WjlHgqj+A+FlBVP7LU?=
 =?us-ascii?Q?eX6fEKCAFyxgX5MArWoE5cpZ8+G1SNrMJ2K9sw2/7aUMxhz1Ol100UWNl4yy?=
 =?us-ascii?Q?2x+xBMznH8zTdyy4Pmdl4D119K6ds80hO1VhbrjCClIzkeMALRh3EUcHuB03?=
 =?us-ascii?Q?i6Daw+T1JNgzh1D9ITNByqn5icUMiwUxL9/2XPpqjpaB/VfkztCPT1mAWQLt?=
 =?us-ascii?Q?cMrTkC2PkKRbFlUvNC/wZgc+c/ejXk5GkWqsNrP6uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lbtQ8i6HwmLQhSjYYHZwoor1kgGsWDYHxhUqrjYX9J/9r94vbhzi+3scbdGP?=
 =?us-ascii?Q?e0Gfbp0OoLXFIyqjq0tV/qnmyjHUvo1hB9iedzZ2atNFoY47fnwvaxdajbS1?=
 =?us-ascii?Q?r2Lj6UScOv1nDZ6Af/IQfkiBpv/5jTznIcev3lZSTbSCVxJ3n3zSuSJ9vkbP?=
 =?us-ascii?Q?y5AZDfSeWnliOkWTRqGjB5FcmJnmY+/NV8nyhg6hueGn75hN9Sr6+u8cVANR?=
 =?us-ascii?Q?iZeLSRrEFxRoJs0mysrFHbMwGyJqHk3+cVbYCFjlHCeQhD6PXCJqn9aMAfGD?=
 =?us-ascii?Q?1lRsdWCwy9jw4lCcqBk4gy1L+AxzRC0qkRflL1WoCz4MNhVWQqLagVU4p6h6?=
 =?us-ascii?Q?DGUDSLeBsaSUvv5eaETJQwDhmgWp7PsDdIwcYU2e8zlNrWxR0hLytjnTBzSX?=
 =?us-ascii?Q?L6ckxCSjUAdQMUw6xjNHrdin00vO6wenWlHldV7ACzFc2/YjrzoE9X2+7WhD?=
 =?us-ascii?Q?4nzzapDV3f0WKgiqUp4gngGz/bpGPNGY9IXqMjnwTtP/uASqQAYLIOjfoAAc?=
 =?us-ascii?Q?kXN63FI3VehFqcjeMFS1If5b5gLfdvWBi7Cn74OnYSkpqyHM6PB6FrpHSo7o?=
 =?us-ascii?Q?mfYaS2ux8+EzIhNAa5vlq7qq8tic9tXblzPrX1WGwXb8nkBLVRbKYp9y1M6z?=
 =?us-ascii?Q?fI+w5H/NxeUAakrtkRepi78nRxJZwJsMfcFmjE2R3+DHIN2HPeCMf9t4SPQU?=
 =?us-ascii?Q?O0Ri46mAGMNFpeWjkjn/sOCXEcEAT8ex/zhEAMWV9q0Nl6SRHbcPVLyyw6Cs?=
 =?us-ascii?Q?t8Y2VEDgXstYNrYRDOPyw+cNSzwv9Ik4Ebx/vQPq6BJJUS6sprR4XBH4IpZY?=
 =?us-ascii?Q?7//G6It87Jp3oYezBbM97iw99PRd1WEW6CMPiQ0vCFsTwsO6e+BV7/iTEzAE?=
 =?us-ascii?Q?/rZ+Wn0WFiTZua/olS8I5CmzqKyYxnGkcfPl0R1PHR2uQn9GkAMQ/YgmuXKG?=
 =?us-ascii?Q?kF0IprF3FQmyBVyGY5APfxEMDOyGX5NXn+iaB/SdpQxqkSY01CnaXsA4rkGJ?=
 =?us-ascii?Q?C32gk1kwV/Go9oXimKRP+itEjb3zUwCa/8Owyoek77/BQsQjxtxVvLWKyn1x?=
 =?us-ascii?Q?09RboJHueMM3cx64lhPk36d+/pClHiTdtb380mvi/7hL5zrvtJLe+WFnDoJu?=
 =?us-ascii?Q?5YSOwDpBHDVx/O85htW7FE4u5N8y/QvbCDLNrNcvkvcTNxOCRKoFV2/KTwbf?=
 =?us-ascii?Q?ZJVYbShx9FXhgi86+INB7xk8AzATb2JnXnSsk5ZMtwEi1TkR8Blw8GNw6gRh?=
 =?us-ascii?Q?dA/SUXfOWStGYZqa26je/z0M/BURh6hb7NxjB/LICf5NyAZk290WDT9LMTgs?=
 =?us-ascii?Q?gTkpJ82HzyGGWM3cz4t6Cup3uXCmuc/7K8OwoZx/8Y5iR3idNpuNzLZB+kRZ?=
 =?us-ascii?Q?9MthrUOUk0iNv4tO3GJm8Vbl+f4CSB0bFV02eRrKlmPeSl9HpjPmaOo+S2k9?=
 =?us-ascii?Q?4v+PoIoiq5H84dQzFnEWdI50ZZ1v8Tl9CZe1z4Z8+nw4x09cz+NpHpHQVaD8?=
 =?us-ascii?Q?CmpvC0qHRpUSyprQhjnOUwWcJ/ZHmTsmUxsqK7tBXFCaz9MZIFx2hvCoQdj6?=
 =?us-ascii?Q?bfYwVq2KDMSogdIoZDowErJv72QM+mhFThB55JlU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7200f948-e919-471d-e542-08dc7ff8961f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:22.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhJcSkjn6FvEg7QX4RsYrh6LxvSECNo58Kq3iDIRTZHMOqFy30eHZxkI7oGyNPZyay/OC8IviY/xt3IBBEWl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 32 ++++++++++++++++++++------------
 net/tls/tls_device.c      | 31 +++++++++----------------------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 11954df382de..38653476bfc2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3132,8 +3132,9 @@ void init_dummy_netdev(struct net_device *dev);
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
index 85fe8138f3e4..8a566456814e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8397,27 +8397,35 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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
+
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
+	if (is_vlan_dev(dev))
+		dev = vlan_dev_real_dev(dev);
 
+	netdev_hold(dev, tracker, gfp);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index ab6e694f7bc2..65a34a4d09e7 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -120,22 +120,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
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
@@ -1064,6 +1048,7 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_crypto_info *crypto_info;
+	netdevice_tracker netdev_tracker;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1077,7 +1062,7 @@ int tls_set_device_offload(struct sock *sk)
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1173,7 +1158,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1187,7 +1172,7 @@ int tls_set_device_offload(struct sock *sk)
 free_marker_record:
 	kfree(start_marker_record);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
@@ -1195,13 +1180,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
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
@@ -1250,7 +1237,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1263,7 +1250,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
-- 
2.34.1


