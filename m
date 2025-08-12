Return-Path: <netdev+bounces-212857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D611B22442
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04281B65C59
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BC72EE5ED;
	Tue, 12 Aug 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aD0FklBH"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF42EE296;
	Tue, 12 Aug 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993313; cv=fail; b=YTmTGY9Z/rDULMLJi6+iFDcF80hxME21v6KjkRM1k5JYV6XB4pMd0ZdPtmwjd6/2tnd9E7s/rbmVYNyBza7tnDAuY2LkpF6jXTAC1bM0k/J90XY/ppnYS5gTDSTsP8QcZKSeg9m1T3r1La39fRT1aIV2cHAxvQoNuAZR93NaDK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993313; c=relaxed/simple;
	bh=Xi0r0pe7l5Vn2x8SoWTA+2RNPK4AnqIRLCZCSHA6IRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzn24tq+pUXLJtBHbJ5caKE+IHgoRXUyP9x095BjK72B+BiJLoTR7zZ8mgr8SuiSVw7V15RGjS3n/J8z/7c2keXgy8Fd5J3CEVrrN+oxAAOHyymbRmZt8NcwLweEbNWPImsvd3t5jjRQurXJmTGsDtHsd9Hbro3r656qHPNZ9mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aD0FklBH; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSlBhRZumOgRGHU4ehhYtkDB0+vEitfzFDSFr1ZX3rr5MF9ca/IZhKo/q8gRor1UTFD27Nm/VLskaqOWpqMHAJMdS9W3kg+IyPj8nLQ9OzSnY0p/bWvK/09tFE8J8jpR/sNLYGbDHyQhbeY2V9T8kfWQcRJ7xtzQl+uMAWPKqgFyB9HGewfBMGkcfZl8T/iRk9/HHQBI1d4PdT2nn1G5MJaKwkiBUHQoaRNrlJvcZ3q6ratOu1mRhSimEPStBfyQ/VlWoA7NHbSPTtCNGo+l1/OMOekxypqZjoAt30PxREeIQFvN0QK6FioifRS9nsqs83Cv2E6+JSPoxlTyC+1/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1dLOtp3xYDDulsUHxKlwtgV+mwGFduGxag5AdVmBrQ=;
 b=JCMQWq/cCPrvavmDf8EXMCoSQkL8YXWUwNxUf7M/jGFuPsHka7vKEW/wDR7FT70VU2P/b3oGYBbKJrsmZNI7R1hEMhvT3OxDc6aYP3CQWFjiIHX8BjRpgcBPZNY6V4pRd7ySZcRCA5K7/YiXDScc0/n4U83KxRkQNYao+2+6AXqO7Clva+pXzljA8zbfvEv0U4ZcftVqKiq1MamKfC7QriMAztWPUc5YdVsiviRA4dRyuvvsHnvE/+TExPmDf1c8YWvnysoDqP8nCd5LwkF+G4pJ45tp0aRcaVHqiz3TCrSbs7ZGL/0m1aFnsQ2KnSJkwEh2jjBRm9Us0lWulGwr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1dLOtp3xYDDulsUHxKlwtgV+mwGFduGxag5AdVmBrQ=;
 b=aD0FklBHG9JFY0SU1VKMP3Qz+9Z87Ml+aWp/hQUFz3217mir869x6HpdiPUIDwI3Jq9mu/sUvFTp4OxEX34gXlgT4JLG9fsoSD3Kr2TWQNjIe+JLie9BelREds2bqu6xAsXBGUxmb1xuWK7mxboI9NbuCsc5xkHnfgPByfij9rhIl+xEE7ncokXKH5IvGKnqprHiVzDV5ywVJCQh3xF+k2OR3jYDOJbxDpGaxFTyIG56rLTPApSDqNGqOd3DRGNGsQyN68zwmgbM55gLkkZ50SzjcJ75IcPs3oYoWVyWThBWPKzTiPxVJb5nSQMwgXGG0AIDPeD874hXW+kziHeQCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:08:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:08:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 net-next 13/15] net: enetc: add PTP synchronization support for ENETC v4
