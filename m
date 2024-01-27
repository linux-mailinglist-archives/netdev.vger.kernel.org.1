Return-Path: <netdev+bounces-66400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785E783ED4B
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8207D1C210B9
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A52560C;
	Sat, 27 Jan 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih/P0EY0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC025765
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362133; cv=none; b=ROixpQFWSwXFXtMfeUN576KIsRTlVng+zLBim94OjsDh/lxgvqIuZ6HSDBUgEPbwSP/hrUpSA1w7jRyf8KFzN4ZM1tjjKa12xSdeXL7uumW7lwyRkkk+5ls/UNr2vzKk57tBNTm29nyycwSxbUCpFNsrU44/P7/bp317VcPqKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362133; c=relaxed/simple;
	bh=KHqM62fAJzAOmaxJ10/iKOQhOE6ncJVaMEMUbi+1HCk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xl9guxT4IOXbejOWVIKZh/5Tc+OdZbYoMrABBPsWCHpoXdkRykZJi1lo72moV7l0dinFvP2dl5t7CjN2AKwnhv3FSBIh5dawE84uiN6a+fvFPYzrFTqzDcjJoJqg2joYAIsvDStNjoUbVI6YPzadPlKDCBuIOuuaXzdBUmTwTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih/P0EY0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ee705e9bfso17000815e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706362129; x=1706966929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zXsRjBzVwKauKpOf4ElYR/H3iRDRSHGM/cJ83kZ+rAw=;
        b=ih/P0EY0S4KDlfWNcioid9YVs393+23/uo24bSQLucQmPj9wWIFAAO0WvfiDVd1Y0A
         j2ClcyHmkHHYsPAms7etJkmnCVrnivUTVPkxIqBzkVjEU48vS5lNUGjZaGhQ6kzi3m9Q
         L2gpcvMZeSsPF0cJ3ySbpkdkB5OzS0LFRbR/TtGf8uGc2NdcMSAila3RZsV+d+01ba8L
         SgPjURuKfmVDlhYBTM+MMXhA9s4zZsEiHImwKa6swmYKnGMpz4AeSPrb/yQSKJXE9UXk
         ihRu1TZKoZqQ+NWcs0D6mMwbtFDMFgXUZpaBifWvrbCbUdViQ0KLja5nK5HbRB925c+P
         Tedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706362129; x=1706966929;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXsRjBzVwKauKpOf4ElYR/H3iRDRSHGM/cJ83kZ+rAw=;
        b=i3skOnA7kZn3rmh6l1VWWmBuXDAD4Tj36ql7EyyPjYyhORhSOKT9En/CT6yk3tYB/f
         d/ipwM7DhwuPIqBJ0pjSGwpI/cf6uWSvX6iQXIq05bytFSUHb4/xAnQ7DUhX7p4xfr4n
         RO3AxviJ8O7DZY/Pfk1N2Z2AdU4goQp+28FcWcjRDsjyqcH7ghj5qShspbKmIt3PlMlS
         nOGGEfL6nUJ59XflKEdNghWok6LM1z1mWuWAk85Lkhnx6PGQOE28k6r/lf77cXPadNQQ
         eIyj3DppX7QzAJpSCMYic14FAGcKFIf+FH6TANZRFzYEHDElk7dERPk/6Z1TCDbo5/Od
         ePTQ==
X-Gm-Message-State: AOJu0YzXk3+uiPL1CWxEoahZJMNhi0BtzYhzVlJ5D04qkZ6bAxhGLQIE
	N71fASSD2Sd0i0eT9o3CtrAjLQ8HDGki3JRdX64uax114iQLyyTg
X-Google-Smtp-Source: AGHT+IGoaUkzBVHVxoCXiZN7iRIxgiWqCaf83VCqikN33OGsLhs80c6FBBeefbld57yS/nxgj4dtGg==
X-Received: by 2002:a05:600c:1f83:b0:40e:7610:f2e2 with SMTP id je3-20020a05600c1f8300b0040e7610f2e2mr1167033wmb.14.1706362128578;
        Sat, 27 Jan 2024 05:28:48 -0800 (PST)
Received: from ?IPV6:2a01:c23:b938:5400:11ba:857c:4df8:38b0? (dynamic-2a01-0c23-b938-5400-11ba-857c-4df8-38b0.c23.pool.telefonica.de. [2a01:c23:b938:5400:11ba:857c:4df8:38b0])
        by smtp.googlemail.com with ESMTPSA id fa7-20020a05600c518700b0040ec6d7420csm8537514wmb.14.2024.01.27.05.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:28:48 -0800 (PST)
