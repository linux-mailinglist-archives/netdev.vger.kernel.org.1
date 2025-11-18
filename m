Return-Path: <netdev+bounces-239304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D1FC66BCB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 584DA4E8B6F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1420DD75;
	Tue, 18 Nov 2025 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmiOkBLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507A2F49EF
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427160; cv=none; b=JL4G5C2bbnHhMCEGAOEqddn7ieeJPxLiTIHYWNk3ZmrTf3Y3Z56FKw9LWzJ8SpboZZnJDSYNJOXzHBDssEkLgE9qkm6BF6jRR59qKZfCyCrt939WEd0aAVRLv7v0f2SOSCfMlafPD8pDgBEMgDR4S5cs/bAq8LePHqwOVYyQozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427160; c=relaxed/simple;
	bh=YhK01yEm8Or5m4iJRKQEVOBZx+xr+W3uS2qAVqJnMsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+XZM1sRGD8uKMS4f2F5cgt2yfQumu9fXLHJM+fWnTL4gr3VV72ETXeSyKuRWi7XPrrVl0P+ZpA2gb//6OZ+qH5/rRdyZu5WquNrj4d9FTZI8QsfK002HAdcgxmbCxw23DgMPOOf3fyD/6qtShSH/pZgUY/KghdpmOAcEi5Z1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmiOkBLn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso3946293b3a.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763427157; x=1764031957; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7xkfyBzlpHLk6cYkYqCdyQYs7/2JZrSvHXCymLJB1fk=;
        b=dmiOkBLn8dmTM+kwMGnjMq084atxuu0jGV0GHza1jye3QcS26DmgrN7qVspkY1deB1
         +QEat55anVHVhL/5kWvDHynPnSnr1oa8mBhbvFUFY0T8IPWvH/Hl0QKOi1hluVOpu8Gr
         wyWBUVfdUM3hdQ+CMO9tTYqZXhG4FdmMvrL1MB0tuJ6z3aNB62m4yr08Rg7VcdIEM9Cx
         a/0q6FvXVKH5mJuTSCVZgUI2C2gUgunzsbPfVW6/c7VDMcZbO+IwtOhKap7TrgZvudet
         dmJum9PiaXtGGx1rmPwhhqLiy5mbcIPpvC3BWbqHVUP7+clAW8WcYytcz8TYZQBLPl76
         v7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427157; x=1764031957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xkfyBzlpHLk6cYkYqCdyQYs7/2JZrSvHXCymLJB1fk=;
        b=wYEFBpVl+yeW99dqBFmRiMgKocoVLDrlDeLQQlI2H8wzxQdCuO56pDyDU3SHedpMTV
         IaCY39Bv35GQuhQQaaQV1X8U7/MarSFjEqkhoWpz1Ej4dnpWA+KXbxBLLYhSr7Cvez95
         6O7oMURJr22fASomHt1Tel5qh7fcVOkGxCvaFGA2lgylvpKHZVwfh5tPxw5r59arEB1r
         G2p0A+cQvl0HxGqfQEZsqJPkwUsKFO7ErXM8e2dk3+lIlIStwcCKVwaaHvxgaT7DaF6B
         vnhYaFVpEsDAIRi0HSVCbO7t5Fj1J9xNfyFAZHxNRsL6xrzTI8nPmAbw98qosvYPyHaH
         PdBA==
X-Forwarded-Encrypted: i=1; AJvYcCUeyqctO8bRXKDPfi81jKuePuxtSwyxWwzdbtcBhp4CZj9jdN4q1exvi3Z89VTJeyTmHCXL05g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO43mPqDROVH59ADAN+6YcleiMIsB1MZydeWeiCf4jR/9MnUkj
	oybW5JXAXmbRhNfCqz5NkX60TkVZbZt79aueAOHyi94yEhg/OtXv5avg
