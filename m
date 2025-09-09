Return-Path: <netdev+bounces-221383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F653B505F8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFBC7A5649
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD897225415;
	Tue,  9 Sep 2025 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYZ/mL8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203242905
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445321; cv=none; b=Na3FWNAOcpxfV2f8mrSoPO5iGk2OKVa1cHPeg8g/+w9ukCeq0oa9rNQgEc+g1rM8L/WcrgBji/wFCA+dwLotMVmCCWr5RHtqNkNvq4A1Gn4GilxMXN7cGXIG7ZnYKs3iqzqAt3mUguUN9wdLL5/rmmHHoVs5qiqOSb8B5M7tzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445321; c=relaxed/simple;
	bh=kP8CuoY3+rEak129gtAvgRHI+/n6vfY8NTbhy6jX6/E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o5+NqBWC6O7VmNZlEAz31X5HU1fCExG/77JCuGdKmDe5iObWt/WV+vfJxRrhfVeEsf3SwIa4Pxspf9BJc1kjpfe2QwNVTZwzhvpm2qbRsfoEnrzbxVCatRjIYEAsUhZ/zHOhQE3rl8WEmP6rZ+j2/Ewx50QONQxt/Kf8r+YI8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYZ/mL8Q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so3917726f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445317; x=1758050117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e/hTG5oXLLEz2EBow4tPo/IFgEpDh4x2jiQHUVPLgE0=;
        b=iYZ/mL8QYtA/ciWgG7u3FtFl8Pwn4FK0zlPoHnAQanqzUKc7bBupChURU5eBkHnCbe
         coJfBvKIPzWzuEIQCMfbjcSpcYO3ZfzhTEICxTwBCHECWo6SDA31CgiOAY6eIOmNOpUd
         sa3F7Vr5MIABkbw5LIyfPxQdeEGoyeZEo0FTteAn3RFMZ2YeJI8wY47H9tupNPSCrDqF
         cvlyQjoASMCFqT75LXxBWJ1deeZyxQrJjq4vm7EUdwW1wdPLfP8K3XhMgZIk5X7pl9KT
         8Lpi6FreGhXSNRgKhIPrOAkMaEodUs1orvGC6ah5+3muR+29jJQ3vtTyeO99YVEXta4F
         kQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445317; x=1758050117;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/hTG5oXLLEz2EBow4tPo/IFgEpDh4x2jiQHUVPLgE0=;
        b=FwfZB9cf6YO4Q0sA/aaZLnwq6ILuA3SYEVNu0E2CZKBxBTE91Ycdi98RhzYugF6D4F
         /4VZfeMuVsBLwFJMBGuBNjlJaHWogENC9NyF9eR/3lrTJoEhugsu2OclacwkUdvSuRCL
         Mr1p7vni3X7+wUDIoYkPNxO+RD5SlMN5ZW+0fe4GCivfLAwhS/vl7BWQScDbjFs4Tn6n
         Zvwif/TP+xrKcboQ5R4GAk8NGNWuZYPeFjkp+gElCuyJsVjqpc1pzbGZKEE44PnjO8PU
         PiOtxAIP37r9cWueu5b233TIPFe9KfJzbqww42Q/bkjaS7601piHy1UEp+4A3aEwQ8rA
         7qXQ==
X-Gm-Message-State: AOJu0YwcP5ijNVRPihauu41LOOdo5c/ix8RsKorIiC5RKWgZCB6wv5ZN
	kzoWvZNvzcHJtUqMfSgeB7klyUWGUa3CwjlEe9M/2/xO33Vo/Ls5MWGY
X-Gm-Gg: ASbGnctIPgEtWa3d/Gjiv4pDCaFKOOy0Uzq99t8Rsl5iMugckwsBaC7Kg0UZLZW/f+U
	PQ95d+w+rlnQYmJsNaO3vLMjMiV5KohvAx3wIvm8Jdq7D5cMLcEiRYEgiDIm6ytn//3Cxop/p6o
	hwxa1OGoRMsL3DSTLfpUOZCnkqrq/Dwltx0QcjQj50+nEhZNuiV0c+xoyCmVJwrHX12jWSjdCFX
	st1cyDwZy6QVlv8sBXXalSj6N8GnZ0E+g89DRk9B5TpPrXMPaXo1Zwe/QvhwQO064WOvPvL+4MR
	mrqFzbdgE6YmkHlcPvv7QIZgrB44yBPuX5VCNwrvUllhmv0ekFi0F5ASBaKaTGbzPIyWlfST0ft
	e0UxpgTGq4fMZOUroFIKPHZva6ksbmvC08Hkf/bW9Ftm6Sj57w1FFFMga6Q6JsbeEpMDpkYuRPe
	XWM7C368Ia5AqUH2iNArt0oeSNT59/OZTbfwSuNfmHDIfNI7+n8fmzyUdXje/WzQ==
X-Google-Smtp-Source: AGHT+IFhHhAFmuwWrmMlSw/Od/yTkjWzwwSJIlD3oMKXHJw43r+HxFTSYydFB+Jf1aA2Bo9YCyQP6g==
X-Received: by 2002:a05:6000:1acf:b0:3da:37de:a38e with SMTP id ffacd0b85a97d-3e643c19857mr11281716f8f.54.1757445317213;
        Tue, 09 Sep 2025 12:15:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f16:4400:58f9:791b:ab22:addb? (p200300ea8f16440058f9791bab22addb.dip0.t-ipconnect.de. [2003:ea:8f16:4400:58f9:791b:ab22:addb])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7522387acsm3704189f8f.40.2025.09.09.12.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:15:16 -0700 (PDT)
Message-ID: <d2910abd-a20c-49f3-ac1f-ff9274ed75d7@gmail.com>
Date: Tue, 9 Sep 2025 21:15:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] of: mdio: warn if deprecated fixed-link binding
 is used
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index d8ca63ed8..d35e28dbe 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -447,6 +447,8 @@ int of_phy_register_fixed_link(struct device_node *np)
 	/* Old binding */
 	if (of_property_read_u32_array(np, "fixed-link", fixed_link_prop,
 				       ARRAY_SIZE(fixed_link_prop)) == 0) {
+		pr_warn_once("%s uses deprecated array-style fixed-link binding!",
+			     of_node_full_name(np));
 		status.link = 1;
 		status.duplex = fixed_link_prop[1];
 		status.speed  = fixed_link_prop[2];
-- 
2.51.0



