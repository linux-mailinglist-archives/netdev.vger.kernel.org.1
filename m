Return-Path: <netdev+bounces-242749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D77C9482A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC0DF4E12FC
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C126738D;
	Sat, 29 Nov 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lgsbN2F3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F61221D9E
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764449488; cv=none; b=AY17anTQWxC8xeBrYzzgEz/GrJ/S57wZQpPTp2M7+Tz6HEyhgF3sDYFY8VB1/fiiKSmW41ApsrqCz4vDmOgUskOal2H8t4kfoolm9wT5Zay0Mclw65y70pUTwGF7zciFlFaNEfpxDLkp2/WWNGen3MWnGo5ug+Yxx8Xb74Yd9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764449488; c=relaxed/simple;
	bh=xY4aPqLpwgbuf/AMZeLiIzqxClwIj+ghLxHX3T3nByg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz0DrAzztJr6IyWOBqrCAB0EY2yVQQEozNPR0HVVcWHz4B7j8GEeqgF+CfYgIf6dFU4AsIrYZkk5p5F3iZT+N7p3PgahRh6KJw2OkDVWo7QBeirN1QOgw+r22AfHmG/7ckmzGZjweqfny5zCo46M7yi87UMFjrr1uNdJeb5CNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lgsbN2F3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bRhdrs5uaCyItxi/xAPTiqiDuqTQpmIP3O/Cjb7Q7jw=; b=lgsbN2F3bV5w5eTiqLWH8/U+Z0
	ZYZKYUJfG4CMLAJVG8l0HIxNJub3G2jZt9bmoeWvVijQNCH3POe063QtOUcGS5JjihR+1WcPn0Lmr
	cPu7XtVoSnMbqRTrAFfPA96YpbJuhTm9a3+waF3qIW3GD82862+ETD7EZH9r0WH358tM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPRuT-00FQWC-SC; Sat, 29 Nov 2025 21:51:13 +0100
Date: Sat, 29 Nov 2025 21:51:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: microchip_rds_ptp: improve HW
 ts config logic
Message-ID: <89c46c72-5d50-4a36-84b6-7af9ee4fdbdb@lunn.ch>
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
 <20251129195334.985464-4-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129195334.985464-4-vadim.fedorenko@linux.dev>

On Sat, Nov 29, 2025 at 07:53:33PM +0000, Vadim Fedorenko wrote:
> The driver stores new HW timestamping configuration values
> unconditionally and may create inconsistency with what is actually
> configured in case of error. Improve the logic to store new values only
> once everything is configured.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

