Return-Path: <netdev+bounces-21014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF7B7622A3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0391C20F89
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919F026B09;
	Tue, 25 Jul 2023 19:49:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83837263BD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:49:57 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA510D4
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSiFeXWjs45Pu8PnyiDaxQ5FLvJv72hQKSSr2CwEAfE3/1aUosELUjHfiUd4VsCqc0hspo95ECW41B4dM0879H/hNaS2r32RNohvbSrHihE5VTldSP75K7b+qP92hIOAeaBoBWrrFKAMIfNEIvomyFnhDH/DoEUpq+ovsjagaTW0Fu6Wgb5lhKu4PEgLXScFetp3wji4WLYYo3p+4RlFxpO2sRs1xdTkU1+epxrQuoF8sx61AOGWQ1x9PQqQ0gQwMV8cbGNbtenqmIZt0pfQkZ1QoOMyMuKBUnRYLYnwzYPDZOUYq0MM/ca1OrFEmukCI5Z9IPr8GB0i3NKLaQPs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuzIanEa/KhiNG59/Uw/58Hkbry3+T0j+fL9cTOMFV8=;
 b=oHOT7Yo/55mwPZWA8wnoMKvO8t8P4ngR9uWz8lpTwS7iE7zgen5sahrB/BEk2TqapmIQ+O2l25tf2O4XIzo3JwxJjgadY/QqBDpwqBKrHOELPRtxueFlgEnKy4l/QcmgP4fAkKxPIE8MN1IJinnvk3cogjnB81PHR+aiM9tLbitBY8EWd6ARIuTZtDsPK4G5Hi8cv/tGXEZub+yEJk6vRLF+adztLRcCXpiT67wZ63gk6L/rl4qWSl5fvfe82HAc28o8xFfPPY9NGQKekHE/MXFe9CRon1BvEFNEqzvYy/iufIf6nHOYmNLej1CRXyD44r0xlXpBoNoikbSwj76H2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuzIanEa/KhiNG59/Uw/58Hkbry3+T0j+fL9cTOMFV8=;
 b=ZB50GtZocTYILSqKs5eFtJt7+/+XXVJGJIQn0tVsbdd1u9VSV9tcNQrhQ28UrrSnmmfQ+jfOo3ETNEf/fuKnU6ZQNFMSbNNpxLTu/4wxxyyt/Jo+x4OOemAtTJgA6tTIjootP0MZxVm/OBooyZPeJHi9ichEaK1Jukp2Z2X85Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 25 Jul
 2023 19:49:52 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:49:52 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Frank Li <frank.li@nxp.com>
