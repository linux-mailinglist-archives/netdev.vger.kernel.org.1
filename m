Return-Path: <netdev+bounces-68864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4A8488F4
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C72852DC
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CDE12B9A;
	Sat,  3 Feb 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps0Pb5LF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7A12B78
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995548; cv=none; b=eCUI1x+yQ+yngTIAhwZT/S9QER3zsGp6zjjY7tIsn4bT7FkBm3d6c6PlXkQo9N1wmGRN7sPyykJJ/NS7XqQrjZxTLhOfZbHn45Hb/57sY+uXeLVCcXsQnR8nMLf+qcCc9Go0LjztgT2FxXALzLyQOAD3rfPKLKMSLrWT2HUWV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995548; c=relaxed/simple;
	bh=R9yczKZaPc9eYH2zs1YcxygcOzr35HApFs4dWr4T7AE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=r5M5m7Pj7cvqob2LyupGdKSmrUX2ALhDhrWOSFX4j/QkrIhs5Io6qP56LKqChTb32kYvSaIGh4gC0++YFDIeLe5knXQhyfAKu0nm4htrI5+HtSWF94je8aMK131Xm77a/gwz+YROTSLUer7/uJAxZvJ+DmB1VXHrNPk/0kwdzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps0Pb5LF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so3667929a12.1
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706995545; x=1707600345; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUhBfV1Kv8NDmocx6Q0OvBPo4AzGNwtqGSzy5Bcz26g=;
        b=Ps0Pb5LFjBfJSY42d2U1thC5G9tOHLhmcQ4aY0TAvcpXfeRktJ1Eyi7ySrlzUNrFP1
         hxQF8c742bz82DcBs9QxPyU00G8EOeT45L1WZToqpA8C2diS6B6Wdv22J4f+zZOGHbfG
         tlaYptdRtSA0kivvbCBZom5jJYwfLP5mcHhfZnzPGHXcId7j7UtXg+YL9qs13kbItHbJ
         aFhCk6fkbgFjUcH8HaqSCcoedbeNTHn5TYYvKHCnmMW+1nKvg9tfrFGfRBGAaoh7YAtj
         z7muZC6ejx+lLrsyOE3MZ8M1qY6uYbWe2moa92pexcWN/FxErU3e8NZVeGeEOxdjBdEz
         1QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706995545; x=1707600345;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUhBfV1Kv8NDmocx6Q0OvBPo4AzGNwtqGSzy5Bcz26g=;
        b=NI2LoozytDxD+ivsygyiGWiQcGyNuuxr9Fqy7/BZBKi7400CnV0gB6DelQZj30KIrf
         nfQfHRfnKn+tS1Ai0MXf12zOIvdQ2++WhMS+AevNig+kZ9uXPUKOCyJ0/yO4zkzvJ+4Q
         TuRI9j7Gr8433aC5CPKdA27coHvoyGiiybsdj9KN8a6jQ/IsqpwoEE3apjMbC/8XAuWT
         AzG3lrzcmTBfbDbIddZzuidNyde6QwpD1C1iryhO6W7onIikkucMpe+0f5v6Dkh6hM3n
         xD/BVWAq5i/ugA+xadWATFMF4QAB/1D8+8u6Ut5G6NG+cH2/gWE0QVGj8VqKfZLU/WkS
         kmSw==
X-Gm-Message-State: AOJu0Yy3ZJlCRpYWw85rl/Z5pSXhR7hxwSki87rAZV5qGNmuat5i1WQK
	l0kqONL8+5XxYhwuzGIpvkcnT/ZHe3hSbP34vtL+I+5qRt/Sajiz
X-Google-Smtp-Source: AGHT+IGb2rJeVo/5DvlJ+POD3nHax43BQ8qI8wul8bFGtbMdYkWaDHjDKS4zyLc7tpbtt9DWiWTgHg==
X-Received: by 2002:aa7:cf83:0:b0:55f:fc6f:835b with SMTP id z3-20020aa7cf83000000b0055ffc6f835bmr2039915edx.35.1706995545142;
        Sat, 03 Feb 2024 13:25:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWB25ygC5dHLTieSclfYRIVOsTXzTJKK/dc09VE5zpluoJdzLXtYn8L7E6PN1lVWguEMn1f0ag0Sranniq0yyQETo5zi8mKi2xwqC6XXwhvuDyXT2XUxIA1mpX8zY0NziFE3rf+lfMFGc7tJOS9KjXrB7LXLcfXKS+1kEvNOEgzKdAbdXW0zBHUWNBhKqhmJ8R40yp3W8Cm72pN9CX3N8LmcSS5IpS66w==
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id n22-20020a05640204d600b0055f50417843sm2102704edw.22.2024.02.03.13.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 13:25:44 -0800 (PST)
Message-ID: <7d34ec3f-a2b7-41f5-8f4b-46ee78a76267@gmail.com>
Date: Sat, 3 Feb 2024 22:25:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Igor Russkikh <irusskikh@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: atlantic: convert EEE handling to use linkmode
 bitmaps
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

Convert EEE handling to use linkmode bitmaps. This prepares for
removing the legacy bitmaps from struct ethtool_keee.
No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../ethernet/aquantia/atlantic/aq_ethtool.c   | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 0bd1a0a1a..7cc36517b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -15,6 +15,7 @@
 #include "aq_macsec.h"
 #include "aq_main.h"
 
+#include <linux/linkmode.h>
 #include <linux/ptp_clock_kernel.h>
 
 static void aq_ethtool_get_regs(struct net_device *ndev,
@@ -681,20 +682,18 @@ static int aq_ethtool_get_ts_info(struct net_device *ndev,
 	return 0;
 }
 
-static u32 eee_mask_to_ethtool_mask(u32 speed)
+static void eee_mask_to_ethtool_mask(unsigned long *mode, u32 speed)
 {
-	u32 rate = 0;
+	linkmode_zero(mode);
 
 	if (speed & AQ_NIC_RATE_EEE_10G)
-		rate |= SUPPORTED_10000baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, mode);
 
 	if (speed & AQ_NIC_RATE_EEE_1G)
-		rate |= SUPPORTED_1000baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mode);
 
 	if (speed & AQ_NIC_RATE_EEE_100M)
-		rate |= SUPPORTED_100baseT_Full;
-
-	return rate;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, mode);
 }
 
 static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
@@ -713,14 +712,14 @@ static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
 	if (err < 0)
 		return err;
 
-	eee->supported_u32 = eee_mask_to_ethtool_mask(supported_rates);
+	eee_mask_to_ethtool_mask(eee->supported, supported_rates);
 
 	if (aq_nic->aq_nic_cfg.eee_speeds)
-		eee->advertised_u32 = eee->supported_u32;
+		linkmode_copy(eee->advertised, eee->supported);
 
-	eee->lp_advertised_u32 = eee_mask_to_ethtool_mask(rate);
+	eee_mask_to_ethtool_mask(eee->lp_advertised, rate);
 
-	eee->eee_enabled = !!eee->advertised_u32;
+	eee->eee_enabled = !linkmode_empty(eee->advertised);
 
 	eee->tx_lpi_enabled = eee->eee_enabled;
 	if ((supported_rates & rate) & AQ_NIC_RATE_EEE_MSK)
-- 
2.43.0


