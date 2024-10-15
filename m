Return-Path: <netdev+bounces-135784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A842499F38F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3791C2164B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401FE1F76C4;
	Tue, 15 Oct 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="uM9G/uYd"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439F1F6665
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011593; cv=fail; b=Pc0asSbmjG7vIavnCrZ9zl81K29gnmEyLCmaxD3Y7mujMgBqMjYFIGQYbQQzJinZL901cfw8mKJpNKVKDfFafCIshnYwcOkPCz6IDOwvvpbHRdUlXEYMzjE9Mjja92ztcUlN1UPz/8I6YwPzgsnofv82OhX/fZB4Awdij2x6HkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011593; c=relaxed/simple;
	bh=jV+iIonJlqtpHRSsioK92yGJNQ9/kW0R3aaSdA7MT+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P45dU3o7U8IJAwCtnXZFxwcPAcj7fXBSoT2gFyJk3EEGsG6WdbuVlRJMxgYSWabK4YGDBk75x/GzpV/i0Od7wCAxigtJFo5kZGDtf47Sm5BCQXraFhcMwB54wUN+puA44Oy4oAbHUoGTd5u26VVmSDS9vMcor4KumdvQdEoMvl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=uM9G/uYd; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 53D871C005D;
	Tue, 15 Oct 2024 16:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZyLQKcty+WcCnjeG26dr2iKG0fEkxLj2AMWczzJUJVpoNGDuOYWymEeC3c18rAFxiGc5xmeSIiILHkAXnKsMoql2sYdAyD3G4c9HM6bkAYkQFEG1BnwIxwNq8tqGPYnyH394Ri7v6k2tAjkI+PhQwxm+t5/bA8GiQ0vcZUMqzd7iYYQ1Qr066teSs3FZWUINoZZl8z/46etOA+KdPYk58m5ZBx09dXcqieAwOY5p2hGYVsDKbPc+bbfwzw8aIYheJ4ZuD/dbXyh7mJLNeIrZX8st+lJSGWCcyIVK98CyWC+0otX0taNNXc9CmsBd9V+kIu/nOFTJt/WjK++4L+eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cit6wYPWqdZ7rb+F113xSvp5dE6ZM2BgKhLOdYZlGQ=;
 b=BhpGZLoL/9dLHnPI3yPaZNjnAfBYE1uKoIPPmHr9wpAIbrsvTTJy3l8TSFFDIzdKTAMe/+JiK/5hgiiuie2qVz5qYET2oTBCDzTOSLsa4Wpd8WPqI1UUh3uyYmyN8rDDcvTUi6/BXNWVbOzXqelFqe2wFaAPhCaLVb4J8KDeoUUe8EPBpjthWJUT9WzgG3nQdOT/dFtju3BljBr+d+i7G31aYKzX/qMTYX7Zs5FT5R1+IPRlOsnJ2mRreIx99gl2zn85RpwviYTncNSbKQFfyzMmXfShpsqWx9NmA9Tz5UQccdoSfuHreG38ob16hFYhM98uzvZ2vuODHloWwjw3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cit6wYPWqdZ7rb+F113xSvp5dE6ZM2BgKhLOdYZlGQ=;
 b=uM9G/uYdN85PhPGfqVX2Bx9A0+oeRz0u0kq2dgJkHjnWdNU7Ntyu3SL3YQuInMkVj9bHO579cVi3krc4eFra6hSW4sli1puq4XOAJY4UCOoYHqsBW9JeX6FU4bZ7QW9JhMJZUAj7/6UNMnQMyzBfTWikkQ1XuZ7BQR5GHpFsbXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:59:41 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:59:41 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v4 0/6] Improve neigh_flush_dev performance
