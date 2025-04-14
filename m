Return-Path: <netdev+bounces-182495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A9BA88DD0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1505C16C463
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070D1CAA6D;
	Mon, 14 Apr 2025 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="isZHnD3d"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48E1B3939
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666216; cv=fail; b=OmsdT2yzqcRrgbr5LbQGPBAlWdxLtyMbHeFSSojXmWpbgiS9hG/FHWg6CG8CWCeXy2dnnQJX7P8JkOgBrf8GL4zDpGhHgqIj2CPUmUHu9Nw0RE259k5xYP9pbJxXTMnsUznDvC8+xJWn54ixTpOOJAALmwFxsl6NsNHz4+/pNZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666216; c=relaxed/simple;
	bh=h86MJDSFsho0Uimg4CtLtaovgNgTxHxFkWUBbJRTm4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNdnKA2EqNtaRMpoiYx4ZEvglRpax45CARl3FJARdXrpbYyb+fYKFZU3s0Wwau22qnF2nDgpUdh3l8SBtwmLwNPAhu68Fwh0HW4u6xnSFv7SumI5blSSo2BEmEv3Z062pUnNTSt3NNBx7H7DtAwTAY375Cbl/ZxOnAPSxmlR5lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=isZHnD3d; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFhpy7Ou9Sl35b5trIysvouetJ5o1D5JEHylyUg8ajgCa6SIaDfaAJ/AnvHL5iunp6/YiGgS7RJp6EyFESzrvGEAbLpQt5c4tS/qCd1oYx85nMjz9u7Bkqk5fgSgiANGQ+8rXW0gqKrsVBZTa1JmaCc3QM2fquJJxxZ8NnhOfla3BOXnBgq7NSjkyYHa5Yi0XCqEjxT4r+o/OuJuabIJl4NWMV0Ueb7x2pHwbvrXGIrTxMICk75oiQQ6r1YgCoW20aUhP3tY7pzFrTF5kWEOFylBESDKUSejYdq/fmUdYqCXzZnbvNx3dT79z5JZTxlgEkiS3gNMR1o/Sp3iBI0GDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8k7Q8VVFYMxehNTgtPjYpjnfa+rBjFUSGyFJKX+nyU=;
 b=WsXZxIDgIl74Bh2BaZNz+4+4++f2dSo8uGn/CDBwhyJbpBHUswNnPb6OEEGq2CjVZ4kBM00lBLzI7X7JgWa7iD/oB7yfuA6LRwhvSMD/TEZCn7Uq7QEj5OM9oEjwCxMdxGbBAfqIFHdD3lYSZFqYapJv80oKhbuGqd0G8bSXTyeQ4HXx21zYlSObEV/DbfpIujJ0qccT3rzWvmctmvfCUh4aEYCEFcx3XzA7JygKJB2Oqj9luxyMUe9OOrEvStcS2aUGvixVltcOM2tqCxhKjEgWnBxl+p5I0Zqik85tVO+cet+8E8nek7NG8vt2mMbUAxXMhoIK52ojdllmNdcxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8k7Q8VVFYMxehNTgtPjYpjnfa+rBjFUSGyFJKX+nyU=;
 b=isZHnD3dUVbD+XZbV83iGGtBMl1FAWsHmqwhdYmUNcvusDAtYFyG04IcmW6MUlcCygGM/B6zVN6Ovdba2VDdbvHml+VEKHNQqIzhiZEB40HCRddZ2BjcqqkErzJA+bsySD1+7pzQKAYABrrHUmI4aQ1W1rXmQfESFBHAJpl46rXIYLnnNwT6M0Ts5AxhKmodH2EOhxt7A1qNGnGVHtHrgEchnNhbe+KNoDyAtiaFcv3hsOX7V5Nj5LXLQtnhneOPWRTIXZX82Pp/fa0/vSC+QFq96eS91O9fDxaqIpK56vgdTsKP2riC4RCqcQUhvEOxsAqTg2P8S+nfz5CW70/cvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 21:30:11 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 21:30:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vivien Didelot <vivien.didelot@gmail.com>
