Return-Path: <netdev+bounces-158845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C273A13839
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4096167B00
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106291DC197;
	Thu, 16 Jan 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PT9Rhr+p"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDB18B494
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024406; cv=fail; b=VXeMskn8fXtixGulppPhRFfimAt2ddoJMx+KIqcIldzGQBpkBev5VYycWmITCsRXa7QA3kty0gskrjs4qTEiPQt1WoOeHFhJNLBWfFssG0Z/B51OIeOiAF/EfNryqGnLtVfuSG/P6zYOqNOGgFAtaCslCnMBhTtzjTTD6/njj80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024406; c=relaxed/simple;
	bh=43Kf7xzBVsE4bfKdbqw9/20cz9ukuWTAw2qVwqEOYVU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cXxap65xSw8BPEjU1A1FXwFxrpl6dYacqZli8RqzaPR0DVQZdn4//GZ28HRh5YD5Y+3vXevb2bQQey67vNsipsc6MU9nsnGy5PmtoCB5LUqJKaQ36Ibd+zx1/fImcEzf6eM3KSjki1M4YCUvLV41+570NRXhnqsLQtT/+ySgW0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PT9Rhr+p; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRsbvKZCD2ojpgsKYbexbSpvhdR7rqYGWH7NIs/jnh/5OQOCIU1lZqZZQvpj5HTDcsv61yghUtCMOyMvjvPetH5guv0qxy0BA0rFd5fRylySFg52AX3SEqf8x/2gfyfYYYKKx7J87vWP3rZkz80d3BkqEOKe7fZxPxvuz+gZ3bre0VbBH/kvmVP+onEhC0hvq51JmzpV0CPP7ZA+Hy23Ubap7JrJDoZywD77UuhZvrWdLwb6avGAis+l2eIhXjumhkVyIxyaIGiOCscIkx6POrZYXn3MISWjY0zQmYTWRwArFk7NqjVRFfNbEqWirxHnh7yaEgSSNOXNlh5L/DEQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xnULy32FV3VjlL/NOlbzFqs+hF13B5w81yfdnLTqjk=;
 b=myVBVFF0hkVbsZff8heDemA7bbBQmvYZBDmcyhfk0AbCeNzKLqJX2vkqyE9CFMpO+M3DBARHJdc9lD+mv2CS55vuvOtYK5MfLAGIEVJygiz5847llhPNRCF8wv4Ruh7yc4f1oFlhvh9SJ9pgWZP1yCCCHqGx4PQRBBuQtxn6I/Gj+s5VjHQxLuDzps6YLo3rBpnIMbKmXzkjbsQfIBeT5yyMQDCLYL3ScprsMKXO2+lbXwB87SkGkHWmqHvU50qVnlfMIsi8JHLJ9bXRHha/IO8QPpREnJVJFmSAJXj7dmI0eKiUJM8LLtkXWHnUUIxedqwhKr3M3r4g7ICe3kOdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xnULy32FV3VjlL/NOlbzFqs+hF13B5w81yfdnLTqjk=;
 b=PT9Rhr+pCu0GKWI1KIN3o6Oq4nPXUGGZakvkAGQTRG7KRLXPUKBYYS2PE7NAgfOlLiB8gNXJwJGNN1eR+CuYBKZnxiHkmr+HZALPjQBsfNwqyS3kqXCmORw4+AiAPPXX1SYby17Dv+jNFGfXshfgufy1TE3NVRQiyW1DxSsnNCpk3f4lvVlETiynbhuD6tCbN/we5UijnkOTP1uXOHqcjL9meqPlBc066Qassbjizd8QZPFRCoHf3j9G2Xh0zfD600tDcR0RX0JJI/iMrUQ6fVUp0M/AFMh15yWYJ7OjTW31Ic8hoY4Dc/O1Cklgg76BXLicnbeTin9Bl18J/9g9PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 10:46:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:46:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net-next 0/4] ethtool get_ts_stats() for DSA and ocelot driver
