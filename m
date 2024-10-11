Return-Path: <netdev+bounces-134507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1323B999E84
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85636B23043
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94920C488;
	Fri, 11 Oct 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Q8ARyHai"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7720C460;
	Fri, 11 Oct 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632955; cv=fail; b=sQN9+vw07LrD1LyHdm9M+x8QhwZMhl13jNuVtiU8+9O2H3Wo7ox+8LRzvTS5sQZVqmf1ENTjT+aZIQ49O2O/loLQ5J0eQywlsOZ253oE6YCLsdBohH1OXc5gHXu8JHHJfJmSYA6BMexzsZ1+xhG3fZ8X8NYANdwS6bagtoXEgRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632955; c=relaxed/simple;
	bh=0TZBWaT8/m2CB3ub0+FGUA21FoqKUXG+bYXQtNb/i1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5ebxBmz5iC5zMOToBKWH9jCcXr7Vwagsu7t6QZ2Yv0OmVnCqBdv2RKRrM1YU5ffHI7133oFi8D9LVWI7hmUmx92T44NRgUYiI9LDE9vN9ll3k2KayEecuDnPhUMLjtUl1GmI3kzcLj+5lu1Ct3XLz6tGzmL5j43JjahtRLpxhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Q8ARyHai; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmid/qnCVlCtmt5UxTOm1RNfIgJjlyQdPaoBqOQ1Sdizbm/1q0zp4cNPDAmLFCylN02M8yGEe7sMwuK0mCrVVI3MH09PxJWwsr8Dpq6cXrSkcyzDa4x6rTv465N6ZZfZP8Gkafh/sz8ZUSNRgfvBMbctFco6VxUn4gAaVM629UplvlElHsICSQlUYJ4NgLvRKmfi7LO34dWrkkOtyKQxQY/Oi9s5MLa18KqN6i1dk62LrVZCtHm5REU7Zon+hE9U8x5IRKfWsNzZ0FLbLP/Bevlf8oALB5XO17Lh/Z6+WJS6NLbiD3b60BWW2GvHhvFGYHP4C36efw/GbUYjbLf/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPfSonQcYqCmQH4rzpVWQ7ao5gpbLP1Z7dagYjM8uXc=;
 b=DVwa/b1WzgCGOGpeCNOehVehl65xLfMqzW8QiRxk9PMBQI/oD0OSS7DNYAwh4LQgkBVI01bcRfmNmjDrZScbKf0nZzj9hInhs/00gHNTfC6zun8qj97KleilZhtuHyBfpsu3/OYAddXdcNjVAb2aaU+vURMrbeqcE6sxv0KqQUkqNUf+SaqkLQ9xuM7OkgpcegnVPVwiRkkbqxBamFYpVn2e4LP7wgs+m/1FT0tAXooX5bAAPbRP5LnudFhbNl0mwt3MH3IHBYLCqe+9KkrMLFh6FcmXNvG9wWxMTh5phUIjP0tdQ8LRnD/lFP3kZtlDcep7O2pxo6S0bgeqgkr1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPfSonQcYqCmQH4rzpVWQ7ao5gpbLP1Z7dagYjM8uXc=;
 b=Q8ARyHaiRBeSMlk0A/M25b2HBfVzt344KMiYLH5Q6RlmoapvNjWhs84/2sgEA10ILQd7NuKcioHhqe9ui/ZH3VHA19dAL2yXBwRNXG81ujYgM5nuq+/sMNrLVubCqIJOTI6MThzDt8jQjq/XqmVNavekd2UJm+9VhflE7hVP8beb8f32IcVktYTQg/hBSAG7hwGVukqw96T4A4X1IZS0rwc8MRL3XWxPUMsn93PTvEeL8hLX0D1GeOhx34xfg3IPlVmlyP4vGpRVoc1QZDMWD3oM9FELQoOsMFvFQbZ+bQsqZ4E5T7S9iBATkjLI+Jxe16YkQujXoq1GG3hGlNaL1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB10028.eurprd07.prod.outlook.com (2603:10a6:10:4cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Fri, 11 Oct
 2024 07:49:08 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:49:08 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v4 5/5] Revert "ipv6: Fix suspicious RCU usage warning in ip6mr"
