Return-Path: <netdev+bounces-193150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC6AC2A9B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE9A189CF20
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93A1A5BAC;
	Fri, 23 May 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqHkLFaX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38C7E1;
	Fri, 23 May 2025 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029880; cv=none; b=R2xmFmh2oZfCjNIcNTw9yJ64mgSnynU8c2wYIrItu8z9xyNPOLBFQDjkfYllPU25heCvVO/I1Pu29xeFaE29YMU0v/YCKNl5crM8sLaTxmKVqenF48rzFIjJzqAgJTCOrBqRV1VA5tS9bCb80OHFw1blSV6Yv6/aRHBPnVoyKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029880; c=relaxed/simple;
	bh=4LzuexN8hHB5XxpSH4wZV1uy0xOqiD6TrVZqM6Zofso=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=K9xU6+6BAatqFrh6gJUIvNH88vFHRVtG8uoqBnLTInddCbjXiljwgUcc4hUvBWwMwieFevPRGomEksZoHAPqWN5IRajEQIoFej0G2RPQ2FxcBaPmHbeDTvMd2z+QT8tSMeI/4zExaX8yFOV5+oXzCCHZ0cF50922fPSNg8mux1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqHkLFaX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edb40f357so1217395e9.0;
        Fri, 23 May 2025 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748029877; x=1748634677; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0OdewP07S+zIklRhBQUNcZ6v96DQC5eAqLBj428dcs=;
        b=cqHkLFaXxcwsbpgafX+3cUueazlf4NCh1fbdT4XwqjeA8+933EwL6HPcX/OPub9lWA
         9MEe2QoVswfdFt4y0qFOcCBGtWkrw1IyBQgKEf+WK3Sz0PEqtOO/4/xoBGaniMqevdIm
         oznobQN0lFjlnyikmRIhT85yCDjoRTrvFcqZPffKGHJovK53HSjSr9kKw3vGcu2naclP
         55TJwlgosyB2YwcHo+Vm/isdE0y4KWGTLg5hdzGnJvOIcgkZNSVEe96lUpB3YxSlapCb
         Mnrp6uzaKsSqvzgiA34TnbDR0f+4qI3A24XU+L7uUpeLQFY/WjScAzUIlg2vuFt0jpUv
         V76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029877; x=1748634677;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0OdewP07S+zIklRhBQUNcZ6v96DQC5eAqLBj428dcs=;
        b=txDkudgefl5Ge9k++wuOqG83XYKrw1adGZjrCwl3r5d0tRaBGfLcILSCjaZ2nuTv7v
         PWp79W42T33wwLnB9jN5Yh4OhovSW4JaW663YrSwuWDWRQ3dp2BLUgLo6BO5L5HWPGVY
         RGu5QsOhR9wAzPy/K5frsW6Z5utm0J2G363pC+8FbyM+srEbRylWc1+itvinaHpQZC8Q
         DjrVcqXp12Q/48lUj77f0HsJPeF1KGUjMWG+16YY0iKTlGLJDOpYOx2GAnCH2Vn2tQDc
         VGiQYMyF9rqYi5ulmC0ko+OMtA3zyN/RbUnCfWTqrj1bRLPxbY+n3Io6UI0G/jVFOmRT
         1w+g==
X-Forwarded-Encrypted: i=1; AJvYcCX1nUEONtVa3cbNXB0dq7XBI713nOgK+J+2/WaJe8/3BCD/fRFMsLW9RD6CrToaAQdL+UAtaUWZgHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxu/QKkZUS3C+3njZZ2HCec5/I9nzVQrAYHV0+d7va5sNoPIRx
	MIM1z4okzw1J6s0k0be0Jn9xu54G0qas+Zl7Ti6YE1h8nOLi6yhLtWUM
X-Gm-Gg: ASbGnctn1oHZpEnRDQjxf88IQeOp3bqzogVdxhOsL6qb8dyuQRb/8EDhAUukawBdF4N
	CWCpEbUyuVTST4maUd9lBrpHd97wtNd6ZYZuO7eYznLHG7wPmg2zCwUo9u0qntjPQxCCS7sEL9y
	1D1yXos8QlzY2dhLZ5xJRvstpj9gPpwrqDDRunzCtEA0g1n0WbRkGvdUQd9AN9z6AxVX7pX4b3a
	96Z6jdwZAZWWnLl0CJD/CTyrA6MsCJrfncrrF733wMubKwyVORvXTmTvA7E9RYc1lyo3I7xXVMp
	kT4VzJ7qu+Q/PwdtWcYHC0LAXC4KTvv6ee7Umou/DqvlRt7oGNPkGyPsHhP9VxFK6GUqfBY42xu
	wzL+io7yW0DPPyDGZimpCmvyzQZHk/yXqeShuR9N9nYWk97i/suiH5ckwimt3jIpG/vTqOWyzOA
	+gvwEshE5FMlT+
X-Google-Smtp-Source: AGHT+IGC4eT/e8mwPUnkwxaQOBFGU7jXAml0JMPp+LgOYy5Q3YfIS8dMrQ5vS2QLwUu0eanUrQGRhQ==
X-Received: by 2002:a05:600c:4e0e:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-44c91dcc114mr2771415e9.19.1748029876963;
        Fri, 23 May 2025 12:51:16 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3100:348b:fd2d:79a:9019? (p200300ea8f473100348bfd2d079a9019.dip0.t-ipconnect.de. [2003:ea:8f47:3100:348b:fd2d:79a:9019])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35e49262fsm26823392f8f.44.2025.05.23.12.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:51:16 -0700 (PDT)
Message-ID: <af1ddf74-1188-46ab-83c3-83293ae47d63@gmail.com>
Date: Fri, 23 May 2025 21:51:58 +0200
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
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: usb: lan78xx: constify fphy_status
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Constify variable fphy_status.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 759dab980..17c23eada 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2630,7 +2630,7 @@ static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
  */
 static struct phy_device *lan78xx_register_fixed_phy(struct lan78xx_net *dev)
 {
-	struct fixed_phy_status fphy_status = {
+	static const struct fixed_phy_status fphy_status = {
 		.link = 1,
 		.speed = SPEED_1000,
 		.duplex = DUPLEX_FULL,
-- 
2.49.0


