Return-Path: <netdev+bounces-29883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60A785064
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF81F1C20C72
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1268834;
	Wed, 23 Aug 2023 06:09:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C989475
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:09:43 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B5E60
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 23:09:24 -0700 (PDT)
X-QQ-mid: bizesmtp73t1692770838ty18n5id
Received: from wxdbg.localdomain.com ( [60.177.96.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Aug 2023 14:07:17 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: Xz3VOcA7Mr0+9g2C+AmSdd5WnNW21BLBjcEuiCYtF7uKTxbuduCiUnltolYbl
	Tc+5urITUX7Lk0C+AeYsl1ojU4NUGMCbmvDyhBo24HtZUhFV7dvAw0u79tJrPqBYiwGaA7/
	3j8eFv8le8UJdQ6P/atSEUUqhE4T+6WTvTZZ+AMQ9ZBWnceAG/8iBdvKkQTzaoDVrGCfIIh
	cRgfiinHsLPADNUSJpNXomCYstPmg+F1yFD7gkKVNmIn9tiNWa7q4Hw0UwNpsMxsPKaQOj2
	W5aKcUjKwGUsBtsPIhuVDQ1fZP1g+kSK/kEwhc6kE94olUrhpRKjugSjEKYUbs/g/kyBYDW
	Ml/RFmKzU4sztSO/j1gNG5J+et+QVqtUc2xl1vWJASKEfdz6TCIv/VPb2D/q6LSI8QrNQWI
	Y5b0MSdkrFE=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9341741896140565135
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 1/8] net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
Date: Wed, 23 Aug 2023 14:19:28 +0800
Message-Id: <20230823061935.415804-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230823061935.415804-1-jiawenwu@trustnetic.com>
References: <20230823061935.415804-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since Wangxun 10Gb NICs require some special configuration on the IP of
Synopsys Designware XPCS, introduce dev_flag for different vendors. Read
OUI from device identifier registers, to detect Wangxun devices.

And xpcs_soft_reset() is skipped to avoid the reset of device identifier
registers.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 35 ++++++++++++++++++++++++++++++++---
 include/linux/pcs/pcs-xpcs.h |  7 +++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 44b037646865..8b56b2f9f24d 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -238,6 +238,29 @@ static int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val)
 	return xpcs_write_vendor(xpcs, MDIO_MMD_PCS, reg, val);
 }
 
+static int xpcs_dev_flag(struct dw_xpcs *xpcs)
+{
+	int ret, oui;
+
+	ret = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVID1);
+	if (ret < 0)
+		return ret;
+
+	oui = ret;
+
+	ret = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVID2);
+	if (ret < 0)
+		return ret;
+
+	ret = (ret >> 10) & 0x3F;
+	oui |= ret << 16;
+
+	if (oui == DW_OUI_WX)
+		xpcs->dev_flag = DW_DEV_TXGBE;
+
+	return 0;
+}
+
 static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 {
 	/* Poll until the reset bit clears (50ms per retry == 0.6 sec) */
@@ -1284,6 +1307,10 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 			goto out;
 		}
 
+		ret = xpcs_dev_flag(xpcs);
+		if (ret)
+			goto out;
+
 		xpcs->pcs.ops = &xpcs_phylink_ops;
 		xpcs->pcs.neg_mode = true;
 		if (compat->an_mode == DW_10GBASER)
@@ -1291,9 +1318,11 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 
 		xpcs->pcs.poll = true;
 
-		ret = xpcs_soft_reset(xpcs, compat);
-		if (ret)
-			goto out;
+		if (xpcs->dev_flag != DW_DEV_TXGBE) {
+			ret = xpcs_soft_reset(xpcs, compat);
+			if (ret)
+				goto out;
+		}
 
 		return xpcs;
 	}
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index ff99cf7a5d0d..f37e8acfd351 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -20,12 +20,19 @@
 #define DW_AN_C37_1000BASEX		4
 #define DW_10GBASER			5
 
+/* device vendor OUI */
+#define DW_OUI_WX			0x0018fc80
+
+/* dev_flag */
+#define DW_DEV_TXGBE			BIT(0)
+
 struct xpcs_id;
 
 struct dw_xpcs {
 	struct mdio_device *mdiodev;
 	const struct xpcs_id *id;
 	struct phylink_pcs pcs;
+	int dev_flag;
 };
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.27.0


