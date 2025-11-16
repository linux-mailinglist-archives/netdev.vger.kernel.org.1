Return-Path: <netdev+bounces-238938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E32C617B4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E80AE360B2B
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A3C2C234E;
	Sun, 16 Nov 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCH4NPbs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D61799F
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763308118; cv=none; b=pzbCg0ipzt7SagSrUqCWXe42RzlC+m5cEmy98sFU7GAnNClv2eUkGU1btxGteholHL5FF1ZrpDMvYSrkKmboIkn85zLG/DhjzyCDQhfEEu+u3PmRxXRD91YqN3kJD8nhux2DrjPOg2Tae3MYj6dEdqCpPKsAyqvrX2Vcff2BfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763308118; c=relaxed/simple;
	bh=4oXlextiRJJRwsBjtdpSqU6dtRWPa4mBeft5xC7uZ0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j17mzGPU7hUM+ragGJ6Q2EjB/DIYhuHAs3yy3T1HoiYb5wswdiHrN5EsKcjMbIVh2grUBnitxZGqNERIlOtu2RjE/5QsMEQGWRPIBsjc42GbN6lYS8hbchE+RI+yNIH7dJu0JfuSgFx6iI1pM19ApdF1qArPKRB1Tko556mdqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCH4NPbs; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2409618a12.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763308116; x=1763912916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9C0XlnYWqrrvJ+b7cMsy53XPbtZDNWszrWBCC6jDbY=;
        b=ZCH4NPbsIQxNkJqXK4LHHsDj/fNl0sf/HTX+V9ztq0gn1caCYTQrUfb18j2LtLYju7
         4G0Kmld2vY0kCPsqLiBfG5XTOdwU2QyhUNaBtMd7/h9jzckfpHTlnxHtWOudr3SeSNJj
         RwD83HKYsCdWUTaDJsq4bGNQ3rXkFblXllavM+ljn+AWwcPyp+GtYWadG+rBbTOsrKmw
         ybz6Mxtz7N6PEuGlYmOrpg/1WkabLxi8OJYjgjzYpS0RYkfKvYB1+hTIwD3OZm1+eLkB
         viaaTYFg2Oj+Ofrz1VXacVPpjT6XuNWzRPsANrr1IQjmacFZV/Qn6qX8PEGJFOZE+3s/
         MJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763308116; x=1763912916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9C0XlnYWqrrvJ+b7cMsy53XPbtZDNWszrWBCC6jDbY=;
        b=FUpwX2I5sADn5CUV0BT7DTWyjfub3YNtnfzi6d6R+FAUss+DqH62eWSSqiokuVxZkg
         Xfq9T2uydoIA6fbvNhSslq0iJeN5mSFFwU7uNy1IGjMJpPIIRR3A7PGw6cf7Bg6Cgha1
         cD+XCDzaHzgTa0w9QcdTj5uwDpvDJ4ed0rVTU7dESm0J+fXdm5OcPhCGY5cmZ5gni/cA
         +yIN1tZZrmIh1b/nVM3AybbuxFkIz8EX8LepYpph17sjCWHN1z2SGIzfu52wb0zgjngz
         4n7Bdq1+HPerS+8epn+xGbwEkMlav2MylakUEY/6HLljhmkn4/cc0OUs+63H0tUZGvSX
         j96A==
X-Forwarded-Encrypted: i=1; AJvYcCVn8/ORHBsaa/+IW7AG6oYjmieebSN7Wf5fSHz9F2Ql4WXOEsiQPe+wmVn44es58ZZHQlvBG8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIT3c8YMxfzz5wge/tMoWY0AQ9QrTBz6H7fPmxU2hGE9EqNlwr
	QdoGe2ieHKosqp/tgtmEkbpBPWqeJRBXYV0f+xVWgiDGY0ol8dK6D5Pd
X-Gm-Gg: ASbGncsj82P1fwaykEowQHT5eyPd0urko2XUFsC9wWUBYy/84DAJbX6QLWClyluXpo4
	+0uchWitl6AQFUZrAdbKuoUFx1qjSMrDtf+DtsB9loZq6U//9WNg/JsfnN2OGms5QBgi1xw0OJE
	BmvQRIEMatyljyZzBL7vPgm9zsiT9XPtIvAcxsMJunIb6MBYS2KcfSzgbW2aiWD5FSYmmpNSGer
	0v9vj9f3up9MsjZnCtSoDNzqHkuNVOiAoJZMhx/rOMprZrVNd7CuRJq5gpjHqcaNDMYUzMIKkk9
	1NaRWW/cSrOkxAMfsm+g6PtrJR28wzJoZgzAlLqJm3DiCbkPwMDL+6ZMlZBQ3/xtR9q+ghYMu4a
	EWVX76yaLBmEQ3vIRKhiDKVJCeDVpxswPOQBX5M0LQxYx5CTdnUKhM8tjJayjvhc7PvnFaa+Vf6
	7UTa03LkcDm2TZEkiQWuAsva7R9YepjlCggy4=
