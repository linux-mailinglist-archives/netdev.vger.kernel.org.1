Return-Path: <netdev+bounces-279220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCgwCSKf4WkQvgAAu9opvQ
	(envelope-from <netdev+bounces-279220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:46:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D241652B
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C86EA302FB5A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96BD31E833;
	Fri, 17 Apr 2026 02:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53C313537;
	Fri, 17 Apr 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393951; cv=fail; b=PuQpQVTwrikMW3rDtXRyC2Sz1noCZj5hrEtU7kXbrRWJ9gNQBkyCQP5CjNMeGSH7hWkueCdpz/HoYEpzJ41njoa12wcLRG62B9xE5fiHTtc51wJR8XAu2rUU7CBH3l/AP7S8uGF31/pIyw60xb38TPP0gsQhx1p/S4SgaDGa7+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393951; c=relaxed/simple;
	bh=9S/4yyuIkgiYBrhCH2+zYcp0sf/R6w6hQDcTFlgxOqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJt1sFcfy5V4SPnjGu+ybVaHP0CWbQRX1MzyRc9cTnT4EskkZB5tQUPKbNvrFncaerNzD28NRdpKh874J7MquGaeo1d7meuRsYgChL0GM4t4wOIYb51SPFob+rmfi34iRs2oLMBULKSTm4IBP2d1VCLCrOFoD7LlXAXlVlvza2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQQsVfYTMlOcY7xNOsgFr0wEh/J58PwO6P1fD9pHwArHNLiIWPCa2xZEXfDVyUPbnU82lzP5DKLJFeHb0goZZNuxmx5mIf+Gv5MVOY3Yo0I0I8j9XJgLjXbsOoGGqk0Pe1NKIU8MkaRXw6BS8mkjpyxp4G2Musxmnobt1vXEFwl12vY58s4rzKmLaZcEw50pq6PKlTSrz8j63xyqQ7PeIpvvsZZxsfO4cZmy7q8dPJSj1mMFVLMCfiZ3sUTpeul7lS5aKeh92EtOddB/QSIaUBxTkEex3MHhMpYQTQTKQEdEARiTKV/zUzRiYkb3AZh4w0L0Te3lBsx5n5yV2qoNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLKYF6go8V6Ox+CEgfbhp1t43GiPd7Gwy3HZGJ+mx4s=;
 b=m5VH0wjhkk230GNkHD0ut0NMEmjZvJ+cgDyVKbcfjADSFkeQu5xkvy6r+D11KlrZ+XXi8wtq2hOxJpjNX3GOzO9JgvG72a3y/Qmvi9OaQsrF+cmUay65aMejxM++ZYujswyNzK0irXVm+dCAjgTxszWHKXpSjWJoXWvNdQX4tDLeku9TsfYWUmxU7aQzbfSpWrCWhqBMWpedmAlQBsUxClxcL0GZMwh1Zj+IM9NzaMcGgrLXXTKPnVO+1hcCxN0JAJuxs8GAecGYIjvKdkJRJLI+KR2c+DT3RpGkm+I6dkeZq6A9GS5qHHzinknaTYvnmHGMQc4K0xSMGwFEMUJ+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0517.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 02:45:36 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Fri, 17 Apr 2026 02:45:36 +0000
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
Subject: [net-next v2 4/5] net: stmmac: starfive: Add JHB100 SGMII interface
Date: Fri, 17 Apr 2026 10:45:22 +0800
Message-Id: <20260417024523.107786-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260417024523.107786-1-minda.chen@starfivetech.com>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::20) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0517:EE_
X-MS-Office365-Filtering-Correlation-Id: b966f87e-01e0-43aa-878d-08de9c2b674f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	yjlK5sPcvx/poaUEilVRJ1S3OyPtVHkomkak71bwX/TDfwnXj2ZA7zezBUwD1XPzhUX/miNNwuZ3YxJRdBD5UiWnUklZNdxUuD0q1TR3JGjjvAKj/VN1pIlkXxUeJvVQDrtpthT7Zx+L/0w4sbN5mY38PgNztCr3CWL9g2+JeRqbairwrvupYEokc8orYLthbJhz0WBnm7MudDAiT+qKXAITravV52nYF0vlw56pWzkDP/Yz52H9riBGvkr+7IIkrW5Tk0+IR2W4pxm3Sx7pHGV5zem5/ZSZeD8OFA6XNp1hQ+FHsYON8VHsI2b1z1yNvZFI7EtD4PU47bSpDziEbu8a7KJKaj18Lg8oMMBHrcS21+g+RP4M/RPM24+AnMRbIu184vXZgRrn//WksJ9xWlLJ1RLDAAcIH1LjbqfTgKLZuAi0lWE9rYQisq38VFu5qpUPmg04fkKeJMNDGJR0g/wky3YKQ+JlbjVMkIXx8emanFZEpAvgeDVypyokyl2PWw5U0vsQ9ZpSaQY9+5andNdOQSD5xOg2Ndgoy1WO7HyLoKMnfMIk/PR/pSm5eliPuoVmKQlsNCeGGubzcOSlGYuf066so57060CweVsNoxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvKMz4VDo0cNSAlngSloFeC1luyFGvTuu8fYy+j8L4djQg8C9e/QP+n+JeJ/?=
 =?us-ascii?Q?2DFPGucANApJsHyuC0GFl2J4zv5shSu4fy1jp8oWmq9d8UXR12WBd7kE6R2h?=
 =?us-ascii?Q?+E1OhPCBJiCf3J2neKhtha5BN3zt5JYufeXyyuEPoxqsY0AytXWYFBK2muDQ?=
 =?us-ascii?Q?SGYwe2PHBqjihIXpzj2KdNdDHuK/5fS57ixsRknlCIZ7mfIUH56sTWPR1I7J?=
 =?us-ascii?Q?bKDNjwHe/GyuxYriRV4/Z7Wnw1HkEBbuk54HT1VdP5RH1NKzvm6Rox/CsQKC?=
 =?us-ascii?Q?n1jM7l/Soq5Nll1S0XC6Niuh/Vvoz6GsMGzeV8bh/aFZzu4BeOB7QcCVlpXd?=
 =?us-ascii?Q?7ojlBatv0KlCMK1w/8vHRx5vF6woztvF6DnVw8cnLEljA0tPxixdfDefXs8K?=
 =?us-ascii?Q?rTAUG1lFmv4KuBviLcJjTNmBDmcFsyY9v1oNh9kxeIK+2771S1LjfSfCJ+NT?=
 =?us-ascii?Q?717gEcaF5YU4vQ5U+DiPu+IrgOXPr0OQk/3hLJK0PdSyQeAe7/onBCXYFCkR?=
 =?us-ascii?Q?dK1OdOWPFPNLuembeWJnFPZ2qWS9G1S7jBcpvqObaPIWl6+xIChcT6RCBpTG?=
 =?us-ascii?Q?jmHk7LF5kDxPHt37QP9JydBAI2jUrecoaYnm45wq0qwF0WP+E3QhAYPOO8Uo?=
 =?us-ascii?Q?/qYxfHsB1DbgBy43WQ+nAU7hhFa9ic7s4BOr9AwLVZaK9w9SCz9awt3r7g/g?=
 =?us-ascii?Q?fgTgnMeFzQS2SxlbrwDf7ZIBQrpxjaE+6p4o1HWzfHjNQ10GTbXnauGlfxEp?=
 =?us-ascii?Q?mLwQ5YO9n7V5pMx5zE09FPgTwfbpeGlxxn4oRzGugyUdlq5fwBl/n0PqlcgL?=
 =?us-ascii?Q?kse9MYT7HpMhmf7Nd6ZNhA5WUa6UaZsUSrGobQB6szKE/YmM56z7G3y4Vu+4?=
 =?us-ascii?Q?55BvPiHh9sT5cAYQHhSNT5wg/7eern8PD77g6WbfqPN1tf6IL/dRKyhG+YeP?=
 =?us-ascii?Q?FNa3lFp1XTOzp/xc4wl5Ov8WC4JI+DjOZT+plcFDtL8aiVXKNbx/zzJLOzWa?=
 =?us-ascii?Q?61ZYc1ZYX0ZKTkx0UWCqyRa5kAZTsg6Q9rdDSqiE8CjTSk5KkBiN+u60mK0C?=
 =?us-ascii?Q?qavvKX1ae0oxEXhlqIO1gGG5EnH2n+CSUrsO+ggPi1tUvewAWOqBsKXPdwVK?=
 =?us-ascii?Q?n0gXC00OYfOaPcq1xM0SFogX/TIkLYoNplEgchQwGz4qtxwABZwUBj5UW+ld?=
 =?us-ascii?Q?YVGXWoZtBPHyk2tuaoO9q4aMLAOwjW0f/1vM4mVnlDMIl4cFVva2T9NhVz2Y?=
 =?us-ascii?Q?747Hc3goIpMWHSRXUw+bvKpDxVCOlFaqQEuLMSYeJsbkS2qDUSB/GHZxHvOe?=
 =?us-ascii?Q?wHeXOPRcp3kkHdRke++df1I6Mv9CAE/sf/qGeCVK90sWICNGVS7UyLFSHjm/?=
 =?us-ascii?Q?UZlz6kyGi9D2v0JvQcj9UamLzYCfwWN+SHyn4fbB5PjWsgPpq4opbz/tFIho?=
 =?us-ascii?Q?gtTLx4Q8xu/sW7lkSlpUICsHHePUrNSA1TYvZq/8V8YVRBlFMm6OVU4eekO5?=
 =?us-ascii?Q?Mx7EPTuCwq97FZz7Z8YVn6ozTp/NN4zkPpAONvb/SG/81unrSUgAO608mFbq?=
 =?us-ascii?Q?OJwZoxGc/3e+vY9LWYMV58VEO0lkBjyVkppXkrb3uzFud3jZtZ30ibApoe25?=
 =?us-ascii?Q?pYrtI+lwhFryauGtVgGmExJydxorQnSrmNqAk2CtsPdjYvTPsNylXALUL+iq?=
 =?us-ascii?Q?/tbC5QEzjq4S6pijdjLvX2FwThxxsjd1Vt7mBd3GqEFEmC0E04XkrPPM+D1R?=
 =?us-ascii?Q?L3Va9NrHyrDEWBZARhFmsX/AKJptUzI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b966f87e-01e0-43aa-878d-08de9c2b674f
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:45:36.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJhnunDiuInnKPBNLZ3bYzNRNToeaRup5aCDRi4EKM3J8/naO5tAHSUhZ8ihqvAGvldpjoLetra/J43TPGg1NfJbhAEmeN0kkImT6clsK3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0517
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279220-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.294];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,starfivetech.com:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 684D241652B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add JHB100 compatible and SGMII support. JHB100 soc contains
2 SGMII interfaces and integrated with serdes PHY. SGMII with
split TX/RX MAC clock and need to set 2.5M/25M/125M TX/RX clock
rate in 10M/100M/1000M speed mode.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 54 ++++++++++++++-----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 16b955a6d77b..91698c763dac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -26,6 +26,7 @@ struct starfive_dwmac_data {
 struct starfive_dwmac {
 	struct device *dev;
 	const struct starfive_dwmac_data *data;
+	struct clk *sgmii_rx;
 };
 
 static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -68,6 +69,24 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
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
@@ -102,24 +121,34 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
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
 
 	dwmac->dev = &pdev->dev;
 	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->dma_cfg->dche = true;
 
-	err = starfive_dwmac_set_mode(plat_dat);
-	if (err)
-		return err;
-
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
@@ -130,6 +159,7 @@ static const struct starfive_dwmac_data jh7100_data = {
 static const struct of_device_id starfive_dwmac_match[] = {
 	{ .compatible = "starfive,jh7100-dwmac", .data = &jh7100_data },
 	{ .compatible = "starfive,jh7110-dwmac" },
+	{ .compatible = "starfive,jhb100-dwmac" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
-- 
2.17.1


