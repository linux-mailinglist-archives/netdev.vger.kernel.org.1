Return-Path: <netdev+bounces-130155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D83988B8C
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 22:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694D7B2439B
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473781C3300;
	Fri, 27 Sep 2024 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Rzy7i+Ka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30951C1AAA
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470278; cv=none; b=haJJWFsrw2K2rU3S6MFC0noTvcUKC9iBixNgqVzp3x3slCA94NO04JP+25ga54TIMDYoRRA5EAM2aQL9ymGLTRogaShz4SQACx2MajV+SO6AikWoR4p1DLBk0DDvdvWUeSetKlGBsshwaRyxnpTIRbxIqRUb7m4KQ3P4/vk7Htc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470278; c=relaxed/simple;
	bh=t5Z0F96nnpNVbvXiI93914QUNkWsiBwAzwQoJCfZ5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWWQTSQ8Qnih3Pi5qawNPWYVT5MRtfdFeHSWEDEAj235Ns3aaZLg06mA0/operVfD0S/XT2q8lx5kjpf18cxj2NJjrx+EaqfjX5l9Vy4DsOoAGJ4o52ojkOQQwf25KFdCxV4lRgUsmJ8aG7jxhiW/yM+NAfdPrRsk3KV3B/zhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Rzy7i+Ka; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso51235a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727470275; x=1728075075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRdgVrabZHhxovBskXyfa2tZhEPgLz1eNAdYEQ47v4A=;
        b=Rzy7i+KaY6oZlRoWG7tYY3YnfGjDMcAWIDuo+cvRC0JZ/fvo0MnClazthRZnHL2iUD
         0gEMjpfFcTINWaoVOr1SbEPk6GV1jsddYG1bhyLoUp9hYJ0gzg0flr/OT/Z9VvelgpJg
         Yy7e0hBcvo5JILKcJoRC4vJqVLvzMfrs1cioeMi6lqLEPby/E7AKdaEtY1m0Mh4PHHDY
         T0SFZjGUqxPGkDbfQ/aVXvODzIIjwK1YgDrQrfhIqZ46sTyzk16j+EjkyiVAkzU1KcwL
         TJ2zxmEKF+86mrss0wjd8tsBkNL7eIM23X+Yn68di5DqflaP2tg5b8wokIaLFrWCSvZP
         MUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470275; x=1728075075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRdgVrabZHhxovBskXyfa2tZhEPgLz1eNAdYEQ47v4A=;
        b=IQ8GLN8DOe9yGL+gk9bT7wx+HXr2UijDf2otiqe+APJnBE3DulnRvNUDVGQoj/sRQf
         znmxKo3OMg0HPkeW8DEpbhDmoRCplYRC/2LULkgqriEGpwkZz9RP+Io4vof0edUPX1ie
         BkLRYxY2VZxfQ+7/a1dyxW7axFyY8QA6oTZDqpoQcFTU6gMdUtInlBO9iLyVAurqqySK
         mYMFF2V+WEGVReeICsEFrZMtSIZI2tqeGds1e9Whry9A/uq7qIzV3WEw0Ov2N3Mt1Phd
         TxQ5agVD9VgkaBaa0kMsRBjEl44+nqT8EFrwrnnJ1MCH2At58up/1+gl4SwsB/zMqDit
         hKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOMc64r0dG47s8i0eGwwqIgYkKFFDyi11ofQGOYPuTP9twrNSSsNBq9ApMsTu+F5xxNtMKwac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3Kl0coWts3uF9ymcSlyTpuB4dxFHMTwJBhO0J+O1A38oQBh6
	AMhbMc+Qj8TIbblV0riliiIKlfOT+CqvClAZajLfDkzf/TAqMu0Fbc/kkUywbqQ=
X-Google-Smtp-Source: AGHT+IFG7leoR14jtfC3q5GGKEHjsTA70H4zEAbpBSmxJ/3keC3i6/61ObBCaup/qbxMFhZgbbqM5Q==
X-Received: by 2002:a17:90a:ec11:b0:2e0:6cd4:973a with SMTP id 98e67ed59e1d1-2e0b887184amr5335905a91.5.1727470275087;
        Fri, 27 Sep 2024 13:51:15 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0e4ca7019sm336000a91.18.2024.09.27.13.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:51:14 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:51:12 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: Add T-HEAD dwmac support
