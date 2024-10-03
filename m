Return-Path: <netdev+bounces-131624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6098F119
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F181C20E9C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6137E19C57F;
	Thu,  3 Oct 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EavRSNlU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF94C8F;
	Thu,  3 Oct 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964501; cv=fail; b=iqTK6kl5R16se3gwYz+1HSfBICXYHtaO/zyjJ3LonSxma6HJ3Bt1aawDfhFyZJvod3pHJKNImZlXmOnoHxnx6Cu+Bw5TxwhJmEPncFk4hb3d/lBSVUoFFPSRbF7UCMZlneP6KHrr+hng9tyTAOQz4TN0CAD1JTH87F9RnxJAaSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964501; c=relaxed/simple;
	bh=JaQKqB5lxGxj7XomhupxZJxJLxa69WVxFIutoqSb1c4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GwvhPubOn7pTLkee+wnGD6qX/ItoAFWvzDzl5HaFVsUdcqbi+zgbTSjp5QAjayzJ2EyQAF5oMqhLUUwnojzQ6A5ZYtG7bUidCvpOHNDm1iODiQlFChegceCoYk7RJ85tKj0RkS/z6qj+QzrkRIyKTI62atMaOewsbg15YlxAIho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EavRSNlU; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqf7twwiQjpNwhqfj60TfSWwhql3d4MXfIZkY4eaVWUaBWH+Ywq22nAE53wUHtB8vwCHXICSrWAS2j4Ps+XvTVGvqR3OJGRrShpKRrYeYCIYcgwfZCbMijLe4clgc9rAkpCGog01aTN8tbzUNSW1AvNwa5o4ZyLLOJ4nFkTFFkR79AR5EwcK07DdxxXlUZK8aDoEC3f5ie6iLbYiSLkUEpTXSejdisLMdH/IIIFBQ2UG7ZNMemoAJVBN+NtwKIEAtsuwpq6p+w1vPZvVMOEeK911gdr18pvGQXibq5USTue9sPoy+Ijf8Xl6cqknQMIFIHhIu43L62vyZhNhFHz+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctTMXfoj6U9huftEW6P0Z8PqAYdPAZcjkXVoPH/Syqs=;
 b=SK/WhbeG1AFUIzMsIbQAxc2u0grO/iDKnC+/2w3eE2KemeL8KFsxo+JGLdq79eyDnpfB/OizMhcgXewP64RtIXXbJwr4upQhiqlTGGnRyMWoqy6VDyXclqh2FI3eVAun2CBK+rIO0dQey3iXGuVk1bkQvUjA82nc6+SdM3uO8zo9LGael9gSZrBRNZNRhQWRhmKSzVnXLcR1UKlBJ+rox9X7IhDybSheCHbE0Zl9iZdWI4tLNJW4PGPBUrBuoRfQUvOcZYr5mCGHTpA2s/jw0BEGGBHasYWgeAAfuPthjqGUXIDGIc4gSZQqyZGUfXl2N6NDfH1nyuy7bYG7dkY23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctTMXfoj6U9huftEW6P0Z8PqAYdPAZcjkXVoPH/Syqs=;
 b=EavRSNlU0JuV0LShCKCwCjG6lVX59tV5nHEUV+HIbgvPJWhxGY4Eq4YKqpNC6pD/s+h0Lt3lCCSpJfMsIsBxXJfUt4KqhkiA9Fz+Enfh0XkPB4q02X8ktBZTPSOoLVUteu/6fYUkEu+Rsu6kQqYSGj2n2p+1c9i7xeCOk8gVBrtfIBqNJgdGaXrbFDz6vFkNco6giAipJvr5vON8eB4mubMWFpTXFubCKlT47GYILNfxkFZTfrwLSNHz5A0fD6lv5eOrW8GIauTqM7dQ6BSd+r9ylvwFsZyv02dKFqyYqhYcwnKw4IkTJYaENLrOw+iW7irmYc1JtaEhqVyQYlrWYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB9199.eurprd04.prod.outlook.com (2603:10a6:150:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 3 Oct
 2024 14:08:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 14:08:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: dsa: sja1105: let phylink help with the replay of link callbacks
Date: Thu,  3 Oct 2024 17:07:53 +0300
Message-ID: <20241003140754.1229076-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4387f3-155f-431a-7628-08dce3b4d315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vkuzKePn4Afdzo7m5bwSe6DvfKvOZaFRm0fb52YEBIW6QSCur623IVLedyyV?=
 =?us-ascii?Q?22wgVoDaAEB4BAKQaJv+v3DNub9V2HdBOPTSQeYB2RhBvQnaRhLIwV6Uqi1p?=
 =?us-ascii?Q?la7u0QL1R5zu9UbafDQOXygx/r/YXfI0HBC1uUgoGVa5y8bZzgTpDsZRx5Om?=
 =?us-ascii?Q?yIdrfavlTk9aLRGy/8WE4c/dN9elWPoJ/lqFA/5iuAA/9ogKiLhtASAVl16c?=
 =?us-ascii?Q?BesiS0Ehil296AEHSG1+eqcR8skIveUXzb+NY1ygpUzaNhwKcG0vCpz43lqj?=
 =?us-ascii?Q?bO+bKFCeFXB/S+e2/qsUTqKiBmdGhkmeN+4Zv6mUS1n+czrYa13W47Mn6OdH?=
 =?us-ascii?Q?ncOm2RLpG/Wg0vTKIAsiuruyR/CjiKsh3/9ktPX8gfTY6NNh8aJUd+x7Oy1R?=
 =?us-ascii?Q?6bB3Eb46wttSyqHVIRTb9y6D8s76MsgXyFsH41OwbNebgurELj0k+l1AIVXx?=
 =?us-ascii?Q?09Xxw7O/BDi7XEtI0Cltw3Tp+P6fII0RDQsMCr8/G+fJyo1UGorytDcbFIpg?=
 =?us-ascii?Q?vvosp6cRgELCILCcu4aFh9OzulrH6cFZwDrS9/Sjh2FP83Z+Lwk+pC4Ooyqj?=
 =?us-ascii?Q?8TYd10fgM2M/RZNdCMk8zQN0R+F1RYDT+m8t8QmTWe31b2KkYfIPtr87TNkW?=
 =?us-ascii?Q?Bin92BS8IRav5tL4QQNzWiM+VATjEFghIBPuWlBNEiJeJ7O1qq2OwKHBLg3N?=
 =?us-ascii?Q?nvMTXKeGi1aai2ZAgNmH3MLg45hZGhxJ/rstnGBAyfP3XxGujdRkjzwcf0yc?=
 =?us-ascii?Q?3yoOYStNjlbgJ2l63TseJ2dq1Am27kMJSsP03CD1lrmDVqeOQNUejUXY7ote?=
 =?us-ascii?Q?/C431vi2w53pN/mDnYnSGJoR2e9K5f+eUKEvMDD1+y9v+Q8pGU3cksQkdANl?=
 =?us-ascii?Q?IY+Ato4WwaXClHKwLNlKgirZkoScXcxWfbsh2xjxHzE208PdX0IZmRDOeLDU?=
 =?us-ascii?Q?gvwf3JeknVvlgeOneKn54fmpJNG2Dry8IJ/yZRbDXLFfZcGzPr1EUAmBd02D?=
 =?us-ascii?Q?kEqxl7IDZSUgqvD78j3Yxi4qqPZfIRuEZA/zVinbttwz2K/O2LG6J0G6iNHu?=
 =?us-ascii?Q?+/ha9JPtwjS39QyxaVuzHLAB7s26PhxtbW6fYcOlS5/OpuAD+gMC6/2K1AUi?=
 =?us-ascii?Q?gFfZuoSRYfucKdOB/uL8AwYE/o3B3QXxaxg5KcC5nwQpvvqUh4or7mMj8+Pq?=
 =?us-ascii?Q?HWWEeKhsXn4gUEJQoljIpI9thOg0+h/FXmAg8KmaLJsH2hPe5OydggpYQsIN?=
 =?us-ascii?Q?CEZKOo4s9oxX+dB8Erf6eaK1idaFPh194+wnkKvAlmuKVjwKt8ebe3fLe2rM?=
 =?us-ascii?Q?qBj9ELlTXoPu5lEWFJHdNBt+5o8+xsDGpnW9Bo2c4y3e7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvWpomYEk5nITpG7dqHkSIMLObrNvWefTgaQV5otDbzXOevYwtj00Bxn1u2n?=
 =?us-ascii?Q?/uWJ7BhfB6A19Y6n4qIhgo+TuEfuHT89+plngN/P34+mHxaZnoMFQ6jvtxMY?=
 =?us-ascii?Q?GIRcsMWV7YvF+Fr8iQOX8+8z+SFpFi7JIykeDeKinIgOJMG8Lq76Gw3P99YU?=
 =?us-ascii?Q?ZgiIdfPvQfY1SzYjTUYndsZ75Ak06ve41K4MEoFyBE9I+993VyzFeZopduJl?=
 =?us-ascii?Q?VyU28eyPzoHY4eEaGo4iRmyVmmrN5is7EkTLAfrprNh/Ju3tfCjUdpn1xkYB?=
 =?us-ascii?Q?kKuiZTvDI1IFazEg1s/fJhSlBC0YZHAa2nhjT++7Vd5mSMNRa1mfiGwxLOA6?=
 =?us-ascii?Q?84TrjQMhbPC1Plyd0f41aqjcTCiKmZoGcqC1hWIYAHbNn3RD7vddiqVwXCjh?=
 =?us-ascii?Q?SZOrMXxuve1GV5zE7YFv0DKM9SvuydGOhh+szM3B5oYJlpgXSPxdp2PM68h2?=
 =?us-ascii?Q?RNvp2DgMY5oHn6MjMjj8PwXmaRbeEdOFc+fHbk0/kgSBqiKsscz9BzWSSkg9?=
 =?us-ascii?Q?6OlREkPfaSWJVFedDArgvSDcIfNs7y0+cYzLhMPYiAgY5ylV/ur4t04pzz81?=
 =?us-ascii?Q?+tpeygvJdXH1g01zPPfk5m9a5AA+zZbmZGuRdRYfD5VgoqWs+bnth3/wCmKk?=
 =?us-ascii?Q?zBefLc7XR1MFJbwjTRzUdP9/aDX0rg9x9ec6/nyF+r60J1jxUKaQdBdwCJ8e?=
 =?us-ascii?Q?CRaDpY1/gar9fizpLZ/mjndO58G4TqmZdhFaEJsPMsJUi321ja9G6h8NVjmV?=
 =?us-ascii?Q?FOeQcd1b3BhffgSR/WLyG6t8rW4deehMjEumqXAikwe2aDjsKjduH7lB2z6U?=
 =?us-ascii?Q?lbO3teCJz9lDPQbDX07Gyud8VJVaLnqgpp0TqJ8EsP19LzYXCytJmIX5ckZ2?=
 =?us-ascii?Q?t/w3lS9481vJEMs3KFPyxKJvNYcuea5yEjvVPFHEgK1/WKiruE6ptb60c4r3?=
 =?us-ascii?Q?szNdgIgbxn+MPswapzMjyzMAFHr8BFFXWyGTD07LGv1hNnHe9hqjDy4+/Wxo?=
 =?us-ascii?Q?aQsMP0yqAR/AXMtODLWp/qkqtp1LwRUunL4Duq9ARgVbOgPYxBxfKOYUfPyx?=
 =?us-ascii?Q?VBRFW2xruMD6T72n4KweHKyLJjZLZCKx7ZYfcjLVgINoMhZHp0OCu+bvyzxj?=
 =?us-ascii?Q?YuDEBoeyHamrlSIo2fUEns9nhxS22/A5eNqS7jj6BHbMY9O3gP/h3gcK1YK3?=
 =?us-ascii?Q?TIHhRQm7LDyd/V0JoaMYG0TozE+qVTdY1Qd17y+06Yd8vs6IKuQLDRDNUXHM?=
 =?us-ascii?Q?SF58D6D7DQan+9FwSEsQ/fsathpA5NIPn0rYLAzVwiVRMVg5YlhOzsE2KfbX?=
 =?us-ascii?Q?tNbtQhKC6GVrZHbXOY0fAWMn+oITF2kP5aW2i/+qBV+WIQptm44hRf9CDfLV?=
 =?us-ascii?Q?FDTIqY4bgJyHVrIusG5poVLa22twzLZfKwRBsmZSB8rH4wXxsv9yJgvur9+F?=
 =?us-ascii?Q?AVNocwfWaWIAqDwIH5i9CsG6Sz15TSPoBCYJrpsKrKsa6+pPpTAhP0XqMVS2?=
 =?us-ascii?Q?Azele4BJ/YyWt6QmZZDTPElnPbrly/YMQ/kbPjhbnkkdaSvmt/5xkcH1pWLx?=
 =?us-ascii?Q?TEcca2fLKn85AM69CEITwoJqI0CDluozvilu2TTPHNDkFWLRSMLdxi7U82Nz?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4387f3-155f-431a-7628-08dce3b4d315
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:08:15.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDkKPd/hYjX/uIxWYwtZYGi9t+yJXsVuFa9iUhbFqedsYpEbxv67INTKfb5dvVfkONQqvJlUxrNRnhVtDsNjyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9199

sja1105_static_config_reload() changes major settings in the switch and
it requires a reset. A use case is to change things like Qdiscs (but see
sja1105_reset_reasons[] for full list) while PTP synchronization is
running, and the servo loop must not exit the locked state (s2).
Therefore, stopping and restarting the phylink instances of all ports is
not desirable, because that also stops the phylib state machine, and
retriggers a seconds-long auto-negotiation process that breaks PTP.
Thus, saving and restoring the link management settings is handled
privately by the driver.

The method got progressively more complex as SGMII support got added,
because this is handled through the xpcs phylink_pcs component, to which
we don't have unfettered access. Nonetheless, the switch reset line is
hardwired to also reset the XPCS, creating a situation where it loses
state and needs to be reprogrammed at a moment in time outside phylink's
control.

Although commits 907476c66d73 ("net: dsa: sja1105: call PCS
config/link_up via pcs_ops structure") and 41bf58314b17 ("net: dsa:
sja1105: use phylink_pcs internally") made the sja1105 <-> xpcs
interaction slightly prettier, we still depend heavily on the PCS being
"XPCS-like", because to back up its settings, we read the MII_BMCR
register, through a mdiobus_c45_read() operation, breaking all layering
separation.

But the phylink instance already has all that state, and more. It's just
that it's private. In this proposal, phylink offers 2 helpers for
walking the MAC and PCS drivers again through the callbacks required
during a destructive reset operation: mac_link_down() -> pcs_link_down()
-> mac_config() -> pcs_config() -> mac_link_up() -> pcs_link_up().

This creates the unique opportunity to simplify away even more code than
just the xpcs handling from sja1105_static_config_reload().
The sja1105_set_port_config() method is also invoked from
sja1105_mac_link_up(). And since that is now called directly by
phylink.. we can just remove it from sja1105_static_config_reload().
This makes it possible to re-merge sja1105_set_port_speed() and
sja1105_set_port_config() in a later change.

Note that my only setups with sja1105 where the xpcs is used is with the
xpcs on the CPU-facing port (fixed-link). Thus, I cannot test xpcs + PHY.
But the replay procedure walks through all ports, and I did test a
regular RGMII user port + a PHY.

ptp4l[54.552]: master offset          5 s2 freq    -931 path delay       764
ptp4l[55.551]: master offset         22 s2 freq    -913 path delay       764
ptp4l[56.551]: master offset         13 s2 freq    -915 path delay       765
ptp4l[57.552]: master offset          5 s2 freq    -919 path delay       765
ptp4l[58.553]: master offset         13 s2 freq    -910 path delay       765
ptp4l[59.553]: master offset         13 s2 freq    -906 path delay       765
ptp4l[60.553]: master offset          6 s2 freq    -909 path delay       765
ptp4l[61.553]: master offset          6 s2 freq    -907 path delay       765
ptp4l[62.553]: master offset          6 s2 freq    -906 path delay       765
ptp4l[63.553]: master offset         14 s2 freq    -896 path delay       765
$ ip link set br0 type bridge vlan_filtering 1
[   63.983283] sja1105 spi2.0 sw0p0: Link is Down
[   63.991913] sja1105 spi2.0: Link is Down
[   64.009784] sja1105 spi2.0: Reset switch and programmed static config. Reason: VLAN filtering
[   64.020217] sja1105 spi2.0 sw0p0: Link is Up - 1Gbps/Full - flow control off
[   64.030683] sja1105 spi2.0: Link is Up - 1Gbps/Full - flow control off
ptp4l[64.554]: master offset       7397 s2 freq   +6491 path delay       765
ptp4l[65.554]: master offset         38 s2 freq   +1352 path delay       765
ptp4l[66.554]: master offset      -2225 s2 freq    -900 path delay       764
ptp4l[67.555]: master offset      -2226 s2 freq   -1569 path delay       765
ptp4l[68.555]: master offset      -1553 s2 freq   -1563 path delay       765
ptp4l[69.555]: master offset       -865 s2 freq   -1341 path delay       765
ptp4l[70.555]: master offset       -401 s2 freq   -1137 path delay       765
ptp4l[71.556]: master offset       -145 s2 freq   -1001 path delay       765
ptp4l[72.558]: master offset        -26 s2 freq    -926 path delay       765
ptp4l[73.557]: master offset         30 s2 freq    -877 path delay       765
ptp4l[74.557]: master offset         47 s2 freq    -851 path delay       765
ptp4l[75.557]: master offset         29 s2 freq    -855 path delay       765

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
This was not what was discussed in
https://lore.kernel.org/netdev/E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk/,
but I will approach that perhaps differently, depending on the feedback here.

 drivers/net/dsa/sja1105/sja1105_main.c | 58 ++++----------------------
 drivers/net/phy/phylink.c              | 51 +++++++++++++++++++++-
 include/linux/phylink.h                |  5 +++
 3 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index af38b8959d8d..864f697105d8 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2291,14 +2291,12 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 {
 	struct ptp_system_timestamp ptp_sts_before;
 	struct ptp_system_timestamp ptp_sts_after;
-	u16 bmcr[SJA1105_MAX_NUM_PORTS] = {0};
-	u64 mac_speed[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_mac_config_entry *mac;
 	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *dp;
 	s64 t1, t2, t3, t4;
-	s64 t12, t34;
-	int rc, i;
-	s64 now;
+	s64 t12, t34, now;
+	int rc;
 
 	mutex_lock(&priv->fdb_lock);
 	mutex_lock(&priv->mgmt_lock);
@@ -2310,13 +2308,9 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	 * switch wants to see in the static config in order to allow us to
 	 * change it through the dynamic interface later.
 	 */
-	for (i = 0; i < ds->num_ports; i++) {
-		mac_speed[i] = mac[i].speed;
-		mac[i].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
-
-		if (priv->pcs[i])
-			bmcr[i] = mdiobus_c45_read(priv->mdio_pcs, i,
-						   MDIO_MMD_VEND2, MDIO_CTRL1);
+	dsa_switch_for_each_available_port(dp, ds) {
+		phylink_replay_link_begin(dp->pl);
+		mac[dp->index].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
 	}
 
 	/* No PTP operations can run right now */
@@ -2370,44 +2364,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 			goto out;
 	}
 
-	for (i = 0; i < ds->num_ports; i++) {
-		struct phylink_pcs *pcs = priv->pcs[i];
-		unsigned int neg_mode;
-
-		mac[i].speed = mac_speed[i];
-		rc = sja1105_set_port_config(priv, i);
-		if (rc < 0)
-			goto out;
-
-		if (!pcs)
-			continue;
-
-		if (bmcr[i] & BMCR_ANENABLE)
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		else
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-
-		rc = pcs->ops->pcs_config(pcs, neg_mode, priv->phy_mode[i],
-					  NULL, true);
-		if (rc < 0)
-			goto out;
-
-		if (neg_mode == PHYLINK_PCS_NEG_OUTBAND) {
-			int speed = SPEED_UNKNOWN;
-
-			if (priv->phy_mode[i] == PHY_INTERFACE_MODE_2500BASEX)
-				speed = SPEED_2500;
-			else if (bmcr[i] & BMCR_SPEED1000)
-				speed = SPEED_1000;
-			else if (bmcr[i] & BMCR_SPEED100)
-				speed = SPEED_100;
-			else
-				speed = SPEED_10;
-
-			pcs->ops->pcs_link_up(pcs, neg_mode, priv->phy_mode[i],
-					      speed, DUPLEX_FULL);
-		}
-	}
+	dsa_switch_for_each_available_port(dp, ds)
+		 phylink_replay_link_end(dp->pl);
 
 	rc = sja1105_reload_cbs(priv);
 	if (rc < 0)
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4309317de3d1..ba13f80ed45f 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -80,6 +80,7 @@ struct phylink {
 
 	bool mac_link_dropped;
 	bool using_mac_select_pcs;
+	bool force_major_config;
 
 	struct sfp_bus *sfp_bus;
 	bool sfp_may_have_phy;
@@ -1551,7 +1552,8 @@ static void phylink_resolve(struct work_struct *w)
 	}
 
 	if (mac_config) {
-		if (link_state.interface != pl->link_config.interface) {
+		if (link_state.interface != pl->link_config.interface ||
+		    pl->force_major_config) {
 			/* The interface has changed, force the link down and
 			 * then reconfigure.
 			 */
@@ -1561,6 +1563,7 @@ static void phylink_resolve(struct work_struct *w)
 			}
 			phylink_major_config(pl, false, &link_state);
 			pl->link_config.interface = link_state.interface;
+			pl->force_major_config = false;
 		}
 	}
 
@@ -3870,6 +3873,52 @@ void phylink_mii_c45_pcs_get_state(struct mdio_device *pcs,
 }
 EXPORT_SYMBOL_GPL(phylink_mii_c45_pcs_get_state);
 
+/**
+ * phylink_replay_link_begin() - begin replay of link callbacks for driver
+ *				 which loses state
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Helper for MAC drivers which may perform a destructive reset at runtime.
+ * Both the own driver's mac_link_down() method is called, as well as the
+ * pcs_link_down() method of the split PCS (if any).
+ *
+ * This is similar to phylink_stop(), except it does not alter the state of
+ * the phylib PHY (it is assumed that it is not affected by the MAC destructive
+ * reset).
+ */
+void phylink_replay_link_begin(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
+}
+EXPORT_SYMBOL_GPL(phylink_replay_link_begin);
+
+/**
+ * phylink_replay_link_end() - end replay of link callbacks for driver
+ *			       which lost state
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Helper for MAC drivers which may perform a destructive reset at runtime.
+ * Both the own driver's mac_config() and mac_link_up() methods, as well as the
+ * pcs_config() and pcs_link_up() method of the split PCS (if any), are called.
+ *
+ * This is similar to phylink_start(), except it does not alter the state of
+ * the phylib PHY.
+ *
+ * One must call this method only within the same rtnl_lock() critical section
+ * as a previous phylink_replay_link_start().
+ */
+void phylink_replay_link_end(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	pl->force_major_config = true;
+	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);
+	flush_work(&pl->resolve);
+}
+EXPORT_SYMBOL_GPL(phylink_replay_link_end);
+
 static int __init phylink_init(void)
 {
 	for (int i = 0; i < ARRAY_SIZE(phylink_sfp_interface_preference); ++i)
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 5c01048860c4..d978daafd0e9 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -687,4 +687,9 @@ void phylink_mii_c45_pcs_get_state(struct mdio_device *pcs,
 
 void phylink_decode_usxgmii_word(struct phylink_link_state *state,
 				 uint16_t lpa);
+
+void phylink_replay_link_begin(struct phylink *pl);
+
+void phylink_replay_link_end(struct phylink *pl);
+
 #endif
-- 
2.43.0


