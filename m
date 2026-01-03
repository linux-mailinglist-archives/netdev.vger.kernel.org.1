Return-Path: <netdev+bounces-246692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648ACF0604
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6184630376BE
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A72BEFF8;
	Sat,  3 Jan 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IiXQxnAV"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197B2BF3F4;
	Sat,  3 Jan 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474325; cv=fail; b=UjMsIwJIVALC0CxsrcIjeQCRKCa9GlXvrfsf7LtLbq05J+MKmD3SfpR7ct/DeBLKeicyCkAlg3ErTjoqIi38+mnPDNVGaEojMuG6XOqT/+og4oJveTMTWtRF417ttjdZgbu9O48zMiaJ60fnucBlT8lEWnQ2izvzHmF5Bw9ueTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474325; c=relaxed/simple;
	bh=tp3vALWMvb0nBVtyAhFzCyA+Eo3jyZN8vQ2ZmPq05I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDtPN5kD5zCjEJuMHFZiMHyfAY/NBeXHrgvvtvbzW4HJqPBMqs7dKMtmRbo0dNWYNBg4wYr0/1OcSniXMf0609RZ+j9E8HYdhBsoXb5q8xevzkOx+9jI4HgVXTBvm77SkipXKOR1JwPVTI4ACpP85MbC4sskVaN7NEYbHwadMOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IiXQxnAV; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQ8S0UY6AJoeL1PcvC95nn+IViLdjySLux7sGnhICYRR/LtwTAVYXJG8d68N5VzCPhOHkryZJ5T35PNrF7HYTB4SZT/xTVmN89f/lFIPv57/D/qtxRWFpzLgkDb9yqskxtq/3n7NKhrsOQERc4CISV2D/j9jNEcjXwSsRjm4e9Unm+ul8s3ARYbYbV1gv5eYU+nM0u3fahdM9nzGTIxqTwNVhqDFedYngsqRmYZk215pS6PsDjcWgRwfzvyhE6h2HJnpKKtagTgqjGFtBv5Lex1G5mOHyQerC2je2IycMUzFXS0IuBv9nHm34S2QweQsxzLLyRxpg7LWbgpxIelumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Eg89aQ9YDc9eStp3LDIEe/pefNUfKptlKojX+qfGOE=;
 b=bafORXPYgD8E3IbT0xs2Bvd95ZrL6NqVfIXCTKbOefWUI7gEdlmNh+D0PXVlgdC2y1qQew8ScL4XQ1j6OPbEREKjn39pvUMjX52W2Ejm4wVUkCPQytTooWIZgb68xDE6QVu1/SwWgLivjbXN3AA7gq+7xdtgs27nRTXDi0dJIP2bdK8fq41KPH0zNJ1B8KzudfrscA7FK6Ablmo7ExxioL0vpDnZAk/qzWANppMtMuiMqRYAQ+ealbh7lH9gUqbsWcJGFBGGxf3fAExTWe8wnKeqv/NNpJQTxvhabKCn8qd0MP0cKqaRmS40OAUsV2EPMA3QTBn9klNDmWu5Roy/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Eg89aQ9YDc9eStp3LDIEe/pefNUfKptlKojX+qfGOE=;
 b=IiXQxnAVLvCUDG/hBOKgyVr83sVJ0GojEzC1Y8F448BtSfiyjo2Z8gkemG9FoWZIhyJ9gAAKulKY9pqEYLze3qGuMWEG+qcgFDfeIr6pZ84lnTgHb145FenRKcC1yaFbmirsUr3cShg2I6wlcBv+J+A5t4kNQgSC0tmzYdOt8Wpfwr50ndFq5h3hXvnh//O9XEK+H64ppWWWfqxbeTk6pQrkfqpOqV+6YPLRZYwoMmCeq5nLiN3dvAn6Wphr60TK2bFMhRt/nzSdGrA8xrt/ePxMqqoI0SL49v+eOzLF70hKEs+yluGuS9gPBViUzdOfCiIqZr7iWhh8YfyzfahRKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:05:21 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:05:21 +0000
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
Subject: [PATCH v2 net-next 10/10] net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"
Date: Sat,  3 Jan 2026 23:04:03 +0200
Message-Id: <20260103210403.438687-11-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e3f67d3-5518-455b-577e-08de4b0bcd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VSkvHjXzV7o2JOAEpIGg70AqdYSVk5fMT6zrRDKpAuXVGGUA0mtNwS1LPGAe?=
 =?us-ascii?Q?V5fbulgwjb71wZL0eGpBj9gmr1Uxf4FF90Uf2h5CAE834+D66aSeXVxIyYHN?=
 =?us-ascii?Q?RgkywFtWmJQrVDgPQpD4FVXJgJAdaucL7N0Tv4TdZyugVtVQOg678Y7P0P+s?=
 =?us-ascii?Q?2hKAwlWFETokfVoP0TA17ejgtJhMTzEiIbPFCsnCFVzFVObbKMNN4P2jKr63?=
 =?us-ascii?Q?asHZSNq34MRV5WxyFFraqRta2rIAaOVG4x6fvfYnrZTok1Ky8jbGIJmvmrd/?=
 =?us-ascii?Q?OCqaYV7CKug7CeyBvzLOie+MdMJwVUwoqXQ2zD7akGljj4OQwZFsaURiLneD?=
 =?us-ascii?Q?NdGSPv8HR1Yk6VWh1hdPiuY5NgFe7DBs397QmwziWM+MJPAjBi333qShDGlb?=
 =?us-ascii?Q?b2kOP0hVOxXwgKKJ3dIYLS9u9pykOQWHmGVxITotGgh3tZxOk7ePOhuDN0me?=
 =?us-ascii?Q?3Csk4ePX9V8y+QpeqTLMKQSCtXmYrQTVJAtFScISja0WAqiQs00YhTOiUOrR?=
 =?us-ascii?Q?bEuQQswUek6KlmC9NI/ppV8/JfaSQuHNksQ5L9CAJAVvrgxtoX5tkUniBi6g?=
 =?us-ascii?Q?H2/XiDeqh6Mb88BTrn4nEcZZ7u0DnzgoyMKiQvpJ2yA/YE5ZhVVf5gltDU9e?=
 =?us-ascii?Q?AjlXLGLoVRWnFm8jTTWje/bsS14S63N1b5L5JcfotHAs2/Gnf5qkeO1CutLx?=
 =?us-ascii?Q?4cR6KY874U24Gf11jUfDKJMqwlUyRkxx3Rz5AIcEdOdscwD+iWqXV1nXq9W/?=
 =?us-ascii?Q?iUDmKUfzLRqRjOOFaaqfto4V4d5rBYxI04H4udmnBG0GCfd43MBBrow6s/2L?=
 =?us-ascii?Q?nOkNER09kNr0rKaq5GTc4ONhLxJz9RuDTX9iyMkx65TI5fxrnmHOMN30/6l6?=
 =?us-ascii?Q?c5IqF9LM7uovTUPLmHmiijV4UDmCmBFh1sgfDwzkgkFOrfkGMDhGcD7x0yxW?=
 =?us-ascii?Q?lIcn/RmYcZUnIF3iVPs66poxCKzcn5ND+yufBMjKnAbnktxYP2/aWgqH2ftg?=
 =?us-ascii?Q?8F83w53dahto6Qvi5hEjIDRbdGN/rGFQE+SxoP6RHP/p1ugzp5lP59Iv7XfQ?=
 =?us-ascii?Q?3wanxyHxDS8F6SgY9NCV05RhVcvxVcykYYsEw5hwdWZCSqMH8dSoDoTQORlg?=
 =?us-ascii?Q?27MZ4Qu4PRqcuBduo2jLYBIQTWGd8zDov1BHjHcOBDIAzhPLabkPzRf1XpSs?=
 =?us-ascii?Q?OSbsjLT2kND/AlIuo2sjaQL8pIoF03IwSi1Y89hx7vYLEro/lJSqSX0Wh8xd?=
 =?us-ascii?Q?tgjaTIKtCgr3gjmPhUmwrqBVe/HpKgE+x4SFRqtG3XW3BleqbDx7f0kvV4eE?=
 =?us-ascii?Q?03nFVWaP3M0qCcAhaYKYWQ+95P4+pV3MU53fFOVGAUnX73UzrnZKbIQMx881?=
 =?us-ascii?Q?cmqmQ2ffK0InPp2X+M+kyECnLy8kUvnAhpXW4diycVL64JrbBEqfRn2bZRSh?=
 =?us-ascii?Q?QPleEN265nx54dSiS6tBWfhZZEpORmFwGfG3gTiN/1l40V+dUV2jmwkYbjT+?=
 =?us-ascii?Q?MMRumKV8hJzdwAak1nbaJ1mtDqbaLa6nmwkI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lf+o/qfk0EWFeHX0AfhD72XvAl5HJxTJmHwWNIrNj7zqEonF83Ph4KVbJ3Ab?=
 =?us-ascii?Q?frlVo9OEfSWbGPm/MMZWMvn+qqk5szzJu6361Yfuvd7nYImMoS1GDaClHI9w?=
 =?us-ascii?Q?jYbrt7muud7jJrjeu1QE1lmELgKdqwOD7qWMq2bdH0dx5+5F6snCMWqAbsc4?=
 =?us-ascii?Q?Oed2pq/Ags298o3lA7KVz8u01YqKhv+rbJUsqif/jUd5i/AOylLCwSTEhsmT?=
 =?us-ascii?Q?63lNZJwXYBBR5+7OsoZSKx7x7qhTxJMPgtFKwY0EoSqNZ5Tqg1FgutkHhm+v?=
 =?us-ascii?Q?i23qyzz2un1Uj0i0Rp1gvU95uwRxJb8cGn3oGTriC8CuxTHFhB+o3EHqBaFZ?=
 =?us-ascii?Q?iRTYEDmHk/+BdT7TgE4HScb3/UlxiVJrGNKotJAxwuyYXHvrsndfpj1LPMj8?=
 =?us-ascii?Q?AjnZ7XinddpQ7mUdxDf5FVrTyFebAfSTsQKT0Ii1eHXh/aSx3TWwAqjj1jSK?=
 =?us-ascii?Q?P7z9zZiYl0Q1m+RHZ1TzAAbF3g7kLRZwYnzBntZZ5U0nFayV1mKz8c14MkfW?=
 =?us-ascii?Q?cqcGLPnTwyVtr/66U5G4yr364FQBmQP6OZQkXfu3yJqyOjGSXa+Gaf3A22ZA?=
 =?us-ascii?Q?UeWbpzTpa+mDP72Aku6xvaHfdXwO2iBujuCxTPhYkI/+YFVDGkdgBBTDETp7?=
 =?us-ascii?Q?eqlFlYiFL2v/wTg8SMESbrd4KcLg/V2Q/cdYQ2RPSFd0Xinq6jOPXV8WPVoE?=
 =?us-ascii?Q?Jo9HdgKlsqYVIy+XV09eDo2zIWigbiz3n9E0pGKsU6oclnauOHPWIAoCXuf2?=
 =?us-ascii?Q?6mwvt4bM6VSQvZQ8bZoKujYWp3f8MtNoxOK2rdM9YjwcfpO3xRG5YL+U9dXi?=
 =?us-ascii?Q?cShbLMypd7G9+z+Gi3BF9FhyMjRJPdg/DeIoKIBsZUe3XXT3FF6b93/aKukG?=
 =?us-ascii?Q?pJDpDYfmWeN0b/enV05QU/RSi9CgH2EczexzAlUagOPJgx73CfPv8OZ+33XA?=
 =?us-ascii?Q?zoEvB3lb4f2nqwXjUQt3j+39pKcKBFrt7dGT3+Dz5zGq1Hd9dS3t2TWxtQcS?=
 =?us-ascii?Q?5DpyiBUZqYuFMW/pR9WawLoFU1b9Vfr2AxaKu1670+sadh8SAi9+unBpQe9D?=
 =?us-ascii?Q?PP96E6cQGUCAg09cveVunsJd5I84N0F0lDQuYaMwfxZYw/t0UyKyXnrrsG4u?=
 =?us-ascii?Q?GLdKxUu78S8emv05kWyYKJuem71qCpmY+fq3qsVHSIlqMN1w33PhSrovAQ5S?=
 =?us-ascii?Q?sVBkPmpGvTXNL3n7Chryo6RXzASW8bQUsmo07O7QqfvTEZFceOsj3kGnUkIc?=
 =?us-ascii?Q?1YnXJJMcr2aahNoA1VaIAKkSZaccbTwQMNyoMmwUEtvMt87KDqz5x+pbrh+Q?=
 =?us-ascii?Q?n9S8d79ZopGBo/gT+XhPUfq6aax7nriuISpEFRUp8GGHuAVw/P5COWCBoEzb?=
 =?us-ascii?Q?y0rSmxFxBqwsRhryEN0IO7RbOWt3RqyRDVyTTTshAbi4D/CvzulqqSVIBhZb?=
 =?us-ascii?Q?2+Tp5pauoZn37KfM7eXZlaID8iSvuMIlwzoHYvC7tA0nEtTxWbdECQ/pKUDx?=
 =?us-ascii?Q?xlY7eNOgcRTAXSmHF5nP108tx4x9cIQ0pbgdIWsQ9y1xQMlNZ8MItAGodQ4H?=
 =?us-ascii?Q?BZ/qgfS9rsnytNSLZ4bpD+rCXe+iUnBG+Q1iEIwin75CppiPf2RVx2SD6W+0?=
 =?us-ascii?Q?8HNpy/j4sMYs5RVvTJWEkj86rwoTGndK8rqeJdl2+jmxfB57B/PJJR7vmD2w?=
 =?us-ascii?Q?Ls7H2p6lNLUNjitpQw/i0+Fig7sDTUV3C4r/I8bmaEgInaYxMMjcMuE3dy9l?=
 =?us-ascii?Q?j8YuYJOrKAuL9IcH4RLGw/ouyMKOkyM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3f67d3-5518-455b-577e-08de4b0bcd24
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:05:21.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuRHOYFqpsbTVsTQgen5cJjRRXahlEf4RFqC1rlBLqNGsX4UPFw3vHG3++yMRzuymN0Vul3obuEPFOS3rMxdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Prefer the new "rx-polarity" and "tx-polarity" properties, which in this
case have the advantage that polarity inversion can be specified per
direction (and per protocol, although this isn't useful here).

We use the vendor specific ones as fallback if the standard description
doesn't exist.

Daniel, referring to the Mediatek SDK, clarifies that the combined
SGMII_PN_SWAP_TX_RX register field should be split like this: bit 0 is
TX and bit 1 is RX:
https://lore.kernel.org/linux-phy/aSW--slbJWpXK0nv@makrotopia.org/

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/pcs/Kconfig         |  1 +
 drivers/net/pcs/pcs-mtk-lynxi.c | 50 +++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index ecbc3530e780..5f94a11f6332 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -20,6 +20,7 @@ config PCS_LYNX
 
 config PCS_MTK_LYNXI
 	tristate
+	select GENERIC_PHY_COMMON_PROPS
 	select REGMAP
 	help
 	  This module provides helpers to phylink for managing the LynxI PCS
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 7f719da5812e..74dbce205f71 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -11,6 +11,7 @@
 #include <linux/mdio.h>
 #include <linux/of.h>
 #include <linux/pcs/pcs-mtk-lynxi.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/phylink.h>
 #include <linux/regmap.h>
 
@@ -62,8 +63,9 @@
 
 /* Register to QPHY wrapper control */
 #define SGMSYS_QPHY_WRAP_CTRL		0xec
-#define SGMII_PN_SWAP_MASK		GENMASK(1, 0)
-#define SGMII_PN_SWAP_TX_RX		(BIT(0) | BIT(1))
+#define SGMII_PN_SWAP_RX		BIT(1)
+#define SGMII_PN_SWAP_TX		BIT(0)
+
 
 /* struct mtk_pcs_lynxi -  This structure holds each sgmii regmap andassociated
  *                         data
@@ -121,6 +123,42 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 					 FIELD_GET(SGMII_LPA, adv));
 }
 
+static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
+				   phy_interface_t interface)
+{
+	struct fwnode_handle *fwnode = mpcs->fwnode, *pcs_fwnode;
+	unsigned int pol, default_pol = PHY_POL_NORMAL;
+	unsigned int val = 0;
+	int ret;
+
+	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
+		default_pol = PHY_POL_INVERT;
+
+	pcs_fwnode = fwnode_get_named_child_node(fwnode, "pcs");
+
+	ret = phy_get_rx_polarity(pcs_fwnode, phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret) {
+		fwnode_handle_put(pcs_fwnode);
+		return ret;
+	}
+	if (pol == PHY_POL_INVERT)
+		val |= SGMII_PN_SWAP_RX;
+
+	ret = phy_get_tx_polarity(pcs_fwnode, phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	fwnode_handle_put(pcs_fwnode);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		val |= SGMII_PN_SWAP_TX;
+
+	return regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
+				  SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX, val);
+}
+
 static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				phy_interface_t interface,
 				const unsigned long *advertising,
@@ -130,6 +168,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	bool mode_changed = false, changed;
 	unsigned int rgc3, sgm_mode, bmcr;
 	int advertise, link_timer;
+	int ret;
 
 	advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
 							     advertising);
@@ -169,10 +208,9 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
 				SGMII_SW_RESET);
 
-		if (fwnode_property_read_bool(mpcs->fwnode, "mediatek,pnswap"))
-			regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
-					   SGMII_PN_SWAP_MASK,
-					   SGMII_PN_SWAP_TX_RX);
+		ret = mtk_pcs_config_polarity(mpcs, interface);
+		if (ret)
+			return ret;
 
 		if (interface == PHY_INTERFACE_MODE_2500BASEX)
 			rgc3 = SGMII_PHY_SPEED_3_125G;
-- 
2.34.1


