Return-Path: <netdev+bounces-128783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4A97BB50
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C44B1F25028
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B310188CDE;
	Wed, 18 Sep 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OfXG8U/7"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013001.outbound.protection.outlook.com [52.101.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E69188A2B
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657816; cv=fail; b=TpQebua3nyvU77fnbn5YsUyIXrQ4IMovyawiaCMzE7cDngHzxxGTnyc7eQWwobYqT6JfY6My1Ml43MvZGukQq4VMhDj8f9pqcBUPDwN2iz1QbilILs0l60hBxw01rR0HBe6aQrIRSsdQRifvFEUj+9mo006oM0000a5GSPlzLDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657816; c=relaxed/simple;
	bh=AUS3EkbdZf592+LUaFX8XDhieKI1UrJSEUnFS/2AJCw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GKTdvaQpF7AWH1lHxtF9hpSubANq6j0eu8qwb+g47sGRAQslrIEdf/wqhrtZjHSxoYkTX7DMYTyCI+qXgJUTt2amN30Bc697htsuaidlM/0/4AACi8siXebXftXsDL9TKDceoOIww8MUV6aTdG9KXl0mT0KV6wKyihp4HSBe/vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OfXG8U/7; arc=fail smtp.client-ip=52.101.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLZfvuqIzU3E/r2o87L4hdiwEygzY5fLi9GXd5vgDqwfpAXnXHnn9waA7p/W25r7cXe0Z5TLqSAaLR2XNOx+Hm5Fe/HeBNLp9+DIsZivwnTLZbg9HaEKPjJTVTehnq/6Evna4KozMY9QeQ/nf3HafwjRg299F+vG8tRp70Qpkx4R0XrdzcrQlRE8lDhxk0ezQveXa1vOmm8SMZGgiCu8UosrZmHw8g9Ie0OFm1GzDk9yQWOL2XvLYMemh2+rdom9FEDVWeb+tNGIuYr8eg99oj5KJ2MB29jRdy8hsg7cP36yc21bTu7opygxhpoFevpslWE0yMwno2NI/nqWib7K9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e03teFNLzCNPnVUI1ffpm7XCNBXoSSPibkDzwWkp7c=;
 b=Qe/ZeIyQrLk0Q2Yd1wzGf60FZTmcY/hJJkCl1YqE4r8Kx5JGVWLUXT5Wp3AMRFlaxXKCaYIfZEmR2SfeWLeyodkFTTXXKBQAwHZjM1z+Md9ElzkZlikb0A1pkB5tNH+kjygAJnW1HnkbgYhJp1+TY0ZpVdcpH17w+GJmlhI8UHVKzNoQu2L9Ji3skXW2IaloF+Q1jiMA2mrgkd4YOPhTzsUQb95XZrYp6YlXrqlu5M2M/CI2lSuZ9wbVq3vsIi+vM401gpM+UtNe7DMcHKBbZVgoj+GyauCfSXYwzX6eR1vat/sf0x+pWaBrsp+8XQ9VIIgJ1lFgYlriinaNjvWdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e03teFNLzCNPnVUI1ffpm7XCNBXoSSPibkDzwWkp7c=;
 b=OfXG8U/7gfMqg1VztBLdusXb3E0zStUe3aCIk2XaKEiGWBCwnItPsQtwz1GwaU3Mz2KU+B/SQ7u9NReYv9SoEKUXeX1JfjswhthblvAccrK1N/ezRxOWJRVifijJXMl7YRLFNqvM2Rd+7yjtAvugKpl0HFnY+pO+mkZQlEKewc5cpwnNLE8afKLGR6j48nfRPMjSYTkwb1qGPmkcSUZUYYu7n/Ba+mhbK9qM66JFGCVb4+ySvRLqSGTEGaOSGza5vd0Kz+cwTEYmG7YlhNgJDoHR2xwUogHHB5xNqjZfbaRHWf7scz3Uob0esS+JDqVfO82eKPenBNOdOL5Kr4BekQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10424.eurprd04.prod.outlook.com (2603:10a6:102:419::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Wed, 18 Sep
 2024 11:10:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 11:10:10 +0000
Date: Wed, 18 Sep 2024 14:10:08 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>, netdev@vger.kernel.org
Subject: Component API not right for DSA?
Message-ID: <20240918111008.uzvzkcjg7wfj5foa@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BE1P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::7) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10424:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa0dbcf-48d7-4a37-7424-08dcd7d27630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E3YKvHSdO5eweqiqPLYnGIb4eGsDyrSS5sRkrzSfsUOBAe2PbRZLEOoFqc/s?=
 =?us-ascii?Q?eh2MawcQppFBFxsHeLxERCrSOsI5PEnfLfwokWqvT2lxc2OMZmLM6N0A9Jjb?=
 =?us-ascii?Q?sEKinzFrCSGasJSPoWEZ2ZqB9/J9h5maPdSJU9vNxrtbIc2jnwcrnW+KzQxD?=
 =?us-ascii?Q?707XNGaG8OdeZRH6H/9ftnUy+XIOLSVv9YdcQ0AELLxpNPYet/I2EMFfGkTo?=
 =?us-ascii?Q?Xi8dTgZtm9XQS3un+IvbOHlwnKDxKt+tUVgfcSPKn1zP/Iyve/UAUKKCQM72?=
 =?us-ascii?Q?PIpsj7qcD2n1glafeR2bJTuNUF4udlUrKAJbSPFqLJcGDZKJkLpi6t0rcbC5?=
 =?us-ascii?Q?r73ILnkLvXyvVV64vslvtY+esHRqAeb877xZm5MHpb4L1y4H6LPBIy+D3nXo?=
 =?us-ascii?Q?HIlGwOIPFKFcOC32fIbPyM75m7ABmmz4VpJmbbLgr7vvJ8bugkWIl69KOnkM?=
 =?us-ascii?Q?QW6DOSwev2L5YjJLPX9+Va9U1U/T8xfysYPbMGke3X1f5Pil7cgDi+8qNhWB?=
 =?us-ascii?Q?n5MuIJ5OGCq18TTay85AWYkJwkkUJMdQ7PoMj2pYYH2Ez2A5ppp3BMeTQet8?=
 =?us-ascii?Q?2EuId0/DRnoXxxCLII3c2hOEFg426esd7so015Z3MbxaqwYIAXZBonvCfSGK?=
 =?us-ascii?Q?xVY3EKNhltfWbt6B5nZ5ZJn779MzG4LG+Rpkj8X/oIS3Bla9kvv+qQOMDRQp?=
 =?us-ascii?Q?ItA6rvKi87ep1hFqaun6E2nB6r+rt4IuYnXrpUS9GUEGcSpTHNWh5qVbKvIC?=
 =?us-ascii?Q?LdlZk7VcPekhmdJ4WWALUN2ZWzanBXOy6Te8KTjrQUWkbukGR8HIe1Gcss5H?=
 =?us-ascii?Q?nBi8UDdHugsRjXAJY9Et7DlUdqJQdFfv7yoOwnfrDNedvDHwvAt05857X1AZ?=
 =?us-ascii?Q?ovQPPCo3Am8ddlAsP4/zlEzKE/rEo9g1Fx/4fllsmP20kWDONvWas/7krJeo?=
 =?us-ascii?Q?SezlnFfUZFCUgcKvj2VESx4kZ1Zcfa7Frvuljv9ZnB96R7qYhFcD//IkvQwp?=
 =?us-ascii?Q?kTcueKUx6w+35ff1zXya53SzIrbGXNL2AUAAhLQ0y3mRmNWtmsh5xVNCTWst?=
 =?us-ascii?Q?Grr2Gb7svA/eErIr/SsV6Q1k7GVQv+V93n1cF6raWmPY1hQzKzK44XI+YgRQ?=
 =?us-ascii?Q?oRSkNN9sQK4JVXx/HdV/0vkQy9nwiWbewoDrT1qp/g9/mL9a8wPiJKLy+ztW?=
 =?us-ascii?Q?W+yas19QA38sL+WtaVH4m6V0QVoHEqBV2IGDCtz/Ksyu3sOIws1+PhV06W3g?=
 =?us-ascii?Q?hGrwHrSDExiafeHjXkJa43SpDlNyYWBNN6U59+nC6b3omPGwqcuBmje6vtf8?=
 =?us-ascii?Q?JA+MkP9IuaCbC6e4LvtJ5yq2cXSUJ4EYroLai9SkvcVxD77YbhGUGb7EYR7+?=
 =?us-ascii?Q?Vlu7c/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFs9hXIiWWdmHOEt1Xrh0OM9rgWkwMbcGU1qkh1KsKMz6COfbxVrapvm69Wg?=
 =?us-ascii?Q?8CZCKswrS/Ahs6x9A71J1JH30VPQzj9XPOfwGaaa6Tt+Qp+d9lf2ligpKLm4?=
 =?us-ascii?Q?cFuOF1ZCuLjg/LDFO2PoipA5TLvsOSa/2cSdnZRhoM9RHTOELhHOho3F+Tp9?=
 =?us-ascii?Q?H4GG73Qupx8IDBlF7+q4JCkDDdShJ5DDugBrKb9DANwKoM8vX/+RuWwGSB6f?=
 =?us-ascii?Q?HxKA25TGxXL1rNqguXjealhyTJQYzADrpo3Sk66Vm51OrvtOltfWhhXiNYvH?=
 =?us-ascii?Q?3JNOAoFrLiQDO3qmOOnwe3ucCzlFJGgwT2XOPEL3ll6PFTL4+lAqHKDbJJdo?=
 =?us-ascii?Q?fqSAzl+zUWsdou8WAEQaeZubUjMjybzMvvUE+Oz7WIJrKdwXxOsftVaEJpUu?=
 =?us-ascii?Q?d7NfVYRqJjVI+vu1K/5W1gfu+8zerfCzPTULKdFXiuEI4mL1gkgpG0l/85hm?=
 =?us-ascii?Q?+Ns1XT1yJXXKzwhUELW2V1TlYVI3sRb9h8Cwutk+bxvoA4R7ucObq9l2fABK?=
 =?us-ascii?Q?sbrwbi8p15R8gJL03KnTusqg9Xe/4pXINLwkvpLjV6uDlrQJgl88QDYwUp71?=
 =?us-ascii?Q?wndzanTfyvKlLC+yGqKG+EhNWfkx3MJrAwprV0cX+KZmU5jkvSTcVFHzVyfE?=
 =?us-ascii?Q?Momj/t4pwLUPjqnzonk5UlUGkIh1i0s8vqCoJ8goR0CyMfwda83dStdk143W?=
 =?us-ascii?Q?1I57t0EAZlVQkf7OBm/8pNlzywCwoZ9RvlxocDLZeYb44tZYsMvRgKQrfIdh?=
 =?us-ascii?Q?AwyM5YZEhpaTq0vgfjhRZjOdlsSxzdSkY3Y1Q1T5uz+xsa2yqsI38lHd9WiF?=
 =?us-ascii?Q?CrMZhwCwZCqJEB9YLT2/KEPY5e1nIuvmfFEr/0c45qLg57M1iFL4TVb9zWwt?=
 =?us-ascii?Q?rkvWzB/iL/TsytrDHGQvsrUMDEN+XRWlhKU5VQTdDOtoqcxDuWtYS2T6h2Py?=
 =?us-ascii?Q?gaDJ7AcqFXd9RfLWUDx3MBjKY37T777/XTWpWfmg7PKDQh5JXob9KNhdAuD1?=
 =?us-ascii?Q?wYVVkPK9JaaYmtsUeuVQvQStihBYelLXmjfD0RQyWwiUUZ7+xWJEjcWKZv7T?=
 =?us-ascii?Q?j1V0w4J2+3va7w9elkJhNPlDcKUQDrkL1P84iXaEN3We7wCOz4FxmPbMPIgj?=
 =?us-ascii?Q?mdJpBQSFNNd7TXPvQp83l7+nsmR7XwvykpDBd0UEcOwnQ2Pgb1jD0Ji/4I+X?=
 =?us-ascii?Q?cXG7byl+WXN2ga+34YYzCvCe/725M7pew66JP+dhqmDa2AZS3lKbuVG/831y?=
 =?us-ascii?Q?o5GHfNAi6DH8yxxl9cPvj3v7JeGRUH2CXtn/pgVpWnsBcr+QVcCNHkzx+sVt?=
 =?us-ascii?Q?DtdDqtJ58aGzcbV71Vk9oH5EuQ+8bIKV13Yg4BB7S1KD6nkkQZ/lf8wtll0l?=
 =?us-ascii?Q?p1NO7Hu8iF0NyYAV4Iq5wJi5Rs14AgSOkqQdLBORjOXbqV1bnzIPvh7PawxB?=
 =?us-ascii?Q?jrsTKpNbL7iT79X4xxf1X521BoUA0qfDs9pjwklcv7/ypry+YMyK+mVreBwZ?=
 =?us-ascii?Q?bLikZvrJAYNZEMYNssPLCB4m2X8Trkip9CNu7JkBaI1WwgSDB9XH4S7Wh6v1?=
 =?us-ascii?Q?usjJUDyu4Cg5Yy02TfdT9yym76Vo35pzxU0N8+yK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa0dbcf-48d7-4a37-7424-08dcd7d27630
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 11:10:10.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcS5/q4mECHkMT4GnsWhggZh1BO2UwZCPGLrkUYmmW7vY9SS/3x3O35F2yKxnIddl0ixofpS8Gsx7okc2z+LWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10424

