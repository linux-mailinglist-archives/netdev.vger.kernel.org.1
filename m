Return-Path: <netdev+bounces-157460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B944A0A5EC
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589777A1FB0
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974F1B85D1;
	Sat, 11 Jan 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrZWQHOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E11B4121
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627493; cv=none; b=hjmpsRV9p0Z8AlYwd9Ehk4r9/n1Ir7Y2dmSRpYykz4AMUiN88XY+5euKVgV37wp+AhfUnXpVW+Phc+8h4IYg9rhTqx7BdhbuWmsPp0WQQA0glruLHYdoZ0gzc4ttqoJ50U6wNsf9tci8T7jDUv07gooWs4G7BWkKBgOwpvTyy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627493; c=relaxed/simple;
	bh=fQOgN1c0jAC5vwrHN2pMGUIXQWYom5HlF5wXYnd+hY4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xd7uWBHzliBq02aVrW604RaZwJSrfFqxIvysehJg0j+LjpZonL7bBbW1CVsH3ywZSFftCLjPK0Z6s7kfghUUpmoxQv8KpCXMj7og66jM8ccb4FXpuSQc8cV8nFcX/RdLeSOP6wiCoyOy6JvS1PWdfhJ/AQnStg6GTAkadkN12qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrZWQHOC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso782353966b.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627490; x=1737232290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yhP2gDXYSklppqnzyOrY+nD+5UuRorJStgXzS44Z7wg=;
        b=BrZWQHOCQUnqs2FX8Y7B0y1nbkgTVev5lFvYCT8TDFEdGBGEpPB3OPDxSm4VnX4vic
         m7RA2tp7NVfNKhNKUPCMSxrxKrrOUasbFYJHKlfofasQwaKl/oEJfEKl4dt0SbC2PxkX
         jcwFO04rj6AsFdofZZV3jAkU4oHL5/2yhcpd3VThhE5Iq/WpMH4Co5ABXkoFqkXr3hIn
         ZoYablMIRVPFg50eCVN04BfKzJCJGjzyMlg9MQ/Sr0wmKBG2l7SfF9pz9N4Y3FrJrNaI
         ZAzR9pVVzBgvuclerJ1HEnO5Os8pQUyH9CR2OnoQMV5bbYrmVYQF4RS0GmrvwqDWwf8k
         QLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627490; x=1737232290;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhP2gDXYSklppqnzyOrY+nD+5UuRorJStgXzS44Z7wg=;
        b=P39Cm68eDCbfdI1aVkJ1rO/BeWFO/DFpQ5shvT0k1iEflRcaNMkPL7khBzUHi2Jx+L
         YyCkK71NGytYt9Q/wDVtWiz04wZ3vd+mwDNlv+uE3Un02vkXP+YEX5Wt7Fm5TyFjQNQz
         RY2UAMR+cOOiEwGPu1Gt+hXuLytidvPxpw6D2VRcYrEM18tZudvY/A0AaLNZH7WIUmRS
         VDkXRfAkN9KtUyFx9qXm1Hm4Q8tA8dkPZScwgM4RiCqxu6gpwFHIB+q7lJPxcc+QN1B2
         2U7ESGB8PNSQGTu360uEIGyz0YK/sOHrPonLh1n1JHdzKOils0hOPgHFYUoOkdqJlhQ/
         rnAQ==
X-Gm-Message-State: AOJu0YwCrJNeMIxpJnWmbye/VB/3AO++SMaNLaCDgnjWtSEIkasa+I+M
	cjGOLCWV5ZHxat+PGQmE++f4SXn0E/lE1gxrkIQM6HfLqVWK6DPN
X-Gm-Gg: ASbGncvNa+DSaslMXbQYkqPlvT7pYE2ZItOkUGxNnvgcoLCQxcI6vmrwv7aoWlSvGbT
	5SBX1lkHWzFBNSxAU/xn8tmkEkfxx6g2iROKZ366Bu6MRXAgPy5bxWjfJpsfcGyv1Xqc2bz3REF
	I4OsOl1BincYy+a7JhVuAeKkQLRTz0NPCr3Tfc5fC6pVFpTf6PNaOWnGddLTwS4auUWlGpOyK3P
	o3CXoH0i3pVXoPueHyjvIBiM1CSGfx9Ap//cv4W/d+E7OZc3k/os+DZ4orRxftqHRtSJ9+cVc4g
	EtOt8W4ib6r83k6ffmPwhfyNV7daDmsqXCOa8XfyoUju63PBSRnf8IZuAbNljIJQDO1pBlhhJdy
	yROkTLp445LasH8Vxn3a7XjIO9ctxouhNileXkCQpHDQvNeHA
X-Google-Smtp-Source: AGHT+IF9p1BJpcEld6mTf9/RAQ8n4SLhaSuARQwDhtoTsI3C5sZHAWvJKbKugZSs8lPlxM57uaIv8A==
X-Received: by 2002:a17:907:c24c:b0:ab2:ca86:cb84 with SMTP id a640c23a62f3a-ab2ca86dd4cmr907489866b.13.1736627490300;
        Sat, 11 Jan 2025 12:31:30 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c95ae536sm302791666b.139.2025.01.11.12.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:31:29 -0800 (PST)
Message-ID: <d8967da5-4337-409e-9024-f8139e80a2f9@gmail.com>
Date: Sat, 11 Jan 2025 21:31:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 08/10] net: phy: c45: Don't silently remove
 disabled EEE modes any longer when writing advertisement register
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

advertising_eee is adjusted now whenever an EEE mode gets disabled.
Therefore we can remove the silent removal of disabled EEE modes here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d5b5531cd..8cb420c04 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -683,13 +683,10 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 				    unsigned long *adv)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	int val, changed = 0;
 
-	linkmode_andnot(tmp, adv, phydev->eee_disabled_modes);
-
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
-		val = linkmode_to_mii_eee_cap1_t(tmp);
+		val = linkmode_to_mii_eee_cap1_t(adv);
 
 		/* IEEE 802.3-2018 45.2.7.13 EEE advertisement 1
 		 * (Register 7.60)
@@ -707,7 +704,7 @@ static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 	}
 
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
-		val = linkmode_to_mii_eee_cap2_t(tmp);
+		val = linkmode_to_mii_eee_cap2_t(adv);
 
 		/* IEEE 802.3-2022 45.2.7.16 EEE advertisement 2
 		 * (Register 7.62)
-- 
2.47.1



