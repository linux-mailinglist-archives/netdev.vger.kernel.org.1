Return-Path: <netdev+bounces-148205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E189E0CFE
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E94B25796
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AA1DED4E;
	Mon,  2 Dec 2024 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwSQTXS2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20A1DE89C
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170807; cv=none; b=mwjRN/ToIKMXWGRmdcp1AWsdpBWYsx1N5l1Yn5rVnbYyi0HiltnWwr8Ex1Dz3dUFgx89Tt/akqX0wg4vnS75wHNIdozBltPdn9ODbJBWG+FqIhrjBuCF8F26WEaRGWQyriSj+u0thZT7oMeV6GQHUOEHzuXrESXbecO4ZPI5Z/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170807; c=relaxed/simple;
	bh=eD9JlWVxz2wIFsQ2K5NIv2XkhL4aTylnvWQgBTYymCc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=S8F9B+cQEp9EXBgj3SsUH+9WSiE3J7t3KPmJxuunFUUZjTBpUOpidsDXrH5VAI6gYgsCHM1s5t5I8sZnbuyuqphP3DOuQI16SZbUGWSsupy7xQy0oWhyf3AP1gaMjKvLfZ3/N91H5HDZV1GFNLviSxmazqzbVYSVvSfMb1fJ99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwSQTXS2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso689084166b.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 12:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733170804; x=1733775604; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7YfJ8qO1unlsHzB5DzvH8j7mMxdgq2lDZAgh/WBnaDI=;
        b=KwSQTXS2ofWGn5NQn2a0zy4nRUXmMc+4yqJIDy7vsbcGzY09cfVTlmeH4o26eTVnMy
         ub9/+Sn38JLhHAjzbiBC99U0J7Obi9vR3iQWJWPncLOImcNeFGnIcQUpmU8GpO51XOoY
         533TOOpNm4U8b7ZjDih3Hkv8ylGj89xUtb1W6W35u/U+bLwUTOIn+yMjyUQhJK1DY7sy
         PeaXw8I/ZxZo1vl+rQZ/6z9MfrY8aQdWwE5Xh+J4ABhkKNMKtIE5Udbm2BLNAeS/7b4T
         P7FbGaJzJ4SapcltIpSh1NkPEzLJuupWuWHdK4Ljssu6XG25G4a7APFe/YRhGWBTYW60
         BVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170804; x=1733775604;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YfJ8qO1unlsHzB5DzvH8j7mMxdgq2lDZAgh/WBnaDI=;
        b=CfKIpfMCIjnSP+ys93t52FdnTP1EzAVoZGK4/lYJtWoPfmw2EQjrwef5EQCE5j7Kv/
         nYtNX117N8vcB905AcWV9G0noh0guqU5oBJ1pM1YI3JjP1etypgIX8352t4j9T4Hjl2Z
         Q11HfLNTm6Cq8Ri516A12JP4EkeXA98LQp9+1vX6Tv/amNq0xiRPPVd7QQJ9e5TiYoB8
         G++PWWtKrnRZ602bnw2HYvNXz1hEqLNFaNKTTJG0SjpDT3hqY6HixiJgPFY5uhkTGAXQ
         Ym7YPANc2Wp+xmKUoUoU/vViGHaPVSbuN3FYLJXW+H0dYRDyD09DzgIdcioYP4l9pvpy
         ibpw==
X-Gm-Message-State: AOJu0YyhZAp2ujMUbW+EgVH6XvEN1oVNttFfguxCKjhrvQfIBXC2F/j9
	38jOikLmx7XjYR8zEc8mejjtaoPGFvpzr9H4A1FAd7VcNh942B9v
X-Gm-Gg: ASbGncs4g+ZFzUSnOcRCaNQo/wGLjuBlDgigY5Nfnu9OAgWsIxWJllaiZTpH8ktgP0R
	Iy3IBbOwMqthaS/zxrZ+UaT8746/uEekWTWMNVXmc/igcmEmOqSc4ldBi4bkUpnvJfF9g14iV29
	NzrJwH653YWi6vtTLuOmYVE1KL6lK+wL02atvhQ4AgTh0o4ClF1VK/yj8wvzGpveoeR6GMDPavK
	XmeDD7oSwS4Ax7Hper2USdOwf3MxQJWcza6U/xqRW7tGT4hojr4j/B1TIZVRWOLQ7LkDqRFmH4W
	YyRVKGjw/mWVtV9bKx1qm6Kre2t9LDr41FO/qQKk63YWQXFTANSlGlRp6WUe90Uuadq30kA9FP5
	EyzpfQjGiwnRg+co437OcGBQeymOuK26TpYceOYZABw==
X-Google-Smtp-Source: AGHT+IFvbpz4TO3qyW9XLm+g13Lhg/8Ur13yIvWUEs8JCsYn8xmSg873YnXcwC8oihuuddnY8boBPA==
X-Received: by 2002:a17:906:30c7:b0:aa1:e51d:cf83 with SMTP id a640c23a62f3a-aa580ed0287mr1868459866b.11.1733170803574;
        Mon, 02 Dec 2024 12:20:03 -0800 (PST)
