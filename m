Return-Path: <netdev+bounces-215253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EBB2DCBC
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AE6A04DF3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A99931DD90;
	Wed, 20 Aug 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="29mEMJaD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71331DD87;
	Wed, 20 Aug 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693304; cv=none; b=WDbWYGY3KixRUZAoaE1C3le8LJbMphcA5+/j8ouYWqEXRdnvYWASBfvwF2JvD15gZ8KOqmpRKRPljpvpppxb1eHo5llxxylN4uFdvSAnRzm/htWawfbz8dktGh7lcWjP7TC0IwXjDSw9JnYk2GRQrusc/Rtth8miaVTCkQlsRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693304; c=relaxed/simple;
	bh=Zn7qDGN0cVFcuhXJH9Nc+kXCraZw6xDo1+dWrtEMk5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THglzI0lR7ugbCWhzSxduzaYVz1sonv9M8KM9Un08VDpj00ZvJmCwdrRB41DZjRDKb4vrWtY/igIJ3RAT4jp4nGaB3gmLxEdjUTkEpul2w3ap9Nb4/TOjbUiaJ7VnU+SL8ay8jAPSockLOQ9gbgvb1T7+PlDD3cjNX9R9/TOA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=29mEMJaD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NnAE6VlJTZ+53nEl6+N5XyUHIn+iGaNZTKyvfFSKOCE=; b=29mEMJaDU5YJnzOHMT4zZ5uHRV
	8TdWJjCsBR4pPzO5GpAlTKU5IrGHXpmfPDf8fQLqinoVvK0UxjXJeVCnUx84GOFtmfVsefy+vQNz7
	Bx2SIm8oBF6ZcAP2AnJtXzMqmbLtIF/QVPfHjqHgV+2+PWr87IUTkUR72nvbIunkinLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoi1g-005JuK-Bg; Wed, 20 Aug 2025 14:34:48 +0200
Date: Wed, 20 Aug 2025 14:34:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: mxl-86110: add basic support
 for led_brightness_set op
Message-ID: <73c364ee-2712-4b95-a05b-886c3e4c4e15@lunn.ch>
References: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>

> +# define MXL86110_COM_EXT_LED_GEN_CFG_LFM(x)		({ typeof(x) _x = (x); \
> +							  GENMASK(1 + (3 * (_x)), \
> +								 3 * (_x)); })

> +static int mxl86110_led_brightness_set(struct phy_device *phydev,
> +				       u8 index, enum led_brightness value)
> +{
> +	u16 mask, set;
> +	int ret;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	/* force manual control */
> +	set = MXL86110_COM_EXT_LED_GEN_CFG_LFE(index);
> +	/* clear previous force mode */
> +	mask = MXL86110_COM_EXT_LED_GEN_CFG_LFM(index);
> +
> +	/* force LED to be permanently on */
> +	if (value != LED_OFF)
> +		set |= MXL86110_COM_EXT_LED_GEN_CFG_LFME(index);

That is particularly complex. We know index is a u8, so why not
GENMASK_U8(1 + 3 * index, 3 * index)? But set is a u16, so
GENMASK_U16() would also be valid.

	Andrew

