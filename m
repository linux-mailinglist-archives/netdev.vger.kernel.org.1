Return-Path: <netdev+bounces-150838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6B9EBB54
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED35167C19
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01022B8AE;
	Tue, 10 Dec 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZbM39lr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9822687F;
	Tue, 10 Dec 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864352; cv=none; b=FC70E4xtlALQHKhUWalbJ9uPkZHuiufBHOml6KFDl0/ttQbNx0aw20O8pMZO4/xh10hASX4QgxAAIT7fWWbA/kO6dVMLRfFCLTMCv1r82laUGXb9MC8JbxBz4uYPHgf9zmBzMPHJx4X9obWzjv5uzKqzZP8D81vHPzsdV1F18Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864352; c=relaxed/simple;
	bh=8ay72ah4zoiprvTWL2Yp+qkOORhqO1uhwF6m23dIdoA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enDY/M8q5alkr3isWLiYKutEUJpucTUBVAHFsQRd77pWswZNlkUk1ecRjG9TJF7/HmX76nV0Sck6i5jMX+6B6qmnFFL4GL1KJ6SuJ8jPxEMEtl7qPgAeiQBW/KX6D4Z3MJWVL8KRmaa4+tkCcPGM3bmqb6ZO7ngf7Xg4+4HMTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZbM39lr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a742481aso53485045e9.3;
        Tue, 10 Dec 2024 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864349; x=1734469149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZoRyVnubsCTXnGDN0W6JhwZ/Q5YmmQyUD3hy10ebHg=;
        b=fZbM39lr9XFHcKMyCnBpdVjroQGIVyMU7ry7DijQ/jvDmlwDC8PuvGAX8B358V4dsW
         1iZTviK1FAChTYs6IBD0DLKFDMiNP0K1LulSKqiIzybcFebpm+aP2e409iCBQzpok1Vs
         Ty/H/MOOOkuzLUuzBbdYLzK/FKDKxzM/qUy5k/zJOz2ps7+FRRkVgv3LSIt84xvgv7rc
         QzUK+e7JIK80OlJnk1E4vEZCKqKzryJ2DVjxgPIow+t7Rx9pspZEJIsoAdiOPErfS9+s
         6Ji5afM6158ppi8Ig56H19hH9t7oG86ARgPgwOioeTi3vr+Yfs6oXOZNYIR+FSbvZ9G7
         Ey7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864349; x=1734469149;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZoRyVnubsCTXnGDN0W6JhwZ/Q5YmmQyUD3hy10ebHg=;
        b=ruRb9ZsM7vEgkX6rPIfT+EbU4m7+WUKw522gi6+WvAPm/wlqLVd9Qyo+5JhVTuU9+a
         kk75G8OE+Rkrzum9/dSUwnuIKeeEnDm6ty4+SU6grkduWoWycq+qyaH1G6ita83zUwll
         txTwf1tbFdvpYUf3vKbO6rmr//ez38h8RbaN1aeEhpaPV2rwqlonIt8uOe10MVi/NsCX
         MBy12qsysKutV+f8Rn/1ODPX9Z4wgd72bGBsXRfg/nBf3PB086sp7ae1VkXFlRAhduk1
         Sb8m2yvZApNghXwQ/f/BXCgXoobnBN/++MktsqxioXrPKkNI62sMVGKXFjUvYV0ZXJLk
         FeFg==
X-Forwarded-Encrypted: i=1; AJvYcCUg9MzNVR5muITXHrVt82AwOUHjqWSrDJ41EqzsHD5iW8vm7PoF1YB4HlGOcG5xHt8SDYuFoSzZaQUS@vger.kernel.org, AJvYcCUgXJwibc/XJNF0j7APD/kpRGcPNCps6H5EgYZHYYFsMappOdoOSlsoxzYHDfMoBSvvir+p0dNziQ80XgQn@vger.kernel.org, AJvYcCVJ5WuQ1OY9lvmmPFi4ZRHQVtlnYPVXOW2VmE2qeLIh5+EbN3b9i+EBgna1SoRK4EPPQ+wkGIs4@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7dezV8sI/rttOTihqcZhHYNmLPFGWETZXDq7YOs8G1NxJQ/H
	r3XmEzLxNwQyGHulOyTNQEe2ANcQU41PLaif6gFRJydbBLxjjXTt
