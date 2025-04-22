Return-Path: <netdev+bounces-184874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D9A9788A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE1E7ACD60
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0210262FC7;
	Tue, 22 Apr 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJgrtq40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2C1E2307
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357428; cv=none; b=g8fetjpMQd7+aoD8brWz6QMMeVb/htjC1e59WeZ6D3fhqQFDX/oOZOq8lgQX1A1PTiQBTF7yy4JXADMFRllnd4jt1SL/E/o+2qU6zzJp5qKdLhc4EGYKI+L8XGqhhpIFA40h2Gz8U85JDeZ69gFkudg4LDefjOdjjKnOWW59YeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357428; c=relaxed/simple;
	bh=RVc/V7Gq3NgR2ti3PoR0DBuRVJ9ATcOHpVTWNE4OXx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LR6kwlxQ50U+k/L9zov+C13EMhOax14xBcdpp3zkG5WFGenABE41cAgCkOC4oV7r+jvV5QvR5n9t4ezBgSEb3q3J9shUUrh4N+m3E2JVB/oW6nVm5jXSXwawr2ZU8t2LYqieh61aAN7w6ECgoSlNtYN3KSo6IeJ9sOdbZJ+8H2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJgrtq40; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso4118567f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745357425; x=1745962225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVc/V7Gq3NgR2ti3PoR0DBuRVJ9ATcOHpVTWNE4OXx0=;
        b=fJgrtq40q4Zu7q+qDmx2udUXbE9ZXE6yrdpkumsYDNJysnYa59Pac9tXtg9RJIQu2c
         vnzz+nkkPqt0xdiDtoZpWkkZlECW97F12jpMJb3xGC4ZfgHvVwqNwcqV1id3lmWkaIuS
         kAPxvdt/Lij7M3297iEpQMy8lSMfKGVvSOPz8KZyic/RsP4hzakUZi+dtSV/XXijWt8n
         mfpW4UGdS00SRWrMGSc8VnoiujWB95fL1qD630+213O1+C8IalOxPClwVC0V7ukJV0SS
         d2yXESt+awaI9B4E7TAoBb+OPXM2RXu2fw0hsF5jI8fGGPC6hl0hUrHJ4FfDFK6TT5ay
         OEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357425; x=1745962225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVc/V7Gq3NgR2ti3PoR0DBuRVJ9ATcOHpVTWNE4OXx0=;
        b=jcLxa3sgTmJ2v6ScvRHfOCkvRuDtc3gukRBAHEwB/MZbwaZQHyTeF73VatKJcGT7a0
         xt0pkQ+Ybt4+/EsqV1rUawbIX3YVSDzBc+NMvziIUBGrA90eFousgCg5PYSf9pFGI2Cq
         HH1qofs27ZEMtK7sdrkiaTGcB24uwK8PhFYMj1NNIcPv+ySywm5Foc0+hLHLk3tdr1+s
         NuXfhPc/+2lHrd4CCJIkyb3sYAG+hMUpmzPWO+WK41bsgWLN73OM1qwWxyFn1EG1uH68
         g2dS3VgcSLjTbrzC9aCLBnp9LTbJH0zUpLyb1M2nv++f9bDwBwO5b9igxPNhYrk95hBt
         e2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWRnd6v67sG2cPNEo25iy4YJVtzuXBvDoKRAPEfgK0whAbexe5vsh1JC2ymIprMOn7d2PlSh/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2vV4EmH2WLxo0+6bxoNFfiSvFIuQ6HvJkrw+pPk7Ev+doy2E
	kg7tHlus5DPYidnO3gIly7QZks9WXD18lzStqrkiL0cFRLLXVjgUAZLDNFLX5cNNd2S3jiNJrjU
	FY6qsXmkJWSlQTnN3YBk0zFjbP40=
X-Gm-Gg: ASbGnctu7/A7LtjTuwAzAsSB0u7hZK1KTPLrspmSid8MUKJ1woSxrHjoIOC1fzXtiXQ
	7hShuvvonpMAp5N7y7vKECV8oYtGUhfS+YLlPqPeBvmxhJokMOcytoqqAveQ//uvDhUK+tpgTWi
	urJuTFZxWI4mUt0U1g9ZAlmv+lk2x1h2et4D6FMD1XIULQYlyaTIgofD0=
X-Google-Smtp-Source: AGHT+IE+S4+5GFPvrOCzykWB3unSrvMO7P/bZU7JAYDt6xJ3G2ef9MzeKCSjB496p8c6uDClPUEDXdhlZ9XgGyoi3u0=
X-Received: by 2002:a05:6000:2913:b0:39e:f641:c43 with SMTP id
 ffacd0b85a97d-39efbaf689bmr13319198f8f.53.1745357424814; Tue, 22 Apr 2025
 14:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch> <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch> <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org> <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org> <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
