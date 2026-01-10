Return-Path: <netdev+bounces-248707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C6D0D87C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9289B3011AAE
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A721346E42;
	Sat, 10 Jan 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD6pI2w+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7430346AF9
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768058050; cv=none; b=LCj8//TKwMM+kdU+U86PJwzxBAYNBBBEg996hbTR6v7uFtmLXp/emNdjBFh9/JhTy1NR5H56b0hKuF21rVRieeJX+CKndwN9rIQUIGTOvqKHt3HP70W5r58EYnge9j8msQ7o1GmKjFeh0i7czG6vPDGm54L1zv+JaDTOre6Qyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768058050; c=relaxed/simple;
	bh=6gPDp4bkyJhaWXTtZMAzeXPeZP3PzvVRQTGRJsMtMjE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b3D3LDyreGYCJVvVOaW5GyPPgxGX0yLZxPyMHqcKsED9jyP605LeAzF4/ep0GpZYCPLfR/VLJ/CcGxeY6p2vvNSAe+W7zDpV2rMzLEVJLQsFDqHh9CXaPoJsaUx4tC0bMK+6UrXi8dtM5cTFdcfd8pzq7qjkllBZKnVz/NCBQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD6pI2w+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43277900fb4so1741980f8f.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 07:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768058047; x=1768662847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1v38WA8OC8zEQ4mp1ZWGQLN0/65m3iKsAkRqIwqHkMQ=;
        b=MD6pI2w+/wuZdZPW0I8lcLkSYsWeRn5A5BSTgKw8KC9IHN67cNDg2jAQSWfF0GEw1s
         RY1HvYwiena099w9FEYTXPXHxhocsuJaMEd10QahiMha/9cOY7c/soNANj78XxOgeN0o
         kI+wh1BrUfbdQuxfnPXAycVgu+t2LAekGjyGnMRU+Uj3ZWiNnr2AZf/IUqTfvwGqswbq
         vmHknq+FbmyX96OOfr76s6RVpcwXeCiifH7Q+8g7PSvjqEuw6nN0mixDRgqvgdo0MD5L
         AKJrmlNqEO7vzMHWX2P5U99oJ4wQ7yRHrh8Rt3iCgArLreKm3lueDfq4l/0Nc35v8L9j
         QDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768058047; x=1768662847;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1v38WA8OC8zEQ4mp1ZWGQLN0/65m3iKsAkRqIwqHkMQ=;
        b=XsO5zka3FD3KHIXXxmUQSq3p+Em1ROhChYEQz1EVcB2Xv0fboskF8/bF2hiMCQKjRa
         X/geFQtKwfabjtMnfh9CRkqLiMdHFEuGYdyA3b6KRd41L5T6bHw5EwRdv8mDWdzrYsFQ
         iFzol4ETtLA9RoeMCjhUs6C7N3i58voYSaZJqVLySZzVF0/eQABn6nxQ/B1KlWizlPtF
         maEQmWf8GjuJXLId0UAPPyQ+8Wj7CdJDcBHHmt6e4XWxFp9xNqTQuHsZZ8pRBYCcWzPh
         JzVEYX5tznlyZSjDR81YILweW99ETAnJJpk+SS4axPR7GwBFmYoVIEzi3v5AaiwFK6Ef
         sQFw==
X-Gm-Message-State: AOJu0YxD7g4q7God1XRmqV7QfyuBrg++RYKw6CMQefTZvOYBZvvUP33X
	BXTuQ6W1Bds/SJ3f7NQ52eKDY1YDwRUvFv8dReU0hTt4MZu2F2LnfO/O
X-Gm-Gg: AY/fxX4tCOmy7lFrL5qVGbnkQCaZ5z82QnOGr5h0DzhSUDFZPVHaYpbrY2qxYGSaXAu
	6W8bBT7yHZgO8ClKbu5QTnnBWYEPjA2Mx99M5BCh8Kjk0IuZiMgANwZ2JwohfZJ8AzQT45Ua6Gr
	xSmB/OKFvGXecjT7KA525laXkjooWnM4c/leaOSfNxT1vEVq+TDO9rJ16hHO0LGvGzDAEHWXzJn
	45iaYakywsWD7SVSgPxCimiPdqlAkkiT5YQ9pBBEMmyi+3f93UXp52DDFuUbNafTn9X+XZUuqyG
	hr0TRuOZlFzNlYmnhf5g3nUjwrG9pZl1j20VQ9jINwu9ZmQPOXJQmRG1risj7m0QUpFDt0KZx4D
	9a0Z25QnOhqbtH99G84WORWBn3p8WFw5oOml3pq8v8bYMBjoSSntpDUE673PQlNiL0SseKmgzmN
	ehU0fxRAZ2hrtQr1M5KMcDbhs7HFcYCRSe0apMfgGDDHaglMYtYD0Z+DKoM3pKen2bjnwD9x452
	O4Kc1BErZEZG5+pShNTUdaBix5Sz9dSzAI+s8qZNNkrFvstVTI7fg==
