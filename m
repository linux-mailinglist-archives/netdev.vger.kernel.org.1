Return-Path: <netdev+bounces-248260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB59D060CD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 323773019574
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B89325736;
	Thu,  8 Jan 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HflUIejB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC432D42B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904032; cv=none; b=ZbSv3h/9JuFj+DrbHRsWINaapo/F9Lzdh9Jn2yYLYqo80yZkEQScvv3AQozgSJUdJw9zZhTj4LL6lg+Dqb3kJOzUMgOujwx/sfCZE5dtjmYDl9PQQ09Wo3tb3qrSmJxUHHH/BbwGcryS7QbHlNMhi2s6SUnpKHt+yHS4QnvKnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904032; c=relaxed/simple;
	bh=+RHUDAGhqDEsevrloWj5YslF4KS0wPESy7wch2rAXVo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LrlrgtM23F6bGRG3o3OY+NAyQXRihkqT/uJPNCwj5a6BvB107ty8zuZ4ujUPCIuOeoNC1Y02aq9n2J8+GPefSOWszNlfjDFCgjl3m2HP3/9ag/v1eiS2AIgkxnVWOdkV2elOL80yLKicWeTGGbORXUKwvuzzfZdCL9DO3uLlaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HflUIejB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so39137345e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 12:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767904029; x=1768508829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z0Ts2P2d09M1U09fX4p9g5VRNOOhKysYhc1hv4q5ekI=;
        b=HflUIejB4Y6EhxPY3ZSf/6pjGY55eh9gztKoZIJI2MwMCplzzBrjfPrjWwUpe7Vrbz
         CsvRcrtrzdhiCP+6grfR3d7OiRXigT7GpB7G09ndIevHfwBXdVl5rHfry/8h/uKTyqp9
         k8OhZuHpK8J6IzYEW8KzL1c3Q3XbH0wrXQuCUf1VWffORoF0iMFUsbtdYQcSmrCfgm9e
         TK9wyGh5tFdtpThZg3PL5OfFNEKCf82L2aXJbGq1x8hNiSADvfzLpB62IaRIgNW7Fm0I
         Kn3//dptSto59U2OODXXQTUS7H97bpcoby4Ck9eG3AkDjFuI9nfVjVvIesppIE0HO4c2
         GBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904029; x=1768508829;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Ts2P2d09M1U09fX4p9g5VRNOOhKysYhc1hv4q5ekI=;
        b=tDFOxpMhqOkrrW0g83HgTyaRjaPNpJ2/V64jPI6PQSprl5n563+65MAnOJqEkTzQC/
         f7gmmPdTwYyR4GLSD7C8c/waO44dM2KUw9gUZcjBqLomdFDbcfyAtYq85fm3PzXoa79f
         VkhAl28pbdOMKownmyvd6V5EjEk+oq/7Gs7TQCEaZjns4gYd7ZAJi/c7s582MZSZHddN
         /rEqo4fENkg3UoEH2BeaBe0X/MD597/LxQaY+I5MYg+9sBLFKq4FIgN13OskzP375av2
         oQHsdA3hBWLccctg+FnmlBR/G/wZg0j7J+juGHkc0apFgS9dKvBbXPAgoilMpoOjDf3z
         shFw==
X-Gm-Message-State: AOJu0Yx2MnK880FPWS/fJiPFSgP0tXlK3K0lea0NdRj42gdWIMx9kh1F
	VdID7VQ0juDP4ICWdrv5X1r4MhAFonTT7NkvOcUCkJ5ug13aBhaPv4dc
X-Gm-Gg: AY/fxX6rozJo8E1+D5jBTLQOCjX3keCeZ9MwEc22B/tUGjU8FBl5nI+VB9Ie/kUKJXk
	dYKdxJk7V6qUhouaQUBTEbnPG4fOaKAToKNW3VWpfBftHyjDu/VjFs16OzDTwF9qAGI7NvZNw/N
	cwVr/UodAqtbtmmYjhoKZ5WNevOxpCgmHTuqfGhFZTpzTnyR+AZrh/zL+vJynbzyW9zdqSvDGz+
	K39L6zJreb8xuuo/nvvvSdjlOG5K4Zch3h2lSZAPpLCSAqGPRUx9otzaBdR6DKOsnf84FsVFciQ
	A42qnCSqIgKVc+WI1qJ8U/kwj81u9UBhHbVFgnhUh6+QRtxm3zdbg6vduTu9l8Ye1MZtjQGWGxg
	UDX7ecA3G4LkidFiOgqicyXbxnThPiJn0VFl7J3k3fJ53NtuHJ4eiBC4PgogVu9zCMrVsTnfMLK
	vQrn0ZlzU6tNIfIo6W7Hb3vybfrlI4KmPSlewMu1pLljjXHux2czJc/uXs27uVEd80fk7kqLRLg
	QjGbyvWt/fYIlMkG3c8oKIygFJVPouIw0vzKRQo1d6Nipf0HOX5ew==
X-Google-Smtp-Source: AGHT+IGTLby2AWOlbTSlHgacqisYmtzmWA1F4EFR2vaZFn9dSPRmP7XXeVpCHz1f/MHmHYFuc8sq2w==
X-Received: by 2002:a05:600c:a102:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-47d84b32793mr78315575e9.23.1767904028645;
        Thu, 08 Jan 2026 12:27:08 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:a400:1d60:60fb:9b76:bf18? (p200300ea8f14a4001d6060fb9b76bf18.dip0.t-ipconnect.de. [2003:ea:8f14:a400:1d60:60fb:9b76:bf18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm168904585e9.13.2026.01.08.12.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 12:27:08 -0800 (PST)
Message-ID: <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
Date: Thu, 8 Jan 2026 21:27:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for RTL8127ATF
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
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
Content-Language: en-US
In-Reply-To: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
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
 MAINTAINERS                            |  1 +
 drivers/net/phy/realtek/realtek_main.c | 54 ++++++++++++++++++++++++++
 include/linux/realtek_phy.h            |  7 ++++
 3 files changed, 62 insertions(+)
 create mode 100644 include/linux/realtek_phy.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa21..6ede656b009 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
+F:	include/linux/realtek_phy.h
 F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index eb5b540ada0..b57ef0ce15a 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/realtek_phy.h>
 #include <linux/string_choices.h>
 
 #include "../phylib.h"
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
diff --git a/include/linux/realtek_phy.h b/include/linux/realtek_phy.h
new file mode 100644
index 00000000000..d683bc1b065
--- /dev/null
+++ b/include/linux/realtek_phy.h
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



