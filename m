Return-Path: <netdev+bounces-206085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C710B0145D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE973ABBBF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F049C21D3F6;
	Fri, 11 Jul 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VCSBbsIs"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94A21ABD0;
	Fri, 11 Jul 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218303; cv=fail; b=jPPDnD3vs8l5FfUoArX/1OVwNAsLPj41R6jo3YwtYN9iksDaAPqGea7ou0oAY08guloXM1iOl4s5rSVLyuLXAA4mP2pkXRBaTM93fCVQrOhMwXqAriFJXF8uHx0XJ0ucPsKjSI5GuGthZMkXbW1fe7lPfvckyDfM9fGFyc+u64M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218303; c=relaxed/simple;
	bh=HSnrVp0ozWn5I3ggTDQ2pLI3mgf8wiqH4j7dBm9QE3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUWqgWQdMiG+LC+SS5CscypTU1m8n6BX4A7oHpharr/e88E9el6TMwJjcE9rDUePhzpQOsosyClEF7FIDFwR+Hp4cH4roe0stUu1DBMBDnA1Je8Rc476A7g/MRCVzeuteyffouge+nkLwgphGzhTKqO0FfWDYiZXLKPObHkhP2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VCSBbsIs; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzBHA5oi4EGaGxSvovYctiqygqEmPnJLEQTBFVQNZMwz2lLIVMHGDY2+1rK2QN6HDWrSSft7gmo/yJ7YSwIogbdbworebt4rlGU35m+uQGsUvt9Nacf+ez77kX7NyxwOPRBHD7+QKV0PFliOkCs5jpZLgSoeVmR1V6Jp0Ae1lk2UvgOpeDgHGtnf1Lj2yf+FUfNc+VXufwVPEJ904Zkl+l2T5I7adbJBJ7pCKZ7qXgVBr3PmQf8QlJeIUKGMGr9mBqRxM6vJegLHOhBt4Zl0a/R1nmSt3VHhG3soiuqFo9ZtyLcjRoQYVQElIz0/ulus29lV7UptsFduc91jxK4uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD4Dhs5cNDhmUTJEBH/01v9XDnV2TK+P5rhG1VqJapI=;
 b=J+e7HV3vHTVW5xp/mr4Z8EVsUZHJiIxGS8ulFNCyUqH6VS1ZQB1bZntUkWLWO+gLRwB4XjT7PCs3RZDn2MW+Ygtxvv3DHMAqylpTeJvlwfeASt/gvWv1yeaK9sE/CyLAeFMPaRdrhT2kLmYVaNHGNedlXO3BwyIJFN6Tuii/MU/szCqwTbOHevbMXC3v7VMlrMbPrzFM9TIO7j9NHAOWaj7JKyjcrEXvKsXQ1bJZTofFq7dBngeEJQL9uw1OxkASW7uG+5WP59junIn92wyREHWNTY3B96Oezzvu8mUuxPa7JVwkiw7NiqFDh2btdVFwt5WzZyLKUMcWnuw0TWS1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD4Dhs5cNDhmUTJEBH/01v9XDnV2TK+P5rhG1VqJapI=;
 b=VCSBbsIsrbP6Kvvybm7fjKPJ/utyNTT3y+bwwNDeBRrJCJzE25CXT3wcQx1e683znHnd+4KHHBEPp1RGl7bPJCNpLH1gP5tF7xi2Di/gQC/4+drvBl7ZcqjmZggo1eo946suToil+moQzSR09Lg4ZDqlXIyaw6iODryQWK7GbIU3e6Pg8MRJoVNWH3iTDiVtKTvrtjZu7HK4J25lEJIHqhWRonmloSUDujsQhlMznsXaIpPBwBnOeMETwsRZHqlXskUZkRgypm41fVqDVmIdrUS5UJzGBMV5vK4MH3rgZbhuscbo9kJLOdoz+gzZeGPnu+QPwiUyp/NPKSUP/MIN8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:18:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:18:20 +0000
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
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 12/12] net: enetc: don't update sync packet checksum if checksum offload is used
Date: Fri, 11 Jul 2025 14:57:48 +0800
Message-Id: <20250711065748.250159-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: 8310eb10-889f-4940-4862-08ddc04b1d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SaxXLoTsWQjeXS3NaPaPC3IdvklhSovWkkENxMx7Tj9UG1BXW0Ooe633eoH9?=
 =?us-ascii?Q?Av8CYbihzSrOkJiFkLnXPFtl9AUyVelHUYyJwdWCIqewFZQ8fAqRnnuYSeUy?=
 =?us-ascii?Q?PTNXMFn4/KszLjKfaVfcpwCIZ+HlGVWttRdLLkNpjJ2jvNl+rWUAMnXs3OEA?=
 =?us-ascii?Q?prfz8IXzyur5SBEablKwuttKh8yiukxqYQWy3rKwP9YBMCssNzJrJ72P2bDL?=
 =?us-ascii?Q?rzQXGu9uWoife2imn+KBRWrFrJmb6DOIsVK2Y3YxXBgTCeZKGZRgXDq4OYR7?=
 =?us-ascii?Q?7HBbH0+F9nMjWHV6PJZyV2Biazartb62PfV01cg5H3gJT85HWI7uESlnW6oi?=
 =?us-ascii?Q?2O2/keaizRgKckILtoVEe0Noau+tAJseZCSlgdL8mrU3D4NMvujLcrRxX6y9?=
 =?us-ascii?Q?pZZm0AwxccDZx7x3s9fuicZI9Cu0bDqj8b+kSBVahtmbT1EY+Yp37f9/mcxQ?=
 =?us-ascii?Q?gqMkjxVnAejR9ZWVMX8DBriDJCtrvwmIiNtj4p9DS3ODx8xI4OFbFy6TSRuO?=
 =?us-ascii?Q?HelbgcQV5xemDWis0sXloYt4pxr6DqzX8RONb6cVczBJ9rJAaYMXlhR30AVQ?=
 =?us-ascii?Q?jv0AmjCJlwCcmFuQMRbcTJ5xP/odg4stuVpEv7J9V7sQy9xNKq5Zyzcq7a0R?=
 =?us-ascii?Q?QWDLmttVFj2KVHK7I1Ldmqr53P/VNcaatKZpGBjA1B71Ig9JHkILWZFFZ1iU?=
 =?us-ascii?Q?fR3Pb6Gq0Uxr8q9zQfvc2+qOv+c7lToSEdQUtqsgqvfBtc2IJVLdBVCEuwXh?=
 =?us-ascii?Q?uEJAcg8u0PYsDBLSAZVQpQ/4nX48ho8i3Vd3DRYx/+x9NAxbJR42PAEjiNzr?=
 =?us-ascii?Q?jLquUvGkPBUxZtf9aansWnVHr+zrFUn8t0fhoZ75zI77k9o/9Zfs6+cGDSmN?=
 =?us-ascii?Q?riGNcvu5bgUE+VwsHHeTj7BbdCjd2VNWHCJlmCqWQZ16SGtaW28ER82wpjf+?=
 =?us-ascii?Q?a0ASfEME1g37ltzo8yhNayjszozSo/BR6QmVTMtf2bG8FyRy1Op9I2wRH6Rw?=
 =?us-ascii?Q?8qkuZKnNS7jDeCHRCIEml1FXF9HGrLKFFx2VuyI9yQm5ttIlQLwCrLLM4os1?=
 =?us-ascii?Q?v+RppHiYS/571yy1CI3S8OVq/K4rOasNIe9g4B84KSj8WXDEd24j1cdbmRtz?=
 =?us-ascii?Q?hSBVvBUMcDzQxlElqY6GL3C0EDOQHlCCmcvi/I6Qu0L7Pcz0Qff1loyA5w6u?=
 =?us-ascii?Q?bCCjg2Q7+/e8h0YCVJlmv/GMVEn6J8dSQoQia58Md3EjY8+y6/YjWxy7MN1D?=
 =?us-ascii?Q?sdo77UKRuXoFrpUysV7rEkjuLKxtQpd0UODyjR3UM9mbqocXJOeqi731PeUv?=
 =?us-ascii?Q?0kexC/P8HhlcKyB9iFT37b5zivX/7VwlphsABQKrxY9mYUisnZQck1ovV4eh?=
 =?us-ascii?Q?tVctlXSA2/iu9VTRELqg9PRivHCakSeYQNYYIoIy35+1s9BBkqV+hngOpy4z?=
 =?us-ascii?Q?0PX8QS864ocduHtem7b9Z1TS6I1VPa41jKeqcx/621+3OCzJk015IPH1N9iP?=
 =?us-ascii?Q?jDcEH8t7M10c+9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kN2pmrBwHtXZlpWcEVWtKTP7LQ9dqtU6Z+hrRdrI6G3tO/A1DExmHlpmMGKD?=
 =?us-ascii?Q?KbroVljNvj7d1qwRMUa+wzRna9MfXeydxdKkGmbs7rwOHH4+YEViq1IHi/ht?=
 =?us-ascii?Q?nFAqaUE8kKPQZ+9M7/JPa5GSvGs2EBGX4YVKwNJ75Uh1lqrucUEWkukzkxKK?=
 =?us-ascii?Q?OIm/3cbkfLupnrTpOQiexG2R1AtlsORq/KInv7v4dynnh7WKRrcVkxYZjOS7?=
 =?us-ascii?Q?yQoUT+53fmh2dnkTWSK2NaoRNdHvGOROGxfzz4QRC9fZW+4F6DaQCFMesijw?=
 =?us-ascii?Q?7jPfWRZ3ipSuq7IiUFy2RZe19D2O/3T3pJ6KI1k2jDKrAMydcQNGGZKss8+d?=
 =?us-ascii?Q?Dq0xEt7ZSLjlv9vr83nWlDzJyL9x/auI4JEOYT+WOeLGlFTadqJKIvjFqCqJ?=
 =?us-ascii?Q?aIRmWqYYMNhI6AYO+pwtoztAooVeu5a0FPPs9MQzB6BE6r9pVg8Bw4uotah7?=
 =?us-ascii?Q?74wwVZZcQPi6RKJSuauQWDnJB8wolyhEvS8ojKAqw7RHQ4SGArAo8wSR4fnm?=
 =?us-ascii?Q?hcENG6ox6IIo+I0qSA2Qiih38QA2Xx2U1vWNU5u3rZiPP/lxWH6y5OtBn9Q1?=
 =?us-ascii?Q?XKgfW2fb6MLNPExy5ZLb4REHiM+LeZXh3LtOYK3Oufr5cATEmXtcHwQ8if1a?=
 =?us-ascii?Q?YsOkJqirlbQvnWIcjACKfKzCA0FShS4STDxGVlqbptIAm56LZvLS85oDfGSU?=
 =?us-ascii?Q?oTrfzwEXWBMLDtn1T9xaLA3WHkZUzlvAk6opeLRqOZqZsqNJx9qw/w3p7Oow?=
 =?us-ascii?Q?Dv1VhBVk/8xLPgJeZ+Gzzyhq1/sgDhJUIxj5kV3SOzWz0N7Zo6T68ZBQrW4A?=
 =?us-ascii?Q?Ctdd64j5+nSr3KWPvO2AQvZS7Eu+lX24dvHO9BNkEiBFYmCIloeUe4UC+iJX?=
 =?us-ascii?Q?AfuTvuIkbr13VtVjZYm1NQfotFDmAqHlQH+3A0bqdqj35Na0JfKKTsb9Niqi?=
 =?us-ascii?Q?bE7+vPwm5dyV3NwukEy94UdWLaViOkm/hlokSgyJlDNjPvV5oMe69+hh1AZh?=
 =?us-ascii?Q?sVhKm7+9WIblSYXifBVdYE3032UIPPg/IkH2kgzIn0g9nLogEVCNE5SXtI4V?=
 =?us-ascii?Q?W7RLjBb6AKrWt8uJKmW4JQSYaaKoW5PEjj0LHgbChqKCpdFM7mUKk2MOZAAK?=
 =?us-ascii?Q?aTWgWx1V8sU46HqkXNhFO2ZiSNpFasqgwftxTufYgBNDSVfGxzeIRq8hwFDw?=
 =?us-ascii?Q?KRjNt31efNzMM84QBr3SkGsrOnJD6GazbctX7EJIIcibt4wZCbkGqYXjRP7c?=
 =?us-ascii?Q?jmSZussKrsN6Wj1HlOSkY32PCyawUgHDWEUqreG7Ov9YEV1qRMJ3+isyT+xg?=
 =?us-ascii?Q?vj0RZs2uLEqfaS+5SWnv6xn3r1ucNnId8sC1T+MUcYBxclqT3ysxtsa9arjD?=
 =?us-ascii?Q?0R/MSchtEayyP30NWNzHemmzuQSR7TRZGajuTPWNh7Pf8mtzOMGZYtWbB9xR?=
 =?us-ascii?Q?kTzfyXDqnMp3pw4wSJYquptiEryCU+ALffiMVvNqGWVqwJENyiwYvPFeeps4?=
 =?us-ascii?Q?LGlC+V0AUIjTCw0FSUbs4Ee1X/qzvjpLU/pn1gUnQCXNUeChfNikQm9C9Bfb?=
 =?us-ascii?Q?ghUVcn6USn7v8HiEqRCAWlSKcvxgIktLvr4ZxgVF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8310eb10-889f-4940-4862-08ddc04b1d6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:18:20.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWa/yv/fPhcdLR3TjM2BaMzCP5vgGUmrpn4uNIthvFatcVWahgCCmXGizBTfzBiS9NjYW4WfjYFbN7mnmH6pXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

