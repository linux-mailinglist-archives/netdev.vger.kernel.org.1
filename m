Return-Path: <netdev+bounces-197637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7126AD96B0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEA41886A74
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D223D2A4;
	Fri, 13 Jun 2025 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTeJLx/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF12397A4
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848077; cv=none; b=SviMfdzFF9Z7/HAO0Y8FRbXseAuwgiwmFEbj6bameTnhCOFtwZWnw2ppjaeD807Qt/dB8O+GQmTtSLoiEQUqACvtJbBUvQ3l2seDk7ajXwc8jLaenrk9Q19oPpK2L9o70IpuX1XZcQn+AnOAY1wv4ZsNsRU0fwY2J58Kow1KZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848077; c=relaxed/simple;
	bh=LIQNNr9dNmsmrHLKIGcrCzHEwlkyKk7hYofv0/jIjIQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p0ViJOyt3XRqkJrUQVcAZcRofu8dbvWq76Jgu2zdr6PgxmPj4BoDgk+6H1Uzvy8JQK1diTzEuJi2P1rc44E9bzkjZU90BLDbWTyhztplUB3VnLABYC2p+lkbwUQ5eJgysTqFhXU9dvooglthCt/4R4YUJTvJy3hU+GjkK8r7Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTeJLx/1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1580936f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749848074; x=1750452874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmeo047TPz2qv2XypmTpm8VIv0kbrIocoQrhrj1ZTOA=;
        b=PTeJLx/1yRNkL9fJfkjAJZfM+880IY933s54+SYSvHg5SHDlTDPTzblgKKzUZa0h03
         CrgsFFb/Ug9PCLVQPrXrPNBDzpJiQRDButjmX2hCVY/bGFyW6O4SlVVEFAmzMSxzDYl3
         gjYuGMk8Jzb7g6IQekAtfW5KU3YKwtyNHOgKQVsRd9As3wtjoEeZiS/NoW45SxOzZN6K
         sRvdb1VUcNG84jPPTT+iaM1640sgnLE6W7ML5PhGcu2j6Np8rA3UeUJ7tJt49kDSjSzW
         bgBxJzrUi8HfcmpkA0CNwVPlvafihdjiAsGrVM2Ds5pQOMpBIZKEfjDDHL1n79PiKxFI
         cf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749848074; x=1750452874;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmeo047TPz2qv2XypmTpm8VIv0kbrIocoQrhrj1ZTOA=;
        b=PSR/Zpk8qGiuxQM05eEXSUbwrgdnRFk8oi8iePuGMMs/N1BseVZRkfJl4l4hGxOh81
         NdJ978a0tN42+YjcuZvNlq6UwVBqRZlodfgnOSPXI4oja2OYurICOwo3bJmvKDeXdFdJ
         cKhMCLaVKaykPBOhUr60M1oXEhalNkmhgldbyXmYzT32f23JVYszhdFxEsRUMxhG/0ll
         wUF+0cCEVaqN1Kmz060GAIxCX50Fr1VBaSrFYSFW9tvOMZhvtJJuyoXy08BPjtjTcYLJ
         FyCph2Tg5sX89nGE+GvVXc6oYMvCYTw+/hCmZ15Opx4wv59IWPmpncKFhCO7wNgMzV+5
         hU3Q==
X-Gm-Message-State: AOJu0Yz41hu7HYi8lkJLCMh2cls9Al97xCjEe+ypkOPnRYJV1ZsvOAv5
	Qozkjc4Lx+BooaAWKlwynTzKtFAvZIRAjLbiG8Vx88uS+g2N9aCOOnyX
X-Gm-Gg: ASbGncuvW8Toq9QVwzFas/RNJnYe6OLwvS8S1S6MN2wT75++hG5mgxDs46V8WDgAZVQ
	YVIQyErfOvI7frHn2qk6gIdZNFhpK//4aYIiApt7unVsZMDohQFN8IGISooKoAmlrutJptB20vC
	iZneTrjaWLDtN7Ln/COxGDyZ7MmtO6qGpbW5rD8+zNSnDFt2XhZSdl2hsgh+ArBVUjysb9KrqPT
	hzdvsISu9Fv0n030zy0Thl97YYu53cBfxIq8IQbw9ZypRgubDkgjU0lHPGXTrs0ib2/f6LKzT2o
	siYxpIugj2hYLBjZmgqptdU2UMfBmyzbTjO6wfGIjskQtk0KaxOpyxv+obhmUNF/zM3saN7U7gM
	zN9igH0PhDz/5W5ZFL/MDAmbQOHPht1QBRKbDOBpRJb2eiDTDeUfiF+vMbHxrJB0r+fftLijlOV
	FLhAs7vcmz0RwHNXBvU0CuDiGfPA==