Subject: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
Date: Tue, 25 Jul 2023 14:49:31 -0500
Message-Id: <20230725194931.1989102-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: 61750e12-b7d6-4efa-881b-08db8d484fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D5NdlpBXEHhI7G/VQsccLgUjsAiyz7/c0zFpcabI+EZ4je329NV4d2gITCz/9qTfAs9JhDDkXy/clxZgRkZ6cLAY2vqMQ5imrQilc3gBSYzaGbPg8nijLXU7btgaIzIpp/r7+ZEkxWR6Lp26Y/NvkDZbPD5vhYr9D1jYllmLa3ICtEB5vpVrTuQrIJ7tf0bRHjcjKGdREQP0WQnxEcgLgxt2SRERtg0W3+b1KpMpQW1/Wb88OD/KLkvAvX9l096ZDL3kqwOTzJxeQrfbnjA0dkS3wrdmxUeklQ+O2RDIksYPnV13SHcnhYpkNPpy9l3IvbUTeYfQdtZyRxCGBw/zdVOeA8TgPuizguGxT//DAt09BI0pHn+8Lz0T9a0UxLAhl97bdbX2FLY6e8MsehWE9D2MG8a4pWcUdEs6vaWeIw/lrr+TGJyhLEFJLOtcHR1WrajVDbr10aFPaocxxtpNV6pN5pAFjwSVepqOckd0WARrBu50PZdnXuoUhhEMMzYHzym6pjrocXqD8cmCk4WXxwOunPSsfmoVB1FCSSMbd3BwZu+yZpv3d3ZtOA59qJaoKpIywJMPFhFTXJ8PiazMhE0emfWwcj8ZL1rSmzI1QzYveAr9ZAs6WfTwVOdB51hm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(110136005)(54906003)(38350700002)(38100700002)(6666004)(6486002)(52116002)(478600001)(7416002)(8936002)(8676002)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(66946007)(66556008)(66476007)(41300700001)(316002)(2616005)(83380400001)(26005)(1076003)(6506007)(55236004)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/ofahmmqFtBsBqQWIMOa3RFI4rvD/f+tnjNzXjMRvsdoOK36UCjrBncWPre?=
 =?us-ascii?Q?VIJ0IBlaRvx0WceLK9HMz6XpQnPTkqk+wWzyPlcj6GW7WD7p42DykLjJ8RD8?=
 =?us-ascii?Q?k/MFuDJjoJK8N4SxfQRRVc645vykDdNpZGywFlUKUFEpNYeh1uH+rMwtG5ow?=
 =?us-ascii?Q?Xj1jTjUcqWx74hPCa2tL7sTSUlqX6RBIG0qE3A1PjTRN3kq5lSBNUl/NDZ8q?=
 =?us-ascii?Q?QWsYJ7aFd5u/fB0UTc+IbEkjLjw5GukYDen/WNfujRAOArl4j9yvRdlAr0QQ?=
 =?us-ascii?Q?o5uWkfirOcTbuNfUOFpbzWgRyMNQSJm8r/vxkRQO4zNuJAcXjJ3bEpSDExZ2?=
 =?us-ascii?Q?oqtGyURPUIUyRb+ic4veuS5OVHWrFZGZP90JRgsD6I+xMv0m80Qf+F5RSgha?=
 =?us-ascii?Q?/K0a+bMcB0txvHRmUYOOPQjM4xcnnjSTzlr21v1JNaLoeW6xQ9v90MVvkYep?=
 =?us-ascii?Q?OEA7J/i1lB8X+kec9nq4cZaH4O59KQfT8TU+ev44P9Jih+pLrCgJLJN7BtNm?=
 =?us-ascii?Q?kXtRZ0dQZvI32Nk6ld5dAf4iDjaqEJfrHhjspr4RC5ugqBvbH7YIMM+pzbGz?=
 =?us-ascii?Q?p+hk2rGsDLJ/VDH4/hoYvOfZd00cf/5+SPPlgOUB/OY1x+6MlHEtSmWmdNhj?=
 =?us-ascii?Q?4ehuC53KELvCZ+D4t1ZtUVbjgyDgdDkQh/HqfFCyKAhV+FbAqTMLj4kwvtew?=
 =?us-ascii?Q?rE8Tlk/eVfIn0HJWRb/12M/CplhNHJh6WSZmUTlf/psa7Yv4CQqf+rpl+w6g?=
 =?us-ascii?Q?Zy+UgC1kOkKeBE/G0Xd3f23S6MYP2wokcixmkhfrf7uRyep56GjPSziICd7u?=
 =?us-ascii?Q?wUdGftDtvQf/I6VdROWbR2eHTnwmw+l1Dp8KeiXDPLf60h8usTHrEO9tV8jf?=
 =?us-ascii?Q?C7YdidX70u44QUS0oTkY4wKhDDd5go7EI4T5zkVTTHKJXAz355fnddUZj2uW?=
 =?us-ascii?Q?cKIwlP8bBwT0jj24QutBoNlLHRD3C8xTPAOHVCbwfrOW9UcgVGO6JrwegLw/?=
 =?us-ascii?Q?lszFLvX99x4TFkuOp5hehFUkAmyabmgNqK6AqyxsyTlAgFtkfDCt4bfiQPRy?=
 =?us-ascii?Q?AupRIFMLhaUqbeOax5brMlVlFNlTOBFCm9WLy6ywbG1q6guYMOizs1gvFvlD?=
 =?us-ascii?Q?ijJYmO54Yzx12s4MiRo8UYaGD7/YBdO3r8oGyOF3GMOOixeMHNrKqGjdLrJ3?=
 =?us-ascii?Q?zPTMf1ehRqHe9LHmylt0G0ZCLo0dbNcxbY1zr/kYJSm8YLQ3HCLeds5fYrqC?=
 =?us-ascii?Q?3QAZRYm2dAQVq9VbP9F86wwk93uf7Nv5/bpMyTwmFc6oM6scaANGiJCJXNRT?=
 =?us-ascii?Q?yFZamU+rhEe3p+1izdbyb2wlB7WK97a3ZixZ3HtxFO98vrtNBZ3as2YIr+v2?=
 =?us-ascii?Q?SS99tkN6foRFMfmjw9iHoM2vs+cBCsiQjous6Jejg6g3v13qb/6B4xOiHOhP?=
 =?us-ascii?Q?q9UiYcXFt/WYwmOhS5cNgK1r6c4KbYTB1JV3cRIHuNYxJOWJ+fqNwnGOPw1T?=
 =?us-ascii?Q?ZqMlLn6lRWVxrgFltTJKBdXNlDE37aClOSAquPNadW3M9YgAnEthcmO1JTFb?=
 =?us-ascii?Q?CKAMJyUbzir2SB4bYF1oLoMiTIje9zdlJa3WrSD+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61750e12-b7d6-4efa-881b-08db8d484fe2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:49:52.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgaN1PKy0iNI+36XW5EsPl5n0MVABbe8pkynSlEGZ8OKiO0TzArN3YPIcTCNcNP5zq40V2Hfio4hhT45wHa9dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When using a fixed-link setup, certain devices like the SJA1105 require a
