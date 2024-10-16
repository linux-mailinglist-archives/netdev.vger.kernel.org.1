Return-Path: <netdev+bounces-136060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E59A02B5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7C51C2470C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161D1B6D00;
	Wed, 16 Oct 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxsYtJID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B4192D9D;
	Wed, 16 Oct 2024 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064202; cv=none; b=bgD3UqVZJM2er3YcgfQrPV685Wa7btzA0wk5su5d9WHYMI1yF59gt/CAfJaxBQlzu4l1frcydp8R4L5ZGNL8f23Zg4EMJMS6hp+nGzkJISisSuoMqXsEyGJfHCtFirBM2l8T1YITOcmchGJ469yL3R/eXa1EM4K6BaVd5GkBklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064202; c=relaxed/simple;
	bh=kIJYOdi42r61UmB7AMlZlhRJq+FfLcyh/DkdTDLgeTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7pXBikRifeXG2XR1aoZt/pOhbGXdZtsiZb4oIkKMlLoWiEdRqEsDKYrCBe3JAr7me3qInbcR1Hgda3u3HAKjGzE4lCHvclytg4hAZoycPPWYgxxgnuw8hRnTByVJNtXqme1/aE3JAOFunBA2gHaRUw4Epz5Qz8yS+wFlpGN/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxsYtJID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F52C4CEC5;
	Wed, 16 Oct 2024 07:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729064201;
	bh=kIJYOdi42r61UmB7AMlZlhRJq+FfLcyh/DkdTDLgeTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxsYtJIDW0TzeqzhrsMi+Mzeb7SXnHbpvDSCdbg0mkN6E7FcYrrKr/JBPs4Z3ST3r
	 IaWjiyhpmSXNq7SbZP82iGv5f/nWNnldVtJcQ/uZs/ryNWm4zuSpYm8Sx976J25jTs
	 eTs1CRrKCeHkbcDE2Ia75QvD1blB7Is0AfZ3Bu2vaWsZt4bXxgnGtbw2jqkITs5Png
	 444hd5/I/4e1Zr6jR2FvD/87pO69dxeKrQZ4m5gPp/ifJmu/UlVzxdp9B8Q0fMTSgy
	 2pr6NoZ6gDgiP2/6cRCRr1fUFWw5zYmTqpd6+1f5KE2+/b/76KXdFjC8gkQ7O6CD3I
	 YnuufAWEOYe/A==
Date: Wed, 16 Oct 2024 08:36:37 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 6/7] net: ibm: emac: generate random MAC if
 not found
Message-ID: <20241016073637.GE2162@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-7-rosenp@gmail.com>
 <20241012131651.GE77519@kernel.org>
 <CAKxU2N87Nqa73M+wda3Phayu5dmkWEMhDXgxz=4bASV_-8D4yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N87Nqa73M+wda3Phayu5dmkWEMhDXgxz=4bASV_-8D4yQ@mail.gmail.com>

On Tue, Oct 15, 2024 at 12:44:52PM -0700, Rosen Penev wrote:
> On Sat, Oct 12, 2024 at 6:16 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Oct 11, 2024 at 12:56:21PM -0700, Rosen Penev wrote:
> > > On this Cisco MX60W, u-boot sets the local-mac-address property.
> > > Unfortunately by default, the MAC is wrong and is actually located on a
> > > UBI partition. Which means nvmem needs to be used to grab it.
> > >
> > > In the case where that fails, EMAC fails to initialize instead of
> > > generating a random MAC as many other drivers do.
> > >
> > > Match behavior with other drivers to have a working ethernet interface.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/net/ethernet/ibm/emac/core.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> > > index b9ccaae61c48..faa483790b29 100644
> > > --- a/drivers/net/ethernet/ibm/emac/core.c
> > > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > > @@ -2937,9 +2937,12 @@ static int emac_init_config(struct emac_instance *dev)
> > >
> > >       /* Read MAC-address */
> > >       err = of_get_ethdev_address(np, dev->ndev);
> > > -     if (err)
> > > -             return dev_err_probe(&dev->ofdev->dev, err,
> > > -                                  "Can't get valid [local-]mac-address from OF !\n");
> > > +     if (err == -EPROBE_DEFER)
> > > +             return err;
> > > +     if (err) {
> > > +             dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. Generating random.");
> > > +             eth_hw_addr_random(dev->ndev);
> > > +     }
> >
> > The above seems to take the random path for all errors other than
> > -EPROBE_DEFER. That seems too broad to me, and perhaps it would
> > be better to be more specific. Assuming the case that needs
> > to be covered is -EINVAL (a guess on my part), perhaps something like this
> > would work? (Completely untested!)
> >
> >         err = of_get_ethdev_address(np, dev->ndev);
> >         if (err == -EINVAL) {
> >                 /* An explanation should go here, mentioning Cisco MX60W
> >                  * Maybe the logic should even be specific to that hw?
> >                  */
> >                 dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. Generating random.");
> >                 eth_hw_addr_random(dev->ndev);
> >         } else if (err) {
> >                 return dev_err_probe(&dev->ofdev->dev, err,
> >                                      "Can't get valid [local-]mac-address from OF !\n");
> >         }
> That's just yak shaving. besides 0 and EPROBE_DEFER,
> of_get_ethdev_address returns ENODEV, EINVAL, and maybe something
> else. I don't see a good enough reason to diverge from convention
> here. This same pattern is present in other drivers.

I assumed that more specific error detection would be appropriate, because
it seemed to be a rather specific case.  But if the pattern is present in
other drivers, then that is fine.

> >
> > Also, should this be a bug fix with a Fixes tag for net?
> No. It's more of a feature honestly.
> >
> > >
> > >       /* IAHT and GAHT filter parameterization */
> > >       if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC)) {
> > > --
> > > 2.47.0
> > >
> 

