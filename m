Return-Path: <netdev+bounces-184309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF6DA948D0
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABFB16C808
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6311EB19F;
	Sun, 20 Apr 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAn6oWeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584381E7C09
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173159; cv=none; b=g6WTp9mcpBrmO4Efg2UJZf+VcBmjeY2i7X+0C4NcZxDXR4trIF0IG7jLmXli3EW+hAn7y0BP2+yrsUXSJNRjD3dO4IhAZ6f11t49FhCuLQVeG4uQso2/QfjS3YV31ftJkLm85cx9lc2GY6P1yrHqgIBQYVgpVPHMwewXZycVTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173159; c=relaxed/simple;
	bh=ZAzKwQUkyX2EOnCFN3Q+ujxi/zYDkekCSD3FRgCgNn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERMMIVquGfPnx3v7zpyXdkty6/EUoc91TIdmTe3V58w40cMoEZ3iMYbPP/8LsbrqGSXxea5UsDFTw4zTNScThHPz02E6vn/1i0lc2V7x5SUJU4NbFQyUmbbbJXGDPbdS/S/4LTMP3dkM3/P+18utXueG+Y21/M316SWUdkN/7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAn6oWeZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso26262965e9.0
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745173155; x=1745777955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aAT63TIvz6MhHnQ04Sw2PBb71VwoWoFqmaOvVyi47Y=;
        b=mAn6oWeZeXuHx0VbDxeQJLXBaGlUkmJBEJaXzs+71yp+3v2Yf9Am4Phnyx2X83zm9Z
         mjdCQU3tLtA5kDL1wG3KhWbvOx0thxU6crUv4hZCeSnOIk+XaJeCVPpVVw9rAVHoBw9d
         SOm4Pl3caH3JYtNAszPKBwKDdN23RzfB2xU+UPlfdJ5jXHGD8LctQtI6o/kF+9vidjYS
         ehV4zc8N/T65NrND8EuV7k7YgA7JPhS0AdB0rnLrry0PenRHiKg5AEhAogZIlYTIGjqm
         4g3vXXtX+i5vsKJBT9k5l/fZOpWcf6iMnepDbP0UMhmzBGuEn3HulNh3w8gP2PaOX5xI
         M2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745173155; x=1745777955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aAT63TIvz6MhHnQ04Sw2PBb71VwoWoFqmaOvVyi47Y=;
        b=N1+ZsHY3Jv9M1JEsbwJ9goIZ+19r775+lKl8SoWn/y4jpDRFkQEzSs0g2HupnGx+Ls
         L5/UZgOFwVoksaMvwVAn4+sP4+wNhLQyFovpyduMzjO1TFUAuc/ClT3Ag96se4GwWA6C
         RiSxgxFkIV2xnrrBMstDXUjsBIVQnqEtLycH8SCR623u8NiHkunu00j/zM+VfXVFuHtz
         NQi3WNNoRHMAw5CAlx3V5jAnQkAx2D8GfSdRad7b6cXGQMmPDciT0hN+zkWe0mv8N/P/
         llnWGjKzUM4K1y9fAJYv8yvzausfTyT7TOetBbOidakrGy+tuqquIg8uO9z5KhYDyC2z
         QK7A==
X-Gm-Message-State: AOJu0Yy54NEjTlDrg3aVyyX3j+M0mA47AWzOwWADtLrXDKhMozF/Vyzk
	8e94tHYB/fNVX+sxs9r8KdDHOcaLoL4SVjXkvnDzSGyujyt2pRWGWf3hcQrT3rXDZ0Nu0gWJqhp
	6gjRyY+2Bjhf5v0P5W7wQEwWSVNo=
X-Gm-Gg: ASbGnctPfRAiaTnszKNS6LAPWTYVq60NfEznDBKDSalkonnjv0Ge+S/qRa085wr5MXl
	6kBcDNLpBABubifv1hTPBjiJ/W39Fwqcw7F7s6+d5003Uk4TspGu2Ds0cIhptsQ+nBdu6xK9bcu
	gLGgfce/btY6ve9jH0IOJQX1Ni2UbO9+sv8khzVSgRzJgkXElcuJZZKUA=
X-Google-Smtp-Source: AGHT+IFW78oG/z6WvaMVMeo40IA8wKdI7LYfuRkmj6gm6eQP5er5s+pA2yrRLRnhzM5klqNz5YKeUOoOrEjUfD3aAqA=
X-Received: by 2002:a05:600c:a405:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-4407163e193mr72022195e9.10.1745173155282; Sun, 20 Apr 2025
 11:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
