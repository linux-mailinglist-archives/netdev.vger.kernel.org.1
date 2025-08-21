Return-Path: <netdev+bounces-215614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5EB2F8D1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B264B6434E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC5311C0B;
	Thu, 21 Aug 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e79uk4uh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA330DD3E;
	Thu, 21 Aug 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780615; cv=none; b=eA1BqaFhjHzy7JzPz3p1FHLbY7KCVnPgjivBMMNVldcqbp+YzDR/c4H+PAQKl/AIwpoYuXwtuSe3PIm6rtWscYxZ78UgcUQpUUmTdSboy6fdOGSjQyZ9U4IrWw9a1kXxmRNx4CJrBZ/WYIIRhUYg5e1OKQ9o/36sKrzkZfstHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780615; c=relaxed/simple;
	bh=GnjsYseB3x82SxnBPiq9wVpuJ57d9eN+HPgAIsk934U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLMoLABBV0JL//dzdxd1N5Q4z83bCAAWmEdUQlwfAZennJN6UaiwTE3odh8wlsnnYq1OWgx4xaNslS3A8hhE9dMgRfrrBiUH9lfv4INCDBMT74/AVetoCpkGVmHoVeinmpPADsG20B3B0Y1nwpMBVRb5HJmt5D4LcbLpV7Jkmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e79uk4uh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e8705415ceso110538085a.1;
        Thu, 21 Aug 2025 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780612; x=1756385412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPd7TEjWkozgvC/v5mJtOM5zRUUP6vJZ0SAdjA9o64g=;
        b=e79uk4uhwK/lzYFLZO3juq26t8RDdGBqcFL6uRxd+Dx003nscSeYQmdFJooCWsDC7J
         AVkDW5zSEU0BZVklNDbZZ11d6sOuRMmY2nI1ac8QoAqG1wxMDQIaG9SQYGJrCwAn3n1j
         Lvs9+D30GuzL5kxAZ6fTOjVTlG4JJQwj2GmP34jm93znJhdQYaFijuomw14BXKCFxZY5
         Gmea2ToU85z2rnIle3W3qzEQuFwcL13QhPd9qysSvK3MaEjCVoa4Y+Cd6tQ72/OirypU
         Jb3TEIWJ/cqRyxgEqOyfbJulgoGjhUrbxXlIBRKKMlKGHnIGtIpKml2Te3qjaGvheiKF
         LNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780612; x=1756385412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPd7TEjWkozgvC/v5mJtOM5zRUUP6vJZ0SAdjA9o64g=;
        b=oqMj2SluRZQzaL6abF8Soh2fFX0WSi6454Y+AE6KBxwEWBbIhQSqDM3O0Xs89JVQfR
         VbebnNY5AMzODool0TRpsbLmhSoD7zY2U/kAvWKQcNtBdI4EK1ryDezMi8j71sW3lbwf
         RKR4qwTjrmb6x6Ha6E9unA6AV6De4cVI3rT6NQk+sULMyMejzov9z0cgTfFJx2T6aCg5
         CVWFoCCHolDIue5TaEpE7qROudQxcxizN+4vjc+OGoGsrIszIUXauE8rz1MMz8U5De0w
         LGSohhqJ8E3lB1RqDx06nxR4xa/aFxhHhwkAOTjkg00R9bXzQ1lYQekea6BvK3t5OG+n
         XV5A==
X-Forwarded-Encrypted: i=1; AJvYcCUZwYNnEhtGVLcRFtYPP2xhmz58XkcAgPxsl/TJDuqU7RiO4QHr2ORcpfi2cOx/AZo53dap4kQ4@vger.kernel.org, AJvYcCUdzg9n1iHK8EOT9HaayLH7vtRwxQ7HWE0/BUrg99NZmkumz8W1RSExrSQgiYmxqe0y7jOqOOoxXr5F@vger.kernel.org, AJvYcCVNwS/uU9C/HXmU9b1ydcm1kQjwZLeIMjsFfY1FBG20Yu0CaKsHoYcu9muHUhKvUfNND1zBaXLEagyBpt/+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdsiWFzuMSXh51AfG5TeBTjVsuuFP8cswiWw2FfzLd+EwRPgw
	ofiovTeX+TAbWUhcIrBRwZs1hB8/Cr5tJ6cOYKxUl/ogBK9+LMBZGLOm
X-Gm-Gg: ASbGnct7WfYp4oUOgqpb9ZI9DZtJGGMgZg0QB8g53b9EHGiLon1NsH0E9VJ6CLhGuO1
	qivE50+VSXZ6BTm16SrgQmBzOBzR14Fwn48SpxJYcXNW3VjNvAqCCEpDk35i3lLvGj6OkDwhgqw
	xVwKx9aYkIRG3HvwCJtDnQccxpuvOU2AHnfgmligLtoeJARdRUV/H5NQ8tYulvnjY0y+OyzZF6Y
	5AZ0p3jHXY76KhtY/3wWY6+mdtrXCFjd9A8pLOUIo64KJN0dwKEVXEtb9lqycB6ueujFJ3HWY0u
	x5M/V2XUq2KuZI6DNLbaslIcgXSoj7ayYWW3L8tOZ4xAonirOQ+SGypdPzuLs49gACEhzWCVyhq
	aDLCrndLzDCuzNUpwMgYxWPRJq6W8O5OZVFFU0DNnd/ozP3GBKrNEN9Gyzg==
X-Google-Smtp-Source: AGHT+IHKlAINmciaKPdOD0ea73iO/5ZcLBWhJDwWa0ZbgscyKMHmIXQTkwQ9F922ubbV6Q5wAXzySg==
X-Received: by 2002:a05:620a:17a8:b0:7e8:324e:c7e8 with SMTP id af79cd13be357-7ea08e8086bmr221288085a.44.1755780612282;
        Thu, 21 Aug 2025 05:50:12 -0700 (PDT)
Received: from glsmbp.wifi.local.cmu.edu (cmu-device2.nat.cmu.net. [128.2.149.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de44f76sm100197321cf.50.2025.08.21.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:50:11 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:50:09 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: net: litex,liteeth: Correct example
 indentation
Message-ID: <aKcWAant1Y4481q9@glsmbp.wifi.local.cmu.edu>
References: <20250821083038.46274-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821083038.46274-3-krzysztof.kozlowski@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett

On Thu, Aug 21, 2025 at 10:30:39AM +0200, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces, so
> correct a mixture of different styles to keep consistent 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel

> ---
>  .../devicetree/bindings/net/litex,liteeth.yaml         | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/litex,liteeth.yaml b/Documentation/devicetree/bindings/net/litex,liteeth.yaml
> index ebf4e360f8dd..bbb71556ec9e 100644
> --- a/Documentation/devicetree/bindings/net/litex,liteeth.yaml
> +++ b/Documentation/devicetree/bindings/net/litex,liteeth.yaml
> @@ -86,12 +86,12 @@ examples:
>          phy-handle = <&eth_phy>;
>  
>          mdio {
> -          #address-cells = <1>;
> -          #size-cells = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
>  
> -          eth_phy: ethernet-phy@0 {
> -            reg = <0>;
> -          };
> +            eth_phy: ethernet-phy@0 {
> +                reg = <0>;
> +            };
>          };
>      };
>  ...
> -- 
> 2.48.1
> 

