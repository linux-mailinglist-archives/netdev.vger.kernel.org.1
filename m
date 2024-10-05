Return-Path: <netdev+bounces-132402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D2991866
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EF0B20D4F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B3155A4E;
	Sat,  5 Oct 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eAf/XK4J"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46379145348;
	Sat,  5 Oct 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146776; cv=none; b=Vmyz21o5xwQpKOUxE5oUIKfc2KiHEcsGlD/Dn8YXm7i/7H81QhtZ13AfQgk+RcrRC1WKEBaEbE0WcyItW565lTRQzbioRCbox+ta78LXcE2g/fI95RtsBEwFADRKtsWlD3+AHdi1jUQjdLDaU65yLN9XT2MMR+Hs4XFdsKLnhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146776; c=relaxed/simple;
	bh=J5bIcUXk5Tx9FMibX3+isSwplXbQ9A3yNh28Nt7J04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJgqVJ1YB7X/Pbif4vW2UC0PMmyymKmBJ+fgZTZ14cRv4JmfEFamLQpbpDwM8OcLq2ToIKirgj4c7vYNPGbHeodicNC+29E64kiyI65JHai42kQjIuCdg1yU7dqLACRDP2BkqAn1aqS9rSc8Snf0H9uSR4okJtBaEfvOEDxmcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eAf/XK4J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G2PtA0ODQfYz3zk5h9vXa5+yFYD1rsD760vf/5W7V+I=; b=eAf/XK4JD8KFHIkiMvQ0AWVfMt
	cvcAEn6V4u1JrCiYhNS5z85MbDnjiPxKamP74aVXs3IxrjDgLUdYiN9CgTTGbrw7BJ2iCQpXGcThP
	RCzlLGY6Iz/pSOP3NMSbXbz0QXKbuVqdLpM6IAQea9pjNMafyy6EJ2xM9srBYyqJA3d8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx7uu-0098ut-VY; Sat, 05 Oct 2024 18:46:04 +0200
Date: Sat, 5 Oct 2024 18:46:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: disable eee due to errata on various KSZ
 switches
Message-ID: <a9467e93-3b35-4136-a756-2c0de2550500@lunn.ch>
References: <20241004213235.3353398-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004213235.3353398-1-tharvey@gateworks.com>

On Fri, Oct 04, 2024 at 02:32:35PM -0700, Tim Harvey wrote:
> The well-known errata regarding EEE not being functional on various KSZ
> switches has been refactored a few times. Recently the refactoring has
> excluded several switches that the errata should also apply to.

Does the commit message say why?

Does this need a Fixes: tag?

	Andrew

