Return-Path: <netdev+bounces-110692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47C92DC39
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 01:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0451F2375C
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670115A85F;
	Wed, 10 Jul 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mzpdnB+F"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013028.outbound.protection.outlook.com [52.101.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA75158D8F;
	Wed, 10 Jul 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652511; cv=fail; b=cTRoKW0lXqgvK6zreN49HMQCG9csuHC1Frhi3G0vJoB5jIYMN/5wLDlqEx1wCOPmJ/T72h+ktoD1wS95Mjk+QJq9CfynjVi8yYOfYSECFBXPnli8ZlO1q5LmpW1TCJRw/3mSmvVZuoV/ONgBJ0ZSTv6QNZkfJ3TNJ+JGXGFXDB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652511; c=relaxed/simple;
	bh=yqCbocuJTcY5fY1ymmOXS/wzclkieIcosqXkK7+tkFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+wcCQHjgnzzkYGfDQxH9BSNL5veAFU7VPLvhh2BeFj5qv/JlBbL/Dp3HuT6vMEjbEFXJzs/8hLf8nD6GmgEreY5E5Y55hS4HoHhJsWO5HuLtE74MsniM3q9TdfoElaP9BISBxIsx+7AGuSF64rzrGIdPLQbwOPn6ANQoDD3PkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mzpdnB+F; arc=fail smtp.client-ip=52.101.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpFUTFI2C/l0jnTf1a89TK1dGwVMFWqI5WZm94BYGGOiRl2WdwLQnw2zCv5xE2DCJZn/bJEMNs2SyiRvopOmhK3czOf2fOMVQMv8hpTqMuScuaV19U89ihdFyToM6Kv652HoRbEXEDlS6w/Jt+e7zrEPVahxXovlP39+qJwSKMuM8SHGd4B88hrlAANpG/U4g7WoOwnyPrOzYjADlOKNpyp1vxENzhB1fws8mmlUaLbsjxjg9+irOpvmI5Y4aemqUPFZB+B8HtcNHI4+mmH8W6rLURwR67+U4SW1hRdVcsk9h/FoF8vA4rR7zvlUUViuwyfsABsC7D1Pkj2xNjbQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK0sDcCs02s8klvKJo36buqPYOhHP35At8avbExFQ38=;
 b=Snms6XVN74KWOc9RSX1sV0KAdkdA3usxsHu6duAWWDugtIR0AbhFXZmqxkx5Lo+m4DqpP2yx+h+Im9mmud46gU3/7SUOU80ONWw3OGpR+/AYb/qCQ4gZWkF2DOxoC+PVjoIVdS8mCKia0dgLm+CpNBwe64LQ/c+zRP0b9RymWMZhjzx9mszs0puBoERE0LLj2ibG3F3gLdOauuG7u44jloeq86rbLa8jQsAyPIeVNcwYxKB+uES4LffTsUIgNP9T0R8xRtnNJ9GqppWmm6PQDA24KQ1QwV7h+WLdNhYFZOHg71QMLPa4EAcYBRPNlFrBbeU/X0Ef2W91KQTyueD/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK0sDcCs02s8klvKJo36buqPYOhHP35At8avbExFQ38=;
 b=mzpdnB+FkKqzA5KYI8X7jOmWKZYtv7Onazx2F93PX5z6CparBsXXl+JolN7XxEQyFPUe/gbw82JDQFinjKyFmXO0hZ2kKnrGmoxpOiYFJsz+G91tNmXhP/ISybqgYyFwvCa3FrBuCcuHYmQ6QndLipeLVU2JQgO7Mbu1rMF/0KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Wed, 10 Jul 2024 23:01:38 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Wed, 10 Jul 2024
 23:01:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 5/5] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Date: Thu, 11 Jul 2024 02:00:25 +0300
