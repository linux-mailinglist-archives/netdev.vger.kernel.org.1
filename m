Return-Path: <netdev+bounces-157529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB9A0A988
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237283A0428
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED71B4247;
	Sun, 12 Jan 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhLLlK2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297291B218B
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688351; cv=none; b=VbURla+r79UcWoSFc/McwLVMHjXa5Rvc97XZqvp+MA5t7aKLaj5oZTgOdg4Sa86eZEUCU28jFucJcqTmLxDCa1fVUTrhDSG0rO46O/GRE6OLnAuEuy4oEOYb5PJ79MU+7aX0+sBYxhrpVccsYi0Iej6wKZH34f/5b2FLb1U13Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688351; c=relaxed/simple;
	bh=Cf7M+ZMP4gSExHOq6C5BklT7emUjrLT48BvByhJ+frY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AeaVcnWipGUroUOzNHAnmLnj09Pe73I2dVGQe78w2XHWjcK70iOUq/an8hBwX1RlBe95ZL9zR6qUXImpaRklXQJhRiZ8gAAsZvzztSevQyl4uyyYqsNV6lKlaweHQdlNNDbznS7QEmZvpn9/tpbuTouddI/v5Y2iBseIhOEfcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhLLlK2x; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e27c75f4so2464053f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688348; x=1737293148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+CM5019PVqbCfLD5uBLhFM7h6xi0D3irHgnC4Bb8RcA=;
        b=PhLLlK2xea1SMoMSo77Z4buhBdqNfLFniAAK/kQaxrXxOkNvVkq6gA+gSVZ/Xwyiu3
         rzpja6bPTGSiFuZOkHiKUdiE7F9t7ovxtU0AgPnbHfR+fotihsVrvxMewgLaYpYJ6iVV
         90wQyfWPXtpHO14FvmXQAZoIop1iHU6hvP/IMkGFU6Ciun2Yj97/qoFVCxM68F839xDU
         aCJ3zGzzpajrWkRmOFeUdfmUsuSCLKTnIgtA2hjX1DBjm2qvDjWblP1nPpJHwW+eZKw8
         X7lSYHEP6F6jFyTDAMTTHOWgy3BJie5cFlonPSqpGgaK7vFmhCbFnyOOwLi4fc3q4qb/
         trWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688348; x=1737293148;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CM5019PVqbCfLD5uBLhFM7h6xi0D3irHgnC4Bb8RcA=;
        b=UBOS24cOy0PfFooveOSj05GIYY3KWXJr4YeaSNvKuO1p4kOR3LJDHXJyZjseSfrUJP
         eH8QOyKHK6Kj49zE28b9mda5y25gw6n/+iXYOx/+BwfeXymGoXMe9pC4SLmZUY+UY+l+
         SCIyJLXMzPqr5LmdN3jFprHtStJIAzErJv+n6+4HJM+ABk0H7O5R3Y75wWibghLcHmJ2
         eITMj0Cvp/8W4hSbiDvRegkLaYBATt58CwFxe3BzIbTZ/lzV45IS7XIGpZyT26O/Alwp
         JxQwXuKbtbEy717gGoQMWy7VcRHX6kk+LC6Ay6Emr/hq7mJ61wLVRzHTfU3zIrKbSGJY
         jSTA==
X-Gm-Message-State: AOJu0Yyji+CFsHejEuU7XCW76rnn48YmXO+KhMgJM247wmw0p0kyV0Ia
	toGgtwl4zVNOH2fG7jVC0I9VZpBRywSYmvt4Us4IZpHKeyafPB5D
