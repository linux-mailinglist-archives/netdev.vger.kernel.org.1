Return-Path: <netdev+bounces-171932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EC9A4F76C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AF23AA9DE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3465D1E0DB3;
	Wed,  5 Mar 2025 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo/CYoSH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB18156F44;
	Wed,  5 Mar 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157186; cv=none; b=NodiuG7UDUszCgFhG9pJCaj43V+umoutYsiOEbV6trOFAu84B4MtmAn75GzcsG0jHLd1wGX7mjhlCftimzrTKMSgAf90/WBDElcfMZ53haaZDatELjJYD344laJbGenOHzQ1TWAS75Ac85u64OKjh83MMwhE2s7KnacQOwgqDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157186; c=relaxed/simple;
	bh=T8kgu10A3Ru0S/vPXVlXR7wrs+4T9jiwbZ+e6G/X/VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCDyhehf51q7o9yElHNrwEx4rmavYrfciXCQHRJWNDdsJqZ8mBjQxXjGDUMnix6PVO0+YmHqmTLg7kbmx+1VU8Nk1+nNsgYWPmFGQ6/8udBc3GH1CXGhOHt8w6j4O7ThE+YVv8/eGfKZUCGY3Q+gUe+crv/kjHsEziUlcbeuhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo/CYoSH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0e135e953so541289985a.2;
        Tue, 04 Mar 2025 22:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741157183; x=1741761983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9bNA98XHBa6A4NtZ0UQAOT1rpXsRwMwVDy3StPnIDc=;
        b=Lo/CYoSHTw1jWSzSqEdG07eoZFjFnsYKfi8MUXk3njUjFGW51DcGB5/oJnvULTTn5z
         TV2Je1BZpQGUx/N7tG7aIpWWdcgCqeHBU4o43QcI+oyQcBQ5u2xxZDAjc/141ZQPCyZc
         sY1Tpjqa0kYdD1yK/8zPzy1OeHvJBM8EnMi07XtfchVANI4odqoEbXQ4d3OzOfoFY1jN
         FV0ed+bS1ris8w13cdkQpEtUH03cbZKH9W6Y+G1MoVtaJVBhuKrSDd3/Fz3rrVsIkm3D
         5aIKSm36pSVssxDLHf7nGd17w9rmkLcVDDf1DHd5Z/a/wIXdZff8QhO2v1qrZlTEQgQW
         YOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741157183; x=1741761983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9bNA98XHBa6A4NtZ0UQAOT1rpXsRwMwVDy3StPnIDc=;
        b=HHlF42S9Fy7VksN2A7y9wPn/jMPczXdwrz5WQz780x21mOt+GvUjjRTzUKeeSI0ssf
         wFMFF+wJSj3iHChKa9/DltQhpNGQBeOyAWFCt7L97xVkCoHaYljmKph0ulD3JyOuFy3L
         HODA3SaEapSYNUDFy5DeWENrLL0JhCDoVXzhnJoT7isIc7Q+pQBGa8AkqGtaoKUSFzdO
         hJaqTLHUc7Y1Am8CmbwTIldwyIvKrszC6kgBci9JqdQ6bLCoIzNws3XiED/1OEtTPcFl
         6a+ackvPlg/SXIEkZw1vxMtDEOVyhZcJGe43tzzqoecBanmIW+HulE+iWPz0jmjg/8tA
         cRgw==
X-Forwarded-Encrypted: i=1; AJvYcCVRd3GROJAPYTHKC5EIZOFJ8lRuPb3Ov59EmRilvA7GGzgbI2mlykmZlZHTMjIThWCwwKgmc8mnslxp@vger.kernel.org, AJvYcCWBDRuaAlITBZr0qItdlYRGTFaFIFXEZCUGs1X5cs0WQOlHO2TN3XI/5k1nV/4PfccoqzLyiJsv@vger.kernel.org, AJvYcCXXIfT8RaZMMsyqWEKAwTUwLF8/7Sjbgo/H2FW9quqG6py7U8W1Ac8NYzRsWJdVpVbfqwwcYXJ+aTIIcOHA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfzxva21YGrvQ2McLlXdDoLQVevU+Ns27aoooxVlbQnOAPTi3a
	BgLUdRoP8Df5Zc7U6Xnu2i/xG9N95k7H4oczp0VP9qsqBIV07Wft
