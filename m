Return-Path: <netdev+bounces-107772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B86091C46E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162751F22445
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641A1CCCB0;
	Fri, 28 Jun 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB+XTLJT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092861CB327;
	Fri, 28 Jun 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594388; cv=none; b=Sv9HvxVpOFsItIMITxbj5wob6E7E3m1fnCzoMxHu1BApkTs2K3YN9lyeJy+4hy9cid/BMq1JtKHzXFYwA+Mxl2stCRL9UBKpZdCasgiv2ddSl8mYP845ekKSdvUbaQchYQPB1X1G6cZbc2O/nmAGFNsxvJzDWVyIx/3TUWVRzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594388; c=relaxed/simple;
	bh=d23WOmuV/HnTicuDlGwo3blk56kDlmCf4wCMAL9gDbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ99IExvnnhY80fUDoxUYDIBDU+Cp2amUAd4RAyyXS/hb2pYl77hD7QDwbqPjrsQG3alLi453rHJ5uE2ARMsqBim2cI94MIJf6/9m7+7HzOQJw8i6Xj9M+cVR397LLPO8KgBYti8lTNPwR+U0BFwFwN38QVgYeEM4NbzQYQ2qZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB+XTLJT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so12273181fa.2;
        Fri, 28 Jun 2024 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719594385; x=1720199185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwOwymiTFXK5bpxKsm90XNAEfYuUZk1CldR/MN3iO+A=;
        b=nB+XTLJTgzCYcT7Rsm9BYA3uYYj0pMP1xjdJdRaLZqDSwvleI36DBSaOUvuI1gsssy
         VNqgrM6YP5Yvt4BS/b2s3wfbB+zFRih50vaAapMlA9BXz/Ya82jV33KngNjwovL4TRED
         oExcslu8FKydrggxK2Xld0NLesv30yfVTkHV9IgnNSp8V6/1uQJHZJWJF2LrLEoI4HIA
         b2OG7ps9+XNDF+TjQmU8Wa7X4l2LhYObP5OILFpcvDt7hhp4mZKBxiXmlH91kg0+fhCx
         yiLAB9iJluDbW+Y2uMT2BdOwHayOqxunsVckSKK5bVGTjc2AmS8o3BcgkybqGdrHTaOG
         ERTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719594385; x=1720199185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwOwymiTFXK5bpxKsm90XNAEfYuUZk1CldR/MN3iO+A=;
        b=G7xjqIBwjQCe5ygQwWVv8E31QtyiWyjnvkgQKsT783LU/N8nvZN/MDLxQS30mbyNiV
         N1RxNlDVSYgZ+fQLXmkOE+JFE9GobOm2tUVIjq2Eup8zkPquW44DZN1Cm6ARRQv5Of9k
         kCJh79Obt5uYu3IG3rBcMX5E5QU1t+vIJwXe6E/nfXdHRN3+Hd5m22JTMxw4oS1ZT5ne
         Vt57ajVLtD2syahtnqpS6WdWgZaC6ujQvffjEtlYzKmTM7z5P7rfE//7OVkGGH2siPCz
         iTULD7vYFh/TbaE6BEnFgOeY2chiqglAOsJVsbCXvJSoWC3Gt5jYu7UWuw5Opz+72fXj
         jM0w==
X-Forwarded-Encrypted: i=1; AJvYcCXSqpcNZHokui5AXDcc/QZHd0MNlrsxpzH1Z69R2lpdkGwPsWd5v7is/66vFF0YwvwUptBPzkj8YM1/tmFZaUZUhqS2pF22iBAWLjLFYeVzxKnoWEn0egRrGXGyR0P8CETyBkXBbDv2+IfyXda5Y22P00JZJmLyYY3yaSA4opqVnA==
X-Gm-Message-State: AOJu0YzkR2nakW5O6B0uf416fzaK2BEPnttBT+kOVwgpdKvf98tXSKAE
	fiF1ZXW/BJ39RbZhrY8k69z3Rzl/JJ/WxBjYqjo7kz7rgDy/TLv0