small pause in the TXC clock line to enable their internal tunable
delay line (TDL).

To satisfy this requirement, this patch temporarily disables the TX clock,
and restarts it after a required period. This provides the required
silent interval on the clock line for SJA1105 to complete the frequency
transition and enable the internal TDLs.

So far we have only enabled this feature on the i.MX93 platform.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index b9378a63f0e8..799aedeec094 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -40,6 +40,9 @@
 #define DMA_BUS_MODE			0x00001000
 #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
 #define RMII_RESET_SPEED		(0x3 << 14)
+#define TEN_BASET_RESET_SPEED		(0x2 << 14)
+#define RGMII_RESET_SPEED		(0x0 << 14)
+#define CTRL_SPEED_MASK			(0x3 << 14)
 
 struct imx_dwmac_ops {
 	u32 addr_width;
@@ -56,6 +59,7 @@ struct imx_priv_data {
 	struct regmap *intf_regmap;
 	u32 intf_reg_off;
 	bool rmii_refclk_ext;
+	void __iomem *base_addr;
 
 	const struct imx_dwmac_ops *ops;
 	struct plat_stmmacenet_data *plat_dat;
@@ -212,6 +216,61 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed)
 		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
 }
 
+static bool imx_dwmac_is_fixed_link(struct imx_priv_data *dwmac)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct device_node *dn;
+
+	if (!dwmac || !dwmac->plat_dat)
+		return false;
+
+	plat_dat = dwmac->plat_dat;
+	dn = of_get_child_by_name(dwmac->dev->of_node, "fixed-link");
+	if (!dn)
+		return false;
+
+	if (plat_dat->phy_node == dn || plat_dat->phylink_node == dn)
+		return true;
+
+	return false;
+}
+
+static void imx_dwmac_fix_speed_mx93(void *priv, unsigned int speed)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct imx_priv_data *dwmac = priv;
+	int val, ctrl, old_ctrl;
+
+	imx_dwmac_fix_speed(priv, speed);
+
+	old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
+	plat_dat = dwmac->plat_dat;
+	ctrl = old_ctrl & ~CTRL_SPEED_MASK;
+
+	/* by default ctrl will be SPEED_1000 */
+	if (speed == SPEED_100)
+		ctrl |= RMII_RESET_SPEED;
+	if (speed == SPEED_10)
+		ctrl |= TEN_BASET_RESET_SPEED;
+
+	if (imx_dwmac_is_fixed_link(dwmac)) {
+		writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
+
+		/* Ensure the settings for CTRL are applied */
+		wmb();
+
+		val = MX93_GPR_ENET_QOS_INTF_SEL_RGMII;
+		regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
+				   MX93_GPR_ENET_QOS_INTF_MODE_MASK, val);
+		usleep_range(50, 100);
+		val = MX93_GPR_ENET_QOS_INTF_SEL_RGMII | MX93_GPR_ENET_QOS_CLK_GEN_EN;
+		regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
+				   MX93_GPR_ENET_QOS_INTF_MODE_MASK, val);
+
+		writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
+	}
+}
+
 static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
 {
 	struct plat_stmmacenet_data *plat_dat = priv;
@@ -317,8 +376,11 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	plat_dat->exit = imx_dwmac_exit;
 	plat_dat->clks_config = imx_dwmac_clks_config;
 	plat_dat->fix_mac_speed = imx_dwmac_fix_speed;
+	if (of_machine_is_compatible("fsl,imx93"))
+		plat_dat->fix_mac_speed = imx_dwmac_fix_speed_mx93;
 	plat_dat->bsp_priv = dwmac;
 	dwmac->plat_dat = plat_dat;
+	dwmac->base_addr = stmmac_res.addr;
 
 	ret = imx_dwmac_clks_config(dwmac, true);
 	if (ret)
-- 
2.34.1


