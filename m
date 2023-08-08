Return-Path: <netdev+bounces-25460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F289077435B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5128176D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849B14F9E;
	Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FC14AB7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5761B22;
	Tue,  8 Aug 2023 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ajwdCnT8njC9y5kbONtAi0NxS4A3FaITcmOZgzwf/nk=; b=eQBZkvjxp0IEb/UJPuCjaB0n9U
	GWy8dZfyNBaMiwnXFECFy1K/3U/ALGlee1P8V+1bWgkDxMsQGq98TB042L7bTiflTtjccVhhGmFww
	w3W7hwFV8sf4skQ3nFjQPaO6ioKfHOCZ3ew26CuHTwDVOEkxbJ1UUGLDMBVMe1tG+Zo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTOQz-003Th8-1Y; Tue, 08 Aug 2023 17:15:45 +0200
Date: Tue, 8 Aug 2023 17:15:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Message-ID: <d021b8ae-a6a3-4697-a683-c9bd45e6c74b@lunn.ch>
References: <20230807193102.6374-1-brgl@bgdev.pl>
 <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
 <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
 <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch>
 <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
 <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I'll make the water muddier (hopefully clearer?). I have access to the
> board schematic (not SIP/SOM stuff though), but that should help here.
> 
> MAC0 owns its own MDIO bus (we'll call it MDIO0). It is pinmuxed to
> gpio8/gpio9 for mdc/mdio. MAC1 owns its own bus (MDIO1) which is
> pinmuxed to gpio21/22.
> 
> On MDIO0 there are two SGMII ethernet phys. One is connected to MAC0,
> one is connected to MAC1.
> 
> MDIO1 is not connected to anything on the board. So there is only one
> MDIO master, MAC0 on MDIO0, and it manages the ethernet phy for both
> MAC0/MAC1.
> 
> Does that make sense? I don't think from a hardware design standpoint
> this is violating anything, it isn't a multimaster setup on MDIO.

Thanks for taking a detailed look at the schematics. This is how i
would expect it to be.

> > > > Good point, but it's worse than that: when MAC0 is unbound, it will
> > > > unregister the MDIO bus and destroy all PHY devices. These are not
> > > > refcounted so they will literally go from under MAC1. Not sure how
> > > > this can be dealt with?
> > >
> > > unbinding is not a normal operation. So i would just live with it, and
> > > if root decides to shoot herself in the foot, that is her choice.
> > >
> > 
> > I disagree. Unbinding is very much a normal operation.

What do you use it for?

I don't think i've ever manually done it. Maybe as part of a script to
unbind the FTDI driver from an FTDI device in order to use user space
tools to program the EEPROM? But that is about it.

I actually expect many unbind operations are broken because it is very
rarely used.

       Andrew

