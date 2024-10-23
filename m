Return-Path: <netdev+bounces-138430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39AD9AD7E3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C331C2153F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF541FF021;
	Wed, 23 Oct 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2LxQ/ap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C81FEFD3;
	Wed, 23 Oct 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723133; cv=none; b=k2+jeEc+sbIk/BaoPq3QjhHSp3/PMIpQoHzSEiaCSe5C+gYxgbYVg5n7Fz2i8pX7nzTRzJ8T3qyaDEIRLD2TfDTa+7AI9O0OFb6pBgtHq73cnPP9trlgDxitrwtOrC/exaQ5mbzb3xvcyLgJSGuNSiQ1ddPZrQN8wMP+/FRti6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723133; c=relaxed/simple;
	bh=ES5iYOA95Kt0KDp71z3fgi0EpYKOwnsO4BIWmBh/gpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpABzy7gmJFRXmpMw/UAdjT4HYQV69SaLMLp4JN2UjEerpAGbFFLkhG+qzjGHkl5KniiXollOuPtQ8+CEFTKcsWutThEukqVxb6i6fnr5dqUARB0Xt0dOKDtUtClzQAxfOTwzFX9LSLihFVIgaUvYQqB8Zfe/0llPBWtRHi4ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2LxQ/ap; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e6d988ecfso240302b3a.0;
        Wed, 23 Oct 2024 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729723131; x=1730327931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkwckHmFPJEkM3Wxs1jlPmTkTzgcJwcJLaHVmfmItpM=;
        b=d2LxQ/apVyAlS1olU1fdMZKiDZjRrbk5T7qyCWqdCPk8ZprLdSID6Ig+ARiK1pINal
         m/xfluNMNHvfQzV5+8kxznjutp2IXYSeyCpEh2lqIsorvgqA7wkJ/lIIHQ/z/e3QO+/P
         i3vxrJa12QTr47FbDAYefW8ZwBqtD9UO8K53j2hFmqiCuvK+pQtUhvt+4vBFIHcNvbRu
         UFpg9Wo1ZLL0sAdk/SP7elW8HnB0lGxy0RWVjNg/oPuvshPfpHZFgAEw9rPZ6YI7Wz/G
         7KTBkxbzyFgBFh35f+J7wSY7NFzYizTCUvHXz8QA1ztUSNdZBpyi/rsZuQMPRnUIq9gx
         2O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723131; x=1730327931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkwckHmFPJEkM3Wxs1jlPmTkTzgcJwcJLaHVmfmItpM=;
        b=s+6htdohf4A8eNjHjAcTB43pkTwxKJoIcpiSOb6+zKEiPr9QT556c5S4lLo6MteWw3
         6X+C+QRCb4OccNyvhtizNYgPee2BOH7YOm+QvXlXRjQqRraojOV3yyRNaYNI21xHJOXv
         v0sIV0znef6v+NJX44t9kacnuTWJhpULi+QV45gryGWoq4PtCXU0VyMc4AqKw3Po4IYF
         op5PWh+CgHLe2CF7w1m/xMgWTOv4Ynyno7yzWpRbXqwXw6YX/egOodK3DHnBLaPYYhty
         uPQf+l9HSitzRdJfMmW8fwTegCsRxk+QB0Kpkm0ZJGWVT5WOuc5N6BmBoPdAP84oQp7Z
         J2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCV4ERdi05OcpiUMtrSoJVgo32Kj6Zo9jW8pJlhwbMA97aOYgzvEVs9vQm1nJZc6VNjh87sbmySysCTy@vger.kernel.org, AJvYcCVs2M6ugftZk8PgPFxB1fCdJzDAFk246uRCu4zGNrnLEzY5D03tnjAFUPoAXYjtjbkuDvb7lC+vmDUxVV7Q@vger.kernel.org, AJvYcCW4DGi+ZHAPF9NKgLd7zliHhVdVL98Gn/b9QcolAs9TDTYiHdqfhYTQVzlrbejakyIY4+ZiDEKB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xNN/uZ4SiIK3/tYDTxoWqKbReX67n0BUC3bGpWf2a65saQQV
	N7JGG1Xf6EjH/sTk73tsRPIDc+6PMRq6c7MC66+ZanlZlkugvMez
X-Google-Smtp-Source: AGHT+IGUv5GcBzM76Tis8BZFsna+Tt+yRb2ER6YRERF8hAd8oZIE6Ogk0CalUXCV034zvn8ODhWHxQ==
X-Received: by 2002:a05:6a00:806:b0:71e:693c:107c with SMTP id d2e1a72fcca58-72030a8b242mr6049959b3a.11.1729723130943;
        Wed, 23 Oct 2024 15:38:50 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312c8fsm7047579b3a.14.2024.10.23.15.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:38:50 -0700 (PDT)
Date: Thu, 24 Oct 2024 06:38:29 +0800
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
Message-ID: <5cv7wcdddxa4ruggrk36cwaquo5srcrjqqwefqzcju2s3yhl73@ekpyw6zrpfug>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-3-inochiama@gmail.com>
 <20241022-crisply-brute-45f98632ef78@spud>
 <yt2idyivivcxctosec3lwkjbmr4tmctbs4viefxsuqlsvihdeh@alya6g27625l>
 <20241023-paper-crease-befa8239f7f0@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-paper-crease-befa8239f7f0@spud>

On Wed, Oct 23, 2024 at 09:49:34PM +0100, Conor Dooley wrote:
> On Wed, Oct 23, 2024 at 08:31:24AM +0800, Inochi Amaoto wrote:
> > On Tue, Oct 22, 2024 at 06:28:06PM +0100, Conor Dooley wrote:
> > > On Mon, Oct 21, 2024 at 06:36:15PM +0800, Inochi Amaoto wrote:
> > > > The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> > > > with some extra clock.
> > > > 
> > > > Add necessary compatible string for this device.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
> > > >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
> > > >  2 files changed, 146 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > index 3c4007cb65f8..69f6bb36970b 100644
> > > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > @@ -99,6 +99,7 @@ properties:
> > > >          - snps,dwmac-5.30a
> > > >          - snps,dwxgmac
> > > >          - snps,dwxgmac-2.10
> > > > +        - sophgo,sg2044-dwmac
> > > >          - starfive,jh7100-dwmac
> > > >          - starfive,jh7110-dwmac
> > > >  
> > > > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > > new file mode 100644
> > > > index 000000000000..93c41550b0b6
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > > @@ -0,0 +1,145 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: StarFive JH7110 DWMAC glue layer
> > > > +
> > > > +maintainers:
> > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > +
> > > > +select:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        enum:
> > > > +          - sophgo,sg2044-dwmac
> > > > +  required:
> > > > +    - compatible
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: sophgo,sg2044-dwmac
> > > > +      - const: snps,dwmac-5.30a
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: GMAC main clock
> > > > +      - description: PTP clock
> > > > +      - description: TX clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: stmmaceth
> > > > +      - const: ptp_ref
> > > > +      - const: tx
> > > > +
> > > > +  sophgo,syscon:
> > > 
> > > How many dwmac instances does the sg2044 have?
> > > 
> > 
> > Only one, there is another 100G dwxgmac instance, but it does not
> > use this syscon.
> 
> That dwxgmac is a different device, with a different compatible etc?

Yes, it needs a different compatiable, and maybe a new binding is needed
since the 100G and 1G IP are different.

Regards,
Inochi

