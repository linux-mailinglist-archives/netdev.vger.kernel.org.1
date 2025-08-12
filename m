Return-Path: <netdev+bounces-212850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F44B22424
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C596D1AA883B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E272ECD04;
	Tue, 12 Aug 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BopseTFb"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455C2EBDC5;
	Tue, 12 Aug 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993268; cv=fail; b=uTyy0UFM6fzruqMvYPOFx9+MBTnWIo8RA3L7RknDOvMivS7eNOJcYQUBxrdOPWUp5VtuSCo3D2z+cWz2nuBWPhjZR/p3AQoXL9VgNGSYmQI2Y8YvSrSK96bwJkikOtCcN0CtUy6P8xFIbiRa6rNaCe3j0ViUUcTPrCAmQKrC/AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993268; c=relaxed/simple;
	bh=5/iko8r8j264P8YzIJmkFhsddTN5qLJ8EstRwWBpGdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rthyOKFKdbVkHGWUgGpR1JPFka6PQcqQFHuS+fUaJt5R7Umm1wwaHil7uzMusWaSuqQUbTa4yyvev7KMsZKul0eFSNEaSyp4NvlIz0K8SaNhoOo2in4YREn4iTvpsS0m5nej8EE3NvWbSNsxrU3IQmNPrsiaWmlgttkiVykxG+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BopseTFb; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5GBYEApcyW9MHfbMfLcI92hGkz7i7eJDTSbg0dF4jvUwgILEpI2tv1jy+0RvL18mLV7siVmDYh5BQTyABvclVcsuKRq3DuAwbZpqJWwh0CHM5LFshbnDs6c2a/ZazpS1Al66mJDGboNAfFqJnaEAEABNfbn1vWUuhCIXFjxAg64UajOe8DSCmOwisvCY40BEpGZewjW/bio7pygIJYhFJ9/vs5s/lC50FMQscCVXkyhHlhskYZNz623vhjmkRejW2SPiWAXEddiAlRRS828qw04ICyDo+VxemoH1r5czxssfnfy6X4UEyXiBqK+XZF/FsNSpyGBSDl7Mzq4btV49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYwBEdqEMXMC2YeS5CEfMDkVs9SXrmjKI0z7mT5uv8g=;
 b=oKDBz3s/tDkDUC64SBr7NKZ087ok67IgqrpZgCLD3U/l972O15SQXvYdM6cjZ3M/Gc3KX8oK4SyLv27dZ/MoO3AcKC+hA5trXeuNHnA+1P9FGAZdtZ6z99nV7duQ7OrPGir9E3NaSszroabMbhOGfdfVwK+dcw3/zktNj18PGagsR2uRU9eMj7lVy0oK3Xi2H3rK8t4p+iT+ZVkGFU1BGeMlX6FhF8J8jLQxU1iOA8DUgaqckMA8uclB6tHU5Qp8f9xmxUR5Vvca/1E0RHv7wzmWLROXJAF7F+HnVwEnWacBayVWS5mDAJ1BYSxPpg7qAY5y6kzBgl1q/+SzVcT5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYwBEdqEMXMC2YeS5CEfMDkVs9SXrmjKI0z7mT5uv8g=;
 b=BopseTFb4AcK77UbRFlZEvPAsxF8Re7cTT0ybB5+P0A/yEOqFOZVFlB4e2nb4gP95c282iTPAKacfglmlGiVT4x6osM01zG4/UivDu7v/bmqPDU3tQn64jZhoppZ6KF6oMu/p5mw+AEKser1hxVZ+lQgOyTlWANH1usZpVPNmIGskvL2wNXdwydQ5QwH+7RJGli9S/Vc6lPliX+jEyhM7nt+a2s7a0IiJoC1GSu7k3IUHr3PhXwzDnVflhp7Tqfd7okN5KmZ/HY9CpRDmY9KfY2qzTT3GO2EiLzvOw7Q6nn0d1atq/PQWNAbHpob/mobaMUQwZrLCU+6IJtyfiIreQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:42 +0000
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
Subject: [PATCH v3 net-next 06/15] ptp: netc: add periodic pulse output support
Date: Tue, 12 Aug 2025 17:46:25 +0800
Message-Id: <20250812094634.489901-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8fa11ac2-cc2c-4c5e-75c0-08ddd9881309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PbcJ1VXlBUSLTK4ZsLQKkEwmYtL1WSBsDQsMH2kAMXORh5Un3igRMtaNxC+x?=
 =?us-ascii?Q?CR/Ibhd3nP5JljusEfC4CmLHjznKbc3l/cBvu9aurpAtZt150NVv/MW5bxra?=
 =?us-ascii?Q?7Haos14O5Sim8U0vSWE4teJIJkgvnLPZXxYpR2J2K0KRCM6A8FW2CeOy70j1?=
 =?us-ascii?Q?q4KNuJXDQCm4hVPaPTEKhzAvHYIJ090xlQf6OYlSS6XZZy1x4pJMjjmI7t2M?=
 =?us-ascii?Q?8HwIaN0p9czJpcap5Cr0GBHQpcp9n6BcKXikEwf5xNsetcM0VBDu1+6bn9Ij?=
 =?us-ascii?Q?QDXhvZWxD1OUOpEO6ChF10UmacmZ3P3T++Om2XrFcmpO6Zrdg9tdos3ng3Zj?=
 =?us-ascii?Q?ceztJKKnoc9BMpK/p1CSU0S8vA/Cuvi/C6LnFFC+v+i3rOtS1gG9y2qDOTdy?=
 =?us-ascii?Q?AhgIjGgQAHGf1NLO4MREYEyqrvh7vpNApnLa1VU5Ix91xwgPMC2fy2XZ6WV/?=
 =?us-ascii?Q?QRjszIhhfEtCwONs2mxZsTL2clJpIIEo5sBUjyhwl4YrKLDB0aw+oP+XpyZm?=
 =?us-ascii?Q?hxWr/p6iFnARFS/znG7Z5bqOCNtZ2RDu7TiWEpgIuHs7s4wwmu4FI1J0aLd2?=
 =?us-ascii?Q?wZONE5vmR+JYjOX7GjKdpfpGSbQrVNa1V5I6lQ/QZvX2tfRSlvzcrC8dNUiX?=
 =?us-ascii?Q?httdBtnL2dXxmQj84Dl+mCy5xH/7vsZXUUV42jVlpmpRKSf4AGAB6ONc9SCG?=
 =?us-ascii?Q?4KsiZbBKDxa+k1ua6e/+ZeeTPLRdN54BUorMQoq4CC2r6ylnm3wNJnmf7UWE?=
 =?us-ascii?Q?urdGHeZT/xW69YdB2rwXyUflm2m/xp5Yjz29aKP2GhQw+LfXCSsFsEOSnlBv?=
 =?us-ascii?Q?QDtdGA6YGHbYBnOhju8E8R5HA8WBcqb6kFagbeFU7cdGly4wwjhgyTr2Y5JW?=
 =?us-ascii?Q?2M36o6GxDRXenAcGkPNq0mqnt8elP5Tve20P7+GkxmwNTjvjzTRtZCQ/aMiL?=
 =?us-ascii?Q?fGgFmSR+pAFIImCit3bLfWnIy9xXp+J42eROh9Nw+8ZYlgbOENNeMAlv7us1?=
 =?us-ascii?Q?LTMMmNE2YpvjiVGWS3oS+Mg3siG68pvJc7ZzgqeQSn78ABKE2k00nzdZN7YZ?=
 =?us-ascii?Q?aQNtbvgXrWKa4Sn5hmIUYmFC4MWj4gtWEJDRzzcI1bDjo87dsESO3D9OWOtv?=
 =?us-ascii?Q?l+IGdWEqTt+NM+/cDHXMFLjJzIjaxMzGewZ3cdfnDuSfZXV4ud3mOjca/JlI?=
 =?us-ascii?Q?nMDEoKZTrtMp1TKnGFZjuU4Bexq7hjTIZenNkCQgB4qAPVEy16PGbIB3KHzy?=
 =?us-ascii?Q?MuNfes6sdGYFq+cyvH7hlbC9TgqnY60DhheRleIyw0MQM2CsVQ6mgbHAHDeo?=
 =?us-ascii?Q?SuUe91ZmJDGV1c+s4BrunnHsNDIDe1SroteuOpQe9WzW2Mq6qviRyYu3i1rJ?=
 =?us-ascii?Q?Kru4sukOr4jDNzjFmdsjwHV0u0za/wPtYml5bVuE5CItQK/BTspK31CI3O7H?=
 =?us-ascii?Q?1DRaWTiTXpR3q9yWAcfy0+lq3CmC5M6eVYSdsMLd3Q9S7cZudQgSo4Hshcin?=
 =?us-ascii?Q?SAmlCuRG7Rhqdkc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5DFKRu8arOHniUWqXcsbgMpjtm5tsgy53cwdshqudtWPzLynLHAFYB41pGUO?=
 =?us-ascii?Q?EzI0cVUIY4ml51INfQEo2/0dAjTx/oUGMkyWbZH0jBYb7NhH2xH8uIoIcEXB?=
 =?us-ascii?Q?6vCnrNiO/IcKvf0GciTTA3DTqjCZqp4Uctj1rtVnzE/icQNEyyNj9t/fev3M?=
 =?us-ascii?Q?rIFkTEch+o0zxJiIteRSmCEPMrKr3NOLQOKG1JTyVgG446Oi3Lqa4SK0If96?=
 =?us-ascii?Q?54L4vUQiccz3nxNrUcZlql+FOti0nSWwS3G5up2rbPfJ4Zt3qr+HJ3lrnujA?=
 =?us-ascii?Q?j0yUFr9IeB+G/FSht28lsePccPAzrZhZivelEbTN4a86WyuGtmEYKFHe9u+k?=
 =?us-ascii?Q?E/7sHJn1GH1mJQS/BOncgoUWJqClw2/SiMayV/C2jbOPpJxQmCd26PIoFt08?=
 =?us-ascii?Q?AW6iuh9fzp8P18bFVTddMGq1n2kp2Qodsp9+CpBomzYtfFKbvZfySaFGwPEU?=
 =?us-ascii?Q?MErrLEA7QuisTkhY3xzmoh51rN68Os/VfF4ZMrTOe4zPvz+uepRwTm74cJHS?=
 =?us-ascii?Q?wBtuahKhEzebZTuB07wfuGIO7e27ScMdCEqFfGFmDz76664ixIzFEqUqwScr?=
 =?us-ascii?Q?06n6N7mVR3ptSWmTMG14dhI8NdOJkUt3dBRQsVmhcGFfHuxXqK5PsJ4cdygM?=
 =?us-ascii?Q?gvdduBX/cC/78kL4qurKVRbPUG6RPZdXzkUfYzM6ODBqWIshKJXrFEj3oM/I?=
 =?us-ascii?Q?eiLoouEeUFdbFAAJMf9mLwVsR1Td9wUs2H99NGUitmPp0BQHjXkxsSRudjv1?=
 =?us-ascii?Q?tglm1UQbsInY40iF8x5+6uuzqpl6V86L8x9WpIqhKoom9NTM5I0ZywQKRQJw?=
 =?us-ascii?Q?B//xhdMsq+rPaoBeKE0WlC9c8JPC8xutiVddhA9CvW9yYVjctWMElGaXCBsP?=
 =?us-ascii?Q?ofP3qwmWg8lmNJrAzAkNSownz7AM8msJcPSUDKhTGvFZfNen+T8YAs4pqMDc?=
 =?us-ascii?Q?Id9hwyFLW82aPL6A4T90w3sBIQwKv7dmRwwpQ7KtA/koIT4/dZc3eLlfvtc6?=
 =?us-ascii?Q?ltVPh9AoU6Iodzat4dxyxTZ6YQMZvXs6//kua7xFUpqZOsjCELesIcX5Ltkp?=
 =?us-ascii?Q?+362fNwz+NziXB0I7lkSRQS4+l03Hyayd8jkujT7Bhnb+bsf9z4sxpPcFtvN?=
 =?us-ascii?Q?zBk2ryiM1p23v5Lfv8c9Q4DrgwVoqHrmPK+qjMMZTEx45yrUrosh7adLCjqy?=
 =?us-ascii?Q?ICNNgTXln1IxBNlCRIbaL9Empo+Uw/Gmt49gO4MUBW3Fpepo/qsKibhqq9LO?=
 =?us-ascii?Q?AuuqeAnC46/3XbclAxJnWEOlOBsT5SBXQzQvia2Rl5tL8pI3EcVd+QPJttGg?=
 =?us-ascii?Q?ijXgf1x2jGF2rnJEb1dibACVRSA/DlnIFTjr7qKgcsqiAaKXqMcbmFaa+UJ/?=
 =?us-ascii?Q?VOjFxhTmG5SK4JwotStBXsvpKoqFc5ejMM1/puVP7w2hh5WC/seQH30hP3kA?=
 =?us-ascii?Q?7OyAgcVZKEqOOa6sRYOkvzxE8E7fwdyXXn/yXXU3k2YE0RrO3wWZG0hs8rJH?=
 =?us-ascii?Q?k4QOoePBronG/cq2Okp3ZV3cS0oWs3gcML2nqWLxhaKzqcyz4b53ZDvXwwye?=
 =?us-ascii?Q?BcO0svJ4UFOjGq9+R6vD1lhrjshnSKGnfGUw8N+d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa11ac2-cc2c-4c5e-75c0-08ddd9881309
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:42.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oA0GxKLRWNapZ/ZTDK/X/0VQ7k+A8qvcFWPYaBwjPMXV2s9tA3RHHrIgwPEoiMJqFSTf1hAKU//hOBW0155CVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

