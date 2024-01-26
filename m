Return-Path: <netdev+bounces-66292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD683E51E
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03953B23DFD
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE45286B7;
	Fri, 26 Jan 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0Qvd8In"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE453E1D
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307469; cv=none; b=h8wQC8OGciyt1itsSy5XjrCYccUIy433tYCOlTB9a1fbPQwuUraDX6efMTDNYYXUDUi6skzcxhHxE9J1LrYpHb3JUYuuf8SOg3Yq1C+tgLtNcTMs2phuLEm+ro4aF6WTHSNymlcSfTr1t5l/EoSdm3D0rQne9pWlVPIhVYKwKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307469; c=relaxed/simple;
	bh=SGmLWXWEGWXCBIDE+eR+eKT68F/34o8jNiMtEVoVA2g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SH2h52F4F1eF3cir3pYmPurzaR9FZAf+w4S2/s5/HdGIBYswPNaRY42GvskAFYjbdSK9TdpJCbQBSlIiBXC5CUMRNZTZYjakvpfI/gwt/qfi7Lf6Kzuejz8GAS4AZbTZMouVlvS474PxaFE9R7YLVFVTt9W/oemEfZcweiL/Juk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0Qvd8In; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30359b97a8so96018466b.0
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 14:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706307466; x=1706912266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xtSfGo9u9jw+lqj+Fi9JK1J1aqcU4/dgIk3yxBFoTo0=;
        b=K0Qvd8InUd1uJiY57oGkGipc0ypDlfu0nGH5LgsCQaM4EPgUaJQa0WzukAtii0QkKd
         AeAvmNDesr8Ziasi6XsKCwfHz3EshmdVfBmy4fj8utMp3qrs8lVN5Gr8tl4g3Kil7Wmd
         gEGR1UII6KyhZSKOzAzGOnhmAV61GVANy9Gvjd8u9fxNaHQUHhMWOLoH+JDwbb9FhmQp
         myA2hvaD7O+F044RZK09MCpoMF1w9SoIuED3wf2V1lFjlTHDTCCGry44XSG8em4/S49m
         N4e3R4Q+he0wpTmO7dUjp3ifTs86zpahOQStYaUzOlVf4gdYzfLTmphdm5/CDhQDxx3V
         y7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307466; x=1706912266;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtSfGo9u9jw+lqj+Fi9JK1J1aqcU4/dgIk3yxBFoTo0=;
        b=sCUi/ZbJ6iuXcV3mSXrmN3YH5ahd3D35TJa3fozOmCgFLMXcIFshNZmNjynYs20mTo
         m7hsXPMNXx2nMEjAz91WcgyUkbFS0yymnulMHGwDJIKRVfX/F5pgT7sXgtfAcm6HDyjX
         RrkUFpnvO+AsKTo5IZFms31a4VEvSdaqiOyTpOKFe8sK2Nubt/BEAfdVNNapuVEW/UIk
         ighQnBwN90zbTbjU9TYFDI/oP5IBdyflD3wcJ5kbgjIhRrdubBCB65lpkfD8GGTOK+bW
         ddLibAPHaBaq0hUgZRQndtaNEfl4CYQxrPUmpgeZXvJ4TA58OnyhoGBRql2o2zW9XbTQ
         /3Kg==
X-Gm-Message-State: AOJu0YyZXXBAD0gtUduxFZ1ADQDF3YVFlCyCbKAWTYrLLIrR/zXdAKt0
	ppMKw0q4fIxF4mrGmM5h3Efwy2SwJu+A81jRvtep//cBNSOaYDvl
X-Google-Smtp-Source: AGHT+IHuOt0e9/bHnd8d3I07apjrJAC/5fjCbHP+IoRTO7GdhQDoS5SZ7dnCM8JKeuUYB7doW4HWRw==
X-Received: by 2002:a17:907:9858:b0:a35:360f:ae69 with SMTP id jj24-20020a170907985800b00a35360fae69mr64654ejc.54.1706307465697;
        Fri, 26 Jan 2024 14:17:45 -0800 (PST)
Received: from ?IPV6:2a01:c23:b936:a00:2153:65f5:37dd:e726? (dynamic-2a01-0c23-b936-0a00-2153-65f5-37dd-e726.c23.pool.telefonica.de. [2a01:c23:b936:a00:2153:65f5:37dd:e726])
        by smtp.googlemail.com with ESMTPSA id qc10-20020a170906d8aa00b00a34a47ca2b2sm1047973ejb.85.2024.01.26.14.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:17:45 -0800 (PST)
Message-ID: <6a7bb313-ebd3-4acf-91be-bca1f3ba50aa@gmail.com>
Date: Fri, 26 Jan 2024 23:17:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 6/6] net: phy: c45: change
 genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
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



