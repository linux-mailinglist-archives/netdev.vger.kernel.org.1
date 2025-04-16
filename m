Return-Path: <netdev+bounces-183538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B4A90F0E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9775A13C4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C582459CC;
	Wed, 16 Apr 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzDKTpmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AF230D3D
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844354; cv=none; b=YepvJQXKRAoTx5MtZGJVKVtZKDvZ2tE4cktPmG8st5I8GLzwt9CFtGUJ8524yuZWO6dXNjytH0dXDUJQB+TWEFHNrVqoPRYSbFhcDANeVQlXEGg+A9hROVXPLL6VvImfi3ewCAhkTcDAY7HNIdEtF8rf/gGiKMxO3AQebaFcsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844354; c=relaxed/simple;
	bh=PCZDrRIitwuPg/cYCFIv/f+a1MWim1CT9jONkhNF8Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCvwI344jkYIJ6ElY8d6KWJnNhj89UJ4veqQMtpcBGzsxPx08V5z5Aaqnk5/WKZ5EanONbBm6hUUqMLSE/Hea329wcvS5CWDJ7tHW0qM0rxUYhF1y2PNiQqs6ZPD2luHj8KjlOmrcjc884dHSUROtJktr3ynloOjEW1XwTXK3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzDKTpmr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so89389f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744844351; x=1745449151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCZDrRIitwuPg/cYCFIv/f+a1MWim1CT9jONkhNF8Ss=;
        b=jzDKTpmr9KaZrgTqumxeN4xhXnVJ9OFpH9zGXjJi6K7eddIn3Fxq+nr08Rs/xNXYsO
         lftjHLy6stiKMbgX9dzibbcLDO3ubP89c+NVd+8C8HBiKY1PoDCEq4bIM7Uf1l6uJl5u
         t3GRHPIIag+LNHE1Cw22blP99S8sgd/gb7I4sV2LB4hr+cWYyBE/bkRLLP7ZVMio1ZUR
         6ICHgs+TTDy4/N+WMr91V3cq6r5lVefSlQcFOLHxy1g5BTSqiVJL+SFJCbjJc67H+3xG
         ZPVAmIxc5kXt9Ne1QNRc0oOIUnKkQ9GWlEoq26VGEPtQ+nnoOBs2OVDLERZj+yVjP4fz
         iZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744844351; x=1745449151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCZDrRIitwuPg/cYCFIv/f+a1MWim1CT9jONkhNF8Ss=;
        b=k+JnCBLLK0cq5szHoWMW4V5VeHRYR8whh+mZ4Bxi69va///L7ZI6Znsn2w4d37cWrn
         cjirlQAsw04SCCSRiJOD7H2fsArg6lROwthwR9ajMINvQdf21UY1HXcXh+n8yZ1/SnSY
         b7YNo+II3C+oT7v/EatzTwBBp8B+ztOD6dpIlCZkJXg0qlcdAlFtvQx69XmnOt7G8ckE
         uJ8MI6/k8iUyFxQ2n+OM/H1vs2pxBKCmTZrLK7vlU90lonpJpDzSQ0gXu64nVj8X8Msc
         KZ0ikdel+n+YBBio7LqZfoDshNU7MclLCuasapN6Go85PYx1pIrVPSvDS0zYO5npct+l
         gIFw==
X-Gm-Message-State: AOJu0Yx5tX9eWKNnHXzRWqst8pDPxhXkl2afGF0SzqebRps0La4auaS0
	d7KZRl7vBqzGKsvJkPz7jofEn9RPwI/v8eRAQJwA0QyLTAcNZZvcZNNrvtr7+GMapF/fYsQE8UP
	TGAkeENiNaWF9a8kSp7oDh2TfKGw=
X-Gm-Gg: ASbGncvpeUyORvSUa6PBMwbXXp4unGjeYXtKwmc9RyVdadrSnUTVGDcgaep1FlyVn0g
	H9n9MqQISt7nMIk04p0DODgPvp7F5cCc9jeEKPhdpjD8PODUGm6u5GQytT1x3yBCtMBmhT4wW2o
	n/2iNEUp41aCYpTSXkyh68lNhDh50751VXKYeWoTaWl1+VQ88kQxxPHHA=
X-Google-Smtp-Source: AGHT+IFSASf9SELikYKA50k0jiQLpQwnFPAi6UmYO45Q8r0puEA5ABeJBhyViCLgS+EZAEoKFZTtQrM7E1TdGjo0PRM=
X-Received: by 2002:a05:6000:1863:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-39ee5b11297mr3477203f8f.9.1744844350597; Wed, 16 Apr 2025
 15:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa>
 <Z__URcfITnra19xy@shell.armlinux.org.uk> <CAKgT0UcgZpE4CMDmnR2V2GTz3tyd+atU-mgMqiHesZVXN8F_+g@mail.gmail.com>
 <aAACyQ494eO4LFQD@shell.armlinux.org.uk> <aAANe/qMWIRY2K5l@shell.armlinux.org.uk>