NETC Timer has three pulse channels, all of which support periodic pulse
output. Bind the channel to a ALARM register and then sets a future time
into the ALARM register. When the current time is greater than the ALARM
value, the FIPER register will be triggered to count down, and when the
count reaches 0, the pulse will be triggered. The PPS signal is also
implemented in this way.

For i.MX95, it only has ALARM1 can be used as an indication to the FIPER
start down counting, but i.MX943 has ALARM1 and ALARM2 can be used. That
is to say, only one channel can work for i.MX95, two channels for i.MX943
as most. Current implementation does not allow multiple channels to share
the same alarm register at the same time.

In addition, because of the introduction of PTP_CLK_REQ_PEROUT support,
the PPS channel is changed from being fixed to 0 to being dynamically
selected.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2: no changes
v3 changes:
1. Improve the commit message
2. Add revision to struct netc_timer
3. Use priv->tmr_emask to instead of reading TMR_EMASK register
4. Add pps_channel to struct netc_timer and NETC_TMR_INVALID_CHANNEL
5. Add some helper functions: netc_timer_enable/disable_periodic_pulse(),
   and netc_timer_select_pps_channel()
6. Dynamically select PPS channel instead of fixed to channel 0.
---
 drivers/ptp/ptp_netc.c | 356 +++++++++++++++++++++++++++++++++++------
 1 file changed, 306 insertions(+), 50 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 9026a967a5fe..aa88767f8355 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -53,12 +53,18 @@
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
 #define NETC_TMR_REGS_BAR		0
