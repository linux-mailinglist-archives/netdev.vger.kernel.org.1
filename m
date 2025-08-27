Return-Path: <netdev+bounces-217190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3BB37B22
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AC53B73F3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A6322541;
	Wed, 27 Aug 2025 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KAjg+rtr"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78E3218B2;
	Wed, 27 Aug 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277804; cv=fail; b=KzliTbEHie/EKhaBdHFBGMagS12Q4Sjqsda5LqCmluGpkh+xYwQIthavJYwENrQ/DmNc/oRlA5FMTRQ6ojhIagG/iSLbBdcaOZrx6358Wm+awJW0f2Lq/uwiMpiaG+w46Bh//wHd6J9xsWd0HwYyqRI4WpQRpftwFXBdIH2KTk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277804; c=relaxed/simple;
	bh=cYS0HXE3B4wJQStICvzXd5lCHjpfNL+pjnnjmMYPBQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/erYT5h9+7IZbRz9NjBkjHkFYdZw2KZ66+hCP/h+m7bdL+H0djuiQ/bLhWh1j45+cIKVTgq6YkLgIsMocjj/mgnOOYjK6tD9gmWblMPiV6XAPzQFyr2EWyxXFlT1AsXOkm052S2xqq1fQZmd0olRvp7UYATT9DKzFizCVojSr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KAjg+rtr; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJOqbBMSGVDhr8+2wjvUg3lUYbPKR3FeTk9yM0XdIw+yoncgebh66RLiHgV/kHAAzJSfApCc1mVlw2ICeeWOi4QnRgM0cDmsueDbSk1mIxsU6o99fHbCXB38IfJVM0ZNfnx2z2oKjPevT72aGZbBbTJPAZEOvFjWB4ljb8f+w4qPlKSCkEuRx7pOofMkGhsZtWSGgXuWDOdAK6YTKLJjNfemnnpurjPyIBMu8ctzYIGFat1DZTs0MzRiLfkzCDHKeV3sM7ls0vxgfjFprFI4JPKvwaN8BhKWwKev/gwaLJs2A2pF7DXK+FA6d/EWwOup+ZPGvqP8aHb0rzdvhQU6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUbNOOoRgkXrJ9IQbAo5aU7HeAXkeG4yXtSm9rmzo7I=;
 b=qHC9idxKsgQBwvu67xqcvU8FzD1Fijq8Dan6/zHLyPHlQ0yYT1NqndCtGJggxU/4XGTuu6fAdWFu2vION5s5gR610I/7Y7sVvJE8GIa1iMNSQt41m59ra5hG5uBFAd7t9Z4jSJPWeItWKrK//RoRVRjM61UEVOJSZzOOM8FIoo5KTNyxSSnbL08f/dCAVWe0ZtnPBDWLlf29enIaqgjUmBDKpodk+0suhjGH4eX/wxOgvFlBwW/XpiXJSHXcjkJ1Vl7gKgr4cTxVDf2gqJlfoJCfXNYDynbGbwdCGdN0b9pC38IDClXksrDwacU4xw1cKH2ECYtwXW0UqJgIdt2LoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUbNOOoRgkXrJ9IQbAo5aU7HeAXkeG4yXtSm9rmzo7I=;
 b=KAjg+rtr2E1TXqM0PjgfJcrUyD4nXxtsYhlu4kCHz5znIyFYnlnVgQq8rL/vEGGBXDJZuj2yWZv7eZx04vnS7VUIWIVTvhb9usrSWecdfMUJcAFgtD1VT+JrD/ZNZ9m79/r2VnQ3mdN6bCYnt7cE+6gYiNRLnV0sDBY6Njl6kRc3xmfLkzGPQnQ9mFOsDiIe9mXHlRhJ0bchI4H4ZOvG4NT3tkm0LVGAgSyZcWXm5Y4gRfYz14i4k3Mx84/Z7dcye5dQMPkc35AqE/+EHuGVEJOJwGQIJFwRIgfqSLV1BXIsUZeMMstw8PtnFqAYmpeqJH3xdbygyj+fo2hLM9UxUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8481.eurprd04.prod.outlook.com (2603:10a6:20b:349::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Wed, 27 Aug
 2025 06:56:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:56:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 17/17] arm64: dts: imx95: add standard PCI device compatible string to NETC Timer