Date: Thu, 16 Jan 2025 12:46:24 +0200
Message-ID: <20250116104628.123555-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: be7ad734-e16f-4dee-9067-08dd361b0f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJW8ECjShgknRE8FD8cce2cAWqyXlaSF5DM029cn+o7oWLmbJUgHiSop4g6g?=
 =?us-ascii?Q?zgQ56aCvy0hKNq6QjkA5f1PU9i/hZ0nxvb+EikB3cKw4XDCiF/1eMsim7lVi?=
 =?us-ascii?Q?ZyXbZjrkPOOv97tOyeXV5OJWWiqGD4R+BkRc0GtBGb/JmjnJPrwMZHuD9gh7?=
 =?us-ascii?Q?l9NKhltOwFpKHiBgnPDtVjATuO57yyef5OVZosjDuTsSOf1xP3QUCIInwCTN?=
 =?us-ascii?Q?rzk/bXvGbV6UifaSzE66+qwCkKIwCWzrQk2J8tqs1XMAdqkb1Ln2U+z4JiPI?=
 =?us-ascii?Q?kfTaoloHgsuy8hneXGbzt22J31avq0aw+1pXGXW/NWlRnw5mEljKFv5YD9rY?=
 =?us-ascii?Q?7Tn5ojaMmYx+6wRE+iK3cdg/f/SG4zvZHUPyR9WX2oDyet/d7Z8ARgIU+QY6?=
 =?us-ascii?Q?maQbmp4VgCkU3wlCdglK+rxkuET53uwbZIEBv+hdLgGrxreewYPaMJqWdK1g?=
 =?us-ascii?Q?BiKE9ZxhHAQB3ca/xRSbzk/0ZFQ8qnB7mXhB+0HZE9rAKliCi0wZ49FNgWeM?=
 =?us-ascii?Q?lY0LNq9/X1SXoI0km+Hw+qjW1DSWoGwzbN8rGLbXi1bQVtRWqHqKwFJCnEVx?=
 =?us-ascii?Q?qgg/3Qur4sfcX8cg3Cgs2yboY+3/qqLAzI4lT+yBek++32+pEwVcCgdK0A14?=
 =?us-ascii?Q?A98hDgJgUmVI+iOvWwutrPcc1cUQ6AUjOag1YO6nhkJro1K2CQ2uDwgYfNPo?=
 =?us-ascii?Q?i+9wPVidBqxi1SQ4QXDdq0od+w+oz4LVTG0+kheQhVsAToGrue+Y8L/qDmRW?=
 =?us-ascii?Q?NJIDDZmoCU4xG/ZRTZRo1jTeIALd56k1dsfkVtrvfF3YYjEfDPgW9s/Y7MFj?=
 =?us-ascii?Q?YzLmbmcFmH75SGi4AeOkx/RzwqsdgJmdoD1uAHiw8U72kLzTx2WChGjan2jJ?=
 =?us-ascii?Q?G9DGHc0jfVVqmgtvXCtF28MgBTdw+klAW2rPNoWWQCnmDoXJmJkqzuWgtnKl?=
 =?us-ascii?Q?1nruwwZQOxNhdslXM54D4ZFQ4zRk/Nokq7s9Jb8VdgdxvXUpGzN3rrmvjvsv?=
 =?us-ascii?Q?skkoZYVApTAZrrILI/PibosPo1q4+QGADlOeIo/LbZ68lt3Y+N1RZwZdli9T?=
 =?us-ascii?Q?Unl5bytyhnROirBqun7Hu0UWIWShOvVNEotewqYWPz/WKL2kkOnhOT6tZasF?=
 =?us-ascii?Q?KNYhKYkx860Q7NkV7lVHhus6osIGuehDDEzK8BSASPB3/K6CS3IKCeu3424+?=
 =?us-ascii?Q?X0euFZiZBBiWtOyknZE7HIyR2MgbODnQ+ArFY7lGqv9IPGtmgr/rgIXqEWDS?=
 =?us-ascii?Q?dXZevv8SSkwZF8sGrPtMcNwMuffu4hz8a2JYpRtXCGr16jU7XeOrdp9ikrgw?=
 =?us-ascii?Q?a1rjf+rTOIS5SqdFvFWmrFloYF6DiEv6GWfwvQUG+IAk0pyOfxH+ZZABVZQh?=
 =?us-ascii?Q?Ble2ezKxRcXBj0xWT1j+E05+Rivzzy+1fLYvDcUoY5VHwb9FlLQJmnEPTnyA?=
 =?us-ascii?Q?19Ln16O8H3w7UP8FvFN79eC8a+FjychMENw2PYzaQPCD8lS21sndHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDb6ASPZ7lz7/2ShUB68djQShGxsz505ZqKYBasfMylsXvq4/jbMM9fEWzrq?=
 =?us-ascii?Q?3uoAQvRlu6nOMEDfHxh1RICyuqqNhNHes2bHHn0KJSp728gF5tT8DrgDnHZr?=
 =?us-ascii?Q?duLjaOSVzjZWp7UgvaXpnCDnIcUzOblNeKzXOZuu2K5VPkoRh2wl7vh+scj7?=
 =?us-ascii?Q?7bS/MIF6mI3lKhycG61C7yPYLSBVVPguOgk3kZVhw4rFLZJlOaRDQn6etLA/?=
 =?us-ascii?Q?a3tPcJIvIjE9XbBnyFNI6LuXpNNTlXCGd1x/ddO1PIWTlNM5OFVXG+HPzX6r?=
 =?us-ascii?Q?GOZ1aCpOf+L0GTDwsPnqnObSBr+62PPlqKSf7JoqOWUizDK6DYJPcS658oy+?=
 =?us-ascii?Q?fkifmdbo6geywVhSLKeR1hbw/PlMx0dmEGfWGFFYdUkqSUY8tuvNOwV5S0pg?=
 =?us-ascii?Q?hx6H8U2LRttYGzxqqwSrP4IGXJSQiZukSpCXApz5JwmSAkRYaFyGYUfnZioj?=
 =?us-ascii?Q?chkIPZEVZjxPCqeM0SCqiQC7MQKTj9AJ5r/DaYgl0V08zYVa/221MdIzbWN8?=
 =?us-ascii?Q?54p0mv53Clch1f/32LlNONhbZeJsP3nF49zgft7zwm2tJLE5moavw4n+musg?=
 =?us-ascii?Q?dVHKSKdttbp1uj13kx4r6gti2Dg0ShT/NEBqcFJXsl8uG7pwnIdJ5qiAn1u/?=
 =?us-ascii?Q?kfvgv4GlZAsUZEo7C/XsIWPdQ83TwI7knLleC1uRdvZdhGb2xJscpCkkKxW+?=
 =?us-ascii?Q?njZQqGJwlf6PepDqJaiM5U5hSAbJCiHQCEnX1yxMYno3mAzYSdd6sRZta+jn?=
 =?us-ascii?Q?Vp01vMn2grTkNK39JuUf/1vi2yWipnS8+5Se6F6MV2u4wuCOzLZcuFo7Pacm?=
 =?us-ascii?Q?Cos+MAvgXzR3D+TrSLrnxkEzym1lyJdmveF2kXK1yneeyaHCyOvbwqO0BwoD?=
 =?us-ascii?Q?9zaejsXVw5WRjEousu3ouf53Z5bJ/jEcXTngmi76p1Zy9XDBhfncDP034FO1?=
 =?us-ascii?Q?7lw2z8Gl11qUYd29JJJr2YzTRG4V7u2ASoFcyqQpfi4yJi+m5eZ1Qu8rYJ4J?=
 =?us-ascii?Q?c5R9jckOeqFnziBgt0qvES9BHsEk7z+00MvAiqU3A3LPs8wxICXbYe9p7Gr9?=
 =?us-ascii?Q?XgISJTrP2UJf33un4LEHfBAmQe/Mxc4CNDqAydsA1KAMfPZkdBTijPYeOVNp?=
 =?us-ascii?Q?ZgIEAW+W+BQYmmJ6ceX5pCc/G5PKLnTT5iPWZOcQfmRr6y3wUCbxxv1dI9Ti?=
 =?us-ascii?Q?jVk0dIU/Dg+5JoW88Gi2Pg4KHoUaPm+mVLRLPH4jG1F57deN0ML39QGPu2H8?=
 =?us-ascii?Q?f7WeB0vYfGI2lMcQjpqwZax7oqktibeXpt0RUOYA95oilPuE1tvQf3cx/G86?=
 =?us-ascii?Q?2zXfNr39Bk/YIQMiZDvUnMEe3RA7F1jxuiqY6QqPxeHfrAuQVLdTNsZ4Oflg?=
 =?us-ascii?Q?KDdxhlB7GPsfVLGo03AmfbV2a/EilW+eUnczYDMxeG/mM3XgDBcPT0HREX/8?=
 =?us-ascii?Q?BYYZVUwO+mqcQa2vRJK4SFB3ulQaP6OBBy5i3zQq/Ng3rsQmlg1RdA2TYt4B?=
 =?us-ascii?Q?kfpz8rMAaAR+dWWueGjZRa/ooFO6o+wETVgES3+04xiMpOrmWtEOC3YnisrS?=
 =?us-ascii?Q?WlTqUyYZsW/dhA/bNSOGpRI0nomFYnosttmT3WlOpBDCtDaeiO6HK7y6G/Ff?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7ad734-e16f-4dee-9067-08dd361b0f39
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:46:40.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5vWKa1AW2L3Q6McIx5QgCia0eRmOrBBAEQhLidNsDc+FPx+nmEy+aOnvz0iYNA2/xJVE1PYpZUXaDBoALWJwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675

