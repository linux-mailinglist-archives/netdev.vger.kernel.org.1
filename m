Return-Path: <netdev+bounces-209417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259CB0F8C7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2593A57F3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291919C54E;
	Wed, 23 Jul 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vlHLPvdm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06B2E371B;
	Wed, 23 Jul 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290971; cv=none; b=TlajRNPn0Zde+WaL4/9arve3gzQuFFlLhYPSdSZvDQ4Jr1yvN7Oa7xKnfupjhkWU5PE7vFudcEISRpUxI8gaH9KuViMt4bBtXUtjoETZhH3jjsRnKkqcKkPVTHI4ocWuDdExWLyBURBb3I/HgT+zo3OYnSb7gzkUV2vW92nMs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290971; c=relaxed/simple;
	bh=iVTDmofGQTAzngV/8kkO8hEyfpfo8lk01PQhA0Hog3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQc48qCEe7xqtc1IBe3l/VzUcyzAhI1X687aEqyv1hIDfX9AuVvaugOP6AgRk68I2IqOUtv5Czh8qrKXyxxeZCu0Ckbc0efB+5k+U2qcRYk26TfgHXDyKM4rC1b2SFxmwQPud0QDgvs6RlzlAYvJEm3+1aIUEhtpUFJhpjqFdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vlHLPvdm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TUmK6VJp0+E0SJQueeIqF9DxsO4dtccjN/iCA5xVXSQ=; b=vlHLPvdmdD+XmzDdgEpCoJ37fR
	4kA3gtamKP6pl7RUUKO7ce0QIfkO69/BZ/B8cVEnuum/5vFgJ/9z9LEreyN4BY0egcqVBEUlz4hoG
	+oAv6TzUYbem5YxCixTJvUMOQfg1CBZLX7BcrP6MF8x+QqEcf+CfpK10/m6eDUp5axqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ued4T-002fhc-Qy; Wed, 23 Jul 2025 19:16:01 +0200
Date: Wed, 23 Jul 2025 19:16:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/6] net: dsa: microchip: Add KSZ8463 switch
 support to KSZ DSA driver
Message-ID: <857db988-fd4d-4cac-9774-43161f1f592a@lunn.ch>
References: <20250723022612.38535-1-Tristram.Ha@microchip.com>
 <20250723022612.38535-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723022612.38535-3-Tristram.Ha@microchip.com>

> KSZ8463 switch is a 3-port switch based from KSZ8863.  Its major
> difference from other KSZ SPI switches is its register access is not a
> simple continual 8-bit transfer with automatic address increase but uses
> a byte-enable mechanism specifying 8-bit, 16-bit, or 32-bit access.  Its
> registers are also defined in 16-bit format because it shares a design
> with a MAC controller using 16-bit access.  As a result some common
> register accesses need to be re-arranged.  The 64-bit access used by
> other switches needs to be broken into 2 32-bit accesses.

> +	if (ksz_is_ksz8463(dev)) {
> +		int i;
> +
> +		for (i = 0; i < 2; i++)
> +			ret = regmap_read(ksz_regmap_32(dev), reg + i * 4,
> +					  &value[i]);
> +		*val = (u64)value[0] << 32 | value[1];
> +		return ret;
> +	}
>  	ret = regmap_bulk_read(ksz_regmap_32(dev), reg, value, 2);

This needs a bit more explanation. When i look at

https://elixir.bootlin.com/linux/v6.15.7/source/drivers/base/regmap/regmap.c#L3117

It appears to do something similar, looping over count doing
_regmap_read().

There is also:

https://elixir.bootlin.com/linux/v6.15.7/source/include/linux/regmap.h#L370

 * @use_single_read: If set, converts the bulk read operation into a series of
 *                   single read operations. This is useful for a device that
 *                   does not support  bulk read.
 * @use_single_write: If set, converts the bulk write operation into a series of
 *                    single write operations. This is useful for a device that
 *                    does not support bulk write.

It would be better if regmap_bulk_read() could be made to work, and
hide away the differences, which is what regmap is all about.

	Andrew

