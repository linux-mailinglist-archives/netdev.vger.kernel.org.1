Return-Path: <netdev+bounces-66397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E643783ED45
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987F5281F4F
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C92557A;
	Sat, 27 Jan 2024 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVeHhugP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC92033E
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361916; cv=none; b=lwFHNOekn/0QyA1hevmIGYCM6QtVaTxKbUxaUeryZqDsuclAX7S8o9ESRY4qzxxcyeXH6bx752CMY+FuXLk4opkpOJSO15NfZjWqJxmjkgKL0nHBAxdTnfJ6W8Vlb6sx2EpYDepamf62ymjR8/Djb9Cs5nqOsgbQ/m+hyTlGsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361916; c=relaxed/simple;
	bh=HtcBcCzIgVGah0hBEm2GlwSH4BflMgSaedB6A6Sbm/w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WVABzeq4p+NIJiz/Qd6UVgOvbW7WzdSC8qH9hPNIL00GzFdPO8el2iJZpIctAilRc2+WlgmfLNJOpP6ke5tF1qr8wdgSah3S0Nsp/NMJPhsuW/d75dB7/mi7VA3SEly+ehByRXjnR+qc4p3N5zYQM13sI7MvIhvPaDaC31nXYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVeHhugP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ef0908c84so1489145e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706361911; x=1706966711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn6RuSyasDMR0Opaz5ojeocOGl9/ombkDQQ8WcyRL8M=;
        b=lVeHhugPhcOz5BGr8LbS2m5nxmhk+I/KEDdrOYTFU7/Qtyh57kZewUXSB9vOUvqTim
         GF79DuwNsMW5sKTMGIvOYrOaZ545yVTOnQGkrcGuf8gynMht0rx66BnXuuGCuiUawqE/
         ZV1Yzyx9wVDHfWvFVPBCX+1I3UKrMXxBoX8nJ5nsomBYymR3Sl1eC7lBaAs9+XfAarOR
         PQ96a5dpNwqaZ1UbxmP4dFjKLFhCfE8XbD9PPs/aqBpIdqgOyLLXU0KoUt3q1TH4vfLr
         ur87Rqd1LPwCQr/mhdPmgTVtmBqsl7N9BoIsnu/Wj19f0yeg+dEQTN5WSNDZNffXBHRW
         +fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706361911; x=1706966711;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn6RuSyasDMR0Opaz5ojeocOGl9/ombkDQQ8WcyRL8M=;
        b=tHXIGTOF6IIV8l+CJBrHisDQrgooSVdIXDL9S2F6I3Tp3bo8+npRDRfa0JxL353g5b
         BmRMi4zNCOSk2uwQ+jvvLoVnm8ETgloFhfho9U/Vb5OFIzp7oVhh5+Pjx7x/2vjywE7g
         zH0gWIG7DX1H1Mq+SkhowTPhpgQ7uHy3h2wchjceLvVfeJ8yFohw4Tplvc75W4XmyhUb
         OpZ7PsHw3zMN9tHqIe+EzuAzufsZ7ghUgYAZKcKIJGboWF4WWVk3aTctWOh0XwKs6mKa
         juM+63cduJSvG4c0qYVc/FWxTIQoeoY4rWio9cheY13HcJ/Xzi3lJZs/X86/+APcjgYA
         2BJg==
X-Gm-Message-State: AOJu0Yxcmkwdo5rsRBzKXkKwkdcYbjVLH84JqB/2OBbhKJz10ZFTvVh1
	Z0QOrR7vzyTo9DrvEszqwCowkA3S6Rd32Vhq3+PlqtZbDu/5GT3K
X-Google-Smtp-Source: AGHT+IFFDj04BLBCXjmhrlLO89JLjK5fOGg38I8zxyDyOpCS9XarXVPvYkCLQmMFX6JCe9/h6E6t3w==
X-Received: by 2002:a05:600c:1986:b0:40e:e97c:e71 with SMTP id t6-20020a05600c198600b0040ee97c0e71mr1399163wmq.1.1706361910259;
        Sat, 27 Jan 2024 05:25:10 -0800 (PST)
