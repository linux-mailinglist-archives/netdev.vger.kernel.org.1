Return-Path: <netdev+bounces-126822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21439729BE
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B606B237B2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B117ADE2;
	Tue, 10 Sep 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ550xSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB41208A5;
	Tue, 10 Sep 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950686; cv=none; b=cuP6wniRIgG2fQBl5cbs0kbz0Q9KkRwj7ligkxtqzIPi1yycT5RVpratG5GMWZnK5O3rTiYjnS2rhvauvhTC2OdzCCJ0HpnmfSh7UwoHO2Hp62VHZ+BWVHba+xBoMfhBP+npm7O6SG3NlRH8bWEC+KCBmjxqYeDjrjYh90HEQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950686; c=relaxed/simple;
	bh=nHnXaPv3ZxJwVaKNgDaBMtI7zm71hl2BFvIrhZbkT7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn/xwnqVD6ncFhoZtf4zVrExN2huxfAIimhx9sQ4aOBHyB/VpbXdbf0Xu0Wz6Fy/jhxHFOfYMG2R0wVCBeMtrtxjZjkMwiP7TL9etILo9KG0rqaTIm1yLPiKk9HoGF17IzS1v4SEfDNiIIHZG7btSF0zzO4UFJRi7W/w63yrRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ550xSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4502C4CEC3;
	Tue, 10 Sep 2024 06:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725950685;
	bh=nHnXaPv3ZxJwVaKNgDaBMtI7zm71hl2BFvIrhZbkT7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQ550xSOyqkguE3g7zqkKxcXjiL6kyO50tXKBIo+lT0IkCW31FxCp3NIZE/DcHMfs
	 wqWOywomj5V5CTXTQgznTcf+emiyhsZ4MAQoBqvSSfYIPX3hPapbA0JrLt8X14s/Qw
	 nkDSkCSQvQ8qFihe3GdGVvCITn7XwJADRiQcLDk0m0mTkMwTCFLzSrjXyGVPlDwyT1
	 +L02NO500DF0t9uS6fiJD/+aibOK0HpmE+jlTPW8JSJisrmfbLW6wUC9vJJGM6Y364
	 vADoue/sk482kXsIRyLJ3kg3N0UQ8rLgtzs35kdYqWOSl/M+/Y/pYhPT0txy4cP2v9
	 i+wACgrmyCl0Q==
Date: Tue, 10 Sep 2024 07:44:41 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com,
	mail@david-bauer.net
Subject: Re: [PATCH net-next] net: gianfar: fix NVMEM mac address
Message-ID: <20240910064441.GH2097826@kernel.org>
References: <20240908213554.11979-1-rosenp@gmail.com>
 <20240909085542.GV2097826@kernel.org>
 <CAKxU2N_1t5osUc53p=G2tRLRctwbxQr3p3fScR-N1kgoNxc80Q@mail.gmail.com>
 <CAKxU2N9kgnqAgo2mHxExjgZos+MvhZw40LWCr4pYOL5DUcJJWg@mail.gmail.com>
 <20240909184850.GG2097826@kernel.org>
 <CAKxU2N_y9CM=P3ki2XGDV+9nZ9SCQwC3y2qWRHbiEZzKK_t62Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_y9CM=P3ki2XGDV+9nZ9SCQwC3y2qWRHbiEZzKK_t62Q@mail.gmail.com>

On Mon, Sep 09, 2024 at 12:14:38PM -0700, Rosen Penev wrote:
> On Mon, Sep 9, 2024 at 11:48 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Sep 09, 2024 at 11:20:20AM -0700, Rosen Penev wrote:
> > > On Mon, Sep 9, 2024 at 11:11 AM Rosen Penev <rosenp@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 9, 2024 at 1:55 AM Simon Horman <horms@kernel.org> wrote:
> > > > >
> > > > > On Sun, Sep 08, 2024 at 02:35:54PM -0700, Rosen Penev wrote:
> > > > > > If nvmem loads after the ethernet driver, mac address assignments will
> > > > > > not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> > > > > > case so we need to handle that to avoid eth_hw_addr_random.
> > > > > >
> > > > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/freescale/gianfar.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> > > > > > index 634049c83ebe..9755ec947029 100644
> > > > > > --- a/drivers/net/ethernet/freescale/gianfar.c
> > > > > > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > > > > > @@ -716,6 +716,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
> > > > > >               priv->device_flags |= FSL_GIANFAR_DEV_HAS_BUF_STASHING;
> > > > > >
> > > > > >       err = of_get_ethdev_address(np, dev);
> > > > > > +     if (err == -EPROBE_DEFER)
> > > > > > +             return err;
> > > > >
> > > > > To avoid leaking resources, I think this should be:
> > > > >
> > > > >                 goto err_grp_init;
> > > > will do in v2. Unfortunately net-next closes today AFAIK.
> > > On second thought, where did you find this?
> > >
> > > git grep err_grp_init
> > >
> > > returns nothing.
> > >
> > > Not only that, this function has no goto.
> >
> > Maybe we are looking at different things for some reason.
> Well that's embarrassing. Locally I seem to have a commit that adds a
> bunch of devm and as a result these gotos. Unfortunately I don't have
> the hardware to test those changes. I'll be doing a v2 for when
> net-next opens.

No problem. TBH it is a relief, as I was beginning to doubt my own sanity.

> >
> > I'm looking at this:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/freescale/gianfar.c?id=bfba7bc8b7c2c100b76edb3a646fdce256392129#n814
> >
> > > > >
> > > > > Flagged by Smatch.
> > > > >
> > > > > >       if (err) {
> > > > > >               eth_hw_addr_random(dev);
> > > > > >               dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
> > > > >
> > > > > --
> > > > > pw-bot: cr
> > >
> 

