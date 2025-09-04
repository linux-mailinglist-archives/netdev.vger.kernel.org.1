Return-Path: <netdev+bounces-219935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66539B43C18
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E77B8A52
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC02FF14C;
	Thu,  4 Sep 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ggGLlRa9"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5A2FDC41;
	Thu,  4 Sep 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990379; cv=fail; b=g97IlF3O2b5bCMpt7Bw4grL5CPobaGqv5Xj48WuSkosMwTRCOgwLiyOUJkPLw8H7SVTkeNDqjt7C+PM2KHVPaGmOLSItW2PZSfgZFqTLLFCR1aizPpeUHhpUrK/Y/NnPbYioOFsANlEt65D9gEgS4jQSAIe4YLKvSjCmkq7kMHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990379; c=relaxed/simple;
	bh=2N5i5BpqdYElFqkGyBCOHhSjl5q7HHdGA9KURmdn6f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WTGyH3mZimkGVuOLJZzlHuo4FdE+yDo8mQDnC+bHNjnRBsOCLYcBZes/ZaBomzJT3lec3QJus8VmoN+5gosN1YHuXAwmKaahs28noYdbWda22HunjhRLw/q3b3ZQzLxxmCpU4Z1FlaBclITaFGSX0JVTFiz3yao2znAetZQVgTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ggGLlRa9; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXeUOFdpOpUPkefb+nVi9qskAYE/qPIaiQCq9e+pl+T3swTAB1ly3n5RykQiltf3eh5Q6cNA2+0LUC+b/+l+mbq1H6n3lWv+SI7HIa7DCuS/PEz7hbCCQxP+kplLU3S0/6hmjVFezn3d5Iwkz88iN1V8A2hBhxm24MS8Q7epKvGR+KdKy/u4G+j/s3JO4JCFMoT/cThJmsLpX40G0T2fNLcsQGl3PvqbW8Xu37ZJf+FFJg0Mffw1BbmdCt64CRpyRHCBPAkGskPT3VhSMmxNAiC8HKkwO88ABdQIkxjASuwXadX+pE+xYPgmx104nXjjMNi4gLr/60tA4KeX/oemAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7FZxjR90/YrFAxe+bZ83SYbRgcFF00ofoN3+ycVIl0=;
 b=JA71Y8iUPMxHW1n+AvQ/7bF9EjLwG6d2xhwP29kxJSn33xr8maa9NpA9o3N5I5O/wFbq9x+9NmrwKBQmj4FAuHTuooLzUmCCwciBm0994ugQgG5bTpdLZjkS1v7dcbR2xJlgs3qd7Sc3sO71BIJ5R86u7lgSQyrvp3yOtAeo+VAmXeFahQdkceNlAPOWlNrhVz2YyDP0H0BXGo/79l6+3RZFo8etGpBuBCtCjNfT2D53bKrNPdk5W7SZx4HPfAf6thzwXOcRzdGTDwi9RZE1VnXfI1wRdomcG75gjwGsyTcZ8zVT6EFPiIUscGTR+YkLE0CMnDJaq2I8LcLekgyK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7FZxjR90/YrFAxe+bZ83SYbRgcFF00ofoN3+ycVIl0=;
 b=ggGLlRa9TpDSlWQxIFPv2WFv4ewNvebu6JHBJGJX1wUSwzAnjRn0pim9ShnftW0qI/5wYuhy4kwhqfT7wFhAO49mQMaJFiKsz3YktqI0TfhmRCKFWGNKso1ndZNUbXHOfYl7aYiU3aMXvdPJIaAVmc1GFuugfGjsmYnrtlvNL8lLlJtzdNT7Yn5gkzv2Yf0SlB1FmQNv8jE6z4T6LjwIOyGVM2ffxZLMQvVH/XvwiQM++vbYZ4+IedXVHZodPF3zxOjGOLRuv/RmdwIdpDVACgUtiXPOy/UiFA8CjB62hTTC7V91HTVY+yhXzhycgKAo4gpBffIw98zZ62XqtNoUQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB9836.eurprd04.prod.outlook.com (2603:10a6:800:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 12:52:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 12:52:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net 2/2] net: phy: transfer phy_config_inband() locking responsibility to phylink
