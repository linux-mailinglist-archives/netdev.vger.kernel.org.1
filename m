Return-Path: <netdev+bounces-157133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9480A08FA7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F001691E9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A2205AC2;
	Fri, 10 Jan 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO0jVEYD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B01ACEDF
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509600; cv=none; b=Fr3h0UzlyEVYGXYEzz+keLYfK0oPFtoY5duHUOukenh3O9mlH98j92qWwwl+GU8iUk1eK42VjsNNARFaEQt75XZ0zpzqzwGY+P5K9tSxQ5EK6dYtopeKCm1sKDmDdWjduGSQWTFLbUXYWihSfLdnr34ADJsjpgiHxX6bFou1iog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509600; c=relaxed/simple;
	bh=qP5/M6vseHnnBiZ/lTYidFMd3YWQ51fEwZPovPeFPNU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dA+/5WzJqwwpomQ4MQYUGezMEBtxCURx0/xR/5vZhlO28nwGJAaSv90RfAD/R99lDfoTCOR56CDOHLrpBlNarM5HNWyFQ6cKhHj8DcaRSYKeVDpGMNeN33ZqGE0jqTXDcZ5WCGoXnk+wO7iyFJyuUEsjPFaOz8JuiJb+O4P1tsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO0jVEYD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so3380392a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509598; x=1737114398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z80OxOIrtkhN3EgoWKZwUPYC+py2jGJPJeNHPUOoGU=;
        b=bO0jVEYDVG3ROFxGOJIqsVMFOzfOrF6etBwBUeFyouYCEmgzxA6cBoXMU0IgX9Xa5l
         2H1pHam/r8Lfhp5ogfUtOb7VCUcxTfzQz3ea7hFJA3wFkw3naU4QdPSh8npp+ZA16qe6
         5oKBTvee43OfKO0rdqv5QOvvj92kXmMPBGIt9R9A6VBiaIfhAYj/nge+kNffTbee7P+E
         LKLbbrWMRA8bCWHvekhpSCLgMT1K/Y0n59LJZnphGcIJivslXGPdLCWfgslMcYDBmcDB
         djdFvIPcUQs2E6KR/USm7U1s3FuftKfTpyvltdJg+mFbnDNfl5fnVhsn2tT0V3jlb2T7
         Lapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509598; x=1737114398;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Z80OxOIrtkhN3EgoWKZwUPYC+py2jGJPJeNHPUOoGU=;
        b=INK46tOgfncvoleheFrDruAo/6mrg78zvu+8IGl+afLqvHTe0KXLaWpHKHQ2G3IYY0
         ootYUZyUnWYgOtgCUjWV0gPuqGHgdKO1R/x31fIvqtgr7qAtLwneETEMCLU7wTm/zMIH
         MfTkUEMbpCY8Jo6k0Bw6R56TGFxDQvP24SEaLFQ1CCHPBI2FAV+HiRU4EVXBO4rVwmfL
         UZ0EbYp06i6mnj1S9SZf2NSsnlPFkph3ltFy4w8cr0K3MnPLCZwpNIiJS+KUM/7QwhT6
         3EqOFr6pE8EqYntQDWbJmZJirE+Zg16CTv9shVRSWGW6XGHgUYXOgFK4GLCWlv5ehFgH
         ql8g==
X-Gm-Message-State: AOJu0YzGX/O7XxRp8GQqEgzJK5JpgluDuRHftKADW+8wuKhkXbQlzoR8
	WJuUpzFCXQJ4UPqbzs4zC4EL0pghwgxX1yyP1GZaujlFfCS9M+m/
X-Gm-Gg: ASbGncvGQ8a4tSwW2z9ddTf0ZUY8n/QTXLS534DJu4b6Tz4Y32eD2g9o8AOpgbVJy6U
	b+ci7ed8uguUDBFEUxh4gdkhRaKPtwa9L1bR5VAGv3pmp3jhUvOXh6k7q9XXbmmxOrIzNdPhMAA
	KwnGPfl/cirMAz4K3lUVHbpUEmffjkgIhfg8Q/YE9Brox1pjUwgBn1m9olxZ0sj03/pjtTQL2bt
	PPKQmmbPIQwmx+h3/UZn/zscnv0RfcUQCb9ZF1nPLw9+dNwNO5Ms4013e97Syu/6uaXzPPRVbcE
	jLgnm8tAQbX9Vylh40hhzrovZNqI78qatbc6VemJT8yCm+F7B6KrQwM9FFLHFyCA19oeetroTLY
	tbsIsJysYkgtwdMFzt7TY0SmWjI07yvGXfBw1WvSWrINWjYTZ
X-Google-Smtp-Source: AGHT+IG8NksOcLiuD8LuuQ6ujzK5F6GeY7sFLd7MQOV778qhwuoqSgXdsT9faXrETn2I6r8K0QxWSg==
X-Received: by 2002:a05:6402:35c4:b0:5d3:e63c:7d71 with SMTP id 4fb4d7f45d1cf-5d972e06e45mr8937485a12.11.1736509597501;
        Fri, 10 Jan 2025 03:46:37 -0800 (PST)
Received: from ?IPV6:2a02:3100:a08a:a100:c4f5:b048:2468:70d1? (dynamic-2a02-3100-a08a-a100-c4f5-b048-2468-70d1.310.pool.telefonica.de. [2a02:3100:a08a:a100:c4f5:b048:2468:70d1])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c2ccsm1584045a12.18.2025.01.10.03.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:46:36 -0800 (PST)
Message-ID: <0c68a882-d26b-4691-93f0-4dbd2317d05f@gmail.com>
Date: Fri, 10 Jan 2025 12:46:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] net: phy: realtek: add support for reading
 MDIO_MMD_VEND2 regs on RTL8125/RTL8126
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
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
In-Reply-To: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8125/RTL8126 don't support MMD access to the internal PHY, but
provide a mechanism to access at least all MDIO_MMD_VEND2 registers.
By exposing this mechanism standard MMD access functions can be used
to access the MDIO_MMD_VEND2 registers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f3..af9874143 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -736,7 +736,11 @@ static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
 {
 	int ret;
 
-	if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE) {
+	if (devnum == MDIO_MMD_VEND2) {
+		rtl821x_write_page(phydev, regnum >> 4);
+		ret = __phy_read(phydev, 0x10 + ((regnum & 0xf) >> 1));
+		rtl821x_write_page(phydev, 0);
+	} else if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE) {
 		rtl821x_write_page(phydev, 0xa5c);
 		ret = __phy_read(phydev, 0x12);
 		rtl821x_write_page(phydev, 0);
@@ -760,7 +764,11 @@ static int rtlgen_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 {
 	int ret;
 
-	if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
+	if (devnum == MDIO_MMD_VEND2) {
+		rtl821x_write_page(phydev, regnum >> 4);
+		ret = __phy_write(phydev, 0x10 + ((regnum & 0xf) >> 1), val);
+		rtl821x_write_page(phydev, 0);
+	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
 		rtl821x_write_page(phydev, 0xa5d);
 		ret = __phy_write(phydev, 0x10, val);
 		rtl821x_write_page(phydev, 0);
-- 
2.47.1



