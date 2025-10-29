Return-Path: <netdev+bounces-233760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC2C17FA9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D41C353C22
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCDD2ED87F;
	Wed, 29 Oct 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nQp0zm2j"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9442E9EDA;
	Wed, 29 Oct 2025 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703294; cv=fail; b=TxTrBpM842GWOkje4LfDPtsvc/E7RterYLuUNW7TqkcXvBZCbtjtdduKzQUwAMb+lKTCPW4+OmcjD5feHjfgxQ/hNdYhp8/zyfa3IsiPIrDIH5VD8GAf6AYOfR5IsLVzcuNpt+1OZ7/1vCV35LqnymlkOqUVzS25QIWU0esGrR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703294; c=relaxed/simple;
	bh=E2k0OMaper+UeMULFyyKgLtwU0h+M7XjNj2KH4h6zZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0SEtd8QFE53TKyCaUy54Z7yMEd3mZD8MobNXZdjhbsxwpUuU3vsI5h8eGKDJYJgCoKUj3quOTcqYX67W31/e3jen7DOqAI6v8twf3QCytwxO62o66F4IAkIx3g/AQYKOw9ve+2+N94hgeXW+fRLpF9UBGyKLhn1SlZQo/5aC4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nQp0zm2j; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbyXgvBCJRwc1PI4eXNi3OqQPE5WFE9KeGue9ucgLfc/7TE393LfP5KyXtiF6qH8U3y0kQC42XVW6v126NmkGiqw5SduDSDf1J3besyLt6xjSVl6u0Xi3fU3gIpQh9OpZGlPGtYQawlJXB1EwKebE7i8NdsRVDeoILWLAEeYoNECTRosGPoZXlh6Ou8cswutSb1+fvHl2wUFNenE1+i1OpkQ0DkWmaLvdtD5fRaoixP/i8Mi91LifmDAtAixJdxxnmyNA6sXIIzC8MoeegDxaHmArTpLpIqyCoRvNCttIUDy3Hx/8QHA1qNgqWNt/WHhlz6TYb1EO5yZwhc0vDzx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXvauh2WhbxJPOpPOFFqnZVaE4JUAIVt3e3V4mUdFxY=;
 b=OTtMMXLjFCauxf0RiR2ZAMUV3Bkvlz1UVccS8gHspiIxGccW3wDsW6MUj/ahZJOuglCrGr7tQ3mlVpOV2MMpzcvJ19qLxHvDnS6I172pUeCQpAgkR1ok0uDc5mez+6HOLD58jSaAJOn1qRbeaj2xkz3pHRReROPdMaMt/FrnovoEY0/GCB1VqMTmPoATq7VSRYaUXc9E3AwMhIEncMZHMdG4jQ9978QjS9tOl6VxIgkPdYuYu6JqUdCWZftoPS9lMt+Z3U3N+5m7CGwm/QhkjV6ZqNT3AbkV+DPdiGf14TtbhFaW0wyQhUz6w3+xNzHX6XyAxroLXgxDF5JvFqBacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXvauh2WhbxJPOpPOFFqnZVaE4JUAIVt3e3V4mUdFxY=;
 b=nQp0zm2jgcxYysU2JNG9sdh6CwYBKI/8oqtpz/jqqF7EWhmaUg4rKhTz9audFTDLzEeLS3JuYjr2vJEgb+9J/NSz754YA6RXh5Ibus9Cet6Y2u4UnuMn3Q/hCfcXol79W8pdKddQdz0E6xc6WTQ3C/WAJ68NrDBQYfkBzZuRr5KF1Gl6kj8r8Kpii/o1ZLtZDLUZTJLrxrz9lDFxX4dZrctcoozixLlXahjr0Qfzko6tHhfAkoiUNfH+Tjrhkv9hs7IN/f9GPuNSFJoqwNQ/fxNevBqd8pCG7yZ6+N9baYRengxhvCjxtPhcyuzY3k49vhHU3XUF4jPjyH/qI7v0rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 02:01:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:01:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 net-next 5/6] net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
