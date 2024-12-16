Return-Path: <netdev+bounces-152222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AC9F31F8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC301884A85
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E700205AD6;
	Mon, 16 Dec 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bTkBz3nF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587F2054F3
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357091; cv=fail; b=RfRUKaOfrfKfKghf6VAEKuCjl3Hy2deL8fCckXinoh8INT24XNki/c2oPYWiKEiHJWWcASJ4mMpunGTtwbW3aTwtvGXMWyu7PkWvz5vC4566jBajWJRSKuEsQ48lddsYC5d1YbI8PDjuAqjD06F6OsSNEHlKkwYz7MPLw3zoSe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357091; c=relaxed/simple;
	bh=zqUJwntTadod3yLA1j3W+Se0dN+uIimUYuEkZuE0L2s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i+OBQGQ0dCnZDEQPv3UQe+QSv49JrRgbEY+ahiDyM7O7mF/OJiITPfE72Y1SXM2vuLih/2sVaMxPFIOm7/RI6UqH7m8TdWr3STokv00jn1BOrkC/uNOITdDZCdGOPRlQSg5MZJBaM4m1HuB0P0pb5oX2N1BayFCtFVr7/SyDxys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bTkBz3nF; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGm4x8kOgrH10Yws5yyZZd3N55s9AOBTeNgJzqAKxtHTyLqspHHNxxu7UDr4rcd2iTiSdEqkqBuEYcNT3Hz4lbr5pvi9rrGgbqgCXlYa+p8ddsSofesDgfRJwExjh6qtcxSYW2i6ZcG6LEfufmcNuVzSI4Gal0CnWEpLPjxLydXB8LzfECgNqNjjR9Fayo/REk9qNd8zQ7c2ZnhQVBcR62KTR8EzgPkYFmR0B1M62hpRbWijKwxEuYJU9paUEYQZvKwr4K/2iAsTr+UFNvr2gEngqvqII5bki1JoRDr5Gi7PeFDMxR+YJK5S73V3ZQhUGqZHDOKxKM/xKAWZ+uwlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMy0vkb0SQtLOZ84GV6uG2s16k46pkVEGsRHO5ihZXQ=;
 b=szM9mCe56BLf4CxfvUn11uaLd8cs2usr5PvWJNIuKTbZDvvsjqpn756hPJyclW73cuLXNDKgZgDzIFaFYv78i0LPAyoRO9NiH1ut69FEfJUAkzTohNn9T+FMhXahQ3brEwYt+XAxrFAGEeEBX1SyqkOZqBC/xfQwUbxIZfmbIWzploX+YObF1Vvyyvc3C/FPDejU3Ob91t8ujVYFubbjt+jng25t6szzE4Te7g2VRpegyKxjaeB/+fpR5T8Ut5z8XPwEohxkHHusgLd6cmto9llncTW9NTR8n4387hS5MbvGqWujPkhHHegJIC0iUwbYJ3+ZCHlCxqscCAw1qA3rGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMy0vkb0SQtLOZ84GV6uG2s16k46pkVEGsRHO5ihZXQ=;
 b=bTkBz3nFTKvsvcxPbt7ndEGA3lSClru0ayap9oG6wLxu5Fp0d01c3GKy4t5XHxbqxkYnYM/U8GJi/w7kpD/uLmT2Dwu1PukBMHx9zp3s+5keAC1PS2VnTr3FKpwC9aZMI/kbOwP/8VN6khly0iWl5S+iL1r7LId//AlItL4RBCHemtm79e/kuwqxI85gry6FqWkqqSY9HKM5mk/me4x5xtxKelI0/a42m1fKUnTTnoEgeP0DRkuFmsAFc6mPJDP3ZGgAXbEU0g6ByQAbGnlUKS7HF8vnz/Sf7arEsBDMtEnVFGY4ODbesvVi+r9ICoc6Ki8/6yC6DF0RI0oP5Z3/9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 13:51:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:51:26 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH net] net: dsa: restore dsa_software_vlan_untag() ability to operate on VLAN-untagged traffic
