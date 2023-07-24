Return-Path: <netdev+bounces-20361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB575F28B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A6E1C20AD4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3211B79F4;
	Mon, 24 Jul 2023 10:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410A8BED
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:16:01 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C721510F
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:15:48 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690193678tcxembnd
Received: from wxdbg.localdomain.com ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 18:14:37 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJmzIw4qyCSuP5nI8pQWFLPCwEvqHZRbuv/orzimr4ypjAzVMgy4r
	eGS5ccMIgEc0JvzmWmMcE+Hh/ZGkaSZXQQq9kGQJQoQJ9p07ubQWOmqOVZs0WKadKneKd7i
	3SJ7Pn6kka7uSt++KUPYhJ0aFTdWAppesBDNtw7/sxjrS1HvAsmoPGms4q3sLJc7ouMKNtF
	H4wfCuFABQEVYIDmAU1gUs2ewsCO7F7/gJPrUH+nQ36r418dr4pIqJ29w8vkSrspRig+xoh
	lQPhACQPmGITJdLOZYeutF3SXcruO5PeQX6nT8uhGMKDudu9cdOQGX4tlztfZ14ar3++Im+
	36O3RtbO6L/GyPGG8PfMadKeNUMdsEwZTqUatAcnCpZT8kde/R5lVwAOWli1fl1SylT/jZG
	irQ5KD9fqek=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8836243731427309133
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 3/7] net: pcs: xpcs: add 1000BASE-X AN interrupt support
Date: Mon, 24 Jul 2023 18:23:37 +0800
Message-Id: <20230724102341.10401-4-jiawenwu@trustnetic.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable CL37 AN complete interrupt for DW XPCS. It requires to clear the
bit(0) [CL37_ANCMPLT_INTR] of VR_MII_AN_INTR_STS after AN completed.

And there is a quirk for Wangxun devices to enable CL37 AN in backplane
configurations because of the special hardware design.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/pcs/pcs-xpcs.c | 16 ++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 82fe45845ebd..f38b9241a942 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -740,6 +740,9 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 	int ret, mdio_ctrl, adv;
 	bool changed = 0;
 
+	if (xpcs_dev_is_txgbe(xpcs))
+		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP);
+
 	/* According to Chap 7.12, to set 1000BASE-X C37 AN, AN must
 	 * be disabled first:-
 	 * 1) VR_MII_MMD_CTRL Bit(12)[AN_ENABLE] = 0b
@@ -761,6 +764,8 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 		return ret;
 
 	ret &= ~DW_VR_MII_PCS_MODE_MASK;
+	if (!xpcs->pcs.poll)
+		ret |= DW_VR_MII_AN_INTR_EN;
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, ret);
 	if (ret < 0)
 		return ret;
@@ -1014,6 +1019,17 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
 		if (bmsr < 0)
 			return bmsr;
 
+		/* Clear AN complete interrupt */
+		if (!xpcs->pcs.poll) {
+			int an_intr;
+
+			an_intr = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
+			if (an_intr & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
+				an_intr &= ~DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+				xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, an_intr);
+			}
+		}
+
 		phylink_mii_c22_pcs_decode_state(state, bmsr, lpa);
 	}
 
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 2657138391af..08a8881614de 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -17,6 +17,7 @@
 #define DW_USXGMII_EN			BIT(9)
 #define DW_VR_XS_PCS_DIG_CTRL1		0x0000
 #define DW_VR_RST			BIT(15)
+#define DW_CL37_BP			BIT(12)
 #define DW_VR_XS_PCS_DIG_STS		0x0010
 #define DW_RXFIFO_ERR			GENMASK(6, 5)
 #define DW_PSEQ_ST			GENMASK(4, 2)
@@ -79,8 +80,10 @@
 #define DW_VR_MII_PCS_MODE_MASK			GENMASK(2, 1)
 #define DW_VR_MII_PCS_MODE_C37_1000BASEX	0x0
 #define DW_VR_MII_PCS_MODE_C37_SGMII		0x2
+#define DW_VR_MII_AN_INTR_EN			BIT(0)
 
 /* VR_MII_AN_INTR_STS */
+#define DW_VR_MII_AN_STS_C37_ANCMPLT_INTR	BIT(0)
 #define DW_VR_MII_AN_STS_C37_ANSGM_FD		BIT(1)
 #define DW_VR_MII_AN_STS_C37_ANSGM_SP_SHIFT	2
 #define DW_VR_MII_AN_STS_C37_ANSGM_SP		GENMASK(3, 2)
-- 
2.27.0


