Return-Path: <netdev+bounces-185781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D4A9BB68
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA54A4F16
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A428DF14;
	Thu, 24 Apr 2025 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFEjFkeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887211F1520
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538073; cv=none; b=jlnODS0JkgSZ4vtm5r3X2i558MCMp3+/N/KSJDidhrHgkjPc4+ynpTm3QFeQcdFr7nZjP+281LGxfK889ap8K1UVzpIqm01oKevcMLbQPSJRqTEVBoFi7Ium8XMrr2Ufls62x8UtWw2ENLKy/DK+bZjs94fIvJ1sK8UT6j9kYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538073; c=relaxed/simple;
	bh=2bW7QHNW9hPY9TZooAP4iIHnCUga3DhSP4SbAG8Mmew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHqjpzdpm5RoknPZInZNa79X+pNK+YukWrdWOHhdz1mV1khMZwuAFPAd54SB2VOQUATYwnQsEKNgZR60RuxgiR4YaETGrva+zHluR9ugLKCrvs+0MyV0624AOTzx/4NcAWdvd+LlunwrMrQrzwTn2OajUuj9pdNa1g6sF8kAVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFEjFkeD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39ac9aea656so1955262f8f.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745538070; x=1746142870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkhmAzi+eF0XhuqfsboOyR4oCkb2qkZo5aNBqcCXnSE=;
        b=HFEjFkeDIZ1xadIe8+2Ozxe6xOSgGAlqo5JqVsN+koigEo+eEy+GXnYTYs92g+Zzmz
         qXMBbI/vsm9oUY71yKBBG2nCGM/V3vEBIpAaM4DNze5IZWBYvbhAG/2OiSVoE+XM+B4k
         l24lIpTEetToBzroUZf/qSqW4FGgU86N3sKGmbPgku3PdVkm+UyNZ6FCpiqAyg+zmKxi
         CR9F2AnNo+WBpE+EWBkMALkmYYEZl1vsYkLd4N+ySCcfxmSzdrI3k5Tp+Thnbpi9T0l9
         B7vUxR6ro4RtBHy5EUinr8mcvNJKQiajFxs6j7xtJQaKtkvHwZ6KvW3L/U72vpZPua6+
         YRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745538070; x=1746142870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkhmAzi+eF0XhuqfsboOyR4oCkb2qkZo5aNBqcCXnSE=;
        b=BwRH+v9SqK+dlrdzZ0SYzS82U/qAXo3iWRmO1bvijJNR/q6vL5wL690szk6LHVpG4J
         lRL8TjGU/ipJgURJBiqjKpbmnCdAMfb1mRBsgq8Vnx4lexAqlyKZ7D7KuTJtwz5JWzfF
         Hk5G9/fgmBxKUCOJtTifLl3P4+YEjlMrOB4Ltb+oKKupFU9l5zLHFRqGEYCHLGYdlgFI
         1/hTyRVC8OVlDMYrZBYFv5S2xxVTVmRsqmKpvjGLs9CWhnE3MRTc9gwQZrSmrXUaY4bU
         F6BFsyP+sgdP9nff31n8sisStN139UrAY0oljIukGj8YqAkS0e7+cKH85ymHGfM8CRC9
         NFeA==
X-Forwarded-Encrypted: i=1; AJvYcCUbvTC41TWXwgwFmFvqxVPGtvgk80R+R1MTDjJCs8x9X4aLwmjP2x1p1PQ3RwlT5PbMWsrRX+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1y6M1VXIMGauzOVVmqv8ylTD5LMkZlKivlBy+Y8/UVVDl1Zk+
	mm3SvmTVVK7zBP0C1G8jRPOg10UMavty1ErHZnQNYGZCNQ/g+5MImnA0ZFWPRzC177lSC2ROcXx
	la2AqYqhObvW/1QWZ9PSMdMxt8iM=
X-Gm-Gg: ASbGncvd5W7yNX3V7NdkhROkW1VIwzBloTSYzjweIWKTWRMmpLhpIDjdU9GPuvYTosN
	i3l/5OkYNiNlQ6eTD24osJxK8MyZ2m1AvFEu8qhvg6kUtEfMjMLfjcJEjDnR0YNYuyRufkf0m4B
	OFw69djiJhdP5f/924R3WnqDOa9TMTe91xdp5rrwEcWOCXxHCYNjpCGRs=
X-Google-Smtp-Source: AGHT+IEEpcyFAgCoQwBbUtJmY88S3FqIIoimA7ruerwnolkPNUL919wKmgXs/1tUSNcalFaBknNUqHfVLAJlLCQnGRs=
X-Received: by 2002:a05:6000:659:20b0:390:ee01:68fa with SMTP id
 ffacd0b85a97d-3a074e2f5f4mr21881f8f.24.1745538069505; Thu, 24 Apr 2025
 16:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch> <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org> <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org> <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>
 <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch> <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>
 <3e37228e-c0a9-4198-98d3-a35cc77dbd94@lunn.ch>
In-Reply-To: <3e37228e-c0a9-4198-98d3-a35cc77dbd94@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 24 Apr 2025 16:40:33 -0700
X-Gm-Features: ATxdqUEx13XeQHdj9CMqRrEBoTuYIeBMUGlE_r3rNJlLin7bhkIQ3voQ5Zr1J7o
Message-ID: <CAKgT0Ufm1T59r4Zn48_8gkOi=g0oqH5fvP+Gtxu0Wn9D5jNdaw@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux@armlinux.org.uk, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 1:34=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Sorry for the delay, busy with $DAY_JOB

