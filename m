Return-Path: <netdev+bounces-212346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12705B1F8D2
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 09:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A147F3BD40D
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308C23BCE3;
	Sun, 10 Aug 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IzWGQ5jX"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013051.outbound.protection.outlook.com [40.107.44.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AC22F757;
	Sun, 10 Aug 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811004; cv=fail; b=DqhqggL183aDlOBWGCmSJ1jf9HXdw8LoMpdIxEpziQEzQ35qtCIEMkwwshjguD9FJ/VFTk7dAvTAxCniPTVcgm0IGo+TpdUfvVJvKS9JERPYyU6IgSDdvmJpfZr8yETSX6w1LwGsUozlz+tp5j4wsXW31SpBBZfHKezG0KHNr+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811004; c=relaxed/simple;
	bh=gMzdRNwoBXl9OnH6yUP8hOr1pzrRFRIwLa0QwOQTxY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pc6VQbMo+/DPecRkCM808F/MbCBe6SATTJJtTED6BEKUpKggoz/CBBBOxDClxwlbT13WsJ56JQHL1c4/Hiweo7wNqdgG8ugKJFSGmRnFEjJVifHQYCdIBoXtkCflVWJt1sGLwt1ClZiXGF1TTVPvHBbh8c/gp1RSoYYpnsnZOaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IzWGQ5jX; arc=fail smtp.client-ip=40.107.44.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n52TXsSpYM5HsddWLF+15vPwuidz2mqDV2esqL9JkiQLHziNRUGywokNiyFf/71cAM2k+p2hz4R0DdLGHgqCmBM4J3LZyCodPvpLhpj+rczWOAB2EWqMapVNwoxkcIwCDPiyN2v3ts/LbafpX4XK9NcESSU8l5T8+ISb8/3nq8adlpuqhqfb435e4zKjmgPy5IIllPKcpux1uNxf7fsrDo0LC1fQnLObkDuK6LsDeXhtKJ8tS9vJr7OuHhSb3bElZ0BqrKxifIcxCyzDZ27ZDgO7uNh2hF2Cdhr411c5Pc/bvHkvCbP5DBbXN9Jsw/rmCRfqmuDV6PtNvaGnoo09XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnqxgHvD+2zw4N4X7TAUSXvUsw+azZANvtp2MJvOdag=;
 b=ipLoOwGU5+77kXJ3mRczmI/4eW20o07/u6cVCkJsWqDe5ziwn24WrmAMjirAFC/ISajfDJeYq9CzN7s0Qe77UlmToJEH+rKwkdU4jQRUr40ZE+GMVjbBWapUWGJopBxi1EF081fj+RMhd1V+VYguxB4TKjix1eRSUyyJc48b+Pl6u1cn/gLD6mJSLEeBDD526TLFs5cbuS3S3lxufVybMnlnUNhcOw/uYtZWjBiOyazvG+NjMeTdTl9hmRw/xI4eEfymfpgTMZex4j4XQDH3YjH4QJP6AxC0ANKqxz6HyQFr7qrAazkz323P/eVll6+l8Ckp2Cw7z9eIoBNRPS3hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnqxgHvD+2zw4N4X7TAUSXvUsw+azZANvtp2MJvOdag=;
 b=IzWGQ5jXRwynU91QVj3PqSt350oAM35kHWFyDxrTp4q/ehrfUKfWBqHtzAy6eWpJoIAQuMCJnTsFAqcgp6hwZauxhZTWy7NjMljEqwROaCma0sTfeASUpWA9JGq49i6G6J5aajL2Fd94ARZUX3Owy0yfjV1bwiEINIWm1K9nKaFm8OLj0p4qouqxYzRY8hFqIUtMn+dZkqGpLNnYeIUUyRxCNbI0wU1Oj1GvDge6K9Mbi9SEPr5JSvQ2FXS/CkARFQV6tFZTRYkzCUEX5/E/sHuP2HXwimCsxcCyjsRETX+TP5nvrvLUEd+C/YxBVrRsAAe8XLu7SPsKyy6JvAyT+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6576.apcprd06.prod.outlook.com (2603:1096:400:47b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 07:30:00 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 07:30:00 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [TCP]),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 1/3] tcp: cdg: remove redundant __GFP_NOWARN