Date: Wed, 29 Oct 2025 09:38:59 +0800
Message-Id: <20251029013900.407583-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029013900.407583-1-wei.fang@nxp.com>
References: <20251029013900.407583-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a65df8-5095-43e1-3f4d-08de168f135a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEo61O6Jz2mGuNcRbRUKQ7binJMl4ENhh9xYdFrTs9cRlh76ODUIjT7tJvpb?=
 =?us-ascii?Q?A2WQ4IVy4ZBujq/fH2jTJlfdqothqsVdYTqZ9XqL9uE9UNNDa1iy+1Xh/Dm1?=
 =?us-ascii?Q?mAlBdoSztujWyqnFRFQeTL92AJ0+6PJtOFIf7kPG+5Gpcxz1qsA+1IikpRGY?=
 =?us-ascii?Q?hh1dhUN8dql6SJ4bsYFTXeg0M9CACJXkHkRR5C1c3SqGXpRzc+MKUyw6fcJq?=
 =?us-ascii?Q?QFDWXv2cLrpN1W6pjTrYxkioQWtnwQBJWdhUc3MeYDMicBJH1PZcIVWse2La?=
 =?us-ascii?Q?I/PcESCDClt+To68fzABY7Wn2pzXaoBvmez3nunfU2uUsyuKL/Y+OMydoWvV?=
 =?us-ascii?Q?ULW8cOsjQs41JVIdxOuCWm5e7Gb86KB1zFHlQDoKEZefOieic3YlH2h3VITJ?=
 =?us-ascii?Q?VG4DOsllxECC47tuTLYxeLrWAi8Jsj4fyH16Dd0RB0AK4HvavvbAfcIHM9NQ?=
 =?us-ascii?Q?6IAa+ehIzCIbFpZYwmWpVfqEDUH1fZmF9f00JSRpUmTAHfSLAju8PEzJ1LPz?=
 =?us-ascii?Q?p3PkTV4fU1lUGL3zsUe69tdu2qcOkXJZyt3z5iXW9GHsTu377/mmQKOZ2LdB?=
 =?us-ascii?Q?Qxpc+vrz0pm7yWZ9JsW4fUk+IQQMJjj+G7o+L7aFnkf9nB1Fn8YyY+1n2Xlg?=
 =?us-ascii?Q?06s8kdLkteRbo0/qCFXQie3kBCbPAzRskNkxvim+jNBq4PEhc4Hfg6vDVWlB?=
 =?us-ascii?Q?t2VyHbu1eVEHN1MPGfouFZbr235p/6og5v6uBuIExAXGe1QDPVcBGxY+q9cb?=
 =?us-ascii?Q?AhOs2uQqVCxnN3qgFSsk1C7pFgmSIQ4Wz5nHP7z5uhVqHNGoqzvD8nSKXBqD?=
 =?us-ascii?Q?WQFN/Zb/0BlwqnBHPQZq90Y+h6aCMHagQ6jdmwRTbEo/zHVfQPe+u/kX6Qx0?=
 =?us-ascii?Q?hDD2OcXuLXMNhMpVgvL5D4YEruDQrPE2n8TSYAarAQYrCHzLQVOSSLxrOAqH?=
 =?us-ascii?Q?RY9srzpnsR8R+UfkSX8nQV6KRQmln2fSOPbN3x3fmL+vlc9PNBVEuetJLDhi?=
 =?us-ascii?Q?6zWWSnWI/7sVFVQjr7H9g7HZNO62uqVsidSAvZEzr5mnZfBiTeYznpG/WAIc?=
 =?us-ascii?Q?uAAhFRbHPzPR3hfEEudO9KndcGdUsCRUy1uM/MSR8s0o7WHG4dEdMEPcTkmf?=
 =?us-ascii?Q?pw8Gfx960xxM21hewsO8VHfeF4aNAT5vl3sWp0+JNT7MvpQvrlIBLdanXBUh?=
 =?us-ascii?Q?6AKkuRWd3lOtngyqobObpYKecP0NOIXa4XsIcHfzqzJldjezG6NgyWuSJK6C?=
 =?us-ascii?Q?kaHgh+bkA93USUxbSc0pD+OWrmBDS7x/Q9A88T9VrN9DzdzmZJA1smgvAwn7?=
 =?us-ascii?Q?IRypeK6DLmJdvBHxbNCyymSpVqqEILT4wG19qgubqVc6Kue6VfI3dSjXQirm?=
 =?us-ascii?Q?OPsJFZX1+XIUEXCw0GsnNNEsFd8hzNDryWOc/L+c2RPC9XVgmp8jNpxn39Tp?=
 =?us-ascii?Q?+Ich/bmKihycHIVZChv9QgcnaRgVuNl6HPMRK1s6MQWcpoqwW0jlbUkHz36/?=
 =?us-ascii?Q?+TGooDAsiuUSlKPa1lAxYDhM3HuaDiAvouhWDtu27cU26f/1u8a1lNByng?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sV+00ASOwy5LwbkDDQrAfGSaiK92gFaWdd7I6558V4S7LkINhRoB4eF2NX6Q?=
 =?us-ascii?Q?SABuTkoV0iDMe625ctvr4MYEogZIKkYhfeg24eBmA6xVVj3Ccz3/4askyLKc?=
 =?us-ascii?Q?Ju3VLZ4kq32X/m7WZUZAxYJbT4CCav6pqcY2XYtPWAsGZnZaD4pZoQZmqu3H?=
 =?us-ascii?Q?Hu+hIE86U3JSnIHe+owNfo/LkCdJVNVlg8eJ5ZXbkO7lwGQtmCXcr2kmkOiv?=
 =?us-ascii?Q?ih3jZX8/H46fkKZdd9VxMVbApnZ60mOw5ryWw327qrQRAezf9qZmY7+B7zVX?=
 =?us-ascii?Q?LsPWNWNBjn75WpeWc7o+3R8aiPig3iA0LSLQV+xaBcf9rclGhKDTUhmDTt5p?=
 =?us-ascii?Q?rSJDmAAZOpD7PpLqhJn6Km6C6ApXOlLYDgl6c+Dn6qkgtfyMRhsJXzoO4++g?=
 =?us-ascii?Q?gp3DwUp2fp/P/A5sVPVt1R+zry69DTGsbgIiT+44gQImF6nwTgoukM9LO2KD?=
 =?us-ascii?Q?9l0ZHI9XAS4AVi/lD4VlmRqLXUNHmCgUO4UhTHJFo0TdlLQC94ew2Z/UaHun?=
 =?us-ascii?Q?8SrE+a4DpjfWzTSGlpuU2RHsSOv8mstmSTk1Z6MRhtvegsL5+K2JaKq5HxXg?=
 =?us-ascii?Q?bEWN/vh3qx/6XX9KpIRRC8Npef5H/Tb2ny/3BheOv1DwxhogBJEvSU0nLxn9?=
 =?us-ascii?Q?jN+5y6SYIi+2E7tiS8EhRW4ecJFvSatezeMFpY+yZO/J0Mkrrttdj9ueiw64?=
 =?us-ascii?Q?TbXdpY1Hw3ICrj8HUa9eIZxGu0WRcvPjG5GPlYSUosOsauBImt0ip+YTlT9X?=
 =?us-ascii?Q?zwplKQ8Vq7QIGYjAW/BmmmkSQpFQjddFGDpPu5Gykd/Pl4Pgc7DvypIU8ohD?=
 =?us-ascii?Q?xQ8B5BJCAcCjrbd3jpSXr8cFjYqniGuLh/EyGrbfWVmCqAMLsmVVpBrUJZA+?=
 =?us-ascii?Q?lUx8Ds+Ak87LyJYzewKR1vVQQ+Evb3hO1pr1WkmQ4aybWZCHpOkj4Qj8tSf4?=
 =?us-ascii?Q?DltIvKGg78DqqnZ4qME08JRUHgYTP3nEUhuJdfErMbXlBKRQnbmA8qDMpOtL?=
 =?us-ascii?Q?fKnfynVBDM+Ke4WsdKYnateV25ITjECdjXGGq4cMgEYWu0g7b4iLZz7KZ3/2?=
 =?us-ascii?Q?BLxZXDXbJRo/FfMwATCVIAZOGxOEmucFdpns6yc2kHCwwqBnueH7lAMWcOnD?=
 =?us-ascii?Q?B7EMcuNBczh5kQzYJA/A76IgTZ3vgn3n8Cf6/oe1VZ78TWbjo79//DA8LR4l?=
 =?us-ascii?Q?lxtuIoMR+gR49rRcpR6JpXL1DPtbGhNR3gW/cj6i/NjeGxCH2yGy+gKvFePs?=
 =?us-ascii?Q?VkoDKUau+yPpvYfmIyvDYoqWDy1GxMysf8IfMYn4wsY0S6xdwfPDhb7DnbGW?=
 =?us-ascii?Q?W6Z6szQOV5F4E8SI/O2gN961Iairce3Olk+JdylNBhqxZcTFhTJNZstBHYAm?=
 =?us-ascii?Q?oJRxu1RlMsZafO6H0oOGWPT5d8LbG0GUOvtMT0oyB7kJEP/XGWuOrMZvyeYL?=
 =?us-ascii?Q?umtCDxlf9Gxi2aj/uYu8Fu8SkLrwDJFDGwRNX1WSonFoue7/2KWFyEIN55nj?=
 =?us-ascii?Q?FgMwdQD8E6R1pH7KxQCi3IS2mTXZqFcCQSw8HkWyhYzDNCxi6waG8pqOfjIP?=
 =?us-ascii?Q?Y3eAE3s+69MGmGjq+OzffE6+vvGp0/cZ1AsJg4mT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a65df8-5095-43e1-3f4d-08de168f135a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:01:29.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpSPFICuI36EbBNAcos5f1cm32cAAPea6bAM5ib5VFLZV4awta0lb048NncAjntdQEaxrfCsNokluRwQ1/SVzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

