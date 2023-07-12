Return-Path: <netdev+bounces-17055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1DA74FF1A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2621C20EEC
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1624427;
	Wed, 12 Jul 2023 06:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1CE20E4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:15:49 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D210CB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:15:41 -0700 (PDT)
X-QQ-mid: bizesmtp90t1689142418t2id3eg8
Received: from wxdbg.localdomain.com ( [183.128.130.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Jul 2023 14:13:24 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: aBJFcW+uBGYrYR6AaHg5YPSvL2uZ5657yIAMb6oQeMfWUH65GDXrbihnF8Alp
	T2BkW9y1x9JY1DMvbY7vXQW59E8hslXGONnXj62eco+XORDau70oE+2lcd1Vc4iKACz6x94
	mN7Cwvk8X4w8ior7lxTCFDygor1wAOktm3Gn3fs04Q58tHlK7ojRSjyohT0hXLVShgqE4h9
	KnRRXyjuuhZyRmP2JJxUFhlCfOFOE4+JX4N/y1npuSLa+Ok4pqunLFAOB0y2MvWMd+VFRom
	bTAUCy9+V73/grghIRAS8d2nIl0Uvdtz4jwVJWN2Esb6/B1J4K9mt/GpSrP9aOZhy6M1wOw
	Bq3dci0CusubAjd204Q5eDyeUAW8On+DusY/oUaSoF37gif5NEV1ktofU/mAg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14284593237507722708
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: linux@armlinux.org.uk,
	kabel@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Wed, 12 Jul 2023 14:26:34 +0800
Message-Id: <20230712062634.21288-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
it sometimes does not take effect immediately. This will cause
mv3310_reset() to time out, which will fail the config initialization.
So add to poll PHY power up.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/phy/marvell10g.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 55d9d7acc32e..2bed654b7c33 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -323,13 +323,20 @@ static int mv3310_power_down(struct phy_device *phydev)
 static int mv3310_power_up(struct phy_device *phydev)
 {
 	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
-	int ret;
+	int ret, val;
 
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
 				 MV_V2_PORT_CTRL_PWRDOWN);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND2,
+					MV_V2_PORT_CTRL, val,
+					!(val & MV_V2_PORT_CTRL_PWRDOWN),
+					1000, 100000, true);
 
 	if (phydev->drv->phy_id != MARVELL_PHY_ID_88X3310 ||
-	    priv->firmware_ver < 0x00030000)
+	    priv->firmware_ver < 0x00030000 || ret < 0)
 		return ret;
 
 	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
-- 
2.27.0