In-Reply-To: <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 20 Apr 2025 11:18:39 -0700
X-Gm-Features: ATxdqUEuY-GtRWi0whhz7JqCZr53dCE4H9Dn8lVfP9Ima6CcB-Cg8MdaodD9-fI
Message-ID: <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 11:11=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Wed, Apr 16, 2025 at 08:28:46AM -0700, Alexander Duyck wrote:
> > Address two issues found in the phylink code.
> >
> > The first issue is the fact that there were unused defines that were
> > referencing deprecated macros themselves. Since they aren't used we mig=
ht
> > as well drop them.
> >
> > The second issue which is more the main reason for this submission is t=
he
> > fact that the BMC was losing link when we would call phylink_resume. Th=
is
> > is fixed by adding a new boolean value link_balanced which will allow u=
s
> > to avoid doing an immediate force of the link up/down and instead defer=
 it
> > until after we have checked the actual link state.
>
> I'm wondering if we have jumped straight into the weeds without having
> a good overall big picture of what we are trying to achieve. But maybe
> it is just me, and this is just for my edification...
>
> As i've said a few times we don't have a good story around networking
> and BMCs. Traditionally, all the details have been hidden away in the
> NIC firmware, and linux is pretty much unaware it is going on, at
> least from the Host side. fbnic is changing that, and we need
> Linux/phylink to understand this.
>
> Since this is all pretty new to me, i went and quickly read:
>
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.1.=
0.pdf
>
> Hopefully i now have a better big picture.
>
> Figure 2 answers a few questions for me. One was, do we actually have
> a three port switch in here? And i would say no. We have something
> similar, but not a switch. There is no back to back MAC on the host
> PCI interface. We do have back to back MAC on the NC-SI port, but it
> appears Linux has no knowledge of the NIC NC-SI MAC, and the BMC is
> controlling BMC NC-SI MAC.
>
> Not having a switch means when we are talking about the MAC, PCS, PHY
> etc, we are talking about the media side MAC, PCS, PHY. Given that
> phylink is just as often used with switches with a conduit interface
> and switch ports, that is an important point.
>
> Figure 2 also hints at there being three different life cycles all
> interacting with each other. Our normal model in phylink is that the
> Network Controller is passive, it is told what to do by
> Linux/phylink. However, in this setup, that is not true. The Network
> Controller is active, it has firmware running on it. The Network
> Controller and the Management Controller life cycle probably starts at
> about the same time, when the PSU starts generating standby power. The
> host life cycle starts later, when the BMC decides to power up the
> host.
>
> The NC-SI protocol defines messages between the Management Controller
> and the Network Controller. One of these messages is how to configure
> the media side. See section 8.4.21. It lists different networks speeds
> which can be negotiated, duplex, and pause, and if to use
> auto-neg. There is not enough details to fully specific link modes
> above 1000BaseT, all you can request for example is 40G, but you
> cannot say CR4, KR4, SR4, or LR4. There also does not appear to be a
> way to ask the network controller what it actually supports. So i
> guess you normally just ask for everything up to 100G, and you are
> happy when Get Link Status response command says the link it 10BaseT
> Half.

In our case this is one of the reasons why the firmware knows what the
interface and media type are before we do. It basically has it coded
into the EEPROM so that it will identify the type as CR and normally
it informs the BMC and the host of the speed/FEC of the port as well.
So the BMC could configure this, but it is normally getting this info
from the NIC as it is setup to bring the link up before the BMC even
gets a chance to ask to setup the config.

