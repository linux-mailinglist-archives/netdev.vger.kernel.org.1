Return-Path: <netdev+bounces-169193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE085A42ECA
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64407A9ABA
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A41C860B;
	Mon, 24 Feb 2025 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="LMApmUC+"
X-Original-To: netdev@vger.kernel.org
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF71DBB03
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431756; cv=none; b=gCTUBSqH/YJNRzMcVOZVYdxLuqxSRGFwSmpr6peK9DKUR69+SWkfQ0Wmy4ZaBNkxY6eWkvJywJs1n5+JazdzpnQ9c9Wsg/5d9NCA8Fwehjqsza5I0GvaXnu3m1jzxeirC60GNNhC2U8pjTPWQqaXF6pWYVzMv/dRIl3TV/VMcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431756; c=relaxed/simple;
	bh=S2dE/z0aGsnbY8NdaLYNkmZW9KztXUsXLqLz6hIA4B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syJ4uRSD9Yssgev1mm/ma4WKvWXpAZUOhNMzZEjXA8nqqabU+Z1C3y6PW1q26HSifpFmhfokBDZeF55nPnCjrwf33EMJSZxqulPCMdxg8LqJSDNh1wraNll+4Sz2YFgHgMlx6LPzXHGpAodpvsmt8OqXm6fcSOEdyDmqdVR7HUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=LMApmUC+; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZiPc592vzeYKTRjw+Zr7BdQk9/pym+uW6W6CjjQX6Oc=; b=LMApmUC+B9JwYPVcBgpp8VFqar
	qckRcnn4DfF7OhvvuYmcU7wx4H2xZz4acd99LUsvSi/o7MN0FvDfvrO6oEkMFvLzj1WNcAswNqWSG
	3YPlnrs2iVcLc8WrWy/rPtS1UPcQpZECHyxyXum3fxa+lOpHNAh50WZTIo/jkkcYDXaI=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tmfnp-000000000wu-46rm;
	Mon, 24 Feb 2025 22:15:50 +0100
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
Subject: [PATCH net-next v8 4/8] net: phy: marvell: Align set_loopback() implementation
Date: Mon, 24 Feb 2025 22:15:27 +0100
Message-Id: <20250224211531.115980-5-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224211531.115980-1-gerhard@engleder-embedded.com>
References: <20250224211531.115980-1-gerhard@engleder-embedded.com>
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