Message-ID: <3d4f2051-90ab-4aa7-bce8-3622cbfd27aa@gmail.com>
Date: Sat, 27 Jan 2024 14:28:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 4/6] ethtool: add suffix _u32 to legacy bitmap
 members of struct ethtool_keee
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

This is in preparation of using the existing names for linkmode
bitmaps.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v4:
- fix missing replacement
---
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |  8 +++---
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  8 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 12 ++++----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 14 +++++-----
 drivers/net/ethernet/broadcom/tg3.c           | 22 +++++++--------
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 10 +++----
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 10 +++----
 drivers/net/ethernet/intel/igb/igb_ethtool.c  | 20 ++++++-------
 drivers/net/ethernet/intel/igc/igc_ethtool.c  | 12 ++++----
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 18 ++++++------
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 28 +++++++++----------
 drivers/net/phy/phy-c45.c                     | 12 ++++----
 drivers/net/usb/ax88179_178a.c                | 10 +++----
 drivers/net/usb/r8152.c                       | 14 +++++-----
 include/linux/ethtool.h                       |  6 ++--
 net/ethtool/eee.c                             | 16 +++++------
 net/ethtool/ioctl.c                           | 12 ++++----
 17 files changed, 116 insertions(+), 116 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index be865776d..6b454eb7a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -713,14 +713,14 @@ static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
 	if (err < 0)
 		return err;
 
-	eee->supported = eee_mask_to_ethtool_mask(supported_rates);
+	eee->supported_u32 = eee_mask_to_ethtool_mask(supported_rates);
 
 	if (aq_nic->aq_nic_cfg.eee_speeds)
-		eee->advertised = eee->supported;
+		eee->advertised_u32 = eee->supported_u32;
 
-	eee->lp_advertised = eee_mask_to_ethtool_mask(rate);
+	eee->lp_advertised_u32 = eee_mask_to_ethtool_mask(rate);
 
-	eee->eee_enabled = !!eee->advertised;
+	eee->eee_enabled = !!eee->advertised_u32;
 
 	eee->tx_lpi_enabled = eee->eee_enabled;
 	if ((supported_rates & rate) & AQ_NIC_RATE_EEE_MSK)
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index c9afb9203..6cabf405d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2120,14 +2120,14 @@ static int bnx2x_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 
 	eee_cfg = bp->link_vars.eee_status;
 
-	edata->supported =
+	edata->supported_u32 =
 		bnx2x_eee_to_adv((eee_cfg & SHMEM_EEE_SUPPORTED_MASK) >>
 				 SHMEM_EEE_SUPPORTED_SHIFT);
 
-	edata->advertised =
+	edata->advertised_u32 =
 		bnx2x_eee_to_adv((eee_cfg & SHMEM_EEE_ADV_STATUS_MASK) >>
 				 SHMEM_EEE_ADV_STATUS_SHIFT);
-	edata->lp_advertised =
+	edata->lp_advertised_u32 =
 		bnx2x_eee_to_adv((eee_cfg & SHMEM_EEE_LP_ADV_STATUS_MASK) >>
 				 SHMEM_EEE_LP_ADV_STATUS_SHIFT);
 
@@ -2162,7 +2162,7 @@ static int bnx2x_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 	}
 
