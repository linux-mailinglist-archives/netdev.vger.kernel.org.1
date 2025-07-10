Return-Path: <netdev+bounces-205971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBBCB00FD6
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C75760A52
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF28286416;
	Thu, 10 Jul 2025 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwJrxykV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42D156C6A;
	Thu, 10 Jul 2025 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191085; cv=none; b=ZXmKGujnEGK+X3f6G5bH2dsvVVcL69hh26SMf03D6gGBtbmfYaME9DGcB8YPsWuY5V4LH504OhJIAiszCdnyFWjxUwQSlcGqCs1n1CblvEq7n+nacp8tgSgWWEP44KEmOqlRs56BiTVL/qjnRNBf5HvuWoz+0U4pKuW04NfNY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191085; c=relaxed/simple;
	bh=z259Q4Tp0gYxqEYztifZv2fErAWVdioCuOGrk7OoTbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNgOsHRXX7xjBPym64UrVhCW6RUqL5h7e7jxdV/Yhf1hVL/Uiju+UAotvmv0DhU5N5S3exmS9xAO013mZRO+xGqgtX/XKvSQFYWaPHw19Yqb/4ztAiAhkFDerGFVpaKsQ6nGa0KYpw+BzfItM2xO6lc/H9j3jZrPk7yVwXHScJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwJrxykV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so14512466d6.1;
        Thu, 10 Jul 2025 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752191082; x=1752795882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvHb1sTKcUnKWQiFLR2r0sXY29OXUGa2fygx6L+kD/Y=;
        b=jwJrxykVKGHlVkNAPv5/HyyZWpdyIDgtiSzhPaWmJJt4VPEY/IgFb58fs2HCshTTSh
         0KDLVQ5yC+BLQQjlUJHnoH0zfsUR04IA0YwUUTsa25bP0bmP/SLhVNJitBlUPjf24Mk3
         kY2ya12YJKhpaRXV+zJEsMw5wxY0IZ38EuLHeUsVrPorTXnKwfgvhGYrdqHDd40U/+4s
         Is59MeP8JnJMK82nw7/OuPp75hVAphMm0SqkEcdw5zLGtZk8DUfRialvHn8pqDDaeqVa
         T4HIHgdJm9sFYfG0WPOqdYwvjeN3mnXAvNEfwp9/Ykuw4l7MehMBwZTZejzMASQYU3Qv
         DuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191082; x=1752795882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvHb1sTKcUnKWQiFLR2r0sXY29OXUGa2fygx6L+kD/Y=;
        b=pnrrnEPoU+xAIp3Elm7XoYOWYCtA1+gL9tPomUIPvt30ZdOuBKZ97y3r70EFukcrSl
         Z4pL+vxIMIN8eYDZR7glcVlMEGf4Vdu15g1cHezxIceOxPFQSZjQrO4qDBAwJDdv+MXi
         kUPs5fVRAb/LOq5C1ZgH4TI9r2+lthoCNXq8c8l9eqhdBSScLSlkid/F/SQ4MeSROawy
         qb6AApzx47E4h/MoAwicuO4LrzoDSpv1z7o2H0ElnQnwbOTcxSH+SgcHJPA99brDiQ84
         cksOKYhYJbBrdn8QVt/TnXnjewiB2w9DbkDZxEIs51qhw8XMu7UBIuJx9/gdmIgQ9XeF
         u+/w==
X-Forwarded-Encrypted: i=1; AJvYcCU8BIsXEcApVOuP6aXfKXcOk7Lss/dgLjrPNiGfmijTlWlszC5Jaov8J8Pv5lefRzb08mKCOYGH@vger.kernel.org, AJvYcCVbbs1udmZOeEMywoFXRLJ3690BXJnSIb0l/Voa8+IAwHu9++W5PKYPwtjlKpIsgUZaYsloa6veXKuBjKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JK5Z2Q6RkdlEaC8VUYE6oT5kKepLW8JvCFmKH8ymuSm1jpxe
	IZRkXCfa9ZBZeTvyoy/x3cmEzctvg3cGddwpWRfV2EJfmjiHFiJOBXkV4DsDLMGvH8FP1mVKahs
	KXb4z5WI1ttqlqwDxElbQjSGqcMIY6pM=