> The Network Controller needs to be smart enough to get the link up and
> running. So it basically has a phylink implementation, with a PCS
> driver, 0 or more PHY drivers, SFP cage driver, SFP driver etc.
>
> Some text from the document, which is pretty relevant to the
> discussion.
>
>   The Set Link command may be used by the Management Controller to
>   configure the external network interface associated with the channel
>   by using the provided settings. Upon receiving this command, while
>   the host NC driver is not operational, the channel shall attempt to
>   set the link to the configuration specified by the parameters. Upon
>   successful completion of this command, link settings specified in
>   the command should be used by the network controller as long as the
>   host NC driver does not overwrite the link settings.
>
>   In the absence of an operational host NC driver, the NC should
>   attempt to make the requested link state change even if it requires
>   the NC to drop the current link. The channel shall send a response
>   packet to the Management Controller within the required response
>   time. However, the requested link state changes may take an
>   unspecified amount of time to complete.
>
>   The actual link settings are controlled by the host NC driver when
>   it is operational. When the host NC driver is operational, link
>   settings specified by the MC using the Set Link command may be
>   overwritten by the host NC driver. The link settings are not
>   restored by the NC if the host NC driver becomes non
>   operational.
>
> There is a very clear indication that the host is in control, or the
> host is not in control. So one obvious question to me is, should
> phylink have ops into the MAC driver to say it is taking over control,
> and relinquishing control? The Linux model is that when the interface
> is admin down, you can use ethtool to preconfigure things, but they
> don't take affect until the link is admin up. So with admin down, we
> have a host NC driver, but it is not operational, hence the Network
> Controller is in control of the link at the Management Controllers
> bequest. It is only with admin up that phylink takes control of the
> Network Controller, and it releases it with admin down. Having these
> ops would also help with suspend/resume. Suspend does not change the
> admin up/down status, but the host clearly needs to hand over control
> of the media to the Network Controller, and take it back again on
> resume.

Yes, this more-or-less describes the current setup in fbnic. The only
piece that is probably missing would be the heartbeat we maintain so
that the NIC doesn't revoke access due to the OS/driver potentially
being hung. The other thing involved in this that you didn't mention
is that the MC is also managing the Rx filter configuration. So when
we take ownership it is both the Rx Filters and MAC/PCS/PHY that we
are taking ownership of.

The current pattern in fbnic is for us to do most of this on the tail
end of __fbnic_open and unwind it near the start of fbnic_stop.
Essentially the pattern is xmit_ownership, init heartbeat, init PTP,
start phylink, configure Rx filters. In the case of close it is the
reverse with us tearing down the filters, disabling phylink, disabling
PTP, and then releasing ownership.

> Also, if we have these ops, we know that admin down/suspend does not
> mean media down. The presence of these ops triggers different state
> transitions in the phylink state machine so that it simply hands off
> control of the media, but otherwise leaves it alone.
>
> With this in place, i think we can avoid all the unbalanced state?

As I understand it right now the main issue is that Phylink assumes
that it has to take the link down in order to perform a major
configuration in phylink_start/phylink_resume. However in the case of
fbnic what I do a check in mac_prepare to see if I even really need to
take the link down or not to support the requested mode. If not then I
skip the destructive settings update and tweak a few minor things that
can be updated without taking the link down. So I think the change I
am making is that mac_prepare before assumed it was just disabling
things from the SerDes down, and I think I pulled that up to the MAC
layer which may be a departure from previous expectations.

> What is potentially more interesting is when phylink takes control. Do
> we have enough information about the system to say its current
> configuration is the wanted configuration? Or are we forced to do a
> ground up reconfiguration, which will include a media down/up? I had a
> quick scan of the document and i did not find anything which says the
> host is not allowed/is allowed to do disruptive things, but the text
> quoted above says 'The actual link settings are controlled by the host
> NC driver when it is operational'. Controlling the link settings is a
> disruptive operation, so the management controller needs to be
> tolerant to such changes.

In the case of fbnic we have a test we can do to verify we are linked
at the correct fec/modulation/lane width via a check of signal outputs
from the PCS. Basically we have one master bit that says link is
present, but then we can inspect the individual values on a per
FEC/lane/modulation basis. So we can do a link check for a specific
interface type and verify if the link is up and configured for the
settings we want.

Historically speaking, drivers in the past did disruptive things while
the BMC was up. That is one of the things that caught me off-guard
with Meta's requirements. I had been used to dealing with 1G BMC on
most enterprise hardware and in the case of those we end up bouncing
the link state when the link is configured. I had gotten quite used to
seeing that on igb some time ago as I have had a 1G system with igb
and a BMC for years and got used to the SoL console stalling as the
igb reconfigured the link.

The requirement that the BMC not lose link comes more out of the
multi-host setups that have been in place in the data center
environment for the last decade or so where there was only one link
but multiple systems all sharing that link, including the BMC. So it
is not strictly a BMC requirement, but more of a multi-host
requirement.

> So, can we ignore the weeds for the moment, and think about the big
> picture?

So big picture wise we really have 2 issues:
1. The BMC handling doesn't currently exist, so we need to extend
handling/hand-off for link up before we start, and link up after we
stop.
2. Expectations for our 25G+ interfaces to behave like multi-host NICs
that are sharing a link via firmware. Specifically that
loading/unloading the driver or ifconfig up/down on the host interface
should not cause the link to bounce and/or drop packets for any other
connections, which in this case includes the BMC.