Received: from ?IPV6:2a01:c23:b938:5400:11ba:857c:4df8:38b0? (dynamic-2a01-0c23-b938-5400-11ba-857c-4df8-38b0.c23.pool.telefonica.de. [2a01:c23:b938:5400:11ba:857c:4df8:38b0])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b0040eccfa8a36sm4732850wmp.27.2024.01.27.05.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:25:09 -0800 (PST)
Message-ID: <a3842379-1f85-4a62-9bf3-53a17f813668@gmail.com>
Date: Sat, 27 Jan 2024 14:25:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 1/6] ethtool: replace struct ethtool_eee with a
 new struct ethtool_keee on kernel side
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to pass EEE link modes beyond bit 32 to userspace we have to
complement the 32 bit bitmaps in struct ethtool_eee with linkmode
bitmaps. Therefore, similar to ethtool_link_settings and
ethtool_link_ksettings, add a struct ethtool_keee. In a first step
it's an identical copy of ethtool_eee. This patch simply does a
s/ethtool_eee/ethtool_keee/g for all users.
No functional change intended.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v3:
- rebased
---
 drivers/net/dsa/b53/b53_common.c                 | 10 +++++-----
 drivers/net/dsa/b53/b53_priv.h                   |  6 +++---
 drivers/net/dsa/bcm_sf2.c                        |  2 +-
 drivers/net/dsa/microchip/ksz_common.c           |  4 ++--
 drivers/net/dsa/mt7530.c                         |  4 ++--
 drivers/net/dsa/mv88e6xxx/chip.c                 |  4 ++--
 drivers/net/dsa/qca/qca8k-common.c               |  4 ++--
 drivers/net/dsa/qca/qca8k.h                      |  4 ++--
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c  |  4 ++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.h      |  2 +-
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c  |  8 ++++----
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c  |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c        |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h        |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c    |  6 +++---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c   |  8 ++++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.h   |  2 +-
 drivers/net/ethernet/broadcom/tg3.c              | 10 +++++-----
 drivers/net/ethernet/broadcom/tg3.h              |  2 +-
 drivers/net/ethernet/engleder/tsnep_main.c       |  6 +++---
 drivers/net/ethernet/freescale/enetc/enetc.c     |  4 ++--
 drivers/net/ethernet/freescale/fec.h             |  2 +-
 drivers/net/ethernet/freescale/fec_main.c        | 10 +++++-----
 drivers/net/ethernet/freescale/gianfar.c         |  4 ++--
 drivers/net/ethernet/intel/e1000e/ethtool.c      |  6 +++---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  6 +++---
 drivers/net/ethernet/intel/igb/igb_ethtool.c     |  8 ++++----
 drivers/net/ethernet/intel/igc/igc.h             |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c     |  8 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 10 +++++-----
 drivers/net/ethernet/marvell/mvneta.c            |  4 ++--
 drivers/net/ethernet/microchip/lan743x_ethtool.c |  4 ++--
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c  |  4 ++--
 drivers/net/ethernet/realtek/r8169_main.c        |  4 ++--
 .../net/ethernet/samsung/sxgbe/sxgbe_ethtool.c   |  4 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c |  4 ++--
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c      |  4 ++--
 drivers/net/ethernet/ti/cpsw_ethtool.c           |  4 ++--
 drivers/net/ethernet/ti/cpsw_priv.h              |  4 ++--
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c    |  4 ++--
 drivers/net/phy/marvell.c                        |  2 +-
 drivers/net/phy/phy-c45.c                        |  8 ++++----
 drivers/net/phy/phy.c                            |  8 ++++----
 drivers/net/phy/phylink.c                        |  8 ++++----
 drivers/net/usb/ax88179_178a.c                   | 10 +++++-----
 drivers/net/usb/lan78xx.c                        |  4 ++--
 drivers/net/usb/r8152.c                          | 14 +++++++-------
 include/linux/ethtool.h                          | 16 ++++++++++++++--
 include/linux/phy.h                              |  8 ++++----
 include/linux/phylink.h                          |  4 ++--
 include/net/dsa.h                                |  4 ++--
 net/dsa/user.c                                   |  4 ++--
 net/ethtool/eee.c                                | 10 +++++-----
 net/ethtool/ioctl.c                              |  6 +++---
 54 files changed, 159 insertions(+), 147 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0d628b35f..adc93abf4 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1257,7 +1257,7 @@ static void b53_adjust_link(struct dsa_switch *ds, int port,
 			    struct phy_device *phydev)
 {
 	struct b53_device *dev = ds->priv;
-	struct ethtool_eee *p = &dev->ports[port].eee;
+	struct ethtool_keee *p = &dev->ports[port].eee;
 	u8 rgmii_ctrl = 0, reg = 0, off;
 	bool tx_pause = false;
 	bool rx_pause = false;
@@ -2224,10 +2224,10 @@ int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 }
 EXPORT_SYMBOL(b53_eee_init);
 
-int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e)
+int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 {
 	struct b53_device *dev = ds->priv;
-	struct ethtool_eee *p = &dev->ports[port].eee;
+	struct ethtool_keee *p = &dev->ports[port].eee;
 	u16 reg;
 
 	if (is5325(dev) || is5365(dev))
@@ -2241,10 +2241,10 @@ int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e)
 }
 EXPORT_SYMBOL(b53_get_mac_eee);
 
-int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e)
+int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 {
 	struct b53_device *dev = ds->priv;
-	struct ethtool_eee *p = &dev->ports[port].eee;
+	struct ethtool_keee *p = &dev->ports[port].eee;
 
 	if (is5325(dev) || is5365(dev))
 		return -EOPNOTSUPP;
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index fdcfd5081..c26a03755 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -95,7 +95,7 @@ struct b53_pcs {
 
 struct b53_port {
 	u16		vlan_ctl_mask;
-	struct ethtool_eee eee;
+	struct ethtool_keee eee;
 };
 
 struct b53_vlan {
@@ -397,7 +397,7 @@ void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
 void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable);
 int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy);
-int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
-int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
+int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
+int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 
 #endif
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 4a52ccbe3..bc77ee9e6 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -835,7 +835,7 @@ static void bcm_sf2_sw_mac_link_up(struct dsa_switch *ds, int port,
 				   bool tx_pause, bool rx_pause)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
-	struct ethtool_eee *p = &priv->dev->ports[port].eee;
+	struct ethtool_keee *p = &priv->dev->ports[port].eee;
 	u32 reg_rgmii_ctrl = 0;
 	u32 reg, offset;
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 245dfb7a7..a7b5ddb86 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2852,7 +2852,7 @@ static int ksz_validate_eee(struct dsa_switch *ds, int port)
 }
 
 static int ksz_get_mac_eee(struct dsa_switch *ds, int port,
-			   struct ethtool_eee *e)
+			   struct ethtool_keee *e)
 {
 	int ret;
 
@@ -2872,7 +2872,7 @@ static int ksz_get_mac_eee(struct dsa_switch *ds, int port,
 }
 
 static int ksz_set_mac_eee(struct dsa_switch *ds, int port,
-			   struct ethtool_eee *e)
+			   struct ethtool_keee *e)
 {
 	struct ksz_device *dev = ds->priv;
 	int ret;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdf..1d577f268 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3046,7 +3046,7 @@ mt753x_setup(struct dsa_switch *ds)
 }
 
 static int mt753x_get_mac_eee(struct dsa_switch *ds, int port,
-			      struct ethtool_eee *e)
+			      struct ethtool_keee *e)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u32 eeecr = mt7530_read(priv, MT7530_PMEEECR_P(port));
@@ -3058,7 +3058,7 @@ static int mt753x_get_mac_eee(struct dsa_switch *ds, int port,
 }
 
 static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
