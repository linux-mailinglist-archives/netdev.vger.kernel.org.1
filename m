Return-Path: <netdev+bounces-219582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8327B420D7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30C67BCF52
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1F305062;
	Wed,  3 Sep 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lBR8ji4x"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A496302CDA;
	Wed,  3 Sep 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904890; cv=fail; b=PjXvdZJp9ULIbso3MPA6vWUpnBNbWgCz7RIwD4RYgfcYgajhYgg1pxdvJavlzYKQWmwC+kwembvksrdYCCmzToV18pz6x1rEnJ3TTXX2PcL9KnlNz63qaALGMHKcP3JhH6/nWKFx6BsaiIFCST9puZMBSfbZdk4KT1MuIE+UMvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904890; c=relaxed/simple;
	bh=wYYD7dZs6cWfWFnzMiEZG0ZbZy+ZNcVuFT/lY5eDyjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUSgwRse99Os2ODbo+vTJ2r+6UBSgwCV3CAg69vgMCuINfpeN6rqeSQYqYScN1MA/qYNwCuJbLuBaF9k6ouJOTwsMNWDUkAxsWxnpjMP78XUV3i5AyJlbhUQWC3vkGus0Sp4ewzST6JO/X5eNE6AbA96gtwP5QOIDixgP3rAsaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lBR8ji4x; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5dFe2ZZipRlHBHqIPaQvHKizUi8XbYEKssULJ/UjM7WaNcGckOWfUiZYFG3lTJW2u7dEstxDiT3TE8GyQQ4WOuB+lYt+yTyaTcb0H9f3pQ/bIvh2abaJlbxH8+FXrXcDHaQ7AU2TC5iGWAWR/CnJlaX/PN93gpvCkt2s5JwFGpsFYDeaYCo4dcz4sdEtQPFYL0N8yEsWFrtAP5E51V+0y7o/PCVOtVHgmvA0tvEaI64+iA0JdZQkv5ToFmLpLAJSCurZKcv2JvHuzuGQYgeOWIOf7qZJvAgrtkXF8Sac8+rO89iEXZWLM9RS7F5ZHr5jAPVcwqOOHGg/MFuhxr8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRxR2sTpD8jSOCewme9oT5sImhXHVE9GxU/g2KKbdec=;
 b=jDSPQVjomZgCm6Msf8euc/HuR1Lf0+LmyVVUFeq4VmhgIm9O3MIS4Jh6VLFOjaxjBvZfnfyRhMH3dKET+2Wk2f8Ypcwv1Z/JwyZDb7j37ENbWGwIecRfoFlNBvQCjrWooufRdxKvKeLYnrcBFH+b5yB7p3Tg/57b679DTFFtLx3NCIY9am1cmDH8YRO5g7lalTupmK0TYxpiu3XRVtt2hqwCNIpymiYmwg02em8WyWkvnIC6KXV40fIkS+xB+PvlRq46y0ns7dKCes8UGTzrSX6evIsHIXpDdF2UecQwYPDooZ33qbdbPL0K3r3AYimC4RnpRvBhhkRKnB4SA/cEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRxR2sTpD8jSOCewme9oT5sImhXHVE9GxU/g2KKbdec=;
 b=lBR8ji4x4tv/cR1qtvQ56L4dROMJ1SjsuE6G8Ije1sACN6B+7p9florqVGOwdRsgNtD6GN26FcekhsbWOaecqYF5nQuu475tZa+wxnY4s6G5yXYkfQmbRhNE188ZxlkZib+V6mQV8UDF720X7SLLKhz4LROjzGp9fMZeCmoCs6FRmg+BT6C7tKYRT+Z8A2743xbcJUi7hR48dP3t4DrDgLKuDsrkQv3N5NQh/dV1yd9y4EIau7RfPraUN/cD8c9gcO1ARbvHSXjoXWRxXZ/a2OPNwvdGMWaDIBoH7a9TySHvvimtz0dBH6lxWcm7bL17Juf/i5H4NwtOVsz8oPrD2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 13:08:05 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:08:05 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/6] net: phy: aquantia: support phy-mode = "10g-qxgmii" on NXP SPF-30841 (AQR412C)
