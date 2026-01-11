Return-Path: <netdev+bounces-248824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172FCD0F348
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA8F30478C2
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4D34A3CB;
	Sun, 11 Jan 2026 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X9Wk2tta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274EC3469F3
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142729; cv=none; b=NwoQz2Um1RTOOsyv0sw1UgPB7nKLE0XLBQ4KnmAN890Gn4bh05tNQFOYMWTKuSYmMmczXZ49D7RYH3ush33XFBKMqLWN7C0PFlWK1/+y77MYLoXv15zKBwlGGjUMg/8rQPC6akPN2Xv5JP60qxWNPNcjC3lJPEmV8YNVjQaOx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142729; c=relaxed/simple;
	bh=YDHNGLJfluFKzT2RaL2uk9Ugi0ok4Sk7jIeMDkApg6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWAFXtkdkh5IASH5RmQ/K7auc5c2pQmRQVxwRap8vtpNYepZfvLQgqEHVQdXBQqxt3BxzeuLZcHCPxfrMqwm1qinAaoYbkKhU6qZLwGwW52nkLzQ24NOD1UguGUPEpi8lmErkUoN8nhbwNSM6v6uTW+J/eMUtqr0eaDh5+vn2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X9Wk2tta; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b87018f11e3so108446666b.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142726; x=1768747526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6rwalswAWwTHAknUrP94zFyJo4NhuP+T6GegkCWM/M=;
        b=X9Wk2ttak/FxxYeh5WLK137PvXT2Bo+6f4tTd7DoZEvDfH1xyhWoL4n6yF/gvnCw8z
         z+h9Pq1VYPIop7EYoYHEF/ZvxNpxMSSGAdL55uhaBcqSfbLSS6+O0g3gtUKbcER1Z7IK
         s2S2cmElL/gpcQWFvwhm/u+qSVXzl+qK0VjAc1Dk2jlacBc88hyZK8whHoOR0r+uNnl3
         9BPa6sdp3h6wLWdtn2N8cV2+HuBUCgov4KQjwoG6XwRdQ8sxApffjIH+TQL/Pc4vRPxm
         y7mX4RoTw9OGMaAtnsluf6omcNfoTTI99nG19wYn4YbH2bFtmLM64ISHwLjSgcuMJIRj
         qGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142726; x=1768747526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6rwalswAWwTHAknUrP94zFyJo4NhuP+T6GegkCWM/M=;
        b=HYxNxIZBcFqtz2YzqNwqaJGL8f8wIQQDqwCKGqsYD+LUC/n9PYoQso6/H15AtZzOap
         vEslf/fO2TPIiVbbQ96qfqqHMa/mmA6u8VxELllx/XEsRkZJBjNZ40yWRnptSrTTnZQZ
         H/S8WhHJoQGrvok4jVV3u00+NTCf6zH6feD+KO7z4rwIY/aFL8K79vuoMq2cfZG8uiNR
         XQqdYDzpuJ5XdvkkivXFiljSVBCWhyn7emPnh/wIxMUn64UwnFYQsf5fkDuZ4/SjF9nA
         UZRrIarHTTm4HhsaB/6WOErXCKKquCAamYRr8FdFTwBnrewQfhv0K9qlLJxZPYcF/w70
         xxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhf/iBQeILPgExjsGMjy2Rp3VRyg8jTHTft94MsV5iWJk0t8UVD4O+bOCnQlilBMjX5NkDVwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6M0tuxA3dSoqDnuZ1gtttTGiUzuWkMkPWHBUcpYVZ1DfYiHAS
	3TlrH05ygagj2ZJMCMnKvmjFuO0o8w1hrKqJWVfvcA2VZ6ouvJnzN38IHyFr+HwWWKI=
X-Gm-Gg: AY/fxX6vdwT+S7Zr12KuUAK/JUd5AbI2OHWk3EhivF6UFQ5pdusZX22r8FA6pwp++om
	rjQUDERm9idNRwuMX0ys5ratgS2DSJDUwpQypW1zpC/Docxspmy0UaSDaIB0fKO1vptl4pHSt2B
	d2kuBAkAcxaL6y3TNvQ0QVX9QsZP4Y3S/nAZqqpWb3sFoZQbftQ7OI1Mvk4hWAuguhZRGVO8UMX
	dykjDaw//bC10zZYY8B5V3bK6YhPLNeeewX9vxXKLVyQNvGb6ATW5p1N2vCbJI16XLVT3qaCH5+
	DyMlr3eYpo1RbiwSFRVjHzoIrUpIoqmOm/OBWa4AX626jGQDJcqMK1Nx5QDtYFKAQx2yD0aEgYG
	TwQZUsdeDQqRh+f1iLy8U5mGYB32LRf06xAWoH2qCHEUzXepclWjB4hx2J11rfDSgR4rYSqSHKx
	hwujxs7V/7Kn+JGZJOqjn/YAo=
X-Google-Smtp-Source: AGHT+IGvS7IBApFn5Y6caZIpVWCcEKkW6+CPDWe6wxvm6P/BpWNKX4ZQoy1X15u9d+HjeZrWR8LDZA==
X-Received: by 2002:a17:907:6d10:b0:b84:40e1:c1c8 with SMTP id a640c23a62f3a-b8444f4afb5mr1764352266b.33.1768142726523;
        Sun, 11 Jan 2026 06:45:26 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm1699865166b.66.2026.01.11.06.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:25 -0800 (PST)
Message-ID: <7081b61b-599d-4a59-8a27-291c55a0e52a@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] dt-bindings: dma: atmel: add
 microchip,lan9691-dma
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-10-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-10-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x DMA compatible which is compatible to SAMA7G5.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

