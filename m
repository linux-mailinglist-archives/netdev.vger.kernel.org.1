Return-Path: <netdev+bounces-178231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE4A75D0B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 00:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCDA16764F
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFC1C5D7B;
	Sun, 30 Mar 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qngwqqaa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4863FE4;
	Sun, 30 Mar 2025 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743372105; cv=none; b=lok9/LwCChvpgrA4HQ0nPr4nXMCjzZPj4yAqucUPg/AbU+Ea1KtLbgrYsjv5tyhcxLSkmGFUZ/Cr6yyns6x/3LTRHFQNeXy4wwtnURdcl15wVWTTMtyTzSQ6DhuGw/YU9eYxX8uH6vesZmDLc56Q3bG6sGHlPYfjmJkb3rdGkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743372105; c=relaxed/simple;
	bh=Tkszc10LvC0X2gbLARjsGrXZv7vlFk8/4HEG3JZn8mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGSDFB+lPfc9i5DrUJ6pnenmnhoApsbhv+1df+Nyrv1atUbB8bPoQXYE5iw9bVvwQp32BsQMZX7W99K5gK0/eaN0uMSpQt8Ibcy9/95Fm9UF9yIZGN08a2/Yp1Bl41TyRIx+AxzfJCnZ34H0mfX2t5ZOr6or87IBF4W+P4K5ghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qngwqqaa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kwMfUz4DFsWidBocR7kOt39zwWI/U4VW18DMFO9dYPI=; b=qngwqqaaexO6eKBiK3FhtSkgdL
	MSs+nzF88N5K+EnT0ayn42AcEt1Tzd/rNS0zSettN7iHSvSTi0GDIgh/3ttm0X1eKnUb4BifKp7Kq
	Gq8FPlSLKGduevzveO93LqEZAsb+UOabQlZ62bvZcUYAh+P2QGohtxJ/5jZNFbWqPAeQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tz0iW-007XLD-KA; Mon, 31 Mar 2025 00:01:20 +0200
Date: Mon, 31 Mar 2025 00:01:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <022e19f5-9a9c-42eb-9358-a6fe832e8f5f@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
 <20250328133544.4149716-5-lukma@denx.de>
 <3648e94f-93e6-4fb0-a432-f834fe755ee3@lunn.ch>
 <20250330222041.10fb8d3d@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330222041.10fb8d3d@wsk>

> > > +	/* Prevent a state halted on mii error */
> > > +	if (fep->mii_timeout && phy_dev->state == PHY_HALTED) {
> > > +		phy_dev->state = PHY_UP;
> > > +		goto spin_unlock;
> > > +	}  
> > 
> > A MAC driver should not be playing around with the internal state of
> > phylib.
> 
> Ok, I've replaced it with PHY API calls (phy_start() and
> phy_is_started()).

phy_start() and phy_stop() should be used in pairs. It is not good to
call start more often than stop.

What exactly is going on here? Why would there be MII errors?

	Andrew

