Return-Path: <netdev+bounces-143213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25929C169C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610E7B214E9
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 06:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDCC1CF5F4;
	Fri,  8 Nov 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azorvctT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5281CCB49
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048891; cv=none; b=srFYnt1B4iFDvZadFtH+6cFFSV5reyvZ670N0vVMmuCwC6xXSoafSRh9eym1zCzjpc6sx9anSFoCZGqZTeExflc/qoRzUu/9FUX7Sqjnc+GqjuYoQWcprTBzKh2+VmP9n6ZeFR4mZugzAON5vYzPWvfHnvSIC/VI13x/XIuohW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048891; c=relaxed/simple;
	bh=ubWw3KJHMZS4O9NF+r7wTnteTdL07uKzfwLkl7JvNI8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V5Rp5HH9lH1CDuj9+rbHPIRm9hUaEOZ8D7fc1tp0PhueBTjUoWpBI6ALxRSK8MssH3Xk++AdiCimcwMx6skdpJ8TXKwsTDRDE7boiaJY5VzaDkrMfpzLUwSxj20KqIRdimqg6EMVjV7pUL6HZ1vEUH2LZHjtfN5F7k63zj+hzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azorvctT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431688d5127so14169815e9.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 22:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731048888; x=1731653688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYwUQGiTrsTyQxaVS3yoG5d/7doY/hFAozvItfjBuHw=;
        b=azorvctT9EPkRf5428pQGDqJTEuInFYEaKjTFwrgHls/oEJ76MSjCHb8U0ROzidcCH
         XD58mSlcLrp1knI6TTLyJr4BbXVvavIempramtgHEoC9Io0raZ3MTT/6W4LRBWVMq/tK
         wklh48XG0BLf2VaYEd7G4zDSt55ca7V4EBK07ZROOaweIZz5+4TsN58Ugpa0cQgmbL13
         NCcbjEcFaFNLWEufOd4VjRjtma+fBLt++s9A7MumRT78BBu1jgBOpZa0RDM43YKS11K5
         S9hRqGTV4LpHkLOGEqYCPVdmcqy7WDrIQGevuH4HCge+hPfbC6vrjWOpvebOkTs489AP
         tzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731048888; x=1731653688;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYwUQGiTrsTyQxaVS3yoG5d/7doY/hFAozvItfjBuHw=;
        b=qscgIHIL0sKEauk+HW1Y/U66kxZLJX+Ua4QgYhGMgg4Q6wl54Cav5c/3fAYg+0bg3L
         ONjq2ABuRNySlRwNZInDQyuuBsRHbHokui6wW4UbleU9zDGdTcQW4lgtsCncoPI98ogq
         KPeo5nDZeP1rswkD7ReKKY8PivHQ7AzgbrmKTAnYXtWvmEaHIJT3k6kpQF5vhY+kUfXl
         j7yCqNcvf9gtXuNgX/H9hfpY3+zpa9XO6g7tvMC9EmRtNTv68taIgWO6gR5YRE+EmrRn
         LK43FxvTGdtuBTof64LU3J9uRrEN4TTHX2jXPDUYKZSd/UIUaW0yTlXMXc3liQiPZPAb
         ABtw==
X-Gm-Message-State: AOJu0YyIq/RivdMHhVm/yCYnlApNcyzLUrWsztA1+UGrk53ID3Isafbu
	M1xODRED+VNQUylzRTRntMxJQBK8914kGfg8U+P8Ym+i51o6wKHp
X-Google-Smtp-Source: AGHT+IHJSwWJv4M9KICJZOSaHsLXY69vatxreQM5TioicVgnDU8pf/yXUkqmi+v7q/ckEIHc92FL4Q==
X-Received: by 2002:a05:600c:46cc:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-432b751dc61mr10680785e9.27.1731048888075;
        Thu, 07 Nov 2024 22:54:48 -0800 (PST)
