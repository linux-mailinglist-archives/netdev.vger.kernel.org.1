Return-Path: <netdev+bounces-289387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO5WG+g+DGqqawUAu9opvQ
	(envelope-from <netdev+bounces-289387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A33357CAE7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E923E31174E2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8C4C77B7;
	Tue, 19 May 2026 10:15:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2123.outbound.protection.partner.outlook.cn [139.219.146.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B94ADD98;
	Tue, 19 May 2026 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185736; cv=fail; b=tZbW/dATZ9fGL6uUdLEo9ukfZ2LbjPayUYrvT3pLi4vpdaOSA9XqTqISMSocXK0vSS3PZzNMirsnZTzA0I+omBrAvrqCV2yA0vIwSwnKjo/R7OYdO5Wy31rr4r4+IuC1IQYwvrzh2pzyT2TJ99EdL1alt8ZceQnT6I8cU2/6H8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185736; c=relaxed/simple;
	bh=j0mUcxa3YXViVZjHFUl4e44m2hYVpNgovueSf7m39UY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7sd2fLq94ouxPPy6dvkIhWtL7fKiOlEZSfm3zEl/KEDdhqLkc92SBWpk0T2rvd+bMPYEzh9w8ZH/WvXo197KY6pp8gWll6ZzQLx9vaVfXvuC6SuG4OfVcdtNPrXyY1ROQKasTJRz1ik47FOE8cWarnMmfjpxvMTBvjrJJgioxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVwfDh5Q/wOSAGyaZM8nzxT/E+gAobIvZsdvBKWxlTyIqaiDD2RE40Dj9fb3l2fOND3N4FPPowidd+/26L0RH+13R+CmwLIbm82WJTgoBQL9ls6rFs9qcGtJmPe5ei+7nxV4kusqBGCL791G5cqvsd3fXDlJASouLhbHjVyEFhxEhR41ZnatoagNagyB1tvvG2AIoUjkyzmv8Y9Ggyv173Xndaqbr0NYHvdrvKLYIC0VwGkweCNw1sK3Ei60ZJSywrfLtyms5C+Nkglvq7A8YfiuoTRN68+9ozRQ+QPNpE8UVg0vF2yWhwOSrIg6i7vo7MmPGN8mlGh+U2Rq8eg47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVXf+4J7WouPIlgZMhQMao9eTK8x3Mh5uCItSsR5/q0=;
 b=X4HH9fXtVi5Fa5NCsHciYnzv2pBrMP1FRNv7xr4NsDOsCSZjARwKxesRJu4s9BBzGskTkJCWjlUDWPYGWnmxXx+ZCnakvHFlsCzHFdSCBRdeWTQ3vjMjDTrqc9KpaWq3Y7Ab0kK+UTJk3IN0kq8ZRcQnvGcDVxd6M7nBckcT7u18u0rIzEWXINrs0qvjHA3zsYxxhrdRASV/Q1Mv/HDgBvuzYN5kwyBhvUwS278+KrqnD7cIkZJxebjgzBtv7aMYBFLM1XRcQzmR+SIOzEIu1D6y8UnhYYFjkHD+2xmCZco9i1G1QWW0GULFhy5KCIRLlZ3JwnkADBtezrLtt5AQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0493.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:14:51 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Tue, 19 May 2026 10:14:51 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v4 4/5] net: stmmac: starfive: Add jhb100 SGMII interface
Date: Tue, 19 May 2026 18:14:35 +0800
Message-Id: <20260519101436.111476-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260519101436.111476-1-minda.chen@starfivetech.com>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0056.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::23) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e524e1e-b2ca-4f24-f1a0-08deb58f7707
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|22082099003|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	jqQeBUT8o15gptGGbl1DULJKaCXigHBoJB7CIZDeS2ySBaglLiecyIgyNP2Ldo/7XtBczHL17tmoF3+Xe7hBE1f8XRR8PYgyaX6YtRVWCOMpT+bMON4cuCOKudpOVzB8D29AQixSZpLWV089kpsXkVqrmn9++jg7W7wsgQJvvTMOVf5aI1wS7zzCspDIR/dxQRQEIdclriNqqdVKBf1jEHKcJD7dvwztikK2SbbN5qpLwlB1sw/lAFwe/47FEKP/4g8RlnjuzpSZf7ZQwIybplA3EOCqjFee0718h82d9Ci2RENEVNsGmFsXtemaFxSc34lVJ5OmDT3Zh3RJ7hmji9ritlVEyTPf6pOWtde8ltgfYgmpme8udHWDRN8odz6rS5mX0gl43n9g8okxDM3A/7a+8TrNMnsCPAYc/zvKtcctWjJd/R6XwuufOLbB8KasE7U8vqdy9k2yRZ7g1XmqCU2HqKIezkNvVkksK7aV1Hee3xYGU3LP89FU7Up7KM4ouh8Ym2LY0uE1WqwrRBJHH/1c6uz3jk1241gXc5MOqDEYccRr6Nog2L7MeBdhRVWX9AfqL4JgxvVunKEgJmcH4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NfwT456LLuyo1W3x0ACd4NMU0PpcNoLm0UOxGGwHRWBYKyCkMaGM6yCfT8iI?=
 =?us-ascii?Q?eiDFp8vjRwn7sJfQwoL6y56vFXPOymXxb4IHtA6awq1Kt48+M5UB9IBW51UU?=
 =?us-ascii?Q?WnGRjmb8hhs+t/Pv+SBLFRA+A+FcI1PWoB0lMaaDLjp964Cfc4F+5zaQalYC?=
 =?us-ascii?Q?4oqUf/+TX8/TPkbmuWbRcXacACR9chjmwrX35rxRVBHGNA03kFHx7bnBhdSg?=
 =?us-ascii?Q?TACDqktkOd3iWOZ/4DYPlr1JmSQpTeSWSoZnTKvpoooHghxl6FxD+1gRGJVH?=
 =?us-ascii?Q?dmnUCAiztQ8gs4twdpsnfFXv5EZmZrrrsvuWJgWiWMhVdSL1RDvaHgwaxKNO?=
 =?us-ascii?Q?4ny7OSLlchJnEtOz27F+SkYLKHs5TcbdXecybB+dnoPGGZ3Z6CZkfu802By7?=
 =?us-ascii?Q?W0IIkrJYXb4zfWRzLkPX+6PlKi3bZ18MgiUg44BwRAyQCdJKK55h5RW8iZ4X?=
 =?us-ascii?Q?MWsRcbLElDf6wy6ZpuOY1irb58PVVWq5tplKlz86u2ZuSqLWJD254pLRlyXe?=
 =?us-ascii?Q?NNUkCRkJ8OalhQGy4W3U6+tEZipc5g1GaNFt9y6sHvbBREAX/R6vz53S70m/?=
 =?us-ascii?Q?VC+oeP5F5g+n8stS6TH5BXaNKoq7lig72GOTKE3cg6hVREw/7gMDGDMdnuLb?=
 =?us-ascii?Q?e96USBdaigmHVBmBOghsZ9tkt3CpfnG0boNnEL2al4KWtaH63N9kj3jlb+ql?=
 =?us-ascii?Q?k8uwip26SGUp381ZXnixHuTkz5z+aeP6QNnYjYFO/Y055AHB4we1pkfJOgA0?=
 =?us-ascii?Q?tSeJNVKXM4WOH0jgS15WWfV2AQoT0i6Ss6FsxVGm9rlDUsQhaKCjAU97/jU9?=
 =?us-ascii?Q?4Uy6aK66zsDnPEVfkiZ2y9yJLNFFNPWDlVXWtqmQmuHoGD3TU6kV2LEDpMfo?=
 =?us-ascii?Q?AKKb5KzCeq5vm7S3QY6muCQp1IHQH28wLDyB8FbnohsMiqv35uiZkyPMFobO?=
 =?us-ascii?Q?AKEOnxGCsKnZyFT4Z31Uso0c0VLeyCMf2Dj92Ymnm4cosAZsNVa2OiRnmS78?=
 =?us-ascii?Q?YdRWMSvxM3H1cKfxvx/l0k3rSRzX3wb2SUqe2im3pMwUvr9xDbtcyDVfzykv?=
 =?us-ascii?Q?LcMJxWyty4z3wYUS1eFowhfdHbndL+EmBxNVzjfeDreSsMXdAZfp/TRLUzhc?=
 =?us-ascii?Q?udHvXS1A863UzDLElb2R+fp3a84L8BxwRjPXAUR5DPODYoLVuLsDARs1haNz?=
 =?us-ascii?Q?SOXvTXpGo5R5qv41GNumePtYmxfs0CYniSyALzJH+FLhBE56xN50+9w4g0ss?=
 =?us-ascii?Q?evLD9WM9QotcFY9n9INpkK0B+SXi/Gr+oyCma1K0wZAGedAoj/3Guq82NqzG?=
 =?us-ascii?Q?y5Jg7CFDz4p39I0mjqna4QzB6KW367L4PiCfEJ4fhkbZ56ef0KdtnCITLg6H?=
 =?us-ascii?Q?766zS18RbreYnqIz6vYdf/j36C0ugKmpDrPalJz65dxGnHwoDkTxH0iD8MVA?=
 =?us-ascii?Q?Ixl6+Auh6JIog/JEoc9talmrdrmFQLbVM/AMbglRETXoxJUrfcAvvvI4oJzP?=
 =?us-ascii?Q?alK61xJ55/348A4HnMc7g9WXWqliOlTk3gPfrPMV+IIQggOHvzUfXK3OcX1J?=
 =?us-ascii?Q?Z6rpgcIpa4ZXQN89gpnvoc9A3PlrG4miaCCO96EfZeXngvr0KeVkMf17n59D?=
 =?us-ascii?Q?YGBfmdbbbE29cQ9w8/cvX3PxUlCUNcuoMSgBB8pWFew1cETc5IrTWqfjqStw?=
 =?us-ascii?Q?F/YzWQLtPW5n9EK3cWIe1Y8MQfYAvqVCbLGBrSTZtxOzXVgpkV88LO+yrSvk?=
 =?us-ascii?Q?wNO3QgZt4NXhTS1RQe1yM77YpBudTH4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e524e1e-b2ca-4f24-f1a0-08deb58f7707
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:14:51.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnbrTbZ2S4d7/JE9SwqX2jFT5Wn/tU1PaqIKV5CPqJEOUIwov+2FrtyDRqX9el4MTYmleZ9RgY3KTy2aFGQvHMpNoent5nXh3S2cuhmIRh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0493
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-289387-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Queue-Id: 6A33357CAE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add jhb100 compatible and SGMII support. jhb100 soc contains
2 SGMII interfaces and integrated with serdes PHY. SGMII with
split TX/RX MAC clock and need to set 2.5M/25M/125M TX/RX clock
rate in 10M/100M/1000M speed mode.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 58 ++++++++++++++-----
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 16b955a6d77b..eb882ec14c8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -26,6 +26,7 @@ struct starfive_dwmac_data {
 struct starfive_dwmac {
 	struct device *dev;
 	const struct starfive_dwmac_data *data;
+	struct clk *sgmii_rx;
 };
 
 static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -68,6 +69,25 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return 0;
 }
 
