Return-Path: <netdev+bounces-120780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90195AAAD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B9B1C2190B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8511712;
	Thu, 22 Aug 2024 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AamtAeiZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3F10A19;
	Thu, 22 Aug 2024 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291496; cv=fail; b=j8aLa+ydLfcpTz5vGjJPT33BPWZ8BJdDkUUDWLo0hCs9ci1aI05QQxwJ8/HwCiAD/WYsRncU9hyzU38rCCZF1b/GUPDp0rpmH3F7VRO5IiBLKGIqv5fnMfkWMZoLX/XNs2nf5mkQXdTzAIG03tz2fVMWDkcIPchNYFGIBaVQ0G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291496; c=relaxed/simple;
	bh=3ANS7wsU7lnVPL0LI4gtcJSNgRHfRhUvJ+W2H6wsRoA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LQD5XtDfhAy9Tl8yMjHEaC9BCMjclinyc738FgethzMb0ygXsZ05LVI6A4osXGLEUUKMQK/O/3RpZHulAG+oPzqWayOoQqhZ4JuO7MfA9f3i6TbUjtqvVbImdp/pEngCz6uLJLQxk+vUA64LekyBphqBvu76POfmGruG+IZY5Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AamtAeiZ; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoTWXjUQIiWHVac3FyzeYaRVSiWFJbCrrsSbJG5scSl4ms7ej0XQcjWXpDD08kVZSne7Edt49Zz9uXYfJpYkMkp6eIBuf1z7QiWH+dpEWTU+kMdOY4v47AsprVpkWEnPbMLN2kO61FKoA9pGWFoW9toEkQhVGGIaMCaAI9KrQ9XplJ64U1OUpgK2Dp1zeXfjA1Cwc8WVStbHKN3GgxQLYqPRiKCJqgSY0OB/fF7T0vb6a0GyY3ULFvhFEg2HFdRTZu9aqcec5NaF3xbPyugJ9hGxUhcoIW0qS+9XUhb9GG1N5umnVjtfcU1rBsEnNM1yoKW0IOEI4U2ZaXFqBrQ0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8Z5o3kyY/KWpI/QA0GwMiuYw++GTXoAzaZiLkdFbng=;
 b=UC3i1+y41MQcJZoUu18b6Mef7KDTheVhEWCOsEf5jVujn0pMEv/+TQcwKJxWEUzY5M+Ge4mTj0EgRAe/HboW4iSSzJ6Qg5qowgSgV6buYap11DjKZGC2smNqDJXiGsgVhlIL386jCKiE02vv4+cHHsLc128zcl8a0S+Zgr77CqClPBq0eGeelCTwfn07cSvSg71KfVFwDxc+nukpEKnFyR3gGRk55WT3/cT4Ooqx1iSXN0MqH7xadvO8xwZZf4eBsRzXaDhf2XOF9uCzqZGQBfIf2TluPv6dHWkmDJDPfd/+u+gxgu+p6tULc0WWHGefLjaMGOJs4ZJZcM0BJP/FEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8Z5o3kyY/KWpI/QA0GwMiuYw++GTXoAzaZiLkdFbng=;
 b=AamtAeiZ4QeQBhxCNiMG/kDglOgM2smL200P7DlBn9ebok0vvbS10sYyGLTszIJeTVRM3XEG7CLS3H/o3b+ovg/MNdzwJTAvX5ntZ6hhXVIBedBJQikhOzjWQGXWo8VqehouaCD5d5V3HmAfRiO3QmvP727ClMOwoJW9kJxWy05OucUtPz5dpcQJDCTC+/ntjfpez9x617FnVpeH5Z5hVsgfHugc8rXBh0nXIfwWgHeNZgBOd2oZd5AN6y2hQx2I89ru2c9vbNWUqAzocZOd9UFr4fTUNJp0N/n4lYVBRnSs8Q1CPTW1V+n5HU1/ItZ2y/m7WvkgAaWTpLXWKqoCEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 01:51:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:51:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/3] add "nxp,phy-output-refclk" to instead of "nxp,rmii-refclk-in"
