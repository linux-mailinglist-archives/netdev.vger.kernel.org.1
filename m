Return-Path: <netdev+bounces-182494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4BA88DCF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28978189958F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38292AF0A;
	Mon, 14 Apr 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cpJ3tHV0"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012053.outbound.protection.outlook.com [52.101.71.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AA15575C
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666187; cv=fail; b=PN4hGIirxm0jgxy7eYwIJeiWsFlsNP97EOmus4GEQH/VDEhJa7qEkckXpvrzhcAsfJIUtlmXRtr6UJbxNXVxRfEExFNMFTmlAVMmVBulTEzW3FGSJxpihqDBeKvF7yqh1DsEttlTo3M00o0WMmgAk921qwnOe7qPYicWFEcaNZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666187; c=relaxed/simple;
	bh=igqHUgrozZkZRV+excMhY9NQsYNgeme43+ShcgkfhvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tP0SBkElgOuWvPa4GrKjzCvZdb+S3zsMk/M9ZqlDktCH7NddPD6x9AHThzhmYz+vvUOiDd7ZDJYPUBkqJD3ABMz/CDs8goayahdc+zqpVnDlO8tEpnDXU1QAkBZNYoU6EykDtyTsVu8vlUuMD6jo1Pr55bjKFPTHr3b56lAvRe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cpJ3tHV0; arc=fail smtp.client-ip=52.101.71.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDbJB+Jl6e0l3x0IbEkSzh3PN2Dksxjrwr7S02hCj+4Vnd1ggTpc3oK3l5k08Bh5MkrABmBoK4mGLTqy7yUzmKP2ZHzzw0qgMOxm27wNWctMmKuKvzY5fsMB/Osdttp6rB4igs5hM+oQ10d5Sk1Tnr+fj2WNubNqCmQpY9i4CkYO2CdlrSBeoGYaeilfnl07HmOntX+27axdozHaFEqL9mTBwg9nL+tJX/L95sjGvqkX6ezAFW44r5TUsOfvy/gAnF8S/Jz4MO+bgqINFh90Z3KFzXQ/OBublRXXcV69PKWwxSdkSerWLBNrLJsK8L0Wa1z/rz5KZrNdHnqwCkVUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi+K8sJlktUeXkcftRXU5ABPacaDk68JQqyPmwyPzBo=;
 b=BjasqxEO8NkcYftrZFXUOh/LbfNU4ozo8kUibjsZeOncP9xQ/lW7eScFy8BWB2sHiPlpaqQCX7OblH2fxXPhmAErmx8udcIt0m+BCSNqL1NHpJuZPMhDjSQ6eD6GjyYmrwbcD0ShDyohyh1bDzNq4wR7XB3UpnKvwBu/kSGMJHEkqbrnx0glNbwwmWboHfy44m2GXOfWAYB5+mZJ3NWI6/vbK3upLxVnXgh/L0Ya+ysbDeDSfzvoZERn71ciH1+c+YhO1CynK62KF7+AOz+QjR+YUHr7Z8Q8NG+rpiQrgzt8QUnrrT6atze9qQUc+9rvDvCEAlN8FNlsUvaz+b0Dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi+K8sJlktUeXkcftRXU5ABPacaDk68JQqyPmwyPzBo=;
 b=cpJ3tHV013vmUOPtbpn2//tXhy2OgCr4SCKb7v3uzLZQi7oema8hjOwp8p+aT4jkEAgdgMNDnZIO0Ln/ow4FB7Z2A+h6H1UBXauf3tVTOLxwaoGsQeImRCQxzmyTaR+zNpJYy5+wDSQ1LAB3829e9vyILcocYj9WqSFmGyp5CFk5DeqodPMoN+z1hYj+k+EpeJHLB5rS8Gzkjbpm4cbgWRzc83cfMUqq09dqTVbR/4giyeB24JbQBuc9ngvWU69/svHJKrF26jlc1y4AfTVxsEJJhYnUgaqsOhWsrJsilAr3cBTOqBPE7vbRZqXOe9pLZV82vAbVkV+dgXKZ+uY6Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 21:29:41 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 21:29:41 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 3/5] net: dsa: clean up FDB, MDB, VLAN entries on unbind