X-Gm-Gg: ASbGncsfsSlJw3GxxBNYr2XSWl37yr9tj7xncjpdNlBnmXtR9mB3/fdMzDHe4KiOWS1
	2P+R+gHMlOqgwT38NWn1Y3xhT2Uf5AWVWMfH2nhqDHNQV32fQwaRuinpW/VLotR3iqHnYUxEXKE
	BUwCY1vBwpAb7c40YosXB9xGExJYBFWH2Yv32VJyh97a6KRYWoBRe5QO4s7NAQ952XY95jeMxNY
	muTHMoPDh3d9/ibZH7tzjgyrA1S/meGvS3opOXg7GDWP98FHSZd9oC6cZKXzCe3UpaCh8W9D76Q
	+iRczPXPt+XyUjdmT5F7
X-Google-Smtp-Source: AGHT+IELWtfqwszYoCcC2kmAJwyH6o+bHtBOPZmt0BU2jCIoX9fDIaH8na6Ue5jCSeNPLr38nklDeg==
X-Received: by 2002:a05:620a:63c1:b0:7c3:b7c0:cd79 with SMTP id af79cd13be357-7c3d8ee1cadmr311033785a.38.1741157183364;
        Tue, 04 Mar 2025 22:46:23 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36feea6fbsm848972785a.22.2025.03.04.22.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 22:46:22 -0800 (PST)
Date: Wed, 5 Mar 2025 14:45:56 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Romain Gantois <romain.gantois@bootlin.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, Jisheng Zhang <jszhang@kernel.org>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	Simon Horman <horms@kernel.org>, Furong Xu <0x1207@gmail.com>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v6 1/4] dt-bindings: net: Add support for Sophgo
 SG2044 dwmac
Message-ID: <n7jfcncujogjlysfd6v5bbt7tzun2sicx3r3jq3s5ogm5k4ths@y7wwlyijemgx>
References: <20250305063920.803601-1-inochiama@gmail.com>
 <20250305063920.803601-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305063920.803601-2-inochiama@gmail.com>

On Wed, Mar 05, 2025 at 02:39:13PM +0800, Inochi Amaoto wrote:
> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare
> MAC (version 5.30a) with some extra clock.
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 126 ++++++++++++++++++
>  2 files changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 91e75eb3f329..02ab6a9aded2 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -32,6 +32,7 @@ select:
>            - snps,dwmac-4.20a
>            - snps,dwmac-5.10a
>            - snps,dwmac-5.20
> +          - snps,dwmac-5.30a
>            - snps,dwxgmac
>            - snps,dwxgmac-2.10
>  
> @@ -98,8 +99,10 @@ properties:
>          - snps,dwmac-4.20a
>          - snps,dwmac-5.10a
>          - snps,dwmac-5.20
> +        - snps,dwmac-5.30a
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
> +        - sophgo,sg2044-dwmac
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
>          - thead,th1520-gmac
> @@ -631,6 +634,7 @@ allOf:
>                  - snps,dwmac-4.20a
>                  - snps,dwmac-5.10a
>                  - snps,dwmac-5.20
> +                - snps,dwmac-5.30a
>                  - snps,dwxgmac
>                  - snps,dwxgmac-2.10
>                  - st,spear600-gmac
> diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> new file mode 100644
> index 000000000000..4dd2dc9c678b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2044 DWMAC glue layer
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - sophgo,sg2044-dwmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sophgo,sg2044-dwmac
> +      - const: snps,dwmac-5.30a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +      - description: PTP clock
> +      - description: TX clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: ptp_ref
> +      - const: tx
> +
> +  dma-noncoherent: true

Hi, Krzysztof,

I add this property due to the discussion on PCIe binding of SG2044, it
can be found on link [1]. As a similar change (at link [2]) was acked by
Conor. I preserve your tag on this binding. If you have any further
requirement, please let me know. I will appreciate it.

[1] https://lore.kernel.org/all/20250221013758.370936-2-inochiama@gmail.com/
[2] https://lore.kernel.org/all/20250303065649.937233-1-inochiama@gmail.com/

Regards,
Inochi