Subject: [PATCH net 4/5] net: dsa: free routing table on probe failure
Date: Tue, 15 Apr 2025 00:30:01 +0300
Message-ID: <20250414213001.2957964-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
References: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f789e7-74c6-4313-eee1-08dd7b9b8964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CiiP+H2+hQwF+0D5CysCX6nRJ0ZUw3ovg3HyhvaeCx0j+drqnrqHNsA7ztDL?=
 =?us-ascii?Q?GUSFcfvQ/xlSKeCexE4Wi72N7la3jOe54SmFVCitvOu0g7gj3OizgnktCTfK?=
 =?us-ascii?Q?jaOdfKLCVVA8oUWG9XHb1YiEjKcFgtbZNCEHjCbiR2FpsCtM5E0/+IIUv7On?=
 =?us-ascii?Q?pZLyRR+9SVPBhhI8RLxSFdCBQ8axqr0G3HDCTFxNCnxLwm52kVi1Lv2L3l5U?=
 =?us-ascii?Q?b1JVhyIkq9NwAQGOafZU9aaygYW6DBS0Ndewd0B+Vh/f81MPY7FHxerGPxs2?=
 =?us-ascii?Q?T36OGQytOcp5RrEYaHinS3XUb42FmsU339nmA6CLOmUTjvvpf6EhDJSUL43+?=
 =?us-ascii?Q?p9cw1fKf7sc0tGGyzwb4Bd9R1bBJs/xW8LS+5cpDUK6QtKx4SWIrvd6KUunM?=
 =?us-ascii?Q?i0tEDUX7fJ/1OeAa8GW0hEyecJAtE2YjYMhF/K8nbo2ilw/4E5rk2Zc+BVQp?=
 =?us-ascii?Q?p4w2sqFJHsjlw0XqpOrY70+BJrZTvxLcTdxh5quXjJdNhrwaMYMOVsh67MJ3?=
 =?us-ascii?Q?raab6WvD5gqo8ur500Pe1RvVxY4KMEzo2rvjkeUiLDLgtbfMgcl/bwCRiiw/?=
 =?us-ascii?Q?grryAXjIK1VoWbuUQri1sspoxla8TFlUJ5bVy5p0CDAjDEPyoctSv7GlBbfT?=
 =?us-ascii?Q?uKNPPbY+rOME9NAUad9LI/d7tCajjlR6GJbQMSN3IIBcZrO/yZj09NDSgMGQ?=
 =?us-ascii?Q?n+UEIZwJSBan9gTLpt8SOrrfo37eoSWHYczkz26Em3HWemjoCEiN6b+3Hl+e?=
 =?us-ascii?Q?eebj9pu8M6Wmm2eoR6ukBsRkL9DR5VenVNoH0BgUwA8MD3BYqP5ynFY5MNZJ?=
 =?us-ascii?Q?kmFiI8rrE4O1ewfI8tAl2hNkrO7X1h3CVqxwq/wtBodcT4zUIGYW/ABbip4v?=
 =?us-ascii?Q?uACH1rvEW6u7AW7EXvi1MEHbldh3Q2V5iUVi2P+euHKE8oHxiuLVJuIW9iFm?=
 =?us-ascii?Q?VY8ZgF5NX7xjpSsOqy8kBCWLXt5berg2bv1bYBglEgGMUMUYx1dfPJuv4sev?=
 =?us-ascii?Q?mI8QeVDU/almxw/B3QvW+Sc4Lx/EuM+LWAD/aQOfuARxsNJjL9exn89sBmCR?=
 =?us-ascii?Q?gGzth8+gOe8YjzlbamcaHNL7gdFxmXprHeWSdzjaFxSBF+oHGHfouKaTRKL7?=
 =?us-ascii?Q?AZmWcMoTgV0gXsdIUPrTqJn3UUao0ZZd9Tuj4s3xfDeT6givVPuo5NHDcQxQ?=
 =?us-ascii?Q?mq3WEwDzVl4N+dh1ChwU1ZtCapS4LQ1QK8fzKQj9t+r+7cIA3ptnhdEvCnwv?=
 =?us-ascii?Q?N6vybqK1LhnRI5XY816TTDbEUb7r+yOYV9DYWiepCBbyL2BJz3H3jdyREzZV?=
 =?us-ascii?Q?z28o8GQTxUwjbuiBY/fEQneAQq5Y7rzaHgB8zFboa/4z2VwPn3S7W2EjT0z0?=
 =?us-ascii?Q?IAruxNnbX0fvPpgRQRcvOo8cpXpU2oorouonA2B+7cJXkoXG+iZkHM2hHNQj?=
 =?us-ascii?Q?gAaiSnnZmI+vwictJv9wd1peVOXmixdx4ZAEVd2mAhP5CuX/Wx/SVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6yy1oZfb5ui3BXHnjZ1gWY7oiQHFF4wUaM5YJpq1NPe/NRVLHK9qe8piee21?=
 =?us-ascii?Q?UvCDoutA/606bEYHRwpzOKFYZNQCqI5wARBoz9ISWJzHQYPpa6NKIduSFKIc?=
 =?us-ascii?Q?gTIgPO78x5kzCK5R+goc+JnCi94aseUvi9GMaHlS+NNh+9bdhIV9q8gP7zhJ?=
 =?us-ascii?Q?ff8PNI3QrywwDeqDpsFqifsxa35LgkLOgoNJ6KrMdyFT4P/ROBFk7VeBK7H5?=
 =?us-ascii?Q?xEq3F31p1Awxa6R69u7520TekxZdXmV2WmskqURKK4DPPsarBtfbC90dggfZ?=
 =?us-ascii?Q?wSrO7aPvwMEfXXxQxBiPHekAC8Va8HwOkLNojZD2F3aR9r0wGlQRy6rbputX?=
 =?us-ascii?Q?Y4kyiXP43RaMWU6t/LN0moksyoEWcT953kzvZ5m3ChDf64R+K1aiFRTrlLu+?=
 =?us-ascii?Q?dZH4gNEdgBDn8vZEm/aGWwFZP6vTraVbY9nnReM+I2jpFkwyrIVaPJVMYHDK?=
 =?us-ascii?Q?RUwp71xIpvYtcJPJmijxRcQ4GbJQCSlkeTzL2Y7Eovya+ErspKq7d2W0MBMT?=
 =?us-ascii?Q?FUZSt8Bj76NFNeVyYsYaG3FysLwFzABMq5C+uWuklJgvHWrZwimCDblRXIRM?=
 =?us-ascii?Q?/X7f5hrI0/I/1YXqwU6nxlfMV3yNbwrxK1sQxk6PkMtlMwxTKqNdS1iqTA0S?=
 =?us-ascii?Q?zVEfuob7b8fcy2H77iajzo58TmyniZOB9oHPInq1jFYORZkNA/lsg+9Gei8J?=
 =?us-ascii?Q?vV+YvSaTD7gyrc570Cp3fwcFujOyAkQ/NYnsLOwdlObozimBl40OuFK3ZXWO?=
 =?us-ascii?Q?yPrDcnI3kJVdJtfn0ggsRJo70bBz2mcKgy+C5Q1nrHibDC4RTczGiNQdXM5k?=
 =?us-ascii?Q?qgqFqK9Le4AUmSCf2Sd0EDmpNrOeHDwc58PbiwmwS/mz2dCMSBw3IpyCGd/q?=
 =?us-ascii?Q?QdzjgZCtmrdziTmPQO034mYjUrBVWyCSw2dfpczO4ah8LBLYyibl9wKOc/MB?=
 =?us-ascii?Q?NTQfvtX3Y2uNq+GaQgQBfrMvqG7mgi7QnM6RvdWMv6O+Zn5tt86o28NJHt2I?=
 =?us-ascii?Q?fLyls3XqRr+90YFXNoexKHU+AiI+dxGvdVRA4CySayawuTiO7kjkNUhpzLBP?=
 =?us-ascii?Q?qk2fq1xd5hab3mfr8iEIXOsYxEnncMNpoAtJPdM0j2bPScEnQbMvPc3ERokb?=
 =?us-ascii?Q?2vK2GnPqEXij05xfw3/9AV8Wmm6nYMTdZG2IoMM/RkC9B4HztZhLhhxfF0tz?=
 =?us-ascii?Q?SmlgyWXcL1i3eZTBoKJE6+Cgs4lWY/gmx7FEkRcIswLGzakdUqji2odRY2Yc?=
 =?us-ascii?Q?rPjEFxgXrodCRt5ef/2E+yOQvEkdIi4tpTW0ftLgIc1BczO3351CY82f3sNF?=
 =?us-ascii?Q?U4bZFLq+EiB8L1xA2yOf1biBTnDGm6m/OWJmVGF2B0L/7sbcw8CTlWXV1DEv?=
 =?us-ascii?Q?EGrnzO7Sq4dYa4wEy+5Q23Kgl8trQ9LbInnTkLWFBiDXXt3B6/Fy0q+I/Znx?=
 =?us-ascii?Q?lxi2XOEwRP2jZbBSoPHh1Ds+Um6w0hCaePOxsxj8ybvTMVeWuS+s4aEA+tu/?=
 =?us-ascii?Q?Yxc5d8a7u9G9fr8xHeEFERA67H3oNfIwexNpZzMGMOXIATz3ukHlSfTE482J?=
 =?us-ascii?Q?vke302foFCTS54OcZPVJ2XCiwnoktgyJKyHg++UQJjuBrTLBcw/VTEVxcwGG?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f789e7-74c6-4313-eee1-08dd7b9b8964
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:30:11.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypHruOl+sm1XCt4x9K3fqY5m/MfU1wp5cR40rrHZPNq6U+f0D4kKS5vQYE7sT9TfvPP+VtfgbyZ6YGeDWNSGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

