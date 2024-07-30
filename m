Return-Path: <netdev+bounces-114308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8F942188
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3861F23DFF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2018CC10;
	Tue, 30 Jul 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FLU1k+dI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640D1662F4;
	Tue, 30 Jul 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371041; cv=none; b=hpkU7b/ZO1sEBehAgeGmHONaPTlMcaBOT+C05A1PdISFAtLlNbvAx/qYUCr5YAsyDfzwlJPcrGmVScgqQ2C+/JqtseTLc12b2/HxQx03ATo+yhv71052tbqlcrz9mlSTqsK6RUJUfHyZQngEjPmHR7QiMH3WorI6r9myIIqCUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371041; c=relaxed/simple;
	bh=2Ups2xTMAM2kCDC2aUnjb9omZbMRlTnrQL5qUEAbdmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDibKx2BwXSKWgD2aLAnp8KqairIAdNuR0CwMKgrbhj6zV/50+yZSkRChDvpLa5lmIJZfXjxNB7ftvM9YlL0VuIro3AqlI3gtQyJ6EJI4/fShPBLvDcSNMhWREEk9aKRcNa4OURnpvDF4fGmmyXRQPTLvfAnlld5S3xA7vQuDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FLU1k+dI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HWZidt9t68N65uJ/uqBHzMVqeCeYG2ka20V5ZYtKlew=; b=FLU1k+dIAfb1x73uQfGgzi2MX9
	l97BMXyooDtHhNRCbU+L4Uheh5t3/ymsjOiqMxlpUigxQY2zw3/bjompee6WIx3RcJlgn0dn6d+9O
	kb2YUAWy1sFnVdD/QhfNodpSUdWu9E5JPYOvgrGCux4HIO++OrOUEo9MlSzrixsoELRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYtNt-003bwZ-2t; Tue, 30 Jul 2024 22:23:49 +0200
Date: Tue, 30 Jul 2024 22:23:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
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
Message-ID: <1be8ed70-8b29-4ccb-86b8-1233200317ec@lunn.ch>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
 <20240729210615.279952-7-paweldembicki@gmail.com>
 <56335a76-7f71-4c70-9c4b-b7494009fa63@lunn.ch>
 <CAJN1KkzJrMV8uDU+Z5xdLSd56uUwLtX+wo1w-8YbNgg-w8GiPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJN1KkzJrMV8uDU+Z5xdLSd56uUwLtX+wo1w-8YbNgg-w8GiPA@mail.gmail.com>

> Yes. It's configured in a completely different subblock. Internal and
> external mdio buses have symmetrical register set. It can be
> configured separately.

O.K. Great.

For the external block, there are well defined DT properties for the
bus speed, and suppressing the pre-amble. They should be used. For the
internal block, i don't see the need, you can hard coded them, they
either work, or they don't.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