Date: Fri, 11 Oct 2024 09:23:28 +0200
Message-ID: <20241011074811.2308043-9-stefan.wiehler@nokia.com>
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
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f3eece-5f67-471e-7724-08dce9c93047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fJ8ahpUYfaAylsmjUUo5oOAIb88+LJSPtthtHICNlUIl0AjTl9NtKRkTmzZt?=
 =?us-ascii?Q?treXHNSAPuQxnHutCf82eB8Xn+ldCDcOWA2J1MUpDJ3ej416QyVZkj57tHuZ?=
 =?us-ascii?Q?ytNIiA++SB0wiyIgXG5fQd3nR3GIKyg9CKcYxC0daX4RzNJQQ2Fbmav6dthX?=
 =?us-ascii?Q?3EvgOVTu/L2m6CusJlYR4imYDBL8WpUfBGXm5hULgmBKozVZLfdyGg5SeMAz?=
 =?us-ascii?Q?nGyWJcMpstEOUvARgPc08l158z54Wole+p8kL+0B/bLDUI03kiOf/Pp7/cRT?=
 =?us-ascii?Q?XEp2Df4xVtOCwX0lw9t+3z0QrLo0O4xj2P7mHISGQtn+nxzhMlHTIv2Flhri?=
 =?us-ascii?Q?Uq6oB6DjiWdXWI7x13glA0JLoeqzFi/RhMZNiPQ7iwTdoXEJTwkD6ANksAJi?=
 =?us-ascii?Q?HI8w5eBk+fFCR0LWDSwWiH5KCr6fTeabxIdi41PGG1kd6FjgZFlznQw8bMyi?=
 =?us-ascii?Q?CuX+XlOEdn61AMOntoGaoyx3SsS935XAutt3y3q4bcrh9RwTfpREMBvmi3cM?=
 =?us-ascii?Q?y9zFiVngtBZaf82z4i0TShM4tfDZJJPGH6O4m6JtSTNrERpGcBCI1iskxxY3?=
 =?us-ascii?Q?LdEi+Nh7EK2lHNHZoktArYhxHTKA6Sm7xjZzKoT5YIjop7A1/hrXQm4nO29Z?=
 =?us-ascii?Q?XzXIh7tPlA72YlME5tBHjf5xAZv6lddGlIdQQT0wS/5q1llDv1ULoPNOaHDw?=
 =?us-ascii?Q?j41nWtLf+Cnm7ycYQtH/MrsOG8pWzLQhfwFdUUh93LWDI5iUGzMcwHBMpfTH?=
 =?us-ascii?Q?QfMoHrlU5SywtkRGA4MXo8P3bTY8joAfKT0FXV2+7Hp6ZzfmVuT1Z3YIiNAU?=
 =?us-ascii?Q?SezpTyt4QCXlKBvRKA+EE13Z7bVr94nWITKbJSnNLs0HlIIDeHHKXTldu+is?=
 =?us-ascii?Q?4+DL02F7HwzGmWTwrikISPj32nciogeU+FzVFK9gnkdFros8eqyaJEVgTDyG?=
 =?us-ascii?Q?lvLZf7GS8l7TpdX1YL0AwdP0Qpx3B8sRQoPrgrLP/GOzIXLJyVi3Jo8EuWfm?=
 =?us-ascii?Q?uIN0a28IZ5QrkeXG+tgIjkcw0luV7T/8rCtmjww8Ou++8FngtgTdHtT60mtC?=
 =?us-ascii?Q?zFZplvI7+Y3THF9FpkLxKE/DCa+83puLTUVLe8vfikcxrTdevJLr1Jv6tLYG?=
 =?us-ascii?Q?4xD62KngZX/a9gxMgVUu/qV+gEh7sYwNbZcSH+4ghXB53f5ASovn0xXGbqK8?=
 =?us-ascii?Q?TEfFxKAH5b0AQDQ/3CqlFKjCLIj5FneV8Lm1O0lQALLCQEqcYul/gDrQ9rM9?=
 =?us-ascii?Q?hI2flGj7FovUMIkfovvQm5ruFr6JkcAyw8lF3lXd2ypFK862Zu5JrObQMNPq?=
 =?us-ascii?Q?m31HUyvZ/ExebjpGDcqGs1kGUEMp2Lq583Tuza3ym+VQYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Ras1qTfUGx5qpCV5aqm3FdinYlLzI3tWe66WzsCmyXdm1+kV451va16Ftcx?=
 =?us-ascii?Q?0qGFETQB0TOWPOwLg1sET+rT4IDAd7vorWteVwiuZHsv75I5Qrb3T5R1ijW4?=
 =?us-ascii?Q?NFwhGAbbqlARMHFxGoUOE6Q8Xp8jFwDf1pGEH5Yifmp/s22jey0fLtsWLk+V?=
 =?us-ascii?Q?UZQnWXw6IOZOGKmFaIPYMdLZfuc+k1wlnZLfqKrDTFSUB0ix+kNHYrnUxOHO?=
 =?us-ascii?Q?khkmJUpbOPCJfs+CZ3vb1QR9auytnm34tlg6rMTOzi/CkH2zglJ2KNXaVxGy?=
 =?us-ascii?Q?rrO6n3LGVZ/8/Qd3yjZpQVNEu5ice0AxPmdkW+LpYGfqTtz0bAToffADyDuZ?=
 =?us-ascii?Q?d3d2tDSNHqiTQu19+4jQp5Hdagqn9bnNvzUXL9k3PCMefQobBSglkh9kTk2q?=
 =?us-ascii?Q?7xztTPwA/GepKbM35gDqB3ne/KIDyeQNY8Wf9CpqhBSKizx6gvPVFiDjmCyJ?=
 =?us-ascii?Q?17165sPg0lMiTBDXhH46DSwGorfzqMKkd+7Xpm9TtLs2+uVcjx7OgQLaASHA?=
 =?us-ascii?Q?Pg2/q6xXxz6GofsB7ytsZaslF8YSlBcAfIO3g8S6TFGPVT8uNs+HFrguBwQd?=
 =?us-ascii?Q?oBkpxMF593/o4Yuz82vfMpAPffE2m3Uiz1ljXiHciJR/LBFeHVmIx9pmTw+3?=
 =?us-ascii?Q?9iB2txa6lrPTZg8uzfkY5L8CwtcIMWOOh+eocDwgm4G1jKEk2GP96IlQu7k7?=
 =?us-ascii?Q?Yd7ofcaBULui5ESvo6EzbR77PT7UWrHFtPvrrRrwb+5ZqVHqfCD/3dOLySMa?=
 =?us-ascii?Q?EsaE0ghNtGUIxpJJmKTvPlLBRf2skgFID0Ewa1zSX5l9qu4dBzd1rG+0NEj2?=
 =?us-ascii?Q?ViUGZf62a1XsQxBU1XmRmVkBG1FClsGlkD1PjNf5DajpC6wEKxDUk5uRllXg?=
 =?us-ascii?Q?M4vWNyeOkYS/5NlN56HaZHcunGiLHMWfQ4ZwIE5Jy08xHBtaows6qTlD5aZa?=
 =?us-ascii?Q?sUlPp4/LfBeTky6G34/ZW47teZ8GZ5gMTVjSpJnhWGMdGklEz3Qb7NZq/M6c?=
 =?us-ascii?Q?Ri/C/GCgt8eqeYYmq6kV+Eu6cpy67KahgvIZHClmdBHjtF812jZ/YBgZIBml?=
 =?us-ascii?Q?zWMfk08OS49j+xQVM5E2hHBlEEdgFQU0yADwGNoUFi/XKaqKGegWcs/CYf3b?=
 =?us-ascii?Q?gM6tD1cGcGXJsbuL+OxShHlKydOBejBOui8VvFy3Xw6/PF52Pd2lbm7GO3ao?=
 =?us-ascii?Q?6/bI/yWMk2XFL27bB5HGMUDa9wJNs3zZ12guiMHYd+ENNDlPRp0rZE+kKSL7?=
 =?us-ascii?Q?xrG0L2BpxRDk6DuhdSm4CGNPv6eUEsJbznmf+GBw25VbMClH+cqTmWPL3xk9?=
 =?us-ascii?Q?ke66SRPX35ZfW6lz3gi8a9S0nbefnj17HVANuhaoer7JKp7DIkZUZEwqQJ9b?=
 =?us-ascii?Q?h0cHkBcqOMKAHj0pMv3/WqekTnflYehkjbZ0C7jqt649maJ+CjAkUSYgZVKZ?=
 =?us-ascii?Q?Puk9itAUXLSdQj8fTIwVxge6S7pP8Wqn2mKG+1hznBPd1DKDMJ+c8plStJJB?=
 =?us-ascii?Q?5ehso1cIvgn8JOWQpjVlHZDUE7cvkXNDaqFcPHaSN/2YJRsbyqSDoKSWQWgB?=
 =?us-ascii?Q?7a/zBw61hF28RqiwEcLK5m+9iwNNAOIY02HDx3qrazrg85jU+gQrPsoUSiW6?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f3eece-5f67-471e-7724-08dce9c93047
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:49:08.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5M9kwwVd4OW8XMlksFHRqfv1FpfFeDZJek7aDmEEU6J8jvGjHB4R/IT/IGGcCYT4sdOROeIQ1QshS7D2+Qdkzu9NXKEp2gbOCUEhoMuKjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10028

This reverts commit b6dd5acde3f165e364881c36de942c5b252e2a27.

We should not suppress Lockdep-RCU splats when calling ip6mr_get_table()
without RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a817b688473a..44e2b4d1ca23 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -105,8 +105,7 @@ static void ipmr_expire_process(struct timer_list *t);
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
 #define ip6mr_for_each_table(mrt, net) \
 	list_for_each_entry_rcu(mrt, &net->ipv6.mr6_tables, list, \
-				lockdep_rtnl_is_held() || \
-				list_empty(&net->ipv6.mr6_tables))
+				lockdep_rtnl_is_held())
 
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
-- 
2.42.0


