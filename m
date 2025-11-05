Return-Path: <netdev+bounces-235709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD268C33F48
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 05:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164A4189491C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 04:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3B256C84;
	Wed,  5 Nov 2025 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I4rmmufg"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C271DFF0;
	Wed,  5 Nov 2025 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318572; cv=fail; b=YTOagRIkvuLzFzTCoCiaxbS/uee9Gv+ccpURcQ0g5euBdAjXVP6O3HcgL7H82tkHdgCrKCG4NsXsaQuaZ5HOEZh1IBvtM0MUjoiVjbNgKbalCfMFpl7N/+xEcmnOD4QdIEFpMcKKhrKO39XJVkETQcsUk5KlgE5to6NsVo/JL6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318572; c=relaxed/simple;
	bh=dym3C2iwkFh/C6dqPcOtke04aErUZJXGmaYPteE/Js8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Na1zCTyOwXGAEfjdQiQk81tC0dXtYOy/GcaQs4K+E0jgXrPSUl89LwNyaWektb7MRilY+EO5cJUDsIZ97wgEAIPNTiwW2UB1y76gDHndUbzKdScF39ySVJQNtQSvIuy8Z45uusj3jAWasDCUKxrN949MtkpGpyb98XqZfXFQt8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I4rmmufg; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scoYMxcn/SSdCSXl+AwQ28tc1d04D2VqXU0q6w+0ulmN4jFHK4wEv0HX0K48HJSN0Vfqf8wkmIYDZOtPO52DqYEs0FudwqM8soU8GZl9fBfyuYzOZde5cHxt8c3c9nxiR3u8UYhNl4BWhpgUfIY5cKH6nKWbhYafX50nUtksfHGaj+7WbF69s28RvxaOIMeRvgek9hyOeUjCP9So2p9nAjfeVuguzSSwCqdH/qoBA362weqvCpHgZDqimAMaX6VgBwEEoP5rOJW0Bw1yNmsr1leTPm/Ya6yBysextLcE5oAz/2M6LEZXSx6bu/lJkV8f2/sB0VhKnmkKVX3s1VFDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LvE111NBgpnQ7JtePoURKur1qOXgN9XAnRMZbnuM1A=;
 b=Tn4vvtD/30L3VB+qkMH0JXeTRLOaynkH40lhwTp4qKK2lNmzHHbukLuODRCOpRRKaCgmbqj+WYx0mcSe179NYcIiZ7JpvEWkATThoGBl5zU2OeLi9bj0KdaMLxxIpisMB1L5Jicp96R+vY9HZmqeHz8h3o716iFR+09URDrQkU5hK1+XySRTUbMjrb+hK+L/bEzP79sE7nwZCUOVvRkcObTweKy6xB+lCDvFjRZNbsyAkJCSKCXzBT6/+gJl1zGt1D0YHUu5UEe0FQr668hyJmjBqcLcD/aZY7EWc6cK/2iBcK0xewfeiFgNCe7aB3pOQIodL12NyTK/FfbKkDW3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LvE111NBgpnQ7JtePoURKur1qOXgN9XAnRMZbnuM1A=;
 b=I4rmmufgLEA8okGCirv4yB5MEvBTD0PNxQvCrXixp7gcp3cabvXJyu1WpO6gdRuk2YAkYp1BzbaGLOW8zixG7DbJb/ifoZFM/xMkYzi7tD0TR+SUkQrROR2ywKkN6550OoqW9lNV/11qwU+mt1eICC27kwvuvsQVqbwwWqyWUywyjzKEGXR7DuVabzkirEuFYqLL6IyBouJXfK9XsO6PNIqgVP5LXjpjOnMUiVf0A9/gVGiAzKybnnepx3MwjgDRRE+KGNteIwCsK2GxFSGPYLbHnxVlVuVbbggfAjWarUTVWO6rXqvqfZ/GM3ulBMHJEOp4cJa+SNMw3t+k6hzheQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 04:56:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 04:56:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for both i.MX94 and i.MX95