Date: Thu,  4 Sep 2025 15:52:38 +0300
Message-Id: <20250904125238.193990-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904125238.193990-1-vladimir.oltean@nxp.com>
References: <20250904125238.193990-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b325c2-c92d-4a9e-3010-08ddebb1f4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gWOwwdBwndBqSvONHAfNmqAY5n2bnAgsAgXLPcsRQ5lmHVaMe4gvqznNTmfm?=
 =?us-ascii?Q?KqQKFpTqVLlh620QC3HE9dZeWs58b6FLc/ug2601qg0r+pUcj3C+j+6QQdzT?=
 =?us-ascii?Q?GGO+OEUSGmF3v0T/vtK7LT3vcYJ4LkGgM2nfJBFa7e32vUo931VUx79uYbOV?=
 =?us-ascii?Q?c4752H6JTSR0M3JjcFAINy65Qv4IMo03p4MkHQvWLvxn2E2ug+eFE3UcDR3Q?=
 =?us-ascii?Q?t6FclYOLi5uESKTHlzXGzDwOJVRemVic9BgysAy2sSNsReN5h0YGnPUA/1U4?=
 =?us-ascii?Q?/F1CFQtPjcowcvwHUSxbgQ92PZg5i7hXU00mcvS7JhtnbC+omSjQT+p9M+5Y?=
 =?us-ascii?Q?t413aPkCYwv6BhBkuv6zAVvRQk7ZmfF4PRmu4t3Vc9SpBGO9HZClS6bH2w0m?=
 =?us-ascii?Q?6As2GfDeyKHHGm3SYlNL5Rto6ZfkjyxKgovvS8G0TOmGyo9G0XdSgNt3ph0h?=
 =?us-ascii?Q?FK8/yRAbvzpcz3/oePHTxN8tpZaf/kMM1mith5aDG8SuqQXbaBUnMvGTg8mP?=
 =?us-ascii?Q?XHfjRvUKKnZzoFSdiOSNwGNeEl8p8wIf9sRVJuXRGIQc9WgP+a5m9PejyOwg?=
 =?us-ascii?Q?Skv2PzGdvakdoTmNPA6gy6rnLmh5YMkC3hVRQgHyBFj4/e1f4NQxW8A6RLTH?=
 =?us-ascii?Q?C+J4rQMalo4iOaomokGYn63xyqKl+BxjpqoRIHOdrV1EDnzTRzGRdeqIiVAO?=
 =?us-ascii?Q?FZjyzEIyHAEC+l88BHvWlo/ESYeIhZsODHTq7+ILF3sm/u4EwcsJmjkaNjAx?=
 =?us-ascii?Q?3mB7kitqP3sjcTSetuiI+oeUVlQrWML6hOaIXU5gDAKw2mfGrpN3swwbilO2?=
 =?us-ascii?Q?8+Bwbl/szvZJwMKu9UTtFVuN1fKzUz+nK+yIlEW04yPXOFoP2x4MM/3tlcfB?=
 =?us-ascii?Q?gP1Fw4ghxCXwAJFD3wN9BtGwW2U8MiUD/ruJwSUm/akh2Fd6sCVI3cx1+jBo?=
 =?us-ascii?Q?EWs2C8BeXB3KnJeDTUUJ07kHdyQaGV/aFAXbKXoE5Xie3Mw9bix7vyusuTW6?=
 =?us-ascii?Q?P7ZSiAp79EkKdiRDTqn9T6pCbUwdkOoUu3C9MA/eUFDHQiOIJweZcId9rtZN?=
 =?us-ascii?Q?rYPxYvB0bSnquo3Qo0cy4yo9U7KqTH1OlzCou6FB4GOCQvwQzfy2DdP7qnYf?=
 =?us-ascii?Q?b9nmNHq69o+g5flbTQKAoB6sRxiT77RAY4QlPsfgssue0kh20M/QIMRBCir6?=
 =?us-ascii?Q?/KfWobcyjQDjlNKqCd5d0XIY1Jrba/GK0fLipjjgrtxgXLJ1TKc7HNyTxWyL?=
 =?us-ascii?Q?rSn2vcegTz7fbYNtMJFTG4Esvv3TcIQi9Nta43A/blhFWVjDktfl1ldlWTYO?=
 =?us-ascii?Q?trvbZB0iHj3l+fMf0NchSnfcD1sRWLHB2/6C5NIoEGtCommW0B+2SnYLsOTM?=
 =?us-ascii?Q?kXhjzM766e20Hfd7nEBtlsbdP5WFExlOAoZqekd0LBK6Ac29nuIiUNMb72sd?=
 =?us-ascii?Q?dOLE0t7VtwcvsMg5nq0MzPBxILmtmpfd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WAWGt0Y4j8pRPEdap5VLIa+pvyuC6JWsrKdb3727D6tODSFL7DvLaKOu6i3?=
 =?us-ascii?Q?T3J1E3qORX4hDHUBkhUDnYjQNEJX8c2GG48Dh3wor+29v4LF42sXVpbRcJmT?=
 =?us-ascii?Q?h2qCJ3jPjBxR0X8bkJ6O8j+IVzQj8393cXI3IQ+5/4YOMlzGafkjpIf7YGuA?=
 =?us-ascii?Q?78jscUz1h1KdLOXs5EKQQmim9Rj6InZavbsDNb0KvjcZkbmPsiLon2jmaS2i?=
 =?us-ascii?Q?/eDSD6ED9ijVZYwcWE5rPEC5ETnZ3h5dIB8btKD6p4hGRcUy8WCNP5MjL7gC?=
 =?us-ascii?Q?5KK1efDzEUZ0TOWA7p/u/wKA8khuesiCnpiSLWFWqud5ROH+75rCtnM27bJJ?=
 =?us-ascii?Q?509D/cLH5SX3lLitNmf7Zub9Z0EnHBRPXojHAil6l0+KOd7EVQG2PoqwXCfk?=
 =?us-ascii?Q?GbNpfvG6aUO71v77dziBQQ5D37cL08U5PZUYmpFIwP3Msp5lebLVwGGL9yCb?=
 =?us-ascii?Q?Wrug0OsyT/3bV01W/W4khhY2hV/MuxoZzOTI2ngU4RbsnwgJoEbggz4GWhZU?=
 =?us-ascii?Q?DyNIh16/MtST/hugPUWC7tmih1RihLkllyLRB/xhwb+EqKCBDChIm/wqTrNZ?=
 =?us-ascii?Q?bKENoDiA+F5dsM8icfGGUTJgGfibBikCg+7QFh96mDqESpVi2SizWk7MhRKn?=
 =?us-ascii?Q?V9a35rsm4/ZN3277GNT1ppNyQBEs36ZLM6+WiqjMRU2aTkc/QRhHTli9pq5l?=
 =?us-ascii?Q?0/is0QX4Hl1qQkYsbBbYyHlpP7Sgn+EUXib2cRcNpeYUrK9Pqyj7ZyvxpfkO?=
 =?us-ascii?Q?N8pQYk+rOvVQtUvIMWUIBXrLgjV+ZOt45SFdF4hJ9ECOU2XfmkgytycrZxQz?=
 =?us-ascii?Q?3ZvIUjEYHtLway7GdBLJLcqaORTMtu4jhY/sOsbx0UGo1ZetfPOZJ5QUZjT7?=
 =?us-ascii?Q?99w97qkUWMe9JcqOIfgppQa9xXGa7e5iWjMGjKLEQL9kLlrVS2ItXhzF9H26?=
 =?us-ascii?Q?tSz0F4GPdBtgyuRw2GTNMLEscWPy81OdDM6hlY2QZqzT2iklyb2n4MHGDcHS?=
 =?us-ascii?Q?J4KgvWDzt6TlOHGuPexoAQe9VWJ/UZ1xTyQvQaz64lkqmbgpS7HH77NcZlQM?=
 =?us-ascii?Q?nN4QMTmozP7YcaIfvDBidA7RtOMUpQYGdLy7E1rDxoFApngKeC+lteImE7g7?=
 =?us-ascii?Q?vmzpzdXAhKjiqM11TXTLaD0Lx5zqoanuDBISkscbnTNQfx9W0HE2x79JWppg?=
 =?us-ascii?Q?dpt+QW3JoDX7YjPZ3kZLqFZqF0yEvUMzA1tVH2VO2fcwEf/OnqgpuJy0q6SZ?=
 =?us-ascii?Q?hhb4orkO0OHeQfDGB1/TIteMuZmVQLzAeNg9haOsU5hvSZl4A4cM7ElMq6po?=
 =?us-ascii?Q?XrKJFcbTvgHVQzaw4WWXr+XPW641cwyL6Nb0wFFlM69PuZ8CUe5CfSRFMJAR?=
 =?us-ascii?Q?XXNZpv79M3ejA9ci3xg2G/UeXNb0+hQU1McdXMqp9nFCWOtofDdrvPnXL3jr?=
 =?us-ascii?Q?LW3aCGO6Bqx7RnhI5SyfgghI6s1p3cEehuhd0dR65dKtN9hfU5oT2L0pnJ39?=
 =?us-ascii?Q?PvJ13T3jBZi1j6d7cS+Ixkp4R5XMP22FDpbGSzKQO1FGCEaHUevb5hl7rXyZ?=
 =?us-ascii?Q?OA/N4daU0qGx+KuYrAIQxzfAMfe7avDklE7JvbFiMuzLvonm9/DSk9Ik4NwM?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b325c2-c92d-4a9e-3010-08ddebb1f4c2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:52:50.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb24RRDu0I6JDeqjYq64j5K67STl9mAJuA2UDuyf3RCfi8pFPo4pMFGHMTRxyvIYFDuToV7ImEhKdkOxn6VsnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9836

