Return-Path: <netdev+bounces-68875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C998489C0
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 00:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A291F240DF
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C1F12E6D;
	Sat,  3 Feb 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLP8U7Zt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257A12B61
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707001803; cv=none; b=C0yICvUWGACTGmU6o3Zcd6vsg9faRv5z2IAP077bMIzKufwAF7AcQqa1eT91r7oAsZljUXDzzc67eyhawuJ60leY0lCGuW6Gv5BB8LB79IO/aFCSAX3Hv9qbUZpot064IkE049Hs7roBbTbOgeZ9Ti5s2xv8V0IEGgePrBIG8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707001803; c=relaxed/simple;
	bh=HGkF/CqE3c8q1WZWK+VMHycoTGRWW2HljyefBPE5u7M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RM/wjGCu5F7nLrC4KKuik9cgKneY5iaOMEsxj913n3kuxeiSxZ/EYGolsu3N0n/CyEpM1aVAbwt1BYVW+t+1HWG4aEjojSCdg537pdcU6lX8TZ3BtsKeypxLw0l9NNK8nPAOp+F5oOYgmIwQ5kIxevbNZx7aLMFVI9yMBebkEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLP8U7Zt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so4331267a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 15:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707001799; x=1707606599; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cCXVW/Si+O9P1vSFVdsSBbl4rcrmHbqZK0JNYdEOz4=;
        b=iLP8U7ZtxseNX1s9HseIfujvlOjXYec3eWlmVPWg5U4k8GVme4YreCOhoqYKMtnSWH
         uQ+JI2m8TjaJZk+nxHJRgSpQUfTek9F+bjJGjGose0YbjfM+r7it4oPlkwb4W2WxM3eD
         SaHKckKSkwANHf//f9GBatptdd2UK0YZSo/ZLavZZIMhy+e2NIDJuQsk9BBqFnLwCil6
         T3NGD6U2Nh1Q9bqvfrwsqqIzv2qRxeBmwWHwsFVG4UwwDszLg80xAbzNkepANqkEb7Ri
         qwgoiBZTR9/+8jDNybRlWQp7r55FQ32R7ZQju7YreaRopOEKMaIAvkYBT6/l0ZSbk0q4
         fWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707001799; x=1707606599;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cCXVW/Si+O9P1vSFVdsSBbl4rcrmHbqZK0JNYdEOz4=;
        b=Pzd98ER+XeuCvcTJJ4J5RKna/Oyq2bQ3PYSP3CO6hGwQvrFqhJY/J2Xj598NQBkEhL
         PX2/dXQa9DplSAAmJUm1/Hn9XV0UIpxpsEscvY7V03swiBAUKJHaXl9Dl9EAY4hl9krY
         tqTtv/gTLwupRfRciMZ/7ePCSjyGehGnsJ3ObNZ5r72o1udJsrPfXu0d7eRTtKPQ0tpg
         mIRfKSPl1nVIIKklRJsY5dc5XTFY02LS2j+biMpRh8fbFPCRLh+FDQY+Am6uEJk50qPk
         oLFGVa71BoA6tZDmG0Wk8i6l8nwCwhiOdvXpwa1PKkMARijNuVpf4sXvz6kGRi6XDpDr
         ZRaQ==
X-Gm-Message-State: AOJu0YwXdp3ePTSy24pjRu2sahp8h0c8PZzwhGZ0c9P7K/6hUqQhmfB0
	+qYd1jmo8WxeVdUjHihfms0vg7mZy/uDOyBKpMgYQ8KlhaxCEw5L
X-Google-Smtp-Source: AGHT+IFnIRP6rYlXFG3mlQvShQyPytUAySKBez6qAiErOPFxPfFAlPsdm+/u6bVBxuXNEtu9RUBmXg==
X-Received: by 2002:aa7:da88:0:b0:560:24e:3ca9 with SMTP id q8-20020aa7da88000000b00560024e3ca9mr2230437eds.0.1707001798808;
        Sat, 03 Feb 2024 15:09:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV2/ANDdDyKwKie2HnDnGyl+LRd/u8Tk4LAFHu5n1UK+uXeG/rmxA21bmyvXL+MP+ox6TS1LgBjoTeE5e/Yd5POCv//Tm46cj9T7pSZ4dABdtZboocXFsTUDrRuU3Aup5sgT/sTAm5SUbV48Z9JEiHZKExvZqN1TpBnS/+9TvD7g+l1+rP75AWEr8W9ppg7TNVcpFvesY7dlTEwaKQQ15nalI6EJVDiNnJCkvmg2Q==
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id x4-20020a056402414400b0055ff68cce5asm1836398eda.27.2024.02.03.15.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 15:09:58 -0800 (PST)
Message-ID: <37792c4f-6ad9-4af0-bb7b-ca9888a7339f@gmail.com>
Date: Sun, 4 Feb 2024 00:09:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Michael Chan <michael.chan@broadcom.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert EEE handling to use linkmode bitmaps. This prepares for removing
the legacy bitmaps from struct ethtool_keee. No functional change
intended. When replacing _bnxt_fw_to_ethtool_adv_spds() with
_bnxt_fw_to_linkmode(), remove the fw_pause argument because it's
always passed as 0.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add missing conversions
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 65 ++++++++-----------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  4 +-
 3 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fde32b32f..8fe8a73ff 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10624,7 +10624,7 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
 		struct ethtool_keee *eee = &bp->eee;
 		u16 fw_speeds = le16_to_cpu(resp->supported_speeds_eee_mode);
 
