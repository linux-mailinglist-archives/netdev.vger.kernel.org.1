Return-Path: <netdev+bounces-18918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5E5759141
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8760281157
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E511190;
	Wed, 19 Jul 2023 09:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D1101F9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:11:21 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2EE19B2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:11:18 -0700 (PDT)
X-QQ-mid: bizesmtp74t1689757774tex72mil
Received: from wxdbg.localdomain.com ( [122.235.243.13])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 19 Jul 2023 17:09:25 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: dDyohfujUnn7RWEIvF/XOujWJsRn6j+OVbFkS4mDaUbv/TWsQCFisS/8vi+PP
	qG5F71ZEomIyMHj1JsoxyKkVPrBW6ALjWV81TxH8PE96SIV/30Y0oHNM0BWduRaBWFBk0IU
	3yBUFcgOPknPBqso3ELvWWNx89Wev042DKvADTtvASw7EeRngx1pSCaUFP+2ylVIHyi4JDO
	c2Nb8S0QwrcMzROvQ8m7r2HtZe7XXPH4QwrirklSi0ixoyQESe/t5pXEC0GmZINKU3webIu
	NUZnIqXpYIByClhl3PLFp23qoym/xBUDHtMfG61D2+Uwalzte2vl4/3pOibU1/ypIkBUdlH
	ZbdI/EoKakujyHnoDFC0wi6M97ePWSKJhk+UXby2xKD6uxqEh8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4837342564142934633
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
Subject: [PATCH net v2] net: phy: marvell10g: fix 88x3310 power up
Date: Wed, 19 Jul 2023 17:22:33 +0800
Message-Id: <20230719092233.137844-1-jiawenwu@trustnetic.com>
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
it sometimes does not take effect immediately. And a read of this
register causes the bit not to clear. This will cause mv3310_reset()
to time out, which will fail the config initialization. So add a delay
before the next access.

Fixes: c9cc1c815d36 ("net: phy: marvell10g: place in powersave mode at probe")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v1 -> v2:
- change poll-bit-clear to time delay
---
 drivers/net/phy/marvell10g.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 55d9d7acc32e..d4bb90d76881 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -328,6 +328,13 @@ static int mv3310_power_up(struct phy_device *phydev)
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
 				 MV_V2_PORT_CTRL_PWRDOWN);
 
+	/* Sometimes, the power down bit doesn't clear immediately, and
+	 * a read of this register causes the bit not to clear. Delay
+	 * 100us to allow the PHY to come out of power down mode before
+	 * the next access.
+	 */
+	udelay(100);
+
 	if (phydev->drv->phy_id != MARVELL_PHY_ID_88X3310 ||
 	    priv->firmware_ver < 0x00030000)
 		return ret;
-- 
2.27.0


