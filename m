Return-Path: <netdev+bounces-49737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F2C7F34D4
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C13B20FB7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B85A118;
	Tue, 21 Nov 2023 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1zRgp1S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE3537E1
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A7EC433C7;
	Tue, 21 Nov 2023 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700587230;
	bh=uRqiRzLlvGBgCBvlICc1h/HlCqP0mTq4GMStsSNxNIM=;
	h=From:To:Cc:Subject:Date:From;
	b=P1zRgp1SRQHb5SvqCgZmFc/zgt+zZjQKXFY7vWioGHcMk/nAUu05ZteAENlfoqfzo
	 KspzPYiKuNqyq+sIPIKMLy9CmMW5pV5OwH0qxQCh6ikRAoxk+e505V3kp5mWdYsJJj
	 Cin5l5lVMRYxHhe3GmOMi029D7QckCvUABHYT6NWmukkueqk4hK4u1YjFhqgmgncC3
	 BNioWH0lmcbpep61Nk6VtMrjB0nS+EuWbMneDMFF+l83TaIHdrGZnI5IqSqX6k08Da
	 6RWqlg+q7j8obFrRoTsmTfuKG1VKxWgKERT8kBafH/ZuH0MPt9b2lVgU9GUe85recG
	 U1v0DYQN3nU1A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next] net: sfp: rework the RollBall PHY waiting code
Date: Tue, 21 Nov 2023 18:20:24 +0100
Message-ID: <20231121172024.19901-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RollBall SFP modules allow the access to PHY registers only after a
certain time has passed. Until then, the registers read 0xffff.

Currently we have quirks for modules where we need to wait either 25
seconds or 4 seconds, but recently I got hands on another module where
the wait is even shorter.

Instead of hardcoding different wait times, lets rework the code:
- increase the PHY retry count to 25
- when RollBall module is detected, increase the PHY retry time from
  50ms to 1s

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/sfp.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5468bd209fab..5eb00295b8bf 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -191,7 +191,7 @@ static const enum gpiod_flags gpio_flags[] = {
  * R_PHY_RETRY is the number of attempts.
  */
 #define T_PHY_RETRY		msecs_to_jiffies(50)
-#define R_PHY_RETRY		12
+#define R_PHY_RETRY		25
 
 /* SFP module presence detection is poor: the three MOD DEF signals are
  * the same length on the PCB, which means it's possible for MOD DEF 0 to
@@ -274,7 +274,7 @@ struct sfp {
 	struct sfp_eeprom_id id;
 	unsigned int module_power_mW;
 	unsigned int module_t_start_up;
-	unsigned int module_t_wait;
+	unsigned int phy_t_retry;
 
 	unsigned int rate_kbd;
 	unsigned int rs_threshold_kbd;
@@ -372,18 +372,22 @@ static void sfp_fixup_10gbaset_30m(struct sfp *sfp)
 	sfp->id.base.extended_cc = SFF8024_ECC_10GBASE_T_SR;
 }
 
-static void sfp_fixup_rollball_proto(struct sfp *sfp, unsigned int secs)
+static void sfp_fixup_rollball(struct sfp *sfp)
 {
 	sfp->mdio_protocol = MDIO_I2C_ROLLBALL;
-	sfp->module_t_wait = msecs_to_jiffies(secs * 1000);
+
+	/* RollBall modules may disallow access to PHY registers for up to 25
+	 * seconds, and the reads return 0xffff before that. Increase the time
+	 * between PHY probe retries from 50ms to 1s so that we will wait for
+	 * the PHY for a sufficient amount of time.
+	 */
+	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
 static void sfp_fixup_fs_10gt(struct sfp *sfp)
 {
 	sfp_fixup_10gbaset_30m(sfp);
-
-	// These SFPs need 4 seconds before the PHY can be accessed
-	sfp_fixup_rollball_proto(sfp, 4);
+	sfp_fixup_rollball(sfp);
 }
 
 static void sfp_fixup_halny_gsfp(struct sfp *sfp)
@@ -395,12 +399,6 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
-static void sfp_fixup_rollball(struct sfp *sfp)
-{
-	// Rollball SFPs need 25 seconds before the PHY can be accessed
-	sfp_fixup_rollball_proto(sfp, 25);
-}
-
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
@@ -2331,7 +2329,7 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 		mask |= SFP_F_RS1;
 
 	sfp->module_t_start_up = T_START_UP;
-	sfp->module_t_wait = T_WAIT;
+	sfp->phy_t_retry = T_PHY_RETRY;
 
 	sfp->state_ignore_mask = 0;
 
@@ -2568,10 +2566,9 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
 
 		/* We need to check the TX_FAULT state, which is not defined
 		 * while TX_DISABLE is asserted. The earliest we want to do
-		 * anything (such as probe for a PHY) is 50ms (or more on
-		 * specific modules).
+		 * anything (such as probe for a PHY) is 50ms.
 		 */
-		sfp_sm_next(sfp, SFP_S_WAIT, sfp->module_t_wait);
+		sfp_sm_next(sfp, SFP_S_WAIT, T_WAIT);
 		break;
 
 	case SFP_S_WAIT:
@@ -2585,8 +2582,8 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
 			 * deasserting.
 			 */
 			timeout = sfp->module_t_start_up;
-			if (timeout > sfp->module_t_wait)
-				timeout -= sfp->module_t_wait;
+			if (timeout > T_WAIT)
+				timeout -= T_WAIT;
 			else
 				timeout = 1;
 
@@ -2629,7 +2626,11 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
 		ret = sfp_sm_probe_for_phy(sfp);
 		if (ret == -ENODEV) {
 			if (--sfp->sm_phy_retries) {
-				sfp_sm_next(sfp, SFP_S_INIT_PHY, T_PHY_RETRY);
+				sfp_sm_next(sfp, SFP_S_INIT_PHY,
+					    sfp->phy_t_retry);
+				dev_dbg(sfp->dev,
+					"no PHY detected, %u tries left\n",
+					sfp->sm_phy_retries);
 				break;
 			} else {
 				dev_info(sfp->dev, "no PHY detected\n");
-- 
2.41.0