Date: Tue, 12 Aug 2025 17:46:32 +0800
Message-Id: <20250812094634.489901-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: f13fd9e7-1ed2-4e07-69ad-08ddd9882ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXZ/cIHsOJQ0TJAdK8r5mv/m57PuuwUQrVtDdQE8t0O4Ov/ESxX8fzDtAAAa?=
 =?us-ascii?Q?q6PeBsD0rgzlOwkg14VSohSjCFxr9pa9QsSVZUF8V0GeTNc0/kThPYqp1D+8?=
 =?us-ascii?Q?fjpAud4yyqNJhnIzphvKPSJYnO5Zp9YDHOVl+jhS9hDr8herOFM2YDBuu41/?=
 =?us-ascii?Q?7TbvshzaR39IL6/NGz4eXEJzFHlJNDIpZ2KEUMiBdzo+jWOC9fIpTqqicJyP?=
 =?us-ascii?Q?uAAMAEFBr0C4XOQRJ1uM1zrEsU+Ar28rpO1zxw1hR9UBcQrImbQp0YE/qx97?=
 =?us-ascii?Q?GvQcaBus3DLWyrWoaaceypgovmxd0K6sFkiBf/GIIPH2Bz68EaoI6fmCY1cG?=
 =?us-ascii?Q?Zi3GWi0c8x9o2yfR28Gbgd5x3f9pMWq3U1tUM327E23rzqqb3NZ0PNPyq2OB?=
 =?us-ascii?Q?dEjSg9OU4X4QI2vGvvFps57KTnL+57kSmY/cbvZvGD0OGFlGRnojqHHNYkLm?=
 =?us-ascii?Q?wWMLdxfAeZoTiV9+arp7jBXrEe6mV1G9P+uz7gI78KnIxPtrBvcbHpVHsrqw?=
 =?us-ascii?Q?M3fFvsPkIwcmHwxumMhIcWCaIUkLq5cbre8Dgbe4EljnvAeNE/nhrsRxVH2T?=
 =?us-ascii?Q?ey98yBwkUi2WDczLR8Rf0uZFdK4hDytBafA5GBj/FqCnKQPgDilavXrElROe?=
 =?us-ascii?Q?DEp4RQFKSAtW2ODZnXsdfAxmNviubNvg+8XDsO5DjwisdjpxVccGlEKuq3uU?=
 =?us-ascii?Q?TQ52g/47n2Phr/JTsButs+vQma+U0g+QD1HAtT7+iejLp4QdX4HJaC7lO0kK?=
 =?us-ascii?Q?E6IneiOBhgTClHjTNeg6e5xECM5V5W+LsAHUCh6gBvLXV3uI1vP6aT6Op7s7?=
 =?us-ascii?Q?hm2WL6+m6/r6tMxxAo+LpvRv4leENXxFeOsTXkDY4oxkHYxf76TX9OIyjexL?=
 =?us-ascii?Q?9HR4QFL3ntv0QVOpfu3pf0nljZKMm4OjtLceB5TJOfu/4ZpB2iugz/UwonvO?=
 =?us-ascii?Q?CLWny8NGSwHHf/Rbpfj2WZ5AUgBE1kVsOHPrbRpnIjd+1S+QuCtkVptlRZ0f?=
 =?us-ascii?Q?ziDCiqDfk1EmgHclAvej5cJBDpjFaj84LE55REa8LT6+PKukK/R9IcCMJAO+?=
 =?us-ascii?Q?cBXQQfSxF2nvwfj6JR6CHNCwVQweyrVS7tzeLb26SyZ4J6H2GGner2kN3IXv?=
 =?us-ascii?Q?o5TMRLvO8D+uO/YXDM+zMbP8wNcT6N622JPl0h0dCJ+Lqgs0gHqVZ5zs5WoP?=
 =?us-ascii?Q?B4rBEQEdlxQNgO1kpf96WtBhZNAQG71olhawtYTnwDiW+kOAUEulFkSbnLx8?=
 =?us-ascii?Q?N9dGyNA6E1aQwGEsu6mqOC0muOCLNDwATXaOtRyivTD4dejaO0YFCD+Jy+LZ?=
 =?us-ascii?Q?7ZUgp1IlaMpyf8aluf6U2ELw4iXN9Zb3Oeb7RernaOUs6CXniJqtocsddWEX?=
 =?us-ascii?Q?x+oHZ6Z2s1ZzTSuSmbqDom2rjPboSu+94oFtJ6E69Sj79vs4928h+GY/UDWE?=
 =?us-ascii?Q?00UudFiK5AH8VDjQX8dd5rGhWiOD2SMBcY2vl7ev+YjXLzIM/7U8ABlO/Jxr?=
 =?us-ascii?Q?v0QGhnGyBMlMTUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3qUkMxcaNJNYQuxFmd5C8gsaYMEc1ENOwhnOV8IMPnblqJf4Gtw1LoOTdUN?=
 =?us-ascii?Q?f41JeQU/yrMDnSyJRHFa7aeJtghutHz5sWJjhhuMFRW7ss+jTrmTpoXl02TR?=
 =?us-ascii?Q?9NCPcpYgqz9J5xk6YR5j87j8N2lDuOF1qAfUMH3hiI2LuTResnlXoSGUj50w?=
 =?us-ascii?Q?gfoDDmP90MEXWvWr6pqMZpzItqaVdavZ8RXwOdrhkXbcUuihmo+mZjzTMmrq?=
 =?us-ascii?Q?4wlB5ddbCIug0rtHtj5I+mJB2fQU15jppZQuBOrMAow2mSJRsyhFmBvsLyAI?=
 =?us-ascii?Q?wrQuIkVI3a8yMlDWQ1a8RHEqkRunAfiwM+XNWFb9w46kg0+tXGrV5CkmRBWy?=
 =?us-ascii?Q?yVsMW77aNA9myamb7yulsmsLwGzySNexQ7z7dWxQ7wH7ZcaG1t2G5PGcYsvR?=
 =?us-ascii?Q?xc4kNu+8hadX85IcxKdpf7PMfqhxJ4m+79jItLvewwZdO9/SPUB5Y5ECYZPM?=
 =?us-ascii?Q?tpw8DMccoJG5ua4S6TZNY21FLr7OQqXgp2g+dOSrGu/AQ1jjUMYK05nCIlcq?=
 =?us-ascii?Q?2Bbm5k+rDo0h1It3zY5jVj/9TY2ffzvrMuRUrFV4Z2zNp3WeX3rnuN4r2JoR?=
 =?us-ascii?Q?iMqLLjgbzubFeW1x6L943gg46M50n8jWlcAe7iqmGwXhC4J1gHW72A6kU7w3?=
 =?us-ascii?Q?pF0zuLESn8vI20xWoQ89zjvDEpQ/gJG+ZW+4o6V/SIcyq4v69DOLZvPu6rEr?=
 =?us-ascii?Q?jdYF9XO5UMXXQF9p9EjB8+17FReQm+ZPgZa7mxHzPMxY9CIXjEM2JnvEBYDi?=
 =?us-ascii?Q?5/p0W//6zpkbeQSzmBxgXfF6R35on6iN2s5ifXrQp3AfpIqGNLSs3x6ujB8W?=
 =?us-ascii?Q?xdiQO+z2L35efadO6FBJ/WP5LQHpFUGfFwpCflfgyaQH1Q7Gy57H2DaTBFxx?=
 =?us-ascii?Q?Ke+j8QFyUUDOk6+7+sOFXWISwSpjZsX+4FH1sCHTVQ70vVqiEH/FCUpzwuo/?=
 =?us-ascii?Q?Z3LOpZRwrgg9Us/ekx+I8RfSQ96nXDmxuPE/M7Jn24CLsEa92AqkRiIx9IE2?=
 =?us-ascii?Q?ucToWXe3NDExSE61jizPSH6uiv+E25428k/IGAXfCf2LQBYdbQLQ8qyjsR+t?=
 =?us-ascii?Q?92Ol7yM+ILpoSWUbGyP96fjOYzNTkeGcM8651n4n8SPhvLAwdI5agM1XFS76?=
 =?us-ascii?Q?5gdtdDpe59oKIVbaOeLknJ4hvbMLGuc33F1bRidxUYLAUjsyNDQcY/rQGuVT?=
 =?us-ascii?Q?BzLyeN1/VNLfOo0HyDhLyG4pVg3yTD/2LkRyfr64IZSeRydIoncqCIN5QWK8?=
 =?us-ascii?Q?8GsnpdBl9fRDQ9DnJ3gNXIUf7QXYUW4kxPl2io+otb02DhM6s4nLKDLB0VVC?=
 =?us-ascii?Q?euT7b7Mbe8EZBHgoYDMJVEDVtFkVGku6FUAlDGovtTR1jR4VHLsLaFC3ECNy?=
 =?us-ascii?Q?qJXv7ptxThm7dbTse2DlonVaieybl+fTkB/M9J/K3TkSrQXSHInyVYCa93K+?=
 =?us-ascii?Q?aPnI+A7vEAIYFwxESoVAAIOwIDcwTQMBFMV/ybu+4fA+xZimkVvyXQeJq1BW?=
 =?us-ascii?Q?JhV621AgbOP6unjhfT5TnCGUTRpAeztT+eOWeavJHJ+BIcqMwbcvU8QpI8oO?=
 =?us-ascii?Q?AwQZ4i6WWefh4xWJD7RS/aOvq/ysItsdDu+4bi6O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13fd9e7-1ed2-4e07-69ad-08ddd9882ec2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:28.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqv4QewoBm4/8K69fwEya0QJni5xalw4tZJPfiw7lGpeFqHeu0aJkbhbB10Sqecyz65mQhR4G8v/dJbwBe0Qsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
