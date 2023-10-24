Return-Path: <netdev+bounces-44029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5F7D5E41
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0326A1C20CE2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236281B27C;
	Tue, 24 Oct 2023 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ab7QFkgf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CCC47363
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:33:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A61BF4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x9D9vd9cbinVTuK3RfWV0o+u1vIJdR5HPsZr+r2szbY=; b=Ab7QFkgfp4MdMHGJ551q0NN844
	05CCQMmPe1/oZdjrGm1rwhMus9ZlbOmpgJD0m0hsI1Z2yFdh/SR4WgiB94IeSYhOseomv0RBeXclM
	7LNq5BnGHt/6/SDi5h/Pfy5Ri3Gio+EmKH05fZY2d6f027Pq+tjy8kSfrwK1WPyTUek0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qvPwu-0007Ui-Ue; Wed, 25 Oct 2023 00:32:32 +0200
Date: Wed, 25 Oct 2023 00:32:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org, krzk+dt@kernel.org,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
Message-ID: <a904eb93-0669-476d-8698-d3f5a3c7a162@lunn.ch>
References: <20231024205805.19314-1-luizluca@gmail.com>
 <CAJq09z4_m5T+bHZR=kPrn-6u-KMxpTE0YJ=gJXOHUkpqm7ZOqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4_m5T+bHZR=kPrn-6u-KMxpTE0YJ=gJXOHUkpqm7ZOqg@mail.gmail.com>

On Tue, Oct 24, 2023 at 07:17:10PM -0300, Luiz Angelo Daros de Luca wrote:
> Hi Linus,
> 
> > -       /* TODO: if power is software controlled, set up any regulators here */
> > +#ifdef CONFIG_RESET_CONTROLLER
> > +       priv->reset_ctl = devm_reset_control_get(dev, "switch");
> > +       if (IS_ERR(priv->reset_ctl)) {
> > +               dev_err(dev, "failed to get switch reset control\n");
> > +               return PTR_ERR(priv->reset_ctl);
> > +       }
> > +#endif
> 
> I'm dropping this TODO as I think it means something like this reset
> control, right?

No, a regulator is a different thing to a reset controller. A
regulator is used to control the power to the device.

	Andrew

