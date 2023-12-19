Return-Path: <netdev+bounces-58977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE814818C21
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94F11C20F1F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2151D53F;
	Tue, 19 Dec 2023 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD/RpbFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35871F939
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 16:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E1DC433C7;
	Tue, 19 Dec 2023 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703003060;
	bh=nqJdHWvYZ46f8qf/EtcB3OKHLCRGzjt/1qyPQeHxq9o=;
	h=From:To:Cc:Subject:Date:From;
	b=AD/RpbFGyGi1zQUM7OB12k3uLLE8v+T2VWgUE3YgtdkpIfSeuAMx0WdzdpSkrX1r5
	 z3/fOZWC+7iXcYtuUWCU9aASVAPIFCGVhdyiSottyKvBnIHgGZuG9d1sfDo5W1ps3Z
	 pgnzVIi8bjsC8NtKE1gS9zqKa2PFpLN/r1FYSs4S/CL6vmx5YSTBxhJEX8B+QkVpX2
	 eleHcLfH2QhqnrdWRtuAc30wq2xAbIAUA/BOKW27lQx2MhuUCXD9gmUy0+ChSbdE07
	 j+5S5b5VfiKWMtQV0As5Xm4HtU4ZWahrPCqNBG3GIdTiNmf7uiFn0J/y6flieDsGYW
	 B7t9esboby1lw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Wei Lei <quic_leiwei@quicinc.com>
Subject: [PATCH net-next] net: sfp: fix PHY discovery for FS SFP-10G-T module
Date: Tue, 19 Dec 2023 17:24:15 +0100
Message-ID: <20231219162415.29409-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 2f3ce7a56c6e ("net: sfp: rework the RollBall PHY waiting code")
changed the long wait before accessing RollBall / FS modules into
probing for PHY every 1 second, and trying 25 times.

Wei Lei reports that this does not work correctly on FS modules: when
initializing, they may report values different from 0xffff in PHY ID
registers for some MMDs, causing get_phy_c45_ids() to find some bogus
MMD.

Fix this by adding the module_t_wait member back, and setting it to 4
seconds for FS modules.

Fixes: 2f3ce7a56c6e ("net: sfp: rework the RollBall PHY waiting code")
Reported-by: Wei Lei <quic_leiwei@quicinc.com>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Lei, could you please test this and send a Tested-by tag?
---
 drivers/net/phy/sfp.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 3780a96d2caa..f75c9eb3958e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -274,6 +274,7 @@ struct sfp {
 	struct sfp_eeprom_id id;
 	unsigned int module_power_mW;
 	unsigned int module_t_start_up;
+	unsigned int module_t_wait;
 	unsigned int phy_t_retry;
 
 	unsigned int rate_kbd;
@@ -388,6 +389,12 @@ static void sfp_fixup_fs_10gt(struct sfp *sfp)
 {
 	sfp_fixup_10gbaset_30m(sfp);
 	sfp_fixup_rollball(sfp);
+
+	/* The RollBall fixup is not enough for FS modules, the AQR chip inside
+	 * them does not return 0xffff for PHY ID registers in all MMDs for the
+	 * while initializing. They need a 4 second wait before accessing PHY.
+	 */
+	sfp->module_t_wait = msecs_to_jiffies(4000);
 }
 
 static void sfp_fixup_halny_gsfp(struct sfp *sfp)
@@ -2329,6 +2336,7 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 		mask |= SFP_F_RS1;
 
 	sfp->module_t_start_up = T_START_UP;
+	sfp->module_t_wait = T_WAIT;
 	sfp->phy_t_retry = T_PHY_RETRY;
 
 	sfp->state_ignore_mask = 0;
@@ -2566,9 +2574,10 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
 
 		/* We need to check the TX_FAULT state, which is not defined
 		 * while TX_DISABLE is asserted. The earliest we want to do
-		 * anything (such as probe for a PHY) is 50ms.
+		 * anything (such as probe for a PHY) is 50ms (or more on
+		 * specific modules).
 		 */
-		sfp_sm_next(sfp, SFP_S_WAIT, T_WAIT);
+		sfp_sm_next(sfp, SFP_S_WAIT, sfp->module_t_wait);
 		break;
 
 	case SFP_S_WAIT:
@@ -2582,8 +2591,8 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
 			 * deasserting.
 			 */
 			timeout = sfp->module_t_start_up;
-			if (timeout > T_WAIT)
-				timeout -= T_WAIT;
+			if (timeout > sfp->module_t_wait)
+				timeout -= sfp->module_t_wait;
 			else
 				timeout = 1;
 
-- 
2.41.0


