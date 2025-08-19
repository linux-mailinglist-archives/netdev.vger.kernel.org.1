Return-Path: <netdev+bounces-214954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68591B2C492
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18194727112
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A4341AB5;
	Tue, 19 Aug 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LT01936V"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357E33EB11;
	Tue, 19 Aug 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608351; cv=fail; b=gqTgKvp3+S3tpBusXTlJEmsr/1apiN+AMi+b+wUxKVZlKzoT4tuBjS6x0IU0C1NTd7h/+Tewi79d42Oc6W/6ylJC5mBKkOgHbOi5Vs0g1Wct+TsZlVBqMh/h3h4DPm+wZwNIMM/3uSno82u3nnlqklX0nGP/wLLPq069R082wlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608351; c=relaxed/simple;
	bh=xo+uL/dex5ptGaClN33t4/wC+lag2NqeMFT4HMALY0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hIYbCn7LPY88Li3zTYKbNjqor/OGWH09b/Ekd2PTt4e7lPltc1ZPTlgdisCxkExsLUBXhElGwF0GWGvsRL0+a6Hgtb7+M3dey0NrOgViyCr4RG73CDAHPuHUeWto5viT+qPkkmHCPoISoN2lwN+U46mfnR+pfdHP0lfV4Tyaxrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LT01936V; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN7bok65nmaD+WkWTYPpOrvszJ5yvaNTTXsrzKalyZ5nv2lIG7XcU3gc1/oexNz5/c3tKFUBIQ2hM1cZ2x/eyGTeyl5uF480gCv2XJB3t2Eg1Hwp/m0gkKhzPSVVwnxnpFjHu2ge7FNFf+POoSBNW6zi9Vv/+fg4yo18jlTJumGlMVr6mOMMdojDp9jJ1mvh7qzcwZ6InsbItaxaRzVvi52ls6PZb3Y4KkQzyC+uFZIVVNpGHllIXIccg15vmk9T1QTHKhmVo42D7YtGl/vLDlBEeo0fs89TAToxLREbbFphTNUDwqNCfmevmLVkDe1OUhJnw9eS8QzKUHhSDllXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1wsEmx0azJto30Z+vzS1zqIcsPgbrpABWolIIYU8aw=;
 b=ep1PCkJVZE4LxpQPENuWrez/pCKZJCe/ajwQg4OcMzBH/tSwgreynj/qR4EwF8Q+3aarrKsBbQUUGnM1UNpcZS6V/ZmbixP403J9sx3Mn8bxtXOhuz/EH0nP2nqCOOKk/GpGtOa9mbZj2cVSm1No6MBXfW0XVrW3L3ajzd9JYsF+ysLxeWXq14eQ20Mxr7ZlMpMd7LRLBHKn+AfX5zB/xJc0emXfwtfvvSpsG+GvqxVdbhAg2h5bOmk2Gv8YE1IbyF24BIbuTK/wmxuGT1OXHq3Nt6jqAPdDWP3KCZo9Pq9YB4skjsg45q2hk2UR6zVpY4wdm5Ej4RUW11iiH5VZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1wsEmx0azJto30Z+vzS1zqIcsPgbrpABWolIIYU8aw=;
 b=LT01936VuFGhfWa91d45HhSRqF2WO9nC7HpKsXL5NqAffzJtENXup0Iuj3NAs+qhYucdW8sv22SuDoP6GFhjALmt7bJIGO1c7e5VhgLzK6qqNnA7VFzrNwSraMjqQ/FoagDyU4Dph3FkxvdEkVdG4dgwnnAMcA2nftvVBBg04UhzbHWby9hXBspUaRIeO5x2WdbWMPa3arMzX63A4q4qXM1KFY8fplU2evM8x8swpW8Hy5bYc46qTmUtZilygyAL17+VhTc9HtAVjdyjXEFk1vvc1OdV3KIwSB6yphan+nDZ10qB6Sqk1sH1FH1k/EfHFlktCv72xtxGAMv6HYgvpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:58:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:58:35 +0000
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
Subject: [PATCH v4 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver support
Date: Tue, 19 Aug 2025 20:36:09 +0800
Message-Id: <20250819123620.916637-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3a23d8-c4b0-4942-1f8f-08dddf201b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EVj9sW5qnEAC0ZCDq0Hm7i5zVF4vH2m7s+b/wPrgpvNzJx0kT0gE5bn1bHiZ?=
 =?us-ascii?Q?xbChp3I/oKkc1X1YnoDwCjnZ1KlQmfwUTZGuytJHzT8Ub1uhT9CAVA24Jub2?=
 =?us-ascii?Q?k0aUyVmXan1GS0ilqxMxD31WmA4whjkicSLwDH81SOUm9vJeNOMtvni9g43y?=
 =?us-ascii?Q?NYDrgWKIpDFu9Z0xQ+aEEUhMx62veZOMTCK1X4m25emcvucSdbmia9ETADYA?=
 =?us-ascii?Q?W7jJSKtoqvQFMMAcHNHxjsk4M9slEq4veGfF0oYHGcqO+9glzW5Sy8t5GtF8?=
 =?us-ascii?Q?IXgwJpbFJqu9X0qcnc2EnDu/pN98mYiu/wOKfQ3DYSVCFpIawb05CKMY9Z++?=
 =?us-ascii?Q?s5RfIyMnMLU9FMSq2i7zyeESHYyFqZ8qpgSAR7jc0PKmqVt6pQey/fjeVKnR?=
 =?us-ascii?Q?6aDjiF11ao1qP6J5wED8xtqoV7RQe7yumbt2Z2MEOCzS0uqnP+FfHNvYYaGs?=
 =?us-ascii?Q?IhkW7lgux6Da/sOb0upofPEntUIjVkDykIu3CvTraL5Z+bgo9FNG/iZ5Hdkc?=
 =?us-ascii?Q?qjrpqKlsc3w+TiLoIRI3AE5D6V3rYcP75BFCMFVE0pHXVd+CY/wMpebmS/BD?=
 =?us-ascii?Q?Yn2EoU0Cmi2C4EOCk82V2gK/k0pO2xfl0fdYKcNGqcGXNuc65IHJYmnNUml7?=
 =?us-ascii?Q?I4aZIRsflBvcgomx4w/5kyMItw9ybna7ebtUYiOVjgFroLUvidr8P0AeqMfg?=
 =?us-ascii?Q?x57ZQd2McKZ3hdgv9fs18JeoqPw6Ur8Uo2oDJQwBAHZx9qZr0NdpJNyG5/QJ?=
 =?us-ascii?Q?Qm+KOQW0ApKcpwSAFl5Eo/4XFn5ULWl24P1uJSvOPmMK9007u0xB/cKPJ2GC?=
 =?us-ascii?Q?fREXN225g8XO+mp/QTElQMSW0a/Do6kCS8AW/9o2c86Ao+QzrhE93RqlSmAQ?=
 =?us-ascii?Q?KJmG5zmJlf2Lfcdf6vUrI2212zMg4szZJ57T68Pfpi3jED+IIImtxqsTUIoa?=
 =?us-ascii?Q?8c1qr0BJ/X+g2Qd93HtzInvmjGcyzoqPfm0v7EACSjK2x/HLY8GOnVh3SBmU?=
 =?us-ascii?Q?4VoaqmS9n4Fu0JNaz3n7n+TsxzdErXizlTlq44daLsXp4A0EUPanWxFvNKvD?=
 =?us-ascii?Q?kLARNjUIe9oTUw1HRtH93pxHe6jOlk6cH1HXhFTVIUsEdq5bYrJ1GnkE+6On?=
 =?us-ascii?Q?3hhLR0FJBhUhvA6cpIsPDpHYzEdOV/SVXE4lLqzUyPNn9auIFsk0L3nyWnX0?=
 =?us-ascii?Q?e6mezfLF258oDjSDRPdQj8b4fr0px8QIlHruJMbpcgYIJXfSCxfD8jyOVk5L?=
 =?us-ascii?Q?XUFaFTiuX3r+PhY5hxtFmnJbILXTE+gRcLn31H4455UhcjgREhJW/5XJO4sg?=
 =?us-ascii?Q?PtH9wFf0vokfn4iKqsNPECOIz/yvKIauayg/PlZF04lCvNIsx6LuVq8/yWG/?=
 =?us-ascii?Q?i3Ic0dtEFzxruOKjloYaOkwO9VdtHL4N7AE+ol8vQPp2+6UpcudTp4oVPyQT?=
 =?us-ascii?Q?Y7RmaFL/7DfNWgVbyKAzyugVftiw8lIv3EQK4m0ROesQjkxIfrd2TzLhbKje?=
 =?us-ascii?Q?Xh1vonUKCmXu4AI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bk8icvI0j9S7226in3U1b6ROItT/x2pdQO6M+9Rs5wBHY0hpE0Di9krtqmcL?=
 =?us-ascii?Q?d+Xzyw6eItaKlGPHjt2YuJhDYIbqDgFasr6rmAB9972gPF2nHVis2DKihB53?=
 =?us-ascii?Q?OW3qVkvNVutHd0uxzt4hhCxRO1qbYPwG/iJTeZ2zePD+d0fJ4y4Qxv2wX9TD?=
 =?us-ascii?Q?BBbhZScTd+W4xL36YSvdA180q+S7XLXqLrkXx8zezp4WjyulF13xgMl2uuMW?=
 =?us-ascii?Q?imiMyUQrJ7lFFnpbop6rCek2iKCmO7n9yjaWt2aOFPmWJ4UYfTF4H4Ct15eD?=
 =?us-ascii?Q?ozGd5w7J4Dllw7idcYS/y6cQza3ah9F5ApDaA8/ncVgnob9l/DfBaCRRyVXk?=
 =?us-ascii?Q?TsfNx/2WnIiMCbJ24dlT1VJeepC9CtbmJFBTT/5/P/Y3xwvkDMVePDaScaMV?=
 =?us-ascii?Q?eT7cUtNqeojwwMbeZSAKt8ONqu9s4Axb94q32MAlhee7LtVLnsQ/QTuBH7XP?=
 =?us-ascii?Q?yur+Z1ZJXZ3OVCURDt46ByJhIGPzax7IK4F9f3+KyJOPLR2OqrJ8qkwMlIbj?=
 =?us-ascii?Q?MruCpcGr6X1XYmu5y9P8FU35vDlXV/ahl/TAyP/qr0qgGiKXr6Z9JrnylBJO?=
 =?us-ascii?Q?TAEbf6aniIHibOjDqaF2YmKFGk7j3fZq6kiDr6gKDUGfzOn6uc1adKHpRAoU?=
 =?us-ascii?Q?Vbq3q6Ar/xFGzoJ0+Fnnb5XLu8aAArWQPFdnMnjwyUHxeVDReguIp4QOZITt?=
 =?us-ascii?Q?DykfnLYoK5UELyUtK7x2AJNHOTtJnAe2GF429xZOidNbBNOBEyP1KKNB2ard?=
 =?us-ascii?Q?dGiAK5Fe+Hz0PvePnlnWNS9T8zjffGcejf6PSmSa3Qf95Tj3l01JXrkCsICh?=
 =?us-ascii?Q?n+4cAxNHAjXol+KEIaWwRWRge9AgCphIRBg2dmwexG3CcTvFNsk8KqQrOXcK?=
 =?us-ascii?Q?nHVEzle2H3uZvp8pRtKIUMo1ZPzVie/h+L3MTncyavLN4Ph+ZsMGs6i9xUoq?=
 =?us-ascii?Q?6kbq9gcjZRen0l6SpjWI3t+nseoMsoZKuRggnZPZCDY4amwPrRQFpgympjyC?=
 =?us-ascii?Q?wPqABNRdIEXJPe7wxxwZnvbdrjV+rk/f9TW+FbdX7WwnI7KWhvCboM9VZYac?=
 =?us-ascii?Q?8CoNVbte1aSNETwK5bSMj7CANJwOoCY2fS0wcEX3R+HEye8rYoQT08/Np/EL?=
 =?us-ascii?Q?HjuzHPP3jTc/XKAL2uq/BuYEXZDHJWyYKby+oSqlbVDtJnKYVvhNfX2+ZiYh?=
 =?us-ascii?Q?lIHB+LrUAcul8KVZPhgtAsXtspGv13L/GQnGAl6dXM985pJ8GOVj3USzO2pO?=
 =?us-ascii?Q?kQhDZ+VcjR32q+OJri3QLUCSXWiANokGcvaoSupTZmwelNgyODzwdnJ1dGLq?=
 =?us-ascii?Q?f3RZ7jV98oKZSu26+U6oczl9jUzVKfaAEjFdV63UOuRPiepHS6AYXEOj5Vsp?=
 =?us-ascii?Q?TFtLC1ePgfj5G2yK3qyWb+gD8f7E3PKZ+8xsijoGClDrHh2zYHUivtq5J9aZ?=
 =?us-ascii?Q?8WKSaT2oEsLCKoraF43yWI6q/eZsoZgA0aE4DLezJIT3EoUwa+w4TKqf3D0N?=
 =?us-ascii?Q?i3N1X0yWwtrZRyddyILr9B9XYwvQK6kkiVV6Q7u++Rnm2EXEnAHqtkDGbnBb?=
 =?us-ascii?Q?4vS3CyVC/uShxwO7LlgdJQUSufNUSr5cisQJrk7r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3a23d8-c4b0-4942-1f8f-08dddf201b87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:58:35.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dAWjOMVPSczY/gTcyRSxs4/q2F75iBIRXThwO0EdearbJ8AqnSJnJf/NFD1CVTAvZd0B9Zzl3yLMT9d67Qdaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

NETC V4 Timer provides current time with nanosecond resolution, precise
periodic pulse, pulse on timeout (alarm), and time capture on external
pulse support. And it supports time synchronization as required for
IEEE 1588 and IEEE 802.1AS-2020.

Inside NETC, ENETC can capture the timestamp of the sent/received packet
through the PHC provided by the Timer and record it on the Tx/Rx BD. And
through the relevant PHC interfaces provided by the driver, the enetc V4
driver can support PTP time synchronization.

In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
not exactly the same. The current ptp-qoriq driver is not compatible with
NETC V4 Timer, most of the code cannot be reused, see below reasons.

1. The architecture of ptp-qoriq driver makes the register offset fixed,
however, the offsets of all the high registers and low registers of V4
are swapped, and V4 also adds some new registers. so extending ptp-qoriq
to make it compatible with V4 Timer is tantamount to completely rewriting
ptp-qoriq driver.

2. The usage of some functions is somewhat different from QorIQ timer,
such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
increase the complexity of the code and reduce readability.

3. QorIQ is an expired brand. It is difficult for us to verify whether
it works stably on the QorIQ platforms if we refactor the driver, and
this will make maintenance difficult, so refactoring the driver obviously
does not bring any benefits.

Therefore, add this new driver for NETC V4 Timer. Note that the missing
features like PEROUT, PPS and EXTTS will be added in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Rename netc_timer_get_source_clk() to
   netc_timer_get_reference_clk_source() and refactor it
2. Remove the scaled_ppm check in netc_timer_adjfine()
3. Add a comment in netc_timer_cur_time_read()
4. Add linux/bitfield.h to fix the build errors
v3 changes:
1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
2. Remove the check of dma_set_mask_and_coherent()
3. Use devm_kzalloc() and pci_ioremap_bar()
4. Move alarm related logic including irq handler to the next patch
5. Improve the commit message
6. Refactor netc_timer_get_reference_clk_source() and remove
   clk_prepare_enable()
7. Use FIELD_PREP() helper
8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
   help text.
9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
   confirmed TMR_OFF is a signed register.
v4 changes:
1. Remove NETC_TMR_PCI_DEVID
2. Fix build warning: "NSEC_PER_SEC << 32" --> "(u64)NSEC_PER_SEC << 32"
3. Remove netc_timer_get_phc_index()
4. Remove phc_index from struct netc_timer
5. Change PTP_NETC_V4_TIMER from bool to tristate
6. Move devm_kzalloc() at the begining of netc_timer_pci_probe()
7. Remove the err log when netc_timer_parse_dt() returns error, instead,
   add the err log to netc_timer_get_reference_clk_source()
---
 drivers/ptp/Kconfig             |  11 +
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_netc.c          | 416 ++++++++++++++++++++++++++++++++
 include/linux/fsl/netc_global.h |   3 +-
 4 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ptp/ptp_netc.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..9256bf2e8ad4 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,15 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_NETC_V4_TIMER
+	tristate "NXP NETC V4 Timer PTP Driver"
+	depends on PTP_1588_CLOCK
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC V4 Timer as a PTP
+	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
+	  synchronization. It also supports periodic output signal (e.g. PPS)
+	  and external trigger timestamping.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..8985d723d29c 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
new file mode 100644
index 000000000000..477d922dfbb8
--- /dev/null
+++ b/drivers/ptp/ptp_netc.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC V4 Timer driver
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/ptp_clock_kernel.h>
+
+#define NETC_TMR_PCI_VENDOR_NXP		0x1131
+
+#define NETC_TMR_CTRL			0x0080
+#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
+#define  TMR_CTRL_TE			BIT(2)
+#define  TMR_COMP_MODE			BIT(15)
+#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+
+#define NETC_TMR_CNT_L			0x0098
+#define NETC_TMR_CNT_H			0x009c
+#define NETC_TMR_ADD			0x00a0
+#define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_OFF_L			0x00b0
+#define NETC_TMR_OFF_H			0x00b4
+
+#define NETC_TMR_FIPER_CTRL		0x00dc
+#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
+#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+
+#define NETC_TMR_CUR_TIME_L		0x00f0
+#define NETC_TMR_CUR_TIME_H		0x00f4
+
+#define NETC_TMR_REGS_BAR		0
+
+#define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_DEFAULT_PRSC		2
+
+/* 1588 timer reference clock source select */
+#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
+#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
+#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
+
+#define NETC_TMR_SYSCLK_333M		333333333U
+
+struct netc_timer {
+	void __iomem *base;
+	struct pci_dev *pdev;
+	spinlock_t lock; /* Prevent concurrent access to registers */
+
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	u32 clk_select;
+	u32 clk_freq;
+	u32 oclk_prsc;
+	/* High 32-bit is integer part, low 32-bit is fractional part */
+	u64 period;
+};
+
+#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
+#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
+
+static const char *const timer_clk_src[] = {
+	"ccm_timer",
+	"ext_1588"
+};
+
+static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
+{
+	u32 tmr_cnt_h = upper_32_bits(ns);
+	u32 tmr_cnt_l = lower_32_bits(ns);
+
+	/* Writes to the TMR_CNT_L register copies the written value
+	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
+	 * register copies the values written into the shadow TMR_CNT_H
+	 * register. Contents of the shadow registers are copied into
+	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
+	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
+	 * register first.
+	 */
+	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
+	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+}
+
+static u64 netc_timer_offset_read(struct netc_timer *priv)
+{
+	u32 tmr_off_l, tmr_off_h;
+	u64 offset;
+
+	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
+	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
+	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
+
+	return offset;
+}
+
+static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
+{
+	u32 tmr_off_h = upper_32_bits(offset);
+	u32 tmr_off_l = lower_32_bits(offset);
+
+	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
+	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+}
+
+static u64 netc_timer_cur_time_read(struct netc_timer *priv)
+{
+	u32 time_h, time_l;
+	u64 ns;
+
+	/* The user should read NETC_TMR_CUR_TIME_L first to
+	 * get correct current time.
+	 */
+	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
+	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
+	ns = (u64)time_h << 32 | time_l;
+
+	return ns;
+}
+
+static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
+{
+	u32 fractional_period = lower_32_bits(period);
+	u32 integral_period = upper_32_bits(period);
+	u32 tmr_ctrl, old_tmr_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
+				    TMR_CTRL_TCLK_PERIOD);
+	if (tmr_ctrl != old_tmr_ctrl)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 new_period;
+
+	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
+	netc_timer_adjust_period(priv, new_period);
+
+	return 0;
+}
+
+static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	s64 tmr_off;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Adjusting TMROFF instead of TMR_CNT is that the timer
+	 * counter keeps increasing during reading and writing
+	 * TMR_CNT, which will cause latency.
+	 */
+	tmr_off = netc_timer_offset_read(priv);
+	tmr_off += delta;
+	netc_timer_offset_write(priv, tmr_off);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	u64 ns;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ptp_read_system_prets(sts);
+	ns = netc_timer_cur_time_read(priv);
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static int netc_timer_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	netc_timer_offset_write(priv, 0);
+	netc_timer_cnt_write(priv, ns);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const struct ptp_clock_info netc_timer_ptp_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "NETC Timer PTP clock",
+	.max_adj	= 500000000,
+	.n_pins		= 0,
+	.adjfine	= netc_timer_adjfine,
+	.adjtime	= netc_timer_adjtime,
+	.gettimex64	= netc_timer_gettimex64,
+	.settime64	= netc_timer_settime64,
+};
+
+static void netc_timer_init(struct netc_timer *priv)
+{
+	u32 fractional_period = lower_32_bits(priv->period);
+	u32 integral_period = upper_32_bits(priv->period);
+	u32 tmr_ctrl, fiper_ctrl;
+	struct timespec64 now;
+	u64 ns;
+	int i;
+
+	/* Software must enable timer first and the clock selected must be
+	 * active, otherwise, the registers which are in the timer clock
+	 * domain are not accessible.
+	 */
+	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
+		   TMR_CTRL_TE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
+
+	/* Disable FIPER by default */
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		fiper_ctrl &= ~FIPER_CTRL_PG(i);
+	}
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+	ktime_get_real_ts64(&now);
+	ns = timespec64_to_ns(&now);
+	netc_timer_cnt_write(priv, ns);
+
+	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
+	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
+	 */
+	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
+		    TMR_COMP_MODE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+}
+
+static int netc_timer_pci_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	pci_set_master(pdev);
+
+	priv->pdev = pdev;
+	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+release_mem_regions:
+	pci_release_mem_regions(pdev);
+disable_dev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void netc_timer_pci_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	iounmap(priv->base);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct clk *clk;
+	int i;
+
+	/* Select NETC system clock as the reference clock by default */
+	priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+
+	/* Update the clock source of the reference clock if the clock
+	 * is specified in DT node.
+	 */
+	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
+		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk),
+					     "Failed to enable clock\n");
+
+		if (clk) {
+			priv->clk_freq = clk_get_rate(clk);
+			priv->clk_select = i ? NETC_TMR_EXT_OSC :
+					       NETC_TMR_CCM_TIMER1;
+			break;
+		}
+	}
+
+	/* The period is a 64-bit number, the high 32-bit is the integer
+	 * part of the period, the low 32-bit is the fractional part of
+	 * the period. In order to get the desired 32-bit fixed-point
+	 * format, multiply the numerator of the fraction by 2^32.
+	 */
+	priv->period = div_u64((u64)NSEC_PER_SEC << 32, priv->clk_freq);
+
+	return 0;
+}
+
+static int netc_timer_parse_dt(struct netc_timer *priv)
+{
+	return netc_timer_get_reference_clk_source(priv);
+}
+
+static int netc_timer_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	err = netc_timer_pci_probe(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	err = netc_timer_parse_dt(priv);
+	if (err)
+		goto timer_pci_remove;
+
+	priv->caps = netc_timer_ptp_caps;
+	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	spin_lock_init(&priv->lock);
+
+	netc_timer_init(priv);
+	priv->clock = ptp_clock_register(&priv->caps, dev);
+	if (IS_ERR(priv->clock)) {
+		err = PTR_ERR(priv->clock);
+		goto timer_pci_remove;
+	}
+
+	return 0;
+
+timer_pci_remove:
+	netc_timer_pci_remove(pdev);
+
+	return err;
+}
+
+static void netc_timer_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	ptp_clock_unregister(priv->clock);
+	netc_timer_pci_remove(pdev);
+}
+
+static const struct pci_device_id netc_timer_id_table[] = {
+	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR_NXP, 0xee02) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
+
+static struct pci_driver netc_timer_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = netc_timer_id_table,
+	.probe = netc_timer_probe,
+	.remove = netc_timer_remove,
+};
+module_pci_driver(netc_timer_driver);
+
+MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..763b38e05d7d 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2024 NXP
+/* Copyright 2024-2025 NXP
  */
 #ifndef __NETC_GLOBAL_H
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
-- 
2.34.1


