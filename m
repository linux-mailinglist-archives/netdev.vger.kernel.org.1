Return-Path: <netdev+bounces-248815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9AD0F0AF
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 473AC30249F8
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D033FE08;
	Sun, 11 Jan 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BkO3z2rF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93AF33DED4
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140317; cv=none; b=g8y0W3M8LiDtdnZVDr0KlNjvgZYgOtdgirr07sZtOnnhVdgoKqWXQJXLxk3r/1f0woTOdp2n2QadGwHCndkzxr2DrA7dIBVBiS1XquXr2E35RDUIfYswQEDQZ7hBDbTLphm24AUGrfO0paYPhkZ778yNd998INgEvs66jyz4kRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140317; c=relaxed/simple;
	bh=XJxqouRZEHyqMQtDF2nj2CC7ybgayxpBpI1cIt6Nuko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq6Ij0wC9Ba6uOddNygi1eZDIdrUYKnJRoY30ZlN1/lShrrRLz3mfflxAhUC2IOYMGGH7GYNIkGzJSniQLhRf5kFwcUPbb4gM86P+iiWnF43SiNGXWPYEzFWrQsvwNBs2ix9mws+oV8bIgHjn8bzwJ5qUzRlI8XaBstHL6FHPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BkO3z2rF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so7207797a12.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140314; x=1768745114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NCh2RDJxN8hiZ1nJoik35Pfikr6nPePDpNs7w6splE=;
        b=BkO3z2rFR8gLFu9KMsttbGGdCIwLHM9rD4383KQBSCw+CJ+lfOYeONmprcyoyZWmOU
         foix3ABm/QKUZPkXZQ02d3llbNlmYK1b5tc9qT1gTTv0gyY7qUa7qIefWRknEuSCSm4i
         dtOCIeiL/TlBE+Gfmpcvb0X5KY6ddxXob6/LF0uZxmTxV04l6TPHYYaxtu4hwIIp4UHa
         fmtFug7tDLjpgqcg6EFliBlyZwsk1p+jeIXItmgOOmkVnlOdQjQqKQsoa16x02wvvS3Q
         FmbIH2X9BIVh+p2zvY1E1z0YKmlJRqn0yUnTW1OtYT0tvX/SQ8j+q1FxVxl3md2KgMyv
         D8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140314; x=1768745114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NCh2RDJxN8hiZ1nJoik35Pfikr6nPePDpNs7w6splE=;
        b=VoOAEXeTeQYqR2bsxCdSbXTAfFELHivBRWK4GMD8xIxfEfdRF70q32T90y1sOp5Muf
         o3e0lALPv8SEqJ8ZWjM/dLeLpT/XNHUJI5mtGUzboa6yTpNA12S9s6Kj2AZO84JoAoFJ
         SL128pwxI7os9HW+X33qTQ254aGzJUItZSTKww5UClt0fOwDqyQYoq+pYvBJA70atwRR
         emNC5YCjV28bwCQXAZey5UjaVY3KecMYZuKKtERKuix+nglIjUOY26kYbS0cbmDgXrC/
         COcN5eXltnbaFRdOWq6ewQcC2pVuM7RnWKcPC6+r8WqrGO+Uc1vlx4+hG8/+DeyP0j1E
         S7cA==
X-Forwarded-Encrypted: i=1; AJvYcCUnna901ulRX/CiEgoQHdvh8106B5Ns8Mh55IhzkbtgqSIWQgUTFQ3vC9DGW+OB83i1wSgONA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+40V14m9+55EK9UMRhBwKFThDXPXOaf12e7G5jkleJEPSwso
	spfdS4JiM5WQ1keropb5w0GIKuSD7pdmzNJPxeEVfxF0v0ip+rFMP539XYn3s7L9s3w=
X-Gm-Gg: AY/fxX7iuATKXh11rSihh0VZ35NmB2/+qZ7PTl4dAFLAhLdhjrBXj4SLFs9fB7RWPB0
	JH/Vq+YHnyqN0jcVWGSD7p5LVHB/rGINJzXpViryxFfMt9yQzKrJANCSlLflmpksSO9K7RDK+mm
	piGNxrMfsiwVkX3cqsdwT0/ZRQkA+H4Io7LAjuQB9JiNs0vTBylpNw220fI7kURz7KO3jYOxciN
	9nuFwCdD/nQU6Y6PBvExLOrbZqwBOrUe1zPQgGtQoi7FIqNNeC3W9LNLT2WvinLeUbHXGWAZrFp
	hL/6o0MQS+G/gsrOTl9pRHOKOd+vZR6qvdNmpyLwUGsWxsNJiQQHfOzevQOZgity9e0clupbVDf
	nENj+J7vQ06TTu9lBCK81BNqUNMC6ttriN+8SYGpeSeBjq07j/+qss2nC1VOHXBVaxqLmiZX0An
	x9CBKQCVUfPoszwgVDVbSXFOnURGGcRN2xlA==
X-Google-Smtp-Source: AGHT+IHX4kBq5in8WgxEwJr9XbVFlnt6AItwyKhU9py/NMR0woB2X72z7DmCdf3HQxhQaT3H7Zh1Jg==
X-Received: by 2002:a17:906:ef0b:b0:b84:365f:10b9 with SMTP id a640c23a62f3a-b844522a6cfmr1333268466b.29.1768140313496;
        Sun, 11 Jan 2026 06:05:13 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8709d11b90sm221829666b.12.2026.01.11.06.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:05:13 -0800 (PST)
Message-ID: <1658b580-cf63-4f57-be1f-0691cc4934c5@tuxon.dev>
Date: Sun, 11 Jan 2026 16:05:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] dt-bindings: rng: atmel,at91-trng: add
 microchip,lan9691-trng
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
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-7-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-7-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN9696X TRNG compatible.

s/LAN9696X/LAN969X ?

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v3:
> * Pick Acked-by from Conor
> 
>   Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> index f78614100ea8..3628251b8c51 100644
> --- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> +++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> @@ -19,6 +19,7 @@ properties:
>             - microchip,sam9x60-trng
>         - items:
>             - enum:
> +              - microchip,lan9691-trng
>                 - microchip,sama7g5-trng
>             - const: atmel,at91sam9g45-trng
>         - items:


