Return-Path: <netdev+bounces-153823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE79F9C87
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C117A04B0
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957421D59E;
	Fri, 20 Dec 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTbz/8pd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DB1B0F0B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732131; cv=none; b=UoTkeYgC+oymmHYw0ArfPF1firzik0M2tTT0UP5kMkk7Oc3Dzcs5RmBYqfeGKi8bVKlURZ+8OzZKiS+i/czleX4Ko8dlbG+Sq+Uy/hH9OsUjNoEM88117H7x+JYVvCS+BBS1jYLgm0Eo56tohf5LFxXXVVni4c9fkhmpdEPs+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732131; c=relaxed/simple;
	bh=qtyFnqMS5Go0Pa5b+3gYzmIdn+tgiUTyR5LQNs9zcmc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SUwhBL4Su6i9nM32SjJ9/VUX8BT9LTruP8PaKLDTVeyR989vG92KLea+2IqiSSrEPBhdLN51VvRNjNXABX1bGyD25/KHOMy5QcpT9ySVG2qUja2TwMZ2bX0K1myOYN1VkiPrC2erBDDwW5kCOSB5NceWccEWCllAFP852tl8+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTbz/8pd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa67f31a858so417227966b.2
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734732128; x=1735336928; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zNxbq91r/yxLz/6zhK96RT7PjIuhoW3Ou62mFZpsb8=;
        b=hTbz/8pdRgpmtbUktY+zfd6m+dvq6XHVJBxlG24Q2zkMreHm8gyrZo68bj0IN1IgoN
         qbNW5s9oUk6JHnt6dDlRF2rPwANMxZRNjmuQYbYCANKrQcyKNPpHOvL0V8ct4Cxjh4Xi
         ILByv6MDNJSPDcQZjmtP+rjPQbXx4U2ZLbZIU0vpx7sE92scPZkqjt1B7KsPF6/LZhcM
         9RX+CpLNHSBHO2JopqBQ07dnwRZuIXPcVi9sUARK2O6c/zuWlN0yaNNY0etIMgPcWVUc
         5DDkceLSKflm7rE98H3sbB3HVourHf45FmWj6QBoG8eQiOtfQUezMR7qZD90JdHammSf
         ckUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734732128; x=1735336928;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zNxbq91r/yxLz/6zhK96RT7PjIuhoW3Ou62mFZpsb8=;
        b=WWu7L3WgV340a1MGUSBG5bBeQ8GW9xGpXqPFxYTR33YDBT5en7pacQSfgUQB5hLyYF
         oxbc5/OpOsQJ58HKycZSAAne6RTrOq0P2deAs9bLkrIQdl3YVoq7+RhlMF5NFsLYtLM9
         luVPkFICYWaCChfUfCGTnUP2O1s6BpMLOf//67dguMedclrHGnIp+shKZxQGXMznuBw+
         lIIxmawwJUuKT1qGOwZV/IIbXR80ywkOlUEdVWNIvbeKnEnjFImYSwcGTywq3c+Fmp8k
         0lmTnE6iQ494uaa+v2+afq29wIxYjTY9UB6CAJ75uQnJAQ+R+8Ls6UfhXjKHviSDWqJ1
         41Rw==
X-Gm-Message-State: AOJu0YxCkORCBzfwa3MRqJYBSU8ZjeGx0hWwdfFQ3KgaUCiN+DKeLGqC
	lv+ToK7d/dP/0QtFGFrjS/tWPFOWeDYXhf810fU3rKU6OLA1io4s
X-Gm-Gg: ASbGncve7Fe+yc7qtq/m54gbgz98Q68b6DBrO0MqXPFpeSrKLhQpnqPJz8z7vaompuU
	5sCPfPv6xqckPoiFZf15mnpHZFizJsRoMbL3GHVkQywjr2s+TuuIV3+jMVbWyOv4crJKhGHWxlY
	Otcj0JIWwhFQX2hzpcnpVfMAs+rKW+g7J28npvVbyURkht/gGtpda+Tl1Rcrd5ybpSh5vX4sjW9
	o22+LOafcWySxEFpp/lVZHVU/aKEDRYL+fWcFRLTQEanTUZU13LfFvul4/O8RmmAaUCcDxvlnEO
	UQrFoHJdJXrL7IwNR1guE0NX/sKUIdz3tSWQXSyJTuwxnPtq+kNaWPJuXPcApOyAi1TP419oliQ
	BnCUEPKpM7tF/UXU34a6YDjjG4EWXj9+Zd6eShG2Oit40XXws
X-Google-Smtp-Source: AGHT+IHzQEsDC0ttYV4HSEaHusGqwMzcpEKHzib/ru9qvm0fKXjiMg7XrVokY1h/F6ys26c1hZc5RA==
X-Received: by 2002:a17:907:7284:b0:aa6:8430:cb02 with SMTP id a640c23a62f3a-aac3397d1ccmr399728266b.61.1734732128105;
        Fri, 20 Dec 2024 14:02:08 -0800 (PST)
Received: from ?IPV6:2a02:3100:a560:5100:791f:8fec:e499:68ea? (dynamic-2a02-3100-a560-5100-791f-8fec-e499-68ea.310.pool.telefonica.de. [2a02:3100:a560:5100:791f:8fec:e499:68ea])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe3958sm213780766b.96.2024.12.20.14.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 14:02:07 -0800 (PST)
Message-ID: <57e2ae5f-4319-413c-b5c4-ebc8d049bc23@gmail.com>
Date: Fri, 20 Dec 2024 23:02:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fix phy_disable_eee
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

genphy_c45_write_eee_adv() becomes a no-op if phydev->supported_eee
is cleared. That's not what we want because this function is still
needed to clear the EEE advertisement register(s).
Fill phydev->eee_broken_modes instead to ensure that userspace
can't re-enable EEE advertising.

Fixes: b55498ff14bd ("net: phy: add phy_disable_eee")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 928dc3c50..6e169fced 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3012,10 +3012,11 @@ EXPORT_SYMBOL(phy_support_eee);
  */
 void phy_disable_eee(struct phy_device *phydev)
 {
-	linkmode_zero(phydev->supported_eee);
 	linkmode_zero(phydev->advertising_eee);
 	phydev->eee_cfg.tx_lpi_enabled = false;
 	phydev->eee_cfg.eee_enabled = false;
+	/* don't let userspace re-enable EEE advertisement */
+	linkmode_fill(phydev->eee_broken_modes);
 }
 EXPORT_SYMBOL_GPL(phy_disable_eee);
 
-- 
2.47.1


