Return-Path: <netdev+bounces-248791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C559BD0E7DD
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DA5B300285B
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76203331214;
	Sun, 11 Jan 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AY87r2lF"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F37330D26;
	Sun, 11 Jan 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124500; cv=fail; b=KoKBFemVoZ0lXORfl/jpMLUw0788oYmruQjcZEi+7dgYcwOwTYmK5xxBu2ueD45CCDivMkSmtrD+5/WTCRrr/G8cNNYQyWiDrN/FcM0qYp+T4xW370rETXIzci+vauTSpTt6qEuGoeGeod2jESk71Fvg1yI6tgny/QZbvtXbCFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124500; c=relaxed/simple;
	bh=OLWpOWNrIPjHAtXMQ1xtayp7gWxwwVzIsig4jG3E3DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4E4q18mZ31N1B1bxtOfw0lxV1Y4mNInRMG0qW8sPwlY7IldLoSSBaN26Ha0BBnn4SK/fwMEEkrmtqSpHPO4JOo/UnnYhUI/YmliZPp1Vbs9ErfG1A2PlFxFmv4tNBtICw7eQ/a8HbMoJR5ZDYyq4avJB7J9vMksRplvdlm903A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AY87r2lF; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQziCKeF3CmUTWN2loIBrL092DdYiTH/p6EfWXPbpQCXjC6HOEQu3XzRn4a2tjsiosi0h8UW1/t68DawUNTQdd7Nj/lLwY/YeO3zFOPV71ufaG8mDo1e/a8eeI/s2u6cM82PUV85tFiC35gWvkfhingzvU5EYBaF0KCmxUb55jjVcD4yPMC7NLJJ9WO94cnDJht0M15y+mhaAk3dTquwm/mHGXvCAj34YONvTpKKMUniZStc6OP5hVKClOMZYd5V7Ekw41mPbPFmDon842RpRwEPb8W9Dp+s9hj0z4z9kQHV5mimLLv4PMkj70LVwzII5qqRvQdJYACRLSeOAfcYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM9ZCwtVU2LRfERPCwmpkHJS+FrtucSSUvGriP+FQmg=;
 b=FTFS2j2Sz1aXTmx9/dw85CagEG6tIArKLDxH0XOBwVB6OINSJcgpzV0cqHVUkhKd4aKtRW3bycbJeEcx66FmkJb39/gnvwCD/QWoiODE38jCsTi+qonMnzFyyN68nEWnq6qXFruHuV4v/VTqyhl2YzDQBx43tU0RvLqkq7esuNnQAVk2Q7UQ5+K1RNdoYXdPQNuN3FyCgkMGsXxv3EMRgct0c3v2Sa2JiMLiMJWpJusV1FOi3qNo69TupaXpE1nHiAyhX/+XH8zwa4K0VZ8pITG0RaX22V2VETTJFeuiv4Z5g27/V1AQFW4CDY+TDwu0KYGHWBhY9NJ98E+Q2nkk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM9ZCwtVU2LRfERPCwmpkHJS+FrtucSSUvGriP+FQmg=;
 b=AY87r2lFEL74fPqE6L5JyR0PAfUvtar00Tz2guKSXeLqvF88aZoFyTzGiwNILlt81pTAuUfsm18pmHMWZd/Vsicrcnn5hyQILLO9BWCXy1uEGS1ylrWqLMRiO1sEWQjduZa61DZhL7q1sEHdA+2RIvBD1pY5Pl6xDfqVi6OMuc75bfAvG3D5BoibAMk9YeiqnDAx5WVMyZiowFiJm4whLUDw9uNF+bAfyIbLyauR3+jal1zRoJBZGh77D9dvIEDMvbMv5KcdKN2b3ZrzgztWHm+vcX+ztOKKtg4P8jqc4ilFshQ5Ph/ebhzbNiUq7pTeUE8uoo9lMJ3RZdPI+o2ZUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:13 +0000
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
Subject: [PATCH v3 net-next 09/10] net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
Date: Sun, 11 Jan 2026 11:39:38 +0200
Message-ID: <20260111093940.975359-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e82684e2-ccce-47bd-7235-08de50f58ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?umcU9QgdBwKNFfcU/0DlWRik9E2deD+9k6VHpQc3k/8bVj8azY+48wLZgF4Y?=
 =?us-ascii?Q?jene3myTooNJo7SX5Rpy+6BR1tL8tLEQIeIXo+tq3JhMLdktNvBOD8lWmqLr?=
 =?us-ascii?Q?zcGVPOrtblkwJK6Be903X13WHhmuqYfPnhFvMR/LtOge15BY0Uu11ixGcacy?=
 =?us-ascii?Q?kEhau9N48VIIHlE46NYhVxYJf2c8m7LOy9IZW7HrGuL73YwDv9pPUCgaryQm?=
 =?us-ascii?Q?UMvZODaZV+beWQ13n5pF/ub9cv7RHcVacsDtjENif6xycfGuHPAhdZDaZtdZ?=
 =?us-ascii?Q?i4NYc9DH3XIH6tgtM/Sn0r/PZDEPbsF+XEhh9ab48+hidwmXxxpOKjIjkoa7?=
 =?us-ascii?Q?6r6stj8j0JJxvWoWhvFX9tIo/fs9fJxKjTkq+OQD2SQzcH+ZTcVQOFO03l8N?=
 =?us-ascii?Q?11x1EqQWwMrFXMgbU6beWAwlHvwkD120bBAb4Le4A4R3lGYXy8Kfhhq8BKSa?=
 =?us-ascii?Q?X/5T+fOyHvWsKYosLYLC7bhJdgWQ80E7OUQHdLRmskquTzAmysBwzpxxGGto?=
 =?us-ascii?Q?YWO4t92FiK/c1Yqm2LItmbKQ+Ns+55yQ1gnN5C0yXGbaExEnXZ+vSQtdSkcc?=
 =?us-ascii?Q?8Ae5BsZg7yGaZYq9nceUDOOnhTeshgPLqIhg9b5Tl5P6wHSKzDqPi/lofCqd?=
 =?us-ascii?Q?3db2L9IXAevF0KlC6KKZTKOJc5M8Vrm6H2HHHO9ligqDRyJ9LvDRvwoGBvkO?=
 =?us-ascii?Q?FvoYpq9STPHwsXBptiz+2BiHmHD9b1wg/+sfG0puwUDIZ3at81zlBusDj2q4?=
 =?us-ascii?Q?cNEN7cI3elw2WgT9qL37bbcLLCTnCV13ZoY7xHViSDiJ0QckKoSIS6TLRq0C?=
 =?us-ascii?Q?7GDVZjEGnKVQFUmTLE0n+7glshUfVUeNUu+XQiQOCAWVux1+ZExJFXbwYf6n?=
 =?us-ascii?Q?sgBtEQVlYvLD3Cs+ttQ8B0nmRZ4ErWh0Vdv43WnoXiPeDirLdWYAJ/UGNcoY?=
 =?us-ascii?Q?brplK1XjW1468TskZ18TtHJcqoPGwPgpy1jMIJ1bArEv3yaupmpQu0ir5FvI?=
 =?us-ascii?Q?kn9WRAZeKNAbKcPgecdUMhrRfF/iQeA899CNBLWbfAO5fBBG+/Pcq9RrK346?=
 =?us-ascii?Q?Lu7i4K38YYOqXx5x7LtHnEhvc73dr8S1Okbb4kjZlKzF6JsSOQAtICjE3Zsz?=
 =?us-ascii?Q?nnubktykupqJhU95/LNu5md5fmNtXI8kTGiNsg7aHPwH8hoQYqieM1ZV+tT6?=
 =?us-ascii?Q?xs/NOV4xnJip6/Tnr9bi7gd2cdyNwRzvkQcJhOop5vinihCu9s8g3ErpHMdD?=
 =?us-ascii?Q?IYlONEusSoUn7wKhb+z09qcgTiicKRFkyUIROcnG/MlcFTGzHBQ7+v/mY7rx?=
 =?us-ascii?Q?RQlVtEULE1nT1j6HUbYgYwgcYSja6xbSmN4uDePr87qZg22Wh3xZnf0J5oCg?=
 =?us-ascii?Q?Baj8Fn2RP3Rh++RC1kJLTlR0Q/o0ldplVcvtZXPD7FmYfJZs8Fim/9o02tjM?=
 =?us-ascii?Q?zjSLy88ZqNac6AuHdwRimoimMQOvq7tq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r7tq8riw4Xy1nhPeC94lMjDY/o8/pKMOblHKHhzSXCzNKTlombX1BVSPIekb?=
 =?us-ascii?Q?CrM/C2Oru2gIzjPMTofdaaG13LBVh8shffI8Ec0O5FXqYWqXAd64Q60xLl7k?=
 =?us-ascii?Q?nmiUpAIB8SlC2vlsqBLLX/9Ppnxg5VOBYLaKdu6Qk9S1gvkGoGKmRMStxIeT?=
 =?us-ascii?Q?s1jQD126gWo+FPUO22w5LN0qHem1x14asqE204ShAS7uKGOkclqn8b4wVvN+?=
 =?us-ascii?Q?u8kZBcDdy+KeVqRiXDrhoSYtPl1XWZS9ufclcN1sb1PAYWZNw6++c1P31dJT?=
 =?us-ascii?Q?vn2hntHWLHqLxgBdvjllFyjMbkfY7gdUMpuxUkyIFCNyyKwQBCkBtkCGLDt6?=
 =?us-ascii?Q?XwWIb6WDxvs6nLGK0dSrdV0M+6OP2dQF1tlHfmYdDSRjpkn2MSrYQ7YiIUYu?=
 =?us-ascii?Q?Erxk75266qZ6PqQ6VsX+r5AcVke9w5MtVL/j8YQ7LMNCs3h6VCoYTKurz83t?=
 =?us-ascii?Q?wb+mlaee6A/tJTEX/LHVWQregkVVgURHVcr70NPALs0bYcnUmgxghmqWN4+5?=
 =?us-ascii?Q?y7obMrV6jFvak7X56ld6PHHqX7REQ+5119b0s7wK6655yMIDd0rPh6YYA01S?=
 =?us-ascii?Q?qTcrwHOiw7z3EM3vDdoMIHDvV0LaEy/44pKKECtTNDkJ5I8P8Zm3SaCwnAJp?=
 =?us-ascii?Q?bRDBxxgrKuscp5G5BF0ugQPpJRMMv0shOVQFNCpHwvulDZeRN2THXyV2sMFA?=
 =?us-ascii?Q?yWqSi9KLP6EYkEux+jNmRPilqLvHjxQcazU+OLSmTghs7LRW1q0JRaz0V4HR?=
 =?us-ascii?Q?2WreFHRUMQtE5IoIn0+MAkAPV9YV5tZa/mQdsW+QRYAttusa2HIm0gGOVZnj?=
 =?us-ascii?Q?z7RcuTVvpZ9LFIms+aEdgT862RUHOrvz5y+O8Xo5v0ZdY1BVHne2+SuVWyIi?=
 =?us-ascii?Q?Zt85AegUiFIY12A+gesP0q/qsUP+p1qPleiFDHrLu9rBqYm9Ea5J1Irt2oee?=
 =?us-ascii?Q?WvGr1mbQBpZp9xCtvXX/u0v8mubiH6FjhpksjWmFdrYynoQqfU37wMpj1QkJ?=
 =?us-ascii?Q?Z8oPigaFC+cQI3HPnE99esEQYgdh/SvAN6lG6REttbZ8T2uWL5akwhfeQprz?=
 =?us-ascii?Q?ZTvIsKdCGDWjCvnvdD8d4R0FwRM4oD5RKOwklw0R35kUhf7FYC3beZK9JSmS?=
 =?us-ascii?Q?NH/mMTM8ooNK9y++nuf1OtVjftctq3HVCoVqgNvvQSeAlvZIKjcc1OwKB+px?=
 =?us-ascii?Q?GEJDQhCg4g2zmKhwG60kbUcqxNbJg26vPgra0PguDaAwsEnUBxOp6q3mxhZ6?=
 =?us-ascii?Q?Ifq7qNtMwA9QVxAt8inrivVGyjGMc95JxXN76YrwJjrOtANoFsgZ5Oy0E0mU?=
 =?us-ascii?Q?YGNST0RY1XkKtkfNS9NX3NoBI48Ox0jkyc9nCZQbD9kwwFgkyBbsmn+Q0Nzs?=
 =?us-ascii?Q?TiyoiJFZSG8bCuaHzusZwdecAVIc3c/3EfTCeqjd4pQyz2mmcWqvc54+kU3C?=
 =?us-ascii?Q?b6qSzbWyKGIlt4gqNvWF126Hs2oAUd0wPUhVJBQFQ2uUoK8y3k1ahDc0owWs?=
 =?us-ascii?Q?7jFyE37ZUzmwmPHhX1yY+NOHpHgL+XIW04xc9Ci36gjHQ6wnk8ZHHtOua6Wk?=
 =?us-ascii?Q?wch3qPazt6n9st7PnkB17Hx/ou+qDsn/WvheQKlcQvWa95Gvw11/wkjWOmc4?=
 =?us-ascii?Q?pyU87LnD1qpeg24yW5lbyiVJJQXNcr0+uCrGAoah9XlzfP8QfBbYOAiPF9Zv?=
 =?us-ascii?Q?/rNJOzBaOcU5/gGSg7C0KS9zNIN32LpriUlN/nSFuz52NS8D2/Qx5cDvg+0k?=
 =?us-ascii?Q?jyu0ozkuEVoToJxEA0S3LvYptyM7hy4vfD7Zs6ADJXDNoThbsHe7BcGeql85?=
