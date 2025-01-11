Return-Path: <netdev+bounces-157393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5C5A0A224
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5793F188C879
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC060186615;
	Sat, 11 Jan 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDAXr1DI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037BB24B22C
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586540; cv=none; b=SkIaRE4P25ybGu3WC2I6pqKkj/GC2vGBuuibk6URJYZ4AGbGnm8KJxCZ81v/4Kk1xcdJpR3R2OoGZkw0b7KQZXCWf70aZcI6yUUpIWqHgmp7W0alrW4Xc4YYEoq37DR6e7UQrZRNLQpxh8ecfxdNMpI524TyPPT+y4CEun8ncSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586540; c=relaxed/simple;
	bh=E3x2OQoXJqKkDTmlqFVNtpZpLpsrweRHWHwI3zrKpyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uk9/6kCig9UNmE6sT8/5/zMgDmzoVk0EvWT91LyotjsklN0NmDVMD5m7CGNjr6B+B+WTzaqTAyGGD4UOhJ/V/p/3nsbcKRHsBvnz/cYXJToOB6TnHnoofpPRbpqAzKjz3fyQk1GSiI3GhVPHWz8E1r58x6+rXpBWVn0kRNENCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDAXr1DI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso540520466b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586537; x=1737191337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TeDwEnVCu9enUYBZi4CcsChMzu7xhWaZb2+Ok1gyBZ4=;
        b=KDAXr1DIVjM8cvcy2lYrQtTslVn0ts7/lDi9IJkGhqeMphdY4o17J4gK4VMrhpI0zx
         cWBMT7jYheSAzP5WdRVz+W8K9gJNnKdLbRWvx6bjSCL+ymWrQw5I02DbpibofqKilLnG
         7FcTbGVCvF5i+UycN8UHbG20Tw2PptcqiUAIXP3w4Guhco5J4HOoWpuJe3oWnFF8BQmK
         ADygnnhz+86FM8yZ027M3milPmoSQYRHt4TX/71NaYXhsj74Bo8RQcJ/reIL0miid6fA
         3OXDbL1ieUtLhIikdgl5vXZ32VkOfEYKXWBPTr/Jo4FyZhwcC7L59vkvceVPswqZmWHi
         S1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586537; x=1737191337;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeDwEnVCu9enUYBZi4CcsChMzu7xhWaZb2+Ok1gyBZ4=;
        b=WAaIa/cUKADr/7MTMw1ZjioDvuPJBBpeia/EwCCm5RovYnPGcgYj5Jjh9CaKmJ5JdP
         P44mLADy0nsV3qG95txlFaN0FATgCGB5fn5ja17dlEjXO18/31j/ZguBBEU1sgeK7H7I
         I8h8vKwlJ+iGYtVAurorSfdfc4aGHvUnFcw0zFEku4z3/E2shOt2TIyL3jUBFfiP0h/z
         2xiSUjD4k1iIGX9IpDt6TAmujUL4D6ohvDk5gi9T2Qimeyy1vpt7NUr9/Yar0w0V1bvK
         hLkA2W+hhOSOPSzcoDIHw/oMAIGvDFvFILUGmYR5ay8WSXZyI/kzxgGfxO5fckCOL54d
         ZRWg==
X-Gm-Message-State: AOJu0Yyh9vGPAjqLrhmHLWS0T6/M+jNYfrirqcz5PBsm1GpWvCKXw4us
	ahu1Chamjg7UbwJuCLEtrqGScz4OqlQf9mFeKVvOyB21i/l13Uka
X-Gm-Gg: ASbGncubt++n7EKlFnPYW0iqdXBXiMAN1C68+qKHPGIHvqZcq1bWqeRUMwsjeBaTLY7
	x+QWft3lM5t25qFVRUggxdlgK6An30v9fC1WRTSh6HJhYvfqQe667ivZ2HZ/xWGtnOlTImJvru3
	sOQ4m+0u8l5AylZZuR/j9xqayjkUuaTd+UcLCE+MUAHsBUob0L8HQa2cKu2V1FZAW9wCvgJo8fc
	VNJSWXG7BJh1e0AGryKkE9LfzuVcqSlIEQ/cieFjtK3TsQrD3tjqbjLAmtdlP+RKXbWlZCPAk6G
	7C5Tr0SRJn1NGVCjmGTGbbYggTEXGzvobKeVfAg4o6IsxaGp9eRvLW86PgHy8+yHUlz0AhOEhrm
	Gwl7Rhe5qQW79gPpK0fSFO8lnMvhWuyzjS4E6fU0/5yX4PGmB
X-Google-Smtp-Source: AGHT+IGu/5h2tUWjP5b81jTdtOkkkbtn1DcX2IVMS3yUzYCghpBZ26XfT1CABvcS+azvrG9HH7cxWQ==
X-Received: by 2002:a17:907:36ce:b0:aaf:87e5:4eac with SMTP id a640c23a62f3a-ab2abcb12fdmr1305584466b.54.1736586537231;
        Sat, 11 Jan 2025 01:08:57 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c905ecb7sm251483266b.26.2025.01.11.01.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:08:56 -0800 (PST)
Message-ID: <19ce7463-46e0-4339-9204-f6a4322d1af6@gmail.com>
Date: Sat, 11 Jan 2025 10:08:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 6/9] net: phy: remove disabled EEE modes from
 advertising in phy_probe
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
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



