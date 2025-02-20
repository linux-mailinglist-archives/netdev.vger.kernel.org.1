Return-Path: <netdev+bounces-168274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915F4A3E554
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94E916E450
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008EB2116F4;
	Thu, 20 Feb 2025 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dW5hEoZ8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55B1B423B;
	Thu, 20 Feb 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080915; cv=none; b=nhBbN5aHAh95OAkEXJQT8M8iew2rYKJnzr11gntuJ0J2041XylBqbTO9YyqzmIaQzFOkW9xddT0a570qdtlbmKhFIhq23voP2XBMi57JsCXjHJVAGA7Apyd5KImpl+OlWlC9okMEbA8jPBFCXt2XFsUV6+8lHXJC/vicNw8d9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080915; c=relaxed/simple;
	bh=9Z5IiRgn3rAUfFKHJpQdNYjmo3ET7IwblODyVXrH2V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTDirtCG8BCfinqeQbSahynGLMGimeOLsqABQ8H2cID/+IhS1UKs3++OuQuLxqC33USJzSlUMl07TYzmsGZAUl4CXDLioLXZ7xBf8M0zb3VOafi8dWuP/zGq3m0ZAv9mmemEUtVPxhNhEYR6WFEXYya4gL3F2OTFPZgLCdTo3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dW5hEoZ8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w5dqSQg35IUM3ZB7T2cJsN8BiirXXd0av1zXQl++BVM=; b=dW5hEoZ8Frg1vLPL3mIncsvgPa
	c+QhMlddH5dKUqgrNTzyCYT35hVRQSJMmqKUrKy/lHtPxitYVK4fYzFHzxLEO+mo2KhwWAT9C8JpU
	nsFq6rcWerk0egfeXH57GIMGh9xmOcmgAYEwGIBku4LuPBeZfGhvFAkz8DCAwcpEaMl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tlCWw-00G4LW-AU; Thu, 20 Feb 2025 20:48:18 +0100
Date: Thu, 20 Feb 2025 20:48:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: cadence: macb: Synchronize stats calculations
Message-ID: <32f5cc19-e4e6-4750-9942-e57126b0bad7@lunn.ch>
References: <20250218195036.37137-1-sean.anderson@linux.dev>
 <20250219094851.0419759f@2a02-8440-d103-5c0b-874f-3af8-c06f-cd89.rev.sfr.net>
 <451aca38-3b58-46c8-b6ce-6460f0504314@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451aca38-3b58-46c8-b6ce-6460f0504314@linux.dev>

> Yeah, looks like I missed this. Although I tested on a kernel with
> lockdep enabled, and I thought that was supposed to catch this sort of
> thing. Will send a v2.

It might be you need the sleep in atomic option, not lockdep. Better
still, just enable them all :-)

	Andrew

