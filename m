Return-Path: <netdev+bounces-67311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4FB842B8D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E8C1C22F0B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 18:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B41552EC;
	Tue, 30 Jan 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6ZNS2/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1768612D
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638685; cv=none; b=pIb6I/QzYGhPu6pEljpJA0n8Lr/V+X/EH5fOXpEjpH2WYQoHR2KLYRRlqZQQvVBLTgijkHx6bRjqxa0nT655vmwPwNl0LHPWseo4ZEFq90C+idPaq3VsoSQvH2HsaIe0HTyleg09bTECC4N8drZfmEYcpfN5a6zkxb4e8WUiMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638685; c=relaxed/simple;
	bh=KZ9VAgsHwxVQG0huaj8rws88hpHKKeDIb0yXJZUCegE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XX7FxE2bGtahGaxZbcovRazOXYouwH8iARMi/0h2EszUdD8puhiIe70w/isPnxmA1ug/SkrYU4G8+gjR/7narsVZgsoOMRXDjCo3oW25QhfzeSId3yV84DM3y8us4t5+WZ5v8AXJd5E5Ydko4KpVpu4k9gWQ77Vv174mz+ggOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6ZNS2/k; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d043160cd1so31860311fa.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638682; x=1707243482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00X13krfPSOmdof/AV62DBDVE5UjTvQgGh1zTxi9SYw=;
        b=R6ZNS2/k94WR1MgyltxRsJI1+V/lnGwnc1fmqW6V7nh29OUxslKaCPrC43mL/zMdaW
         qN1k1YNaWxj3YTY8Qs1GDnptsOo1AuoGreM1636QYH4hymKqX8gTEJ3eVBhhBSwL7LBx
         ZzWklKmH3HYv0So/YBE02lUab9YjxOw0k45dVSMTjaoAYEMNdbXtq9nz7hjNuPkoR6Vw
         x6iYLvWNLEW6dapinPWNLVIpUh6ThzNqL0KURPykmzAaPV1vgmro9YpUou0EphNBbwk2
         NkaTc8rkg7IVlLA+b/vUsM2lTqiPvZ6Vg+unN/6vQspmKLYCG23Y2S1fqvUJb+rsL0tM
         KZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638682; x=1707243482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00X13krfPSOmdof/AV62DBDVE5UjTvQgGh1zTxi9SYw=;
        b=cUOMmydYCfhSj5OQvcq1HoiPcvhNGTnTR5Vi0rZ1b1w66J20xO6sVkzlI26kvyhCRZ
         re5htx4Aqhrzt6jXXVUIaTXw9ViBppP44YGpxYc9bRRZuYJA1A9tPCDLAWr+juZ7DItE
         5cdf1/nRdTlzZrsqDWq7IPzZSE6tSo1ca37dUEZFlgzDREKhao3SnkTWt4Xr3VCHE0LR
         yliHX7nWw3hVZ2q82ceOGHCAdjMebgd+Tp90bH5GKlgBVzWorOepXDXBS1bATWJFoB/g
         M0cl/CPHIh8pKHGJNmF4mEOwSj/DoS8s5kkOt7kvVdBdxlX0RBCHy7LvMVvw8fuw2djb
         tb7w==
X-Gm-Message-State: AOJu0Yz4e11hh5cmBi2cGT74IeJoLV41Xvt/esvVrAFDgtW+hV9Y5Yfh
	BAZbGmYolzPF+tZiP0zoFnHPe6DfltNZIgULfWg65rOGUgHZXcgEo0jaWmk7hjj+xvZLUru85C7
	2isyP113V8BI1vWf6aEws/cSAKms=