X-Gm-Gg: ASbGncs7xuhUJARzd7QheeUEidk8Lvn5UMBa5z9PlxlQFBxiio1Xw5y29brJSnQXEdV
	TEFUGLBSaO27etxqc0+WyqQnecXa1OzRzHaaUswJrXgWH/yXpksDVW/yA6DhEqNdKZW+kTLVGmj
	bnLZf9QoMHCKH5dnGJGU1RPF4YUU5QnYI/jB8t/PxkitcSTxtW82J1eoy1Qql0xB82hP4WdsbBn
	cCyH0sjYZJY712V9v/vQp+uYhy/vjWUHLB4xftUr9e5Wv7nIOtOp0Oc0LMYJ4PqOXweM0ZnJFbT
	DVbLAFtZgLTAIc2a6juh+OhiJxYgQ9shm6YGr/Q5qbgtUpWRcOf05YkRCW3ZJe2aCp2LZ9UWvOS
	4H6tLlKgv7jBU1udZMrVjuM3K/hSdfXaKtJz4Olj8R68jQcY1LuYripw7RlYteN8+9jq9w6RdSl
	pZa8lselmV/AViHgJGyJlOYE5+w8NfZIEg7X2kQOwNgboGo1dKgPrlwbUuLZmqnlP/1A==
X-Google-Smtp-Source: AGHT+IHI6r30fmHCfJda6Wio1aA9zaaV2vJoyHVqRCkPlOwNOBPcbPMld3Tka8Rft1T7PFly+o22OQ==
X-Received: by 2002:a05:6a00:1306:b0:7a9:d1ca:8a44 with SMTP id d2e1a72fcca58-7ba3c66777amr16998865b3a.24.1763427157372;
        Mon, 17 Nov 2025 16:52:37 -0800 (PST)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7b927c24254sm14528058b3a.64.2025.11.17.16.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:52:36 -0800 (PST)
Message-ID: <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
Subject: Re: Ethtool: advance phy debug support
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Lee Trager <lee@trager.us>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Susheela Doddagoudar	
 <susheelavin@gmail.com>, netdev@vger.kernel.org, mkubecek@suse.cz,
 Hariprasad Kelam <hkelam@marvell.com>, Alexander Duyck
 <alexanderduyck@fb.com>
Date: Mon, 17 Nov 2025 16:52:35 -0800
In-Reply-To: <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
References: 
	<CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
	 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
	 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
	 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
	 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
	 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
	 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-16 at 00:27 +0100, Andrew Lunn wrote:
> > PRBS testing can be used as a signal integrity test between any two end
> > points, not just networking. For example we have CSRs to allow PRBS tes=
ting
> > on PCIE with fbnic. My thought was always to limit the scope to network=
 use
> > case. The feedback I received at Netdev was we need to handle this
> > generically for any phy, thus the suggestion to do this on phy. That ad=
ds a
> > ton of complexity so I'd be supportive to narrow this down to just
> > networking and leverage ethtool.
>=20
> We need to be careful with terms here. We have PHYs driven by phylib,
> bitstreams to signals on twisted pairs, drivers/net/phy
>=20
> And we have generic PHYs, which might contain a SERDES, for PCIE,
> SATA, USB, /drivers/phy.
>=20
> Maxime reference to comphy for Marvell is a generic PHY, and they do
> implement SATA, USB and networking.
>=20
> Having said that, i don't see why you should not narrow it down to
> networking, and ethtool. It might well be Marvell MAC drivers could
> call into the generic PHY, and the API needed for that should be
> reusable for anybody wanting to do testing of PCIE via a PRBS within a
> generic PHY.
>=20
> As i said before, what is important is we have an architecture that
> allows for PRBS in different locations. You don't need to implement
> all those locations, just the plumbing you need for your use case. So
> MAC calling phylink, calling into the PCS driver. We might also need
> some enumeration of where the PRBSes are, and being able to select
> which one you want to use, e.g. you could have a PCS with PRBS, doing
> SGMII connecting to a Marvell PHY which also has PRBS.

It seems to me like we would likely end up with two different setups.
For the SerDes PHYs they would likely end up with support for many more
test patterns than a standard Ethernet PHY would.

I know I had been looking at section 45.2.1.168 - 45.2.1.174 of the
IEEE 802.3 spec as that would be the standard for a PMA/PMD interface,
or section 45.2.3.17 - 45.2.3.20 for the PCS interface, as to how to do
this sort of testing on Ethernet using a c45 PHY. I wonder if we
couldn't use those registers as a general guide for putting together
the interface to enable the PHY testing with the general idea being
that the APIs should translate to similar functionality as what is
exposed in the IEEE spec.

