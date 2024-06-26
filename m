Return-Path: <netdev+bounces-106978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E643691857D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EFDB257AC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750B1891B2;
	Wed, 26 Jun 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRdpsHqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE318509F;
	Wed, 26 Jun 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414352; cv=none; b=s94L8bSc89mdpet4Kgzby6nWcWGox2JJDbj0FK/Z8PkzuUs9DFj4YDpPy8jq7yRt/iI3w2weUOKPxyfsb8gtif+yJkIS/EZHmgOy/8eJS8MtKWYpGZDr5rGDesiZpObfeQrdy7vANREZiIoxyuaRH1UwsLm38NLaYNbEyDoIArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414352; c=relaxed/simple;
	bh=IxAd4upe9fmE4XdyGShW3nCD39XW5BHu25DymPl43jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZrjzmhRR0sZ6ZmCVnme73dAoEMGDjnIfe20wtTP82vOUQ7k1mWajW3ADQTOj8cRxxCBk61YK3vj9qy8LCOsHNiPwXk0yu5yFlpuCTRpO/o6p8m9iPngSgZrB1ZdDO3n27C5zBSrvfGW2AYEbEVJ5gVMvfqJbgRRe7NvIKcOfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRdpsHqw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cdf579dd2so4376691e87.3;
        Wed, 26 Jun 2024 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719414349; x=1720019149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhZutRH62J+/FRWi2pPQOnLif3nNehoGYOCj0XwfrU0=;
        b=bRdpsHqwq22hA4cBPjlx8Z990/1QRd01Kx287ciGG5xJPTg3cRqzwnjMiKt9uZK9IR
         ypXFgR63hy8myk+9SjlCSOjqw5tVC91V4TCaxT/8Zp7LlffllWZCgiL93yMKd5GhzV3N
         RoPG7fST9jF1qjBbSbhk2AysJpWiHB9ddGLzXki93Q2EJiqeN4ejGFpbHKGZt2EcHxgb
         mjuhADwgHSQpbABdpB6MkjZ/hHkpAplRZ2el+feVG7o4d++czhk+d+wM18yzZv1ZSPTc
         pz03n6bB4NegizV3rUvAciVoeiRusNpBtSFzHn11bb7gfeZDNVSxwk6fVsghDZELxeBB
         gVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414349; x=1720019149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhZutRH62J+/FRWi2pPQOnLif3nNehoGYOCj0XwfrU0=;
        b=S3lLNzXuPkeFbiA/+YXtTc/7wbWKN6cBoz3rC0OgpYzQkCfLmaSDZBAPCMp+q0CMFl
         aykJsjmEoeEUyNr0LgZRirStBvIKxwj2io6GOIkDuG0ieu/udE5X+A5d56WL6HHyQIo4
         IpqokHCbEQO4nnAflX5R8fI2WF0BAEGZJminHfwnYjTe8zDFKzTDujkwAxLSz8+dJOhZ
         ebQIpwKAgmJh6qDp2ZoEWVqhE9Yz3lGBCCsqSoFAt98zKx0ctKGMyc1vxkrtz5eLMoS2
         ZcQ8hZWyLq4y4bMnx9mi+wG2LyqEJ3v37L2iTZ015HMcDvlh515pq+20AI6aVSoCYItW
         kVdw==
X-Forwarded-Encrypted: i=1; AJvYcCVy6cLc9udzNSxy7bjqDZrtKEg5Lpr4Zt4bbVHZnDvgw9XFcAOxxxj04bG6X4PnaMtptJoldmC2R64jFwQ9kvfH4LEZOQpJhfcvWFp+wjEDJJ5p1zfAjpWvkmeBMAUPBgEZSiPYaDxri6egdmk0KBZpGGL6JfpsZw2xdObFP881aQ==
X-Gm-Message-State: AOJu0YwWKpsvlAwoyBkDTnwlJmw2gIusBg89nY/SzFKBH2txFssEfm7I
	HTfV+6MObioYhZqRKG8Z25nYoNBNfsFXLYKi+6+6UB7mF0KvWVUs
