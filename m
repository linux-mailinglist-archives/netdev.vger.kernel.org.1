Return-Path: <netdev+bounces-190616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BAFAB7D39
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A45189C16F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B752957C2;
	Thu, 15 May 2025 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAxTfly0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1E295506
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288089; cv=none; b=k9QtQnFk1bDzgZiOcmZla8+zwwhGDlIu1khbsp3q8mP6f+9thCDJLzpB33QZ/0ykJGaBMkfAbgExtyXZ+/W3Fww1ktha5+5MsxZaPOgSn+6LLU7pR2MaUyueLdFfZOlGiCsi5Tt8uCh+6PrbWAfvGN6Y2cBmFixJP7jWIoNTbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288089; c=relaxed/simple;
	bh=JOiatNQBf9gchLRG0OutYn/9esvBIUVCHAoSaDwbX8g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qGhRDiiEfehEYF0bAlhZY6DbPw+BpMnGH1v1ISz/xHJHBCN4XK66ONPfikeDZ6f+76NFXwGhbX/o5M7sQG2JUZ60E7I578A9tYO4x7W4b2/2qw2flfjSy3KTYIh9BTSOhfaXB9t8AWHSnv1AqaVC9Iz0EO71i8scOOMqtGk1znY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAxTfly0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so275051f8f.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747288086; x=1747892886; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwX8dlOWc1RLRAscoe5M4eunlrZmsCw9s0yjcc+sLjc=;
        b=UAxTfly0lv7bKlXM2NOYfuf7E3dBiWoVMyhPI2hr3DPSq2fx1UAN+CBNkZQsmvwOVO
         kKGbCPKYvw451bS02MDw6cWFYoxe5MnNAI+tj4MRFdw9ZrcQzeZsNsFIkmxcRU+U8fVk
         PKBvM1xqXjkTqG3VT/nYIW97Nu2lIN+cquV7jbpct8VpbSvQWCC5N6V4lF/DmcefJyBo
         TPEoIS8MaCdcTGHUJRtoBy+Z8KYZdJkFugwasR8BkMvBPDIyco1mJK49EvutXQRbAPOr
         xesaJ3RKCTLQX4SH7mb67XyoCIrC/5ClHQrq0E8wYCI9Poaj+Y4CH1eUSsua3zhi47xz
         VyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747288086; x=1747892886;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwX8dlOWc1RLRAscoe5M4eunlrZmsCw9s0yjcc+sLjc=;
        b=ZvGX/mSaojEQ//eJhJH+v7YxvsKIuRLXsL0r7pONhwsGm20xh6NMMzvhCQzbFMiNGa
         +1FYZOtvG+0iYBL/aoMnsEgd+GFqqbLMWoX5SJA99eu3UGA0a4rMDspUcWtV5w6xGCuf
         RNZn45dITC48/INLQzDW+nLzBjbhPZCw1g8RmQ9XeKuraNx92rBptWnAiRPxPEGA4k/X
         ybDdOvg+vlmarZv5BEjCjQ0l5DGxmMAT92sZKZ+tfjKbLiP286qvOFsgOxzdfQ6sG1On
         yCjV1UPDq98QEe0diqtie7s+ITeQKTOCxKtg8fg3FsbrqsFeq/Ty8gtP1NAdtr4kZqDL
         d9Ug==
X-Gm-Message-State: AOJu0YxIPkOBwHvE6RUzGH8dJxh3JBJF+y4K9ufgMXkDppGb8NEVwVqy
	/Nc7Qqvl8DtirGvR7IzfqF7eZZmZTaZopPlvQOHtMDrOmAftlrqo
