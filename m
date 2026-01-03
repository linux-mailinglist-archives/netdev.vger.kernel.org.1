Return-Path: <netdev+bounces-246687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4017CF05E6
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 040EB30487E2
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070132BE642;
	Sat,  3 Jan 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kwB1yhAD"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB62BE641;
	Sat,  3 Jan 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474311; cv=fail; b=T+ejaOBBekumhDiirkAmzJH0nveCaY0xZV4rVe4j4I/Vh98GVf9elTTrcPkiRd/TYOct465yK4JYLFODhWt+5qslxJqyPE44DrQDznllzXGdkrVENuu8pn8bUFPPH4TWjamrakWr17dA+aoRXlD0MkrLhisdxRIKStYdoM4dvJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474311; c=relaxed/simple;
	bh=Vw8i3Lo54xWCFsYYsuNyGVJE2dsg504CYuBeTTBJti0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxOFgBt5zkxc94qkooQZx3RZ0C+fm4idVTxi/zRm2eK2rOyTLFvYWFKoprq3/Ie+5a/qFNFjhyNL/EQ3jGe91xnSw8uFb18cDK/5EXGV1q1QOYFrc1yFCAKGnCox4Cg/KSA7XXWarsZgDv8wvrz3lfsap5GjX0t50sih0phl3/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kwB1yhAD; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poWfc2ZfJzIlsDK4zq1vvgxQKANiXAcUCRVCBBgifh04MPeQnk8+/Uv4MIQJKv6mBOtpKZOelLPOINyAl02XOYckFIIWiVaCTVG5OigLAFwSR93qdbC5NjhVUpi05T/z3xVcxL7FJ3rnA4oVdrLt2su3nSgaLzkqnnbsxP3IvY02ihrIMJOMMjYsmcTvFS5NOuQw4dPOB0O+JOFev8SSZTC/DRfTuT8aGmonFHqkwA2T4dn7u60I0v4Vw+UR0+pHYscy10eJcY5xB/QrZUspaTPvR6lZmiAm2dnP1T3BXQwJkny2jhjQOcH/KTIWQ206RW7FNksOAger+CP3F1Hcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO4pLOQUtDnt9X38blVvGkPDCp/0C2CzQLQrJXApMAs=;
 b=UIOHc+64iXOlvb8nCuu0qGThFhDeO9snYX2Vsv+1Ul2uen/b+4adaXQoaZqZvgo3Lr0kkifu7pbEFmlOsszhJOV+1W+toVaeseKyzjkZETQxH1PjcmCQkZMTVISwMY4t1jBwP9XNbQO/tLVIf+8fAjw33b1BQEs/ngOJFf46YAe01UWlZV8bmR4GwdJs446boNHMebuGh8uaNXuqe8/+cBfQZfEhaQf3SMZ289+vkkTVGwDiCa8IntFgfZyFJBTggjDlgEzg8ph3d6eUcUetogBCOInBZ39Ju6bSfBk4VbOo6sIJPsqlGT3d3qFvpmRFzCc7puAjNJDJI5AqsgsHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO4pLOQUtDnt9X38blVvGkPDCp/0C2CzQLQrJXApMAs=;
 b=kwB1yhADbqXpxURwmR0qcplCTkxAhv4pURMR/ID3hczcrS3PrXXrQxKNkXcQiF7x1/6StITOWH03ftOClC+VnH5I8qay0FC07R/AEpnpfbI6zhOcAPwFvW5zBTojKWfF7tlRJtJxeoQfL5t69lPbUDLWqnOfCSuYezjHkWb6me0AwPdTDYyNcxqmi4ZnNeuYhaJjIUnWwpAmpmmrbERKG0BCoozFGFwi2sXHicsLcp8di+vYcu3ddD7/UOPdnwoFcIsDe8sCqdE9yodZX8sm8MbhonvSQ8Wd/X46TLSf1j4HyKaCQ02IUrVaNKS8T/2a3Vxkf8EK0L4Kd+bbYazo9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:05:04 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:05:04 +0000
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
Subject: [PATCH v2 net-next 05/10] phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
Date: Sat,  3 Jan 2026 23:03:58 +0200
Message-Id: <20260103210403.438687-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1937f309-8241-42ec-2242-08de4b0bc3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8fXbFnw47XXIaLqZ+BMbpNQ2OIcA8kGMi0eKcW9jnB3qyHQgMz0HjRTFawGv?=
 =?us-ascii?Q?l8E0JC6wFoIeyMRAUrqybBZTMhOPbzUcRK/e4yR3aBZy1FpXAS8b89gE5Pvb?=
 =?us-ascii?Q?qau1Q6/SKWX2BViRYscAykkk05Cdc+7PxdF0HAbnQgTuejO7bCeXWpONjeA9?=
 =?us-ascii?Q?8kEjPrHx2BHnFBKhmPPeUBg515WDqcy/gj3nr70A+3eUJvd9ZnXITRh5cCoe?=
 =?us-ascii?Q?XqBENDUOZ7aTdOn4oEHZIWAVBz8jzgbxK+7wzYf7F978BkZW6U+DNfwJUoqO?=
 =?us-ascii?Q?DtAswUGGmDD1hlsTDcFnGzP5urbQLkU3+YT+yU9yZtt5lHLmJjoVdfpui49+?=
 =?us-ascii?Q?5Xynt3urJB69C+GrU2LyelQ1T5zuTFCVMWY/cN33x422hN6nHof6OKmh8MS5?=
 =?us-ascii?Q?NqPm0PGxM/v8ar0ApqWM9hZUdKmkR0/C2gDHaWUbbrZkqJ3ISIQq33rhmNJx?=
 =?us-ascii?Q?w8H/KBBzR6fQPxPtFd7xQeSWShVuMaXGXJmmXbS945M0NnmDkyyMjclrpl9Y?=
 =?us-ascii?Q?PTJXp9+0Ct5znRKEWEwb6p8LIFMVA78beIdL2Xn5ullTGyfEfSyiRKGMxzCG?=
 =?us-ascii?Q?kgFi84Gf3RNt4tUSKixo+OoKuKSJeOz/f68xhuiH2CDCAF3TLh5aF9tkn2vY?=
 =?us-ascii?Q?CAcxU17JzYqHkZ3+lLJbCiiXiCE7yQBc+fIQ/3H5wZ02U1lB1IHGDTeEEKS7?=
 =?us-ascii?Q?icN1Kd+cS38swN+dfVIMclvshzDOAP4ZimJNhJy9ahbIE2Wc2lNy1Oy9Vtul?=
 =?us-ascii?Q?njRj1TNdhGFhDio7NfeyLtZVwr37MXtXzxx2NqLKIe3d6IdUuc11ga54WkH6?=
 =?us-ascii?Q?cMZqf9f35TIGH7alZ7SAg8kYuhOOZ5VszmV/SLMJolYPjZzvTu58FrJDqosL?=
 =?us-ascii?Q?nC3EI4H/Voxpd00HJB+2Ph+ZpJ+rw97fHMwVVD1N8mDlRDFNAxrPJTcien/Z?=
 =?us-ascii?Q?y4eEqZM/gk0qB7ACxRHL/y2GYTV6wl/pSACobWRdrumhxd9C5MIcckYhEpT2?=
 =?us-ascii?Q?4Y60JE36hgdddrSR7Rzt0F6JF1TYdm3N59qvcuGbrZb+qR6XhXP6FseEiCkn?=
 =?us-ascii?Q?64sExSlBiqI2QsMwxhdNAiUiXoJCB5oJPqiTr6zsZquWhCrmUmiNaJfA4ru0?=
 =?us-ascii?Q?VCqyQjtEoNDx2enjpuBh5u912EW+2WxH5uXm/LqNhIxy05S48M2DyIJG4R3v?=
 =?us-ascii?Q?J7aNiHAaWkhTrYOkc00HHGGnYltmyuRiOm8bq8XawGRLNtLQlsuTO29CGxu4?=
 =?us-ascii?Q?ljDoT+7NZeuFn/BF7RzTU8HQT+25v+1l6Xy8fwbSGqB79M/UadvKlxR2bfDk?=
 =?us-ascii?Q?qtyrsUqYINrtuHeuSiBjttslaDq6VU1bzHYDw5DBnAkxGrZjSPyX9HkHxXZG?=
 =?us-ascii?Q?IZNDoZEMpglCEJdh4u+r0evWsH1L6+dJ1+ByDg8tDf2ga2jtxF7yKnnhXXZ5?=
 =?us-ascii?Q?wR1EnX5UI+Bt5jJIcZ0m15KXtWPCN+21qX4t7t6N4nc7T8K8XAqNJ+FiWQw0?=
 =?us-ascii?Q?cr7oBY70QLRgKouyTxpCxD4WbdgbJDB7Rlut?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Zo6G81zvfYAB0vj6agJ0PBD4Z6yZoDU2cJY5Hwq/x4vjDxSVifQHKX52EzT?=
 =?us-ascii?Q?HAS8HSZuDiKalrDnfgVkiw181yETLB3Y6l4xms5Dg+RDbE41WPh46YAqbCdy?=
 =?us-ascii?Q?OSWTQqpo+dvIf2r19K3D96/Q4kuQ6rE1IPIDnIDcY+SKmEwYVPI9LY0fRjwo?=
 =?us-ascii?Q?Cvl48Dafp9s/RKrfjhNeZiCiaAQSkiH8PHRGTGtUuVd8xJc7dU8WxjfJOBiI?=
 =?us-ascii?Q?Hy5vE3Dd/uPg7dQcK2KFAVp1JxucWiW2RElGHQEXL6Y5eTc9V7yJ7S92r1w2?=
 =?us-ascii?Q?pR0DGKel49vSj9INyZ02ERDZYwUXHgJooGw9YLwGxuUEPaQFDJk5Z/+YsHok?=
 =?us-ascii?Q?KCM9S4Srwa7re+oUDd1m681E9sqIekV6HYLeDOhC1VW3oNWnZ8ZbVqrTn/YR?=
 =?us-ascii?Q?JkJHbvSjz/tQFKZWlG/NDn1Iyk7sb2di6atktMkZzDq8GX3GTM6SqtuGH1HK?=
 =?us-ascii?Q?qIxqAh/lFjS72Z2UECMsbzHhfhC1ay0ssgutUtzx8mxxKM0Genn600xMd6wP?=
 =?us-ascii?Q?kyDWDDmZtbxClstVOwFi7inrcEei7Xid4Wy05WRIYJggy/30EJF9kswt4c7H?=
 =?us-ascii?Q?8RcS0f5co7gObwn/FMVsq8RXmBx2k2bXnpX6pvOx7PelJjGe6BhJpb3XEbtd?=
 =?us-ascii?Q?I2TjDh13kDrzedcTxK9JmC5M/OdCrw9rvzqP90eiRN5xsXinmKxB9lhe/dAR?=
 =?us-ascii?Q?voxQDsiUY42Hdu84bEnbvmMjvtuT/mpwEDcafaCYSCzxYpuHXTb6dXxi9L9K?=
 =?us-ascii?Q?7YFrhC1icfnp4pE9SX9yS/s+RZxh9DQVe0ktfgAXhvtHRbICOkK58uinX0T/?=
 =?us-ascii?Q?5jGVblDw29udJzm1qHtFu3O73nVI1LPXoQO1qaPe7YGdjhpkbbGpJOvXKRVV?=
 =?us-ascii?Q?Ch2yGXaPvHO2SB9u7X3gMNFeRlXaTkE5GjIuEQo5/juABwSvKs53lir9mO6I?=
 =?us-ascii?Q?Q8Z1vjosSsQZxPw+0iIjsASSoWz069VRXTgLYMP0hKDxzKcVkVfUAdUktdm3?=
 =?us-ascii?Q?BZOwzozv3w+lpp//EONu6wpubQ09qXkGebFraINpNJ973qVGI7QpLaEPjOie?=
 =?us-ascii?Q?wow89+AstiaJIczbEHftHxbWPFE2j9yjQFqvaqONdzr9+q67zfFmCMaUyXgJ?=
 =?us-ascii?Q?8Ey+hxreYlKZvgvh1Hg28P1/h2wPC3BNH1LS0hgeSFSg5qLnNHdlYgOWeoCl?=
 =?us-ascii?Q?cSAx38uzfKmpFVCVNPvRdYW6BJUxtf0og7p6/xmXiIbVaMN48mICE/QGd51C?=
 =?us-ascii?Q?ObC0GuMD/GEdVYeuFOb8q2GnILZ2YWoZv86ufny5UK0uXJjBGLRX3BMCp8Yj?=
 =?us-ascii?Q?f6fYMUWg/1E0iwpm8MnP4GWTu3yJ8Ja523FhEMgE5yziLuQQmF2u+7s16cPX?=
 =?us-ascii?Q?iIzqAUJIm1yEd6eMYfwbqayzexHuWhYlD9Otug9KGL+3zBfRHHQeD5Dlqhyv?=
 =?us-ascii?Q?iD4hPA57AgaGhkM5o70apl6NChrDdLAomVerqBIyqY9hVD5OGG0Vzprcvef5?=
 =?us-ascii?Q?TDep9vnjXW+QEB+vz3wbJXU/nUn5KQ0xaTxz2Z+KTKHQ7TCqaSA8N6shxza6?=
 =?us-ascii?Q?Cn/ZG1hWw+l6DFzujSLfeiOxgOJUevdLZPKms7+TvS67yk0ZcHkaT3Mard5t?=
 =?us-ascii?Q?ODLbLnlEy09cGOBST7vu1/uKUt9KPIrQJ35wwAtofawcv8zlmsMPkxXTgQ7k?=
 =?us-ascii?Q?nNeopiytMQ+rSQDC9EZHJBiv/ywHuK/7lXFdoAAMK2BwbjVqtp66Sf1Q5uFV?=
 =?us-ascii?Q?w+UllerF6mY0K2Umn76kSLuWdkdQ2zE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1937f309-8241-42ec-2242-08de4b0bc3a4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:05:04.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCfa+kue7zPA4aVhU4N0f3rPzETE16lA+DcqowKNGdRMerLYa6OORTqbeq1rRa0eQticLi5YHSGitQ+l2Rnr4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Add helpers in the generic PHY folder which can be used using 'select
GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
enable GENERIC_PHY.

These helpers need to deal with the slight messiness of the fact that
the polarity properties are arrays per protocol, and with the fact that
there is no default value mandated by the standard properties, all
default values depend on driver and protocol (PHY_POL_NORMAL may be a
good default for SGMII, whereas PHY_POL_AUTO may be a good default for
PCIe).

Push the supported mask of polarities to these helpers, to simplify
drivers such that they don't need to validate what's in the device tree
(or other firmware description).

Add a KUnit test suite to make sure that the API produces the expected
results. The fact that we use fwnode structures means we can validate
with software nodes, and as opposed to the device_property API, we can
bypass the need to have a device structure.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- add KUnit test suite
- replace joint maintainership model with linux-phy being the only tree.
- split the combined return code (if negative, error, if positive, valid
  return value) into a single "error or zero" return code and an
  unsigned int pointer argument to the returned polarity
- add __must_check to ensure that callers are forced to test for errors
- add a reusable fwnode_get_u32_prop_for_name() helper for further
  property parsing
- remove support for looking up polarity of a NULL PHY mode
- introduce phy_get_manual_rx_polarity() and
  phy_get_manual_tx_polarity() helpers to reduce boilerplate in simple
  drivers
- bug fix: a polarity defined as a single value rather than an array was
  not validated against the supported mask
