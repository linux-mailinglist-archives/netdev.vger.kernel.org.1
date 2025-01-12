Return-Path: <netdev+bounces-157552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4045A0AB34
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6F67A2A6B
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406521BEF8C;
	Sun, 12 Jan 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ijUtO+T4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506A1BEF77
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736701917; cv=none; b=YJy44qKqvi/PIY/ZZPrWWpcexgpt5u0GDf9HFzTCLw1bjnKz90UlA7SyVOsoMy3JRoTy1o+2n5D4wKBfkHJuoOXqm7JlgELnhuIKem+aQgTQNRc8XBQk7EhWCU2UZyIdEW0siV8tUMlWhbVWmAs6+qb1pGZWt4xw5pUeQ5rMiBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736701917; c=relaxed/simple;
	bh=lMrOKcentY9FQHIecxEaV1jaTdHL3e0LR3bVvhJSCTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ6o8NxYEOPFBdmnjVKta1v5FMOp6T9ljNxWsT0SB422YjoNm4V8mnAcOHIgMmX9fTCF0kIslbN9+d/+mJLbon1kLkr9KccnW/JOg/0hkdrY2DP5/jSit/sAA74R544a3FmXdO5yS1b7IdhBtTtZFNET9w64G6oxWoXvBc+VBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ijUtO+T4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NEhm2Wllnh7Un2cPHuAMPY2D5ytQg6dwmrlCFGe+Xm8=; b=ijUtO+T4tz2ALgh21GurPg9CK/
	Rw6+oz8Hn4hwmr53WJI14eM2pJTf5XVJ4qULa88tBWXGSAafVkZS2wEVXkt+UTgNAFiQiK5eqF3Bm
	MWmRr7GeeEfS3NhdKoWw/DFYBWIlmTfxU5BBamcNoAXR4c5nS0WPIhct9Hw+/JjqCB2o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tX0zd-003pvN-3g; Sun, 12 Jan 2025 17:39:17 +0100
Date: Sun, 12 Jan 2025 17:39:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
Message-ID: <40b5b96e-ca48-4865-b0db-0cd33a9cbc74@lunn.ch>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
 <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>
 <0834047d-5eee-4d27-99c3-5f92460f78c3@lunn.ch>
 <10b72540-3642-4811-8691-9fbcc72d513d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b72540-3642-4811-8691-9fbcc72d513d@gmail.com>

> In my case, if HWMON=n, I want REALTEK_PHY_HWMON to be n, because
> then I omit building realtek_hwmon.c (see Makefile).

Thanks for the explanation.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

