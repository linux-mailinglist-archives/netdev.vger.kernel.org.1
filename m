Return-Path: <netdev+bounces-142523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2E9BF7F1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580AD1F2243A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4509F20C003;
	Wed,  6 Nov 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIGUOjMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3020BB46
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924718; cv=none; b=Cfc40qabmMacNAkGNZbQcSkunbjRKmb3KTAiYTOCWEL1DOK9xVvQIe//hIIEf8l0JgXqG9PV9I8eS+ZOg5GZsinYqDy6PsxxRb2PiwA6VeQYyvcEas1rx1q8ufT3km0eqXW3XTf25bGty6RJYd4ftp9kFHbVBn2Sl05xFxUZnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924718; c=relaxed/simple;
	bh=m4v2xLP1maIzhczF4mKLM8kdd/0M768SZcOKbXAGYlU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ucuY0oF9pToSrUXY2E7s6eZ+UxF0VAaupBTms8hCRHDZUWf6LzjoKW9ccRVyNMCZaPXJMZnIFua50qrugvYfkW6Wpb2KAKD8cC6v5AGTa8zCoDlSjc5Mt7k3zbtihozREd4nCVw63E7urM8hhghF31ywUTpM9TMEq/dediWzp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIGUOjMU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso184065a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 12:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730924715; x=1731529515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ6LKY3tJMAexyqo8j030RiLll74Bu8U55fYkKhVu1Y=;
        b=iIGUOjMUGSev7N9tJtHVPXGSWWzBssf9VvFmL10F77qNGbkXt2gVLgAPwdCoDZllb0
         JcjgyBBk9f3nlFZjUEpQv5faBHkwruQ4dh+HWPd7lCgZNvx3Es69ZKmt3uR2CCyxQSKX
         nIEMGA8jJv2eiqq3CEKLXj5raVxHK5kppb7snEKPEkouJt1uDIkiFK7/eTPU6pxxWWEv
         XlbUsUWv5bda1m9h2PSJwegDy7kIu4XzYPIGkowDGGWc+2DUZA+ZuvMrJjMNcenqVWTO
         Mzce9vZurWY6tOldRR9JDtKYn28LhigeXvXRRSu6qjmGsFZG+j3hekVSnaty1ryhSRIE
         r/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924715; x=1731529515;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ6LKY3tJMAexyqo8j030RiLll74Bu8U55fYkKhVu1Y=;
        b=GmzIZlAEb0WTp0A+wpYl+A8DtA+FpP6tvKHMRwrd6RfhNxJkb+UyJ7V6JjiPV9owAw
         4RCxqswQsupxPp+oojle44WxDpEhwCxBFSh19wiSE2SAAqimt4TBc8IKNqt5E5sTEqyN
         kB70edHmSK8kGh+rNPtSvyV2fzt77YjmHw5d6kRelQz262I3z5iMjN9t57OU9ptYAiGU
         ZcUdq+QRv8XMjR9wKNlYqHcY4Xx+dYJ+PkjsOVZL5/W7IypFzCQiK2gE+ozzsHHx5hM6
         uNps+rRNpjrAQzV3xAEbNvFzpke24Sc+Iy7WN9TkyjiSzg6P06QqiPOfe3H/BIDCA1mB
         fTgA==
X-Gm-Message-State: AOJu0YyLxk+YEXZzd3+aESh57EXvW3tV+qlXQyVwG8KAtAywSMGdgd6v
	20WojPEkGM7zUHM3gWFt8LBAkFw5tyV27IsSki2a3/I9hod1g86k5jjTgA==
X-Google-Smtp-Source: AGHT+IEG2hPkWUQsAwDflXljRf3YHsfzmgsF2W/7wpW9biOvt1TBm6NzinfBE3g980Sogw/sbqp8ng==
X-Received: by 2002:a05:6402:2105:b0:5c9:5ac1:df6c with SMTP id 4fb4d7f45d1cf-5cea9732262mr20103193a12.33.1730924714817;
        Wed, 06 Nov 2024 12:25:14 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6aafc8dsm3279991a12.24.2024.11.06.12.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 12:25:13 -0800 (PST)
Message-ID: <37da7f3e-b883-4c07-9881-b8c0516822b7@gmail.com>
Date: Wed, 6 Nov 2024 21:25:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/4] net: phy: remove genphy_config_eee_advert
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 David Miller <davem@davemloft.net>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

bcm_config_lre_aneg() doesn't use genphy_config_eee_advert() any longer.
As this was the only user, we can remove genphy_config_eee_advert() now.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 23 -----------------------
 include/linux/phy.h          |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 563497a32..bc24c9f27 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2239,29 +2239,6 @@ static int genphy_c37_config_advert(struct phy_device *phydev)
 				  adv);
 }
 
-/**
- * genphy_config_eee_advert - disable unwanted eee mode advertisement
- * @phydev: target phy_device struct
- *
- * Description: Writes MDIO_AN_EEE_ADV after disabling unsupported energy
- *   efficent ethernet modes. Returns 0 if the PHY's advertisement hasn't
- *   changed, and 1 if it has changed.
- */
-int genphy_config_eee_advert(struct phy_device *phydev)
-{
-	int err;
-
-	/* Nothing to disable */
-	if (!phydev->eee_broken_modes)
-		return 0;
-
-	err = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
-				     phydev->eee_broken_modes, 0);
-	/* If the call failed, we assume that EEE is not supported */
-	return err < 0 ? 0 : err;
-}
-EXPORT_SYMBOL(genphy_config_eee_advert);
-
 /**
  * genphy_setup_forced - configures/forces speed/duplex from @phydev
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 517f6e0d3..d1a4f3f86 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1886,7 +1886,6 @@ int genphy_read_abilities(struct phy_device *phydev);
 int genphy_setup_forced(struct phy_device *phydev);
 int genphy_restart_aneg(struct phy_device *phydev);
 int genphy_check_and_restart_aneg(struct phy_device *phydev, bool restart);
-int genphy_config_eee_advert(struct phy_device *phydev);
 int __genphy_config_aneg(struct phy_device *phydev, bool changed);
 int genphy_aneg_done(struct phy_device *phydev);
 int genphy_update_link(struct phy_device *phydev);
-- 
2.47.0



