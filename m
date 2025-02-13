Return-Path: <netdev+bounces-165845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBE0A33837
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F318F1887791
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4A207A1C;
	Thu, 13 Feb 2025 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0K9ST1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF562063E3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429470; cv=none; b=mQOIDNmSk6WSy4scvR5xKM52DNNMRG9upbs66rA7GOcJdn+EoqkCfz0JB/ildXDzIgXJIXKGra8YQFMysMABgRoAt32rAS+uBGrzbbN5haRfFeJieHDkqQiLp43WN8FsJLsM/CApB1f7exqdWw8OujBNUU+cz7+m5p0T99s8HAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429470; c=relaxed/simple;
	bh=AhzIdeUNW+hCq2NsK0teMbmcDd0av7JWUfWU+f4ZMRk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nr2sm1iv9gGuLo2hwk5pNzqH9WS+3WVpi4yF+yMbP7npmZPw/LHNL1KZTCbIcQJwoaruzkHXpZrkxYnE9HLqbqTPzng4qp/e2JWc8/kkjTz4759oYBd56El/ew2mWBGeIv+vF2AQ25ytt06RvHyfPLcTfbOBVCZAia++zgSAv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0K9ST1/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4395b367329so2821995e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739429467; x=1740034267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aqwR/OohvPeKiJLulmHUEaUwhhaHWF7qcqQ9CtgceOQ=;
        b=m0K9ST1/yPSZ2XfDwi1xH/ob2FRBRpzZWAMl+d9EyqzZqZGzMPHLSwpnCwnxWiwsX/
         9oZUJW+yydoj8PoT1HBbla+aZDXMNHAGXhGRPAJxuEFFkd1C8NoGGvDboxk8I/qpsnsw
         kb9U5UMvyV57IvkQNpCEXSBQULtZJZmCv9F0BQCDRefj2x0ka9VDI39MwJUwTK8ZM3OA
         XLCLz2+PkzEo/sUj0lFh8/V6HPc+M28mn4sVMx1r7HjGxrcaOCjGt2zo9psBnffWQaZp
         H5nftJKZXV+rBlRB/YBrAqR0mMgLdxGIhqyTSlPEIgXpXJ/4zplgD/7XeO2rHD7DKL+T
         SyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739429467; x=1740034267;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqwR/OohvPeKiJLulmHUEaUwhhaHWF7qcqQ9CtgceOQ=;
        b=qUAdoLCDwtTwND2kVSfKR4fn38oPmpuKN72Az2+dXR6VPyrhnqs1M6msDroIT8x8od
         OgZRIqbf5juyZs7w0bNXe4KnMzZTf90R1Z5/58y5ek1xOOoHHlT21SwxWPkeE0vIl4QI
         dnNQahgYf3pd+2WAuOK6a/r14cjeENJkv07pNGyG5biSt0txwMBhT/7Asm2LAEqhTGP1
         bzclZ8Zih6QafHgt1zUXKIdo5wR+9lYL70q7ILt4Rap1/CYqz9KRrW0ybHV4v+W6+U3Q
         I/K9nN0f1XZk/U7/sLTMW9w1JlvR6lnR05EC2rv036ML+4D8A5sv8r68SbgfG2S2z8Es
         Eg+g==
X-Gm-Message-State: AOJu0Ywv/GVT0xx00DG4OC+ZOvQ9Z+3iVyLSfkQqLyMGw65A2Ebz+uYP
	+wLyua4pPHH/sscbgO47ZZRwxNzsBxHy8AhArCck6mUnbdQz0RWe
X-Gm-Gg: ASbGncsFjvaArlZOIqfAQ6UKxL68mQSgTfaMV1FQRo8XyKlnmLi+KI0yBJ4RyinawJs
	UkhlsAPp2KiW9Tdd14bKt/Wf9s5Dgb2IqdXD1ZrSP/eRdfi/vhAejF7cyU7cegk/NNpAoiEPQNC
	1PcMmsyJw806Z1cM+GFk+2pKj43/ZV4wWAopJnRkPrxZpCQjZswwMMF7S19/UCf1fk+hrf+luzQ
	9EdsrUwHtUgKHBGb9WTmQFXIAywCu9h6CJSLrPlGFV6oIrY0jGToZKlDFsDLiBdllMtF5v3xcaS
	vLcxzuWcDNTqVC45qPceROTQIxKl+wbeDLvw1Pfuef3hxPjyBCTEgo/XSU5vnR8PPY7WVDL5LAF
	LCcMXzhqB1mqyv6zGfA+PXRvLOwYBqUXUm3hNpXwcfpHQSFUxt+MmtUELRY41Wm8w4/dv6ueJhS
	8YG4TW
X-Google-Smtp-Source: AGHT+IGu1eNUwiFn+nUdopSVOr9fun/kqLG1NPYXuTvj1QveyTnF+yfbFrOIvoeWAZqh1J9QYFEVtQ==
X-Received: by 2002:a05:600c:46cc:b0:439:5f5b:e98 with SMTP id 5b1f17b1804b1-439601a96f3mr17459435e9.27.1739429466931;
        Wed, 12 Feb 2025 22:51:06 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8068:750d:197f:b741? (dynamic-2a02-3100-9dea-0b00-8068-750d-197f-b741.310.pool.telefonica.de. [2a02:3100:9dea:b00:8068:750d:197f:b741])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f25914d73sm991066f8f.54.2025.02.12.22.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 22:51:05 -0800 (PST)
Message-ID: <4a39826d-1dfd-4b93-80b6-c0da7c5109ec@gmail.com>
Date: Thu, 13 Feb 2025 07:51:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] net: phy: realtek: switch from paged to MMD ops
 in rtl822x functions
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ca05b98a-5830-4637-be72-c11d7418647a@gmail.com>
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
In-Reply-To: <ca05b98a-5830-4637-be72-c11d7418647a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The MDIO bus provided by r8169 for the internal PHY's now supports
c45 ops for the MDIO_MMD_VEND2 device. So we can switch to standard
MMD ops here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 2e2c5353c..34be1d752 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -901,7 +901,7 @@ static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
 
-	val = phy_read_paged(phydev, 0xa61, 0x13);
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa616);
 	if (val < 0)
 		return val;
 
@@ -922,10 +922,9 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		u16 adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
 
-		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
-					       MDIO_AN_10GBT_CTRL_ADV2_5G |
-					       MDIO_AN_10GBT_CTRL_ADV5G,
-					       adv);
+		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2, 0xa5d4,
+					     MDIO_AN_10GBT_CTRL_ADV2_5G |
+					     MDIO_AN_10GBT_CTRL_ADV5G, adv);
 		if (ret < 0)
 			return ret;
 	}
@@ -969,7 +968,7 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	    !phydev->autoneg_complete)
 		return 0;
 
-	lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
+	lpadv = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa5d6);
 	if (lpadv < 0)
 		return lpadv;
 
-- 
2.48.1



