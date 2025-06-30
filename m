Return-Path: <netdev+bounces-202454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905BDAEE026
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350D9188510C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266EC23AB9C;
	Mon, 30 Jun 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nCNLs1ho"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D128BA96
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292491; cv=fail; b=tYdMwvE7ipxBuAsKnIGlS2AnlyBj+Hn94SSi71SZku8MxMKtiJlLDTNvUBKISVQPfl7XZzaUbZhsXADCnTZFscArqaHwWqsLRAwUFGUMfQC5mGdTfgGTry8pLaNYED3L8fiZqYepI7lXz+oe9EbdKZnwLocQtPUw6puuYZr1YiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292491; c=relaxed/simple;
	bh=gzrxHMm7iYlJH6BTn9R61SWAT76cxrhtbbhggX7ijfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/XN+QL5zzWhyr7CfWQNcnx9BOoaPo2kRQu9gmUF2fANXRUGvJDNIir2EmBYcoo/4cv/eCh8EnH0egapftlzozAOViOQkIhj66gKfQDWnGdcdfMCow2KBDgh2g+uwvvxsdJF33QjFIs+jeg2Y+s+b0GtFCwEFHPkRMj1f0c8sGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nCNLs1ho; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2OPoGJKfhxQs5UeYXXJ79KtEXjVlZE+EOfgQp8uy3MqQMVNBTjmTE1DI2hBX/zAR4HBiHKMZ/hJSSJ6veLpksaflf+hX3tyI+XQQg1pqFklX/DUNsHW1oDtb/5QJNpJ8JWIKNgQJS8os+JpGvfbx3zPxosWXnW1m5/48vCbeLMZaqnydi/gmLw25Hva/jAJ1DgeKx7CBQBibzP4klJ/+T8Pe372tLKxlQg6W3eBQrN6GFej3jRD3leCXWD5qQ3zVbaGecaxXs0sFg6JByixRPoJIObYN7ivK8iAr2eMEZEgVHx2B716UWxIxGeVILHCxkP2/jByO+dhs/SgC9LGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tggvAd0QNajF/Z+R8F0dzfmio/KBJj0dsQLD9aNICeA=;
 b=cxkPQgBR88/7bW0c97MacMzFZDqNu34AE4eb9C9bcvDAyqnroTxtecmKllFHJOeYkF1Bpnfy1HKly7k6TBuPvE+Af9MkarVkLCtc4tK87TjkAY55SOr8cZ6cDWEFoLqJ3Ky+Y10QOjoLzgMb2yvGhig0/MI3KJfPDIh1nAT3h+8TyzCveBAlVsqlek59dsu+YPyY867FvNssWd5e+SGfylDp2Gw8C1TiK0zeEuno/uwr5qXPfnE/TArNHIWuO0ouTymdTLglbZvryN2TpO5+yEGYg9LpdjQic+XXUWrn2QQJpKbrasVhmU7Ztmu4XFtJ7r+88oYlm5fHFfaQMXnPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tggvAd0QNajF/Z+R8F0dzfmio/KBJj0dsQLD9aNICeA=;
 b=nCNLs1hoVk71B1+0qPvCpyMsGlbTZ9x9Fzj3ZGX9rW2F9ULtQ0So+fp7/15dQdSwnxbRJlFnkrzmkNF7h+UurV8d3Bu7Op0tYFkPadeQ3BWD70snay9IqI4JPaOqcQ3Zecp3VFKa48o2bxNjHiJ00UwgX1JgOZ79Km85MCINIMCwXI0DYEqAgMTJ6CDHBrwggSWblW21p9FSKMo/IdXsUNdfh77ykkAprMcxGo7V/WIcs5tfIhsk9xjblhJxfGGV4Ey/bG5H+5OyuN2Kt18o4WgdTFYop2vjs2FrMRmMMkwg+SlwouX4xm4y5saLhzpYKsAmVBq/x8CZADnByopj5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:05 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:05 +0000
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
	tariqt@nvidia.com,
	gus@collabora.com,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH v29 04/20] net/tls,core: export get_netdev_for_sock
