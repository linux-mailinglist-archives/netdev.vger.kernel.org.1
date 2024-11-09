Return-Path: <netdev+bounces-143561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8679C2FBE
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 23:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365CA1C2085B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425231A08B5;
	Sat,  9 Nov 2024 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp8CILjX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2E1A0B05
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731190337; cv=none; b=gqPP3lWci0SU6/aI+LUyk6rOL0TsyB2VS1NBrLdKvMX7+vDEL0AxC6osUDmm2gfTlL9NtridGH6R6yz2em0/yhgcSf8xgubarPIgiEykxC2kBrMarRIOzpgpD8yR88vOmHHJu54EO6IHKQiW0xIh12fj+Gw0m8g72gbWo8nkjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731190337; c=relaxed/simple;
	bh=BrZvujyHQ8fFNznMcs2JTLj4neQDd5To8S3GXQENpuM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=oAvq6qpU0b04rkYBJgomwesJskMzbH8KmBKgBVj3fZ65fJ+w+WLvuPuUacB6YTpcyOuNxNfF0NZ5+swriO/YEtVeALzkxeC1zA7n09zeFhBfI/H6I8bXG8RaHFFEifKtjRJvaVAeMQw6x0BC1JaznJVjNFApn6X+uRA3toW7sWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp8CILjX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43158625112so29424235e9.3
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731190334; x=1731795134; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rmH9YmssOx4npjXL+IaxRHchhbFrAsmI2/rR+nZhMTk=;
        b=hp8CILjXh+hv90RDO7kJCGZiD4kEEn8M7kMzccjSWtxps6OVX670bVsx7q6ZmgkJpI
         XvxbMsbBWaOGP6GO7OgHJq8zpEb9Jg2VkShtbgrPZqh2r0XjNvEVLwKTpi0RkpXeHJQV
         6DiHDAuZ7pcls0PeRI+kmnXwF1IxIzo/e404vNT5pZPIZ7Cwyba9Ssbuoynb6+p82X5g
         eU8z9FpjMbW83r1I6CjjoSSoNoFSzTDP1PO2l01MmYgL1AUtd9iyNeRz13brAmE7j0fU
         +e1M4SKU1tQZpUWV67Og0kEGzeQNuG+tklEAM9H8/XuVMsg9Prno+q/2P3+MK45Uz9B6
         NLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731190334; x=1731795134;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmH9YmssOx4npjXL+IaxRHchhbFrAsmI2/rR+nZhMTk=;
        b=TTnoi3JTfyZzQ5mj3sGeJowtAc5msZsrjxy+dInKijPPJWAmnn5e78mU2hDFGt/b8D
         3Ub1Pthkel7DgA4OXu0XECIICfV6sIoF8qxnm2xkPlotKyqDL+N7hGgCSWUhZOFgNMTE
         zQtTkLzxBwmJub6yluAYVELACWYLm6gdaOw7Th0OWSG3ykie1bgHT17XJWzKyZo5gVkO
         3sjho+ZL72IXtaj6qmXQuYfP5sEWTI3PMiS3CxpgSnXU53EZOxYyCl1eF8NKbL5Rek4X
         TP3ZV7vlflmf939dJcyrBTNai3T+np1BE4KHS6M2QQV9b3w/TMzkFg8ThFVVbn6tqFXx
         qFZw==
X-Gm-Message-State: AOJu0Yzt7oUTtwcpIDYl+vUGGxVhty6JqJK0K2NrGOxJlyRGO3oLptsK
	OJD/CBpaEnTtuVFPgpUAke+lkuonWQJijhTEHPNzX9nZft3xpymnJce0iA==
X-Google-Smtp-Source: AGHT+IFLifpsElhrepbiRXkkSvq9TFIB0xa5eZGi99rwRQ9qURyyV9RT/U1YTe4lq1P34fRhTKX2Kg==
X-Received: by 2002:a05:6000:410a:b0:381:f5a7:9baa with SMTP id ffacd0b85a97d-381f5a79bc3mr3611651f8f.0.1731190333641;
        Sat, 09 Nov 2024 14:12:13 -0800 (PST)
Received: from ?IPV6:2a02:3100:a1ef:1400:29a4:a976:2b3:b90f? (dynamic-2a02-3100-a1ef-1400-29a4-a976-02b3-b90f.310.pool.telefonica.de. [2a02:3100:a1ef:1400:29a4:a976:2b3:b90f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1d8sm162032135e9.27.2024.11.09.14.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 14:12:12 -0800 (PST)
Message-ID: <3df1d484-a02e-46e7-8f75-db5b428e422e@gmail.com>
Date: Sat, 9 Nov 2024 23:12:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: use helper r8169_mod_reg8_cond to simplify
 rtl_jumbo_config
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
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

Use recently added helper r8169_mod_reg8_cond() to simplify jumbo
mode configuration.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 77 ++++-------------------
 1 file changed, 11 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 24a3cc4b9..739707a7b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2543,86 +2543,31 @@ static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
 }
 
-static void r8168c_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | Jumbo_En1);
-}
-
-static void r8168c_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~Jumbo_En1);
-}
-
-static void r8168dp_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
-}
-
-static void r8168dp_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
-}
-
-static void r8168e_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, MaxTxPacketSize, 0x24);
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | 0x01);
-}
-
-static void r8168e_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, MaxTxPacketSize, 0x3f);
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~0x01);
-}
-
-static void r8168b_1_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | (1 << 0));
-}
-
-static void r8168b_1_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~(1 << 0));
-}
-
 static void rtl_jumbo_config(struct rtl8169_private *tp)
 {
 	bool jumbo = tp->dev->mtu > ETH_DATA_LEN;
 	int readrq = 4096;
 
+	if (jumbo && tp->mac_version >= RTL_GIGA_MAC_VER_17 &&
+	    tp->mac_version <= RTL_GIGA_MAC_VER_26)
+		readrq = 512;
+
 	rtl_unlock_config_regs(tp);
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_17:
-		if (jumbo) {
-			readrq = 512;
-			r8168b_1_hw_jumbo_enable(tp);
-		} else {
-			r8168b_1_hw_jumbo_disable(tp);
-		}
+		r8169_mod_reg8_cond(tp, Config4, BIT(0), jumbo);
 		break;
 	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_26:
-		if (jumbo) {
-			readrq = 512;
-			r8168c_hw_jumbo_enable(tp);
-		} else {
-			r8168c_hw_jumbo_disable(tp);
-		}
+		r8169_mod_reg8_cond(tp, Config3, Jumbo_En0, jumbo);
+		r8169_mod_reg8_cond(tp, Config4, Jumbo_En1, jumbo);
 		break;
 	case RTL_GIGA_MAC_VER_28:
-		if (jumbo)
-			r8168dp_hw_jumbo_enable(tp);
-		else
-			r8168dp_hw_jumbo_disable(tp);
+		r8169_mod_reg8_cond(tp, Config3, Jumbo_En0, jumbo);
 		break;
 	case RTL_GIGA_MAC_VER_31 ... RTL_GIGA_MAC_VER_33:
-		if (jumbo)
-			r8168e_hw_jumbo_enable(tp);
-		else
-			r8168e_hw_jumbo_disable(tp);
+		RTL_W8(tp, MaxTxPacketSize, jumbo ? 0x24 : 0x3f);
+		r8169_mod_reg8_cond(tp, Config3, Jumbo_En0, jumbo);
+		r8169_mod_reg8_cond(tp, Config4, BIT(0), jumbo);
 		break;
 	default:
 		break;
-- 
2.47.0


