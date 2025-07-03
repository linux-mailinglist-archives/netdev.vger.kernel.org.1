Return-Path: <netdev+bounces-203652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660EBAF69E6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15C016FCBD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D317290BB4;
	Thu,  3 Jul 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbKOneMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F828B516;
	Thu,  3 Jul 2025 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751521709; cv=none; b=FwOdbu4ikAqJm3G5lGM+xV5oKybRWqA5BbTnu5c6SFS1/xIAQJOTx64JH5OxrEiqmUDrw8DQ+2CfeSHdBtiHxmpqja1TnBoqkveYUY1H+uXpLeOhxj8GHedGTrTx6001FB+q5UCXxp+EK187wc6AEpWtV0rw0835S1VF82/bnJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751521709; c=relaxed/simple;
	bh=lBlIwD1+HPN9F48HR3I4lp9HNBaEwYAQT2Qr5gl9Dv0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IfxCMGZcjr0f4WXgIFNtepSxbkWAp8buXROyxM6Qgdnzse0ZYTARB1llxlnrph0O8rudOHm8hqGTzs1ki5Z3tF9BINncSz3aiQqmyUjLmnlWVEV5EU7w9PzOkywkOREI4C7YEOJ9ozARsCgD2XC/8zHgRchv8J0dgv3jwsV+AzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbKOneMn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so3408761f8f.0;
        Wed, 02 Jul 2025 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751521706; x=1752126506; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM058Tg3W3oA64f/wG1GTu48HHbwAoadSHZZmHC4nmU=;
        b=dbKOneMn6Z0bkZJxsIR9nzJ+WZCIMtUoC/ystJAl0oanqEHYlAZS0T3PFfhLwFrMnS
         6xfhRBQO/AkHlzJg6cfON+JXHTdsNW9nLzL3r4muBWh3yUorwyUB2mfN5Cy/AhY76CSP
         2al6oZ2fam1XXHLFuhujNEYCvk3gKcd16TJmxI8r6atXHVrXHUeGveWC1Lsy7JVoJRxG
         yF2eiV1I/Ggcp71/DRwNbRufU5GUag5rYmlmPyQqUzhQYIx0leXxttM3ZBsOf0zUubY9
         SxUS1Kmauo3IOEXYOJOIdS/Cn5XXhx1stbhJ26EQcVdS67dduaR7QODlXatEM0jH5i7H
         JqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751521706; x=1752126506;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM058Tg3W3oA64f/wG1GTu48HHbwAoadSHZZmHC4nmU=;
        b=hLi03j5pdS74Zs1kq7voJrcibZgulkyX/f0sJ/io1YL9MyumAH+vmlwiUY+4RkyxRU
         tnDcFljU35hWlbqDus8zNjzhRs8wU+xSnMcKY0xsya1r3kHQZhAjgXD4oxjvzV/Ht6Bn
         KybapVDzXWbJNflFJd+1HmoJfvpfsp0toxLruPpcCuwhs6DxZifP8/Hm1HHs6JouIngB
         u4gpen9bOj/GzMC/V9bVOWFJXirL2x+o095sZ+6Cp7zayq0E2rLU62M8D8MSD+ujqUkb
         jorfAlJW/peLkH51FkGmWUhzSAJb5dYLebHiANjdPtB/bzZWSg90uugkSoXUhzhQUsfx
         khHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6z+vo6lP3WEBZsXsN1f7O947klKcQUFDYRWmXE5QcrSCjTQQ0nmMae/Tv4nODcbrbNqInmL2S73Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0Jqf0o8zlG6XEIUm01acZO2hZo3URFjeTORqwztRPpxFYaU5
	DY6NHHj2kUPuYv2SLgQPrSOu5WXz5qbWwJXzmARQ+qRVr5LLiHsZqa+q
X-Gm-Gg: ASbGncsmRXeEyRKvzDVNpVBNA8IXafpzH0baRcYmWIiok1fknH9McPxxqQ30yoryE8m
	L+GVcSyzVyRKSY4IM+5+OpAY+JLJgdBMDdjipWrZej3QYzELmSgDFwNs4CAQjqhk5FE2h4MPQiE
	DZqHkR+dRLxe6fRpwgRLJjwRrqhf5KjZ5j+/V2NuF+BzQUz3siQtKmfAAlRpbF4lyC5MdqoAHcG
	UtwRShoVHs+7MjCc5Fr/8dc+nJ6dEOKh/oPHCDvNgbfDu4eiajMlfmbanVhbSjSlZPfMsfRrwrA
	0ALGLW2KEfs1VAbaJRVuVv5CU/zv5Z+4b7jf6Dx1zl3PtRqI//l/Qy25UcXkiIzvjXmGXQ2XROL
	dB0tHpaU1EmDS8Nxu3WYfGSt4vgw7kvR7vuoDrqRo6tYi4mvKYmzag5EJKtPSH89a2XngAz0XMQ
	z35YWMLtN5zOoTcHcC9iyZcuay3g==
X-Google-Smtp-Source: AGHT+IH1B1lTgXn5+od88Xltkx5wFKMdwuL5Pk0Em9LvLCPYzbgoNwVsEifUQ+RDt5BsDJ6ovzWIwA==
X-Received: by 2002:a05:6000:4607:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3b32f0a322emr1198377f8f.59.1751521705606;
        Wed, 02 Jul 2025 22:48:25 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f21:4e00:f537:96de:2e59:ab23? (p200300ea8f214e00f53796de2e59ab23.dip0.t-ipconnect.de. [2003:ea:8f21:4e00:f537:96de:2e59:ab23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454a997b598sm16205675e9.10.2025.07.02.22.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 22:48:24 -0700 (PDT)
Message-ID: <626d389a-0f33-4b45-8949-ad53e89c36f5@gmail.com>
Date: Thu, 3 Jul 2025 07:49:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: usb: lan78xx: stop including phy_fixed.h
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved
PHY and MAC management") this header isn't needed any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/usb/lan78xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f00284c9a..82ae9574c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -26,7 +26,6 @@
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/microchipphy.h>
-#include <linux/phy_fixed.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include "lan78xx.h"
-- 
2.50.0


