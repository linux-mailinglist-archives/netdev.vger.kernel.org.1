Return-Path: <netdev+bounces-234514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95326C22733
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0BA406AB7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13430F534;
	Thu, 30 Oct 2025 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njcQdhzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1E26ED57
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860615; cv=none; b=GQ5GZaAS8gmrQxP0frbfM2pFghmSbyiRiUYu8AXj99z0lacs7R0og17BKJZSOBl07boq2+65vDB4ebrwhLl4GGbADe8EWr1gxqa7hpgwzQRN9mv4G9ithwE1oJPwzoACBWpxk4uLqcxXrZRnGEkpREetk1nHOkaBBkwJquRIUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860615; c=relaxed/simple;
	bh=726SBCQ2p6EtS2laU45uEz8m/+eOynHeRtx/IHLwsK4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RFW2QmfNFFfVgjUdIOiXyqq9/5WpvXVfPDJQQXoonErn4pGLnWrERRFc+9jmr9HWAr/HyYl2dABtTgeeNbSVasvOMJsx8uQfLI30Z3h5VSUEq/zB4ZB1/Y5LjBNKeMXGAYbOyyHulWz74pXLrk9agFxdbkXoziwzYkQmYfYbw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njcQdhzn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso4798572a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860611; x=1762465411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ir8AQa1wMUOcSt+/a7sUYtl8GxEW4QEfEGayOfnmqow=;
        b=njcQdhzn4gq5hmxZNuBiZGZ7b9rXap/huUyaUKHrKLgwJcJQKyMydTvV7a7iRuVCsk
         c117nsdaxZYXUHBaAQjvwdNDe+bZlySt9vgMzanxUD0EYpwCz24PM56BB4KsvcqJjG5i
         9A3ZdcvY11YtNJ4SIcH5ck06en/5yu8NwdqvYWanZT1v9Xr6+z/Z59YK+7fod3UhQECv
         Shhc+B19K+vpsHPu1bBPsTPgypDK85wrFu3ytGhm9HhLSxXkZ66f0QBq9BkmG6zaYlV8
         OnRhig0ZeoZg8o7qFui8GCTYLIdpFAuretlyGsuwYDvkLCCKsU3rQ+IPFmU2oSa6Yt0r
         ek2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860611; x=1762465411;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir8AQa1wMUOcSt+/a7sUYtl8GxEW4QEfEGayOfnmqow=;
        b=p6xjc4j1PAq3QRwS7MWhGKs/Djnyi0WAW3EJMxaV8RQqLQyxYVujT0y1vWYvH3llaP
         DM4DIX4Z1wDZlWF+KIch/cs2fh8FvFOOuKiLs3LkMVqYSJSV3vT6Xxz94owRuHzgpNQK
         bTg12z87xVLtmLdXwGu+JWasocG9tPP7ljtmN93QWy2mzinPcqcZkinDftYDht4P10Bk
         OMuDZSlpJ7239yPwmuLgeWSOKZzCYGxjd4FjenBJxI7cm1hxX8jmygJEpeFwOmucOGCo
         kmILX2/SghudqIEBZDyk5/x6UsNavsfJfXto60DLFVM2D62cAWI+r6gUkLlggS6juvh8
         T3xA==
X-Forwarded-Encrypted: i=1; AJvYcCXNcc5hsLcG0pxo6WIQBldUxjzO2WIXUTw4Uze0yuDxm8mNR6wPYRD3wlgVxr55uvLJ/q3xOJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6l0QalhDUU9/m9wn9rDnS9X02KVD9HAGSZc/D8OlGDTHNbVZ1
	neLHSx3rw4wlCAc4oQJi5XaEYB/zMBihcegww1Ix7Vw3vfDHEDn7o50B
X-Gm-Gg: ASbGncvEF9wLH4sugrEAk2PHekpqP+1O+fHwQdlVQPnDF8rc8qn+z239qRUr+pzS9FQ
	Y/DYsJLNgOM5nhOL3vrT7+cCzZZdU/u7GAdIuYU/US3ZBcrwZz+9YTo0jGsGI/NGNcD5nnlIwLc
	I1pTcpOtVZAUXvCfJ+e1aXXcW/u+dMdFknt0G+u6L/6NYRd6DuShx/JGxoA9bxJJEJrew0FVn7w
	EweRUWpUSRqLy+Ej7P/jXXQJTzxm3HH77XLxwOfCXwJDCO/RpH2zi95bGFC5xhl1Xb2yeULkJW8
	HKj3GA7O+fOzEbs3+pFE+Btc3DVxoyfuLwFw/bLoSLomF+LvhgzJ1EyigefZ1PzhD2N7DPOUwwZ
	XrBq42ocL0QfSjc2FDyKHhWjH/hKYNhmOFXNskqWthZXtvjVriDERzNC1YX97v9zzEB/wnXsnAC
	jbDNVj5RwTVBGqgD6aXUUaHkZ/EaTEyCb2jZqc6RVqRIKKv/1bSA6HYZSalt4YG0d77EgiPKoy2
	gSWKPn9rqZF4osD8IljU1UIaXYStN1NmsQFTGGFXkg=
X-Google-Smtp-Source: AGHT+IFin9LuBkbb0AYlwQbtnRdbrtyDgRJm0skxN5mswL3VB45tj8ToOhRdUQJToapuvAyVdWHmfg==
X-Received: by 2002:aa7:cb83:0:b0:634:bff4:524c with SMTP id 4fb4d7f45d1cf-6405efcc89dmr3248794a12.9.1761860610802;
        Thu, 30 Oct 2025 14:43:30 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:be00:f474:dcfc:be2f:4938? (p200300ea8f48be00f474dcfcbe2f4938.dip0.t-ipconnect.de. [2003:ea:8f48:be00:f474:dcfc:be2f:4938])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b34a03asm14294a12.3.2025.10.30.14.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:43:30 -0700 (PDT)
Message-ID: <212e0cb5-a2f5-460f-8e03-3c3369d0acf1@gmail.com>
Date: Thu, 30 Oct 2025 22:43:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/6] m68k: coldfire: remove creating a fixed phy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Chan <michael.chan@broadcom.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Language: en-US
In-Reply-To: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Now that the fec ethernet driver creates a fixed phy if needed,
we can remove this here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/m68k/coldfire/m5272.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/m68k/coldfire/m5272.c b/arch/m68k/coldfire/m5272.c
index 918e2a323..28b3ffa25 100644
--- a/arch/m68k/coldfire/m5272.c
+++ b/arch/m68k/coldfire/m5272.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/phy.h>
-#include <linux/phy_fixed.h>
 #include <asm/machdep.h>
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
@@ -103,23 +102,9 @@ void __init config_BSP(char *commandp, int size)
 
 /***************************************************************************/
 
-/*
- * Some 5272 based boards have the FEC ethernet directly connected to
- * an ethernet switch. In this case we need to use the fixed phy type,
- * and we need to declare it early in boot.
- */
-static const struct fixed_phy_status nettel_fixed_phy_status __initconst = {
-	.link	= 1,
-	.speed	= 100,
-	.duplex	= 0,
-};
-
-/***************************************************************************/
-
 static int __init init_BSP(void)
 {
 	m5272_uarts_init();
-	fixed_phy_add(&nettel_fixed_phy_status);
 	clkdev_add_table(m5272_clk_lookup, ARRAY_SIZE(m5272_clk_lookup));
 	return 0;
 }
-- 
2.51.1