Hi,

DSA probing in a multi-switch tree is a bit of a hack job.
It relies on the device tree providing complete "routing" information
(the "link" property between one cascade port and the cascade ports of
all other switches reachable through it) to determine whether the tree
has completely probed or not.

A switch which probes but finds that it has a dst->rtable entry (struct
dsa_link) towards another switch which hasn't probed will just report
a successful early probe here:

static int dsa_tree_setup(struct dsa_switch_tree *dst)
{
	...
	complete = dsa_tree_setup_routing_table(dst);
	if (!complete)
		return 0;
	...
}

and will mostly do nothing, except for listing its ports (dsa_port_touch())
in dst->ports.

The dst->ports puzzle becomes complete piece by piece, and when the
final piece of the puzzle probes (last switch of the tree), it sees that
all its link_dp ports are present in dst->ports, so complete=true, and
the code flow actually proceeds further in dsa_tree_setup().

The dsa_tree_setup() runs in the context of the last switch to probe,
and calls ds->ops->setup() etc for all other switches in this tree.

I don't like this for the following reasons:

1. I would like the device tree binding to make the "link" property optional
   (full routing table). Only direct adjacency information is sufficient
   to compute the rest, plus it is much easier on the device tree writer
   (https://lore.kernel.org/netdev/20240913131507.2760966-3-vladimir.oltean@nxp.com/).
   But I would have to keep this workaround functional - otherwise a
   switch will not wait for the entire tree to probe, just for its
   directly connected neighbors. Thus, I would need to run BFS to
   construct a routing table for probe time (_before_ struct dsa_switch
   and struct dsa_port are allocated for the other switches in the tree),
   and then I also need the regular variant of the rtable, that
   dsa_routing_port() uses. Could be done, but not great.

2. I honestly don't think that the workaround to wait until the routing
   table is complete is in the best interest of DSA. The larger context
   here is that one can imagine DSA trees operating in a "degraded state"
   where not all switches are present. For example, if there is a chain
   of 3 switches and the last switch is missing, nothing prevents the
   first 2 from doing their normal job. There is actually a customer who
   wants to take down a switch for regular maintainance, while keeping
   the rest of the system operational. This is currently not possible
   with DSA, because the tree wants all switches to be present. As soon
   as one single switch unbinds, the entire tree is torn down. They are
   pretty serious about this request, not just "would be nice if".
   And of course, not any degraded state makes functional sense. For
   example, removing the top-most switch must result in all switches
   downstream of it also getting removed, because traffic from the CPU
   can no longer reach them. That's fine, and I plan to handle that
   using device links from one switch to its upstream.

For reason #1, I started prototyping an integration between DSA and the
component API - something which was also suggested by Saravana Kannan in
the past. The component master is the tree, and the components are the
switches. For each struct dsa_switch_tree, I instantiated a struct
platform_device and a struct component_master_ops. The tree is created
by the first switch that calls dsa_register_switch(). It has a function
that explores the device tree using BFS, starting from that first switch
that created it, "link" phandle by phandle, calling component_match_add_release()
for the OF node of each other reachable switch. Every other switch in
the tree no longer creates it, but finds it and bumps its refcount.
The tree is bound when all switches have called component_add() with
their struct component_ops.

This is all great, but then I realized that, for addressing issue #2,
it is no better than what we currently have. Namely, by default the tree
looks like this:

$ cat /sys/kernel/debug/device_component/dsa_tree.0.auto
aggregate_device name                                  status
-------------------------------------------------------------
dsa_tree.0.auto                                         bound

device name                                            status
-------------------------------------------------------------
d0032004.mdio-mii:11                                    bound
d0032004.mdio-mii:10                                    bound
d0032004.mdio-mii:12                                    bound

but after this operation:

$ echo d0032004.mdio-mii:11 > /sys/bus/mdio_bus/devices/d0032004.mdio-mii\:11/driver/unbind
$ cat /sys/kernel/debug/device_component/dsa_tree.0.auto
aggregate_device name                                  status
-------------------------------------------------------------
dsa_tree.0.auto                                     not bound

device name                                            status
-------------------------------------------------------------
(unknown)                                      not registered
d0032004.mdio-mii:10                                not bound
d0032004.mdio-mii:12                                not bound

the tree (component master) is unbound, its unbind() method calls
component_unbind_all(), and this also unbinds the other switches.

The idea that a "degraded state" doesn't make sense for the component
master seems pretty fundamental to the entire component API. But I
figured I'd ask, before I put the idea of using this API to rest.

[ although I do like the debugfs device_component folder ]

Otherwise, my plan is to go ahead and introduce new dsa_switch_ops API
to let them know of dynamic updates to the routing table. This way, we
remove the baked assumption that all of it is available at ds->ops->setup()
time and never changes afterwards. There is nothing, functionally speaking,
that the component API can help me with, for this desired behavior.

Just thought I'd let everybody know of my current intention of making
changes to DSA, and gather some opinions/confirmation that I am on the
right track/alternative suggestions.

Thanks,
Vladimir

