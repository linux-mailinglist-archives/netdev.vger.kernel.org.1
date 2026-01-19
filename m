Return-Path: <netdev+bounces-251018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E602D3A289
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D21C3008E3B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AAD352FB6;
	Mon, 19 Jan 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BF+ZLRWZ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA71352F82;
	Mon, 19 Jan 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813958; cv=fail; b=ots8J7ya7ey3eXgDtVysEA0V7VGjYLxQSn0cf0aW8Su8w1mmQsW3KTjO18QJZ21V9FUMyuz2k5Nf/Q/AfSwCEjqQugsuhQIlEouHIRbKW80y+NPzClTDH1pMXoUu+UZlRkdavnWyuy6if6yk5VU6iQb+xMgxAZN6EZ6aHH3CVpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813958; c=relaxed/simple;
	bh=etmtgF/1Q9QrQwOUuoKAR8PxzXbieWi60f5chSak3pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEytRwV05qb3fd9sP1a3QRC/omAD/oSSHMJN6aZvcGvHFhoFg89yVCdPb3n71XoNtPzVdIm9cO/nIXQ9ACjIzTandW5V25V4YeirD6oDuGqiib9Xxps6s3hezByjNLNl6vj0i8IClzd2TVnUh6pUPJsh1rnOEX2qwIMMCFgFjuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BF+ZLRWZ; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTXNGc/BpK7hUkFXSfIGJKPXWRlzlpa4LBk1WNszCn5Fss8QKb7/i6Pdjqgs6AYn7bD1DdojtnprWip+l1smpsT83LFLlBTdLcf9IgA4H2mcGcyf8MwpJXNJP0DoJ8zqBVwYOkUgF/cu2IolqSIvBZx66m448wfv/BaEwAfSVWzafx+49gXglK+5KRr1v0QgkcJPD24xcmkj5pkbYvo0exkt5kwssDfmRAgtydUQdq8OSns7wTIBDGPj1U/QC2SyUvikcasdpBHH/S03x1Cz0qqUwOy2QILNEFvWhIe7NGTDVPcQupFS8rGAqIQ87mRje+Axxj0k4OldRiMWYQwH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsfORM/ddAmcr0hOKcPiTiLCSwhDnirMA0CbiQFeVQE=;
 b=Jlb3Q9qbZq5XxLCEiSjmbdSZs1A6aq5qEvgv7mX0SW693YEcyL60kJYDd6k/rUa8NrYC3UoDzZhMHYKUWXCkzeHh624r9ORDt7ciNelcwozo/PktyMbCNIOVOvcd0ZjLj/2e4j3wvwi2M8rEzKNOZvnOwRRENcEZX8VzaAu+sEwtl/6OgkqEsMsItsb/8ZtROw6+nOnVxupIwI1UjHBh3liBIcK0WJ9gN8r8AxStOnQsU9wLJtj51nXCsai/b7LFtc14jOfLodsN8ICwggDTEQuu8QCX7X5HcjzyAdrJIRhoOzOjDfAYpCCsDjbXRqvU5mVGzEmYWNuEk7cG0F2M8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsfORM/ddAmcr0hOKcPiTiLCSwhDnirMA0CbiQFeVQE=;
 b=BF+ZLRWZj2bLz/1nyuOHMvYFwlhuErj2UK52mt9EBNTMeXVJ6eMiPovuaLUw0hdXYTx7NSrx+gG0jS+L/XMdDwnCZyRNFbDY4ScSP6N0TMGuEzj3CyShy7ZXt9yKjLq2BsyAypUGdjl1Oi0BV743iZKxN26BvUvRSnQyonctzW2VxBkTMnnW2nncUNXelaTTaH9SbDGGj9edqHTS5Q1UT7qekAtt2b5qSVBndEuz2kFWC/BNjd7QB4Hx5MuWRrqGb098sgR0yNBhWHn88TT5FYYE41gfCmBx3dqVyEkdBXODq+3hN+u0DzaGbz8WBd0apIGH6401AdC/CM+TmENCYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:12:34 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:12:34 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v4 net-next 1/5] dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