The ENETC with pseudo MAC is an internal port which connects to the CPU
port of the switch. The switch CPU/host ENETC is fully integrated with
the switch and does not require a back-to-back MAC, instead a light
weight "pseudo MAC" provides the delineation between switch and ENETC.
This translates to lower power (less logic and memory) and lower delay
(as there is no serialization delay across this link).

Different from the standalone ENETC which is used as the external port,
the internal ENETC has a different PCIe device ID, and it does not have
Ethernet MAC port registers, instead, it has a small number of pseudo
MAC port registers, so some features are not supported by pseudo MAC,
such as loopback, half duplex, one-step timestamping and so on.

Therefore, the configuration of this internal ENETC is also somewhat
different from that of the standalone ENETC. So add the basic support
for ENETC with pseudo MAC. More supports will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 24 +++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 +++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 30 +++++++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 15 +++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 61 +++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         |  5 +-
 7 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0535e92404e3..3ed0e04eb589 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -14,12 +14,21 @@
 
 u32 enetc_port_mac_rd(struct enetc_si *si, u32 reg)
 {
+	/* ENETC with pseudo MAC does not have Ethernet MAC
+	 * port registers.
+	 */
+	if (enetc_is_pseudo_mac(si))
+		return 0;
+
 	return enetc_port_rd(&si->hw, reg);
 }
 EXPORT_SYMBOL_GPL(enetc_port_mac_rd);
 
 void enetc_port_mac_wr(struct enetc_si *si, u32 reg, u32 val)
 {
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	enetc_port_wr(&si->hw, reg, val);
 	if (si->hw_features & ENETC_SI_F_QBU)
 		enetc_port_wr(&si->hw, reg + si->drvdata->pmac_offset, val);
@@ -3367,7 +3376,8 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
-		if (!enetc_si_is_pf(priv->si))
+		if (!enetc_si_is_pf(priv->si) ||
+		    enetc_is_pseudo_mac(priv->si))
 			return -EOPNOTSUPP;
 
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
@@ -3708,6 +3718,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_ppm_data = {
+	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc4_ppm_ethtool_ops,
+};
+
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.max_frags = ENETC_MAX_SKB_FRAGS,
@@ -3727,6 +3744,11 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = ENETC_DEV_ID_VF,
 	  .data = &enetc_vf_data,
 	},
