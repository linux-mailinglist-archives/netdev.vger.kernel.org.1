Return-Path: <netdev+bounces-241005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4640EC7D654
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 289FD4E02D2
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F231FAC34;
	Sat, 22 Nov 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fF5Fg9Wr"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6B19004A;
	Sat, 22 Nov 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840044; cv=fail; b=tBmxWlS5aXmJpc+AhUBg+dkYIgxgIf3XE3LQnErtjBwMx5Ob02xvgEIaXFkPnLsI0lW2Tbc3A3ZjadxWGW0IXq7tV3+UjenldjIuF8pkAFx7sbLdX4vJ1VjMupI2apwxyjoVF6/a73aWmHUfIsfvRAKjeHVyMiN8KyRRoqAEnfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840044; c=relaxed/simple;
	bh=lMMkFs1bJ/Als1W/NehrMquwQ1qKmpPssHVJH9ikFZI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NCdaj6eLMGt5qwfgCNR6Ef9SY9s/MeKA8rke7mwyi2tf28wfx4fg40eGn2Z6UWLatg5PXQhmkCDoqjlRNjVzLzXZRdtdar/A3Zbk0sr3T/6UbwudniC0vhJhRCkIVVytt6QjsLgMLCIiDilQ3NpmHu7sUi00XqYjLHJ6PH6pMhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fF5Fg9Wr; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYxKFFhEeirVXXn/Yf0m634nWFywNq8jNw2PmaRAwMsdyN7ftU+SLYftSK86KGe8+DSrf/0Aq6E9/NhPFdU8nsrCiBarbRPvDYnGWVSp5QDxFXhLC8eFKJLCXzKoLc2urzW+VXp8zDs0JF1e4UCykuZ2Bvj04QnKYdCW5N525UNXmCPZ2ufndgTpx4ORdu8U6nyrvrrKgWOBbGvvVzTYioxhONXzYuQAUVPaDholyWacZmxHeFeGXoxgCY5pgRvsDBa36s08xHYANJbd2HCpy1ffLpKz3kjg55zFsWjLMReDFmbs9vCx2mfKa0GXWtLCrEL2xxS9L6/0NPAgX1bvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OStEHuJMYBQf/tt8dnuVJ820gtXuQtSGdNd1q0YiEho=;
 b=UQjUMME4/w8AnF8dSDMI2yZasQ7DHP78V7GvQU2vTOn+k0TYxG1HAa93JGRC2HsEZje42sjAk3lKLCzKe+mEkLHJIDhKwm2Sw4aNyB/cpnq2nXa5AfLSMcBl+svOT5X3mgFm4+i4WFy2jFguDX8/aUI3SacwpPGpR+VvVMlwN5nAJBf+Fbm1kHso3xwiPq5CtIvV+wUY8Pa/DnSYQg7UNUa/N3x9kjVIPSE2X1eTkYnFL/2UVIbJsvPoWXYJJ1hldZtmG+DJak4bCvbwdhqJvE+q9ZKruxLY5HaYpnpEOkzbcvt7OLbE9XqMPcgpywXyypCmBRnMiic02puCcpM6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OStEHuJMYBQf/tt8dnuVJ820gtXuQtSGdNd1q0YiEho=;
 b=fF5Fg9WrKD3fGe881yXfdaWsXhvok9x4x0twR4RDe2twj2c+0m45SylJ51YJ7IKWSz6SG3jQn6v8p5lJLA+i8boU+KSj1xogEVWyYKfuQ0IKkMhLh6Qc/rW0ZtAzIt+O0/ON/M8X+CV3tojTgx++vXrTjnmqcuAKHG4A18SY2Z7UUJYbW4rzWNU0USkAc6nKc31XY08VwXq8lEG7kn2437qf191AWcmSManMUZcsC/eiYpjognMaQRrvsM4qjy5WQjZ2eyJi705rZiBnqBjX7HkNJCE70bM41SF9ocmk83ZylS6s08mjABF0Q/3lps6xGpnPNS3KQlDEpxMEwOKkHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:33:56 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:33:56 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
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
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 0/9] XPCS polarity inversion via generic device tree properties
Date: Sat, 22 Nov 2025 21:33:32 +0200
Message-Id: <20251122193341.332324-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: a1404424-b226-4208-4388-08de29fe1375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9OSp2ClcOExMB6NU5PbJMWlEnmHY3ZY4/eXqr0wRdoaRxoYpSqPuj7yflJB?=
 =?us-ascii?Q?2gprwOmmtfx4rcHnYk2raMybU2xuvcbuIjSHWf9AzVj3ogxwMjuveRf7Fkqc?=
 =?us-ascii?Q?M0CoU70HGwvPplB6fK+GsECuirEB7IryKNVLFy4Dfl1WcKe5MImYEcN1DoRC?=
 =?us-ascii?Q?Xd5N7rol2fku2shW1Imstnceg4Jrjy5gguqUxx82zzMmRcMwYV9Qbbaoxgf2?=
 =?us-ascii?Q?1jeLuwUwmH6NjGtHJRefjFRcYVt4BRGoMSdynd/F8T/5cmPQJYWAO5179TDx?=
 =?us-ascii?Q?OpfGtdHK8uXOq8rI292cFXDs0D6oDwHbwKIRsQUfjyTsVABvnU5T2fh+uXlR?=
 =?us-ascii?Q?ToXmMmovvMF2mGxUNTWjLMsE9BygWMWJhDiaUi5gmz9+Hdr8is83RqaMI9o+?=
 =?us-ascii?Q?L/J8NuP1vejprBO/HDARKyqU5ldrGIEI5eqL2r7jJi5qDECsOD4Au65I8Awr?=
 =?us-ascii?Q?Hk3MgOB2+DIHoSv3gzGvYXw1NEXxaMc0TWrj3DOuj6wQLj5BIWvfcOaSjZlp?=
 =?us-ascii?Q?5f7jQbzcfNgBRg5OjIOgpKLg4hU9UjrAoetEHkhZ6r5Os1nfjP+GPJWN678B?=
 =?us-ascii?Q?h5aMkilU+c71X6XKwHIyLrBloI6f5NtRyp16+cR4p8dCxldHPkJ4gr/1qYRC?=
 =?us-ascii?Q?ouLuLXYtR27zbZVH743TsvtUVVzzw9yaHeN2nWCx8BXGWx0kqi9OPzoD8/qw?=
 =?us-ascii?Q?ELN2EX9qTUcWpmsTHrF0KXCafT0FpHx6Sak/WnkM17h6qTDZgnFcGhvjkTN+?=
 =?us-ascii?Q?Zxmgw4uBRT6pP+nSC6XQwpjnqXGPTe9tplTHG/nfFvz13pzUczfMdnA1XcaV?=
 =?us-ascii?Q?HIdN/L+O+PyBykgnSZcM2A5CMwETRas1ubJj58SrAFnChRdO0S4pkAT2zcdY?=
 =?us-ascii?Q?+bVbfOLf/L+pRULm6L+/nz1l81ux8OmhGpnNdnzn6bWzlt6v74qwQslt0X0p?=
 =?us-ascii?Q?JAkezaaz5MxmCLD0ovZdt2NzrFCP5Nw5r6+elzUXNAgPCBng9L3tqt0QjMw6?=
 =?us-ascii?Q?jWC4LdMyIaquOZoXrRt2+OPxJkBSDNh64fLDpWFBtNO5+KRfPwsk4mJ1qiNm?=
 =?us-ascii?Q?2D2pi75GfeWghDX2XrfA+dZPnFyoUvyCgFjTqdBqOopMQsYLguqwNPDki3ga?=
 =?us-ascii?Q?WTiULmh4OqPXVdQ/hN9yvItKmj0GoEAqhNy/suxWVN87jOM9G/2I2f0UsSZb?=
 =?us-ascii?Q?3GdtdIUAZCnazWoR33A8arN0nH2iG7bWqRMlVZDBzMZ85ZeMwii3bjSWi/Cm?=
 =?us-ascii?Q?/BSV6CeN/oQV4ELGCj3W/GTBV/cUI5zgGLUDhgdrBo8E5nVyq8X5vfnXGQtS?=
 =?us-ascii?Q?v6hLPdR4EO30zlo798D/brAw8JSARFpR/++Dl7lWr5byX5BPUr/R1tZfz5jV?=
 =?us-ascii?Q?MG8DRRVthPVkVJ6JaHyXqVeugb7SLbE0htzTBbVS5gwJ5JIZW9SWovKsyRfV?=
 =?us-ascii?Q?npwFyxedyUKDkRsOeI0icskiFh9Kfjqr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LIDLdeU2CmnwHOeBxOuwJ/3RuBbJc0TofU5mZkrw3GwjYF/PbnnoW99f1b6M?=
 =?us-ascii?Q?nNBL9+hIYmGPxbDyWneG8iHsPjzFTeVHHlJV8/4NFl8Dy5Uxa8F18p2IpMrO?=
 =?us-ascii?Q?o/rvtrP4Qp2Td0WWB2mWWxL0AlKD04ST3znwJ3EsxywxdfTbIghwwucJ6b4a?=
 =?us-ascii?Q?b0hcc9SlepDcXWo/lpvEX9/B+mMPmf8CvzLo1AxGB6KJYGlEmO2mprPrWH4F?=
 =?us-ascii?Q?JPzmHd8zCM5j65DMJd5NznH0GcCD7YV0GkyukKbpkxJJ/zpGJBhRs0tbAWDO?=
 =?us-ascii?Q?Dyb0gLjTVSbp0RTU2Aoc13GlyrUU5JGxpQGP4w1UWz/leJGwzOG6sZqb6YWd?=
 =?us-ascii?Q?BWEuv+ChLrfcsl8pXtmQqHNvNroBu3uyfVQbhwbFIjlhud9O/6vRe3FldJBF?=
 =?us-ascii?Q?O2bnpYWdYZyyYZOagJwXR7nwNZkY/NdW/d+DMGjrZ6vm+Erl/s0XJebzd3Tq?=
 =?us-ascii?Q?yvDNoX0j0YZaPypwKmlxNTtPDG8WkqzbVgw37PTqlPna6SLN6tIG4YwDSC7v?=
 =?us-ascii?Q?3qKkIb/g7S4Qu6RoDsersHnYARY29PZPV5krBi3ReM8VWsRPladudrSOozqV?=
 =?us-ascii?Q?IRB4B9rC3qz5O8i3Ac8iZ6ZQSSZ3pO5VZU62q+Vk+t+tleWhWpYTTv9ltfAy?=
 =?us-ascii?Q?IcghcE3Rg7Pcnq6cY7V2Hw2ffzOMekksna6KB+AveDfSKKbqEifPTGGKve2y?=
 =?us-ascii?Q?gqoWc1w9ta0bcMQSUFqr4qF1LJzUjoYzBBBUSn3ipjAqa6M1fgZOX9qttsXP?=
 =?us-ascii?Q?pvBJUYUKzIAuGlHg0+pagAT1IeKjLigXxFOrAIbj/tbUIRVytk3XNfAfgU2u?=
 =?us-ascii?Q?oIklvpLy88u3oHuNCzuZhDe0ARjdKWnNxNwhnMfOzxyHNWH2Bvvrv0GFsIXb?=
 =?us-ascii?Q?471pmCvXSfkB6liPQfGQ0yi0FD+tyiwKDYjTnIFJqOGLyHGscP/2xK4Mw6Lk?=
 =?us-ascii?Q?Z6gOYUvmEy+VSLDb0N5KppdTgr+S3i8RReFaX+qDXpvcr11DszbVqc5+I/kf?=
 =?us-ascii?Q?YGJ6Beb2tfkJ6iNdMR8lPgVWOp2GKR3r9Saz82kjPrls+K0kmnQ1r7XOS4vN?=
 =?us-ascii?Q?Zm9MsBHNiCefgqDCoF5rP7RG11mmHjZKvczgEbUgRnk9EZv4mhhPH9Rya15n?=
 =?us-ascii?Q?qug1vwzbZqseqAliWsDW+v1XgdzHLST8gXbgSwzei+ZgV+BpF9VbMvoR2Nq2?=
 =?us-ascii?Q?+CvXnyMVr2lD4ZI43gT1sOhpKYci1/lhrVI8lUWkd9GOF0WIL7DKnZsjHG9F?=
 =?us-ascii?Q?5N6pf+HAhCjR00chWZdCVyXwQG2LytB/qx1fnjW7IRBTt1q9m9tjX38+ylKh?=
 =?us-ascii?Q?+2ycn2f6zFRAdiy8Ft8rSVHiXE+17cXal01KYLcyX/ETLKektSmbQ3DvUWac?=
 =?us-ascii?Q?c52WQXtkyq9xfXd6JpUdEviJZ6PoJKGoDy/5Ru+thdtYQ88/9sOCEe9FRsRA?=
 =?us-ascii?Q?LALfHTCJ/KUzE9cOZ5dypnX0hqo819S5/KOqRidfvyBrsiQpj8dADUq0iLls?=
 =?us-ascii?Q?Z4cF+ID4p+vfNffOT0hYBDwOVJt+/gZcp1IX48UyrkeAZh+7z286FyQnFC+J?=
 =?us-ascii?Q?qwrNChwqayfcAe6wbLgZ2GhZhxPDMnznftn0t34+AAjmP+wpSgvA5VOn8ElB?=
 =?us-ascii?Q?2/Pb7/+b1kUbXcW3kJ0rljE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1404424-b226-4208-4388-08de29fe1375
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:33:56.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJPVVFSqxUSRpC0Oy6aVNgrwxR2doOxGhCFDhLwDLFH5kGCaNRW9hhKS4FUzkrH3hrpz1a+Gw7ToxtPsoYIEHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Polarity inversion (described in patch 3/6) is a feature with at least 3
potential new users waiting for a generic description:
- Horatiu Vultur with the lan966x SerDes
- Daniel Golle with the MaxLinear GSW1xx switches
- Me with a custom SJA1105 board, switch which uses the DesignWare XPCS

