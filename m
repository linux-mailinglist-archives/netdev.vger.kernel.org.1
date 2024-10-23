Return-Path: <netdev+bounces-138265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74A19ACBAD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36AB1C22540
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F031BBBDD;
	Wed, 23 Oct 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c9IC2O16"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14B1B4F15;
	Wed, 23 Oct 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691590; cv=fail; b=iw1jcGh8QCerXMe15bhfpdvbtJV80dmvIxZE7jjngydB1tvP09PhvBbZz3AI37FnVD4ZkeduEVLyz9aZHFIU3LpxjvrhMie48dB7BYuGklU1jt0yVvbeu0kzWw5LE5iPUbxtLJ108NF/rST+2iIT6BIPjs1fxd8vNo/z8QQhuHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691590; c=relaxed/simple;
	bh=dZfy9t2RV+K/4GztmEvHNkLAvswoQDvmyKRokEz4Apw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VjUoLuWW3wPS6XGiARwPBsDpsk9uzqKNonsALjWxSKgt0gdFIBxA47p0c8o9AjONUedOyyKgijYb58cK+BsOFZ1SxcFIr59z9gTAI8i8z0ZziNzYwyNKZcYjZzO32J9Wc2P8B0sMO2MogiBEfuTC3FycSdpiD7xR1AXim69Onjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c9IC2O16; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=em6JSvDrDVcpoET3gvzrIzccQjnaBLMFE9h+HYU7svRmPgFhbv4/IIhZhNg30HbHzm8uIZNW1zh+yIN3mFgjsWbltzZh1SAqNlwkrEDmeTUchNkoKAlFskjrbXGwEXIll5LDWYCeZTkGsx5SJ1ccmBAmi6M1UcjRQ3/vYD0zK/MHz0yN53igKlOjspZZ83HivqSFjN9Ay31XRePArzKDp7wnBqEe+XK/33f0dp9K4XInPrkXVMevWMDuQmPml3Z9vjrxoj2btMX2xw/J9CckxN6m8OFVC9Us+UUncBEjZOob6al1NwxwJZhZRYrarE9HP9/oAjgdjT7hH6/tcYebOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO/gNL7mcxOGWPQb2ExICHs7JMw60lCeiJczgEiVCaM=;
 b=WBIwsxupn7Uwb6wjIPPgsUScONcgOy3APs7a4KMNJJ/UcAQLhm2m9yFsEAHd8QahqyDtD7YjFTOyxK6AVK3YB1n/N8wXoWrVVr1fibGORXrQj32DBfVLREP1sTXduhY0THyTwNZ/91lsQi0STAVo/oOUlueSV18IjOpLskXdXHASJCtDjQfPbCGZgMDjTdaQmVJ8fMKNoZZwZ7xx8fUncn6n+g40KTBhkIgB3JpKgPXbxG4vClPtpsdDvX0mpAUMbQ3vhNjmlUD5jxOlsZYsMAx0Y/8oKDqY0hmFQO3m/6suuRHrGbTDL5kpcnC6o+scLG2vx2/q6LNq+yvJ01iqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO/gNL7mcxOGWPQb2ExICHs7JMw60lCeiJczgEiVCaM=;
 b=c9IC2O167mWbTNjKfseQeXWTQukCWl7b7K2iHO3f/1x5okE5q/OHw51Go9tjQBgxCvt0KQFDaCXW3QIB/y+4y6APSJINUuts+l5SJfg5dWBF7UoAhOBRehWsAgf/tfCD645uUbyKFIJd0Js1LwUmntdhDCiR0lsPzSCx83KlITP3BXIlU7aZndSECAbGipEy640SIuCSxp5c/iGwiqfaX2UUvSCRpsdQccYA34dWtQTGRlmzzhyz0qpKXVrFBIznZ1fc2bfGIPaCJaBUelbJe9wWCvTLVxp78I8lMCsLVuMmCSSIcVH8r+mTwxgn6WQ/exzZToduuPTvXNGEaCkStQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:53:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:53:03 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 1/6] net: sched: propagate "skip_sw" flag to struct flow_cls_common_offload
