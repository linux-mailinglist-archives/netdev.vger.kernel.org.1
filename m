Return-Path: <netdev+bounces-134503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C81999E7C
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E0E1F2458B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AD209F50;
	Fri, 11 Oct 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="KuzAORHp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515861CF7A0;
	Fri, 11 Oct 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632948; cv=fail; b=Eab6laHcvHAYNlzW7SI2rP3VI9Ml87rUedXYpoanNI+yhcvKQQebePQRIHjluc5zMntH+vso6MRNSYilQTr7gok/RCVzQlYIb0TO3L1wgJfI7MUA/mmgcxqAQZlPoAlTYSUvyLcxrkcWHyvXd9dquWh8PmvClcoiyttl6MflWrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632948; c=relaxed/simple;
	bh=ib6Faai4OQRqmtopYKqjOO0SsweiMc5aOUhyF3/iuI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0kkuCvpLsPFVaDPKRgm7nPYfAOp/Ndwx1AEa+DuMYBi15BK5sNUg5HP0JzUrZh6tbT2/RnIn3hrigTsw5fLrWi2IB8rbNM3o1Et1mGt1m6t9RCFznDKb8mjAH/q+Na2WGFv6Wm+dzzDv78hq9Uzhenh8Zp9zRbgJrBRET2qk74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=KuzAORHp; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rijwIOpOqbkAfdJoar1pjTYWV0nx2OFvXg8CqyodByyj8AfEmtqiV3jWHfYiuO5NJSuF4xD6jMRs46eSN1zr5kJlotA1cvo2ZsxqlnAtccHozHKj9I8hScKFY852fnw4Wj4fRJ+0Y1s6sap2Tz8gxAHdXD0Gap2JjLbL9ogPE+2eEqxZ9InvYYev+N+O1mKhUFqFGr75TRQYMQ9nOCV4D+7neRzq895xdGwQd+RPTI3Te3Nkcv9nRJHvJZq2vjgr8KzYnEuJtYxOiUs9GLYCici3oZ8cU7efSuDtf503u/ljj6HVbejIA6XxghdH+zrm/106t87A5Uc2nK2TPnfoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tWeL6x6otq58JBciWHLWg2V3W5/9/f7qlubIloiMjU=;
 b=BOlw3vIHm0JWG5WKiDBlfVwvgUVFJJpERxN5fJTFhoX+Co64ggC5+8eSzYiqQLQA5g8sxO7cuMQbUY2sBVYTalSXgHoshLEjVJk2SASsv3aNTaGCWJIuTGZ4eYJvZYBcr8mZ4ZZuhRdLotwJWQfhjeHJ2jL/ol117trWGdr5E9AZGpPVQddPZuNxPIdMaNtjV+zdeP/wK1fvfnjU5WIQAcBGTA6azPhAwoi3rBOvjidO5Olma5jgHXIitw7x0CsvvXXZpnvo6kWabjKTtASYzR6/Xptnv6j85aiSBeRXdRGYZM6u9STMqpNf9Od1wMtEeqmYcfaM+FVUlYjhKpnzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tWeL6x6otq58JBciWHLWg2V3W5/9/f7qlubIloiMjU=;
 b=KuzAORHp2aCXzgt5hgzrH+7lISSymJl02gsQzBrhliK/E0adXAzOwy0UxotnZyiAtJRN0uNO83+CeO5wJgr12b2IHQ7ReRJc0IW0g2EZuCvude/wXedPW8VPd1kjHGqOFvkOASeP0v//TEDDmzQQaT0ARBWtoyKGShZiEYKg3NzsnSW0G/POwA0nDPKnf5mxmWtaRATv6v+nkGTI57Rts1wdT/C0ABEZvOUMVw9zeWySuEFV9BVlndBk+Yo/6yZqShRv+UkuQo2UGRk7Ko6Bi+RMLYbgITYze2RUVA8aldOKCkThzEcEs+n3YfsRuQr+ZTNihDWCp6oZC9b6ATEyBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PR3PR07MB6922.eurprd07.prod.outlook.com (2603:10a6:102:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 07:49:04 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:49:04 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v4 1/5] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_vif_seq_start()