-			      struct ethtool_eee *e)
+			      struct ethtool_keee *e)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u32 set, mask = LPI_THRESH_MASK | LPI_MODE_EN;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 383b3c4d6..8b0079b8e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1451,14 +1451,14 @@ static void mv88e6xxx_get_regs(struct dsa_switch *ds, int port,
 }
 
 static int mv88e6xxx_get_mac_eee(struct dsa_switch *ds, int port,
-				 struct ethtool_eee *e)
+				 struct ethtool_keee *e)
 {
 	/* Nothing to do on the port's MAC */
 	return 0;
 }
 
 static int mv88e6xxx_set_mac_eee(struct dsa_switch *ds, int port,
-				 struct ethtool_eee *e)
+				 struct ethtool_keee *e)
 {
 	/* Nothing to do on the port's MAC */
 	return 0;
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 2358cd399..7f80035c5 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -534,7 +534,7 @@ int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 }
 
 int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
-		      struct ethtool_eee *eee)
+		      struct ethtool_keee *eee)
 {
 	u32 lpi_en = QCA8K_REG_EEE_CTRL_LPI_EN(port);
 	struct qca8k_priv *priv = ds->priv;
@@ -558,7 +558,7 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 }
 
 int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
-		      struct ethtool_eee *e)
+		      struct ethtool_keee *e)
 {
 	/* Nothing to do on the port's MAC */
 	return 0;
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index c8785c36c..2184d8d2d 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -518,8 +518,8 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset);
 
 /* Common eee function */
-int qca8k_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *eee);
-int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
+int qca8k_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *eee);
+int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 
 /* Common bridge function */
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 18a6c8d99..be865776d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -697,7 +697,7 @@ static u32 eee_mask_to_ethtool_mask(u32 speed)
 	return rate;
 }
 
-static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_eee *eee)
+static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
 	u32 rate, supported_rates;
@@ -729,7 +729,7 @@ static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_eee *eee)
 	return 0;
 }
 
-static int aq_ethtool_set_eee(struct net_device *ndev, struct ethtool_eee *eee)
+static int aq_ethtool_set_eee(struct net_device *ndev, struct ethtool_keee *eee)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
 	u32 rate, supported_rates;
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index ec90add6b..312bf9b65 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -337,7 +337,7 @@ struct bcmasp_intf {
 	int				wol_irq;
 	unsigned int			wol_irq_enabled:1;
 
-	struct ethtool_eee		eee;
+	struct ethtool_keee		eee;
 };
 
 #define NUM_NET_FILTERS				32
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index ce6a3d56f..2851bed15 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -363,10 +363,10 @@ void bcmasp_eee_enable_set(struct bcmasp_intf *intf, bool enable)
 	intf->eee.eee_active = enable;
 }
 
-static int bcmasp_get_eee(struct net_device *dev, struct ethtool_eee *e)
+static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
-	struct ethtool_eee *p = &intf->eee;
+	struct ethtool_keee *p = &intf->eee;
 
 	if (!dev->phydev)
 		return -ENODEV;
@@ -379,10 +379,10 @@ static int bcmasp_get_eee(struct net_device *dev, struct ethtool_eee *e)
 	return phy_ethtool_get_eee(dev->phydev, e);
 }
 
-static int bcmasp_set_eee(struct net_device *dev, struct ethtool_eee *e)
+static int bcmasp_set_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
-	struct ethtool_eee *p = &intf->eee;
+	struct ethtool_keee *p = &intf->eee;
 	int ret;
 
 	if (!dev->phydev)
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 81d232e6d..c9afb9203 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2108,7 +2108,7 @@ static u32 bnx2x_adv_to_eee(u32 modes, u32 shift)
 	return eee_adv << shift;
 }
 
-static int bnx2x_get_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int bnx2x_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct bnx2x *bp = netdev_priv(dev);
 	u32 eee_cfg;
@@ -2141,7 +2141,7 @@ static int bnx2x_get_eee(struct net_device *dev, struct ethtool_eee *edata)
 	return 0;
 }
 