If complete = true in dsa_tree_setup(), it means that we are the last
switch of the tree which is successfully probing, and we should be
setting up all switches from our probe path.

After "complete" becomes true, dsa_tree_setup_cpu_ports() or any
subsequent function may fail. If that happens, the entire tree setup is
in limbo: the first N-1 switches have successfully finished probing
(doing nothing but having allocated persistent memory in the tree's
dst->ports, and maybe dst->rtable), and switch N failed to probe, ending
the tree setup process before anything is tangible from the user's PoV.

If switch N fails to probe, its memory (ports) will be freed and removed
from dst->ports. However, the dst->rtable elements pointing to its ports,
as created by dsa_link_touch(), will remain there, and will lead to
use-after-free if dereferenced.

If dsa_tree_setup_switches() returns -EPROBE_DEFER, which is entirely
possible because that is where ds->ops->setup() is, we get a kasan
report like this:

==================================================================
BUG: KASAN: slab-use-after-free in mv88e6xxx_setup_upstream_port+0x240/0x568
Read of size 8 at addr ffff000004f56020 by task kworker/u8:3/42

Call trace:
 __asan_report_load8_noabort+0x20/0x30
 mv88e6xxx_setup_upstream_port+0x240/0x568
 mv88e6xxx_setup+0xebc/0x1eb0
 dsa_register_switch+0x1af4/0x2ae0
 mv88e6xxx_register_switch+0x1b8/0x2a8
 mv88e6xxx_probe+0xc4c/0xf60
 mdio_probe+0x78/0xb8
 really_probe+0x2b8/0x5a8
 __driver_probe_device+0x164/0x298
 driver_probe_device+0x78/0x258
 __device_attach_driver+0x274/0x350

