Return-Path: <netdev+bounces-204295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7CAF9F1E
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E071C47D24
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCE27A930;
	Sat,  5 Jul 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q3+NU44/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A670813;
	Sat,  5 Jul 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751703831; cv=none; b=ichWJrssSjCqdxXBX5ZbWpVtqUsOf94KSodFoawqVGfVbpiYYNdXtN64i8m+P+Q6AbQ1FQMyYfPPhy6VIOub8ssbVSe02pWi6xYUE4+wxvI1KnKMQmbeGaJ41wsiHZsSh7FOwnftCvXUNC5NBW4Eu7tX2oHcqOFB7tZSjJd4Pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751703831; c=relaxed/simple;
	bh=ooE5fM4XyflQS909ENk/p7WI6Na5G0eS4a5NyH9gXCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaCfP/qajSgaaBq6v24EDYlLJ9xsO9ia7IcpUbsNqoJfZPreEULKTaTvqYRh84MPPiwu2DaQ3H2fLbyZh6uIZ7PjmtAB0b/9z76JZHonE+9qhsEE04qzOlitfSBZQYbYhh0fDS+YIEiIZgYBDnADBapz1QLXdUAVbZ4DgMmNpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q3+NU44/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xNWnDiVe43oAC4aWbLN7TJ3894ISYCh7qPYCBILP4oM=; b=Q3+NU44/QcBZJ1YBSEOaNKsDVi
	Iz79r9aCFH+H/yIIBueqCSmLy36lHn7A1EnLdLQx6Vga/yNYK0Q70iLa04bXMaz0zDSgS4G+dFSAm
	UZMcHHSqTzN9192HjrgyttF+5k9Jy/UOsTY6MuGQ0wUBjj2vY+0MHyVCd4Wh7ncBHPcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXyB9-000NRq-M8; Sat, 05 Jul 2025 10:23:23 +0200
Date: Sat, 5 Jul 2025 10:23:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add KSZ8463 switch
 support to KSZ DSA driver
Message-ID: <eeb48306-0564-46da-ae74-a9f779242399@lunn.ch>
References: <20250703020155.10331-1-Tristram.Ha@microchip.com>
 <20250703020155.10331-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703020155.10331-3-Tristram.Ha@microchip.com>

On Wed, Jul 02, 2025 at 07:01:55PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 switch is a 3-port switch based from KSZ8863.  Its major
> difference from other KSZ SPI switches is its register access is not a
> simple continual 8-bit transfer with automatic address increase but uses
> a byte-enable mechanism specifying 8-bit, 16-bit, or 32-bit access.  Its
> registers are also defined in 16-bit format because it shares a design
> with a MAC controller using 16-bit access.  As a result some common
> register accesses need to be re-arranged.  The 64-bit access used by
> other switches needs to be broken into 2 32-bit accesses.

This is a rather large patch, making it hard to review. Please could
you break it up into smaller patches, with good commit messages.

>  static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
>  {
> -	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
> +	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, addr), bits,
> +			   set ? bits : 0);
>  }

This pattern of using reg8() appears a few times. That could be one
patch.

>  
>  static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
>  			 bool set)
>  {
> -	regmap_update_bits(ksz_regmap_8(dev), PORT_CTRL_ADDR(port, offset),
> +	regmap_update_bits(ksz_regmap_8(dev),
> +			   reg8(dev, dev->dev_ops->get_port_addr(port, offset)),
>  			   bits, set ? bits : 0);

Adding this helper and using it could be a patch.


> -	if (ksz_is_ksz88x3(dev))
> +	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
>  		return -ENOTSUPP;

All these ENOTSUPP could be a patch.

etc.


    Andrew

---
pw-bot: cr