X-Google-Smtp-Source: AGHT+IFfvQuvbFtUymfS+v+q1U8+HqmXwVg3jhbZkUkyGIolFmwzG7d9zEm7xC7zyYhb9iSQcMXKDQ==
X-Received: by 2002:a05:6512:32a4:b0:52c:d647:1375 with SMTP id 2adb3069b0e04-52cdf826725mr7522240e87.66.1719414348270;
        Wed, 26 Jun 2024 08:05:48 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b48c1sm1592588e87.29.2024.06.26.08.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:05:47 -0700 (PDT)
Date: Wed, 26 Jun 2024 18:05:45 +0300
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
Subject: Re: [PATCH net-next] dt-bindings: net: Define properties at top-level
Message-ID: <gr7rgy7cptnpj2rkeufhgqkve4ytqddpts6gdekeszoq7znwf2@ivyjpaiyxruk>
References: <20240625215442.190557-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v3mh3gbsjgv5bejq"
Content-Disposition: inline
In-Reply-To: <20240625215442.190557-2-robh@kernel.org>


--v3mh3gbsjgv5bejq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rob

On Tue, Jun 25, 2024 at 03:54:41PM -0600, Rob Herring (Arm) wrote:
> Convention is DT schemas should define all properties at the top-level
> and not inside of if/then schemas. That minimizes the if/then schemas
> and is more future proof.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml |  28 +--

>  .../devicetree/bindings/net/snps,dwmac.yaml   | 167 +++++++++---------

For Synopsys DW MACs you can just move the PBL-properties constraints to
the top-level schema part with no compatible-based conditional
validation left. It's because the DMA PBL settings are available on all the
DW MAC IP-cores (DW MAC, DW GMAC, DW QoS Eth, DW XGMAC, DW XLGMAC).
Moreover the STMMAC driver responsible for the DW MAC device handling
parses the pbl* properties for all IP-cores irrespective from the
device compatible string.

Alternatively you can just merge in the attached patch, which BTW you
have already reviewed sometime ago.

-Serge(y)

>  2 files changed, 105 insertions(+), 90 deletions(-)
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
> index 21cc27e75f50..023865b6f497 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -485,6 +485,38 @@ properties:
>      description:
>        Frequency division factor for MDC clock.
>  
> +  snps,pbl:
> +    description:
> +      Programmable Burst Length (tx and rx)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32]
> +
> +  snps,txpbl:
> +    description:
> +      Tx Programmable Burst Length. If set, DMA tx will use this value rather
> +      than snps,pbl.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32]
> +
> +  snps,rxpbl:
> +    description:
> +      Rx Programmable Burst Length. If set, DMA rx will use this value rather
> +      than snps,pbl.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32]
> +
> +  snps,no-pbl-x8:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core rev < 3.50,
> +      don\'t multiply the values by 4.
> +
> +  snps,tso:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enables the TSO feature otherwise it will be managed by MAC HW capability
> +      register.
> +
>    mdio:
>      $ref: mdio.yaml#
>      unevaluatedProperties: false
> @@ -568,95 +600,72 @@ allOf:
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
> -              - ingenic,jz4775-mac
> -              - ingenic,x1000-mac
> -              - ingenic,x1600-mac
> -              - ingenic,x1830-mac
> -              - ingenic,x2000-mac
> -              - qcom,sa8775p-ethqos
> -              - qcom,sc8280xp-ethqos
> -              - snps,dwmac-3.50a
> -              - snps,dwmac-4.10a
> -              - snps,dwmac-4.20a
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
> +                - ingenic,jz4775-mac
> +                - ingenic,x1000-mac
> +                - ingenic,x1600-mac
> +                - ingenic,x1830-mac
> +                - ingenic,x2000-mac
> +                - qcom,sa8775p-ethqos
> +                - qcom,sc8280xp-ethqos
> +                - snps,dwmac-3.50a
> +                - snps,dwmac-4.10a
> +                - snps,dwmac-4.20a
> +                - snps,dwmac-5.20
> +                - snps,dwxgmac
> +                - snps,dwxgmac-2.10
> +                - st,spear600-gmac
>  
>      then:
>        properties:
> -        snps,pbl:
> -          description:
> -            Programmable Burst Length (tx and rx)
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -          enum: [1, 2, 4, 8, 16, 32]
> -
> -        snps,txpbl:
> -          description:
> -            Tx Programmable Burst Length. If set, DMA tx will use this
> -            value rather than snps,pbl.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -          enum: [1, 2, 4, 8, 16, 32]
> -
> -        snps,rxpbl:
> -          description:
> -            Rx Programmable Burst Length. If set, DMA rx will use this
> -            value rather than snps,pbl.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -          enum: [1, 2, 4, 8, 16, 32]
> -
> -        snps,no-pbl-x8:
> -          $ref: /schemas/types.yaml#/definitions/flag
> -          description:
> -            Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
> -            rev < 3.50, don\'t multiply the values by 4.
> +        snps,pbl: false
> +        snps,txpbl: false
> +        snps,rxpbl: false
> +        snps,no-pbl-x8: false
>  
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
> 

