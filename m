Return-Path: <netdev+bounces-113857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D282894018B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE18B21350
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F3F18A940;
	Mon, 29 Jul 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2y9CtY/R"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB63D9E;
	Mon, 29 Jul 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294663; cv=none; b=WIZunGgnel69x91cM+1GG9oDgYgd1NudNMZGcw8MFp0EhShZ+S7ktNc27wCrB79hrEKL27D+Gjr3G1BeEXQtTRBj9HsdFeUHZ4u1I2lDlFW/SxFSyWfQOY3H7VsGv/gN0iHTfh91KtlCCJQhqooNPaX5szNuWhfnUBo41u8Tuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294663; c=relaxed/simple;
	bh=+KALGAYHWeDChsBu5x2X0e2rHdT9D4cUAoPmGHqeols=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG+spSQWXiCWTXO+iRYlvA0UFaTrQXhGVO6l9izPNYerM9cuqokU551/Zdw+x21O4lM4BtDHiURPMZ9f5/Xt/tyLl83l2gcF9oX5po0QvKl6NGQSfH/LhXzRlPMp6yj+Is9D4TzsllOycga4uXhEUJLi0xwZshRNLfTgpT6UIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2y9CtY/R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X8MrpDDV2qv6M49EbVatv4sbsj1Myyz/1ZHmypRWkRM=; b=2y9CtY/RZihdz5aJlH2OPy0+m/
	OuOCQG5JUJkGYm6ApMEDUFWaRnvaH3VpMmegbwtuYWS97wodLMBlmvy+9Up4i4jNLdcCQdiSxA7CV
	A4KS4pc6dSn9la8lftHnzojoO4q/6nL5L57vKVB+/K+8cyhlCl417L7No4/KTbaDEcIM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYZW3-003W4g-Ae; Tue, 30 Jul 2024 01:10:55 +0200
Date: Tue, 30 Jul 2024 01:10:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] net: dsa: vsc73xx: speed up mdio bus to max
 allowed value
Message-ID: <56335a76-7f71-4c70-9c4b-b7494009fa63@lunn.ch>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
 <20240729210615.279952-7-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729210615.279952-7-paweldembicki@gmail.com>

On Mon, Jul 29, 2024 at 11:06:12PM +0200, Pawel Dembicki wrote:
> According the datasheet, vsc73xx family max internal mdio bus speed is
> 20MHz. It also allow to disable preamble.
> 
> This commit sets mdio clock prescaler to minimal value and crop preamble
> to speed up mdio operations.

Just checking...

This has no effect on the external MDIO bus, correct. It has its own
set of registers for the divider and to crop the preamble.

    Andrew

