Return-Path: <netdev+bounces-181377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957BA84B40
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED231B831CE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352128C5BE;
	Thu, 10 Apr 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmH75SkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE928A3EA;
	Thu, 10 Apr 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306809; cv=none; b=ga2V9g70AwSJc3MCAbUMMipySIyE52HvPVQyZpUVP4oVbOKFiBLaBI5KWvRRwyK73K8NBSd44GaSu+NSQNRuFYxDRdXGtQS/FQWAPURS0N5vJ/A7KONrK7dDgsDlkF87m+rjZxed1+a/QiE2EKeU/41IucsWXFP7OgdRAJPL7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306809; c=relaxed/simple;
	bh=FAho+0yZ/VdplV9UJBGYCdY74HYgyPoltCXDR8BmIgk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9FFInX8jQdiql9FHKocS1jKQN/8tuDzQAXX/C2GZJi6kxnn9+o2RaTNxdG1pppJXGWystumBZqqrQHeQ1LM2RSIiY7xfR7qIJTcVlN+KLT4YCNQzKx9scEJ/CevdmnZ/Iukoivw6B+RkIjhVcHbh4RKZCcdShRqr7dtP9W9zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmH75SkW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0dfba946so603860f8f.3;
        Thu, 10 Apr 2025 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744306806; x=1744911606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pFjKItarHUEZIrjo0ZjhvTOl5jmnWBzUA0dauVIkn30=;
        b=mmH75SkWeTAwvAbF97pgsbkK74cP5hn9M6DJR5PcgUe0BDYVorzymgM4nB4N0zMbl5
         piKEwQUcXEPhRUJnIUa3BkMELngCuuV3EJR1S20DB4Kvq8qV3yHXK40JwmAchVX12//R
         roiKXmu4s2pDG5deKOBKuK4OB/hIyoqZsWW7hlxyBm2nUMwAJWrfRwM3iH4RaQBHI+PC
         CGttawWi4NpRSxwIx//nCIUS9D88rnMv6wF9k5+JuNpcQEqHOSTzLbDZ0t/9XM0ST3Ne
         jM3G7aEMThrbS4OYWxHkel5QZLah0W5IiXjjM9353eUG1E+OgUdp+Kq3aezylyeqM6r6
         RqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306806; x=1744911606;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFjKItarHUEZIrjo0ZjhvTOl5jmnWBzUA0dauVIkn30=;
        b=lu8nIvEzh0rt5uYc4aZDlGL66kx5Bdd70MEZrivS47CeiWqMubLAdLpwAv+fudPiYv
         3E1iiFwCzQ7Vr7cgfUtCAwUcGQIVVFMHFGOhiTO6zeTsE65b8rR9pBGa5b4f51sqTMgQ
         37dFQJOZAynWasmrvVoEnkaJpeSzodA/tiChpuXQilAAYocM+kLH7YPw1vJqJymmsDic
         f6ODsHORMPXPxFYIhedETc91U2+owc6S0RX6yNp1gnqMP+hSuwKOk8Z0lkuODRl62Spz
         jcIBFKNX4T9TY7WqFVEhkCjXIB0AYUEhJDiVB2n6FPXSbSI/k5r7YPOUuSai5REt5ZWM
         2b9g==
X-Forwarded-Encrypted: i=1; AJvYcCU6XqYjmvSl8KrE2mQAtnGsLCcYUExpcIQq5kkwNQrLSb5pNrQk9GMT4nhvChY+OEbEa4RBvjUn@vger.kernel.org, AJvYcCWHsl4GSImdmADzQTU8lYZ+xYIf7cPzCKGSdj239gFdSbZa4k6Epll9Gek4+17945KWFtHwvwscI0ws@vger.kernel.org, AJvYcCXlc8Brm0gHew8SlH0v202glVRft7TREOrDSX6RmOar2ijXVUyqlH8mLFRveZB8nOR07mzn/uIvfLq+GAcZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YEhah6rBoB3wpof+9zqx1uPwA/BqQFipsjdUCAAiohxVE4Vk
	lGbFBvv5UMdZv8OnvdgZNU7PUnw8tKDDneONdFASjFfT+igyopeI
X-Gm-Gg: ASbGnct+har/cx2kYYyeXGeKf0runHz4a7y1aW3+9P2ZNmxDkjIA5zlyrI0Gcz2XFyG
	NK+kHmWhlLovYSxhKRy+cuW3m8KNZ5oAXNaeHwIf31c96ctA2DZgZq1gKj5ZAXSKYL+VPqeolk6
	L+bQBuHjDvhdXeEhRzKIErYtxoz2n/Z6YAydS5m6jfGJUzEnOkiJy1M75EvD+FlI5EY/xACUMmG
	5d/3lPokyjb0HharqA1jcsnn9fgVX1qKjv62GaTbEcVkPJOE9x1wnsJoGNe1ly4VY4mEVK5eKGf
	Z8Vky07VFah6b6H5OUEYj4s/Ef8YW3er6ADiFKgh9ZSTFjQltqKBl7Fg0h6y8oyMTzgsEsaD7Cs
	q9uOXjMo=