Date: Mon, 19 Jan 2026 11:12:16 +0200
Message-Id: <20260119091220.1493761-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: d724aa99-332a-42aa-cf1f-08de573ae193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XRZdGZ1EOBAvaSXU+aohJ9HZH4uzlkUhRm5o61jqPGd6dcjC9vpSUd8sOHkF?=
 =?us-ascii?Q?TmJzFMSwbSgwT8D2Jnkd71PVI6wd2bQsYj+c2CV0rLaSuDiL0ds9x2vOSqX5?=
 =?us-ascii?Q?xo4eUZhR7F3Wb1ahddoufyuErO8FldjOJyEyV0UR1TLM+SkQ+xE9F5lwaVek?=
 =?us-ascii?Q?/XUfIArIjCvv2n+Rs7NtL+OJxJAH+oYQZVYf1CK7GuRr56+bQe7VpilbCqh/?=
 =?us-ascii?Q?dqkXn6tmURBqZJJnP+1hm+sKav26EFd2XZj9smrAjflPAcou9ytezjp2Wraa?=
 =?us-ascii?Q?f5jpnzL1TF0mzVRdll6Z6xrDWGbvjmbEg5UW4HMbJ8Se1K7WnPghXfDGGlSL?=
 =?us-ascii?Q?ERVTt134lXW3pvEW0A8VTNMNxpNRAJh9UGYgtvezvbTlzRywVefSUhv94vuK?=
 =?us-ascii?Q?Y2Pee9pJ70cfzMfYOfVCnMHKX0a0+x3xmI5dKg2X/D6nPLCmjWWVkUMsaZqD?=
 =?us-ascii?Q?f7ePs7HbVqmkD3mImevbAEUNolxffY4KpFAay4gb9agTVogi2Z5vCSwQ7frk?=
 =?us-ascii?Q?8old03r+jgqvIszSXMePcZokNcbgYdOP+pk/J/33/TRGLpn/B2jvSHnzyFrj?=
 =?us-ascii?Q?Wi48rbwwmcK4K0EFjMs9qRE0BKNGOLRlCKHK6/XGZhw6xb32LZGTSNbJDpLN?=
 =?us-ascii?Q?viIsFyyU7dwEKeZWovliLrtXBnnmxs57mugOFarK6d4APuBCkrGThGP3wGLB?=
 =?us-ascii?Q?FC3SYN+9QiHEfcYZoGAwOpSL2ZjFqQtqCGAU4XTNHW5mso8NVcR20y4B+P33?=
 =?us-ascii?Q?5/rR/7DwDQULt4mmstOWEymHjWVWpg3CJu24oEpm/6UHTHDbcXLkKEwxYL/m?=
 =?us-ascii?Q?YLgatxk4eLaOcS4zlM4iStk2hHHgwB42Ex9+Yb8QAbmUPqVtz9njFqPGkl5k?=
 =?us-ascii?Q?Fv9XvpnK1oUiV993eqvQtK5B9XqRXcLQGZCQ1DgN8tDnOLgtvlZP2q7m9/rt?=
 =?us-ascii?Q?k97L25tMu5g9IjfwCe4L15V19Wnt3AeQNLeZnEfoOGa4dkHQT2mBnDADIBBy?=
 =?us-ascii?Q?6Q42rGwPeWsrxrIayFggvtrVlAcbq0vB0eGS772QSRvwgBNr7jsRzXIljO3H?=
 =?us-ascii?Q?SvAf5BDcsRop7uAqtEOZmo5MbQh/Ii+8LOQWzu0YaG4T1cjY7JzWtPPzMD7L?=
 =?us-ascii?Q?yeoivgZvkNePdwnxg1IvRGhfBhfkyM+crD/nV/BsFVvdFUvKPHsUMuErYgDS?=
 =?us-ascii?Q?jqVfS1rkB8TkCYQb3AkwcK1g6/ndQozohlxJ3eHag7SSlDdWG7h55YCi9HFg?=
 =?us-ascii?Q?ATK3YVKLqsqlMohWDJGnBt0LeEbMMFPzDdn9zi7X4XV6RGiagyAeV8E8iH2b?=
 =?us-ascii?Q?BjmsLLHibZiuU2VOySBM5MIwtHPXEn2KvDIcWnlJC6GWow66ItPnmRs9oif6?=
 =?us-ascii?Q?YlM55P8lK3pLKdPC0t/RwEv0rsmA944Op+EBSiNI9ctK7ggmLJKp3P7Hzqld?=
 =?us-ascii?Q?PonQQBSffBmL9E4d5olWTizkDkMK3d5Omo8B5ILS0ZplfKYmQjzz6/ZawtGV?=
 =?us-ascii?Q?uLI8j5M6DFi+1NnDn2H5KgCI1ousTHB+SGC2nYYTixEeWepJFxkHH3lu1/mW?=
 =?us-ascii?Q?gYDikUeW/Y/dClaiTbIru2SiWkUlfX/J1rXDxIA5cVZGd7KqMOpIpV5MOt0W?=
 =?us-ascii?Q?+uXF8BDtTKGvW3VMMUTF7Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/hU5CCtdSbJJMZ84Ut7QUnfP/6rbxfXIErnDIr3Njvgz7BqqmOicyxEIV0F?=
 =?us-ascii?Q?mc4zlnfnq0ONOnp4ICajM04HTX75DawfI54yFPNX6Xj6Yx9ykVKxZLjCO8/X?=
 =?us-ascii?Q?KIWtSHIcCHk7jbtRRFl8jYkQoXg17gWU+SoN0wAa57ABEmIwxVUH6Vo5kQYs?=
 =?us-ascii?Q?EoOUL9FeTcycqLLJBCPphDQy6XGI12DnnQFuN1U+Ad7PldcBCDs6t4+xkeNm?=
 =?us-ascii?Q?NgHceE2jCEndUDid3NdmOdygvYBK1Xsjqhmc9uPHWhKTLig2mmy8vzdzG9MY?=
 =?us-ascii?Q?Y5uIfe8OOU7q/rZP2mzmKWzvEtXBJLKVfNze3hUU0WyQVYLZxlvuemEQ+b9p?=
 =?us-ascii?Q?o727TcBtMwBzYZ1gS6LnjQyEHmA5ed2Qm2X2lxUgwoVkXNLkJTiWI2PL0nPi?=
 =?us-ascii?Q?+IJ9o7IinAnYE8hO+On/gl/Bpx8sPniDxCHJUOkC4TZskxqNyW0rCnbajMcF?=
 =?us-ascii?Q?STIbp1CqOWxpQ49FqWgzt4pgEUPNYWoiEvTKz57U8mZmYyLK6tR/iN+eyQki?=
 =?us-ascii?Q?PxfnHy4GoSmbC6jPgwMgKQHBpbqVCVVbEJrUfQvgd3/WE+L+3wAsABbGv9tK?=
 =?us-ascii?Q?KE/q5kXOYYk1EIFqNsFxouO/h9VUOQAQLutAA+oW39lIp8SPEpsQYIPGO9sj?=
 =?us-ascii?Q?onX53ilSST2/ECDVtLJoWOj8TR11WxQHxk1dwsjA1oprek60I3AguapaGMwC?=
 =?us-ascii?Q?BvHj2bUoSjdOXMMk2bApYKtbR9IORxjJQiWjoocvMUNEZNvRIo5irfZ5Ohul?=
 =?us-ascii?Q?QLaClHQmYzoXYghQ4e4W6LZobSlGDVclRAupQJ7+ULsE56cEE3bMccbdAcFV?=
 =?us-ascii?Q?+xR6NOJnY/fvwdB1FXkelMHjlZhqokfBo2pXgmRniGfhQjk25Q9WeF+kWZDQ?=
 =?us-ascii?Q?FjtHvf69I0ezYVIj/QQ1omXD1i+8fC9hyArEL4CEjUGxiinftEJNiyV3a8zW?=
 =?us-ascii?Q?w+ly8fUq+JJTcJ0Qohtxh5biXLfNue6EXH3piaAbF+QhZj5kL+lrVuItlICh?=
 =?us-ascii?Q?zXHlH6TtU+ypnTimt25Rzq6FUC5oixaF37bOCfxs98lyo2uLiT7wJlnPjh7l?=
 =?us-ascii?Q?RRbYWuJ/GM5cxnnxWkIE92Ys9W/OHVeMF+PGWk3kETssYeMXlvAQxUKZRMy1?=
 =?us-ascii?Q?FVGmSB1k7UH88iurbcaksYhYmqrpxXqW1JiIHC6VhZ99Am7d1YVk9lFneVXv?=
 =?us-ascii?Q?1qwhghlOsM2BbJf48GHqRax0fEoXkDsIENfKgxjxrh/PwxpEl+yrwe8m9QbI?=
 =?us-ascii?Q?G0ZZCQxShgrpmDVJ2PTP9VmdZMPoWUd1mz+FQXoTOjwBwwVRYCISyFXMcvxK?=
 =?us-ascii?Q?iYqSYiP6K6UUI0vPPt3wcbzNiQ5jtkR2HPWX8hI4lt7lUdzdHOjmcYUaqhCO?=
 =?us-ascii?Q?qr6BVngGRFOxBbUbUbeJWXJ0cPFiBYsflear0ODMjP5XCk4Z48FX9uKIdIoN?=
 =?us-ascii?Q?4A/cl3hsDb4yaq+0KG+AZn4zZJ1O4c5ZY89XWmYw+qBxroi4kB4HTN3ZoRyZ?=
 =?us-ascii?Q?hDhc92pJNXIM1T7uIqi1sTSHL5jee/dAOrysQfnUvyfPmhBzoLSLK+L6dVO/?=
 =?us-ascii?Q?CCXPyr6dTcdSQ4yfM3fLCBAGdN7OXCpT/Q/e/JFbuv8XcuIDv6lrPrxx0gc5?=
 =?us-ascii?Q?Bn7HrY29h7W31k+jHhf0nfJ41bH7BQrpqbVLnFYCrqo+JKXNBg23vfbOPPfJ?=
 =?us-ascii?Q?XGdo5NkMhfmgvv6XePmlDoKiADX8AiW9RNtequr6R+U8T3PlkYqV3xtSq+Er?=
 =?us-ascii?Q?vWf2QV+mIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d724aa99-332a-42aa-cf1f-08de573ae193
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:12:33.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwRINOnTZzTLPLfvCSiPpl24cq7S3n3OzkyH/VKDByMbdU/pVRge0HfLHLanILS+HRN4M4hg0VNvaDL66Vr2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762

Reference the common PHY properties, and update the example to use them.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v1->v4: none

 .../devicetree/bindings/net/airoha,en8811h.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
index ecb5149ec6b0..0de6e9284fbc 100644
--- a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
@@ -16,6 +16,7 @@ description:
 
 allOf:
   - $ref: ethernet-phy.yaml#
+  - $ref: /schemas/phy/phy-common-props.yaml#
 
 properties:
   compatible:
@@ -30,12 +31,18 @@ properties:
     description:
       Reverse rx polarity of the SERDES. This is the receiving
       side of the lines from the MAC towards the EN881H.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml
+    deprecated: true
 
   airoha,pnswap-tx:
     type: boolean
     description:
       Reverse tx polarity of SERDES. This is the transmitting
       side of the lines from EN8811H towards the MAC.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml
+    deprecated: true
 
 required:
   - reg
@@ -44,6 +51,8 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/phy/phy.h>
+
     mdio {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -51,6 +60,6 @@ examples:
         ethernet-phy@1 {
             compatible = "ethernet-phy-id03a2.a411";
             reg = <1>;
-            airoha,pnswap-rx;
+            rx-polarity = <PHY_POL_INVERT>;
         };
     };
-- 
2.34.1


