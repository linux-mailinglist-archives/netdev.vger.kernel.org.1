Return-Path: <netdev+bounces-109121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01676927105
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843A92811C6
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929E1A38E4;
	Thu,  4 Jul 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKCBaGzk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7551A0B07;
	Thu,  4 Jul 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079812; cv=none; b=s4APc/ke0sZW6IoobitxPo4D3vSJMltANvxttTGpBKqxxGDYA4JCS1o0L5KIc1h2K+5/BeZPa8SUCY4zCw1jY6dPYhwYuDFNy3WE/y9UC0MkqbH6qXMdPO5LXf3SqG5OqX+mBK8mEVDTEkgEUh7ckLy/IbyEhuSnKcrNtE0KR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079812; c=relaxed/simple;
	bh=hoVFwIi7Lm83goOEWi8wU9f6EkbdjoADWbfAuZTwfJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omwjkoBOg44qoGkg6xJkr7m+0LlrtqyM0ejefa5Aa3MGIlUf/EF2b1wn30kuSE5+8OJg6ddnZfi+ElSiJs3D0WGfuwF2M4XF6eMurwFffVHUod+46QVvHDfGAlhd98EAf+1iJvYYK3m0w7QKXTDI/O8Ha3fd/ko3eLF7uQUK4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKCBaGzk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee910d6a9dso404101fa.1;
        Thu, 04 Jul 2024 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720079809; x=1720684609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MC//Jt155OtPzEJgjMqdaEMtRJLJr6GW0gLkD4HSAFU=;
        b=bKCBaGzkZyY8fT7HpBbUZu6MzhAtqd7K3GDe1wNqUurWOpuqiwreE8FaU20LYIUjPP
         5+ehTDnhaPwZ9p9nbPv6BZbp/1FOWOjGz7wf5ThCB74N8m8Qf3zpE6+6+yx28n/yNNTS
         8BfBFAIBEzerY7jzQnYJNW6p2y+vliiZXdbzQUe0KDYTULXjf2RsSJzKWkDVoY16YMZE
         HKT8q9gJ3X1MHRdhqgCY0BxmwqFd4cY1LCKNhZWrMnUyGhCnrhXzQ2yZ3QT4hkE9sn81
         zvbdp+eBl3FJoG1RXzC42mJr6cIKIQuPDCyMcOMQy8M7QLeme+mcUXtcq5IpJ1E9vptT
         ofbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079809; x=1720684609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC//Jt155OtPzEJgjMqdaEMtRJLJr6GW0gLkD4HSAFU=;
        b=i4OZ56L9x83YX0zBoVKsS282mG8D20oBo8fRq1Ls0wHwqfFOKjs14bGU6EIhVFpQgk
         ebJ7V4aOVTQ/RjVgFQ2dNGjL+/TrWGARKHBbtIoD/zDu3r9tKg1Ao07deBWO1KB/5fjQ
         wXvJOwnGTsJH8/4bSUDHTMxvYae4PFhUOPnSpARlkFQUUIV4x59gVGmyl4kNSLUA2ptR
         aWVsr2jLe9zr1QcCLxSD+bMvDeHkCbP81Rjk9W0xbU2vPFYj25qXCYV5ZRG9Do4UAswG
         LhIStZAgcu4olfe+AucdPfTLhyAFUs97w/AxGgdKJqdhmSms88soWzUOKpPXxUXFNepY
         96Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWFlRS4tQNnUwbuy+ZUblcQkQNirz+RfcteixU73sxyjplsfbE17r15RTuuODQy71ZFJTR1Ot2QV97mZBaZhBPtROcNNghckdrfAWlUDpLimwBDtU2tFI2bh5IUIG/3e0nq4NiF4dtlJO6NiDHKc3iSFwAhUELrxowPSAEBhrjl2A==
X-Gm-Message-State: AOJu0Yxs6eV2uJ3vNCtKUavUh7lS4+OEYe1fVFJ9oWr7JivCaUt6yYiR
	SuOScOXH34kNLzyyk/vW85yKHP77h0SOIfnCRTt49R8AsLgUn69Z
X-Google-Smtp-Source: AGHT+IH8vHXEt7rohBJbbN7OKP60OIDN216n0d2ah1Y2BHFfUgWWLvZXMIjfXlFhDQmaAcBu5FuhJw==
X-Received: by 2002:a05:651c:990:b0:2ec:5172:dbc4 with SMTP id 38308e7fff4ca-2ee8ed8b7efmr6265731fa.12.1720079808427;
        Thu, 04 Jul 2024 00:56:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee81c79a73sm4026811fa.45.2024.07.04.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:56:47 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:56:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: net: Define properties at top-level
Message-ID: <c7oamspfai2zd347vbvmwg4lyqw32hfkwwcl2u5trg55apijew@hskr6tm5mfjy>
References: <20240703195827.1670594-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703195827.1670594-2-robh@kernel.org>