-		eee->supported_u32 = _bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
+		_bnxt_fw_to_linkmode(eee->supported, fw_speeds);
 		bp->lpi_tmr_lo = le32_to_cpu(resp->tx_lpi_timer_low) &
 				 PORT_PHY_QCAPS_RESP_TX_LPI_TIMER_LOW_MASK;
 		bp->lpi_tmr_hi = le32_to_cpu(resp->valid_tx_lpi_timer_high) &
@@ -10775,8 +10775,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 			eee->eee_active = 1;
 			fw_speeds = le16_to_cpu(
 				resp->link_partner_adv_eee_link_speed_mask);
-			eee->lp_advertised_u32 =
-				_bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
+			_bnxt_fw_to_linkmode(eee->lp_advertised, fw_speeds);
 		}
 
 		/* Pull initial EEE config */
@@ -10786,8 +10785,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 				eee->eee_enabled = 1;
 
 			fw_speeds = le16_to_cpu(resp->adv_eee_link_speed_mask);
-			eee->advertised_u32 =
-				_bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
+			_bnxt_fw_to_linkmode(eee->advertised, fw_speeds);
 
 			if (resp->eee_config_phy_addr &
 			    PORT_PHY_QCFG_RESP_EEE_CONFIG_EEE_TX_LPI) {
@@ -10969,7 +10967,7 @@ static void bnxt_hwrm_set_eee(struct bnxt *bp,
 			flags |= PORT_PHY_CFG_REQ_FLAGS_EEE_TX_LPI_DISABLE;
 
 		req->flags |= cpu_to_le32(flags);
-		eee_speeds = bnxt_get_fw_auto_link_speeds(eee->advertised_u32);
+		eee_speeds = bnxt_get_fw_auto_link_speeds(eee->advertised);
 		req->eee_link_speed_mask = cpu_to_le16(eee_speeds);
 		req->tx_lpi_timer = cpu_to_le32(eee->tx_lpi_timer);
 	} else {
@@ -11329,15 +11327,18 @@ static bool bnxt_eee_config_ok(struct bnxt *bp)
 		return true;
 
 	if (eee->eee_enabled) {
-		u32 advertising =
-			_bnxt_fw_to_ethtool_adv_spds(link_info->advertising, 0);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
+
+		_bnxt_fw_to_linkmode(advertising, link_info->advertising);
 
 		if (!(link_info->autoneg & BNXT_AUTONEG_SPEED)) {
 			eee->eee_enabled = 0;
 			return false;
 		}
-		if (eee->advertised_u32 & ~advertising) {
-			eee->advertised_u32 = advertising & eee->supported_u32;
+		if (linkmode_andnot(tmp, eee->advertised, advertising)) {
+			linkmode_and(eee->advertised, advertising,
+				     eee->supported);
 			return false;
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 481b835a7..482ce88b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1751,31 +1751,21 @@ static int bnxt_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	return 0;
 }
 
-u32 _bnxt_fw_to_ethtool_adv_spds(u16 fw_speeds, u8 fw_pause)
+/* TODO: support 25GB, 40GB, 50GB with different cable type */
+void _bnxt_fw_to_linkmode(unsigned long *mode, u16 fw_speeds)
 {
-	u32 speed_mask = 0;
+	linkmode_zero(mode);
 
-	/* TODO: support 25GB, 40GB, 50GB with different cable type */
-	/* set the advertised speeds */
 	if (fw_speeds & BNXT_LINK_SPEED_MSK_100MB)
-		speed_mask |= ADVERTISED_100baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, mode);
 	if (fw_speeds & BNXT_LINK_SPEED_MSK_1GB)
-		speed_mask |= ADVERTISED_1000baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mode);
 	if (fw_speeds & BNXT_LINK_SPEED_MSK_2_5GB)
-		speed_mask |= ADVERTISED_2500baseX_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, mode);
 	if (fw_speeds & BNXT_LINK_SPEED_MSK_10GB)
-		speed_mask |= ADVERTISED_10000baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, mode);
 	if (fw_speeds & BNXT_LINK_SPEED_MSK_40GB)
-		speed_mask |= ADVERTISED_40000baseCR4_Full;
-
-	if ((fw_pause & BNXT_LINK_PAUSE_BOTH) == BNXT_LINK_PAUSE_BOTH)
-		speed_mask |= ADVERTISED_Pause;
-	else if (fw_pause & BNXT_LINK_PAUSE_TX)
-		speed_mask |= ADVERTISED_Asym_Pause;
-	else if (fw_pause & BNXT_LINK_PAUSE_RX)
-		speed_mask |= ADVERTISED_Pause | ADVERTISED_Asym_Pause;
-
-	return speed_mask;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, mode);
 }
 
 enum bnxt_media_type {
@@ -2643,23 +2633,22 @@ bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 	return 0;
 }
 
