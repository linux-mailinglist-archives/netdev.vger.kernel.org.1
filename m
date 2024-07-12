Return-Path: <netdev+bounces-111096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2B92FD66
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8289F1C228AB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF41171E47;
	Fri, 12 Jul 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GPuOOp5z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D317107F;
	Fri, 12 Jul 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797630; cv=none; b=admOfr5tEzyMjXLst/jsvLESnaCo95SXjLu4hqB44NW25Qa+BIq3xwz/Uxm2ICSKDQ36euS4Jhq1FxaHhoph7EHp5+ZsgEctt+oMJf/8zc2c+OHWwtBZWjUG22LxjSCkns+81yPszUfVLjgWvnWcNj3ySIgkjuoAxBx38Kznmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797630; c=relaxed/simple;
	bh=7uKOgDp7TAdj58LAb9mS2Yvc9w/hBsmlsfwEPcUWUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWDRS23M0LQpBQh45g+qVIrZMnLGedHBU9+k0aiJiikq6LMQCOCBitaqTFTQqvJaKdfGQL/M1VuJmiztY5jqQown+W6/iP47fBeXPrJH4aLavMzSHqayNr1DcSyjB7tEBAOtOR5kzW/RAMSVR2JgM7YAkxdUWqReVi5QFEtUWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GPuOOp5z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gqKXjyZVYfRhKhuyUliBeWu5ezOtZdik8oAcq3I5nyc=; b=GPuOOp5zvgEPeHTqvHY0JriRps
	2B5+pYtt44kVLPkQulGoAj/Y0XYx+9uP5TJztyYxbC7a63onCKr4ZIt0KMR1fVogSZkG25Hjw4EvI
	4HwU5ZFvONDTQkyw5a0FPc1E74o22HuUsWlLLn966SUnWqDw/ewSZAFO4WQVBR7nggb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSI46-002Pku-MD; Fri, 12 Jul 2024 17:20:06 +0200
Date: Fri, 12 Jul 2024 17:20:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83td510: add cable testing
 support
Message-ID: <3e1103cf-6023-475d-9532-2e5840ed14f8@lunn.ch>
References: <20240708140542.2424824-1-o.rempel@pengutronix.de>
 <a14ae101-d492-45a0-90fe-683e2f43fa3e@lunn.ch>
 <ZpE_WwtSSdxGyWtC@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpE_WwtSSdxGyWtC@pengutronix.de>

> > > +#define DP83TD510E_TDR_CFG2			0x301
> > > +#define DP83TD510E_TDR_END_TAP_INDEX_1		GENMASK(14, 8)
> > > +#define DP83TD510E_TDR_END_TAP_INDEX_1_DEF	36
> > > +#define DP83TD510E_TDR_START_TAP_INDEX_1	GENMASK(6, 0)
> > > +#define DP83TD510E_TDR_START_TAP_INDEX_1_DEF	3
> > 
> > Does this correspond the minimum and maximum distance it will test?
> > Is this 3m to 36m?
> 
> No. At least, i can't confirm it with tests.
> 
> If I see it correctly, this PHY is using SSTDR instead of usual TDR.
> Instead of pulses it will send modulated transmission with default
> length of 16ms
> 
> I tried my best google foo, but was not able to find anything
> understandable about "Start/End tap index for echo coeff sweep for segment 1"
> im context of SSTDR. If anyone know more about this, please tell me :)

I was just curious. Does not really matter with respect to getting the
patch applied.

      Andrew