Date: Wed,  3 Sep 2025 16:07:30 +0300
Message-Id: <20250903130730.2836022-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
References: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PR3PR04MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 34647a51-3732-4eec-9353-08ddeaeae9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rUzHGBzG5e5mATo26GBJUBnOmF+vBzba9HudpmyYNuBiMBx8NFfuRhYylpt?=
 =?us-ascii?Q?VtBUNyRakuaioKZyB+bpUpLppWfTduoXUAc2tXO7xsgR+7DWgn/oT1xs6v8b?=
 =?us-ascii?Q?gU0OE/L91dXwzNQmwtOeb/Y+Fxl5J/Q9RB84xCuqLdC1ROr1bDA2beZNhzsK?=
 =?us-ascii?Q?5yngIVwPgEOcRhdZsd8Mhy1wf8cuMQ+YBSPhR98vqQPbfNaMVa6RWlonOSgu?=
 =?us-ascii?Q?otJSPd5Dzzrho//cIZiRJuxRZf9vdC/0O6prqn7HYt7h6W6okJu6KlT2hQvn?=
 =?us-ascii?Q?fb2H+iKVkXCbM9++dB7mETY+kDBFKFG27ps0GcDfZ3suMh4xnOyrIb+bLZLf?=
 =?us-ascii?Q?aeG0PNTRynIM6QGW2PlCM4T+ySM6jW8zuHjrXU72eTAknv6y1swOKUKnXJAt?=
 =?us-ascii?Q?MXdli85cqM4DnTxhLjaNnPhk1ej/arj37vusyt+J1MT7GqAYGjpdt3rfSRLl?=
 =?us-ascii?Q?xIyUgBbO3pN/KS+mu5HmkNOCuaU8ioNt4UWhosnEEsXVeVB9qole3jxJVJvc?=
 =?us-ascii?Q?4y16MLFa3bNLQtQIZXCplDE6oGX+5rspWSxbimTP1jhEe2+FARm3NbRvSCM5?=
 =?us-ascii?Q?bAdeV7+zcVaAE5Qxa3k0VlqAVWgtiJWTia7qjj1EC2n39rJHEORgwO+4YR1v?=
 =?us-ascii?Q?Kh57HLIOMJUK6zZwdkgdbtBc7P/YB80YFyaaDuhHp23MZOd3ZQBxrTgJFYCH?=
 =?us-ascii?Q?1Xv1ri+uoKbWR2yg7yPDDt3+WZbpbNttnJrcTr6T6POC1ksle2XEtjKYfgDR?=
 =?us-ascii?Q?BcO6D7eDWmuPvb+lWP3RZhWn/vRwYddX8dGtUOCTUm2gBAt53jkDgy8IJYzj?=
 =?us-ascii?Q?ABEUPl5QhdZv3zsRpvYW5s0Q+nzH2AVLQMVctrfHe2qmYg8Ol28kcPWulUUG?=
 =?us-ascii?Q?G/nq+rRDG5Azfe1mRjOP6MD9KeJSm3e7mfzLAwo9R2IlbHtaqyHf4sSsORXR?=
 =?us-ascii?Q?E190DQwV7tmjn47El1Swx/AycfRQiwHRyk7PsfVDqmpInQcqao8GqzyPyAbE?=
 =?us-ascii?Q?+TnDrVnjWJWziX38LmlFya3jeyors6OfPyUsGXkic/FfM+hPRcgBdqTlwnH4?=
 =?us-ascii?Q?E5zhOKQ/ZEErIqhBn3+/v9rPCehQsMLccJpveQWR1LBKj6WwWfe4Ao/c+yqq?=
 =?us-ascii?Q?3c91XUOqKug6mJCqAzTsk6QDEEulZJiPIDyqzxKCpHIRkhlT8FJYafLaMgwb?=
 =?us-ascii?Q?VUIPq9fmFwk7SR8m3hUGFeRMG9p2d1tLl9MHQ4rJS/5DnfRG2qhl4EFmTZuu?=
 =?us-ascii?Q?m1xCksAVYmLXEUvOxJZZFWiBts2Hl2F9eJYDQmODn4QMb42uTjMMRmwX9CCT?=
 =?us-ascii?Q?N0d4EjumKw4lsc0wTVV9kj9dtn3NugkrxQ5tH4OjtP2g8ox88W6dt1Z/m2nO?=
 =?us-ascii?Q?RaxJXVi1XogLiuMF3qFFcwooDeqeynGgt0VJFO1ftRDUgYQjDhR2ZtotJKDN?=
 =?us-ascii?Q?bnYtUCUIbx8FfhyZQ7OifXWJZR7TZyskxRafWK3BzAtvWr7NmvQ1wG+h7BlC?=
 =?us-ascii?Q?XMyKmoIPXhkVzp8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+gofYVM7DxZIYOoSfSzQPCow1H4kLRgpug8MncOX4B9TbTUNZOJHS+cflJ8?=
 =?us-ascii?Q?Ithz8H/MAFyao5fiwXAwGNT9BveL1narN9+vEUM0kaEKzKaPRHsQJ25lB8G3?=
 =?us-ascii?Q?92FTN36EvAzOjG1xDmIpWleJxsMza4GhgwGbkwnIrJ7ir9E7KWwzFwsp5LqS?=
 =?us-ascii?Q?t08srKwac4phXuNc94dv5y+sMfJqGU10ePHRJDaGwQSomer0eGO2hMimdw+R?=
 =?us-ascii?Q?QY1yaUiGgmGJCa1GeGTk5BGBmICdVpT9K32AU6KnpCRpaVJuzdDmclZQGkY2?=
 =?us-ascii?Q?JtBQgpld/3kFiS+LSDoGtnhbDwZt1xgZmaBBHs69xP4MBK7iyQ6RqdyUgcOh?=
 =?us-ascii?Q?Dep52WVHe5Yh+ScJn7RiV71EU8ZFaa9PkZwzXYEPr0Vp8Od3l6uSGkMzl4Mc?=
 =?us-ascii?Q?akmu2pNKLgsro68ivzgIxyl2RbPmRQNS9Ykd6L2lLPY+5hODykgVkv4NKWKf?=
 =?us-ascii?Q?qcZETT3VCaR3wsoant5ILTArFnqddZUvzJMv9HDEQcKwcLLfAsow/7E18vwu?=
 =?us-ascii?Q?j+/gX4chWf+uqNoMos1FOUSkGRNqxViho72DYnafDypcaQLoQwMfoLfwVERW?=
 =?us-ascii?Q?QH4C1OpEFfGmbVZ2oHiOLXK+zUTtvSeeXi17a1u+Yl4rp1C17DXt/S89cyxS?=
 =?us-ascii?Q?W8AF+8Ne6dDC6m5VnL14JPxQlsZ/j2xyTygHzOoI7FwxgKyFRakUVK1360GC?=
 =?us-ascii?Q?aHKN2FMDaG2AfKB4cDaUIkvMxXzhowUhSLI6isZ5btbSDIzSZYtUci9ir1cK?=
 =?us-ascii?Q?3tpv/c6+KNvKaF/PJTUVTftKexHXD4DEZmxMt6++swZD564UYTYBlrTDL2Eq?=
 =?us-ascii?Q?imcgPTsYK64WokBdZHKwU/risNuqitmiwbFR3uk3UqbeuMZwLYWjYQtuFCef?=
 =?us-ascii?Q?CgLlRGRvauIQOLdYzG3S6iBnj99Z2CLy6ZVW2vgeGnlTgsVMQiBMTGKcqAk+?=
 =?us-ascii?Q?13OXnnnKitq2bsBM8SqbvH7o3WkR70C5l+CcEhRmSq3syuxjZhj/yzNIsKiV?=
 =?us-ascii?Q?Yc6YkgA0ZHJHJ5ghzEGUNmsayb4hzkH5zDPXNTV6iAdU5To48iQjJUeTvu6H?=
 =?us-ascii?Q?aQtJlY9J3vVSMUhylu2FoncGnqOo9IrQPLs/fbuwJi+VriDRUugQOA8Ft9k2?=
 =?us-ascii?Q?Hn2YFew4LWy4PxwJNa9KpUcHnFVl1Jtmw+2xsIEUW9SM2h86gTUuiNnKkjwn?=
 =?us-ascii?Q?2crVnn8ePalfBeq1MmUX+1VTsbboNf0PimZ/BnEyPNHGTy8Zur49Mn5VVWCE?=
 =?us-ascii?Q?XTGFVl1X0PMzmtU1rB5T9ZLilBbe/a7dXms4rUa+39MsNpslSUhVM7bIJjHb?=
 =?us-ascii?Q?pZjm+q7tn2KdTCBi7ZDVMwl9ae9cJpdtGZme+NkKdGHpvRZT5Yvk4Flh7K7/?=
 =?us-ascii?Q?Y7duMkfOLPBCRI5X+5DVdA2bk9qevihUs5RFZYg87uM0pswcR1JX0IABvuUs?=
 =?us-ascii?Q?/tidx2Ww+/WZ/+s6dn66McvC7ULyRVOjkeiLYka0EYfp+kRzz0BH1AIpPmW2?=
 =?us-ascii?Q?EMIz6GXXDjDjnYLyrRh0Nk0CJCgULVmD/AcxmUJtUAE//o6CtJgt8EWu4TIK?=
 =?us-ascii?Q?BXKv+EtuYfL4deBLGLl6OAWBQi+E1IfXv+iDO4Hn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34647a51-3732-4eec-9353-08ddeaeae9c4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:08:02.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGMDV0PPHDN5feP4/vkE+PB3ikSSH5vh+qqaVBf3J1+t3Z6VdOVmL6Ea0jAJOG45Jo1X/4C/9sBTlIJWQOFIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420

