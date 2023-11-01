Return-Path: <netdev+bounces-45559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E177DE49E
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3113E1C20D49
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F814F7E;
	Wed,  1 Nov 2023 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R/gO4xfA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B614A91;
	Wed,  1 Nov 2023 16:32:47 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65141183;
	Wed,  1 Nov 2023 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b7ErS4udndynF6UaXLpgiQ7+PIYLOlNsuoCTupPOWmI=; b=R/gO4xfAVLAFORdwaOjVel2gQ1
	ldQeo1PiZoeo2VlEDgy7DjdnE8D5BLQW0SdGY+2IuHSyHkqMN3kAsK0IJ0JT23KY6+FPj7q5cC6zZ
	IbouZ6W1KsqlfLHw3Nn3gomjThRsjZNXpJUMjNLd6/bxCB1BA/t8v4R5g1Jsgrhwcgek=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyE8r-000hBV-OS; Wed, 01 Nov 2023 17:32:29 +0100
Date: Wed, 1 Nov 2023 17:32:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
Message-ID: <34a0b76e-aa0e-4148-ba01-c3b4608f17f7@lunn.ch>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
 <65427400.5d0a0220.41c58.0ded@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65427400.5d0a0220.41c58.0ded@mx.google.com>

> > > +	for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
> > > +		u32 word = 0;
> > > +
> > > +		memcpy(&word, data + pos, min(sizeof(u32), len - pos));
> > 
> > Rather than do a memcpy, use the get_unaligned_ macros. They might map
> > to a memcpy(), but some architectures can do unaligned accesses
> > without problems.
> > 
> 
> I don't think this is doable for this loop, think we would end up in
> some funny situation where for the last run we have to copy less than
> u32. (get_unaligned would always take u32 of data and that would end up
> reading more than requested) Am I wrong?

Does it happen in practice that the last chunk is not 4 bytes?  Since
this is firmware, its probably produced by some sort of linker, and
they often round segments to words. Could you take a look at the
firmware images you have access to and see if this is true?

It could be we do need to keep with the memcpy, but it would be nice
if we could limit it to words, at least until somebody has a firmware
which is not word aligned.

      Andrew