X-MS-Exchange-AntiSpam-MessageData-1: KC23hyY4fxHm4bX6o4mrc5+BbvU4dJYu/FY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82684e2-ccce-47bd-7235-08de50f58ee8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:12.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBqZMqLy7lbX7zX7uafhAj+Zj6cdPK4hgqBEQvt3LJmUR2pe62cf5SRyFwrKGm49hi7fXPJos9e0NRotOySh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

The Mediatek LynxI PCS is used from the MT7530 DSA driver (where it does
not have an OF presence) and from mtk_eth_soc, where it does
(Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
informs of a combined clock provider + SGMII PCS "SGMIISYS" syscon
block).

Currently, mtk_eth_soc parses the SGMIISYS OF node for the
"mediatek,pnswap" property and sets a bit in the "flags" argument of
mtk_pcs_lynxi_create() if set.

I'd like to deprecate "mediatek,pnswap" in favour of a property which
takes the current phy-mode into consideration. But this is only known at
mtk_pcs_lynxi_config() time, and not known at mtk_pcs_lynxi_create(),
when the SGMIISYS OF node is parsed.

To achieve that, we must pass the OF node of the PCS, if it exists, to
mtk_pcs_lynxi_create(), and let the PCS take a reference on it and
handle property parsing whenever it wants.