Problem description
===================

Lockdep reports a possible circular locking dependency (AB/BA) between
&pl->state_mutex and &phy->lock, as follows.

phylink_resolve() // acquires &pl->state_mutex
-> phylink_major_config()
   -> phy_config_inband() // acquires &pl->phydev->lock

whereas all the other call sites where &pl->state_mutex and
&pl->phydev->lock have the locking scheme reversed. Everywhere else,
&pl->phydev->lock is acquired at the top level, and &pl->state_mutex at
the lower level. A clear example is phylink_bringup_phy().

The outlier is the newly introduced phy_config_inband() and the existing
lock order is the correct one. To understand why it cannot be the other
way around, it is sufficient to consider phylink_phy_change(), phylink's
callback from the PHY device's phy->phy_link_change() virtual method,
invoked by the PHY state machine.

phy_link_up() and phy_link_down(), the (indirect) callers of
phylink_phy_change(), are called with &phydev->lock acquired.
Then phylink_phy_change() acquires its own &pl->state_mutex, to
serialize changes made to its pl->phy_state and pl->link_config.
So all other instances of &pl->state_mutex and &phydev->lock must be
consistent with this order.

Problem impact
==============

I think the kernel runs a serious deadlock risk if an existing
phylink_resolve() thread, which results in a phy_config_inband() call,
is concurrent with a phy_link_up() or phy_link_down() call, which will
deadlock on &pl->state_mutex in phylink_phy_change(). Practically
speaking, the impact may be limited by the slow speed of the medium
auto-negotiation protocol, which makes it unlikely for the current state
to still be unresolved when a new one is detected, but I think the
problem is there. Nonetheless, the problem was discovered using lockdep.

