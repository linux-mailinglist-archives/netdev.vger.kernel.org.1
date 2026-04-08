Return-Path: <netdev+bounces-276452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fl4NmU81mlZBwgAu9opvQ
	(envelope-from <netdev+bounces-276452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A23BB411
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4093014662
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27C0382F00;
	Wed,  8 Apr 2026 11:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCF212542;
	Wed,  8 Apr 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647164; cv=fail; b=IDnnzsISj2EelwBu8B1mG/frx0JP9YKowinHSWdOVqjaknmZ3zuFHiWncCbBpXrJbZFBMRolmfagdSXyIvnjVygZ7TtBY0CIZN810bGj41eumVsqMlrYuQkwHtQ4mf8jmWrLzeC5url2qqpo04XOXoaLKMJJCPwiZZ4sSF1M/UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647164; c=relaxed/simple;
	bh=tNAW+shbsym8c0+bDYiVrJvYNzp7EIUtoQY1t5o6Z7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7vx876kNiXyZVZZr3yCUFvgpumLXZ18+W4h6/9pPy8M0QUXPHINgq2haBnHlrvePBWNN3ETMJSQxaFxJggVVIEr4kqgca2iVJsUhXipQfpERmbhIMHeakXW/oQDHKav4AoxDxP5JYrWEySzMwlFbhVydPnjO9Z4DBLigvN1EXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzelvsUVhgMEWq6nXlAZbq79xruTyIN4JmXNy6IlpmIPAehr5kjPvsZ3uERsYxsRcckF/vedO2yDu+NMyYacO5MT4xohhBGZWvLLgZWwHxF+W+6iR4mXcKK6FztIMpr2FLK5PQ0XRU3oX4FnHyy5A6BQAperXug3sraK3TjIKW2nA5YQG0KmrsC8FjW2AjEYZJD1uDeFNh6ruxguRaPmh+M/kciNVhfyeAoRiLWgDX0aZboFqLlg+30LtyWxCrQn5VlxNl7EoB3oQI4DomiBNQJlzepqsc4nv51/D9jwBe4IVWMWno2A4uAIS7Z/ojKaoZQzNoRnJITYMHLrWY/NDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxnpck7TrVA5wMP2NkTWH/2B/ZaP7UQX3MOJvDE63LM=;
 b=fjU/sN1Zsfsz8Ilk90q2E8LnP6WKw8OuGVjLL1DWIFTRnxo+i9IepLdLlDZ/dLkL3wsaIxyOm68zoyctBCWqupGxBd9hckG6tbYCJZB6N8Z01yk7KQd+EnPr7B8NMSxWEQ7sWlHqF5vablFsmsvX2DOaRrQURH0C+UWQKpcaKq0z06NBhNPgjBKrBoZd6hYTtTcMVZywbQX/vn6zD0LIiUmp40ybipVahXLiDsRh6h5aithb6p37XOOpD0weyZIadLQf/njud6gidq3pE4v/TXk9k9WnpH1VvHkb+nbuf2kBKR6ABjUCSUDSO1ISTaEH/WljzPF1CAZHdCsTVncGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0719.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 8 Apr
 2026 08:44:30 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Wed, 8 Apr 2026 08:44:30 +0000
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 v1 4/5] net: stmmac: starfive: Add JHB100 SGMII interface
Date: Wed,  8 Apr 2026 16:44:15 +0800
Message-Id: <20260408084416.29753-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260408084416.29753-1-minda.chen@starfivetech.com>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9d1b3e-e680-4497-1c8d-08de954b0cff
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 PBbu7FVSdwA5jqkyNFGLZ19jX+Si3dlLtV3Suoj/SEZvJI0tgJxgfsxV7Bp2hWQMOTnU71pj+Ug5xjXMXJrHhwlXpLLnK0sPZaUnQRWZb/B/58IZRqV2CZtXgdSjVJdujd4stabHk2aSBB9++dlq0wDQ2heY/sn3UmaayU9ebWsmLI7Un8WriRW9RDtPrV7f48z0rbhYT+HQPKbPxMlUO332LRIBavihrmDskCnW565j0QfI7IalleMCDsHrH16L2+PPGHzH0YCEouD0SbB2w7OIJn1FY5ylW8wgm+G6RKZGARZsEL7oB4pKe60QENZ8E9hw5vMIEGYg6d+3PPYRh89bHbsCmI2Jd3htYgBE4wi8NtnUQtdoZeV/0SI5Q53MwBerj+XKXVLuyMTIG6anHCRe6wddX/oVMKs0GRJnXlRPHu+0PXsbTHYTdgn9gX539dYa37Zw7KoUgBXIl4eyWcsoA2HtAdydDsVzQDj+l5mvogK2Wb+IYYDJqR1S/wwQqUElq6T/wHAfAFl8U4s9zuuWiYUQprWvnuZfBkCJym1A71DDQNkzmIvq/WWBvdtZQMnkv5le8NjgTrSsoq+DzOr1yC19qeOKmmKEudEPd6w=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jfV5NZCZx0l9n6nC0xXvbkeb1hM5ibgJv4Xi7QD5iteDRCe0OJD2dJMZv+m1?=
 =?us-ascii?Q?KsWFi3N+y/ut0HMdlOb9XayFnG1nwn63Qug45tIiEVPvCHGtNBH34hNgIZqb?=
 =?us-ascii?Q?Ha6/BMpS7YubGc+nrH7GYQs8bQD4KJLrZquUYaNIWMVi+fAIuEMwXYuc6kw2?=
 =?us-ascii?Q?79UmksinX7fBeZduX7qwwHeEaU83S0rOqYJ5N+n2gSyKon/2vXbvgZ0xbMYI?=
 =?us-ascii?Q?Uxh+jz14RgohMAhDq3FlR8AcIQLwgp+9yDkcO2GTkGWMxlcE37zPRjz44tVs?=
 =?us-ascii?Q?28ySDsgjJUqbKPIaaxjxO0VRQ2ooCuJCYbTmUlyEMUb2vtsFEQq1gPa34Hvt?=
 =?us-ascii?Q?cOylNojAoNinxcVvm1j5avpESTsP/vcYuD4Jbl1VNj5JCFMbC5DAt6iDXvGM?=
 =?us-ascii?Q?z+gOfmLJpWijjVXhl4JnGWZ+yOgZ7Y62C5I8ubdm3RtjkpIqVhwrinahaZUC?=
 =?us-ascii?Q?iMT17dN9doXcb2oS2w4e/pYLh8dxN1YhJQuNOB4TOFCnCm86Eo7M39iQ5FbR?=
 =?us-ascii?Q?SNmz/hKT0aG/SpT0rhz+XSWsZzXp+RKFKS6xOvnXp+PZxBw4vBeyjhiu0NsR?=
 =?us-ascii?Q?TkatmGLkOYLfwL93VoVuds6/n3TBoZhBfMGxcDgUEilY0idZWxXwjCA3eCaR?=
 =?us-ascii?Q?vVl8S2iILUlUlyEDUsyUfbLQS0um4m6S9qPTxrIdxQuGq5olB8KYIxnAbrWq?=
 =?us-ascii?Q?+oJQVnlG5rjITEHIMMocP3raC3c/C9BNy7cT0fXIMelGKFMdbVJc0fQjzDy+?=
 =?us-ascii?Q?Mdn3eSpBfKW2ivs07wM9f2ZmhviuBDMV8WXuDQLrc9Vd0fCX/gxvoXmuISY5?=
 =?us-ascii?Q?iv/m7To5aMk6wotinH5+as/2amBkOlb+wPFYmsgkgRmtvcnXRAbat0cRL9rO?=
 =?us-ascii?Q?fuEWxVUpbQo8wC/DvAerXSVjjMydjhGqy5k/nVphqVwkiz0eqXhPO3jELAvW?=
 =?us-ascii?Q?qY7qPToqBPNyf+uCQDOcjOz3DL5RffTGQo1hK5xx8zzeHXPyoYs+Jj0CAQav?=
 =?us-ascii?Q?KfyyQwsM6Sz3ooyv3U8YRPkHw7PiRCHjhUnk8P5aBun8eqRxFJlXtOyeUgPG?=
 =?us-ascii?Q?yNUvg3KqcR4mFFYrXzQNd9CJMQLeh668D52RQtKtusNZ04B+B40VzvOcjFLn?=
 =?us-ascii?Q?hNVRNPjJDbqNhMewCI+Aaani1bY1Ub3men0kSq1GNkLMYNRisF//qKRXrRxG?=
 =?us-ascii?Q?0dTX2/W+3fF6KijwLgx58WLehnS4tJJ98RZPB5MnIYunq3/PYVtK3K7Wj15X?=
 =?us-ascii?Q?jCHC38jEyvuE7+8SEwPz5EQSV+7gEAhs+mVw8MDyKIZ9SDrZ7/qe7a3ZKEtW?=
 =?us-ascii?Q?c62xhBbJeXPAXi7r+DDTBJf857XtvCYU97jvZkYvU1K/hvFUP9aXP8/3twdK?=
 =?us-ascii?Q?+bHw7fLb0E7wy+U1UyaJ9KJBhM4ITy8vvXFughKIb9xQuuDvWFBVcI2WFCPf?=
 =?us-ascii?Q?ihPF4yRYY60kpN/CgguUDKX4nK34KO/2amTPuS3RnuRkgqgfUCPdnNaWTvgC?=
 =?us-ascii?Q?rDaztNz2bfHT1gDtV7Y+Dsa8c3VOOPH7qV002yryPC0FdfIK1f4KtNQY9wEf?=
 =?us-ascii?Q?FnRLH9cvJVAOPf+1Ud1wJKNgtS2Ts9xTzVqi2Zp6lkV0WT6KD7g8/oV2nVFL?=
 =?us-ascii?Q?SRBaLVh+KTjiLL37DZ9hpD8ouqaLYt33ETqtCUa0zZ6fNBysgNM6dIoyO2BU?=
 =?us-ascii?Q?NCsYsosTpzgMTFfV3M7KhK3Jdvc8AP77tWSMjmNuPkWYjX5rgfGu+peO11bK?=
 =?us-ascii?Q?5r6YNvV122VFgV7eBtqP1mEKMK0kFIk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9d1b3e-e680-4497-1c8d-08de954b0cff
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:44:30.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQx7cIthsroD9Nb/QHgnIJFuX1B2I2RXDg03wI58izYajqUoT2HIKBzr38kcjY1w72fYKxvy2+vQTsk7bxu1rsGIO2SVqH/hcU4FV8X7N0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0719
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,linaro.org,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276452-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.624];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 294A23BB411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add JHB100 compatible and SGMII support. JHB100 soc contains
2 SGMII interfaces and integrated with serdes PHY. SGMII with
split TX/RX MAC clock and need to set 2.5M/25M/125M TX/RX clock
rate in 10M/100M/1000M speed mode.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 16b955a6d77b..df7b2fc9989d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -26,6 +26,7 @@ struct starfive_dwmac_data {
 struct starfive_dwmac {
 	struct device *dev;
 	const struct starfive_dwmac_data *data;
+	struct clk *sgmii_rx;
 };
 
 static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -36,6 +37,9 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	int phy_intf_sel;
 	int err;
 
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII)
+		return 0;
+
 	phy_intf_sel = stmmac_get_phy_intf_sel(plat_dat->phy_interface);
 	if (phy_intf_sel != PHY_INTF_SEL_RGMII &&
 	    phy_intf_sel != PHY_INTF_SEL_RMII) {
@@ -68,6 +72,24 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return 0;
 }
 
