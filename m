Return-Path: <netdev+bounces-246689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E4CF05EF
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726743056A73
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59502BE647;
	Sat,  3 Jan 2026 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TEonJbZ5"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4392BE64C;
	Sat,  3 Jan 2026 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474317; cv=fail; b=MvzzoulshR1U094YyAdHDCYlvNENYZq6L2gRk3OCGo4Xg1hi0pgoUClLlHphfsIivIebLoCtBTp7dlDm/6t/W1JprWz2sWy15J+sTnTU+M/H4SyE+Wo7eLgsY2elV8vexQybr0c+yjPwZD+68Yc7ITmsIBqWojhxbV43Ksxyw90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474317; c=relaxed/simple;
	bh=R1lXWFvVpdmqo5LvWDpBJ+03CJnavZnjVqUI34iTTwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbu0ozKugJP0ppXBbrxY9DQjyMrg8n1+Ew7NifpQ77sXhTZvDPiOE6HfxqlqfWvoK+FA4/HXEZz2nnxrNFuclctBbnHHzge8NIrL6FWCvr+6+FbRRjxZuREO/D4VgQbg+XD9KiQ568AvsO8a7rDhk/JHs5LXL3TeaZtzNBMBpCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TEonJbZ5; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZtN1uwsz+Fk/Qjv+rOnAEfl6tF9APQnOs1mpSDuW26243WJOL3XDoFtbGJuvhmtpP7C1BRp/FUQNqSjOx7e4yLss0ddJ4jHm4fhDiwYoRh45/Yvz9xifKlKa6ahB78/jCFTumGdxlZm455x5Su3Xw9eUVbQ4F6HVZwmkDdze7enty9TuBOmX6ExKiLc7jWZZgf+xDvDX54f6ftw89SQcXdhNPEB2PCfsgi+6i2Yd0El1jhDdylzhgdJmDuIjFhaPm2P+TrFyi6mWxH/ComHTnhgpE7UBllPG15eXHvIJxS+iTtNt3XmRC26I0kIJ9TyzxprLFsDqL27deyMicdoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu829agQaPnN8LyVXsYvEE6pTuOhpJjo1wvtjJyhOKk=;
 b=IV4gI8FDRHfzFu+UZ9EI44LUFMmnPspHHG5fsECUpqa8BZuP2r+1q6TeiHwqsZxlvYEpKi5iIDuO90SbuMiek6CFiMR28KDk5q9aCBm1D/mONvFObVVCvE0/pBxO0kDVHvZOlMdtBNVCHQwZqL3lBUdpH+5+asCAqhNA7+MRtYzdfGI3YwfNCjYauQZcyZsVPB7CxdKOyxvsfP6zYmhFHkQDISEQUxVfDV/EGmrqZb+9Pkjcg95XTVAsE6M4d32gmNGRFUwywh17d7NybKFiQj4xrSmUHs0U2H0zUNAqI4CZTxTgNmCs3k3kOkOEDA4HwZCbrjIPMwNEmaGoyZ9TGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu829agQaPnN8LyVXsYvEE6pTuOhpJjo1wvtjJyhOKk=;
 b=TEonJbZ5Ofkz4WdF0Dlh/bO7G6IAg+2NuYSBY0MwoSfcsm7CzNAQTf65tVKq634mruUg7Lj4tO4/FTdhGE5zGl5JeG7KmO71/CZGiJtZUVfneewkxOvpICEsExTiIOsglpd/BKwQ3c0zsR87zLZCEthGECx7NYYcTI7X7u3hZIHp3GujU8R1aVjIbc2aQiOkDMRpm+NMH3+mMWcmfm4Ec/rfv+BivqGQyKwRa9pHLPOXxgpJZkP68Ehud7Z0rxq5KEqJBMFGOnRhrml35PTDmiNQJO4IaTEsw/EUAK+mt6Jb/ZfV0y64adX12kFP7rO8hBvlaaZjHrDYNuB3EzK2uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:05:10 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:05:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 net-next 07/10] net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
