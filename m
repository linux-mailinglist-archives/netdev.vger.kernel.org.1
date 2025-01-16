Return-Path: <netdev+bounces-158846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F127AA1383A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44393A4911
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90B1DE2BE;
	Thu, 16 Jan 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ls3RWKYT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B91DDA00
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024408; cv=fail; b=N4bcNBBcFVC6xtKqJjSL0jDEcRC7dtOtooTo4A4uh3SlPP3DqU2/S8GC6pbAX56IRvMeG46jbcI80mfk0sYsh7F2bSE0RH7CXnVIB42wqei4CZTaiJlzytrMQPNUUiSKZRdMlhJDBsS+B5zM6ktjHZiSyhLtCteCmuL3tBfynr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024408; c=relaxed/simple;
	bh=A0G1H39jf8gruX399WWti7z/lw8jpyOUSkfbHpOliSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ce9oAnvcE43q4kDiUUQtWK//zf15abBjkTj6NpGXwg9T00oNjGUZYX5bmWrFtAaykmMXOKD2TQsr/UNGFx2x0VHrEHkC9vIwABpq3mI+mfWXnUvgkAgTjKANVGvWtPwF+ZHhzNoD7Q94B421Sg6JeAugTys8rcx3+G3doP/8gLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ls3RWKYT; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObvzJj9tYn7lHZt4vyliSt2sm73ql4zkZR5VLpKZ7swHR9p8dUCVL6XbiDV7fglnLp2lTPt3zBaI0lPGZm9yJsU3Lp5jJsBaQASt0srWQzCrh1N/qfE3jVZq7eX91AkMDKvAGyka33vGKW9xtssf7aOoO2tMNGXkJhla0YBbn8UIoyGls5Aydvl3VQ3Kh0H6x6r/gagGV03+BTjYIg06N+5vJTKb54K96ApbmqNkui9A//yyLyF9x1c0nKPxS6Z0aMZI0WcIlxTg6K0Nf+/myuYRM5xRyQdB+5xWgnZM+1Gtpg2JCEanktk+/zrOcmkNjjPX9/nU0LAVr0Drmen15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iThzukZnWfxIQ5uMxxj4lb0iPwQP10emQKZh9pa+0x0=;
 b=j5U/ZBDzxN2Fw81ayxu4mfz9hoOaaEvxftLqw0X0qMSLFw6r2OWxPr5AO5Lhv9H7fmzMrYCR6T04gHirFkheIxftGz2G/Ya0EkzWGOikSo4bR8+wC3xMs806x0nz93A9I9EO7D5AaozD0Y+ZBjSktaXFPkpc/klQbZQgvquxiApoo5T/zQYNzZzmmsgVfmXcLg6TsV5lmt1KVTLbu4Nu3knVRnvg/FIRn5caOupReCxXHxU/ITjvOt09IqgZiweYA7eUAyXYIJuRO61hriNv5wdsdJcwsF+o7uh9QZp88USHLdGmmGNzdHhIiwFUvr9vxqvQc/rEPZKhb5ft+4VhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iThzukZnWfxIQ5uMxxj4lb0iPwQP10emQKZh9pa+0x0=;
 b=ls3RWKYTg+vXrg+Zr/+wjY44IXxU85JoTMkrX6u+xT/H7LaeTiMdXE0nrwtT7MITkBKGz1uR1bCT8VrXHNOrbQiQk1jj4Md+OtNuw/fiXf/Z4/9vfsrKTOqbBnOP9od0SGgllHHZDH21FdShKPSVnkHpAjWGGrW3pQ2k8t3WTZ3WiTt8lo03yVIZE2KY8E6NpAoLbqW5Hnh5MJ3eeYiz1sQrk/pCsCSqHCzPLLMMPgy3SMYg6iOZFyPyG8Prwd0mT9FpjuVei6A4RgkJAOXcNGAE31Up/OFfpVgvgZkD51wNO/i6qquMjkWiMzSBCNJL4zs57J+PSKP46tC2CiyIlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 10:46:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:46:42 +0000
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
Subject: [PATCH v2 net-next 1/4] net: ethtool: ts: add separate counter for unconfirmed one-step TX timestamps
Date: Thu, 16 Jan 2025 12:46:25 +0200
Message-ID: <20250116104628.123555-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116104628.123555-1-vladimir.oltean@nxp.com>
References: <20250116104628.123555-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ded4eab-cfd6-4177-c729-08dd361b0ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N4Iuf3SZTDwwkPe53Tvyj0u18xXBelLwX3ZBjDX9xxawjdBMv8H+jVcV0iOQ?=
 =?us-ascii?Q?ZDYLHrakL6i+yvhKemh2OlV/jK5Kk+v51RzgUDMZ6zicWZEFH9QySHmT/wTo?=
 =?us-ascii?Q?H6MisXR2DlO8duQaqKCIMM2mBkndYNzDDwKpRcUpIlW6zXQ1HCl3hgOgEE/i?=
 =?us-ascii?Q?EYQg36eIwQ8xvfvo1zgW3Og9RjZ2JgzGt2Hb8lGE+k4TnNc1ZixJ+XEzkntQ?=
 =?us-ascii?Q?+EqbJusmF0QSFT+nIn/UD+Bp6dNJBSHkRnMDKcC/zyXDG8/Y5zic6E+yg6Hr?=
 =?us-ascii?Q?ozidMMWoB78YfqTwfHOpHWAM6dZmkcvOXw+kN2HXV44W2oahujmnhKywmIRN?=
 =?us-ascii?Q?QvXvXCMVEuU7gxDlS+AlzFXlRocjwBTMTx+g4kTUyTNxWw6sB915fdzdkCL0?=
 =?us-ascii?Q?mfcqk4iKdGhYZWAOL9hPtZ4trKhnpfSslEUUFMC7+yrXlU+5WquXLRFKMNm7?=
 =?us-ascii?Q?O6h2vJnTAE0R34U6d6QC7YXEldpQOmsSq5QaoXBJFgdHAmDNjuA6roSjZmn0?=
 =?us-ascii?Q?sXQo7ajp5N7yo0/XHQ/mvc9aOvXUMyCzlE2c5nkQadwU9kp1ATpRz29jyTZ9?=
 =?us-ascii?Q?jY6nIOZvxyRybCvkbsaAWxrHEIFqtq1G8xmWoDwCQgMgfvoubI99E388VPAr?=
 =?us-ascii?Q?VzB1QZIvgZORfwE9EXoSnHyasKEDbZcgLMjcUWFKvaT3hqiHSKoXy/B1krDs?=
 =?us-ascii?Q?unBlruJrsZzhs+t6kH7rwoEW5s6qbCvRUpSk90b2RdiuEuBzN371GFo9Z0wm?=
 =?us-ascii?Q?Zy8YG/GQKeuA5KkIfgXPiuIGWSvUxsLajX8uane7PE3QPFj0lkdxr31vd/Wj?=
 =?us-ascii?Q?h1PVcNiRp6BMPmVnLitV4hpQEWAzzS/1sGTdqtjSf49XFSC32cbiVinnDtbg?=
 =?us-ascii?Q?1fGP0YHenccXitm6ZB2W16IYiz1sYPAU91M6h+Gnp1eaduOaZdvdL+QyPifc?=
 =?us-ascii?Q?8kHGkuAYAdA8G1Pu/QuY8Ywv+pcsOmSPw0NLu84gW3pEFTa5EVrsN81aObLB?=
 =?us-ascii?Q?tMKXcnrlu8iJkc5pYKGXqY7JkegOHLcsIpZ3IfJQ5i5pvzOcPAS9rZiRVd+y?=
 =?us-ascii?Q?aHLZgL17ifGTELqkM5lI3O+/LUlfpCLbCux0tLCl85U+ecvOr/141EhkXOmI?=
 =?us-ascii?Q?Q6BwMrN04XmNo/uaHyUrSp57sdsWp+CIbuAINy5q+sxCjbVz/BhGXZDvJIaf?=
 =?us-ascii?Q?dTOd1oT+Qbgyoi7EM9UvyGtMmnqX2u7IGY6CMKH5T26+9aDOEmDwJVqc7VPi?=
 =?us-ascii?Q?uBwjPUFNqdGTpOmMUkiSvKxXFWrTNccN8/KlIOaN4h3AKKK0wJrjfKv7hDdh?=
 =?us-ascii?Q?sKapszstbNe8lHQAsXKxaZIduBHxZHGn0cR+jIw7J5DVJlIAybygqTppK8La?=
 =?us-ascii?Q?2Jz3S4isSz9QIL50ezDA43udA82ZWljL/8gxdwr/Jo9YGJMD9JIhUX+0q0Md?=
 =?us-ascii?Q?WD1cmoxzbcMcXd05mnhEjbg0YXQdNl+i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1zoGR+qSQn1uKLDIUQjDD4fKYbZO1Lf1DjebVQXE3fQjG0EZyIN2kHyqoeu?=
 =?us-ascii?Q?2NYslaS3s0JiyEkMwK/lUa7Lllp8K/qn7zU1n7EGJJaVyxVOQN9jMRA/ji0Z?=
 =?us-ascii?Q?dOwE2MLcaL5bYavM09i2pT5cDDse95ucGWi7g8UU/Pb0Hu84BWymPNK1JpO/?=
 =?us-ascii?Q?87jt3HCg55LTZligNHTgwbXpMpe+Lsgd3sEX0/oKLn72arvGwf51a5C8UAim?=
 =?us-ascii?Q?WuToniysKfMkK8lxjrIglQt/YmfSXZyx6j69dPJIhJW4QBTUHmdHnm8+NV6F?=
 =?us-ascii?Q?X3KYOKffZAlgLaQfVidu6zDPfyppYRE3unV828nAoG1bMQKVBQpZvB//LBnY?=
 =?us-ascii?Q?/CWXz7soypzwN02gOulI+mBTzBtL5S2PJCDEaAOvmUFEQjmAdAy3nrUNtZiy?=
 =?us-ascii?Q?rjTgWYI0E2sSvhbgwaHOiePZmTNZ3G/ZlnzAAtQprsoYMRY8oeN7tT9UvS/0?=
 =?us-ascii?Q?G+5xH+4WkTe0On99v3oHw/+ksywV+84Hpol7kvmT8qKGcW2ufrZ3Cl0Ce/4c?=
 =?us-ascii?Q?RR1kAWxdWc4SSvq8PBQ/oTkWI9OPHcpPYUCCk7a0CFGHe5+d8RjqRyofEond?=
 =?us-ascii?Q?RURxW6ZXh94odj7MVDBAWKnukyhTTEQQuRZumxCMLjrVM3W6xd6D8ea8nf3s?=
 =?us-ascii?Q?Vek/jMniH6JbmFAwKrGJuERg3wspUP6ZsySef2k3S8TwOdfsbEOv7nuAtg6O?=
 =?us-ascii?Q?U2CKqzoSBwrgQAWqxqzKv96csBOpoFeSnnIIo+CUdvzZqWSk2pgNb5VETqCa?=
 =?us-ascii?Q?GDNkeyerf74LNhHGjEy4ZeEwi+l3M8TkZAdZJg3+L3WNdscLHxTQkFsD4jvv?=
 =?us-ascii?Q?FVW0HIbIMXtyqFGuBbRkuJkrizZkM93poEYUeZ3x/1VxP0pv0OVTVzt7/YIv?=
 =?us-ascii?Q?rXaz8HOLlK+P25BaXyzJXV580bCMdJxXab+TzcZCJipY6bg1mtyJx6akcz/0?=
 =?us-ascii?Q?h472TtzsZJjRem4LzaDsjjLG8KMjxc2T2JqU7vx84I6H3evclJiZ92+pde5V?=
 =?us-ascii?Q?o1oFiVOJIZAdkISBdVQ9yU107Yh7zmJmETVOBZIvymAT6VzMIbUXYyKT2z4K?=
 =?us-ascii?Q?mOHQJW16EzYa0wJ7itteo4oo/tyXWXSkfGSrIgZstXU5LsKJnzcWew/lMNHi?=
 =?us-ascii?Q?EWWWRdBBSfSFP/G9tVKjRp0Fvoqm3hk1i0nKeD1/GDD+q6O2nj7Wo9ZHhoXt?=
 =?us-ascii?Q?Ejzmvfzg04qxsgaWNOH6fKyADjNSu5s2/AHYoXs6odeWw6zW1Dkcwvi1x5Z9?=
 =?us-ascii?Q?J7ymESD75SBBKGgK0G2zkzSVO8nazOINZUAfX+5pLMv8lHZM844Hz+ACrZo9?=
 =?us-ascii?Q?HaP/Q9lprm+PPNU3M3ZOyi5R/8tTxIuVR2oBUVOxvbE7FW0HxELRwU0XpA4p?=
 =?us-ascii?Q?/Fn5WDDTZbjAV0JEaHdp1JKUDKGTJGPQPz0G6ihq2rsJuhB7m0KomdLlLVZV?=
 =?us-ascii?Q?v/PPMkWtKBqUqlWO5TXtagaxuxoOBNw7sQcTK0I24FZuG9wfhxDMA8KfSd6b?=
 =?us-ascii?Q?Y9a+1BlG6ascv+Xk4hnQ0RILD7yaYuOXEgqUIieZCqXos0Lhp89jaHqHQ8NM?=
 =?us-ascii?Q?gC4FiHIeMt6jJ77fDOYuiSfCXUO9thkgQ7mnolDNrktc4i2EF4Q1BFFWG8Sq?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ded4eab-cfd6-4177-c729-08dd361b0ff4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:46:42.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk+xYzbEoZpqG+GmdxdRaQlzYdrGRJU7m2NcRdUEJzrmpZPL9zdlSoibEZ3wMfRVMMv4aUJWzL8Mk9MUZXKDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675