The quad port PHYs (AQR4*) have 4 system interfaces, and some of them,
like AQR412C, can be used with a special firmware provisioning which
multiplexes all ports over a single host-side SerDes lane. The protocol
used over this lane is Cisco 10G-QXGMII feature, or "MUSX", as Aquantia
seems to call it.

One such example is the AQR412C PHY from the NXP SPF-30841 10G-QXGMII
add-in card, which uses this firmware file:
https://github.com/nxp-qoriq/qoriq-firmware-aquantia/blob/master/AQR-G3_v4.3.C-AQR_NXP_SPF-30841_MUSX_ID40019_VER1198.cld

There seems to be no disagreement, including from Marvell FAE, that
10G-QXGMII is reported to the host over MDIO as USXGMII and
indistinguishable from it. This includes the registers from the
provisioning based on which the firmware configures a single system
interface (lane C in the case of SPF-30841) to multiplex all ports -
they are also only accessible from the firmware, or over I2C (?!).

However, the Linux MAC and especially SerDes drivers may need to know if
it is using 1 port per lane (USXGMII) or 4 ports per lane (10G-QXGMII).

In the downstream Layerscape SDK we have previously implemented a
simpler scheme where for certain PHY interface modes, we trust the
device tree and never let the PHY driver overwrite phydev->interface:
https://github.com/nxp-qoriq/linux/commit/862694a4961db590c4d8a5590b84791361ca773d

