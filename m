Return-Path: <netdev+bounces-142457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AC9BF3C3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB41B20B47
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22F0205137;
	Wed,  6 Nov 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBY4+dfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8484039
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912234; cv=none; b=PVMi1+jXvJl5V2MGJUvZNe2NF7VZW4MnOPRwlD4tzSplbc/I+YgMg85GYU1mLXQA3eORxluBr2HjnUuMAAsQkFWXbqk9/8n+5GsOrlDwSCpZvo+oxDzezyIuzWX5aOhr5YnQX/SpnaHSE2xhYKaksmWcZKhxxQA4DwDUFQKgdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912234; c=relaxed/simple;
	bh=fd568gFWsCcINcOGvywTroVD9GzsjtFRw/OBzfUhYd4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BM+X+0iD2pqO1YZD/5l6tbjtdmPr/GcJcTVYLlsycMHTMePeAQBTQNp1KZE+J73o46jwO6Q5r5MWM7Cfh3MUSL5HHIBogn0mVfIWgXn2XffvN08Lvum5yrbAllbFCN1eKpWKZYHNLZm+KPKkYO0vTPGYEHXej0Vg8Yq4CCZ5w+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBY4+dfz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so9819462a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730912231; x=1731517031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h4yyirgKKS1Jkv+dzWbU7HxJXzvp4L+IHEaBvPjYqYY=;
        b=bBY4+dfz5AycUZOTTwAIK1FXMQ2aAKAekX1KntLvyaNyH3u4r731Fsflb35c2Ed5TT
         kfjjc4HTQx4qQQWpC6bohzoTv3kX9D/RXSCl9tFG+4TCXEKBeHX5djX9Oj6859JxSm/Y
         lClx/4KH+dfJerLns+dlCRO+oMWvrEvrDAdvVPjKISWcqfeTqm1KurIxt6s3kHZx953/
         LbO5CGn4yJzKz/EJf7FSGGrDw40gOB14dPecla+Ln9dTGtE+oA4y8WgYko/si6KvAVQO
         Vhm3JwQB/keq8dfbVpjrlS0fMH1AvVzyfdsEuqR4ghQT6CDrPBbDY47b7y/+Pfa3PKwz
         KZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912231; x=1731517031;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4yyirgKKS1Jkv+dzWbU7HxJXzvp4L+IHEaBvPjYqYY=;
        b=lKEO/Tnz6qUxj0AUXPTzV7oTY5tG82eyBhrMCuLXfvuGPUm2CGyjkZ5+qUCWD8Rndc
         58lgpEzPAufvSXB4VQYHe0b8Gbc92gLHNXjkoXOe6eGPnCN60zYi0eCr7/cj06g2EYRN
         Ak2kNLXIQ7OsPiHFCUKANywjsJ3IdXxCpbkQyZaKShsCKhH64uFvlSmAImQp+Boct/jz
         dfLH7njLfQQtKzWP1L/NGoZoDlm0nuVg1m0zjQRyjoQyHvt5ZdyKOipaML0o9Ap+F1nl
         /kdnS+g9ccWm693bRlBcp4+IYuCEToE/GgtntcsCa6DOlWGtiqCYaZjC8DVbizwku2P1
         FIhw==
X-Gm-Message-State: AOJu0YxjDghnFdGysYMysxwaW2361W4wVusof82EOz5yYbFU28Qkv5oQ
	USD6kwBKhBlxfr4OwuYuJnhRIa4LTDJ9wHk0KX3/CA0V0TN6i6WE
X-Google-Smtp-Source: AGHT+IG7Mq3GUiPMJ7NFMz7Sm/2u+XVWXDdxluZldxv/EdmlbmpxnhhfFCbZHEC+ChLTt5NopjSm4w==
X-Received: by 2002:a05:6402:845:b0:5cb:6675:bb3b with SMTP id 4fb4d7f45d1cf-5cbbf8b23eemr28028988a12.13.1730912230975;
        Wed, 06 Nov 2024 08:57:10 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a3eesm2958920a12.10.2024.11.06.08.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 08:57:09 -0800 (PST)
Message-ID: <51130715-45be-4db5-abb7-05d87e1f5df9@gmail.com>
Date: Wed, 6 Nov 2024 17:57:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] r8169: align WAKE_PHY handling with r8125/r8126
 vendor drivers
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Vendor drivers r8125/r8126 apply this additional magic setting when
enabling WAKE_PHY, so do the same here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 43b03176c..6578a9947 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1562,6 +1562,9 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 	}
 
 	r8169_mod_reg8_cond(tp, Config3, LinkUp, wolopts & WAKE_PHY);
+	if (rtl_is_8125(tp))
+		r8168_mac_ocp_modify(tp, 0xe0c6, 0x3f,
+				     wolopts & WAKE_PHY ? 0x13 : 0);
 	r8169_mod_reg8_cond(tp, Config5, UWF, wolopts & WAKE_UCAST);
 	r8169_mod_reg8_cond(tp, Config5, BWF, wolopts & WAKE_BCAST);
 	r8169_mod_reg8_cond(tp, Config5, MWF, wolopts & WAKE_MCAST);
-- 
2.47.0