Date: Wed,  5 Nov 2025 12:33:41 +0800
Message-Id: <20251105043344.677592-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0174.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::8) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 7198bb64-afc6-4957-f565-08de1c279f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZGPJim8mAjH61n88FSs5yswHrWto5q1XbBSxPYwx6VmcY0H/b+9HyR3VvqS?=
 =?us-ascii?Q?rx+D+c5MuvUOBrdFbFl8qsVxasVeqQHnjwIdAaWQXcfYuiq2xFzJ5Xy27tfF?=
 =?us-ascii?Q?tXnlHQaS1vjzhBNOloydQQ2GuRDXxHr7MMnrd5+9vgkR392W6HARMFKF+TtB?=
 =?us-ascii?Q?nNhEtN/GNgR3AJ+c1u/bV3130zxjaXgrpYL9sJVzar3WFlNhrKZdtG5Tvxb3?=
 =?us-ascii?Q?0m7IdgrxualSjzakOx+Gl/4zAf1ThYOOnYc6xkCMsq9wn5PzpaE5/DT+8S/G?=
 =?us-ascii?Q?gJixufamHB+9GV0uHcO0trhlTWH7LC+NXVi6epjjef6fP31hq8vqV72KiW6c?=
 =?us-ascii?Q?2BRBwjSHeVR8ZX5XsEZP31TiWuyiFehXYY19ukczNPaU89JtR+NXHk6rmmCM?=
 =?us-ascii?Q?kc8MP1jKHmZw1Hxh7nC03n/mOZyjKH7wJ/reTjYgIEusPxGxpHMQgIxq+i4g?=
 =?us-ascii?Q?ODg2dDUUzVTD1PXbHSzB1sMcBp6fH7pL9LHKvVmllGqZgMcPYnBjpGioA01W?=
 =?us-ascii?Q?GF1yF9rVmhbjOc6OLWtTds8rsVfD45rs81xsLpGjLYXAeX5+pzKF9ScHt5X+?=
 =?us-ascii?Q?pCUuasGO2XgIseA4GlIGZ5P4fYJ37gh4bFYscOf1/MqtYpPM+rKykBvu3LuY?=
 =?us-ascii?Q?PaIKdjJ3M0RKdXjpxpyp22LhWp6M0dKyo5DMBBZKVaV173ZLBvLfEvkH1hdp?=
 =?us-ascii?Q?aMwPl1aPXR7b0Kskxx1OaCsoqi/hIvXUBHlXoP2OVED8uMQPwUefKFypsYZY?=
 =?us-ascii?Q?0xj6FLuQbX9qLVrjeiK65Y/uM5hVdp87qzpFrlnwRftnmgcLs7v61ObIGpjp?=
 =?us-ascii?Q?n4XTr8ejjAtRpLlU065kbhm/EbKuo92MbvZ5ir+i8LQjrTryXhAw3nCwfAup?=
 =?us-ascii?Q?rSpoJtVr0mRJj+OuzbgsJwamfri6Q60BXVnsrbpxI8hJJtd56erCfpXgGrgl?=
 =?us-ascii?Q?7SVlyY/WGuqGmAyDdsi1/pXlfpIWf1+JkQRIb9IuMbZmOU7Y5EFmyBTDbRZK?=
 =?us-ascii?Q?zeG/5pl1dPWplAzccBzqDdeNbOfwgaFCTkkfmhBtlkiZzLT9Zc7cndd78hZt?=
 =?us-ascii?Q?tgZUoWnrckcpBJuTSRYY5oQAzzFEvPKc1vduVLPUnJZT0JOL0cc+/pbLzKnM?=
 =?us-ascii?Q?GxgYTfqXa8v5LNk6tSjrrh1wsBVoimOAaSdEZlyg2Hgi3ExWOXnDKVdEZa1f?=
 =?us-ascii?Q?kA6yXnZO4Pz+eWlzeaXilfycSVpjzJNVlMD9o/W5cpnatsH6iTZx/rueMYzF?=
 =?us-ascii?Q?nkuJrzHsCBUZElbdPz2AWGHWK2qROIt9rC0pBUnBBKqq6Sdqet/3erSMcqmO?=
 =?us-ascii?Q?bEFmIonfxSToCNKlOyJplJ45YwuaD1rngltiSUOGBff6pBvQBS1tXTGRz8po?=
 =?us-ascii?Q?Vpyo0/gA17jirCautPUc3rd4ZjViQTcU+jylAd+5JbWyzxJ2aJ7i+xMTmLFI?=
 =?us-ascii?Q?flVC7pCryj5ChmdMWvIcPymWHz7SAZyDE83sqF0ticIFmgdlDV63leGTc+pm?=
 =?us-ascii?Q?6PA+ki0a9vN/ymfpoxEhDvLBhZjWSsb5xcub?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKR4owLQcxTyaFBk+bZfGwYjoaz/68ns3PGtWr2K1CO+bRpfMeHnH+jsm2YB?=
 =?us-ascii?Q?Gm0bVbklMQNZqy3RVFQGd4gtdswrcrbc7cVU/sCat9CWnmEqLDlS532+jn0Y?=
 =?us-ascii?Q?qir4FlRr3lCXH5YhGR1JuL3jPFcI1I7zBEt+18xLsfAyb3Bg+7nHb8oegTnh?=
 =?us-ascii?Q?ODwwcMfdIsQ2PLBXglFrBmH6grVQGzAa7TOLWlW1Xw1uG0HwUmgFfM0Si1p7?=
 =?us-ascii?Q?yV2o+dD3FJ1+01yqMhjjwOndM4etTXNDTydw/nCPSuZwk9SkG0SVmUdCR2NH?=
 =?us-ascii?Q?m7TxoFxojhcMw8cIa8SfNpHDBeCeeAikMJC+wp1Sg73VH6u6A59PDK3SpkZz?=
 =?us-ascii?Q?U6UiGXjvCTgE5ZddW40fSd9tNrW6C7U8GWl/IoWpr3Qr7MYJ/6DDdJjsdd9y?=
 =?us-ascii?Q?TxbV/UjnkuiB5Elz7RZDwFwo0/vwjKHC8W666IpfO04KatmUlHJKcNLb8GY7?=
 =?us-ascii?Q?af/Ce+DPsY7ZRugugH2MtJkkoYuh0JoXB+5RUrrrAWVG04N/ntsBltAEmvs8?=
 =?us-ascii?Q?pzfe5TIC94D4vlaUNS0in4BF8HOYu2ukqzSz6R6z+37mrrm+IuWpP3i0s90w?=
 =?us-ascii?Q?GGxks9xkdcJks9dYEM+uaw29lZfBhUvHBh5gH9J5bIQpEZ+4U2FlulCilCa+?=
 =?us-ascii?Q?vGGPP++kRw7xyG7GyejOgZkjJElb8LsxK24AXe2M2wfoR2qxpxadzduyTtD/?=
 =?us-ascii?Q?az1G9hlYuifGeS45owbY6+t9dDbWHyrt3cR7Tf9nDMz22awKTFpqS4H82Cfz?=
 =?us-ascii?Q?TeMHvfyNRuDwXXTnfTOWz+MkeaYrn5NqU3nzTFvU/WITRurpFsPJhg2+WUSF?=
 =?us-ascii?Q?T2djWh9oIGmz+L4omzBlKfG2KW0Xwc+8UB+QOOL+2XZ5YqmoD9Q4klCiuQ5s?=
 =?us-ascii?Q?pb30PJH7p7SiTqKn6cAa5qjYzeXobiIShQxrvJUGkNjmHgfiWpt97zY+pk5T?=
 =?us-ascii?Q?Ezn/MZzg0KUdhtSWwqYOSmAdeBf7KsopMkTw7kCLQddkDwT2ZFnp+LH0g2KT?=
 =?us-ascii?Q?BrQUPAUGTcwaoAfslOk6e0Z7oX63H0Jl66L/e+a1a0nd3+n1tGMkwFKecjdE?=
 =?us-ascii?Q?GK0UqLg6DJn+vPEFKbp661ND7fyLorB7cfcDHNQcEmj3leawS31jm5caL+3W?=
 =?us-ascii?Q?BMhJurzvoR7lJ9I+Wx92V0JkomvBwsQtfXSJBQ3OOcbqYpIjKdDav3oKW6m/?=
 =?us-ascii?Q?u+IWklWXDpWKFb6fr9+cL8QIQHV+sjtxLiabj2pADu5CwL5CvOA4cbz10Hyy?=
 =?us-ascii?Q?gRkikisf1bCZySH7mg3Rgo2E439WAyvWil4FLPetNx2saQWXmRzUiHZhlymF?=
 =?us-ascii?Q?Oes++gCqhEwal4mFwnfrhFwR3peXctUyqSx/H4sWE0jYfKWu29sJfzRF0kol?=
 =?us-ascii?Q?wJkwbfAy7bDPdbJlXJ0L0Tgs3I7COfr7PRftIm8UpjtgI5sBOfZrNAUItyTK?=
 =?us-ascii?Q?W9o+LMgnWsbq6lODN9IsyWGy1S0JhvGn4/zJrrJ9xN+IoNkIVXZ+SCIHOrbI?=
 =?us-ascii?Q?V2o4q5ho5WRZRDeiV/q24S+46M5PVHkZIkyhDf5MJ62kXdbfUhdiZ7TDhYxb?=
 =?us-ascii?Q?l1/8eB0W2B0gCh8ViG6hP4Uo+uMPTFlsRrrRye8M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7198bb64-afc6-4957-f565-08de1c279f09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 04:56:03.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GhpNXMZJ6O6zPJ7HvFn2r9h/VYPoSGgrrFI279RiIwFUp0yTGN80Dbah8S170YXsf+3YgHgkAyIcANTWyhKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

