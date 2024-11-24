Return-Path: <netdev+bounces-147089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A19D785E
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA9B226BC
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA815575D;
	Sun, 24 Nov 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hBNQqfdc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E736C;
	Sun, 24 Nov 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732484414; cv=none; b=EAw4NTnH+Rk7+pkrzJrc3lr+ngeKdb6hp79ZatPz1pQ3BWRKIThjC3kcNyXHpJiS5PfpdP63JQBqoiOr4RsxIQrPNP8pcA1O4k4W6ALv1ghcheu8Cdyl2z1/WyQD12agQHH4++n0lSES+dY0C7R2QIjdzpnTBhGC8ALB6qj6G0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732484414; c=relaxed/simple;
	bh=j6hzJEyWM5vb7fJM17XLivRsnJy99gNTkiQmcCBjRpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF8jPF4+U3BmuaC5ND4DdmRpvucDdKbaqyQ436xbC99cQuZiA4T6gjIFuRGXXFy7sMb7/VKgPEpcRvKCvQoahMg0XKiC0FoWIsaXD+1TVda/z61mBm+11YEmY+YBzBMXXF7a8hok/LgQNZGC7v+DWB9TT+TdUmSiEUTMS7h3HdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hBNQqfdc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KaSiJRXS9OhBunsgyPg301R18jDt/UQe0bt1sbZ08hI=; b=hBNQqfdcM0JQGa3ZpQQl+R8xaT
	zCPqzD1v1K4FBUn1a3VzqcWTXlKXrgBqfa3GNFdAqRJR9Rsi50GmTl8iBv2+aKdYUE+Xh0GOChDzG
	ppwj6Y+qt6qmQVTIv6nj+I6xVNMGZfXzBBji8pBnp3AI/VPdgUC5YJcoIq1vcoeWMwfc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFKKj-00EJr5-1r; Sun, 24 Nov 2024 22:39:57 +0100
Date: Sun, 24 Nov 2024 22:39:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>
Cc: "olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"roopa@nvidia.com" <roopa@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bridge@lists.linux.dev" <bridge@lists.linux.dev>
Subject: Re: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
Message-ID: <0e80ace1-92f0-4b30-b7e2-af81cb9c84c3@lunn.ch>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>
 <e562704277f5d64a37ea67789b8e7d13d2cb12a4.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e562704277f5d64a37ea67789b8e7d13d2cb12a4.camel@alliedtelesis.co.nz>

> I have changed my implementation to use Andrew's suggestion of using a new attribute
> rather than messing with the port. But would this also be more appropriate if the
> notification was only triggered when receiving the event from hardware?

Hardware only accelerates what the Linux network stack already does in
software. You need something which makes sense for a pure software
setup.

	Andrew

