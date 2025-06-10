Return-Path: <netdev+bounces-195977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C538AD2F91
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F5A188ED33
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD372280310;
	Tue, 10 Jun 2025 08:11:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625A21FF25
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543094; cv=none; b=AJOoAmY2PVGCIfEjShCKxVnm1zPZlMFCE/DWzXlmn923tZtUIiqqvun8jByhmLeMGVrdN1oCRaFJ7cWA8RNyu6ziB90M7KkkkZT1rw5t/nBCIhSoCyinvzVotJplO5Rw+liLBS1Fc8DQpOouoqqpOBrJ3VpXkVmwhQh+kaeyo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543094; c=relaxed/simple;
	bh=hAFywkrXtxpAhlguoSPB5Kr0FN5vqzunIDN9TmRX+w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P80al0gEi6eKP7kEy5enqXwF+eWTgqJ2O/PB80VnU8icYgiHEMnROSnE+LO5EPaIHdKcuy2xByh/SFmbVmbEW1v2lItxrx9181OXh9587C0jQwxKwzJyCQD2AI5Ak4j/mpc0e7V9eVtIGMuYmjjgjxKolnCWJKaM24kks2FxaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4T-0006BG-Dh; Tue, 10 Jun 2025 10:11:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-002jx4-0c;
	Tue, 10 Jun 2025 10:11:00 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-00G7cj-0O;
	Tue, 10 Jun 2025 10:11:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Jander <david@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 2/3] net: phy: dp83tg720: remove redundant 600ms post-reset delay
Date: Tue, 10 Jun 2025 10:10:58 +0200
Message-Id: <20250610081059.3842459-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610081059.3842459-1-o.rempel@pengutronix.de>
References: <20250610081059.3842459-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: David Jander <david@protonic.nl>

Now that dp83tg720_soft_reset() introduces role-specific delays to avoid
reset synchronization deadlocks, the fixed 600ms post-reset delay in
dp83tg720_read_status() is no longer needed.

The new logic provides both the required MDC timing and link stabilization,
making the old empirical delay redundant and unnecessarily long.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/phy/dp83tg720.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 2c86d05bf857..00963ce0eb10 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -444,21 +444,11 @@ static int dp83tg720_read_status(struct phy_device *phydev)
 		/* According to the "DP83TC81x, DP83TG72x Software
 		 * Implementation Guide", the PHY needs to be reset after a
 		 * link loss or if no link is created after at least 100ms.
-		 *
-		 * Currently we are polling with the PHY_STATE_TIME (1000ms)
-		 * interval, which is still enough for not automotive use cases.
 		 */
 		ret = phy_init_hw(phydev);
 		if (ret)
 			return ret;
 
-		/* Sleep 600ms for PHY stabilization post-reset.
-		 * Empirically chosen value (not documented).
-		 * Helps reduce reset bounces with link partners having similar
-		 * issues.
-		 */
-		msleep(600);
-
 		/* After HW reset we need to restore master/slave configuration.
 		 * genphy_c45_pma_baset1_read_master_slave() call will be done
 		 * by the dp83tg720_config_aneg() function.
-- 
2.39.5


