Return-Path: <netdev+bounces-195938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C3EAD2D73
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C60F16FA7F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841425EFBE;
	Tue, 10 Jun 2025 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmbfDGIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2E259CBF
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534221; cv=none; b=YyJX1Gf16Vk6//8uHJGL596sIDhqlz96AblQQKyJDo4ZSKtYua/UplDocdvMei64W7zUjVEaVLh6HznH228j5v2EaadWDOSK8rbOwbOLCJO/kltTuH0wv1PJhHSiBRawOqbJPa/KYFwN243O7qBOekZxPgbPOzTVnCxL6fe7IkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534221; c=relaxed/simple;
	bh=TpZQUkZD/0/znO/mvohm8jB09vSGl+Ce1dJ4Zn7aiXE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=QosRlnR056GpJbRpV/aWxh4GakNGeRalI7CduTaCjGTxgdHsv0MUT8B00Eog1XCyLK4/XrOjzgcnisdl1R2Gltk8q+lKjsALppwk5L9fm/FGFPenFN61WdzUdRZYFGunvc6a+/W5tsC+m/zu9jivyCKUUPOaWlyzwpvk7GETqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmbfDGIV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so30950795e9.2
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 22:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749534218; x=1750139018; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfRZPZTuFzasJ+ZPz9XWfHK9jyJlUykAcEoNSEdkP+o=;
        b=nmbfDGIVrgxcT/suXCJXi6aBxTuBHNjuUK62x2+MoUq3S4Noyr24rRchifBhWkmTen
         yFmwND8KPMh8wvi9ygO2WX9+y0wtWzRAWG+HRY7Ca441A7wX4bb2DZ4PA1WP6op8zeT4
         CyNf/wbquJFeBVQxLsQgGAZq0k6KIOEcv2RLJM0DplMXaV10xHYEHDXPrPzRBGxA7o6k
         N1+QNy2zUhWmZDdf3lzae3sp9ynn1AW3zRv/GVnOBSASuX04mdwaL08OpuGC4otpA1tM
         w6DT1lMi3MxmPKfs9ed3Ei1maT8wjskFAa03v8XDj34/4RTHOPGFcs0Qh5q5jQczYz1b
         4fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749534218; x=1750139018;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfRZPZTuFzasJ+ZPz9XWfHK9jyJlUykAcEoNSEdkP+o=;
        b=on6UNVK2qnC3zu3rjavxlNJ7gG4f9bReyKKOpcqZjHM0FQnYI9bFMMjSjJI+QJf+j/
         UxAsflusgzw2H1U4b3AiSVo6fUftUUF5M+2RrzsAYVdU8p8BiT5DQvGNq7iVOaa+5OUr
         hpOTK5/UDr+Shkpma0c3ALwTGvsJoDVe1D2MDKj59E269QELIcT35NqA8z7R2WPeKjBq
         tmfV2y98nY1NuNNYYTzkcUEUwtWIptkosLd6NsxgEiX3Uu6av/xurvazYNBum60MRPQG
         rhNQL3AEkiyonhb3BI8rO+C6zKHBVZZvipqXiFM8J0mJl+pfJBQsJSwwi52m+L4OUHGK
         /4dA==
X-Gm-Message-State: AOJu0Yzd3CEF48Gelu+psWySZQKa+xgX6cjY4SJPHiJJfb86G++G/WCj
	XgCuwy8L3B9ki8eR3uFXHOoscgqWocgQpw1N6yofvOKRgH7CEjgcDAdE
X-Gm-Gg: ASbGnctfKrjy7ndQfSQRQvgQWz/6+bxc8XEQXo9FoJGm+ckRKWkKR9wZZPu7pDHr+SA
	/OL5hAOo0wiIjvczlmd4hCvD6wFaj1BHsRMd7C4pAN2H8hZSjTASwXb8TDWdRSJASO8a6bSsYIJ
	2/Qlk5d/OZ9ExHRV99ybKlZ0GYrcLUVKFEtt5PmOo6h5Un/P6tSrIiP+V2cGvzCOtWyLIZl7XCm
	PL3cKmmm7XhED8qknFKpjMkd8yIP7CRbH7lU0tdEHeEZkC3WDV57xMCBL/LRW1w2Ewm35+UP1wl
	+KzatQV9mTTfaJo152z1fB6gjoPEAWqnDL5q6RBQcDo1soJDZ9QSgG5+QrihVDbfjbISk0kzroX
	kwvZzaewVfQBrhBP/ddJgZEaNlul6NzTEPrNRJlXO5aoh+NuxJqpgeRc8bT4OPA1fDEPK3ieoEP
	Mar9kunHAfeFAwQrRPT1ag1v3xOQ==
X-Google-Smtp-Source: AGHT+IGurCMCYp/EVVGHXENyJP4ioW8nHVvD949rBlW/NfNO5jTQmYpqrtzWU+Qkhnx+Az2LVfduxQ==
X-Received: by 2002:a05:600c:8595:b0:452:fdfa:3b3b with SMTP id 5b1f17b1804b1-452fdfa3c0emr77142435e9.5.1749534217909;
        Mon, 09 Jun 2025 22:43:37 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:8200:19e3:25e6:afd9:6d60? (p200300ea8f1a820019e325e6afd96d60.dip0.t-ipconnect.de. [2003:ea:8f1a:8200:19e3:25e6:afd9:6d60])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a53229de48sm11425881f8f.10.2025.06.09.22.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 22:43:37 -0700 (PDT)
Message-ID: <18ce0996-0182-4a11-a93a-df14b0e6876c@gmail.com>
Date: Tue, 10 Jun 2025 07:43:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: enable EEE at 5Gbps on RTL8126
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

According to Realtek [0] it's safe to enable EEE at 5Gbps on RTL8126.

[0] https://www.spinics.net/lists/netdev/msg1091873.html

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 43170500d..013b06182 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5262,7 +5262,6 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
 		phy_disable_eee_mode(tp->phydev,
 				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
-	phy_disable_eee_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
 
 	/* PHY will be woken up in rtl_open() */
 	phy_suspend(tp->phydev);
-- 
2.49.0