+#define NETC_GLOBAL_OFFSET		0x10000
+#define NETC_GLOBAL_IPBRR0		0xbf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+#define NETC_REV_4_1			0x0401
 
 #define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
 #define NETC_TMR_DEFAULT_PRSC		2
 #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
+#define NETC_TMR_ALARM_NUM		2
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -67,6 +73,19 @@
 
 #define NETC_TMR_SYSCLK_333M		333333333U
 
+enum netc_pp_type {
+	NETC_PP_PPS = 1,
+	NETC_PP_PEROUT,
+};
+
+struct netc_pp {
+	enum netc_pp_type type;
+	bool enabled;
+	int alarm_id;
+	u32 period; /* pulse period, ns */
+	u64 stime; /* start time, ns */
+};
+
 struct netc_timer {
 	void __iomem *base;
 	struct pci_dev *pdev;
@@ -82,8 +101,12 @@ struct netc_timer {
 	u64 period;
 
 	int irq;
+	int revision;
 	u32 tmr_emask;
-	bool pps_enabled;
+	u8 pps_channel;
+	u8 fs_alarm_num;
+	u8 fs_alarm_bitmap;
+	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -192,6 +215,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
 static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 				     u32 integral_period)
 {
+	struct netc_pp *pp = &priv->pp[channel];
 	u64 alarm;
 
 	/* Get the alarm value */
@@ -199,7 +223,116 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 	alarm = roundup_u64(alarm, NSEC_PER_SEC);
 	alarm = roundup_u64(alarm, integral_period);
 
-	netc_timer_alarm_write(priv, alarm, 0);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
+					u32 integral_period)
+{
+	u64 cur_time = netc_timer_cur_time_read(priv);
+	struct netc_pp *pp = &priv->pp[channel];
+	u64 alarm, delta, min_time;
+	u32 period = pp->period;
+	u64 stime = pp->stime;
+
+	min_time = cur_time + NSEC_PER_MSEC + period;
+	if (stime < min_time) {
+		delta = min_time - stime;
+		stime += roundup_u64(delta, period);
+	}
+
+	alarm = roundup_u64(stime - period, integral_period);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static int netc_timer_get_alarm_id(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->fs_alarm_num; i++) {
+		if (!(priv->fs_alarm_bitmap & BIT(i))) {
+			priv->fs_alarm_bitmap |= BIT(i);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
+{
+	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
+	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
+	 */
+
+	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
+		       priv->clk_freq);
+}
+
+static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
+					     u8 channel)
+{
+	u32 fiper_pw, fiper, fiper_ctrl, integral_period;
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	/* Set to desired FIPER interval in ns - TCLK_PERIOD */
+	fiper = pp->period - integral_period;
+	fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+			FIPER_CTRL_FS_ALARM(channel));
+	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
+
+	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
+			   TMR_TEVENT_ALMEN(alarm_id);
+
+	if (pp->type == NETC_PP_PPS)
+		netc_timer_set_pps_alarm(priv, channel, integral_period);
+	else
+		netc_timer_set_perout_alarm(priv, channel, integral_period);
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_disable_periodic_pulse(struct netc_timer *priv,
+					      u8 channel)
+{
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+	u32 fiper_ctrl;
+
+	if (!pp->enabled)
+		return;
+
+	priv->tmr_emask &= ~(TMR_TEVNET_PPEN(channel) |
+			     TMR_TEVENT_ALMEN(alarm_id));
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+
+	netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static u8 netc_timer_select_pps_channel(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			return i;
+	}
+
+	return NETC_TMR_INVALID_CHANNEL;
 }
 
 /* Note that users should not use this API to output PPS signal on
@@ -210,77 +343,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 static int netc_timer_enable_pps(struct netc_timer *priv,
 				 struct ptp_clock_request *rq, int on)
 {
-	u32 fiper, fiper_ctrl;
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-
 	if (on) {
-		u32 integral_period, fiper_pw;
+		int alarm_id;
+		u8 channel;
+
+		if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
+			channel = priv->pps_channel;
+		} else {
+			channel = netc_timer_select_pps_channel(priv);
+			if (channel == NETC_TMR_INVALID_CHANNEL) {
+				dev_err(dev, "No available FIPERs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+		}
 
-		if (priv->pps_enabled)
+		pp = &priv->pp[channel];
+		if (pp->enabled)
 			goto unlock_spinlock;
 
-		integral_period = netc_timer_get_integral_period(priv);
-		fiper = NSEC_PER_SEC - integral_period;
-		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
-		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
-				FIPER_CTRL_FS_ALARM(0));
-		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
-		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
-		priv->pps_enabled = true;
-		netc_timer_set_pps_alarm(priv, 0, integral_period);
+		alarm_id = netc_timer_get_alarm_id(priv);
+		if (alarm_id == priv->fs_alarm_num) {
+			dev_err(dev, "No available ALARMs\n");
+			err = -EBUSY;
+			goto unlock_spinlock;
+		}
+
+		pp->enabled = true;
+		pp->type = NETC_PP_PPS;
+		pp->alarm_id = alarm_id;
+		pp->period = NSEC_PER_SEC;
+		priv->pps_channel = channel;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
 	} else {
-		if (!priv->pps_enabled)
+		/* pps_channel is invalid if PPS is not enabled, so no
+		 * processing is needed.
+		 */
+		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
 			goto unlock_spinlock;
 
-		fiper = NETC_TMR_DEFAULT_FIPER;
-		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
-				     TMR_TEVENT_ALMEN(0));
-		fiper_ctrl |= FIPER_CTRL_DIS(0);
-		priv->pps_enabled = false;
-		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		pp = &priv->pp[priv->pps_channel];
+		memset(pp, 0, sizeof(*pp));
+		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	}
 
