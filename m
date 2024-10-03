Return-Path: <netdev+bounces-131813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3218F98FA18
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48AC285498
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4821CEEA0;
	Thu,  3 Oct 2024 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cCRxfGt/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7D1CCEDC;
	Thu,  3 Oct 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995906; cv=none; b=HlhlidM1lSvnLAHLMSHaO7HyzkacI28LP2b3YYyeffy5yX+UTgk419wIm8oZGBxINPRnNp/Rd4G6HPhGEum2EQpzUb9mvwpF8Xxe9wRGL9fFUaLP9+HkVVSSra8yzVr4nFgwguxBzqpOkw7d1p2STXCY9cWuE467CtwGzhMxoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995906; c=relaxed/simple;
	bh=KvvJWaRhw8gHj+kyeV14WkUn6sy7X59pJwjpgbCt32E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am0F+pomXRietVVNltJuDoS/DyoMZKbMyakjgK1SITSgu61uEnCF8SXMiPhZPoDqeuNJh1AtAjuE0czW/LxMXFFg1AHSbJxpzuOiYiIS5dN74yFqker58250G32Df2ng4UVPADqbT6uDOVeFnQAkmd4auRszzmsTUb9uXM8BiQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cCRxfGt/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iS27mmN6sFMeUGEoqsAoSMETbWES7EFCfAXrJS+nCJM=; b=cCRxfGt/wn7ZxWKRpe58K6TOr9
	Gg2wvGB41zz8DyuBshKOjrBQtR/lr75TUy3PF+6Sxoohux/kmhyH8l/KdoD2CxO16sUPkIIwXGs6+
	pQAiAu74amFQfNPt4ewHliotv/07ILSg1vIiVyhceyvHggAFTDkt+U7WnCYTUBFlqws8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swUfU-008zOz-OD; Fri, 04 Oct 2024 00:51:32 +0200
Date: Fri, 4 Oct 2024 00:51:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: Validate PHY LED OPs presence before
 registering
Message-ID: <f275660f-79cb-4044-8f02-c4341bdad6e5@lunn.ch>
References: <20241003221250.5502-1-ansuelsmth@gmail.com>
 <20241003222400.q46szutlnxivzrup@skbuf>
 <66ff1bb3.7b0a0220.135f57.013e@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ff1bb3.7b0a0220.135f57.013e@mx.google.com>

On Fri, Oct 04, 2024 at 12:33:17AM +0200, Christian Marangi wrote:
> On Fri, Oct 04, 2024 at 01:24:00AM +0300, Vladimir Oltean wrote:
> > On Fri, Oct 04, 2024 at 12:12:48AM +0200, Christian Marangi wrote:
> > > Validate PHY LED OPs presence before registering and parsing them.
> > > Defining LED nodes for a PHY driver that actually doesn't supports them
> > > is wrong and should be reported.
> > 
> > What about the case where a PHY driver gets LED support in the future?
> > Shouldn't the current kernel driver work with future device trees which
> > define LEDs, and just ignore that node, rather than fail to probe?
> 
> Well this just skip leds node parse and return 0, so no fail to probe.
> This just adds an error. Maybe I should use warn instead?

Yes, a phydev_warn() would be better.

	Andrew

