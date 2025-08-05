Return-Path: <netdev+bounces-211690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5810CB1B3C1
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E247B3AB60B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF4272E60;
	Tue,  5 Aug 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOLh531q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BE2727F5;
	Tue,  5 Aug 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398098; cv=none; b=Trmg2Vm06ZezYRLGfpeMKDIkokw7otYG3yV6RX19DyIkoRysZaWTsrB/7AuMSNkiwK2y9Z9WdpyTFlQH7gFIbAlRcDfU9isS13j6vWUqWc0pbPeINnX5GG2DiYEt3wvrFAvfaAJdLzrlJ2Zu+O8CtVEWaw61yeVM3GJxvLc0Nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398098; c=relaxed/simple;
	bh=zMYW5Dc+amN5HAgb+PGEOgBovaSlEsCMYnLaFnLlMXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JT1q3H2ZxgCnWmK3aYSlX/jMAH8ym5e8SUHn8dYcV+Fr9+pkCuCKtKXNFU5cMQYUzmpk4QsMGtFwWj0zeQUtA8TqnAMW8/zMy8fCh6wHMrCu5heuYbymdEpgWZ3yhpq6uw3uwAEHoSGATzpk7UdhBgHLvDiQKYtz0U6ko+7yIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOLh531q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so4672141b3a.2;
        Tue, 05 Aug 2025 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754398096; x=1755002896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwJfXNbCpAaf1tvDKNhH5lAo52g5GzwEwWVp4t5FoPI=;
        b=XOLh531qpcochHpJYreUE2+98zjCvxnoNisLc+2+XYxrNaYbrO+919X3+St6w0PMbs
         agMQb5Q0tT1Dr8PcwNSdEQxB7BvoCtwBdyXmKkFKWr5knVLbUkfbgSwtzTPoVO3zui1m
         Od+BnK+mZ+nY2GAaHCspQthd1HZoQNrmolwC/OZz6OnvXlg/eFXqR6Lv2hUOWOAKuEZE
         uNojL/679tetZNXJhVd1mtkpH1snNolqPKdHczPDSBBbt8K33IiZvpoFJWfLPRuq0yM8
         dSQTswy8wrWUIFnUvf5tK753B+iKEUvP2CTREmEwtcOWxe8yjMD3STwl7dxMX9XayWmE
         OiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398096; x=1755002896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwJfXNbCpAaf1tvDKNhH5lAo52g5GzwEwWVp4t5FoPI=;
        b=XCivwM12rONsPCOYViXHOcDU7VHoAoZQlatXbPvgUZOOfB2U00dNBN+QvIh5pUscMD
         3QHk0/JgR9z+mcEJVIDvWnyGnEyaSwlUJHaYOLWXD5q7CcN524SCKkkc5qkPoGdn2j7M
         2kUmxQ0jURdKWrYgA7YlwwmLqvaJaOVpKxi7WDdxWZZRFClldxFrx1hlTWmMrk4w+IqT
         H3UHDqR+Ls/ik40uyfxRKCrb440Yybhi5sr64fjlL/rUlMXVnnlaCfwEYAcn5Xaqzcr/
         o915ySjkM117jEing7Y9C6mxxuZ1EJm5U3lWy43TzggPugI/e9gbIhaYb3GaMxFS2Nd2
         AU8A==
X-Forwarded-Encrypted: i=1; AJvYcCUAe2IgK9JZLmWEJCfkX5RvSx4DDNM74e2NsSYES0Ph9cybjBP6ynAeoIkW2m8kvyEQ0duGblT1c6MPqOW/@vger.kernel.org, AJvYcCUiuEcitVcYCt9cRoziY1EQrGLLbIr70n6aulL27nT0HCQ47BoaK4scj9kEtCGwXc+e0ffHoYnb@vger.kernel.org, AJvYcCV1gLytK7tUndeKob0gFjsTCW1RCFjtj0Y6k5Y9cYJBgamyTSTeU6LXJWuyUnLB67JWKkmNzVlnN8ab@vger.kernel.org
X-Gm-Message-State: AOJu0YxhshadTqPDmfB6Cfn1PQqTEhydt/0dfhY45j4V2J5h1bR33HSO
	6bwlrPDHguFzN5Dm+pEOtOQNbqPmobwaS0VJFniqCiPrg1M2vHDyuPnR
X-Gm-Gg: ASbGnctHL5MBaCbzZFzPOzp5PYJYzRCDzeoaYeY8HG7psa8pd+85xeoZsTfE3kZjiwp
	p3uDcrZ2cU0dtLqux+eneJ0Mbji3hDKwl1K8e6LACdTcUejF6pXusQ0z1tZ7XL7ZFvDQpZt8CxO
	CLKX6TlORzRWmGF7jGnsVy6b0ByTAwfUrseIanGuEiBG8B/hDjHwtlawULBONDHRxiLgKG2PK2G
	C65pWQ3x7X/GM7UADbbkYfmbA9SWCK7KNAiQx5hQ4jOvgzDNgEGykPp5HxhAn8Z3OUDjQwfw8Lv
	wFSgXweLtn4otrhzwyXvl5XPhPaQxVdqFjOQaYP2hxDSjvWvaXC3oY7/FQaBrOM1++VhUhPP598
	c3Q/ideaI1m2K8IerRTmjBgk9ck3tuRQ=
X-Google-Smtp-Source: AGHT+IGLP0rIe8sm1sv9dF85p8HSkB21IbSlnit3fmQUaj2sMz2867GX9FBja2F/tMnc9XANdtsdjQ==
X-Received: by 2002:a05:6a00:1403:b0:76b:d67b:2ee0 with SMTP id d2e1a72fcca58-76bec308509mr17921117b3a.6.1754398095668;
        Tue, 05 Aug 2025 05:48:15 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfd8f8dsm12923915b3a.104.2025.08.05.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:48:14 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:48:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
Message-ID: <aJH9mE55UjqdFoQk@debian-BULLSEYE-live-builder-AMD64>
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>

Hi All,

On 07/24, Krzysztof Kozlowski wrote:
> Emails to alexandru.tachici@analog.com bounce permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace him with Marcelo Schmitt from Analog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> ---
> 
> I don't know who from Analog should maintain these devices, so I chosen
> author from Analog of one of last commits.
> 
> Marcelo Schmitt, could you confirm that you are okay (or not) with this?

Yes, I'm okay in taking maintainership of those.

Thanks,
Marcelo

> ---
>  Documentation/devicetree/bindings/net/adi,adin.yaml     | 2 +-
>  Documentation/devicetree/bindings/net/adi,adin1110.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Documentation/devicetree/bindings/net/adi,adin.yaml
> index 929cf8c0b0fd..c425a9f1886d 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADIN1200/ADIN1300 PHY
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  description: |
>    Bindings for Analog Devices Industrial Ethernet PHYs
> diff --git a/Documentation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> index 9de865295d7a..0a73e01d7f97 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ADI ADIN1110 MAC-PHY
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  description: |
>    The ADIN1110 is a low power single port 10BASE-T1L MAC-
> -- 
> 2.48.1
> 
> 

