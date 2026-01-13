Return-Path: <netdev+bounces-249454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28772D194A3
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9760630118F7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568E3933E3;
	Tue, 13 Jan 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="icIkQpDU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1472392C5B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313117; cv=none; b=BpDz+k1R0ZOIGqaZp7t3fKF20gHzt6lJp0Pz24QKHDdJqeGdQMdXyUh/s5oFwpksXy1E2ucC4DGpy2cnHnmrT6YoeRnWOq7k/n/rHjZNGQIu64o6al0YdOglKZxHIkZizNGL1qDWap2zkcD95ctczjqKpbazr4Bi5+5Ow/Ppb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313117; c=relaxed/simple;
	bh=8/sOBd+1YrLPJE5npHPXqw2HyqHJ5W48330FYqFzL2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSkwepXzj5Hk6Z73NyLzY6ajDqpqY/Irlw5k49Ixe1QG8x1btM/vxHOxM9bGrTZgm4omsLXHvhZqQJmX0QmEy2MwO//fTmXP8gSUMEN00jZs1Hu5BMiU1zdArL6NFQiB26n0Z1SvLKiWmFRZm3bz0fcXq2dMJhQyQyBqk5acZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=icIkQpDU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3b67iZ9CiqCH20NvQLTsQVqLE9T86R59H9dxNQXhdGo=; b=icIkQpDUuhl5TjkwARxisWAJVI
	WOKDYbDCQpVhO9gkcXY3OPqjyEEZZCoQ2mVPstGsTXSYaZI3H/y8A3AXMGG9lKwcYIXCppiK70HGM
	S/HM9h5l8mnMHOV8lIc+xeAk2rjT2028Sq88MJ+93gGtq5It40B+P6x0IJdCzd0aRTR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vff18-002dcl-Q5; Tue, 13 Jan 2026 15:05:06 +0100
Date: Tue, 13 Jan 2026 15:05:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] mdio: Make use of bus callbacks
Message-ID: <5ca319af-46c1-4c3c-af50-c804a8ba2a8d@lunn.ch>
References: <20260113102636.3822825-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113102636.3822825-2-u.kleine-koenig@baylibre.com>

> Hello,
> 
> it seems I misunderstood when net-next opens, I thought this happens
> "automatically" after an -rc1

Normally yes, although it is a manual operation, Jakub sends an email
saying it is open. However, this time, there was a poll of
Maintainers, and it was decided to keep it closed until January due to
the holidays and not having Maintainer bandwidth to process patches.

	Andrew