Date: Tue, 15 Apr 2025 00:29:30 +0300
Message-ID: <20250414212930.2956310-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
References: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0100.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1c0fdf-6b59-49e0-759f-08dd7b9b7742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhcz0AGFWA96DWsFgOUz4xrbTuPzar/8F826oB+kpajrWYzEDQy+3APRVG+S?=
 =?us-ascii?Q?5D2At2u4jpqNJrsMFlozTYOPAzjlPQ0a8P/rT44bGFUUUW1e4w2mHVPvdYJa?=
 =?us-ascii?Q?4sycc4P/fr71SyaNEYA6gzfA9Avfhx95EqRB8ekyazYn4L637OuHmYmpjZIE?=
 =?us-ascii?Q?2t8bgRYTy4pXi4V1XsuzFf1sZNVCtaucQwFyGABx6WmXLh3cOwJjDiKJ74Hg?=
 =?us-ascii?Q?ZiooGllvVj45V250qicDo9G/xTFywbjCMe6PHWdYKB87XqWQu60i0AVMp001?=
 =?us-ascii?Q?fGkAs5M9+ZCNTC7iQwpC4VcOFyNpK4qDidKkWA6xMO8ixW24XPKkugTI4zHU?=
 =?us-ascii?Q?d5OpHgidEBAbOG/5H+5CB+Z3jbl8D6H9HPT7bwzo6LSAAgE5bkppRiY5/s6x?=
 =?us-ascii?Q?fjIhK7E+fUu33vwtItZ6Hoa9rYk2rlGEYaqoLwc+srAGnMgbqkMFNIQ2S9gp?=
 =?us-ascii?Q?DuM22LMnQ2SRMtnvuPumVlUB7YgCJcLJi5z3Dyaq5hNyElc1RcqE674thhOT?=
 =?us-ascii?Q?SUnBeJ4gBUsqxilCSHwaKQLJ4Trywo6ikkx60XdS4LcUCk++3QRvWQxwjx8U?=
 =?us-ascii?Q?1LEk2rEsLf7K5Yu8fUnoCOaGNTygGau+VAULXz8MrcGQMhwshO/HPSM+88dm?=
 =?us-ascii?Q?YZjVPUvDBD8dgcIMIenySUgtVpfHuvul5opja2ETB4RwmbfE+gQhijKpEOLm?=
 =?us-ascii?Q?IlKb1OslpGCAyyhdi5Zlo7Jx7CZ+nlXVY3GP1ZxJxdZHCMYOTwh7BHxgPjtw?=
 =?us-ascii?Q?7jgXWiYwGSSH3Bgo3ouuKdSzuqKHQ6qK0XYFoWrk0JxNXM1CsVPx6XpiY1Zb?=
 =?us-ascii?Q?SbywLLvWrPdt2i4fevU/bRzxNt1Dp/bLbOBK0QGR71PphhovIvzGEF5+4qF9?=
 =?us-ascii?Q?86RMTtraKGiax5ayR58Xea+KNpJVA0i/etQ/JwMrZLDaLNL0iPslgLsv50aU?=
 =?us-ascii?Q?7Ypqno7v5aHL0GBvYTb8VdBxUiLHmcu/8LPP2jKLlhJ53W1RS4nzrb2oscff?=
 =?us-ascii?Q?E59FpDuMca7yECkjrcNRtzR4G2IFpVLU9J7xahwnV/LU8VWgp7Ah2GlOsjEk?=
 =?us-ascii?Q?d4eNZsIMz3SD7Y4S7kIgvm/nubgYc0BjYvGXHnKwCjeMdukNZn7ml7ll6Mpc?=
 =?us-ascii?Q?0vAaO4DHNof5Gek6qXyqbiHOYifpnxxC+UV25B5FzBfEC9wyl0PDIaPO7G++?=
 =?us-ascii?Q?KL1dCZPaQdbUJxbwsswipKnCAjVDq4ZV8cEnHBy3UZIVJEtHHOYNe8+l0N1z?=
 =?us-ascii?Q?ndZyd9q/vjnEbO5JTM5ofyjgpUqK7GkSzLDaEuSamiXTv2iP3DNxz1u3DiwV?=
 =?us-ascii?Q?CMBfyzCAljQaPuB5l0MVYFdHxGVS60muRJpBE+aj6hLyh6dmNSOgzR5hRgOy?=
 =?us-ascii?Q?fhYaIpNaKnN1JIPr9jK7Kl5EuiaYFz/rg+J2WQ/+mFOYfpt3hxdn6obGfz6h?=
 =?us-ascii?Q?ytTX2Vzx1KiucBVMB4CTLrllFB/2bvS8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OmKH0NoUEjYinxq9gdc1z83k67pm2YPUd5l/XGCtYFt8XLRRlSM8ZtwR9Or9?=
 =?us-ascii?Q?c01a38WiLd7IvDaHWXue8z9J8is7gPb1hamjbNp3VczTG2xqCMupDUwMkq6p?=
 =?us-ascii?Q?79kQFLtygfXHXS/b7Ttx8C9xo2FC4pJ8YUVrDt5IlCJmb9+N4dm8sjeNWkm7?=
 =?us-ascii?Q?yMRQYtMoVL9InK9cOV4PXzubn2FfuINzISWxwamCo21EODCiPLfomSJMRy1K?=
 =?us-ascii?Q?u/oLuBiNQfq9QawVZQXfQxdppSxGanLXX5ybe/FfEWN9fqz7+XIXDrd67x4D?=
 =?us-ascii?Q?DRUJpfL2OUuEApDxbvyHKFtXij5lP6LpedawdbpVZNev7Z8eRzBvTCOTSfhN?=
 =?us-ascii?Q?2vt55j0SioxjTV7ZNhGByKnM9tQtshfOQA0GI8eTohb6kGOkmwB2fVX5/QAT?=
 =?us-ascii?Q?BuxXV5jrnAk5LG+AGBKwExYZuqkuyCh8XIUBxlEOXHxY5jIW+Km8zprWOtwx?=
 =?us-ascii?Q?2R++z82idFgLGiewjD6DJlvKofLSWEaF2ZBCVQ/5BCmt8qhYbHWrIc+ppkqr?=
 =?us-ascii?Q?NKX8kSpTMOuRHs8AXUbEm6vios4/wLgULjTjrVPDYzmNYbKJE5vrSr8ZxiWt?=
 =?us-ascii?Q?mRHykgqhwTSOA+TG5+hzIMYfiZmrIgdmgFxiUspKCOfX1VbjMZc4aa+HnuO4?=
 =?us-ascii?Q?piC4QI+2DqjMvkebDiO76B0rd6f9KmhlvL5gKcUsuYaKq6wJVTGOV3sp9EWv?=
 =?us-ascii?Q?8zUo2wf4GSxtlj4QP4h/MXbaGD//O0g2uHbbwbH+yK1pcPJQJp+lwmp91/oG?=
 =?us-ascii?Q?Hf+YNeqoC1PDhgNr9zRFrS8AopqXk+zPXKRKeXE1TCt+iq2MuRpv+zL+yBUo?=
 =?us-ascii?Q?ihCQXUBvG1NRmJpQvT9Nwj8mvFV2HYLTzYqkKO/A5sQDJ3UpRLTzoWtVaz1j?=
 =?us-ascii?Q?qKUARG1cIwleOzo/JHYZolobPJTgIiRwmcBUSoMKpQ0MyqG/sJwItTmpmI7s?=
 =?us-ascii?Q?e8XoIIk6CXiO29kUj+EVfpKF4Jh5p+en4g1aBWLMBsLJCjhj8BKJUfiVxoDh?=
 =?us-ascii?Q?8fQlAltKi/POdjRKpD7ws+1axwePjkpBPIPlkm9XLD0AG4mvd92lmrdwa5mb?=
 =?us-ascii?Q?RxCeaBxyHptpYnK4b7bEY/SpzmEl5iDHQtmjTdvl5FXMqlAL7LHpJkHzkKK5?=
 =?us-ascii?Q?u+3dbEtwp/GS+yXV1+9p5fIL/rlr3kNAFyVYoyxMIaWvTx/wmo9p+Wpjq5vH?=
 =?us-ascii?Q?N/d+ehYdKcBriT2R5lxrFMj/Jg7PQA7Q/MEUo0zQ2X2w3NlQe4InDKi07cXv?=
 =?us-ascii?Q?/++y5IYeX6p2UeKFOk59a3JJXrFd/VrW8wYN94hIY1cS5HGuYVsBzHrwsDVq?=
 =?us-ascii?Q?4wPQ8DGJD8zyOy/zyff/czivebgUd4haKakj/YErns1KuDPfGgknGY9gYLW6?=
 =?us-ascii?Q?1VsX2keC+CztIFwo7EN7AqaTctDmYzcFrRjxKvsLhuxjt2mSV/h586nNRU/q?=
 =?us-ascii?Q?XYQlA7KdfqzzYG5PR0RxwBYf0iK7IxkP9C2zlTVvynh9o8OxGGzh6jzZ2wNX?=
 =?us-ascii?Q?Q4JbuqWl5C2j9fhZJMfPkUxIyhdXMi2K43qyremn/uQEVWHTDfA420j5GbQI?=
 =?us-ascii?Q?ZkgOkkUMXcTfAIa9KY4wm4Sh7Xlb6QRj0zsn6YV72tyoSeKuJWi6n7Hzxwwf?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1c0fdf-6b59-49e0-759f-08dd7b9b7742
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:29:40.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNIyUGCgEbw19u/367oPZxzvnwVI0H9k3FQphfeD/gI1ZeivRFOQOtjZz+2NiudxL42GM3dmoHrH+d0i09lK1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

