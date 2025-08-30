Return-Path: <netdev+bounces-218487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9671FB3CA2F
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 12:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E727C610B
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C1A27586C;
	Sat, 30 Aug 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8UKIG8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777125BF15;
	Sat, 30 Aug 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549734; cv=none; b=N7RnpaMJnAa4Z+pIsd/LIlrm0LPkv4nhnk6za42H5cT24K38ZfuvZlJ7ym3ksx+sc8vMrETcu+bY1xknVIAwi1kgFVQ/6zb4+1XKx08gadvZkp6/7qlGycIla/QJnGOxLUnIk/31o69W4T3GLcUITBH5yRrTM8Y1FRJs9VzYmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549734; c=relaxed/simple;
	bh=+DwoslA7/kfwqHfljxKUTzfBmEeaGG9DKg+W8ghJOwM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CwzcdqZIQqTmz3JTnnbFUsNSM9HkQsfC2Zx0FfZDRRtF+Z9Pg8ggjGlE/okoDg3Eovd019xsKT83M7uLJJVpaQDGp/KUt1UDl5JUN0HiIddhgt3pgjFerqUPi/oqffoJAsLrf3SeJ41M1dm14mYCNzLDwyiKbamV6XBETvvPmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8UKIG8u; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so275205f8f.1;
        Sat, 30 Aug 2025 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756549730; x=1757154530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WHgH8oy5n+l+ZwlFEabPRf0dx6W3J1c630BijBzFt9g=;
        b=B8UKIG8uD3IKrd0XPxZ/k99Jc6eeltI3qoy/3uE7yTpOVetIt8pZCC/WpsLIAfeaFE
         sj6+dbNPnMrnaUt+IVc4ahoQVwdSXT79huBF8HCcd7do49Xib6VbCXgKkFBVsjiwl1fU
         NWexTH4F1+kgysGNS9G40LKHv82q0OqS/syTSqliWdgKih474Fn2Wf86SpjnO13rd2Gb
         1R1TGcIWOKcospdokEgvHpwzJKCEF5r5SAsczGrMqDlXGPLaMRasc/jIPW7NZPJ6Las0
         GxuqxXTOTiyep7tRLJHGjnxAMYWEXacjTlsndb6+1CnhcCLuK17QY36jTev9e3+7bmkL
         LK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549730; x=1757154530;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHgH8oy5n+l+ZwlFEabPRf0dx6W3J1c630BijBzFt9g=;
        b=YlkrIECoq1mtmnRCKQfavpwGU0n415k5XdQq0BVuq1xI9e6FPbuc+QmuRc7G4ZUay/
         neZeRkCwPSPAsuaHvNeKCr5mLD/jJrrVdm8ZY/dEoj4kT6YXrTtgME8FFsLHEsc95gMW
         0KJCfRiquuz5llJOAjoXRsdgH4zeLlSgjavlrw7qMaa3JyYMHFKNL5cyzsEjNKTmjJo4
         ew6WGcv+qLPRXVRAdsAaKbre1r5/HCWNcbAx6dy2QRWQo++TT1Z0+nztTo2ICGW+3fst
         tF7/0/Nbyl13nJB4D7I6Jiewvmvs/usPtp6YqEnbCEC3lRpLzgxo5Ala9ltF0r9Pc8/+
         OGHA==
X-Forwarded-Encrypted: i=1; AJvYcCV44Z9hrO+eDs9GgZ7ZCIRXYZDL5cDtUkHD2hNxvvvxHX8ul+Fuqk7u0W3M3BR3rmoUkhxZsj3u@vger.kernel.org, AJvYcCVpNX7tFP6iezYXPBsMpnJwGwA0xONxbPRov/xKapav/xD5GjYbFNMMJNCZk3Bnk2Tdufq8RQxtdlUg@vger.kernel.org
X-Gm-Message-State: AOJu0YynGoEb59PrS0CWyErID+cgFPGzfb5ng600eaKErNqWiJLWu2eE
	4YIxfVSL/qPdSQJ7EKj1kZ5W+/vtMmQjdO/yrr/nLAN/zhZJxBOjCviV
X-Gm-Gg: ASbGncu8gird0ej0xmFYF+LIHPECq9eAHpKaBdl8wZHfKamI5uIApSOTWxQru15DrLb
	unRBPhxGS0BFLnrac5ZJ9SCU3Tp2LZCc7R3K1pjSu5S0DjbVlotpqtmJrV0io0Z7oH4Cu6anN0r
	yrAXWmfR6QEIkvzDFBvjfNhjaL61Wr0Haa1qBgwGXbftBny4zMXsM7zdKZ/lw5MkIoEIULsZLzV
	Bo6huqbW3kX975A9fdUGYukTboXX8AhDbmJR/njNPhPuqTR36JFXyw3UBGXYjOA8TGqpw7Z94yH
	/Zq3OFyvPTxnpoyESEkT+lv6I7mlt8bFDxxF2Vc7xc6JBe4xEKBMkpL/ukc/xOIqmIkOOwUsFib
	fISAo9TxGDaackb1uAJEUMJQJYqpbnMjNmmdimJeEm3eUeiKHXG9OaYAcpSWu31NXR7Lt1OqPN3
	T+Sc4D1FPDp9S6IpgGEKnSnG5Kvre3uJxnaW0r1iJMCMvTZiKrgnCYX4c0MvBYNqiOpxI=
X-Google-Smtp-Source: AGHT+IHVJCd/+HdJVP9uB4pTqlOmy229F5d8tyap6dwLZFq0cuUVPwza6+iNT3KkXtyV+TvLcVITKQ==
X-Received: by 2002:a05:6000:250a:b0:3ce:7673:bb30 with SMTP id ffacd0b85a97d-3d1b16f01e5mr1648635f8f.14.1756549729740;
        Sat, 30 Aug 2025 03:28:49 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2? (p200300ea8f2f9b00080ca2fc7bcf03a2.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf276cc915sm6584706f8f.21.2025.08.30.03.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 03:28:49 -0700 (PDT)
Message-ID: <e5fec041-14b8-46ba-9302-25c34a30241f@gmail.com>
Date: Sat, 30 Aug 2025 12:28:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/5] ARM: dts: st: switch to new fixed-link binding
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
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
In-Reply-To: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The old array-type fixed-link binding has been deprecated
for more than 10 yrs. Switch to the new binding.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm/boot/dts/st/stih418-b2199.dts  | 5 ++++-
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih418-b2199.dts b/arch/arm/boot/dts/st/stih418-b2199.dts
index 53ac6c2b7..5231222b7 100644
--- a/arch/arm/boot/dts/st/stih418-b2199.dts
+++ b/arch/arm/boot/dts/st/stih418-b2199.dts
@@ -103,7 +103,10 @@ ethernet0: dwmac@9630000 {
 			st,tx-retime-src = "clkgen";
 			status = "okay";
 			phy-mode = "rgmii";
-			fixed-link = <0 1 1000 0 0>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi b/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
index 8d9a2dfa7..f45c65544 100644
--- a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
@@ -147,7 +147,10 @@ ethernet0: dwmac@9630000 {
 			st,tx-retime-src = "clkgen";
 			status = "okay";
 			phy-mode = "rgmii";
-			fixed-link = <0 1 1000 0 0>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
 		};
 
 		demux@8a20000 {
-- 
2.51.0



