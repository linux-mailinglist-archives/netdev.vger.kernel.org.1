Return-Path: <netdev+bounces-138042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181449ABA8C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17D91C22949
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526C1798F;
	Wed, 23 Oct 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQazO35Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A0AD23;
	Wed, 23 Oct 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729643508; cv=none; b=fwVhaWKQ0zHM3Y76kgK3llQI9dgqwPN7476QiDBIp3WkrOBEuDnwV8Ycd1qYls6+TQ0xm+5+Z6TcIyFSiHTlVKlxzsqHXOHIg3u0LuUZVBYvPbwoPiL5Irv+PgNs6CZBBXimxgO5Y6qHsMpCgLI6JeUGl3V+W/FDPlBAjqqr17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729643508; c=relaxed/simple;
	bh=Vu0r1qdDAy33eyoeK/Y6bjj3QVniLF+Xctt/SokXYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qExFvyaaNJtUZybEhQFYNAso6gMtS87B5jaM9likUOmKs9t+px1vOWnjDYmud1zK1PlxXuhrjk7ufsSTwNlHZwYZQxMlEc/qnc9XBd4LX/513qpzdAkq9XK5ekQLhw5gTPJebLYY+V5P7n9b4Bx8cvbcQuEOqIyywkeJHeG3ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQazO35Y; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71eb1d0e3c2so2828934b3a.2;
        Tue, 22 Oct 2024 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729643506; x=1730248306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqoKRoP0trGpynhgqzBKYCwSQUSG9Om+dv3i8c0Nq6Q=;
        b=hQazO35YL9Jph58VC+bNt9E7OrLwE/22YcY2/a9KaxZeUSy/pxxY/Joi6XuRy3DWR0
         fvwJXWbEFHDUydCbfdx8vBaqiCn4AFYGLpRJ+iafpdr/pTtekGNF1P8EigDpRzjjVPJ5
         Ev4vNvvNEXSNPEO52tqtuXuEGJEeu3s+B0Etw0Ss0aQZsZPjxp+vioknxn2CkjevhKHj
         EIDgQlgElaJsKAD693z2LPXOcWl9ZTFPPlRQDjU2SnQ+PIYIZnu/VclXv9UijySqowP8
         kEoy6YoZxLrcyOC23TozJTDKPzuPu5wFoIRP1t1NCujnxn1PKmjN5qdwZWE4svnxHOma
         XgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729643506; x=1730248306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqoKRoP0trGpynhgqzBKYCwSQUSG9Om+dv3i8c0Nq6Q=;
        b=lNOv9dBwrd7syqzbMv/ECJictngw7KuqRYhed2+pw+onbiuLWBnXPpQEjDxt2Q0boj
         XGeC5xqCqInNcctLaT9BanDaGAA7Dj8o4P1NpNp3/G5YvWTYpKygg6/U1kp8FeeTUo/j
         Q1AnK++A9ntdonrqW7C/LblZ1f7FWYd+9bYfmuZbfKDTs7fgdSfCieW+GPwxxWziNZWK
         MEoTQ8tcZkS7Zc3ppYC7u6Bu6iEfXVmpu68ddpUGENvloWaqIbYX+k1LgpS3+wcH7Z+4
         A+UvlvOL/jpgYxernPe1xQcnlrf7bTF/f8xRA4IdzecNcT8XzAMAp3fHVnyWlh9mEpY/
         XBew==
X-Forwarded-Encrypted: i=1; AJvYcCUFuhJfdSvJHZM0SfCMKalX3sGq8AAiiUymTQSN9/+egXD4FKiYmHGhjgQP6jJmLnosZQHi82Y02y7Cpw85@vger.kernel.org, AJvYcCX/VN7GW0+c42kH6C9EzvV617A8FxvpYYzYPto2GGq34qNJXRtHjRyS4+m/rAoL4Tf7JqlxHueHUOCW@vger.kernel.org, AJvYcCXCbSx/x0FJtX8W5UIAOdVChFHGhQOL4ItcUQkqyb5MqgC0nszBGgdkGvBGqwXFT+7NKozeko2n@vger.kernel.org
X-Gm-Message-State: AOJu0Yyez09gJwC6GnFKcLIxNDNbCJYiANS89sSxXsAydK2wFbgVlK4S
	Qmw/+FICebQZ/V1uLDEIDVI+Kxw84Lofdft9oseopNklEhIWB4Hn
