Return-Path: <netdev+bounces-237533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A3C4CDD2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6073634CF78
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9569346779;
	Tue, 11 Nov 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DEx9YKbA"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624DB345733;
	Tue, 11 Nov 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855241; cv=fail; b=CeZuoijZ+jf3f+peC8K1ro1g45WJwE3dul71SAPrtHQpeDI0GmKgOGNrgbCvbhisP2CHNi/dRXwBCP4BtscMaXbjvF6qMDxWWBTa7LPka8fUtnqMI2IEo1ZN0DgRYnsCJSTORogYVq4//vjjDQzSTQMAbYTNJ1cpUC3QfnNg5Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855241; c=relaxed/simple;
	bh=4FzeVl2h8opWldluNDKo3pIYa53btCbUpgk6A/BGvXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCF+JVLqi1vFMSSAG5v7LStVgxVKE4pyvipwbAoVFFC9ofjeAXUbTsmSUTnTK16TkDusUu41XgaVfLgYhEbKbGRa/aqZWfuxPw/jBHS1KPukEyUtQlGSHv5WWTzps800Pv0asp55SVWD4dKmBxwiyJM6wxLxBJPUGSZ75wi1jAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DEx9YKbA; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiGPYwWum5dE7vvT0mSvX9Mvnl4K8axia4TMV1D2BLq58HMShLTDBLGKQQqLoTM3Duq0xDGkJK5Ckn6gdoQbQ2xJhdBQGtbISj9ePZ7L3yGnB8CLcb52vAL9bsb7XQEX70NfV3Gn2KyH2QfX5LNCzsiK6u6y8+vGJ1Re25gOzfhxcllddBpitx/CDkm74wDouyCaJpDg4HcqNG0XBIXDUTUkzawKIjzr55h6sIr6gUo+U+q7WkFqWbaf8k0nsHVxIeLKExIIR622EVOTZ4TIbwaigtCZyIYV2JiKYaWOW0T6w51itJ58jUD/o+6VrtzVnpVuuu665ly1t2yU0l7QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76nKMqunUH0Yo7AsvhZ7ttV9zDzbysHhol3+pS9P5ZE=;
 b=jVFfuEWRNnGqkMdSxovC/4PzQ9LmBgzr7Sxkp3QNtay/GlW75b1BX8YCNjTiLLPF59qDl0HdDYmht6mhWmwX9wQrCMlQQzh48/d3N0CrNOBIUuynrkTYB0DXRp3eb1n7CPZvfuO4xh/Uu42UcHlP0joHqNe2GeJL7dzp87BmzDVyyM3b2RPJZI4zW7Hxz4goop0LeLruxFIwhRnWO0Nh4ixXnmK5ukyrHE2qq9RlX7hcEqjQqqMvvrFQ8MnKTNi9Y4rbrWRhqk7KNi0oFv6bFV2S2RsT07JLqGgCZBz2yETDbXKzqDgehAE0s3ZAE1/GOwhMQHzu78XglPfdprOqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76nKMqunUH0Yo7AsvhZ7ttV9zDzbysHhol3+pS9P5ZE=;
 b=DEx9YKbAt9PS0yiIS7AXEki0dBywqzWUMRaglqgrx/M2IdHkcg71pzw2U5NZgVuwIXH7mkTNjjhZ9PNtQrhKhSU/ZejT8/b/pRTzOa/qhXqmUszH44U4Suk7JsOvavv57fMv2xFynNCiRdu9R40ygnYbhdb4McpPYaiJFW4AUGW6APO2noTnr5V92dBHNHl4iPnb5CHhpolkoTyLktqdaTzi+CicIenhAW+v3Ym51UspdekDoBDV7ugeuGaRRX5afJvOykcCFkE4DKjBQHJEJVdQHKTUg3W7Bh6bajfWLs0/uhrvOPiZcmR9rdsvMVdKcsh5pTskgLMATKisIeHtTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7545.eurprd04.prod.outlook.com (2603:10a6:10:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:00:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:00:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: fec: simplify the conditional preprocessor directives
Date: Tue, 11 Nov 2025 18:00:54 +0800
Message-Id: <20251111100057.2660101-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111100057.2660101-1-wei.fang@nxp.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bdf387-9a6c-413d-1824-08de21092a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UdC571Y1K9FHd88/+xZsIEBLkAA6zxAtwUQ6QOMh3/rxbChVMi7tdRlkaOLX?=
 =?us-ascii?Q?dyhYZpEUZSw9Vn7xAoDxsth3R1FllVJjGTm2aB1X4nzcfRTkGj1JfFnmUmKZ?=
 =?us-ascii?Q?2t4Xa0rY3X0vXiqyhQrd3qCtnP5Op5KqMYAUbHmZSzA51WD64dh3G8zw3cIu?=
 =?us-ascii?Q?tO24xt3gkbiTwGGMZ+r59yv3pQWIZAr6Kl3luCBpGEZoe83f+htz4hxd4ujf?=
 =?us-ascii?Q?tY2+QYXOCGfNHAMRyMyd65u/IGaDItByu5enKRIW9e2fKgEQH5YL08PVwNO9?=
 =?us-ascii?Q?FwRcW9JlJwBgvkBgPMZMWfsVgCtepz1I9L1wlhGLUerGELl5wlqRFLlPGTsE?=
 =?us-ascii?Q?i1OGzuv2MwssrjDdnjNMQKcl5Cr+PTM36IG0ZUQ/HCZ9kEAsgJD4i6K7kB9o?=
 =?us-ascii?Q?UCR80YeW+0Kzf1Jsc2UdTPZ/6j8C/2Vj8VPEoyDbcQCfA34VnMoJ+I9azvzs?=
 =?us-ascii?Q?x6Y2lzAg0AevrZv4KGIYQXPbs0x3Mv6exlvVYVMKj4JsIXtaur490D7gq8hF?=
 =?us-ascii?Q?5Kp6Vw/bFN5/1qFRXvyWYfHJ4w0tcluSF2iMhXnLMM5uTt4GHHwN8mtPiNdV?=
 =?us-ascii?Q?CaPmFrLKvSSYv9yCTihYIpEtn8lKzRdmjPn/Fkyqe/U8FUochCbd9pjyRgVB?=
 =?us-ascii?Q?a06ENBk5SuEVodJXV3zeUqRyemklFvDsYrFPxlYYxGGW/4+CqMGb+Y0LCq4O?=
 =?us-ascii?Q?qrUwi8TKHt05xz27bB5fC1aHYANhBUnFeVmVhmsk1qYG3nO4AIocMwiJaacl?=
 =?us-ascii?Q?QC4FYkB09gJZViu+QHAwDMHrQnI1IuxsbYojiJVJgXSrLHtKwdqTmwBfeQ+e?=
 =?us-ascii?Q?lrlb2ufBSu4iricSCDZGg5ByLX+0guj1v6Yv2DQ+q0TdHONR2s2l5nLMerpK?=
 =?us-ascii?Q?7PF20bkM5PLNhkMBjSc17U2MB49NoBXpvRG9Ejzg0ughQAnPf4kvNt2j8elB?=
 =?us-ascii?Q?1SWDN1OM+wfOuj2MFqDlpuyPzklwa2Wauh/QeytFEI2FIl2PYUc30NpxTmm1?=
 =?us-ascii?Q?2qgAUZy/hWEWsnNZGSRYEYGOdQvyabMe/oB5dChpY/bGFBh7LR2wdIUGe3Kv?=
 =?us-ascii?Q?h+cmroik4lN25aXxrg0XIU1dSEGpRTatqKEdx25rXl+QDCfCgcyqXsRYvcS8?=
 =?us-ascii?Q?h0ba9nckkmRJDw/jcxkmXZbi5KTW56Dc705z2Xo+yNUYLosxdDlEuONUsiQT?=
 =?us-ascii?Q?b4SpYQ7WijMFSmg5bYUc3Pmh+SOyZ0GBpQI/uAPDLYWCKNyg2d8BPO3GSPdH?=
 =?us-ascii?Q?5anQm5KsKhEW0nrA4Z1f2wLkDcL9v640v9h6qLAQUJLmfcopHDcjieAC0LOe?=
 =?us-ascii?Q?y/6w/ESkzQ9ZZmoaPZ+hQnbvRGwKD2ZiJoZ7kyON1TWb9xDbTJuwNH3OcAoh?=
 =?us-ascii?Q?x6Gs3i9RV5Hu4kvpfCHip5mOJnKTfMT9k/ul4NN83S8IhZvTnWA2jTf0qVDq?=
 =?us-ascii?Q?QGU9J4urgpghC62pQpJqyTtsjDXvYunnOgTcYJkzs5iNaLEKqG8+Pymy4goV?=
 =?us-ascii?Q?eI8+LWoKre0O5X9jgCYfFmpWuxwDOb7IRCyM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2ihqeF7WmeYYo2iVnW/ewsKym+NQi35hjk4VNgc1YMw52RwNTs0c02bg/fo?=
 =?us-ascii?Q?mIA7Qy7vV73wFvNoNe8xLI4V9mHG47n3xAJvDwrFMMDFhnwT6xU7+3pM80U1?=
 =?us-ascii?Q?SJgXazn0H82kXmDOJsX6cF4IV8B288aBvmArUwrxqgS1A2SalEdkKFg3XhGl?=
 =?us-ascii?Q?Lhvhp4WXzJ6gZTTrAQ/G3wKLf1FsjFh5PUc1gnE9R1RGYkOWfYlSk8kFsaPO?=
 =?us-ascii?Q?g23OtiditM9bx3XaE7FIXAk0dYBJ8N+KyBijePlLWs6nynHpUCXYlrQ8Y8y2?=
 =?us-ascii?Q?jXptY2C87/uapMgL8DVdjny7HILwqdd7J52xy5o73me/EQM4xFkEC19FAxum?=
 =?us-ascii?Q?OY2D1eD3UUdGhxTOgpDUBK4aTS9yeJVkmZ8/WCWSsbYeX10U21ROl/5skuvL?=
 =?us-ascii?Q?GMa5eiSKKwgV4Ub3LPS4w/jIOa2/szWzunoI1PKszUjpLOMtRTFjLpo1PWvX?=
 =?us-ascii?Q?3+CQZkhxX3Msrs1QT7eRwk41MfRnouApwuJG416Vu9uSmVWBMlpTytJuWEeu?=
 =?us-ascii?Q?DPCqXVuCD38YDKPXccqcqwgR2lHWuq5Ym2gQ9sNrlJ0wFuws+KGu9pmyz0Rm?=
 =?us-ascii?Q?Fu9vuENcULdO8GS3rl5A9AiD4ZaRq0NERUv7/77iPZbH1pMUMmiH2bmn/MRA?=
 =?us-ascii?Q?QdaK/pKC5xuWd8iLlu8RJdSciP4f88RAlB1ID0GQtTmGfAdIIi4raF2CYfEE?=
 =?us-ascii?Q?s83RqGVN7Ln8WKssgQ7E8hXHc/s2iBS6hpwNRHbZXgHTMDPjYGm2J9d0hiz/?=
 =?us-ascii?Q?uJKyIHROGmE9ldFcrzeOYk5xOsccME7hDFBsuR+zkhMBuJ31G7Lppm88szq1?=
 =?us-ascii?Q?bQ3vXWtLrvETcfkhqiC8dkhNxzwa+xu90zRMYlCVSqiU5oox8tez+VaUJco4?=
 =?us-ascii?Q?3jcI8Via4YYIyzjLPBvviF/koV4zUJZ/CIh1W8UKGwSHhu8fC7geYkS6imk5?=
 =?us-ascii?Q?XPxQRR0Ap/T8zoy9Ms0NPeePNXRKSaV+zEET2h/tMyuSZJeAbWgHrVaAQq7f?=
 =?us-ascii?Q?sP5vd/Xqtc1WCqCFz2wt7Iybuf3lODWy+4rDw9LkDR+jvTSDnm8tuXJe8dPa?=
 =?us-ascii?Q?baUzsfTO0PQbEIOfy6mrS6+2M4ruT9TLjc4+7XCdqZfxPcPSHzoNu4Pp3YfR?=
 =?us-ascii?Q?wzwUl8SmU4fQF6MUfkokvbC6vfn7IRDsuvMfEAdRpaDjpojoulE3Ovn/ryS0?=
 =?us-ascii?Q?qIY1Tb8TTGUW7pOPKP2UuEb/f+Qtu3+ANYwQ/wAPiO8yhGuH18dqFZQQXOeM?=
 =?us-ascii?Q?WkneqN+38NAMn90R73I8SwuTP1ZzDptpMUlHdW/yP1aFV7M6k/h/E94IgdDK?=
 =?us-ascii?Q?Q5SPk4RW6zUYw+qtl/mQXM+3EGTZXCFmnQrX95O3/qLxL1jJBFFZoxYKoMpA?=
 =?us-ascii?Q?HMinpGrFQ+eyPdTSYX349x5RJKNSZ7o4253sXHz2lf9B33F/CSgFsPSF13xK?=
 =?us-ascii?Q?nDmTeZxQkfQFHKdcfOLDLwux5kPGusg/ndz1pu1D6dG6eCJI5BlbfDxfbDzw?=
 =?us-ascii?Q?OhLjxx+3/P3os/NDnBbNJTpkrnqnm9gS4Bt505+fPnLw7XET5eZmn3b5kfAI?=
 =?us-ascii?Q?Ux7lIz2EIFW0TOkrNmacByWAUDTI/FduavULYMXJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bdf387-9a6c-413d-1824-08de21092a23
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:00:38.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAZapM4lLf1RrxUP4wFHbkX0Wo3Hd47iRERv/Ppz9jrEhGloYgtLVDw9o6JN7e3VaFEHPsAsy0OWgAxWCC6M8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7545

From the Kconfig file, we can see CONFIG_FEC depends on the following
platform-related options.

ColdFire: M523x, M527x, M5272, M528x, M520x and M532x
S32: ARCH_S32 (ARM64)
i.MX: SOC_IMX28 and ARCH_MXC (ARM and ARM64)

Based on the code of fec driver, only some macro definitions on the
M5272 platform are different from those on other platforms. Therefore,
we can simplify the following complex preprocessor directives to
"if !defined(CONFIG_M5272)".

"#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || \
     defined(CONFIG_M528x) || defined(CONFIG_M520x) || \
     defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)"

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  4 +---
 drivers/net/ethernet/freescale/fec_main.c | 27 ++++++-----------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 41e0d85d15da..8e438f6e7ec4 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -24,9 +24,7 @@
 #include <linux/timecounter.h>
 #include <net/xdp.h>
 
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
 /*
  *	Just figures, Motorola would have to change the offsets for
  *	registers in the same peripheral device on different models
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e0e84f2979c8..9d0e5abe5f66 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * size bits. Other FEC hardware does not, so we need to take that into
  * account when setting it.
  */
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64)
+#ifndef CONFIG_M5272
 #define	OPT_ARCH_HAS_MAX_FL	1
 #else
 #define	OPT_ARCH_HAS_MAX_FL	0
