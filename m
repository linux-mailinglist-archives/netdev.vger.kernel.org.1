Return-Path: <netdev+bounces-231996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801FBFF7B5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3CF1898495
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE52DA757;
	Thu, 23 Oct 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oI45BL/D"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4A2C11F0;
	Thu, 23 Oct 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203803; cv=fail; b=kiXMpd+j2jZBdixsSoQQDcJNgN71M2xAvXlmgY4cGaPM/nP02WxgECzY7H9HWIuevjcud7D2Q+SOKwVo2twKs4sf6BJoynWKlWXAxhq0AWvDFTNCpPrek0q4JjVy8zDo/9n3m92ySFgVZ4UGL8FuTv7I/mUt8PA8YFk15I+JjWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203803; c=relaxed/simple;
	bh=Wbi4dZffeMflDy/IVVj2OZuq44Gm7Uut1ynMWTaA5Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RzJmYEyxFwpgxzCor2PMxAG9A2T/iBQ5vd0odCq3N2OjTHf2rgp94CYov2ZYudnh33asa3ll8rnDyXvF4tiPPpKX7omuloMexZITW62SVTf6DV9gcCZGj+4nKa3ISrPasJ6oSTN3dOzyVJTnAdvlJkr07SB0wUtxfVn3YZFIpSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oI45BL/D; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYfhmlLBCUhvfL0ZxPh5mVEcIYP7xGIWq6QPOMC2PcYMEhDROKSe/QxXgib6j8VDSBoQN0frGZD9ZxLhPN+aTTpbxs/egTv/emSDjztX8J9i9GyIZBHYDb0Cpyh7SSHwVboUWpXJVCW1xvAaHz9WtBuw2cqQqi8km8woimsDimR3EfVWHGmyZhYtPdpH1lVIf4aQUJCx8gIFssKzjZgseQgUPC2Z0VhdMtrhBqI1VUd9rklNwbRdxWrmh9pCZmEE9t+9ZxpysJgWPTPo81oyivhwNUOCeqp0QrhOFwkCen+pnAb8fNyPP/tEkyNod8HMNlcC7mRnpGHtseILVjp8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkB8IuSLyquVNI1LT9Kb7sox6OgPVGtcsbD14OUPq5g=;
 b=Rhy8Ioc8S0KIUFnPyVnrx6uJUCaxQ8SQ9Bh82yXh152YPdNxMfAuqkoOoFBs3MHjoBZMIXL/D8uBJXoKVy/UbFiwCXvVwaAllrBNTfVnxyEZQUle37LEx+SnEGFBJ6/hQvK2q9L14cZRgQ5r3ye4XM9x80KbELbs7+5nHS43B6RLlrUqrUUk96g1QE2AG/gf3dIMd+sWx616SbmoYRb8MnD0gYc6c21JhFUcQ7N4lzUlBGwZjmMT5VGKr1lqdjGbs5Y6zdUwb6Jb1xev+x5b3cZ+RNWxSC3BgxQecipcPs3/eKQR2kATftX2AqkFVAp5NOtFclJ+0xsuqNSIctDB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkB8IuSLyquVNI1LT9Kb7sox6OgPVGtcsbD14OUPq5g=;
 b=oI45BL/DNLC24BBg4aWOwwwKMhdSzF6XazX7FfYUqvpOvSLQUwRSE5//0Bk45AwOo96VQ3xDyeLuE0SLQ7EvRTUEE6fVsDrgclC0oJWKXNwH5wask/o2nvJl/TPfJvNz+zEBFA9iokq6MkUwh+lqBRXZ1KHdL/ebLcR3RHYQsJEfllXob3GIGGYkUNB0Fbw3krtwid/Vp2NWIAhglxOgCkj2ER8ksklf5a1qYhHYbOvrGLPB3eNKdfLHZ3v2xCOrDazk4kelvHl/CvdOY7ICs7eQ1SqsL80oHGcXkpWpKPLS7IlJS6+RZyk+x/X84wbY0xxe3uVc5PbVALmzIIVvWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11331.eurprd04.prod.outlook.com (2603:10a6:150:29e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:16:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:16:36 +0000
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
Subject: [PATCH v2 net-next 5/6] net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
Date: Thu, 23 Oct 2025 14:54:15 +0800
Message-Id: <20251023065416.30404-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023065416.30404-1-wei.fang@nxp.com>
References: <20251023065416.30404-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 0143f32a-f57a-4608-43a9-08de120419de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xrc4MmSfAEqeeyo+ptGg1NB1MYGUCsU6S8VQs0soYM5zjRPz0WiXhWINnYeH?=
 =?us-ascii?Q?TUgbMMPeRdzaiJdoJVDqbRLMWA7OoOUl8IWM4T7hSp+BXQ0G0wIEMUF48QsX?=
 =?us-ascii?Q?8klcYvrmIClnanhrxxE9+rwIXfG+3U14o0RADfo4YTP8f8E1d2Z9f4pbbcEl?=
 =?us-ascii?Q?HgYMEVBWDv4Zdqlm6d0ceGcr6tJ9agQVfsDgiB5ul4MXqPa//Z+b84ulnY50?=
 =?us-ascii?Q?PFmE6qE8EsSrHOQQoM808w7VGzORHIF1s9GORUNOR9lMXbjY5Dn5U4Ad2zmZ?=
 =?us-ascii?Q?tvVDn0KpGom5wPpilyYrkJ0HyLKxzeqdzHe3+S8GJNoeTkpA1ufLTmnL3DKF?=
 =?us-ascii?Q?X6eyepP0j89dN7HzRtL0baMhJKrv+HtrhFDaRZs5cQqz7np0itN6iHPQbhGz?=
 =?us-ascii?Q?3N0t1eMWK3Q9VZCKVsIKf5cuieaCSOh5SWvQvhTRd5lMH0H/T8/wHAUP2A0C?=
 =?us-ascii?Q?IxWaU3tw5H32DSvbKx92rNMDCfUYmf2ZD/+dw55gPG9W7ejLcNDzlmAzcTv3?=
 =?us-ascii?Q?uTME9UDckh/XGjb0jGuVXvcLDjOLaeGa9o2r7ir4MG4+cBKjXPRueNl/ct2w?=
 =?us-ascii?Q?6BKM9ZiBkDXiM6lp4iHawg8QB5cISiO8F8JY/OFv3F4tm9SycAn6QWCVlU0X?=
 =?us-ascii?Q?wgG2TF29gtqRV0VN1MpexvCncXzblirMZNGOIUx9IchEVeR32crv18oCXpTm?=
 =?us-ascii?Q?X0ZQUoa4ADqZD38i66fSoMpWyPUSEF5/uMf0fEMx5n+LAK2mRpYd3OXxBGXA?=
 =?us-ascii?Q?PQsnqYvt0m6JzX9CSEWKGsOdRMC5w9g0xEDCYHBx8FmoJE7Vsd9JPWS0wreC?=
 =?us-ascii?Q?6Ybt273rfJWdGQsDggiP6QCUoWDzWp5fsIt7VC6UHS+dKiYKrbRLmoii8geD?=
 =?us-ascii?Q?Kz7mU6nTcSQfaMD2Zmq6q+RN4HWCac3MKiesKsic5h7B6Yzx3d2V0KMTIA+r?=
 =?us-ascii?Q?FO+JfonSNtqk+yc88lD+SMSYYtCwH2CsQz7FtmUbc92PcCpbY8uItDVr21tD?=
 =?us-ascii?Q?xIQicgR1DhBIRoIG7NfyPukEO17x+K0dr5uDaRCEiWlmLi/enJyBSQIpIIDh?=
 =?us-ascii?Q?XzOOL0lsTcT88c3O/Cz42mXKtMt7g70IcdV3eTan8aip/6Fw1X4jXTBcsywf?=
 =?us-ascii?Q?0SPy4+38WZ+gtQv7j/9sLxcCh79JC4B7z3OUIEBHQvTUtwACO95o3n7pUANg?=
 =?us-ascii?Q?oZztG9emlERfGokupJAOBiG3N2K62R8zUgas2kc2mOH2INx2jKz07dtg2k78?=
 =?us-ascii?Q?pq4OhO5BOXP88KrqaG5N42/JHAErFaiFD1jfRM5l5fqwq/QFOLUl9fy3WEbC?=
 =?us-ascii?Q?UARtSNonlU/ZdZFIWmHLa422IhxRQPM1HoCRffaV4HLI6vtkMJXCmbKVsQJE?=
 =?us-ascii?Q?vtrxnvpHDlEFYOyqmfqF0WOEhPKwXiwIhSB8QK+QyEaO8KBEn+geI0UltqWA?=
 =?us-ascii?Q?EGQD/XvaubdhnLXuJkFVwG2ECcjwEakPepAug60jd/4PrRLldGO29YcDsrku?=
 =?us-ascii?Q?ugT9f9xR1CWGkeWp6+ebiu5B/F6VgMaMa3QcV6QaWFuNWrc8sJgHWi4OEw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pzu0Aj82iaZFNKJNAHe96JZgQafxAZHfYhKx+V0NwmatHVpAs2hDK2bmuNTK?=
 =?us-ascii?Q?Vbl4Vsx6cAcpLtvocVtt30TpdMs5zymh/MQa4KR7Ajc/Gb2ae81bOsKMUTZ+?=
 =?us-ascii?Q?wzbBMsJgA7VJIy5oVYTmcEdeg6gf9R79aTGOkCJZZV4chZI2gXI9fpSY/TtR?=
 =?us-ascii?Q?5g7gf3E487jy5Ap5Gam1aW13iA4GwKVlJ5/F/oVfBZzkLf3zwVRZKcAo6Sea?=
 =?us-ascii?Q?RmT8mgWwUOztFFT6P5BF+K/uJgNE0MDf4ND6tESH2jjwQpMwUiQQnaSZU9tz?=
 =?us-ascii?Q?cl5JwX7VJeM2QIVXPQN3BBS/gJsMRN8DstVVrC35RsoCYBU2ieSbxjciMLGv?=
 =?us-ascii?Q?Z+0peGSrevbLiE0edM+OwZm5qFGO3n+jY1opMPefnsKrjL0wpUphk01bY+ip?=
 =?us-ascii?Q?b3xNAA6x6HBIIOko8d8eQG24GOqfIQSOyxjzht9WZ3tGK0SchWc/aRInWQ+j?=
 =?us-ascii?Q?/z4E96CgSglrRKTo1NQ7vT7sXMvWnzgjV0nxt5HSZAzWYlXhzVThLVBgFRy9?=
 =?us-ascii?Q?yiiw/io+82NFkXM7BtEs4xVqEAW45UktLAFOLsVfJ5xjsw/xAuWxd8T8duFt?=
 =?us-ascii?Q?IVZlJioM66kzFAFzjMRNKH+u5fXMY/FEwncjrhz0lrB5/fiv+N0fsB6MyOgZ?=
 =?us-ascii?Q?WLkaZ+X55KpIyU+yJcHvRWShA/Cc55Wml0wbJfdh7ZdqZzvc5i+DZDxod4iN?=
 =?us-ascii?Q?OC1fWie5nPmnBqW1A/swNzvFgXzhW3UT46i2JzguDScOPpgOs3EHy6sqpg//?=
 =?us-ascii?Q?F3bqxKI0iMm4NsaMu28lj9XwKDzGye/HxJTAnCFM10X2XANy3wKuEDCKa8ry?=
 =?us-ascii?Q?hMSJVZSl5tRxlgMew8Fr0m3olKbGjepY/l3r0tMDg1Fy77D8xmBiOR/nKNyg?=
 =?us-ascii?Q?Mz9LmgkvObLYx0yKBdDFbxWTCYBknCbytUE91MtSmMy0+tv8MhZzvzQAuiW8?=
 =?us-ascii?Q?1Q/1UglGf/C73/9j1hzCJptlNt5Byun/23GNtZsOJKhpubbNn4uozRfioIkD?=
 =?us-ascii?Q?bbaD7PK2dU8D/bqtHww/zj1i8dKP1dI+mWAwiQhBm6OpXjCqyCQdNB9KEN9n?=
 =?us-ascii?Q?QqtBNtJ6rw+0wAB3w4apQo9wVHNGcTBB7Bq7xcsiRO9V3yk2+qsHd7RKUz+u?=
 =?us-ascii?Q?3qjk+St+80WEVSEOl9WOZZokY4utz4VM+1Y4zbvfHuUKlQWSpTw2HFUDM0Qf?=
 =?us-ascii?Q?fZlOaqni2gp/T0ysjG+sk/W/Fi//E/BWDhuVcl8f81der8YCKvXnRbXXGpsh?=
 =?us-ascii?Q?qHQiJqu7bCoc0tava84JCxNDL5G+5rvg/JzAUp7UrZChkrza/x9ChVZlcezn?=
 =?us-ascii?Q?khV2Yp10YSM5KLxgWX3qjgLilVdv2z3Ljrm6Q2Tb/+m70enefrhmWcVbqJ8k?=
 =?us-ascii?Q?s2McEpfTiLP9R6wzbZssTtGOjZk5XRzf/sYBtOXCmuLNuCk6s8W2OfsjAh2k?=
 =?us-ascii?Q?Waj+fARxJXbaePpc7Aj9TnmE5WdthQzSe8LOkHeVRUl4LNiZ727mKUW/n4wB?=
 =?us-ascii?Q?vGChc8rKDqnHgoYepYGylnaHpBjMx3skUC0crTOxAUt69UM2uAUDRS+mWsnh?=
 =?us-ascii?Q?Zzr62HQNl6ucAVpTW5vVPx3RDrz+F9C/1f+nBkdF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0143f32a-f57a-4608-43a9-08de120419de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:16:35.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+di9ko3Te5XTmRwFlpZxSGYxH+MTphgE2dtSOh7U4u7tgsKL+A2TqHjc5NvsNnIO3vbELpOziiOfhcHGQZg8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11331

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
index aae462a0cf5a..88eeb0f51d41 100644
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
@@ -3350,7 +3359,8 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
-		if (!enetc_si_is_pf(priv->si))
+		if (!enetc_si_is_pf(priv->si) ||
+		    enetc_is_pseudo_mac(priv->si))
 			return -EOPNOTSUPP;
 
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
@@ -3691,6 +3701,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
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
@@ -3710,6 +3727,11 @@ static const struct enetc_platform_info enetc_info[] = {
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
index 0ec010a7d640..a202dbd4b40a 100644
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


