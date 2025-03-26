Return-Path: <netdev+bounces-177760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F781A71A1C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2163BC84F
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6C154430;
	Wed, 26 Mar 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjPTI6da"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092121487FE;
	Wed, 26 Mar 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002203; cv=none; b=g0c5u5FiBDpdPa1bM/s+rm+Txt//qWdpvSbktZ2DuGEzWXxu/UyeFn9l2sosEiuNtriSGLbx6AoJve+FPvDkfZWAD441tuLuJ7pkNMEYI52+n+G1MyvjOQinf4yxv/Sba4UBfNb0d/kvNdPSJKLGG29l3B1cSURU9iwFVfunBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002203; c=relaxed/simple;
	bh=24X/ZdyDqQkvrH6CWkwNHWJIQTB8tBU3RYiNFxsB0EI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTV5If9gRAiPKSvEfGc0605POUrJ4BhbP9dM7KlVtxRj6uep0/cpT9+LtT3zUMRisHUhYruzAeIZdmA7LemBIJ10gqF/k+eAnOL9W/tWJ9WGr1OvWpSD9X3G9hIGbPx6mVyvdO+xv4gWVKTMLSPw+wPz/RH8uGcb+HTEViCQbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjPTI6da; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so35624075e9.1;
        Wed, 26 Mar 2025 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743002200; x=1743607000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y85oIIcm8gxsyGNFmtbfLlnKY/DF/ZVUpoApBWzNdw4=;
        b=XjPTI6daBoQibAYSGrnkbP2D29Xq5zjELN+deVVEWTFFEofj/skljMtRGenWJfgxCf
         /U+4R5dpG9RHl131E3msqS4IQOC+BzTc8ylg5pxjl78MwT5Jeho/RjOu9RiWGP4J/ZuY
         1TX2eNjGc8KbkXWhPqsQqvNQ8XtLg+en83mP9lbHSeMSz+07Aajq1XEkJ/Eda/Lyq6P0
         Qq+8NcILPurC17vBsJMtqve4f6uylySXxYQvDlkaW7Yp8uj8O9RKJ87Ea8qTjgArfXCD
         oCknbPJ36iwkmF4X0o3PRwIPxTSq8ww7utd+Qz79efVOcwNnVzBjOjV6lj33P54MpEB3
         GOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002200; x=1743607000;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y85oIIcm8gxsyGNFmtbfLlnKY/DF/ZVUpoApBWzNdw4=;
        b=VpCR7FsShxO/iVWU6QtPRQc21/2BxW43T+RO7bXPEMMGYd0OOq31FGquKqDDVfXQyr
         7IC25mXvB3JmgH83zBWmOY0ExDkQZXgkZtUYZO27X9jnSSi51Zc9iIU5iqcwQPE5NiWZ
         Rnw9z9xTqR2BeWriYVbo+nmOdBtpuF2Bg3/gFgS0P+Fdi0baSoiAAkUw2iMQvShasB84
         0SFrGb7fRu0f8IlFPdZxzK2rBJf8FNs8iqwBHvn2lHQANQrNW+nt5LgTPWjxbOmhYC1q
         DaXUEOxRgV9K4iHpgcu8ff75qEbZ9P301GspYt3kSOjzgymdHfi43e4LF22VAwX+kCi4
         KhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7rjuRy2FCvfQaC4kFVL451gn0nrCqU0oeb4/ePkL1XwVujXeSJoU5GqmkjrEM7ms4uLP/mj6+@vger.kernel.org, AJvYcCUWecEuHLKUwROhYfpe4P7l5Y918eXE7Ga/d1hs/tjE36AsIAo73LL6IdzCCXEO+65pWAncAdm+KjCq@vger.kernel.org, AJvYcCWPHPbxOFlN6GAwgJV/kvMoG6uwrm048gMFyiyXh66U+6PSYUT47MmNpScx6B4JSibLbWpGO/tQWGHv6e2a@vger.kernel.org
X-Gm-Message-State: AOJu0Yynh4Q1B5Rd+/QdMUb4dPFDBtCntgf7IRqt7gWU2HgUO5jXXFQM
	dNZO4gvOIh2leLFAfjTzMuDzh/TjCPiHaFuWPlbGxR/CJy5znR7k