Proposed solution
=================

Practically speaking, the phy_config_inband() requirement of having
phydev->lock acquired must transfer to the caller (phylink is the only
caller). There, it must bubble up until immediately before
&pl->state_mutex is acquired, for the cases where that takes place.

Solution details, considerations, notes
=======================================

This is the phy_config_inband() call graph:

                          sfp_upstream_ops :: connect_phy()
                          |
                          v
                          phylink_sfp_connect_phy()
                          |
                          v
                          phylink_sfp_config_phy()
                          |
                          |   sfp_upstream_ops :: module_insert()
                          |   |
                          |   v
                          |   phylink_sfp_module_insert()
                          |   |
                          |   |   sfp_upstream_ops :: module_start()
                          |   |   |
                          |   |   v
                          |   |   phylink_sfp_module_start()
                          |   |   |
                          |   v   v
                          |   phylink_sfp_config_optical()
 phylink_start()          |   |
   |   phylink_resume()   v   v
   |   |  phylink_sfp_set_config()
   |   |  |
   v   v  v
 phylink_mac_initial_config()
   |   phylink_resolve()
   |   |  phylink_ethtool_ksettings_set()
   v   v  v
   phylink_major_config()
            |
            v
    phy_config_inband()

phylink_major_config() caller #1, phylink_mac_initial_config(), does not
acquire &pl->state_mutex nor do its callers. It must acquire
&pl->phydev->lock prior to calling phylink_major_config().

