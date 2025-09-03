Return-Path: <netdev+bounces-219580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D8B42094
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5617C161260
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF8C30275A;
	Wed,  3 Sep 2025 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H9gPV88D"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB8301464;
	Wed,  3 Sep 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904886; cv=fail; b=NzdXR/D3wbyrc6plQ406vYtajWeDsblVWS2xH7zmzKWd+fhxWTeusZSf9TQlNvNm1K5akEsYGQLAdP8AS0UcVhSrFnaAT4ejT7EO5QRUgrmChj0TwEZNRqIcbtyZhCwEz2ow+Ozai1dt6f8QXB6gyZgWNpsC8brNrbfhBtTR3js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904886; c=relaxed/simple;
	bh=jglmZSmvTHW5oE2VMo8xjh6sIN3HFPO22SAAWA3TajY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RR+UaXpBestCxHT/Ti01TTsvL784ij4vsUohbzlGh15zSOgpBHaQlSUBZWuGNVSsFevdFP1C0NlstAjosLCLrHLM5sk0uickH+E6Wdikc3/Mvmxe+MDcIEgWnTxSM34L0ENdGJRwRqrG1HDnzAfkBt8ew+Wo/eHX9ba01dZB7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H9gPV88D; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDZeyArXUjqiCR+hAC8EgRuDporn/xPiByvyp5tSKqYogMjdYqQaRZDB41GJDv7gr1i0kgxRwNt2f8qL5DvQUJ2bLitZqg/GEmgIjkwFyGAqCLM3uhp2QO8/kQDnnfAHldfzNmeuKeEnL1b8RT+qMHGClWD5BqfbQsVjXx4o1T3A4bwfCZ4G4mhZljkbq0lFIai6dcGOPw4dUW8510o5lPVzIpwfkpgfnAy/wMr+nvS3YcSJbvS4sVh/acXDKg1QSA6LhlIRCDUn6io53JVO4pKe9EAtKZvjUTHGpB0Vs3iTQ3jvUwPYAXhEuRGRmiWoV/G9nJCuZBxTRQpBxVBM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyzUXw4ml1BeBPFz8RbTD2SXLxxv1hgZyUMC3oIWxlk=;
 b=EWfh6g0DKuB9GuD2HteejudrxT4IxwFIVWaf7ezhBH1ufjXM4Vx6Nyrq7PG4AL+23l+wSmURwQ+m87mKkwWu1vQZtKNXtQO/0ge3ZanMrskmjRE7sRSlr7dtm1KoDrNZw1bauTM4bEy9r/7nvfzaDXRLFiTo+Ixv/kjbdzd9MdafvqRSt/u6FXtYhIpcyQbbuUeZTUTC48igNg9gBR9nWxaYkd+G6qY74SPN2ZQobEvtbunDLk4qd63JIX3evC4kRP0hXDcC/e4LyBI3CjkIVyUP29KBcUqcAE3B2lVah3ozPERyvkqerbRwdGQGjG4YWOYOSIvrk1UaFBOpnVfW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyzUXw4ml1BeBPFz8RbTD2SXLxxv1hgZyUMC3oIWxlk=;
 b=H9gPV88D51ZhLs4QWkdc8HvVqTHfQQDz1kLPfm8rBqDXaJ+ZUW61WyjTAnoOCupAub4qCylFIcxckk05gP/r8+gFE6SosYKV5QrU4Y9aJPDGCx8r/2wRFOURuzkLndYX3xVxbe5yq0oRr8MJ7xDrjTzqxKzfG1gStTv5QkIFK/zxBghh/2/aeLBYuhKQNOEZGA9adHDbqaGccJkCeW9lGw/2Qr87cYfLR9SRoQRi+F/JPSxVxfP1Mk3Fbmq98h52oBfyXo1EBDSuFO1p1b0+fPZLEs2vBUBlxFi2a5mVPOm8FCnsLzTml3U3REIUpAynHttjMUbIZ+3xISuapS0cqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 13:07:56 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:07:55 +0000
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
Subject: [PATCH net-next 2/6] net: dsa: felix: support phy-mode = "10g-qxgmii"
Date: Wed,  3 Sep 2025 16:07:26 +0300
Message-Id: <20250903130730.2836022-3-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb209cf-0a74-43e7-5758-08ddeaeae5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Akat8K+ltyWziFY38Oqdpt/2Z8voVpirRvPAY45VP6Oh0gqsD4QawnkdTyD?=
 =?us-ascii?Q?sXLDRuRp7YpInN26UcBoI04AFr7rw79wC9ESSDdBNmlAKDkX2PapM9pWdcF9?=
 =?us-ascii?Q?O9ezMXG53JZOPL1gnfg+sR0i0gbuttu42ICmuEFkE0RCjZKnFZfr7vFBa1GT?=
 =?us-ascii?Q?rfs1KafojC4D+Y6ZZz96NN7U/NkKpv9tJSj870kE5hpvT5qpzaMSpUkvQ8ix?=
 =?us-ascii?Q?qQB8oxDCXkA4YLn5byktJ2azO9zqU/AV7JiM8+5Jc0+qg2qOVKktfJ8t3UTt?=
 =?us-ascii?Q?mze0J6R5qdRTU/ApCFzW2Th91OiOpO1jvvnEyADR7wprMFLevoywdllveU3o?=
 =?us-ascii?Q?z/II31DrarEBOZswKSTdLd4hrM1QkRu/iLiz/1X9afrWIr3Wp0QJLyWTHCYd?=
 =?us-ascii?Q?vj4GOEkNse7bfIRoqoM9XHCdVBAKiaS3Jt936dqosPZNIg8wdIHbwRAaagCD?=
 =?us-ascii?Q?0/guzWOVAY3xGDcLhzNS+leWJ93WC2MaP0l8JMCMa6kZmM07rat6F0pXDY/v?=
 =?us-ascii?Q?RYNierhSGpwM1ieCM7PEgoXNs1I0efr0a4DGBLSdKvfVT4vWqybwbtuQ+O2D?=
 =?us-ascii?Q?2d9DKHUlYRHDQb5EOQ3Of88+k0tOpjKkohP7j6QUs1LLSQcKta2SBb5X6/WT?=
 =?us-ascii?Q?dxIgfnQbQ1vKY1AGFcqTMvXPjgH7Kuv7tIwOO8tRF7yzHZb9l26gDLNetwHf?=
 =?us-ascii?Q?CoMl6JZVt9YWi6YxBSwPUBUdO7jO59eDfFqpOU3NxJvWFEKVqUZy+YEAgV/p?=
 =?us-ascii?Q?cqy8EmsY9NY64YNQeSJa0MkdVObIZ6neczIicwB4OwGYSwBFs41aWIKLrPx+?=
 =?us-ascii?Q?Ojv7Ueihi7s9ZQ7Y+GBAwP9yeyJMjD7Z883QOwp5+lHuJc3uCKvWWJHDtX4d?=
 =?us-ascii?Q?Xto097eH4xNgYKCF6CTR5By+JgO2ebgh9qf+NuOsOPgAMhU7Mqa7Uhs7RBVw?=
 =?us-ascii?Q?vDDx/kN+VezxFSO8ONGvaOKF5twew0qN4Mouy1KPDIGEwHPABCAp/2mlR3Dy?=
 =?us-ascii?Q?TuyAsp3lVGas7w8NrMMh0vARxUoyELPL4yBYljvkNdysVBD4RjgNn1PPgt/7?=
 =?us-ascii?Q?9qKFgasK7Y50IVhDkBg5uaKS0ovY1s4Qt63IzPZaIZhsI01Tu/xIyqTtNdgh?=
 =?us-ascii?Q?gmQ8SX5Nss5ff/5zf4JB/9CFIdJ3QsqnOfByCJhtbz+wxT1q0IZPMK38bxbK?=
 =?us-ascii?Q?DL9GDmkJIHpQjYsm4YSIRk7C63YyGNx/iY0WrvEH8NSEl//gtAMoO8485pfL?=
 =?us-ascii?Q?tbcz00qGBTgd+tL6U5mOcwKelRYBraK3aLhB6zC/gtyeX4FYNIalrhxnh1LQ?=
 =?us-ascii?Q?q9LXncyCnfxYsp+OMYG10C1LpvJaFmtrOlY/n41xeVgq2jiA+wZka4NUB3jG?=
 =?us-ascii?Q?S1uxNh8MzImdgPmb2UkwMoAMeJ+wzUWVBkW4fIzBkq8LP8kLrIkcdg0f3/gh?=
 =?us-ascii?Q?IfXr9Tx0r6BzPsqddj+4BSiMLgSgvZFx6jlT/J/Q5AFs525WwPp2Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ahZc3DITfIjOn3EpINuKHHbEqh7ZbQtRdVucrtdyzGg27XiK5yt+CiQduh6L?=
 =?us-ascii?Q?0uMDe1yjmdd2v7mkid+dT9wmRJXtPTwPaKI7bCG1jcFTLf8hVYBWdMhaeDtI?=
 =?us-ascii?Q?hc/U+eNAy5B3A9urUiJq312yzT5fGKxlM5D8CLyks7nsM2iUn7XZm4XhSyVy?=
 =?us-ascii?Q?uwShjt4rm2pNWD+1SUG38hNtl9sTyxdIGri15f+p6yffpnmQeYC5/HJs8MT5?=
 =?us-ascii?Q?AMC6IT3D8LrzqECY+HhaG6sfHlJ3pMv4Up0YE++ChdP7mgZXWogJo68J/ZFr?=
 =?us-ascii?Q?/ha8FRTHlt6s82Qtw/CHoSmqjuylEc4MPZc1l9s97zJsnF85aGB52G4UUTsl?=
 =?us-ascii?Q?leQr01cMxk+LXNM7ckywTygPrD4b8cpFnZoaguD771J7KvNcfvDyKonwdrSo?=
 =?us-ascii?Q?Uy/s9WbpJTaooQAqpC42RAgHkbMiSdwMdsZzQCMqyH/2HKXpJHiVXC0LEy7y?=
 =?us-ascii?Q?QNDa15p0TBns23y4bxkRnXsvBoMSOUrXFg94vVszSakbN9qOVuclhYGTjPyU?=
 =?us-ascii?Q?BTs7+SygVzQ12FogXrJaiFn0AWNx7uUhBkvyjxrZa2HAbP6VTv8ccpkJhbM5?=
 =?us-ascii?Q?XC35ULNm/FnccU8s1Yg+CWDzyObOcpqmGS4A67yN4WV5Mk9w3evtipk6/V3W?=
 =?us-ascii?Q?doKuYZ2RlBTGYYOqkbBzHNhZqCVsfhjjJJdTwertJJ6BXmyTKmW/RCDHbouw?=
 =?us-ascii?Q?med+SXXkBNiPmfv7uS64qviB/3I+GZty4UGh8iFZ+eaYaqeJrsacsRnSZkii?=
 =?us-ascii?Q?ek1dbzJXC+YG6fF/iTd0FS1woMt20Nf4mO2uQH2Z7VK4FL0ROCoV6HTadj1L?=
 =?us-ascii?Q?BvtSIc4BW6uGodVO6L6NyB/HjagG3qwGmyp45isyX0wBpDRGS78LgGWWJ80v?=
 =?us-ascii?Q?Cee97240RF0/LBVv/fPpDMLPsblTDbKOzrQ0ETAu7g89ro/ErDKoo0f2yv6K?=
 =?us-ascii?Q?XsIjVUotKbVgg59QGGNZULG6JP///ncNdy20z3CZBhVZxnNYJDVygAz0uZGi?=
 =?us-ascii?Q?Fy8x/Yg4+s+XQAoukh+GTIYzb1eXjrpw+nF4Nmk31vTlJUuERc28VibZY9iv?=
 =?us-ascii?Q?yVpmrBmyLzjlfSul9NZ8vmSzvdor7nIcopMhQTw0zTiONSZ1EK0TZ6yUtq4o?=
 =?us-ascii?Q?27RbT4HC5YxM0SovWqAxgQrx2DCGdprnOzzM+vx0fxZycJcXR5wAmsD3VcTb?=
 =?us-ascii?Q?00sgCADI/nAReMPKvH28odUHKNQJufztKGSkNpiie0UT2K0DEwHWSD1pUDyw?=
 =?us-ascii?Q?1zg9M8C8c8qLYNqpjosOHpwQNN7Pu2Y9zb2tpraGkMDMmatjptIxF8StK6hk?=
 =?us-ascii?Q?ymTaZ4lrxUEh0WX5HtSgGOoeFLRNF0yY1nnKSiLQ8cf7lh7+fJxpoqkEuKos?=
 =?us-ascii?Q?Kv3nl1hIs2VFIOHjOdmGXFMxpuPfKu9lu+CY97K3QSvt2l6zhfTr+Ysr6B98?=
 =?us-ascii?Q?3BCHouX3Uhls8mK9zTsB6jSnPZKIpwgJv01tQG8uZ9Hj+ZV6Qw8S4n4D46Xk?=
 =?us-ascii?Q?NibRrMSL19lplWXBhyNqdAZg000UqfYre/9oEYfvAVAhoGDgu7kU8BRy9Uwb?=
 =?us-ascii?Q?CeJBzd37PIqyAyt2SdK7O0+96/cWJE2/vKD3MiJV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb209cf-0a74-43e7-5758-08ddeaeae5e9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:07:55.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olYJ8LNgA0diKDT/oKyQgZw6Bdi3hwlW6O/mk/WTHH3eO1GxNgfZvYW1ExrBGHkNXkJnpOoZl/X+7gMo5gSDOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