In-Reply-To: <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 Apr 2025 14:29:48 -0700
X-Gm-Features: ATxdqUE1CZJTDoE1ODvGgA8LG87iUsn9dODIYGcbdhUEKtXrRqNKjeNooxJM9GY
Message-ID: <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux@armlinux.org.uk, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 9:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > The whole concept of a multi-host NIC is new to me. So i at least nee=
d
> > > to get up to speed with it. I've no idea if Russell has come across i=
t
> > > before, since it is not a SoC concept.
> > >
> > > I don't really want to agree to anything until i do have that concept
> > > understood. That is part of why i asked about a standard. It is a
> > > dense document answering a lot of questions. Without a standard, i
> > > need to ask a lot of questions.
> >
> > Don't hesitate to ask the questions, your last reply contains no
> > question marks :)
>
> O.K. Lets start with the basics. I assume the NIC has a PCIe connector
> something like a 4.0 x4? Each of the four hosts in the system
> contribute one PCIe lane. So from the host side it looks like a 4.0 x1
> NIC?

More like 5.0 x16 split in to 4 5.0 x4 NICs.

> There are not 4 host MACs connected to a 5 port switch. Rather, each
> host gets its own subset of queues, DMA engines etc, for one shared
> MAC. Below the MAC you have all the usual PCS, SFP cage, gpios, I2C
> bus, and blinky LEDs. Plus you have the BMC connected via an RMII like
> interface.

Yeah, that is the setup so far. Basically we are using one QSFP cable
and slicing it up. So instead of having a 100CR4 connection we might
have 2x50CR2 operating on the same cable, or 4x25CR.

> You must have a minimum of firmware on the NIC to get the MAC into a
> state the BMC can inject/receive frames, configure the PCS, gpios to
> the SFP, enough I2C to figure out what the module is, what quirks are
> needed etc.

The firmware isn't that smart. It isn't reading the QSFP itself to get
that info. It could, but it doesn't. It is essentially hands off as
there isn't any change needed for a direct attach cable. Basically it
is configuring the MAC, PCS, FEC, PMA, PMD with a pre-recorded setting
in the EEPROM for the NIC.

> NC-SI, with Linux controlling the hardware, implies you need to be
> able to hand off control of the GPIOs, I2C, PCS to Linux. But with
> multi-host, it makes no sense for all 4 hosts to be trying to control
> the GPIOs, I2C, PCS, perform SFP firmware upgrade. So it seems more
> likely to me, one host gets put in change of everything below the
> queues to the MAC. The others just know there is link, nothing more.

Things are a bit simpler than that. With the direct-attach we don't
need to take any action on the SFP. Essentially the I2C and GPIOs are
all shared. As such we can read the QSFP state, but cannot modify it
directly. We aren't taking any actions to write to the I2C other than
bank/page which is handled all as a part of the read call.

> This actually circles back to the discussion about fixed-link. The one
> host in control of all the lower hardware has the complete
> picture. The other 3 maybe just need a fixed link. They don't get to
> see what is going on below the MAC, and as a result there is no
> ethtool support to change anything, and so no conflicting
> configuration? And since they cannot control any of that, they cannot
> put the link down. So 3/4 of the problem is solved.

Yeah, this is why I was headed down that path for a bit. However our
links are independent with the only shared bit being the PMD and the
SFP module. We can essentially configure everything else diffrerent
between the ports from there. So depending on what the cable supports
we can potentially run one lane or two, and in NRZ or PAM4 mode.

So for example one of our standard test items to run is to use a
QSFP-DD loopback plug and essentially cycle through all different port
configurations on all the different ports to make sure we don't have
configuration leaking over from one port to the other as the PMD is
shared between hosts 0 and 1, and hosts 2 and 3 if we have a 4 port
setup. We don't have to have all 4 MAC/PCS/PMA configured the same. We
can have a different config between ports, although in most cases it
will just end up being the same.

> phylink is however not expecting that when phylink_start() is called,
> it might or might not have to drive the hardware depending on if it
> wins an election to control the hardware. And if it losses, it needs
> to ditch all its configuration for a PCS, SPF, etc and swap to a
> fixed-link. Do we want to teach phylink all this, or put all phylink
> stuff into open(), rather than spread across probe() and open(). Being
> in open(), you basically construct a different phylink configuration
> depending on if you win the election or not.

We are getting a bit off into the weeds here. So there isn't any sort
of election. There is still a firmware that is sitting on the shared
bits. So the PMD, I2C to the QSFP, and GPIO from the QSFP are all
controlled via the firmware. To prevent any significant issues for now
we treat the QSFP as read-only from the hosts as we have to go through
the firmware to get access, and the PMD can only be configured via a
message to the FW asking for a specific bitrate/modulation and number
of lanes.

> Is one host in the position to control the complete media
> configuration? Could you split the QSFP into four, each host gets its
> own channel, and it gets to choose how to use that channel, different
> FEC schemes, bit rates?

So one thing to be aware of is that the QSFP can be electrically
separated so that it is one cable, but with either 2 (QSFP+/QSFP28) or
4 (QSFP-DD) separate sets of lanes. The cable defines the limits of
what we can do in terms of modulation and number of lanes, but we
don't have to configure anything directly on it. That is handled
through the PCS/PMA/PMD side of things.

