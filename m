Return-Path: <netdev+bounces-29127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D8781A95
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05D5281970
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6018AF4;
	Sat, 19 Aug 2023 17:11:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FEA46BC
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0B3C433C8;
	Sat, 19 Aug 2023 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692465058;
	bh=gbs+cSeiYRfvW051Zt5AWgiLvcsHAZU/NvFtQpER3bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1uESBh03AaOXuQaZwDOnIH1Fmsdc4H6gn53hy3fBlpzrBOYCjsgNK04cfXHJZ9CF
	 G0zXkx62zxgsBicqNyjNQnwhziZV+hjgd8ZNcTUCbuc92q3xBmTK6Py0ag9O4hN6gJ
	 /7hGz8+YIfzVFy2rCw8CJftbSQrbuNw8K9AdbrLiA84ugSLwOLVw0qAoUX03PeKHI4
	 Gjirc0vrdnJzzxz8PoCP3HvwNwsd/RqUqYYokOqxt3NvUWzlzktpskTVIrT8IHNdcQ
	 xv4fsFN4/hHGSbiTnC88YT6waJuWjUj1SGQcZOvcl6jmzL4jhQ8fuYSMPQtzOkyih4
	 9ne+f1K9obu/w==
Date: Sat, 19 Aug 2023 19:10:54 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: bcmgenet: Return PTR_ERR() for
 fixed_phy_register()
Message-ID: <ZOD3nl+dOA39cVg5@vergenet.net>
References: <20230818070707.3670245-1-ruanjinjie@huawei.com>
 <20230818070707.3670245-3-ruanjinjie@huawei.com>
 <ZOD2hylmo1/HgaYO@vergenet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOD2hylmo1/HgaYO@vergenet.net>

On Sat, Aug 19, 2023 at 07:06:15PM +0200, Simon Horman wrote:
> On Fri, Aug 18, 2023 at 03:07:06PM +0800, Ruan Jinjie wrote:
> > fixed_phy_register() returns -EPROBE_DEFER, -EINVAL and -EBUSY,
> > etc, in addition to -ENODEV. The Best practice is to return these
> > error codes with PTR_ERR().
> > 
> > Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> > ---
> > v3:
> > - Split the return value check into another patch set.
> > - Update the commit title and message.
> > ---
> >  drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > index 0092e46c46f8..4012a141a229 100644
> > --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > @@ -619,7 +619,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
> >  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> >  		if (!phydev || IS_ERR(phydev)) {
> >  			dev_err(kdev, "failed to register fixed PHY device\n");
> > -			return -ENODEV;
> > +			return PTR_ERR(phydev);
> 
> Hi Ruan,
> 
> thanks for your patch.
> 
> Perhaps I am missing something, but this doesn't seem right to me.
> In the case where phydev is NULL will return 0.
> But bcmgenet_mii_pd_init() also returns 0 on success.
> 
> Perhaps this is better?
> 
> 		if (!phydev || IS_ERR(phydev)) {
> 			dev_err(kdev, "failed to register fixed PHY device\n");
> 			return physdev ? PTR_ERR(phydev) : -ENODEV;
> 		}
> 
> I have a similar concern for patch 1/3 of this series.
> Patch 3/3 seems fine in this regard.

Sorry for the noise.

I now see that fixed_phy_register() never returns NULL,
and that condition is being removed by another patchset [1].

I'm fine with this, other than that I suspect your two series
conflict with each other.

[1] https://lore.kernel.org/all/20230818051221.3634844-1-ruanjinjie@huawei.com/


