Return-Path: <netdev+bounces-133302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE4995883
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B31F25C3F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31003212EF2;
	Tue,  8 Oct 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="c/w4o3H2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814F7DA76
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419715; cv=none; b=D76AjYhKv80SGLeVrhKCW5w1kZb7U8k1iVMkRB4m/efmdBHaLeY88abLHGUjk5TaOHimsV9gDv30BaJcwIE14TlKF6orhPmMdH+8a6tkxvkT/tSLh2rbQYxSKsmmPhQV1Xw5sgpOY+ijht2HUd1liFnONQRh8xlvZxc92h7iZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419715; c=relaxed/simple;
	bh=HFoXHfJtEe/wRLoPmYwcVpYKrHu2SAwKxZMlpyf+Hmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOkD5antrdsSfTED/p+7hMJ3r0gfykOsQzMOuqBn/q+VsbmOqrFtO3FZpsxZ5zxkf0KBmgxvqAipUluDfQ5YXtpb5SNs73V7P4S6zQf9ksL53hQQYrgaDx9lrSsrcwYNEEwxMx6VZSAJ0SGNcLSv7PVdg7Z/pCfxrOLaA09KmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=c/w4o3H2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e25cc9e94eeso5306609276.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1728419712; x=1729024512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFoXHfJtEe/wRLoPmYwcVpYKrHu2SAwKxZMlpyf+Hmg=;
        b=c/w4o3H2LyCLc/ja4XSvIVKx2tdwQC3ZLOXoVGhTXUbcuqYCSxf7GDOXs1n/rfuf8v
         8eBEShOpQ3ubjW7DmH5FIAd1rTLT90CqB3cyLx8QpCp0QxW2sR9fMgkyMMXoOgRU9i19
         NzV2WD+CJYJp7cMWvXrBKQLjYMD/lygILDZ8cNf70b1l8iAqQuXLVmMwjaHmyCcGIZhM
         R6khjnvtiCHsuAzhKie3x5nYicOYY4EwYilQDjiC1sZyRBsDM/8MXBdcwOb55xscn7Dw
         wJLdXP81Ut+Qsb1Brjg5YzndexVw5f/NTpn/L1WFXsm+rx/L86fX13R7Q6uP5OD34752
         2xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728419712; x=1729024512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFoXHfJtEe/wRLoPmYwcVpYKrHu2SAwKxZMlpyf+Hmg=;
        b=rpdl53Ja2MgBjnbQW7YwZWwqHXvMORIN51ujWi3Lt2RLyBwcBm76oz5342kgunYsyK
         pmNV35EtgFp73MRyGjVR0QfRq7sPbt6EwAtXduHzSsQKJMGALO65X71R0ZUg9UDrWT1S
         zF8doWA+riVSp3nqbCjqUSozwu9+Kl0p/qier4DJx45onV8aXLyNtA24I04Bh5NtkYJt
         p5IbZzbsxCXVtKEluLVvcZJnJwWRV1SBZd17ZUtgJ6uV8AeV6d1jfaVsUkZ9SWbeA4ok
         e6DYZl486ctmG6G/yb+djXEqXtFEsTGe22BgCsAKFbqVApwiqA//3u+haL1MkJzRHuLs
         JumA==
X-Gm-Message-State: AOJu0YyVSBRzEiV4OBclF0GQeIC3m1GAjg6TawzU/vkz8+iTN2ZNOEE/
	Lv+TwNj8hSatLbeO3EaO0nT0OM2rGZoUbP7tBfjGkewQ/YImAMAHxGPjPY/qLUPAyUUFmgjcchX
	qvwgMuF8K9oYP6o09Hw5Jai06zN/FDnMyfU19S4MHPH6+y/xK
X-Google-Smtp-Source: AGHT+IGlBOizMcT0HMp19V9hMj2cvOve+bcbzVxtpbO8hMP+et4LuaIKXJNiOVIP4cO3dHLmWywwNDQaqZdhZubN4dU=
X-Received: by 2002:a05:6902:e0c:b0:e13:d5e7:b1f9 with SMTP id
 3f1490d57ef6-e28fe3891e1mr513874276.25.1728419711979; Tue, 08 Oct 2024
 13:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU12DeT3QWp8aU+tSL-PF00yJu5M36Bmx_tw_3oXsyb76g@mail.gmail.com>
 <c572529e-78c4-42d5-a799-1027fd5fca29@gmail.com> <CAJ+vNU3qCKzsK2XFj6Gj0vr4JfE=URYadWsr3xvxOO__MVNsPw@mail.gmail.com>
 <009d90a1-16e6-4f6b-bfe7-8282e9deeeb3@gmail.com>