For packets with two-step timestamp requests, the hardware timestamp
comes back to the driver through a confirmation mechanism of sorts,
which allows the driver to confidently bump the successful "pkts"
counter.

For one-step PTP, the NIC is supposed to autonomously insert its
hardware TX timestamp in the packet headers while simultaneously
transmitting it. There may be a confirmation that this was done
successfully, or there may not.

None of the current drivers which implement ethtool_ops :: get_ts_stats()
also support HWTSTAMP_TX_ONESTEP_SYNC or HWTSTAMP_TX_ONESTEP_SYNC, so it
is a bit unclear which model to follow. But there are NICs, such as DSA,
where there is no transmit confirmation at all. Here, it would be wrong /
misleading to increment the successful "pkts" counter, because one-step
PTP packets can be dropped on TX just like any other packets.

So introduce a special counter which signifies "yes, an attempt was made,
but we don't know whether it also exited the port or not". I expect that
for one-step PTP packets where a confirmation is available, the "pkts"
counter would be bumped.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v1->v2: rebase

 Documentation/netlink/specs/ethtool.yaml       |  3 +++
 Documentation/networking/ethtool-netlink.rst   | 16 +++++++++++-----
 include/linux/ethtool.h                        |  7 +++++++
 include/uapi/linux/ethtool_netlink_generated.h |  1 +
 net/ethtool/tsinfo.c                           |  2 ++
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 66be04013048..259cb211a338 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -842,6 +842,9 @@ attribute-sets:
       -
         name: tx-err
         type: uint
