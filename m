Return-Path: <netdev+bounces-66291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEEC83E50C
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE7B256C4
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD946559;
	Fri, 26 Jan 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8h5NVWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2152563D
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307404; cv=none; b=E+La78yRsR0g/0fFs9gXkCSa4bYw/W6OMN8kYWM4LGA/5dAhlkbKdjHMXifmDR5hkKh/KsOg5nz53kHjv3ai26f4E0OpABBPOZtdBO/rNyVcW8RTqERYo2CBwNcSwBv3+GQsLdu1SgWnCvPXmI84Qusj2kkeptVt0LyVWPgdX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307404; c=relaxed/simple;
	bh=Kv+Dtl517OAR9A45mxa+2nPZUxLDbOZFEqRCo9HwzSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gv+lWKAuCOaoWO7UPMJu4T//qIbD3G7QvX0hZdUBJWS0jfAiBQLt2jhf1eWarL4bLK18fbsB2gpun5weqjorCPEf19jMstyNN6B4EEzfsGlSfI8oN859Q0mxlYmYgJ+YOvTELuMuuHP6OfI2EMw286AgZNyXvjbtsAAh7yfkrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8h5NVWu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so69152966b.1
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 14:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706307400; x=1706912200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YiyjZT4FjG46ykY17ul015oOsHoiFXFS6O/wHz4L0oI=;
        b=G8h5NVWujZ86qtg8XwT1B+oSJOIIkgc+lWQnt1W5WP1bpMMWQ0dkXqP46GRzlmdgJE
         2T71tN8rK9AuHpGAWg+UpEkL8JGT/y/wstd7fCiUcawOZ3/5lGM+KqnYcgkVx6hByqTX
         sAg1Kcia4gaFMJRVcsYRGNweKZCytBKA8XY4JIFeqEf5WWSJ6DL134fwbXzxLBN734vD
         HxNJiRZLm1dEdYtbikfgm0IS5uv0mz2w1n77yZBQZ2vNy0XXd7vxiy+Z49CiqIC0SGql
         3GKwqAt4E1B2pXuPeQ/LZusN6nlaaP/aMlCyx2uE5uv3X6QtLe6XztxzfOfg/YZtJp2R
         nZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307400; x=1706912200;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiyjZT4FjG46ykY17ul015oOsHoiFXFS6O/wHz4L0oI=;
        b=VBIlu5HrK/yB212hv56BOnxdRE1XKYzkMrNEk40Bv+xw0jUZdFoDsayp5E+wVcTVm9
         pk2Sgo4Ri7swknvaZTlU+KkKEIOlVMuqGQ2jmHEIup77TbRNrGjrf04KtsIy70D5UC88
         W2mWmwO8L5Ha6WDDr+z+bAn4SwNx+tONvtOUTSZByCPCT0scG8vDRJxeh7INNBLiYv+P
         bAoPSaj0Wob+P4kJF3UlkVs22Ke6DG9mxi2w7wTp/QTZjk5Ocbdl6tothYos5wowxPxT
         KXJs6bn8yT3pCywxv5KWwkZgoSomNXQVOB/XqZAsntdDRwCozuuB6ClEB7GFydthXgTf
         ciig==
X-Gm-Message-State: AOJu0YzMKKn/TGw4sqRDI8prXzZJ60LdQltLxa+vmEnMpUReHuJsVmzj
	Q3x7In+Fu5JWkEUc8zeUXayGYLmt+kkDxHk3idZABqbJECQfnDzHwEk/zm9K
X-Google-Smtp-Source: AGHT+IHQiZRlvp1MlJXHtvhg3HgpMrpaFRTtMCnTuaT6estlZCq1kiozWtVAYgav4EXcmiiFki55Nw==
X-Received: by 2002:a17:906:b7d4:b0:a31:1ee9:da54 with SMTP id fy20-20020a170906b7d400b00a311ee9da54mr227309ejb.60.1706307400430;
        Fri, 26 Jan 2024 14:16:40 -0800 (PST)