-static int bnx2x_set_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int bnx2x_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct bnx2x *bp = netdev_priv(dev);
 	u32 eee_cfg;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 39845d556..d7626c26f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10621,7 +10621,7 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
 
 	bp->phy_flags = resp->flags | (le16_to_cpu(resp->flags2) << 8);
 	if (resp->flags & PORT_PHY_QCAPS_RESP_FLAGS_EEE_SUPPORTED) {
-		struct ethtool_eee *eee = &bp->eee;
+		struct ethtool_keee *eee = &bp->eee;
 		u16 fw_speeds = le16_to_cpu(resp->supported_speeds_eee_mode);
 
 		eee->supported = _bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
@@ -10766,7 +10766,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 	link_info->module_status = resp->module_status;
 
 	if (bp->phy_flags & BNXT_PHY_FL_EEE_CAP) {
-		struct ethtool_eee *eee = &bp->eee;
+		struct ethtool_keee *eee = &bp->eee;
 		u16 fw_speeds;
 
 		eee->eee_active = 0;
@@ -10957,7 +10957,7 @@ int bnxt_hwrm_set_pause(struct bnxt *bp)
 static void bnxt_hwrm_set_eee(struct bnxt *bp,
 			      struct hwrm_port_phy_cfg_input *req)
 {
-	struct ethtool_eee *eee = &bp->eee;
+	struct ethtool_keee *eee = &bp->eee;
 
 	if (eee->eee_enabled) {
 		u16 eee_speeds;
@@ -11322,7 +11322,7 @@ static void bnxt_get_wol_settings(struct bnxt *bp)
 
 static bool bnxt_eee_config_ok(struct bnxt *bp)
 {
-	struct ethtool_eee *eee = &bp->eee;
+	struct ethtool_keee *eee = &bp->eee;
 	struct bnxt_link_info *link_info = &bp->link_info;
 
 	if (!(bp->phy_flags & BNXT_PHY_FL_EEE_CAP))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 47338b48c..b2cb3e775 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2442,7 +2442,7 @@ struct bnxt {
 	 */
 	struct mutex		link_lock;
 	struct bnxt_link_info	link_info;
-	struct ethtool_eee	eee;
+	struct ethtool_keee	eee;
 	u32			lpi_tmr_lo;
 	u32			lpi_tmr_hi;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index dc4ca706b..d6a8577d6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3884,10 +3884,10 @@ static int bnxt_set_eeprom(struct net_device *dev,
 				eeprom->len);
 }
 
-static int bnxt_set_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int bnxt_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	struct ethtool_eee *eee = &bp->eee;
+	struct ethtool_keee *eee = &bp->eee;
 	struct bnxt_link_info *link_info = &bp->link_info;
 	u32 advertising;
 	int rc = 0;
@@ -3942,7 +3942,7 @@ static int bnxt_set_eee(struct net_device *dev, struct ethtool_eee *edata)
 	return rc;
 }
 
-static int bnxt_get_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 2d7ae7128..051c31fb1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1317,10 +1317,10 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
 	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
-static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
+static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	struct ethtool_eee *p = &priv->eee;
+	struct ethtool_keee *p = &priv->eee;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1336,10 +1336,10 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
 	return phy_ethtool_get_eee(dev->phydev, e);
 }
 
-static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
+static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	struct ethtool_eee *p = &priv->eee;
+	struct ethtool_keee *p = &priv->eee;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 1985c0ec4..7523b60b3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -645,7 +645,7 @@ struct bcmgenet_priv {
 
 	struct bcmgenet_mib_counters mib;
 
-	struct ethtool_eee eee;
+	struct ethtool_keee eee;
 };
 
 #define GENET_IO_MACRO(name, offset)					\
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 04964bbe0..11054177c 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -2338,10 +2338,10 @@ static void tg3_phy_apply_otp(struct tg3 *tp)
 	tg3_phy_toggle_auxctl_smdsp(tp, false);
 }
 
-static void tg3_eee_pull_config(struct tg3 *tp, struct ethtool_eee *eee)
+static void tg3_eee_pull_config(struct tg3 *tp, struct ethtool_keee *eee)
 {
 	u32 val;
-	struct ethtool_eee *dest = &tp->eee;
+	struct ethtool_keee *dest = &tp->eee;
 
 	if (!(tp->phy_flags & TG3_PHYFLG_EEE_CAP))
 		return;
@@ -4618,7 +4618,7 @@ static int tg3_init_5401phy_dsp(struct tg3 *tp)
 
 static bool tg3_phy_eee_config_ok(struct tg3 *tp)
 {
-	struct ethtool_eee eee;
+	struct ethtool_keee eee;
 
 	if (!(tp->phy_flags & TG3_PHYFLG_EEE_CAP))
 		return true;
@@ -14180,7 +14180,7 @@ static int tg3_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static int tg3_set_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int tg3_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct tg3 *tp = netdev_priv(dev);
 
@@ -14217,7 +14217,7 @@ static int tg3_set_eee(struct net_device *dev, struct ethtool_eee *edata)
 	return 0;
 }
 
-static int tg3_get_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int tg3_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct tg3 *tp = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 5016475e5..cf1b2b123 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3419,7 +3419,7 @@ struct tg3 {
 	unsigned int			irq_cnt;
 
 	struct ethtool_coalesce		coal;
-	struct ethtool_eee		eee;
+	struct ethtool_keee		eee;
 
 	/* firmware info */
 	const char			*fw_needed;
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index df40c720e..351f39e02 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -238,7 +238,7 @@ static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
 static int tsnep_phy_open(struct tsnep_adapter *adapter)
 {
 	struct phy_device *phydev;
-	struct ethtool_eee ethtool_eee;
+	struct ethtool_keee ethtool_keee;
 	int retval;
 
 	retval = phy_connect_direct(adapter->netdev, adapter->phydev,
@@ -257,8 +257,8 @@ static int tsnep_phy_open(struct tsnep_adapter *adapter)
 	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
 
 	/* disable EEE autoneg, EEE not supported by TSNEP */
-	memset(&ethtool_eee, 0, sizeof(ethtool_eee));
-	phy_ethtool_set_eee(adapter->phydev, &ethtool_eee);
+	memset(&ethtool_keee, 0, sizeof(ethtool_keee));
+	phy_ethtool_set_eee(adapter->phydev, &ethtool_keee);
 
 	adapter->phydev->irq = PHY_MAC_INTERRUPT;
 	phy_start(adapter->phydev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index cffbf27c4..ceecda91d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2402,7 +2402,7 @@ static void enetc_clear_interrupts(struct enetc_ndev_priv *priv)
 static int enetc_phylink_connect(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct ethtool_eee edata;
+	struct ethtool_keee edata;
 	int err;
 
 	if (!priv->phylink) {
@@ -2418,7 +2418,7 @@ static int enetc_phylink_connect(struct net_device *ndev)
 	}
 
 	/* disable EEE autoneg, until ENETC driver supports it */
-	memset(&edata, 0, sizeof(struct ethtool_eee));
+	memset(&edata, 0, sizeof(struct ethtool_keee));
 	phylink_ethtool_set_eee(priv->phylink, &edata);
 
 	phylink_start(priv->phylink);
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a8fbcada6..a19cb2a78 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -672,7 +672,7 @@ struct fec_enet_private {
 	unsigned int itr_clk_rate;
 
 	/* tx lpi eee mode */
-	struct ethtool_eee eee;
+	struct ethtool_keee eee;
 	unsigned int clk_ref_rate;
 
 	/* ptp clock period in ns*/
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d42594f32..11185754e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3120,7 +3120,7 @@ static int fec_enet_us_to_tx_cycle(struct net_device *ndev, int us)
 static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_eee *p = &fep->eee;
+	struct ethtool_keee *p = &fep->eee;
 	unsigned int sleep_cycle, wake_cycle;
 	int ret = 0;
 
@@ -3147,10 +3147,10 @@ static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
 }
 
 static int
-fec_enet_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_eee *p = &fep->eee;
+	struct ethtool_keee *p = &fep->eee;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
 		return -EOPNOTSUPP;
@@ -3167,10 +3167,10 @@ fec_enet_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
 }
 
 static int
-fec_enet_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
+fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_eee *p = &fep->eee;
+	struct ethtool_keee *p = &fep->eee;
 	int ret = 0;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index e3dfbd7a4..a811238c0 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1649,7 +1649,7 @@ static int init_phy(struct net_device *dev)
 	struct gfar_private *priv = netdev_priv(dev);
 	phy_interface_t interface = priv->interface;
 	struct phy_device *phydev;
-	struct ethtool_eee edata;
+	struct ethtool_keee edata;
 
 	linkmode_set_bit_array(phy_10_100_features_array,
 			       ARRAY_SIZE(phy_10_100_features_array),
@@ -1681,7 +1681,7 @@ static int init_phy(struct net_device *dev)
 	phy_support_asym_pause(phydev);
 
 	/* disable EEE autoneg, EEE not supported by eTSEC */
-	memset(&edata, 0, sizeof(struct ethtool_eee));
+	memset(&edata, 0, sizeof(struct ethtool_keee));
 	phy_ethtool_set_eee(phydev, &edata);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index fc0f98ea6..343f54b2b 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2186,7 +2186,7 @@ static int e1000_get_rxnfc(struct net_device *netdev,
 	}
 }
 
-static int e1000e_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
+static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
@@ -2262,11 +2262,11 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
 	return ret_val;
 }
 
-static int e1000e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
+static int e1000e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	struct ethtool_eee eee_curr;
+	struct ethtool_keee eee_curr;
 	s32 ret_val;
 
 	ret_val = e1000e_get_eee(netdev, &eee_curr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c84177971..9dfda3c48 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5644,7 +5644,7 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
-static int i40e_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
+static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_aq_get_phy_abilities_resp phy_cfg;
@@ -5682,7 +5682,7 @@ static int i40e_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
 }
 
 static int i40e_is_eee_param_supported(struct net_device *netdev,
-				       struct ethtool_eee *edata)
+				       struct ethtool_keee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
@@ -5709,7 +5709,7 @@ static int i40e_is_eee_param_supported(struct net_device *netdev,
 	return 0;
 }
 
-static int i40e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
+static int i40e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_aq_get_phy_abilities_resp abilities;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index b66199c9b..778d1e6cf 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3027,7 +3027,7 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
-static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
+static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
@@ -3106,11 +3106,11 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
 }
 
 static int igb_set_eee(struct net_device *netdev,
-		       struct ethtool_eee *edata)
+		       struct ethtool_keee *edata)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	struct ethtool_eee eee_curr;
+	struct ethtool_keee eee_curr;
 	bool adv1g_eee = true, adv100m_eee = true;
 	s32 ret_val;
 
@@ -3118,7 +3118,7 @@ static int igb_set_eee(struct net_device *netdev,
 	    (hw->phy.media_type != e1000_media_type_copper))
 		return -EOPNOTSUPP;
 
-	memset(&eee_curr, 0, sizeof(struct ethtool_eee));
+	memset(&eee_curr, 0, sizeof(struct ethtool_keee));
 
 	ret_val = igb_get_eee(netdev, &eee_curr);
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 45430e246..75f7c5ba6 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -168,7 +168,7 @@ struct igc_ring {
 struct igc_adapter {
 	struct net_device *netdev;
 
-	struct ethtool_eee eee;
+	struct ethtool_keee eee;
 	u16 eee_advert;
 
 	unsigned long state;
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index b95d2c86e..f2dcfe920 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1623,7 +1623,7 @@ static int igc_ethtool_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 }
 
 static int igc_ethtool_get_eee(struct net_device *netdev,
-			       struct ethtool_eee *edata)
+			       struct ethtool_keee *edata)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct igc_hw *hw = &adapter->hw;
@@ -1664,14 +1664,14 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 }
 
 static int igc_ethtool_set_eee(struct net_device *netdev,
-			       struct ethtool_eee *edata)
+			       struct ethtool_keee *edata)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct igc_hw *hw = &adapter->hw;
-	struct ethtool_eee eee_curr;
+	struct ethtool_keee eee_curr;
 	s32 ret_val;
 
-	memset(&eee_curr, 0, sizeof(struct ethtool_eee));
+	memset(&eee_curr, 0, sizeof(struct ethtool_keee));
 
 	ret_val = igc_ethtool_get_eee(netdev, &eee_curr);
 	if (ret_val) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 9a6345771..0aa73519a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3425,7 +3425,7 @@ static const struct {
 };
 
 static int
-ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_eee *edata)
+ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 {
 	u32 info[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -3462,7 +3462,7 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_eee *edata)
 	return 0;
 }
 
-static int ixgbe_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
+static int ixgbe_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -3476,17 +3476,17 @@ static int ixgbe_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
 	return -EOPNOTSUPP;
 }
 
