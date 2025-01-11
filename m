Return-Path: <netdev+bounces-157459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBABA0A5EB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904FE1888AC7
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC01B6544;
	Sat, 11 Jan 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+UMAM35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012D24B225
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627447; cv=none; b=KoPWRB6q/n82Gdb6POaADvfuD8cubcUczaxRc+2CmeD4sb5ytZnyIF++dzKXg5bQcJoW5IrNpDReFN1G7g350OnRQ6xk3ST17AlRuia4cycrblizZBPKG5G/6dNhyNk2Mrd/3p3nGmUvC/cZ3MqYOJoUncS1sLLpRn4K4boWK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627447; c=relaxed/simple;
	bh=E3x2OQoXJqKkDTmlqFVNtpZpLpsrweRHWHwI3zrKpyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VZplAqNHMvvxiAKtNTXw/YYadHYDVnRQTLcW15qIYx/4hg9ZU7IQ7Jjsb3P4eiDUTZhJsHwSXWdHV6fOy24C3oe5h4if0oMBOx2tcNCS2e5OuKVr0a+8GKsR+Jy7fw+jBc6LLiKA7SSuYx3CSMuCVmKQ3JeYrS/Rmj9Qv+HKJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+UMAM35; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso405239666b.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627444; x=1737232244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TeDwEnVCu9enUYBZi4CcsChMzu7xhWaZb2+Ok1gyBZ4=;
        b=N+UMAM35fNzApYKsJ6XLUjwoJmeRXSyStTNKC4XZiaxsXg4AKT5+lWmZD6dFoReUS4
         OTw17pnCH15tU8WBZLnKSxemt5Nb2KkaBNic16EjX+Bkw5tAylejrIQlppLl83YwR20G
         dlGEFTl6gwRgyIJ6ikfA9yFNqbiB+a7giL5C1PdiGYbtbPf+VLCU/2IzKuyaHMWGEeM5
         /bRUr90KI1/WEziblU0u6ujPx/XvFcSKMUOBXum1fsCLNUDAnYppawsFFCyZU8IZOhvP
         VGGABlWlKgYHSx36vzvwWYCeruWRpiioGsRzr+AG0Fv0W+01bU4a6xpW51e4pPbW4diM
         wMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627444; x=1737232244;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeDwEnVCu9enUYBZi4CcsChMzu7xhWaZb2+Ok1gyBZ4=;
        b=BhvZGC7HT7r2COHex/u3SQwUVGoRMGgv44uIxA6qtUHGYPy3ZdjZdhBDFvlt+ZSqf8
         DaaeJJXyjV5CLlrP7K0T1pc0h0yT9hR83YNO4ZH42GnWlVxNeBV9cHWRFZg7D5dKyeuN
         g7cSPzwOKF0tExnnQr05jiKYJNRMmE+1SWU+sqCKzQyYct9NvHd+CCM/XE5ovUdhcn0X
         0+XntHs74MRPs/KCZ7l61X7twnp2BKizvn5d/sTopuLhfOAfWX+Iel1+0sTXJmmmNIB9
         81wDaCCEgR/XlFgveLDF1fC/f6aQbuvqDDCyhO1R0pBIeHji9nnkCmzjnKC7OmHRXOep
         FDwA==
X-Gm-Message-State: AOJu0YyqeQEVITTujkXBh0N4FdrjSJw72oIUzvvnGCsUatYgjxNEMgWC
	kNIRsRCTsJ/pfLnBwrk87/DU7rG488Ho/bkyI59lgmOdh5bufvpG
X-Gm-Gg: ASbGncuMy5XX0ocNAhRMgH6wb4hmasCVLuovhTSKrEBkPDwDBEqxexO2IgmPEtiLrRE
	g4rTIU5wbkvyzKv8zZhN/1khENnHmOgbSFaOxw/8s7se1jZtNI6Ep/owBOcfMRmWuvbFP3BhpUo
	/KJWwlTKgH/k2mmKJCbdbQRj124FPQKCZYAev5jfSU734XCh2kYF8KZ+wv9+G3lFAiJqsFwTUqK
	7Rh4UadTccD0kK8B3+Od8C6yMMgXb2T5Rpm/Wl3CDhSnIE7zTrjrkR3hRfF+9mUrp8cocVhRd4L
	KwfK5dGqkZSH5I7ExqW7WBbQL6BL5yEri7zWuViP8DSECAjjaagPRIWZtmDkAiuxBS7JwW3oz4a
	9es6wtEgcHw9eDow0RhOlB1ALZJvtfY/BYyL2aI+ab6w1meIX
X-Google-Smtp-Source: AGHT+IGyPTQFWkhyZFGaBrS35OUQhleg8ZalhjBubdV5BHhXYY9sxEfRe79KkcwoYzjYzAtcQ8aYzg==
X-Received: by 2002:a17:906:6a15:b0:aa6:a8da:7ba3 with SMTP id a640c23a62f3a-ab2ab5f533emr1643759666b.27.1736627444000;
        Sat, 11 Jan 2025 12:30:44 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c90dace5sm308591066b.60.2025.01.11.12.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:30:42 -0800 (PST)
Message-ID: <80c86da0-80c8-4d1b-91d7-3d31e3c38bb2@gmail.com>
Date: Sat, 11 Jan 2025 21:30:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 07/10] net: phy: remove disabled EEE modes from
 advertising in phy_probe
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A PHY driver may populate eee_disabled_modes in its probe or get_features
callback, therefore filter the EEE advertisement read from the PHY.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f6a5f986f..ff4b4d42b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3613,22 +3613,21 @@ static int phy_probe(struct device *dev)
 	if (err)
 		goto out;
 
-	/* There is no "enabled" flag. If PHY is advertising, assume it is
-	 * kind of enabled.
-	 */
-	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
+	/* Get the EEE modes we want to prohibit. */
+	of_set_phy_eee_broken(phydev);
 
 	/* Some PHYs may advertise, by default, not support EEE modes. So,
-	 * we need to clean them.
+	 * we need to clean them. In addition remove all disabled EEE modes.
 	 */
-	if (phydev->eee_cfg.eee_enabled)
-		linkmode_and(phydev->advertising_eee, phydev->supported_eee,
-			     phydev->advertising_eee);
+	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
+		     phydev->advertising_eee);
+	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
+			phydev->eee_disabled_modes);
 
-	/* Get the EEE modes we want to prohibit. We will ask
-	 * the PHY stop advertising these mode later on
+	/* There is no "enabled" flag. If PHY is advertising, assume it is
+	 * kind of enabled.
 	 */
-	of_set_phy_eee_broken(phydev);
+	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
 
 	/* Get master/slave strap overrides */
 	of_set_phy_timing_role(phydev);
-- 
2.47.1