Use the fwnode API which is more general than OF (in case we ever need
to describe the PCS using some other format). This API should be NULL
tolerant, so add no particular tests for the mt7530 case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2: patch is new

 drivers/net/dsa/mt7530-mdio.c               |  4 ++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 19 ++++++++-----------
 drivers/net/pcs/pcs-mtk-lynxi.c             | 15 ++++++++++-----
 include/linux/pcs/pcs-mtk-lynxi.h           |  5 ++---
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 0286a6cecb6f..11ea924a9f35 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -113,8 +113,8 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
 			ret = PTR_ERR(regmap);
 			break;
 		}
-		pcs = mtk_pcs_lynxi_create(priv->dev, regmap,
-					   MT7531_PHYA_CTRL_SIGNAL3, 0);
+		pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
+					   MT7531_PHYA_CTRL_SIGNAL3);
 		if (!pcs) {
 			ret = -ENXIO;
 			break;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e68997a29191..8534579b8470 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4991,7 +4991,6 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 {
 	struct device_node *np;
 	struct regmap *regmap;
-	u32 flags;
 	int i;
 
 	for (i = 0; i < MTK_MAX_DEVS; i++) {
@@ -5000,18 +4999,16 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 			break;
 
 		regmap = syscon_node_to_regmap(np);
-		flags = 0;
-		if (of_property_read_bool(np, "mediatek,pnswap"))
-			flags |= MTK_SGMII_FLAG_PN_SWAP;
-
-		of_node_put(np);
-
-		if (IS_ERR(regmap))
+		if (IS_ERR(regmap)) {
+			of_node_put(np);
 			return PTR_ERR(regmap);
+		}
 
-		eth->sgmii_pcs[i] = mtk_pcs_lynxi_create(eth->dev, regmap,
-							 eth->soc->ana_rgc3,
-							 flags);
+		eth->sgmii_pcs[i] = mtk_pcs_lynxi_create(eth->dev,
+							 of_fwnode_handle(np),
+							 regmap,
+							 eth->soc->ana_rgc3);
+		of_node_put(np);
 	}
 
 	return 0;
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 149ddf51d785..7f719da5812e 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -81,6 +81,7 @@ struct mtk_pcs_lynxi {
 	phy_interface_t		interface;
 	struct			phylink_pcs pcs;
 	u32			flags;
+	struct fwnode_handle	*fwnode;
 };
 
 static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
@@ -168,7 +169,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
 				SGMII_SW_RESET);
 
-		if (mpcs->flags & MTK_SGMII_FLAG_PN_SWAP)
+		if (fwnode_property_read_bool(mpcs->fwnode, "mediatek,pnswap"))
 			regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
 					   SGMII_PN_SWAP_MASK,
 					   SGMII_PN_SWAP_TX_RX);
