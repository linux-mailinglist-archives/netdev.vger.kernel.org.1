Return-Path: <netdev+bounces-214953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0EB2C48B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60048725734
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB733A03A;
	Tue, 19 Aug 2025 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EERqhOmW"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F633CEBC;
	Tue, 19 Aug 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608333; cv=fail; b=FpRIZ5FDhUQadJYmruHN2V/LF81LLKdfQWv6mTv8Ut0GqMvfGfEbitJpDD7rbIulTpMbZahGSLqHinHCMl7l+DlBjn+VgZ5L6JdxvZkS3yNn7LlID7oZVdr3mhSRmeJCnll/jUZCKt3mP1fS1UZ8DGOcWpWhl7mb1T1nVM4xoDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608333; c=relaxed/simple;
	bh=Zis2JL0etjysc3vxDacQn7EoZzJLN5Tk68OL4siE3IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJ4bb0G0AFR9Ah6SiKpZhH2z9YJPGgUhnnc96tBQLJREkYs49xX4yCIBfhLABkC3+bmIJroMJBnlTGbPex5aenHBbi6TxiCmWb7HwmQ6oAWrba/etW0kJjqoP9daO3Lq+4Y3Si5YXNOUVq9n2tfimFtkc8sh3bHZb91T7UcNXBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EERqhOmW; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdrnbyGrKr2XA8Gaw/dsBF7NTWcDQi5EdC8EVtaTJUPAMnnySnMNdURaSvkkyHygmEJZi9gFl5yjiGS8PiPTBQyxJVEBaxtEM0uh/SdOAI27nfxM6+a+ZZQL5Jb5GF3xZhxiSOApL9TXD9BCCIQPwWnka0WnimLvwFHsUu14LpfLhvlm9pU0Yk4FyrD0k4ADgC3Zn7prc6LCCUB80nCUiGfxLeEhis0dWF6lt29djm1u6S5/uGv0zK5j3iukcBSL5D3Zka4ViZTdw4shO9qCEAU5kgPIawHOqpUePM86gtNkW4mERsr0aWg1YTOOuKQNzWoxPfWLo2StIvsK9VLKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzqKvfa66g0Bc+z6ODbx2gk3YXIz0Qdx8v9tbxdaXmU=;
 b=atSfzKLlX6zRgKdMr16ot2UaLyZca2N0LkiyFIhxarHdrKii+seZNAAotQbSvLEGI6XtK2TlkuwCVPaJHmtwczsyUzZNWQzqXiCtj2DOmDGJw5qpMWwNkbXg2ZHpmKX4AVJ0eptoyUVK2/ddxoSeNsSu9kl5ODOocs7GWabuztJzo1f7RBRWcjJAYQgXgp6XNf02eSOKijMc7UAQSR0xbasj/zeNlASXSTHPHq6eO0W0j81/L/MLfFJJ6uJC+1Lfvm+42DwXDOlP6aPKjBWUMH5NP9KBQ6aBi88us2Cf6XcGga/bfhHo+UOfQ+z1AqB9im6fwgFo6ko3E9Czi3DbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzqKvfa66g0Bc+z6ODbx2gk3YXIz0Qdx8v9tbxdaXmU=;
 b=EERqhOmWBBRoT3eKl5bkIwHiTJBb55r4FlGtouHpLGlQwFTEDAScKY11EM/64QFPZTRisVXqeO7+lJDTdk2f8yNu05ZFR/Hd5knT7+zpX1hVNC/kJ1jqtEiXKAH6vLTC5lDlUeDMBoOTTaoazmPgoOSBcRPmBlurb7CH7213O7nMx8yYR7I8rU2N/6NSiYYUkZYez20neu/Iych9LeFPXf7XAfoIOPTIiyzIZj87xJ32GPSYO1WWj+dx9rq80QZFZP2Dxw9R0xkvH0YrKyZtwaBp5P9NAKgEW6V0uNYPccJFMoO4AqZ46xgwSYmMeP94/nRiJ0+j1BtjFT1G16vMvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:58:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:58:28 +0000
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
Subject: [PATCH v4 net-next 03/15] ptp: add helpers to get the phc_index by of_node or dev
Date: Tue, 19 Aug 2025 20:36:08 +0800
Message-Id: <20250819123620.916637-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc26feb8-84fb-4787-ffca-08dddf201728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4x86jFsIS7Rv6vpDMMn1ev1qReJgtLrirFGWw0rYCsGseAAT35JVwXpHaU8?=
 =?us-ascii?Q?LjKF5jhdUmMRMXCoJWKiJlvQAzHpyi+enR9iypQwibUajOCARaqDykS90LIz?=
 =?us-ascii?Q?jx1eGZRn0ndkomonsxo2Amd0jHuN1pnQcXtAQXz2N5mVvZU58SbJ0UP2RCvJ?=
 =?us-ascii?Q?ns3vYRG8+SR41J1o6vSFx7Z+RAS3bDrXKouL5X851EWIIOCdg6Bsd3dEXdIS?=
 =?us-ascii?Q?JdR6DQjU2olll3n7Yvqu32Wbe0wdez0p/t4PZQgdGiClwR8MLonPTgTgjhvn?=
 =?us-ascii?Q?bWPLBBo5PWWgnDdh42GqOXfY2JyNBBlVz4z+7gRU2rQOJZySVKVzfUVKCBQ/?=
 =?us-ascii?Q?jVL0a0kuGt6FioiwgIT+aKZK5YMTCwAQzJ7Yh5ATyHwhN6NPllLTfvfWpwY0?=
 =?us-ascii?Q?fq5DVbCJ7Qcv1xIpdZRq1OtuVVB/ugq4u0xVqDUZ++Xv2UJp6WFJCGLdkDCI?=
 =?us-ascii?Q?dcVNtRlEiSfrpHM00hWmlQuOhdcVgiMk30mgpIv8H43RxxqbGQBm4Bd+Sk8M?=
 =?us-ascii?Q?KzaataRhGgjCC5XPVcgPTvggm0Hl9U+/YNRwVMX0XbTDilOqAtT+M3Ll2Opu?=
 =?us-ascii?Q?uZBdKYjra7IjxAg4T/EBNEPJxHd6OVvCyZaCCJK/RcVibYz9Y6jbMF74+hXj?=
 =?us-ascii?Q?5cHhLL3QJLjVQiPyfr0MXcJ2EyPLs2sDJWxRy/JNZkItNIgKoZgRj7nAaAxD?=
 =?us-ascii?Q?5pwCSfVtCgVxvqvssJmQsP5GH0lAuG61va2wgDz3TNJQ0mB4ZN9a2uvkmr7O?=
 =?us-ascii?Q?CvhYzRIV2FYEkFhefSVYCmBnwoFq4m8smlFq/Z3xlQhUpV3xl3TWIOJdsoaD?=
 =?us-ascii?Q?HNPUbX5oSfkMvxlgbA24IUsuBhgSWUVB/m6RKAr65YoHY7mHvTp438Hy2Vwn?=
 =?us-ascii?Q?TqLmqxLwvVTUdda98IZU5vXEluGEaGOKI7oyL4poW7+sc2xOj1iMoEoAB6NM?=
 =?us-ascii?Q?bQ+ErSGSxFNYVUfQsrsJeihJ5LqQJr0BJswoz1ffGBckYQFUKfPbIVWKgGSA?=
 =?us-ascii?Q?0JDN1o13/9kBdqlhkaFG2D0bxlUT613Mp30/JEuS7ruUNliiF83j9rMX5dHU?=
 =?us-ascii?Q?GzVDJjL5kB5bu1TA6+6FGB5FrD8UmsPsZLkj7/d9LfeeEoN3KcEmNg09CTR1?=
 =?us-ascii?Q?JxuE/qxxFvdRszaVzdEjmMG8s1vCht14UeqIDQJ1CNgxQ8JOdv0r+J8/+XNR?=
 =?us-ascii?Q?8FjOWMk0jnKuB6383lcbM2hqsAC95xkNmO4gU8xgB1NuxoDTsFYucWGeiqw0?=
 =?us-ascii?Q?S7IvJB6XRWtlusSwF3V7lZe55AQsusDd6bsOnwdakY5zCb+2QtTCtal1gVm8?=
 =?us-ascii?Q?lhAfW8z9aOFahXqgufHStLSsWtX5YffVWms1ax257ovmjux0XWN9wx20j20v?=
 =?us-ascii?Q?MY2FKXFuxGyKBK9dknBD1yQS6xIGThpihfk/KRcP9nFbFp/6MXmEsH1NHFNe?=
 =?us-ascii?Q?MeVwgP1vmpZJ41rDLveaUSgV0SqRTe2uSRxjmUeNAJShdlBdJW0patHMYZCm?=
 =?us-ascii?Q?+WLd6ul/w7boNRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkZ5sgDFhHdiwc6nPfR4hyVbhrijtKvUEMT4mIfCMf3npwXcp/5a9BTs0/+u?=
 =?us-ascii?Q?Lhu1EYL9lYdtv9EFIIzN7tDNYsfBgSPUG24tF+Ogthwm+QKh26xHUFmNskqi?=
 =?us-ascii?Q?e/kjRa9sLCP5HmJv6qx3dXVzlyQ6yW60ah61WXUHqDCYIA94XoE0SKdNKAX2?=
 =?us-ascii?Q?PoSeSq2avQLRDUtZewuNLRVGfVOt1iNCMh0ctUtrw11xJDNNda9ziVjfX2RA?=
 =?us-ascii?Q?Hgx56E32ObE/j0HvQWnuWyPaIhTCTCeDu3A6/No7bazltcSfvUDc4kBVNkYD?=
 =?us-ascii?Q?VQyDKTu1Bnba7yH4S77ktdeYuhYUXFNusqvNYx3VLJ5HtKJebKyz3oX+oJKA?=
 =?us-ascii?Q?BtbL36y4UTDJK1Oe/yPMF8MVUUmQnVLq/yaiYS3UQi//lcgcSCMHgHnC0RIA?=
 =?us-ascii?Q?6kxS0l90rxIx/lLS1R+eRpWdTN7Ja3WQELUKJOf36ZCN6PsePcm9H8E8XPCU?=
 =?us-ascii?Q?3PFMT6OQAiZvncrecoAKpP2SOha2U1w7BmLy89D9x3x2hUNh4OFPA+Lddd3w?=
 =?us-ascii?Q?EcKbuKhl9dJS48aVpXiwUH2MjlYaigWnzcohV3Sk6GHcx5n5MmtjIilWZRV5?=
 =?us-ascii?Q?TaBWjxBXJ6qydL4x70nrOVBdRxNwT48XvxAfdu4lihToKtlGnDC7UFjTqagT?=
 =?us-ascii?Q?dONa56V1fL1pwRYfiANJ5IZ1dZGoUJgvasn7oGg5Zq/cEp+ImNoil8tJHkpo?=
 =?us-ascii?Q?nOBRSBRUBoMjFQcAWcHIBA+hJ9HdrgT89t0/rBCe5NwmykINFrY/tpJIqG19?=
 =?us-ascii?Q?Uj03XIH89jYLRJc0p0lAXV7dDY5kHWN2GPNe0De14pke4L3an+YIqBzlXZoN?=
 =?us-ascii?Q?pid6D2NPh1yj7gyXHNFoVN0rmZz+Gl/HT9vGLfHIZCoChhPqAICcFjZLoLDf?=
 =?us-ascii?Q?TQDTvhI3S32KpcPcL2qdezzECMg0CHGEdJw5Hh0q0vd2rDUHCkYmeqF6ZGL8?=
 =?us-ascii?Q?xiGNH+8xooRu1RX/1vgx67UNuIp8jq+RfduuD+mDPQBEAqy63sZsNdDvEJNU?=
 =?us-ascii?Q?oJESuBu2MWX4AYLASt2GjZUpNNSSBlBE+smV4gdpkcC8vOC3a0LXvO9LpJTw?=
 =?us-ascii?Q?Z9fHJeP60qlSuiIXu7QCnspE/we/wcDgTNcWckjsEsZiV99bFoXHq18I4gMp?=
 =?us-ascii?Q?zR8ygR814XoI03TF1TSmg2RiP5A0w9pHLjwO3jNW7T1+Oc8b6gL16sRG9S7R?=
 =?us-ascii?Q?1FzfjkTdZnfXITuRpQhkCKqrXd7gTrMzTugsgozqvtMGs8Qwac/xhVvhskeX?=
 =?us-ascii?Q?TtfdaWMfc8i7Ck0ZMeSunP6/DAeXkgm9/Nx+0gcBICUg9ISj90OU8ItcSuUY?=
 =?us-ascii?Q?hyIR+ObM055W1ItMkmnGrpeUxTJa2EC1s+SBSzKoCACTtfx83qPEaOBQipM7?=
 =?us-ascii?Q?D6Y+CkKZPfuKublbgAoBX1TvC13tXbpIw8JAWs1DQXorKb1EXyt9ciWMPfHL?=
 =?us-ascii?Q?HYC6/UGf9Db07vxfTaDbP3OSX/zD/rYqMmCA6fXtb0Lh/rSpqaX1+Y/q19Ke?=
 =?us-ascii?Q?98qibw+XX4Bv5Xh+Q+28yM+Y1bLF2phOhQ6mf9XRoRyZrBRLleaP49I8YdgJ?=
 =?us-ascii?Q?EbcxPgk6+K/URoINifU5oZ13JX6Ls5Qv5sKGucuY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc26feb8-84fb-4787-ffca-08dddf201728
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:58:28.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqZjDGd8XlcHgdysNTC4RCgB9gM8afO56/agYKUiWaRukeXXJAntdZZ2JJ4F/z5GnClVW9YKCqeeLFAZHJEvQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