X-Gm-Gg: ASbGncunxUQToj/8pbsW/l9VaqFwip8+ZAS/nAvlhZ8o+t+xw3g94YOv+qkdsD/XaH0
	E4QOSINDWpkS1FNShKZB7tLG0sF8D2E5QDh9XjDB0PNMGIRoE7gvWCCKjihUjP2S7i1CX1XJAXL
	FKLzM+OkPlVLYPFx00YUUW6md0jaAJ1eXYt8u2gv9ZOoXJk2KbC8QXEkgRBT0CHxZiCQC7VaedR
	3m5Mzle6TGzDG1G4sPGjFj1OmJPyqSi/oTfaeUVh4MCFAKo4m3Bn3wO65YviP59PvyfJytx7kci
	tx7LNOZnQ85SXy66T9df2q5pTO5DhsC0gbSdndEbcZvKod2ytNbk9Vek+0jgoR6abx+ysik3UMv
	k/Td/QnIwca6h0iaBIiFY6KsArRAE6M681TyIDqA80NOReFT1/Pp4NrPvlCsPdfqV01Wc8OSAeB
	Tlop1xBBsTdN1V
X-Google-Smtp-Source: AGHT+IHh3QcqKXg1Qj7w5W+u5+zzqP7XJED3S5G9vcz28RPo1kvG0pI8Yu0Alme2yZnOi5MQv+763g==
X-Received: by 2002:a05:6000:1789:b0:391:2e6a:30fe with SMTP id ffacd0b85a97d-3a3537aac5amr926908f8f.39.1747288085841;
        Wed, 14 May 2025 22:48:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:108a:494:9658:90b2? (p200300ea8f4a2300108a0494965890b2.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:108a:494:9658:90b2])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf0esm21749272f8f.79.2025.05.14.22.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 22:48:04 -0700 (PDT)
Message-ID: <9a284c3d-73d4-402c-86ba-c82aabe9c44e@gmail.com>
Date: Thu, 15 May 2025 07:48:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: make mdio consumer / device layer a
 separate module
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After having factored out the provider part from mdio_bus.c, we can
make the mdio consumer / device layer a separate module. This also
allows to remove Kconfig symbol MDIO_DEVICE.
The module init / exit functions from mdio_bus.c no longer have to be
called from phy_device.c. The link order defined in
drivers/net/phy/Makefile ensures that init / exit functions are called
in the right order.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/mdio/Kconfig     | 16 ++--------------
 drivers/net/phy/Kconfig      |  2 +-
 drivers/net/phy/Makefile     | 18 +++++-------------
 drivers/net/phy/mdio_bus.c   | 14 ++++++--------
 drivers/net/phy/phy_device.c | 11 ++---------
 include/linux/phy.h          |  3 ---
 6 files changed, 16 insertions(+), 48 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index d3219ca19..7db40aaa0 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -3,21 +3,10 @@
 # MDIO Layer Configuration
 #
 
-menuconfig MDIO_DEVICE
-	tristate "MDIO bus device drivers"
-	help
-	  MDIO devices and driver infrastructure code.
-
-if MDIO_DEVICE
-
 config MDIO_BUS
-	tristate
-	default m if PHYLIB=m
-	default MDIO_DEVICE
+	tristate "MDIO bus consumer layer"
 	help
-	  This internal symbol is used for link time dependencies and it
-	  reflects whether the mdio_bus/mdio_device code is built as a
-	  loadable module or built-in.
+	  MDIO bus consumer layer
 
 if PHYLIB
 
@@ -291,4 +280,3 @@ config MDIO_BUS_MUX_MMIOREG
 
 
 endif
-endif
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 677d56e06..127a9fd0f 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -14,7 +14,7 @@ config PHYLINK
 
 menuconfig PHYLIB
 	tristate "PHY Device support and infrastructure"
-	select MDIO_DEVICE
+	select MDIO_BUS
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 59ac3a9a3..7de69320a 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -6,27 +6,19 @@ libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
 				   phy_package.o phy_caps.o mdio_bus_provider.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
-ifdef CONFIG_MDIO_DEVICE
-obj-y				+= mdio-boardinfo.o
-endif
-
-# PHYLIB implies MDIO_DEVICE, in that case, we have a bunch of circular
-# dependencies that does not make it possible to split mdio-bus objects into a
-# dedicated loadable module, so we bundle them all together into libphy.ko
 ifdef CONFIG_PHYLIB
