Return-Path: <netdev+bounces-248788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F2D0E7C4
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DBC0300673E
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FF330B0E;
	Sun, 11 Jan 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gn+uqhNm"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EC322B7C;
	Sun, 11 Jan 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124489; cv=fail; b=p6EyXLeTmglTkgKZOln/Yb22VpWhw9tO6zcuopuDENzyHsgkw9LCevUwAL+oZdrXl1N2DFmlwXKrYItmaR5LuM0O3MgqgLFvcOiqqDgfeeH7gOuLRsHESgqJnA+1kJukQRQE/2LHqBCN4FuHYLCIA/FuASOelNxYWjv5xbZsBgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124489; c=relaxed/simple;
	bh=WqA4zNLUeL8T6Hv0tDzaamDLNKwVKaBL0Lc/aUxTEpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uV1sqnzpmnjInc97nwVJBmhcst10cc6yjwujRrVFgvCzjrR17zVSqxIdtS0IN3l+vtHD3Buw1gWNLIvIy5FI7lOqcHRRe5pO/LiKX9cC1ZGW+lJdWCCbLjDL++BBFI757a87PDkFY4fVZNKpDiN6lwPPTacpjJaR3LijmGQzE6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gn+uqhNm; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2Ghqm42Qpr89oiRmLMm6a+l2u0zYYfBmJc9A+cqJ9UkiRpM26Luy5/fLpig/c5HM18lsASL+s9EJ00abobthHI5vh69PWDNIMPCpG8sJMLzm/yaAwl/ZkhER3lLVj81tfxecCdv9S1ayjYQruWavELy2+PXEwgQe93f5s4ud6IHy6k1Vsj2p+FSIOrf1WPh3oH7Et+E7Vozpgn+MkKd/gISq33G6MczK5V3RWjmVYiJiRGJuG3D085hKHM9y0qZ+45G6KWNqMLCSLA1iS+p5VjIaTRBbrOthzx29wIH8QrMcXeQOGBtltj6RVqxannHCuyHVksOT8ItjcWXzzbCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT/yD4vMfhWWxL7AtzGCbx0DIFOEd4tZwwsztubyGDk=;
 b=yCyum5XCRIIphwzb5MIMDug6+fFGlIacpSAowc9LGhPxiYTJTcDsf48DZSrkrob8xjYGM9f3Argm8adAeqFpeHSv2DNw8AjCaW8i3b1VnqZ4T0FVK7hlmaZhSC40bRSOpHZFcxyBAoaq5slcVJVhLDK9wu+ZPn4UWGbVcxEPoReBEfe7UU4IFeyqD+cATieZthhOQ2ppPBnESQJWa0YDnHzYhD4cyMr/SYXohfyvIzydW/A7lVSbxQ73uKIvAMlKLJMYeigZfGChbGOkOO8S+J2Qv8cE7MKYUIfjbLAyRvb/Y5hmsI3mqwUIZ2CtkwzgVuDk6Gq/+EQSY1zWnFxyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT/yD4vMfhWWxL7AtzGCbx0DIFOEd4tZwwsztubyGDk=;
 b=gn+uqhNmsADAhBuY+6Qjluj3ux9RGgtmO706PSm/JDa30UaYCIlFMuewtO/8ghGFTuXcMH7u7iNRsK8IbZ9p6clMur482IDj1SZTNFTsJIE6/4d4oFEtktiDP4nu7HoUcmu2KQjlsj/smj1e3TDsaanx5a2yv8K+uR4j70NZhDUoOYwawBjDw+dp2aflBJrLaYl42dXVLV2ZuL9JCt6Pws8BvSJPouM2JhMnT3YqSLtSiB0ddLsguJwHWbffPyjZp4m6n2xcFzpubShJP/8N3K6+8aVQj/5phOeo+z/5iUOvaoBTzgrhgp6hgTLPs/Ky4zU6NFVlqAPGsMbePpYzhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:08 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:08 +0000
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
Subject: [PATCH v3 net-next 06/10] dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
Date: Sun, 11 Jan 2026 11:39:35 +0200
Message-ID: <20260111093940.975359-7-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c2a5371-3df0-4e44-3717-08de50f58bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4c91MhSWBB0ILkXD9gWkjxjRxNT0sVxGiGWdqhVpNRRYrIsJmhCstWk0hmgV?=
 =?us-ascii?Q?L/YcCEi0FkoyzwDCQW54oxYgzNqzHqxf+T7xZHBFYXI73CibxmQeW9Ti9KJZ?=
 =?us-ascii?Q?vgIlYeZUWUmxpg+GHJQSPIqoYHGMG13CF49FKaKWqyzbxiktaHYMyR4h5ITw?=
 =?us-ascii?Q?a4KHOM79xXxK2LXt8dTdIiRq6X8qbPxbsgiVUm+8bp9kWcLCAhJ74vrdYFvy?=
 =?us-ascii?Q?4PVU2MwB3jjLxFvk/so/d5AuI4xviRVPjY2Me+Nxk17etcb4eSpjmqbVX4F3?=
 =?us-ascii?Q?m180dHSdwsszPP+9rEVubImUkjZPIBVRjYqKzU3jqjDRoZIQNmj8xwlJqF/Y?=
 =?us-ascii?Q?/2gvfHd/xWXOTz942NLFyh+wSvp4RWtfi1B6EBVkZHdMP+FuWIccD5nbHh06?=
 =?us-ascii?Q?GtbfGPWk/XOwMPYboLd47MQJlsLedd6WEPkdxJJ8M488Oobi+cy4zQnMMQD7?=
 =?us-ascii?Q?Qud9Lq+EzrVUL3bS9HQpGCwxiQUv0hfBHJ5Hanv1nUGtGC6JNeT91F3/+26e?=
 =?us-ascii?Q?Dj3IcWCpQHD/CulmPvAmoBxGKDf99rQ4SEvGGDMQgM4UcKcMunEMbSt0ysFC?=
 =?us-ascii?Q?0HG/CjIbredOE6q/JXeGRKZ5y5YY/gJIVBZdDYZNORr3PRF6O/LivvMi2ps8?=
 =?us-ascii?Q?EDlGDYv9UJkRD3tZzcMQKaZwXhM5p8IMDqkgJ7kqUI2J0gzMo/J3gewv+tp9?=
 =?us-ascii?Q?BmdEq04njm7mivIp3liqksbAANdlS6Ui6AGrUv/8XvisGYHVyawqBxozT9qS?=
 =?us-ascii?Q?7FR6awJr0f2XaDa6UVQy66iAbltRW5vYdAHeruZaaqVqZZdPnhEUHq2j2i6C?=
 =?us-ascii?Q?acburD1Pl9j2TFEBJkADApmR1iRR1OJuLPirUrPXOfjClmvyf9QNwzHugXRz?=
 =?us-ascii?Q?7MHUTmd9hpP3hf/OG7dRmTMQTZBC+3WFDUyMYos9AlIJwOtoddmmdKAqcx54?=
 =?us-ascii?Q?K/mPpGnFdKI/L/se+A5wJOysiZW83Y2p8vNHLA6BtctYsz35x5i+7NmhuSMK?=
 =?us-ascii?Q?8wpjIo9KtlICf9Ja5dC22xIOfsx+4Mk3vXKMQOe/YNnhpZ41PtbBSnuLK+qJ?=
 =?us-ascii?Q?spQM86JhVfmXjsFvx2thmS+0aVzTkwFZ5RharW54CRaF5ABPVmj8wY3tovBx?=
 =?us-ascii?Q?HdI5xClxQyHX5uulCqdOJfAlopKKunHRhKX+IpNuB9D6T281XiGSxCSevKnf?=
 =?us-ascii?Q?vkpiXzmQIf1uE05NgE9FxyQX7Mxx8rM/qrRMk933FOUmKS0TZzQaf3FKclb1?=
 =?us-ascii?Q?vo6xmVkR9e2aJLSF9zQdZZ/Au5+4o+QKnG2Fej920/xNa1qwCKYqTqdHtmh2?=
 =?us-ascii?Q?WbjDK4up37M1d1dq6Mv7dPTg2HIHtUtKJvdwuFrhJDFgxkrSFeESBOHsiSYw?=
 =?us-ascii?Q?SwR3tywVgyHNiW1oUdtZ81hAM579mX2rM8RQaT5aOdvYD0mRjOgwBfGnH5/I?=
 =?us-ascii?Q?+NYsj5U/IgJPpTtkFesdBsObSQBhbsXz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/4dJFLqCVLE/HK+9KLJ8zeOYZaIo0jf22AWQQnnIJf53y8fbuD8MgDUVvumY?=
 =?us-ascii?Q?0lJ7NrqO0n4tfp4zFt/YH+ezFv+zMEcoU1HkJHvJhNQ3Uxeq2t2NSKcsSPrZ?=
 =?us-ascii?Q?13qFdx+FHBGzgbOmG+/dGrN7ocYVkqo5oADx9wqZfegvGB7994ahQg8PeUyP?=
 =?us-ascii?Q?wiBrBB0ppQRlsE0ktf5t1C23EsE5yCl0Ip9IIj+NptOmuaU50iCLIsaQDrra?=
 =?us-ascii?Q?UfSfdCKe3K5nQhgxN7F0wTQn5LZ5RwV2AcFu9vo6ca5PtFOoVOnF2Gq1OpyC?=
 =?us-ascii?Q?dG+07O40P8rhasAW+3vJKb29avZ2OmCC/h17oyHiCn/Z8SFOABZjmy4Zdyni?=
 =?us-ascii?Q?aRTLtlVrLWcPur9N9JbsIlEmy0Dhnb6t83QVlhBJvigJVnir8u6msDzEly7X?=
 =?us-ascii?Q?VP+oX0iVNLj2wzrfsMh3fTQuDBUhkG4Ndh/tG0XrWEV4Dg5PC3ss4z2iUS/o?=
 =?us-ascii?Q?T7o8Op0PuN+5VE67bkQ1YypNO5xlwfbv73VVsKvxpnjY7Q8/e+QkoOD9EN9+?=
 =?us-ascii?Q?lwGVHd2KONH4xtDTxne6Ap+iaVPmDbie9S1izgkUZEG5Tx/UW7WXqfpqFwS4?=
 =?us-ascii?Q?WaBsjQEyduJRfg0HjqxCCB2qWrh3coQcSdEH4KekqVVAHMmN4zUeIcKOngs3?=
 =?us-ascii?Q?TH4SR4WAJwpZpFNqjjNHSUabYMQaiRHJqWv7v8FseHMGSdK7kW77aa9U83OR?=
 =?us-ascii?Q?au6sdLGE/my62X6KDQX9pO5w5lVVlsG7RCHgne7mIFrmNNTEqCfqAvOZqWlu?=
 =?us-ascii?Q?/eAyylyACsoKcLl6XURoD+CD02g5k0UafwTCMIdPcRw1fYvRgbBdex1VvflJ?=
 =?us-ascii?Q?MadsFchyyR6JJmuFqCup1OWMUsvWqtndMEDwU+SpiMrJxHBrOUAZDFcjJB85?=
 =?us-ascii?Q?Nk+7Oe6o3SKwvm6A0CX/Tgp4BOcEVZN+AVG3C4jwxl0ZoLY+kSjVoz0ig9Sm?=
 =?us-ascii?Q?FQfapylyaH/mjKnnPFaOb1ddAsVqJk2zJbOQoLBfh+5RMLbRxzBZzRccj862?=
 =?us-ascii?Q?W87qPltEC1B+v4qfOCVg+jumuBaRyZdtQo6zF9fYUl+dRsFqT0p/Uplt1IKs?=
 =?us-ascii?Q?bxt8CUh5DQVYFJ9CrLssP+eLT57ouFdV6+VLl8+HHEdx85J+uypntnNQnb/J?=
 =?us-ascii?Q?RAjrW99SHomqY+4rmlqIi5W4VnEFlJM2sCF8b9QcsaQUP+6mthvqn3L7VQM2?=
 =?us-ascii?Q?s4g3qzmPIV5aBTjVqWMEDKGtxIyhiVomOl2m8yLKvGBE+fYRFNz9xLQBnbJH?=
 =?us-ascii?Q?4ZroKTix4mTTDn7IAa7jn/ZI1WIDCBdT9OrftA+gIMfWgZX4nowOvSSmpGMV?=
 =?us-ascii?Q?Zh7hONVQ/mVsfSIJdVpbzBeFpWiC83S9I78oY/hF0HCNSrSSvr+b0k9OFF5x?=
 =?us-ascii?Q?EfWQZulfAR6xGMlNO0i+lpuWfomXZDIKkGiGtZW+2hRuTzl/eMxGnbY6bgAy?=
 =?us-ascii?Q?MPjX16YTUO5c+ApALiKY57wY6DJkJS07obNkoY9NvdpbE71Ycr9xYp4AZC12?=
 =?us-ascii?Q?oeFwdDg00Dul8ZxMLeRRISS8La8DGHoft7PKB2RhRT6fvt9YjIzukx+k0TlY?=
 =?us-ascii?Q?JZRXp7iatJLdsnJrIBIH9FDYkxck74BSLcAavnsIEFTEFDUpooPPBdNEvE5M?=
 =?us-ascii?Q?HB/yW6zj90gOQqVz2ONUYRW6fmm54Wc6nEX5ntwR+SD8T25zaD2DvBn0Kj0r?=
 =?us-ascii?Q?OcTHorvU+1dVONRoRIlV2AdVv7KrQE/XPco0P32xZ/lFT0/UIRVsiEv0lGlF?=
 =?us-ascii?Q?ORQZTW3504rDJdExCF6UMCG+RF4cTUs2ez8lrQh4SxqPkVhkbCGtGUveH1CD?=
X-MS-Exchange-AntiSpam-MessageData-1: 7cjMPVHdLz6pePOw9PHHH/421AvW8/FbXm4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2a5371-3df0-4e44-3717-08de50f58bea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:07.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81i76cuYtYBV/4B4Rn7bKvKssRt85R+l/tbGsduYJEUdVqpaXPX4yf2VU+y1WIh2iab5x6JgJZ4TC5MxyFAMug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Reference the common PHY properties, and update the example to use them.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v1->v3: none

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
2.43.0