-	advertised = bnx2x_adv_to_eee(edata->advertised,
+	advertised = bnx2x_adv_to_eee(edata->advertised_u32,
 				      SHMEM_EEE_ADV_STATUS_SHIFT);
 	if ((advertised != (eee_cfg & SHMEM_EEE_ADV_STATUS_MASK))) {
 		DP(BNX2X_MSG_ETHTOOL,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d7626c26f..fde32b32f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10624,7 +10624,7 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
 		struct ethtool_keee *eee = &bp->eee;
 		u16 fw_speeds = le16_to_cpu(resp->supported_speeds_eee_mode);
 
-		eee->supported = _bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
+		eee->supported_u32 = _bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
 		bp->lpi_tmr_lo = le32_to_cpu(resp->tx_lpi_timer_low) &
 				 PORT_PHY_QCAPS_RESP_TX_LPI_TIMER_LOW_MASK;
 		bp->lpi_tmr_hi = le32_to_cpu(resp->valid_tx_lpi_timer_high) &
@@ -10775,7 +10775,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 			eee->eee_active = 1;
 			fw_speeds = le16_to_cpu(
 				resp->link_partner_adv_eee_link_speed_mask);
-			eee->lp_advertised =
+			eee->lp_advertised_u32 =
 				_bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
 		}
 
@@ -10786,7 +10786,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 				eee->eee_enabled = 1;
 
 			fw_speeds = le16_to_cpu(resp->adv_eee_link_speed_mask);
-			eee->advertised =
+			eee->advertised_u32 =
 				_bnxt_fw_to_ethtool_adv_spds(fw_speeds, 0);
 
 			if (resp->eee_config_phy_addr &
@@ -10969,7 +10969,7 @@ static void bnxt_hwrm_set_eee(struct bnxt *bp,
 			flags |= PORT_PHY_CFG_REQ_FLAGS_EEE_TX_LPI_DISABLE;
 
 		req->flags |= cpu_to_le32(flags);
-		eee_speeds = bnxt_get_fw_auto_link_speeds(eee->advertised);
+		eee_speeds = bnxt_get_fw_auto_link_speeds(eee->advertised_u32);
 		req->eee_link_speed_mask = cpu_to_le16(eee_speeds);
 		req->tx_lpi_timer = cpu_to_le32(eee->tx_lpi_timer);
 	} else {
@@ -11336,8 +11336,8 @@ static bool bnxt_eee_config_ok(struct bnxt *bp)
 			eee->eee_enabled = 0;
 			return false;
 		}
-		if (eee->advertised & ~advertising) {
-			eee->advertised = advertising & eee->supported;
+		if (eee->advertised_u32 & ~advertising) {
+			eee->advertised_u32 = advertising & eee->supported_u32;
 			return false;
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index d6a8577d6..481b835a7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3919,16 +3919,16 @@ static int bnxt_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 			edata->tx_lpi_timer = eee->tx_lpi_timer;
 		}
 	}
-	if (!edata->advertised) {
-		edata->advertised = advertising & eee->supported;
-	} else if (edata->advertised & ~advertising) {
+	if (!edata->advertised_u32) {
+		edata->advertised_u32 = advertising & eee->supported_u32;
+	} else if (edata->advertised_u32 & ~advertising) {
 		netdev_warn(dev, "EEE advertised %x must be a subset of autoneg advertised speeds %x\n",
-			    edata->advertised, advertising);
+			    edata->advertised_u32, advertising);
 		rc = -EINVAL;
 		goto eee_exit;
 	}
 
-	eee->advertised = edata->advertised;
+	eee->advertised_u32 = edata->advertised_u32;
 	eee->tx_lpi_enabled = edata->tx_lpi_enabled;
 	eee->tx_lpi_timer = edata->tx_lpi_timer;
 eee_ok:
@@ -3954,12 +3954,12 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 		/* Preserve tx_lpi_timer so that the last value will be used
 		 * by default when it is re-enabled.
 		 */
-		edata->advertised = 0;
+		edata->advertised_u32 = 0;
 		edata->tx_lpi_enabled = 0;
 	}
 
 	if (!bp->eee.eee_active)
-		edata->lp_advertised = 0;
+		edata->lp_advertised_u32 = 0;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 11054177c..f644a9131 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -2362,13 +2362,13 @@ static void tg3_eee_pull_config(struct tg3 *tp, struct ethtool_keee *eee)
 	/* Pull lp advertised settings */
 	if (tg3_phy_cl45_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE, &val))
 		return;
-	dest->lp_advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	dest->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
 
 	/* Pull advertised and eee_enabled settings */
 	if (tg3_phy_cl45_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV, &val))
 		return;
 	dest->eee_enabled = !!val;
-	dest->advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	dest->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
 
 	/* Pull tx_lpi_enabled */
 	val = tr32(TG3_CPMU_EEE_MODE);
@@ -4364,9 +4364,9 @@ static int tg3_phy_autoneg_cfg(struct tg3 *tp, u32 advertise, u32 flowctrl)
 
 		if (!tp->eee.eee_enabled) {
 			val = 0;
-			tp->eee.advertised = 0;
+			tp->eee.advertised_u32 = 0;
 		} else {
-			tp->eee.advertised = advertise &
+			tp->eee.advertised_u32 = advertise &
 					     (ADVERTISED_100baseT_Full |
 					      ADVERTISED_1000baseT_Full);
 		}