@@ -268,8 +269,8 @@ static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
 };
 
 struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-					 struct regmap *regmap, u32 ana_rgc3,
-					 u32 flags)
+					 struct fwnode_handle *fwnode,
+					 struct regmap *regmap, u32 ana_rgc3)
 {
 	struct mtk_pcs_lynxi *mpcs;
 	u32 id, ver;
@@ -303,10 +304,10 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 
 	mpcs->ana_rgc3 = ana_rgc3;
 	mpcs->regmap = regmap;
-	mpcs->flags = flags;
 	mpcs->pcs.ops = &mtk_pcs_lynxi_ops;
 	mpcs->pcs.poll = true;
 	mpcs->interface = PHY_INTERFACE_MODE_NA;
+	mpcs->fwnode = fwnode_handle_get(fwnode);
 
 	__set_bit(PHY_INTERFACE_MODE_SGMII, mpcs->pcs.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_1000BASEX, mpcs->pcs.supported_interfaces);
@@ -318,10 +319,14 @@ EXPORT_SYMBOL(mtk_pcs_lynxi_create);
 
 void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
 {
+	struct mtk_pcs_lynxi *mpcs;
+
 	if (!pcs)
 		return;
 
-	kfree(pcs_to_mtk_pcs_lynxi(pcs));
+	mpcs = pcs_to_mtk_pcs_lynxi(pcs);
+	fwnode_handle_put(mpcs->fwnode);
+	kfree(mpcs);
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
 
diff --git a/include/linux/pcs/pcs-mtk-lynxi.h b/include/linux/pcs/pcs-mtk-lynxi.h
index be3b4ab32f4a..1bd4a27a8898 100644
--- a/include/linux/pcs/pcs-mtk-lynxi.h
+++ b/include/linux/pcs/pcs-mtk-lynxi.h
@@ -5,9 +5,8 @@
 #include <linux/phylink.h>
 #include <linux/regmap.h>
 
-#define MTK_SGMII_FLAG_PN_SWAP BIT(0)
 struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-					 struct regmap *regmap,
-					 u32 ana_rgc3, u32 flags);
+					 struct fwnode_handle *fwnode,
+					 struct regmap *regmap, u32 ana_rgc3);
 void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs);
 #endif
-- 
2.43.0