The "usxgmii" phy-mode that the Felix switch ports support on LS1028A is
not quite USXGMII, it is defined by the USXGMII multiport specification
document as 10G-QXGMII. It uses the same signaling as USXGMII, but it
multiplexes 4 ports over the link, resulting in a maximum speed of 2.5G
per port.

This change is needed in preparation for the lynx-10g SerDes driver on
LS1028A, which will make a more clear distinction between usxgmii
(supported on lane 0) and 10g-qxgmii (supported on lane 1). These
protocols have their configuration in different PCCR registers (PCCRB vs
PCCR9).

Continue parsing and supporting single-port-per-lane USXGMII when found
in the device tree as usual (because it works), but add support for
10G-QXGMII too. Using phy-mode = "10g-qxgmii" will be required when
modifying the device trees to specify a "phys" phandle to the SerDes
lane. The result when the "phys" phandle is present but the phy-mode is
wrong is undefined.

The only PHY driver in known use with this phy-mode, AQR412C, will gain
logic to transition from "usxgmii" to "10g-qxgmii" in a future change.
Prepare the driver by also setting PHY_INTERFACE_MODE_10G_QXGMII in
supported_interfaces when PHY_INTERFACE_MODE_USXGMII is there, to
prevent breakage with existing device trees.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c         | 4 ++++
 drivers/net/dsa/ocelot/felix.h         | 3 ++-
 drivers/net/dsa/ocelot/felix_vsc9959.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 2dd4e56e1cf1..20ab558fde24 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1153,6 +1153,9 @@ static void felix_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	__set_bit(ocelot->ports[port]->phy_mode,
 		  config->supported_interfaces);
