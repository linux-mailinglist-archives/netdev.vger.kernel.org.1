Return-Path: <netdev+bounces-20366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966A75F2AD
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70F1C2090F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C989470;
	Mon, 24 Jul 2023 10:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DF9466
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:16:50 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529A49CB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:16:47 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690193671t2pocbmj
Received: from wxdbg.localdomain.com ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 18:14:30 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: TXoNPSSaW4nAiNukRaxcoo/RibD1aLXdFJPXBg8QwPKnm4nRsT0iPREO9yNea
	EOsjTjIAarVriJ+ufQ8s6pvPgEorEVgwb7pwXj5wATD0744I7QQ9BrHPpNynrFNhG+aKFEk
	4r60uCrVemL/i9vidjDVPUtCSM8mQAGPH4NbHvoNuhhEKHjfpreSjw8UG+Q70Bg8GAPpc7B
	w8p9GtNH1UMqZvcgKsjn0ppshkzgGWa1bJyy3ZhxYP01ppxohMSkiE1OLADZmcAXyMs+kUz
	ghLSct6vPJQyUlmmWvqHTUPBpkTIXMDr2Y2dpV8qEj5H5c9S2zkNKxwjL18QtM1snrGDKeo
	JPco6hFVspYizCrhNUefRA8AKWkdE7DCl69kludr2cYg5jSOY4OvM37tUD7vdsMzsouKADu
	2FYNOSZYFoA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11403738966932144212
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 1/7] net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
Date: Mon, 24 Jul 2023 18:23:35 +0800
Message-Id: <20230724102341.10401-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230724102341.10401-1-jiawenwu@trustnetic.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since Wangxun 10Gb NICs require some special configuration on the IP of
Synopsys Designware XPCS, the vendor identification of wangxun devices
is added by comparing the name of mii bus.

And interrupt mode is used in Wangxun devices, so make it to be the first
specific configuration.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 11 ++++++++++-
 include/linux/pcs/pcs-xpcs.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 44b037646865..79a34ffb7518 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -238,6 +238,14 @@ static int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val)
 	return xpcs_write_vendor(xpcs, MDIO_MMD_PCS, reg, val);
 }
 
+static bool xpcs_dev_is_txgbe(struct dw_xpcs *xpcs)
+{
+	if (!strcmp(xpcs->mdiodev->bus->name, DW_MII_BUS_TXGBE))
+		return true;
+
+	return false;
+}
+
 static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 {
 	/* Poll until the reset bit clears (50ms per retry == 0.6 sec) */
@@ -1289,7 +1297,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 		if (compat->an_mode == DW_10GBASER)
 			return xpcs;
 
-		xpcs->pcs.poll = true;
+		if (!xpcs_dev_is_txgbe(xpcs))
+			xpcs->pcs.poll = true;
 
 		ret = xpcs_soft_reset(xpcs, compat);
 		if (ret)
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index ff99cf7a5d0d..fb60c7e28623 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -20,6 +20,8 @@
 #define DW_AN_C37_1000BASEX		4
 #define DW_10GBASER			5
 
+#define DW_MII_BUS_TXGBE	"txgbe_pcs_mdio_bus"
+
 struct xpcs_id;
 
 struct dw_xpcs {
-- 
2.27.0


