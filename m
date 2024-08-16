Return-Path: <netdev+bounces-119035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C3953E60
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF11B1C20D75
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D61FA5;
	Fri, 16 Aug 2024 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR/Q5y+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6521846D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769401; cv=none; b=IpGaFzoqxD+KIYm6aUFPlPlFcoz6pxSwk/5vqkbma0q7qVqXDowExDO1EJXQcXmpkaQ6RllcEV5ew0XmWTBQZ9SIsRyR6wYeZIBz5ZgYOjKWd0Q4q8SfhGQER65r6OJ+2MnSVG3fNYPtK4dfvoFxI43CYipq4N5hGCK4gfOtIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769401; c=relaxed/simple;
	bh=NjrCGAXuR3AVw3nL2gGHr/vaZGM/Am55dQqMK5Rf26o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfJJE5ZSuOUAxAwOYb9e7iEUKMGFR10DcIR+dxjf08BGd1nPH5i7bxpDPE9QDTcXTOLz+rTzl1w5A9OZdAO/L4PTQYzAplljQHmwZZAi0jyAzfNMCyrIYatk3nQ8V5Yth7xY9sNMf9H/vsc//Bq03qJzx+HYfrbdLdGA7PEqvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kR/Q5y+7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so14615e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723769397; x=1724374197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNI4Zk7oSqUCXigqn1vX4EVxFnCzFXjRZzRV7egwguY=;
        b=kR/Q5y+7aARo45Y1pgdfIx9H/LRrXIvKvsOmdY91NNT9dsJYBxPh6m7ai2dhIRi+R/
         hnQc3c8cBSMEAJR1BZlTQ2rEkRBaTqN83z4WE5/Ms5++cxheKyTpSbeU61lSN/AbLJBR
         /ni3xGlPql5RrG2fdeDHCXldZjkjsyw9Fqn33ITcIFzEOOAH3Csd8id11i/ZflQLF1R6
         kE4gdw/ayQXSMpDIOEbfESze3n6RW28kBYwjUoaHEuRz2O0FgYsnuA9gsp8PWf+TPjOx
         wEppxqHBcpjLRUF/xo5xNvKj0P3Y+BmiK+T6Cx2cDvD+4ImhFsmLKmg6J4Qr8QY6TexR
         jeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723769397; x=1724374197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNI4Zk7oSqUCXigqn1vX4EVxFnCzFXjRZzRV7egwguY=;
        b=VlxKmg6f8tw1yfT91bFsBYPG7cr5reH1KRzHLc3/BG85hswr2Ngs2wdPXtbP1143Wx
         +2JXUVnM+R8tGUPQmmv7RU3l2a9S5WIAUgr3oNYLiub7fNPXiMa54ZZE+CTtyGSd7AgP
         GrIG0FXykJdwKjAvvp5QvTBhrjQ2cWkox/Uhfooi4iZS98fMg9ezyn8HsyO2WPa/HuiH
         rldegpizRlkPouzVStYtf3yCgTomOouKRGAXjCn4i7h1yT1/9IERmADMIHGkBojSLx89
         tVBhicEpCBRAlnF3eMnKdARtwZ9ealIZMZept4Vw8NWE6iL/tEk8LTVegW1izVMfcEDF
         8YRg==
X-Forwarded-Encrypted: i=1; AJvYcCUvcEw47Smi8u8CUEeV+nGg3wZlyJgphB6DcifV6F83v7nEPkLv9v3D4X1Fiy4bSbFESUPyk2uT8hOdNTn0ttEuMSvJUS35
X-Gm-Message-State: AOJu0Yx4cSaE6+GOBrkNlusE7WXAJ2UtbPkC/2Fpk5c7HoLvTH381Nso
	2EoqwG+lAtNFZKnxI08wIe3OJYe2UyHEYRUPwWxTEzgmVl9N7NJg5wpZIk6QszWqV7PapC12zQl
	UeXNuq36eB+pkYH7lSUt4d7UGc6bokupj+NUw
X-Google-Smtp-Source: AGHT+IHoKCn9FJViTjRDz7CALCmA/4VFFVcAiQkpJZ6mQip67wWEj/Zv1FOrP2EhOZVaGwP72ABv2gInhCyAhAz56dw=
X-Received: by 2002:a05:600c:5022:b0:428:31c:5a4f with SMTP id
 5b1f17b1804b1-429ee591499mr156195e9.3.1723769396881; Thu, 15 Aug 2024
 17:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813223325.3522113-1-maze@google.com> <20240814173248.685681d7@kernel.org>