Date: Wed, 27 Aug 2025 14:33:32 +0800
Message-Id: <20250827063332.1217664-18-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 00313ca3-ceff-411c-08bb-08dde536debe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hf2OPzbpAX8ZGPjdtI0UpMATDMT7gED/UcdXlQTlxZqX5vcGOvLy1HiJdKlO?=
 =?us-ascii?Q?x4vAnGGqrzyjJ6j/5/Lw1lKjnJmLeVIyr/F3S1kUGUoDGT2ZGLWLVF9tLPab?=
 =?us-ascii?Q?4u1kt82sHX5OKYJOVv7MFLh0ZspvJrLRsarncHkpn4t4sQCaAOlHGs2LEO61?=
 =?us-ascii?Q?XrMI45QTZb94Cn0Z8tiCzxMW6qWGvpmliOo5zgT61gCMeLIKH2LzHBHrptq+?=
 =?us-ascii?Q?ZXXppwtMi6p/oO/m1jFPmQt6BWkDaANB8WdATUZ3TgD7sIHoVWHTCQbChr13?=
 =?us-ascii?Q?cBmySWkVB04fR7+vWexHxlHEgc0TzzpcoTsFBOt8g19OQxMVGMtdTjboN7s+?=
 =?us-ascii?Q?SvOQ4c2w7Sv6MiCSdyAPi1moTGmVwSF4GUtJhMNrjDBMOPi0ChfV5/yvfTwx?=
 =?us-ascii?Q?obvG+7hFZT4X2mh3yMFNTWGdhwkm5wxLaAV7ioGw8WLu/0zKvk+U95QphZNh?=
 =?us-ascii?Q?/h+kxvWymCTaofSQBCZshj0Obp1rJgUhCqx8jQPVNw2iEXEhxDhsUcs/OLSU?=
 =?us-ascii?Q?O6uBnYXTozoCaMiivgC659wvd/NzalYRYNnUJ9KoB/w4kNx6485pFEoCAkE1?=
 =?us-ascii?Q?e7bGKCOvVMF4YSeG/U0zISVlRp+yF0wYglAXkoRgN8A6z8htC6K9zj7kjUO6?=
 =?us-ascii?Q?wtm+tleq/QUvReUpoAfa+2Wj9d3heX7oRj8li/zhi4DhtPeNb9P5sKHh0Q31?=
 =?us-ascii?Q?lpXcxJWr9Xnhz36jQD+PYoPEbW5A90K3G98uTqchP1QWFU5pfB2XvOrR8N2c?=
 =?us-ascii?Q?kHqMaHgcRznzj6rlKYIKO9cF5yXmEuLafwLaK8EUjSloBDrryzSjFlF8BECU?=
 =?us-ascii?Q?2hD/GlNhNBuYwaOkqLC0Td9Rdn7ezmModBkXjAfur5wz0L29PBf0XR2Ko2v9?=
 =?us-ascii?Q?9TOwz2ZE7W82P+voveVxX9I5rCBRVU/HyvtY1nAQFnzrVpbNATC/B9GL8TX5?=
 =?us-ascii?Q?uf3x9dFD+bAh901DZ3MdHZ83KSXqRbNLJxg5HywrwRF21ZMbmJf1ndEJdvm8?=
 =?us-ascii?Q?2puqNotjNiqrD0cmPpyYCury10uo6sdn3NB6txsYDJZvrxONZph+0ao+Tz63?=
 =?us-ascii?Q?khaGca89KGeNaOYrVvmbX0+ZZycC691M56OEErKIGll3WfyfYbPRkC5enkWv?=
 =?us-ascii?Q?JH1gwed1LoKnQpKsp6JlQhyxJykgxxYssJhms7XhDi15w+lvE7r7Cr3s3vIV?=
 =?us-ascii?Q?N5QC9mTFwT0V0SHfTBq/QNBasmzeAlIYD0TdawpRKlfsw8qs4ylGb7jgw8d/?=
 =?us-ascii?Q?Kl6Qfh/CwSBnegXFw6n5aUs/3KjGAajVxsHugrN+UyyW0nti1f9KlA8PlZDp?=
 =?us-ascii?Q?KKVtfsm3C/Pg333otQU5QeNP8EpkQHYPGuc1XiAM5FtjRcn8RXG5B9kK5CGD?=
 =?us-ascii?Q?4K9U6rBipCfy7MW2auFrQfcQQQQol1yzqOroFxV9e5a7lp2DHZLDOwd7sQ2c?=
 =?us-ascii?Q?TyV5br7pkOTnzZKwr7IOuGf0R8yhlk1vyAiIgdhszxdTKJq0ug3u85Tr066T?=
 =?us-ascii?Q?00Wz1OozNMY/ilY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwoyJqpnrahNrqCh+F+X8XQa7NSpHdoAJKQ1mNJup5X0IvogpShbACQsDFSS?=
 =?us-ascii?Q?LpYG7o44pFKEAteCccziodU+HTee12rrpHHPtYijNSuu/J+LG02IGOEgzxUh?=
 =?us-ascii?Q?J2l/FXcdyPzvzKV1QHPsM8qrYvW2T6HM/5cG63aot4+m+h0VuuHtGLWSgO0r?=
 =?us-ascii?Q?bFbjie/K6ppKgBGLAhqazLI9EMPaqYdKcgnNZJj3kvPL/b3z0Xxg3k6YB/s2?=
 =?us-ascii?Q?MzLduw6SFIb/nAinvuJ6rmPs4+XOoU1IQ6pkkNMfolPEfyxARbvozNqHICBt?=
 =?us-ascii?Q?tgqE73HQljyR3lbZOjODfhwXJMAwjSsSgwZ7pIy5zFSN5RrwvtCz5IYM9sGr?=
 =?us-ascii?Q?LCHn4vy0yRTmzX/H6WV+LxgHLm5AkUTJzzzKR09MZWAo9Ik3wjoeoUTZ1m5c?=
 =?us-ascii?Q?bTCD30026Aii2/UTM3zUtHBSUMRAKv5np2LCjDdg2vg8lV2ZR5WgIOb+7Ows?=
 =?us-ascii?Q?Ic2AyZpGx81ZkuX3MpUlPZ2L7wXS8eeu9s0a5N0iKY8Caf1UmgIjo29+OH79?=
 =?us-ascii?Q?Kp83D/T7/JSFV6esye5fZ1ut0aqZBC4Qpu6Dcjx6+/831JwItFjgwJDxAC+f?=
 =?us-ascii?Q?jVqma1oFAQN5C2UANrErEGEApQTshsOJvT2zm/ibJwULuqdwv++owEDO8aKE?=
 =?us-ascii?Q?PNYhKu+4g+YiKtwMjcgdfbbr2Z5pF76DGZ/LbcO/tZJeDwIBygQ7gveR6wpi?=
 =?us-ascii?Q?SSx3R5/1nvLpucpn9eB+c9zyIMXK8S0r4Vw38UY+siPTk8OCsErtaJdIf8Dj?=
 =?us-ascii?Q?RxpVW3J5/uHILG3XwberSRB/qgwtogjVjV/R03yQNqkaHIr9k2xIfrzA4J2c?=
 =?us-ascii?Q?z6Vp9cMtKhoR/C9+1/YWVeeLdBgZycSKYUuH32342ZgmCYix3fsqAZDzHCO3?=
 =?us-ascii?Q?hViFbr38HrdWDDnWTc5NAGHcC44PodkvPts6bkL6uvs0Z1QZO5gTh8k5EpV8?=
 =?us-ascii?Q?2nnyJHkM73/WxfGqGK1swoC/EPd/Ra0NBb/9AcTFm/leGfC0EyNsAYToT1AK?=
 =?us-ascii?Q?7s+vsthlI/7/IfrhNjz5WfmYTjuvrsDvjLLaTa7/Q7xo2Tv2K5LXSwDrrWUg?=
 =?us-ascii?Q?+f+DJQcBSonBRzUd1ZsmijksKkDVBbDTCieKMV80OCqcFuYn6xqUftTBBGPP?=
 =?us-ascii?Q?yLAOjVRkpLZuj2cpvDnp8hebH9KLCGN8DiKPvz4qRAJrOo5p0E0cvmVUbuBs?=
 =?us-ascii?Q?0qf4t/W1V5Hyr93woSUa2PYiRnTdCbnKY8bfKJEPgMXUrSfjHd0me/zbGBBW?=
 =?us-ascii?Q?pCJSAEsa+1C7FGrQebQ1l/mqXOzZg51eCeb3oPK3TqW6BN862VcbzE4iY562?=
 =?us-ascii?Q?VenZc5xBb3KlF7h1da3eiDhwGOoQ9W7lnMA9h9y9JtIXXqU83ph6YdC2uuYM?=
 =?us-ascii?Q?DrfTYUn40V4Qkjj2uBpbxg7mbwAglWKMPIrh1kRObTg741huIvyOwvFwerc6?=
 =?us-ascii?Q?QUblKcBocYWFaY5wtCfdqU60B8nWWG+SQaWyecjdYD2co8mivXZgD4eFDVTd?=
 =?us-ascii?Q?bA61T6sU6G32t8zg9wx+7bqZ/t0iRuXpe/ve7WqLvDU/MPZX/cpEU/6AGPTN?=
 =?us-ascii?Q?1/SiAKeh+asMy8LnMgDIhBv3hCW9ZNPMm/9lBmIP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00313ca3-ceff-411c-08bb-08dde536debe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:56:39.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXGYd6H30BEHSPtZ72NuVBV8Zi11V3YG82A39kDlJLrJMdbeRI2X4zEf7RSc0JySCT3+hNu47vJ7WV6Lm6/i8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8481

PCI devices should have a compatible string based on the vendor and
device IDs. So add this compatible string to NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
new patch
v3 changes:
Since the commit 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0
flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3") has enabled NETC Timer, so
rebase this patch and change the title and commit message.
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586e..605f14d8fa25 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1948,6 +1948,7 @@ enetc_port2: ethernet@10,0 {
 				};
 
 				netc_timer: ethernet@18,0 {
+					compatible = "pci1131,ee02";
 					reg = <0x00c000 0 0 0 0>;
 					status = "disabled";
 				};
-- 
2.34.1