-	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
-	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
+}
+
+static int net_timer_enable_perout(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	struct device *dev = &priv->pdev->dev;
+	u32 channel = rq->perout.index;
+	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PPS) {
+		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
+
+	if (on) {
+		u64 period_ns, gclk_period, max_period, min_period;
+		struct timespec64 period, stime;
+		u32 integral_period;
+		int alarm_id;
+
+		period.tv_sec = rq->perout.period.sec;
+		period.tv_nsec = rq->perout.period.nsec;
+		period_ns = timespec64_to_ns(&period);
+
+		integral_period = netc_timer_get_integral_period(priv);
+		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		gclk_period = netc_timer_get_gclk_period(priv);
+		min_period = gclk_period * 4 + integral_period;
+		if (period_ns > max_period || period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %llu\n",
+				min_period, max_period);
+			err = -EINVAL;
+			goto unlock_spinlock;
+		}
+
+		if (pp->enabled) {
+			alarm_id = pp->alarm_id;
+		} else {
+			alarm_id = netc_timer_get_alarm_id(priv);
+			if (alarm_id == priv->fs_alarm_num) {
+				dev_err(dev, "No available ALARMs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+
+			pp->type = NETC_PP_PEROUT;
+			pp->enabled = true;
+			pp->alarm_id = alarm_id;
+		}
+
+		stime.tv_sec = rq->perout.start.sec;
+		stime.tv_nsec = rq->perout.start.nsec;
+		pp->stime = timespec64_to_ns(&stime);
+		pp->period = period_ns;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
+	} else {
+		netc_timer_disable_periodic_pulse(priv, channel);
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+	}
 
 unlock_spinlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	return err;
 }
 
-static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl;
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			continue;
+
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
+	}
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl |= FIPER_CTRL_DIS(0);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
-static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_enable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl, integral_period, fiper;
+	u32 integral_period = netc_timer_get_integral_period(priv);
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+		u32 fiper;
 
