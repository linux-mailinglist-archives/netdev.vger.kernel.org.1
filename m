Return-Path: <netdev+bounces-141205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F329BA09F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459821F214E1
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67E189B88;
	Sat,  2 Nov 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhwPCZdF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F61607AA
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730555347; cv=none; b=QBbv171LkkMdHKUvwzpXrPlvDF1LWVpe/XVf+gFjdjy3n+jsgBIslsh+5NGIIMePxDRJKOEMJVME+Vk86lQ4KR2VMRp7JRiR0cHo5QYuXDneX+Sa3ep0EYE//UVOG+jN7QB6Dpzs3pgKWbcdl0Cb3envTs3RoXTBR06hOaTsLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730555347; c=relaxed/simple;
	bh=KAT6xDBCYhFOYv5uuh23BI0MorIZBUwPnnsMDDYzjQ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AmjkPUtLnaZSgRDKUF55foXYUiOZs6RNw2M3zmzSPrQ/AZ0FyLE7cD0fAMAmJ71I8Ow3xaVhKTPJfHaQ/EmYVEqmbd5959u5NrvpTK1aJiGE9/d67LZxe+jYtI/qMVm0/4S3unJL5IsCukBxFO/2EhMKXEvNNs6BSMPFSUVVWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhwPCZdF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d495d217bso2390469f8f.0
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730555344; x=1731160144; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0gn0+0kCyGcbKOERwBLVRrtZlMrbhnFqbK0nTYSSWc=;
        b=FhwPCZdFsjAlmKzXEvU/VJG4cMWxlN0DdRsu3nsuKOTjJZpU4KrpXVTBMqGK+DzgiC
         6sKXs7KcFlr0Q2mcXN5Ia75elEdV2mrAxlem3LZ/nCojOARBzNSjQ5cVgXg9pNLrXb4w
         ffaqzGhxeBOhOAwbMkcIdXYA5Lz3f/3rLFSoWldjQmqIMtkPAvbw/nlJWygUsQzQgFN/
         FnINUOzwmH/WC498ZQhKFr9cBk3B+N4O9KXfOZGfupB5mRkEFTlGoiu2G5GD+4G3UTHU
         AYUwlYgqEvI68/X85zytTm8IwQwSxjSs6gyPk/+wGdiFuPb86vLhejjKBBKJQ26RtIW6
         192A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730555344; x=1731160144;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0gn0+0kCyGcbKOERwBLVRrtZlMrbhnFqbK0nTYSSWc=;
        b=Pc+iJ2ETUnbv9aYLbI/ia90hBkINCzt+CLxBtO1iZqzlk11fr2Dd4GulaoFFjb9dam
         +3UGzic3Er1LOcH57K6Uq3d8FHGwcwGVYCZEswxPhg4AXjHOyjPZCTdH3fScizNU08/g
         kLbmufvpvy1U2jtF44kaGNdwJGWRmKHc3VbvY3BPBdoO52tRfgP3YfnnxgKF5r6zRnpV
         rUOLr3dgYUMfKpLcySadRv4F2xqMmEyQhsJSwBXuU7MampbipQjLt+fU06EUvD3TPwWk
         9Ts7MH06Zg6abbtjZrXHBTR575exTGO7DlMhJQQX7speS5tc0JnMipaJvluP2I1JpHyZ
         uTFw==
X-Gm-Message-State: AOJu0YyiPMZnR9xJLRDjcHtgNGsf2VHpIpna9+ZPrCq+PfDMwaKUAZ9U
	Y41CAs14CnRyQlLsDN4i8PGy4S9Vt78z3ZfyCxIa3SNHp3b0UU0G
X-Google-Smtp-Source: AGHT+IHnuzaYENphdjOGEw5xpHVlhkswdPf+t4+R7odLncs4BT/amymMsFxSKG+R5nO7UY4bK85DTw==
X-Received: by 2002:a5d:6dab:0:b0:37e:d2b8:883a with SMTP id ffacd0b85a97d-381c7a464c6mr6843029f8f.12.1730555343577;
        Sat, 02 Nov 2024 06:49:03 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a029:9600:b581:b80a:431b:19ed? (dynamic-2a02-3100-a029-9600-b581-b80a-431b-19ed.310.pool.telefonica.de. [2a02:3100:a029:9600:b581:b80a:431b:19ed])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e564c5332sm309969866b.65.2024.11.02.06.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:49:02 -0700 (PDT)
Message-ID: <3bf2f340-b369-4174-97bf-fd38d4217492@gmail.com>
Date: Sat, 2 Nov 2024 14:49:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: improve initialization of RSS registers on
 RTL8125/RTL8126
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replace the register addresses with the names used in r8125/r8126
vendor driver, and consider that RSS_CTRL_8125 is a 32 bit register.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4217768c8..647dd3880 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -347,6 +347,8 @@ enum rtl8125_registers {
 	TxPoll_8125		= 0x90,
 	LEDSEL3			= 0x96,
 	MAC0_BKP		= 0x19e0,
+	RSS_CTRL_8125		= 0x4500,
+	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
 };
 
@@ -3756,8 +3758,8 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	rtl_pcie_state_l2l3_disable(tp);
 
 	RTL_W16(tp, 0x382, 0x221b);
-	RTL_W8(tp, 0x4500, 0);
-	RTL_W16(tp, 0x4800, 0);
+	RTL_W32(tp, RSS_CTRL_8125, 0);
+	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
 
 	/* disable UPS */
 	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
-- 
2.47.0