X-Google-Smtp-Source: AGHT+IGmNOktrkMsRGSRoFZEzpHaYVFUh13/BWWs4wn7goCRo9+Vrg1G4iHidfZ7oS2QLut++KLwTA==
X-Received: by 2002:a5d:584c:0:b0:432:5a4e:c023 with SMTP id ffacd0b85a97d-432c364532fmr17065638f8f.13.1768058046970;
        Sat, 10 Jan 2026 07:14:06 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa84sm28250798f8f.2.2026.01.10.07.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 07:14:06 -0800 (PST)
Message-ID: <e3d55162-210a-4fab-9abf-99c6954eee10@gmail.com>
Date: Sat, 10 Jan 2026 16:14:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/2] net: phy: realtek: add dummy PHY driver for
 RTL8127ATF
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
Content-Language: en-US
In-Reply-To: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
DAC). The list of supported modes was provided by Realtek. According to the
r8127 vendor driver also 1G modules are supported, but this needs some more
complexity in the driver, and only 10G mode has been tested so far.
Therefore mainline support will be limited to 10G for now.
The SFP port signals are hidden in the chip IP and driven by firmware.
Therefore mainline SFP support can't be used here.
This PHY driver is used by the RTL8127ATF support in r8169.
RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
PHY ID.  This PHY driver is used by the RTL8127ATF support in r8169.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- move realtek_phy.h to new include/net/phy/
---
 MAINTAINERS                            |  1 +
 drivers/net/phy/realtek/realtek_main.c | 54 ++++++++++++++++++++++++++
 include/net/phy/realtek_phy.h          |  7 ++++
 3 files changed, 62 insertions(+)
 create mode 100644 include/net/phy/realtek_phy.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa21..44a69cc48b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
+F:	include/net/phy/
 F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index eb5b540ada0..5a7f472bf58 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/string_choices.h>
+#include <net/phy/realtek_phy.h>
 
 #include "../phylib.h"
 #include "realtek.h"
@@ -2100,6 +2101,45 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int rtlgen_sfp_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported);
+
+	/* set default mode */
+	phydev->speed = SPEED_10000;
+	phydev->duplex = DUPLEX_FULL;
+
+	phydev->port = PORT_FIBRE;
+
+	return 0;
+}
+
+static int rtlgen_sfp_read_status(struct phy_device *phydev)
+{
+	int val, err;
+
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	if (!phydev->link)
+		return 0;
+
+	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
+	if (val < 0)
+		return val;
+
+	rtlgen_decode_physr(phydev, val);
+
+	return 0;
+}
+
+static int rtlgen_sfp_config_aneg(struct phy_device *phydev)
+{
+	return 0;
+}
+
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
@@ -2361,6 +2401,20 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
+	}, {
+		PHY_ID_MATCH_EXACT(PHY_ID_RTL_DUMMY_SFP),
+		.name		= "Realtek SFP PHY Mode",
+		.flags		= PHY_IS_INTERNAL,
+		.probe		= rtl822x_probe,
+		.get_features	= rtlgen_sfp_get_features,
+		.config_aneg	= rtlgen_sfp_config_aneg,
+		.read_status	= rtlgen_sfp_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= rtlgen_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822x_read_mmd,
+		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
diff --git a/include/net/phy/realtek_phy.h b/include/net/phy/realtek_phy.h
new file mode 100644
index 00000000000..d683bc1b065
--- /dev/null
+++ b/include/net/phy/realtek_phy.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _REALTEK_PHY_H
+#define _REALTEK_PHY_H
+
+#define	PHY_ID_RTL_DUMMY_SFP	0x001ccbff
+
+#endif /* _REALTEK_PHY_H */
-- 
2.52.0