+static int stmmac_starfive_sgmii_set_clk_rate(void *bsp_priv, struct clk *clk_tx_i,
+					      phy_interface_t interface, int speed)
+{
+	struct starfive_dwmac *dwmac = (void *)bsp_priv;
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
@@ -102,14 +124,23 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk_gtx),
 				     "error getting gtx clock\n");
 
+	dwmac->sgmii_rx = devm_clk_get_optional(&pdev->dev, "rx");
+	if (IS_ERR(dwmac->sgmii_rx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->sgmii_rx),
+				     "error getting sgmii rx clock\n");
+
 	/* Generally, the rgmii_tx clock is provided by the internal clock,
 	 * which needs to match the corresponding clock frequency according
 	 * to different speeds. If the rgmii_tx clock is provided by the
 	 * external rgmii_rxin, there is no need to configure the clock
 	 * internally, because rgmii_rxin will be adaptively adjusted.
 	 */
-	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk"))
-		plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
+	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk")) {
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII)
+			plat_dat->set_clk_tx_rate = stmmac_starfive_sgmii_set_clk_rate;
+		else
+			plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
+	}
 
 	dwmac->dev = &pdev->dev;
 	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
@@ -130,6 +161,7 @@ static const struct starfive_dwmac_data jh7100_data = {
 static const struct of_device_id starfive_dwmac_match[] = {
 	{ .compatible = "starfive,jh7100-dwmac", .data = &jh7100_data },
 	{ .compatible = "starfive,jh7110-dwmac" },
+	{ .compatible = "starfive,jhb100-dwmac" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
-- 
2.17.1


