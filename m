Return-Path: <netdev+bounces-248785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E0D0E7DB
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC08D302BA65
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4C33066F;
	Sun, 11 Jan 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VrrTt8PE"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C23322B7C;
	Sun, 11 Jan 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124474; cv=fail; b=Texg0ES0hQO+3PkHvNKTeypkB0HtEQ0DRmyFlaV33ELGdJJlJoN7srzWXlT2yLDTVrrGxF46D3OnGn5+innr8pk2nSdOU5+NzydoQTbdM7OiAAH1TOHdOvjVVn2ah86MrI3ke6GrWRL+Af7jiLUzQWbTglvJer3YDMfJML0tPfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124474; c=relaxed/simple;
	bh=H1Whub95+Dyrq1dSuVzd63hQA+kGM+Mz0H75kORy6DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nu+6C5OvBrbuYCiQQ20Ulu6yEYunqcCJQe6Tapqm9EnPyT2mjistnyP+3da2N643HbfG7/ifweJhK7JCSTyamavsGULh5kV1K3VAhYKdJiyawUxYgvEQ9kghwUT4qREz+fSZJtlVaaRznqQ/6Mmn1BwKpLGKp4xFoS0mO7uIW64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VrrTt8PE; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQxsQgwrcYLZbkLqqXXUJlf35eMcaevOwP5AsyqVk9w8qylNv9Bl2GLhq9uq011KIZgStnWVtx/5kZj+vuGwRVXhJzFmacZldsMQaeKb/OhYvjSMaW1AtgghP0YIy6J7+eQSAesYE05lOLXEFP4lvwoZyZsi9veXkkRfpgiIs0JK/PF0qwlAUQLRez1AgAhQftETA6HqhmgP9Xolw87ujxWz/pnVCbGe2jMeaZKqyDsF/gcsjwDkvAZRb/Mo1Ff9TIudnzNO+NzILQriavx3LxmD7b8VviI6TfkfVgzI+y2xBQZcS01Fs2883t6xCl1iCNzArXgLNSRkEod2nXzJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyv3YL5vEsJBhwG6bUUGbVUuYWIGI2xp5dR/6eBgU+A=;
 b=VfvjPUxUqYR/G+L2TMzaLB8E4RqhLIs/wEYsyro9ieKtZamw1AVgrpD6FPyXfHKF0FVE+ejh5r15yjg5dB0oSR1LPeRArLgkbGSAPAnglHbu4Kbj7M2j3aK6a+Dcv0U2cVOSPMX8hJ+64rz61WP5XhyY/uclyjvWiGs74R5koGXWYFJbXiaisSFkBAc+3ccfBNQnKoXgYloX958TwvHzOV2rs4PSvGkfxVeDDhIRJissU8J5Mp23CXgEATYeOpgagoKifbCNoHr/ZttRDsqd+oFesp8LcK3qqJfSiJ5om6z/3nOFYJxI2ukRX44QSnytuPNOotL+n+kgDC2WSogrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyv3YL5vEsJBhwG6bUUGbVUuYWIGI2xp5dR/6eBgU+A=;
 b=VrrTt8PEp38DNP5KFTdQkamFIkZYnr5BsUyh3lVxYoKZ0lDx2aPvRvVRKJHuSfiU740FobEXqBujc/RLfUMrQ/6OkNUGIVgOmk/BkQME6TcWFnB4ZLQgrMUgp2MvpjbPBF9GBUyffYl79RHMbtrYXEuw6wLloQ7swKCobQfiYPZd6IEIprF4YG7Bf+j30XW9ghVAy+fVeFfClfkEpR8pwutOC0MQjwr1SMcg2OpJEABLl9v7jzG5CbWM6TT66y+S2JI2mgus1fLM+lguQ8xmivPLgxgghK21C4ukDCufpfzEgrLcVcbrcwntgFXIYbojJeL6pykkoApQ7mHSJgbQNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:02 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:02 +0000
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
Subject: [PATCH v3 net-next 03/10] dt-bindings: phy-common-props: ensure protocol-names are unique
Date: Sun, 11 Jan 2026 11:39:32 +0200
Message-ID: <20260111093940.975359-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e45041c-7f56-44bb-5e79-08de50f588d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TjK9z811dES6+9/FYiWjd5z+lVAjAdg4rgPGdqbj+cMnPybZHWt1qZARTZuZ?=
 =?us-ascii?Q?upgsufJtGrJRxVNyMijuUSbIfFit5ZNBaiGBRin3WpB3l7u8IwOuotisWSje?=
 =?us-ascii?Q?7zg7/zxFuFUnrsqibotgmsb7LXO/8bXiyzzdPpcygsWsSX1spLAIhTO22j78?=
 =?us-ascii?Q?0agQZFzfo1KKbNWjvvUGUeIXjknbY6eKAyUuoGRHrMd0v+qgv6/4eM0uu9cj?=
 =?us-ascii?Q?/88SiIjumL8+9ksqvBznDXAWtVasB0lPrgYxrFIisnPFHFHepNs2zhG+7uX2?=
 =?us-ascii?Q?/DxjbHbL6mu2/OPN/tdFj6+jLLRiJzcDywyr+g9Uo838spy7tSjoiNfp7gfV?=
 =?us-ascii?Q?b4e1GhAYyZNbzPgqa++R7FkYXjTXw+ndj73wh/FmUOi8LAXyNJHu3R6kQIuQ?=
 =?us-ascii?Q?ApeuwITyh7k3TwARbWmLvds6dvVD5Bcee1ghBQ1meBZdDGTrpa2YvfycVC8u?=
 =?us-ascii?Q?Gqt+17QVn6SCXDBN3XdlY/E6YZKFM7rTWG8nh/3+r2cQR1XofZXmOVSGDrK5?=
 =?us-ascii?Q?NuJxyxXJ/MtL1jwuD996p8nZCIK8VCIfKOQ1BKl2l6nF+UKjDpXibvlmR3Jl?=
 =?us-ascii?Q?BGIBUCIEJFyJaWWwLiqSNQ3JNO+j42ly3lK+m0iktQOdBI0KjonCSMJclpHM?=
 =?us-ascii?Q?o65DR8IpUXJTgJlYpm+cvqdaxV0vfIeg/espE0yQGp3hRBUNGbx0gOfgDonA?=
 =?us-ascii?Q?5iIa23Ms04zW4WKHI/5y4/qv9+PSgKUfOQ2s9xDXmIZCTRFl3oJ1UyeDrAiI?=
 =?us-ascii?Q?6S1iaDcFOsRhpo3eZ1IyPxGlxKvrQieuYdl5vD3tzi27bFSHbLosrUPV9JXh?=
 =?us-ascii?Q?4s8jKQ6ck7iJ++IRCLmZZ4n69EFpxoxWbZgsek3rDAxTCwHaVvCrgpBfPko5?=
 =?us-ascii?Q?PD906Wu2x1EFKnV2uuaIVmETan72CQwdCL2KUdUIIPDIc6ONKYmv4I01bekE?=
 =?us-ascii?Q?rLqULERQUeciMo3yKUoqPlzBeYgyFSD+3otjaa7h6phbwERmYFsvXMRjJfeb?=
 =?us-ascii?Q?bgfh8/LcnjIdTAiEk36fEKeJd2+/yE+dkPzjnHHjmAXjOlvHxuhja0qqhI94?=
 =?us-ascii?Q?7zZb50uqLSKH9CTfQN4ydP2VVTAUtlE9sFRa6fippXPd77c15YGXOjlZaEKP?=
 =?us-ascii?Q?ZUvahZOB7kfNpofIM/3s4mDWk6f5Y9v0zOf2wuM5KLxm26dR+ddeRaZqVBks?=
 =?us-ascii?Q?I1yYZi1Km6CcecJiGqdjISvRN5u6SXarfYY0fYwTNULBrHGOfYIyN8tijVI/?=
 =?us-ascii?Q?qZNzUKJrY+HkKmNvn6NJ4Kah/MbCyyDdlh/higZMqG1NkwCKTCvSoB6r2xe1?=
 =?us-ascii?Q?5/4PwXfLL2X11foFazAYgPFCXQc3oiPYMhizb7OwBiUfDis31Q7lIUY//aj9?=
 =?us-ascii?Q?GO0T7UStNziuF40Rf0KcPHAxwReqBkUmzxieCDDbech2qcPhehgXlExmE2py?=
 =?us-ascii?Q?AmZ0mVI6Ik3KGycuP8TYCVuPHlisUHVnb8+0oOCVjEcPh080JpYlgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmQ9sZ206318dSzcVtEfL6Cg+0mjcX/7BFUHcXnC1GW/d0OGIcTizNRLkzj5?=
 =?us-ascii?Q?fUOfdKvNWThw3+SaIiPtXKRx7Bm5xqpvilWZwifdTw9wBM9cxFm8j3MsOB+9?=
 =?us-ascii?Q?S7QwtPab7HMyczJ052Gj8Ynn0ZdZ5ylTh+vd10R8lExjHjwvCxc00FMNV12Z?=
 =?us-ascii?Q?hY2dxFpCl7Ia0Pnrfa05p8adWEITa0q0+GUmiXwA68ASzdicyMh4/qCgYuaJ?=
 =?us-ascii?Q?OyhmoWoy1QBx3kMQ23080OXU9yn59sG1L4vNbScwNK3v4VTzz3P4OFUIZ9Mi?=
 =?us-ascii?Q?GYmJEs81sj8Y4wiWvJ6mmjBBPvOfc1h2dRDkWYCQ0uxRcT1LBXgZ0w1tmCfi?=
 =?us-ascii?Q?0u14ntFDlKWsieAJILcXWzn7OFFvFTY+35i5XPwIxNf3iHaxo3qiWO2pupav?=
 =?us-ascii?Q?3VYZ5gQKcqDLupIeraLdJvW+ylDcziVFFtIJnj/lHGC9j7sgwMEkLlbItMwN?=
 =?us-ascii?Q?2ago+U4Sh3VVZPx6QaxQZFcGoJgvjhyZo9E+ZHrcZwxA+erizg8jxM523n/S?=
 =?us-ascii?Q?vHoaLOx9l5YEBUCJskx9Wyar18SoVAXSRotqD7PPJwyrXjwE1TOjpGQg22VI?=
 =?us-ascii?Q?5/0SS59oWRJ5KTcjfKkY2gaGzCPFJs61qR5EOiWsAtgOZ6cgUbLU66TiXRHh?=
 =?us-ascii?Q?lwhc4ArdEPb/zs3u2RKvHJ2N05aBdnfZ4mmm+i278bc2TfYkQ/WeSElU6Vud?=
 =?us-ascii?Q?0RRDP7qot0Rk5mW0JwB3h6OeEsjHyJOljMs88RlC800HhpyD9vOg/3hTxu8B?=
 =?us-ascii?Q?ANqHJjV3Hr6EhGiA6UCqTRx/SYahB3WDE+57buO2Tvqobsc4mhl2g5fQVj8o?=
 =?us-ascii?Q?QwyW5HyoFLmvKJ32YnmJZGMzdYR2TX1fjECjeak5wd3RIN14nJbKrgZuUoPE?=
 =?us-ascii?Q?Ohp+Fuv4yjbH766jsTJYttdly+dUtbq4j/pCkWO+ZJOBOp+ok7z9bac3p8Ug?=
 =?us-ascii?Q?zhi9tjXhQ72fAM4ZhMvWJgDCyCm7ZRpILWLou1ZxpoWAwP4MK6f9nkFOoOVO?=
 =?us-ascii?Q?GQHN8qHCmbebdTSenECCIlI9kVUvn+SswOW9TeXeEKG949WZ4eAi1TfPcUtO?=
 =?us-ascii?Q?+yJwLyupAu7jehLitzRB3eO52ydN5okOnVAy+F7NYyD9/bfUgm9Q/LBxWUBd?=
 =?us-ascii?Q?JowfCY7hak0Yg2N5RO7Dw/LKBPM+DhHZ1KEhH4oI4IgfX9//a3PWMrMcITML?=
 =?us-ascii?Q?e0u29FK9U1f0AoRe8C7HyKARLTUtBqopkPNgHuen+VgmNLbQ80TwKpbxZ02F?=
 =?us-ascii?Q?1Ce6NwDnq6ZuGAMC04k5MKlwNqznkpDg+BPtlQvbP3wedPQicQcwREF+O4JF?=
 =?us-ascii?Q?eWw+GQzyLeEuvtDQkD5fDNCIldMrA0t36y1qCPWOe9U0qUflVqabD++JrnlJ?=
 =?us-ascii?Q?cBvhRvWkFyJyZCPczYy8ZSxO4VEtYDpZbUzdyj2DN29vTw4iGv7tR50Hdj5f?=
 =?us-ascii?Q?wa1+qcnJcQRGTa2X6kF9NJxkQdfkgoesOaXoxzUHEOHYM3eS2LlW4809fzxg?=
 =?us-ascii?Q?rimtwV7XpQgDlTJTs5gB7wX0HbeaH08BYfdXi17hLTKXdtpIPePcTJ/UOl2w?=
 =?us-ascii?Q?mypJZ3Q89DCFoUJOoTkHIq95uD88L7xgjbfNhR/nodQOEFULJOVk9tBLAO65?=
 =?us-ascii?Q?Gz9VcgVi90SaZYdrNjByqnljWkl3lD+uKO8sY2LUCFqpwOneMNUkh1vbZuLh?=
 =?us-ascii?Q?KemO+9vZOBFHc1xMstNwPeW8raFwHxAiq1YC47O0tAvfJcgaJDQ0cx0nSM8k?=
 =?us-ascii?Q?AwiVdAsdz307iF99Yb2fhFRslytyQ+TuvufmuAsoKjl62QFYGGLV7jgFpjw1?=
