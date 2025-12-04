Return-Path: <netdev+bounces-243588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D63CA44A6
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FDB73022F04
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72C2DC770;
	Thu,  4 Dec 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wnf+8WDc"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E2246778;
	Thu,  4 Dec 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764862452; cv=fail; b=B+TLQ7Q3tW+GrGRfe2oAMxl9slONbaMG3JPeijD88uU7Z2cxcF+Eo/9TVeP+KjI0k8M122dAq5e2f2g/RAQ8Tfrq5RwKZDqP/YfBVSSdIW6JArBtKulY6JtmSSJ5dMkQoZQVcicJC/fCAHUkxjHHEiCMiVbpY55PcBHGHlqaMTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764862452; c=relaxed/simple;
	bh=bBHsZfxgabwTtEiK2gmsGKUVenjKpMDfXhLawbMj3sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ogMGiu39GqOpATXx6rPAAI2S2q2xS3f6OHpk6lB/o4eN+svhqi4vA7ZP7zdiVYuE2whe6Mr5VeDx8LPyoN5SNLzATGSDvUg4SYIanKUcQ7oLx42eoaAgLvEZE7Hduc0AMTi3wBR5sBYhXMAvB9r4k6H4y4X+RGE79jBigXohFpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wnf+8WDc; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMDc0HKyERAl5APac9H+lvaH+nq21CYA9OlGb+KC0AjtQQYfmlKvjVN1gc/RoaWyEutboy6tp4kpUH+JQm5Snl6JkCNI6pDuytK/siOwezX5a3s0Ga2xZZD2MxfNFR/WpK9UQ8gzt8/xHVPPfQ4ebjFB0/h0oLkFRwpkXnuqFxw7Cp324rMI9MSMvQ3ThMTajn4u2wARN5Xb5qzSWnYLc7vdj6PFlA0Gb1G+UyTzs45pqFWQe7ilTm5Fyy9cCB0mtq0p5bhyz7VAZ1JQ0tGoyfOKeTB0clXk6VuAbNqg7ZPwBLqCs4YVo9Od4ulNqQQ+7l9bNTNRJ8D3boebnIQK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYW7bEb9/GSHgbvO9qbG+Xqx87nVx92gULGVO2e+jLE=;
 b=FJRNEbzyEkQMpe1B/wmIvHn6gv0jVQ68L8n2Qn13qxahqcdWVfWNtp3ePpJpJ3NiVEaxMOoJFEaSo0sob1O4ftgiPAmbRiECzt881rI0C+v85LDvODim2aZqEx58El5cotA832+qHFAFeE2Y7zVLSiFDqbBCNiCaUj3oRhCb6/jDt+o9kKagLe1ZJXP6mvbo2d0r4cTRmt+OrV2mYMrpUruPCiQhl4DflXPcp/MQ+h7EvRvWyHnH3TDTyjddMP/XWeHALiawFfGOo7g35KNOmMVrWEXNCQaUHcKHptKMl8AwnQpCL24sSNSqPZ/eV77sNvP3nELEo80YFD5aEnj9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYW7bEb9/GSHgbvO9qbG+Xqx87nVx92gULGVO2e+jLE=;
 b=Wnf+8WDcLfa6/KFmqAmo2g8JAN6pyxTSwGemOo8L8MeoY2tczAB5kRZkbrOTjwvjOCj6E4lDqoj7D2V1sAE+o01PanQy+tFtbjcMesq4SCMI1JLEkamlquhZ41ef6FA36DmhBseYn0SMvN5/FBdFFINUlPDWHzF9b/lDDmhsVf1I5hVYoqbS6KXa1+D3u6ZkxV1bc8/SIA4N+5wE845YDigLqChjAfOoiRF5KQ4xfUA3Ryta1dYWMbRvGWEIdVRM40ooXqhYc75evzLmzz8TDUZfTKW3vC+CFuxVw9ay+kvkc01Zld+PpZmkIBP4OGain99pPU2F+iIhIq6gFw4ohQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 15:34:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 15:34:04 +0000
Date: Thu, 4 Dec 2025 17:34:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 5/9] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20251204153401.tinrt57ifjthw55r@skbuf>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-6-vladimir.oltean@nxp.com>
 <20251124200121.5b82f09e@kernel.org>
 <aS1T5i3pCHsNVql6@vaman>
 <69ac21ea-eed2-449a-b231-c43e3cd0bdc0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ac21ea-eed2-449a-b231-c43e3cd0bdc0@kernel.org>
