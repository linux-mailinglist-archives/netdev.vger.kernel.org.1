Return-Path: <netdev+bounces-239943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBFCC6E377
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8D4B32E2A3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61E352FB1;
	Wed, 19 Nov 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pvl8qjnn"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6735295B;
	Wed, 19 Nov 2025 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551532; cv=fail; b=SFaABYovIVwozYI8ku0d0UOkcfFvk2v1jqF6qpMdIsiLg9nqnGyj9REHAfkYEiX1oR2hPxcSE/qlDrw1FNdQ8S3+eniSiXKsj3SGELjRExDKBt1SAn0sGw/oRWJNe1p8E6JDj29up/cyroverU6UhLH2GiAnnMSqiGtJBjhMBKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551532; c=relaxed/simple;
	bh=L2Bxb6k23uGwa+rHWInJUPmhzmps215NviXsK0udoZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aMKp7HfLaPO/5nmH2k/tnAgVOimcBdDFtWqJ5nN8S7iU5FfEqIWxgruKx+RTkyDyzk7Z6ue7OE9xhW/iH+p3LNWmWAylQ2Ny0xPaC7v2T1/tMurzg914ptciBIyknq7+sVhWVe2sJvD5PMc6Gn1KvMFuK3Qkarh/za7xL2MbVOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pvl8qjnn; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/X3UT7FTY8aIK5P2kvm3S9N1gM9M6UnkV+2iUCOZ3+0peWIrWYcyB8HIqB6/QZ/+zPJ8+7zBXal3kLMaRH5Av33KkK32tD0tK3yZGBiCMx7gwMgMiigzI38xVzx1sSCGAiUEQgRxZp58R9pGf2gwcAWIxWAMjRHErgoSN4N0+PXUJB3Mpz9zTe2jIWY24B0ABt+JvPqqvjLIOmCL1B8tjopvDtH2XjHy8K8xiTMt2we1AjN4I+w+xGqtRy/x2v5H/JSK2C1BP2GPlMoT1OPaZhpgEGcCXgE4kJ0+XfH4XqAb8tVxCKYUaWbuNd/Hylnq54cNgHNAUSgwjyvvgyZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBRSTTkAeTJQUJAWRyafwen4N5j3FNawZbky2y8UJDs=;
 b=Cx4urM01ly8PsxCWmAqjVDjNJ7IAu0jpg59JkhjStQbHvFcTrCzlhK3uDNpjv+/Cku795l+mXZKIJzl+tax2K8CTDwx+NUHlmkCMNlSE4t+SO2kYjITGw2UhMpBHIoTHLxyK/TevTjHTjuOdIFm8fHsxW2LX9AiKNKE1Fu5GyLqOC+S8IU/64qSEz3SN8SeVIpWFIWwUynScyM1xC0qU1WaqIRao3FXMKQUgXGyyit3iMcqLioBJdl/CJSgYkOBbhm5fmrGeTof3U+KY2eFaZrGsmjVzQV7MkLdumx7YkRvb3VivCRuv7WGQ31iN8EjUmq32HTal51RNzPhubN87UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBRSTTkAeTJQUJAWRyafwen4N5j3FNawZbky2y8UJDs=;
 b=Pvl8qjnn0MBrffsLcFqaeZtmNwik3R4iwr45BcG9sIRcMdd141cMyAqv4hBEhoaT9LZbs3dtB+yDcxLN0OJpyV1niua9/DFwaEw1Jt94KDvzMZfqTHe0xATM1gBX1/t19GbYjO792sy5LZnYO9ufArIRDafF0OxV2uAJBNj1WFvM0UUDj+AUpiVNcY2m1PGd1C/SPT5ck4FANv6i+YNkoTPye6iVmOVC7EQiVG8vv6X+wGz+WhkfozDsabtgel5vLrRrCXyQEv1ed3ZD2PMrDJk5nPsvRRO/ZlmnTKX4JebL9G/LeIxXga3CHbw6S4hut4TEBYffIC/R406FWrmwxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:25:26 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 11:25:26 +0000