Date: Mon, 16 Dec 2024 15:50:59 +0200
Message-ID: <20241216135059.1258266-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: be3be7bb-748f-4539-079f-08dd1dd8bc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n8W+CAErIJu8GlOhrOBk5uSvEPNMYgktyLod2SGU0bwmyUDtJzyn1hkYU7sK?=
 =?us-ascii?Q?jsdZcDSJvnw6cEUYcZuX9nzysgYXm7ChVSm7g7/qfzCcs/OtCafrgdAyfBH/?=
 =?us-ascii?Q?0VEMgl9j0I0AauM8gVSwhOi8KShv+6HoBhyXnNTULD7rh7fpWqj/R2NX5R3n?=
 =?us-ascii?Q?h9KvJSzeYk4iCxv0zRj8f1YNwjiioxhYqX6pMIiqKWPY2wtfj4hd+8jHQ9MQ?=
 =?us-ascii?Q?zYXDRglvBGypL2RJt674OPF16TVffHS33dzXflADFdTy2fVgmlGUKe9lcak+?=
 =?us-ascii?Q?9wyBiTwBJ/0K4g7do9rQ47JQqgG19ZJzfPdynTN4s8SmntcwCsJOjvqsOfUq?=
 =?us-ascii?Q?C04bsKR6rxEjRs0mDEj5IGwfEgwxXFT/tkykVpMINlOu3l+YIJLgcshZNnEQ?=
 =?us-ascii?Q?sG28E9jiVe82jQ/AW8+Qs5JoLrLdmlGawhKWbxgFSki5juG3YDztp5oNACCp?=
 =?us-ascii?Q?rv5gi29bTPnWrns0MQDJnXC4g1gxTqGSuiSgydfGBxIFJ1V2n3qQ+L68Tv94?=
 =?us-ascii?Q?LMYGmP5QpxkwhCx7az7bDktdO0C5SeJCXZZyia7KZPuWH7Kt+e2DOqQHWzRD?=
 =?us-ascii?Q?CYrHi5/693zDjWBu/KqCyGLgXFUq/mGfe+VaJWDMWlUw5i1hwys8PXTolD8D?=
 =?us-ascii?Q?/wAYA4UZwuWRd4Hx6LBETc9CDP6QN1NNpwVujOpOWSlt9ZiTPNdDzE8+OhGM?=
 =?us-ascii?Q?llksJhqkg96gsjosTGH6d+tUjZnJj/lSVkBSbGTmMYphxcg9WaZQ5ZjltIDC?=
 =?us-ascii?Q?/DQ20hJZyv0UHarMrm1fh0Rb/hYiz/HMrZHuBjZCKj0Sw3o2FuC2YoxPpBgq?=
 =?us-ascii?Q?KwubqEBRhzy6qfFDM0clGA++Wiz4UpikO7s8wU9q2F5npPMHDWH5Tk/gUWN+?=
 =?us-ascii?Q?wKycZ2uIZCjHA2FlMCllLwU09O8zwfU8OHEsDPfAYmedZE+rU1/2aIPWFuTq?=
 =?us-ascii?Q?3vgRTp3DwK5ZjvC22+TJGHBZw+0SSplh13X8rpNNd8INbXxoWxpozMVot1es?=
 =?us-ascii?Q?R3UjViC2nDlqARy6CBlAyuRYlE2XzgNVuSR3pglunon+GIxs1smwn2rHpJiA?=
 =?us-ascii?Q?qYU+MsOisv52YNtSTHPrIdWvkacqrFsxe1t73QiF1kJDqTzbRHKzbe4Tqp2M?=
 =?us-ascii?Q?Yhj1dExVWFh/UlutRABgBUGroYgQswQD/HIteLNKfG7gUIWinx3CKYsVptAW?=
 =?us-ascii?Q?VHnjba22828hb9BDo2N9TnlZRJ90tfFTaLajVu9yGLUAMfIzFukHA4Q3GB3m?=
 =?us-ascii?Q?bt2YTKCqAIoMZbhdAR9Z8bpvEG0g6M73Tgx4kUmG/JOZhFDEg5RrthpSs0++?=
 =?us-ascii?Q?7bl0131t24KteVZsWthNjbmxMnXm71zFwyWvMZZY90BxAbsdRzDLmeFsbl27?=
 =?us-ascii?Q?t+MAj6gYThIbWNZvFB3m4aKV8KGGD8Qp2J61fgblOSPHivbxwTBZh0P9BHIa?=
 =?us-ascii?Q?gv++zmWsA5PHDOQfVZ1y59qpK8rJzHJAflvF9rjESqNDBNPnWJHcaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7C9jUPNl50dXw4Sop9Dw1afhvQ2pIuderUsArT16uv5WXecoKHBVXRUu3Mte?=
 =?us-ascii?Q?ixpH9GxXaGafhKNae+nzCECzUdbr8A/OcZWcW6R0s3jaTxefo7mXbjpd6CNs?=
 =?us-ascii?Q?szsJM0A5gX3AY6H3ExPbf7KyzT3Nz0FVqQKZOwUInMw39ktkX8skTx2F5LL2?=
 =?us-ascii?Q?4aE9Uft8EaQq91VbgJWhPZ99JxEGXxn5wRnU6UnB10zR74vMDTE9kLKSYp+p?=
 =?us-ascii?Q?aiZki7IpJF9AKhUm+PuN5JUCq9l2xz0UAM5MniX3EYD+3oDSmszQp7TzZ+HT?=
 =?us-ascii?Q?UpmM/XGZz4CIhvghlUVAReY+Nc28UXZWl4Backv0HxmjSVzu09EYefkKvLwW?=
 =?us-ascii?Q?CFWKlpuMLB8Mu0lBMSLbX+3dQfClfuJeT4/1dIzljirrXGWFGk4bRgKrspDv?=
 =?us-ascii?Q?ixpXmNQFFeHq7xBpmnxQ7HSW08B2suzDVlPqsu5r68QQq7G7Za4HCr82l00u?=
 =?us-ascii?Q?JQRuKFWMXEKobNeIpa7ewtwTd0N2QN18IscXATojPKQbSWTd41wXaaYFcneZ?=
 =?us-ascii?Q?hUFnRnk0o2a/zXTsBDOrAEhbogCa0LR5yFzLoexILos5e6iSKkX/7dTZNmFG?=
 =?us-ascii?Q?zr9j/mkBLRl5NxJZlYOiiQtyUQ26c3KNuBczujIu3ANDtYBSxzWc9tJUaSaL?=
 =?us-ascii?Q?6TGJFG8rtmjKpcRe60c1i4rCC2WMs/VX8KdCoi8y++HZe2jzvQxBRBAzK8/H?=
 =?us-ascii?Q?bPsJ2j7zLE66x1Du26Rm1h/UOGjjw26E+9InPBmqiPlrQtMPOxn8ntQ2b8rD?=
 =?us-ascii?Q?A6W6JJR4dDuRR1GTpgIFMzIWTh8qJn1CedPcGRrZxca38kVsG47MCSi8G6xs?=
 =?us-ascii?Q?Huy3mm1FfiGbTbSfR6L/nGpJCulEI+sLy/ppHSMyYEWrTJuT7wtiLKlpnY87?=
 =?us-ascii?Q?eIMlShBJ5ewSJ7fWuZ3OYXNDSLiAAOpYKxL43O5pAD6qeeL0XjF3kiTkBxyG?=
 =?us-ascii?Q?Et3UiJ07rBZc5S75leviadNhto6Aazqb6bztO5mV9l0KFLHeVmip7jD1z3ql?=
 =?us-ascii?Q?JdndESqXqlxbm5CYZlwCaTrbu0i+YAPDjs1/Z/sD6nc3K4wFWPRJl1tRElqu?=
 =?us-ascii?Q?DAyIJxzE/9q/+IAWTCd/NCup/ou85srt6TzO1Y4aOTycbtpnnv2tD6x7R5I7?=
 =?us-ascii?Q?XHJ9p8OLDfBWzaExFqUTPBaQwOkjUJcVOa+ZHm6IPwTPbPld5sCfFhIrnzXA?=
 =?us-ascii?Q?kNM+3USyPNuADlxu2MoJRf+xyW7jGhtcfGsmCsn4s91Np2coCBuH17EtrbeR?=
 =?us-ascii?Q?AJ4hRgbEUB0As/sffgvV7WZxvnOHzRiLOqGUa1uWL+IS6ixrslydLpWiARA1?=
 =?us-ascii?Q?v3JqhTRbYIGLnVl6JOp+o/f2rDhmgRT1/OmX439/VMZIZlAVr/Bt42kUr4Ti?=
 =?us-ascii?Q?8BFcyJBpXLjnUBrlgXnmUFDHkiXEMcW2NJMt5+kT8nGRtoMTi9wLnZHbnYtJ?=
 =?us-ascii?Q?UwETMUIgobAK/Vh8jgcJ+UkIwG0agz6EEUnPW1ibG7LiaXjNuhkNZaut/9K/?=
 =?us-ascii?Q?LXWQ+x8BIRW2cUE3Vbrd/U/LR/CRtfEWI/ndkJQIrjBVsiaf3OQH8iTBoGOP?=
 =?us-ascii?Q?tH2mm2NyS6LPhrWzd++5AcBrC49WM2s/uD5gvt8YnKastJnrNymfTEv01FR+?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3be7bb-748f-4539-079f-08dd1dd8bc1b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:51:26.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTJCTDib+SxIregYjk3m6z44rb18uavRdgYHucUXvaR46SE+Q3V+/YrsxzUAYX7/CspsQSpID/HPfMjdTx3eVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153