Allocated by task 42:
 __kasan_kmalloc+0x84/0xa0
 __kmalloc_cache_noprof+0x298/0x490
 dsa_switch_touch_ports+0x174/0x3d8
 dsa_register_switch+0x800/0x2ae0
 mv88e6xxx_register_switch+0x1b8/0x2a8
 mv88e6xxx_probe+0xc4c/0xf60
 mdio_probe+0x78/0xb8
 really_probe+0x2b8/0x5a8
 __driver_probe_device+0x164/0x298
 driver_probe_device+0x78/0x258
 __device_attach_driver+0x274/0x350

Freed by task 42:
 __kasan_slab_free+0x48/0x68
 kfree+0x138/0x418
 dsa_register_switch+0x2694/0x2ae0
 mv88e6xxx_register_switch+0x1b8/0x2a8
 mv88e6xxx_probe+0xc4c/0xf60
 mdio_probe+0x78/0xb8
 really_probe+0x2b8/0x5a8
 __driver_probe_device+0x164/0x298
 driver_probe_device+0x78/0x258
 __device_attach_driver+0x274/0x350

The simplest way to fix the bug is to delete the routing table in its
entirety. dsa_tree_setup_routing_table() has no problem in regenerating
it even if we deleted links between ports other than those of switch N,
because dsa_link_touch() first checks whether the port pair already
exists in dst->rtable, allocating if not.

The deletion of the routing table in its entirety already exists in
dsa_tree_teardown(), so refactor that into a function that can also be
called from the tree setup error path.

In my analysis of the commit to blame, it is the one which added
dsa_link elements to dst->rtable. Prior to that, each switch had its own
ds->rtable which is freed when the switch fails to probe. But the tree
is potentially persistent memory.

Fixes: c5f51765a1f6 ("net: dsa: list DSA links in the fabric")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index e7e32956070a..436a7e1b412a 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -862,6 +862,16 @@ static void dsa_tree_teardown_lags(struct dsa_switch_tree *dst)
 	kfree(dst->lags);
 }
 
+static void dsa_tree_teardown_routing_table(struct dsa_switch_tree *dst)
+{
+	struct dsa_link *dl, *next;
+
+	list_for_each_entry_safe(dl, next, &dst->rtable, list) {
+		list_del(&dl->list);
+		kfree(dl);
+	}
+}
+
 static int dsa_tree_setup(struct dsa_switch_tree *dst)
 {
 	bool complete;
@@ -879,7 +889,7 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 
 	err = dsa_tree_setup_cpu_ports(dst);
 	if (err)
-		return err;
+		goto teardown_rtable;
 
 	err = dsa_tree_setup_switches(dst);
 	if (err)
@@ -911,14 +921,14 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 	dsa_tree_teardown_switches(dst);
 teardown_cpu_ports:
 	dsa_tree_teardown_cpu_ports(dst);
+teardown_rtable:
+	dsa_tree_teardown_routing_table(dst);
 
 	return err;
 }
 
 static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 {
-	struct dsa_link *dl, *next;
-
 	if (!dst->setup)
 		return;
 
@@ -932,10 +942,7 @@ static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 
 	dsa_tree_teardown_cpu_ports(dst);
 
-	list_for_each_entry_safe(dl, next, &dst->rtable, list) {
-		list_del(&dl->list);
-		kfree(dl);
-	}
+	dsa_tree_teardown_routing_table(dst);
 
 	pr_info("DSA: tree %d torn down\n", dst->index);
 
-- 
2.43.0