As explained in many places such as commit b117e1e8a86d ("net: dsa:
delete dsa_legacy_fdb_add and dsa_legacy_fdb_del"), DSA is written given
the assumption that higher layers have balanced additions/deletions.
As such, it only makes sense to be extremely vocal when those
assumptions are violated and the driver unbinds with entries still
present.

But Ido Schimmel points out a very simple situation where that is wrong:
https://lore.kernel.org/netdev/ZDazSM5UsPPjQuKr@shredder/
(also briefly discussed by me in the aforementioned commit).

Basically, while the bridge bypass operations are not something that DSA
explicitly documents, and for the majority of DSA drivers this API
simply causes them to go to promiscuous mode, that isn't the case for
all drivers. Some have the necessary requirements for bridge bypass
operations to do something useful - see dsa_switch_supports_uc_filtering().

Although in tools/testing/selftests/net/forwarding/local_termination.sh,
we made an effort to popularize better mechanisms to manage address
filters on DSA interfaces from user space - namely macvlan for unicast,
and setsockopt(IP_ADD_MEMBERSHIP) - through mtools - for multicast, the
fact is that 'bridge fdb add ... self static local' also exists as
kernel UAPI, and might be useful to someone, even if only for a quick
hack.

It seems counter-productive to block that path by implementing shim
.ndo_fdb_add and .ndo_fdb_del operations which just return -EOPNOTSUPP
in order to prevent the ndo_dflt_fdb_add() and ndo_dflt_fdb_del() from
running, although we could do that.

Accepting that cleanup is necessary seems to be the only option.
Especially since we appear to be coming back at this from a different
angle as well. Russell King is noticing that the WARN_ON() triggers even
for VLANs:
https://lore.kernel.org/netdev/Z_li8Bj8bD4-BYKQ@shell.armlinux.org.uk/

What happens in the bug report above is that dsa_port_do_vlan_del() fails,
then the VLAN entry lingers on, and then we warn on unbind and leak it.

This is not a straight revert of the blamed commit, but we now add an
informational print to the kernel log (to still have a way to see
that bugs exist), and some extra comments gathered from past years'
experience, to justify the logic.

Fixes: 0832cd9f1f02 ("net: dsa: warn if port lists aren't empty in dsa_port_teardown")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index e827775baf2e..e7e32956070a 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1478,12 +1478,44 @@ static int dsa_switch_parse(struct dsa_switch *ds, struct dsa_chip_data *cd)
 
 static void dsa_switch_release_ports(struct dsa_switch *ds)
 {
+	struct dsa_mac_addr *a, *tmp;
 	struct dsa_port *dp, *next;
+	struct dsa_vlan *v, *n;
 
 	dsa_switch_for_each_port_safe(dp, next, ds) {
-		WARN_ON(!list_empty(&dp->fdbs));
-		WARN_ON(!list_empty(&dp->mdbs));
-		WARN_ON(!list_empty(&dp->vlans));
+		/* These are either entries that upper layers lost track of
+		 * (probably due to bugs), or installed through interfaces
+		 * where one does not necessarily have to remove them, like
+		 * ndo_dflt_fdb_add().
+		 */
+		list_for_each_entry_safe(a, tmp, &dp->fdbs, list) {
+			dev_info(ds->dev,
+				 "Cleaning up unicast address %pM vid %u from port %d\n",
+				 a->addr, a->vid, dp->index);
+			list_del(&a->list);
+			kfree(a);
+		}
+
+		list_for_each_entry_safe(a, tmp, &dp->mdbs, list) {
+			dev_info(ds->dev,
+				 "Cleaning up multicast address %pM vid %u from port %d\n",
+				 a->addr, a->vid, dp->index);
+			list_del(&a->list);
+			kfree(a);
+		}
+
+		/* These are entries that upper layers have lost track of,
+		 * probably due to bugs, but also due to dsa_port_do_vlan_del()
+		 * having failed and the VLAN entry still lingering on.
+		 */
+		list_for_each_entry_safe(v, n, &dp->vlans, list) {
+			dev_info(ds->dev,
+				 "Cleaning up vid %u from port %d\n",
+				 v->vid, dp->index);
+			list_del(&v->list);
+			kfree(v);
+		}
+
 		list_del(&dp->list);
 		kfree(dp);
 	}
-- 
2.43.0


