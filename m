Return-Path: <netdev+bounces-151070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD39ECAA5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C8316962D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF21A8413;
	Wed, 11 Dec 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPOT7iMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF94239BD1;
	Wed, 11 Dec 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914267; cv=none; b=G30NUSyvwFr06XE2v9E9ZkHZa4BLEq7QIGxRrpfTWCKmgQ61lIwccFxKvrZsWXUqBcjMKP2lRGIsaTF/qQG7bYrhhSmxd5ZARKdTKgOGH+tIsIp7lr0qxmcl9chFqNiyVkqdZY5a9ppiyqFCXxJX0PL4J8F8ptn5VrJgYgsBAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914267; c=relaxed/simple;
	bh=Ksk5GQlLTE9G/be0wD6j9Sj8kt6j5Ht+2opyZU37J5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLPd/8JVVcgVBifyGn137iirPuMiTD1tuasVYk4ZZFMd3Umaj4AIaqIGaCI7r3L3X35kWLsgla96GeRG3fIPjt7Nri+vtJ3yiE5lZHXiLQXMxchLj14+U3gTGkwr2K07PKg2TQOV/mMoupEhpNuvxLiMZ9fprntDEsziI1Dc/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPOT7iMp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa69251292dso529171266b.2;
        Wed, 11 Dec 2024 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733914264; x=1734519064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GX/1WZMZrEFw0JXFhurobNKgpPuqP1bqjRL4XCmzGz0=;
        b=fPOT7iMpr5d2n9rPJ8eeB5clhh1SLToMX1umtUfgRExZlwnTsIy3zquH8P4qep2DXj
         589TACyG2oDim74LwJWBhtVhjNrGehI6TFSi+xS7/m7FnZ1JuddLVM07UEPXwYirNHOO
         Trp7Y4ZX5TL5M7z7O3ocj05tIlPJdrPqarv30cPUV+TMaoYtFdeQPXHyeF5zoa5v4Eu5
         cgmiYe5QLF6+N68xmLxqIoznn8Iph9xJeqeFi+lL2WtYtidKYoC9SJ4U2xSOLjPXDRsU
         i/dGkJaUXhmRAbPyX02GhryIhqNNZEhspZZmHVbbKUnAXRLqZohzQQ6C8QYFPJgrfp3E
         6sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914264; x=1734519064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX/1WZMZrEFw0JXFhurobNKgpPuqP1bqjRL4XCmzGz0=;
        b=iqwsB0oHFhInSv6mFTD2pzoTSb1Xis7IKBP1mHy/+zGrh5guRJSnudOQ8jKZ+isaZv
         e4NVgResnsDTSRs3Phq5NGHqR+NofFWLoNcRwndPEMwK3sSPVb+/e7FPgzUMeV9dU5nw
         7S33CNCKY6+rH/qGK1wI5oSRT4QkVCKVjc/t+qGV0TyxOJvwT1fvsgbyEjGypLPpdZ6Q
         oZiGoTgV5UY+L1gKFMGOt6lmEsXNOn7a6Dp5EdcZGwxRmP7SLy044sDXqhMpA8ugkGUd
         ai8MpUEtuMaBMj26JvIM+lDR3HDxEPOiuVP0Mv8LTxjsOA9H+l0fMf6Cp24H7781MCNr
         U44g==
X-Forwarded-Encrypted: i=1; AJvYcCVHHd8hx55uXvwHEW3caclO/Q9/I6ghesZvjo+SvCOxXomUsBhRRbFdfkp3Chs/uiY3NUaQToKwIl+EHidy@vger.kernel.org, AJvYcCWD+reM4UDhKUIzbYObyKDcbenVgBiHGLLck0t+nk+vjFFLdrVDvVnEwUKaDyDETZkVlOOcVrAQ@vger.kernel.org, AJvYcCXFxM53PJH1qAG5QPk3IbPcwG8t7AWGGPQYEMom/vh0INu0J9WgXUP55+YRVKujMfigtUk1hdDXSJjC@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTUtTlM4I9rpjuVl8IMYHr/DYg5YTIcr47XupUA+c1QEPEd/l
	W2ao6MKGm5YBNuI6IjciJQct4QCHIKxjZj/lQj1aQvsJrxRCTa8N