X-ClientProxiedBy: VI1P194CA0044.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::33) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a713417-1a60-4e8e-1988-08de334a8ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G6T8rqE4u/ToDyfuhTnfDnHys60QnRcxAj1KtKKQjTaN74722oIXoyxRWqtr?=
 =?us-ascii?Q?/gEHy5O1NkM33pTNzJFHfcrEhQ38yvQz8fubtVtxobLIsNfWSJUJyy7fk5az?=
 =?us-ascii?Q?pj+6bBsDYZi1NHstBoEHe4MMnz0J9146cLAxtMRwm56vkZWKPhH7K+KKK+Gx?=
 =?us-ascii?Q?QZTxpVhxMcdS9Sd9BpYIDTGqyWR4ka4cark5T39HqQmAaUl5pnpEDIqbCMsx?=
 =?us-ascii?Q?sw0gSGbkckNaLU5WvNnt2bGgpmGwKEFKiIveyi8z1DjZB+YrMm2whld0xxPO?=
 =?us-ascii?Q?/qLMl6V4pqZNmheNRm9VQbnTcaEtcK528fRR8RL8jGij1TIsovB2r1JQ76o9?=
 =?us-ascii?Q?RsFCtfx5YHaQKvVRlLw34maCrtlYOjtoXDGqHJly2vtkkuz86KI/V1fsWZJk?=
 =?us-ascii?Q?/33n7mNGkro35Gck+Bk5umnzlAu6uQVzG9leKNNn1ex2CsBtp361hy0eV0hb?=
 =?us-ascii?Q?x7H/0ZeI2BdTlu9yFZUgThcBEK1o4p/CuSxM2n9q4s2y/d+mLqM+qmoQpMI0?=
 =?us-ascii?Q?cQ9UazAzzWM08zIsOxgy7M6LagnY+GsxH8R2JFS72oAW5xlLmTtAYeqXir5+?=
 =?us-ascii?Q?vrKi73P7Jn/KdpIdxV8yW3su+2AVQTfBsduxZJiVD/Bpzz5itFguL9Mac+HB?=
 =?us-ascii?Q?wccVGudb9T4Ei6awUxLujQPgk8LJTd+lwpK2xEFYTa4yFYINcAPyurYWBAvQ?=
 =?us-ascii?Q?ZMoFpSZCHTRXuCHsGaetHKmyMX6f3tzc9D838hpeVXSFzu9ofeoh0zcSIg1W?=
 =?us-ascii?Q?vp4NTaB/TCdF9YwuhHdj+Yj97r0OrNcsGSErRzAZSSEJMZil+EB9PK3sZuTc?=
 =?us-ascii?Q?5yMnPZ3kiEkDhKXkH3YGnBrAUC9tK//Q5nDdIn7k2VnOvIq+9szBBytzpGh1?=
 =?us-ascii?Q?uMzenauxwZlJIohErxVanWdjWf3qePMqqQ18llXdoelmDIcHXB3MuElvjaGJ?=
 =?us-ascii?Q?SjpOJapScI8zeGGyePc+cgcXI7vnHeygT1oAY8Bb8Nz/OV1pumt2I6ZLW9sI?=
 =?us-ascii?Q?0aQp9md7z1ElsG40iz80Nk1A8UeIdyizI7muzKcTbZm8AkTgQNdTbHgeUv38?=
 =?us-ascii?Q?G1PEjMIUxe2hkmw98kEh72yu8/t67KRotWovElcsY5zx/CHVqIJaXcU1COmS?=
 =?us-ascii?Q?14Df8Umd+yUiESPUfITORMSVdWW/HhgtCFjcqc2H9Jl77L8wRrHfJNXXmb+S?=
 =?us-ascii?Q?+Vp2uT85dArOmEdPq/iqpvwHEFzvLQv9tQXEwxIaOaCAWs6ocif4dMZ+fxPX?=
 =?us-ascii?Q?2D/1svVMxux90l3NFvCA+ftt3FiV4JoD8Lpi7zhPDB0RbQhrBmlkJl5/30FD?=
 =?us-ascii?Q?xPGRtTGwU0kXXKAjWELXxdDa0NpQBs5LIIGsgF4XBOWE5T/fCrFcyvR55JRO?=
 =?us-ascii?Q?18fCeKj56kN4MCLoOkUZ0t9hXP9Eo7uln0ejZHIOo3eK4eCNKOX6y01ZsB55?=
 =?us-ascii?Q?HIRlyvbylOt+zap4sP6pW2/kPgRRMG6C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zP8ba20l5sjbEMjqKsg/myIGg8CiFcvSivqbtOKxTTF2u5ZSwllwvRSNGmPE?=
 =?us-ascii?Q?nB32btiO4S5lm30jhJwyPF1nAlVQxUuYlms1E50mTSbHwx7ngV0hZZ2x1CNE?=
 =?us-ascii?Q?r9urQvXygTURK+fnqlqtYg3ugE/qMZdLZWXEDaepV3z8Q739Q84/7sItuQAZ?=
 =?us-ascii?Q?3tTcxuHc7j6xU9anovZQu2rEWN+akR4Ayk48LaSt8bAHqvnoiEMpwBmXzcpJ?=
 =?us-ascii?Q?j2YiV2x8EiOf4Ry6bU977IPuxVqHB4dyIVIQNcOZNW96sF+39uK8kSFfBgKz?=
 =?us-ascii?Q?dUmo6ql8WnCYqmmSCT1Miw2SLs4ZpuBMlzwxBY5ynL41j9SCjwgtbVkpjFcL?=
 =?us-ascii?Q?n0v6qy3FG2tmCbyzAyPAeiuEeIteUeeky/wwxey2Mhx+bxLSySlb2mbetchU?=
 =?us-ascii?Q?WD7za4umVfoODhii3ko5elMzvqqm/dLNyBU5qSqVcO4r/ORooudJxyRLtxLU?=
 =?us-ascii?Q?0VRqXSDmSNmShBHmQc8o25MKRiVoc2MC1hmdzLtwXfTW6iGhWBNMGrHwJmLn?=
 =?us-ascii?Q?hLDSBw3lpQv0pE10xqwobP21i2RXcj44db30Ez0b+gE6TeJ/KEtjwcZm7e9o?=
 =?us-ascii?Q?RyzHS8eAGM+SIJSGadRA7ey3MbZsudsg7DOvwhi3OBolmycyiCtfJe1YAsYx?=
 =?us-ascii?Q?rpLQFN8acy3MYZ2tdbeMMfFDUmxcuj6ZAhJTxiwK6UUM0tOIPVhl+aqDFhkW?=
 =?us-ascii?Q?nllcPR7+wqCpASyO3+onHw3Cq9Z6c8v5tnx+ECvtzifxczGS/IwO2bFC6iU8?=
 =?us-ascii?Q?FGwNi94PjJuoozFCc6m+oeNGABKTg2MmuENd2cOey1cOhejWZDpUUyNgBbgr?=
 =?us-ascii?Q?kstgiyPk6Nveb79h1l4IA9kMHxSB8d2spQzXWSwfhChcW+AFUy6a2yNKhZ7l?=
 =?us-ascii?Q?SeVfqv3atUfzbjfZNhQ6n6/7BIuUo457ymrMUiqM/vZTlSp8IZz0gfHzv/Ax?=
 =?us-ascii?Q?wimQoSQ7n6UCpuL6a7/i5SSqx4E30eeDe13KhenmORz+W8CAlga94g6eNJoH?=
 =?us-ascii?Q?Ma8EZ5S9T/70F6d+dtFnkDtxGxE8NsSpicZpzFNk/rn0f2VwvIETIXrn2dUA?=
 =?us-ascii?Q?adN9GX6YSfZrQB9QrjJV00oxX77GfyROMgIsGsJb3ONdzyrNn20cBRJyO2yL?=
 =?us-ascii?Q?osOsIxKOPLSuqhR842DJEBrHMoMbWf2VvmQha0KOELq14LRG7PDmO4k0f3jy?=
 =?us-ascii?Q?iBEC8hZsMLp5kLKl8nJGq2XlATRlhypDVVxtx89Vm9/IywKMMf/AsQFSVhfA?=
 =?us-ascii?Q?+QNgf3veKwndy+WOQyVlaDk5JqOT5yMTqxCxcszhOcrU695Fk84bw4knSQ3i?=
 =?us-ascii?Q?dS6/VlzTtUMfbRAi/SCl8wV62EMrj0Qq6qCwn9ZGTa/zczbEWEutx9JLnQsf?=
 =?us-ascii?Q?kh2RPH0eWDioirxw/r3pI0sIY7klHvN1GTiiYoX7TuTQh15TxVGQnLY8E21I?=
 =?us-ascii?Q?dZOiVA4AQ+fWUOM5hlMr6qrZXaaG2+Fcx0af6NvQrcnvUprYD3R8ceN/O+PV?=
 =?us-ascii?Q?cH46gScymi9AYgCjJlfCEIhNHntZ9URQwtSQ5/R46U9MZ1b79eRi5RxTJbbk?=
 =?us-ascii?Q?EkUGpEhye+D7jRWEsjimugA5b7SYE2PkOaFavyWg9uNhTsLHEt3uqP7zwN20?=
 =?us-ascii?Q?oVIjFpwQqHA73BG3dUVcFaVrgtUuFKFzm1JL3SIa6V34gCe/u6K46nRuGkXI?=
 =?us-ascii?Q?mvzRfg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a713417-1a60-4e8e-1988-08de334a8ea5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:34:04.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhRQ/+D3EWu8bycKJ7qvp97ICaKSvLmjAN+9rCFEEwjkpsm90OndCWT+qszLMOLBZJc4E7Nc+4eFJEKfBOjeyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

