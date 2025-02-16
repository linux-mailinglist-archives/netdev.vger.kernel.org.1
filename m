Return-Path: <netdev+bounces-166830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F979A377C0
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA1B166028
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3431A238B;
	Sun, 16 Feb 2025 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WByziarl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3A33C5
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740728; cv=none; b=a4D3kngCulhUPdOqo0RVzq3v6k9ClcqCpYlZgdnYSFajOXh3gms7MOqZ8WgAGXvafa9QrT6MI5hkPmJpZQE06K7aewSnYMhZ03Z98Rg7KVQogVKyhQkhGfbvufacIEAr9xx6zTTzmT5Lad+c5cf1CnATgwmv42/ScAUuYKPX4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740728; c=relaxed/simple;
	bh=cNFZM/1iu/GJ/shS9BDpSgw6M4yNj3XbvvUObN3v8bU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LnikLYwK+2JopcU9pYtvvTmbZR+nAw0YrEuLkd5Fds5/WyH756nW/PA3qysSggAfgbbc+31tcUNlTdDRARwgDpk7WaKgIf3ShmZtVQkGBEXLhtIdYunBVxdwythoYOaQVDJdRdr4lkrZn7lwTvoqHiEOOeScXuOX4DDSZ0sQJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WByziarl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so1291384f8f.2
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740725; x=1740345525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SFkB1jTDRz+0wNhHSMj73GYmT9rlcg+aO4yyElssBtE=;
        b=WByziarlNOl6Mw2aIoXiRCUOaZ68JGSVnEYfkeJYvHoPKHfMYw9FNJaFmiTQJHF0f3
         YQKzmfXEx5iH4oipf3GZRZFL5Rq3jWJ64KogGl6a3nIetLXpxgCQu4oINixBb8Ebmje8
         YZe2D66y1VqFGqw/D6bRHeqatKlxiQYe33ae8lKYg3RQZtK9f4quic83TDZIbDo4CIQP
         YthK+ujYsPMCPyJujYluWMfYlZqA0WDE1K106pAgO1G7aqzS+cfSua3m4iceNijgjy7a
         xYoH84CF3paFCCo8BmKQ1PV/jGWIyQWxV5BDsFhM0Nid1C2/VdY76NTM32CB8NwSzt2R
         qPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740725; x=1740345525;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFkB1jTDRz+0wNhHSMj73GYmT9rlcg+aO4yyElssBtE=;
        b=pBcmtJM/5VdLzT9WGWz0bWYtml/5VzyorsfHnxm2sAY4lM0CvNqcyPbCqWRW9Fa6ET
         XEszRoGMDYnjjcxTl95ZXk9BgqLbO/hcgi8SObHREZco//y5c81/1qYf7fwVNP7w+FDN
         2IOCpnDmkBfu2WxOQ/fZUyVEUvcp+QY3mXAJZwSLKEFjRbQxUQiW1JK7uqLXA5LU30en
         MvEYFINpjM4VnVJyALIx5apbUSD6aUjRRWidU4IvGLL3dzpHZbWUy4knwXv/jvWNdBjN
         TrpBvA+rSFCVY5mCtob9VU/OnwppcTPQINR4b0+kE0+d3sGkE1bs4gNXPrerZQZq+2mi
         u4pg==
X-Gm-Message-State: AOJu0YxpV/F+apinnsFF8i+CnCiVBBMkkNv6Ihsnfiz6qI3QhUFxY4lq
	Su+w1b7WcNyybSCEpsbjblAJG433otdY1kqXYCIicMsUYl32OxCb
X-Gm-Gg: ASbGncvHHqoWPWDfOh1/OwyPy8JWv0gQNKYeoztPcicMWp1XhKpYHhAxzvAbpqXd4Tf
	LJc/CMrPxVyvmpmjK/OrP5OopY21ntxsEu3vU3ruX531IcrtYOlsA+X7BwISQd5xcqMUDCrtT3I
	zFqRHZSEaA5yXjx/hUW74PavyL6Y6IDeenbLiWf4cXaiRDo3oztqNFOy6S6n891bIZIK6ipbldT
	2QEkGHnfhB2ilYPRU3E6JfGLVaaT6imdA+JWNaHH3BOn0KvUjWXkCrqVdww9nP3oYvV61LnL/iW
	N+9MGN0wkmWSdlCiLRFvdbaGElp7A72JakbR/0UkbgRtf38Q5O9STeyPt27tp06xsn/RNM21Ay3
	DXHdDy1JLZJxP1Kae05BbXSJRzOPtWYR7BZXK0rD48d0fMN0Ox1wRQ+htfuQtWhqlYFw8pXNzWV
	FsH3RU/wU=
X-Google-Smtp-Source: AGHT+IHmPi+2Hhd7ijrGfo+bY0+A/ZsH2MDTL6jqGkiRb++2IZ/pZpUY2v66hUQG96GkRiTKUdtxOQ==
X-Received: by 2002:a05:6000:2cc:b0:38d:da79:c27 with SMTP id ffacd0b85a97d-38f33f37449mr4713580f8f.2.1739740724805;
        Sun, 16 Feb 2025 13:18:44 -0800 (PST)
Received: from ?IPV6:2a02:3100:a14d:c000:1d06:77f1:27f3:ba49? (dynamic-2a02-3100-a14d-c000-1d06-77f1-27f3-ba49.310.pool.telefonica.de. [2a02:3100:a14d:c000:1d06:77f1:27f3:ba49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258ccda0sm10497445f8f.27.2025.02.16.13.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:18:44 -0800 (PST)
Message-ID: <e57ed3d4-d0bc-4f91-83f6-8f48dfb6d7d7@gmail.com>
Date: Sun, 16 Feb 2025 22:19:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 5/6] net: phy: c45: use cached EEE advertisement in
 genphy_c45_ethtool_get_eee
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Now that disabled EEE modes are considered when populating
advertising_eee, we can use this bitmap here instead of reading
the PHY register.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index b19055cfc..fed5fb0ef 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1516,14 +1516,14 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 {
 	int ret;
 
-	ret = genphy_c45_eee_is_active(phydev, data->advertised,
-				       data->lp_advertised);
+	ret = genphy_c45_eee_is_active(phydev, NULL, data->lp_advertised);
 	if (ret < 0)
 		return ret;
 
 	data->eee_active = phydev->eee_active;
 	linkmode_andnot(data->supported, phydev->supported_eee,
 			phydev->eee_disabled_modes);
+	linkmode_copy(data->advertised, phydev->advertising_eee);
 	return 0;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
-- 
2.48.1