X-Google-Smtp-Source: AGHT+IE/EmIUFDrkEnasULUT9TnLW0DMraLwPlJfZhNd8+1qE1ieaafFg/FIQckU5WrODA3aincEjg==
X-Received: by 2002:a05:6a00:9297:b0:71e:98a:b6b4 with SMTP id d2e1a72fcca58-72030babd9fmr1189730b3a.11.1729643504597;
        Tue, 22 Oct 2024 17:31:44 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabda3b2sm5606574a12.83.2024.10.22.17.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 17:31:44 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:31:24 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Message-ID: <yt2idyivivcxctosec3lwkjbmr4tmctbs4viefxsuqlsvihdeh@alya6g27625l>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-3-inochiama@gmail.com>
 <20241022-crisply-brute-45f98632ef78@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-crisply-brute-45f98632ef78@spud>

On Tue, Oct 22, 2024 at 06:28:06PM +0100, Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 06:36:15PM +0800, Inochi Amaoto wrote:
> > The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> > with some extra clock.
> > 
> > Add necessary compatible string for this device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
> >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
> >  2 files changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 3c4007cb65f8..69f6bb36970b 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -99,6 +99,7 @@ properties:
> >          - snps,dwmac-5.30a
> >          - snps,dwxgmac
> >          - snps,dwxgmac-2.10
> > +        - sophgo,sg2044-dwmac
> >          - starfive,jh7100-dwmac
> >          - starfive,jh7110-dwmac
> >  
> > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > new file mode 100644
> > index 000000000000..93c41550b0b6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > @@ -0,0 +1,145 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: StarFive JH7110 DWMAC glue layer
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@gmail.com>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - sophgo,sg2044-dwmac
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sophgo,sg2044-dwmac
> > +      - const: snps,dwmac-5.30a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: GMAC main clock
> > +      - description: PTP clock
> > +      - description: TX clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: stmmaceth
> > +      - const: ptp_ref
> > +      - const: tx
> > +
> > +  sophgo,syscon:
> 
> How many dwmac instances does the sg2044 have?
> 

Only one, there is another 100G dwxgmac instance, but it does not
use this syscon.

> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to syscon that configures phy
> > +          - description: offset of phy mode register
> > +          - description: length of the phy mode register
> > +    description:
> > +      A phandle to syscon with two arguments that configure phy mode.
> > +      The argument one is the offset of phy mode register, the
> > +      argument two is the length of phy mode register.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - resets
> > +  - reset-names
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: sophgo,sg2044-dwmac
> 
> Why does this have to be applied conditionally? There's only one
> compatible in the binding, can't you apply these unconditionally?
> 
> 
> Cheers,
> Conor.
> 

I think it can apply it unconditionally. I will fix it.

Regards,
Inochi

> > +    then:
> > +      properties:
> > +        interrupts:
> > +          minItems: 1
> > +          maxItems: 1
> > +
> > +        interrupt-names:
> > +          minItems: 1
> > +          maxItems: 1
> > +
> > +        resets:
> > +          maxItems: 1
> > +
> > +        reset-names:
> > +          const: stmmaceth
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    ethernet@30006000 {
> > +      compatible = "sophgo,sg2044-dwmac", "snps,dwmac-5.30a";
> > +      reg = <0x30006000 0x4000>;
> > +      clocks = <&clk 151>, <&clk 152>, <&clk 154>;
> > +      clock-names = "stmmaceth", "ptp_ref", "tx";
> > +      interrupt-parent = <&intc>;
> > +      interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
> > +      interrupt-names = "macirq";
> > +      resets = <&rst 30>;
> > +      reset-names = "stmmaceth";
> > +      snps,multicast-filter-bins = <0>;
> > +      snps,perfect-filter-entries = <1>;
> > +      snps,aal;
> > +      snps,tso;
> > +      snps,txpbl = <32>;
> > +      snps,rxpbl = <32>;
> > +      snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> > +      snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> > +      snps,axi-config = <&gmac0_stmmac_axi_setup>;
> > +      status = "disabled";
> > +
> > +      gmac0_mtl_rx_setup: rx-queues-config {
> > +        snps,rx-queues-to-use = <8>;
> > +        snps,rx-sched-wsp;
> > +        queue0 {};
> > +        queue1 {};
> > +        queue2 {};
> > +        queue3 {};
> > +        queue4 {};
> > +        queue5 {};
> > +        queue6 {};
> > +        queue7 {};
> > +      };
> > +
> > +      gmac0_mtl_tx_setup: tx-queues-config {
> > +        snps,tx-queues-to-use = <8>;
> > +        queue0 {};
> > +        queue1 {};
> > +        queue2 {};
> > +        queue3 {};
> > +        queue4 {};
> > +        queue5 {};
> > +        queue6 {};
> > +        queue7 {};
> > +      };
> > +
> > +      gmac0_stmmac_axi_setup: stmmac-axi-config {
> > +        snps,blen = <16 8 4 0 0 0 0>;
> > +        snps,wr_osr_lmt = <1>;
> > +        snps,rd_osr_lmt = <2>;
> > +      };
> > +    };
> > -- 
> > 2.47.0
> > 



