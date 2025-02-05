Return-Path: <netdev+bounces-163233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4654CA29A41
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC21B163C9B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6012040B2;
	Wed,  5 Feb 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="CM2fLVlx"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AB1FE476
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784247; cv=none; b=MPOOUGmNm8QNe+HjQF3t0GrAJJtpZu6KpS1Qk+AOTR6pQOARDOqhkviEPeKoD5DngKT36JuKJdiG60PeeAVasyl4B9IE4EoIGNL8twbm2J2S80ogZTvbcfFE3CxCTneTSkshM2eYiNnC490J1JOCIsW1i22sKXWJXpySIoyfhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784247; c=relaxed/simple;
	bh=8ye0a9/fdhMZZ0ytbbI4m36+PkOdsLRg1d8Da9EOIe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MouyNjnrlwXM4SMOL4IO8pwJYdmbJKk/JbU3LDqvpsRxuDQeT4R8ZIYb5bIHnzQ2bTgCEY4A+muPowsfe5c8dE3rUcSW2gOF2Q9RrGFKKzLzHImGFtKNu7SlnRhX6TlC6j2ks+1236rOLXUoBzdKEx+9zLwpUeiR0c4m6Et/2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=CM2fLVlx; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FI62flwppvBCl5cLI4ZTmqK7t8EmrqPHcCaIoTN1mBk=; b=CM2fLVlxMRLxGUwt3WZ9Aj0ZBc
	WTm/qgd/fRy/Ucz0VoS/DXFfiQZvWzAKPn3JO2KKFIhR0fn4ehPBWO7MWSU34TOwOqGMpruGamV46
	TTgyWiBc9KBTAvRXoqORtnwG6wqkESf+ZUq59i6jQpVUNnvv/S1qOj/fjj2MWEbXEktY=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tfklE-0000000017b-06d7;
	Wed, 05 Feb 2025 20:08:33 +0100
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
Subject: [PATCH net-next v5 4/7] net: phy: marvell: Align set_loopback() implementation
Date: Wed,  5 Feb 2025 20:08:20 +0100
Message-Id: <20250205190823.23528-5-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205190823.23528-1-gerhard@engleder-embedded.com>
References: <20250205190823.23528-1-gerhard@engleder-embedded.com>
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


