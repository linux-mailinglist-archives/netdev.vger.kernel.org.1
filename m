Return-Path: <netdev+bounces-208439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2AAB0B6CD
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0543AF2E7
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71621C19D;
	Sun, 20 Jul 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vaQydxC+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4F20D4FC;
	Sun, 20 Jul 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027030; cv=none; b=OgvsmgiUdlqKwww3i9nDP9XfQUosgJ/578P1Z2f8kj1PGoDAbwPdmIDmQvkEsKjPd8HXJiHsVDSg7LgAdd3OkxC+QJv7TcejF4U+m1e3izNdmrQU2w28lTDRIWNgdrKVPtQhkDS8YwpNFGhtYAShcnGlTg3rhNxwAlXn+Au7uJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027030; c=relaxed/simple;
	bh=acbZNQ8wzNe9UhG8osyw9whHFhX2+PMv5SqAhvGrJxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/AEniIwqusWQWg/s19Nxp8a78/xRzw/E9qN9wj70xz42+vxnew5DQ/Whhj429exVt4LcCC3hJ9U/9cl/cnCvkzW2SkFRQwft312z+Y8tn7lOt3VsKCwh4NqP0MPk7+YfxWdLiXrV60q5rQinyUHJK91uqadhu2mSjSNVxfShAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vaQydxC+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=64nxx6o3UjsOD65DzGW1UiFh1tmvoBz5/OywLQywsuk=; b=vaQydxC+p99n0aFgzK9ODIGBcE
	c76b8JTV9FtYQnKIKBUYRnVxAgRqBNSAog0CuByr5QNViO1mr7noGT96HP2S9J2aZnexf+OOdtvLR
	BtlA2X5etCJ/8aBcZK1Ofb/cBSZZhlFLAMNxrzlFZPxcMFvZ9mvDizTm0cbnarAdYX/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udWPE-002Cro-Fp; Sun, 20 Jul 2025 17:56:52 +0200
Date: Sun, 20 Jul 2025 17:56:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/7] net: dsa: microchip: Transform register
 for use with KSZ8463
Message-ID: <4dd544ad-fa71-4759-bc23-d1dd7f554eb8@lunn.ch>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-4-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719012106.257968-4-Tristram.Ha@microchip.com>

> +static inline bool ksz_is_ksz8463(struct ksz_device *dev)
> +{
> +	return dev->chip_id == KSZ8463_CHIP_ID;
> +}
> +
> +static inline u32 reg8(struct ksz_device *dev, u32 reg)
> +{
> +	if (ksz_is_ksz8463(dev))
> +		return ((reg >> 2) << 4) | (1 << (reg & 3));
> +	return reg;
> +}
> +
> +static inline u32 reg16(struct ksz_device *dev, u32 reg)
> +{
> +	if (ksz_is_ksz8463(dev))
> +		return ((reg >> 2) << 4) | (reg & 2 ? 0x0c : 0x03);
> +	return reg;
> +}
> +
> +static inline u32 reg32(struct ksz_device *dev, u32 reg)
> +{
> +	if (ksz_is_ksz8463(dev))
> +		return ((reg >> 2) << 4) | 0xf;
> +	return reg;
> +}
> +
>  static inline int ksz_read8(struct ksz_device *dev, u32 reg, u8 *val)
>  {
>  	unsigned int value;
> -	int ret = regmap_read(ksz_regmap_8(dev), reg, &value);
> +	int ret = regmap_read(ksz_regmap_8(dev), reg8(dev, reg), &value);

I'm wondering if there is a less intrusive way to do this. When you
create a regmap, you can optionally pass it methods to use for
read/write/update etc.

struct regmap_config {
...
	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
	int (*reg_update_bits)(void *context, unsigned int reg,
			       unsigned int mask, unsigned int val);

Could you provide your own methods for the ksz8463 which perform the
register modification, and then call the normal regmap SPI function to
do the operation?

If you cannot get direct access to the regmap SPI functions, you can
stack one regmap on top of another regmap. Have the top regmap do the
register modifications, and then call a normal SPI regmap to do the
read/write.

What i don't like about the current code is that developers adding new
code could miss they need to add reg8().. to all regmap calls. So
ideally you want to hide that away so they don't need to care, it just
works.

	Andrew