On Mon, Dec 01, 2025 at 09:41:21AM +0100, Krzysztof Kozlowski wrote:
> On 01/12/2025 09:37, Vinod Koul wrote:
> > On 24-11-25, 20:01, Jakub Kicinski wrote:
> >> On Sat, 22 Nov 2025 21:33:37 +0200 Vladimir Oltean wrote:
> >>> Add helpers in the generic PHY folder which can be used using 'select
> >>> GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
> >>> enable GENERIC_PHY.
> >>>
> >>> These helpers need to deal with the slight messiness of the fact that
> >>> the polarity properties are arrays per protocol, and with the fact that
> >>> there is no default value mandated by the standard properties, all
> >>> default values depend on driver and protocol (PHY_POL_NORMAL may be a
> >>> good default for SGMII, whereas PHY_POL_AUTO may be a good default for
> >>> PCIe).
> >>>
> >>> Push the supported mask of polarities to these helpers, to simplify
> >>> drivers such that they don't need to validate what's in the device tree
> >>> (or other firmware description).
> >>>
> >>> The proposed maintainership model is joint custody between netdev and
> >>> linux-phy, because of the fact that these properties can be applied to
> >>> Ethernet PCS blocks just as well as Generic PHY devices. I've added as
> >>> maintainers those from "ETHERNET PHY LIBRARY", "NETWORKING DRIVERS" and
> >>> "GENERIC PHY FRAMEWORK".
> >>
> >> I dunno.. ain't no such thing as "joint custody" maintainership.
> >> We have to pick one tree. Given the set of Ms here, I suspect 
> >> the best course of action may be to bubble this up to its own tree.
> >> Ask Konstantin for a tree in k.org, then you can "co-post" the patches
> >> for review + PR link in the cover letter (e.g. how Tony from Intel
> >> submits their patches). This way not networking and PHY can pull
> >> the shared changes with stable commit IDs.
> > 
> > How much is the volume of the changes that we are talking about, we can
> > always ack and pull into each other trees..?
> 
> That's just one C file, isn't it? Having dedicated tree for one file
> feels like huge overhead.

I have to admit, no matter how we define what pertains to this presumed
new git tree, the fact is that the volume of patches will be quite low.

Since the API provider always sits in drivers/phy/ in every case that I
can think about, technically all situations can be resolved by linux-phy
providing these stable PR branches to netdev. In turn, to netdev it
makes no difference whether the branches are coming from linux-phy or a
third git tree. Whereas to linux-phy, things would even maybe a bit
simpler, due to already having the patches vs needing to pull them from
the 3rd tree.

From my perspective, if I'm perfectly honest, the idea was attractive
because of the phenomenal difference in turnaround times between netdev
and linux-phy review&merge processes (very fast in netdev, very slow and
patchy in linux-phy). If there's a set like this, where all API consumers
are in netdev for now but the API itself is in linux-phy, you'd have to
introduce 1000 NOP cycles just to wait for the PR branch.

In that sense, having more people into the mix would help just because
there's more people (i.e. fewer points of failure), even though overall
there's more overhead.

IDK, these are my 2 cents, I can resubmit this set in 2 weeks with the
maintainership of the PHY common properties exclusive to linux-phy.