X-MS-Exchange-AntiSpam-MessageData-1: 6tD1dcfo7YTQSRU03nFmiiZHQodDF2kCK64=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e45041c-7f56-44bb-5e79-08de50f588d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:02.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBNEILL2szS76NUTf+3YAU5H2f9zjrIY/xmkpUuVXBz6ZhgG4ZYvCY7PoMiT7xhWoMzwHa5cPqZ9fTycZJNU4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Rob Herring points out that "The default for .*-names is the entries
don't have to be unique.":
https://lore.kernel.org/linux-phy/20251204155219.GA1533839-robh@kernel.org/

Let's use uniqueItems: true to make sure the schema enforces this. It
doesn't make sense in this case to have duplicate properties for the
same SerDes protocol.

Note that this can only be done with the $defs + $ref pattern as
established by the previous commit. When the tx-p2p-microvolt-names
constraints were expressed directly under "properties", it would have
been validated by the string-array meta-schema, which does not support
the 'uniqueItems' keyword as can be seen below.

properties:tx-p2p-microvolt-names: Additional properties are not allowed ('uniqueItems' was unexpected)
        from schema $id: http://devicetree.org/meta-schemas/string-array.yaml

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v2->v3: none
v1->v2: patch is new

 Documentation/devicetree/bindings/phy/phy-common-props.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-common-props.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 775f4dfe3cc3..31bf1382262a 100644
--- a/Documentation/devicetree/bindings/phy/phy-common-props.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -21,6 +21,7 @@ $defs:
       'default' is not provided, the system should use manufacturer default value.
     minItems: 1
     maxItems: 16
+    uniqueItems: true
     items:
       enum:
         - default
-- 
2.43.0


