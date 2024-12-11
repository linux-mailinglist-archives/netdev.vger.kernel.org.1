Return-Path: <netdev+bounces-151071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9B9ECAAE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2A818831F8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CCA1A8417;
	Wed, 11 Dec 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcKpA8X2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C035239BD7;
	Wed, 11 Dec 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914368; cv=none; b=kNyDciRwJ86PulHmcBPwKcUbrv+dm22f0XomqTEtBzye7vpSi9fguTaxgaVTByTKO2P72Xx5tNFMErdsrDIMOXYO+W2RMW9vk3T3a99WoVq2+hZmS9NibRwRQdJTu7ofarlmFP+YwMXiCL7gPjpZ4qNliSa/Yp9dpgeG1HWbkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914368; c=relaxed/simple;
	bh=BgZhTlevp6pqoGWsVWl9p/I9hGt8OABfUQFAsOGdESw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISUHCswJLq9AEMPzzrRp7/0JZBEeWR6sBitCVkFUx/LqxRCF7HmJjD+qNAMMrFhxXVX94qLfgkfTcQqCAm1MKNCAW5Mj3CobR8P7qv3f7axUK11SJXF7SQoNpFgv3DLqRIEp3ZkcALiCdiUmKkUYISeJmvY4zikqxFvH4n3EH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcKpA8X2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa68d0b9e7bso564552766b.3;
        Wed, 11 Dec 2024 02:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733914365; x=1734519165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ar7X7quiyDOv9lF7YgSvJbRmBbIs8Br6m+T2KQOTxk=;
        b=bcKpA8X2Gq51dTOFtTbs5SwxuC3uuY9PpbMydWBOfwErwgJXe389Ij0b4oSYgcuUNP
         eQOGbfMtgaryRmu6NoX8uBagVG+zPf306Mu2XmO2cMmToSM6oE7mwD7u2ggsHOQH4ZNF
         3sMkY5PAMVXPOIBV5NdYzI3IMWENSBOJeUKKKJQcH+jNglVdiU8fvZnGQibHFNK/pdTB
         v2iDGJur1DqJufnqaH9KbiOMsjT/TByvCHDVOr9VOoLicBps7q75V6txtGgPY5kri6Hh
         QjofZ3pUcQkWSVKp0+uZ6XYctvVkx2lKgv7l26xfS3/YdorIGPUDPzf6/I798G5JgiP9
         qGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914365; x=1734519165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ar7X7quiyDOv9lF7YgSvJbRmBbIs8Br6m+T2KQOTxk=;
        b=HAC+kr1c8oErApDWwZOZqecVfu7QznuADoyGALyGdEBAQrGZQl/nh2CEBirJdFLW19
         D3+oulai7ASqrjpeHmacpjO6SqMbpQKDOW36noW1TftEfYa/C5mb3v+DwM0G3/bfYEQj
         aW1f0l3YEcS2Yqvsk/B0/YPXnsG8Duq/ppTvQ+7RufQrteFSEL8kgvChh9CETZ1GpLvI
         WlnkZ09LF5nM+4SeKro10kWG7JIZ3iIEkzZHXYU8KjvMR/I6UZ1EjTO5hZsV075W6p1m
         h0gT9oZ0nu0C8T2TIUJaz0GiyohAHHPoyKabP8ydKgPmouU3fEsMw0pDNLZftyPhmLkb
         RdHw==
X-Forwarded-Encrypted: i=1; AJvYcCU1xaaxjctrC1YA9cPdi1mW46Ac3C2eeCbgpzdgU7cOkn79RCMQwRiYs/1iJsIpp5RWo4ViERzsrJHY@vger.kernel.org, AJvYcCWeLK652pphDwOdjbg5llm8UMN35DiTLtuOmy/60mllKuaFxr0ZJVriaJ9m1WFriFKqWQHg5j1z@vger.kernel.org, AJvYcCXV1HXLk2CqGUCoDba18H9wneux2H5wMgJiw1Qa/6utCjaxsz68Dtlx7fIqRAS1udgO6llIpZ+N7Zjifq8m@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvt+/GntnLPYhyOmCqMLv/eLE36TKZ7jMiTgKjc10rFkJ6ah0n
	CkAi5OzOmcsFZJltaxR88Vb4JLSzxpfZR/e9PpzbCacPJDtw2FSD
X-Gm-Gg: ASbGnctluSNb8gC5YcofWMFWMVDb4z0XDZn14yaH6NMAN0tq6Fe9YMW/jy9+Hme46sG
	MFo9o6TzEtTE+X7R+16IATYc71uc+5WtwJj20CwDq9fQ1RMUzGM3rxI0D5EBRtYZ5+gArRPUbYt
	dwLX9lOukqiBMOTBd9pv18NiCcl+3l7f4S7c7gVta9rVYg8vGGZLVztvzkWJYvCQJBKXlI5rv7z
	U5uHCGX7acyAGiIviOsYXbTlBqLK8fy8BLQIxESG71ke9do6Q==