> > > That actually seems odd to me. I assume you need to set the link mode
> > > you want. Having it default to 10/Half is probably not what you
> > > want. You want to use ethtool_ksettings_set to force the MAC and PCS
> > > into a specific link mode. Most MAC drivers don't do anything if that
> > > call is made when the interface is admin down. And if you look at how
> > > most MAC drivers are structured, they don't bind to phylink/phylib
> > > until open() is called. So when admin down, you don't even have a
> > > PCS/PHY. And some designs have multiple PCSes, and you select the one
> > > you need based on the link mode, set by ethtool_ksettings_set or
> > > autoneg. And if admin down, the phylink will turn the SFP laser off.
> >=20
> > fbnic does not currently support autoneg
>=20
> autoneg does not really come into this. Yes, ksettings_set can be used
> to configure what autoneg offers to the link partner. But if you call
> ksettings_set with the autoneg parameter set to off, it is used to
> directly set the link mode. So this is going to be the generic way you
> set the link to the correct mode before starting the test.
>=20
> fbnic is actually very odd in that the link mode is hard wired at
> production time. I don't know of any other device that does
> that. Because fbnic is odd, while designing this, you probably want to
> ignore it, consider 'normal' devices making use of the normal
> APIs. Maybe go buy a board using stmmac and the XPCS_PCS driver, so
> you have a normal system to work on? And then make sure the oddball
> fbnic can be somehow coerced to do the right thing like normal
> devices.

It isn't so much hard wired as limited based on the cable connected to
it. In addition the other end doesn't do any sort of autoneg. In theory
we should be able to resolve much of that once we get the SFP framework
updated so that it can actually handle QSFP and reading the CMIS and
SFF-8636 EEPROMs. Doing that we can at least determine what the media
supports and just run with that. Arguably much of the weirdness is due
to the 50R2 implementation as that seems to be where everything
diverges from the norm and becomes a parallel 25G setup without much
support for autoneg.

As far as the testing itself, we aren't going to be linking anyway. So
the configured speed/duplex won't matter. When we are testing either
the PCS or the PMA/PMD is essentially running the show and everything
above it is pretty much cut off. So the MAC isn't going to see a link
anyway. In the grand scheme of things it is basically just a matter of
setting up the lanes and frequency/modulation for those lanes.

The way I see it we need to be able to determine the number of lanes,
frequency, and then the test pattern we need to operate at. One of the
things is that the PMA/PMD interface provides tuning variables for
equalization based on if we are running with NRZ/PAM2 (4.2.1.112) or
PAM4 (4.2.1.135).

> > > > When I spoke with test engineers internally in Meta I could not com=
e up with
> > > > a time period and over night testing came up as a requirement. I de=
cided to
> > > > just let the user start and stop testing with no time requirement. =
If
> > > > firmware loses the host heartbeat it automatically disables PRBS te=
sting.
> > > O.K. So i would probably go for a blocking netlink call, and when ^C
> > > is used, to exits PRBS and allows normal traffic. You then need to
> > > think about RTNL, which you cannot hold for hours.
> > RTNL() is only held when starting testing, its released once testing ha=
s
> > begun. We could set a flag on the netdev to say PRBS testing is running=
,
> > don't do anything else with this device until the flag is reset.
>=20
> Its the ^C bit which makes it interesting. The idea is used other
> places in the stack. mrouted(1) and the kernel side for multicast
> routing does something similar. So long at the user space daemon holds
> the socket open, the kernel maintains the multicast routing
> cache. Once the socket is closed, because the daemon as died/exited,
> the kernel flushes the cache. But this is an old BSD sockets
> behaviour, not netlink sockets. I've no idea if you can do the same
> with netlink, get a notification when a process closes such a socket.
>=20
> 	Andrew

This is one of the reasons why I was thinking of something like a
phydev being provided by the driver. Specifically it provides an
interface that can be inspected by a netdev via standard calls to
determine things like if the link is allowed to come up. In the case of
the phydev code it already had all the bits in place for PHY_CABLETEST
as a state.

Assuming we have something like that buried somewhere in the PHY,
either as a part of the PMAPMD or the PCS drivers we could then look at
having a state there that essentially communicates that "this device is
testing so brining the link up is blocked". Then it would just be a
matter of making sure you can pop the device into and out of that state
while holding the RTNL lock without having to hold it for the full
duration.

