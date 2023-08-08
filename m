Return-Path: <netdev+bounces-25227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC87773636
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F71C20E0E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048217C7;
	Tue,  8 Aug 2023 02:07:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CE20EF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:07:15 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402A138
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:07:13 -0700 (PDT)
X-QQ-mid: bizesmtp73t1691460271thr3ze5o
Received: from wxdbg.localdomain.com ( [115.195.149.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Aug 2023 10:04:29 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: SFhf6fKhx/8TEflKjMgIDnCHjbZ49MxUZ13Xtk3ymKrggIwMRyKJvgKksxFU1
	ocoZ06VeEc1M1cGZPNAKx16ehUp4228SvFXTp6tj6wA0QF9DoyKxXkia/Z3zjrp+h9WGLdF
	Ljwdhz5hsXlOvs8riuBSbvSIT4ZQxu4gdQoNelWnRft9Tm+gKGxycJNvkgtDAYs+ufnw1OA
	VK8GsvrCSExadcvl36E52ErBdJmP68NuSKQD5xiv/3MeRdIDXcLUq0EwXc6Zm3xtkn8lQDZ
	zw9UjGo3jtIrTpGMgCYujX0vUOhc2lVsM8aMVDlfwdjWSpy1COoobOmnW1Iy4OmSLcy4qBB
	bz3tbesrWSkmAg73T1p8/zQYoKu4PVZxQPkaxs6QJkbSsghWZJ3uShDS6uekk3O8vELlNh1
	Hr3sNubJxpc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12745222789739632765
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
Subject: [PATCH net-next v2 1/7] net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
Date: Tue,  8 Aug 2023 10:17:02 +0800
Message-Id: <20230808021708.196160-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230808021708.196160-1-jiawenwu@trustnetic.com>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com>
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
Synopsys Designware XPCS, introduce dev_flag for different vendors. The
vendor identification of wangxun devices is added by comparing the name
of mii bus.

And interrupt mode is used in Wangxun devices, so make it to be the first
specific configuration.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 10 +++++++++-
 include/linux/pcs/pcs-xpcs.h |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 44b037646865..88c5e36735b6 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -238,6 +238,12 @@ static int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val)
 	return xpcs_write_vendor(xpcs, MDIO_MMD_PCS, reg, val);
 }
 
+static void xpcs_dev_flag(struct dw_xpcs *xpcs)
+{
+	if (!strcmp(xpcs->mdiodev->bus->name, "txgbe_pcs_mdio_bus"))
+		xpcs->dev_flag = DW_DEV_TXGBE;
+}
+
 static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 {
 	/* Poll until the reset bit clears (50ms per retry == 0.6 sec) */
@@ -1284,12 +1290,14 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 			goto out;
 		}
 
+		xpcs_dev_flag(xpcs);
 		xpcs->pcs.ops = &xpcs_phylink_ops;
 		xpcs->pcs.neg_mode = true;
 		if (compat->an_mode == DW_10GBASER)
 			return xpcs;
 
-		xpcs->pcs.poll = true;
+		if (xpcs->dev_flag != DW_DEV_TXGBE)
+			xpcs->pcs.poll = true;
 
 		ret = xpcs_soft_reset(xpcs, compat);
 		if (ret)
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index ff99cf7a5d0d..29ca4c12d044 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -20,12 +20,16 @@
 #define DW_AN_C37_1000BASEX		4
 #define DW_10GBASER			5
 
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