Received: from ?IPV6:2a01:c23:b936:a00:2153:65f5:37dd:e726? (dynamic-2a01-0c23-b936-0a00-2153-65f5-37dd-e726.c23.pool.telefonica.de. [2a01:c23:b936:a00:2153:65f5:37dd:e726])
        by smtp.googlemail.com with ESMTPSA id qc10-20020a170906d8aa00b00a34a47ca2b2sm1047973ejb.85.2024.01.26.14.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:16:40 -0800 (PST)
Message-ID: <f96621cf-06ad-4df0-a8d5-2635351ca8f7@gmail.com>
Date: Fri, 26 Jan 2024 23:16:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 5/6] ethtool: add linkmode bitmap support to
 struct ethtool_keee
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
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
In-Reply-To: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add linkmode bitmap members to struct ethtool_keee, but keep the legacy
u32 bitmaps for compatibility with existing drivers.
Use linkmode "supported" not being empty as indicator that a user wants
to use the linkmode bitmap members instead of the legacy bitmaps.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v3:
- after adding patch 4, use the old names for the linkmode bitmap members
---
 include/linux/ethtool.h |  3 +++
 net/ethtool/common.c    |  5 +++++
 net/ethtool/common.h    |  1 +
 net/ethtool/eee.c       | 49 +++++++++++++++++++++++++++++------------
 net/ethtool/ioctl.c     | 27 ++++++++++++++++++++---
 5 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 89807c30f..b90c33607 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -223,6 +223,9 @@ __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
 struct ethtool_keee {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
 	u32	supported_u32;
 	u32	advertised_u32;
 	u32	lp_advertised_u32;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dc..ce486cec3 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -712,3 +712,8 @@ ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
 	}
 }
 EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);
+
+bool ethtool_eee_use_linkmodes(const struct ethtool_keee *eee)
+{
+	return !linkmode_empty(eee->supported);
+}
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 28b8aaaf9..0f2b5f7ea 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -55,5 +55,6 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 				   struct ethtool_eeprom *ee, u8 *data);
 
 bool __ethtool_dev_mm_supported(struct net_device *dev);
+bool ethtool_eee_use_linkmodes(const struct ethtool_keee *eee);
 
 #endif /* _ETHTOOL_COMMON_H */
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index ca56f2817..db6faa18f 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -30,6 +30,7 @@ static int eee_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct eee_reply_data *data = EEE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
+	struct ethtool_keee *eee = &data->eee;
 	int ret;
 
 	if (!dev->ethtool_ops->get_eee)
@@ -37,9 +38,18 @@ static int eee_prepare_data(const struct ethnl_req_info *req_base,
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
-	ret = dev->ethtool_ops->get_eee(dev, &data->eee);
+	ret = dev->ethtool_ops->get_eee(dev, eee);
 	ethnl_ops_complete(dev);
 
+	if (!ret && !ethtool_eee_use_linkmodes(eee)) {
+		ethtool_convert_legacy_u32_to_link_mode(eee->supported,
+							eee->supported_u32);
+		ethtool_convert_legacy_u32_to_link_mode(eee->advertised,
+							eee->advertised_u32);
+		ethtool_convert_legacy_u32_to_link_mode(eee->lp_advertised,
+							eee->lp_advertised_u32);
+	}
+
 	return ret;
 }
 
@@ -58,14 +68,16 @@ static int eee_reply_size(const struct ethnl_req_info *req_base,
 		     EEE_MODES_COUNT);
 
 	/* MODES_OURS */