X-Google-Smtp-Source: AGHT+IFG4XSik9g7rTEzvrLRBdPQNbpChx5BkM7KijySta6/R30c+YkWWD5l+B0N4O7ww+fhyLtyKA==
X-Received: by 2002:a5d:5f48:0:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a5723a3141mr1091121f8f.19.1749848074031;
        Fri, 13 Jun 2025 13:54:34 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1c:2700:11ba:d147:51f7:99fa? (p200300ea8f1c270011bad14751f799fa.dip0.t-ipconnect.de. [2003:ea:8f1c:2700:11ba:d147:51f7:99fa])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568a7fb62sm3254057f8f.43.2025.06.13.13.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 13:54:33 -0700 (PDT)
Message-ID: <c3b24132-212b-4f83-aed0-37338a805f72@gmail.com>
Date: Fri, 13 Jun 2025 22:54:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] net: phy: add flag is_genphy_driven to struct
 phy_device
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8bcd626f-a219-43e8-a0c2-aa04148d046d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <8bcd626f-a219-43e8-a0c2-aa04148d046d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to get rid of phy_driver_is_genphy() and
phy_driver_is_genphy_10g(), as first step add and use flag
phydev->is_genphy_driven.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 13 +++++++------
 include/linux/phy.h          |  2 ++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2..bbd8e3710 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1515,7 +1515,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
-	bool using_genphy = false;
 	int err;
 
 	/* For Ethernet device drivers that register their own MDIO bus, we
@@ -1541,7 +1540,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		else
 			d->driver = &genphy_driver.mdiodrv.driver;
 
-		using_genphy = true;
+		phydev->is_genphy_driven = 1;
 	}
 
 	if (!try_module_get(d->driver->owner)) {
@@ -1550,7 +1549,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		goto error_put_device;
 	}
 
-	if (using_genphy) {
+	if (phydev->is_genphy_driven) {
 		err = d->driver->probe(d);
 		if (err >= 0)
 			err = device_bind_driver(d);
@@ -1620,7 +1619,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 * the generic PHY driver we can't figure it out, thus set the old
 	 * legacy PORT_MII value.
 	 */
-	if (using_genphy)
+	if (phydev->is_genphy_driven)
 		phydev->port = PORT_MII;
 
 	/* Initial carrier state is off as the phy is about to be
@@ -1659,6 +1658,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 error_module_put:
 	module_put(d->driver->owner);
+	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
 	put_device(d);
@@ -1792,9 +1792,10 @@ void phy_detach(struct phy_device *phydev)
 	 * from the generic driver so that there's a chance a
 	 * real driver could be loaded
 	 */
-	if (phy_driver_is_genphy(phydev) ||
-	    phy_driver_is_genphy_10g(phydev))
+	if (phydev->is_genphy_driven) {
 		device_release_driver(&phydev->mdio.dev);
+		phydev->is_genphy_driven = 0;
+	}
 
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad16..5b02b4319 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -526,6 +526,7 @@ struct macsec_ops;
  * @mac_managed_pm: Set true if MAC driver takes of suspending/resuming PHY
  * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
  * 		 enabled.
+ * @is_genphy_driven: PHY is driven by one of the generic PHY drivers
  * @state: State of the PHY for management purposes
  * @dev_flags: Device-specific flags used by the PHY driver.
  *
@@ -629,6 +630,7 @@ struct phy_device {
 	unsigned is_on_sfp_module:1;
 	unsigned mac_managed_pm:1;
 	unsigned wol_enabled:1;
+	unsigned is_genphy_driven:1;
 
 	unsigned autoneg:1;
 	/* The most recently read link state */
-- 
2.49.0