X-Gm-Gg: ASbGncu0hABU8X8D+o67XUgiR9eXqYN7/Ui5hU5PUILeYHj2J8vbeK9oPEN9LlpjS3n
	vY4zhC+ySd81PXaC6/dDCnJK08kJcLQCWPEB5zgFyBGCuhCN9UIJY8s2UCqeIL8euCyPg1KPKeZ
	QrsCiyUerRNXX0IEpJ5GN+Y1Z7awcHACtiBG3RvU7yfMb+sxA5Ev2Ie1tb1joRGQqGYdM6++AGy
	R9cQn8jlkTpAiUwUQ==
X-Google-Smtp-Source: AGHT+IECn/n0UQxfjfmrc0JZ37l9MntH3ViegnY1pzNYqOmMOwyY2zJneRJkjnV11tv8X7MfRtah4FaMa5qXVb02Wa4=
X-Received: by 2002:a05:6214:258f:b0:6fa:fddf:734b with SMTP id
 6a1803df08f44-704a38aca5cmr19606046d6.24.1752191082171; Thu, 10 Jul 2025
 16:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEwfME3dYisQtdCj@pidgin.makrotopia.org> <24c4dfe9-ae3a-4126-b4ec-baac7754a669@linux.dev>
 <20250709135216.GA721198@horms.kernel.org>
In-Reply-To: <20250709135216.GA721198@horms.kernel.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Fri, 11 Jul 2025 01:44:30 +0200
X-Gm-Features: Ac12FXzK9auwvTPHIQwIDGSyod4bJnXDWkv_0u6wuaDfHP8r6J2VKj0fDuUQv6c
Message-ID: <CA+_ehUyDOE-4_FD42BHKXjyT2kWxxWtpy_+HU2bwZXu9TRE7eg@mail.gmail.com>
Subject: Re: [RFC] comparing the propesed implementation for standalone PCS drivers
To: Simon Horman <horms@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, Daniel Golle <daniel@makrotopia.org>, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Russell King <linux@armlinux.org.uk>, 
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
	Lei Wei <quic_leiwei@quicinc.com>, Michal Simek <michal.simek@amd.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>, 
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>, Robert Marko <robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 9 lug 2025 alle ore 15:52 Simon Horman
<horms@kernel.org> ha scritto:
>
> On Fri, Jun 13, 2025 at 12:06:23PM -0400, Sean Anderson wrote:
> > On 6/13/25 08:55, Daniel Golle wrote:
> > > Hi netdev folks,
> > >
> > > there are currently 2 competing implementations for the groundworks to
> > > support standalone PCS drivers.
> > >
> > > https://patchwork.kernel.org/project/netdevbpf/list/?series=970582&state=%2A&archive=both
> > >
> > > https://patchwork.kernel.org/project/netdevbpf/list/?series=961784&state=%2A&archive=both
> > >
> > > They both kinda stalled due to a lack of feedback in the past 2 months
> > > since they have been published.
> > >
> > > Merging the 2 implementation is not a viable option due to rather large
> > > architecture differences:
> > >
> > >                             | Sean                  | Ansuel
> > > --------------------------------+-----------------------+-----------------------
> > > Architecture                        | Standalone subsystem  | Built into phylink
> > > Need OPs wrapped            | Yes                   | No
> > > resource lifecycle          | New subsystem         | phylink
> > > Supports hot remove         | Yes                   | Yes
> > > Supports hot add            | Yes (*)               | Yes
> > > provides generic select_pcs | No                    | Yes
> > > support for #pcs-cell-cells | No                    | Yes
> > > allows migrating legacy drivers     | Yes                   | Yes
> > > comes with tested migrations        | Yes                   | No
> > >
> > > (*) requires MAC driver to also unload and subsequent re-probe for link
> > > to work again
> > >
> > > Obviously both architectures have pros and cons, here an incomplete and
> > > certainly biased list (please help completing it and discussing all
> > > details):
> > >
> > > Standalone Subsystem (Sean)
> > >
> > > pros
> > > ====
> > >  * phylink code (mostly) untouched
> > >  * doesn't burden systems which don't use dedicated PCS drivers
> > >  * series provides tested migrations for all Ethernet drivers currently
> > >    using dedicated PCS drivers
> > >
> > > cons
> > > ====
> > >  * needs wrapper for each PCS OP
> > >  * more complex resource management (malloc/free)
> > >  * hot add and PCS showing up late (eg. due to deferred probe) are
> > >    problematic
> > >  * phylink is anyway the only user of that new subsystem
> >
> > I mean, if you want I can move the whole thing to live in phylink.c, but
> > that just enlarges the kernel if PCSs are not being used. The reverse
> > criticism can be made for Ansuel's series: most phylink users do not
> > have "dynamic" PCSs but the code is imtimately integrated with phylink
> > anyway.
>
> At the risk of stating the obvious it seems to me that a key decision
> that needs to be made is weather a new subsystem is the correct direction.
>