Date: Thu, 22 Aug 2024 09:37:18 +0800
Message-Id: <20240822013721.203161-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab9e33e-bf9b-4fb0-0553-08dcc24cf1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGSjQo1JabpQC5ivwP8Hkkqkm61IMaoH1ezNlYTWJkU3svpJf0WG/CPi7wMi?=
 =?us-ascii?Q?rSNga2CFSI8LPb6o22H43OTjl+SQWe5i2YFq+uKtCZM8DvupByslWI5X8Zsj?=
 =?us-ascii?Q?rkDARs607MQEAt5IFqXZ4Z+/b3J0e0UUBUAYYvGa7qrtmGce2P/vgQfqBPUT?=
 =?us-ascii?Q?vu7oyW9vpcMkqtN1rvJID3xEQcPaIevd18YxXLuVhgMRDUQpXgEaymzUFV87?=
 =?us-ascii?Q?yhKca0Cb8IdhcAI+QPijFJfPTCAUQO+2VNYEXgh67ZuMshWVyOK3NFOWxKmQ?=
 =?us-ascii?Q?HKOUOMyjObwoCPndHoq3RXEhfUPNbAvTuAV/d9yoTuo7NlyIHYu2JjASL2eH?=
 =?us-ascii?Q?Hus+ztBIJK03Ifqn/tQYVjiCywT81MnPELzWStxXM4su97J63IcLETe/6sSd?=
 =?us-ascii?Q?R40Hd6Ex3sIuT7EDbyNSZKbsxwPQmZXBlvoNsAznKp3YfcqGUXSPatcCeEJ7?=
 =?us-ascii?Q?3L4JoVFTUrLmtQGYL1RZgvNXyECyB/Yf5odSg7q0y9ssESoNzZgiDEqVUA6N?=
 =?us-ascii?Q?ZtzKGkNfggNff5Vi/gDZZLkp2vscom0CUejVF/DPVSz5eNtQIVygxbm8GxBG?=
 =?us-ascii?Q?hjzcQF5H7lwh2CbxY8WsxSL0XyNo7Z6lCy4BBUd092yDLszlXgd/K1cC0Jgm?=
 =?us-ascii?Q?PJXslNZKjYaHJxvhKZgsKdLnyq8hWt6QPPOVSBoxcVpKJAZs0EeE6TbQRvnn?=
 =?us-ascii?Q?7ZyouhWyWPF2ZQmo4cDAY3TZexFOmOV+2BCjcxR+yTr7rVt1OFOdMJ7qKUzD?=
 =?us-ascii?Q?pBdTm73PIcH8PiHfOSFFYM4gtEe9PECzmPZysDbOi7EH9d9J+N5Kd6mCcAOa?=
 =?us-ascii?Q?b2hCWbk80WtpKM2NPcpEQ1cJrAcUaaOa1+Vtl2cbWzAzs2xKsDE0hWqLm5BE?=
 =?us-ascii?Q?W5Y2u6tgGvvx5GfWDd/XahZUcTP8u3UrOBMebAlhC+oCn0R4WwAUtSXwd5TZ?=
 =?us-ascii?Q?9+MPqxv+rkeGpXLljm+qM+KxDakdk7aEGErJcTxpm9cvzMBhRQfvioTKK251?=
 =?us-ascii?Q?8+SCNO7Wt8dWsPKbTtVvgpfENPtghuQimhdTNratJJmQ0pHOMC1obakqrqRh?=
 =?us-ascii?Q?JbWxAeWU+kFp13y56hp4RVipOHwamzvdTE9fGwjJL8ow0vafGVWkW310mxpq?=
 =?us-ascii?Q?qvYqqQ+Fq/Xw730AYDl692FJeSgLBjGpjoZJBQOs0mvpSY7zMYbtImmr2dCt?=
 =?us-ascii?Q?zM4f768cfqAKJM03+ROiMT2uB/5p/LXBmh+tZHi8ux8uZ3VpzAEG2QMUddts?=
 =?us-ascii?Q?geYEcHTm9gZ563i3IkqRUb3t9mclFa44nTnV4ZfAigzkbo0HRs7htjAfd758?=
 =?us-ascii?Q?GzF65SSQ3yitZfuNnGWsJQwD3PN3z16/Nn4w2OQkq7cjpoIQoWOu1DrGcJLq?=
 =?us-ascii?Q?TfIVuOsIEcvdR7HZxlXiu2M/el0nJwxQusoOK/In03t3tcGTCSdhwGJ6f7NE?=
 =?us-ascii?Q?sA8CmKRnk38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djv+Ufq+DFWb2EbtjRRZqbuZRps2eblbecJVUlg83UF+CY/TQUcirYoqkALf?=
 =?us-ascii?Q?erh56Bi93XP2973wRHUKvEr6dt74LRy4WsJ/KDIlqShCdTxGKgV43XsghgNW?=
 =?us-ascii?Q?mEZdYXLIh1A5OBX7e2RQl//oTE3L89M9MghJ5Bta6qExNH50QbVQ3vw3MNj3?=
 =?us-ascii?Q?9E/ZN98SUQ88Ect08HI2vRCACXqWTG0p6boEalynrpW7WmPqOAbPtvP07mVZ?=
 =?us-ascii?Q?13+yHzY0B1+QbmyGIo3Dju8UUX+PaSOL8SkDVfYKJEPUfbFa9uVfk2O3B/Bb?=
 =?us-ascii?Q?TbLNe65KfHzDbBP5X+TIT3y5BlaV0j6EG9HgwFntYFbVyM5VX/NOnT3JIS0w?=
 =?us-ascii?Q?yYA1gok/bzUjKxRgm+GUDk2r3xydx+AQO0ogshJC1cxszQZtOb3+qRxR7xDE?=
 =?us-ascii?Q?Ipj9+h1Vc/GnmYwm4gAApkBDsoa8mwtd9A/8Ep2qn3HW4D42SBBUG/MOmw2/?=
 =?us-ascii?Q?h62h/sJz25OWg/UxS513sTGaxvVyk1LuZUNHDJSEqsE7MZU5suHdpsipP20u?=
 =?us-ascii?Q?ucTHro4gF2RwnsiZ+DgO5GdLC8g6j1GRVKRsA5pEstoeVu5GV+Aiw1MWC635?=
 =?us-ascii?Q?f51/yfOFUFI9rCXD9EhGlVsggvN6jOHcctXNfBKfW0fbDUGLMjME4ybU2+d4?=
 =?us-ascii?Q?8Yd77+yx03H2m+ScR4gxmGaViTtB75fqH5IX6F03nOBd0uDqliLiprGGAr/M?=
 =?us-ascii?Q?/AedDLSzXjHpbwtEfZYAzSQLdEucPZ2X6bkCKfw70RK7sfMETErW532XpuQR?=
 =?us-ascii?Q?6JyfTElJ9PIa0BzkvJH3k6JpTC8b5ZskggUmLrUjJXKTMGoOIO0f9l1xaw8v?=
 =?us-ascii?Q?eAbPviOSqGf+e76sY83XEIBe7ducK338+cXSaQfzBHslV2m4jsvrHYAalccu?=
 =?us-ascii?Q?KffLJIxOAx/9BvKmAIF7u/9nubGmIxQb6rw9CuQk/GLMZeD1zBvlPk4/3yEG?=
 =?us-ascii?Q?aIkSYsfWScjYdEtBhBUyaF8zwxiZ+VCBBBfp/vmZv8NVeEEJc/alS/IjfJhs?=
 =?us-ascii?Q?aM23wdkZ6arsA2s/N2b4VDpDEwEvIqK1BDjk9/lv91GGzP6bXjbRnjreLdpc?=
 =?us-ascii?Q?4psxqiVNrFinTgD3Wvzs9koFcHCnHfHPyYGUCA0C+0rYpiaud6cMmpEVw9Tk?=
 =?us-ascii?Q?1NUmsW2W38pmFk2tITI6E0Mio4klpPwwOoh6R0o3v/KXJsfesFqM1r4txSiQ?=
 =?us-ascii?Q?3yNMvf7RB2GmO1HLx8tFyTNQ4JRRgHoGSWAluTQswWKz44Q+WyI9zxV71jMB?=
 =?us-ascii?Q?zQkEg6nkFO+wqL57zCJFr4kYkF2CxDk7VgMdq2CDoGLOUfvJ3Hu0321iyVKZ?=
 =?us-ascii?Q?EIR4AUJdokIymaar0jv41PxvcnGv5Y9IZiv6oYCmL0LrC9ZtXkeXtkMtJQ1i?=
 =?us-ascii?Q?36MAiQtKDzC374hNiOJykCH6v572EFjE7SgokJ3alUssorWwO+eUFOR3dcT5?=
 =?us-ascii?Q?kd+wtoarx9GdewOPKGs88VCMnDSqsDeplapDbCWrnEwU+6kgEOOTo2Ls2B/G?=
 =?us-ascii?Q?ToRjAz3T3SteZ5YsGUrKxuGN/55U9prSmV5IQMzDO4F8/HDV8t3a0SwghSB/?=
 =?us-ascii?Q?7ZF2vbMz3jQTjU8QsiThiyyv7vjeAf3bMPI8B7eS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab9e33e-bf9b-4fb0-0553-08dcc24cf1ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:51:31.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JovQZ1Fp08Zzg/8CbfuvHjPrMWGw76wrnH/DSrsadLH3V37pekWZ/38QpWInOHnG7SyBREkfTif3RmTXtv6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755

The TJA11xx PHYs have the capability to provide 50MHz reference clock
in RMII mode and output on REF_CLK pin. Therefore, add the new property
"nxp,phy-output-refclk" to support this feature.

Wei Fang (3):
  dt-bindings: net: tja11xx: use phy-output-refclk to instead of
    rmii-refclk-in
  net: phy: tja11xx: replace "nxp,rmii-refclk-in" with
    "nxp,phy-output-refclk"
  net: phy: c45-tja11xx: add support for outputing RMII reference clock

 .../devicetree/bindings/net/nxp,tja11xx.yaml  | 18 ++----------
 drivers/net/phy/nxp-c45-tja11xx.c             | 29 +++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h             |  1 +
 drivers/net/phy/nxp-tja11xx.c                 | 13 ++++-----
 4 files changed, 37 insertions(+), 24 deletions(-)

-- 
2.34.1