-static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
+static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	struct ethtool_eee eee_data;
+	struct ethtool_keee eee_data;
 	s32 ret_val;
 
 	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE))
 		return -EOPNOTSUPP;
 
-	memset(&eee_data, 0, sizeof(struct ethtool_eee));
+	memset(&eee_data, 0, sizeof(struct ethtool_keee));
 
 	ret_val = ixgbe_get_eee(netdev, &eee_data);
 	if (ret_val)
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index a641b3534..40a5f1431 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5097,7 +5097,7 @@ static int mvneta_ethtool_set_wol(struct net_device *dev,
 }
 
 static int mvneta_ethtool_get_eee(struct net_device *dev,
-				  struct ethtool_eee *eee)
+				  struct ethtool_keee *eee)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
 	u32 lpi_ctl0;
@@ -5113,7 +5113,7 @@ static int mvneta_ethtool_get_eee(struct net_device *dev,
 }
 
 static int mvneta_ethtool_set_eee(struct net_device *dev,
-				  struct ethtool_eee *eee)
+				  struct ethtool_keee *eee)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
 	u32 lpi_ctl0;
diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index a2b3f4433..8a6ae171e 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1055,7 +1055,7 @@ static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
 }
 
 static int lan743x_ethtool_get_eee(struct net_device *netdev,
-				   struct ethtool_eee *eee)
+				   struct ethtool_keee *eee)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
@@ -1092,7 +1092,7 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
 }
 
 static int lan743x_ethtool_set_eee(struct net_device *netdev,
-				   struct ethtool_eee *eee)
+				   struct ethtool_keee *eee)
 {
 	struct lan743x_adapter *adapter;
 	struct phy_device *phydev;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 0e240b5ab..77491fb64 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1776,7 +1776,7 @@ static int qede_get_tunable(struct net_device *dev,
 	return 0;
 }
 
-static int qede_get_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int qede_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qed_link_output current_link;
@@ -1810,7 +1810,7 @@ static int qede_get_eee(struct net_device *dev, struct ethtool_eee *edata)
 	return 0;
 }
 