@@ -4626,13 +4626,13 @@ static bool tg3_phy_eee_config_ok(struct tg3 *tp)
 	tg3_eee_pull_config(tp, &eee);
 
 	if (tp->eee.eee_enabled) {
-		if (tp->eee.advertised != eee.advertised ||
+		if (tp->eee.advertised_u32 != eee.advertised_u32 ||
 		    tp->eee.tx_lpi_timer != eee.tx_lpi_timer ||
 		    tp->eee.tx_lpi_enabled != eee.tx_lpi_enabled)
 			return false;
 	} else {
 		/* EEE is disabled but we're advertising */
-		if (eee.advertised)
+		if (eee.advertised_u32)
 			return false;
 	}
 
@@ -14189,7 +14189,7 @@ static int tg3_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 	}
 
-	if (edata->advertised != tp->eee.advertised) {
+	if (edata->advertised_u32 != tp->eee.advertised_u32) {
 		netdev_warn(tp->dev,
 			    "Direct manipulation of EEE advertisement is not supported\n");
 		return -EINVAL;
@@ -15655,10 +15655,10 @@ static int tg3_phy_probe(struct tg3 *tp)
 	      tg3_chip_rev_id(tp) != CHIPREV_ID_57765_A0))) {
 		tp->phy_flags |= TG3_PHYFLG_EEE_CAP;
 
-		tp->eee.supported = SUPPORTED_100baseT_Full |
-				    SUPPORTED_1000baseT_Full;
-		tp->eee.advertised = ADVERTISED_100baseT_Full |
-				     ADVERTISED_1000baseT_Full;
+		tp->eee.supported_u32 = SUPPORTED_100baseT_Full |
+					SUPPORTED_1000baseT_Full;
+		tp->eee.advertised_u32 = ADVERTISED_100baseT_Full |
+					 ADVERTISED_1000baseT_Full;
 		tp->eee.eee_enabled = 1;
 		tp->eee.tx_lpi_enabled = 1;
 		tp->eee.tx_lpi_timer = TG3_CPMU_DBTMR1_LNKIDLE_2047US;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 343f54b2b..ff243ae71 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2223,16 +2223,16 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	ret_val = e1000_read_emi_reg_locked(hw, cap_addr, &phy_data);
 	if (ret_val)
 		goto release;
-	edata->supported = mmd_eee_cap_to_ethtool_sup_t(phy_data);
+	edata->supported_u32 = mmd_eee_cap_to_ethtool_sup_t(phy_data);
 
 	/* EEE Advertised */
-	edata->advertised = mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
+	edata->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
 
 	/* EEE Link Partner Advertised */
 	ret_val = e1000_read_emi_reg_locked(hw, lpa_addr, &phy_data);
 	if (ret_val)
 		goto release;
-	edata->lp_advertised = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+	edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
 
 	/* EEE PCS Status */
 	ret_val = e1000_read_emi_reg_locked(hw, pcs_stat_addr, &phy_data);
@@ -2283,12 +2283,12 @@ static int e1000e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		return -EINVAL;
 	}
 
-	if (edata->advertised & ~(ADVERTISE_100_FULL | ADVERTISE_1000_FULL)) {
+	if (edata->advertised_u32 & ~(ADVERTISE_100_FULL | ADVERTISE_1000_FULL)) {
 		e_err("EEE advertisement supports only 100TX and/or 1000T full-duplex\n");
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised);
+	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
 
 	hw->dev_spec.ich8lan.eee_disable = !edata->eee_enabled;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9dfda3c48..1b5473358 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5664,16 +5664,16 @@ static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	if (phy_cfg.eee_capability == 0)
 		return -EOPNOTSUPP;
 
-	edata->supported = SUPPORTED_Autoneg;
-	edata->lp_advertised = edata->supported;
+	edata->supported_u32 = SUPPORTED_Autoneg;
+	edata->lp_advertised_u32 = edata->supported_u32;
 
 	/* Get current configuration */
 	status = i40e_aq_get_phy_capabilities(hw, false, false, &phy_cfg, NULL);
 	if (status)
 		return -EAGAIN;
 
-	edata->advertised = phy_cfg.eee_capability ? SUPPORTED_Autoneg : 0U;
-	edata->eee_enabled = !!edata->advertised;
+	edata->advertised_u32 = phy_cfg.eee_capability ? SUPPORTED_Autoneg : 0U;
+	edata->eee_enabled = !!edata->advertised_u32;
 	edata->tx_lpi_enabled = pf->stats.tx_lpi_status;
 
 	edata->eee_active = pf->stats.tx_lpi_status && pf->stats.rx_lpi_status;
@@ -5691,7 +5691,7 @@ static int i40e_is_eee_param_supported(struct net_device *netdev,
 		u32 value;
 		const char *name;
 	} param[] = {
-		{edata->advertised & ~SUPPORTED_Autoneg, "advertise"},
+		{edata->advertised_u32 & ~SUPPORTED_Autoneg, "advertise"},
 		{edata->tx_lpi_timer, "tx-timer"},
 		{edata->tx_lpi_enabled != pf->stats.tx_lpi_status, "tx-lpi"}
 	};
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 778d1e6cf..b87b23d21 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3038,10 +3038,10 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	    (hw->phy.media_type != e1000_media_type_copper))
 		return -EOPNOTSUPP;
 
