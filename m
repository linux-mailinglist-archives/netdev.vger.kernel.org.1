Return-Path: <netdev+bounces-222260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACACB53C33
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F2188C47C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED623D28C;
	Thu, 11 Sep 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGshL3jC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367A1E32B7
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618430; cv=none; b=FbBmqidBVIDX2ALR/HaIQIgk+lfIxxxGYr0RHyBxkIS2SBoXLayaNyuLi7kPCf/3OmqTgL0/EAbrmqjMD6W+DJ3FvJj1zYXioJIg4kFz0MYKG55qhjI8Mo/MvE/yZzJBbi0+kMYIUATojm8b8oevDJUgDvjdMINsL/fL6v/YnvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618430; c=relaxed/simple;
	bh=V7ucydsWwpVOeduUTHf66MG5yhRgS1dFiCcyCFxG8B0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QIRjoRWrwC/OQHU7hPMdcoFLm/iDgKX1fKTj0/oO15JL3PMw9Qsv2QAIIs3/LBkOIC6sNqgDpy1T4nc6ZeuOvFG+ODuH8ifxhjFLVkuYh7UDaYuie7oxeGYSQDXgcJY+VFv8eWi3jVQjWNDtGY9bYwrXSdxEcX+1+S1MKyH2sPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGshL3jC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so10277575e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757618427; x=1758223227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L7R+q7ClhKK5B76AebiTdWbDg1ZDZSOPGdV0Y7uE910=;
        b=dGshL3jCOiA36fHo1JTjGqfnEkt+AI7BTFPtGUNGEl91Ay36ImcKFaFzp3iPnrBk6b
         UR4b400divzEQmX5x8vi3T2ddMPvpJVc3QC5V3Ir/6S21+2z/CRljT8bdvjPX5XYvBb6
         aAcJ6Ne9yEsgCS9VftmANUnQtMJlnTWjODXNQnp1tdjz8z7q9aeaJ6p9JywZtqxIMk6W
         A/ySogGqf0HEztAOhmL03M54PU56Zpcckq0JorUxWpruyAY+hKB0/hNFdJvy0cDnidSD
         5LecfDVoj5C3IO5l4miVWMoa16S2GVpzZTGHJkPI22/uosRIWx0d8zdbWTLQinULzIiN
         UEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618427; x=1758223227;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7R+q7ClhKK5B76AebiTdWbDg1ZDZSOPGdV0Y7uE910=;
        b=xOuidaUEfIo9m3aD8ifhUnkj/g+QHK5EvEWHxpKcVO9ifb/NOpe4FfBq5zoP5v8AE5
         Inm5YWWRFBszsh/vSffZXIeOdeKNX2RG0F1YWLe0MXC5PjFFnW6GLWtUTW6PbSKQwulA
         piaIhueG6oEgWfuAWMRZbPoe8RXLxNA+RZdfyBZgrV19MJVxv9XSn3BOenZYAsVZXXrA
         vjAr/SQY4rfpKzsljr/WszksWGeB/Ponf2UCrbeW+WrQfLMWLUlRvTYUTzXXc5W3pxmx
         p9Nn3RxRpLjwuWjhoymM+vT4NNE9K0l9hW0FIScVAakoymL3NZipMwrQTyIrMzbThqm5
         b7Og==
X-Forwarded-Encrypted: i=1; AJvYcCUFjmYVpc/xt/yx2vMo0tbu/OC3TMew/XyNMLAwQijkjtEeLYu9GiYGj8L9v3ivWlr//2IPokI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/QaU25iQtV6Vt/1xr06xOq2YDtPMSVjLmkSEeoDEtphUVzsy
	jZCJkOhgz1gnwNMi7t0hQC9ThH0yBT+fxkkHbLZDqhkbxnygj98lslpM
X-Gm-Gg: ASbGncvuDW25sUv9TAOsfkVZyRvGMP9IFKevvqbqxzj7ndbhQm+sI1KOBP2lcPC5v2B
	CAQkIxTqUyOvY6tGGBCcAZhG2+6iCf/pVMENv/yax1jg1vbiOWjXqXUPODXlNmJ7sHzy8ntgqkR
	gB4OXSox28hg/dnl32mpATbB7+fZfqLE+XWaSvtoWmno1eTdnB31RjJWMHO931+WofeSkzOOYNX
	1mXc/njPobgULGx/YJvDJ9ELX/5n7usM+CuGx3dJqNi58DBMdiMPiRL4qrIF3vzsiCsNf0+JU4x
	u5JzkLrzUPxio30Y3d1yfU4r/IVZRKduX/9Hw76FecXMIarljMJxKixgBIchiEDI8vEkPOkhR9j
	z3wUfedws2CxWBFKakJXUZSpKf1WZ3h7upeuqN5ukOePAaq+nodjtJliueLR7LeoJMJLMMMM0J/
	ZHovf3BsRMME/mZE8So8zi/JQ1bfDvaoap86PJC5fY3CuOIiIjUDfAvbrKtjjtOg==
X-Google-Smtp-Source: AGHT+IF5BAJZG6aBnXfKkua9SsiW5nqoCYCVPcsvoidWtydvrVPWNixD4TIR9kQKtWhmsm6oIBhdrQ==
X-Received: by 2002:a05:600c:1546:b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45f211c4c03mr4544855e9.2.1757618426362;
        Thu, 11 Sep 2025 12:20:26 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4f:5300:1cfa:4708:5a23:4727? (p200300ea8f4f53001cfa47085a234727.dip0.t-ipconnect.de. [2003:ea:8f4f:5300:1cfa:4708:5a23:4727])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e0156d40esm38028005e9.1.2025.09.11.12.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:20:25 -0700 (PDT)
Message-ID: <3b6ea0f8-6cd2-4a57-92ab-707b71b33992@gmail.com>
Date: Thu, 11 Sep 2025 21:20:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 2/2] net: phylink: warn if deprecated array-style
 fixed-link binding is used
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use %pfw printk specifier
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
 
+		phylink_warn(pl, "%pfw uses deprecated array-style fixed-link binding!",
+			     fwnode);
+
 		ret = fwnode_property_read_u32_array(fwnode, "fixed-link",
 						     prop, ARRAY_SIZE(prop));
 		if (!ret) {
-- 
2.51.0