mainly as follows.

1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
different from LS1028A. Therefore, enetc_get_ts_info() has been modified
appropriately to be compatible with ENETC v1 and v4.

2. The hardware of ENETC v4 does not support "dma-coherent", therefore,
to support PTP one-step, the PTP sync packets must be modified before
calling dma_map_single() to map the DMA cache of the packets. Otherwise,
the modification is invalid, the originTimestamp and correction fields
of the sent packets will still be the values before the modification.

3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
register offset, but also some register fields. Therefore, two helper
functions are added, enetc_set_one_step_ts() for ENETC v1 and
enetc4_set_one_step_ts() for ENETC v4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
errors.
2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
Timer.
v3 changes:
1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
2. Change "nxp,netc-timer" to "ptp-timer"
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 92 ++++++++++++++++---
 5 files changed, 135 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4325eb3d9481..6dbc9cc811a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = ENETC_PM0_SINGLE_STEP_EN;
+
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
+	if (udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	/* The "Correction" field of a packet is updated based on the
+	 * current time and the timestamp provided
+	 */
+	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
+}
+
+static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = PM_SINGLE_STEP_EN;
+
+	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
+}
+
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 				     struct sk_buff *skb)
 {
@@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	u32 lo, hi, nsec;
 	u8 *data;
 	u64 sec;
-	u32 val;
 
 	lo = enetc_rd_hot(hw, ENETC_SICTR0);
 	hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 	/* Configure single-step register */
-	val = ENETC_PM0_SINGLE_STEP_EN;
-	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-	if (enetc_cb->udp)
-		val |= ENETC_PM0_SINGLE_STEP_CH;
-
-	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+	if (is_enetc_rev1(si))
+		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
+	else
+		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
 
 	return lo & ENETC_TXBD_TSTAMP;
 }