-static int qede_set_eee(struct net_device *dev, struct ethtool_eee *edata)
+static int qede_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qed_link_output current_link;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index dd73df6b1..3d30d4499 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1974,7 +1974,7 @@ static int rtl_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static int rtl8169_get_eee(struct net_device *dev, struct ethtool_eee *data)
+static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 
@@ -1984,7 +1984,7 @@ static int rtl8169_get_eee(struct net_device *dev, struct ethtool_eee *data)
 	return phy_ethtool_get_eee(tp->phydev, data);
 }
 
-static int rtl8169_set_eee(struct net_device *dev, struct ethtool_eee *data)
+static int rtl8169_set_eee(struct net_device *dev, struct ethtool_keee *data)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 	int ret;
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
index 8ba017ec9..d93b628b7 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
@@ -133,7 +133,7 @@ static const struct sxgbe_stats sxgbe_gstrings_stats[] = {
 #define SXGBE_STATS_LEN ARRAY_SIZE(sxgbe_gstrings_stats)
 
 static int sxgbe_get_eee(struct net_device *dev,
-			 struct ethtool_eee *edata)
+			 struct ethtool_keee *edata)
 {
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
 
@@ -148,7 +148,7 @@ static int sxgbe_get_eee(struct net_device *dev,
 }
 
 static int sxgbe_set_eee(struct net_device *dev,
-			 struct ethtool_eee *edata)
+			 struct ethtool_keee *edata)
 {
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 42d27b97d..bbecb3b89 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -852,7 +852,7 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 }
 
 static int stmmac_ethtool_op_get_eee(struct net_device *dev,
-				     struct ethtool_eee *edata)
+				     struct ethtool_keee *edata)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
@@ -868,7 +868,7 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 }
 
 static int stmmac_ethtool_op_set_eee(struct net_device *dev,
-				     struct ethtool_eee *edata)
+				     struct ethtool_keee *edata)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int ret;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index 35fceba01..d6ce2c9f0 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -514,14 +514,14 @@ am65_cpsw_set_link_ksettings(struct net_device *ndev,
 	return phylink_ethtool_ksettings_set(salve->phylink, ecmd);
 }
 
-static int am65_cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+static int am65_cpsw_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct am65_cpsw_slave_data *salve = am65_ndev_to_slave(ndev);
 
 	return phylink_ethtool_get_eee(salve->phylink, edata);
 }
 
-static int am65_cpsw_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
+static int am65_cpsw_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct am65_cpsw_slave_data *salve = am65_ndev_to_slave(ndev);
 
diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index a557a477d..f7b283353 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -422,7 +422,7 @@ int cpsw_set_link_ksettings(struct net_device *ndev,
 	return phy_ethtool_ksettings_set(cpsw->slaves[slave_no].phy, ecmd);
 }
 
-int cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+int cpsw_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
@@ -434,7 +434,7 @@ int cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
 		return -EOPNOTSUPP;
 }
 
-int cpsw_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
+int cpsw_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 0e27c4330..7efa72502 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -496,8 +496,8 @@ int cpsw_get_link_ksettings(struct net_device *ndev,
 			    struct ethtool_link_ksettings *ecmd);
 int cpsw_set_link_ksettings(struct net_device *ndev,
 			    const struct ethtool_link_ksettings *ecmd);
-int cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata);
-int cpsw_set_eee(struct net_device *ndev, struct ethtool_eee *edata);
+int cpsw_get_eee(struct net_device *ndev, struct ethtool_keee *edata);
+int cpsw_set_eee(struct net_device *ndev, struct ethtool_keee *edata);
 int cpsw_nway_reset(struct net_device *ndev);
 void cpsw_get_ringparam(struct net_device *ndev,
 			struct ethtool_ringparam *ering,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index a27ec1dcc..9a7dd7efc 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -45,7 +45,7 @@ static int emac_set_link_ksettings(struct net_device *ndev,
 	return phy_ethtool_set_link_ksettings(ndev, ecmd);
 }
 
-static int emac_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+static int emac_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
@@ -53,7 +53,7 @@ static int emac_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
 	return phy_ethtool_get_eee(ndev->phydev, edata);
 }
 
-static int emac_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
+static int emac_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index eba652a4c..1faa22f58 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1461,7 +1461,7 @@ static int m88e1540_get_fld(struct phy_device *phydev, u8 *msecs)
 
 static int m88e1540_set_fld(struct phy_device *phydev, const u8 *msecs)
 {
-	struct ethtool_eee eee;
+	struct ethtool_keee eee;
 	int val, ret;
 
 	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 747d14bf1..adee5e712 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1443,13 +1443,13 @@ EXPORT_SYMBOL(genphy_c45_eee_is_active);
 /**
  * genphy_c45_ethtool_get_eee - get EEE supported and status
  * @phydev: target phy_device struct
- * @data: ethtool_eee data
+ * @data: ethtool_keee data
  *
  * Description: it reports the Supported/Advertisement/LP Advertisement
  * capabilities.
  */
 int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
-			       struct ethtool_eee *data)
+			       struct ethtool_keee *data)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp) = {};
@@ -1481,7 +1481,7 @@ EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
 /**
  * genphy_c45_ethtool_set_eee - set EEE supported and status
  * @phydev: target phy_device struct
- * @data: ethtool_eee data
+ * @data: ethtool_keee data
  *
  * Description: sets the Supported/Advertisement/LP Advertisement
  * capabilities. If eee_enabled is false, no links modes are
@@ -1490,7 +1490,7 @@ EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
  * non-destructive way.
  */
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
-			       struct ethtool_eee *data)
+			       struct ethtool_keee *data)
 {
 	int ret;
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 3376e58e2..3b9531143 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1632,12 +1632,12 @@ EXPORT_SYMBOL(phy_get_eee_err);
 /**
  * phy_ethtool_get_eee - get EEE supported and status
  * @phydev: target phy_device struct
- * @data: ethtool_eee data
+ * @data: ethtool_keee data
  *
  * Description: it reportes the Supported/Advertisement/LP Advertisement
  * capabilities.
  */
-int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_eee *data)
+int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
 	int ret;
 
