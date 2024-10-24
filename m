Return-Path: <netdev+bounces-138898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917319AF55D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506E7281504
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6B2178FC;
	Thu, 24 Oct 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIMXG4BA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13F14A4CC;
	Thu, 24 Oct 2024 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808879; cv=none; b=YIl7Dttp6Hv2tNIKH8jOEVYbVRqP64jlK75BfOl2LFcnioq/V7hewdSAVamm9i8cY44CBYTlxghi6Pop1g3Ze456P9MxJ1TngCu5gT1uDhOYWu1dULBzRjsfuFuWawOiKxc+rJlyd7mv10U4oVih4fUPzaJBpLDa3gUXxY1tZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808879; c=relaxed/simple;
	bh=tDvMcOPBbLZ81Q+N1FMjB7QzXRLwq50AvCYD+kYpyEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYWKjz3ttTngjmHtidOfjvGOVHJZ7jIpx8NUK+LJZOhlsGGSAFtkQm4LqnwJxZN1ioB4IViTU7OcdGq5rtye/SL2xIYclxoi3FoXo8dSz7cBsruUaFqUwTSioIpSESeeqVD3W0gN+UxIahWXRgb7Ko2jZeKQC16kD0B2Y+Mdnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIMXG4BA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so1078797a12.0;
        Thu, 24 Oct 2024 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729808877; x=1730413677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fD7JZCX3WSpRYBUjkGKdk6/F/9roVP52zuSU1cyvQeQ=;
        b=mIMXG4BASQDBFKGZJRQK2d6jkY6AHxPf+tEJazxIIN2newXW4FeRpWJVQp89t4O4An
         xI5KTw7jhRRrqVLea0++P80roh6hI7DjrE/sQscHPGuQpaMgnXGWnVYYRPZ3vq+hdELi
         ao/YJL3pouwwXqTIW99iJtWnQTmjE78Cw3PvIZMkAbD4G1G+f/A7pB9evSvgCgRZHRgJ
         FUynuvZ3H3VGPjAaPmDEI6jPpPVY6r23FFscPowfXYmqbJ8AZbEwTC0PZd+Cqggboyue
         Rbn9IreNCCi3npheopM5MssxQaVGkHGrUIijboJrmf7ZZgJVygShxgURnNIhItG8e4FK
         JuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808877; x=1730413677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD7JZCX3WSpRYBUjkGKdk6/F/9roVP52zuSU1cyvQeQ=;
        b=TmgS5T1+NTjHLiGvxCZBN3kjQFVclMUX5jbjyyAHBuJdoeo3DkbQDXp2KT3V7nidvC
         7DPTzLQDTpNlPl1hCHDb4ksEkzlY3UnQVwSTmyJH8oItU9J0aeVhXwutVGAkbgZ6g/Sf
         2EjAQT6I6RWS53w+givjvoGw4EDDXL0CU3CmQ8J3s8N7y77N1/c05c7/AaVFOiYcwW71
         SZs/bDcEF3FjAPLeIUGxaoJRoaMxpAW/QqyBQ/KLbVuGhPg82EWUhaZJhQkCbP84csy8
         qgcSW3Gera45fIZjRG4zTiE1IOuiqmUMqtNZtkwUQgBGZfGnhFR/hMJ1Zy0mi1i9Oteg
         wvJw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Lvl/QaANJAYQqt2H2ggnL7RGV1xqeisN8KLfV+xa++gcIoNKwpSkL5pfsRXQYtV8pu7++5vjhqEw7F3z@vger.kernel.org, AJvYcCWGrwKPQss8YICwwx6T5DEkU2MOTlG3UV1XIY81dlKc+b+DBN6HcTMtAbHFhTi0u14vEsX03uoc@vger.kernel.org, AJvYcCXf3qEdw5LfxEcnG2RNgEx65rET+4rTrsGe5yBty0uANbHh3ELHo/ElXzEkbGbcJhdqAv/qd5BTlKvC@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHhAxxajTSidK+aetP2XqatGnjxQfB2Yx3Infn0mxLWFLSCVA
	qWPb94bsFg02PW6ZehIm4ptLtjpzrz5tYEt2u6fiEr91I/FihqgW