--v3mh3gbsjgv5bejq
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-dt-bindings-net-dwmac-Validate-PBL-for-all-IP-cores.patch"

From 7222d63947e61e6ef82eb72f2110d62d68222147 Mon Sep 17 00:00:00 2001
From: Serge Semin <fancer.lancer@gmail.com>
Date: Sun, 22 Nov 2020 22:17:40 +0300
Subject: [PATCH v2] dt-bindings: net: dwmac: Validate PBL for all IP-cores

Indeed the maximum DMA burst length can be programmed not only for DW
xGMACs, Allwinner EMACs and Spear SoC GMAC, but in accordance with [1, 2,
3] for Generic DW *MAC IP-cores. Moreover the STMMAC driver parses the
property and then apply the configuration for all supported DW MAC
devices. All of that makes the property being available for all IP-cores
the bindings supports. Let's make sure the PBL-related properties are
validated for all of them by the common DW MAC DT schema.

[1] DesignWare Cores Ethernet MAC Universal Databook, Revision 3.73a,
    October 2013, p.378.

[2] DesignWare Cores Ethernet Quality-of-Service Databook, Revision 5.10a,
    December 2017, p.1223.

[3] DesignWare Cores XGMAC - 10G Ethernet MAC Databook, Revision 2.11a,
    September 2015, p.469-473.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v1:
- Use correct syntax of the JSON pointers, so the later would begin
  with a '/' after the '#'.

Changelog v2:
- Fix invalid constraints defined after movement. (@DT-bot)
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 80 ++++++-------------
 1 file changed, 26 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5a39d931e429..509086b76211 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -447,6 +447,32 @@ properties:
     description:
       Use Address-Aligned Beats
 
+  snps,pbl:
+    description:
+      Programmable Burst Length (tx and rx)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,txpbl:
+    description:
+      Tx Programmable Burst Length. If set, DMA tx will use this
+      value rather than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,rxpbl:
+    description:
+      Rx Programmable Burst Length. If set, DMA rx will use this
+      value rather than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,no-pbl-x8:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
+      rev < 3.50, don\'t multiply the values by 4.
+
   snps,fixed-burst:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -577,60 +603,6 @@ dependencies:
 
 allOf:
   - $ref: ethernet-controller.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - allwinner,sun7i-a20-gmac
-              - allwinner,sun8i-a83t-emac
-              - allwinner,sun8i-h3-emac
-              - allwinner,sun8i-r40-gmac
-              - allwinner,sun8i-v3s-emac
-              - allwinner,sun50i-a64-emac
-              - ingenic,jz4775-mac
-              - ingenic,x1000-mac
-              - ingenic,x1600-mac
-              - ingenic,x1830-mac
-              - ingenic,x2000-mac
-              - qcom,sa8775p-ethqos
-              - qcom,sc8280xp-ethqos
-              - snps,dwmac-3.50a
-              - snps,dwmac-4.10a
-              - snps,dwmac-4.20a
-              - snps,dwmac-5.20
-              - snps,dwxgmac
-              - snps,dwxgmac-2.10
-              - st,spear600-gmac
-
-    then:
-      properties:
-        snps,pbl:
-          description:
-            Programmable Burst Length (tx and rx)
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,txpbl:
-          description:
-            Tx Programmable Burst Length. If set, DMA tx will use this
-            value rather than snps,pbl.
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,rxpbl:
-          description:
-            Rx Programmable Burst Length. If set, DMA rx will use this
-            value rather than snps,pbl.
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,no-pbl-x8:
-          $ref: /schemas/types.yaml#/definitions/flag
-          description:
-            Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
-            rev < 3.50, don\'t multiply the values by 4.
-
   - if:
       properties:
         compatible:
-- 
2.43.0


--v3mh3gbsjgv5bejq--

