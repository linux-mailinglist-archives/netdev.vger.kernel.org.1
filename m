Return-Path: <netdev+bounces-184402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CAA953C4
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F54A7A2035
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B611A317E;
	Mon, 21 Apr 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijAbkcmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34512F872
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250750; cv=none; b=Wrwz4RH9ZXL0XRiIvGaMk0lkfwhMf07my/eJ9HWKg9iip/kMW0GJgLcSrInBvlUzB0GdAPc0uWH9ihkm0aFO3cxtimv+v0X5ZCPx/F56cp6p6DTyOokhrqJ4V0z1XvWAr9CyanO6CgGcwuPmlS9UvFjGdO/63bX1LucGfrwPMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250750; c=relaxed/simple;
	bh=IeMA1qCQcsoVeEzUITlEdy448kxdt9xmw+vSAhUwkOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8oun7WY546rUkVhdWf8ppsW6QNZz8T1paq28I6Ws/BOGTAfKrK4+ggzI6Wd5Js/zGbUspQUOGYfXt/cfW98vForyEaWBPcDtz9r4oqXN1AhpwNF2zJn/1AecCJZlYxW3j/uryA0ir2yJbeG2EC8IC6PwWNPp7XGZ9Y8RETXZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijAbkcmG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so37551365e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745250747; x=1745855547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCKDTxNs/yD7VynJllIcjSn4h1n19mQA2EzB8pMbjJA=;
        b=ijAbkcmGVffaMdkqNPTVRXQXQcLDZi7HVF8hXMKO2IxYWfUcy1xpUu0UeTlzhDZo3G
         7fnZywdlAQvlOakwKaQaV/rBM16EeFzdNeEjScByYGmIMa/zJ4kofcQu9WSuX7JEE6yg
         8hjJaQxgDv6lJgwEA6yY5uaWek40Chjw+Oah0BWItJfK+wl/NI12oGeW4I1B2Vf4oWhd
         0SxSksnMscYzibF9Tw7C1P7xMg9hubrp5QZoWUwAhzmNPneMWlGPa0x0qbpMW4/n9iau
         P/noH5fYSZEELkC+z7gAGX4E9NX5F+O9WG4zV4m7rHGKtlFuVPc8GdZXnLClx0r9/4pp
         jW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745250747; x=1745855547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCKDTxNs/yD7VynJllIcjSn4h1n19mQA2EzB8pMbjJA=;
        b=C0AzeHtXY/gXANtGtlT5fVcvoAEvAbhPy4QVidZms7kbTsFQKtjlgsQtROimrIU7RO
         +bf01SXrUW9xW7FYNW8nSZIekkuJiI9DhsoBmeYPf4pXYXRkbUTCuhVi7rzEzsd0hGps
         RtGHwJWmTM23E+qK6uXIvzYESN9qkctACIAF0VDf3PiEdjm+od8GJRap3VYH15dtg9V6
         oqtudno+JZ0ZzNq19gx38uY1kpdFO+e5QDcVTARs3eMGa62TEc0K1ipB4K3ZqPPY/j4s
         88GvMsU4DlEjP2mrYSvIWIl2DihOMKcwFi0MG05yokMQjD19hxrJAlb2mpH6wo8Y9II2
         CG5w==
X-Gm-Message-State: AOJu0YyRL0DdmwCYafr8ovj9Dqk4OCWZZKfhzfmWOITLwggQ9j86Z6hl
	tZYpreApwHLfmpXUDWL5ytTVkrYRvrogtq3L6p8CoZ6jh7+9QnNDhYlNcHYg9N4w6DMAbDuOMhH
	WDEsvOV6+SUnhCTEujffq3SojUvA=
X-Gm-Gg: ASbGncsrDFUl32rBQKVSUjrzh6NPivjknx6gRcE+iV5pXu04ZTIRUx6coZcPWSKJXEr
	CB2N+h/CyxS1BvPDadZRDow5mIcYnz5Se3dNy+QYhHzguUOWDurP3f39BtvxyNmNpMqALDw5ttb
	tduxSmXtkaucM7KDKsM2aBBVfjm87FiIRN+olFe7MnD8BEssdN2xwG8Ic=