-	ret = ethnl_bitset32_size(&eee->advertised_u32, &eee->supported_u32,
-				  EEE_MODES_COUNT, link_mode_names, compact);
+	ret = ethnl_bitset_size(eee->advertised, eee->supported,
+				__ETHTOOL_LINK_MODE_MASK_NBITS,
+				link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 	len += ret;
 	/* MODES_PEERS */
-	ret = ethnl_bitset32_size(&eee->lp_advertised_u32, NULL,
-				  EEE_MODES_COUNT, link_mode_names, compact);
+	ret = ethnl_bitset_size(eee->lp_advertised, NULL,
+				__ETHTOOL_LINK_MODE_MASK_NBITS,
+				link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 	len += ret;
@@ -87,14 +99,16 @@ static int eee_fill_reply(struct sk_buff *skb,
 	const struct ethtool_keee *eee = &data->eee;
 	int ret;
 
-	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_OURS,
-				 &eee->advertised_u32, &eee->supported_u32,
-				 EEE_MODES_COUNT, link_mode_names, compact);
+	ret = ethnl_put_bitset(skb, ETHTOOL_A_EEE_MODES_OURS,
+			       eee->advertised, eee->supported,
+			       __ETHTOOL_LINK_MODE_MASK_NBITS,
+			       link_mode_names, compact);
 	if (ret < 0)
 		return ret;
-	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_PEER,
-				 &eee->lp_advertised_u32, NULL, EEE_MODES_COUNT,
-				 link_mode_names, compact);
+	ret = ethnl_put_bitset(skb, ETHTOOL_A_EEE_MODES_PEER,
+			       eee->lp_advertised, NULL,
+			       __ETHTOOL_LINK_MODE_MASK_NBITS,
+			       link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 
@@ -140,9 +154,16 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	ret = ethnl_update_bitset32(&eee.advertised_u32, EEE_MODES_COUNT,
-				    tb[ETHTOOL_A_EEE_MODES_OURS],
-				    link_mode_names, info->extack, &mod);
+	if (ethtool_eee_use_linkmodes(&eee)) {
+		ret = ethnl_update_bitset(eee.advertised,
+					  __ETHTOOL_LINK_MODE_MASK_NBITS,
+					  tb[ETHTOOL_A_EEE_MODES_OURS],
+					  link_mode_names, info->extack, &mod);
+	} else {
+		ret = ethnl_update_bitset32(&eee.advertised_u32, EEE_MODES_COUNT,
+					    tb[ETHTOOL_A_EEE_MODES_OURS],
+					    link_mode_names, info->extack, &mod);
+	}
 	if (ret < 0)
 		return ret;
 	ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5b2ca72e3..1763e8b69 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1520,6 +1520,13 @@ static void eee_to_keee(struct ethtool_keee *keee,
 	keee->eee_enabled = eee->eee_enabled;
 	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
 	keee->tx_lpi_timer = eee->tx_lpi_timer;
+
+	ethtool_convert_legacy_u32_to_link_mode(keee->supported,
+						eee->supported);
+	ethtool_convert_legacy_u32_to_link_mode(keee->advertised,
+						eee->advertised);
+	ethtool_convert_legacy_u32_to_link_mode(keee->lp_advertised,
+						eee->lp_advertised);
 }
 
 static void keee_to_eee(struct ethtool_eee *eee,
@@ -1527,13 +1534,27 @@ static void keee_to_eee(struct ethtool_eee *eee,
 {
 	memset(eee, 0, sizeof(*eee));
 
-	eee->supported = keee->supported_u32;
-	eee->advertised = keee->advertised_u32;
-	eee->lp_advertised = keee->lp_advertised_u32;
 	eee->eee_active = keee->eee_active;
 	eee->eee_enabled = keee->eee_enabled;
 	eee->tx_lpi_enabled = keee->tx_lpi_enabled;
 	eee->tx_lpi_timer = keee->tx_lpi_timer;
+
+	if (ethtool_eee_use_linkmodes(keee)) {
+		bool overflow;
+
+		overflow = !ethtool_convert_link_mode_to_legacy_u32(&eee->supported,
+								    keee->supported);
+		ethtool_convert_link_mode_to_legacy_u32(&eee->advertised,
+							keee->advertised);
+		ethtool_convert_link_mode_to_legacy_u32(&eee->lp_advertised,
+							keee->lp_advertised);
+		if (overflow)
+			pr_warn("Ethtool ioctl interface doesn't support passing EEE linkmodes beyond bit 32\n");
+	} else {
+		eee->supported = keee->supported_u32;
+		eee->advertised = keee->advertised_u32;
+		eee->lp_advertised = keee->lp_advertised_u32;
+	}
 }
 
 static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
-- 
2.43.0



