Return-Path: <netdev+bounces-222682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A307BB556CF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D326A161679
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192AF322A38;
	Fri, 12 Sep 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnh1RmUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F22868B4
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704264; cv=none; b=Ynh/JzxW4xg0XPpzrHO7j0b+ItYts9xyp/Rgonqqcd06e70vfamvTzrAOSI9/tHhhUcjqZ+BHUHLLmfsjyIl/mo5ZsKUTofoq5szdSL9oZL3HfTJZ7eBjBATzFoKF1p7iOhvKA0RMDiUniZHuV2MVf91B8BzWiM+ggXGjtGTslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704264; c=relaxed/simple;
	bh=3oeYzqU901f5wRgNmTZwhTHdB0P2HYzouA3lZmsOu5Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OxULLC3egjEz8DKsEIXqd6A0XvMV3ZA3r1eLcvHgmG+1FmkRU4Ifv+ZXQnyXALmue7VHQxEog5Bx2uzatilLQM28QXINiAdzeGFBtJxrMfIAJ7weIZUSHdTWuACUNgl2AilpFTx8g+JJPLCh9379iPdYEpOTyRO1DNENX2DsH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnh1RmUQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45df656889cso15648935e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757704259; x=1758309059; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9Lr5sRXYEo6shpqlaKMxCi6Y5z5GwvfKG/C7kzJN30=;
        b=Wnh1RmUQC8u1BRPo0xBz76aMXuaIwMSnyC5cffooGwl5wRIH4WOk9SvbE9HaCfihBF
         tyZPKeAr4kT4x0GyCFzV7LJm4sxx4EMNoxeS0s9iguSPW+9SKq85X+zp8oaI3gdvBWD/
         0PQ2dRfGDqmqFHcacyEwj8gRtu9qpL5X4YViTTMvva6NcO7ECQl0eG1ktpjbaqigEgwR
         Slgxiravrl8KQjb+M3sOdxI3FwaggurN7k6gxHRzcH1BpjvmB8oPB2unlOUKkN4s8sTo
         +i8ghIuZFfJet0LNxD/gcwUAu2IJPrHk13hdFxGuC2ufHmJpwzA2bXNIJHdQofkE4B3K
         xJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704259; x=1758309059;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9Lr5sRXYEo6shpqlaKMxCi6Y5z5GwvfKG/C7kzJN30=;
        b=gCIc+N5nXavDoAJnyf2azjB0FfWGTAb0VXTqdkWteQJ4Zy7DjG4qOUOWRY6VK5a+Pk
         5XBfgoCw5J+12US/etMUNs628zUGvJH4YGM/3AC+E/whcjaiHM3oj2oPno1OvXiEvZdR
         En0rCQ3hSwthn2WInmam4g/SNXhO6UFs4X0sgJPPEYMTCWMkCh+ZTy+0C7c6jyIwuTa1
         3udbuvS348ul3lMV4rSAPJ1eyHMGqsUJpxwzUtgN8o9kxUiZ8V2xdCLnornzN03acaBo
         IXn5uiLMfBZ+VjDx76PS3eKQyn0FgUKxjqcpRNf7KsgCtiltJVE9XTRrWiJ7OdO3/Nwz
         NWZg==
X-Gm-Message-State: AOJu0YyKKLxRLGpHUwTqVUp1IF8PKGAAHJRwME7LAR6liTgOUwUYYkRh
	NRBmh7FgaYg8sY/fNPN19t8H04eGAkHplcWkuw/akPIyFPwx9l+paa9Q
X-Gm-Gg: ASbGncvbL64a4hZ+rPX3kdBykrfoC9rX3kIZ3CMQ6Gb/kD9DDSvG/IvyYo18LtoDwv+
	UZDF7HFdRat3ig2Hgo2I4E06ZZvESKiQkVW8LQZQYoPO55wjlW9nQuTs+WVjq0IXYU6gkakQgDA
	gzHiQJU/Nl1CyG6QhxxM2kL9Q7izhDK2Dhr4otVMB78W5RC6wRWUDeuxjByN97FuEXI/jK8o1AT
	HVgYkYeqDDDjyO22Y2g2pfFW50KDoWTZSfuwatRWAcZ3YWd7SV7UsVqZHIlZ4H5JTZMNaLUkVip
	cnx1YMdWH4QQUHsC2HtnvK6Xy48eyUsFWXPnSvgOZv582qpAvH9HNSbk8eNtIhxsleRTuZ83FJQ
	U5CHyydB0xb/YavmYMW0ZfodW5Ckn8ZBtLlpZEtJlfXGFxYhGG2j0Qs8cj80si6BfysybKeW3a9
	e/+QGM89Y4rRz0RKh5DOlOcF1HUahyIxUfOmvZdiLcdk3EQnloCjFyvuW7u8Q=
X-Google-Smtp-Source: AGHT+IFjywQtM3sKJ0myaq2ZSPkjtE5Jb5S05vnJSoveFCt+qkcB6BbX4rrWaQQIjiLZPDu4Rn2INw==
X-Received: by 2002:a05:600c:8486:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-45f211f7aaamr35188175e9.22.1757704259440;
        Fri, 12 Sep 2025 12:10:59 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f09:8900:81f2:fb63:ffd:3c7d? (p200300ea8f09890081f2fb630ffd3c7d.dip0.t-ipconnect.de. [2003:ea:8f09:8900:81f2:fb63:ffd:3c7d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e03718c64sm70902495e9.3.2025.09.12.12.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 12:10:58 -0700 (PDT)
Message-ID: <a532b46b-ef68-4d68-a129-35ff0ee35150@gmail.com>
Date: Fri, 12 Sep 2025 21:11:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: log that system vendor flags ASPM as safe
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ASPM isn't disabled if system vendor flags it as safe. Log this,
in order to know whom to blame if a user complains about ASPM
issues on such a system.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271..75272510f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5441,10 +5441,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Disable ASPM L1 as that cause random device stop working
 	 * problems as well as full system hangs for some PCIe devices users.
 	 */
-	if (rtl_aspm_is_safe(tp))
+	if (rtl_aspm_is_safe(tp)) {
+		dev_info(&pdev->dev, "System vendor flags ASPM as safe\n");
 		rc = 0;
-	else
+	} else {
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
+	}
 	tp->aspm_manageable = !rc;
 
 	tp->dash_type = rtl_get_dash_type(tp);
-- 
2.51.0