For ENETC v4, the hardware has the capability to support Tx checksum
offload. so the enetc driver does not need to update the UDP checksum
of PTP sync packets if Tx checksum offload is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6e04dd825a95..cf72d50246a9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -247,7 +247,7 @@ static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
 }
 
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, bool csum_offload)
 {
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	u16 tstamp_off = enetc_cb->origin_tstamp_off;
@@ -269,18 +269,17 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	 * - 48 bits seconds field
 	 * - 32 bits nanseconds field
 	 *
-	 * In addition, the UDP checksum needs to be updated
-	 * by software after updating originTimestamp field,
-	 * otherwise the hardware will calculate the wrong
-	 * checksum when updating the correction field and
-	 * update it to the packet.
+	 * In addition, if csum_offload is false, the UDP checksum needs
+	 * to be updated by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong checksum when
+	 * updating the correction field and update it to the packet.
 	 */
 
 	data = skb_mac_header(skb);
 	new_sec_h = htons((sec >> 32) & 0xffff);
 	new_sec_l = htonl(sec & 0xffffffff);
 	new_nsec = htonl(nsec);
-	if (enetc_cb->udp) {
+	if (enetc_cb->udp && !csum_offload) {
 		struct udphdr *uh = udp_hdr(skb);
 		__be32 old_sec_l, old_nsec;
 		__be16 old_sec_h;
@@ -319,6 +318,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
+	bool csum_offload = false;
 	union enetc_tx_bd *txbd;
 	int i, count = 0;
 	skb_frag_t *frag;
@@ -345,6 +345,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
 							    ENETC_TXBD_L4T_UDP);
 			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+			csum_offload = true;
 		} else if (skb_checksum_help(skb)) {
 			return 0;
 		}
@@ -352,7 +353,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		do_onestep_tstamp = true;
-		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
 	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
 		do_twostep_tstamp = true;
 	}
-- 
2.34.1