+	{
+	  .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_PPM_DEV_ID,
+	  .data = &enetc4_ppm_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index f279fa597991..dce27bd67a7d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -273,6 +273,7 @@ enum enetc_errata {
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
 #define ENETC_SI_F_LSO	BIT(3)
+#define ENETC_SI_F_PPM	BIT(4) /* pseudo MAC */
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -362,6 +363,11 @@ static inline int enetc_pf_to_port(struct pci_dev *pf_pdev)
 	}
 }
 
+static inline bool enetc_is_pseudo_mac(struct enetc_si *si)
+{
+	return si->hw_features & ENETC_SI_F_PPM;
+}
+
 #define ENETC_MAX_NUM_TXQS	8
 #define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
@@ -534,6 +540,8 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 extern const struct ethtool_ops enetc_pf_ethtool_ops;
 extern const struct ethtool_ops enetc4_pf_ethtool_ops;
 extern const struct ethtool_ops enetc_vf_ethtool_ops;
+extern const struct ethtool_ops enetc4_ppm_ethtool_ops;
+
 void enetc_set_ethtool_ops(struct net_device *ndev);
 void enetc_mm_link_state_update(struct enetc_ndev_priv *priv, bool link);
 void enetc_mm_commit_preemptible_tcs(struct enetc_ndev_priv *priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 19bf0e89cdc2..ebea4298791c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -11,6 +11,7 @@
 
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
+#define NXP_ENETC_PPM_DEV_ID		0xe110
 
 /**********************Station interface registers************************/
 /* Station interface LSO segmentation flag mask register 0/1 */
@@ -115,6 +116,10 @@
 #define  PMCAPR_HD			BIT(8)
 #define  PMCAPR_FP			GENMASK(10, 9)
 
+/* Port capability register */
+#define ENETC4_PCAPR			0x4000
+#define  PCAPR_LINK_TYPE		BIT(4)
+
 /* Port configuration register */
 #define ENETC4_PCR			0x4010
 #define  PCR_HDR_FMT			BIT(0)
@@ -193,4 +198,29 @@
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/**********************ENETC Pseudo MAC port registers************************/
+/* Port pseudo MAC receive octets counter (64-bit) */
+#define ENETC4_PPMROCR			0x5080
+
+/* Port pseudo MAC receive unicast frame counter register (64-bit) */
+#define ENETC4_PPMRUFCR			0x5088
+
+/* Port pseudo MAC receive multicast frame counter register (64-bit) */
+#define ENETC4_PPMRMFCR			0x5090
+
+/* Port pseudo MAC receive broadcast frame counter register (64-bit) */
+#define ENETC4_PPMRBFCR			0x5098
+
+/* Port pseudo MAC transmit octets counter (64-bit) */
+#define ENETC4_PPMTOCR			0x50c0
+
+/* Port pseudo MAC transmit unicast frame counter register (64-bit) */
+#define ENETC4_PPMTUFCR			0x50c8
+
+/* Port pseudo MAC transmit multicast frame counter register (64-bit) */
+#define ENETC4_PPMTMFCR			0x50d0
+
+/* Port pseudo MAC transmit broadcast frame counter register (64-bit) */
+#define ENETC4_PPMTBFCR			0x50d8
+
 #endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 82c443b28b15..498346dd996a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -41,6 +41,16 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	pf->caps.mac_filter_num = val & PSIMAFCAPR_NUM_MAC_AFTE;
 }
 
