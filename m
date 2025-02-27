Return-Path: <netdev+bounces-170416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83416A48A59
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FDE188A78E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F626E95E;
	Thu, 27 Feb 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="li5zcPDK"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8926E64A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691185; cv=none; b=Ht4Qw4v7HHAgOUAR50hyNdFZdpWWvKjC10osUf8CnaRABdUTFvgUWcbiTAdU7bL4VZrQgRja+FfL9wsrj0CYqLHbP4EYsIqUJN2d6xiuihBJ+F5Goi+KogFqW53qjz+rvAu/w0MUOFuFab+mPGfu+Jl7O1Ek3yCO9DwickwMQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691185; c=relaxed/simple;
	bh=S2dE/z0aGsnbY8NdaLYNkmZW9KztXUsXLqLz6hIA4B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYSx2GNTZPjTD4LMwIn/huEGGGyyFEqC9C1iK19AO8Lit/r5mv6Q1eWz5lOQjhu0rfbc/f5UF0eyJziz4dRFQB0BzlVFCXY+DzBK9czo896fsRv+vI+y51A2HeCa46C532IbeM9P7MSzv2FMfdj9avgD0W7MVzOxB6gj25Fc7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=li5zcPDK; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZiPc592vzeYKTRjw+Zr7BdQk9/pym+uW6W6CjjQX6Oc=; b=li5zcPDKwz4JC02PFqsLwLphXt
	0GITyaMz654wkkx2qELFDCk58ZmCqs0+mHJbbv3RJACYzkycTS/F8abwfPCl/evPjuCDGErPvi1Il
	bTJjzwlbOFQ7MGRElZ6Nmtxda0NnvTEBg5g7FSohvLTgPugt6X5a90/U1qQ14MtY+C8k=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tnkXs-000000000iA-0U4L;
	Thu, 27 Feb 2025 21:31:48 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v9 4/8] net: phy: marvell: Align set_loopback() implementation
Date: Thu, 27 Feb 2025 21:31:34 +0100
Message-Id: <20250227203138.60420-5-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227203138.60420-1-gerhard@engleder-embedded.com>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Use genphy_loopback() to disable loopback like ksz9031_set_loopback().
This way disable loopback is implemented only once within
genphy_loopback() and the set_loopback() implementations look similar.

Also fix comment about msleep() in the out-of loopback case which is not
executed in the out-of loopback case.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/marvell.c | 72 ++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f2ad675537d1..623292948fa7 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -2133,56 +2133,50 @@ static void marvell_get_stats_simple(struct phy_device *phydev,
 
 static int m88e1510_loopback(struct phy_device *phydev, bool enable, int speed)
 {
+	u16 bmcr_ctl, mscr2_ctl = 0;
 	int err;
 
-	if (enable) {
-		u16 bmcr_ctl, mscr2_ctl = 0;
+	if (!enable)
+		return genphy_loopback(phydev, enable, 0);
 
-		if (speed == SPEED_10 || speed == SPEED_100 ||
-		    speed == SPEED_1000)
-			phydev->speed = speed;
-		else if (speed)
-			return -EINVAL;
-
-		bmcr_ctl = mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
-
-		err = phy_write(phydev, MII_BMCR, bmcr_ctl);
-		if (err < 0)
-			return err;
+	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
+		phydev->speed = speed;
+	else if (speed)
+		return -EINVAL;
 
-		if (phydev->speed == SPEED_1000)
-			mscr2_ctl = BMCR_SPEED1000;
-		else if (phydev->speed == SPEED_100)
-			mscr2_ctl = BMCR_SPEED100;
+	bmcr_ctl = mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
-		err = phy_modify_paged(phydev, MII_MARVELL_MSCR_PAGE,
-				       MII_88E1510_MSCR_2, BMCR_SPEED1000 |
-				       BMCR_SPEED100, mscr2_ctl);
-		if (err < 0)
-			return err;
+	err = phy_write(phydev, MII_BMCR, bmcr_ctl);
+	if (err < 0)
+		return err;
 
-		/* Need soft reset to have speed configuration takes effect */
-		err = genphy_soft_reset(phydev);
-		if (err < 0)
-			return err;
+	if (phydev->speed == SPEED_1000)
+		mscr2_ctl = BMCR_SPEED1000;
+	else if (phydev->speed == SPEED_100)
+		mscr2_ctl = BMCR_SPEED100;
 
-		err = phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
-				 BMCR_LOOPBACK);
+	err = phy_modify_paged(phydev, MII_MARVELL_MSCR_PAGE,
+			       MII_88E1510_MSCR_2, BMCR_SPEED1000 |
+			       BMCR_SPEED100, mscr2_ctl);
+	if (err < 0)
+		return err;
 
-		if (!err) {
-			/* It takes some time for PHY device to switch
-			 * into/out-of loopback mode.
-			 */
-			msleep(1000);
-		}
+	/* Need soft reset to have speed configuration takes effect */
+	err = genphy_soft_reset(phydev);
+	if (err < 0)
 		return err;
-	} else {
-		err = phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK, 0);
-		if (err < 0)
-			return err;
 
-		return phy_config_aneg(phydev);
+	err = phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
+			 BMCR_LOOPBACK);
+
+	if (!err) {
+		/*
+		 * It takes some time for PHY device to switch into loopback
+		 * mode.
+		 */
+		msleep(1000);
 	}
+	return err;
 }
 
 static int marvell_vct5_wait_complete(struct phy_device *phydev)
-- 
2.39.5