Date: Wed, 23 Oct 2024 16:52:46 +0300
Message-ID: <20241023135251.1752488-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: ac452d96-4c79-43b4-eba6-08dcf36a036f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EArAz6N4H3pzMfm6Wv/Ly5tST4l7hfS31p0b5xs8Cshx4NFn2yBaFomlinVr?=
 =?us-ascii?Q?ZtjvX9I7NyU/Hl0kGNkHXxDUTLUyAiwMpTi7V6xBYJFuc5BV/O9QuTrqdipg?=
 =?us-ascii?Q?viNMnBlz1PNt9wFV9X7+Ifxtvypb+rClF7+6JhSw2IfRiriYs1jyRWYxJmbM?=
 =?us-ascii?Q?4JCfYC/w+Q7+rHQbVfFyWU8MmMKJcEe9hMTKYBn6ditAXku+DVlgALb8+MWv?=
 =?us-ascii?Q?4ck5fxqLDKXt/f2z8C6ScVDND/6y+awFS2E9JVDE9lIZFPpmk/Ev3sdcQ5Nz?=
 =?us-ascii?Q?jkhAhICyK5vEC4Ata+uQHBIHGJ+Qn0jkuZkGc1kgduWX1A6uKp3ameaIRPNc?=
 =?us-ascii?Q?FDf+uYTKLbuU5QrTrqSgewckw5GjoOQghOkWCxNgmvRL1RSD4aLxWxzt13VN?=
 =?us-ascii?Q?1GL2fxQv/k+JLmzCWV30pCisgvdcN2qzESJ5Eth2gXwCO0ohPHgizKsm4m6U?=
 =?us-ascii?Q?o8YLzu0/FpWHm4vQ6TdrQcTb2bvaH44zaS35jqKCpbzeXCMUBxoN+6S8/dvZ?=
 =?us-ascii?Q?qTcRH/FLLgq886sIFlpuSXN7zGhTi2WYCDq0SJSz5WxkQQ998EvI8Vga8rd6?=
 =?us-ascii?Q?sv1nhflKUNtDby/7cwk4KWLS5y5GH2eItvQC6GULUe9gb8ivsEW43PrHU7vV?=
 =?us-ascii?Q?ao4zipiSK58UQoptQUon7k43RC35qPq3+6xM9G3+rpJPQZbMQu3AR3OpAC5e?=
 =?us-ascii?Q?o4HRSAc8gJDJl1c64zY+/2adyfHQBqPxxFaKZvCfVgn9UT0rA39zSSzoq1Hs?=
 =?us-ascii?Q?WKrf49w0Zd9Lle62G7og0XG0UjXLDXv2VP9cJj1BAss8BDB71uRKGh1kBvhU?=
 =?us-ascii?Q?FTrheEBZ2LLkx00gFqRdyvtxYpuLxd2+lE0knBRsSwKmBBBDi4X45Pz0jl+0?=
 =?us-ascii?Q?5K/2HYfKKHP2wz9IQqTd+7Zgcrig2oJnu2bGs9q8hFTwQRnn5gIRIJTURhFB?=
 =?us-ascii?Q?JufgdkmozbdrFqaTA2wvhaI5Lu5xwNLUOcvZA2gVFYSkTiXGOAUNxjt69QYd?=
 =?us-ascii?Q?SI0Cf2mWSXcBXz3nNIyYHbcFNxL2gck8WGhaPgOWEZQOTeKFig6TtSnJa2YZ?=
 =?us-ascii?Q?Fo8khTavt7zEX6Ptq+pzn3ERNu00K3oVbcgYdMVdYvWKRRJXXEB9jcsYpGJO?=
 =?us-ascii?Q?6bfqcYMebF5nV0fVKFQ3nbA568nwOSKTtbb7zXRsGSts7uYYxoVb/8IiECvf?=
 =?us-ascii?Q?x6STlwLqaxVh5YsZIj2D8snUk8C3tDGeEYPJZCd7juOm9jhonnivNLo+Ipkt?=
 =?us-ascii?Q?F2v/1DajJ9ixSldIGAEcvdM3M9AQ56Dzel1/xfVhnwUyqYuIe4EAu21pMnAE?=
 =?us-ascii?Q?QSWww0kXtwI/t/1/wXxTbUTp7fsLo+LPZLZ2vORfB0I0rJoZBoozdfmHpHrN?=
 =?us-ascii?Q?dVj3gySGX+mY0Cl3kgUPUVmpDtCD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?41GZ8bvQu+VAQD7FCBOFIKTsRShQ3TD/M4RUKUQqSLzcd0LBV6KWFIZepJtw?=
 =?us-ascii?Q?G1tHVq4GAA4F6D26Ims0/RzLoJ7thYsAroAMphtxPgw/7bMqWc1QN+i/025k?=
 =?us-ascii?Q?bCRX5fpAwETh+xJDbspDB+ErTpIFbdXJWO/wbiRTBfPoY1XfvEBgKUFjdbdm?=
 =?us-ascii?Q?ty3wRpFOr/cy5TO7RZAWyStSWy7cTj1Sw2q2CC+z0mklThMI1cWRLDyHLk9O?=
 =?us-ascii?Q?Lcf3U/SgK7w8yNH0DIp+L1PgszDtUJ4NPBjrCB26OGuj36vWHPQKMD73u+XQ?=
 =?us-ascii?Q?6cpmwCUU5NrrYuwuGvrFllI4wyVRfln31OWw3Qq3xqWSqpKaV1tRlZL2AiJg?=
 =?us-ascii?Q?PD0vq63CwMa9Zw2i/VcUu0XGsf3pZzcRBYHOsnHQMKxyZxPxTXcYfdkFewIH?=
 =?us-ascii?Q?TQatqBXLywU7Xb62BxEyeJ98ItVZ30PYF3shktX4miDdczYBJrD30nKz7SP8?=
 =?us-ascii?Q?uP9yjOQHDfUQsZdPpAgfCQA5HDHmKB4YpyNuTvbMkGsHhUEZ9UMoaJYscFfi?=
 =?us-ascii?Q?Xkn9eoXqaB3qTxrRzornCX20ZXlkdV+cH4suWserdyhdMBXDdMyelDGJteBR?=
 =?us-ascii?Q?P2KomMVpOqwzOnZ+xBH4eR9WM/3sF6cPvyhPYe42pWWxXHRkKY4Dg0e39ppL?=
 =?us-ascii?Q?7/22dIUnf73RA/0JPevVv/DG+Us0F/Wotbxne9ZgOk4f/jkoUVyzNf8JType?=
 =?us-ascii?Q?qycHd2MhZpJYJ3Vpd0bAuERCwYg+8wvjmA/SblCYxtog66bG7smDwogQKpZP?=
 =?us-ascii?Q?Xfms/NwzUrik27CNZD5GkmkzYomq0/AQ0d3jpW9OmjMPjZzYPdqLoyqsQ+H6?=
 =?us-ascii?Q?iUMOLKyYEd3THtIvC42r8rUaS4YXYSiEjAjx9AqIFHHyJd7/a6e7NR+RHZ6q?=
 =?us-ascii?Q?s7ih2Ul9o/tEAk8PmRkHzIXxSwUANDBJvaN5PMbMJC3vjt0petSGx/tVbiPt?=
 =?us-ascii?Q?H8C2llMVobVmPI8e2QiS4F7txiF87PU6XHCBy+ZRsfvY97i4l9+o0aZtB3My?=
 =?us-ascii?Q?c9cqXgsyuRFdwUJJodO7F0NWyvI4yFYzi0KP+3Ww4TJxjldry/bT8RQPdy5R?=
 =?us-ascii?Q?t69FgFg2VXAcn6wIuxxwDgEJMjNvG08ZOB0AiZzeccsiNPLJNq0sBCyy3b1X?=
 =?us-ascii?Q?BTXHx/EQEU4AFP7QldWlEBfVIYBgwVAifJEO0wlo6LuJuSHEKUN4zPF8T42z?=
 =?us-ascii?Q?7DBb+CK36o9D7MYpEq+Eq6+UNdnnysFu3GLY0yZ8DllMQZsqn55InPbTNQ6M?=
 =?us-ascii?Q?2yMar4PKMRpcwY3lPqFrcfJWYJMsqt+Z8wKTtj21r8cTU2sdMmQu+/Cnfg+Y?=
 =?us-ascii?Q?tp76H1wsgnWx8VE9uOrI+12FNVp+nk3mYeADfNU3zKCUZPd16ofHNUZHRfHa?=
 =?us-ascii?Q?OejPIkgmHuFSjp+sxx3zqlndTquSdzKcNUwSyiPMUdCynTbIC3pjIOQHeFPk?=
 =?us-ascii?Q?/PjvEDf3RlPFJzypVvPcZXs0HxL+8pZqcQWdncgUZ4uODRH9lYNOx9bQ2pyJ?=
 =?us-ascii?Q?EwRqN5fWT9/UXw6qx8gjx7MhTZwcIzORa3Lxz5KlEOxFAFCMWxX+tw2F9FdC?=
 =?us-ascii?Q?TUuxd9dkVmph21P7wVqR192g4HBH/ujpEyt16YTB49safAGXFOyoc9+qEpcE?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac452d96-4c79-43b4-eba6-08dcf36a036f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:03.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oxv0YpAXOxcq4TY1sJ1GZlxj5tyuLRcDwdl8V7ExDtBC9NpXp8qQ+j+AKkZQWjvrVh7eJkQSDFn4SFmOxWzJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