but for upstream, a nicer detection method is implemented, where
although we can not distinguish USXGMII from 10G-QXGMII per se, we
create a whitelist of firmware fingerprints for which USXGMII is
translated into 10G-QXGMII. At the time of writing, it is expected that
this should only happen for the NXP SPF-30841 card, although extending
for more is trivial - just uncomment the phydev_dbg() in
aqr_build_fingerprint().

An advantage of this method is that it doesn't strictly require updates
to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso, since the
PHY driver will transition from "usxgmii" to "10g-qxgmii".

All aqr_translate_interface() callers have also previously called
aqr107_probe(), so dereferencing phydev->priv is safe.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia.h      |  4 ++
 drivers/net/phy/aquantia/aquantia_main.c | 52 ++++++++++++++++++------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 2911965f0868..a70c1b241827 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -171,6 +171,10 @@
 	 FIELD_PREP(AQR_FW_FINGERPRINT_MISC_ID, misc_id) | \
 	 FIELD_PREP(AQR_FW_FINGERPRINT_MISC_VER, misc_ver))
 
+/* 10G-QXGMII firmware for NXP SPF-30841 riser board (AQR412C) */
+#define AQR_G3_V4_3_C_AQR_NXP_SPF_30841_MUSX_ID40019_VER1198 \
+	AQR_FW_FINGERPRINT(4, 3, 0xc, 1, 40019, 1198)
+
 struct aqr107_hw_stat {
 	const char *name;
 	int reg;
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 5fbf392a84b2..41f3676c7f1e 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -512,8 +512,31 @@ static int aqr_gen1_read_rate(struct phy_device *phydev)
 	return 0;
 }
 