No problem. I have a number of my own issues I am dealing with here in
terms of code cleanup stuff anyway.

> > > > > There are not 4 host MACs connected to a 5 port switch. Rather, e=
ach
> > > > > host gets its own subset of queues, DMA engines etc, for one shar=
ed
> > > > > MAC. Below the MAC you have all the usual PCS, SFP cage, gpios, I=
2C
> > > > > bus, and blinky LEDs. Plus you have the BMC connected via an RMII=
 like
> > > > > interface.
> > > >
> > > > Yeah, that is the setup so far. Basically we are using one QSFP cab=
le
> > > > and slicing it up. So instead of having a 100CR4 connection we migh=
t
> > > > have 2x50CR2 operating on the same cable, or 4x25CR.
> > >
> > > But for 2x50CR2 you have two MACs? And for 4x25CR 4 MACs?
> >
> > Yes. Some confusion here may be that our hardware always has 4
> > MAC/PCS/PMA setups, one for each host. Depending on the NIC
> > configuration we may have either 4 hosts or 2 hosts present with 2
> > disabled.
>
> So with 2 hosts, each host has two netdevs? If you were to dedicate
> the whole card to one host, you would have 4 netdevs? It is upto
> whatever is above to perform load balancing over those?

Just to be clear when I say "host" in this case I am referring to a
system running Linux, not "host" in the CMIS regard as that is the
NIC/FW I think.

Anyway we have 2 scenarios. Our main use case is to route one x4 to
each host. So in that case we only have one PCIe connection and it
will only show up as one netdev. In our manufacturing test case we
have a riser and use PCIe bifurcation to split up a x16 to 4 x4 and
all 4 endpoints can show up on the one host.

> If you always have 4 MAC/PCS, then the PCS is only ever used with a
> single lane? The MAC does not support 100000baseKR4 for example, but
> 250000baseKR1?

In our 2 host setup we are normally running a QSFP28 or QSFP+ cable
that has 4 lanes. So we effectively are cutting the cable in half to
provide 2 lanes to each host. This allows us to support either
50baseCR2 or 100baseCR2 as the upper limit for the cable depending on
if it is running NRZ or PAM4 modulation. In these setups things are
fairly rigid as we can only select to use 1 or 2 lanes, no selection
for modulation due to the nature of the cable spec.

In our 4 host setup we are configured to connect a QSFP-DD cable. With
that the cable has 8 lanes, with each host getting 2 of that and
seeing the same limitations as the 2 host setup mentioned earlier.

In theory we could do something like you call out in your example, but
we haven't configured a board combination for that yet. Basically it
would require a specific board and EEPROM combination to route the
lanes so that we had one lane per host instead of 2 which is the
current configs.

> > The general idea is that we have to cache the page and bank in the
> > driver and pass those as arguments to the firmware when we perform a
> > read. Basically it will take a lock on the I2C, set the page and bank,
> > perform the read, and then release the lock. With that all 4 hosts can
> > read the I2C from the QSFP without causing any side effects.
>
> I assume your hardware team have not actually implemented I2C, they
> have licensed it. Hence there is probably already a driver for it in
> drivers/i2c/busses, maybe one of the i2c-designware-? However, you are
> not going to use it, you are going to reinvent the wheel so you can
> parse the transactions going over it, look for reads and writes to
> address 127? Humm, i suppose you could have a virtual I2C driver doing
> this stacked on top of the real I2C driver. Is this something other
> network drivers are going to need? Should it be somewhere in
> drivers/net/phy? The hard bit is how you do the mutex in an agnostic
> way. But it looks like hardware spinlocks would work:
> https://docs.kernel.org/locking/hwspinlock.html

Part of the issue would be who owns the I2C driver. Both the firmware
and the host would need access to it. Rather than having to do a
handoff for that it is easier to have the firmware maintain the driver
and just process the requests for us via mailbox IPC calls.

One other point of contention is that we don't have a central firmware
managing things. We have one instance of the firmware running per
host. So the 4 firmware instances will be competing with each other
over access to the QSFP, so they have their own mutex that they
maintain to determine who can have master access to the I2C bus for
the QSFP with each having their own I2C device to connect to the bus.

> And actually, it is more complex than caching the page.

Yeah, that was generally my thought on it, and that is if I even need
to do that. From what I have seen most of the QSFP28/+ direct attach
cables we are working with are very simplistic. Seems like they only
had page 0. It wasn't until I started getting into the QSFP-DD stuff
for the 4 host NIC that I started running into the need for multi page
support. So for example the hwmon sensors don't do much for us as
direct attach cables don't really bother implementing them. A call to
"ethtool -m" on on of our systems usually yields 0.00 degrees C and
0.000 volts.

Also the ethtool API already had get_module_eeprom_by_page which is a
very good fit for our model since it allowed for atomic access based
on the page and bank number.

>   This specification defines functions in Pages 00h-02h. Pages 03-7Fh
>   are reserved for future use. Writing the value of a non-supported
>   Page shall not be accepted by the transceiver. The Page Select byte
>   shall revert to 0 and read / write operations shall be to the
>   unpaged A2h memory map.
>
> So i expect the SFP driver to do a write followed by a read to know if
> it needs to return EOPNOTSUPP to user space because the SFP does not
> implement the page.

I guess it could do EOPNOTSUPP too, we had used EADDRNOTAVAIL to
indicate that case. This is one of the reasons why our firmware API
requires the bank and page be passed in the message to perform an QSFP
I2C read. It is able to verify it on its end and if it isn't supported
it returns an error.

