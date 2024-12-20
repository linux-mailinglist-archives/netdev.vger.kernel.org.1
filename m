Return-Path: <netdev+bounces-153699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACF9F93DB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1325B18993D1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50A215F62;
	Fri, 20 Dec 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8jQpQq0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181431E50B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702791; cv=none; b=tU4S7zNfUqfkpPf5jWNcMVxRsVlSyOpXXALVK9utiQO2r3P3Ts4KTpDKb9GXKFiT2ac4agX9MKurumACniD2mqyQGlBqw01GwUNqbqdPGyeXwWy1PfRSy3KCMqPuw3srF/E5GQoJwyMhbwOBtvESTbNljpjkAIdPgvuwXrTICbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702791; c=relaxed/simple;
	bh=m1mCPvBp43UbZ7rArGrXPCOB0+OgvAZcctk37qDgAms=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kiKMO4hIAxufMti+cWuqQdMcnc6ln+J+bc8NTOMPheTmTsdFijSoj/C6mWPkx836wmz2dbdw8AocJGRznmrbXLuN7dEVVzS/cwOPIMmFk50QSiv7H1Me2BSDK/rMvrb7woca0K9cK8rSSiMgwsHcSLTG9kUmY4pGsW6xNFvkYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8jQpQq0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so3184113a12.2
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734702788; x=1735307588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IlNbFsuhYHbkoNMP8k7KamF4IsayJ/k2ixFqpG4Rrtg=;
        b=D8jQpQq0TyT5b71JlaTtG/P9lWXXW+lOh98P6I1kH6EmJbse4khfNyHKlC3eTHMESS
         QAoLUAlXGPzDDhRNV374H/JZTOMrUmHk3YVulaB8SflYk8ceFXw9TPDBKxbvvdEnSzdm
         Lum7E0I9ZbDiCScXlrX6oO/xBZHI+HULm34W1e0y2m+sCnTeFzeaOl5fgtiaw/iJmdTA
         z/EU3LQpHzJr7kE0ukGlROIoI63dS+t1KAMO/EnREjwOMvL0APlOmQCbRy7f/5IdFg8O
         KQhHvEuZcUMkn/86Rg1fu/iaXGxX04QMxuliGoDbhXc2eeuzXLLgmV91csQ/pBBpB9bP
         TtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734702788; x=1735307588;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlNbFsuhYHbkoNMP8k7KamF4IsayJ/k2ixFqpG4Rrtg=;
        b=NcgoRIbqqtffYWPed0JYJJ7FN/4MQgn2MCvB7sMFHiJpI8vvoFAw7+kLSktmOy/RlJ
         8QJJcJ8EV3ufaIb+tCYIKlx7JpXTQa8WoC6fEplaT3sQry/bJ6A3DiWilxkYsM20TG7L
         zV7+al3tGQ1+5GlZygtQGvFONvyzJotkZAhDTqv33IP5qnRAbNBuVd89JdErnRVbo3kC
         QRqcT9iOM4lo0AYnyFFv175urXR1FpOkMRJi5vfchJZX7m5XYZ48DB3eDNQoOMynmBdU
         JqbnNokNjn/bGTZlPsgdqwnS0NczVMJGgx7ZuzNrP0BxEItaRA6yeOqETXQC9Bd7Pmcg
         orhg==
X-Gm-Message-State: AOJu0YxjvfZ2+KcsSefqlz42mWhqDFU1TXvjAM18nvs5Ip1ziEKXu8xV
	MwJh8tMETYleO4/aPm4SO2yj0hN/5NBRjhaRA2lrhN8xotErnC14
