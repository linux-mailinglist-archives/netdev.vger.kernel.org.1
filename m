Return-Path: <netdev+bounces-184909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11031A97AE7
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A4718874DB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EAA1EE7B7;
	Tue, 22 Apr 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOjs3fRJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201C9476
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363220; cv=none; b=Lq16xGg8I5F4oN4eiWSWH6EtEzRhBTqTGKVbcuOIxSRWqhB3M5fWXqg8dB8UKvxlaW52E1/nVz2kQnl/HNhawIGJl4R1eQcPHknsrHYRMTCuu1j3IL1oU0EG1nysKLpRoSUMjR9HDA8XKelSTiS6TXIbxpg6gAW5Ua81TiedZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363220; c=relaxed/simple;
	bh=B84M41yhf7PaZex3hwybYtmQf9d2HEOmnqm6gKZpkc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDlAHAEjhM2I1hhGKZdpWEQGIj1Q19Q+HyBJSXXYKzb4VUMp+dZYaH4ynveO0HbbHj/q5KCQEKwEG9mcTUdXTL46FSpc07eDXzGzt7rQ8EP0b2i3J1V5zN2LsUNEuBm6dxeax52Apl+C46DIeGyZVI4WAkaUZUi9IV1gDKofCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOjs3fRJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ac56756f6so5666799f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745363216; x=1745968016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B84M41yhf7PaZex3hwybYtmQf9d2HEOmnqm6gKZpkc0=;
        b=DOjs3fRJISLhfkad+N3ESxL+twVRWnZfRnp0ELOp538sQWqkJDwzairKupr0uvfRXw
         Yxv+cYWpa8Gx2IjUIybE3dJ/ba/MI8ImVAVq0qRhfoh2PQRp+j0wxg7JuWblv//63AbL
         JHRG7+qN6i0Tn/gLs6z865K2ZR8b07aCih341wiRRt5wShHvMmVf2whQRDY9NCBFpWlw
         /QHKXQstmBCHROVRgAFerDP3kgx6b3CgTgcFkrQkyVBM0WbzUl5U11IWHgPz36ZqWm7C
         2iM4X26z7+C695/OV/dPR51HXTdp8TSrOd+bvwpLA3eZxxka5RqU5eKpDJ/Humtklm+w
         t4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745363216; x=1745968016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B84M41yhf7PaZex3hwybYtmQf9d2HEOmnqm6gKZpkc0=;
        b=sjxxJ02mvKe3seC1oGXcjuzxkkeHE8JggxwTXW3MGx6jsJjSGhDSkV3Jyqs2y45AVE
         j+nUHv2rJhlrc9BwBAdW0rv2WhziUlE4V4q63cCdMBfNW+IQKLUkndC8Afi97Wi0CvWx
         9n+pEwsTq2RYjNyyjle9QkDTfj9x2Vn3gQMYFBFD4CuIanvmkY1Tnfg3+kQYj7jX8How
         95+nHsO5EJhrTXAJ0OAkB6wOlYTGSnMEfcASN8r2ugNT6/cLy3IA22oQFibxj/OJ2M06
         NcQ5tUNx66KODKWNZGVcE9FY0K2t7xuct8k0FlZXs03o2A5HnJdjElcTfmw1yh4esDsJ
         T6pw==
X-Forwarded-Encrypted: i=1; AJvYcCW6gmg9IVWeFUE0whZe/dLhoR3M5rdyWQLgpBDcI/6/H/euVltaTpHZkr/e0S1oW0h6aU6i9MI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1f+m8cRWJdEf7Uc6MJlSdGyHGZrfcdBJDmwPyOEta65LwaEE
	ovIRjwUQ2/S44fxZUZ8ukuXEi1lE6FAXcxpBL/GaJ6lnlXMWmwGq1f4YU9TeErwmsbK2T5B+c5a
	Z3g4/nj6jk9Hk0VxBKUozm7n9OuU=
X-Gm-Gg: ASbGnctzDzNrn8dS6Tj3pZobmx91i2TZ+zl3/2or9lW8cf4yHcz9PrT0nAy5JY7PxHR
	5YXNEmYCfzF0cHo5y0ZkH4Ma0e7CglGW8EFCTzNNZFO9Bpgd3pzhUGxLljlXtXSKNNOGDG5cVpI
	T++JKA96AUWlF461h+pnmnIeWMAOOlUPHylBTTeqAis9Y3CJT0aIuarj8=
X-Google-Smtp-Source: AGHT+IF0eTI8qJhLL0CcPl+mm0ljJmmsBF0EQc/0Ht7P/DJ5fO/fFgiicLe6BP+5jEkxLNcX9S8S0r+sQnL8O58Q39U=
X-Received: by 2002:a5d:59a9:0:b0:391:2c67:798f with SMTP id
 ffacd0b85a97d-39efbaded2bmr12514499f8f.41.1745363216214; Tue, 22 Apr 2025
 16:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch> <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch> <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org> <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org> <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com> <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch>
In-Reply-To: <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 Apr 2025 16:06:19 -0700
X-Gm-Features: ATxdqUGU8zL7ZjX3dBUB3W2_ARhCI1IACBppFJr_imRlTeB-VN4k-6X8tZPpngQ
Message-ID: <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux@armlinux.org.uk, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 3:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Apr 22, 2025 at 02:29:48PM -0700, Alexander Duyck wrote:
> > On Tue, Apr 22, 2025 at 9:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > > The whole concept of a multi-host NIC is new to me. So i at least=
 need