X-Google-Smtp-Source: AGHT+IGQmCYk2RoxkOpXP4PJ+QT2gDC7178GzCSx0ES9YMS9JzYskSa3vPomTHV9tDwOnPLPR2pM0w==
X-Received: by 2002:a17:90b:17c1:b0:2e0:9d3e:bc2a with SMTP id 98e67ed59e1d1-2e76b6cda50mr8866774a91.32.1729808876652;
        Thu, 24 Oct 2024 15:27:56 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e57f74asm2019615a91.46.2024.10.24.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:27:56 -0700 (PDT)
Date: Fri, 25 Oct 2024 06:27:02 +0800
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
Message-ID: <s2rbj66rarjs33fvmyrwtmeq562pbx7mif5fld56tnk3fm73m5@hlsufkbunu3t>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-3-inochiama@gmail.com>
 <20241022-crisply-brute-45f98632ef78@spud>
 <yt2idyivivcxctosec3lwkjbmr4tmctbs4viefxsuqlsvihdeh@alya6g27625l>
 <20241023-paper-crease-befa8239f7f0@spud>
 <5cv7wcdddxa4ruggrk36cwaquo5srcrjqqwefqzcju2s3yhl73@ekpyw6zrpfug>
 <20241024-wad-dusk-3d49f9ac4dff@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-wad-dusk-3d49f9ac4dff@spud>

On Thu, Oct 24, 2024 at 06:04:31PM +0100, Conor Dooley wrote:
> On Thu, Oct 24, 2024 at 06:38:29AM +0800, Inochi Amaoto wrote:
> > On Wed, Oct 23, 2024 at 09:49:34PM +0100, Conor Dooley wrote:
> > > On Wed, Oct 23, 2024 at 08:31:24AM +0800, Inochi Amaoto wrote:
> > > > On Tue, Oct 22, 2024 at 06:28:06PM +0100, Conor Dooley wrote:
> > > > > On Mon, Oct 21, 2024 at 06:36:15PM +0800, Inochi Amaoto wrote:
> > > > > > The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> > > > > > with some extra clock.
> > > > > > 
> > > > > > Add necessary compatible string for this device.
> > > > > > 
> > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
> > > > > >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
> > > > > >  2 files changed, 146 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > > > index 3c4007cb65f8..69f6bb36970b 100644
> > > > > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > > > @@ -99,6 +99,7 @@ properties:
> > > > > >          - snps,dwmac-5.30a
> > > > > >          - snps,dwxgmac
> > > > > >          - snps,dwxgmac-2.10
> > > > > > +        - sophgo,sg2044-dwmac
> > > > > >          - starfive,jh7100-dwmac
> > > > > >          - starfive,jh7110-dwmac
> > > > > >  
> > > > > > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..93c41550b0b6
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > > > > @@ -0,0 +1,145 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: StarFive JH7110 DWMAC glue layer
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > > +
> > > > > > +select:
> > > > > > +  properties:
> > > > > > +    compatible:
> > > > > > +      contains:
> > > > > > +        enum:
> > > > > > +          - sophgo,sg2044-dwmac
> > > > > > +  required:
> > > > > > +    - compatible
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    items:
> > > > > > +      - const: sophgo,sg2044-dwmac
> > > > > > +      - const: snps,dwmac-5.30a
> > > > > > +
> > > > > > +  reg:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  clocks:
> > > > > > +    items:
> > > > > > +      - description: GMAC main clock
> > > > > > +      - description: PTP clock
> > > > > > +      - description: TX clock
> > > > > > +
> > > > > > +  clock-names:
> > > > > > +    items:
> > > > > > +      - const: stmmaceth
> > > > > > +      - const: ptp_ref
> > > > > > +      - const: tx
> > > > > > +
> > > > > > +  sophgo,syscon:
> > > > > 
> > > > > How many dwmac instances does the sg2044 have?
> > > > > 
> > > > 
> > > > Only one, there is another 100G dwxgmac instance, but it does not
> > > > use this syscon.
> > > 
> > > That dwxgmac is a different device, with a different compatible etc?
> > 
> > Yes, it needs a different compatiable, and maybe a new binding is needed
> > since the 100G and 1G IP are different.
> 
> In that case, you don't /need/ a syscon property at all, much less one
> with offsets. You can just look up the syscon by compatible and hard
> code the offset in the driver.

Good, look up the syscon is a good idea. Thanks for this suggestion.

Regards,
Inochi