Date: Sun, 10 Aug 2025 15:29:40 +0800
Message-Id: <20250810072944.438574-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810072944.438574-1-rongqianfeng@vivo.com>
References: <20250810072944.438574-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: d47a9ef9-2bc8-4054-934a-08ddd7dfb691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YDFUq+65lbhd87xmj0VbJqIt5nynI2J/UsAJCG3WrPPc/rD0VfL5nrJ7ATao?=
 =?us-ascii?Q?9Bj3OC5t2+9YCbEVZrrviBfLC3Un81Cn8NAS6Smft6G9CBzwQf0o2rKsVzWJ?=
 =?us-ascii?Q?nnrgVN0iXnDfqea8/1a7ldZScJ5dKcAs0v63DOoUIEXaslxR+9CEkxp7OWHt?=
 =?us-ascii?Q?gsxpuI0Rng41XJo3B7rB3UVMYoH8suK6w92IrGHGwqnrNMtgA41JLefcr18B?=
 =?us-ascii?Q?h8ErOrgvbL/4H4M0ej2MvteXZPxMhh7K2omaT/1/J7NHqM5J3RX09S4E2Ajy?=
 =?us-ascii?Q?T26kxaoKNQf7pHx6dYUywBakP7Ea0iFEz3sORAAsm8ptVzHdqh9onf+75Q/w?=
 =?us-ascii?Q?235w2Lxh208wTGHHF4NNX4OGTOGXJN3kQBn1idKmCdiURh/4tVxN+84X/QZW?=
 =?us-ascii?Q?+E/GzP/OSZ1QeH4ZLz2IHgyDgtYI+8H+wDypZR/l9tjU/lXzshv82Nvhowxg?=
 =?us-ascii?Q?1epWmm4/MLCiUD0h0Pd/zw8i8L0XT+254plCAANMYcMncJiEUlpkXNlykpt0?=
 =?us-ascii?Q?JMNvuDV7x6IGAT/wTZmcrDpR0sCy82krQWBDGH2x41Yz3sjNiPbSaKrHNU8T?=
 =?us-ascii?Q?8YrBjN2CDjwUX0t5RQUSnNKMzIpWeicgV+PEvl8epejIwZO1Iyw1owBJLycT?=
 =?us-ascii?Q?vCS2bxsmPejmjb8PTKz2Rmilj4FU0U7L34+88hyrBQOQ8NB+4AlTP5Ht/Wls?=
 =?us-ascii?Q?E0g+rUKgPGmDclyQlYWSUT+/hAUXFPAn1wCDFdnkMEd/SwzzjhhCCOx49xNk?=
 =?us-ascii?Q?wO7MDZI9/CAuNc9orTnMtnILSiP7qrg4xVLKiRQZayx5P9L85KCfuWnct6I+?=
 =?us-ascii?Q?YNS90+NbEKpMC7sa2yYT7JaGyVmxXvbB9JugggDNSMEbRanbN6VwnOL5Y69K?=
 =?us-ascii?Q?io1nEgbseARZXSpOffGVoPBwE9N2scyJJlX++S02xjJME1dQ9i9GiBQJp6XM?=
 =?us-ascii?Q?/oOfPUaCDj9vl+a8i7H+2YZF2jzkk9lbyNPyH/yucyMCj82cOIzUgVLCR4UU?=
 =?us-ascii?Q?mWrFQZrsWBKSUpIqMvngBfK/lEE4GV2KWYV191IobAOTGgrJjOtqRO8wCaAR?=
 =?us-ascii?Q?NW/Voe5NTRWzFlkG0O1bQIFXN+5XFl0VIYYPmtI5E9hkgMTY3FE3VnBgYWLr?=
 =?us-ascii?Q?9a6cqo+p10B9wPh7XqbT7uJv7F8eSNDZus1RpcGAKtkHNNLN15DOiQPW68PX?=
 =?us-ascii?Q?imAxfA5yHHi8ArVQAOnTK3f/oy7zxYrMr0LiCkZDy1Yu4/5UGWgZTAZV+Pvh?=
 =?us-ascii?Q?r54fj0YQ6GcZLbaeNUA985W7SF+gqzqgGmUIWnDqP6YbT4Bh15vFpod4lrC7?=
 =?us-ascii?Q?igCj818TtDv3YofaFxEQCvmqfsGSRvilCY9OUyyvpJR8ZH92usbNbcbw8ARS?=
 =?us-ascii?Q?wvwaNu58D3Y1dvFY5RgMYY4YS+dGojVJb2jAu5Obf5t5YoXMmKkcdcZkMQfA?=
 =?us-ascii?Q?37I4jCfAsCGgry+cJqupy6fetscqIKWOrVQw7bfnLYQL7iY47qKv2JMAzf3o?=
 =?us-ascii?Q?fpLvBxVWvAcmI2I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L0StTQB2RLsliUV0dRTdCmKOlYnl9DvZbckkJNbFvQh/P7S1sox1bGaScVhJ?=
 =?us-ascii?Q?xxB+W3LBe9m5JBj4DpVqgtsE5bhwSPiRFIniJ8DnEdo0g6LYKKSFKQ7m30yv?=
 =?us-ascii?Q?cmELXuuym3Pxtn0AudP5o9Yklco6zq9L0YNG8Y4xBs5PrCRuXl9KFJ5IOxB5?=
 =?us-ascii?Q?DHWKrvZHX2krvnFiHFVlbqRAkYkj+Odiu+eNd9VfMPUm+prVTNAqgViD1/Ac?=
 =?us-ascii?Q?ucLQ4A8vdr5+8iV0WvoHjw1ldTRGTqnSaotKWNQTQxOw92Ug7bu6LOR8YCMI?=
 =?us-ascii?Q?nlkaCwVSmBtBOIhcfeUrcMI74Q5Rctm9kKxQg8Oa+bzQuxWzROH++0vV+c60?=
 =?us-ascii?Q?3R7QqvAQmP5sybSf4t4ilQOn27dsRdWGwYeijo3apbLeKS2INUFrPfl4T+gR?=
 =?us-ascii?Q?e7L5J2I+kcPy1fGQ5lD+VOu2dMl3KKoVBSpj54eRMymr1R9RgNC76MMkhvV5?=
 =?us-ascii?Q?89UwkZMx8fKjncqtP8TS7VKWlpwyCHOe1kQya00R+JH4z90MkJvMK87YZPE5?=
 =?us-ascii?Q?F4VBWjFNOm7e+BDdrKpWF691MvoC7NZEYLmsG+/siyQGFYvcdRR+eJby5LP2?=
 =?us-ascii?Q?uOk5B9CIMeyjrP5rA3UrOFFf/o7XYgmWwqo1+E02M+ZxVFJEmqkIPbat2R9K?=
 =?us-ascii?Q?aB66yIsysM+KFZ9JqBeH+f2+2QjQnEw1oFQz9unMRnw+iOVTf3Q+cIkP3b3j?=
 =?us-ascii?Q?9aLAkqQoo/kSZcFy9yhNgkJAKXT9nA0hC+xr2S4QzwN9ZAQoFnDekRcMdbd2?=
 =?us-ascii?Q?wzQGHnU3wVJ0c93yJ/EKpSJUVWqafQPca1CoaNG6A6zk3BtRu6CDQgVEEjOB?=
 =?us-ascii?Q?6p0vx/PYk7EsEcpthHYbVqhGFy04Wr44cuwqhuwhm98OK6Xx3vx+DFaRHAW6?=
 =?us-ascii?Q?4OmiDg2UrZuLDmOmHjZc1sz89V+ccbQjeNciFlDwdF3sJTcZ3rJ2o4mNQr6u?=
 =?us-ascii?Q?DVXfEVp39N5oZWDVluP0vr6k4EkbR84UfTt/YLOQrYcGxu54iHqGUG/ZKnXv?=
 =?us-ascii?Q?jlt2qT2bkoTSu4v73K4if4d7DuxEbawqpLfh7OwT58l9FSHClEyiYO7+Hvg+?=
 =?us-ascii?Q?l4lHFlzm2o9W82TwPLARuOlYHvq0qHUkSQ9b+aqTikxTwDrpqicTiG3Uf8Gh?=
 =?us-ascii?Q?5JqI9IbwpCwQ6U1VOkXhTLefR0W7v6FULBNRnZFNLqxRnSiAgNzexSY3049U?=
 =?us-ascii?Q?J3H/mHQ1lhufpIOJaI3AQddGcPy6faqS70sRZAz65+391NmM9CFHvlH8JrNc?=
 =?us-ascii?Q?k2AMf180XWuyx7OLwsxaAZ5nBu2TXIRUhcWLrYaFcG0M27vZ0QR6iFAl3aS9?=
 =?us-ascii?Q?UaAjyFwIsWbvr2aegPa4mebcxLBPIN1wVEdvH2D13/9mOe2bcN7nHZWOT8VU?=
 =?us-ascii?Q?0DSKR5sL+DtSmr5rlMygzcFsSF5/ArgF6DKk7gqZVpHLezi9Vr2N5fWaptfP?=
 =?us-ascii?Q?2OaJpMLfwpZqt6YuNiveG1sDmhHfhKzO/+wYkz6zQgZWqKrUeRMPhkSyvArX?=
 =?us-ascii?Q?E7M7TKEwLRcdpkdUmLe3lSzmifG4X2IaaiNdKkq6KDvb1sxRsMyrDA8Mi2vF?=
 =?us-ascii?Q?5Qrvk3vUToqw+9aEzXpAJt8pQMMwrbZIUxVxALNJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47a9ef9-2bc8-4054-934a-08ddd7dfb691
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 07:29:59.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S6XQdVx31+9inwT2mKJJPRt6k1WtEeeq2LdOlU6gPA7n1F4ZNa5EQ621tV6marg1whGsyZ2UZD5Bn3zE2nO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6576

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
__GFP_NOWARN.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 net/ipv4/tcp_cdg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cdg.c b/net/ipv4/tcp_cdg.c
index ba4d98e510e0..fbad6c35dee9 100644
--- a/net/ipv4/tcp_cdg.c
+++ b/net/ipv4/tcp_cdg.c
@@ -379,7 +379,7 @@ static void tcp_cdg_init(struct sock *sk)
 	/* We silently fall back to window = 1 if allocation fails. */
 	if (window > 1)
 		ca->gradients = kcalloc(window, sizeof(ca->gradients[0]),
-					GFP_NOWAIT | __GFP_NOWARN);
+					GFP_NOWAIT);
 	ca->rtt_seq = tp->snd_nxt;
 	ca->shadow_wnd = tcp_snd_cwnd(tp);
 }
-- 
2.34.1


