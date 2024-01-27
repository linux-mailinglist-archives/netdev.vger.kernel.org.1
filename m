Return-Path: <netdev+bounces-66402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75783ED51
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DC41F22BB6
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435DC25614;
	Sat, 27 Jan 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkmqmCMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746C25605
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362234; cv=none; b=o/uk+bQ27ryuT3qw1spv4NubH9Xsd8F17agTAcT8FRKv4/vpIYb9atdNgu7tms9jA0fssvxGuvRIGsBWRnbE0GSfLvGmDA8M8ln4uGzGtNdF+5qO3ejsoQmOXOJmphiT/Hl4r8wjKZX/1bZSACAPiZC6+/CEG7q5LPtqk+a/mEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362234; c=relaxed/simple;
	bh=SGmLWXWEGWXCBIDE+eR+eKT68F/34o8jNiMtEVoVA2g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lur2vgUCYl+FT78BVt562zcLBhh4rp0kOG5qaiLgV9oCXePdazRD5Jmt5Hn6Ps4U4s5nry41mO5FiW57c3BGhs+MmjoS+52DiQSNgoi6cntiayjD0QOIQbMo16KlYxTcixT3QxkDORB1CgOwpvr4hdskDXCtIQ0o53zb7VsW0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkmqmCMk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-339289fead2so1492332f8f.3
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706362230; x=1706967030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xtSfGo9u9jw+lqj+Fi9JK1J1aqcU4/dgIk3yxBFoTo0=;
        b=PkmqmCMkgwE3bSEwTtPSbMG6RDqMOaL3K8oy3EZXC2jLa6bOrCbHx02zBn/aV2kHFo
         /QricXER5vp3M98RkH+2EPzdyJQAC7efwRWPqJnFwLds47Se6AboRCI2R5mTINyr6jy5
         SofqgSm/zKKnG+6sxOaIUs5tR4+g/WMFBB6pBiiNFYwv8BANXaCZ0HjG4Fa1NCRJ8P/x
         tpUCxtFA13+xPl/4lEK1mqvZ+yJ3C+1fNxRYzXz5XELBHG7Wkm/pqysAhFbCYJ4PIOSi
         YIdbDu9QLMlK4LClWzv2Rlrv8ERK/g9baSCOCQSW5X0K+YZPTmhVxf709RpiJtszYCas
         rW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706362230; x=1706967030;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtSfGo9u9jw+lqj+Fi9JK1J1aqcU4/dgIk3yxBFoTo0=;
        b=GJVxQ4BoER6mARJJojyx34Xz+EpDfsBXWBXdNKbRTgzR9V6jr/Bn0dLThXxtmh8HAD
         CBB5OGBJqNW97ulVpGq5tWpQVlcVJGtJD4iZOGfowJsEFNNRO2gYYjmqtpxcUsJMKqiz
         ZrgL2IMEgW+Z4HRaJg2S2mXEtieDyAMqlqueeBovsdqvv/C3T0phYZJtBbABh4+M3F/2
         WGlVUk21qLQmT/5VhI7z1xIofLyJRTlDEU9+fiWyiucEBkpVc3ipTipAtMvHSLN5KYJu
         GwRwmDeYL0SwcOnkApAWQTGeNXdmwzeC9HPBv8yAR5kB6p/PBPK4QQMAsp1f6prXYIcv
         seow==
X-Gm-Message-State: AOJu0YwWgzdPReELvWL1Zf4e3veuWbBQSbWEzQB0r10hjppkmkoLLVcA
	ChqWvZKLGUo6yoLGnrC29Ui89POQfDNfBlSMedxLhTPeFvnKw+9R
X-Google-Smtp-Source: AGHT+IHTyRrVLeVir5IZU3oE2ohFtrEcr4tisV2rASfa6ERf/foQ05MUrO1BK2gy1cd2kSsYv3kpeA==
X-Received: by 2002:a5d:438e:0:b0:33a:e478:94a6 with SMTP id i14-20020a5d438e000000b0033ae47894a6mr686872wrq.31.1706362230359;
        Sat, 27 Jan 2024 05:30:30 -0800 (PST)
Received: from ?IPV6:2a01:c23:b938:5400:11ba:857c:4df8:38b0? (dynamic-2a01-0c23-b938-5400-11ba-857c-4df8-38b0.c23.pool.telefonica.de. [2a01:c23:b938:5400:11ba:857c:4df8:38b0])
        by smtp.googlemail.com with ESMTPSA id fa7-20020a05600c518700b0040ec6d7420csm8537514wmb.14.2024.01.27.05.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:30:30 -0800 (PST)
Message-ID: <5047dcc7-534c-4570-97d2-9ed4f4397406@gmail.com>
Date: Sat, 27 Jan 2024 14:30:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 6/6] net: phy: c45: change
 genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps
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

Change genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps.
This is a prerequisite for adding support for EEE modes beyond bit 31.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 99c84af25..46c87a903 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1453,7 +1453,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp) = {};
-	bool overflow = false, is_enabled;
+	bool is_enabled;
 	int ret;
 
 	ret = genphy_c45_eee_is_active(phydev, adv, lp, &is_enabled);
@@ -1462,17 +1462,9 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 
 	data->eee_enabled = is_enabled;
 	data->eee_active = ret;
-
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->supported_u32,
-						     phydev->supported_eee))
-		overflow = true;
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->advertised_u32, adv))
-		overflow = true;
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->lp_advertised_u32, lp))
-		overflow = true;
-
-	if (overflow)
-		phydev_warn(phydev, "Not all supported or advertised EEE link modes were passed to the user space\n");
+	linkmode_copy(data->supported, phydev->supported_eee);
+	linkmode_copy(data->advertised, adv);
+	linkmode_copy(data->lp_advertised, lp);
 
 	return 0;
 }
@@ -1495,24 +1487,22 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	int ret;
 
 	if (data->eee_enabled) {
-		if (data->advertised_u32) {
-			__ETHTOOL_DECLARE_LINK_MODE_MASK(adv);
+		unsigned long *adv = data->advertised;
 
-			ethtool_convert_legacy_u32_to_link_mode(adv,
-								data->advertised_u32);
-			linkmode_andnot(adv, adv, phydev->supported_eee);
-			if (!linkmode_empty(adv)) {
+		if (!linkmode_empty(adv)) {
+			__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
+			bool unsupp;
+
+			unsupp = linkmode_andnot(tmp, adv, phydev->supported_eee);
+			if (unsupp) {
 				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
 				return -EINVAL;
 			}
-
-			ethtool_convert_legacy_u32_to_link_mode(phydev->advertising_eee,
-								data->advertised_u32);
 		} else {
-			linkmode_copy(phydev->advertising_eee,
-				      phydev->supported_eee);
+			adv = phydev->supported_eee;
 		}
 
+		linkmode_copy(phydev->advertising_eee, adv);
 		phydev->eee_enabled = true;
 	} else {
 		phydev->eee_enabled = false;
-- 
2.43.0