+static int stmmac_starfive_sgmii_set_clk_rate(void *bsp_priv, struct clk *clk_tx_i,
+					      phy_interface_t __maybe_unused interface,
+					      int speed)
+{
+	struct starfive_dwmac *dwmac = bsp_priv;
+	long rate = rgmii_clock(speed);
+	int ret;
+
+	/* MAC clock rate the same as RGMII */
+	if (rate < 0)
+		return 0;
+
+	ret = clk_set_rate(clk_tx_i, rate);
+	if (ret)
+		return ret;
+
+	return clk_set_rate(dwmac->sgmii_rx, rate);
+}
+
 static int starfive_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -102,23 +122,33 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk_gtx),
 				     "error getting gtx clock\n");
 
-	/* Generally, the rgmii_tx clock is provided by the internal clock,
-	 * which needs to match the corresponding clock frequency according
-	 * to different speeds. If the rgmii_tx clock is provided by the
-	 * external rgmii_rxin, there is no need to configure the clock
-	 * internally, because rgmii_rxin will be adaptively adjusted.
-	 */
-	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk"))
-		plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
-
 	dwmac->dev = &pdev->dev;
-	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
 	plat_dat->bsp_priv = dwmac;
-	plat_dat->dma_cfg->dche = true;
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+		dwmac->sgmii_rx = devm_clk_get_enabled(&pdev->dev, "sgmii_rx");
+		if (IS_ERR(dwmac->sgmii_rx))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(dwmac->sgmii_rx),
+					     "error getting sgmii rx clock\n");
+		plat_dat->set_clk_tx_rate = stmmac_starfive_sgmii_set_clk_rate;
+	} else {
+		/*
+		 * Generally, the rgmii_tx clock is provided by the internal clock,
+		 * which needs to match the corresponding clock frequency according
+		 * to different speeds. If the rgmii_tx clock is provided by the
+		 * external rgmii_rxin, there is no need to configure the clock
+		 * internally, because rgmii_rxin will be adaptively adjusted.
+		 */
+		if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk"))
+			plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
+
+		err = starfive_dwmac_set_mode(plat_dat);
+		if (err)
+			return err;
+	}
 
-	err = starfive_dwmac_set_mode(plat_dat);
-	if (err)
-		return err;
+	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+	plat_dat->dma_cfg->dche = true;
 
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
-- 
2.17.1