From the hardware perspective, NETC IP has only one external master MDIO
interface (eMDIO) for managing external PHYs. The EMDIO function and the
ENETC port MDIO are all virtual ports of the eMDIO.

The difference is that EMDIO function is a 'global port', it can access
all the PHYs on the eMDIO, so it provides a means for different software
modules to share a single set of MDIO signals to access their PHYs.

But for ENETC port MDIO, each ENETC can access its set of registers to
initiate accesses on the MDIO and the eMDIO arbitrates between them,
completing one access before proceeding with the next. It is required
that each ENETC port MDIO has exclusive access and control of its PHY.
Therefore, we need to set the external PHY address for ENETCs, so that
its port MDIO can only access its own PHY. If the PHY address accessed
by the port MDIO is different from the preset PHY address, the MDIO
access will be invalid.

Normally, all ENETCs use the interfaces provided by the EMDIO function
to access their PHYs, provided that the ENETC and EMDIO are on the same
OS. If an ENETC is assigned to a guest OS, it will not be able to use
the interfaces provided by the EMDIO function, so it must uses its port
MDIO to access and manage its PHY.

In DTS, when the PHY node is a child node of EMDIO, ENETC will use EMDIO
to access the PHY. If ENETC wants to use port MDIO, it only needs to add
a mdio child node to the ENETC node.

Different from the external MDIO interface, each ENETC has an internal
MDIO interface for managing on-die PHY (PCS) if it has PCS layer. The
internal MDIO interface is controlled by the internal MDIO registers of
the ENETC port.

---
v2 changes:
Improve the commit message.
v1 link: https://lore.kernel.org/imx/20251030091538.581541-1-wei.fang@nxp.com/
---

Aziz Sellami (1):
  net: enetc: set external MDIO PHY address for i.MX95 ENETC

Wei Fang (2):
  net: enetc: set external MDIO PHY address for i.MX94 ENETC
  net: enetc: add port MDIO support for ENETC v4

 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +
 .../freescale/enetc/enetc_pf_common.c         |  14 ++-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 111 +++++++++++++++++-
 3 files changed, 128 insertions(+), 3 deletions(-)

-- 
2.34.1


