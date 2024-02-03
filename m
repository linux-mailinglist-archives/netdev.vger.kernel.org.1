Return-Path: <netdev+bounces-68862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE558488E3
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518041C21491
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9611739;
	Sat,  3 Feb 2024 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2Dzqvpb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558C12B61
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706994775; cv=none; b=hf/6HFKXc+QnhN7O32MhAVcTIK7eNJiSxYBaRXtND0S+ZvZGxYc1c+/w1THThL4mxfZMx6tKs3am69OQw6n3coFgSExSWcV4VUStlYQD3B9k2PbLxsOr9MqKDp+GYKiVUXwqoeT2rE9ODvifY4LW93hJXgs8DJAfecijTvZ5HZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706994775; c=relaxed/simple;
	bh=0w6mEGpD3e4Hs2IMH21twJWagPIkhPFv64L2xHmQ9Ok=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UqnyNjQpMdO0WqoHOzJBhpcpqcPXJ0/ZoUL5IqBGRUmfuAHpHOE4U2LRnZWPmKwxbP6bxOoRlt81SBXAcEHwJ42AIdMFwtnpx6MwGIoSd48Tlt9N775k8t7Gs69nznejojsDt2MPo9fxsR20Yh6bSTESBZM2VmL3xH+uSUVfrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2Dzqvpb; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51142b5b76dso1380944e87.2
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 13:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706994771; x=1707599571; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxF9u4aP5ltJPUJ2rDWrzM7evqM4uATcpm0TzxAvUyM=;
        b=f2DzqvpbAtDms2zGsuawp0+OVk/mRXYOjbrhcAgMohtPEGta+Cu2p3WG6l+zb4F32b
         02JX2GBlFsytONIogniXTpSK40R+vtaQYYSotuntybyp4Cmt+QY7Myl48qFowwvDhxqq
         XM7LeQBWNIk1fqU7947BvkTbCmnEcufcL+sWPq6qIJUQoFkSgIHsNlfyj4dSlKeyR9Xk
         IY8wdstqwPwrnBkyENzsB3KAf4/8f8A7juoj86kcUZdxZ84WmxZFqLT5GxrZRkapg8bm
         IXWw9ZpJ5QRC53AKlsZ54CzYp+gAlDdyQC8gooEFkQRNKAaaiHkyAjx0sGrPPtJ7Ec8z
         GNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706994771; x=1707599571;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxF9u4aP5ltJPUJ2rDWrzM7evqM4uATcpm0TzxAvUyM=;
        b=FW/EPteZO7YZKv+h5tgutwYlYzvkH3oqkd5l6P9BnphzLRJ+yEubOjj6MOj3/AC3Cx
         L/r/pNO39qhXvlmHP1+yqpnP0eFvJEklnacp7I8/oDLTJXDWwfaDNd8y6o7c3514QDZg
         jSYI2mm45PoW5+ymITczKvJd2F6Bqea+gTDMH8smG3EEwNHAiOF9gkrzEbSqfqUDFquI
         TTxVthtBZLf4WAeyfefFqvvmhCQM/nkA2O/A95KnYEuWB9RzAv/GrfgJHeuWpwjSN4iI
         olFmR/l1sUxp/OMAkvxxAlgUn0HDL4OuF1u9wmqR3j/KSOBm2KlrNZufrRXUV3EHoXTg
         VKyQ==
X-Gm-Message-State: AOJu0Yw2zVsmZefV8AS353oWh9H94vrtSjcFKyMNOFghTa4xTjGzY9dK
	tsorcEIQnGa2qjyJoazY75tO7ikDvIylsUTgSzzcTKSF38Ad9jMP