Date: Tue, 15 Oct 2024 16:59:20 +0000
Message-ID: <20241015165929.3203216-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7a5908-960f-4afb-e3b2-08dced3ac283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9M6j67Yqm7T+Y9WlBq4ziuqHVhC0y0Xj3ZbCWW8ONixZ1jGLgHnqNwscIuPm?=
 =?us-ascii?Q?GhRkk2I/UsHHOcLpEJ039gYwq+ZW0dMNLnxUwxjIkhdG/hOYAc81weFLtgQl?=
 =?us-ascii?Q?CBfTFezvKDrjE43zqPzhyiiBoouSU+W11jVfQ+caj35e0VdeDGrdqxR+L/AP?=
 =?us-ascii?Q?bucfg1dZL0u9rDIhSREByrcRllHjNzcKz9PBYEFP3e2ZXZQ4WeHU6hAjd2JB?=
 =?us-ascii?Q?/jKQQywz8jeDkyzk/477Mkb9TgrM6+Ci6Of20kksI862mtW1b9HCApzWWmnU?=
 =?us-ascii?Q?Ho7naXr/WdMeLgcfMrPmE5768y6X9PZUvduyVPqRxj0YW6nqEsLV/+dOPnrY?=
 =?us-ascii?Q?/xaYCKim5T14XD3E0uE1efavvFhi9Onv2FnzHuGSSi0eu+z7jpUe4IWOVikW?=
 =?us-ascii?Q?AjzrdZjJBZiFzblEk+VNgFGHFJEMZjn/unOCMb2wECSWMjXxmNo2PmzJqRlA?=
 =?us-ascii?Q?ykPw7YBcc2LZBSckAlEWkDnbl2uRk+Rnlq2y2gy3eQX4QQ9EVCdHvS+/ArbG?=
 =?us-ascii?Q?DqnilQZuCkJwzQagY4NL5cY+TeihGMI18e0Q4KM9FMibflw1z6mrAkXOBiRm?=
 =?us-ascii?Q?OR5drghKpjpGypCWY3xZ1OvRrHGl3aytAy0uyJAqaAMk+cToxKZv2cS/OH2x?=
 =?us-ascii?Q?CXg9CH3bgy6uppPaGiqSb6P/jjv3bTRv14FwtC5ad1NbuoonCaq2oN5pJ/m9?=
 =?us-ascii?Q?sJ0TWZO7FZS39urxmr2vRbbaiaGauZi7UFdEdmHGKvE1Jo25AyxY7/GThfD0?=
 =?us-ascii?Q?KcmmBJYBLMlG2GXBa1NHyfWkACJcQVE3oe922sCcZZGAvc8501o7iZP8ng/T?=
 =?us-ascii?Q?SyRtHqDk+KuiNgN90uNjPteOQxcn+HMwMvgZ/iDOCPlwumEjH0WyawKiHT1a?=
 =?us-ascii?Q?hAsLHyu4n/3lrFKBIc/26QGCPmuNbhnD/BIwG/ikCj30UqLP5yO/xnmOqPzl?=
 =?us-ascii?Q?q30QdNSdPmRpd4L/y6QXgq0UgCkbDgtfjHxcg7SHrT/pB7GMjoz3X2Hes5ss?=
 =?us-ascii?Q?PAXhLVcsFLSoB63EtZhJNO+cZKcv3dyCd7g4b0unZs/3qRBED4PguqgcACqb?=
 =?us-ascii?Q?WQEK30dHRzyehdTfIERaoJO4noh7h85qHp/3lua3fZSNrhoM0WAngs4zhmzg?=
 =?us-ascii?Q?TTDlk7EGWy75BoVs0eNxLkozci7c2T3wwR3AhnIvBNce8kUt4ewuRylxrNH7?=
 =?us-ascii?Q?k3nCBcQLiMdhJlavs+HKqDWYglWVkMLkcYR3ELIy9gdbawr78Ezb30OPjdRE?=
 =?us-ascii?Q?B7CsKbHCP9STniy36DlaL4/Y7yr34XEaBFTrc+XM57srxM0EGShI+ESuLKX3?=
 =?us-ascii?Q?xKAmhuzstmmHsS4rNiZA/dYaMq0Lx73Akk/WbLOF+3yORw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bSOjhujyUErBJEbrxSNoTL0bnId5nfb/ioSgeg1ej8NAaseBfJ8NMOBSRiU+?=
 =?us-ascii?Q?37EQt/942oITJDFiaWycSSr/QuKEASfZ0WTQ/6+2w5esdgyc9JSB3t/TcBoH?=
 =?us-ascii?Q?o+WuW2Za5ghEx0Nt7tXYhOEAGwWddOqBtPhRu+GXYKEFNhK1vZ/RRkurcApY?=
 =?us-ascii?Q?1+Ys6CODHCAqBCq9ykD6qSs9H2OrpLx4ZVELAqWA6ynPQ1qzTVl6QLG17eML?=
 =?us-ascii?Q?eHJbTv4OA7SbNVZY+CGUkKgbzeVaXySZccNyhlsJgNtZESBhOeLb4jDogGs8?=
 =?us-ascii?Q?Ym+58sDh091ek6JbLa1mO0uPFeTrkW+s/iNdI97PL/rh0ynjlOtBhyKWbXsg?=
 =?us-ascii?Q?wuzgHVx3f5ElSml2089C+KPSeo4x92FqvnZEs4FFheAHWs3vqQRYzewzQUwu?=
 =?us-ascii?Q?3/+haxbmHJ7b4WUfpoGW7Aom5AGFoE8rhAnr+T0lp5sktH94+aAGuepyFQGm?=
 =?us-ascii?Q?9n9MF11nzYU7GacvEJ9653NIPjrFD2DwyQO/jIOBrUHBG4Ai8YtlsENLUlPr?=
 =?us-ascii?Q?UBg84Qc3N8+fHbnni9s76rNvkEQhsJxvz6bORkPxERn8za+h7353Dp4uhp6N?=
 =?us-ascii?Q?5flssGsM05fbuko1SWaWyvxMqU26m4S4kt09/k5xNwzg/8emzGWx0YVlai9J?=
 =?us-ascii?Q?L/Qon/r2nne/3zqOrsz1bIjFpl+zR0F/DT3mbCnYoGRr0jRGofmZ6vo8mpoB?=
 =?us-ascii?Q?lNx4V2NqujhvfRpU/dBl2a4M0EKYsXDr/Mq/7xIb7dZX226PSB9J9cDo0tmG?=
 =?us-ascii?Q?HkvncdLD5Ywjyzd1hDbDAZPLgM0Mai+UNK6wYxUrU50boe9EzB16Gb3dVAs3?=
 =?us-ascii?Q?5wuUtwOvelvtAZizSeNChHSOrfOWJun5IXLqpVbeuJTnBak0M/dmYkZlezwY?=
 =?us-ascii?Q?8J3D6YV+eQivlCn6OQy1mjxSDwFQ0y5PcqpPGfCeKhvwn07B8b7vo3dy1F5O?=
 =?us-ascii?Q?LjbJMkF0k8atsJc6/ZQ60A1oLntaaKWc872rQPxYRWX6aN4YfgRmv9yBN0EN?=
 =?us-ascii?Q?EWdrOZJGKH2hTR9IPda7jeUOCxIvU0HDENHv0nB0noMH7QN3o3RmnJAPGBCl?=
 =?us-ascii?Q?NItNZ3Dc7IRIKdTFStpTvbqpVRL9n5hb37Z2XECxyZoXdJmZYJ/DMfVQoAzg?=
 =?us-ascii?Q?78K1k3gai+S0TKUADRAg11rmc4IelfO3mOHAXDYhlX5aPRCeM4VvkeuxVh1S?=
 =?us-ascii?Q?df4yxAZjYaD6pyXMUZyIe+7niO62hJerdLEO2C3HK3CVPqBUeZgrnQt33sqA?=
 =?us-ascii?Q?6yhT10HkYnEjcvvnxddnMiLRkJHPcKV7GzEVRQ8NiQV8AvJqPf8JU65KNyCR?=
 =?us-ascii?Q?M8oRVGua5dQPtJKJ0vCJxQR2xVwG9LWnq5D84J8Mnrpw1X4k3l1DTdxrT13O?=
 =?us-ascii?Q?hhArKQu8m/Hr4BSkw2nbb+rNm2RFDLT77WpLb50Ri7aGag+arHWTeOOdsD4M?=
 =?us-ascii?Q?r+Pa++68YGaxdU4Ctt+O38yBJ1OknrJl+4i4OpnPOhcLCENKbejYJAwrrRRA?=
 =?us-ascii?Q?JKwsA7Hby90PCA/L8Vb2eWcOG/la3AeZSfWjsKrfjDH//s//qHcjhqX7pXMC?=
 =?us-ascii?Q?M3VQOTMw4xdPVWMvp1pbhbcI1iQboZ9+e13XmN6qr8TDa15WydcZ3Vj67hFf?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4zBCOBEGId1G0MSeAu8lX82a3VTi/JN7xZp8cTrqADdnK7f4ey5WFsU2E3idQJvp2Qk1kMcxYuMt+KqiIU0CocYJPixXnR27f2/OAMnw7+jxjk8OKXVvIz02eTHFSv4EQJn6KVUmyqlVrZVQJUgk5f60prt/1WareYQIWYTQlHNO6osvSQZKpht7VpDZ8ATGfw3VB8HJ2jjXnE4FUBzcSyNlrOIyNn03tFLTT4VmMpX2JffadEL3oemC9cxHzh8IS1qc/czRrveubPs9TxTPFhRrMe/dvGNm12FJvygpqg5fD7THIn3iMO4ZsKVGCv/izvzVJNtIsAixFh+9xve00fWob+iCAPWvwgoNYFJz1eVc8yHBI3b2uXRrnQ1M/ZTbszR3CeQgQzBqvtdMPASvpZu4DWcngQmnjaNPPuTMsWcWzNzSd7co1O4lThVXRS/usHDVFAT490o/ugaOSpxeEK0oEfpGtbVcmXbOq0z9fqBCwbLBtBA6flve0abodJWRYBnsyV+qtsVBmUsRRSXBNi8mxVVhI0ikjJ0kskC8SdSN3WgvndJwZWycd0qkWAsQy4DATU48I2u0b7BDQ0KnFDtEqBc4fOjW9H5NJD/17jXy57oW8j5hWejzduO8nWN0
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7a5908-960f-4afb-e3b2-08dced3ac283
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:59:41.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /43XCnfY8/T0PxFUQiuf89Bq+5d/JisXEBW+s472B/eE1RJ4sroitn9tNS4MX+ufXxxk2bbLD2WEHRdn60ctBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
X-MDID: 1729011584-qF69NLjOPRrC
X-MDID-O:
 eu1;ams;1729011584;qF69NLjOPRrC;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;


This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neighbour-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.

Changes in v4:

 - Remove usage of rcu_protected when under lock
 - Rename `list` to a more proper `hash`
 - Divide the patchset into bite-sized commits
 - Remove references to DECnet

Gilad Naaman (6):
  Add hlist_node to struct neighbour
  Define neigh_for_each
  Convert neigh_* seq_file functions to use hlist
  Convert neighbour iteration to use hlist+macro
  Remove bare neighbour::next pointer
  Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  25 +-
 include/linux/netdevice.h                     |   7 +
 include/net/neighbour.h                       |  29 +-
 include/net/neighbour_tables.h                |  12 +
 net/core/neighbour.c                          | 271 +++++++-----------
 net/mpls/af_mpls.c                            |   2 +-
 7 files changed, 159 insertions(+), 188 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.46.0