Date: Sat,  3 Jan 2026 23:04:00 +0200
Message-Id: <20260103210403.438687-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103210403.438687-1-vladimir.oltean@nxp.com>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 718f0f3b-b4fa-48e3-4851-08de4b0bc76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dGZTRi6E2hjFBLjiYTUECvHNDfVuf1QbKeUEOgbxs+IHIXWg2Odr/oz1kwd0?=
 =?us-ascii?Q?mYIDQv2gLJ1W3rndlPUhBH7cmEY4IErodiWuV+979guT1EXXS7yVZAVplB9j?=
 =?us-ascii?Q?dBGsmiqA88t4twqL3R4O7kr9bzQFhX6JcwxxsdNqGD5Dldyl8KANw4WmEYuU?=
 =?us-ascii?Q?maJJBUFLusEe2Z/krRMov765QqVtqiHWuGqtIBaA4FR3U93f/6T9xAMeHbNb?=
 =?us-ascii?Q?DGB19Yvt5h8/MHfDrE3cy0P4luUNXrvpz+g0xaNTepZFNIRdhhwCTxnsGwVW?=
 =?us-ascii?Q?Nbw4HogEh3kyYiyUEOMn95ltq35pJGmncML6dV6CobwyaPB0llvO9JRywPDH?=
 =?us-ascii?Q?3Loq5O+KmnEIvIARYGL3JkcYoIBXG4KuJRJfHdlCCgv3HJmLX/2sj9okYa5t?=
 =?us-ascii?Q?mDpzu/P1og636aEAgKY+9DR3RzbsVQYJ9IculH9Ygxt8ka0tM2XMGi1PjPH8?=
 =?us-ascii?Q?rwVaOM5c/whZrXY8yGpalvHsSg8sr+zQgIyVoA4SIUGavRwKkbjfltJHRngA?=
 =?us-ascii?Q?1C5DIcUBPb5upizrgLGk1G+UiU+aTcp4vEA46buFUQCqvRany7e26e8fwRN0?=
 =?us-ascii?Q?deyOv+CDvoRTNpNhU7OuPP1EZelh1vMJkuYdAPO2izqsFmR0TmXKJff7d8n6?=
 =?us-ascii?Q?F6pLVUOW5OaqXqdZAe4MicpHuwVOW+MfaC1ufV2yCeqKFrNmLXvAj7SOQLOy?=
 =?us-ascii?Q?2UsQYZAbSE6aJYe9OxJ07Bu7Xsz2OcKqzeZMDZMggnXkIaAzvjbTmJkyKD72?=
 =?us-ascii?Q?1h+nzVHrrKIO307IZvrzz7Duy63S945P0gUddsGxmho2zqYsqS8wCh4NvbZe?=
 =?us-ascii?Q?KBaPr3etWkXl5iEVrkf8yEfVnoIjkdG4MSJsu+b12qLRZnEwwWt4077Z/8Dv?=
 =?us-ascii?Q?9csPMefXTYUCA5rFNZxfPnEY6D9sTWf8ZOem/aY5ghPppH+p1rsV1KqZCROt?=
 =?us-ascii?Q?ThDjOpbT12eWsxVffAmCM3QOu2ZhhWLwyr0la+R3O0QjKPIQ+4uZpmBVwz6J?=
 =?us-ascii?Q?bbnux/FCZIMVi1W3E1VY2IY4aMAS5QGUVbWluoeojM7KWeGYt6eVWkkCX7sl?=
 =?us-ascii?Q?F/pAQPXqvry/+z/Y40fjbPDf7gtVGULE30UbOZfrck965tAi7nIhcocDT5Bl?=
 =?us-ascii?Q?unoodnJ3vWtSAH+PTeu/GyKLb+ykZcJgSyDhxoRK9zN/g2GpbMI3dW2U13ND?=
 =?us-ascii?Q?zxb5SmX68kPcIsV8AVTZX8TDKdZNhes2+mwOc3Krb0Jes5ivwPAAw5NGyaTX?=
 =?us-ascii?Q?EvaiKBpc7dZSWSdJma+498FzkQsPGY0/YHj6ZipAkd6H8ETSZ1ZB8Pssko5K?=
 =?us-ascii?Q?HjzMmPJY2GdvVngbhMqvuRhKWhadrtNB5Fgqzno6UTfuILOG68j6KWz/KFm4?=
 =?us-ascii?Q?77g5ojZMPqQ6bO2YofZUg9shwZEizRvMV35geW2ImQUhad4hzFLyPbzRlFlg?=
 =?us-ascii?Q?MlaYKaPJ4UEuq33enkSVmNmWiV1Wy6jA8dh8NzRqIPN1LSY+zz7gSRLqfFS/?=
 =?us-ascii?Q?dyUWWzUTBRnnxEU2mQ7aBA6VtwN7LHLJDv3t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2OW2VP8s21HKob0hSSsrDxbcMSEnLbaGcvi21AAIfTpguQpgMYrWxHwM6vP?=
 =?us-ascii?Q?cH2r9n3D0ibRWFdiQhieEtoKgJclI907crG60SZJcSKg3NGu+AmGQEM77hKn?=
 =?us-ascii?Q?gCAPClBqI9hdoiUpIY/WheTv+XAEH2L5ZC6zrDaxZy1CHVVZZWtMCAa+Lkfo?=
 =?us-ascii?Q?3dZcPLj28HNi4ZuHPtvoV36jAbYFezg78935CnJm443FeRQB4LzanDw8O0ja?=
 =?us-ascii?Q?fesy8kvlxyqcxnM1EN8dzadY8IOk2yhFDMXmdWVuZJhBhmum4lreF+Kw3HLB?=
 =?us-ascii?Q?WYeNLQDfy6ShgLswdHd7LvB64g5oefUsSMxEGyoyFnHNFvUQGJ82WaLw9dM4?=
 =?us-ascii?Q?QkO3H9NIvBZWCfclrTL4Khl+mN9652Q0ci9t6aFP8zlGum3yeQDGSmkUMA8H?=
 =?us-ascii?Q?mVBwPtbJJs8/VBr2rYSmDMaJW+zomzwg3ieFHYkvoubsBbsscgY3tVt1wOQw?=
 =?us-ascii?Q?y2WAVSWBugsripzsJYOC2AlaRRHUZ5Ib7wpe5xy5rzhs2Mz0xWoojRTeTcfw?=
 =?us-ascii?Q?BFlOUqu6JQ28ypZYMDh7JkhEzx2xDpYitHBTj51PSFdTLlyPT6bkf7JYo9Ol?=
 =?us-ascii?Q?FPY5oV3q+wsn+79vhLllNt+enRMxWbV7pTmg15sV6bxdqLe2WcI/s4pLHV1M?=
 =?us-ascii?Q?QGTh0tME+F06DUjdY5gKVwaqdVOrBDAwTdvxP5vAi8vO4OalCzH7gE1HZXQa?=
 =?us-ascii?Q?gMv/otCFBbevJDWlT2NBmYNUl9ev9S6Az4TIbppm0sOYc6O3jhpGfgh4RrTi?=
 =?us-ascii?Q?TfgEYLxyCEWNUH5BdsdFT0VvZeh3Hx0AQMMYx6ACtZy1h+uOvqGHNTOCydra?=
 =?us-ascii?Q?U3jSjoDshm6v0vZtTzFj3tZPA5gi0GY4QKqSymtztSi1QvBWDzCssIhwPUi5?=
 =?us-ascii?Q?rD63M66FoX4sqonNdivYf0sqr2YEtzK0wYJYfAeMkfVbSb4DrBrluTQ/HnHG?=
 =?us-ascii?Q?VCSdIy3ylIH9eiU3c9LKyPR7jRcV6QcpWuQaHe52JbFh9eSe2KCHNY2YuDCO?=
 =?us-ascii?Q?VFoigtJ12zn7tQmbiBYU2IvJ8B5pI2E+YrA/anVkyhqSSpQ17CgIYuiPJNyF?=
 =?us-ascii?Q?GAeoUnK7GOefzmVKzIG0qv7hMSZO49zUuDgsESg7B3DjUdee7V3sHmESlfuc?=
 =?us-ascii?Q?20CrR7+tsJs4yVL9qk++RGjFEERfbYPNRyVpZAXS3K5h8opTVBialq6Ykupj?=
 =?us-ascii?Q?rkGAA7vom1bT4auszFSYhX/Pd4d3WiQjfNBYCsIQmpcXfgfDGNfM/guSM/JM?=
 =?us-ascii?Q?viScYIPM1Cd8iKkOrmum4T7IdOlIV8xSwx3z9ZJ6vtLmENohroO8/2PiQvqX?=
 =?us-ascii?Q?IvtAEvF8u3nOAzy8p4/7VhBuZ31GlmVWCg4AQT+9Msp2gjEZ2rXi54fJDXdE?=
 =?us-ascii?Q?hVHrAUhcoDZBUswwTpte/PDV1meu9v27H+s102xbcivguvNeWC750jCmLIhs?=
 =?us-ascii?Q?/1w5yvXTE1Xrh7ifvLtyUcKFTdw6dusGpr2n57x6CmlJSEIM1RGLNKPOKj+q?=
 =?us-ascii?Q?Q6AZK5gj2ZSxJyQxJUcr1My1d+FewMo/NBne/s/jXOsMKBACz1K5fCinq8Qc?=
 =?us-ascii?Q?zJ7yGg39jFTNEapxSXM0bq7GmbL9qVsFo2mVs6+jaSgoQKV6fTSsqAuUsh3x?=
 =?us-ascii?Q?nbtYet/kwq/bHjS/Ca0LtmfjYY95Gpjr7LSNDpX4XyFQi5em7pz+td2WfysY?=
 =?us-ascii?Q?WwDfXRV6mzhGEDDnB5vgn1Om7MNw8DhYkO0t+sraXyL0LPckIKZi+azrpspI?=
 =?us-ascii?Q?1W+NHqkxXQvH4/iogFDVQKeyw5s1dXw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718f0f3b-b4fa-48e3-4851-08de4b0bc76d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:05:10.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx2vdJ1vKWeHO1NMFfmKDDk5dZyH3g7mLZMFjrN4IVqokUdv881E7Qz1FYGIc1hKOByvmH59sRAxY8vtY+J8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Prefer the new "rx-polarity" and "tx-polarity" properties, and use the
