Return-Path: <netdev+bounces-69902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFB84CF3D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC6DB28187
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864981ACA;
	Wed,  7 Feb 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmQPnPeB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED381ABF
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324460; cv=none; b=rn7RXeuu/Q1/qVuiD1vIchxBITL2APhhKsGBX9p5yZzfNvwtGsgE3NXsX3hP6G0ScrIrTU1cOjtPTM4o36CoJUq/mQzZZre4cE5olnNWlwcXQ30Db9PpyP/lhp85N/VS8dzlW4lF9U+3urGjTwZi6He05PwQpRziaFSXRhCCr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324460; c=relaxed/simple;
	bh=YgYi0w5tdz41Xg/Nw1J177Fk72+D5VudCMu3l3NPBhU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YWbBQ1PZJLZmjeQ3HF9j3cH9sLhujlTcDngANiapvdxIY+6/ugf60MgOHMDwsTCDvkzpCdpNhBILtb9xDPBqGQ/lDyhj+vtFDdhikBAfEB46IuB9yqjyNZPECF7psH39v2MLL/K/vPBngT82MTqOC2Nm4+HeGEqvFF10nNsbDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmQPnPeB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5116b017503so296153e87.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324456; x=1707929256; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/zUKqXp8YG/yHe3utiJxwNybi2WCtBEV0ZZtqP5kjI=;
        b=jmQPnPeBNQumcd10ZrMrPOZ3O7By5vG0BcpzXH3w3NRodqTOxKvwv+ZCGvOxBa39xy
         fciknBXj8ii6jX4g3FdQ2tK6k900H3wWuZAmKN6E5Oz0XxTZsM2Kyl+SHI0v4I/hFRIe
         V1LpPEXqKgtMY5uAHksQIL5zq3uwS1vvmXDm2MJGbTz+at1kG/tXsv7dhoSS9cvlzqab
         jEtTBSjuQ1//bI9sgUGIWbwEYNWKgtB9Ih64o1UrsSVI/50rf5DkJLPALn1evhibSanp
         iES3UHUlBvSXOVQQ7EW+IIHvUAxvZrQG8kWP6+Yi+hJAH12t3RuPlDLyejZQgiBXYKld
         FxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324456; x=1707929256;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/zUKqXp8YG/yHe3utiJxwNybi2WCtBEV0ZZtqP5kjI=;
        b=U6YGJudjsyr8nwOl8IJYz+ZRmojzHpdfHxF9a4o21mn0ovNajZify3EBY8H2G8yraZ
         fKSD6XtBkn7oy+usL0EZRzhUdiVaBlIGMJO5jj9gkdmEs0S9I3Vmgb8vmtFZub2eQKHk
         ZfNT+0kAGP+XT5PvYTVLjeB9P+MeMdy6vlmVsdMC09J1RQMxiJq3Z61Ec3YEAxQ1CCRN
         YIFUOgeYKYrR/97gMaI1wlGLl63+fx5RDtScXAKTgl31sVxJvqG+szp+jN3WFIl+63RS
         QUCsCtNf/lEOobqbFwisfyGKDLT0t5wEsqPO6jImu7xY4DYRcDF0Z0xnkaDTQUDH/KmZ
         mGiA==
X-Gm-Message-State: AOJu0YwUaWKIDr6yi7JETM3zyN7ClN3MVXphosM2DW/U/NIqRng9peTG
	9hV3em6EJqlvrgpDuOwdLiONNFLutsN8Fbhjr6nyIBmtNFeYNecT
X-Google-Smtp-Source: AGHT+IHZwPhQMYmuPR85oa701Tm/lCpZUMAJRmWVuGRG0ycm4P7xGCyQiDp7dVLulNojPfZtjkgB7Q==
X-Received: by 2002:a05:6512:3445:b0:511:4ee4:2c73 with SMTP id j5-20020a056512344500b005114ee42c73mr3932864lfr.68.1707324455938;
        Wed, 07 Feb 2024 08:47:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWExM3oZKhordV5mOrGMB0+joeyjtPuxqksV55HOx880C5rSy032K8QmRKtrhVadWwCtD7wxp4rTN5gVMlJZLaKKeV8gTIR37yoQapT21sUvz0KUBKlaKCinLXCKXAWQ5t1OBAIG09VBX/aWO4EwvMlmq+XkPlsHcUR6UCWqPVO6rRNZl/6r+eR0d37Kf7DuR5dQImC+hgUkmH+ss4HHRxhYMbb2nM+0hOg1/U=
Received: from ?IPV6:2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a? (dynamic-2a01-0c22-76b1-9500-5d1b-fc9d-6dc2-024a.c22.pool.telefonica.de. [2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a])
        by smtp.googlemail.com with ESMTPSA id lj24-20020a170906f9d800b00a38599ba2d1sm929052ejb.118.2024.02.07.08.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:47:35 -0800 (PST)
Message-ID: <9123bf18-a0d0-404e-a7c4-d6c466b4c5e8@gmail.com>
Date: Wed, 7 Feb 2024 17:47:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Michael Chan <michael.chan@broadcom.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 RESUBMIT net-next] bnxt: convert EEE handling to use
 linkmode bitmaps
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert EEE handling to use linkmode bitmaps. This prepares for removing
the legacy bitmaps from struct ethtool_keee. No functional change
intended. When replacing _bnxt_fw_to_ethtool_adv_spds() with
_bnxt_fw_to_linkmode(), remove the fw_pause argument because it's
always passed as 0.

Note:
There's a discussion on whether the underlying implementation is correct,
but it's independent of this mechanical conversion w/o functional change.

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