phylink_major_config() caller #2, phylink_resolve() acquires
&pl->state_mutex, thus also needs to acquire &pl->phydev->lock.

phylink_major_config() caller #3, phylink_ethtool_ksettings_set(), is
completely uninteresting, because it only calls phylink_major_config()
if pl->phydev is NULL (otherwise it calls phy_ethtool_ksettings_set()).
We need to change nothing there.

Other solutions
===============

The lock inversion between &pl->state_mutex and &pl->phydev->lock has
occurred at least once before, as seen in commit c718af2d00a3 ("net:
phylink: fix ethtool -A with attached PHYs"). The solution there was to
simply not call phy_set_asym_pause() under the &pl->state_mutex. That
cannot be extended to our case though, where the phy_config_inband()
call is much deeper inside the &pl->state_mutex section.

Fixes: 5fd0f1a02e75 ("net: phylink: add negotiation of in-band capabilities")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3:
- remove the patch hunk which replaced "pl->phydev" with the local "phy"
  variable in phylink_resolve(). It's now in the previous patch.

v2 at:
https://lore.kernel.org/netdev/20250903152348.2998651-2-vladimir.oltean@nxp.com/

v1->v2:
- rebase over new patch which introduces pl->phy_lock
- add "Other solutions" section

v1 at:
https://lore.kernel.org/netdev/20250902134141.2430896-1-vladimir.oltean@nxp.com/

 drivers/net/phy/phy.c     | 12 ++++--------
 drivers/net/phy/phylink.c |  9 +++++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13df28445f02..c02da57a4da5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1065,23 +1065,19 @@ EXPORT_SYMBOL_GPL(phy_inband_caps);
  */
 int phy_config_inband(struct phy_device *phydev, unsigned int modes)
 {
-	int err;
+	lockdep_assert_held(&phydev->lock);
 
 	if (!!(modes & LINK_INBAND_DISABLE) +
 	    !!(modes & LINK_INBAND_ENABLE) +
 	    !!(modes & LINK_INBAND_BYPASS) != 1)
 		return -EINVAL;
 
-	mutex_lock(&phydev->lock);
 	if (!phydev->drv)
-		err = -EIO;
+		return -EIO;
 	else if (!phydev->drv->config_inband)
-		err = -EOPNOTSUPP;
-	else
-		err = phydev->drv->config_inband(phydev, modes);
-	mutex_unlock(&phydev->lock);
+		return -EOPNOTSUPP;
 
-	return err;
+	return phydev->drv->config_inband(phydev, modes);
 }
 EXPORT_SYMBOL(phy_config_inband);
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 386d37f6bad4..76cc6f6d671b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1425,6 +1425,7 @@ static void phylink_get_fixed_state(struct phylink *pl,
 static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 {
 	struct phylink_link_state link_state;
+	struct phy_device *phy = pl->phydev;
 
 	switch (pl->req_link_an_mode) {
 	case MLO_AN_PHY:
@@ -1448,7 +1449,11 @@ static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 	link_state.link = false;
 
 	phylink_apply_manual_flow(pl, &link_state);
+	if (phy)
+		mutex_lock(&phy->lock);
 	phylink_major_config(pl, force_restart, &link_state);
+	if (phy)
+		mutex_unlock(&phy->lock);
 }
 
 static const char *phylink_pause_to_str(int pause)
@@ -1589,6 +1594,8 @@ static void phylink_resolve(struct work_struct *w)
 
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
+	if (phy)
+		mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
 	cur_link_state = phylink_link_is_up(pl);
 
@@ -1690,6 +1697,8 @@ static void phylink_resolve(struct work_struct *w)
 		queue_work(system_power_efficient_wq, &pl->resolve);
 	}
 	mutex_unlock(&pl->state_mutex);
+	if (phy)
+		mutex_unlock(&phy->lock);
 	mutex_unlock(&pl->phydev_mutex);
 }
 
-- 
2.34.1