vendor specific ones as fallback if the standard description doesn't
exist.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- adapt to API change: error code and returned value have been split
- bug fix: supported mask of polarities should be BIT(PHY_POL_NORMAL) |
  BIT(PHY_POL_INVERT) rather than PHY_POL_NORMAL | PHY_POL_INVERT.

 drivers/net/phy/Kconfig       |  1 +
 drivers/net/phy/air_en8811h.c | 53 +++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a7ade7b95a2e..7b73332a13d9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -98,6 +98,7 @@ config AS21XXX_PHY
 
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
+	select PHY_COMMON_PROPS
 	help
 	  Currently supports the Airoha EN8811H PHY.
 
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index badd65f0ccee..e890bb2c0aa8 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/phy.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/firmware.h>
 #include <linux/property.h>
 #include <linux/wordpart.h>
@@ -966,11 +967,45 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int en8811h_config_serdes_polarity(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	unsigned int pol, default_pol;
+	u32 pbus_value = 0;
+	int ret;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_tx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_NORMAL)
+		pbus_value |= EN8811H_POLARITY_TX_NORMAL;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+				       EN8811H_POLARITY_RX_REVERSE |
+				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
+}
+
 static int en8811h_config_init(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
-	u32 pbus_value;
 	int ret;
 
 	/* If restart happened in .probe(), no need to restart now */
@@ -1003,19 +1038,7 @@ static int en8811h_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* Serdes polarity */
-	pbus_value = 0;
-	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
-		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
-	else
-		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
-	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
-		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
-	else
-		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
-				      EN8811H_POLARITY_RX_REVERSE |
-				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	ret = en8811h_config_serdes_polarity(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1


