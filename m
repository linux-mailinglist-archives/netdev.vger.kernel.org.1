Return-Path: <netdev+bounces-197833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F49AD9FBA
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1985C7AC2F4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525831420DD;
	Sat, 14 Jun 2025 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GogRUarr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954042065
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749933036; cv=none; b=Hlcu0YqQBo6tfvAAYVw+R06z4vUnz9KhXnWgDzHXJUZk5+hbVjv0tVqNsPbPXn+A1eRHfhASVHqoBzWwDT8nVYUqmkV7xcZP0pugiCobGxwaUmOE47mCgWU8U76Vw0MWmQJkY5h/yuuIERP6Eu+kjTwVYDoe9qP0gBo70+/bb6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749933036; c=relaxed/simple;
	bh=rd7fchi0vqjYsftgMIMgKDE6GUw8NC3QL5olzZEMK+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ssCuIaBW5VhDOojKhvSDxUxZTb8QffCHmZIn9dnns7gzZB0WlUQ5IiZODF6aS8slw3tQ+E3zaoCYChZVyy7ngCkxedqugw4Nc+So1PFmw1YG46wKFDoUaTq9nt4fo7iy0/zJShVSYR18meuT5ojBNJznomOyb9ZEuHdL1u3ktDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GogRUarr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453066fad06so24202895e9.2
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749933033; x=1750537833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8g8uO7HjY9+JQ64Y0yYzrwnttWPD+Po4IqamxEMFJ7Q=;
        b=GogRUarryIpu0qgNgxrqOemqDBaGe1GnBr/hj5dcXish7/kW8n3RmlCvaCLRCNvjyY
         nEDf5NqYEvOTj0es1aNqAgwKGYN3GwrlGIh7lPJnUPwq/2yL26YZkPMervJMgAvbtk2d
         eDC6rqD0elZCSWz0oOl44FEvZQBQgiDoO0IsAcwn/J7oUbQ3XWjMttd1tO0EkwSDYFeh
         vqUa12lDixc+OK2AfqX+/ZFloXmopD+LVHUITL2em5qJub45hu+BbLmX5JShC4m9BonV
         ZntujGLmn8gCBvtzm9+9XvcKuzOGAkAL3SBlmHoC4CjZaNppvHTGx/ZjR8hbs8kTD2S+
         c8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749933033; x=1750537833;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g8uO7HjY9+JQ64Y0yYzrwnttWPD+Po4IqamxEMFJ7Q=;
        b=HbmNg0jdVqvZtbsutlIK6SbiaOXwQS65OrJy2qiokf200kri/M2Ye2wKhR2qkkth+Z
         3rQG1Yz1e3SajTNhBq190GQhTmntqc4VmkFyTUXTOx0PsKWrRzsebvEej6DAOxHl/ZTZ
         Bth7kx9MMpWf0h3k15iMj3XPCioe0iF/LoVzq03+cwL6axo7mxdcVkE8T8ucE8Ltuuu1
         0j4GLO+CVy58g9NMwIIywPSOg4tslzBb5nhsdaZkhWSZBBdJOFBtF6noNo1SFP7fNxBm
         Ihkt0uRHAOie2/+YUhVcq+xxYhUYvmER5d9f9fMy6bY4zdbpn+KUArTDQ5cgk74bjkFR
         ijGA==
X-Gm-Message-State: AOJu0YwxWPDioXNwG30c62Ssxn5MYb+8hraOwtTNTkisUfyI3RpKJUqA
	moG4MoUhNQbq4zGO7etW3vDEEPFCNE/NJNxO4gceA2FzCSVdUaq+qUsA
X-Gm-Gg: ASbGncv+Atb0YDbU+eKxI5fOwS6sqiqwzmvW+kFRWc+sJ29Y42xS1BUm4XwhwUgTR7i
	UvI4mc0fnp6lD/q/obvnaobRX0nizfUC/Ug7ziuD1TCa1AGD3s8rOcMgkZ4jMfi1md9kmy2YNzf
	aUplqYxz8SRkZA6933M1slkYEAHwtUFELlVKcnnyJGxsXqwuqrPj2nH6gIXADgXfz9si/4ubwVl
	tq0K34aYHlr3xzvYZCn95+Ox+DXWg88jkcqTJ+lHelcyAHR8VZxQIhDcLlg5YHIx+50JqLgVOsf
	F0D/jwNoQTvkc8iIxcYBNGtu+G+x3b3YLZpeFb+/nEEwrchEnHYkQ3oVhwiTUB4M6IpCVgWW4OC
	zC3u28V1EoKZ4fRMIjbedXV6HJdFsLO+vbf0WN88pwwjXdL3CnducNIzP/gMy6ddW5a84FAqg8e
	jSA1Ifpv41L3ghERTC2pWCwJ36Aq2hlNmbt7+9
X-Google-Smtp-Source: AGHT+IFMMRSqzbGRHCW+IkJMyIhn+BDzUT9h/oU92Q+ruCKPAVYUo2bD5codT2RpG0LYP/o3TM14Fg==
X-Received: by 2002:a05:600c:828c:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-4533caa2172mr37201525e9.21.1749933032736;
        Sat, 14 Jun 2025 13:30:32 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:2b00:1164:b467:ea80:aea5? (p200300ea8f472b001164b467ea80aea5.dip0.t-ipconnect.de. [2003:ea:8f47:2b00:1164:b467:ea80:aea5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453421fe188sm17620065e9.5.2025.06.14.13.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 13:30:32 -0700 (PDT)
Message-ID: <3f3ad6dc-402e-4915-8d5a-2306b6d5562b@gmail.com>
Date: Sat, 14 Jun 2025 22:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/3] net: phy: add flag is_genphy_driven to struct
 phy_device
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to get rid of phy_driver_is_genphy() and
phy_driver_is_genphy_10g(), as first step add and use a flag
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