I became interested in exploring the problem space because I was averse
to the idea of adding vendor-specific device tree properties to describe
a common need.

This set contains an implementation of a generic feature that should
cater to all known needs that were identified during my documentation
phase. I've added a new user - the XPCS - and I've converted an existing
user - the EN8811H Ethernet PHY.

I haven't converted the rest due to various reasons:
- "mediatek,pnswap" is defined bidirectionally and the underlying
  SGMII_PN_SWAP_TX_RX register field doesn't make it clear which bit is
  RX and which is TX. Needs more work and expert knowledge from maintainer.
- "st,px_rx_pol_inv" - its binding is a .txt file and I don't have time
  for such a large detour to convert it to dtschema.
- "st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" - these are defined in a
  .txt schema but are not implemented in any driver. My verdict would be
  "delete the properties" but again, I would prefer not introducing such
  dependency to this series.

Vladimir Oltean (9):
  dt-bindings: phy: rename transmit-amplitude.yaml to
    phy-common-props.yaml
  dt-bindings: phy-common-props: create a reusable "protocol-names"
    definition
  dt-bindings: phy-common-props: RX and TX lane polarity inversion
  dt-bindings: net: xpcs: allow properties from phy-common-props.yaml
  phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
  net: pcs: xpcs: promote SJA1105 TX polarity inversion to core
  net: pcs: xpcs: allow lane polarity inversion
  net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"
  dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"

 .../bindings/net/airoha,en8811h.yaml          |  11 +-
 .../bindings/net/pcs/snps,dw-xpcs.yaml        |   5 +-
 .../bindings/phy/phy-common-props.yaml        | 152 ++++++++++++++++++
 .../bindings/phy/transmit-amplitude.yaml      | 103 ------------
 MAINTAINERS                                   |  21 +++
 drivers/net/pcs/Kconfig                       |   1 +
 drivers/net/pcs/pcs-xpcs-nxp.c                |  11 --
 drivers/net/pcs/pcs-xpcs.c                    |  58 ++++++-
 drivers/net/pcs/pcs-xpcs.h                    |   2 +-
 drivers/net/phy/Kconfig                       |   1 +
 drivers/net/phy/air_en8811h.c                 |  50 ++++--
 drivers/phy/Kconfig                           |   9 ++
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-common-props.c                | 117 ++++++++++++++
 include/dt-bindings/phy/phy.h                 |   4 +
 include/linux/phy/phy-common-props.h          |  20 +++
 16 files changed, 426 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-common-props.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

-- 
2.34.1


