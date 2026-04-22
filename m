Return-Path: <netdev+bounces-280306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB48OGZK6GnMIQIAu9opvQ
	(envelope-from <netdev+bounces-280306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:11:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41950441F24
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE92302000F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B625782D;
	Wed, 22 Apr 2026 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5+9ubs1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DB21CC5A
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776831056; cv=pass; b=ch2uag+YbPEJI1UvBTRtpz9Mf5rT2osnMg5YbCmui0nei9jPt3MbTgylYrpDESJ3Hv+3qOGudWn3iDAjfJ6x1s7U/l+fsRb6sD4KYcon0GWkzb8LZCnnqRrXD+bNTzPe74dCkODlxdb5y0o9/GyalOR+zR8Gus/wB6ey82e+lpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776831056; c=relaxed/simple;
	bh=oy27W4go+NEVBJXlJgJAXp2NzrmsMpmtCyl7ZtqtBnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1Purxyu3+YLAAQe1vRM4bar/fZ8/E1ebFs9qYLIvOCR6og9Ld9ECmuKN5Xd2IW9le+4gEyLpZgC9heFhAtgy9Dyle6vlVyobhG0KYy01qNR+koBLqmFQICeWVP8CNCMREi5/W15tFUBVg5YsYOsim8UOVKiBSTCrC2FwMQ6kGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5+9ubs1; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6715006f4f7so7566321a12.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 21:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776831053; cv=none;
        d=google.com; s=arc-20240605;
        b=hWHMj2WIPEqvpGnRxiUfeIpk46NlgLM5y4retKYqAXmB91a5Vaa6BVkCcJJ7gGImHk
         jrb5fkQrZQfIJfS6tYnTZnsm7JEwYyUoKUcoIon7EyMM3GtL4K78H26owYt4UPA1I2cp
         iRcHsPkijToKOZOSBoWnj9qfUlYy0kB7mqeTQGrpbgUZgXuyVTxWhbEOmq3EfeOTKMdY
         NP15mAidsjBYOtYsRqXcAP08PtFvb3ylQPWpaOSZUl1eIa0mCbVYdID7NqwjlIZSucGg
         hWM0PT8TU2EQbeaqEQCjhXCi7Sch9Pz/MQg2rJJyjcMZ3D1Z8t72ADIhwTFs50AoVpnY
         8fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oy27W4go+NEVBJXlJgJAXp2NzrmsMpmtCyl7ZtqtBnE=;
        fh=jBTiAQexXEr3NCmRjTMDW9ztnYMBNPXs69FIo8Ir+9M=;
        b=cJoSnYuIh1TRv/ty8bSwXK+l4rJ2VO17D48YwAnAFWuzo9xtCpZ/wNyl8xV3FXGwvs
         vNCVv+xu9kZmLljm97/dzAuQ4cTZDQnYVkekFuGUvboe51m+7Iq7l2E1jBn4jGSbmBP7
         EQcOh4pJ8EtmZUJjnN6TUDXzaqTaIUWaNj6yTr/p4shHDx1QZOg8rv/tEqNuxLy709+P
         PAPQePuC8wsJ2xG84ZpG0vrnHHPGFAP1ycYAQhAWcHcArLPNyp3rzgv2Dy4N9FEhgLRK
         Xjg1I4jX6TamXIKK4H0BRDACtXh+ZHJSWXbOPZmkTv4upQ2iEcXPR+bp13kZZeZ3X9jj
         BjWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776831053; x=1777435853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy27W4go+NEVBJXlJgJAXp2NzrmsMpmtCyl7ZtqtBnE=;
        b=W5+9ubs1iaJdX/8KIkPa/EBAynOakNxJAmNYfb6G8DnAk4MV7mSOFJaDiHpzxl1N15
         +3eomAmj1dA0HwV4G6DzfWpjRUco63m6/z8W0R6820zrS6l8V5UfozGkInVztSE497vY
         D3kySR5pjpBmfrhjcQxDLMGuD2xj8pu6103Pqwk2plw8D3BQCnEUWNtqmoaUTe93ZGQ4
         kcPesd1t+Z9sZtWbrhSZ3IySQI7+olpHSVwKS4nA+UeABH2cfWl4kUtDAFgQEvs6n4Xz
         mh1JhjHvt6TAoAd+s3F11ONcQXn/WU8y4uohBBJFx131YQir/piqx6WbXOxlINg4paHP
         Ni8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776831053; x=1777435853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oy27W4go+NEVBJXlJgJAXp2NzrmsMpmtCyl7ZtqtBnE=;
        b=qO06uIaZD627JpAWQlaVAWZvs2dRaXs8948IpXbRMEE2ahM6LobYnikj8fdOr+LgQO
         viY5bfttLtPF86kY8jIPEYIbDTNgAR8SC7bjr2DwkxeJqOUPobuZ8CQIsrlwME5h+R3t
         6QCMu46poPjmlfWlnVnrkwlA6yZPBJhVI9Xrnu3V3TMqnik4e0N+T1pj8uTz58RojcZr
         kIYHwl9p6SCf7/l8jK4filmaDCMfE8lnddsAZHnoS1M42ews/R9QCZTNU45tGqwwdku+
         AQLzKN+7RV8gEmGouj3mXPs2tUAcxiF57nWIPRCXp1nOwoJ80VQoQvm+PruK1P/cSgnz
         jSOA==
X-Forwarded-Encrypted: i=1; AFNElJ8+mNzeQCpzfAn/2X4GlLsmfNYHMkn42Bda2NxxdatNEGE5csvbncD7TDBObT+39LPVfFxZ7Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxST8umopj4evMMUgQaBnUKDqymX41XTXcSyXOn7XdujZrEhuEo
	uhuCI0FpFSz57KqlOYE1AKa6ayU5C/BKOBUuJY38SPgbBi7YNTMnEYQ5bBXmPZurJESYkWV7fms
	05IB5PLMrURUbezstWi7/9LHaZNTX9lo=
X-Gm-Gg: AeBDiesyKA99m88HDo46g1Uh8cQkZtq4f/Gv5LImjJjiPlblcqrYkS14i86se78YW9p
	pC3x5v9cZOG3Shg7xM/AzSjfxza6RcBoqolQahG9AVf1P+7VgMvUjeYi1kEzVVt7hbulc9XFded
	iCPi50DyKVLbL5ZAKKGCRc/p5R8FzCscwGAg3loVo5I6Xu0DYoLv15jtAlZkEpk1CNg3ek4SL0W
	u7EKb4T0g4pESJB1MqnZ0PETlqsu1e5SfhBub7w465xAsJjOt/cfC/jnGcGIKl7JRL33xabzE7/
	Wk2yoOv8FN+RTeLfUXlr4qyd+L7LlLZzgfYSxO5RLtyos9Zo1bs=
X-Received: by 2002:a05:6402:21c3:b0:672:c22a:289a with SMTP id
 4fb4d7f45d1cf-672c22a29f2mr6891191a12.9.1776831052477; Tue, 21 Apr 2026
 21:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com> <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
 <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com> <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com>
In-Reply-To: <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 22 Apr 2026 01:10:39 -0300
X-Gm-Features: AQROBzCUjpgNtqnWYtZlutf9AdBOv3iRA7kppfZnpolORaVPyV4w2BB1lslTT5c
Message-ID: <CAJq09z6O81Sev07pQiQzCXzbKC2JxBCjep6=tX2Noqd=pPW1KQ@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 41950441F24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Even if we end up splitting out VLAN, I think my comments on the other
> things that can be shared are still valid as well.

Agree. It is generally more effective to refactor and share code once
the target models are well-understood, rather than aiming at a moving
target.

> > While rtl8366-core is currently only used by RTL8366, I understand the
> > goal of sharing VLAN handling across these drivers. However, RTL8365MB
> > differs from RTL8366RB in how VLANs and PVIDs are implemented.
>
> To give the whole picture, RTL8365MB wasn't even in the picture when
> this abstraction was created.

The logic is indeed similar in several places, but the overhead of
creating abstractions or indirect calls for relatively simple
operations might outweigh the benefits of reuse at this stage.

> The ASICs the driver was supposed to handle (and which were/is used
> by OpenWrt) were:
> - RTL8366RB
> - RTL8366S
> - RTL8367
>
> The abstraction was part of the outoftree "swconfig" driver for a long
> time before being migrated to DSA.
>
> I haven't yet wrapped my head around if the RTL8367 (no extra letters)
> is more RTL8366RB-ish or more RTL8365MB-ish... take a look at the
> old code if you can figure it out from register maps etc:
> https://github.com/openwrt/openwrt/tree/main/target/linux/generic/files/d=
rivers/net/phy
> (maybe Gabor knows, put him on cc)

I have experimented with the RTL8367R (found in the TP-Link
TL-WR2543ND), which appears to belong to the RTL8367B family. From
what I=E2=80=99ve observed, it behaves more like the RTL8365MB. However, my
visibility is limited to a small subset of registers used in U-Boot. I
haven't been able to confirm if the switch supports a CPU tag or how
to enable it, as the registers used for the RTL8365MB did not produce
the same results.

> OK seems we should split up the VLAN handling if there is nothing
> to share in the abstraction here. We don't do abstraction for abstraction=
s
> sake.
>
> I'd say make a patch moving all functions from realtek_ops
> that can't be reused into the rtl8366rb driver and make them static.

Merging rtl8366-core.c into rtl8366rb.c would likely simplify the
implementation significantly and remove unnecessary indirection.

> But probably keep the shared core for other stuff. Though I guess it
> might be empty then until we add more stuff :/

Not empty as we already have some functions from rtl83xx.c :-)

> > This could be explored in the future as a separate effort as it
> > changes how RTL8366RB driver behave. For now, I would prefer to keep
> > this implementation local to RTL8365MB and then follow up with a
> > separate effort to reconcile both drivers and extract shared logic.
> > Some of that work will likely become clearer while adding RTL8367D
> > family support.
>
> The reason I push back a bit is that any kind of things that are
> "fix later" tend to never actually happen in my experience.
> Either we add the abstraction now or never.

I understand the concern regarding "technical debt." However, forcing
code sharing now carries the risk of regressions on legacy hardware
that is difficult to test. Keeping the implementations distinct for
now ensures stability for these older devices while we refine the
RTL8365MB support.

> For VLAN I'm pretty much convinced that there is not much to
> share. For port separation/isolation and possibly FDB I'm not as
> convinced.

It remains difficult to determine the best path for sharing port
isolation or FDB logic without a clearer picture of the future
rtl8366rb FDB code. Specifically, differences in IVL logic might make
shared abstractions more complex than they initially appear.

> Yours,
> Linus Walleij

Regards,
Luiz