X-Google-Smtp-Source: AGHT+IHZHBnsfVjk3W/G/V45o0piL4CHZadYb28IWJPLziXyOpgdnn/L+zGnCB+cQ2zlzrmqkvnoiA==
X-Received: by 2002:a2e:7211:0:b0:2ea:e74c:40a2 with SMTP id 38308e7fff4ca-2ec5b2d5b95mr125913701fa.20.1719594384850;
        Fri, 28 Jun 2024 10:06:24 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5168cf89sm3362251fa.115.2024.06.28.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:06:24 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:06:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <a234uiz4gtjpgq3uphe2dh42nihkg6bzlspslhhfuv32f53yli@fypobrcl3wyp>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-7-fancer.lancer@gmail.com>
 <20240627-hurry-gills-19a2496797f3@spud>
 <e5mqaztxz62b7jktr47mojjrz7ht5m4ou4mqsxtozpp3xba7e4@uh7v5zn2pbn2>
 <20240628-ovary-bucket-3d23c67c82ed@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628-ovary-bucket-3d23c67c82ed@spud>

On Fri, Jun 28, 2024 at 05:42:58PM +0100, Conor Dooley wrote:
> On Thu, Jun 27, 2024 at 08:10:48PM +0300, Serge Semin wrote:
> > On Thu, Jun 27, 2024 at 04:51:22PM +0100, Conor Dooley wrote:
> > > On Thu, Jun 27, 2024 at 03:41:26AM +0300, Serge Semin wrote:
> > > > +  clocks:
> > > > +    description:
> > > > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > > > +      source connected via the clk_csr_i line.
> > > > +
> > > > +      PCS/PMA layer can be clocked by an internal reference clock source
> > > > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > > > +      generator. Both clocks can be supplied at a time.
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > > +
> > > > +  clock-names:
> > > > +    oneOf:
> > > > +      - minItems: 1
> > > > +        items:
> > > > +          - enum: [core, pad]
> > > > +          - const: pad
> > > > +      - minItems: 1
> > > > +        items:
> > > > +          - const: pclk
> > > > +          - enum: [core, pad]
> > > > +          - const: pad
> > > 
> > 
> > > While reading this, I'm kinda struggling to map "clk_csr_i" to a clock
> > > name. Is that pclk? And why pclk if it is connected to "clk_csr_i"?
> > 
> > Right. It's "pclk". The reason of using the "pclk" name is that it has
> > turned to be a de-facto standard name in the DT-bindings for the
> > peripheral bus clock sources utilized for the CSR-space IO buses.
> > Moreover the STMMAC driver responsible for the parental DW *MAC
> > devices handling also has the "pclk" name utilized for the clk_csr_i
> > signal. So using the "pclk" name in the tightly coupled devices (MAC
> > and PCS) for the same signal seemed a good idea.
> > 
> > > If two interfaces are meant to be "equipped" with that clock, how come
> > > it is optional? I'm probably missing something...
> > 
> > MCI and APB3 interfaces are basically the same from the bindings
> > pointer of view. Both of them can be utilized for the DW XPCS
> > installed on the SoC system bus, so the device could be accessed using
> > the simple MMIO ops.
> > 
> > The first "clock-names" schema is meant to be applied on the DW XPCS
> > accessible over an _MDIO_ bus, which obviously doesn't have any
> > special CSR IO bus. In that case the DW XPCS device is supposed to be
> > defined as a subnode of the MDIO-bus DT-node.
> > 
> > The second "clock-names" constraint is supposed to be applied to the
> > DW XPCS synthesized with the MCI/APB3 CSRs IO interface. The device in
> > that case should be defined in the DT source file as a normal memory
> > mapped device.
> > 
> > > 
> > > Otherwise this binding looks fine to me.
> > 
> > Shall I add a note to the clock description that the "clk_csr_i"
> > signal is named as "pclk"? I'll need to resubmit the series anyway.
>
 
> Better yet, could you mention MDIO? It wasn't clear to me (but I'm just
> reviewing bindings not a dwmac-ist) that MCI and APB3 were only two of
> the options and that the first clock-names was for MDIO. Maybe something
> like:
> 
>   clock-names:
>     oneOf:
>       - minItems: 1
>         items: # MDIO
>           - enum: [core, pad]
>           - const: pad
>       - minItems: 1
>         items: # MCI or APB
>           - const: pclk
>           - enum: [core, pad]
>           - const: pad

Agreed. I'll add the comments to the oneOf-subschemas as you
suggested.

Thanks,
-Serge(y)