Received: from ?IPV6:2a02:3100:a4d2:4900:2dc5:1fb9:a62c:2977? (dynamic-2a02-3100-a4d2-4900-2dc5-1fb9-a62c-2977.310.pool.telefonica.de. [2a02:3100:a4d2:4900:2dc5:1fb9:a62c:2977])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5998e6a1asm541215866b.98.2024.12.02.12.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 12:20:02 -0800 (PST)
Message-ID: <b689ab6d-20b5-4b64-bd7e-531a0a972ba3@gmail.com>
Date: Mon, 2 Dec 2024 21:20:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove support for chip version 11
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a follow-up to 982300c115d2 ("r8169: remove detection of chip
version 11 (early RTL8168b)"). Nobody complained yet, so remove
support for this chip version.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h            |  2 +-
 drivers/net/ethernet/realtek/r8169_main.c       | 14 +-------------
 drivers/net/ethernet/realtek/r8169_phy_config.c | 10 ----------
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index be4c96226..8904aae41 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -23,7 +23,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_08,
 	RTL_GIGA_MAC_VER_09,
 	RTL_GIGA_MAC_VER_10,
-	RTL_GIGA_MAC_VER_11,
+	/* support for RTL_GIGA_MAC_VER_11 has been removed */
 	/* RTL_GIGA_MAC_VER_12 was handled the same as VER_17 */
 	/* RTL_GIGA_MAC_VER_13 was merged with VER_10 */
 	RTL_GIGA_MAC_VER_14,
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 432a4f41a..e846a6457 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -104,7 +104,6 @@ static const struct {
 	[RTL_GIGA_MAC_VER_08] = {"RTL8102e"				},
 	[RTL_GIGA_MAC_VER_09] = {"RTL8102e/RTL8103e"			},
 	[RTL_GIGA_MAC_VER_10] = {"RTL8101e/RTL8100e"			},
-	[RTL_GIGA_MAC_VER_11] = {"RTL8168b/8111b"			},
 	[RTL_GIGA_MAC_VER_14] = {"RTL8401"				},
 	[RTL_GIGA_MAC_VER_17] = {"RTL8168b/8111b"			},
 	[RTL_GIGA_MAC_VER_18] = {"RTL8168cp/8111cp"			},
@@ -2335,7 +2334,7 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 
 		/* 8168B family. */
 		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
-		/* This one is very old and rare, let's see if anybody complains.
+		/* This one is very old and rare, support has been removed.
 		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
 		 */
 
@@ -3803,7 +3802,6 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_08] = rtl_hw_start_8102e_3,
 		[RTL_GIGA_MAC_VER_09] = rtl_hw_start_8102e_2,
 		[RTL_GIGA_MAC_VER_10] = NULL,
-		[RTL_GIGA_MAC_VER_11] = rtl_hw_start_8168b,
 		[RTL_GIGA_MAC_VER_14] = rtl_hw_start_8401,
 		[RTL_GIGA_MAC_VER_17] = rtl_hw_start_8168b,
 		[RTL_GIGA_MAC_VER_18] = rtl_hw_start_8168cp_1,
@@ -4679,12 +4677,6 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if (status & LinkChg)
 		phy_mac_interrupt(tp->phydev);
 
-	if (unlikely(status & RxFIFOOver &&
-	    tp->mac_version == RTL_GIGA_MAC_VER_11)) {
-		netif_stop_queue(tp->dev);
-		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
-	}
-
 	rtl_irq_disable(tp);
 	napi_schedule(&tp->napi);
 out:
@@ -5103,9 +5095,6 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
 		tp->irq_mask |= SYSErr | RxFIFOOver;
-	else if (tp->mac_version == RTL_GIGA_MAC_VER_11)
-		/* special workaround needed */
-		tp->irq_mask |= RxFIFOOver;
 }
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
@@ -5300,7 +5289,6 @@ static int rtl_jumbo_max(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
 		return JUMBO_7K;
 	/* RTL8168b */
-	case RTL_GIGA_MAC_VER_11:
 	case RTL_GIGA_MAC_VER_17:
 		return JUMBO_4K;
 	/* RTL8168c */
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 5307c6ff4..b28b30390 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -276,15 +276,6 @@ static void rtl8169sce_hw_phy_config(struct rtl8169_private *tp,
 	rtl_writephy_batch(phydev, phy_reg_init);
 }
 
-static void rtl8168bb_hw_phy_config(struct rtl8169_private *tp,
-				    struct phy_device *phydev)
-{
-	phy_write(phydev, 0x1f, 0x0001);
-	phy_set_bits(phydev, 0x16, BIT(0));
-	phy_write(phydev, 0x10, 0xf41b);
-	phy_write(phydev, 0x1f, 0x0000);
-}
-
 static void rtl8168bef_hw_phy_config(struct rtl8169_private *tp,
 				     struct phy_device *phydev)
 {
@@ -1136,7 +1127,6 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_08] = rtl8102e_hw_phy_config,
 		[RTL_GIGA_MAC_VER_09] = rtl8102e_hw_phy_config,
 		[RTL_GIGA_MAC_VER_10] = NULL,
-		[RTL_GIGA_MAC_VER_11] = rtl8168bb_hw_phy_config,
 		[RTL_GIGA_MAC_VER_14] = rtl8401_hw_phy_config,
 		[RTL_GIGA_MAC_VER_17] = rtl8168bef_hw_phy_config,
 		[RTL_GIGA_MAC_VER_18] = rtl8168cp_1_hw_phy_config,
-- 
2.47.1




