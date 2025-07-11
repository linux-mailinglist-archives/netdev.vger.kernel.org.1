Return-Path: <netdev+bounces-206080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943BAB01450
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5171F3BA328
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B2C202C5C;
	Fri, 11 Jul 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R53yDDlj"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A961EF36C;
	Fri, 11 Jul 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218277; cv=fail; b=dRk6JHmUP8w9fToxNHnefTf13cIiLWW5/Ep4cBr3cv6FtgamaRO3FU2+pesL2+5+1MjqPxEnc6/CptTJrVnyGGFIyrsG9GXgzAn1ap1u1Vpp9fdYNMkAaXvAEAjImjD4Tm/nnW4OD5fjLHJ1uQjeQKfqYIQlYuX8GrI0xbrMJuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218277; c=relaxed/simple;
	bh=wQ09XO+5HT54vDAV1KulzGo9SFkIJ8RqyxgMYV0TaQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DG4VpVTOqyAfrCut54aHfgLCyILSkJTWhrLPCi/AbGd+LVMAYFJO9HF3a5pnr9cFsiTkH8ulgzCbS96IVhGU2VgPWgbJtCEDogTyu+rVUrpHDCkF1s7/7UW2NJOTzvMIiRZqsdqCUrfjCB2x0IQyJve+8fp70vwpewDyNG2nqMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R53yDDlj; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1qonIoHSps5A5uF8rdP7xjLcqxzY84JIdQSwOP3DVnbiwctCjqmw1MQmI+Hjy7N17uX7WhP6RtNSTxFvcxe2Xf9LSu+jaABTnWVPRyQ4/0c5y9ycBfzuDXp0rN1nVTuMUFS4anvnB9IWU4UpjzyYbKi58r0a0S6KpwpNU6Tlaz4RXWFC4EcRbeBcvwMmI80Q9gBdsA7n24916h9w28NYE0Ru+1dPJ5kIPF1awIShySbdkSxmkO1mHDBJ/E2TOSl3VOVtQJqVV/h4msQEGNbb+gze5LzuWVoEXkWjz0c7I5dgWqFlaj5hmgCx7+1ABMygPxfzJO7mZ80fF0qStJrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUFc8ayVBkQRLS5BB2rtikJU+Tle5Ovzrw3xvB3asnw=;
 b=HuFcEXRFfgrx1MlN3OiI6SJERnlnjMYjOOIUJZ5QHpcM5NiKYMAIYALQK3oFHAplUQBU7z+Mf0ElEsVCzyBtvB3FF3aQG5CS9XizF7lgyNfkc+xtrQRC9NxXA0KftgGiZTSSCunNuKmmuOW3MBhvpLsyY/3S9/ScVHWAiYjRXQcepA+8Qz2oVJEiqh0HgcAnMzMZhb9sZo8bBy8wiMueRgqqHrJDi96iFiKptOg/UZeGLAqaQh0HP2qGxO1whoO7DrJsVpXnnTxOsKdJ3UWCxiYagDDAcNl0+hRmgQIRl6yreHw66346PascXD5mbaAra1ucpwTcI+Wck6gknqYVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUFc8ayVBkQRLS5BB2rtikJU+Tle5Ovzrw3xvB3asnw=;
 b=R53yDDljrR3qTMCqC/8+D17yw5jUhofCYgoTPFHJVHGuAF5s0vpabTzMfchpTSokFtg2vQ/bdgNURkeAWAJcKVMbW5ltu0O4PRc9OfJ5eGOpNOKt4H7CcwKcXrKQV1eAkhDdVESiedTwt89IBIam6ttt0UrvkX4pXnzmkv8JFaaEyLGOBPbBAGSCjeV6klKuvnB+giwlaClr9B7OhcRNyjIiuZ5l+jXqxxnq6Rv76gdleVuk5Ve/3L+ZD9x/zN2nX+ZXQ+JuC9iFOetkKNP73rnPXR8HezHREgl3T60DVXB0K9jz8p5HqbzgU1li+9xqj3WJNeWhZRVtN7u00edM6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:52 +0000
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
Subject: [PATCH net-next 07/12] MAINTAINERS: add NETC Timer PTP clock driver section
Date: Fri, 11 Jul 2025 14:57:43 +0800
Message-Id: <20250711065748.250159-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1be6c64f-87c7-4678-34e1-08ddc04b0c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9oiA6HxbZ5l3Xtpnj4xw+MfHK9IPVknojKjpgCWBMr1GioGx8x8zHnXSeIvq?=
 =?us-ascii?Q?+ucPrTEaNlI22/gzEO6NKyNoyRK6SSPhLJY8+NEXseyQNltNq/cwskErZUwi?=
 =?us-ascii?Q?An5q9eNi3+R52d731rZGyOuSPGSYHkHBgp4wfrZfoBrFtn5Rcp2Uz6ZgB1/a?=
 =?us-ascii?Q?m3a2A/tyK+8RNEz2j3DzgSBuWg2ioSnpwKbtolbxifZuxr/qAOhNw3Of4DK3?=
 =?us-ascii?Q?kNJ3HRvCNzykGoV8TB29DpQgnCddE36C+CkLLOFdf8a94wSNmGc9QDKdCPEa?=
 =?us-ascii?Q?nfd1QG2oy4TSOmN/muvNeKQw/8JTHV1ATv85tT7JY+h23gwQs66q3iID5+I7?=
 =?us-ascii?Q?N08EqJ4QeR1OtDihTpx0CtNG85qSaBAdAD/8sFskUwL7/FefANc2zCHj6oB1?=
 =?us-ascii?Q?8v9wlT4jVZg7Ru/vFWmOvGxz0QZFdnBcSprS96RKAEc71N1iUT9h7ZX2oLiB?=
 =?us-ascii?Q?n6YLqk8ICqej+pktsA+SkrT/37+FwIR8nbVH3exqEB7tvnqAAQUFFEVWSfat?=
 =?us-ascii?Q?sg12B749kfL/ksp6ngvP96vNah0TRxIXqg3gmZCvJVlQ9XukefxUaAhad0q4?=
 =?us-ascii?Q?UYPkxxA2jF47d4t6YE/YLwDYwOEXs9hdLcrwbk6yJpv5e6DEX4jilTxW6NIP?=
 =?us-ascii?Q?RYlaDaToA4WHHEBNuZ75P0E3yxq3qscz2vkO0ZS96iUy/mG/keI+ek2H2xsR?=
 =?us-ascii?Q?y6H8ca2mCTwQI2JY+xTrMmSHS4WOJnyw2JC3uzK4zw3IrnOK1Kkh2GStIe3n?=
 =?us-ascii?Q?OyoEsRKNceMW0gfeGckvw/RoWoVv7XfbZp3L09hhQaMjN0NDHM+SGOIPmMQW?=
 =?us-ascii?Q?Rm3yLXzZC4rAgn5qOuon0c7OM527fmVNq+BsNqqsVcWI/Um2g4uTwy7+YhcP?=
 =?us-ascii?Q?To3Ttu3OkzF6Iefib3c/NZ/hb56gfipwaReH0hcptADE+YIa5q9Ddf2LDXsW?=
 =?us-ascii?Q?nCeEB7cx0DJT1qvJk9bG1fv3UOvHLmDUVBP/ynZW9q1ehezntSGdYSENZtJe?=
 =?us-ascii?Q?SLNjE/dgzwu6E1rcYge2T1NZnpoNIET9w0YBwWu28qbLundLWzM5dtzn0phT?=
 =?us-ascii?Q?4i4TWxi0PQXnuatoJU70KL2Ll5ck/IAsWSEEkrAwQm2p3KaHuTsEZnXgDZeI?=
 =?us-ascii?Q?xz2d++9tat+ifOhbEapf0rfoPwvKvrbCjiXDCG5TpJaGkN2oP1WYIaZlnMK9?=
 =?us-ascii?Q?4QoFHTnGoyaZfhVLLE0x5zQVTyteqC0/piX4KcEDgmMAVQjfQoOhdLUymDpu?=
 =?us-ascii?Q?7bWoR4cNezxMZadlJBEEoVn2PptivolFFTZP+1KtBd9iQwMKNOrCNVprSixZ?=
 =?us-ascii?Q?3gLo/KN2xChQn4/6WP6BEWVa5n/RefG8ulRO840inuObAKgO8OxhwtnuidJX?=
 =?us-ascii?Q?7ltkHv9h10MTojh+w6ncVOS7AX0qF6Ri9llW/8akL9DKd6yFO66xR2TwHN2O?=
 =?us-ascii?Q?WzcqIjaAl2OPJSl7BjU26erBkR7gvII03TSbGkrHyDIxQHqj0xlI7lIz0jOa?=
 =?us-ascii?Q?nvpDN0fbyJEb5/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0UhIL38DTGzoSUNJZaESO+33AOHdNOZNQmSfs0kXGaTUlwAPw+PlXaX+NIfk?=
 =?us-ascii?Q?UyWq9ZyYp3bHN2MQTTohj0MYnlxUHp2BIIj0DFqk1jHbJs0Z/+apMTW4m/Lx?=
 =?us-ascii?Q?KHRcsJ1rPx4ngLKwvEeeBBPI7QDXYBf/dfl06F51zG+CMRHj8CE2r5ciQ6zI?=
 =?us-ascii?Q?sxHrF5pM9ZT2drNMRBZ/imluznPgIWNO7Uy2GfZTUeCC6g9rQMC16g6/l08M?=
 =?us-ascii?Q?vqiRc6XsIXyyUHpBP9HSqxKaCEGlrOAdlOkhB75jIAv5VNZnbIXGR5Z7B0fX?=
 =?us-ascii?Q?HQvLkjl+G6s5DZwhBMkiQ2ADxkOluxLJV+3L3FrkVLnhJERxOA0kuFzd5wiq?=
 =?us-ascii?Q?X27TmGdLcIIWGhEhe1NP++kr0EywDSUIzGw9UAKGrLDx88xH34HWUNMVsnhC?=
 =?us-ascii?Q?SwFTnHVyGgQFD+bTOg1QVB8vz8fqOB82tLg/2X2z+9CU/AZwhQ9zdbqEHrUQ?=
 =?us-ascii?Q?rgEgjrq6a9Gb7O952fjlrdTKRZtVB0rQxVDZAivtw+S6WWXI6MLoaLOP9kdt?=
 =?us-ascii?Q?LEWUKjpfU/8kUZ4MjYLv6GCQOEnl8xoUKqfr/M1bM+kpTdQiHXaXR2RHJ8Oh?=
 =?us-ascii?Q?lOwJhteR91lgKc9tKwcUoTDyOxvUFg2fCkxVBrjhZ8Obfk1QoC2wvZM8FDBZ?=
 =?us-ascii?Q?1vz63T5iupTSV6fsghUMtB4A4s1wpeCsUUemVWZOxeKIMiRlGw/FCvtx4Ce+?=
 =?us-ascii?Q?xp5QxFaCM3R0/4vhwORUHZI5Th1uwkIo5ISF3GoDJ94YQm9RMw/R+s1QhUi3?=
 =?us-ascii?Q?O8aATjMK54VuC2+TK+484YxP3negdYvly2vTYeVbVin6pp9JRehJVEH7tIrl?=
 =?us-ascii?Q?MvfgOY5Ayjf2m33PtWuDbBrKkhokyzQvukLvfq4w/h9HdywzAN1WVfRXxBJB?=
 =?us-ascii?Q?C8HlVaCV7JhiRan48iS1xvFXGUYPSG4IGvHAsdIKr1mxjRS2L9nTDMLJXg2b?=
 =?us-ascii?Q?9b/vj8p7trBDu8SjuvWes8eE9oHprZII9MEHxHGAg7ra7K/uvA3GwM7Jz0/b?=
 =?us-ascii?Q?6P7L7VSQOTf66NYLTsxrDe1hf2HiffACBDGXx22XF4Dv/lqTkjk6itZV/qTs?=
 =?us-ascii?Q?ZlINgS9yDj0CSZpgKoeUa/ZdrgIiXH9gntgfunkunWg/1yahLLukxow55eQd?=
 =?us-ascii?Q?LV3H5EbQZ8hxmyk8lWxTP8uhVLRwIDypO4oM2qsw5JCE9TJmfmO6IXIE3HUF?=
 =?us-ascii?Q?o05lEB3v/aK+C24jq1RRwAp5+Y/yLDcjvIQK2CO5IDWMuZXkq3EpXqTNWSiD?=
 =?us-ascii?Q?jFzT/BRqIs8jnYFUB9BnA/aV/JQ4IDJ8wxTDjALx9keMzmqYNfQ5VvqLHTaB?=
 =?us-ascii?Q?afBZTfAiYXe/aXlRoVjRkKijut3Jaql3sxD0p0Yiq0YgIYrIRKN1KykeOVdd?=
 =?us-ascii?Q?nPBbAf7r/02WW/ierXAJJUAGtnrXP6kmedTwTr7DpfDio6Di1mT+wI/9A81i?=
 =?us-ascii?Q?1mTRRTAsfgaFpRtULhz0yhs2nyDbxP1O19Xcdagk7bsYalebCFBxJwfwMKTk?=
 =?us-ascii?Q?+c4z0qs2exikWfK2VGxzV7QVNomQkbZlWDLKv6Rtv6O2OFfoPL/t8OKMkl41?=
 =?us-ascii?Q?kvYmZFrB5Qvf8aiHNmW+wd1SB7MlIiBFNRvpAan7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be6c64f-87c7-4678-34e1-08ddc04b0c45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:52.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5qrx36Lp6mqegPJUdrpgFHLEMfQtkV28xrKci5PnbVHJRAl0vI3laI03xjxUZboHTqa1zANKBNS2FTCQSnhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

Add a section entry for NXP NETC Timer PTP clock driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1554f33d0ac..dacc5824dca6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18005,6 +18005,15 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP NETC TIMER PTP CLOCK DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
+F:	drivers/ptp/ptp_netc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