> > > > > to get up to speed with it. I've no idea if Russell has come acro=
ss it
> > > > > before, since it is not a SoC concept.
> > > > >
> > > > > I don't really want to agree to anything until i do have that con=
cept
> > > > > understood. That is part of why i asked about a standard. It is a
> > > > > dense document answering a lot of questions. Without a standard, =
i
> > > > > need to ask a lot of questions.
> > > >
> > > > Don't hesitate to ask the questions, your last reply contains no
> > > > question marks :)
> > >
> > > O.K. Lets start with the basics. I assume the NIC has a PCIe connecto=
r
> > > something like a 4.0 x4? Each of the four hosts in the system
> > > contribute one PCIe lane. So from the host side it looks like a 4.0 x=
1
> > > NIC?
> >
> > More like 5.0 x16 split in to 4 5.0 x4 NICs.
>
> O.K. Same thing, different scale.

Agreed.

> > > There are not 4 host MACs connected to a 5 port switch. Rather, each
> > > host gets its own subset of queues, DMA engines etc, for one shared
> > > MAC. Below the MAC you have all the usual PCS, SFP cage, gpios, I2C
> > > bus, and blinky LEDs. Plus you have the BMC connected via an RMII lik=
e
> > > interface.
> >
> > Yeah, that is the setup so far. Basically we are using one QSFP cable
> > and slicing it up. So instead of having a 100CR4 connection we might
> > have 2x50CR2 operating on the same cable, or 4x25CR.
>
> But for 2x50CR2 you have two MACs? And for 4x25CR 4 MACs?

Yes. Some confusion here may be that our hardware always has 4
MAC/PCS/PMA setups, one for each host. Depending on the NIC
configuration we may have either 4 hosts or 2 hosts present with 2
disabled. What they end up doing is routing 2 lanes from the QSFP to
one host and the other two to the other. So in the case of the QSFP28
or QSFP+ we can only support 2 hosts, and with the QSFP-DD we can
support 4.

> Or is there always 4 MACs, each MAC has its own queues, and you need
> to place frames into the correct queue, and with a 2x50CR2 you also
> need to load balance across those two queues?

Are you familiar with the concept of QSFP breakout cables? The general
idea is that one end of the cable is a QSFP connection and it will
break out into 4 SFP connections on the other end. That is actually
pretty close to the concept behind our NIC. We essentially have an
internalized breakout where the QSFP connection comes in, but we break
it into either 2 or 4 connections on our end. Our limit is 2 lanes per
host.

I did a quick search and came up with the following link to a Cisco
whitepaper that sort of explains the breakout cable concept. I will
try to see if I can find a spec somewhere that defines how to handle a
breakout cable:
https://www.cisco.com/c/en/us/products/collateral/interfaces-modules/transc=
eiver-modules/whitepaper-c11-744077.html

> I guess the queuing does not matter much to phylink, but how do you
> represent multiple PCS lanes to phylink? Up until now, one netdev has
> had one PCS lane. It now has 1, 2, or 4 lanes. None of the
> phylink_pcs_op have a lane indicator.

So the PCS isn't really much of a problem. There is only one PCS per
host. Where things get a bit messier is that the PMA/PMD setup is per
lane. So our PCS has vendor registers for setting up the PMA side of
things and we have to set them for 2 devices instead of just one.
Likewise we have to pass a lanes mask to the PMD to tell it which
lanes are being configured for what modulation and which lanes are
disabled.

> > > NC-SI, with Linux controlling the hardware, implies you need to be
> > > able to hand off control of the GPIOs, I2C, PCS to Linux. But with
> > > multi-host, it makes no sense for all 4 hosts to be trying to control
> > > the GPIOs, I2C, PCS, perform SFP firmware upgrade. So it seems more
> > > likely to me, one host gets put in change of everything below the
> > > queues to the MAC. The others just know there is link, nothing more.
> >
> > Things are a bit simpler than that. With the direct-attach we don't
> > need to take any action on the SFP. Essentially the I2C and GPIOs are
> > all shared. As such we can read the QSFP state, but cannot modify it
> > directly. We aren't taking any actions to write to the I2C other than
> > bank/page which is handled all as a part of the read call.
>
> That might work for direct-attach, but what about the general case? We
> need to ensure whatever we add supports the general case.

I agree, but at the same time I am just letting you know the
limitations of our hardware setup. There isn't anything to really
control on the QSFP. It is mostly just there to provide the media and
that is about it. No PHY on it to load FW for.

> The current SFP code expects a Linux I2C bus. Given how SFPs are
> broken, it does 16 bytes reads at the most. When it needs to read more
> than 16 bytes, i expect it will set the page once, read it back to
> ensure the SFP actually implements the page, and then do multiple I2C
> reads to read all the data it wants from that page. I don't see how
> this is going to work when the I2C bus is shared.

The general idea is that we have to cache the page and bank in the
driver and pass those as arguments to the firmware when we perform a
read. Basically it will take a lock on the I2C, set the page and bank,
perform the read, and then release the lock. With that all 4 hosts can
read the I2C from the QSFP without causing any side effects.

> > > This actually circles back to the discussion about fixed-link. The on=
e
> > > host in control of all the lower hardware has the complete
> > > picture. The other 3 maybe just need a fixed link. They don't get to
> > > see what is going on below the MAC, and as a result there is no
> > > ethtool support to change anything, and so no conflicting
> > > configuration? And since they cannot control any of that, they cannot
> > > put the link down. So 3/4 of the problem is solved.
> >
> > Yeah, this is why I was headed down that path for a bit. However our
> > links are independent with the only shared bit being the PMD and the
> > SFP module.
>
> Yours might be, but what is the general case?

I will do some digging into the breakout cable path. That seems like
the most likely setup that would be similar and more general.