@@ -2704,9 +2702,7 @@ static int fec_enet_get_regs_len(struct net_device *ndev)
 }
 
 /* List of registers that can be safety be read to dump them with ethtool */
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
 static __u32 fec_enet_register_version = 2;
 static u32 fec_enet_register_offset[] = {
 	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
@@ -2780,29 +2776,20 @@ static u32 fec_enet_register_offset[] = {
 static void fec_enet_get_regs(struct net_device *ndev,
 			      struct ethtool_regs *regs, void *regbuf)
 {
+	u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 __iomem *theregs = (u32 __iomem *)fep->hwp;
+	u32 *reg_list = fec_enet_register_offset;
 	struct device *dev = &fep->pdev->dev;
 	u32 *buf = (u32 *)regbuf;
 	u32 i, off;
 	int ret;
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
-	u32 *reg_list;
-	u32 reg_cnt;
-
-	if (!of_machine_is_compatible("fsl,imx6ul")) {
-		reg_list = fec_enet_register_offset;
-		reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
-	} else {
+
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
+	if (of_machine_is_compatible("fsl,imx6ul")) {
 		reg_list = fec_enet_register_offset_6ul;
 		reg_cnt = ARRAY_SIZE(fec_enet_register_offset_6ul);
 	}
-#else
-	/* coldfire */
-	static u32 *reg_list = fec_enet_register_offset;
-	static const u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
 #endif
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
-- 
2.34.1