X-Google-Smtp-Source: AGHT+IFkWYisrb2xcJo476JFklBq3dIkrtQHUQ5qETlCQAfQ9WaZAtMPLEq2qUkNERv1Xzuh9Rc/PQ==
X-Received: by 2002:a05:7022:3d0d:b0:11b:adb3:ff9f with SMTP id a92af1059eb24-11badb40060mr2275242c88.36.1763308116169;
        Sun, 16 Nov 2025 07:48:36 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c36f:6205:ec94:7cc1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b80fd6790sm17179763c88.10.2025.11.16.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:48:35 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kuba@kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	manfred.schlaegl@ginzinger.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	f.fainelli@gmail.com,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH net] net: phy: smsc: Skip soft reset when a hardware reset GPIO is provided
Date: Sun, 16 Nov 2025 12:48:24 -0300
Message-Id: <20251116154824.3799310-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms using the LAN8720 in RMII mode, issuing a soft reset through
genphy_soft_reset() can temporarily disrupt the PHY output clock (REF_CLK).

Boards that source ENET_REF_CLK from the LAN8720 are therefore sensitive
to PHY soft resets, as the MAC receives an unstable or missing RMII clock
during the transition.

When a "reset-gpios" property is present, the MDIO core already performs a
hardware reset using this GPIO before calling the driver's ->reset() hook.
Issuing an additional soft reset in smsc_phy_reset() is redundant and may
result in RX CRC/frame errors, packet loss, and general link instability at
100 Mbps.

Change smsc_phy_reset() so that:

- If reset-gpios is present: rely solely on the hardware reset and skip
the soft reset.
- If reset-gpios is absent: fall back to genphy_soft_reset(), preserving
the existing behavior.

The soft reset to remove the PHY from power down is kept, as this is
a requirement mentioned in the LAN8720 datasheet.

This fixes packet loss observed on i.MX6 platforms using LAN8720 without
breaking boards that rely on the existing soft reset path.

Fixes: fc0f7e3317c5 ("net: phy: smsc: reintroduced unconditional soft reset")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/phy/smsc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 48487149c225..3840b658a996 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -54,6 +54,7 @@ struct smsc_phy_priv {
 	unsigned int edpd_mode_set_by_user:1;
 	unsigned int edpd_max_wait_ms;
 	bool wol_arp;
+	bool reset_gpio;
 };
 
 static int smsc_phy_ack_interrupt(struct phy_device *phydev)
@@ -136,6 +137,7 @@ EXPORT_SYMBOL_GPL(smsc_phy_config_init);
 
 static int smsc_phy_reset(struct phy_device *phydev)
 {
+	struct smsc_phy_priv *priv = phydev->priv;
 	int rc = phy_read(phydev, MII_LAN83C185_SPECIAL_MODES);
 	if (rc < 0)
 		return rc;
@@ -147,9 +149,17 @@ static int smsc_phy_reset(struct phy_device *phydev)
 		/* set "all capable" mode */
 		rc |= MII_LAN83C185_MODE_ALL;
 		phy_write(phydev, MII_LAN83C185_SPECIAL_MODES, rc);
+		/* reset the phy */
+		return genphy_soft_reset(phydev);
 	}
 
-	/* reset the phy */
+	/* If the reset-gpios property exists, hardware reset will be
+	 * performed by the MDIO core, so do NOT issue a soft reset here.
+	 */
+	if (priv->reset_gpio)
+		return 0;
+
+	/* No reset GPIO found: fall back to soft reset */
 	return genphy_soft_reset(phydev);
 }
 
@@ -671,6 +681,9 @@ int smsc_phy_probe(struct phy_device *phydev)
 	if (device_property_present(dev, "smsc,disable-energy-detect"))
 		priv->edpd_enable = false;
 
+	if (device_property_present(dev, "reset-gpios"))
+		priv->reset_gpio = true;
+
 	phydev->priv = priv;
 
 	/* Make clk optional to keep DTB backward compatibility. */
-- 
2.34.1