X-Google-Smtp-Source: AGHT+IFUCJvlE0UfJ3Od4gfF+8PnqznZy3WW1GGpmpKcika2R5ffPaFZhkdOjSLkbf9ZJOyiS8/5/F89CvZGTDltp9o=
X-Received: by 2002:a05:6000:40cf:b0:391:2e0f:efce with SMTP id
 ffacd0b85a97d-39efba2607cmr9578513f8f.1.1745250746918; Mon, 21 Apr 2025
 08:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch> <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
In-Reply-To: <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 21 Apr 2025 08:51:50 -0700
X-Gm-Features: ATxdqUHB8ZB3P7WYU0S3mv2EZXt4Uf94rnpnL3VRun67nhoiAOQ-zA10Sed6rBQ
Message-ID: <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 2:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > >   The actual link settings are controlled by the host NC driver when
> > >   it is operational. When the host NC driver is operational, link
> > >   settings specified by the MC using the Set Link command may be
> > >   overwritten by the host NC driver. The link settings are not
> > >   restored by the NC if the host NC driver becomes non
> > >   operational.
> > >
> > > There is a very clear indication that the host is in control, or the
> > > host is not in control. So one obvious question to me is, should
> > > phylink have ops into the MAC driver to say it is taking over control=
,
> > > and relinquishing control? The Linux model is that when the interface
> > > is admin down, you can use ethtool to preconfigure things, but they
> > > don't take affect until the link is admin up. So with admin down, we
> > > have a host NC driver, but it is not operational, hence the Network
> > > Controller is in control of the link at the Management Controllers
> > > bequest. It is only with admin up that phylink takes control of the
> > > Network Controller, and it releases it with admin down. Having these
> > > ops would also help with suspend/resume. Suspend does not change the
> > > admin up/down status, but the host clearly needs to hand over control
> > > of the media to the Network Controller, and take it back again on
> > > resume.
> >
> > Yes, this more-or-less describes the current setup in fbnic. The only
> > piece that is probably missing would be the heartbeat we maintain so
> > that the NIC doesn't revoke access due to the OS/driver potentially
> > being hung.
>
> That probably goes against the last sentence i quoted above. I do
> however understand why you would want it. Can the host driver know if
> the Network Controller has taken back control? Or does the heartbeat
> also act as a watchdog, the host does not need to care, it is about to
> experience a BMC induced reboot?

The heartbeat acts as a two way watchdog of sorts. Basically if the
firmware doesn't receive one every 2 minutes (was 10 seconds, but
there are BIOS bugs that cause things to literally lock up for over 90
seconds in early UEFI boot that we just had to work around), it will
evict the host and reject all further heartbeat requests. Likewise if
the FW receives a heartbeat without the host first claiming ownership
it will send back a rejection. If the host sends a heartbeat and the
FW rejects it or we don't receive a response, then we know we have
somehow lost ownership and we in turn will back off and reinitialize
ourselves. Currently the two cases we have seen this get triggered is
either due to a OS/BIOS CPU lockup and/or hang, or due to the FW
crashing and rebooting.

> > The other thing involved in this that you didn't mention
> > is that the MC is also managing the Rx filter configuration. So when
> > we take ownership it is both the Rx Filters and MAC/PCS/PHY that we
> > are taking ownership of.
>
> That does not seem consistent with the standard. The Set Link command
> i quoted above makes it clear that when the host driver is active, it
> is in control of the media. However the Set VLAN Filter command,
> Enable VLAN command, Set MAC Address command, Enable Broadcast Filter
> command, say nothing about differences when the Host driver is
> operational or not. It just seems to assume the Management Controller
> and the host share the resources, and try not to stomp over each
> other. Does fbnic not follow the standard in this respect? However,
> from a phylink perspective, i don't think this matters, phylink is not
> involved with any of this.

Yes, there are going to be deviations from the standard and for me it
is kind of a blurred line as I haven't done the 1G stuff in a while so
I keep defaulting to multi-host NIC thinking. The host driver is
managing the Rx filter config and the MAC/PCS directly and indirectly
ordering the FW to configure the PHY, at least until we can implement
the code to allow direct access in the 2 host mode. The FW effectively
becomes a relay between the host and the external entities such as the
SFP, BMC, GPIO, etc. On 1G there were checks that the host driver had
to perform to make sure not to touch the link but the Rx filter config
was more inline in front of the host filtering rather than
incorporated as a part of it as it is in our setup.