X-Gm-Gg: ASbGncsrmmYrVgEKvnK85Grogz1rvG21nrInZrRJHRpu+zSzE2gNHDhbXqqtLf8ISS9
	GPNYZGqoNiD+odMFG0hcOGbZxFSc55Io76DhY1iQiSf+GwltcKJCTYgYl+IrL+XLo5sqna5S9m7
	Rbnu4f05CJjP2FaD3WhKzO9hkCrUPudt3l8OmXW54Xf//UsVYAFvN+CDpwOmsGYGRBKy6YohNPM
	2KbdpdseErUWyzRmaEFLX8QkFheVv0UgrZV3yttf1inFIX1p6SKtWIuYwlbbQEpRQv6RWSZgv+4
	YtNEWIfC+KnW4p8mTGLpw+uAy7hurv1tCEP29u6jVEqIcw5LfgHIhSLB7DD6IPb6IfY9KaCfrka
	dxN40JrDTL4lg3jbrOfPVbdStWHy7j9GDAl2sUL+aUt35ADg3
X-Google-Smtp-Source: AGHT+IGXWBwx7tgm73lJFhiEvmKg8e3u87n7wxA6bySxP28kZDoOh8HrS5GO0A1ANIRimrI1/vrPsA==
X-Received: by 2002:a5d:6d84:0:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-38a873140f6mr15812997f8f.33.1736688348373;
        Sun, 12 Jan 2025 05:25:48 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fb99sm112613555e9.3.2025.01.12.05.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:25:47 -0800 (PST)
Message-ID: <b326a230-6369-49d7-b043-7b34d6594c1a@gmail.com>
Date: Sun, 12 Jan 2025 14:25:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 01/10] net: phy: rename eee_broken_modes to
 eee_disabled_modes
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This bitmap is used also if the MAC doesn't support an EEE mode.
So the mode isn't necessarily broken in the PHY. Therefore rename
the bitmap.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c    | 2 +-
 drivers/net/phy/phy-core.c   | 2 +-
 drivers/net/phy/phy_device.c | 2 +-
 include/linux/phy.h          | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 0dac08e85..468d24611 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -686,7 +686,7 @@ static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	int val, changed = 0;
 
-	linkmode_andnot(tmp, adv, phydev->eee_broken_modes);
+	linkmode_andnot(tmp, adv, phydev->eee_disabled_modes);
 
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
 		val = linkmode_to_mii_eee_cap1_t(tmp);
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 6bf3ec985..beeb0ef2f 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -388,7 +388,7 @@ void of_set_phy_supported(struct phy_device *phydev)
 void of_set_phy_eee_broken(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-	unsigned long *modes = phydev->eee_broken_modes;
+	unsigned long *modes = phydev->eee_disabled_modes;
 
 	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
 		return;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bdc997f59..f6a5f986f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3016,7 +3016,7 @@ void phy_disable_eee(struct phy_device *phydev)
 	phydev->eee_cfg.tx_lpi_enabled = false;
 	phydev->eee_cfg.eee_enabled = false;
 	/* don't let userspace re-enable EEE advertisement */
-	linkmode_fill(phydev->eee_broken_modes);
+	linkmode_fill(phydev->eee_disabled_modes);
 }
 EXPORT_SYMBOL_GPL(phy_disable_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5bc71d599..c5dc2dbf0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -629,7 +629,7 @@ struct macsec_ops;
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
- * @eee_broken_modes: Energy efficient ethernet modes which should be prohibited
+ * @eee_disabled_modes: Energy efficient ethernet modes not to be advertised
  * @autoneg: Flag autoneg being used
  * @rate_matching: Current rate matching mode
  * @link: Current link state
@@ -745,7 +745,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
 	/* Energy efficient ethernet modes which should be prohibited */
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
 	bool enable_tx_lpi;
 	bool eee_active;
 	struct eee_config eee_cfg;
@@ -1324,7 +1324,7 @@ int phy_speed_down_core(struct phy_device *phydev);
  */
 static inline void phy_set_eee_broken(struct phy_device *phydev, u32 link_mode)
 {
-	linkmode_set_bit(link_mode, phydev->eee_broken_modes);
+	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
 
 /**
-- 
2.47.1



