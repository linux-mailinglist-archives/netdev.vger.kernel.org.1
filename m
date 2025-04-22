Return-Path: <netdev+bounces-184479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA722A95A6C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 03:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03653B644A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB61125DF;
	Tue, 22 Apr 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXLNThi3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446A3D6A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284906; cv=none; b=W6FZ6MQ4c0u3eX6GDxenehrOOlUM23yDyaPglEqxgftztQTb//IzdiyltkUxQuYExVBHeUnObDTte59eFGFJnh28LK6GuI6qPBYWGtY4tvczEljdZ98cNaGEV/0CGMHxOqIXHxtVKemAZuOtmHd4zwIxQlKImcsytEtl6Z+G/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284906; c=relaxed/simple;
	bh=i0eVxUB4qlCu6bDZCw/2MAZYRGRX1GatsTiQBx4idfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yly7UQJGHsmMvo3YPEL/d8zqwemCylasUlpLmKWah+Ha3mkbbY1j1WqWnJfVoFYPbgahUDch7d6oRu7747ZKLaG83y6KOwMGSjb+4ewyvbKf73o3872/jjxdy8vlGHjLF1Y+dG84qhuIlGMEEpZ5RB6boYqrKOdWTpsjbxM6njE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXLNThi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E1DC4CEE4;
	Tue, 22 Apr 2025 01:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745284904;
	bh=i0eVxUB4qlCu6bDZCw/2MAZYRGRX1GatsTiQBx4idfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXLNThi3g17NG1QSbZlsjb+XuOkslE9JMCMQKoTqk6Azrw3Kw+7+pQ20TJjdY45ih
	 3qNN9qBFo9icFGFZsmrOTd7fwPQtmR9o1adT7duC74nxt6d+NbewKiR/M5f2rXGTU3
	 yHz9PEF908hVwbrbwaFUwi0gJRxcIvvQ4IUAjbPwRUvN7fMQE4dHWPNZl2aZXzJYuQ
	 g2s8jYbkGo8uM7EkvO06Vgt7hmXWnlG+FeXhdy3f+mFQ6rjfjiBTqTdyRizjlWpQtk
	 8y3MvH5A8NDODqMD0s2+9KprJlAxbvzUBJA9qpRBX922hJcsldZLqLZV4mZX7f6rQ7
	 mhsG+m7pUI5tw==
Date: Mon, 21 Apr 2025 18:21:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
 pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <20250421182143.56509949@kernel.org>
In-Reply-To: <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
	<de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
	<CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
	<06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
	<CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
	<CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 09:50:25 -0700 Alexander Duyck wrote:
> On Mon, Apr 21, 2025 at 8:51=E2=80=AFAM Alexander Duyck wrote:
> > On Sun, Apr 20, 2025 at 2:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote: =20
> > > > 2. Expectations for our 25G+ interfaces to behave like multi-host N=
ICs
> > > > that are sharing a link via firmware. Specifically that
> > > > loading/unloading the driver or ifconfig up/down on the host interf=
ace
> > > > should not cause the link to bounce and/or drop packets for any oth=
er
> > > > connections, which in this case includes the BMC. =20
> > >
> > > For this, it would be nice to point to some standard which describes
> > > this, so we have a generic, vendor agnostic, description of how this
> > > is supposed to work.
> >
> > The problem here is this is more-or-less a bit of a "wild west" in
> > terms of the spec setup. From what I can tell OCP 3.0 defines how to
> > set up the PCIe bifurcation but doesn't explain what the expected
> > behavior is for the shared ports. One thing we might look into would
> > be the handling for VEPA(Virtual Ethernet Port Aggregator) or VEB
> > (Virtual Ethernet Bridging) as that wouldn't be too far off from what
> > inspired most of the logic in the hardware. Essentially the only
> > difference is that instead of supporting VFs most of these NICs are
> > supporting multiple PFs. =20
>=20
> So looking at 802.1Q-2022 section 40 I wonder if we don't need to
> essentially define ourselves as an edge relay as our setup is pretty
> close to what is depicted in figure 40-1. In our case an S-channel
> essentially represents 2 SerDes lanes on an QSFP cable, with the
> switch playing the role of the EVB bridge.
>=20
> Anyway I think that is probably the spec we need to dig into if we are
> looking for how the link is being shared and such. I'll try to do some
> more reading myself to get caught up on all this as the last time I
> had been reading through this it was called VEB instead of EVB.. :-/

Interesting. My gut feeling is that even if we make Linux and the NIC
behave nicely according to 802.1Q, we'll also need to make some changes
on the BMC side. And there we may encounter pushback as the status quo
works quite trivially for devices with PHY control in FW.

To paraphrase what was already said upthread - in my mind the question
is whether we want to support "picking up" an already running link with
phylink. Whether the use case is BMC or avoiding link flap when picking
up from uboot is of secondary importance.

Andrew, the standard could help us build a common higher layer, if
needed but I'm not sure how much it impacts the phylink side. The only
question for phylink is 1 bit of policy whether link can be "recovered"
and left up on close, no?

BTW Saeed posted a devlink param to "keep link up" recently:
https://lore.kernel.org/all/20250414195959.1375031-11-saeed@kernel.org/
Intel has ethtool priv flags to the same effect, in their 40G and 100G
drivers, but with reverse polarity:
https://docs.kernel.org/networking/device_drivers/ethernet/intel/i40e.html#=
setting-the-link-down-on-close-private-flag
These are all for this exact use case. In the past Ido added module
power policy, which is the only truly generic configurable, and one we
should probably build upon:
https://docs.kernel.org/networking/ethtool-netlink.html#c.ethtool_module_po=
wer_mode_policy
I'm not sure if this is expected to include PCS or it's just telling
the module to keep the laser on..

