Return-Path: <netdev+bounces-29882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A559F785063
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74141C20C11
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A04883A;
	Wed, 23 Aug 2023 06:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CC8834
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:09:42 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB65BE57
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 23:09:22 -0700 (PDT)
X-QQ-mid: bizesmtp73t1692770845tfpsc4e0
Received: from wxdbg.localdomain.com ( [60.177.96.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Aug 2023 14:07:24 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 7YFKcddXagiRKBKQPgw18b1+b8KLqpRYcMI/NjtmjhjwH5RS0CczoxxuFrP7X
	hskCCb0+uWvObZw3uvNQqCFPssoE+mIQtta+Jr2aXes7ou9xzQfzxmUhaUe4NuxmeObg3fK
	EAR3XFIwC1Wv4uRa4ZF6kEcPNm+HecXsBaIwLgJdQHXVQNm0cBKfCFygQKOgbOO4acNzFZS
	/vSt5LfztAvNiBmG77knsNOZMVzNmT2LZDN57It1eZhbiKhkBMtLeCGr1l4qRXLlr3NvC4D
	0ef/jc+BrxAs0Ko0v5+zQHzzmQhY0pC0LwdYuv/gtSFZrcUhM1eTmVrFFRMdaLJNpdF2Mc+
	+ZNm/Je8ibLtOfk9nVGmH143BQfjxZrVDqWv38C3peRRZN6tA5Ss0jtCDybuk+ygyjLbQQ/
	08/8nvhpoes=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8998824361086517846
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
Subject: [PATCH net-next v3 3/8] net: pcs: xpcs: add 1000BASE-X AN interrupt support
Date: Wed, 23 Aug 2023 14:19:30 +0800
Message-Id: <20230823061935.415804-4-jiawenwu@trustnetic.com>
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

Enable CL37 AN complete interrupt for DW XPCS. It requires to clear the
bit(0) [CL37_ANCMPLT_INTR] of VR_MII_AN_INTR_STS after AN completed.

And there is a quirk for Wangxun devices to enable CL37 AN in backplane
configurations because of the special hardware design.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/pcs/pcs-xpcs.c | 19 ++++++++++++++++++-
 drivers/net/pcs/pcs-xpcs.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4cd011405376..b806a9beecde 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -755,6 +755,9 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 	int ret, mdio_ctrl, adv;
 	bool changed = 0;
 
+	if (xpcs->dev_flag == DW_DEV_TXGBE)
+		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP | DW_EN_VSMMD1);
+
 	/* According to Chap 7.12, to set 1000BASE-X C37 AN, AN must
 	 * be disabled first:-
 	 * 1) VR_MII_MMD_CTRL Bit(12)[AN_ENABLE] = 0b
@@ -776,6 +779,8 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 		return ret;
 
 	ret &= ~DW_VR_MII_PCS_MODE_MASK;
+	if (!xpcs->pcs.poll)
+		ret |= DW_VR_MII_AN_INTR_EN;
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, ret);
 	if (ret < 0)
 		return ret;
@@ -1029,6 +1034,17 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
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
 
@@ -1319,9 +1335,10 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 
 		xpcs->pcs.ops = &xpcs_phylink_ops;
 		xpcs->pcs.neg_mode = true;
-		xpcs->pcs.poll = true;
 
 		if (xpcs->dev_flag != DW_DEV_TXGBE) {
+			xpcs->pcs.poll = true;
+
 			ret = xpcs_soft_reset(xpcs, compat);
 			if (ret)
 				goto out;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index da61ad36946c..ff04f6bc00a1 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -18,6 +18,7 @@
 #define DW_VR_XS_PCS_DIG_CTRL1		0x0000
 #define DW_VR_RST			BIT(15)
 #define DW_EN_VSMMD1			BIT(13)
+#define DW_CL37_BP			BIT(12)
 #define DW_VR_XS_PCS_DIG_STS		0x0010
 #define DW_RXFIFO_ERR			GENMASK(6, 5)
 #define DW_PSEQ_ST			GENMASK(4, 2)
@@ -80,8 +81,10 @@
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


