Return-Path: <netdev+bounces-137871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D823B9AA340
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125361C221A5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B49145B24;
	Tue, 22 Oct 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r85hpzFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7221E481;
	Tue, 22 Oct 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604115; cv=none; b=mCMjvPRWNIXGmDXiLcYONPUTgYx4MleBm03LFcnrnORsQi9edXOLDnMFz8j1hzw9XZjLEXXCgLFuXoHHcbZKeecTcEKbQtqTeXkTwFGILgnvlnogU1UWS0cdkzEFIeCkDxlm0GNbXHsslwYv1UJ61zG5fOcv15UYztJlnWGgZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604115; c=relaxed/simple;
	bh=qDbw4iQAOpQcGNeHy6beNAJP98MdOCI+be23tNCoFSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnmO0dz+12J54f2Zm7uTzmapG7/22rrNPO4HSmAVJkMHxKDTHvJgHk7wvVP3sDpz9HjLt9cWIabTGk9MH4K90hi2D3tMENeyv/Y/M6BF7bTJjWfn+HuGQi1N9Cv9mPov1I3Xz39VQLNDiw3QqbtXTbeZrVMmeu+y8nFLAKYSkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r85hpzFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5CAC4CEC3;
	Tue, 22 Oct 2024 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729604115;
	bh=qDbw4iQAOpQcGNeHy6beNAJP98MdOCI+be23tNCoFSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r85hpzFNcYJqa8q/mviguSa8hDJYzLTzeJAPiQFXlUVRQO/iPeQySWCnb9POflz/I
	 /uG/FD5LLBLcg2c7xme06K+s+xSuX+YpSeW1+WmxdQj4Z/aLFSSVAcpRY/UgXaBAJQ
	 jrdA3vaFo8FRCm3ZmX++XCObdMhQyHNLis286B1sQ5IxPEec45N0kDO6d3bowNnwhq
	 dsUfJWA3ILOSK3uvtlRQKByZskt5Bk0eLIe7VZnZb70lrV9dolnbeAMf7/hxWlwaih
	 2QclJG/qTUnCO18VkLbg7kRGRyebQrH1L/eVXsF5QJJKZ4qo3TJknrvCManli0k+JE
	 Yx9QtFmW02nWQ==
Date: Tue, 22 Oct 2024 14:35:08 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	horatiu.vultur@microchip.com,
	jensemil.schulzostergaard@microchip.com,
	Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
	ast@fiberby.net, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Message-ID: <20241022133508.GT402847@kernel.org>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
 <20241022085050.GQ402847@kernel.org>
 <20241022120842.uf575qwaulufjyv6@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022120842.uf575qwaulufjyv6@DEN-DL-M70577>

On Tue, Oct 22, 2024 at 12:08:42PM +0000, Daniel Machon wrote:
> Hi Simon,
> 
> > > Add compatible strings for the twelve lan969x SKU's (Stock Keeping Unit)
> > > that we support, and verify that the devicetree target is supported by
> > > the chip target.
> > >
> > > Each SKU supports different bandwidths and features (see [1] for
> > > details). We want to be able to run a SKU with a lower bandwidth and/or
> > > feature set, than what is supported by the actual chip. In order to
> > > accomplish this we:
> > >
> > >     - add new field sparx5->target_dt that reflects the target from the
> > >       devicetree (compatible string).
> > >
> > >     - compare the devicetree target with the actual chip target. If the
> > >       bandwidth and features provided by the devicetree target is
> > >       supported by the chip, we approve - otherwise reject.
> > >
> > >     - set the core clock and features based on the devicetree target
> > >
> > > [1] https://www.microchip.com/en-us/product/lan9698
> > >
> > > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > > ---
> > >  drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
> > >  .../net/ethernet/microchip/sparx5/sparx5_main.c    | 194 ++++++++++++++++++++-
> > >  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
> > >  3 files changed, 193 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
> > > index 3435ca86dd70..8fe302415563 100644
> > > --- a/drivers/net/ethernet/microchip/sparx5/Makefile
> > > +++ b/drivers/net/ethernet/microchip/sparx5/Makefile
> > > @@ -19,3 +19,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
> > >  # Provide include files
> > >  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
> > >  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
> > > +ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/lan969x
> > > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > > index 5c986c373b3e..edbe639d98c5 100644
> > > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > > @@ -24,6 +24,8 @@
> > >  #include <linux/types.h>
> > >  #include <linux/reset.h>
> > >
> > > +#include "lan969x.h" /* lan969x_desc */
> > > +
> > 
> > Hi Daniel,
> > 
> > Perhaps this will change when Krzysztof's comment elsewhere in this thread
> > is addressed. But as it stands the construction in the above two hunks
> > appears to cause a build failure.
> > 
> >   CC      drivers/net/ethernet/microchip/sparx5/sparx5_main.o
> > In file included from drivers/net/ethernet/microchip/sparx5/sparx5_main.c:27:
> > ./drivers/net/ethernet/microchip/lan969x/lan969x.h:10:10: fatal error: sparx5_main.h: No such file or directory
> >    10 | #include "sparx5_main.h"
> >       |          ^~~~~~~~~~~~~~~
> > 
> > My preference would be to move away from adding -I directives and, rather,
> > use relative includes as is common practice in Networking drivers (at least).
> > 
> > ...
> > 
> > --
> > pw-bot: changes-requested
> 
> I didn't see this build failure when I ran my tests, nor did the NIPA
> tests reveal it. I can only reproduce it if I point to the microchip
> subdir when building - but maybe that's what you did too?
> 
> Anyway, I will skip the -I includes and resort to relative includes, as
> per your request. Thanks.

Thanks Daniel,

Yes I did see the problem when pointing to the subdir.
But I was also able to see it without doing so when
using a config based on tinyconfigi on x86_64.

I can dig further if you like, or provide that config.
But I did see that relative includes (or an extra -I)
resolved the problem.

