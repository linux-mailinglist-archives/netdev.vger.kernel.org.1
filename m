Return-Path: <netdev+bounces-131367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F4998E552
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C48B24F6F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C122178F4;
	Wed,  2 Oct 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EuV3hG7T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD89C8FE;
	Wed,  2 Oct 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904751; cv=none; b=Q0nSLAiR5c3/nJ7LYG3w+jJGWoW/IsDtvjCLvlFBTw4cRjdVmkUm24QeLL5vHHRmpiI/qzyG0BiSjvsJcO61erDhexBH47zmasBwYjrZjITAXD96eTBEKjP6M46sTtFdIDEn5mmz9VkSkT3YTbJOcBu1lpWaYRfrfr5arQBFZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904751; c=relaxed/simple;
	bh=PQ8L5OFMacPSsxZkCvX38gAtDu7vhlvcnzMBekB5ZY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYja/e664y3mjk2SBkxEERyfq3I0SLQw8oAq9+CLTvr8eg0nUdTN+7NpbzQiz/6CLjBAhetajsJsowDrIhgixQoaFT6Xt1Io3VIR87+Nhqe5785YV8oSi4w80eKdEc7beSbbw7GFHJOIDnugUzosmLjPieaoXBu0II1eutlvFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EuV3hG7T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=m0HUbrqlt+QK9AMe/0YFpaLPR8XNUc1DWho8TbWZpLQ=; b=Eu
	V3hG7TzURVPOZ1srFREWKiIaEqSfiRn2IRH2kafRKQZRDggqN4WAy2hakifYXBhnAKEykrKLUTVXT
	y8UYCpgIRxk0KASSK8FtmNLGThdLABNI9Vk9VoSLmLLs2bu2luoFfTFFV5ex0SfZvzhk5AoyodtbL
	6vhoAvtXGOe6t1A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw6xI-008tdW-OM; Wed, 02 Oct 2024 23:32:20 +0200
Date: Wed, 2 Oct 2024 23:32:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 5/6] net: gianfar: use devm for request_irq
Message-ID: <fecc95be-eec6-4c79-9ae3-438f24f85122@lunn.ch>
References: <20241001212204.308758-1-rosenp@gmail.com>
 <20241001212204.308758-6-rosenp@gmail.com>
 <20241002093736.43af4008@fedora.home>
 <CAKxU2N8QQFP93Y9=S_vavXHkVwc7-h1aOm0ydupa1=4s9w=XYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8QQFP93Y9=S_vavXHkVwc7-h1aOm0ydupa1=4s9w=XYA@mail.gmail.com>

On Wed, Oct 02, 2024 at 12:29:04PM -0700, Rosen Penev wrote:
> On Wed, Oct 2, 2024 at 12:37 AM Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
> >
> > Hi Rosen,
> >
> > On Tue,  1 Oct 2024 14:22:03 -0700
> > Rosen Penev <rosenp@gmail.com> wrote:
> >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/net/ethernet/freescale/gianfar.c | 67 +++++++-----------------
> > >  1 file changed, 18 insertions(+), 49 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> > > index 07936dccc389..78fdab3c6f77 100644
> > > --- a/drivers/net/ethernet/freescale/gianfar.c
> > > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > > @@ -2769,13 +2769,6 @@ static void gfar_netpoll(struct net_device *dev)
> > >  }
> > >  #endif
> > >
> > > -static void free_grp_irqs(struct gfar_priv_grp *grp)
> > > -{
> > > -     free_irq(gfar_irq(grp, TX)->irq, grp);
> > > -     free_irq(gfar_irq(grp, RX)->irq, grp);
> > > -     free_irq(gfar_irq(grp, ER)->irq, grp);
> > > -}
> > > -
> > >  static int register_grp_irqs(struct gfar_priv_grp *grp)
> > >  {
> > >       struct gfar_private *priv = grp->priv;
> > > @@ -2789,80 +2782,58 @@ static int register_grp_irqs(struct gfar_priv_grp *grp)
> > >               /* Install our interrupt handlers for Error,
> > >                * Transmit, and Receive
> > >                */
> > > -             err = request_irq(gfar_irq(grp, ER)->irq, gfar_error, 0,
> > > -                               gfar_irq(grp, ER)->name, grp);
> > > +             err = devm_request_irq(priv->dev, gfar_irq(grp, ER)->irq,
> > > +                                    gfar_error, 0, gfar_irq(grp, ER)->name,
> > > +                                    grp);
> >
> > This is called during open/close, so the lifetime of the irqs
> > isn't tied to the struct device, devm won't apply here. If you
> > open/close/re-open the device, you'll request the same irq multiple
> > times.
> Good point. Would it make sense to move to probe?

Do you have the hardware? Can you test such a change?

	Andrew