X-Google-Smtp-Source: AGHT+IFv4THUajH089YkeOkRes3LsTf9KDOb0k8QeqOxF6+NTBvRT51OO4QNQNiPc57IIpsOupZZ1w==
X-Received: by 2002:a05:6000:2204:b0:391:40bd:6222 with SMTP id ffacd0b85a97d-39d8f46daecmr3242955f8f.22.1744306805615;
        Thu, 10 Apr 2025 10:40:05 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0a80sm5568993f8f.68.2025.04.10.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:40:05 -0700 (PDT)
Message-ID: <67f80275.df0a0220.39b09a.dd38@mx.google.com>
X-Google-Original-Message-ID: <Z_gCcun1WNIjfxbM@Ansuel-XPS.>
Date: Thu, 10 Apr 2025 19:40:02 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v14 07/16] net: mdio: regmap: add support for
 C45 read/write
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-8-ansuelsmth@gmail.com>
 <50c7328d-b8f7-4b07-9e34-6d7c34923335@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c7328d-b8f7-4b07-9e34-6d7c34923335@lunn.ch>

On Thu, Apr 10, 2025 at 07:08:53PM +0200, Andrew Lunn wrote:
> On Tue, Apr 08, 2025 at 11:51:14AM +0200, Christian Marangi wrote:
> > Add support for C45 read/write for mdio regmap. This can be done
> > by enabling the support_encoded_addr bool in mdio regmap config and by
> > using the new API devm_mdio_regmap_init to init a regmap.
> > 
> > To support C45, additional info needs to be appended to the regmap
> > address passed to regmap OPs.
> > 
> > The logic applied to the regmap address value:
> > - First the regnum value (20, 16)
> > - Second the devnum value (25, 21)
> > - A bit to signal if it's C45 (26)
> > 
> > devm_mdio_regmap_init MUST be used to register a regmap for this to
> > correctly handle internally the encode/decode of the address.
> > 
> > Drivers needs to define a mdio_regmap_init_config where an optional regmap
> > name can be defined and MUST define C22 OPs (mdio_read/write).
> > To support C45 operation also C45 OPs (mdio_read/write_c45).
> > 
> > The regmap from devm_mdio_regmap_init will internally decode the encoded
> > regmap address and extract the various info (addr, devnum if C45 and
> > regnum). It will then call the related OP and pass the extracted values to
> > the function.
> > 
> > Example for a C45 read operation:
> > - With an encoded address with C45 bit enabled, it will call the
> >   .mdio_read_c45 and addr, devnum and regnum will be passed.
> >   .mdio_read_c45 will then return the val and val will be stored in the
> >   regmap_read pointer and will return 0. If .mdio_read_c45 returns
> >   any error, then the regmap_read will return such error.
> > 
> > With support_encoded_addr enabled, also C22 will encode the address in
> > the regmap address and .mdio_read/write will called accordingly similar
> > to C45 operation.
> 
> This patchset needs pulling apart, there are two many things going on.
> 
> You are adding at least two different features here. The current code
> only supports a single device on the bus, and it assumes the regmap
> provider knows what device that is. That is probably because all
> current users only have a single device. You now appear to want to
> pass that address to the regmap provider. I don't see the need for
> that, since it is still a single device on the bus. So adding this
> feature on its own, with a good commit message, will explain that.
>

Thing is that for C45 some kind of encoding/decoding is needed anyway
and with the suggested encoding (in previous patches) also C22 needs
special handling to extract the right address.

> You want to add C45 support. So that is another patch.
> 

I decided to implement C45 first as it would indirectly add support for
multiple register as for C45 you need to encode the PHY address anyway
(even if it's always the same) (making the next patch trivial as
everything will be already in place and just need to enable it by
passing a valid_addr_mask)

> C22 and C45 are different address spaces. To me, it seems logical to
> have different regmaps. That makes the regmap provider simpler. A C22
> regmap provider probably is just a straight access. A C45 regmap
> provider might need to handle the hardware having a sparse register
> map, only some of these 32 block of 65536 are implemented, etc.
> 
> So i think:
> 
> struct mdio_regmap_config {
>         struct device *parent;
>         struct regmap *regmap;
>         char name[MII_BUS_ID_SIZE];
>         u8 valid_addr;
>         bool autoscan;
> };
> 
> should be extended with a second regmap, used for C45.

So you are suggesting 2 regmap with dedicated read/write function.

The thing is that if the final target is to permit this driver to
support multiple PHY from a single regmap, and we also want to apply the
same encoding format, the regmap max_register will be the same for the 2
regmap making it redundant to have 2.

I think this is the blocking part that unlocks everything else.
Understand what is the preferable way to handle multiple PHY.

For C45 encoding is a MUST, and with encoding you get the side
effect/bonus feature that you can inject more info.

Hope you can give some guidance about this! Happy to split this once we
find a common point on how to proceed with this.

-- 
	Ansuel