X-Gm-Gg: ASbGncv8blCgW3IaZ+qdSGYCYun0W4x3ZsgKVh4wtlS1jK+MN1UFokXHBlUL3JePkwo
	Kmx4SC0hWvMgc4TSSgSu8SHmlP8RK9f+tnEK2OhnBaHAAfXdm5oGVB1GxsKWLIAZSl3Tl34Zumq
	722BYNW3HIgsiFQlXAokahk39Y4hhb5+CPVkW8vCoM2fMUpjx/u4KpoR1ZV00ZwPqAuYOA4X6Il
	meD4sbE4S096sIiRNTH2cCsE9QoA1nGL1sk2tzv/jN/dbuoBA==
X-Google-Smtp-Source: AGHT+IGaTNOAYs445X35p8C+/vkCaXdBe1C4Aw01aMs405nbpDjnnn5dg1Q3ScPc562xQ2jSrpX7WQ==
X-Received: by 2002:a05:6402:3806:b0:5d0:c9e6:309d with SMTP id 4fb4d7f45d1cf-5d43306db5fmr2026538a12.1.1733914264077;
        Wed, 11 Dec 2024 02:51:04 -0800 (PST)
Received: from debian ([2a00:79c0:67c:dd00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ce5b776esm7280138a12.29.2024.12.11.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:51:02 -0800 (PST)
Date: Wed, 11 Dec 2024 11:51:00 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dp83822: Add support
 for GPIO2 clock output
Message-ID: <20241211105100.GA4424@debian>
References: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
 <20241211-dp83822-gpio2-clk-out-v2-1-614a54f6acab@liebherr.com>
 <hayqmsohcpdg43yh5obmkbxpw3stckxpmm3myhqfsf62jdpquh@ndwfhr3gqm3b>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hayqmsohcpdg43yh5obmkbxpw3stckxpmm3myhqfsf62jdpquh@ndwfhr3gqm3b>

Am Wed, Dec 11, 2024 at 10:43:40AM +0100 schrieb Krzysztof Kozlowski:
> On Wed, Dec 11, 2024 at 09:04:39AM +0100, Dimitri Fedrau wrote:
> > The GPIO2 pin on the DP83822 can be configured as clock output. Add
> > binding to support this feature.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  .../devicetree/bindings/net/ti,dp83822.yaml         |  7 +++++++
> >  include/dt-bindings/net/ti-dp83822.h                | 21 +++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> > index 784866ea392b2083e93d8dc9aaea93b70dc80934..4a4dc794f21162c6a61c3daeeffa08e666034679 100644
> > --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> > +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> > @@ -96,6 +96,13 @@ properties:
> >        - master
> >        - slave
> >  
> > +  ti,gpio2-clk-out:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +       DP83822 PHY only.
> > +       Muxing option for GPIO2 pin. See dt-bindings/net/ti-dp83822.h for
> > +       applicable values. When omitted, the PHY's default will be left as is.
> 
> 1. Missing constraints, this looks like enum.
> 2. Missing explanation of values.
> 3. This should be most likely a string.
> 4. Extend your example with this. 
>
Ok, will fix it.

> > +
> >  required:
> >    - reg
> >  
> > diff --git a/include/dt-bindings/net/ti-dp83822.h b/include/dt-bindings/net/ti-dp83822.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..d569c90618b7bcae9ffe44eb041f7dae2e74e5d1
> > --- /dev/null
> > +++ b/include/dt-bindings/net/ti-dp83822.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> > +/*
> > + * Device Tree constants for the Texas Instruments DP83822 PHY
> > + *
> > + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> > + *
> > + * Author: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_TI_DP83822_H
> > +#define _DT_BINDINGS_TI_DP83822_H
> > +
> > +/* IO_MUX_GPIO_CTRL - Clock source selection */
> > +#define DP83822_CLK_SRC_MAC_IF			0x0
> > +#define DP83822_CLK_SRC_XI			0x1
> > +#define DP83822_CLK_SRC_INT_REF			0x2
> > +#define DP83822_CLK_SRC_RMII_MASTER_MODE_REF	0x4
> > +#define DP83822_CLK_SRC_FREE_RUNNING		0x6
> > +#define DP83822_CLK_SRC_RECOVERED		0x7
> 
> These are not really bindings but some register values. Hex numbers
> indicate that. Don't store register values as bindings, because this
> is neither necessary nor helping.
>
Ok, got it. Have seen similar in <dt-bindings/net/ti-dp83867.h> or
<dt-bindings/net/ti-dp83869.h>, is it wrong there ?

Best regards,
Dimitri Fedrau

