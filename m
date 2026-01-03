Return-Path: <netdev+bounces-246684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA86CF05EC
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C78E303B7ED
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43CA2BE639;
	Sat,  3 Jan 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dJVSp/u4"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3C2BDC3F;
	Sat,  3 Jan 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474302; cv=fail; b=h6MMU4PzXMDLQk2LgNjMR4SiPZu7+52PGOmVS1cvNxvxLSxZs7zR4yvRQbe1xShIGxFwVbCV/03x/b6Xgetc6L8fbdwv0epXbNIHZyC7wJqAkXuMM0tgp7uy9+iPofvMkXwkEh8xt2iN4s581QuI7DzX6dm9QwzROsUmG12UPak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474302; c=relaxed/simple;
	bh=nS/W6h6qbdYcKepgUX9YFcw6nao9r/Eq/eDWZgTHBys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwomR5JMGdwpmT4aZQ3nyO+gNWZnm24AT4OBu/isLey8Hw6+ugebsTWLJEi1qozuqoqAdo/i9xNG5nW5NitBwA/WWOz3TidnfGDZ738OPruH8YXLWyUa8ZfozCqH6H4akQylSAqrYb0Yd6ZItnMm6hI180xtxshd2SE3TXUhwas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dJVSp/u4; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHw0cCBSoJByNYFb8Xh3WrqkcILfv3BBrtYedtlrkaGEA0kN584XMYG2e8+HDXveCxrbGeeXrCZX+sapo2h3oiaB5/A31/uVpZcbcTKmwNHlSmVwKH//N2WQm3xdYgCjEjymovp7yIan576Ze1MNc5mJcz/5IZVOlJrBYdqiCljwfMJD82AF7DoI6EPzdCnO/GsuYjipxSkpvAhGkQ/nzDvmE/9uojF7VHnreMYThyIUbyG0T+xWfzU1JfaOYNPC2gsDIM+wY6aWneI+e8lPwRjOg7jDY3nlWJ6aQlJniOl7XDzxXoZrjyy6BpkIPuTSstzYGzcp3FOegoqHScD/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p2DfYBOSFYgq+qjOp7SHFjFuNX9xu5+iDPVZkWKHeI=;
 b=t/K6MATsBJb/PNvare5H4VQtDe3N2V1+52+6BqzYncmSDuKTOqcrQMQAhwEbLiWRiedvS6PkZ7ouiPkHfkTI7aZBddO/lHD4QP0WHh7+nvFj968U7Mm7U5Z/zejMn6xx0AJpLbI2VHSGBHHvq7Ywfz0nYF4T8GIvBHnf1IYQbAZOf5Ye8qesMaaAHzSUcKHwk8AU104pM4eDu4BQ0RV8IJSR+C9f1khhksRjANUDsEMipsuQFCL5xmKqevEFfNTzf2jVYEkmedzv67juqiGt0n/j4tJiY2qVjUqEjLlKNlwfvtpI1zfuuNq12otDmqJjrUK5BTMwdil1JETnLI9GGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p2DfYBOSFYgq+qjOp7SHFjFuNX9xu5+iDPVZkWKHeI=;
 b=dJVSp/u4+xzgrkjCq+i4VD+oigy0qyXHQ9H63zYNMD+eeRbT2DNwwpU9a+uZn0r/0PXbw0mLr72vdznyqwRHEum7E+SiabKhmXPNut/BwA2rCHmqi+PlZTN0s76jS1OM01isne3WGBA21l0GXQd7VvIzqJI4/bCoMnf6e8SPjd/SPOneHjlmWWyLgkRHDG6ZJ2KmHyg4VTYYPfq88NsAxSyb1qin9H/wE7GQ+tJczPeFSeRd+N08zCi6SezN+JPAD7ETZ4PAciI4OatrjvyTNldwcSCOlVASFfAqOk/0tQ95waRHW2b1XblljBXdVBS20sre5B/45fhJxnv7GOzCrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:04:58 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:04:57 +0000
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
Subject: [PATCH v2 net-next 03/10] dt-bindings: phy-common-props: ensure protocol-names are unique
Date: Sat,  3 Jan 2026 23:03:56 +0200
Message-Id: <20260103210403.438687-4-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3ef8ef1-7924-438e-0db5-08de4b0bc05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6I/uCWViP0IbhnfUsF0ovnetkoe8mYK6unqmjDdE2BYHEpCBA44t6rvisI54?=
 =?us-ascii?Q?LGime90AS6thUK6FwK8xV20QzeHbc0Ju89MPwtoiKxdc73Exzjwkd5Tl34Il?=
 =?us-ascii?Q?+dS/1ZVl1yvwxGWPJiGkV3/NytW8b/TLKCTUv74fFc9oJTxqWD3GYfKohIeU?=
 =?us-ascii?Q?FYhvzDJyjdEwW8h2xyV7Z2pYuNifJtsFoAicsBu9DXoBykLF5sQyhKS1Kz7X?=
 =?us-ascii?Q?0xSqAQ61YoksP1D6yPmfMF08Lja95BPTCV3o0YjLkZSBApnBVNK+6REcvB9r?=
 =?us-ascii?Q?M+18yxDBOYEQcyoCJ8aEAO/OESqCLGn9cU2pn2GAAj7ay8uvmmL6AFv4MX7h?=
 =?us-ascii?Q?jD6UeF2/sozASZK25Pm+pwQiU6KlvMdySSE6jFbMP1QzSdSqWD7hylHpjNBZ?=
 =?us-ascii?Q?0YRzmx4DbWyP2MPKlB72BzZ8NuAZ4Ja/bhnm81XpsoWZURUtP97vsyeGwXav?=
 =?us-ascii?Q?r+VtZVikrVj830OYP5bYRtBc6m+lu+4sl+PsCFBDbOv00Bk/YP5Y6IpvwqHF?=
 =?us-ascii?Q?C2xIzMSF4g3Uz9w7Emfh7Ew+UWDW3ii9fcr7mJnYy5hyKOMx1zfL30stnFic?=
 =?us-ascii?Q?Tg90jbmfK4MFSUfaFSEX+RpasmIh2PG8Kt/11yeYWZ+AXcTePhUsrQ8MqYWn?=
 =?us-ascii?Q?kTK4lW9nwe/cO+1aHZv+6O59xkIMpG4lYNAm43DHXPlNb9wORE8IQqa0LywY?=
 =?us-ascii?Q?5zDdZbupwuYRWI8MXeSxWMEFurhkyL3f6DmBq+/dUEw8lwZHlQYemogCMBdR?=
 =?us-ascii?Q?XVMdD2w8aqoToJ4fzP+2tLnl1qfpBpXiMFCm0fDrWJvXNLksIouPZK7rqYs4?=
 =?us-ascii?Q?IaS2zI7fsbmJRX8m14zUvxmXb4XPTgojdCTnS/9Zppn/7jjxfZNk0kAquJml?=
 =?us-ascii?Q?7+ewXNeW0HsUNN/J6RF6t4FZexeDrmI5YWxrrRuGiDluLcXfAieljHh0sbrG?=
 =?us-ascii?Q?528ho6VDVIhaXsjMjpNViWnqjhrv4ZUFY+9vpBjIKmYQE4/aHazaLwh2BOxD?=
 =?us-ascii?Q?5+TitlgnvNzRTrVBzUTP/PrCD6Zd/8HC00+/uXRyQf9W++hTiKkj7P2GkoT1?=
 =?us-ascii?Q?lBG14c8sXHSXGX4ftl07GXyim2TDakmV1PiMLAQP3pumIR5CbXWFZ8HOuveh?=
 =?us-ascii?Q?g9SNm0JdrxFxqno3JMdcBqW5upPqg3mdK70xdRe2x/rtGPwNAVlXC/SUQUok?=
 =?us-ascii?Q?qAZM8yFfIbXVItJQlKKGeEVOW7xqqRyLeInnVa8CxJf3BW5wdVx3pbLza8x/?=
 =?us-ascii?Q?lKXzM7leeRWH9aHHL8SfZVDQLhd4+UEjsNZ0nL8SCoWdGFFogIWghXT4SXoc?=
 =?us-ascii?Q?rIM25VlUGAlyigTOaYHcGx9QLpj1W/6po3L7BysYYXjBBk/gOkt+Nh5R/4dP?=
 =?us-ascii?Q?XkOKKkJaZA7hjeMM8sfqHPN+MBbcb3RSfHA0NOkjFo+bCkvk0LtansqzDAT8?=
 =?us-ascii?Q?0zyxPl/yuT9fZLf9vQgzFzASVVT5+PhZGHwKcyrQATI+1HV3oHaAvyfbs6Y+?=
 =?us-ascii?Q?1gQfgdNYG25gzaTmJAUe4G/fH3st680Is/KY5OE+cZR2ggCpm778dwIveg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4PENyzuJZWQMPiS5AdAeIpWio5c98Kr4BAdjF5Omyk247NMWowx1TgoWEk0U?=
 =?us-ascii?Q?M+QonHO+4LwPYBRrOC4kHEOczXMRESfG1S7U+8L6kR73xHOmx2kTjYp4JPc8?=
 =?us-ascii?Q?9505UvPGI2ZeVnNdaNAnNJONhBa6uogdziXy8nrDA69UXG3k3bVC+zxk6fxp?=
 =?us-ascii?Q?2COvGPOGNo3ja7LD/nvCYsRpAuwzGWuUqXx4PFFylHsWrQehn+v3BFfW2Oct?=
 =?us-ascii?Q?0IIsAW4BcRtwI9CzT6C8XPlDmsmqVBo+ZJ7+kYth1h74eIZILtjX+ZOrCIHS?=
 =?us-ascii?Q?sHEz1BMRUht6seK/i4DaO+D9i7D8pg8PCe8QNawS/LaeB+20KTjn+7lHayQH?=
 =?us-ascii?Q?J0rkO02e+FZ2c/WXaPwM5zz/zynKhSDNI5NugJNGPzJ1OPqwT2UPySgMXs5r?=
 =?us-ascii?Q?ZjFClkUr5ZV/5VMm6iCBbcYF0y9QMu3aNnx0Aqsa+Tb28W9HxS0JLqhzmz6m?=
 =?us-ascii?Q?VdN2iJY2KWrnFaGt/wnr8IWoy+pgLNESy9VP5dqEvodMCKNfJC7shn/qOT1b?=
 =?us-ascii?Q?c2GcQgvuEQux7QmwOPM0dwaV+qCuN73Jtpws2OkjpQ2p3WV/0pNG+fG30gRI?=
 =?us-ascii?Q?csrPP0BnKGZse0Qn9aJeZ9aqzpxSsJdDLJbV8Hx+61tJ2rCTeLExVxqW4/pG?=
 =?us-ascii?Q?eH0rzexcr2L3lGJdUVktnKCJw9NMGSTqHwH3V8Bvwq9PJxt05CO1TaNhyyEq?=
 =?us-ascii?Q?ABXF2tzVViGKWoq8W7VyiK8ntN9F0vXpQCzZfGQz0/vcqGyEQX2MkSWQfncL?=
 =?us-ascii?Q?FOwVJFujrAJo1pIuAmr5jjLImLaZK7IK5dQXr7JJB5g9j2/L15mW3QniVrao?=
 =?us-ascii?Q?K7MQ0fG+qT7FlMU8HAaQI4x63QPCdoGIKBCZ+WGFDjun8+3jVAgxyRTQY2TO?=
 =?us-ascii?Q?kkbIzi3HqksMHSPVRsdt4GWfN5YQ/QDd23LMmddl8YgoN+oa58YXxV5dzXat?=
 =?us-ascii?Q?fHo3cfbjTT6RXlDgye1tFJRSTFfYBKB4tiYJxjr9jHsfiysvdXIQdGLuMRqr?=
 =?us-ascii?Q?8FEHNh6EPudNgfiF2e6U9n6SfLnfPJmHcpTPnqdSx9EsVAlZ3cpbDHG04eOR?=
 =?us-ascii?Q?EHDuBkPDHADrsyX/nGvoRgxCwQ1yNUqog35rDorB4UhYAOgaduH2L3W8BsXL?=
 =?us-ascii?Q?9skWVFmcMn0g+kN1IxOUlYSnIGjBVzfQBymECV0lcnB8XWx8mVZKtjtR4MsN?=
 =?us-ascii?Q?8oo4bGa5zaixSvQ7hDIVDZ9NdVp/z6M5dUBlyU8YjZAqAWmxxtAP7a/7P34r?=
 =?us-ascii?Q?w3gunnRnc82W8344AsZ8SH8r/kTFkfQlcrTLcRWlRIbofI3GZRBJRoui/CBX?=
 =?us-ascii?Q?JotyFKnSPMK4mKvo7frAmN2uvS7Xr+4eO90FTIsItdsL3ax2xmQOTd57bnQ5?=
 =?us-ascii?Q?9VYVLO28pPrD9SOgyEdiTkG9dtZbM+AzCYu/fmBawZ1sA1ntUmp1uvAe0IbH?=
 =?us-ascii?Q?VTXTXzxlg2UodyH6jH9vGEPHYA67lEpoyC7hSAd2BDxPNHPDtgK27w/0bqRf?=
 =?us-ascii?Q?bH6WO7BLuIXi+yPJqCWeEuYp3a6owObHsPTWFGLxKpVnxhd8F+ppnPmWfpMx?=
 =?us-ascii?Q?1nzK5FtpJJKxq3cl12ihxeSeJlVVrsmk2pb/SwIpDotsjvwXb+uvY4vbNer0?=
 =?us-ascii?Q?fwS5t68MfF5K5wNT9TwOxdrnPr08lsqMXq34ntNRGp4ooQVtB0E5jZ7Zb3yV?=
 =?us-ascii?Q?aSBEnP/eskeuAWnMmZrmILtNr8o6qNX+5TCuCH9brf3amQEDM8JLYb89CgnB?=
 =?us-ascii?Q?lXd1cRwJmZ2Q7fW/fFlRRoqXMmEN1ag=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ef8ef1-7924-438e-0db5-08de4b0bc05a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:04:57.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEqVLHldUxuCcTTEy/duvNyo4Vi8sqelAQs7jKclKbKlbtyaQuRjluQbKsDU/FhTeaZg4+DkQ4w0dRH1weFBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

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
---
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
2.34.1


