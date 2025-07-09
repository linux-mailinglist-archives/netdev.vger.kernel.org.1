Return-Path: <netdev+bounces-205415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5AAFE974
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7834C1C45A04
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CC2D9ED8;
	Wed,  9 Jul 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="usp4w+Hp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2122DFB6;
	Wed,  9 Jul 2025 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065687; cv=none; b=X4w2+eUR62MqTuWP2VOV++fuu8ZTeM5/CKjU39cSxym+v4dEhd0MyaAqn58hxYNu2mnVvWZ7nsS+ZfkJvrMi7CtUgVfjMjQSjA3Sn40Kx8hIw57UmqhcklKh7KgvJ1OsXFidNBNgYS9uG+2mKmxIOsDJhIcs61cVupiczu164I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065687; c=relaxed/simple;
	bh=jw5S7T1dSAVfDkZJEEU5PzR03kKw+4t/3mo+s+VSXyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE40UGaECRTLLdPMLSij4kDkd44fy3KDliPPKLitV95eXcbxyvAECVI2Gw9Y+D6gcTMv4Us9Z108qoXDUDqn5JUP5oJb5+ycHP9TIYogPJxlEwXStGQlJ33IQxJch7ntddbgCQPkcTrdLeXnhUOlh+mbpENtBGILwbegaLQcgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=usp4w+Hp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=t79h60EOE9SVzV/lSAFUANryOijd3ceSpP+xl2sr/zo=; b=us
	p4w+HpkHUACw9jAJA+G2O9+nD3UMKn8yluu61YrP7Maq0gfFET9IcIIAaaGtzzYe4xWKa8EI4eA26
	+tOH+Dmcj1nQ5UFzZA763YXpz5Zld1dO+GjmqqbkH1KTPpSy6wACvmOJQ/lr2jWKgopP5uUgJQp4d
	y5zbOerb4VCgeBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZUJX-000wOt-Ak; Wed, 09 Jul 2025 14:54:19 +0200
Date: Wed, 9 Jul 2025 14:54:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: lizhe <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] net: stmmac: Support gpio high-level reset for
 devices requiring it
Message-ID: <30933244-bfc0-4f6c-9dec-0db4bb33ba58@lunn.ch>
References: <20250708165044.3923-1-sensor1010@163.com>
 <52b71fe7-d10a-4680-9549-ca55fd2e2864@lunn.ch>
 <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>

On Wed, Jul 09, 2025 at 09:57:50AM +0800, lizhe wrote:
> Hi， Andrew
> 
> Thx,
> 
> 
> i conducted an experiment, and no matter whether i configured it as 
> 
> GPIO_ACTIVE_LOW or GPIO_ACTIVE_HIGH in the dts, the resulting
> 
> GPIO pin state was 0, indicating a low level.

You need to keep digging and understand why.

Scatter some printk() in the gpio core code. Does it recognise the
option in DT? Is GPIO_ACTIVE_LOW, FLAG_ACTIVE_LOW being set?

Put some prints into the actual GPIO driver, what is passed to it.

There is something interesting in gpio.txt:

Most controllers are specifying a generic flag bitfield in the last cell, so
for these, use the macros defined in
include/dt-bindings/gpio/gpio.h whenever possible:

It says 'Most'. Is the GPIO controller you are using not actually
doing this?

	Andrew