X-Google-Smtp-Source: AGHT+IHwiOT3GsBg/NVpMOQ92ESIyoTXbNqLBTHHdiqMKQk4eQbTAxxraV2PCuqQkMb1fjMOP2h/7A==
X-Received: by 2002:a17:906:3190:b0:aa6:851d:af4d with SMTP id a640c23a62f3a-aa6b115b2bcmr151872666b.21.1733914365146;
        Wed, 11 Dec 2024 02:52:45 -0800 (PST)
Received: from debian ([2a00:79c0:67c:dd00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68c8944basm415879866b.143.2024.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:52:44 -0800 (PST)
Date: Wed, 11 Dec 2024 11:52:42 +0100
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
Subject: Re: [PATCH net-next v2 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Message-ID: <20241211105242.GB4424@debian>
References: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
 <20241211-dp83822-gpio2-clk-out-v2-2-614a54f6acab@liebherr.com>
 <qqqwdzmcnkuga6qvvszgg7o2myb26sld5i37e4konhln2n4cgc@mwtropwj3ywv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qqqwdzmcnkuga6qvvszgg7o2myb26sld5i37e4konhln2n4cgc@mwtropwj3ywv>

Am Wed, Dec 11, 2024 at 10:45:53AM +0100 schrieb Krzysztof Kozlowski:
> On Wed, Dec 11, 2024 at 09:04:40AM +0100, Dimitri Fedrau wrote:
> > The GPIO2 pin on the DP83822 can be configured as clock output. Add support
> > for configuration via DT.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  drivers/net/phy/dp83822.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> > index 25ee09c48027c86b7d8f4acb5cbe2e157c56a85a..dc5595eae6cc74e5c77914d53772c5fad64c3e70 100644
> > --- a/drivers/net/phy/dp83822.c
> > +++ b/drivers/net/phy/dp83822.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/bitfield.h>
> >  
> > +#include <dt-bindings/net/ti-dp83822.h>
> > +
> >  #define DP83822_PHY_ID	        0x2000a240
> >  #define DP83825S_PHY_ID		0x2000a140
> >  #define DP83825I_PHY_ID		0x2000a150
> > @@ -30,6 +32,7 @@
> >  #define MII_DP83822_FCSCR	0x14
> >  #define MII_DP83822_RCSR	0x17
> >  #define MII_DP83822_RESET_CTRL	0x1f
> > +#define MII_DP83822_IOCTRL2	0x463
> >  #define MII_DP83822_GENCFG	0x465
> >  #define MII_DP83822_SOR1	0x467
> >  
> > @@ -104,6 +107,11 @@
> >  #define DP83822_RX_CLK_SHIFT	BIT(12)
> >  #define DP83822_TX_CLK_SHIFT	BIT(11)
> >  
> > +/* IOCTRL2 bits */
> > +#define DP83822_IOCTRL2_GPIO2_CLK_SRC		GENMASK(6, 4)
> > +#define DP83822_IOCTRL2_GPIO2_CTRL		GENMASK(2, 0)
> > +#define DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF	GENMASK(1, 0)
> > +
> >  /* SOR1 mode */
> >  #define DP83822_STRAP_MODE1	0
> >  #define DP83822_STRAP_MODE2	BIT(0)
> > @@ -139,6 +147,8 @@ struct dp83822_private {
> >  	u8 cfg_dac_minus;
> >  	u8 cfg_dac_plus;
> >  	struct ethtool_wolinfo wol;
> > +	bool set_gpio2_clk_out;
> > +	u32 gpio2_clk_out;
> >  };
> >  
> >  static int dp83822_config_wol(struct phy_device *phydev,
> > @@ -413,6 +423,15 @@ static int dp83822_config_init(struct phy_device *phydev)
> >  	int err = 0;
> >  	int bmcr;
> >  
> > +	if (dp83822->set_gpio2_clk_out)
> > +		phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_IOCTRL2,
> > +			       DP83822_IOCTRL2_GPIO2_CTRL |
> > +			       DP83822_IOCTRL2_GPIO2_CLK_SRC,
> > +			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CTRL,
> > +					  DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF) |
> > +			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CLK_SRC,
> > +					  dp83822->gpio2_clk_out));
> 
> You include the header but you do not use the defines, so it's a proof
> these are register values. Register values are not bindings, they do not
> bind anything. Bindings are imaginary numbers starting from 0 or 1 which
> are used between drivers and DTS, serving as abstraction layer (or
> abstraction values) between these two.
> 
> You do not have here abstraction. Drop the bindings header entirely.
>
Ok, thanks for the explanation.

Best regards,
Dimitri Fedrau