Date: Wed, 19 Nov 2025 13:25:22 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251119112522.dcfrh6x6msnw4cmi@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
 <20251119095942.bu64kg6whi4gtnwe@skbuf>
 <aR2cf91qdcKMy5PB@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2cf91qdcKMy5PB@smile.fi.intel.com>
X-ClientProxiedBy: VI1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:803:1::23) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b879f41-1663-4b92-96cd-08de275e5623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4EUlwRQbcMqhatJj4TqgxUVzGsKkuSkPKUqop2Oa79KnM3FnoZmg0tvo2VKI?=
 =?us-ascii?Q?gpLtzA/kbtWZKs6pdPdUqKA892kU5kQizXqTJAEZCfRWQLvnPQe2yfoNqnU8?=
 =?us-ascii?Q?qmHAVgmTzTDYgeW9B3e9l57y+9ozzOua8Qz08fLGD+Lht8Jcf8ttC85lghhy?=
 =?us-ascii?Q?N92bKN/RF+0BaWlzLUDpEna9FrOF3dp1meCXUfStv++Ua77O/rKqz5NqGUhW?=
 =?us-ascii?Q?HFkHEH+qXt+sFdmN6lrKWSvEL9KqK/85YS1K/oqHJujyJMaGOY8jqBpRm36t?=
 =?us-ascii?Q?ivZirLno/AmV9MZqhL8hrd3yicdE0vVUFY0lZFlgEzRgJNMOFQtaTfARjbgo?=
 =?us-ascii?Q?ZEnPjpY9yEJstJxpuIWBEvtjZWqNGZEwroOlvp9H5BKEXvehhJ0HnNZL5bF2?=
 =?us-ascii?Q?URLKA7mZ2iH+FHaZi6YPjhDAIdKor1FY+H3YgmvJQ7jBf1P/9wPlaqXBYhi2?=
 =?us-ascii?Q?f/1IAlB+urs70u+9563S11ozW2cuqWUy3YQvnliY2QbBm68W1eFyzHwGrpxJ?=
 =?us-ascii?Q?IXYybd6rNuIZvpUJNHrLO8uKo1sdb3Jx3o/oLrA6qY1AsPceVPZu30ZfEZX+?=
 =?us-ascii?Q?9rfZL/2Ih67MZFkwUNa3sYmMtc+2QMH6Q2SlfXYa2sL0qjFgiZ/pcf6BWtqm?=
 =?us-ascii?Q?GITeG66Mvp4ZP84TJr9uSRwIcaMHgE26yPOFcfIzJ2+FSdJo6BfaaLFGvpFl?=
 =?us-ascii?Q?X4XLng7sBfzRTlhWdmBYeLNHTX5tCl9McQh+zfPRlRrglpyjYTEz2Zw78Mvc?=
 =?us-ascii?Q?GlhxH0hn9cSmg+TVb0yWSBlp/4on8+8SGZ41g438YOTqbmTARSOxm9iaiVH/?=
 =?us-ascii?Q?0x0U+UNO29AUoU8M5suOuFaJpKEfyTIe6pL1aPd4I+VkbRQNUFK+cNBFOdge?=
 =?us-ascii?Q?IunqXUjZwsqm0KBX7S2WXn1il+HbvsZ1mLhQE+5ZripB3/joTWR1DlcssDPt?=
 =?us-ascii?Q?t/O+lXe7Yxs1cZmbvcNEkj7dNyb0UjDAE+07EWiKyD616AMXlP4kF6Qx/HRa?=
 =?us-ascii?Q?/jjyynpq/Mc66ujlijHheyMQq6ZuRGTsrkKbJ5QKCp7+IOkgqR/6R6S/m6CI?=
 =?us-ascii?Q?TN+GQiExoElGABU1wPjCctphOFieVTnEsm6YhE8Qr3A+82UKAL7Aa81iMxtG?=
 =?us-ascii?Q?FrVyjZxk5hQqmJUfTl0YX++bXSBonAmFLmWmy5A5GBAo2ds9AfWzHeFeUxCt?=
 =?us-ascii?Q?k0/VRSU0FN+4wR8mRPUZUPHs6wW02G13yXlhxk2yPCT5+s8n60qzbxAihpdc?=
 =?us-ascii?Q?DqQC35O+LD/RImGbBkZium2MdT0UFbyEYXgNfOIvHxWGXtkWMYPEQJc+jm6k?=
 =?us-ascii?Q?g5hgbbxPChhD+nwyr2hCUbXJqK5XVY0EMjdOfEgpyYZhEnzBsyxpMl4O563W?=
 =?us-ascii?Q?HhHkF03JmankGgqQSvfLRYRW4bUxv5NxISqmaxiE+kx310BVdbVVaNjg+qTz?=
 =?us-ascii?Q?JVUOXPNYXIGApuE4hi+G+MN0LlFAfhDu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/JAnb3LPsIXd+xaqDcXW6Gcu0jWotPpJasEoe5q/M7RXqaDVeNXY7pMMudiu?=
 =?us-ascii?Q?oZ/Za1JFaBzly0SxRimsrdjKfKnZUipF+p+Pn7hdJ8/pC19wm7gRey2fsBaU?=
 =?us-ascii?Q?l2MbYeMnIVDMSJKVlY/cwgAqrQOAJARqI3rjzcNCgfAd143jKtoTx3xICDOs?=
 =?us-ascii?Q?cpaGnbwxRjmzLUqcMTS8zsMBlwUsXlXjWibCPfu+V477ePoaGHfCBQQRmUNl?=
 =?us-ascii?Q?DOps1E/iA7uvnTZ5gtheNegq4HB03y8jgpXO6etyLdVrEi/GCEVkhIfvR6u4?=
 =?us-ascii?Q?iFXIEi84lSVUAeUQVCPHd7Q+FqG5WpGIWpTnLI1a2upGHVYpbQIGlfIiuRXE?=
 =?us-ascii?Q?FnswceZNN80c2WE7b1DTgAf9aBexuvtbyaXrymilkMBhA24O3v5SKK86eqq7?=
 =?us-ascii?Q?9gpivuj4CSojgYSk54z95i/KT0wKWPk4/XoTB85iVxBqI7uoNpIqITM9doXj?=
 =?us-ascii?Q?M8WqBZAWZpXfhRREMj8VNRJCziUvDF771YwqVRFyCzSBlZOzE7E5whFpY56H?=
 =?us-ascii?Q?637iDN30Wzam/6+p2IwikSJOKfBfS4vi/lQgOyWbwlFco6V0Fy8UyVWHMhBz?=
 =?us-ascii?Q?XPatVbiufcVSDrIs9pr5Lfhlaq7QWBQ3sDwfhSnUOPl0S52OMpCrs/ed4iGe?=
 =?us-ascii?Q?u5cloPHiG3KtXzpxX4wrMVLiX+juzGwcw50+NIklzCtZm2N+a8GyPp4RcEmL?=
 =?us-ascii?Q?CwC8IDPdY7FBaBtUdY2PO2SGdtw8Ichn7sxcf65UqcCNpbna2ph7VSJgqxq5?=
 =?us-ascii?Q?G81hcPAjocZ3jlP9MhlDSGiHQsiBm1ueq1StBOOKEj5Bt9w8KOQL2AXewIkS?=
 =?us-ascii?Q?ijSM4sReMlbtucz9gcSdcvYkKS5tvO5Ljy6yg+g4TZM4qsd1pc4gTRg25w9m?=
 =?us-ascii?Q?bWwTcdYEgTXsQqWZBoSd61zjvzh8aFoR6U/vnwVEDmXmxiyd8/kbZKKu1ATg?=
 =?us-ascii?Q?5L0KXRmRr6Z4dj1wyZcDxT+HBHXGWzyEAsJT/Rad+/c2nxmTterFl4z8Hqbw?=
 =?us-ascii?Q?3NbGclKTyXlOeTIk9drzLf39LuVtrOjw9Li9iMYBszf9t/8S4gwEmsqEw0cp?=
 =?us-ascii?Q?MeFF7hIGnr30gpwdd7Qg6HgOhlI2VemxUALrHRaObjMNQNt48yGrz9ujgCI2?=
 =?us-ascii?Q?Asj6FW+IKbB9ghH+3IclLITxzrAyAi9+meBaKY8FfAAv90qDQI/Bqf2PtgCy?=
 =?us-ascii?Q?kqTDyN9flmXmVSSKjhz6T9D+U9ekdoUv8F4VNgvir4++WuqaEo2x/iJr7Xbz?=
 =?us-ascii?Q?bLZNCNc+uMoWrrOqP0iz0J50liDsdaviyVR8LousC8syfsq8rJHzttXWn8xT?=
 =?us-ascii?Q?epqiCqtnk3qtB8oS+Sf1C+riKhBcnJu+8uVBdWwxGiUdPQpcrVWG2EZjeBZ1?=
 =?us-ascii?Q?7iEwtztXMMVTOoBreSo/fkA6mQV+q9/dyDDrpEA8GpmNYET27IJWZ8NGL/Df?=
 =?us-ascii?Q?GeKZNRWAQAGAhH6UjKPlkBrAAnpCNuzsXS8iOv8OYhx0yGn13+TQ6pQV9+Qg?=
 =?us-ascii?Q?l6KWb9IzIGnlOBsjPa4V4ENxQl/xAdK8q1TvO70/6f2X9koikSC5ZUEy4aox?=
 =?us-ascii?Q?1cEDr2my6YJl6ZEyblqQ/ojMBaB10ICcDAeC9MKHBuk/duq82qUYe39wQorm?=
 =?us-ascii?Q?fKNP7oRtfjnKkvQTLY60VLvr0/cHY/UTjN6BimTQbqtxeGJ6+dMhuSlyGMEL?=
 =?us-ascii?Q?CRiMgg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b879f41-1663-4b92-96cd-08de275e5623
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:25:26.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wzEEsqXGpCnRcMBj2ZJJa5YqBLBeFEG3IkMeHtzq3On2Ynb43N0LlZOg0/Le6XwvTIearZHwV+APvvQ3DEvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

On Wed, Nov 19, 2025 at 12:31:27PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 19, 2025 at 11:59:42AM +0200, Vladimir Oltean wrote:
> > On Tue, Nov 18, 2025 at 04:41:30PM -0800, Jakub Kicinski wrote:
> > > On Tue, 18 Nov 2025 21:05:29 +0200 Vladimir Oltean wrote:
> 
> ...
> 
> > > > +	for_each_child_of_node(node, child) {
> > > > +		if (!of_node_name_eq(child, name))
> > > > +			continue;
> > > > +
> > > > +		if (of_property_read_u32_array(child, "reg", reg, ARRAY_SIZE(reg)))
> > > > +			continue;
> > > > +
> > > > +		if (reg[0] == res->start && reg[1] == resource_size(res))
> > > > +			return true;
> > > 
> > > coccicheck says you're likely leaking the reference on the child here
> > 
> > Ok, one item added to the change list for v2.
> 
> Note, we have __free() and _scoped() variants of the respective APIs to make it
> easier to not forget.

Ok, I'll use for_each_child_of_node_scoped(), as it's a good fit, thanks.

> > Why is cocci-check.sh part of the "contest" test suite that runs on
> > remote executors? This test didn't run when I tested this series locally
> > with ingest_mdir.py.
> 
> I believe it's due to heavy load it makes. Running it on a (whole) kernel make
> take hours.

For context, the "local" NIPA tests for this set took me 3 hours and 34 minutes
to run on 32 AMD EPYC 9R14 CPU cores. So if cocci-check.sh increases that time
by a few additional hours, yeah, it's bad, but it was bad before too, so
the "heavy load" argument doesn't satisfactorily explain things.

Plus, looking deeper at the NIPA code, it only submits the patch set
under test to a "contest" branch if it already passed the slow
gate_checks=build_clang,build_32bit,build_allmodconfig_warn. So it's not
like the "local" build tests run in parallel with the remote worker, and
we're not saving any time for a single build.

I think it's due to the fact that the "contest" checks are fundamentally
so slow, that they can't be run on individual patch sets, and are run on
batches of patch sets merged into a single branch (of which there seem
to be 8 per day). I didn't get this from NIPA documentation, though.