X-Google-Smtp-Source: AGHT+IFm2VYtaX3bm6iCvVfU4ln8PHNU8XNafq9kmoSS4voQ5laobFXPzcAdC/T01sbLjGZzIQz3HTgaDQzuzUu0vJE=
X-Received: by 2002:a05:651c:a06:b0:2d0:63b6:e93c with SMTP id
 k6-20020a05651c0a0600b002d063b6e93cmr99835ljq.20.1706638681653; Tue, 30 Jan
 2024 10:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123215606.26716-1-luizluca@gmail.com> <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf> <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
 <20240129161532.sub4yfbjkpfgqfwh@skbuf> <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>
 <a50ca71f-e0b9-43ad-a08f-b4ee8a349387@arinc9.com> <9657a15e-7c60-4244-9c27-327d96b7b76b@lunn.ch>
In-Reply-To: <9657a15e-7c60-4244-9c27-327d96b7b76b@lunn.ch>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 15:17:50 -0300
Message-ID: <CAJq09z7iBht6KP3XRKzCkWHZwMMOR3O5UHO3hvPaSHRNjX67Ug@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus setup
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > >  From other discussions I've had, there seems to be interest in qui=
te the
> > > > opposite thing, in fact. Reboot the SoC running Linux, but do not
> > > > disturb traffic flowing through the switch, and somehow pick up the
> > > > state from where the previous kernel left it.
> > >
> > > Yes this is actually an use case that is very dear to the users of DS=
A in an airplane. The entertainment system in the seat in front of you typi=
cally has a left, CPU/display and right set of switch ports. Across the 300=
+ units in the plane each entertainment systems runs STP to avoid loops bei=
ng created when one of the display units goes bad. Occasionally cabin crew =
members will have to swap those units out since they tend to wear out. When=
 they do, the switch operates in a headless mode and it would be unfortunat=
e that plugging in a display unit into the network again would be disruptin=
g existing traffic. I have seen out of tree patches doing that, but there w=
as not a good way to make them upstream quality.
> >
> > This piqued my interest. I'm trying to understand how exactly plugging =
in a
> > display unit into the network would disrupt the traffic flow. Is this a=
bout
> > all network interfaces attached to the bridge interface being blocked w=
hen
> > a new link is established to relearn the changed topology?
>
> The hardware is split into two parts, a cradle and the display
> unit. The switch itself is in the cradle embedded in the seat
> back. The display unit contains the CPU, GPU, storage etc. There is a
> single Ethernet interface between the display unit and the cradle,
> along with MDIO, power, audio cables for the headphone jack etc.
>
> When you take out the display unit, you disconnect the switches
> management plain. The CPU has gone, and its the CPU running STP,
> sending and receiving BPDUs, etc. But the switch is still powered, and
> switching packets, keeping the network going, at least for a while.
>
> When you plug in a display unit, it boots. As typical for any computer
> booting, it assumes the hardware is in an unknown state, and hits the
> switch with a reset. That then kills the local networking, and it
> takes a little while of the devices around it to swap to a redundant
> path. The move from STP to RSTP has been made, which speeds this all
> up, but you do get some disruption.
>
> It can take a while for the display unit to boot into user space and
> reconfigure the switch. Its only when that is complete can the switch
> rejoin the network.
>
> Rather than hit the switch with a reset, it would be better to somehow
> suck the current configuration out of the switch and prime the Linux
> network stack with that configuration. But that is a totally alien
> concept to Linux.

This is quite a particular case. You'll need to update userland config
from the kernel state and the kernel state from the HW state. It's
upside down from what we normally see.
Anyway, we are far from that point in realtek DSA drivers. The DSA
driver actually resets the switch twice (HW and then SW) during setup.
Even vendor driver/lib states that without the initialization steps,
the switch behavior is undefined. And those steps would probably mess
with any existing switch state. Parsing the reg values into kernel
state is quite a complex task if you need to be usable for many
scenarios. And we still have opaque jam tables in the driver that I
would love to get rid of.

Now, back to the point I raised:

1) should we continue to HW reset the switch when the driver stops
controlling it?
2) If that is a yes, should we do that both for shutdown and poweroff?
3) Should we take additional precautions to lock the switch before
resetting it (as HW reset might be missing or misconfigured)?

I'll probably send the v5 without touching this topic but it is an
interesting point to think about, at least to assert the reset during
shutdown.

Regards,

Luiz