If you want to expand it a bit it's about new subsystem + making things
more deterministic.

> If I understand things correctly it seems that not creating a new subsystem
> is likely to lead to a simpler implementation, at least in the near term.
> While doing so lends itself towards greater flexibility in terms of users,
> I'd suggest a cleaner abstraction layer, and possibly a smaller footprint
> (I assume space consumed by unused code) for cases where PCS is not used.
>

Funnily enough almost all implementation have an attached PCS either
if it's something very basic or it's something more advanced (normally
this is 100% of the case when 10g is supported)

Soo case where PCS is not used are very little and in the case where
it's not used it's just an empty pointer and some bitmask for PHY
interface.

> On the last point, I do wonder if there are other approaches to managing
> the footprint. And if so, that may tip the balance towards a new subsystem.
>
>
> Another way of framing this is: Say, hypothetically, Sean was to move his
> implementation into phylink.c. Then we might be able to have a clearer
> discussion of the merits of each implementation. Possibly driving towards
> common ground. But it seems hard to do so if we're unsure if there should
> be a new subsystem or not.
>

Honestly speaking this case is very similar to some situation where Russell
had to intervene as the implementation reached criticality (a recent example is
EEE where the only solution was to provide to phylink more info so correct
decision could be made preventing MAC driver doing strange broken stuff)

I'm still with the idea that PCS handling in phylink should be improved.
For example there is a big problem where phylink doesn't exactly know
what interface are supported from PCS or MAC with the MAC driver
implement the common pattern of ORing the interface supported by MAC
and by the different PCS.

I feel that even if the wrapper solution gets accepted, phylink requires a
big overhaul for PCS handling. (And Russell more or less already started
it with filling some condition when the select_pcs fails when the interface
change)

Things are getting complex enough that in some scenarios the PCS
might fail calibration or might """explode"""" after a while and phylink
is currently not designed for that.

And also worth considering that for 1gigabit connection it's possible
that something will fallback from usxgmii to sgmii in this extreme case
and I feel phylink should be able to handle that smoothly.

This is really just to give some context hoping it gets some traction
on why we really need to start fixing the problem and putting effort
on it. (my opinion is that it will only get worse, I'm scared to see
the complexity of things when 10g+ stuff will reach consumer or
prosumer market)

> > > phylink-managed standalone PCS drivers (Ansuel)
> > >
> > > pros
> > > ====
> > >  * trivial resource management
> >
> > Actually, I would say the resource management is much more complex and
> > difficult to follow due to being spread out over many different
> > functions.
> >
> > >  * no wrappers needed
> > >  * full support for hot-add and deferred probe
> > >  * avoids code duplication by providing generic select_pcs
> > >    implementation
> > >  * supports devices which provide more than one PCS port per device
> > >    ('#pcs-cell-cells')
> > >
> > > cons
> > > ====
> > >  * inclusion in phylink means more (dead) code on platforms not using
> > >    dedicated PCS
> > >  * series does not provide migrations for existing drivers
> > >    (but that can be done after)
> > >  * probably a bit harder to review as one needs to know phylink very well
> > >
> > >
> > > It would be great if more people can take a look and help deciding the
> > > general direction to go.
> >
> > I also encourage netdev maintainers to have a look; Russell does not
> > seem to have the time to review either system.
> >
> > > There are many drivers awaiting merge which require such
> > > infrastructure (most are fine with either of the two), some for more
> > > than a year by now.
> >
> > This is the major thing. PCS drivers should have been supported from the
> > start of phylink, and the longer there is no solution the more legacy
> > code there is to migrate.
>
> This seems to be something we can all agree on :)