Some Ethernet controllers do not have an integrated PTP timer function.
Instead, the PTP timer is a separated device and provides PTP hardware
clock to the Ethernet controller to use. Therefore, the Ethernet
controller driver needs to obtain the PTP clock's phc_index in its
ethtool_ops::get_ts_info(). Currently, most drivers implement this in
the following ways.

1. The PTP device driver adds a custom API and exports it to the Ethernet
controller driver.
2. The PTP device driver adds private data to its device structure. So
the private data structure needs to be exposed to the Ethernet controller
driver.

When registering the ptp clock, ptp_clock_register() always saves the
ptp_clock pointer to the private data of ptp_clock::dev. Therefore, as
long as ptp_clock::dev is obtained, the phc_index can be obtained. So
the following generic APIs can be added to the ptp driver to obtain the
phc_index.

1. ptp_clock_index_by_dev(): Obtain the phc_index by the device pointer
of the PTP device.
2.ptp_clock_index_by_of_node(): Obtain the phc_index by the of_node
pointer of the PTP device.

Also, we can add another API like ptp_clock_index_by_fwnode() to get the
phc_index by fwnode of PTP device. However, this API is not used in this
patch set, so it is better to add it when needed.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v4 changes:
New patch
---
 drivers/ptp/ptp_clock.c          | 53 ++++++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 22 +++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1cc06b7cb17e..2b0fd62a17ef 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/posix-clock.h>
 #include <linux/pps_kernel.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
