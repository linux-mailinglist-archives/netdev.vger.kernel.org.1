Return-Path: <netdev+bounces-151793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCC9F0EBB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B007162C39
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BAB1E22FC;
	Fri, 13 Dec 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M0HAzbmZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9771E22EB
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098959; cv=fail; b=fxkL5HrSTmnk7e8m9HmXsCZZqcP9SmYYYtIHZJkew7C4/PyBIUThsPiirL5NAbIK9X+eMLqqhucUMl9uM1J0b+rYK/zEZVNIjGuJrbU1yctjwBQN4qXK5y927mFMiZFCG4bPEZtPOnvhxakvn73vgncY3bRaqYb/akUqypMY8bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098959; c=relaxed/simple;
	bh=hxDFLP9VpFumfGB7mZXvMs7uI7Yy2Wu8n6SKzNJA5Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hfsk5RoEuUf8NcmC9148WmVS5TN7pJsY1XyDMUFL0CFQhfgYPIc5pzrf3ETJHJkbZaHgwIYTz2jJjkCmG6cmIjnqL4JiFxhP8m2JBDPyl8S2ZCv5kEpUSpUYDaGkfX8F+yKjh+NtWkEUnztu5ayXtsBWNLUZxSeJTOKrGm79aPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M0HAzbmZ; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwY7QxaO8LstMDKLEIjXcGPhgZFKvB0ISzZvwecJ5191NAuq9cTRWya0ESdHdoBOVrhjGj4t1Kgj6Nelt5EX9m3kTqAd3CCP/kl0yg9BrJ0tGmX9vIWPzXesD1qx16Dxaj094nn+BEyXQGnf0uXu65Ak6NOcsxFpQ/eD/pq7HK+2V5B6CqXHxQIVpUmvxCSwuxVwZrsda4HQ61x0sHHObBLEvBGFAdA1vRVrUe3A0/yq1ruM2Tp0o3l+6LuRSCMy5Ij4fKvyOeKHevUn66Znjxur++NkjfynzKQInPP3/01m1qUBn+B3jW5aFkmdlAAozOuvYsMHjvq/+0a09do+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/Wa/D8MQ9icVhzungj1dTd45AQR8DWStlL+K15Ejf4=;
 b=YxRMerqN+eVDNbrl90RHzqXVGtYRB9w3mkgFVqvdP5lL7+v+OB4WETwv0i4pI/75FhCHfoBzeGPXiHwpnayA20UnEcshhIhLU/wbwoQKUKAowsrFNFlh6jALDFw8rWxmrCZXa+dmf0XAye4jbzXS9DXkIC2RxC4ioyn7Y5Q8WJET4tJhVk5qLk8Py8q4tK2Mu20MJK47bQaU+eWZxFnjSmqqnFiejS5GsPLSAK4qRdX3kRAw98L6X+SsHgAE8vBT4omAvPHzpl2h/UfNzgFc5sv+VJipYXsl94efZ8sqzJgZQXtaqHvaqJohq4qo+xup7IoZgJmx29x1cvHky7RbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Wa/D8MQ9icVhzungj1dTd45AQR8DWStlL+K15Ejf4=;
 b=M0HAzbmZGo49v1uBA0Ljyq42R9dDhx1hcJgCVfM1ZRzPYWAu1SXZxWySoy6Kup4GWCzjm3CpOj+ffJVcrEJBQ3lYXMaIaISUJrNffmp8+eP8kbOYVpI5vZOnF8zPU39Hfh+60vq0UpylPM0/zUzNplJDGVx3qR3vzW1IHITzvSBAOCfX6kckPGI+BjCQ+hgb4CN/UOkW3JxY+Kl+47T46O1nUwHNf68ZJ0bW+eQRVSRCun64AhZvI6DWCfjL5/U0YILz1w7v9ydo8RcHu15JGK5J79YjjdejKqCkwzdHJ8VrxNfvSYcHRuGiLBnH2DJBO4+SzTjzf0jAlU2lyL+zbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:09:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:09:13 +0000
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
Subject: [PATCH net-next 0/4] ethtool get_ts_stats() for DSA and ocelot driver
Date: Fri, 13 Dec 2024 16:08:48 +0200
Message-ID: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8193a7ba-5055-4cbe-2593-08dd1b7fb8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GSk8PgeZewZmQ9EW8dbc+/NSdzLFcnU2Ha3+ZRalxQXBb72NYy8Jak0YO9DX?=
 =?us-ascii?Q?tKd0pMwBvhBbC6mXUUSiriVBWr6LfDyX9vYjX3f4vw+Cfg8PhJHyDAozvP6a?=
 =?us-ascii?Q?Ef6YhdEyRLMOkYr2tFi0p3DSIA+u5z7hGjKnhdMwPIeuild+QrSa2qbxiaYt?=
 =?us-ascii?Q?roGFw6RCuZAx30BqYSxLUeF7hqpm6Uo4ueeeAWOGYp3FV3iBPf3ae89MHWQ8?=
 =?us-ascii?Q?uiu9JpjPrBtr84UAvzHSnDR4GsQ2QeaWatg1V788PGoOjoEiXtTdQ9VHFQox?=
 =?us-ascii?Q?CrXycrTHMlDOM7+uQJNVnigV7fn92cxCOchA7FYv4at7HAoWgGeRpY+RY5sC?=
 =?us-ascii?Q?wOFk6jFmkbRoLag6/iXfPoJclh22R4i7Y4ifd1eTkM6m3p2QB2D5h0WVj8YT?=
 =?us-ascii?Q?sQeTKCeWpwdidhjuS4BuYW+2r1nip1MCruRv20wLUF5KOw9RFr4Mbbdbaer8?=
 =?us-ascii?Q?H60kApoT1DDidc7RXLjmt2Q3jbhtbL6fcNW7pdZaUA7Arpb4IKEgfnd+R524?=
 =?us-ascii?Q?RwckUxW53BECWYdz048GEIKWjKfmsEHmfnlhfDM0Tpcxe31tbhLBQEYJSJ3M?=
 =?us-ascii?Q?unGkTYJjUALezWXdW82mARkI5vrIYU2a2VcVJ4h6pvJRflwzKjLCKGpdOmiS?=
 =?us-ascii?Q?n/8TeZd02iedBpC2tXfZNxYaYkHiM9LvT/xUjpq08FJPoL4bPequO6N0gjD2?=
 =?us-ascii?Q?1FiNb392tVpAV0TRtSAKksVvBkOAOfeCbPu1+tdg7nnuzop//EGrWfFHlDVG?=
 =?us-ascii?Q?fc3zRN/BzgY0SxD6bcMPI/sP1tHO7H1Wv7Rbjlk4OSJJJSA8v11J/UqevYlR?=
 =?us-ascii?Q?9itDjapB3GDwUtKNoO3SSzm9QpJMfvPs+fzuMVZaHVrlZWK8drrlKaGtZxbc?=
 =?us-ascii?Q?jZyhgOR+2hXCsi9NljdivhCO2y9oI3xS1wF2/ZI4zyJJ4/1WnFDoRUseCi54?=
 =?us-ascii?Q?o+kJT66FkqPvMokjbLMo0yQ88DXFBYYSubuc4A5SLnHeJfBqh3FwtEo2qiQv?=
 =?us-ascii?Q?02cPH2k1MiOix597Ev7/yZ60hY/vuf1nWzA78oe8BBPzUnvbT+5CpC1adO24?=
 =?us-ascii?Q?1/GWHvBH5PAZA5Oc5T2ZR4FH1s3cFTeJCQK3FaBjqFFN573xNx8e1esLcdlq?=
 =?us-ascii?Q?A4MjrcyEyUmnWNB5y/Qu51YYXalCwqbNIKgvzRpNhddyNH67mCGYUYHJ91P9?=
 =?us-ascii?Q?fpcixydAvAfhtOi71PrHtdIHQgiHig/J1lKKQHGsbO4pr0bkDuXi1rgoX1v/?=
 =?us-ascii?Q?8fLpSDYHdra6bNa/+YufwBgvOaV9smJTHQksdQ8eiJCDK9CU0tXFUFal3POR?=
 =?us-ascii?Q?aq04rFwhXda6kCPOviQ+CA/JVHhgHzGUv9bw8Q0wtSv8hmV+RpfQRC26A6Jn?=
 =?us-ascii?Q?rne+wtnF0fuaLzUalxEMN1FZ38gPDlrGbsIKCwuv/gLx07wRMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GVPsgzytHDgdCx7hsVSHK4+wBagHCHH3QjgxbR+ZGmBcasrae9I1Y71FzD/p?=
 =?us-ascii?Q?tAZ4HIHVzFhs8BjJuzb1ODmyhopBHaBYREHHWR+kzRvmAfmwAlh7Zg1nS6eu?=
 =?us-ascii?Q?MjHvEeqWt/f7w9u//lG6nkshmBPQbwBE6QKn0nHvPZNlVYbBUIGAQJPCaLUI?=
 =?us-ascii?Q?9PrvtEWR78uKzIQcZSEafJxTZCqidKpnkbzTUgMxz/BoXo8KYcDnZ+bIZNym?=
 =?us-ascii?Q?2bft8yWcRB+oT3Bw5WRzZD83uZRnpo00ya3Zag/hIkNBso1NGV+hvIC2tg3u?=
 =?us-ascii?Q?xKwi+Fz9tMOAgpHXGU7Y92+XKh5qBmGa1qUBJ30ms3Qf3YoWsbPYWGof6mZr?=
 =?us-ascii?Q?mFiyoMCIN2UO+NbdrwXypsI4de7vi+xw9KXbBU6KIozxeP418ALZ6Wq09rZM?=
 =?us-ascii?Q?B+dqgfmNl3tDphvbBbxJoXLn1NOni77Gi/GzbOL9F0ZDe1F3iZNf7N6hlNuP?=
 =?us-ascii?Q?+nGAvp2jNQk6Q4DbNeFV0YHWd4+qBaOvL8xJS09j2cEMOteJUV8bkIq5LzpM?=
 =?us-ascii?Q?ue6sXAuzqVbm8m4zsuExkCV0w5Eh6LU061XZL+Y8e/4e/oKfQO/rrEccCPY6?=
 =?us-ascii?Q?tHBv4jNxREz0DKKEIEcg3c/EYn9nhX4HOocgdK2RLhV6iiEiuBzVgvDIYSfr?=
 =?us-ascii?Q?iL9DhnkIDHHqPmfcnazK1eSp7aUWiQvd/HOBzB5kleeGAbIYf2oxyl6Rprc0?=
 =?us-ascii?Q?+J/11C7B8CDGkOMF0J2IqhSZ12a9zd+KEmNxyJ6GVnf9KvEAVd87d34CQ1of?=
 =?us-ascii?Q?m+jb/BeUsH85NCDK9Sv91UZlpsDV+g4dtMj9MwHDfELHjePs1MQfOXi1ci/j?=
 =?us-ascii?Q?eGLOhYDEOnHKGlhITrTjYPkuEVzEFsVKmWV5m7OiKirQtM/AGsNDQsDG+UsL?=
 =?us-ascii?Q?axoqQBUTs6T93B0AJrp+7jPYVfFo+JZPqVJZiS//xzdHNxInvdFFoxz8rbfU?=
 =?us-ascii?Q?OvRT/uDYaSFfn3XALVcNMKbr3/01d8dgRz3BhuY7DmX0BWRxg89bSW015jFp?=
 =?us-ascii?Q?qhzraoyko2WpfGMD9hPvB27zm0hjfPLpp+t4CmsnVRCYeh7+6i4jh+PjUEeB?=
 =?us-ascii?Q?aWbi8HpxntbMbENgnN9dQWLIqwiNOYqUSQ0eHoD4ycP5WBTZlLvFEXExEC6K?=
 =?us-ascii?Q?qLWIwjV6WKZWiU7+mqhSiU2hwx7HhIYeEGkD3ohxotOcePzqZIZJrzNhyDyK?=
 =?us-ascii?Q?5DGZt6LYQqs0fwXtMaImwR9KW8k1dUxs1ntzcMrINZlM6VEpXsoLS/Ws7z7T?=
 =?us-ascii?Q?3o2mZi4aNNvOi367bKwY6CyMGoRm6spetIh1lC2a0BvFyAIP2n3cSs5WWaCW?=
 =?us-ascii?Q?p1XS4vfddIiXdNd4+dHvxbVpE9I+Ywu5C0jaDGUTcGKeBvZHW/ih3ykVXsHa?=
 =?us-ascii?Q?mFpkW+J+IgoYjzPCvoTTWiQon7DEEtnMcPY7vKZ1lHO7lE7ELoZ1PLTu25dL?=
 =?us-ascii?Q?kxonovD04TU8kPH8X5thayyRHD5pCWSg9q6xhE0ZW5leStPxQ2g2HkqkEiRS?=
 =?us-ascii?Q?jOXsmwiK4yoxZ/dbikb/owugCE/EwFOkdIJHnI8Vo0UJ5jBCvZWC/ac6t2OL?=
 =?us-ascii?Q?TgGqFm1ZPLnFkcym4i/v6Gt2fy6+BXYTrkncOIe1+h2HPQrVshm/aqB+mZ7z?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8193a7ba-5055-4cbe-2593-08dd1b7fb8c3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:09:13.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pB+eD3XZ76A4vdTGFxZuwEQujena9AKBlDFBtqg9vg0vkEyIe7s8jeaQALv+vAlW3Kq92wI9pKA2ijbUXBk2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780

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


