Return-Path: <netdev+bounces-155558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28706A02F70
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0961882E95
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC511DE89C;
	Mon,  6 Jan 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ43H9rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810F1DE4F1
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186718; cv=none; b=BYbDBiCibMvA1XHjM2qwhqRAmGmlppHJcYNSJRE/WFg5fSjhRdZCw0CTDYZhB7E8W4BIWgUIQXtxGlh8s5KvxlIXEyAY+hhx8b4MBXZhoD+4otS3RAD14pdUkvgBqegGV8UsTUkeFzjZO1DEC7NWwGVfkG5S6Mz2GskLlmLGaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186718; c=relaxed/simple;
	bh=2ofS9WWOmW9q9dpjY/gybK/HLt+BRsJhtacfxZeZlFQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pIqCFb0B5tTehjwlVoGhkhM5Qk2XB/hNOqgogmuKd0l/SpwJ8eqaI6G/ybusYQ0FuAheXi8B62mWIrmPzhgJQ7B1QzJF7idcpMY2Z5cAm7/LwRJwT+5Et8rCVfE4yn4z9FfYBbVU2nGZ1pHGPWVXS5ogd6OT+tn8ccqCV8k+tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ43H9rk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaeecbb7309so115757866b.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736186715; x=1736791515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UpGfN9yA5rtjygyZCZr0AAJc1kLEkTiuNusRLw8EH+k=;
        b=CQ43H9rk5oENbLxfy3XI4lI8SFTEuqpcuflGLPPoMIr3V5fvb/QTc0/b8/RjYR3pD+
         YtbglNC/mDSH+4KX1LAV1P0+76hJIzKhKw7k4TlZSGtb39u3zjeW3oZwYlzC4G7L24Nh
         slCQrRDas0hEk8QpWN9JE7LHI+swLbtKQLVljXnFwbaprLgsJG245ufjpIdLFHLfG7zi
         FWr3utKETaeIS8ryJENHQTEBcj5s57V2fWB4CIFrMaGLwHtzEhPlcfdbSmF8NhNlnx/i
         E8rtnsb+YzAyKXQjCClI+Gmez46VC7KKnDIqz6VF9ZIFVPWW9oHjP8OxxWJ0cTTjJzqD
         7aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186715; x=1736791515;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpGfN9yA5rtjygyZCZr0AAJc1kLEkTiuNusRLw8EH+k=;
        b=MbLzBv6YcFGiL6UwkkAHkwZVb1Yz/AIaqH/vTr7lyoF8k1BCTpbFDgWr9Y95uaEv0v
         Mbdz3Mr2LHVKt6wWYGKoCIS6uvdevad3pUk011A/OdAwuQxekoilrTbn4bnaXAl6w9OV
         hponmS4GMEV3pfsZh0EfWtvl/bC920+Oxv0xegFDrXd8jnUMeeNlP4VJHbe1nZHtTzPi
         dFxGJnRHFePILe2ZKvKEo5imvKmbliRVu5z2/+JTzM3RFobNolWDaUNFg/e3tybrRLSI
         9p5EPIJ2mBp1/ft9blrIBAbY4N2ad8GtFYHDC3mLycVvUFsot+C1fwqLwRfRhVn+62Fe
         ALPA==
X-Gm-Message-State: AOJu0Yym12U+Ve5i4AFaC6Yhrr94e5Bd6wKaXDledlj6bquWko1YHiMF
	+BffYY57VBux1Emds0oaxOp1z2+tlDdOQfHVXa6yJ1gMGsC8ZErX
X-Gm-Gg: ASbGncvmDXv4gy48SseO9AbHH48WImX2EvO3q2Sl0/GU1TDJKTG+rVh5nNuVP5lEEBy
	kZOUmxwsiyJbMy00Re5CkkYELwyZoYLs1Zb02YzEOy99R8TmhQ4S0Q+9pwDKlrYA69Ox9dYbxpT
	ACBPQpKJEAfTrWOhT65J6TCKriiCGQwW6EHPKPB1szkN1CRwDc/TwBBBuUZv29jNcHmtY07wmpi
	BiaFvHZu87tl/T2l6/J8Tm+ZgJmnK3QOuWYnRBrdwYVwcQpcqOT2GeafvWoWbHAPlCVI8TmIkXZ
	UowvWJKUdMgnq4SYVsxRigPT4aVFoglrAmhvgGIVeXvynw6SlWSvDmBxmRDmR2yTxeupb8F2kaN
	f6e5CTWwD9c8EM2Td9LSkp+JxS/56L+LijEaLYUCN
X-Google-Smtp-Source: AGHT+IHzIPNIVUbZU+Gg5/kO87Lp9x8AvDtEdLh2MiOCd796Jzbbxus3NkEVhwwtLbYF4Y3ShgYPoQ==
X-Received: by 2002:a17:907:da4:b0:aa6:8bb4:5030 with SMTP id a640c23a62f3a-aac269598damr5512941866b.0.1736186715306;
        Mon, 06 Jan 2025 10:05:15 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0e89887csm2283658266b.80.2025.01.06.10.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 10:05:14 -0800 (PST)
Message-ID: <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
Date: Mon, 6 Jan 2025 19:05:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] r8169: add support for reading over-temp
 threshold
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
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
In-Reply-To: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for reading the over-temp threshold. If the chip temperature
exceeds this value, the chip will reduce the speed to 1Gbps (by disabling
2.5G/5G advertisement and triggering a renegotiation).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 38f915956..fd6ff77e8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5357,6 +5357,11 @@ static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 		raw = phy_read_paged(tp->phydev, 0xbd8, 0x12) & 0x3ff;
 		*val = r8169_hwmon_get_temp(raw);
 		break;
+	case hwmon_temp_max:
+		/* Chip reduces speed to 1G if threshold is exceeded */
+		raw = phy_read_paged(tp->phydev, 0xb54, 0x16) >> 6;
+		*val = r8169_hwmon_get_temp(raw);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -5370,7 +5375,7 @@ static const struct hwmon_ops r8169_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info * const r8169_hwmon_info[] = {
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX),
 	NULL
 };
 
-- 
2.47.1