+      -
+        name: tx-onestep-pkts-unconfirmed
+        type: uint
   -
     name: ts-hwtstamp-provider
     attr-cnt-name: __ethtool-a-ts-hwtstamp-provider-cnt
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index f70c0249860c..3770a2294509 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1281,11 +1281,17 @@ would be empty (no bit set).
 
 Additional hardware timestamping statistics response contents:
 
-  =====================================  ======  ===================================
-  ``ETHTOOL_A_TS_STAT_TX_PKTS``          uint    Packets with Tx HW timestamps
-  ``ETHTOOL_A_TS_STAT_TX_LOST``          uint    Tx HW timestamp not arrived count
-  ``ETHTOOL_A_TS_STAT_TX_ERR``           uint    HW error request Tx timestamp count
-  =====================================  ======  ===================================
+  ==================================================  ======  =====================
+  ``ETHTOOL_A_TS_STAT_TX_PKTS``                       uint    Packets with Tx
+                                                              HW timestamps
+  ``ETHTOOL_A_TS_STAT_TX_LOST``                       uint    Tx HW timestamp
+                                                              not arrived count
+  ``ETHTOOL_A_TS_STAT_TX_ERR``                        uint    HW error request
+                                                              Tx timestamp count
+  ``ETHTOOL_A_TS_STAT_TX_ONESTEP_PKTS_UNCONFIRMED``   uint    Packets with one-step
+                                                              HW TX timestamps with
+                                                              unconfirmed delivery
+  ==================================================  ======  =====================
 
 CABLE_TEST
 ==========
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index e4136b0df892..64301ddf2f59 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -559,6 +559,12 @@ struct ethtool_rmon_stats {
 /**
  * struct ethtool_ts_stats - HW timestamping statistics
  * @pkts: Number of packets successfully timestamped by the hardware.
+ * @onestep_pkts_unconfirmed: Number of PTP packets with one-step TX
+ *			      timestamping that were sent, but for which the
+ *			      device offers no confirmation whether they made
+ *			      it onto the wire and the timestamp was inserted
+ *			      in the originTimestamp or correctionField, or
+ *			      not.
  * @lost: Number of hardware timestamping requests where the timestamping
  *	information from the hardware never arrived for submission with
  *	the skb.
@@ -571,6 +577,7 @@ struct ethtool_rmon_stats {
 struct ethtool_ts_stats {
 	struct_group(tx_stats,
 		u64 pkts;
+		u64 onestep_pkts_unconfirmed;
 		u64 lost;
 		u64 err;
 	);
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 2e17ff348f89..fe24c3459ac0 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -382,6 +382,7 @@ enum {
 	ETHTOOL_A_TS_STAT_TX_PKTS,
 	ETHTOOL_A_TS_STAT_TX_LOST,
 	ETHTOOL_A_TS_STAT_TX_ERR,
+	ETHTOOL_A_TS_STAT_TX_ONESTEP_PKTS_UNCONFIRMED,
 
 	__ETHTOOL_A_TS_STAT_CNT,
 	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 7e495a41aeec..691be6c445b3 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -186,6 +186,8 @@ static int tsinfo_put_stats(struct sk_buff *skb,
 
 	if (tsinfo_put_stat(skb, stats->tx_stats.pkts,
 			    ETHTOOL_A_TS_STAT_TX_PKTS) ||
+	    tsinfo_put_stat(skb, stats->tx_stats.onestep_pkts_unconfirmed,
+			    ETHTOOL_A_TS_STAT_TX_ONESTEP_PKTS_UNCONFIRMED) ||
 	    tsinfo_put_stat(skb, stats->tx_stats.lost,
 			    ETHTOOL_A_TS_STAT_TX_LOST) ||
 	    tsinfo_put_stat(skb, stats->tx_stats.err,
-- 
2.43.0