+/* Quad port PHYs like AQR412(C) have 4 system interfaces, but they can also be
+ * used with a single system interface over which all 4 ports are multiplexed
+ * (10G-QXGMII). To the MDIO registers, this mode is indistinguishable from
+ * USXGMII (which implies a single 10G port).
+ *
+ * To not rely solely on the device tree, we allow the regular system interface
+ * detection to work as usual, but we replace USXGMII with 10G-QXGMII based on
+ * the specific fingerprint of firmware images that are known to be for MUSX.
+ */
+static phy_interface_t aqr_translate_interface(struct phy_device *phydev,
+					       phy_interface_t interface)
+{
+	struct aqr107_priv *priv = phydev->priv;
+
+	if (phy_id_compare(phydev->drv->phy_id, PHY_ID_AQR412C, phydev->drv->phy_id_mask) &&
+	    priv->fingerprint == AQR_G3_V4_3_C_AQR_NXP_SPF_30841_MUSX_ID40019_VER1198 &&
+	    interface == PHY_INTERFACE_MODE_USXGMII)
+		return PHY_INTERFACE_MODE_10G_QXGMII;
+
+	return interface;
+}
+
 static int aqr_gen1_read_status(struct phy_device *phydev)
 {
+	phy_interface_t interface;
 	int ret;
 	int val;
 
@@ -539,36 +562,38 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
 
 	switch (FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val)) {
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR:
-		phydev->interface = PHY_INTERFACE_MODE_10GKR;
+		interface = PHY_INTERFACE_MODE_10GKR;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KX:
-		phydev->interface = PHY_INTERFACE_MODE_1000BASEKX;
+		interface = PHY_INTERFACE_MODE_1000BASEKX;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_XFI:
-		phydev->interface = PHY_INTERFACE_MODE_10GBASER;
+		interface = PHY_INTERFACE_MODE_10GBASER;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_USXGMII:
-		phydev->interface = PHY_INTERFACE_MODE_USXGMII;
+		interface = PHY_INTERFACE_MODE_USXGMII;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_XAUI:
-		phydev->interface = PHY_INTERFACE_MODE_XAUI;
+		interface = PHY_INTERFACE_MODE_XAUI;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_SGMII:
-		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		interface = PHY_INTERFACE_MODE_SGMII;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI:
-		phydev->interface = PHY_INTERFACE_MODE_RXAUI;
+		interface = PHY_INTERFACE_MODE_RXAUI;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
-		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		interface = PHY_INTERFACE_MODE_2500BASEX;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF:
 	default:
 		phydev->link = false;
-		phydev->interface = PHY_INTERFACE_MODE_NA;
+		interface = PHY_INTERFACE_MODE_NA;
 		break;
 	}
 
+	phydev->interface = aqr_translate_interface(phydev, interface);
+
 	/* Read rate from vendor register */
 	return aqr_gen1_read_rate(phydev);
 }
@@ -757,6 +782,7 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
 	    phydev->interface != PHY_INTERFACE_MODE_USXGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_10G_QXGMII &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GBASER &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
@@ -851,7 +877,7 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
 			break;
 		}
 
-		syscfg->interface = interface;
+		syscfg->interface = aqr_translate_interface(phydev, interface);
 
 		switch (rate_adapt) {
 		case VEND1_GLOBAL_CFG_RATE_ADAPT_NONE:
@@ -1091,7 +1117,8 @@ static unsigned int aqr_gen2_inband_caps(struct phy_device *phydev,
 					 phy_interface_t interface)
 {
 	if (interface == PHY_INTERFACE_MODE_SGMII ||
-	    interface == PHY_INTERFACE_MODE_USXGMII)
+	    interface == PHY_INTERFACE_MODE_USXGMII ||
+	    interface == PHY_INTERFACE_MODE_10G_QXGMII)
 		return LINK_INBAND_ENABLE | LINK_INBAND_DISABLE;
 
 	return 0;
@@ -1101,7 +1128,8 @@ static int aqr_gen2_config_inband(struct phy_device *phydev, unsigned int modes)
 {
 	struct aqr107_priv *priv = phydev->priv;
 
-	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII) {
+	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII ||
+	    phydev->interface == PHY_INTERFACE_MODE_10G_QXGMII) {
 		u16 set = 0;
 
 		if (modes == LINK_INBAND_ENABLE)
-- 
2.34.1


