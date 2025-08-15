Return-Path: <netdev+bounces-214217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51DCB288A7
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EF15C16D9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFEF2D0C6E;
	Fri, 15 Aug 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QmoArtYG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6752D0C6B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299585; cv=none; b=RytEqea1sJhQ13XnsD/X/JiXbdTMFChg90gQzOD1r+CO0P/n8BgwanGR+MrkX5wDuJjUj5PeYyJgC9in6jeYop6IjhHK7Osjbigg5LxLjq9ND+2fZ5tzu2P+2JRzpBj7l+JP0oAdPt+ZGzxPi8WBTN4Z4nYqlDv43C1zcZSCWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299585; c=relaxed/simple;
	bh=0I8Mk2ymD74zT48aexSjpXNwXSLQBn5yyGDnpuQ/ChU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDJbrT2LfkdUjHtJSj3FKdOXc7C68QH3HWua6IqlLV1l7flcUf8Ant43aeEf1XwVi5nwlj7lvjTjMh53/TDfjbzb86zW3uxMonWbXqq6iCSvBEDoH83iZ9wuhusu6RJ5yqb5h6k+cKJR2nohDWMLivoOtkK+KziiGLKmuxcxvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QmoArtYG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KK6TSRBzkphfL1Kw6GDkEnsoNQB8QYlSnEBOSO6NJXU=; b=QmoArtYG+fFufOOl+tdmgAeDOs
	Iz+2g44/nCmq22GXkEcmtPe2wL3yC8ERXf4ArlXjFqJd8aCRTUGeALy8xrjjwe3k+kmknLnPryIgX
	3h1sOWsQbltiFSqyzdeTpZBTCuc/rReO0dGY/aNlc3IMvhy5ETmKf7UxIPxRKHKVtAP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un3bU-004s1c-FM; Sat, 16 Aug 2025 01:12:56 +0200
Date: Sat, 16 Aug 2025 01:12:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: ks8995: Add proper RESET delay
Message-ID: <6106f356-0849-48b7-91b7-b3eaf0b8c6d9@lunn.ch>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
 <20250813-ks8995-to-dsa-v1-2-75c359ede3a5@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-ks8995-to-dsa-v1-2-75c359ede3a5@linaro.org>

On Wed, Aug 13, 2025 at 11:43:04PM +0200, Linus Walleij wrote:
> According to the datasheet we need to wait 100us before accessing
> any registers in the KS8995 after a reset de-assertion.
> 
> Add this delay, if and only if we obtained a GPIO descriptor,
> otherwise it is just a pointless delay.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