X-Google-Smtp-Source: AGHT+IFFZuQ4Q89EutW5OxDzgyNSxIGTBsxuEOh37tnwsW4YdL8MzYZRCuGPkj/Frn1GcmUTlpy0sg==
X-Received: by 2002:ac2:5f55:0:b0:511:35f0:559b with SMTP id 21-20020ac25f55000000b0051135f0559bmr3170772lfz.14.1706994771106;
        Sat, 03 Feb 2024 13:12:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV0enukE6jn4sABI5InTmEo7p0VHLheraZODnX26MkzTsDMG5CTK+fYdYzZzpfKTd7czCLCwqEi6PGBiErUAZW++YECrxalJVt2SoudsfZPqi9ImeZUZXVzehw/jiBX1/e5UwVN0vsj2AJvSzK/JAwZwwBekUP0qML+r3BxiOCUJaDLN16EvcB2JXhL7i57AF0zAQnkbjFTUocBGWmJMfpnRWa4IjmFB52uGX7ampKkoSl5eYhVvcs=
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id s12-20020a170906454c00b00a360eb62afdsm2379614ejq.32.2024.02.03.13.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 13:12:50 -0800 (PST)
Message-ID: <0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com>
Date: Sat, 3 Feb 2024 22:12:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] tg3: convert EEE handling to use linkmode bitmaps
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert EEE handling to use linkmode bitmaps. This prepares for
removing the legacy bitmaps from struct ethtool_keee.
No functional change intended.

Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
the current functionality.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index f644a9131..50f674031 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -2362,13 +2362,13 @@ static void tg3_eee_pull_config(struct tg3 *tp, struct ethtool_keee *eee)
 	/* Pull lp advertised settings */
 	if (tg3_phy_cl45_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE, &val))
 		return;
-	dest->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(dest->lp_advertised, val);
 
 	/* Pull advertised and eee_enabled settings */
 	if (tg3_phy_cl45_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV, &val))
 		return;
 	dest->eee_enabled = !!val;
-	dest->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(dest->advertised, val);
 
 	/* Pull tx_lpi_enabled */
 	val = tr32(TG3_CPMU_EEE_MODE);
@@ -4364,11 +4364,9 @@ static int tg3_phy_autoneg_cfg(struct tg3 *tp, u32 advertise, u32 flowctrl)
 
 		if (!tp->eee.eee_enabled) {
 			val = 0;
-			tp->eee.advertised_u32 = 0;
+			linkmode_zero(tp->eee.advertised);
 		} else {
-			tp->eee.advertised_u32 = advertise &
-					     (ADVERTISED_100baseT_Full |
-					      ADVERTISED_1000baseT_Full);
+			mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val);
 		}
 
 		err = tg3_phy_cl45_write(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV, val);
@@ -4626,13 +4624,13 @@ static bool tg3_phy_eee_config_ok(struct tg3 *tp)
 	tg3_eee_pull_config(tp, &eee);
 
 	if (tp->eee.eee_enabled) {
-		if (tp->eee.advertised_u32 != eee.advertised_u32 ||
+		if (!linkmode_equal(tp->eee.advertised, eee.advertised) ||
 		    tp->eee.tx_lpi_timer != eee.tx_lpi_timer ||
 		    tp->eee.tx_lpi_enabled != eee.tx_lpi_enabled)
 			return false;
 	} else {
 		/* EEE is disabled but we're advertising */
-		if (eee.advertised_u32)
+		if (!linkmode_empty(eee.advertised))
 			return false;
 	}
 
@@ -14189,7 +14187,7 @@ static int tg3_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 	}
 
-	if (edata->advertised_u32 != tp->eee.advertised_u32) {
+	if (!linkmode_equal(edata->advertised, tp->eee.advertised)) {
 		netdev_warn(tp->dev,
 			    "Direct manipulation of EEE advertisement is not supported\n");
 		return -EINVAL;
@@ -15655,10 +15653,13 @@ static int tg3_phy_probe(struct tg3 *tp)
 	      tg3_chip_rev_id(tp) != CHIPREV_ID_57765_A0))) {
 		tp->phy_flags |= TG3_PHYFLG_EEE_CAP;
 
-		tp->eee.supported_u32 = SUPPORTED_100baseT_Full |
-					SUPPORTED_1000baseT_Full;
-		tp->eee.advertised_u32 = ADVERTISED_100baseT_Full |
-					 ADVERTISED_1000baseT_Full;
+		linkmode_zero(tp->eee.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 tp->eee.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 tp->eee.supported);
+		linkmode_copy(tp->eee.advertised, tp->eee.supported);
+
 		tp->eee.eee_enabled = 1;
 		tp->eee.tx_lpi_enabled = 1;
 		tp->eee.tx_lpi_timer = TG3_CPMU_DBTMR1_LNKIDLE_2047US;
-- 
2.43.0