-	integral_period = netc_timer_get_integral_period(priv);
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
-	fiper = NSEC_PER_SEC - integral_period;
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
+
+		if (pp->type == NETC_PP_PPS)
+			netc_timer_set_pps_alarm(priv, i, integral_period);
+		else if (pp->type == NETC_PP_PEROUT)
+			netc_timer_set_perout_alarm(priv, i, integral_period);
+
+		fiper = pp->period - integral_period;
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
+	}
 
-	netc_timer_set_pps_alarm(priv, 0, integral_period);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
@@ -292,6 +526,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 		return netc_timer_enable_pps(priv, rq, on);
+	case PTP_CLK_REQ_PEROUT:
+		return net_timer_enable_perout(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -310,9 +546,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
 	if (tmr_ctrl != old_tmr_ctrl) {
-		netc_timer_disable_pps_fiper(priv);
+		netc_timer_disable_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
-		netc_timer_enable_pps_fiper(priv);
+		netc_timer_enable_fiper(priv);
 	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
@@ -339,7 +575,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
@@ -349,7 +585,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -386,10 +622,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -418,6 +654,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_pins		= 0,
 	.n_alarm	= 2,
 	.pps		= 1,
+	.n_per_out	= 3,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -575,6 +812,9 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	if (tmr_event & TMR_TEVENT_ALMEN(0))
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
 
+	if (tmr_event & TMR_TEVENT_ALMEN(1))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
+
 	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
 		event.type = PTP_CLOCK_PPS;
 		ptp_clock_event(priv->clock, &event);
@@ -619,6 +859,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 	pci_free_irq_vectors(pdev);
 }
 
+static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
+{
+	u32 val;
+
+	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
+
+	return val & IPBRR0_IP_REV;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -631,6 +880,12 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		return err;
 
 	priv = pci_get_drvdata(pdev);
+	priv->revision = netc_timer_get_global_ip_rev(priv);
+	if (priv->revision == NETC_REV_4_1)
+		priv->fs_alarm_num = 1;
+	else
+		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
+
 	err = netc_timer_parse_dt(priv);
 	if (err) {
 		if (err != -EPROBE_DEFER)
@@ -640,6 +895,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
 
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	spin_lock_init(&priv->lock);
 
 	err = netc_timer_init_msix_irq(priv);
-- 
2.34.1