X-Gm-Gg: ASbGncso1voA5/Hh9wrfsUXFLhrPLn27DQzl0yyFfZTmIup20Is4WtrCuUAKx+F8anu
	uKyuhJ3vvnk2bU/wzdq+Uf5+TrQQ9gfL75k5eliJ7yQYv4brlNzBKxbKUtNefC84NEJskcv1Z8a
	bmk2cSzFfOYS6zAgttk6OeDAdFdtgol6bmRynKjfQ0X4Sp9WfdrvVIHakMjRktzMgAX/HJzFmAo
	UTEuKl/OMEgUO6JtYjHLo2mavVVQqcxHmzg1aYXfLkD2+HaGdm6HcP8kQStM4yZvLtTDNqdc4Zz
	Vao6BmZ2rQ==
X-Google-Smtp-Source: AGHT+IE2p4zS0d4ssJx5pitNO8yM+2jWAE85KmDwhz76rWPYidu8fzQPEOifjDJac/byApIZwC84jg==
X-Received: by 2002:a05:6000:1843:b0:386:3b93:6cc6 with SMTP id ffacd0b85a97d-3864ce54e5fmr442280f8f.15.1733864348810;
        Tue, 10 Dec 2024 12:59:08 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f5774454sm94941465e9.13.2024.12.10.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:59:07 -0800 (PST)
Message-ID: <6758ab9b.7b0a0220.3347af.914a@mx.google.com>
X-Google-Original-Message-ID: <Z1irmE4BWBl1jIz7@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 21:59:04 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 3/9] dt-bindings: net: dsa: Document support
 for Airoha AN8855 DSA Switch
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-4-ansuelsmth@gmail.com>
 <20241210204855.7pgvh74irualyxbn@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210204855.7pgvh74irualyxbn@skbuf>

On Tue, Dec 10, 2024 at 10:48:55PM +0200, Vladimir Oltean wrote:
> On Mon, Dec 09, 2024 at 02:44:20PM +0100, Christian Marangi wrote:
> > Document support for Airoha AN8855 5-port Gigabit Switch.
> > 
> > It does expose the 5 Internal PHYs on the MDIO bus and each port
> > can access the Switch register space by configurting the PHY page.
> 
> typo: configuring
> Also below.
> 
> > 
> > Each internal PHY might require calibration with the fused EFUSE on
> > the switch exposed by the Airoha AN8855 SoC NVMEM.
> 
> This paragraph should be irrelevant to the switch binding.
> 
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../net/dsa/airoha,an8855-switch.yaml         | 105 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> > new file mode 100644
> > index 000000000000..63bcbebd6a29
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha AN8855 Gigabit Switch
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: >
> > +  Airoha AN8855 is a 5-port Gigabit Switch.
> > +
> > +  It does expose the 5 Internal PHYs on the MDIO bus and each port
> > +  can access the Switch register space by configurting the PHY page.
> > +
> > +  Each internal PHY might require calibration with the fused EFUSE on
> > +  the switch exposed by the Airoha AN8855 SoC NVMEM.
> > +
> > +$ref: dsa.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,an8855-switch
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIO to be used to reset the whole device
> > +    maxItems: 1
> 
> Since this affects the whole device, the SoC node (handled by the
> MFD driver) should handle it. Otherwise you expose the code to weird
> race conditions where one child MFD device resets the whole chip after
> the other MFD children have probed, and this undoes their settings.
>

OK.

> > +
> > +  airoha,ext-surge:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Calibrate the internal PHY with the calibration values stored in EFUSE
> > +      for the r50Ohm values.
> 
> Doesn't seem that this pertains to the switch.

Do you think this should be placed in each PHY node? I wanted to prevent
having to define a schema also for PHY if possible given how integrated
these are. (originally it was defined in DT node to follow how it was
done in Airoha SDK)

-- 
	Ansuel

