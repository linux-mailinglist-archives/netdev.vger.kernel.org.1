Return-Path: <netdev+bounces-146058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F69D1DA4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F891F223E6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894B86252;
	Tue, 19 Nov 2024 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qokv2DXP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652942E3EB;
	Tue, 19 Nov 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981150; cv=none; b=OZWrbYX8/6WMASRVU9LVSCbvQLN8mjFMos8JjaK0ge0rt0PzVoR0T8Eb7To0oJDlCTC1iij7t8pEeXlIWGaUvaE/DEO/Y+VvecXlC5n+yjnuq8XnpoPRYqpfi1Af1LkBO/7sJ0n1/HWzUF4tavw0rsNvvU9mMk2M9vHQoiR9jGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981150; c=relaxed/simple;
	bh=0ae1K5p4ElQdh94m5eUWpua2D8G6Ytdrfz3mhxapIE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACHYkLTbtZgXDeEkZq2uy/s1UIR1sgnRafrTnQEpUjAqw7m29xsBmCrVfn4bkvNdfhPRG+nQA/36pLkm6OVJCyTNTRZm7mzsZEWwcW5GKUSMt7o3TOsn5xOfbeLNrtPK8O6C49DostgTLP0vcf/Uvhi0AtzYP3X6EQlo/pvGFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qokv2DXP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=SxM76o8BGy53AtlOJoitl7JV8kJz7mesTX75V2BZ4D4=; b=qo
	kv2DXPF5NrFtTmXJuEOhpovQLZUIAGFuSld5TeLwIPl4mLkHcAF1mYH216IVlMWFOR4wCy9/us05n
	wPB7GLUOqbaKO12CCPHEKGt2dCOpkA+ildcppazSaUoNRItAVq6uDUkenkPYF6Km+XGmoh7xYVLE4
	Nwvweckmq3fDjYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDDPX-00DjZv-5j; Tue, 19 Nov 2024 02:52:11 +0100
Date: Tue, 19 Nov 2024 02:52:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 3/3] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <b8986779-27eb-4b60-b180-24d84ca9a501@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
 <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>

On Tue, Nov 19, 2024 at 09:35:39AM +1030, Andrew Jeffery wrote:
> Hi Jacky,
> 
> On Mon, 2024-11-18 at 18:47 +0800, Jacky Chou wrote:
> > Add a dummy read to ensure triggering mdio controller before starting
> > polling the status of mdio controller.
> > 
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > ---
> >  drivers/net/mdio/mdio-aspeed.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-
> > aspeed.c
> > index 4d5a115baf85..feae30bc3e78 100644
> > --- a/drivers/net/mdio/mdio-aspeed.c
> > +++ b/drivers/net/mdio/mdio-aspeed.c
> > @@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8
> > st, u8 op, u8 phyad, u8 regad,
> >                 | FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
> >  
> >         iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> > +       /* Add dummy read to ensure triggering mdio controller */
> > +       (void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
> 
> Why do this when the same register is immediately read by
> readl_poll_timeout() below?
> 
> If there is a reason, I'd like some more explanation in the comment
> you've added, discussing the details of the problem it's solving when
> taking into account the readl_poll_timeout() call.

Also, is this a fix? Should it have a Fixes: tag? If so, it should not
be part of this series, assuming the older devices have the same
issue.

	Andrew

