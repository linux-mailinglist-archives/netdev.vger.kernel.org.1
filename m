Return-Path: <netdev+bounces-160862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E98A1BE48
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D511188E728
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C381E98EA;
	Fri, 24 Jan 2025 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="xwWI/P6z"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695114D430
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756341; cv=none; b=GXKyUIEz1/KiUNbLPlGHRBJ2eSTYO80cd08tYk17MiA+YWCzcpbmMxjZWTlu4K/2VXQ64tG5jYi/QWfCTxnO7FZKE5pYcYOF9Nd9LxdnNLqhECd4GuYryfC56v/gJ3lT1iw5VMX4PFi9DzpKaLRuly5jBY63A/UsxJmmdwJD1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756341; c=relaxed/simple;
	bh=8ye0a9/fdhMZZ0ytbbI4m36+PkOdsLRg1d8Da9EOIe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjlQgo+y8j3jQPOGBLwvnyjxpy13kJ7PLIBVI5xy7JMHlDPqus/9RIORda4PIcB3oz1a3Nf3M661+n59GCam2PtsHpDWCTU6knEFL5OB9U9I5RHeRS9i94okrcSAS69SR0+U3JAWm/hcsP2aeEwFR4/XelajJjJVbxIRLC3+Xd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=xwWI/P6z; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FI62flwppvBCl5cLI4ZTmqK7t8EmrqPHcCaIoTN1mBk=; b=xwWI/P6zUHrtdgTbEWoi9QJ4qr
	HBL2gKJF0LLxqEB5VdyfM30PP//v6CKQG/MM/GM3ijotGXwalg3aG3wROWhM5aZMEcWVlaM1vrtK1
	7Iw2TyFMSi7QQRd/pDiMfgd/dpuVlv0FiddJ2T6I1BeMVQITRqlN2IVLaLY/duGdRqRE=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tbRo0-000000005Ng-0Ke9;
	Fri, 24 Jan 2025 23:05:36 +0100
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
Subject: [RFC PATCH net-next v3 4/7] net: phy: marvell: Align set_loopback() implementation
Date: Fri, 24 Jan 2025 23:05:13 +0100
Message-Id: <20250124220516.113798-5-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124220516.113798-1-gerhard@engleder-embedded.com>
References: <20250124220516.113798-1-gerhard@engleder-embedded.com>
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
---
 drivers/net/phy/marvell.c | 72 ++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 4ed7ec1be74f..ca8b7d97c964 100644
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


