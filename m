Return-Path: <netdev+bounces-186971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC246AA4616
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE9C7A3201
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADA721B19D;
	Wed, 30 Apr 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeBNzxUK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055721ADB0
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003496; cv=fail; b=bFH04CZ2Mf7S1QvSUXXSB5qKpNqHLVQqsC4EP3ThYtoUcmDTwhyxO4rI6qNWGam84fA/SduS44FJcdVtNrB+MCYRcivrYIlDmUKS+vn/fK6P+jJs1BYlzShSCELf4X6ipahhzwz4vkPqa36p+CTPsxrfJDy5is2ke5TMK2xH+/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003496; c=relaxed/simple;
	bh=4QEfB7e804QzWbGdIxSdpbdvacSlPzxMRuuRHQJFg1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KdxcDmddoQrdtNypD9Z1yPLkj00LBRiN0LEew8a3/4Yr9Ou7iYmGM9eRbnDSYZ12u9OzUnH73BB5eN7+3n07G1UW/XiCqpf+y5Uvgx8Al18jUXFdRaiegATbnc7qEoh+sRyM3Pwb0MyQvo+90ZPa3rsfSEQRav5q7LquYKaZSiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeBNzxUK; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7bn8THAAniWVaDdQfJYXTOl7UfMSsImIxwWhA7OC7SoBgVeiy6Zwb0Wg0DjLXnLs/XHW8amjwJgI4I3wU4qieYe3pX7ky0fdNsF1FT62ivH3LMk+dCjBAPuMbDdr6iKgaLYLeQzdhxw7zp2Gr5ZOmFpxBblG/gySDOaY61sU7auihLG3s1c53nYQbh74zVajd/rgjstfOcXaxUG1Yb5Dkny4JA8zLtxgTODc6nfCEd73Ioh5DmOjsw7xGgHDcUXG39hsL+gN+Jd/kYWiVsuuXFmKYjy1TSj+x6ptqy1zR+Z7JVSR54A0R7U97KKkUHxlTO7bNI2wau4lCAiGcskzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g/HUnZrBWC/JbXSzoMoXCg09saKUVLv+j9ktFXmTvU=;
 b=r4wAHQQPpgl/LRRXyXnGI/gA0JjbJ4dhtisK9yfvjSIdjOdnJIgxIBvpJFtNHdRfS35Q/MN9rtY5rnJgepzPPuO4yeOZYXREHBygr/uKYb+iWaFcDIqE26JU61BnVmro/bdzsYZ2xGK0wavN33mAyneFSCuNQ7bWOsEykb2vKm8Zx2AMvwvKZDmEP0mCE5dCtRen7JvsmjycPkw/a4khgzA9DeCpSQRIYLwTy7p1/ROFpXkJSqoNDw5ZOzyi2zn/zV7OnDTDEe4HGnaudQZTy9kW/IlofC0FoMFoxbzCvoyVfJaG1DBMSUeLJ9v5xeKCk+6a0tPXBZSS3xo9IJPPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g/HUnZrBWC/JbXSzoMoXCg09saKUVLv+j9ktFXmTvU=;
 b=BeBNzxUKTdPfWJi4wTT3VWDvhMc7WfrJdcuAaPnM7+6+V6DPWroeLjdTEarCFDYFFEA8u5y8i3utgqEnIilXZHaz1fYmCuf68XgACZwzLXYfUWHj9ZIjzPN6Z9J9GIcO8viNYAju2o5Yqgvf+EV6YOWlQn7NoUK3K+h68h2UFJVP9myfRIS2KEM69V31bpnIjhO4OIbKbzeCgx95cIyZ8UuLL0gqz2ZC1jHO31UweQMG3yQ/Qm45lvmcCKuhQ1x30nHKETM3yc7TFNJGBLgKNomi3vMafkk0Fqh3ZkUZ1maILuoct3t8HDrvJH2rBbl21zjJMduGGWnuLLJLbM7fhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 08:58:12 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:12 +0000
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
Subject: [PATCH v28 04/20] net/tls,core: export get_netdev_for_sock
Date: Wed, 30 Apr 2025 08:57:25 +0000
Message-Id: <20250430085741.5108-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: b1afa2f5-6570-4910-1eee-08dd87c5230f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kw6Tp3NQi2tW8CY3tUoXl3QWmBqhrDIu8UPotBrzhywJBiOnv67kb1EWuXda?=
 =?us-ascii?Q?ubNa3zwBldIOwctu0sl0qmi1gkbZlm7tfK2em+rUSXPUDzzkuuFe40t4DIK+?=
 =?us-ascii?Q?JB0kf1004FXmrfi/2bJ7nhDxjoHUvjBXnMonBnpBHaSLHcwCEspa+8S+Fbqk?=
 =?us-ascii?Q?o/zqP2jo7R7ezRNbRSlCRBeVRnfWqV0CvlgeIgt5Dlw54bvYQm/vuMJ4Q6ie?=
 =?us-ascii?Q?292FGEL/aVo1Sa4yb+X6eB5zw8OcbVCMKwr4gzagNJfzMNBHOr5QWIQYiXpg?=
 =?us-ascii?Q?WWS7YaU1vu0YIaUEfKRA4wsTmqg5CG3qwzkqWOrZkT8wbKQ1JkHi77Oj63MK?=
 =?us-ascii?Q?HzpOmisWvBOhwpghAG7fbKoPRWF9Ib7oV5EPEnRZkZMH+6gDPVnRFmFgGRXc?=
 =?us-ascii?Q?TmG2W8Wv6mVmlOWS8YnvzbpwDOZawO0VmbLRp/x88WEEV4EDxDUWafEvvH7A?=
 =?us-ascii?Q?Tcc8aFM3QmWVOzAYh86LIEsayyUB3SlX8Y5ZAyxYfqj5v8ZACjDbJ7RFvh0+?=
 =?us-ascii?Q?vY173Pd/wVMpSGoXMAfow66tgjio1xk/YzEW3QMWGdNmlrQxTKGJH7EFojWH?=
 =?us-ascii?Q?pu4goFLmA7diz7YwwQUvZy2ATDKR2k3Sahepkruys6jlNQtCpS8ZfiXEiUpI?=
 =?us-ascii?Q?lgk2avsxaq1o6mPk3MrGGdql95lYPQ+eyJ9PavfcSkUUCpt550Dwft1BzZ/7?=
 =?us-ascii?Q?9P2z8w1vAoZ8nAE2FpejFX1NKFLxtNLE1K5c75Xpsr4MBF6LZT1B6EQ8cYFQ?=
 =?us-ascii?Q?r4ZIBdz+elZ0doFCOiUZiVvbtv9EIuq9hsjyIrXO5di3rQTRZWzdcsjQG6FP?=
 =?us-ascii?Q?/ei1zECt9IFL4gXbM1NgTuJatAGm5EGdvUhvhBGFHCT19k7VQGcdKgsUzNzn?=
 =?us-ascii?Q?sDThcWYmRxcjoUFfSKmi4grxIXd7fWdxkXEnxGNMKyObLj7L3+zib2MXiKE0?=
 =?us-ascii?Q?mWlHgbu4HxOl2r4ACEGSetrLMx00aeTumoTmm1VtBjWM1jT11mWeeotJ/Wqt?=
 =?us-ascii?Q?ybMKEHFdLYc1geuC3LhU5CrWUXyH8CcNS3guHOEjPdPWSek5ZsOgda5DQmk/?=
 =?us-ascii?Q?U25yED/8Di8EtWqMlgoW2sSgJUwspBgqy3CH+8oorADDgf8h/O148ZF5XbCH?=
 =?us-ascii?Q?XCvnv1A/Je0j+sRL9y+HkZ/XtE/FAisrfRRRn0LU03z0H60AatisLdklsTQM?=
 =?us-ascii?Q?SI1WfiX4UQ/gIJ4OG4JOLXk/PzCY+/axFXMApdlHYIw1TvRsI4KFSE21i7Sk?=
 =?us-ascii?Q?A/2Z+9MnU6C2MiJE7Wnxk9SNozi02VcSA2RWy9e6t+J68avFOr54nogcLtOg?=
 =?us-ascii?Q?jHTSvHrpzh5axjNa80f/fkgFC9HCJqAiD1QImKq5d+f2oy3YwMDNfF1E57wW?=
 =?us-ascii?Q?jP1XvBNE5QUutxgWVNkHeZ1NjkUQtIMbCXXpET07WfgoBrnOb3wvUf95v49B?=
 =?us-ascii?Q?HFJ21rWLkeo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16eG9rRd/xNoffPpmS1TMZWsEY3oCEWbCRgxY8OHxXM3+f3NnKEZB+0Bc852?=
 =?us-ascii?Q?N7o9Z5Du0170HJA7f/rVS2tbTfoXQ//IuZRbmht/b8B2qoCpldmh6P63P25G?=
 =?us-ascii?Q?yJjthn7v8wLsbhiYlV/AIwJ6v/KlMg1ATGUfE0gREyqric2I079KjCLzduI6?=
 =?us-ascii?Q?rPyJo3+rg8v/KUOtDCOmqRc0ALKiwLwWFBD7OZYsw42H1YsY1TjOzSgvgSpy?=
 =?us-ascii?Q?BCkcb8f5ORtkUz2cUJMyidLt6SEjWzvYKvTcq4ypuvwog3EDBH1gUCwYAa+j?=
 =?us-ascii?Q?RUVUz6pU22eiwPp1nG6r8z2ugZs/JLTrmr/M4wnFnwYtkSiQV1Y7xJezEqq0?=
 =?us-ascii?Q?ffBrqzYdyi2SG6EKBpXgoZzuaS/8MEP6uqQQb6gqaI930JyyCl/yOfbRjNq3?=
 =?us-ascii?Q?GsZn+S2ofKRJdgbSAJJnVO45RMFtd9y/uflDk94bbtOtMWT0CtFdQ4//aDul?=
 =?us-ascii?Q?dn1BI28GWyIGpSyqB8FQuEpUALS+pmqEmAAaFRQ04UtX1VRjWljHExZdi5WV?=
 =?us-ascii?Q?LcsGpDtU+5nltCcw1JK7hy705y/bJdSkvk90TH4ynRTmbxfSMRNA6E266ywX?=
 =?us-ascii?Q?y1oo52hn/T8e+lJkVBuqiLiaDVD+uw4XRjYVn0CSkNNOP0AvHp3X6uOpKbHP?=
 =?us-ascii?Q?uly1ip5riegWc5UWztzb5OiPCJKTTKMMjhwf6m7UQKywS1+w6fARGEqxtb64?=
 =?us-ascii?Q?4EHhfStNadMa0lswWNcyIL/TpjQ+FjrWLaKKWPNxqfG1adEMTnOqQJ74lm3F?=
 =?us-ascii?Q?qZC60UCvqsIBEqRe4xfXa1qZQ/DJzSR8T/Z/MhAsGDgffn08Bvyyn78mlIUU?=
 =?us-ascii?Q?VuEvMhgFFAGvmeuHMgvXM+D0P7/A2fbmAM/sQGP1IK41mpItPpDBi7mvO6zg?=
 =?us-ascii?Q?j2uQwO+xKESpznrrIIER2FE9VwlTXC6QA4UQyDSWo8+TXZQ03W8I8o+dIXAG?=
 =?us-ascii?Q?SzRDbfq8iHg7UGfI3IoJSM++NroNRQg4S9m33a6mQs+RrngW6adt/7wuMXNv?=
 =?us-ascii?Q?MOLlZVWqeZKBbZbsgW0leGwsEP6ylMQ/kZiBRWWLi5SYy5ajAqqikZ3NPUB/?=
 =?us-ascii?Q?RnYgvp2Cx48gY8Sr+vqhx0xZharW23UlN6RNITUYXGC6ZxvXs86hfxs1zX7A?=
 =?us-ascii?Q?FNd+GepQxU5ZpHyfM8hvv7m47rGN6D01ee5of35EMmXTtPhPw59audrEItkd?=
 =?us-ascii?Q?JvjmNXhSYHV/T1VtmrfiLQCI6U79kOBXWIXfj+NbUwZe8+OoVRTi601DxmoA?=
 =?us-ascii?Q?WAMEBb9vrGbnEB+6pQuQac3dCcq/ir821ZWG4X01ehTJrY9OYoNZwziKkmJ9?=
 =?us-ascii?Q?UZjySuQFUgXrFm4TkAk1/23DyCEJhKNmcP8U2xGK26U6XeBRqUv2FzLlx6TP?=
 =?us-ascii?Q?FKfhPeK7A8hr+h2BBw84ctqIuYmReW05+whUfXSv5TW7kcNtDY1HqJmPJEei?=
 =?us-ascii?Q?PA89hJYa6+TSuJuI/PB96UFJO/U2RPooMjfwV0US/D5RQ9wA5CBtQmLbAGV3?=
 =?us-ascii?Q?yBKBTqqOjK1Il6a0lmhq9q6DCMiWa5aHuTxLfqfC9dNfThhsPk+BIlgVsHVs?=
 =?us-ascii?Q?f+EHX6D2m3HJLQrDvWtuGqcVnoK2Y6WJA/O7poQn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1afa2f5-6570-4910-1eee-08dd87c5230f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:12.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaKiSxyHM/7p9uI6QvKyd6N8GqWNsKLLHrVexPe8nrdu74vFKS0X6k2MwhKDktyAHGo3+z6ZzP0EeFhEeRWogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

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
index 21fb312816bd..816343d81bad 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3384,8 +3384,9 @@ void free_netdev(struct net_device *dev);
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
index d1a8cad0c99c..531362eaf954 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9057,27 +9057,35 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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


