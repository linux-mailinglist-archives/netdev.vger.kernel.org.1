Return-Path: <netdev+bounces-71826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1CB8553D2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5191E293BCE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E913DBAE;
	Wed, 14 Feb 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YigXpF4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE813DB9F
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941835; cv=none; b=k38tGJbNp+mFFbww0gp5nS1goGuOTNOpvk4WrdSj1boiQwxRhbiNZS+ba9wzpf66NxXuCZPWPAzLX17HsxIO5XYewxl7SlvdmYsUW1cxqB1ck4ixZsLlf9xS8702BD327R6xMQ9EUM+R/rr6gRMf4hDMdQfV68OpIbdnvmBckVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941835; c=relaxed/simple;
	bh=akKTxfgHLu0FBpqgnqdgGwWq1ZxZR1G1qBQFAgqXk9U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DTndnFlE3VsFtr/6sANQ0V8uEv8fxT1GjqV+uqSs/rW7sA3VE/8wAXw1uv11WbydMvAzIkNqpzeHY4Mnyd4cQIWtDhv7K9yOlHsbA7z6XwX+Jbx5Ep5Saa1dmxYzxkqx93ZLbQb5nStxQuuLrkAEz2/smpfQMHicHUkWdTFLgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YigXpF4q; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51147d0abd1so106473e87.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707941832; x=1708546632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PJqusheqD94Gp9PDSLOXTzyl7fRnOhX2kW8rohaaCpA=;
        b=YigXpF4qSDO9UeZ7zg5uVuyMBZb+e7c1eHEortwBB3aimJ6ZtuTAQBuRuvUVrYnoEW
         Kdn0ohqjQjCVClHKOE2zVpser2nwpeuIlyAIo3p7DnQ4taHBz/+jAlVfaN/sa4zqYlVU
         rwfx8j6kMHwGSkkVRlRqDSSGJCI35id28PsZT/od4dXUhhmZyl20eOzui0lVbu+UiQgE
         S/lQRpctyXQwAEmH5ovUDO44y2TnjExVMWLfKw0ZAiHOfryofkflOeUnS3/B5vLplWjM
         nyeNexw0H5i3ixwTXhphy+URtQkGl1EsczuS3rbsZ+b6/MSY3yzGbu/2LXQ/NJ9ibs/O
         v1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941832; x=1708546632;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJqusheqD94Gp9PDSLOXTzyl7fRnOhX2kW8rohaaCpA=;
        b=neuVtZAMrcmT08Jlu/U55fGkn0qY8pQa/HQ4lpn5uxZ6/rudLwnnJ1DfzHLJI7HO/o
         P1LNv0MMf/E36+b4k1P9lVgzpoMIzwsexeAgT1OeOAvfyOdC6WemNL7KjCkgIOBj7Rfk
         u597HK5gwQwmZ6ZCemgxPhhA0DW9v8x3FXG2ykCRpAokSMEZQdPPBmGCEt0mRxoOoGqd
         7FjnD0vCxjLCdhVEfly/Yp86ZIji4G46QB9B1zhFqwVJxx5LywljVddweuxz9WnOmKdu
         NUmqQhrqhhHmCalnbUO0DprGSZAyOZ9VPqhlz93Mvu/0UQUnMY3duLHkOOUAnV/yw5O/
         /OIQ==
X-Gm-Message-State: AOJu0Yy/Uh/8ovaYWIc9LzCF689dqukZM725H6xTTPiZLegwwvLr0/mw
	eOYk6SPnNMIE0MwduaTFaRwaM+ewecjXRISkiI88683+F1WIxHoE
X-Google-Smtp-Source: AGHT+IEbUS/9JPQ1vdk0TaVCpg0LOkc8rnPVqkMPF13lZ68B/2ysmwDqdDP6cXpMZLAHcqZGmP3oKw==
X-Received: by 2002:a2e:9dd3:0:b0:2d0:cd24:24c3 with SMTP id x19-20020a2e9dd3000000b002d0cd2424c3mr2674693ljj.53.1707941832035;
        Wed, 14 Feb 2024 12:17:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2qnlgX5F7R0+7xBk58gmgoLth7tJu8haI+9lHKyW23dOBspqeYOLnydzz+IJg9qwZMtQMEETcCamwc+spCY4zI9WzaVCNB8PndiaN0F4cZXnDxS7dugwKWhwKpvCWDkbrPXt35UoftoQ6cpk4UG6ZA+8SSHaTd8HhCbZtcaJSjhPfVtSWSA3pVKRGZrlq2xF9ozY=
Received: from ?IPV6:2a01:c23:c153:4a00:f92b:249d:fae6:3a40? (dynamic-2a01-0c23-c153-4a00-f92b-249d-fae6-3a40.c23.pool.telefonica.de. [2a01:c23:c153:4a00:f92b:249d:fae6:3a40])
        by smtp.googlemail.com with ESMTPSA id en14-20020a056402528e00b0055fef53460bsm4979118edb.0.2024.02.14.12.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:17:11 -0800 (PST)
Message-ID: <6b683779-ba96-421a-a274-a4288828fd95@gmail.com>
Date: Wed, 14 Feb 2024 21:17:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/5] net: phy: add PHY_EEE_CAP2_FEATURES
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
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
In-Reply-To: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As a prerequisite for adding EEE CAP2 register support, complement
PHY_EEE_CAP1_FEATURES with PHY_EEE_CAP2_FEATURES.
For now only 2500baseT and 5000baseT modes are supported.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 11 +++++++++++
 include/linux/phy.h          |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9f37c0bfb..9ab1369ba 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -148,6 +148,14 @@ static const int phy_eee_cap1_features_array[] = {
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_eee_cap1_features);
 
+static const int phy_eee_cap2_features_array[] = {
+	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+};
+
+__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
+EXPORT_SYMBOL_GPL(phy_eee_cap2_features);
+
 static void features_init(void)
 {
 	/* 10/100 half/full*/
@@ -232,6 +240,9 @@ static void features_init(void)
 	linkmode_set_bit_array(phy_eee_cap1_features_array,
 			       ARRAY_SIZE(phy_eee_cap1_features_array),
 			       phy_eee_cap1_features);
+	linkmode_set_bit_array(phy_eee_cap2_features_array,
+			       ARRAY_SIZE(phy_eee_cap2_features_array),
+			       phy_eee_cap2_features);
 
 }
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 2249cdb59..aa3fd1468 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -54,6 +54,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
+extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
 
 #define PHY_BASIC_FEATURES ((unsigned long *)&phy_basic_features)
 #define PHY_BASIC_T1_FEATURES ((unsigned long *)&phy_basic_t1_features)
@@ -65,6 +66,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 #define PHY_10GBIT_FEC_FEATURES ((unsigned long *)&phy_10gbit_fec_features)
 #define PHY_10GBIT_FULL_FEATURES ((unsigned long *)&phy_10gbit_full_features)
 #define PHY_EEE_CAP1_FEATURES ((unsigned long *)&phy_eee_cap1_features)
+#define PHY_EEE_CAP2_FEATURES ((unsigned long *)&phy_eee_cap2_features)
 
 extern const int phy_basic_ports_array[3];
 extern const int phy_fibre_port_array[1];
-- 
2.43.1



