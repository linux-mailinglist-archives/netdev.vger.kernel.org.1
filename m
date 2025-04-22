Return-Path: <netdev+bounces-184729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86DA970C1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2C33A830F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93AC28FFD1;
	Tue, 22 Apr 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMUXKyUX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C628FFCD
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335688; cv=none; b=Q27HJWkmtZ/akilbe9POBjYoxAOE80KpXNQFO860qVmEMX66YXsbenlaHyRBKpXdzDeqLRRGgs8A7vuAzOgXUbzN+24ciWxxzpZH5FAVCMB++KPILqFkUCaDYRF3i4Qv9YxYy8Nj73HXEB3zx4FsNgsqkwsa2hCuUb/AEbYVL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335688; c=relaxed/simple;
	bh=2Vtymed43jE3eqa+iT/LjKB/xHeQMUhQNK2xCymdLMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIP1g44l18RIj/GxXFtBp4qForaXpIG5VPp+xCpj0JzYAKzQIdGfoyTShxnDmmIr9dW5cnBC040LhZLrxnL1+1r31gsFw82al29ApfqVwJCc2PcCu5NfqEciejx8op6J2O33wJIDS7D2hCR09g6KhrzHX2y6/KNgrwNmrL9mWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMUXKyUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB711C4CEE9;
	Tue, 22 Apr 2025 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335688;
	bh=2Vtymed43jE3eqa+iT/LjKB/xHeQMUhQNK2xCymdLMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EMUXKyUXeFEdHrgUgnjAXjM47i4glDYEX/suOpebTDKNaJvQBXfvU1JEmSLLhAXDD
	 kyxAZOuyqfUQMp8pxVxN9pXzIMTLT+mt+9qBl+Uk3ziVSFQXHuf8Ex+5+TiyhLe31D
	 +U1EanNoa7awS82uT3poWsqewREsLaSHupe6kgHyIE2//ynfNnOZF67knToDAsJ9eV
	 eAFeDmxmmRHp3NlULFcbsDq0AlocYupTcaia/j/UAavJp2nkR4KTXUXBcqfau9UKDp
	 o6W2nM9fvpJbyn/+V5WFoh96c4iFuJPHkHJhqfrOpiqmDDM/xsRNn10yti7/bDtDj2
	 aaYrjLUFr1ayQ==
Date: Tue, 22 Apr 2025 08:28:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
 pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <20250422082806.6224c602@kernel.org>
In-Reply-To: <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
	<de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
	<CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
	<06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
	<CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
	<CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
	<20250421182143.56509949@kernel.org>
	<e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 15:49:02 +0200 Andrew Lunn wrote:
> > Interesting. My gut feeling is that even if we make Linux and the NIC
> > behave nicely according to 802.1Q, we'll also need to make some changes
> > on the BMC side. And there we may encounter pushback as the status quo
> > works quite trivially for devices with PHY control in FW.  
> 
> As i see it, we have two things stacked on top of each other. We have
> what is standardised for NC-SI, DSP0222. That gives a basis, and then
> there is vendor stuff on top for multi-host, which is more strict.

The multi-host piece I'd completely ignore. Real multi-host NICs
cannot do without firmware. One component needs to be in control
of global resources, and it can't be a host that may get randomly
rebooted.

> Linux should have generic support for DSP0222. I've seen vendors hack
> around with WoL to make it work. It would be nice to replace that hack
> with a method to tell phylink to enable support for DSP0222. A
> standardised method, since as additional ops, or a flag. phylink can
> then separate admin down from carrier down when needed.

I'm no DSP0222 expert but in my experience it is rather limited in
defining its interactions with the host. It is also irrelevant what
exact tap / agent is asking us to keep the link up. The point is
_some_ agent is running either on the NIC or leeching off the NIC,
and is requesting the link to stay up. It could even be a VF/VM on
the same host.

FWIW in the NFP we just had a "forced" bit which told the host not
to touch physical link status:
https://elixir.bootlin.com/linux/v6.15-rc1/source/drivers/net/ethernet/netronome/nfp/nfp_port.h#L62

A possible extension would be to have a bitmap of possible agent types,
so that the user has more info about what agent is keeping the link up.
But at the end of the day all the link mgmt cares about is whether such
bitmap is empty or not.

> Then we have vendor stuff on top. 
> 
> > BTW Saeed posted a devlink param to "keep link up" recently:
> > https://lore.kernel.org/all/20250414195959.1375031-11-saeed@kernel.org/
> > Intel has ethtool priv flags to the same effect, in their 40G and 100G
> > drivers, but with reverse polarity:
> > https://docs.kernel.org/networking/device_drivers/ethernet/intel/i40e.html#setting-the-link-down-on-close-private-flag
> > These are all for this exact use case. In the past Ido added module
> > power policy, which is the only truly generic configurable, and one we
> > should probably build upon:
> > https://docs.kernel.org/networking/ethtool-netlink.html#c.ethtool_module_power_mode_policy
> > I'm not sure if this is expected to include PCS or it's just telling
> > the module to keep the laser on..  
> 
> Ideally, we want to define something vendor agnostic. And i would
> prefer we talk about the high level concept, sharing the NIC with a
> BMC and multiple hosts, rather than the low level, keep link up.
> 
> The whole concept of a multi-host NIC is new to me. So i at least need
> to get up to speed with it. I've no idea if Russell has come across it
> before, since it is not a SoC concept.
> 
> I don't really want to agree to anything until i do have that concept
> understood. That is part of why i asked about a standard. It is a
> dense document answering a lot of questions. Without a standard, i
> need to ask a lot of questions.

Don't hesitate to ask the questions, your last reply contains no
question marks :)

> I also think there is a lot more to it than just keeping the laser
> on. For NC-SI, DSP0222 that probably does cover a big chunk of the
> problem, but for multi-host, my gut is telling me there is more to it.
> 
> Let me do some research and thinking about multi-host.

The only case that could make multi-host relevant here is if each host
had its own port but they shared some resources like clocks. Making it
a not-really multi-host. I know there are NICs on the market which have
similar limitations on single host. If you configure port breakout all
sub-ports need to run at the same rate. Programming of shared resources
is orthogonal in my mind to a subservient agent asking us not to link
down.