- bug fix: the default polarity was not validated against the supported
  mask
- bug fix: wrong error message if the polarity value is unsupported

 MAINTAINERS                          |  10 +
 drivers/phy/Kconfig                  |  22 ++
 drivers/phy/Makefile                 |   2 +
 drivers/phy/phy-common-props-test.c  | 380 +++++++++++++++++++++++++++
 drivers/phy/phy-common-props.c       | 216 +++++++++++++++
 include/linux/phy/phy-common-props.h |  32 +++
 6 files changed, 662 insertions(+)
 create mode 100644 drivers/phy/phy-common-props-test.c
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..24965eec37c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10561,6 +10561,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 F:	include/asm-generic/
 F:	include/uapi/asm-generic/
 
+GENERIC PHY COMMON PROPERTIES
+M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/netdevbpf/list/
+F:	Documentation/devicetree/bindings/phy/phy-common-props.yaml
+F:	drivers/phy/phy-common-props-test.c
+F:	drivers/phy/phy-common-props.c
+F:	include/linux/phy/phy-common-props.h
+
 GENERIC PHY FRAMEWORK
 M:	Vinod Koul <vkoul@kernel.org>
 R:	Neil Armstrong <neil.armstrong@linaro.org>
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 678dd0452f0a..f082680e1262 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -16,6 +16,28 @@ config GENERIC_PHY
 	  phy users can obtain reference to the PHY. All the users of this
 	  framework should select this config.
 