@@ -477,6 +478,58 @@ int ptp_clock_index(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_clock_index);
 
+static int ptp_clock_of_node_match(struct device *dev, const void *data)
+{
+	const struct device_node *parent_np = data;
+
+	return (dev->parent && dev_of_node(dev->parent) == parent_np);
+}
+
+int ptp_clock_index_by_of_node(struct device_node *np)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, np,
+				ptp_clock_of_node_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_of_node);
+
+static int ptp_clock_dev_match(struct device *dev, const void *data)
+{
+	const struct device *parent = data;
+
+	return dev->parent == parent;
+}
+
+int ptp_clock_index_by_dev(struct device *parent)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, parent,
+				ptp_clock_dev_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_dev);
+
 int ptp_find_pin(struct ptp_clock *ptp,
 		 enum ptp_pin_function func, unsigned int chan)
 {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 3d089bd4d5e9..7dd7951b23d5 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -360,6 +360,24 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
 
+/**
+ * ptp_clock_index_by_of_node() - obtain the device index of
+ * a PTP clock based on the PTP device of_node
+ *
+ * @np:    The device of_node pointer of the PTP device.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_of_node(struct device_node *np);
+
+/**
+ * ptp_clock_index_by_dev() - obtain the device index of
+ * a PTP clock based on the PTP device.
+ *
+ * @parent:    The parent device (PTP device) pointer of the PTP clock.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_dev(struct device *parent);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -425,6 +443,10 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
 { }
 static inline int ptp_clock_index(struct ptp_clock *ptp)
 { return -1; }
+static inline int ptp_clock_index_by_of_node(struct device_node *np)
+{ return -1; }
+static inline int ptp_clock_index_by_dev(struct device *parent)
+{ return -1; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }
-- 
2.34.1