In-Reply-To: <aAANe/qMWIRY2K5l@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 16 Apr 2025 15:58:33 -0700
X-Gm-Features: ATxdqUFLZWLfZLYONo7LsmlJwpM6i1vkupsjwY5ua88IFJow0MM9rhz8MDWbzvs
Message-ID: <CAKgT0UeY1xHvxXm8YDJ6MArgwcgu2Dkw3PBTg=m0XK7Hi-XrXw@mail.gmail.com>
Subject: Re: [net-next PATCH 2/2] net: phylink: Fix issues with link balancing
 w/ BMC present
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 1:05=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 16, 2025 at 08:19:38PM +0100, Russell King (Oracle) wrote:
> > So, when a Linux network driver probes, it starts out in administrative
> > state *DOWN*. When the administrator configures the network driver,
> > .ndo_open is called, which is expected to configure the network adapter=
.
> >
> > Part of that process is to call phylink_start() as one of the last
> > steps, which detects whether the link is up or not. If the link is up,
> > then phylink will call netif_carrier_on() and .mac_link_up(). This
> > tells the core networking layers that the network interface is now
> > ready to start sending packets, and it will begin queueing packets for
> > the network driver to process - not before.
> >
> > Prior to .ndo_open being called, the networking layers do not expect
> > traffic from the network device no matter what physical state the
> > media link is in. If .ndo_open fails, the same applies - no traffic is
> > expected to be passed to the core network layers from the network
> > layers because as far as the network stack is concerned, the interface
> > is still administratively down.
> >
> > Thus, the fact that your BMC thinks that the link is up is irrelevant.
> >
> > So, start off in a state that packet activity is suspended even if the
> > link is up at probe time. Only start packet activity (reception and
> > transmission) once .mac_link_up() has been called. Stop that activity
> > when .mac_link_down() is subsequently called.
> >
> > There have been lots of NICs out there where the physical link doesn't
> > follow the adminstrative state of the network interface. This is not a
> > problem. It may be desirable that it does, but a desire is not the same
> > as "it must".
>
> Let me be crystal clear on this.
>
> Phylink has a contract with all existing users. That contract is:
>
> Initial state: link down.
>
> Driver calls phylink_start() in its .ndo_open method.
>
> Phylink does configuration of the PHY and link according to the
> chosen link parameters by calling into the MAC, PCS, and phylib as
> appropriate.
>
> If the link is then discovered to be up (it might have been already
> up before phylink_start() was called), phylink will call the various
> components such as PCS and MAC to inform them that the link is now up.
> This will mean calling the .mac_link_up() method. Otherwise (if the
> link is discovered to be down when the interface is brought up) no
> call to either .mac_link_up() nor .mac_link_down() will be made.
>
> If the link _subsequently_ goes down, then phylink deals with that
> and calls .mac_link_down() - only if .mac_link_up() was previously
> called (that's one of the bugs you discovered, that on resume it
> gets called anyway. I've submitted a fix for that contract breach,
> which only affects a very small number of drivers - stmmac, ucc_geth
> and your fbnic out of 22 total ethernet users plus however many DSA
> users we have.)
>
> Only if .mac_link_down() has been called, if the link subsequently
> comes back up, then the same process happens as before resulting in
> .mac_link_up() being called.
>
> If the interface is taken down, then .mac_link_down() will be called
> if and only if .mac_link_up() had been called.
>
> The ordering of .mac_link_up() / .mac_link_down() is a strict
> contract term with phylink users.
>
> The reason for this contract: phylink users may have ordering
> requirements.
>
> For example, on mac_link_down(), they may wait for packet activity to
> stop, and then place the MAC in reset. If called without a previous
> .mac_link_up call, the wait stage may time out due to the MAC being
> in reset. (Ocelot may suffer with this.)
>
> Another example is fs_enet which also relies on this strict ordering
> as described above.
>
> There could be others - there are some that call into firmware on
> calls to .mac_link_up() / .mac_link_down() and misordering those
> depends on what the firmware is doing, which we have no visibility
> of.
>
> As I stated, this is the contract that phylink gave to users, and
> the contract still stands, and can't be broken to behave differently
> (e.g. calling .mac_link_down() after phylink_start() without an
> intervening call to .mac_link_up()) otherwise existing users will
> break. Bugs that go against that contract will be fixed, but the
> contract will not be intentionally broken.

The issue is as that stands the contract is inherently broken if a BMC
is present.

1. There is still the link loss during the phylink_start issue which
will essentially leave the MAC up if the link fails. This will cause
the Tx FIFO on the NIC to essentially be left to hang without flushing
out the stale packets that may have queued up when the link dropped.
This is one of the reasons why the mac_link_down call still needs to
propagate all the way back down to the hardware.

2. We already have precedent for the link being up when WOL is in use.
One concern I would have with your patch is if it will impact that or
not. I suspected part of the mac_link_down is related to cleaning up
something related to the link setup for WOL configuring the link for
some speed.

3. While it may be a part of the contract, isn't there some way we can
"renegotiate the terms"? The fact is in the case of our driver we are
essentially doing a hand-off from FW to the OS for the link when we
call ndo_open. When we are done in ndo_stop we hand ownership back
over to the firmware. Those hand-offs need to be free of link bounces.
This pattern looks very much like the WOL setup with the only
exception being trying to avoid these link bounces. I'm just wondering
if there isn't some way we can add a phylink_config value indicating
that there is a BMC present on the link so we can handle those cases.
The general idea would be to update my patch so instead of
pl->link_balanced being just set to false in suspend and at creation
time we could essentially just set it to "pl->link_balanced =3D
!pl->config.mac_bmc_handoff".

The fact is the code with the diff I provided did everything I needed.
I could load/unload and ifconfig up/down the driver all day and it
didn't drop a packet. As it stood the definition of the mac_config
code more or less called out that we weren't supposed to change things
unless we needed to and I had followed that. I suspect the overall
change should be small, smaller now following your fix of the message
issue, and it shouldn't impact anything other than our driver if I add
the config flag checks.