Robert Hodaszi reports that locally terminated traffic towards
VLAN-unaware bridge ports is broken with ocelot-8021q. He is describing
the same symptoms as for commit 1f9fc48fd302 ("net: dsa: sja1105: fix
reception from VLAN-unaware bridges").

For context, the set merged as "VLAN fixes for Ocelot driver":
https://lore.kernel.org/netdev/20240815000707.2006121-1-vladimir.oltean@nxp.com/

was developed in a slightly different form earlier this year, in January.
Initially, the switch was unconditionally configured to set OCELOT_ES0_TAG
when using ocelot-8021q, regardless of port operating mode.

This led to the situation where VLAN-unaware bridge ports would always
push their PVID - see ocelot_vlan_unaware_pvid() - a negligible value
anyway - into RX packets. To strip this in software, we would have needed
DSA to know what private VID the switch chose for VLAN-unaware bridge
ports, and pushed into the packets. This was implemented downstream, and
a remnant of it remains in the form of a comment mentioning
ds->ops->get_private_vid(), as something which would maybe need to be
considered in the future.

However, for upstream, it was deemed inappropriate, because it would
mean introducing yet another behavior for stripping VLAN tags from
VLAN-unaware bridge ports, when one already existed (ds->untag_bridge_pvid).
The latter has been marked as obsolete along with an explanation why it
is logically broken, but still, it would have been confusing.

So, for upstream, felix_update_tag_8021q_rx_rule() was developed, which
essentially changed the state of affairs from "Felix with ocelot-8021q
delivers all packets as VLAN-tagged towards the CPU" into "Felix with
ocelot-8021q delivers all packets from VLAN-aware bridge ports towards
the CPU". This was done on the premise that in VLAN-unaware mode,
there's nothing useful in the VLAN tags, and we can avoid introducing
ds->ops->get_private_vid() in the DSA receive path if we configure the
switch to not push those VLAN tags into packets in the first place.

Unfortunately, and this is when the trainwreck started, the selftests
developed initially and posted with the series were not re-ran.
dsa_software_vlan_untag() was initially written given the assumption
that users of this feature would send _all_ traffic as VLAN-tagged.
It was only partially adapted to the new scheme, by removing
ds->ops->get_private_vid(), which also used to be necessary in
standalone ports mode.

Where the trainwreck became even worse is that I had a second opportunity
to think about this, when the dsa_software_vlan_untag() logic change
initially broke sja1105, in commit 1f9fc48fd302 ("net: dsa: sja1105: fix
reception from VLAN-unaware bridges"). I did not connect the dots that
it also breaks ocelot-8021q, for pretty much the same reason that not
all received packets will be VLAN-tagged.

To be compatible with the optimized Felix control path which runs
felix_update_tag_8021q_rx_rule() to only push VLAN tags when useful (in
VLAN-aware mode), we need to restore the old dsa_software_vlan_untag()
logic. The blamed commit introduced the assumption that
dsa_software_vlan_untag() will see only VLAN-tagged packets, assumption
which is false. What corrupts RX traffic is the fact that we call
skb_vlan_untag() on packets which are not VLAN-tagged in the first
place.

Fixes: 93e4649efa96 ("net: dsa: provide a software untagging function on RX for VLAN-aware bridges")
Reported-by: Robert Hodaszi <robert.hodaszi@digi.com>
Closes: https://lore.kernel.org/netdev/20241215163334.615427-1-robert.hodaszi@digi.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index d5707870906b..5d80ddad4ff6 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -138,9 +138,10 @@ static inline void dsa_software_untag_vlan_unaware_bridge(struct sk_buff *skb,
  * dsa_software_vlan_untag: Software VLAN untagging in DSA receive path
  * @skb: Pointer to socket buffer (packet)
  *
- * Receive path method for switches which cannot avoid tagging all packets
- * towards the CPU port. Called when ds->untag_bridge_pvid (legacy) or
- * ds->untag_vlan_aware_bridge_pvid is set to true.
+ * Receive path method for switches which send some packets as VLAN-tagged
+ * towards the CPU port (generally from VLAN-aware bridge ports) even when the
+ * packet was not tagged on the wire. Called when ds->untag_bridge_pvid
+ * (legacy) or ds->untag_vlan_aware_bridge_pvid is set to true.
  *
  * As a side effect of this method, any VLAN tag from the skb head is moved
  * to hwaccel.
@@ -149,14 +150,19 @@ static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
 {
 	struct dsa_port *dp = dsa_user_to_port(skb->dev);
 	struct net_device *br = dsa_port_bridge_dev_get(dp);
-	u16 vid;
+	u16 vid, proto;
+	int err;
 
 	/* software untagging for standalone ports not yet necessary */
 	if (!br)
 		return skb;
 
+	err = br_vlan_get_proto(br, &proto);
+	if (err)
+		return skb;
+
 	/* Move VLAN tag from data to hwaccel */
-	if (!skb_vlan_tag_present(skb)) {
+	if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
 		skb = skb_vlan_untag(skb);
 		if (!skb)
 			return NULL;
-- 
2.43.0