@@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	unsigned int f;
 	dma_addr_t dma;
 	u8 flags = 0;
+	u32 tstamp;
 
 	enetc_clear_tx_bd(&temp_bd);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 	}
 
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		do_onestep_tstamp = true;
+		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
+		do_twostep_tstamp = true;
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		do_onestep_tstamp = true;
-	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
-		do_twostep_tstamp = true;
-
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
 	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
@@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
-
 			/* Configure extension BD */
 			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
@@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
@@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c65aa7b88122..815afdc2ec23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
 void enetc_reset_ptcmsdur(struct enetc_hw *hw);
 void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
 
+static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
+
+	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
+}
+
 #ifdef CONFIG_FSL_ENETC_QOS
 int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
 int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index aa25b445d301..a8113c9057eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -171,6 +171,12 @@
 /* Port MAC 0/1 Pause Quanta Threshold Register */
 #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
 
+#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b3dc1afeefd1..107f59169e67 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 961e76cd8489..b6014b1069de 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -2,8 +2,11 @@
 /* Copyright 2017-2019 NXP */
 
 #include <linux/ethtool_netlink.h>
+#include <linux/fsl/netc_global.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
+#include <linux/of.h>
+
 #include "enetc.h"
 
 static const u32 enetc_si_regs[] = {
@@ -877,23 +880,49 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc_get_ts_info(struct net_device *ndev,
-			     struct kernel_ethtool_ts_info *info)
+static struct pci_dev *enetc4_get_default_timer_pdev(struct enetc_si *si)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	int *phc_idx;
-
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
+	struct pci_bus *bus = si->pdev->bus;
+	int domain = pci_domain_nr(bus);
+	int bus_num = bus->number;
+	int devfn;
+
+	switch (si->revision) {
+	case ENETC_REV_4_1:
+		devfn = PCI_DEVFN(24, 0);
+		break;
+	default:
+		return NULL;
 	}
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+	return pci_dev_get(pci_get_domain_bus_and_slot(domain, bus_num, devfn));
+}
 