+	if (ocelot->ports[port]->phy_mode == PHY_INTERFACE_MODE_USXGMII)
+		__set_bit(PHY_INTERFACE_MODE_10G_QXGMII,
+			  config->supported_interfaces);
 }
 
 static void felix_phylink_mac_config(struct phylink_config *config,
@@ -1359,6 +1362,7 @@ static const u32 felix_phy_match_table[PHY_INTERFACE_MODE_MAX] = {
 	[PHY_INTERFACE_MODE_SGMII] = OCELOT_PORT_MODE_SGMII,
 	[PHY_INTERFACE_MODE_QSGMII] = OCELOT_PORT_MODE_QSGMII,
 	[PHY_INTERFACE_MODE_USXGMII] = OCELOT_PORT_MODE_USXGMII,
+	[PHY_INTERFACE_MODE_10G_QXGMII] = OCELOT_PORT_MODE_10G_QXGMII,
 	[PHY_INTERFACE_MODE_1000BASEX] = OCELOT_PORT_MODE_1000BASEX,
 	[PHY_INTERFACE_MODE_2500BASEX] = OCELOT_PORT_MODE_2500BASEX,
 };
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index 211991f494e3..a657b190c5d7 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -12,8 +12,9 @@
 #define OCELOT_PORT_MODE_SGMII		BIT(1)
 #define OCELOT_PORT_MODE_QSGMII		BIT(2)
 #define OCELOT_PORT_MODE_2500BASEX	BIT(3)
-#define OCELOT_PORT_MODE_USXGMII	BIT(4)
+#define OCELOT_PORT_MODE_USXGMII	BIT(4) /* compatibility */
 #define OCELOT_PORT_MODE_1000BASEX	BIT(5)
+#define OCELOT_PORT_MODE_10G_QXGMII	BIT(6)
 
 struct device_node;
 
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 7b35d24c38d7..8cf4c8986587 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -34,7 +34,8 @@
 					 OCELOT_PORT_MODE_QSGMII | \
 					 OCELOT_PORT_MODE_1000BASEX | \
 					 OCELOT_PORT_MODE_2500BASEX | \
-					 OCELOT_PORT_MODE_USXGMII)
+					 OCELOT_PORT_MODE_USXGMII | \
+					 OCELOT_PORT_MODE_10G_QXGMII)
 
 static const u32 vsc9959_port_modes[VSC9959_NUM_PORTS] = {
 	VSC9959_PORT_MODE_SERDES,
-- 
2.34.1


