Return-Path: <netdev+bounces-134502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E46999E7A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A771C22B26
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F48209F3C;
	Fri, 11 Oct 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="OWVO7ohx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434F1CF7A0;
	Fri, 11 Oct 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632937; cv=fail; b=ZS0vVGokwDMIdrF7qBcDD3Lcmkx+4HVoQFnvPjeSTNzgjeYlEWL+HJgEGi0e54EcbUeeKUcnJ4V0jpgu4xFR3+HcR2LFeJOuFq/MYkKlcB4pHCbYn/3BgUYVVL/+9NujPlyaWmkBk/BvkVwvZpr9SFt/4YrDiy9K6pXcL9eQ8Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632937; c=relaxed/simple;
	bh=l12PehmDlYYIHy5rzTaCuab1ahteTDoJiRryXQmUqac=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BcWPjBPOqIuyGwhyFQu2lLw9KE8FOpGNFZFKiTL1Yl6sbUb5yqXlnLql3aJfZGSZBx3pzGLPMAXBS96FkTL7R4aGwEaFvIWeg0kCYNHPumHyYG6s7oU32P0qL3S6kZ3TMDxAsReqcCKSt99X3Q9QQdNXTDnEwfcKwK1M4BakpsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=OWVO7ohx; arc=fail smtp.client-ip=40.107.241.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmBDjQ54jYUIFl/IJfVC3pD8kLjvioxzzpVIV/5kx3ulkABNVt+/aZNtISJt8kmQS3JfAtXBWGCb8zSgbNtOcmvTh6JJm5VjTqzzx57gwSmxk085nrsJgGLovqOh5mPZ/VvHkNjgFZkQZz+psjdcUYvLdje2Oc6h3E0MK6wFpCyjosSdFvSnUwGF1bhgrEWgAqcP9Ff6A/D25/xSaYGufb2h4P1wTKe5+FJRaNoPCdV5ztZN5COyqaWW08kQ0tHTbNGBAlDDSkTnlDwaM6uFTxMaWcmp2NapHoNb/uDl7jgkCusseFbvvVXHTd6KkaLDVg//J1fZBakYHOnEmR/10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbhciavuusKDLxJ4GZY78yoSQYq+jkgr9IdQU+z49Bo=;
 b=Ur2efuAErbbDFbLjq2Amfj12/Mt2oZSoV2J9ao1cK0tJN8BfJ3l6UhPsPhk8AduivQYUISOxQh3qeYYTAgNJxNI5HnxE1MnKo7/0qFq3hJixzQ2Cj7S3xG/nOdM+88q+CSfVYsCBezHguELxXEgSyxFaKTolHbthIUyvyqc1/xU7vX8AgNioml6MHGE4ZBCkgahjpaewyncAqBl0lp5UmPI+LKK1WeT0vmTVq/D/V1Ptx9fXcCuH2KaNgr6f6viYSXnoUSKl+ZUOUko7Ei7nnUqqD/cZjKZX9+BrD+qTX43Io6ymsHFIS/AIlXsChNQXYwCOnPkK0CwI8qrQ3oUg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbhciavuusKDLxJ4GZY78yoSQYq+jkgr9IdQU+z49Bo=;
 b=OWVO7ohxcwDIKwDhO6/Jf+IGx2IAG8agS8e9Rz/6DasABVpQcvmb/Uhb9rfvD8S1MPbcREyzpBYaKfl+8FZtFKo64KGT8MGMocXbdBfLReGhWZemHBn562sYeFbv+qDaU94KtPqw4mi3y8+O+GGQAgt6LB5b/rZcUyEidNqDDyQFgnK21X2E9Fv7ywc1kMVlUMGDbCosLoYWxeIRVk+yi8sHmSMu1CgeJDho99wdO7Baulcwp2Cuj1ETjlkdAFFU/HK9yAxalc9Jj7o400UyxuZDDO94xNGCxWEuWDiABvS9CscH0gAlMESYZdbMfXhXoKwdXYxdJK5EFfcZsqRBZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PR3PR07MB6922.eurprd07.prod.outlook.com (2603:10a6:102:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 07:48:52 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:48:52 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v4 0/5] Lock RCU before calling ip6mr_get_table()