+static void enetc4_get_psi_hw_features(struct enetc_si *si)
+{
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_PCAPR);
+	if (val & PCAPR_LINK_TYPE)
+		si->hw_features |= ENETC_SI_F_PPM;
+}
+
 static void enetc4_pf_set_si_primary_mac(struct enetc_hw *hw, int si,
 					 const u8 *addr)
 {
@@ -277,6 +287,7 @@ static int enetc4_pf_struct_init(struct enetc_si *si)
 	pf->ops = &enetc4_pf_ops;
 
 	enetc4_get_port_caps(pf);
+	enetc4_get_psi_hw_features(si);
 
 	return 0;
 }
@@ -589,6 +600,9 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	struct enetc_si *si = pf->si;
 	u32 val;
 
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
 	val &= ~(PM_IF_MODE_IFMODE | PM_IF_MODE_ENA);
 
@@ -1071,6 +1085,7 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc4_pf_id_table[] = {
 	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_PF_DEV_ID) },
+	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_PPM_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc4_pf_id_table);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71d052de669a..5ef2c5f3ff8f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -435,6 +435,48 @@ static void enetc_get_eth_mac_stats(struct net_device *ndev,
 	}
 }
 
+static void enetc_ppm_mac_stats(struct enetc_si *si,
+				struct ethtool_eth_mac_stats *s)
+{
+	struct enetc_hw *hw = &si->hw;
+	u64 rufcr, rmfcr, rbfcr;
+	u64 tufcr, tmfcr, tbfcr;
+
+	rufcr = enetc_port_rd64(hw, ENETC4_PPMRUFCR);
+	rmfcr = enetc_port_rd64(hw, ENETC4_PPMRMFCR);
+	rbfcr = enetc_port_rd64(hw, ENETC4_PPMRBFCR);
+
+	tufcr = enetc_port_rd64(hw, ENETC4_PPMTUFCR);
+	tmfcr = enetc_port_rd64(hw, ENETC4_PPMTMFCR);
+	tbfcr = enetc_port_rd64(hw, ENETC4_PPMTBFCR);
+
+	s->FramesTransmittedOK = tufcr + tmfcr + tbfcr;
+	s->FramesReceivedOK = rufcr + rmfcr + rbfcr;
+	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC4_PPMTOCR);
+	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC4_PPMROCR);
+	s->MulticastFramesXmittedOK = tmfcr;
+	s->BroadcastFramesXmittedOK = tbfcr;
+	s->MulticastFramesReceivedOK = rmfcr;
+	s->BroadcastFramesReceivedOK = rbfcr;
+}
+
+static void enetc_ppm_get_eth_mac_stats(struct net_device *ndev,
+					struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	switch (mac_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		enetc_ppm_mac_stats(priv->si, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
+
 static void enetc_get_eth_ctrl_stats(struct net_device *ndev,
 				     struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
@@ -1313,6 +1355,25 @@ const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.get_mm_stats = enetc_get_mm_stats,
 };
 
+const struct ethtool_ops enetc4_ppm_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_eth_mac_stats = enetc_ppm_get_eth_mac_stats,
+	.get_rxnfc = enetc4_get_rxnfc,
+	.get_rxfh_key_size = enetc_get_rxfh_key_size,
+	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
+	.get_rxfh = enetc_get_rxfh,
+	.set_rxfh = enetc_set_rxfh,
+	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ringparam = enetc_get_ringparam,
+	.get_coalesce = enetc_get_coalesce,
+	.set_coalesce = enetc_set_coalesce,
+	.get_link_ksettings = enetc_get_link_ksettings,
+	.set_link_ksettings = enetc_set_link_ksettings,
+	.get_link = ethtool_op_get_link,
+};
+
 const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 377c96325814..7b882b8921fe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -378,6 +378,7 @@ enum enetc_bdr_type {TX, RX};
 #define EIPBRR0_REVISION	GENMASK(15, 0)
 #define ENETC_REV_1_0		0x0100
 #define ENETC_REV_4_1		0X0401
+#define ENETC_REV_4_3		0x0403
 
 #define ENETC_G_EIPBRR1		0x0bfc
 #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index edf14a95cab7..9c634205e2a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -109,7 +109,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
+			    NETIF_F_HW_VLAN_CTAG_FILTER |
 			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
 			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
@@ -133,6 +133,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->features |= NETIF_F_RXHASH;
 	}
 
+	if (!enetc_is_pseudo_mac(si))
+		ndev->hw_features |= NETIF_F_LOOPBACK;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si))
 		goto end;
-- 
2.34.1