In-Reply-To: <20240814173248.685681d7@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 15 Aug 2024 17:49:42 -0700
Message-ID: <CANP3RGdMEYrbHWMEb-gTUgNRwje66FTihccVgrg6s4z0c0a+Kw@mail.gmail.com>
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Yuyang Huang <yuyanghuang@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Sounds sane, adding Florian, he mentioned MDNS at last netconf.
> Tho, wasn't there supposed to be a more granular API in Android
> to control such protocol offloads?

We're deprecating the 'new' but already old mdns offload logic in
favour of APFv6+ (unfortunately there was a race here, we weren't
ready with APFv6 in time...).

APF [Android Packet Filter] is a bytecode interpreter built into
[wifi] firmware, currently the bytecode is fed in via Android Wifi HAL
(we'd like to change this to ethtool or something as well) from a java
bytecode generator that knows the state of the system.

APFv2 (ingress packet filtering to prevent spurious wakeups) and APFv4
(adds drop counters) have been in use on Pixel for many many years now
(going back to Pixel 3? somewhere 2016-ish).
We require all new (launched on Android 14/U+) devices to have a
working APFv4 implementation on their wifi client/sta interface
(enforced via Android VTS).
APFv6 (only available on non publicly available hardware atm) adds
support for sending back replies (ie. arp offload & the like).  We
hope to require it for newly launched devices on (the future) Android
16/W (or whatever it ends up being) and to extend it to non-wifi (ie.
wired) as well.

The APFv6 interpreter source is here:
https://android.googlesource.com/platform/hardware/google/apf/+/refs/heads/=
main/v6/
for the curious.

APF is *not* eBPF simply because eBPF is *far* too complex (there's
not enough space for it in the firmware/ram of many low end wifi
chipsets).  The latest APFv6 interpreter is only ~5kB of compiled
code, and another ~2kB of bytecode (though space for 4kB is
recommended).  Some wifi chipset vendors are finding it very hard to
find room for even that.

eBPF bytecode is very space inefficient compared to APF.

> You gotta find an upstream driver which implements this for us to merge.

This came about due to a request from a major wifi chipset vendor to
notify them which offloads could/should be disabled due to being
reimplemented via APFv6 (Android Packet Filter).
So I believe (note: we're still discussing this) we likely have folks
willing to implement this for at least 1 wifi driver (not sure which
one, and if it is merged upstream or lives out-of-tree).

I am of course in a very hard position here, as I don't own any
drivers/firmware - AFAIK even Pixel's wifi/cell drivers aren't Google
owned/maintained, but rather Broadcom/Synaptics/Qualcomm/Mediatek/etc
as appropriate...

I do know there is a need for an api of this sort (not necessarily
exactly this patch though), and if we merge something (sane :-) ) into
Linux, we can then backport that (either to LTS or just to ACK), and
then we (as in Google) can require implementations (for new
hardware/drivers) in future versions of Android...

Presumably that would result in implementations in many drivers,
though not necessarily any in-tree ones (I have no idea what the
current state of in-vs-out-of-tree drivers is wrt. Android wifi/cell
hardware)

This is very much a chicken-and-egg problem though.  As long as there
is no 'public' API, the default approach is for per-vendor or even
per-chip / per-driver custom apis, hidden behind Android HALs.  For
example we have such an Android HAL api for disabling ND offload on at
least one of our devices.  Of course the HAL itself is backed by
calling into the driver - just over some driver specific netlink...

Similarly for APF bytecode installation: it all goes via Android HALs,
which then in practice immediately turn around and talk straight over
driver/vendor-specific netlink to the driver.

I'd *love* to simplify all this.  Indeed in an ideal world, we'd have
'native' Linux apis into drivers to disable offloads, load APF, and
could even teach the kernel to actually build the APF bytecode to load
in in the first place (this would fix lots of races we currently have,
where we need to fetch state out of the kernel to build the bytecode
to pass back into the kernel driver/firmware...).  Perhaps a BPF
program to build the APF bytecode during the suspend sequence --
seriously, this isn't even a joke.

That said... the problem is simply too large to bite all at once, so
I'm trying to find a way out of the logjam wrt. upstream Linux that
APF has been in for years.

If we can't settle on a 'public' Linux API for this (not saying *this*
patch is necessarily the right way) we'll likely end up implementing
this either via ethtool privflags (or something) or simply via an
Android HAL... again :-( Be aware HALs are what most of the org loves
and it's hard enough to explain why we don't want to go via a HAL....

This isn't meant to be a threat ;-) it's just an unavoidable statement
of fact... :-(

What I could offer to provide is some sort of tun/tap/veth/virtio-net
based APF implementation for testing (but that's not exactly relevant
to *this* patch, since they don't support offloads to disable in the
first place) - as I would love to have that available in cuttlefish
(Android VM) for integration testing.

> If Florian doesn't have any quick uses -- I think Intel ethernet drivers
> have private flags for enabling/disabling an LLDP agent. That could be
> another way..
> --
> pw-bot: cr

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

