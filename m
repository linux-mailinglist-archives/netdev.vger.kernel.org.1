Return-Path: <netdev+bounces-292826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ8eIVKZGGr+lQgAu9opvQ
	(envelope-from <netdev+bounces-292826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC55F7364
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6AB43037782
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257C352018;
	Thu, 28 May 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxWYrcWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716C33711D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996959; cv=none; b=eGKsqVyl+SjAdyieM9RFXqMjky34zTYEHjI4gxNVgXPNOdkt4hKYefx1m4STvqlAF28uScQ541SBvpb+AFgHbLC+ZdyVEvjiksbX3yGdvNefMSJxHrZLPuTKmvSeKPpvat1dHueEQghy5m8ggNLbR1F17EVjYv2m80gUysADp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996959; c=relaxed/simple;
	bh=YamYR0gB5YpvzrPrfHuKhWssK/k1gQlhxfDHYVzOSrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKa6otZ4fQL8eRPADSBp/algDwKT8tm/GKgAWtI4uMUXFovxKU8TnwqfD9MKAtPLecms+uhR0g/RF10VBYC+jg5Fq5Wv5zP9KOQjyNmuwZV0slb2h8yHuPr/S9gfp9j6hN6H0NdTG2Rrc8qnFxaipUuwmkBL7aG1ROiFTCdhz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxWYrcWw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so590294f8f.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996956; x=1780601756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/VphDQS+fwFrSctDzTxKBEr+9CTd6YQLukQQPgTJa4=;
        b=lxWYrcWwJrZuQW1jcttfRyr+fOH/VhFAZyhZe+oQlsKKQ9Z0Fti5PYFapsKlqcwB/R
         49yfk+F6xAMR/afjGhT/1RURuRjE9AfWh2jP8Txc/of8FORLCLH427LFHAdf4pm/tMJN
         P/ruu/K4jgzfJcwjYHX6FsyD1GQ8s8MdSmJ0jUerfxXGtyRNY7Qc+ITL5SPWMSsfPf9S
         j/gpr7SIHcCOyEM+KZ69WfXApmFW62kejDK71UImDiFBbmayzEDtspn5u6wOg8MSKkWJ
         333h6a4CoglQ/GQWibZkc/9fFhAc/rUl5azokpnOIwFhUtp4iCeSHIskJHUxXqGz7bDI
         euGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996956; x=1780601756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/VphDQS+fwFrSctDzTxKBEr+9CTd6YQLukQQPgTJa4=;
        b=gx6OWuCx3x+Z/SFIcr8E/9m7x5MI0MTsnYodajuTKkwZtW2Zm9svN/nf+a1iEkGyZ8
         gSHz6ohaX8RkHyqUOyx+9jExqQHm1pG/JUi2lAaZU4rLaFp6CluijSUM4mlOLqO6vGOc
         W36dxrVQm2Uj18GOqppBdwJszwP8xJQ7WsVWmlOtu7BVHdvEzUh5ogSanohDtv3aXRje
         Gioiidj2XuAHU3RH4cSqB5DpzPArb5L+am8SfOuJjqyR5tiFGg9qhWCFfsvqFQhbx6xr
         eSQcvVals/lINYKgIiKvUHbRhWV2UrGfNhGxu1iXaxrAQGtlvl4Xd0rfu6Rezx8GR+0E
         p0yg==
X-Forwarded-Encrypted: i=1; AFNElJ9vGS8ou2rrhy/WE5p5ZYQXslMh/MHAODEqMjyQttFlSFsanZ2lNTBTJ6tEgkbOKl7UT7UAdsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvqmZuPMFAONP6BJSIqXvs8r/I/h1Pk/96szJOdI+Zgll7A8v
	X5UqYO24gAwEWw9UGCd9rZ1DoW7FUHzpxXZKKqeOAGaKpslbL53aXuY9
X-Gm-Gg: Acq92OGy4iVDwVTjRSKUP0xVFpB09UaxkbFEahXI4h+6vhn61Zz80/gnLHCkrnosxQ+
	QuGW1alN71Zyv/xlPnwMOXgByKSVygrAPRucaxjh/JMN2xDEFoafvVA8wzOwV/qD1ER6aF3RNzq
	KE/FjSk0EOhhmd2f+DPewxtFtvP9KoTh8dY+tRnY6s1p4g1kzm8J2Io4cV3ZY3xitFzHOlqtsvM
	VL5o3OUl64qtV99yTAwHfMAWBx9vlh2xZiKZ76r1UmdkpLaNxB8DSqh9v+0W7hGeQJ6RLCEdoC+
	DEfE12PIhDid+xPRPYoBvTOuv9FvJmH1T+DQbojP63pl8S9qD/QyfIBWeOUdj3xuzWMsHy1/D/0
	vcSnvLMtogFE6WemCWtU4qe5ix5wbtqrig40sffImX9qMw1qRzvDh0kevehJpeMTvlRMqbFzd9R
	UUEmBj59yStTpVqQHJBaz7lnCbD00fb5uG80y0X5AUaFh2XcmD2Mzr0159G7lFl+QLpJaYwFer4
	pD8zxp/y9+94N0aVg==
X-Received: by 2002:a5d:588b:0:b0:45e:73a1:8cb5 with SMTP id ffacd0b85a97d-45ef05e7003mr820751f8f.34.1779996956276;
        Thu, 28 May 2026 12:35:56 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eec5eba06sm4220471f8f.22.2026.05.28.12.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:35:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: phy: as21xxx: fix read_status speed handling
Date: Thu, 28 May 2026 21:35:42 +0200
Message-ID: <20260528193545.11160-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528193545.11160-1-ansuelsmth@gmail.com>
References: <20260528193545.11160-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292826-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F2DC55F7364
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With further test with 2.5G NIC it was discovered that
phy_resolve_aneg_linkmode is not enough to detect speed higher that 1G
when autoneg is enabled.

Also in the switch case there is a typo where the speed mask is AND with
VEND1_SPEED_STATUS instead of the correct mask VEND1_SPEED_MASK.

Rework the read_status code to always read the speed from the vendor
register and parse the generic bit only for the pause frame.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 96 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 0db82da8dbdf..97ca37c6929f 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -671,7 +671,7 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 
 static int as21xxx_read_c22_lpa(struct phy_device *phydev)
 {
-	int lpagb;
+	int lpagb, lpa;
 
 	/* MII_STAT1000 are only filled in the mapped C22
 	 * in C45, use that to fill lpagb values and check.
@@ -698,12 +698,20 @@ static int as21xxx_read_c22_lpa(struct phy_device *phydev)
 	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
 					lpagb);
 
+	lpa = phy_read_mmd(phydev, MDIO_MMD_AN,
+			   AS21XXX_MDIO_AN_C22 + MII_LPA);
+	if (lpa < 0)
+		return lpa;
+
+	mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, lpa);
+
 	return 0;
 }
 
 static int as21xxx_read_status(struct phy_device *phydev)
 {
 	int bmcr, old_link = phydev->link;
+	int speed;
 	int ret;
 
 	ret = as21xxx_read_link(phydev, &bmcr);
@@ -720,58 +728,60 @@ static int as21xxx_read_status(struct phy_device *phydev)
 	phydev->asym_pause = 0;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
-		ret = genphy_c45_read_lpa(phydev);
-		if (ret)
-			return ret;
+		if (!phydev->autoneg_complete) {
+			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
+							0);
+			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+			return 0;
+		}
 
 		ret = as21xxx_read_c22_lpa(phydev);
 		if (ret)
 			return ret;
-
-		phy_resolve_aneg_linkmode(phydev);
 	} else {
-		int speed;
-
 		linkmode_zero(phydev->lp_advertising);
+	}
 
-		speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
-				     VEND1_SPEED_STATUS);
-		if (speed < 0)
-			return speed;
-
-		switch (speed & VEND1_SPEED_STATUS) {
-		case VEND1_SPEED_10000:
-			phydev->speed = SPEED_10000;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_5000:
-			phydev->speed = SPEED_5000;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_2500:
-			phydev->speed = SPEED_2500;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_1000:
-			phydev->speed = SPEED_1000;
-			if (bmcr & BMCR_FULLDPLX)
-				phydev->duplex = DUPLEX_FULL;
-			else
-				phydev->duplex = DUPLEX_HALF;
-			break;
-		case VEND1_SPEED_100:
-			phydev->speed = SPEED_100;
+	speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			     VEND1_SPEED_STATUS);
+	if (speed < 0)
+		return speed;
+
+	switch (speed & VEND1_SPEED_MASK) {
+	case VEND1_SPEED_10000:
+		phydev->speed = SPEED_10000;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_5000:
+		phydev->speed = SPEED_5000;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_2500:
+		phydev->speed = SPEED_2500;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		if (bmcr & BMCR_FULLDPLX)
 			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_10:
-			phydev->speed = SPEED_10;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		default:
-			return -EINVAL;
-		}
+		else
+			phydev->duplex = DUPLEX_HALF;
+		break;
+	case VEND1_SPEED_100:
+		phydev->speed = SPEED_100;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_10:
+		phydev->speed = SPEED_10;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	default:
+		return -EINVAL;
 	}
 
+	if (phydev->autoneg == AUTONEG_ENABLE)
+		phy_resolve_aneg_pause(phydev);
+
 	return 0;
 }
 
-- 
2.53.0