-libphy-y			+= $(mdio-bus-y)
-# the stubs are built-in whenever PHYLIB is built-in or module
-obj-y				+= stubs.o
-else
-obj-$(CONFIG_MDIO_DEVICE)	+= mdio-bus.o
+# built-in whenever PHYLIB is built-in or module
+obj-y				+= stubs.o mdio-boardinfo.o
 endif
-obj-$(CONFIG_PHYLIB)		+= mdio_devres.o
+
 libphy-$(CONFIG_SWPHY)		+= swphy.o
 libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
 libphy-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o
 
+obj-$(CONFIG_MDIO_BUS)		+= mdio-bus.o
 obj-$(CONFIG_PHYLINK)		+= phylink.o
 obj-$(CONFIG_PHYLIB)		+= libphy.o
+obj-$(CONFIG_PHYLIB)		+= mdio_devres.o
 
 obj-$(CONFIG_NETWORK_PHY_TIMESTAMPING) += mii_timestamper.o
 
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index f5ccbe33a..a6bcb0fee 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -988,7 +988,7 @@ const struct bus_type mdio_bus_type = {
 };
 EXPORT_SYMBOL(mdio_bus_type);
 
-int __init mdio_bus_init(void)
+static int __init mdio_bus_init(void)
 {
 	int ret;
 
@@ -1002,16 +1002,14 @@ int __init mdio_bus_init(void)
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_PHYLIB)
-void mdio_bus_exit(void)
+static void __exit mdio_bus_exit(void)
 {
 	class_unregister(&mdio_bus_class);
 	bus_unregister(&mdio_bus_type);
 }
-EXPORT_SYMBOL_GPL(mdio_bus_exit);
-#else
-module_init(mdio_bus_init);
-/* no module_exit, intentional */
+
+subsys_initcall(mdio_bus_init);
+module_exit(mdio_bus_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MDIO bus/device layer");
-#endif
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f85c172c4..c06a1ff9b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3557,19 +3557,15 @@ static int __init phy_init(void)
 	phylib_register_stubs();
 	rtnl_unlock();
 
-	rc = mdio_bus_init();
-	if (rc)
-		goto err_ethtool_phy_ops;
-
 	rc = phy_caps_init();
 	if (rc)
-		goto err_mdio_bus;
+		goto err_ethtool_phy_ops;
 
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
 	if (rc)
-		goto err_mdio_bus;
+		goto err_ethtool_phy_ops;
 
 	rc = phy_driver_register(&genphy_driver, THIS_MODULE);
 	if (rc)
@@ -3579,8 +3575,6 @@ static int __init phy_init(void)
 
 err_c45:
 	phy_driver_unregister(&genphy_c45_driver);
-err_mdio_bus:
-	mdio_bus_exit();
 err_ethtool_phy_ops:
 	rtnl_lock();
 	phylib_unregister_stubs();
@@ -3594,7 +3588,6 @@ static void __exit phy_exit(void)
 {
 	phy_driver_unregister(&genphy_c45_driver);
 	phy_driver_unregister(&genphy_driver);
-	mdio_bus_exit();
 	rtnl_lock();
 	phylib_unregister_stubs();
 	ethtool_set_ethtool_phy_ops(NULL);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c29d346d..92a88b5ce 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2033,9 +2033,6 @@ int phy_ethtool_set_link_ksettings(struct net_device *ndev,
 				   const struct ethtool_link_ksettings *cmd);
 int phy_ethtool_nway_reset(struct net_device *ndev);
 
-int __init mdio_bus_init(void);
-void mdio_bus_exit(void);
-
 int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data);
 int phy_ethtool_get_sset_count(struct phy_device *phydev);
 int phy_ethtool_get_stats(struct phy_device *phydev,
-- 
2.49.0