+config GENERIC_PHY_COMMON_PROPS
+	bool
+	help
+	  Generic PHY common property parsing.
+
+	  Select this from consumer drivers to gain access to helpers for
+	  parsing properties from the
+	  Documentation/devicetree/bindings/phy/phy-common-props.yaml schema.
+
+config GENERIC_PHY_COMMON_PROPS_TEST
+	tristate "KUnit tests for generic PHY common props" if !KUNIT_ALL_TESTS
+	select GENERIC_PHY_COMMON_PROPS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the generic PHY common property API.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  When in doubt, say N.
+
 config GENERIC_PHY_MIPI_DPHY
 	bool
 	select GENERIC_PHY
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index bfb27fb5a494..4e8ac966064b 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,6 +4,8 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
+obj-$(CONFIG_GENERIC_PHY_COMMON_PROPS)	+= phy-common-props.o
+obj-$(CONFIG_GENERIC_PHY_COMMON_PROPS_TEST) += phy-common-props-test.o
 obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
 obj-$(CONFIG_PHY_CAN_TRANSCEIVER)	+= phy-can-transceiver.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
diff --git a/drivers/phy/phy-common-props-test.c b/drivers/phy/phy-common-props-test.c
new file mode 100644
index 000000000000..269353891add
--- /dev/null
+++ b/drivers/phy/phy-common-props-test.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-common-props-test.c  --  Unit tests for PHY common properties API
+ *
+ * Copyright 2025-2026 NXP
+ */
+#include <kunit/test.h>
+#include <linux/property.h>
+#include <linux/phy/phy-common-props.h>
+#include <dt-bindings/phy/phy.h>
+
+/* Test: rx-polarity has more values than rx-polarity-names */
+static void phy_test_rx_polarity_more_values_than_names(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_NORMAL };
+	static const char * const rx_pol_names[] = { "sgmii", "2500base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: rx-polarity has 1 value and rx-polarity-names does not exist */
+static void phy_test_rx_polarity_single_value_no_names(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_INVERT };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: rx-polarity-names has more values than rx-polarity */
+static void phy_test_rx_polarity_more_names_than_values(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const rx_pol_names[] = { "sgmii", "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: rx-polarity and rx-polarity-names have same length, find the name */
+static void phy_test_rx_polarity_find_by_name(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_AUTO };
+	static const char * const rx_pol_names[] = { "sgmii", "2500base-x", "usb-ss" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	ret = phy_get_manual_rx_polarity(node, "2500base-x", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	ret = phy_get_rx_polarity(node, "usb-ss", BIT(PHY_POL_AUTO),
+				  PHY_POL_AUTO, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_AUTO);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, no "default" - error */
+static void phy_test_rx_polarity_name_not_found_no_default(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const rx_pol_names[] = { "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, but "default" exists */
+static void phy_test_rx_polarity_name_not_found_with_default(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const rx_pol_names[] = { "2500base-x", "default" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: polarity found but value is unsupported */
+static void phy_test_rx_polarity_unsupported_value(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_AUTO };
+	static const char * const rx_pol_names[] = { "sgmii" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity has more values than tx-polarity-names */
+static void phy_test_tx_polarity_more_values_than_names(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_NORMAL };
+	static const char * const tx_pol_names[] = { "sgmii", "2500base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity has 1 value and tx-polarity-names does not exist */
+static void phy_test_tx_polarity_single_value_no_names(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_INVERT };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity-names has more values than tx-polarity */
+static void phy_test_tx_polarity_more_names_than_values(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const tx_pol_names[] = { "sgmii", "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity and tx-polarity-names have same length, find the name */
+static void phy_test_tx_polarity_find_by_name(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_NORMAL };
+	static const char * const tx_pol_names[] = { "sgmii", "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	ret = phy_get_manual_tx_polarity(node, "2500base-x", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	ret = phy_get_manual_tx_polarity(node, "1000base-x", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, no "default" - error */
+static void phy_test_tx_polarity_name_not_found_no_default(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const tx_pol_names[] = { "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, but "default" exists */
+static void phy_test_tx_polarity_name_not_found_with_default(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const tx_pol_names[] = { "2500base-x", "default" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: polarity found but value is unsupported (AUTO for TX) */
+static void phy_test_tx_polarity_unsupported_value(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_AUTO };
+	static const char * const tx_pol_names[] = { "sgmii" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
+
+	fwnode_remove_software_node(node);
+}
+
+static struct kunit_case phy_common_props_test_cases[] = {
+	KUNIT_CASE(phy_test_rx_polarity_more_values_than_names),
+	KUNIT_CASE(phy_test_rx_polarity_single_value_no_names),
+	KUNIT_CASE(phy_test_rx_polarity_more_names_than_values),
+	KUNIT_CASE(phy_test_rx_polarity_find_by_name),
+	KUNIT_CASE(phy_test_rx_polarity_name_not_found_no_default),
+	KUNIT_CASE(phy_test_rx_polarity_name_not_found_with_default),
+	KUNIT_CASE(phy_test_rx_polarity_unsupported_value),
+	KUNIT_CASE(phy_test_tx_polarity_more_values_than_names),
+	KUNIT_CASE(phy_test_tx_polarity_single_value_no_names),
+	KUNIT_CASE(phy_test_tx_polarity_more_names_than_values),
+	KUNIT_CASE(phy_test_tx_polarity_find_by_name),
+	KUNIT_CASE(phy_test_tx_polarity_name_not_found_no_default),
+	KUNIT_CASE(phy_test_tx_polarity_name_not_found_with_default),
+	KUNIT_CASE(phy_test_tx_polarity_unsupported_value),
+	{}
+};
+
+static struct kunit_suite phy_common_props_test_suite = {
+	.name = "phy-common-props",
+	.test_cases = phy_common_props_test_cases,
+};
+
+kunit_test_suite(phy_common_props_test_suite);
+
+MODULE_DESCRIPTION("Test module for PHY common properties API");
+MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/phy/phy-common-props.c b/drivers/phy/phy-common-props.c
new file mode 100644
index 000000000000..120b5562ade5
--- /dev/null
+++ b/drivers/phy/phy-common-props.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * phy-common-props.c  --  Common PHY properties
+ *
+ * Copyright 2025-2026 NXP
+ */
+#include <linux/export.h>
+#include <linux/fwnode.h>
+#include <linux/phy/phy-common-props.h>
+#include <linux/printk.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+/**
+ * fwnode_get_u32_prop_for_name - Find u32 property by name, or default value
+ * @fwnode: Pointer to firmware node, or NULL to use @default_val
+ * @name: Property name used as lookup key in @names_title (must not be NULL)
+ * @props_title: Name of u32 array property holding values
+ * @names_title: Name of string array property holding lookup keys
+ * @default_val: Default value if @fwnode is NULL or @props_title is empty
+ * @val: Pointer to store the returned value
+ *
+ * This function retrieves a u32 value from @props_title based on a name lookup
+ * in @names_title. The value stored in @val is determined as follows:
+ *
+ * - If @fwnode is NULL or @props_title is empty: @default_val is used
+ * - If @props_title has exactly one element and @names_title is empty:
+ *   that element is used
+ * - Otherwise: @val is set to the element at the same index where @name is
+ *   found in @names_title.
+ * - If @name is not found, the function looks for a "default" entry in
+ *   @names_title and uses the corresponding value from @props_title
+ *
+ * When both @props_title and @names_title are present, they must have the
+ * same number of elements (except when @props_title has exactly one element).
+ *
+ * Return: zero on success, negative error on failure.
+ */
+static int fwnode_get_u32_prop_for_name(struct fwnode_handle *fwnode,
+					const char *name,
+					const char *props_title,
+					const char *names_title,
+					unsigned int default_val,
+					unsigned int *val)
+{
+	int err, n_props, n_names, idx = -1;
+	u32 *props;
+
+	if (!name) {
+		pr_err("Lookup key inside \"%s\" is mandatory\n", names_title);
+		return -EINVAL;
+	}
+
+	if (!fwnode) {
+		*val = default_val;
+		return 0;
+	}
+
+	err = fwnode_property_count_u32(fwnode, props_title);
+	if (err < 0)
+		return err;
+	if (err == 0) {
+		*val = default_val;
+		return 0;
+	}
+	n_props = err;
+
+	n_names = fwnode_property_string_array_count(fwnode, names_title);
+	if (n_names >= 0 && n_props != n_names) {
+		pr_err("%pfw mismatch between \"%s\" and \"%s\" property count (%d vs %d)\n",
+		       fwnode, props_title, names_title, n_props, n_names);
+		return -EINVAL;
+	}
+
+	idx = fwnode_property_match_string(fwnode, names_title, name);
+	if (idx < 0)
+		idx = fwnode_property_match_string(fwnode, names_title, "default");
+	/*
+	 * If the mode name is missing, it can only mean the specified property
+	 * is the default one for all modes, so reject any other property count
+	 * than 1.
+	 */
+	if (idx < 0 && n_props != 1) {
+		pr_err("%pfw \"%s \" property has %d elements, but cannot find \"%s\" in \"%s\" and there is no default value\n",
+		       fwnode, props_title, n_props, name, names_title);
+		return -EINVAL;
+	}
+
+	if (n_props == 1) {
+		err = fwnode_property_read_u32(fwnode, props_title, val);
+		if (err)
+			return err;
+
+		return 0;
+	}
+
+	/* We implicitly know idx >= 0 here */
+	props = kcalloc(n_props, sizeof(*props), GFP_KERNEL);
+	if (!props)
+		return -ENOMEM;
+
+	err = fwnode_property_read_u32_array(fwnode, props_title, props, n_props);
+	if (err >= 0)
+		*val = props[idx];
+
+	kfree(props);
+
+	return err;
+}
+
+static int phy_get_polarity_for_mode(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     const char *polarity_prop,
+				     const char *names_prop,
+				     unsigned int *val)
+{
+	int err;
+
+	err = fwnode_get_u32_prop_for_name(fwnode, mode_name, polarity_prop,
+					   names_prop, default_val, val);
+	if (err)
+		return err;
+
+	if (!(supported & BIT(*val))) {
+		pr_err("%d is not a supported value for %pfw '%s' element '%s'\n",
+		       *val, fwnode, polarity_prop, mode_name);
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+/**
+ * phy_get_rx_polarity - Get RX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL, PHY_POL_INVERT and PHY_POL_AUTO
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_rx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     unsigned int *val)
+{
+	return phy_get_polarity_for_mode(fwnode, mode_name, supported,
+					 default_val, "rx-polarity",
+					 "rx-polarity-names", val);
+}
+EXPORT_SYMBOL_GPL(phy_get_rx_polarity);
+
+/**
+ * phy_get_tx_polarity - Get TX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL and PHY_POL_INVERT
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_tx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name, unsigned int supported,
+				     unsigned int default_val, unsigned int *val)
+{
+	return phy_get_polarity_for_mode(fwnode, mode_name, supported,
+					 default_val, "tx-polarity",
+					 "tx-polarity-names", val);
+}
+EXPORT_SYMBOL_GPL(phy_get_tx_polarity);
+
+/**
+ * phy_get_manual_rx_polarity - Get manual RX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs which do not support protocols with automatic RX polarity
+ * detection and correction.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_manual_rx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val)
+{
+	return phy_get_rx_polarity(fwnode, mode_name,
+				   BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				   PHY_POL_NORMAL, val);
+}
+EXPORT_SYMBOL_GPL(phy_get_manual_rx_polarity);
+
+/**
+ * phy_get_manual_tx_polarity - Get manual TX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs without any custom default value for the TX polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_manual_tx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val)
+{
+	return phy_get_tx_polarity(fwnode, mode_name,
+				   BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				   PHY_POL_NORMAL, val);
+}
+EXPORT_SYMBOL_GPL(phy_get_manual_tx_polarity);
diff --git a/include/linux/phy/phy-common-props.h b/include/linux/phy/phy-common-props.h
new file mode 100644
index 000000000000..680e13de4558
--- /dev/null
+++ b/include/linux/phy/phy-common-props.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-common-props.h -- Common properties for generic PHYs
+ *
+ * Copyright 2025 NXP
+ */
+
+#ifndef __PHY_COMMON_PROPS_H
+#define __PHY_COMMON_PROPS_H
+
+#include <dt-bindings/phy/phy.h>
+
+struct fwnode_handle;
+
+int __must_check phy_get_rx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     unsigned int *val);
+int __must_check phy_get_tx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     unsigned int *val);
+int __must_check phy_get_manual_rx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val);
+int __must_check phy_get_manual_tx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val);
+
+#endif /* __PHY_COMMON_PROPS_H */
-- 
2.34.1


