Return-Path: <netdev+bounces-292267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JB0O4HmFmruvgcAu9opvQ
	(envelope-from <netdev+bounces-292267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBEB5E4587
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FBC83074EC7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31563D1706;
	Wed, 27 May 2026 12:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCC28686;
	Wed, 27 May 2026 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884040; cv=fail; b=IUX+OxhY5lqLJCrhk3HQ4r2FpDjL+N+ZGAE41u6gsruwarZEzDaHP8Mu289+jXxYjw4VwR67T+CIQchGyWo+Lw5h1ng1bftl5iQ3j6rA5zMYWw5To4mAVaua77qkyvef98cEtDJohHptU06la9vG4Ww1WOyAYo77Z74hcaoUaAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884040; c=relaxed/simple;
	bh=YfDtUH8ON0JNehxP5ckz5NWmQPevpRBQ0ODWrolLc50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAH1qWr1sqUTNurT5B2e18Q2zbzQTGu87GsiNHHmwaFPcggPp/9xIcqN5HDCDcwXNr50EX/pMygRM23urUuNNcTIlPgY5ObjCC0x1+n1T2tvh+K8C/xLto1CxX0hhw4U7y2T67TpO7g32f94FFF/q6QcovecWccezdlNszR/oqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4pSKyJiQxGrjSryFK1K7p0HEriCME/XHD6wAN0Xx70fvHixFlvfChqqf0erzFM1Gaa+eT7Vkzd1W3EA5zt71O/zqfA7d5lIhnKF8D1nlvSnUY3lSMEekoFcq/Ml9poMwaCzFq0A2M0aAiYF3qcugDTJpeYrJF5v7LA+pqXiog78kVI7FMUknpETRDuops5BDXQc+c0lnXOUcr7E5dhHftFA5FNGpwNwdGiSqUSB6Ho1rrrqsDR93HJnsMGWgwelox7iWS9cYe8XKUoHXa/rGu7ohnqlL7XsN2aDCpQXnzkGxg8RhWs2QmhnR8R0cJZyD4zSO37PScihQ3knaCnrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFd69cig6Dd2Dt39hE6WC0DYlDVE/Y0qrTKM+Q7q6wQ=;
 b=Q586e76wgz+rqom18f41K0KNI/VfvjW0nJbXfMqXAAjvdzyDIuK3VOEgjQZjLVLmu28dmhyyx6U6aBhqyvLqxwRdH3qXSnjSx4E3A3KLPI0+O4agJxQA8TnDjAiW5lWl6NVxbpgPIJ2bx6UfgoclkDIQtzqNjCib3Evx9ajJET1QFfiCOeF7DHmTFD5WB+9axkiJneRSUi+R7Xo+AcGQYYxKEzVehFRLyxNZA4ZCUIvSjVyrTLYuNhJR9buNTMz2TTCtSzWreq71xvEEZCqWGR0QqYC1Cd/LbgCb9QDEr6b4ITfAg+RPrk1LodZxlLPDUmpdJ1Q/1EPB/ymmk0IHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0829.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 27 May
 2026 08:41:18 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 27 May 2026 08:41:18 +0000
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
Subject: [net-next v5 3/4] net: stmmac: starfive: Add jhb100 SGMII interface
Date: Wed, 27 May 2026 16:41:07 +0800
Message-Id: <20260527084108.121416-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527084108.121416-1-minda.chen@starfivetech.com>
References: <20260527084108.121416-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::26) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0829:EE_
X-MS-Office365-Filtering-Correlation-Id: 23918a6e-f0d7-4b3f-b9c9-08debbcbb89d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|22082099003|921020|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
 aoAdKi77FiLVgaJs5BfSTD8VXa7mk66NKi1g8+7EG4Ukt0/F9Qo3BKlX9zN72xxTebr+VNi5piOdzOwyd7VmGEBJnmgUqWb40wQUz6VXwe6ceIDNpPVwxKT5DVG0OGYYUU233V6Lt9EAUsjVCp7ZM26diQDjq453TiFCSue6SnVEC2+xRe/Fva6vJ4itihhvUxUzwVC0rcTTgolueYZhuSbSnugozKAKiknEAVmeU92WRmhxGXp63eC0xgycm5SRs6C93+LVP3zmeOUibkCRW5PbeOsxI2x8fzhWbzLw6khm6JeoWifVAP6fdk00Dnz9J/gK89yvPWT+SaYHD8GvBsaAFvXgdlLZ2BG8dDbiXPg1mUFirKhyVO4/5Bz3QDnopTRPq24aMm+3iIvyKzVbrJhtH6oZbjrbLj1isCfsAMdKw7kzpqUnFlhSdkt5PfNOqnmw6dyuw9Rn7iGC7wxx/J/BPy2d+dOnLspx5QkRYMtQlFTj8EaDIhJRifr1zANJmCMsurxOM5UW3UtPhNjX7Q660pnsrfwIZ56QEGqMBiYA4yi4FYNNYtCrwJgJAdfCCxd2kEP9ZzmGp61iG/Ui+g==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(22082099003)(921020)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?X8oF1iIEGHMWgQuGDLgqVac5lpSG9Fj58aKMQ8ZYemjH0OYbtm+5x6JnMnUR?=
 =?us-ascii?Q?BxdfM4ovRpIH3+ZfAqqtgmDr67nYM7FmZFpHQWXRBFz2H49xNbOWc4T2slA5?=
 =?us-ascii?Q?t83aGK4tejJr62F+oQjkb1I54YJOZLVFyCUivYhAOIF6g89tTXzSE8AV0u4J?=
 =?us-ascii?Q?wnaCqPjfNrJaLHUtwYNvuPynQ7+PoI7KufHeEca2o1jKCeKembFmLflMiiii?=
 =?us-ascii?Q?hV03Oc9a5rU3Ap7wfl1k4SX7xK0D3GEJhB419u/aEpEMYSFTZiECOkCVbmJY?=
 =?us-ascii?Q?uisnqrq6mF8zh/XmAwEDKQYW4YzMSelY409cRIdL8aZVWwwSzfe50o+Cy0lS?=
 =?us-ascii?Q?Uw7oIJnmAI+0HXdF3S6acxmUxFSjVtY/bV5mVu10e3WYpujJ+9e64WluC/40?=
 =?us-ascii?Q?5rjfqWvro0v+SWHXy+ZVSGTnzewi+jK4Mc6NV59UmpzyXRZLo8k4/PY+SDjL?=
 =?us-ascii?Q?+ojN2QE7cGdc06fnzEnUumHz5RsfHrb5lXt7gP7rQ4iTF6g59iho1LsHAlZz?=
 =?us-ascii?Q?lP92X4AXez0f2pd65I83kzWdYXevzF2M6Ym2/xdXwVnd6MmRFF3kmOqL29fi?=
 =?us-ascii?Q?MYyn+MiIIPaiaaGkJyL+9GlWqhOQe43b/5tExIjQavN1Uu8a3YR525I5wfw7?=
 =?us-ascii?Q?rVxPeQP/Vy8Gr/TVWhkdcnZeY+3e6+Fl/aezU+l690DPwYTakWoSHiBVZwn4?=
 =?us-ascii?Q?OcAdmarms36urvZjXjh5XrCLfejN0gS1ERfBThJczkA4kqF6PujGaKJW2xLk?=
 =?us-ascii?Q?ctC026LqZaa45eLfAe130KtZcLn5UvZbTHAhzoGio/4NGKMp7X6Gz9/wBgDx?=
 =?us-ascii?Q?TFamfIvOgOBVHM9NrmS70E+gtLK9Rll+kQ3CH8xqSoHTfS99N//Lg7lZ4YQn?=
 =?us-ascii?Q?YHOpykA/Wral/wmJzxAE5TXVn/zzE2ExdTullmwR5h80VkyX8J9OSm/dFvmg?=
 =?us-ascii?Q?47aP10bmQNCOKez/Ej+i8zps0Mj2EDK7xO6IO4JGye0hilKU70c2z/ikJ8Bk?=
 =?us-ascii?Q?b8CN/qp2mIQ+25Z8gQuOScUbSppB3CojpJj2t79D/6+7xIGsXgFtUCasliLU?=
 =?us-ascii?Q?wYNKni/QJ4Lztdb8Vz4vSz6I7ZWc14zC0wylQUXN7HsIcEggGeV+9l0C+Be6?=
 =?us-ascii?Q?MiqcFa4HdmrA3UGUYVUpA+Y1AmSU39x8fjRTPy2BhfHyKsAZR+FwjiXc3quH?=
 =?us-ascii?Q?8qn2hCl7614SfZHlVpxI9VxgluBQA0uW0J2UP3gyD8wyxZjG7fFl0pbtJOiB?=
 =?us-ascii?Q?AQfC8kCEM4AJn1Z3Sd50ukk8U6ul7bWj1qz8uOQ5t29SGp853R2pCM0kVmYU?=
 =?us-ascii?Q?mHMR4FRCDupo6oYkWd4tafReqswyxEz/6jgYN0hlyeNp5eOdxdRIsGzT9ss8?=
 =?us-ascii?Q?cPjudkLPKMjQtbeBHlXKODz23DaV8OekJWfXcKfKLM01d5edZ9hP0h24IBZi?=
 =?us-ascii?Q?55ufGQh73OuJ2oUiaIPednOjQDTK4PyqHW+kTp5eSiMHf2C2LiHLVzdJviZZ?=
 =?us-ascii?Q?RPCQNLqhFlDZaVGWzvYVJrpp6a4FpXhNBODtzewbMJ/QgqXQn/I4GHu3c7uW?=
 =?us-ascii?Q?NlziOvxEwEaxBhW6PXfXRc57SJohTEnjhXZKNL4gNmX2qC6GXu3D3GI4HnJJ?=
 =?us-ascii?Q?2SfLK+tAE8LCToBwGOXTfutZmHrWFzGAYEF4u7hpKimJpdVsWgx4A70Kzzor?=
 =?us-ascii?Q?6TUmxm/lhxGe1P/M+xRX9RwdDGMqI4vNCs3aP9znvlv0aNdL10L9ObkTFmEW?=
 =?us-ascii?Q?b0G/OlwbGsaxxkzbAJ+c6qp+G9ghqYI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23918a6e-f0d7-4b3f-b9c9-08debbcbb89d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:41:18.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AqSBK+ERetKfgloVYdC4+fllqAEA7snUYAVU/v00miIikQf3hs0pYlCcI5w+nYBLr/I7f/J+oqPm9AxJBbQVt74QSlcjUYPZLyQrN+q+ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0829
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-292267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.041];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,starfivetech.com:mid,starfivetech.com:email,marvell.com:email]
X-Rspamd-Queue-Id: 3CBEB5E4587
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add jhb100 compatible and SGMII support. jhb100 soc contains
2 SGMII interfaces and integrated with serdes PHY. SGMII with
split TX/RX MAC clock and need to set 2.5M/25M/125M TX/RX clock
rate in 10M/100M/1000M speed mode.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 59 ++++++++++++++-----
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 16b955a6d77b..b1717a6f97f1 100644
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
+		return -EINVAL;
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
@@ -102,23 +122,34 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
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
+	/* generic sgmii, 1000_BASEX not support yet */
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