-		return 0;
-	}
+static struct pci_dev *enetc4_get_timer_pdev(struct enetc_si *si)
+{
+	struct device_node *np = si->pdev->dev.of_node;
+	struct fwnode_handle *timer_fwnode;
+	struct device_node *timer_np;
+
+	if (!np)
+		return enetc4_get_default_timer_pdev(si);
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np)
+		return enetc4_get_default_timer_pdev(si);
+
+	timer_fwnode = of_fwnode_handle(timer_np);
+	of_node_put(timer_np);
+	if (!timer_fwnode)
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(timer_fwnode->dev));
+}
+
+static void enetc_get_ts_generic_info(struct net_device *ndev,
+				      struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
@@ -908,6 +937,42 @@ static int enetc_get_ts_info(struct net_device *ndev,
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
+}
+
+static int enetc_get_ts_info(struct net_device *ndev,
+			     struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	struct pci_dev *timer_pdev;
+	int *phc_idx;
+
+	if (!enetc_ptp_clock_is_enabled(si))
+		goto timestamp_tx_sw;
+
+	if (is_enetc_rev1(si)) {
+		phc_idx = symbol_get(enetc_phc_index);
+		if (phc_idx) {
+			info->phc_index = *phc_idx;
+			symbol_put(enetc_phc_index);
+		}
+	} else {
+		timer_pdev = enetc4_get_timer_pdev(si);
+		if (!timer_pdev)
+			goto timestamp_tx_sw;
+
+		info->phc_index = netc_timer_get_phc_index(timer_pdev);
+		pci_dev_put(timer_pdev);
+		if (info->phc_index < 0)
+			goto timestamp_tx_sw;
+	}
+
+	enetc_get_ts_generic_info(ndev, info);
+
+	return 0;
+
+timestamp_tx_sw:
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
@@ -1296,6 +1361,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
 	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ts_info = enetc_get_ts_info,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.34.1