-u16 bnxt_get_fw_auto_link_speeds(u32 advertising)
+u16 bnxt_get_fw_auto_link_speeds(const unsigned long *mode)
 {
 	u16 fw_speed_mask = 0;
 
-	/* only support autoneg at speed 100, 1000, and 10000 */
-	if (advertising & (ADVERTISED_100baseT_Full |
-			   ADVERTISED_100baseT_Half)) {
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, mode) ||
+	    linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, mode))
 		fw_speed_mask |= BNXT_LINK_SPEED_MSK_100MB;
-	}
-	if (advertising & (ADVERTISED_1000baseT_Full |
-			   ADVERTISED_1000baseT_Half)) {
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mode) ||
+	    linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, mode))
 		fw_speed_mask |= BNXT_LINK_SPEED_MSK_1GB;
-	}
-	if (advertising & ADVERTISED_10000baseT_Full)
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, mode))
 		fw_speed_mask |= BNXT_LINK_SPEED_MSK_10GB;
 
-	if (advertising & ADVERTISED_40000baseCR4_Full)
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, mode))
 		fw_speed_mask |= BNXT_LINK_SPEED_MSK_40GB;
 
 	return fw_speed_mask;
@@ -3886,10 +3875,11 @@ static int bnxt_set_eeprom(struct net_device *dev,
 
 static int bnxt_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	struct bnxt *bp = netdev_priv(dev);
 	struct ethtool_keee *eee = &bp->eee;
 	struct bnxt_link_info *link_info = &bp->link_info;
-	u32 advertising;
 	int rc = 0;
 
 	if (!BNXT_PHY_CFG_ABLE(bp))
@@ -3899,7 +3889,7 @@ static int bnxt_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&bp->link_lock);
-	advertising = _bnxt_fw_to_ethtool_adv_spds(link_info->advertising, 0);
+	_bnxt_fw_to_linkmode(advertising, link_info->advertising);
 	if (!edata->eee_enabled)
 		goto eee_ok;
 
@@ -3919,16 +3909,15 @@ static int bnxt_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 			edata->tx_lpi_timer = eee->tx_lpi_timer;
 		}
 	}
-	if (!edata->advertised_u32) {
-		edata->advertised_u32 = advertising & eee->supported_u32;
-	} else if (edata->advertised_u32 & ~advertising) {
-		netdev_warn(dev, "EEE advertised %x must be a subset of autoneg advertised speeds %x\n",
-			    edata->advertised_u32, advertising);
+	if (linkmode_empty(edata->advertised)) {
+		linkmode_and(edata->advertised, advertising, eee->supported);
+	} else if (linkmode_andnot(tmp, edata->advertised, advertising)) {
+		netdev_warn(dev, "EEE advertised must be a subset of autoneg advertised speeds\n");
 		rc = -EINVAL;
 		goto eee_exit;
 	}
 
-	eee->advertised_u32 = edata->advertised_u32;
+	linkmode_copy(eee->advertised, edata->advertised);
 	eee->tx_lpi_enabled = edata->tx_lpi_enabled;
 	eee->tx_lpi_timer = edata->tx_lpi_timer;
 eee_ok:
@@ -3954,12 +3943,12 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 		/* Preserve tx_lpi_timer so that the last value will be used
 		 * by default when it is re-enabled.
 		 */
-		edata->advertised_u32 = 0;
+		linkmode_zero(edata->advertised);
 		edata->tx_lpi_enabled = 0;
 	}
 
 	if (!bp->eee.eee_active)
-		edata->lp_advertised_u32 = 0;
+		linkmode_zero(edata->lp_advertised);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
index a8ecef8ab..0ea0f4a36 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
@@ -46,9 +46,9 @@ struct bnxt_led_cfg {
 extern const struct ethtool_ops bnxt_ethtool_ops;
 
 u32 bnxt_get_rxfh_indir_size(struct net_device *dev);
-u32 _bnxt_fw_to_ethtool_adv_spds(u16, u8);
+void _bnxt_fw_to_linkmode(unsigned long *mode, u16 fw_speeds);
 u32 bnxt_fw_to_ethtool_speed(u16);
-u16 bnxt_get_fw_auto_link_speeds(u32);
+u16 bnxt_get_fw_auto_link_speeds(const unsigned long *mode);
 int bnxt_hwrm_nvm_get_dev_info(struct bnxt *bp,
 			       struct hwrm_nvm_get_dev_info_output *nvm_dev_info);
 int bnxt_hwrm_firmware_reset(struct net_device *dev, u8 proc_type,
-- 
2.43.0