@@ -1655,11 +1655,11 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
 /**
  * phy_ethtool_set_eee - set EEE supported and status
  * @phydev: target phy_device struct
- * @data: ethtool_eee data
+ * @data: ethtool_keee data
  *
  * Description: it is to program the Advertisement EEE register.
  */
-int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_eee *data)
+int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
 	int ret;
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ed0b4ccaa..503fd7c40 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2764,9 +2764,9 @@ EXPORT_SYMBOL_GPL(phylink_init_eee);
 /**
  * phylink_ethtool_get_eee() - read the energy efficient ethernet parameters
  * @pl: a pointer to a &struct phylink returned from phylink_create()
- * @eee: a pointer to a &struct ethtool_eee for the read parameters
+ * @eee: a pointer to a &struct ethtool_keee for the read parameters
  */
-int phylink_ethtool_get_eee(struct phylink *pl, struct ethtool_eee *eee)
+int phylink_ethtool_get_eee(struct phylink *pl, struct ethtool_keee *eee)
 {
 	int ret = -EOPNOTSUPP;
 
@@ -2782,9 +2782,9 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_get_eee);
 /**
  * phylink_ethtool_set_eee() - set the energy efficient ethernet parameters
  * @pl: a pointer to a &struct phylink returned from phylink_create()
- * @eee: a pointer to a &struct ethtool_eee for the desired parameters
+ * @eee: a pointer to a &struct ethtool_keee for the desired parameters
  */
-int phylink_ethtool_set_eee(struct phylink *pl, struct ethtool_eee *eee)
+int phylink_ethtool_set_eee(struct phylink *pl, struct ethtool_keee *eee)
 {
 	int ret = -EOPNOTSUPP;
 
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index d837c1887..3922a9afd 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -667,7 +667,7 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 }
 
 static int
-ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_eee *data)
+ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
 	int val;
 
@@ -696,7 +696,7 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_eee *data)
 }
 
 static int
-ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_eee *data)
+ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
 	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised);
 
@@ -807,7 +807,7 @@ static void ax88179_enable_eee(struct usbnet *dev)
 			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
 }
 
-static int ax88179_get_eee(struct net_device *net, struct ethtool_eee *edata)
+static int ax88179_get_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
 	struct ax88179_data *priv = dev->driver_priv;
@@ -818,7 +818,7 @@ static int ax88179_get_eee(struct net_device *net, struct ethtool_eee *edata)
 	return ax88179_ethtool_get_eee(dev, edata);
 }
 
-static int ax88179_set_eee(struct net_device *net, struct ethtool_eee *edata)
+static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
 	struct ax88179_data *priv = dev->driver_priv;
@@ -1587,7 +1587,7 @@ static int ax88179_reset(struct usbnet *dev)
 	u16 *tmp16;
 	u8 *tmp;
 	struct ax88179_data *ax179_data = dev->driver_priv;
-	struct ethtool_eee eee_data;
+	struct ethtool_keee eee_data;
 
 	tmp16 = (u16 *)buf;
 	tmp = (u8 *)buf;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a6d653ff5..106282612 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1673,7 +1673,7 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	return ret;
 }
 
-static int lan78xx_get_eee(struct net_device *net, struct ethtool_eee *edata)
+static int lan78xx_get_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
 	struct phy_device *phydev = net->phydev;
@@ -1709,7 +1709,7 @@ static int lan78xx_get_eee(struct net_device *net, struct ethtool_eee *edata)
 	return ret;
 }
 
-static int lan78xx_set_eee(struct net_device *net, struct ethtool_eee *edata)
+static int lan78xx_set_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
 	int ret;
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0d0672d2a..dc163b766 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -891,8 +891,8 @@ struct r8152 {
 		void (*up)(struct r8152 *tp);
 		void (*down)(struct r8152 *tp);
 		void (*unload)(struct r8152 *tp);
-		int (*eee_get)(struct r8152 *tp, struct ethtool_eee *eee);
-		int (*eee_set)(struct r8152 *tp, struct ethtool_eee *eee);
+		int (*eee_get)(struct r8152 *tp, struct ethtool_keee *eee);
+		int (*eee_set)(struct r8152 *tp, struct ethtool_keee *eee);
 		bool (*in_nway)(struct r8152 *tp);
 		void (*hw_phy_cfg)(struct r8152 *tp);
 		void (*autosuspend_en)(struct r8152 *tp, bool enable);
@@ -8922,7 +8922,7 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	}
 }
 
-static int r8152_get_eee(struct r8152 *tp, struct ethtool_eee *eee)
+static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
 	u32 lp, adv, supported = 0;
 	u16 val;
@@ -8945,7 +8945,7 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_eee *eee)
 	return 0;
 }
 
-static int r8152_set_eee(struct r8152 *tp, struct ethtool_eee *eee)
+static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
 	u16 val = ethtool_adv_to_mmd_eee_adv_t(eee->advertised);
 
@@ -8957,7 +8957,7 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_eee *eee)
 	return 0;
 }
 
-static int r8153_get_eee(struct r8152 *tp, struct ethtool_eee *eee)
+static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
 	u32 lp, adv, supported = 0;
 	u16 val;
@@ -8981,7 +8981,7 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_eee *eee)
 }
 
 static int
-rtl_ethtool_get_eee(struct net_device *net, struct ethtool_eee *edata)
+rtl_ethtool_get_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct r8152 *tp = netdev_priv(net);
 	int ret;
@@ -9008,7 +9008,7 @@ rtl_ethtool_get_eee(struct net_device *net, struct ethtool_eee *edata)
 }
 
 static int
-rtl_ethtool_set_eee(struct net_device *net, struct ethtool_eee *edata)
+rtl_ethtool_set_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct r8152 *tp = netdev_priv(net);
 	int ret;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 325e0778e..a850bab84 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -222,6 +222,18 @@ extern int
 __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