Background: switchdev ports offload the Linux bridge, and most of the
packets they handle will never see the CPU. The ports between which
there exists no hardware data path are considered 'foreign' to switchdev.
These can either be normal physical NICs without switchdev offload, or
incompatible switchdev ports, or virtual interfaces like veth/dummy/etc.

In some cases, an offloaded filter can only do half the work, and the
rest must be handled by software. Redirecting/mirroring from the ingress
of a switchdev port towards a foreign interface is one example of
combined hardware/software data path. The most that the switchdev port
can do is to extract the matching packets from its offloaded data path
and send them to the CPU. From there on, the software filter runs
(a second time, after the first run in hardware) on the packet and
performs the mirred action.

It makes sense for switchdev drivers which allow this kind of "half
offloading" to sense the "skip_sw" flag of the filter/action pair, and
deny attempts from the user to install a filter that does not run in
software, because that simply won't work.

In fact, a mirred action on a switchdev port towards a dummy interface
appears to be a valid way of (selectively) monitoring offloaded traffic
that flows through it. IFF_PROMISC was also discussed years ago, but
(despite initial disagreement) there seems to be consensus that this
flag should not affect the destination taken by packets, but merely
whether or not the NIC discards packets with unknown MAC DA for local
processing.

[1] https://lore.kernel.org/netdev/20190830092637.7f83d162@ceranb/
[2] https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/ZxUo0Dc0M5Y6l9qF@shredder.mtl.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: move skip_sw from struct flow_cls_offload and struct
        tc_cls_matchall_offload to struct flow_cls_common_offload.
v1->v2: rewrite commit message

 include/net/flow_offload.h | 1 +
 include/net/pkt_cls.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 292cd8f4b762..596ab9791e4d 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -685,6 +685,7 @@ struct flow_cls_common_offload {
 	u32 chain_index;
 	__be16 protocol;
 	u32 prio;
+	bool skip_sw;
 	struct netlink_ext_ack *extack;
 };
 
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 4880b3a7aced..cf199af85c52 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -755,6 +755,7 @@ tc_cls_common_offload_init(struct flow_cls_common_offload *cls_common,
 	cls_common->chain_index = tp->chain->index;
 	cls_common->protocol = tp->protocol;
 	cls_common->prio = tp->prio >> 16;
+	cls_common->skip_sw = tc_skip_sw(flags);
 	if (tc_skip_sw(flags) || flags & TCA_CLS_FLAGS_VERBOSE)
 		cls_common->extack = extack;
 }
-- 
2.43.0