Date: Fri, 11 Oct 2024 09:23:22 +0200
Message-ID: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|PR3PR07MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: b15d9167-a822-403d-a73c-08dce9c9264e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tAFGwGY/jGmy1Gx//Wg+5AHEGxzTHD+7uRZ8MqFSb+BrbxzfrTNSrL/EJvvv?=
 =?us-ascii?Q?ejrnbvVqMy8izTo9ubpwUIApORJ1/TVThOCoFFagX1r/HGYqDtpslTqt8162?=
 =?us-ascii?Q?zjI2DL4X6spqi2UvyDSSLxPbC0gKAgBwLP80Mqsz0Wxivkz2P2N7xmN/Ylj9?=
 =?us-ascii?Q?8Eu2ClXJZRIsm/mQSII/o+PXPsQmaEAfUabi2jgou0w8NsnH64g1JQW3JXrn?=
 =?us-ascii?Q?aeGx0vkQJEeg6rVLcVI/idctXDirevKL+PPHji+qf69tP2lRYDB/7GZvdptz?=
 =?us-ascii?Q?USUuRmqFx+7Htk8uuKUAriCHM/8JlSPFXHmB7CNGcTL4CpmIGzI7X3FAmx/r?=
 =?us-ascii?Q?pKmJWr7i241t/zhkPRxHbabgsfG7jGYiAWgqGPRjkcKnv2JbSeHBJPALsgD4?=
 =?us-ascii?Q?0X772Dba46uaGzuh3FgtVu9n5suIc068cXki3IU5B8JcYDSNEZI8IFFfuS7g?=
 =?us-ascii?Q?8GFtiz7wbtjufJm/FOZDkM3MRucSxb3tRHH48t0AdNrIC5nNXvV9ml6FibrN?=
 =?us-ascii?Q?X5sPt2sH4GJ5a9zAmULnhATKwt0C3DxsyTdUXFjmbPkjTXauFC0eEn4mAaFR?=
 =?us-ascii?Q?l6K8akNO3lz5xddRW9ubXUpKPb+gyEbYneta6CgeMt9WY6zWL7Y+JuaBkgq5?=
 =?us-ascii?Q?O5ZRUWXPFNe2RgcXfUqellezYyXS/4Piaq5zVwK6908RHV/6CwxkRyoK6gs7?=
 =?us-ascii?Q?PXeKd8YDY5vxBdFav2+hxIKChm0IJgd8pYg944xyeGtevZApZJq5jDEuO9q8?=
 =?us-ascii?Q?iDmaT6r54vSBKpnUu9l63aGqqxc08qB5mFe4NShQ5eWpp13OMhX7CWNF5axx?=
 =?us-ascii?Q?bD5XFZsdwojstv8RUT8DHmGFLzyPrmAI6X1mKTkuGDr2z5TqRnmejCcQPSJT?=
 =?us-ascii?Q?nQ+kk+pjv1MZoXq8wFxt6k5gV/4oNsaykQbP2HudXd0/B/fEok+/CzkLKg98?=
 =?us-ascii?Q?RpSNMBPDCpOm62oXgJwPK/jx/hyghsAMwt902nr6Xjk4f9zl7jOogmKQQ68s?=
 =?us-ascii?Q?B3Iwi5Kj0veJw0mZWaTNeAMNTbyNINrw4gYOZw17fCw+5J1yA6ygVhKmb/d/?=
 =?us-ascii?Q?eUigIZpt6+U+9t3lNQ2GCV2finYkcvTpRx3DLCQLEpk88y39Deh+BJelEacs?=
 =?us-ascii?Q?U6q8ZbUGrnKlT5sNR2QwiOkUyD1cayjaHVWO3L4HFze4lC7YgyY7t4c0LUIn?=
 =?us-ascii?Q?whywVBC12vLtmwhMPfR73PGoiSk4hHlJTOvCJ/F0U9Yh+rMAlRVdsBnXVIcJ?=
 =?us-ascii?Q?I7k6JhV7nR48fbeDcRxc0QFb0PZhCuxSyWQoPt65UX7BxEbwc5AtgDxCh/ei?=
 =?us-ascii?Q?LrYkReaDc+MnuV6hYhKn/IMS7QQW/JRxUPYGFCxwCBLZLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gLkS4WOymGtUWezWi/p7JesewUSmOEBU240WCybPSFE5cemwBaVohTYMzNUV?=
 =?us-ascii?Q?y6D/307Z8fBDm5UbmgTKG4w02wgMUJKbfO1y5nZ58HPT6Ot6WeN9EhGx1Ftu?=
 =?us-ascii?Q?zv9sdy4oLIqT9y7tU6LpLSUS/Zwdz13WsPq3tQ+ZmfVCJNEXKsu1c6nz8BxY?=
 =?us-ascii?Q?Wt06/ePNUr/gqZ8sVw5sKUjXHs8V5JJAy9sEL1IW/1zWyRYEaLG0OtjI0Am3?=
 =?us-ascii?Q?JiHgQdkwGrD1ZpXJhJgClqEbwtL77G1l4bkhOY9jWuZwSCrjjNcwDHx/zpxR?=
 =?us-ascii?Q?Zdq7COs5mXkjxBItgZjXwGSnU2wN5u6M2qMb+1KN06wT84dCWqUU5IqZZPWz?=
 =?us-ascii?Q?5hTBaBjvi7iwOQpUWZnm14dJwJZ/B/twACXx5cdqgiqjDJYlT8PLbZ15uA6K?=
 =?us-ascii?Q?suJgsk2upOfYng+a8rDzJHGwwjRt/bZK6bJuuIJ5CG0owXe2IWvgeHopki4p?=
 =?us-ascii?Q?pU4t8bykblwlcJo59xnkQwjCRlc+sKRhMLrvKxhxWPZq/1ZaA5uNtu/7+tn8?=
 =?us-ascii?Q?J7chpYShPo8qMXiUOPmnKffEvRrvHbZq5VigDthpcpLKenEIhxMomQMiUUf+?=
 =?us-ascii?Q?2oMzIzFgISwWKUIumI5CuNtg1DQXbthKMyXE2h4t6FeS1fv/JxXQ7yQfMNtt?=
 =?us-ascii?Q?l6zXUsIFNeqlcDajzj7L5mgNIyhRYgSSiJqvxVWWI9GYIfzaHBoDxxzZ+sp9?=
 =?us-ascii?Q?SlIomhQcnn7KA3GW/Xm5FtM9h7JIwhruDcmZyLRU7E/iPBD/mJnMmDoVwz11?=
 =?us-ascii?Q?ZMcShGw2uReVcPSJ8cf3HLAtfF5pg480TzmT9d9FXhbfZVVvPdrmn7XnIgBr?=
 =?us-ascii?Q?FA6c0DB6cmhMRjpV/bUBb6T1PGNq+Zk9TbmNJ4PtBV6S4UjTz65xpSZ6JG0m?=
 =?us-ascii?Q?5o4KnP635hm0dlXNTiUWCShcYy775a03Bll7cGc72yrcrBibx0ik0R83C5dc?=
 =?us-ascii?Q?rcttEBMDSUALvlwabYjM/YYmQCmZA9OBxcwQXxmsi9FZdeR5qteDVmgzML29?=
 =?us-ascii?Q?guLfhZEOJ1p0VZt1WPClYyOaKZ3uw/2r50Rya/ibT9KSBeOZB7NpT7xUfLND?=
 =?us-ascii?Q?IYXxJxQrNqkoHJ6pArttIeMsi/0Fd0rAjJcKNhwN7dRpf53Q8IyxUJ4Oytfp?=
 =?us-ascii?Q?Zcu/bkv7ctvGWLl2u37kQN76XtHFiM9CIXEMpqu4zKTptb6EwlxOPFn/0OVQ?=
 =?us-ascii?Q?3OeDSlCIGs2AfE9FtG7AF9X2+yLUSczGljWEdta+PKKTV9alJJqkGNdY2Zw0?=
 =?us-ascii?Q?aMnSGgvbMEcvYezNXd09+2mk/I9Ojh3T7AXQUz9OUgL6S9WwVqP/IZDi61qD?=
 =?us-ascii?Q?dGq4LSTdP6Ug/f1SkwI4sWFARp0anDMs0UUnVRsUZ3q3xY2S7FriKxDwl+DW?=
 =?us-ascii?Q?DdsNvz7hd4LbLjVUvBJUm6w/t18eXYWruxGriX4xPv31bUKkkBPkUH2dV37b?=
 =?us-ascii?Q?trEClTO7CBqzOY9/tgb4xMm4y6/hqTw7ZDdkUdlP+oJmaQZRNRfpv0yVl1OC?=
 =?us-ascii?Q?Q+rIvtjHk98D5zkCRxpA640FH1y6ByvgdtJPitFEfyH9WrFneILO5lLLgkK3?=
 =?us-ascii?Q?0KpjjQwz/zGFyZ17YswAQFfOMpQWFCCbsB2b79b6BeuL/8GrbiYDUF39ZmQH?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15d9167-a822-403d-a73c-08dce9c9264e
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:48:52.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fhk5LCOMTu68E2bneQ282vJtI3gG8PvYTI+t9XEnhmIp1UBnOBBbKyXZB6IzC5n75b7awYHIbyBX2Kxm0EKKxHGlEyn+iQYSq0IksAMGgG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6922

Lock RCU before calling ip6mr_get_table() in several ip6mr functions.

v4:
  - mention in commit message that ip6mr_vif_seq_stop() would be called
    in case ip6mr_vif_seq_start() returns an error
  - fix unitialised use of mrt variable
  - revert commit b6dd5acde3f1 ("ipv6: Fix suspicious RCU usage warning
    in ip6mr")
v3: https://patchwork.kernel.org/project/netdevbpf/patch/20241010090741.1980100-2-stefan.wiehler@nokia.com/
  - split into separate patches
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/

Stefan Wiehler (5):
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_vif_seq_start()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_ioctl()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_get_route()
  Revert "ipv6: Fix suspicious RCU usage warning in ip6mr"

 net/ipv6/ip6mr.c | 105 +++++++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 39 deletions(-)

-- 
2.42.0