On Wed, Jul 03, 2024 at 01:58:27PM -0600, Rob Herring (Arm) wrote:
> Convention is DT schemas should define all properties at the top-level
> and not inside of if/then schemas. That minimizes the if/then schemas
> and is more future proof.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Drop the parts already applied from Serge
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 28 +++++---

>  .../devicetree/bindings/net/snps,dwmac.yaml   | 67 ++++++++++---------

For the DW *MAC bindings.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  2 files changed, 52 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index 3202dc7967c5..686b5c2fae40 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -68,6 +68,17 @@ properties:
>        Phandle to the syscon node that handles the path from GMAC to
>        PHY variants.
>  
> +  mediatek,pcie-mirror:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the mediatek pcie-mirror controller.
> +
> +  mediatek,pctl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon node that handles the ports slew rate and
> +      driver current.
> +
>    mediatek,sgmiisys:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      minItems: 1
> @@ -131,15 +142,12 @@ allOf:
>  
>          mediatek,infracfg: false
>  
> -        mediatek,pctl:
> -          $ref: /schemas/types.yaml#/definitions/phandle
> -          description:
> -            Phandle to the syscon node that handles the ports slew rate and
> -            driver current.
> -
>          mediatek,wed: false
>  
>          mediatek,wed-pcie: false
> +    else:
> +      properties:
> +        mediatek,pctl: false
>  
>    - if:
>        properties:
> @@ -201,12 +209,10 @@ allOf:
>            minItems: 1
>            maxItems: 1
>  
> -        mediatek,pcie-mirror:
> -          $ref: /schemas/types.yaml#/definitions/phandle
> -          description:
> -            Phandle to the mediatek pcie-mirror controller.
> -
>          mediatek,wed-pcie: false
> +    else:
> +      properties:
> +        mediatek,pcie-mirror: false
>  
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 0ab124324eec..3eb65e63fdae 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -512,6 +512,12 @@ properties:
>      description:
>        Frequency division factor for MDC clock.
>  
> +  snps,tso:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enables the TSO feature otherwise it will be managed by MAC HW capability
> +      register.
> +
>    mdio:
>      $ref: mdio.yaml#
>      unevaluatedProperties: false
> @@ -595,41 +601,38 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          contains:
> -            enum:
> -              - allwinner,sun7i-a20-gmac
> -              - allwinner,sun8i-a83t-emac
> -              - allwinner,sun8i-h3-emac
> -              - allwinner,sun8i-r40-gmac
> -              - allwinner,sun8i-v3s-emac
> -              - allwinner,sun50i-a64-emac
> -              - loongson,ls2k-dwmac
> -              - loongson,ls7a-dwmac
> -              - ingenic,jz4775-mac
> -              - ingenic,x1000-mac
> -              - ingenic,x1600-mac
> -              - ingenic,x1830-mac
> -              - ingenic,x2000-mac
> -              - qcom,qcs404-ethqos
> -              - qcom,sa8775p-ethqos
> -              - qcom,sc8280xp-ethqos
> -              - qcom,sm8150-ethqos
> -              - snps,dwmac-4.00
> -              - snps,dwmac-4.10a
> -              - snps,dwmac-4.20a
> -              - snps,dwmac-5.10a
> -              - snps,dwmac-5.20
> -              - snps,dwxgmac
> -              - snps,dwxgmac-2.10
> -              - st,spear600-gmac
> +          not:
> +            contains:
> +              enum:
> +                - allwinner,sun7i-a20-gmac
> +                - allwinner,sun8i-a83t-emac
> +                - allwinner,sun8i-h3-emac
> +                - allwinner,sun8i-r40-gmac
> +                - allwinner,sun8i-v3s-emac
> +                - allwinner,sun50i-a64-emac
> +                - loongson,ls2k-dwmac
> +                - loongson,ls7a-dwmac
> +                - ingenic,jz4775-mac
> +                - ingenic,x1000-mac
> +                - ingenic,x1600-mac
> +                - ingenic,x1830-mac
> +                - ingenic,x2000-mac
> +                - qcom,qcs404-ethqos
> +                - qcom,sa8775p-ethqos
> +                - qcom,sc8280xp-ethqos
> +                - qcom,sm8150-ethqos
> +                - snps,dwmac-4.00
> +                - snps,dwmac-4.10a
> +                - snps,dwmac-4.20a
> +                - snps,dwmac-5.10a
> +                - snps,dwmac-5.20
> +                - snps,dwxgmac
> +                - snps,dwxgmac-2.10
> +                - st,spear600-gmac
>  
>      then:
>        properties:
> -        snps,tso:
> -          $ref: /schemas/types.yaml#/definitions/flag
> -          description:
> -            Enables the TSO feature otherwise it will be managed by
> -            MAC HW capability register.
> +        snps,tso: false
>  
>  additionalProperties: true
>  
> -- 
> 2.43.0
> 

