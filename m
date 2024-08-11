Return-Path: <netdev+bounces-117534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A094E32C
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3A9B20B07
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251E1547E1;
	Sun, 11 Aug 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wJZG8ZQv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8C79F4;
	Sun, 11 Aug 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409971; cv=none; b=EU3lF+MKQjDk55nKZ3cZcyThIVPQh/R3S8mAReH72351KH5lGbWKPrrb7K/zoDoEF21Cl0xz4Je7dKTyrPvThAiZ4QMeKQW3qLvOFZcd6gTjB2a/fOdrYHa5FilujOv8+JVfQsXC6hqZ1gKYkkjFAefnZxLTKAKW3t6kjS7U8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409971; c=relaxed/simple;
	bh=sfwU2UFIJdjH1CnBaOrSYQIvxbfGiL2gGLNqxqTag40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=somVeAeguYuBlMGKeVSPaNdT+X6iw4+uRQbE53i9jjfpqlZQGsakwsYz0S1awPpwWZn3zKOU7xIUNc9pXwbeyRLYhXnq9XHE6hv39Mhexuv/YIvIE18IS4kpfyNECRirnJ2bU9rsj2YkUjktpbnf9tlbTFuPRgOv/avDjkc81/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wJZG8ZQv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tetulHRx1+SiKaVY4y0TSkhRbm+G3mEZPmNc10p7ZY4=; b=wJZG8ZQvMX0/OpsptrcS2Lj3RY
	I7DDb0cGWhTyYd63wQg86Y9H6/CevEfNI482WMjzrU5rkrB+Cod0eJWJy5ecyVp4pENwr9W887o0f
	lw4st7tfWHS7wmqSUY+eGjiEFYJuV1w/gq9khQeJ0TsEeubYawz33O627w6l2YyGENq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdFeo-004WMd-NP; Sun, 11 Aug 2024 22:59:18 +0200
Date: Sun, 11 Aug 2024 22:59:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC v2] net: dsa: mv88e6xxx: Support LED control
Message-ID: <7e874408-d125-4002-9ce3-ec2653fb6c46@lunn.ch>
References: <20240810-mv88e6xxx-leds-v2-1-7417d5336686@linaro.org>
 <07b19b43-e8db-45c8-9b7f-1372753e6865@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b19b43-e8db-45c8-9b7f-1372753e6865@lunn.ch>

> You could also add a 
> mv88e6xxx_port_led_read(chip, port, *reg)
> {
> 	int err;
> 
> 	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_LED_CONTROL, reg);
> 	*reg &= 0x3ff;
> 
> 	return err;

Actually, this wrong. You first need to write the register pointer
number you want to read:

 	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_LED_CONTROL, ptr);
	if (err)
	   return err;

and then do a read, and mask the only the lower 10 bits, where the
register value will be:

 	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_LED_CONTROL, val);
 	*val &= 0x3ff;
 
 	return err;

	Andrew