+struct ethtool_keee {
+	u32	cmd;
+	u32	supported;
+	u32	advertised;
+	u32	lp_advertised;
+	u32	eee_active;
+	u32	eee_enabled;
+	u32	tx_lpi_enabled;
+	u32	tx_lpi_timer;
+	u32	reserved[2];
+};
+
 struct kernel_ethtool_coalesce {
 	u8 use_cqe_mode_tx;
 	u8 use_cqe_mode_rx;
@@ -892,8 +904,8 @@ struct ethtool_ops {
 				   struct ethtool_modinfo *);
 	int     (*get_module_eeprom)(struct net_device *,
 				     struct ethtool_eeprom *, u8 *);
-	int	(*get_eee)(struct net_device *, struct ethtool_eee *);
-	int	(*set_eee)(struct net_device *, struct ethtool_eee *);
+	int	(*get_eee)(struct net_device *dev, struct ethtool_keee *eee);
+	int	(*set_eee)(struct net_device *dev, struct ethtool_keee *eee);
 	int	(*get_tunable)(struct net_device *,
 			       const struct ethtool_tunable *, void *);
 	int	(*set_tunable)(struct net_device *,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 684efaeca..75c73bf79 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1886,9 +1886,9 @@ int genphy_c45_plca_get_status(struct phy_device *phydev,
 int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
 			     unsigned long *lp, bool *is_enabled);
 int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
-			       struct ethtool_eee *data);
+			       struct ethtool_keee *data);
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
-			       struct ethtool_eee *data);
+			       struct ethtool_keee *data);
 int genphy_c45_write_eee_adv(struct phy_device *phydev, unsigned long *adv);
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
@@ -1966,8 +1966,8 @@ int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
-int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_eee *data);
-int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_eee *data);
+int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
+int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data);
 int phy_ethtool_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol);
 void phy_ethtool_get_wol(struct phy_device *phydev,
 			 struct ethtool_wolinfo *wol);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index d589f89c6..6ba411732 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -584,8 +584,8 @@ int phylink_ethtool_set_pauseparam(struct phylink *,
 				   struct ethtool_pauseparam *);
 int phylink_get_eee_err(struct phylink *);
 int phylink_init_eee(struct phylink *, bool);
-int phylink_ethtool_get_eee(struct phylink *, struct ethtool_eee *);
-int phylink_ethtool_set_eee(struct phylink *, struct ethtool_eee *);
+int phylink_ethtool_get_eee(struct phylink *link, struct ethtool_keee *eee);
+int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
 int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
 int phylink_speed_down(struct phylink *pl, bool sync);
 int phylink_speed_up(struct phylink *pl);
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 82135fbdb..7c0da9eff 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -991,9 +991,9 @@ struct dsa_switch_ops {
 	 * Port's MAC EEE settings
 	 */
 	int	(*set_mac_eee)(struct dsa_switch *ds, int port,
-			       struct ethtool_eee *e);
+			       struct ethtool_keee *e);
 	int	(*get_mac_eee)(struct dsa_switch *ds, int port,
-			       struct ethtool_eee *e);
+			       struct ethtool_keee *e);
 
 	/* EEPROM access */
 	int	(*get_eeprom_len)(struct dsa_switch *ds);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index b15e71cc3..e03da3a4a 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1222,7 +1222,7 @@ static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
 	return ret;
 }
 
-static int dsa_user_set_eee(struct net_device *dev, struct ethtool_eee *e)
+static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
@@ -1242,7 +1242,7 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_eee *e)
 	return phylink_ethtool_set_eee(dp->pl, e);
 }
 
-static int dsa_user_get_eee(struct net_device *dev, struct ethtool_eee *e)
+static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index 2853394d0..21b0e845a 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -5,7 +5,7 @@
 #include "bitset.h"
 
 #define EEE_MODES_COUNT \
-	(sizeof_field(struct ethtool_eee, supported) * BITS_PER_BYTE)
+	(sizeof_field(struct ethtool_keee, supported) * BITS_PER_BYTE)
 
 struct eee_req_info {
 	struct ethnl_req_info		base;
@@ -13,7 +13,7 @@ struct eee_req_info {
 
 struct eee_reply_data {
 	struct ethnl_reply_data		base;
-	struct ethtool_eee		eee;
+	struct ethtool_keee		eee;
 };
 
 #define EEE_REPDATA(__reply_base) \
@@ -48,7 +48,7 @@ static int eee_reply_size(const struct ethnl_req_info *req_base,
 {
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
 	const struct eee_reply_data *data = EEE_REPDATA(reply_base);
-	const struct ethtool_eee *eee = &data->eee;
+	const struct ethtool_keee *eee = &data->eee;
 	int len = 0;
 	int ret;
 
@@ -84,7 +84,7 @@ static int eee_fill_reply(struct sk_buff *skb,
 {
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
 	const struct eee_reply_data *data = EEE_REPDATA(reply_base);
-	const struct ethtool_eee *eee = &data->eee;
+	const struct ethtool_keee *eee = &data->eee;
 	int ret;
 
 	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_OURS,
@@ -132,7 +132,7 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
-	struct ethtool_eee eee = {};
+	struct ethtool_keee eee = {};
 	bool mod = false;
 	int ret;
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7519b0818..b02ca72f4 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1510,13 +1510,13 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 
 static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_eee edata;
+	struct ethtool_keee edata;
 	int rc;
 
 	if (!dev->ethtool_ops->get_eee)
 		return -EOPNOTSUPP;
 
-	memset(&edata, 0, sizeof(struct ethtool_eee));
+	memset(&edata, 0, sizeof(struct ethtool_keee));
 	edata.cmd = ETHTOOL_GEEE;
 	rc = dev->ethtool_ops->get_eee(dev, &edata);
 
@@ -1531,7 +1531,7 @@ static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
 
 static int ethtool_set_eee(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_eee edata;
+	struct ethtool_keee edata;
 	int ret;
 
 	if (!dev->ethtool_ops->set_eee)
-- 
2.43.0