Date: Fri, 11 Oct 2024 09:23:24 +0200
Message-ID: <20241011074811.2308043-5-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a735730-126f-4893-35c3-08dce9c92d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Df5R+ieoCCUdgJC9RkU0jf1aMCOCQlGdM0hUIN4K9AdU5eDlAZ2CebjN03o0?=
 =?us-ascii?Q?eP5olV9USmwgPdQztb1bLfsFymzwAmMh7ZUwlU4OFTHmcd0hPqtjhMMOgz2j?=
 =?us-ascii?Q?wCDIo/yQ7qrzHO5K1zyJckAdV5tz6q6NC4CGVnECOF/exAyaoLHBtSNZra8o?=
 =?us-ascii?Q?cIN+0FEmMQzDnA2fhUQHmLv9dhZi8EfYagysu72M38w9hVFjYw397a2p3QOw?=
 =?us-ascii?Q?z+XgakVBGnjObR9TjbEezBeV7CG309waW3+v/T/iHCwfYbH5wERADwdOKq5H?=
 =?us-ascii?Q?7rrdHINKMMzC4MLmCo/qIWiKz9i5gqNrH4ovWCiVrP6vXPu1/QyZyohGMMrN?=
 =?us-ascii?Q?7shtOuYv858r/leoR6H7l6xdDdoJqeCcUDg1KV+DcILhLCCgJ+rv9D3M+IxE?=
 =?us-ascii?Q?bvhqtTe6VvmeNLsfmFV6zejFAQmmh03vMEyE/dg15KUkxlhHYU+xGqMSRvrB?=
 =?us-ascii?Q?e4ybuHDzqMUctSODPo9VQCldO6/xhi+QLUewIKt8y8BacrBVudd3EJkSwoXt?=
 =?us-ascii?Q?OABlRP/UVpq7nx+1UFDD7QEMAGDg3Rp2PSGKSinRY+jgbcDYL/FOdOlWSwpP?=
 =?us-ascii?Q?xZYdxQjmuzI432vaZ5X2xWDxCzIPiCdsHuOpeKVVoHTQnYmUPByXP1GkmtAT?=
 =?us-ascii?Q?0jOquPBw1an+aTPCPxSZ+RCSN43QC5GJ1dLl1ngGK3aL1DlDbZL/MmR16eMB?=
 =?us-ascii?Q?jWk/dw5RhiSkLbADbBO9/f9tnRHEFllNHUPQUX4PHTuKHKE/BpqYIClAa1Ev?=
 =?us-ascii?Q?dWddO/vDwL0LLLww2HecY7oz9eE1NAQ65GJzmWqoD4DrEdwK2Y/K6nj5p4T+?=
 =?us-ascii?Q?wz045V2AXy3Qr8zacMGfreZekvcfCz3cO10bt5q+dygaL2GJaCXEHriARxUv?=
 =?us-ascii?Q?TVRRoajEZxr27BumeZYHj+uiGwRprfW2V/0OINYexXzE6gWKP4TmxI1bnuee?=
 =?us-ascii?Q?3dLFdu6EQGv8JXkGgy90w7N9/gMWHe+DKyLNsFWozqAIS4LVmCd1Lt6coWnV?=
 =?us-ascii?Q?FBDW3ABpIfn/DeY/C+AYafUYEP+O1cmuxF3MzSNRnmmRO/IB/CjziTLRP/BN?=
 =?us-ascii?Q?Inwg4DE75z1+Ffbl747A8i5xIwxL+6SdHWJLYxFeVeDCOhQ2Vxq9wm8Q62WV?=
 =?us-ascii?Q?x2Hn11jNusgIs1fHUwljSLoqobODyedpnIrDr57CocpbAD2k/TXGcn6lS1jo?=
 =?us-ascii?Q?IwBQZWUiAwPv+8thFyP2xHhWa8DAEib82ZDkrn1oTBfUQqZQvU95W7RvN46W?=
 =?us-ascii?Q?ig807deF56oa0WhD0n+pPYPy5Q9XZnSH4k46bSM5dSPLs7d9LQ+4CYgblDcI?=
 =?us-ascii?Q?JJLCTe9V10L440rvC0HVHoM550dpDMFTY9+MfA31B1+P2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlqlSUzBgntMTI9u6AH3x52M6BN7Xn3KHS97HSt2Ge/eX3zV5c8YppNW9Aso?=
 =?us-ascii?Q?hhFmvpl0eetQvRVS5vk5Z7f16qNAb1kILB2vhblSD9KOKICdXMtdvQxDnSED?=
 =?us-ascii?Q?mZ20Pc4w5mU2PxSGXuUWTTYRMixMWBPfG4AkYecY42Q0mkus5YwE+Fhczy+A?=
 =?us-ascii?Q?Iia4EK9jga9niq+iDq2+KLHoRW9ie9tI8R6HtpeQJtNTOUSeq6t9xc69J7CP?=
 =?us-ascii?Q?bDB4KL1zOhUIy9s2XnyWZ8g2Galk9nQ6FCaLtj93zVvkhuNBQjVqtwYheLJ9?=
 =?us-ascii?Q?Zho4qx2U8Xkls8EsgGfAfGsohr2hZVADl5FkQEIhr/FDjZXnbkPFZ9QpCtA6?=
 =?us-ascii?Q?hpNpRuCnBJLPGeTC9P6m0w7AetEaj1tgGtEv8PxfJlgiDrETUy2V0gFObfEY?=
 =?us-ascii?Q?VistyupQ3dvdbMwYqMpRmOlcMsdA4KEWa9eEhPJdeeZoTWrZ2onNSos+2zlv?=
 =?us-ascii?Q?3vGIAba33kpo8FIgmqXj0aSp1VMIqESNBAmgFdoAWcGbjEnlZGy7AZwUkWOh?=
 =?us-ascii?Q?hf6XDOph72+H8j4IVI9NcL+MBvLRfL9JlZwC2jVODAKBYUrPiugMBSkiTD/j?=
 =?us-ascii?Q?l9L6BfvVUCRNVVx7hMw08bgLeMk13dM8gYTfQIQr9Njyse+hMlSl+TNuAWQj?=
 =?us-ascii?Q?/jtBPjuBuKJzJJLcjBcTQ61BWxhJMylKKpuzbZ62GyEqLsZ+r519WQWaqSao?=
 =?us-ascii?Q?2iazqIJcFZbV6O6rZpu64L+zV78Yh+OuOZcgGJLB9GQW8nmQK/6a309u8X9W?=
 =?us-ascii?Q?24zK4Ime5JKYZjZ0/YiJAtybnongFV2DyctNncsJCzPlAR7AqUMiI4dS2OhL?=
 =?us-ascii?Q?u4vxYej6RwBAHEMrGKDDRGouUzmkVWZp+6fnXq8V0oNljUcv7mMF8eGeqhLV?=
 =?us-ascii?Q?NBP1EZ1rn9Jryqowu3dmU6ya/DUzuqgKzOiglK3KNUx8YoV44NSer2j/cKrx?=
 =?us-ascii?Q?nRFda1OgEvoPWHAqU524YU5q0d7bldFnM3ILLDWj9RZkD5nNfK0ItCCLCz8M?=
 =?us-ascii?Q?/0415nDZapeUt2yLp9V6JU2JcEmxpreJklrlvNH7r7aon6Od3QI4ejQPwmyd?=
 =?us-ascii?Q?uMaDCmhnreXPdjg7wpItDIN592GmMIpP/kPKVWi1a9XQ6WQngsSe5/zNG2ex?=
 =?us-ascii?Q?InU+kkS2P/dAtJav9zRYOVCMFpz1Qp5qnEJuAhN+tViAFIOFZ6/w+5FgAtNl?=
 =?us-ascii?Q?+tUHfzYRxLiihPyYQ7LU5cFH6JMK2+EZkRslunk7F2BY2Vf1sLK1NbmUYtqi?=
 =?us-ascii?Q?HeeVkOjGFoUZEi9dwX0xuYWFphcvYC1HgJbvTCoSHPiXbeBwtfwcz1YX6lys?=
 =?us-ascii?Q?Z0GNUdqoAm1AEdXYtQwWxTPkDRy6b30l6z2vfHshjBHxJCvR1eFa3rew+ilz?=
 =?us-ascii?Q?Ob6O3tcYQNoqBgJhKktp78gzMPl5ok5LJ0htSjttOMVxHQHk0R8z0dhhcltT?=
 =?us-ascii?Q?2BzqwgVXbFY0Ldnhy8R+0q7x2Z5Ny6Fv3Zi+FzQTS8RV663gOk+ircDNe/BN?=
 =?us-ascii?Q?hCdbZegrxjwR1CPfX52eQkrYqEws7xUYvB+lb5XKemsSn2CFdnblY2Yb/0cG?=
 =?us-ascii?Q?69bxi/kaSxU/2RJCeePhiPkxamuYDQq9LKqYdRQH1cj+6qOJ1EMGs2YzpPRq?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a735730-126f-4893-35c3-08dce9c92d86
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:49:04.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du9jbSr57MN3PjEm1a8T0SdXL4ZgyBR8H235dahKoNlLNa//7v6Sk+zsf0o1Z10N02dD3lgMX2kfofLiswPTDc6oWDQFvB81La3GtGoOjmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6922

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

In case ip6mr_vif_seq_start() fails with an error (currently not
possible, as RT6_TABLE_DFLT always exists, ip6mr_get_table() cannot fail
in this case), ip6mr_vif_seq_stop() would be called and release the RCU
lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2ce4ae0d8dc3..268e77196753 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -411,13 +411,13 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
-- 
2.42.0