Received: from ?IPV6:2a02:3100:a8c7:1100:21c3:489d:8064:fe8b? (dynamic-2a02-3100-a8c7-1100-21c3-489d-8064-fe8b.310.pool.telefonica.de. [2a02:3100:a8c7:1100:21c3:489d:8064:fe8b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b054a5ccsm52625245e9.11.2024.11.07.22.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 22:54:46 -0800 (PST)
Message-ID: <dfe0c9ff-84b0-4328-86d7-e917ebc084a1@gmail.com>
Date: Fri, 8 Nov 2024 07:54:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] net: phy: convert eee_broken_modes to a linkmode
 bitmap
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

eee_broken_modes has a eee_cap1 register layout currently. This doen't
allow to flag e.g. 2.5Gbps or 5Gbps BaseT EEE as broken. To overcome
this limitation switch eee_broken_modes to a linkmode bitmap.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/micrel.c   |  2 +-
 drivers/net/phy/phy-c45.c  | 12 +++++-------
 drivers/net/phy/phy-core.c | 21 +++++++++------------
 include/linux/phy.h        |  9 ++++-----
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 43c82a87b..3ef508840 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2004,7 +2004,7 @@ static int ksz9477_config_init(struct phy_device *phydev)
 	 * in this switch shall be regarded as broken.
 	 */
 	if (phydev->dev_flags & MICREL_NO_EEE)
-		phydev->eee_broken_modes = -1;
+		linkmode_fill(phydev->eee_broken_modes);
 
 	return kszphy_config_init(phydev);
 }
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index dabd90a3c..29cc22a4b 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -683,15 +683,13 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 				    unsigned long *adv)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	int val, changed = 0;
 
-	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
-		val = linkmode_to_mii_eee_cap1_t(adv);
+	linkmode_andnot(tmp, adv, phydev->eee_broken_modes);
 
-		/* In eee_broken_modes are stored MDIO_AN_EEE_ADV specific raw
-		 * register values.
-		 */
-		val &= ~phydev->eee_broken_modes;
+	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
+		val = linkmode_to_mii_eee_cap1_t(tmp);
 
 		/* IEEE 802.3-2018 45.2.7.13 EEE advertisement 1
 		 * (Register 7.60)
@@ -709,7 +707,7 @@ static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 	}
 
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
-		val = linkmode_to_mii_eee_cap2_t(adv);
+		val = linkmode_to_mii_eee_cap2_t(tmp);
 
 		/* IEEE 802.3-2022 45.2.7.16 EEE advertisement 2
 		 * (Register 7.62)
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 4e8db12d6..6bf3ec985 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -388,28 +388,25 @@ void of_set_phy_supported(struct phy_device *phydev)
 void of_set_phy_eee_broken(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-	u32 broken = 0;
+	unsigned long *modes = phydev->eee_broken_modes;
 
-	if (!IS_ENABLED(CONFIG_OF_MDIO))
+	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
 		return;
 
-	if (!node)
-		return;
+	linkmode_zero(modes);
 
 	if (of_property_read_bool(node, "eee-broken-100tx"))
-		broken |= MDIO_EEE_100TX;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-1000t"))
-		broken |= MDIO_EEE_1000T;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-10gt"))
-		broken |= MDIO_EEE_10GT;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-1000kx"))
-		broken |= MDIO_EEE_1000KX;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-10gkx4"))
-		broken |= MDIO_EEE_10GKX4;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-10gkr"))
-		broken |= MDIO_EEE_10GKR;
-
-	phydev->eee_broken_modes = broken;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, modes);
 }
 
 /**
diff --git a/include/linux/phy.h b/include/linux/phy.h
index d1a4f3f86..e3b578afb 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -721,16 +721,15 @@ struct phy_device {
 	/* used for eee validation and configuration*/
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
+	/* Energy efficient ethernet modes which should be prohibited */
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
 	bool eee_enabled;
+	bool enable_tx_lpi;
+	struct eee_config eee_cfg;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
 	DECLARE_PHY_INTERFACE_MASK(host_interfaces);
 
-	/* Energy efficient ethernet modes which should be prohibited */
-	u32 eee_broken_modes;
-	bool enable_tx_lpi;
-	struct eee_config eee_cfg;
-
 #ifdef CONFIG_LED_TRIGGER_PHY
 	struct phy_led_trigger *phy_led_triggers;
 	unsigned int phy_num_led_triggers;
-- 
2.47.0



