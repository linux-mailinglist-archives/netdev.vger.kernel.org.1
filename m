Return-Path: <netdev+bounces-126653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53238972211
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004F61F24323
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C918951E;
	Mon,  9 Sep 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsnmcWbi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367B188CAF;
	Mon,  9 Sep 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907735; cv=none; b=IArTIfYvfmvzlqn6PFTmRJUQcTGM6UvKNA8KLQqVyU63cLcESz2a2rOz3vdoRzpfywF9sVof0YNcZF+LMk8xC0LND4EDrrQQTadRuNSypDDNS0ry8bD3E4Q3iJOfcBUFk9sSZmlFkeJHSG8szCsjnyNvwWKEtWz6TVmlC8sbieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907735; c=relaxed/simple;
	bh=b0uGc2+lyepnPSeWPQrpCAbX/zRM5L8u++CbX7HPZZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeP9M1jJAfQF0NTxJfSSSaR+bypzWHvh3ag2OvZy/G4yKUgS5J2rKvQmg+cYTEQwJnyZcyswJ1iyoHpRPor8DnXxqx77Zf/iGo0lUOh9erSznvbCrK7XQtzXTot5cw/cEUJWDUsUBQJ0xYs4XJMJJpBTnAvxS4OJzy9g/7Do57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsnmcWbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A72C4CEC5;
	Mon,  9 Sep 2024 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725907734;
	bh=b0uGc2+lyepnPSeWPQrpCAbX/zRM5L8u++CbX7HPZZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsnmcWbi+8UCWw+0MXhswKN8OBRrFHMSXTPyOfxBUoj5G9W8MXXOGubYj9M0j6GNb
	 mi3xepV2vkv/ygIy+eSclSQwiz3PmrHSLmsJrk0NunENPxVsgmYSF+szxIAZRxn0r8
	 cYGAX08idyMCpyNoO1EuGjHDwMddMiFfoXK4+oi49J2b8O+KjhAgJycYVMZzoVHMtW
	 tr5C/WqFKaii/z/NTdY1/JNL74PTPg2Mj6bhFYjZHOaiX2gl5qJ4oMChyw4JbIHpPi
	 IcM6Yr/S7LmM4xfEXThuMNEz8sh7t6MwpOVku3P7jQa3H/iHzPHraJra9CBt8JEnSK
	 4PDZHzuFDgkzg==
Date: Mon, 9 Sep 2024 19:48:50 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com,
	mail@david-bauer.net
Subject: Re: [PATCH net-next] net: gianfar: fix NVMEM mac address
Message-ID: <20240909184850.GG2097826@kernel.org>
References: <20240908213554.11979-1-rosenp@gmail.com>
 <20240909085542.GV2097826@kernel.org>
 <CAKxU2N_1t5osUc53p=G2tRLRctwbxQr3p3fScR-N1kgoNxc80Q@mail.gmail.com>
 <CAKxU2N9kgnqAgo2mHxExjgZos+MvhZw40LWCr4pYOL5DUcJJWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9kgnqAgo2mHxExjgZos+MvhZw40LWCr4pYOL5DUcJJWg@mail.gmail.com>

On Mon, Sep 09, 2024 at 11:20:20AM -0700, Rosen Penev wrote:
> On Mon, Sep 9, 2024 at 11:11 AM Rosen Penev <rosenp@gmail.com> wrote:
> >
> > On Mon, Sep 9, 2024 at 1:55 AM Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Sun, Sep 08, 2024 at 02:35:54PM -0700, Rosen Penev wrote:
> > > > If nvmem loads after the ethernet driver, mac address assignments will
> > > > not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> > > > case so we need to handle that to avoid eth_hw_addr_random.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/net/ethernet/freescale/gianfar.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> > > > index 634049c83ebe..9755ec947029 100644
> > > > --- a/drivers/net/ethernet/freescale/gianfar.c
> > > > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > > > @@ -716,6 +716,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
> > > >               priv->device_flags |= FSL_GIANFAR_DEV_HAS_BUF_STASHING;
> > > >
> > > >       err = of_get_ethdev_address(np, dev);
> > > > +     if (err == -EPROBE_DEFER)
> > > > +             return err;
> > >
> > > To avoid leaking resources, I think this should be:
> > >
> > >                 goto err_grp_init;
> > will do in v2. Unfortunately net-next closes today AFAIK.
> On second thought, where did you find this?
> 
> git grep err_grp_init
> 
> returns nothing.
> 
> Not only that, this function has no goto.

Maybe we are looking at different things for some reason.

I'm looking at this:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/freescale/gianfar.c?id=bfba7bc8b7c2c100b76edb3a646fdce256392129#n814

> > >
> > > Flagged by Smatch.
> > >
> > > >       if (err) {
> > > >               eth_hw_addr_random(dev);
> > > >               dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
> > >
> > > --
> > > pw-bot: cr
> 