Message-ID: <ZvcawOIcufEHXCHU@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-1-f34f28ad1dc9@tenstorrent.com>
 <4pxpku3btckw7chyxlqw56entdb2s3gqeas4w3owbu5egmq3nf@5v76h4cczv4z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4pxpku3btckw7chyxlqw56entdb2s3gqeas4w3owbu5egmq3nf@5v76h4cczv4z>

On Fri, Sep 27, 2024 at 11:34:48AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Sep 26, 2024 at 11:15:50AM -0700, Drew Fustini wrote:
> > From: Jisheng Zhang <jszhang@kernel.org>
> > 
> > Add documentation to describe T-HEAD dwmac.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > [drew: change apb registers from syscon to second reg of gmac node]
> > [drew: rename compatible, add thead rx/tx internal delay properties]
> > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
> >  .../devicetree/bindings/net/thead,th1520-gmac.yaml | 109 +++++++++++++++++++++
> >  MAINTAINERS                                        |   1 +
> >  3 files changed, 111 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 4e2ba1bf788c..474ade185033 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -99,6 +99,7 @@ properties:
> >          - snps,dwxgmac-2.10
> >          - starfive,jh7100-dwmac
> >          - starfive,jh7110-dwmac
> > +        - thead,th1520-gmac
> >  
> >    reg:
> >      minItems: 1
> > diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> > new file mode 100644
> > index 000000000000..1070e891c025
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> > @@ -0,0 +1,109 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/thead,th1520-gmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: T-HEAD TH1520 GMAC Ethernet controller
> > +
> > +maintainers:
> > +  - Drew Fustini <dfustini@tenstorrent.com>
> > +
> > +description: |
> > +  The TH1520 GMAC is described in the TH1520 Peripheral Interface User Manual
> > +  https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
> > +
> > +  Features include
> > +    - Compliant with IEEE802.3 Specification
> > +    - IEEE 1588-2008 standard for precision networked clock synchronization
> > +    - Supports 10/100/1000Mbps data transfer rate
> > +    - Supports RGMII/MII interface
> > +    - Preamble and start of frame data (SFD) insertion in Transmit path
> > +    - Preamble and SFD deletion in the Receive path
> > +    - Automatic CRC and pad generation options for receive frames
> > +    - MDIO master interface for PHY device configuration and management
> > +
> > +  The GMAC Registers consists of two parts
> > +    - APB registers are used to configure clock frequency/clock enable/clock
> > +      direction/PHY interface type.
> > +    - AHB registers are use to configure GMAC core (DesignWare Core part).
> > +      GMAC core register consists of DMA registers and GMAC registers.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - thead,th1520-gmac
> > +  required:
> > +    - compatible
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - thead,th1520-gmac
> > +      - const: snps,dwmac-3.70a
> > +
> > +  reg:
> > +    items:
> > +      - description: DesignWare GMAC IP core registers
> > +      - description: GMAC APB registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dwmac
> > +      - const: apb
> > +
> > +  thead,rx-internal-delay:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      RGMII receive clock delay. The value is used for the delay_ctrl
> > +      field in GMAC_RXCLK_DELAY_CTRL. Units are not specified.
> 
> What do you mean by "unspecified units"? They are always specified,
> hardware does not work randomly, e.g. once uses clock cycles, but next
> time you run it will use picoseconds.
> 
> You also miss default (property is not required) and some sort of constraints.

I should have stated that I don't know the units for delay_ctrl. The
5-bit field has a max value of 31 which seems far too small for
picoseconds. Unfortunately, the documentation from the SoC vendor does
not give anymore details about what the value represents.

Andrew Lunn replied [1] to my cover letter that it is best to hard code
the field to 0 (which is the hardware reset value) if I don't know what
the units are for delay_ctrl. The hardware that I have works okay with
delay_ctrl of 0, so it seems these new vendor properties are not needed.

Thanks,
Drew

[1] https://lore.kernel.org/lkml/5e379911-e3de-478c-b785-61dbcc9627b1@lunn.ch/

