Return-Path: <netdev+bounces-126579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98D971E80
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E508B22B2F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F481727;
	Mon,  9 Sep 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyv9JeuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C677110;
	Mon,  9 Sep 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897388; cv=none; b=tgpqh15bK3kAvlPCnGcEH2XGm3sx4LRg8fvbiMyCk8W9yBitwiFzsCYB69bKpwUpMkOa3sUjM62wNlokGNuQG8PVa6ElxG6cOL5syixAIBw+PZG0mU0VI9Sk3DgdqX32TQvi2vcOslGETFKNbsxAZ97URGZTOP8RVaH2P0mg2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897388; c=relaxed/simple;
	bh=pT2EUSaLUXi+dOJKC0VVWgsH8wTzFavxhQ7iLA4dl+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKU/99zLjRkPP3o5WDNwgCSLPnV7HmNu0b8gvuY7qUnzFWiUCKkH+N0rENDlaHo6AhNhdLM10iMDJQpxsX1jX81eF58hhqCK9jEXbGd62fOj2MVuWKcrOreOa5MYQ9RKjKbxMhtBGhSaAXpi4TtLfDpgDW5ju3eDnOlwiYEpkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyv9JeuP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3217384a12.0;
        Mon, 09 Sep 2024 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725897386; x=1726502186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9dFyHJI2v/P8Ov3wwNKVMHA53Z7GGngYjJBvosOcyvM=;
        b=Gyv9JeuPGIlp0Jboe3V3j2bw3rqVX4TYcRloMsNYIoAvPGk0uR+HlwWkYnCAZywxOu
         fQ3oXuTvSTOtwsx5fVkXD0cQjjbVbkyaFIOz/iGo7Ex+BK3iX0fCien7OmihVBj2TCIL
         zbiDdwR3z7o5+mA3+En5Pco6cSImCgkVi2Dy9wd2REs3hPNCSJO0CGzk60MmwAwtbKEJ
         qds2sWTxSOU45rh+dkq5FKfa2Y93OpMsCUzVAN83fq78sjxbIN1e/5kiq4acitxeavrK
         jiZjWxjVlTye0RXThHrzYiXinAnqU/IwzjMiDOjSdPeI7Sx0AVYS9U14BayZc0FSkLu5
         SUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725897386; x=1726502186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dFyHJI2v/P8Ov3wwNKVMHA53Z7GGngYjJBvosOcyvM=;
        b=KGJpxFu2uCz9/ltI928FHYekYFpCPROzpn5G3acWoamnSQCiT+p2u771ZUoMefYRCp
         z0iLXAig9UdUTexdhoguQuq8kKFp061oq0AnBcCs0+YVlBoc+Dwj5KfW88uFTaBCgWXC
         /h6yaBDbkksobuIKX/99PI8dkYQEHckigmhN6/dBCHNew7ETzUvo85XAWRENAoXfZvlN
         kn+SGgXzG4Q5EuOjeDwmDm7EPVUHqwUfY7z+y5rpZn8HyYrumJ5DHvHTPxROKBYjwuW3
         qfOPPfsWVOsRj0rpzqoMyZJ2gS+FPqpHYzzabUotxlcsSfSrNanT8JlT5OLxUuS9PyDr
         Vvtg==
X-Forwarded-Encrypted: i=1; AJvYcCUyZm9B/PLHyqIs4eGtwEPp1FmfBf7AyNGWB/YuHpFSaWgJcN1bqoGkXY6Zn9DbEdASY+qfQz65@vger.kernel.org, AJvYcCWEPYGT/cCOfj5DDBJLVLYv8bAfnywNdZrCBTleiEOn3cOv8KqHPCDCtkhTVUqH327+zYOLuBJDKm1k2mwr@vger.kernel.org, AJvYcCXduJFFP9Xt4FrZfj5P78ri0FbT0AZSGxWjCKclEPgvUCdSnh7uVETQEMUZ+pygFyo9T2J56voHycwP@vger.kernel.org
X-Gm-Message-State: AOJu0YylIedj1ukDChYYhVnvXWTghiQgrUvAXH3uleB7SnvvTgw8lh52
	06WJ5Ip/VoOpglvhsM09Q1WhDWLuIzPCLGHjihjXzclHL8gAmOI+
X-Google-Smtp-Source: AGHT+IFrvFzePGSvr3x+U1HAhXpiaJt7YCnQsmyk2Qasm8IxN7EsKlYpk5e2kddp324I2xmvA9iuYg==
X-Received: by 2002:a05:6a21:a4ca:b0:1cf:4d8a:a12d with SMTP id adf61e73a8af0-1cf4d8aa3a7mr890091637.1.1725897386098;
        Mon, 09 Sep 2024 08:56:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5990c24sm3664181b3a.213.2024.09.09.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:56:25 -0700 (PDT)
Message-ID: <b08916e8-e682-450f-9253-efb001abf759@gmail.com>
Date: Mon, 9 Sep 2024 08:56:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: ethernet-phy: Add
 master-slave role property for SPE PHYs
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org
References: <20240909124342.2838263-1-o.rempel@pengutronix.de>
 <20240909124342.2838263-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240909124342.2838263-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 05:43, Oleksij Rempel wrote:
> Introduce a new `master-slave` string property in the ethernet-phy
> binding to specify the link role for Single Pair Ethernet
> (1000/100/10Base-T1) PHYs. This property supports the values
> `forced-master` and `forced-slave`, which allow the PHY to operate in a
> predefined role, necessary when hardware strap pins are unavailable or
> wrongly set.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - use string property instead of multiple flags
> ---
>   .../devicetree/bindings/net/ethernet-phy.yaml      | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index d9b62741a2259..025e59f6be6f3 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -158,6 +158,20 @@ properties:
>         Mark the corresponding energy efficient ethernet mode as
>         broken and request the ethernet to stop advertising it.
>   
> +  master-slave:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - forced-master
> +      - forced-slave
> +    description: |
> +      Specifies the predefined link role for the PHY in Single Pair Ethernet
> +      (1000/100/10Base-T1).  This property is required for setups where the link
> +      role must be assigned by the device tree due to limitations in using
> +      hardware strap pins.

Nit: the way this is implemented right now, this is also applicable to 
1000BaseT which is fine, just needs to be called out explicitly IMHO.
-- 
Florian