Picking up this set again after the end-of-year break.

Changes in v2: trivial rebase after the concurrent merge of the "net:
Make timestamping selectable" set.

Link to v1:
https://lore.kernel.org/netdev/20241213140852.1254063-1-vladimir.oltean@nxp.com/

Original cover letter:

After a recent patch set with fixes and general restructuring, Jakub asked for
the Felix DSA driver to start reporting standardized statistics for hardware
timestamping:
https://lore.kernel.org/netdev/20241207180640.12da60ed@kernel.org/

Testing follows the same procedure as in the aforementioned series, with PTP
packet loss induced through taprio:

$ ethtool -I --show-time-stamping swp3
Time stamping parameters for swp3:
Capabilities:
        hardware-transmit
        software-transmit
        hardware-receive
        software-receive
        software-system-clock
        hardware-raw-clock
PTP Hardware Clock: 1
Hardware Transmit Timestamp Modes:
        off
        on
        onestep-sync
Hardware Receive Filter Modes:
        none
        ptpv2-l4-event
        ptpv2-l2-event
        ptpv2-event
Statistics:
  tx_pkts: 14591
  tx_lost: 85
  tx_err: 0

Note that the kernel netlink attributes contain a newly added statistics
counter for unconfirmed one-step TX timestamps, which is not printed by
the ethtool user space program yet. I will post a patch once this set is
accepted.

Vladimir Oltean (4):
  net: ethtool: ts: add separate counter for unconfirmed one-step TX
    timestamps
  net: dsa: implement get_ts_stats ethtool operation for user ports
  net: mscc: ocelot: add TX timestamping statistics
  net: dsa: felix: report timestamping stats from the ocelot library

 Documentation/netlink/specs/ethtool.yaml      |  3 ++
 Documentation/networking/ethtool-netlink.rst  | 16 ++++--
 drivers/net/dsa/ocelot/felix.c                |  9 ++++
 drivers/net/ethernet/mscc/ocelot_net.c        | 11 ++++
 drivers/net/ethernet/mscc/ocelot_ptp.c        | 53 +++++++++++++++----
 drivers/net/ethernet/mscc/ocelot_stats.c      | 37 +++++++++++++
 include/linux/ethtool.h                       |  7 +++
 include/net/dsa.h                             |  2 +
 include/soc/mscc/ocelot.h                     | 11 ++++
 .../uapi/linux/ethtool_netlink_generated.h    |  1 +
 net/dsa/user.c                                | 11 ++++
 net/ethtool/tsinfo.c                          |  2 +
 12 files changed, 147 insertions(+), 16 deletions(-)

-- 
2.43.0