X-Gm-Gg: ASbGncu/4/ZrvpUbAzNxWVa3xoQ94/vl8ok8brxuJo4lGhS5afX0UhiMgWT0ZEDUvte
	DlcXu9cjdhPa4KV3pHo/xA71wDpOVgeQrwpQAXxR3uEMcXEVUDxIUOWFp723VQWz/faC6ueMnOf
	9zV5oSPRhjAxd4NS0/WqQLjtZMwWmRoXAg+1jYS3bfNA4dNvcIT0oB7MYbNWNO1WCxd2Lpf+ema
	KGTcDlTc8SYI4gG/6tLid/7RGdLe/bY1DxgwpvZbv4arncidx2PLROrpfNk4qQJy03MtSGjwqeM
	CtIEnxsvol7yL2L5o+FgTga/oRRuFtGPGSyNXSrKIhnq8USKyTDs2bYXpPxAiXGBIYOpz34c6aa
	M
X-Google-Smtp-Source: AGHT+IHq4/YZ4/H5LWJdb571fFty3ntzrqohrYGC3QHhtf0iMCl7uuDPZdsJX1dTGPwHqjX0z+upeg==
X-Received: by 2002:a05:600c:1d81:b0:43d:10a:1b90 with SMTP id 5b1f17b1804b1-43d509f8691mr209903635e9.16.1743002200098;
        Wed, 26 Mar 2025 08:16:40 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b517csm17433341f8f.51.2025.03.26.08.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:16:39 -0700 (PDT)
Message-ID: <67e41a57.df0a0220.21de93.f609@mx.google.com>
X-Google-Original-Message-ID: <Z-QaVe1BiFCZ2Hqj@Ansuel-XPS.>
Date: Wed, 26 Mar 2025 16:16:37 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 3/3] dt-bindings: net: Document support
 for Aeonsemi PHYs
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-4-ansuelsmth@gmail.com>
 <77a366f8-0b58-4e1f-9020-b57f7c90b3bb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a366f8-0b58-4e1f-9020-b57f7c90b3bb@lunn.ch>

On Wed, Mar 26, 2025 at 04:08:31PM +0100, Andrew Lunn wrote:
> > +  A PHY with not firmware loaded will be exposed on the MDIO bus with ID
> > +  0x7500 0x7500 or 0x7500 0x9410 on C45 registers.
> 
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - ethernet-phy-id7500.9410
> > +          - ethernet-phy-id7500.9402
> > +          - ethernet-phy-id7500.9412
> > +          - ethernet-phy-id7500.9422
> > +          - ethernet-phy-id7500.9432
> > +          - ethernet-phy-id7500.9442
> > +          - ethernet-phy-id7500.9452
> > +          - ethernet-phy-id7500.9462
> > +          - ethernet-phy-id7500.9472
> > +          - ethernet-phy-id7500.9482
> > +          - ethernet-phy-id7500.9492
> 
> > +        ethernet-phy@1f {
> > +            compatible = "ethernet-phy-id7500.9410",
> > +                         "ethernet-phy-ieee802.3-c45";
> 
> You need to be careful here. And fully understand what this means.  In
> general, you don't list a compatible here, or only
> ethernet-phy-ieee802.3-c45. This is because the bus can be enumerated,
> you can get the ID from the device. What is in the device is more
> likely to be correct than whatever the DT author put here. However,
> you can state a compatible with an ID, and when you do that, it means
> the PHY device ID in the silicon is broken, ignore it, probe based on
> the value here.  So if you state ethernet-phy-id7500.9410, it does not
> matter if there is firmware or not in the PHY, what ID the PHY has, it
> will get probed as a ethernet-phy-id7500.9410.
> 
> Except, if there is a .match_phy_device in the driver ops. If there is
> a .match_phy_device the driver does whatever it wants to try to
> identify the device and perform a match.
>

Yep I will note this for the PHY driver. I really need to use
match_phy_device for the FW load OPs to prevent any kind of bad
compatible.

In C22 75007500 is reported while in C45 a more correct 75009410 is
reported, this is why the c45 compatible.

Aside from this, the compatible listed here are really just to document
the need for firmware-name and to what PHY it should be needed. It's a
pattern I followed from the aquantia schema.

Example for PHY with ID 7500.9410 in C45, firmware-name is required, for
anything else (example 7500.9422) firmware-name property should not be
used (case with a SPI attached for example).

-- 
	Ansuel