What we did in fbnic was to reserve the first 4 MAC TCAM addresses for
the BMC. One complication we ran into though is that by default the
BMC will run in multicast promiscuous mode. So we had to add logic to
allow the host to reorder things so that the multicast promisc filter
is at the end of the multicast address list routed only to BMC, and
the BMC gets included as a destination for all the multicast filters
added by the host. In addition we have to notify the FW of our MAC
config so that it can direct BMC traffic to the host as needed.

> > The current pattern in fbnic is for us to do most of this on the tail
> > end of __fbnic_open and unwind it near the start of fbnic_stop.
> > Essentially the pattern is xmit_ownership, init heartbeat, init PTP,
> > start phylink, configure Rx filters. In the case of close it is the
> > reverse with us tearing down the filters, disabling phylink, disabling
> > PTP, and then releasing ownership.
> >
> > > Also, if we have these ops, we know that admin down/suspend does not
> > > mean media down. The presence of these ops triggers different state
> > > transitions in the phylink state machine so that it simply hands off
> > > control of the media, but otherwise leaves it alone.
> > >
> > > With this in place, i think we can avoid all the unbalanced state?
> >
> > As I understand it right now the main issue is that Phylink assumes
> > that it has to take the link down in order to perform a major
> > configuration in phylink_start/phylink_resume.
>
> Well, as i said, my reading of the standard is that the host can make
> disruptive media changes, so you have to be able to live with
> disruptive media changes. If you have to live with it, the path of
> lease resistance is just to accept it.

The problem is that precedent has been set by the other multi-host NIC
vendors that didn't go w/ phylink. The argument will be that we either
move the MAC/PCS/PHY to firmware and make it work like the other
vendors or we are essentially DOA.

> > The requirement that the BMC not lose link comes more out of the
> > multi-host setups that have been in place in the data center
> > environment for the last decade or so where there was only one link
> > but multiple systems all sharing that link, including the BMC. So it
> > is not strictly a BMC requirement, but more of a multi-host
> > requirement.
>
> Is this actually standardised somewhere? I see there is a draft of an
> update to NC-SI Specification, but i don't think the section about
> controlling the link has changed. Also, the standard talks about how
> you connect one Management Controller to multiple Network
> Controllers. There is nothing about multiple Management Controllers
> connected to one Network Controller. Or i'm i missing something, like
> one Management Controller is controlling all the host connected to the
> Network Controller?

As far as a standard I can't say if it is. By and large our
requirements have been coming out of the fact that Broadcom or
Nvidia/Mellanox did it this way so we are expected to do it the same
way. So essentially I am dealing with project/platform requirements
more than a standard.

The issue isn't that we have multiple management controllers, it is
that we have setups where one physical MAC/PCS/PHY is shared between 4
PCIe connections to 4 seperate hosts. This is one of the reasons why
so many NICs now have the proprietary FW blob you have to talk to in
order to configure anything. This is also what we were trying to get
away from as the shared resources have a bad habit of creating other
issues such as noisy neighbor problems.

> > > So, can we ignore the weeds for the moment, and think about the big
> > > picture?
> >
> > So big picture wise we really have 2 issues:
> > 1. The BMC handling doesn't currently exist, so we need to extend
> > handling/hand-off for link up before we start, and link up after we
> > stop.
>
> Agreed, and that fits with DSP0222.
>
> > 2. Expectations for our 25G+ interfaces to behave like multi-host NICs
> > that are sharing a link via firmware. Specifically that
> > loading/unloading the driver or ifconfig up/down on the host interface
> > should not cause the link to bounce and/or drop packets for any other
> > connections, which in this case includes the BMC.
>
> For this, it would be nice to point to some standard which describes
> this, so we have a generic, vendor agnostic, description of how this
> is supposed to work.
>
>         Andrew

The problem here is this is more-or-less a bit of a "wild west" in
terms of the spec setup. From what I can tell OCP 3.0 defines how to
set up the PCIe bifurcation but doesn't explain what the expected
behavior is for the shared ports. One thing we might look into would
be the handling for VEPA(Virtual Ethernet Port Aggregator) or VEB
(Virtual Ethernet Bridging) as that wouldn't be too far off from what
inspired most of the logic in the hardware. Essentially the only
difference is that instead of supporting VFs most of these NICs are
supporting multiple PFs.

