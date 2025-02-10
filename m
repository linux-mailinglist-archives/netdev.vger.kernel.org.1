Return-Path: <netdev+bounces-164923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74FA2FB09
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668101640CC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B61C2317;
	Mon, 10 Feb 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGGddyu/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE31BD4E4
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220538; cv=none; b=efovxLC6koEW3TNEbFUr8LPMiqVZIhg+MI9Jbd+ea74uOUhsCFYiI8sGnAg2rJTKi1VoQim7DP88AwB8uQnr03BdC2NXG+heQOv0poz4SjqDZsZ5JhI2PkhLiFR0V8Z+M0yADLtrn0XE9fie40den8Wr0EVoGERBom0gVDXjAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220538; c=relaxed/simple;
	bh=TvoAPStNV1o2B9YQXaI546kqIbf0KASbAlU212gi/e8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nHxnXmEtgvs/CVg7jLLLLxsbJk9nmGQi4665gN5ytBXTJFhnrYi80I7z+0gyiG5r0cdD7Ix5g9fq9lBRkPMV/fU3gHdr2yR0gTLFgNAIjqNrfMYlcQ8LtIPP6qUdpoplzfDHeclg9VQYFa/amhmr+jNFWca4btzEIQ5JtTDkZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGGddyu/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab78bcb4b19so620397366b.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739220535; x=1739825335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jWF0yWxLmlpZBsu3EsbvYtb0lDiV3zwMPuu7SS/MLOw=;
        b=HGGddyu/tpaqIRNB1WTFNFZJ6cl4oGrG4mmZ16SwXQCN2d5yixbiIq1wYryuCtnWHE
         dVDu8DBtnZHlL17jNKtGbyXneXkCth70HNV0EX0hLu4MMCyrbHxOycwP5Rtvx0Q3dsCm
         XrpJjZq15qv9zAzDfJpyhFO16bk5QVBoRw4UCMXQWT3QqF4Xo8BWtAecYtZGSYOk3rH7
         QJyDbz80wUVCQK1cCwT40AXvCAUlzV6huOyiIT4Og1IHJsPgIMXaO2rKP4xDuW2LAsY0
         M5oUtxbmvzOBsvnCEyxYH7AkuJwFbuhkvsmsSjBc5LHvneidYcsX4w1QizEzDY/vJSD0
         tPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220535; x=1739825335;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWF0yWxLmlpZBsu3EsbvYtb0lDiV3zwMPuu7SS/MLOw=;
        b=QlcYEMtlqsAd0dUiF7hxv0TuQtjW8HClQF/1hHmi8bNJ1el5xbXVYVrImMfILYX1NH
         hTI0AuneydU9+J9SNp2grQg8km/YOIu2k06FPBmHEel6WjFtDCv519lDFz2NCSnuVUk4
         1jEEiFD+mtbCYT98KBaxAM8K1zvM599mCuDDlyKTw2wwv2DP2M+qFXCAYKfpcYSgOoMe
         W0CP2XiAFuHh3W5UpJa8NZ5KOxsSBR2UuMaEODQloDLmD+/gjvyLNxEf//s3OHlPRt2s
         PEmmwoTOu4vzBqGqi/tEcPAE2xDXfC9btHJ+UMVXyz/8dsiAE5hxGMV8RPwnhQwxZb92
         mEEw==
X-Gm-Message-State: AOJu0YwXecXvl5d0Sh/xD9Ztis6TudoiLjHUushASkpu6hcTplg6JXDG
	pu34Lz9MfFXridxtPDlR0egtKXq8pJ/fRQgic46z1Q7gmQSsVqh0
X-Gm-Gg: ASbGnctBNyJi1hF3K83+PPHcAjSUWZlDWdEy1bTNLGg+7JGsVdXbBKT9wjNyYoScaRN
	NfeYM+5x3wrVuQYMCcZAmdIDCFd/GoTmtNER7iI/a6idXoVePvHnaXW3e0RAvrGRMbNeOLoKe6q
	0MQB2/HLorma60ElA0lRw1wbJhLQ/SZRqqHDHspfVeg0nWWWk0+Nkb/SeESLTNqtXzZwKaFTw+m
	J3azi7AlHWi5ZOixkXEAWPJ4gRJR+wMZDZLCIYWczrLTb2eDyReXTGTP4XP8CeTEO7734SMlQL4
	62EVysbarPV5uzLQQQJ2bETwNkWWdUjS3+Jy7NhsBglq/bS5JMx4jOK2xfwvHFauPI+tiBx4/jy
	ES2eKULU4yj1zLFAHuJdRmXBIkcAiUuFinRlh+O45ac7J9cZHS5KIXK09xyedYJJeTSYeRb0zqg
	40im3f
X-Google-Smtp-Source: AGHT+IEMksoxQ5xDn88naq0Dc1Ou3RfcHPVnofKBOukQMBjuLIBWhfRetPr84JOOmA5A82PemEsnfA==
X-Received: by 2002:a17:907:3fa9:b0:ab7:a237:2791 with SMTP id a640c23a62f3a-ab7a237293cmr1060550066b.30.1739220534959;
        Mon, 10 Feb 2025 12:48:54 -0800 (PST)
Received: from ?IPV6:2a02:3100:af5b:5100:3572:f08a:34f2:f31? (dynamic-2a02-3100-af5b-5100-3572-f08a-34f2-0f31.310.pool.telefonica.de. [2a02:3100:af5b:5100:3572:f08a:34f2:f31])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab7db5ef658sm28229666b.42.2025.02.10.12.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 12:48:53 -0800 (PST)
Message-ID: <6cd11422-dd67-4c87-a642-308de694af92@gmail.com>
Date: Mon, 10 Feb 2025 21:49:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: phy: rename eee_broken_modes to
 eee_disabled_modes
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
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
index f181f05cb..2fd1d153a 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -406,7 +406,7 @@ void of_set_phy_supported(struct phy_device *phydev)
 void of_set_phy_eee_broken(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-	unsigned long *modes = phydev->eee_broken_modes;
+	unsigned long *modes = phydev->eee_disabled_modes;
 
 	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
 		return;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 46713d274..9b06ba92f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2966,7 +2966,7 @@ void phy_disable_eee(struct phy_device *phydev)
 	phydev->eee_cfg.tx_lpi_enabled = false;
 	phydev->eee_cfg.eee_enabled = false;
 	/* don't let userspace re-enable EEE advertisement */
-	linkmode_fill(phydev->eee_broken_modes);
+	linkmode_fill(phydev->eee_disabled_modes);
 }
 EXPORT_SYMBOL_GPL(phy_disable_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71..dbc7e7245 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -611,7 +611,7 @@ struct macsec_ops;
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
- * @eee_broken_modes: Energy efficient ethernet modes which should be prohibited
+ * @eee_disabled_modes: Energy efficient ethernet modes not to be advertised
  * @autoneg: Flag autoneg being used
  * @rate_matching: Current rate matching mode
  * @link: Current link state
@@ -727,7 +727,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
 	/* Energy efficient ethernet modes which should be prohibited */
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
 	bool enable_tx_lpi;
 	bool eee_active;
 	struct eee_config eee_cfg;
@@ -1353,7 +1353,7 @@ int phy_speed_down_core(struct phy_device *phydev);
  */
 static inline void phy_set_eee_broken(struct phy_device *phydev, u32 link_mode)
 {
-	linkmode_set_bit(link_mode, phydev->eee_broken_modes);
+	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
 
 /**
-- 
2.48.1