-	edata->supported = (SUPPORTED_1000baseT_Full |
-			    SUPPORTED_100baseT_Full);
+	edata->supported_u32 = (SUPPORTED_1000baseT_Full |
+				SUPPORTED_100baseT_Full);
 	if (!hw->dev_spec._82575.eee_disable)
-		edata->advertised =
+		edata->advertised_u32 =
 			mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
 
 	/* The IPCNFG and EEER registers are not supported on I354. */
@@ -3068,7 +3068,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		if (ret_val)
 			return -ENODATA;
 
-		edata->lp_advertised = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+		edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
 		break;
 	case e1000_i354:
 	case e1000_i210:
@@ -3079,7 +3079,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		if (ret_val)
 			return -ENODATA;
 
-		edata->lp_advertised = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+		edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
 
 		break;
 	default:
@@ -3099,7 +3099,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		edata->eee_enabled = false;
 		edata->eee_active = false;
 		edata->tx_lpi_enabled = false;
-		edata->advertised &= ~edata->advertised;
+		edata->advertised_u32 &= ~edata->advertised_u32;
 	}
 
 	return 0;
@@ -3138,14 +3138,14 @@ static int igb_set_eee(struct net_device *netdev,
 			return -EINVAL;
 		}
 
-		if (!edata->advertised || (edata->advertised &
+		if (!edata->advertised_u32 || (edata->advertised_u32 &
 		    ~(ADVERTISE_100_FULL | ADVERTISE_1000_FULL))) {
 			dev_err(&adapter->pdev->dev,
 				"EEE Advertisement supports only 100Tx and/or 100T full duplex\n");
 			return -EINVAL;
 		}
-		adv100m_eee = !!(edata->advertised & ADVERTISE_100_FULL);
-		adv1g_eee = !!(edata->advertised & ADVERTISE_1000_FULL);
+		adv100m_eee = !!(edata->advertised_u32 & ADVERTISE_100_FULL);
+		adv1g_eee = !!(edata->advertised_u32 & ADVERTISE_1000_FULL);
 
 	} else if (!edata->eee_enabled) {
 		dev_err(&adapter->pdev->dev,
@@ -3153,7 +3153,7 @@ static int igb_set_eee(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised);
+	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
 	if (hw->dev_spec._82575.eee_disable != !edata->eee_enabled) {
 		hw->dev_spec._82575.eee_disable = !edata->eee_enabled;
 		adapter->flags |= IGB_FLAG_EEE;
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index f2dcfe920..7f844e967 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1630,11 +1630,11 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 	u32 eeer;
 
 	if (hw->dev_spec._base.eee_enable)
-		edata->advertised =
+		edata->advertised_u32 =
 			mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
 
 	*edata = adapter->eee;
-	edata->supported = SUPPORTED_Autoneg;
+	edata->supported_u32 = SUPPORTED_Autoneg;
 
 	eeer = rd32(IGC_EEER);
 
@@ -1647,8 +1647,8 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 
 	edata->eee_enabled = hw->dev_spec._base.eee_enable;
 
-	edata->advertised = SUPPORTED_Autoneg;
-	edata->lp_advertised = SUPPORTED_Autoneg;
+	edata->advertised_u32 = SUPPORTED_Autoneg;
+	edata->lp_advertised_u32 = SUPPORTED_Autoneg;
 
 	/* Report correct negotiated EEE status for devices that
 	 * wrongly report EEE at half-duplex
@@ -1657,7 +1657,7 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 		edata->eee_enabled = false;
 		edata->eee_active = false;
 		edata->tx_lpi_enabled = false;
-		edata->advertised &= ~edata->advertised;
+		edata->advertised_u32 &= ~edata->advertised_u32;
 	}
 
 	return 0;
@@ -1699,7 +1699,7 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised);
+	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
 	if (hw->dev_spec._base.eee_enable != edata->eee_enabled) {
 		hw->dev_spec._base.eee_enable = edata->eee_enabled;
 		adapter->flags |= IGC_FLAG_EEE;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0aa73519a..ca69a8221 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3436,27 +3436,27 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 	if (rc)
 		return rc;
 
-	edata->lp_advertised = 0;
+	edata->lp_advertised_u32 = 0;
 	for (i = 0; i < ARRAY_SIZE(ixgbe_lp_map); ++i) {
 		if (info[0] & ixgbe_lp_map[i].lp_advertised)
-			edata->lp_advertised |= ixgbe_lp_map[i].mac_speed;
+			edata->lp_advertised_u32 |= ixgbe_lp_map[i].mac_speed;
 	}
 
-	edata->supported = 0;
+	edata->supported_u32 = 0;
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
-			edata->supported |= ixgbe_ls_map[i].supported;
+			edata->supported_u32 |= ixgbe_ls_map[i].supported;
 	}
 
-	edata->advertised = 0;
+	edata->advertised_u32 = 0;
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_advertised & ixgbe_ls_map[i].mac_speed)
-			edata->advertised |= ixgbe_ls_map[i].supported;
+			edata->advertised_u32 |= ixgbe_ls_map[i].supported;
 	}
 
-	edata->eee_enabled = !!edata->advertised;
+	edata->eee_enabled = !!edata->advertised_u32;
 	edata->tx_lpi_enabled = edata->eee_enabled;
-	if (edata->advertised & edata->lp_advertised)
+	if (edata->advertised_u32 & edata->lp_advertised_u32)
 		edata->eee_active = true;
 
 	return 0;
@@ -3504,7 +3504,7 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 			return -EINVAL;
 		}
 
-		if (eee_data.advertised != edata->advertised) {
+		if (eee_data.advertised_u32 != edata->advertised_u32) {
 			e_err(drv,
 			      "Setting EEE advertised speeds is not supported\n");
 			return -EINVAL;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 77491fb64..dfa15619f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1790,17 +1790,17 @@ static int qede_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 	}
 
 	if (current_link.eee.adv_caps & QED_EEE_1G_ADV)
-		edata->advertised = ADVERTISED_1000baseT_Full;
+		edata->advertised_u32 = ADVERTISED_1000baseT_Full;
 	if (current_link.eee.adv_caps & QED_EEE_10G_ADV)
-		edata->advertised |= ADVERTISED_10000baseT_Full;
+		edata->advertised_u32 |= ADVERTISED_10000baseT_Full;
 	if (current_link.sup_caps & QED_EEE_1G_ADV)
-		edata->supported = ADVERTISED_1000baseT_Full;
+		edata->supported_u32 = ADVERTISED_1000baseT_Full;
 	if (current_link.sup_caps & QED_EEE_10G_ADV)
-		edata->supported |= ADVERTISED_10000baseT_Full;
+		edata->supported_u32 |= ADVERTISED_10000baseT_Full;
 	if (current_link.eee.lp_adv_caps & QED_EEE_1G_ADV)
-		edata->lp_advertised = ADVERTISED_1000baseT_Full;
+		edata->lp_advertised_u32 = ADVERTISED_1000baseT_Full;
 	if (current_link.eee.lp_adv_caps & QED_EEE_10G_ADV)
-		edata->lp_advertised |= ADVERTISED_10000baseT_Full;
+		edata->lp_advertised_u32 |= ADVERTISED_10000baseT_Full;
 
 	edata->tx_lpi_timer = current_link.eee.tx_lpi_timer;
 	edata->eee_enabled = current_link.eee.enable;
@@ -1832,20 +1832,20 @@ static int qede_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 	memset(&params, 0, sizeof(params));
 	params.override_flags |= QED_LINK_OVERRIDE_EEE_CONFIG;
 
-	if (!(edata->advertised & (ADVERTISED_1000baseT_Full |
-				   ADVERTISED_10000baseT_Full)) ||
-	    ((edata->advertised & (ADVERTISED_1000baseT_Full |
-				   ADVERTISED_10000baseT_Full)) !=
-	     edata->advertised)) {
+	if (!(edata->advertised_u32 & (ADVERTISED_1000baseT_Full |
+				       ADVERTISED_10000baseT_Full)) ||
+	    ((edata->advertised_u32 & (ADVERTISED_1000baseT_Full |
+				       ADVERTISED_10000baseT_Full)) !=
+	     edata->advertised_u32)) {
 		DP_VERBOSE(edev, QED_MSG_DEBUG,
 			   "Invalid advertised capabilities %d\n",
-			   edata->advertised);
+			   edata->advertised_u32);
 		return -EINVAL;
 	}
 
-	if (edata->advertised & ADVERTISED_1000baseT_Full)
+	if (edata->advertised_u32 & ADVERTISED_1000baseT_Full)
 		params.eee.adv_caps = QED_EEE_1G_ADV;
-	if (edata->advertised & ADVERTISED_10000baseT_Full)
+	if (edata->advertised_u32 & ADVERTISED_10000baseT_Full)
 		params.eee.adv_caps |= QED_EEE_10G_ADV;
 	params.eee.enable = edata->eee_enabled;
 	params.eee.tx_lpi_enable = edata->tx_lpi_enabled;
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index adee5e712..99c84af25 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1463,12 +1463,12 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 	data->eee_enabled = is_enabled;
 	data->eee_active = ret;
 
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->supported,
+	if (!ethtool_convert_link_mode_to_legacy_u32(&data->supported_u32,
 						     phydev->supported_eee))
 		overflow = true;
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->advertised, adv))
+	if (!ethtool_convert_link_mode_to_legacy_u32(&data->advertised_u32, adv))
 		overflow = true;
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->lp_advertised, lp))
+	if (!ethtool_convert_link_mode_to_legacy_u32(&data->lp_advertised_u32, lp))
 		overflow = true;
 
 	if (overflow)
@@ -1495,11 +1495,11 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	int ret;
 
 	if (data->eee_enabled) {
-		if (data->advertised) {
+		if (data->advertised_u32) {
 			__ETHTOOL_DECLARE_LINK_MODE_MASK(adv);
 
 			ethtool_convert_legacy_u32_to_link_mode(adv,
-								data->advertised);
+								data->advertised_u32);
 			linkmode_andnot(adv, adv, phydev->supported_eee);
 			if (!linkmode_empty(adv)) {
 				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
@@ -1507,7 +1507,7 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			}
 
 			ethtool_convert_legacy_u32_to_link_mode(phydev->advertising_eee,
-								data->advertised);
+								data->advertised_u32);
 		} else {
 			linkmode_copy(phydev->advertising_eee,
 				      phydev->supported_eee);
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 3922a9afd..d6168eaa2 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -676,21 +676,21 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 					    MDIO_MMD_PCS);
 	if (val < 0)
 		return val;
-	data->supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	data->supported_u32 = mmd_eee_cap_to_ethtool_sup_t(val);
 
 	/* Get advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	data->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
 
 	/* Get LP advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->lp_advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	data->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
 
 	return 0;
 }
@@ -698,7 +698,7 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 static int
 ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
-	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised);
+	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised_u32);
 
 	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					      MDIO_MMD_AN, tmp16);
@@ -1663,7 +1663,7 @@ static int ax88179_reset(struct usbnet *dev)
 	ax88179_disable_eee(dev);
 
 	ax88179_ethtool_get_eee(dev, &eee_data);
-	eee_data.advertised = 0;
+	eee_data.advertised_u32 = 0;
 	ax88179_ethtool_set_eee(dev, &eee_data);
 
 	/* Restart autoneg */
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index dc163b766..3d806b3ff 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8938,16 +8938,16 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 	eee->eee_enabled = tp->eee_en;
 	eee->eee_active = !!(supported & adv & lp);
-	eee->supported = supported;
-	eee->advertised = tp->eee_adv;
-	eee->lp_advertised = lp;
+	eee->supported_u32 = supported;
+	eee->advertised_u32 = tp->eee_adv;
+	eee->lp_advertised_u32 = lp;
 
 	return 0;
 }
 
 static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	u16 val = ethtool_adv_to_mmd_eee_adv_t(eee->advertised);
+	u16 val = ethtool_adv_to_mmd_eee_adv_t(eee->advertised_u32);
 
 	tp->eee_en = eee->eee_enabled;
 	tp->eee_adv = val;
@@ -8973,9 +8973,9 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 	eee->eee_enabled = tp->eee_en;
 	eee->eee_active = !!(supported & adv & lp);
-	eee->supported = supported;
-	eee->advertised = tp->eee_adv;
-	eee->lp_advertised = lp;
+	eee->supported_u32 = supported;
+	eee->advertised_u32 = tp->eee_adv;
+	eee->lp_advertised_u32 = lp;
 
 	return 0;
 }
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 14549cb9e..89807c30f 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -223,9 +223,9 @@ __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
 struct ethtool_keee {
-	u32	supported;
-	u32	advertised;
-	u32	lp_advertised;
+	u32	supported_u32;
+	u32	advertised_u32;
+	u32	lp_advertised_u32;
 	u32	tx_lpi_timer;
 	bool	tx_lpi_enabled;
 	bool	eee_active;
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index ac9f694ff..ca56f2817 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -5,7 +5,7 @@
 #include "bitset.h"
 
 #define EEE_MODES_COUNT \
-	(sizeof_field(struct ethtool_keee, supported) * BITS_PER_BYTE)
+	(sizeof_field(struct ethtool_keee, supported_u32) * BITS_PER_BYTE)
 
 struct eee_req_info {
 	struct ethnl_req_info		base;
@@ -52,19 +52,19 @@ static int eee_reply_size(const struct ethnl_req_info *req_base,
 	int len = 0;
 	int ret;
 
-	BUILD_BUG_ON(sizeof(eee->advertised) * BITS_PER_BYTE !=
+	BUILD_BUG_ON(sizeof(eee->advertised_u32) * BITS_PER_BYTE !=
 		     EEE_MODES_COUNT);
-	BUILD_BUG_ON(sizeof(eee->lp_advertised) * BITS_PER_BYTE !=
+	BUILD_BUG_ON(sizeof(eee->lp_advertised_u32) * BITS_PER_BYTE !=
 		     EEE_MODES_COUNT);
 
 	/* MODES_OURS */
-	ret = ethnl_bitset32_size(&eee->advertised, &eee->supported,
+	ret = ethnl_bitset32_size(&eee->advertised_u32, &eee->supported_u32,
 				  EEE_MODES_COUNT, link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 	len += ret;
 	/* MODES_PEERS */
-	ret = ethnl_bitset32_size(&eee->lp_advertised, NULL,
+	ret = ethnl_bitset32_size(&eee->lp_advertised_u32, NULL,
 				  EEE_MODES_COUNT, link_mode_names, compact);
 	if (ret < 0)
 		return ret;
@@ -88,12 +88,12 @@ static int eee_fill_reply(struct sk_buff *skb,
 	int ret;
 
 	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_OURS,
-				 &eee->advertised, &eee->supported,
+				 &eee->advertised_u32, &eee->supported_u32,
 				 EEE_MODES_COUNT, link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_PEER,
-				 &eee->lp_advertised, NULL, EEE_MODES_COUNT,
+				 &eee->lp_advertised_u32, NULL, EEE_MODES_COUNT,
 				 link_mode_names, compact);
 	if (ret < 0)
 		return ret;
@@ -140,7 +140,7 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	ret = ethnl_update_bitset32(&eee.advertised, EEE_MODES_COUNT,
+	ret = ethnl_update_bitset32(&eee.advertised_u32, EEE_MODES_COUNT,
 				    tb[ETHTOOL_A_EEE_MODES_OURS],
 				    link_mode_names, info->extack, &mod);
 	if (ret < 0)
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 46c29b369..5b2ca72e3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1513,9 +1513,9 @@ static void eee_to_keee(struct ethtool_keee *keee,
 {
 	memset(keee, 0, sizeof(*keee));
 
-	keee->supported = eee->supported;
-	keee->advertised = eee->advertised;
-	keee->lp_advertised = eee->lp_advertised;
+	keee->supported_u32 = eee->supported;
+	keee->advertised_u32 = eee->advertised;
+	keee->lp_advertised_u32 = eee->lp_advertised;
 	keee->eee_active = eee->eee_active;
 	keee->eee_enabled = eee->eee_enabled;
 	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
@@ -1527,9 +1527,9 @@ static void keee_to_eee(struct ethtool_eee *eee,
 {
 	memset(eee, 0, sizeof(*eee));
 
-	eee->supported = keee->supported;
-	eee->advertised = keee->advertised;
-	eee->lp_advertised = keee->lp_advertised;
+	eee->supported = keee->supported_u32;
+	eee->advertised = keee->advertised_u32;
+	eee->lp_advertised = keee->lp_advertised_u32;
 	eee->eee_active = keee->eee_active;
 	eee->eee_enabled = keee->eee_enabled;
 	eee->tx_lpi_enabled = keee->tx_lpi_enabled;
-- 
2.43.0