X-Gm-Gg: ASbGncsi79XgqzeqVFgbWLNR92tyTWgw+C7wS1/nziduOiSllchDxD27RxzW9sAqOF/
	ZNPyqZMGytfA6trk9noVOvabQ0/0PBHLfuDh1LTFttDtKx7OqU8CT8iWeZI+m3q/P72dw8A+avB
	xxezQ5WkdeiCx2fgtrB+BgKF6e1mbwWOaGUkCqjlnSlJaID6YRV6crWQMO6LYgkRSv7zYfQ1O/H
	ktAhApZJCT/NX/71Lzdh9b/G4KjOVJfI2wBNQtqST4t09/zr6V2qFvNcsAS7XPe0iJFwESXOPcP
	AT+z9KWHG5x0fwvcFsacN8EUTSZcmC84Dclb11IJ1ikofRqjHqa/cXEcLsgGlnQ1WXnkWCBZQ0B
	kcMag0h+IPqCR007Rrpjaq1J0JUw7zuXsQLWTjePA7ggFYgJK
X-Google-Smtp-Source: AGHT+IEKR9lqo/hqz8KB7weodz8v7Aqpf53KghXcIYZZZWBswPHglSjrY6/FG0qMlC4Vb42mAnlGcg==
X-Received: by 2002:a05:6402:5384:b0:5d0:88da:c235 with SMTP id 4fb4d7f45d1cf-5d81de19814mr2304032a12.31.1734702788134;
        Fri, 20 Dec 2024 05:53:08 -0800 (PST)
Received: from ?IPV6:2a02:3100:a560:5100:8565:bec9:a1c7:2d82? (dynamic-2a02-3100-a560-5100-8565-bec9-a1c7-2d82.310.pool.telefonica.de. [2a02:3100:a560:5100:8565:bec9:a1c7:2d82])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f3e8sm1738212a12.43.2024.12.20.05.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 05:53:07 -0800 (PST)
Message-ID: <678a7f46-f8df-4967-b298-05b97537bc28@gmail.com>
Date: Fri, 20 Dec 2024 14:53:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: dsa: microchip: remove MICREL_NO_EEE
 workaround
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Woojung Huh <woojung.huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Tim Harvey <tharvey@gateworks.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <942da603-ec84-4cb8-b452-22b5d8651ec1@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <942da603-ec84-4cb8-b452-22b5d8651ec1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The integrated PHY's on all these switch types have the same PHY ID.
So we can assume that the issue is related to the PHY type, not the
switch type. After having disabled EEE for this PHY type, we can remove
the workarouund code here.

Note: On the fast ethernet models listed here the integrated PHY has
      PHY ID 0x00221550, which is handled by PHY driver
      "Micrel KSZ87XX Switch". This PHY driver doesn't handle flag
      MICREL_NO_EEE, therefore setting the flag for these models
      results in a no-op.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 25 -------------------------
 include/linux/micrel_phy.h             |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index df314724e..c29dc1c9c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2990,31 +2990,6 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
 		break;
-	case KSZ8567_CHIP_ID:
-		/* KSZ8567R Errata DS80000752C Module 4 */
-	case KSZ8765_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8795_CHIP_ID:
-		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
-	case KSZ9477_CHIP_ID:
-		/* KSZ9477S Errata DS80000754A Module 4 */
-	case KSZ9567_CHIP_ID:
-		/* KSZ9567S Errata DS80000756A Module 4 */
-	case KSZ9896_CHIP_ID:
-		/* KSZ9896C Errata DS80000757A Module 3 */
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		/* KSZ9897R Errata DS80000758C Module 4 */
-		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
-		 *   The EEE feature is enabled by default, but it is not fully
-		 *   operational. It must be manually disabled through register
-		 *   controls. If not disabled, the PHY ports can auto-negotiate
-		 *   to enable EEE, and this feature can cause link drops when
-		 *   linked to another device supporting EEE.
-		 *
-		 * The same item appears in the errata for all switches above.
-		 */
-		return MICREL_NO_EEE;
 	}
 
 	return 0;
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 591bf5b5e..9af01bdd8 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -44,7 +44,6 @@
 #define MICREL_PHY_50MHZ_CLK	BIT(0)
 #define MICREL_PHY_FXEN		BIT(1)
 #define MICREL_KSZ8_P1_ERRATA	BIT(2)
-#define MICREL_NO_EEE		BIT(3)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.47.1