Message-Id: <20240710230025.46487-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710230025.46487-1-vladimir.oltean@nxp.com>
References: <20240710230025.46487-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::41) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 35464288-2b3f-444d-e3e9-08dca1344160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVbp6EwsvQ9Bz/bUCLEifGXCGsiKaG7D/+vUZAOXseqrU5V8f9cQl2Lr5L/O?=
 =?us-ascii?Q?ldgxx8A6yotPSBGy1whYdA1TH5dMVObFHomNeh0z6SMz4l1SqMJMKBOo5SPI?=
 =?us-ascii?Q?TW1IAx7+zMKX9m6nQrnIpWQ0v7aPsduqjR1nF9w98FCoVSzr0ZEpmcQl5/++?=
 =?us-ascii?Q?hjFdY0SiLxhb9h5yFXM26Pfr93EieylhgpKK9LtdgG7uoIgATMY3AKF0zy51?=
 =?us-ascii?Q?XKd+D5SUk7ZJY9l9QCe1pdFFSFEINq/6mEgb7qE5Rz1FKDVnz+KH32wncHYl?=
 =?us-ascii?Q?oSdZNB2myoLLftrhqlqV8cRrfH+7scJ4DpavKiyHkFUUA73YlmFipN3IgqZX?=
 =?us-ascii?Q?b5ubtoTOw+fVm56Z6FxmfrWuAPcKMyCMCGXOmWPEuRIIgPYeYF8UNYXhQw5+?=
 =?us-ascii?Q?tfNcxxEX8WWJyUkQKgfaJ7lCQUREhxji9rDft/mAjF1VQ1mWd+zx2yqYhAxf?=
 =?us-ascii?Q?5oUhwuM25CUzMUgw30mZnQNmIQSanaY0lYdNfaXCvcMjOMf1B5mM+CwTwmVD?=
 =?us-ascii?Q?QzA3lVx7v2c3/JBYQRh8mRNQ+X3omFxhoCfxOrSEi6fvriaATbki7UKBZXcO?=
 =?us-ascii?Q?vY3dQwgqYKiBi3t520inJuOwU03nRG17ciZzTh6Uu9Ub83BXBmh4wwjs8UTF?=
 =?us-ascii?Q?qLX0fLS1jHs9W9tFpZqxN1jjYXsfQvrQJpSIovL70k7ZpgvEpfvmy2BBQiev?=
 =?us-ascii?Q?attIE6ZEZ6bvvDQ4sdpGClCEtU8aHxzdVZDRH9dh2kDIoWXsgVHgumCD874f?=
 =?us-ascii?Q?d5FOjWRj1su/TXYXw3pYqcpjZhhIvGFn+xZ28DNeTy1GE8uiG7rx0n1CT29/?=
 =?us-ascii?Q?wkSVdR5Ddf75LrSpLxn+q1MgKt3k+NQi+kQiudPsgUqoLRxsVdzHe7PNDsCU?=
 =?us-ascii?Q?LPQM8kP1b7WDyjeLa5/oDSYZqBMJMpjF2/C0JRczy3MWtsn2sdwhr3WFtlc1?=
 =?us-ascii?Q?ifxM9nnU6+m7b8FHchPFtqn9NACN94a3W0nSjizS0Ig5btb+wc5YTXeucktv?=
 =?us-ascii?Q?nU9qNaLLp+xIVFLeplYFM2XPzOv0cdUO6gGgykRL8yhC6DTUvXjkhvJxnM/l?=
 =?us-ascii?Q?DRo6jXAoBME0PVL7qxwa2IiI4xmXmdokSC6n/GygYuU6WW7JQyk+Zl6DPcnp?=
 =?us-ascii?Q?IWQgWF06A0SY2+dfdEVgbKo4tilHHSZLvKGd+faC/DcVl83UIoX2cAM25hv+?=
 =?us-ascii?Q?9zxCdrmkU4K76wxOEOonU/vJzNg5bX3Mh4gvAieFAo+XGTH00PSPUqCc0/2l?=
 =?us-ascii?Q?ulQh+31gBp6X4mpkznFpAWA84/ifB5RmzP+mYK/ff1Sr7qiwTNAUrF9QpTRe?=
 =?us-ascii?Q?S9Af2FNylKfrfgmN5UowkII07GP0qSJ0riI6Oo9t5cyQQt55JXQuhxwD2440?=
 =?us-ascii?Q?nW+KKJyoxALUTHVqf3IFLfdmeN/ia26TxFVYwdjoUwyj+g4Zdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mw5SgrDyJSZmjLJferkSQCQDzy02Ux3tt+T6fFZU7Hr/D2X44ftufPPfMaxE?=
 =?us-ascii?Q?qOHyvAwzIiCnBfOo2/YYliZAXwVsFNzeFoFPUv9TxhOnKlegctMWd8cpxUq/?=
 =?us-ascii?Q?Owy3FvstoMlUxIus2z4Y4fwPCpyZVw+2Vayc6Sp8MrcB+jHwcx6ruXS1e8ow?=
 =?us-ascii?Q?92ZB5svwiWlAWELk53ExD+4+TdrPKRLUU0YUa9rtMWdSkZ0BWY06HedY+PQM?=
 =?us-ascii?Q?+igjcv+Dh0q35WTwUopvUKPLiYFFfHCuzgHmE0ey5UWtyh1AhFxdIOjwbVpl?=
 =?us-ascii?Q?lhzBoSwSW/IqQ+6BDNG67dhHMSjXSHjCzToWrM6Wcehz5sRs5Jutyn+AWMWX?=
 =?us-ascii?Q?WzUAHwJiz4cqqiuDDqbjjz/JF50E4B9NgqRe1ndI/JitqSS4YIEIVcSDQPPW?=
 =?us-ascii?Q?G7nZAgEebGCBWCn4O6lxZWMzQwGiiqrngsRpV4N80KAdG4/nLry36nBT+9iA?=
 =?us-ascii?Q?7S1hhskJZjfI5AAaf3TMurdTC3x28nEtilx7DVn69jf8BhzBqtI9KW48yXwo?=
 =?us-ascii?Q?U+Ult4z506OgdOLttJ8hzFVWbb3kRNu9LNFWHlUcF+LExKaUlMrxSSXAEdFB?=
 =?us-ascii?Q?g4fVAWWHTekHLg5wryHlBdqQXh/q3fgz/6wxPkAP1fzpRJVKjDNyydUVYXAk?=
 =?us-ascii?Q?Png1mX/+xkhr6LZpIF1rvc54M0pIUxWbyrCiTqQpRsRIcxQ8rhSB/Hhn4yXC?=
 =?us-ascii?Q?B3fuc2zSLYoQMcctmB3hlYMaEFR5AP8DNk6D9tgKHMb9Y3xAc/6SWe+KoScp?=
 =?us-ascii?Q?fTVfzq/J0hfel9aSaeJ+zzQOalQ6sqDtXce/F/uIqXFlAw8zjQq6GBIQA98U?=
 =?us-ascii?Q?MgYWL8IFBnlFPRBlOrcc2Tp5BNLg/jdy1+h0MXRwWrHruQyIIH1XcXPD+ZsR?=
 =?us-ascii?Q?8DaNxMWyIEHP9qhFCMLclh8ZEa5B64/g6NylzBdPahzdqGekRGzdUvzHw6Ji?=
 =?us-ascii?Q?bLHD43KV4ThOqLBOaZjslDRA+jR3xKJ+mD/Z4+f4c+a3KxooopUTyi+1rvg4?=
 =?us-ascii?Q?ySQdXCkziMUy+54wBx3D+rIri8qEfBBDBEmQbRMy1S53V4hNvuLVukPP53iv?=
 =?us-ascii?Q?fHIiJDaYrPIoEGzttZfmlTDXdS7fNriuSVggzPDsjyHYFMOA00yvcWjoEsCm?=
 =?us-ascii?Q?pn+ehJO0PstCEAInyShqmvpIvu7aTb3GJs2grq3ZuKa67Uxe6uMVSm6r+zkU?=
 =?us-ascii?Q?GNl4dB/0prbbzCGtGq6WISi/GuLMNDGVo18bYMA6yqKOdWSePCsRwBvo/kla?=
 =?us-ascii?Q?CtbhNFE2btKX8eyseSG6YN/xAczgT+VA3JlAg4NAm7DKtRyEx4i4y0Anf55u?=
 =?us-ascii?Q?YDnz23cHeuenW1TvPg7utXbPbfKmbjUMJEM5NDHdx0l8IaesRUSXxKps6JTR?=
 =?us-ascii?Q?EtXpMMy81Ivf66MUGiDu29EWJqP1lGR9zLLhJcIylJpadpcAG6JjV3vCrRRR?=
 =?us-ascii?Q?3DQrxPC6kJBFwpEU9XgGtih8Jgi4ovo96+7iv8laUrN40oqo5sWyMdx775X7?=
 =?us-ascii?Q?y+hke258+tY+C1A54YRDakXBZziNcDjmY1m4+cdIUITXpa83NllmtlbWf/vp?=
 =?us-ascii?Q?D/joszsV9jvjLnNaN6ZhiTQ3JpQYQ4d1tc8705fOppPFoc07qs1pRr6xx8gz?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35464288-2b3f-444d-e3e9-08dca1344160
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:01:38.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AHmBsdTF4GGUCeDTQe676mWGff8xv+csDnnLGxZ0R9gfbRqs1pE+IuMlusIoT+CA4/zfUcsMs/d78qelwa86A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

From: Breno Leitao <leitao@debian.org>

As most of the drivers that depend on ARCH_LAYERSCAPE, make FSL_DPAA
depend on COMPILE_TEST for compilation and testing.

	# grep -r depends.\*ARCH_LAYERSCAPE.\*COMPILE_TEST | wc -l
	29

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/soc/fsl/qbman/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
index bdecb86bb656..27774ec6ff90 100644
--- a/drivers/soc/fsl/qbman/Kconfig
+++ b/drivers/soc/fsl/qbman/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig FSL_DPAA
 	bool "QorIQ DPAA1 framework support"
-	depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE) && ARCH_DMA_ADDR_T_64BIT)
+	depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE || COMPILE_TEST) && ARCH_DMA_ADDR_T_64BIT)
 	select GENERIC_ALLOCATOR
 	help
 	  The Freescale Data Path Acceleration Architecture (DPAA) is a set of
-- 
2.34.1