Date: Mon, 30 Jun 2025 14:07:21 +0000
Message-Id: <20250630140737.28662-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: a89f47b5-8c40-4bd6-8c0c-08ddb7df8868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VE46XChoJUdQkoThZM2JEi6UXQDOPufgL7alFiW/z8R4h6/Rvg/KgXCTLN2y?=
 =?us-ascii?Q?ErZOBs37+NdmySpigebuhkMSJZu8bwKaExOw8Q7npxKWmUDqXuxTNPMJefQz?=
 =?us-ascii?Q?PCHyZXeW8AunVLUW8UWBXwtRrB6QCxsmKxt9NARAsVUTYl06qWeSAU/4b18K?=
 =?us-ascii?Q?wjmnJ7L0WqziYniEUdPftSMPHbH8pJz3UaVQviQ2xmRW9lQZg1OHTKvyaQ4r?=
 =?us-ascii?Q?TS8WeyBe6HjwLGnrKvxtKHKHohIlFrnSATxhvvEfBqzzF/v47bgXU08TG32u?=
 =?us-ascii?Q?0Oc2U3Ef2lctJRSzRzR4itZZkhEBmIjyCeVW1u/IWqEBSNTNuX0u4zCxws3f?=
 =?us-ascii?Q?dhLSbN5D0rr49Nfs8GuVdv9QpsgpMIe/6NpqC8g7UwMmES4hUKLiApum10pq?=
 =?us-ascii?Q?hvTgEpK8SvUyuv0KNlYAL5mlbkIB8j0SgNhbngLf7ff9liONDfdla26RkKMB?=
 =?us-ascii?Q?xga/HjLkjlqwxmV1sSo3IE9wP3DPajG1msQI2RVBNBCC/ZyEOysWDDH9jIky?=
 =?us-ascii?Q?UO68RvlanMJRfX9k8T3EF3v8fxUzaSnP2m9lToOx7qG0u0RJMpG2gWvDzk1q?=
 =?us-ascii?Q?N5lwBfrQsC9moNO76DbX5wFdYD1qp41FxfZJPXPahQHF+1qbempUmsm78Lzx?=
 =?us-ascii?Q?Tqhvr9JXYBCdlWzG//EDfP7UvN/4xHe2XzBiwf6xr7ZbyCH4obwAQK084H3T?=
 =?us-ascii?Q?NjKStubBzjJAfpcR8diIvwPsGAU1iV5pJHsZv61zspB1SDDyJl5kUzsweeHI?=
 =?us-ascii?Q?rRRrwWnMInEX1XwHm1LSJF6kr8jQuDuDa8SbCTLiEbljQ3+ug0SMbKAPkPb5?=
 =?us-ascii?Q?6prIfM4pXC2y/TUCYenAl+lYtBN63P2ftKXOMQxIqqNqR40q31Ok43iKBU/T?=
 =?us-ascii?Q?19o8JDI5o4hEOSHUHX7eEJF/bBrKBMQd9RuDaQqM6ltLNylCd6NTdG/do+3/?=
 =?us-ascii?Q?+xtMa+1O47PqfS8ek51x0FdslVTHgbLUuFo5B4CeAsbBAj/QmDqMK6HrwZ96?=
 =?us-ascii?Q?EJo9WntDmg68FfmlJbQZjsbdECxtkGAI/NOq4wZldN1jZdKPqy2disr9TZn1?=
 =?us-ascii?Q?BVuockhSAFOcP4YGFxP/SLYLC+iOOBIEy8mX37VJdmOEqc9SqYWs9US1wZKn?=
 =?us-ascii?Q?EYA/pNwgW8X7wn9kjS70dWgBFTImc9rWyJCn6TVmmF6irxaZQy7t2se9jw93?=
 =?us-ascii?Q?lBbVQm84hUE/G9nveag2kPPq0sKxcADsN2/ZEu3EWDyAwJ0HuqpTzRGPKS4/?=
 =?us-ascii?Q?1E3ZUGCnAX2Q7b5L8JYFKBTPFTSND8HUlepVbyC4hpZQqchVHcGQS+SXMcr3?=
 =?us-ascii?Q?N71p/fVS9NSdDqAc5TUZbnaVolUOUW4X28iKuDxd6ddQyUcPKWquTeMxWKbb?=
 =?us-ascii?Q?Tvwuo0liHTIq3Qsj6eMwmRiVXeimUALmX1gUsEGUpcyZL/8BFMp+uMgXwL+F?=
 =?us-ascii?Q?qmDpy847fkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dKgC0wHXvewliR6b/43tUfKilXL7XCt1fKcftYtjYD6cXo34DtW2dq+xChKL?=
 =?us-ascii?Q?tmWTnkQk4OuRSyDV6SDvikCZmJIjes6hyjc0UEOFyz/GXbFalpAUFNnnCeE+?=
 =?us-ascii?Q?h4pvmlnjbuRCvm3FDJxy1GANGW+kIKbvAGMW5tugw0DQCr3ZuykMiNBdpcPT?=
 =?us-ascii?Q?avZ8hcVQzGcHQn4tsxyHYe/l3XsJpxt65sFbRpxQc+G6gNMQ5v8yUHnVXJY9?=
 =?us-ascii?Q?nw4/OZwwNCdPd7bBdufiFF0jFxcpoK+rkPQLLvXeHliuaeQiBEwxrCuF726I?=
 =?us-ascii?Q?Zq1A+NUqTWb3N26K0WMROznAcUCUaOY5AkaFr09nGYLl1cpgjZ4nGWh7w/T8?=
 =?us-ascii?Q?9bW/JkkdcwBwzSnT4s1X/WyyDw3ZmqI1l4ry37PFPdv6yJuHK5qQioMtOmKH?=
 =?us-ascii?Q?AX+KWMEgwyiizyby6U+5tju/Y/DLeVi3CR/ptgMvJ7rp7yq8niBi3z13S8rW?=
 =?us-ascii?Q?v3mErzTasGK/R05lYwzWcFxFhTZVDfT6t00f5TKxl+X14EWl6W+af75kTxEC?=
 =?us-ascii?Q?qCSgVVfv4oxeFd8QVPjJIMVTRyB5onIC3WHG04ramo6t7i0V4SoEpnIKBfOl?=
 =?us-ascii?Q?d6otieUbYm7fS0vMIgl4I9g/sM1Nkb31DFEMo8x+kQ/sAcwTCRCggw5+6T0i?=
 =?us-ascii?Q?Wofr+7zZQjkjGUY6e5XEeGlfMAJHRfOIePSW5CSzLayJ9fmK8ZLeA6lg5fyS?=
 =?us-ascii?Q?1kNmo1dnRSRl0cuuCSdlJfmStl/V5+xNEFydN2bAcFeiskn32FpVQpvyfqSJ?=
 =?us-ascii?Q?RoE714Fj1mO8ZQKYdOWlB+C4U9OApFZLtLdUjqHLSS+pl+7PWMfcnyvHO+7c?=
 =?us-ascii?Q?gc4Ku0dLPSPlJNodaS9lq1+NhV62MhpQAnztHipFVrhUXi2SzJw5s+dek2SB?=
 =?us-ascii?Q?g5MpTWhuGM3EDO8nv2pr8+0Xq41e/Hrtr9d/B1dqNKG5XpygA/gxmQ74+zSd?=
 =?us-ascii?Q?l+mKsYkVwxNXYhjcKUN/UVU7awpKRuwUvqntlO9DuTI3tzrp7Dox9FyvgGgt?=
 =?us-ascii?Q?UljADOph3h8Ojt6ks4JJjDURgfwgZRJvKIOywGQ1oC04hNNtjmMj9M1ZV18b?=
 =?us-ascii?Q?jcq5qf0imEqm/sFjXth1X15IIRyd+BeHfCo33L9iK+/8o3nTwmafv7f8CXrc?=
 =?us-ascii?Q?eCS8E7ZdVQDL1p4NXI3GIwQr3JFHZb2zdGKZlAqZLrD75TffPILHCsg2B1Zp?=
 =?us-ascii?Q?ezenHPpZdNDRyl7DcPDTS986tvfhHVMldsbvYy8DKCYRDFMsyGEJJZt/XGCk?=
 =?us-ascii?Q?3vB/ZuAc8ZVyo4stK1EY8Nmc/yFnz9LXy+FM2zb5NRM6JJwKBOIBEAMr7/DX?=
 =?us-ascii?Q?U0b57IDYdXBGeBmkZh0bq6Ia3gOqDz8JdtB+/+yXigx85t6UqEsgpXdsX9WY?=
 =?us-ascii?Q?ucS029KSXIgAt23RLSvAzjQRgqD71/BUq8Ol6pWK55RYgkpJQKQFg6yYUvTO?=
 =?us-ascii?Q?o4MpgB84JoCLwUcvo/7y+zbfIzv+QOp1CJvhDWVz91jDzwL6QYpGP9CA/Ver?=
 =?us-ascii?Q?XV6en7Sgh1d/lvWBC6nxlB3ubh2dDxqC0RDXHi7Qa1g8yBBn09yHUWkXI4TC?=
 =?us-ascii?Q?dvP2HSe2mwZJRXHPDZDp5U6gIp7qnZjJbH4GnJxM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89f47b5-8c40-4bd6-8c0c-08ddb7df8868
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:05.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WJr3w1lF7TalvwqH2oNKnyJAmIg2FcrmUU6bEE0menyt1Z0cYhGGsGbmMT+HZ5H2yXVqLfQCe8rcAoLkU6r3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core
* update existing users in net/tls/tls_device.c

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
index fe510ba65c7b..f6adc0b7d5b4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3400,8 +3400,9 @@ void free_netdev(struct net_device *dev);
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
index 7ee808eb068e..9dc206f3d1c1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9137,27 +9137,35 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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
index f672a62a9a52..150410ee2c6c 100644
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
@@ -1060,6 +1044,7 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_crypto_info *crypto_info;
+	netdevice_tracker netdev_tracker;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1072,7 +1057,7 @@ int tls_set_device_offload(struct sock *sk)
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1166,7 +1151,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1180,7 +1165,7 @@ int tls_set_device_offload(struct sock *sk)
 free_marker_record:
 	kfree(start_marker_record);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
@@ -1188,13 +1173,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
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
@@ -1243,7 +1230,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1256,7 +1243,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
-- 
2.34.1


