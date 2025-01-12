Return-Path: <netdev+bounces-157535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19DDA0A98E
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77F616648F
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA7F1B4C35;
	Sun, 12 Jan 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QagdziYD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D01B393D
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688726; cv=none; b=udKhmm2KunDBcf4t2YqYB2C/JqdF2NXbNTOf6oG9ZlvKWRwalCehx7Bv3oSweVOTQAJbJ9owI+0R4Jv7I9A5N2BOmmDGYvbgBs/sjb9BxbSyN0TaHfApYYU4HGOOzEeHszfmNnWSZ98ECd1yyRIlA/7dSy0Si8eq62OItV8yJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688726; c=relaxed/simple;
	bh=E3x2OQoXJqKkDTmlqFVNtpZpLpsrweRHWHwI3zrKpyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZSFLJXksmO+hhmXx53N7hb3wfMiuhJQyidBfkAE5YxTKW75+liMjjz1mRLLHYvwrrMtGkaTlnQbNqjnkw7fLVV23TMJGy7jwdwRpMgZ2P7rWYWUq+QnleXEEBxpO4SVNviBDTdo8pYp3z1nUkk8Rnn1u48vhAtaTOsWiux2JLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QagdziYD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a8b35e168so2110991f8f.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688724; x=1737293524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TeDwEnVCu9enUYBZi4CcsChMzu7xhWaZb2+Ok1gyBZ4=;
        b=QagdziYDtghF00miYu/fNwdYeDz2itLFRg+kK0LwxzouNoaisY1ngdB/ZFBM6dmq4A
         9I4SKGbm8jRv7uJ1VCbSjpWTBqL7ZFdxPnT3AueuTrZvF8NmfP66SMd+p183fxl+MwRv
         ai1qNNfa5gSzEDTb1uQqlogaeiCwCzGDk40L/AfBDXb7Q0r1yhC8/5BOFgREbRWYLu8s
         tJU31gPScchC9vSKLEfY537zvBOpSxv1KT8aNa2PJTFL5k3Zud/kOcuZKyFUKsexIlOe
         ZL4P2wU/A9XPjbSuU3MKHcva8s+r7i0nDN6bob8JXFVAZ8UmHjWlC3NU7Yj8n0GxQqG2
         Nh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688724; x=1737293524;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeDwEnVCu9enUYBZi4CcsChMzu7xhWaZb2+Ok1gyBZ4=;
        b=LmQGBrdYHalv7xCJ05kqHeg0jGypLF+Dd3m7wuut36aeW9MiwGWtvCNKkk1rchptXT
         1WxICnF498bNSn6ooTKwoMjqa0Ob941OsPWNFE66EIWpcwGHRNLHxSyf3NxkQCwQdEr8
         PmZC6VT4o8/W3gFnP4Z9hdGEKCVX3mYTX5Ro2nrkSkwm6vBntTfGiXG8pzXKDZsW2Eg1
         U1gzDpcG4yeKpMuAdoQ7jkoqwkoypmJfIJlzL8vaIXSlvUxnkBDewTMBWru7+Q78Zu6V
         xJKnZkxwcdBf5FecLpl5/OSQo4nPTq02zP+BdJ3Soha/v0jwRNA2d8L3d0S3idF12tH6
         iSXQ==
X-Gm-Message-State: AOJu0Yz/gTpXE7bDIRVESosFkwvnXqwXhxvoQ2SpJe9mNxI92nk9r04T
	jPEkgKxRiHOqbatQbbW7WmEuCO0CUiJaUFt0UMwvBG/ACkY2dyrT
X-Gm-Gg: ASbGncv483UbdtOSH13/oHPgiGPt6bNJkzs65bjZResniw6tC5kACeUOw3oO52zEgQS
	TJj11TtHQY8RI/q206B31dmUzy27VwKXXPtn0Vijtux3TbgnUGs0mMu1PafF0R+Nc1P4lyvKdEr
	EO2ouh0neGqPfSqE3VtqsBSL7s9zXZJFXEW5QCM8GempxElqPSTSOCGgYI5v4Z+MmzWiBh+Ojrd
	Va5mCyHgMt5M89G4YW6VE+/jdfY5LiUcTko3RlEl85VuuSRSd6bFaCCdalIdvjn8xBJgkDrc+0s
	K92+NOoNXw0gSK05RkNLwNm0Tud7C+W+3aVnmg3QoiN/5fofQ3BlCRdzfgbfkCzPV33EQ6Tnhy9
	hfEW7h3Qv3A2m/sYRieITmKIqcIyNC/IAjBpd4Hu8YJpBQR8p
X-Google-Smtp-Source: AGHT+IHG+PFtOBbqIBQ97cgSygKA4gDTWX0Lo0FQ6oTgDXfoCS1cjoOrqsS0erF+70zSQan849rteQ==
X-Received: by 2002:a05:6000:1787:b0:38a:5dc4:6dcd with SMTP id ffacd0b85a97d-38a8b0f2ba7mr11450501f8f.22.1736688723600;
        Sun, 12 Jan 2025 05:32:03 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e37d154sm9887118f8f.10.2025.01.12.05.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:32:02 -0800 (PST)
Message-ID: <0d395441-a42f-442d-97e0-33b8d9757a23@gmail.com>
Date: Sun, 12 Jan 2025 14:32:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 07/10] net: phy: remove disabled EEE modes from
 advertising in phy_probe
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



