Return-Path: <netdev+bounces-222681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF3CB556C0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A81CC2BA8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27728489B;
	Fri, 12 Sep 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd1C48Xe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251817BA1
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704015; cv=none; b=pTBSUXghZkVEZ+PLOUvVfJnqscEry1gAV+EiK1OIKNH4qGYv8fiEYv4tF73mFPFIn1yFS9Cr3tupxMPCnTDyMZtGnLsEebyVYVc36TcS0pPNcllntJhqf6Juxh4kV8KeGGZW/1YTtGbU+vP6x/7okF+giy/7EF9SC7XW4/xOT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704015; c=relaxed/simple;
	bh=ZZUAOeZbMeFZMjekRoHqlYXHokiz6et5GCufS6E1WQA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F++nQKYCL04xmN780cCYkhXPzUzoPOvGa2Ul5/vLvWE89zmvGtVJ1KizqQ2hVzmm6S/wDb6L3VNoJyN8Qcytu8wKlC4rbSHG2SidmqMgaCM2unbmIr1NJ73wOAApfUrnQdD05L/vzofCWmiGJZJhbVw2v4tggonGeZ9VPIMqvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd1C48Xe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3db9641b725so1930023f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757704013; x=1758308813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SV6Ojjj4xd7nu4u5yHexJDAjlCPQ8SETV3fhsO+esoA=;
        b=dd1C48Xe6Kuic1P8iAyfidUDQQZTTlDLgTQ3ywCo6YAM5/1jNw2azwq0+prxfG2JxO
         kuGkAxDaIFezzbhCSWjH/JdUc+U3szyLBTObJLttjz1Yt1tE68gYB3bkiaFoAQ1/P3sb
         +whv8gDvQ0bfMG7NA8iyXi12y51cCfpbniUYvRTf0IC6pERkl6ATlYLDOONr6RFs2UFv
         37Dwb7FuXzKOiNh0qUEe0nThgccBoi6VsYMxdSX7BxhoMNq63nJC0kZ/+NE0p1cZ9W0y
         3QEu48qYeeUZk2KYAI0D0/xJ99qbj0nXkJbjIjdVQrLXA/cxJAKaDiQp9fa2d9C6ldNQ
         fO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704013; x=1758308813;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV6Ojjj4xd7nu4u5yHexJDAjlCPQ8SETV3fhsO+esoA=;
        b=flt2w6+ASePPZO8/db41LaSs0zRJcU2JI8PJz4SxfYfcpXS9qLy4Q/1TWtixcoAc2x
         SLpQ0dcBaYof8uVPjOW8hlRnDRdjUeXEQeE8PMo4cUVGxNzve8Wdiphu5hoBdTnp9Mte
         wyb5g1PqFJlpBYrN0cclLsNoRDkYpS2rtEjAkS01tqMXqi4pGeon1NwxL8btYMZ5xr/R
         GcRAL/BnHikDwppmwEaAf0A7va7vDx/ScxLBAYMrk0ZZMoTmBLZMW2r5EnLtwGtHHYR9
         2kSCX4wAPaAS8G5sdyqhQZhHN7GXNc85tBM8KuaxT6TT0Ty0B1Jlg25cyy3J+pZdnZ1h
         TGLw==
X-Forwarded-Encrypted: i=1; AJvYcCWEBwATnZMxpR7gMjn66lUyBYUjqBLDBK103vTUrRGNIWGPA1jhPxCHPK5ZEDTA7BD4PUDOmCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImVDb+7ZPUT/a6SJbl7OnXmaVTEo5ohDTuQtsnmKRKq/NqqDx
	OQYVkY3LDBw3Inhvrdcdv9jnDmf9kMMmYjqXyXlLEA8sAEB3+vpU4NXX
X-Gm-Gg: ASbGnctFnDINmx47LzOeQlfk44/UQ1xDA1foR8m2U2ArlMQciFcFvUq5+IS7JpGl6vJ
	jh/JalzgffXLDvgZW4zTbcoCy8TgyUm++SYGZ6fwmRCWAL8NfPrbC0ET6qgMJMZO1TCnfT0yRi1
	R/e3EOxIxLksU9LkGmEUtaRBhYQaB2bOA/U7bz5hkPzTgK6zzpKK5pBzC9ImhiOz7Uzzk3W8dPv
	gZhpIsMuFKdAjJzQIW1EQNceV+IwCCBEX8crLV/vwidHHyBks87ojWU/a8bMfLFlORrhAixeFsS
	Lx22l/608etbAx8w5ILMuZFuPRECVlM8aw0JHBhX5vke90qPfvmGsUxoPvSHjGhykoqeKSUQnV+
	OteswdLf7fwcIrJVWhBSFmDWEPuyZ4YEpnYbf6JNhUGSB4RPegZU2LKMHp/8pL/pNrjY9kre19v
	t7Na25xECi8XsdcRSB+6c9acRu6YsQKBKhjj7boma0bzdi2K6ZCBxYJ/exRkY=
X-Google-Smtp-Source: AGHT+IE+lcz8Jco35np3zFKtHZgut/DkmcTOnUh7UtIQngMtViTLG++uhdIOXgyXeRAiRssRRjfWog==
X-Received: by 2002:a05:6000:2389:b0:3e7:6268:71fd with SMTP id ffacd0b85a97d-3e765a4c887mr4116284f8f.52.1757704012612;
        Fri, 12 Sep 2025 12:06:52 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f09:8900:81f2:fb63:ffd:3c7d? (p200300ea8f09890081f2fb630ffd3c7d.dip0.t-ipconnect.de. [2003:ea:8f09:8900:81f2:fb63:ffd:3c7d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e017b2a32sm74994025e9.18.2025.09.12.12.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 12:06:51 -0700 (PDT)
Message-ID: <cc823d38-2a2c-4c83-9a27-d7f25d61a2de@gmail.com>
Date: Fri, 12 Sep 2025 21:07:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 2/2] net: phylink: warn if deprecated array-style
 fixed-link binding is used
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use %pfw printk specifier
v3:
- add missing newline
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1988b7d20..0524dcc1b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -702,6 +702,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 			return -EINVAL;
 		}
 
+		phylink_warn(pl, "%pfw uses deprecated array-style fixed-link binding!\n",
+			     fwnode);
+
 		ret = fwnode_property_read_u32_array(fwnode, "fixed-link",
 						     prop, ARRAY_SIZE(prop));
 		if (!ret) {
-- 
2.51.0