In-Reply-To: <009d90a1-16e6-4f6b-bfe7-8282e9deeeb3@gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 8 Oct 2024 13:35:01 -0700
Message-ID: <CAJ+vNU3u62Z6Nr=5AmWtBRC6M3bR_0SMf8RbKXe9os6Ru4w2Vw@mail.gmail.com>
Subject: Re: Linux network PHY initial configuration for ports not 'up'
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:35=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 10/7/24 11:18, Tim Harvey wrote:
> > On Mon, Oct 7, 2024 at 10:28=E2=80=AFAM Florian Fainelli <f.fainelli@gm=
ail.com> wrote:
> >>
> >> On 10/7/24 09:48, Tim Harvey wrote:
> >>> Greetings,
> >>>
> >>> What is the policy for configuration of network PHY's for ports that
> >>> are not brought 'up'?
> >>>
> >>> I work with boards with several PHY's that have invalid link
> >>> configuration which does not get fixed until the port is brought up.
> >>> One could argue that this is fine because the port isn't up but in th=
e
> >>> case of LED misconfiguration people wonder why the LED's are not
> >>> configured properly until the port is brought up (or they wonder why
> >>> LEDs are ilumnated at all for a port that isn't up). Another example
> >>> would be a PHY with EEE errata where EEE should be disabled but this
> >>> doesn't happen utnil the port is brought up yet while the port is
> >>> 'down' a link with EEE is still established at the PHY level with a
> >>> link partner. One could also point out that power is being used to
> >>> link PHY's that should not even be linked.
> >>>
> >>> In other words, should a MAC driver somehow trigger a PHY to get
> >>> initialized (as in fixups and allowing a physical link) even if the
> >>> MAC port is not up? If so, how is this done currently?
> >>
> >> There are drivers that have historically brought up Ethernet PHYs in t=
he
> >> MAC's probe routine. This is fine in premise, and you get a bit of spe=
ed
> >> up because by the time the network interface is opened by user-space y=
ou
> >> have usually finished auto-negotiation. This does mean that usually th=
e
> >> PHY is already in the UP state.
> >
> > Hi Florian,
> >
> > Can you point me to an example of a driver that does 'not' do this? I
> > can not find an example where the PHY isn't UP regardless of the MAC
> > state (maybe I'm biased due to the boards I've been working with most
> > in the last couple of years) but then again its not because the MAC
> > driver brought the PHY up, its because it doesn't take it down and it
> > was up on power-up.
>
> Essentially any Ethernet MAC driver that calls phy_connect() in their
> .probe() routine would be doing this. bgmac.c is one such example, most,
> if not all of the time it deals with fixed-link PHYs because it is the
> Ethernet controller used with integrated switches, though occasionally
> there might an external PHY connected to it. There are certainly more
> examples.
>
> >
> > Some examples that I just looked at where if your OS does not bring up
> > the MAC the PHY is still UP
> > - imx8m FEC with DP83867 PHY
> > - KSZ9897S (ksz9447) switch/phy
> >
> >>
> >> The caveat with that approach is that it does not conserve power, and =
it
> >> assumes that the network device will end-up being used shortly
> >> thereafter, which is not a given.
> >
> > agreed... it seems wrong from a power perspective to have those PHY's
> > up. I recall not to many years ago when a Gbit PHY link cost 1W... and
> > I think we are currently way worse than that for a 10Gbps PHY link.
>
> Quite likely, yes.
>
> >
> > Then again think of the case where you have a switch with ports
> > unconfigured yet connected to a partner and all the LED's are lit up
> > (giving the impression visually that the ports are up).
> >
> >>
> >> For LEDs, I would argue that if you care about having some sensible
> >> feedback, the place where this belongs is the boot loader, because you
> >> can address any kernel short comings there: lack of a kernel driver fo=
r
> >> said PHY/MAC, network never being brought up, etc.
> >
> > I agree that boot firmware can and perhaps should do this but often
> > the PHY config that is done in the boot loader gets undone in the
> > Linux PHY driver if the reset pin is exposed to the Linux or in some
> > cases by soft reset done in the Linux PHY driver, or in other cases
> > blatant re-configuration of LED's in the Linux PHY driver without
> > using DT properties (intel-xway.c does this).
>
> Unfortunately if you care about consistency or independence between the
> boot stages, you have to duplicate things a tiny bit, for the reasons I
> mentioned that while you might bring-up networking in u-boot, you may
> not in Linux, or vice versa.
>
> It's all wonderful if you can come to an agreement as to what belongs to
> the boot loader configuration and what belongs to the OS configuration,
> but in practice there is quite a bit of overlap due to each one being
> somewhat independent. I don't think there is a hard and fast set of
> rules, because all of this is inherently PHY specific, but there should
> be some general consistency that applies, starting with LEDs. Best if
> you can just HW strap though...
>
> >
> >>
> >> For errata like EEE, it seems fine to address that at link up time.
> >
> > one would think that makes sense as well but the case I just ran into
> > was where a KSZ9897S switch had a network cable to a link partner and
> > the link partner would 'flap' with its link giong up and down due to
> > EEE errata until the KSZ9897S port was brought up which disabled EEE.
> > In this specific case EEE could have been disabled in U-Boot but that
> > would also require some changes as U-Boot does the same thing as Linux
> > currently - it only configures PHY's that are active.
>
> OK, but unfortunately I don't see how you can avoid not making those
> changes in u-boot.

So you are thinking the right place to address this is in boot
firmware and the network switch init there should go and disable all
PHY's by default then? I'm good with that approach and can code that
up.

But then based on the point that Linux and boot loader should be doing
the same things and be independent from each other I would think the
kernel should do this as well.

Best Regards,

Tim

