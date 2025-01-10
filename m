Return-Path: <netdev+bounces-157134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163CA08FAA
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF573A04FC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CC2205E23;
	Fri, 10 Jan 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5ww/C50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858821ACEDF
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509665; cv=none; b=hiXeT814LlbSe0pk/6rVcsfTQxz6LoM8LhVutUX0aPoBTWTMR5QJrcM+hKpqxoZ9BnbgU5O798AXrDxY5jDsb7VdfVK62uAcbBd+dr68LK3mgD8d7gjPUWEu3VHAf/ZH+pCkbmozW3jyXYhn7wI9YN92jZYrSPFguXmwaTi4BhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509665; c=relaxed/simple;
	bh=0JgUYubwMsTnZZayq7Xcx9vFNC5KL2/i+zDt01DeCEA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MxzZWcWZgFdy0NCSXzyNQg8sQ/WjVfzLVqBeNdy0k7BsexDpzyO/mbQ1A1/CwyLnVGgJDNkW35BHFlWSwhO+f6QJ4lcCXw5eSbkGCOZYWADHbPrSoZXMD+ccN8n+N06W/OnCf40jjAl073nU00Cwr1SP/FDMinx4hlqF2IKiXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5ww/C50; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aab925654d9so381789266b.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509662; x=1737114462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bdKRKNdDdfqkrv3XBlPRPNz+3NLUejExUC38jrL6/+A=;
        b=k5ww/C50RjJkGMZAcwhVovwj3Zbn9fxxua+3AnfGHl25iUaUnlT9i1UhdLc2Nm8a/l
         EWs/VoDeu4M5ShTpWFdnU1NNjcZNKcsqaa5FOyMBnbUd/SFHmI773FuSsMINIWpxpmay
         3yPWmsFCpAjORAnvDXYk0f9jGL9sCXtpOucx7b/MykD/OteMguqDaiHOMx7LibJ+7SA7
         W0iznsaHkHDoawjxy2B8ZmGc5sx986IjxKWmVVuhLGjVNyqGNzQNihRgxZopF3CIdXHE
         QDf0mTTwuy1ZoUXR5tIGFPu3eMR5Ofk9JMzmUBIhhbLWawjSm3UhSiRhXLFLU8gHwmck
         7HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509662; x=1737114462;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdKRKNdDdfqkrv3XBlPRPNz+3NLUejExUC38jrL6/+A=;
        b=b2wkkl1RnfiHb4My/x7Jno0ed7qvXQDgjx0OorYWu21KiX/wW/Cixy4pjEjxP6zoeS
         tKH60OazYDKKrtYhu0CLqZuYSJ8533yqNisfziPCJBmT9YC53Tk02uRqXYYcPg4Pl/Sj
         llPF4UPRmMAd8TlfyXfX39GGBZn4fbp/WLyUIrcwdQN07lratn4Nad+ixPfMqW4D4DPS
         I0IfJVyfCycbvVBo53jwof5L5JBmGOjo9wGsJju3xIXWPmi+c+nD0OWgi1+8ykr83h2P
         3Oc5YyfFEKwGbiR0zYdEg0imt/nk2kLt3koywCuNYm+CgqFoc19mRgyPNAaRrL0QX9on
         0ELA==
X-Gm-Message-State: AOJu0YxbZE4qZ84CyH8Oh/9zNCeL8f3LGzSOlORdW5FTJobJnJi8hbhU
	eXIFMN6z202QJ+FBqu7RAdrR+iLjPPmKPvlRXTRexcnOjYrqvVhz
X-Gm-Gg: ASbGncstlh5O5fcEA8GUqzjFBmc3uqWdBiMeRqWuu1/lw9NXcc0lt2jaNFgzV0S2vsS
	yuvaT/nrHyI/mSwROldRcrZ0Fn+hOr5GkQ1sq5BqlQWrZALhMuykAm0OKoqvSnJwQDfqC50Nh+Q
	0RFg9xCmhb0vlNzcxOWSNbXvRGOmJtkqUhkNT3/ZQcY4ut1nXzJ+6ZNQZLN57Jdal0ma5rM+P3R
	uwziLHU6xM2+AgafyUUG/K0ldvAHiluKIYcp7RH4h/q0odgwS6HT3Oc8IsQWOxwUIvo75/hqRjz
	DwPpvAN6yutM8j8swUfnKkuHaAjvUxf6nBXiRVAklL1qsqpNHfL151zEXIMmxEUQK1KZ4fzRupj
	h5iL+CusxTm5FxU715RFlq5MHV0/DGgpkfc9nAFiT2yi/jYbc
X-Google-Smtp-Source: AGHT+IFh9Op6m7HUKqlNozPqDGnrjITONhZmtR8qRNjBOEamwSg2CaeU9Escym4ucWLcT1UK329duA==
X-Received: by 2002:a17:907:3e0b:b0:aa6:6885:e2fa with SMTP id a640c23a62f3a-ab2ab6fd586mr781117566b.14.1736509661610;
        Fri, 10 Jan 2025 03:47:41 -0800 (PST)
Received: from ?IPV6:2a02:3100:a08a:a100:c4f5:b048:2468:70d1? (dynamic-2a02-3100-a08a-a100-c4f5-b048-2468-70d1.310.pool.telefonica.de. [2a02:3100:a08a:a100:c4f5:b048:2468:70d1])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c913628csm158550666b.86.2025.01.10.03.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:47:40 -0800 (PST)
Message-ID: <b67681db-76f2-46fa-9e87-48603b7ee081@gmail.com>
Date: Fri, 10 Jan 2025 12:47:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] net: phy: realtek: rename realtek.c to
 realtek_main.c
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

In preparation of adding a source file with hwmon support, rename
realtek.c to realtek_main.c.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Makefile                      | 1 +
 drivers/net/phy/{realtek.c => realtek_main.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/net/phy/{realtek.c => realtek_main.c} (100%)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 39b72b464..ec480e733 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-y				+= qcom/
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
+realtek-y += realtek_main.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
 obj-$(CONFIG_RENESAS_PHY)	+= uPD60620.o
 obj-$(CONFIG_ROCKCHIP_PHY)	+= rockchip.o
diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek_main.c
similarity index 100%
rename from drivers/net/phy/realtek.c
rename to drivers/net/phy/realtek_main.c
-- 
2.47.1



