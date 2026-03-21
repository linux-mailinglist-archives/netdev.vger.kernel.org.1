Return-Path: <netdev+bounces-270160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKVLLHMOvmlQFwMAu9opvQ
	(envelope-from <netdev+bounces-270160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:20:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C42E3174
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 432773007CAD
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90128725A;
	Sat, 21 Mar 2026 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E4MAcEA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16547230BE9
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063119; cv=none; b=GScUl6Mi+HkZFY7dkvyZCRaa0rrjjxXdWDtjpCJn/LsZOr1cZ1dxuSxce9Ar1qlmTlUbfl/lT0MOe232bBTPeJybQR3BoxZG7hb1i3ALucumWeeM6CF8iJ9f5xzyx43EshGa4wC4t+bWa2ksCFiRqe1GIO1SBSqO/Jv9IECHmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063119; c=relaxed/simple;
	bh=KCouMn/Dg6hm0eYmov7z8hH1AZtJwHW0P50SCpJ5vto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ho9jpBqKjuLvHz4HpEg47WwAy7ftG5oEnm8Bs8l+BxlQcteWK5tlpeRpYT5ODh7Li0H1szeI0DtpbGJJhWN9aou3O02D4rPaapnI9yC4j64t8CYSdXJnLX4Kh5YLs7nctQFReHR4bJCmKpyNzWxSwC6nrkqQo3HzpTFvjU/gQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E4MAcEA0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so3308562e87.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774063116; x=1774667916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=E4MAcEA0o+/VwmebsmhAz7rvUEK9bN34+6Ckd9GkRk9uYtI+QYImvBA0I5RXIwsP+q
         Us0ouZ52ezQ3UFp53hhIx1BMxOqhhc72UMW7BDJ8o57fslmZD/UGJFRLCqKRljqh6ObP
         zUowVl+4RwtOqnS0PcVPXTYt4mFTORWKZmMrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774063116; x=1774667916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=js0AIfqozdY6NVRZ5ZjB9w7EWBM+vaAcyLy9khPmx2HcWv2EQ58byF1bg4apj0F1pm
         k1N9rG+bWVGtFuBsgKK5mLE4l+Jw8Y2urQw6kDy0cGu82FkoTE5ALwp3PcH9GDnyA8s1
         s4KHVbKbvBBfqYROG7kjKqmVzRCrN/PAHi7NbIRZ+n/A1oWdvp2JtJ4bTBt3v03b+Y8m
         JoDHk+m19qnHqynEuUCaMmXB4GxIWFqOFhn+VxMsfDEbS2mKoVWweF3LXbRwVNye8e6R
         dgFSH7lZClB3j1/KCvgJ26DlKdRdgPh9BYHcNiEw6dRIl2VJFQYsrstZ8XAzB8IQcwN0
         xdcg==
X-Forwarded-Encrypted: i=1; AJvYcCVMSkscO7yTnVSUk7OVE4iUZp4qBEBVN64ei0r/jpTGSFKxLL9BNLtIDXhn3QIxCY5mwR8eAe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8nEg9JMYWtVodlvEjwU0R/1daG/yRvnBgMZmMJ0OYLX8SFiQ
	NAlggQ1LZ28fstc545hx9e/YcoBBtLM2/xoVJFbWcw+pHbSFoirJZuNBQIszCgemRrIewSK8uSp
	XaB8Hj3gR
X-Gm-Gg: ATEYQzxXgXELo82P5fYHlG71sDuHnNAd9YpuswgQTJKlgkTO8gsZI8q3SCWS1NnBlT7
	HWKn43WI5sTUat5iOYJycHfTDvXRtf7xbKAmQwIhICSlGr6bUWTa7u3hsYCv0JS8+SP/SazukgY
	OdUrO1AEFjQf8joycqonUSNqYGXvdd9NVt7o47pwo4HdSMKKq1UCKTHx5vb6AOrOXOgetwHkpsk
	xG+5wgC14bBColsLfAOStiQWKnylcnTm4eEhLx6w1q4Xv1pUvpBrOczOljO7wedX6wzZSv2D/fY
	onaSbGrB5MpUBZyd5/jlguTH4pPjqLQjT0RCafVlasjqHr0JBd6JMwpM1hXhmi9sZmkRKkDyypi
	Kz5qqwhgM/6uq5Wz6M9JvkTNF5OQ9C4yjR4t6RBzO8hBrNq7gVr5nSERgXhjUk3vtUpQQ6/RHiI
	gyppG4KLZtbvahPREtbHZ1GOql3JjsYmLDxLFcDqXStN981DpbTzllm2VPZBc7MTu/mkQD+Jyb8
	Esp
X-Received: by 2002:a05:6512:3196:b0:5a1:3437:84a2 with SMTP id 2adb3069b0e04-5a285b445e2mr2210372e87.23.1774063115781;
        Fri, 20 Mar 2026 20:18:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853055bbsm894489e87.60.2026.03.20.20.18.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 20:18:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38bda6da51cso19419251fa.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:18:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL00umGw6a7qfTfQSAakxLMIYNi6AHiNUckvyZf4UgwyiiOvkhAdkcBZQhWuf0Zbn6Xdj8k0s=@vger.kernel.org
X-Received: by 2002:a05:600c:8119:b0:485:345b:ccb1 with SMTP id
 5b1f17b1804b1-486ff031f5dmr63989995e9.27.1774062615176; Fri, 20 Mar 2026
 20:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com> <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 Mar 2026 20:10:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
X-Gm-Features: AaiRm53JJySLwTXCCA6qh8x4Qo2JwYxEnfOViwtwDhVjyjDx4WswvOZrKm9fsCw
Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Saravana Kannan <saravanak@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270160-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,sang-engineering.com,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,sang-engineering.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 160C42E3174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Mar 19, 2026 at 10:52=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kerne=
l.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > >
> > > In various places in the kernel, we modify the fwnode "flags" member
> > > by doing either:
> > >   fwnode->flags |=3D SOME_FLAG;
> > >   fwnode->flags &=3D ~SOME_FLAG;
> > >
> > > This type of modification is not thread-safe. If two threads are both
> > > mucking with the flags at the same time then one can clobber the
> > > other.
> > >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> > >
> > > Create some accessor functions for setting, clearing, and testing the
> > > FWNODE flags and move all users to these accessor functions. New
> > > accessor functions use set_bit() and clear_bit(), which are
> > > thread-safe.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > While this patch is not known for sure to fix any specific issues, it
> > > seems possible that it could fix some rare problems. I'm currently
> > > trying to track down a hard-to-reproduce heisenbug and one (currently
> > > unproven) theory I had was that the fwnode flags could be getting
> > > messed up like this. Even if turns out not to fix my heisenbug,
> > > though, this seems like a worthwhile change to take.
> >
> > Reviewed-by: Saravana Kannan <saravanak@kernel.org>
>
> Thanks for the review!
>
>
> > Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> > it here, I might be able to take a look at it too (no promises).
>
> I don't _think_ it fixes my bug, but I'm still not 100% sure because
> the bug can take a day or so to reproduce and it appears to only
> reproduce on official kernels built by the builder. :( This makes it
> hard to say anything for certain and also hard for me to inject extra
> debug logic.

Just in case anyone out there was wracking their brains based on my
description of the bug...

I've made progress in getting the issue to reproduce even with debug
information added. With that, I've found that
device_links_driver_bound() is getting called where `dev->fwnode->dev`
is NULL. That prevents it from running the ever-important
__fw_devlink_pickup_dangling_consumers().

I can see that device_add() has started, but it just hasn't made it to
the `dev->fwnode->dev =3D dev;` line yet.  My printout next to that line
shows up _after_ my printout in device_links_driver_bound().

So obviously something can happen to cause the device to probe before
the call to bus_probe_device().

OK, I managed to get a stack crawl for when `dev->fwnode->dev =3D=3D
NULL`. It looks like this (FWIW, it's a 6.6 kernel but issue also
reproduces on our 6.12 kernel, and I see no reason it wouldn't
reproduce on mainline):

  Call trace:
  dump_backtrace+0xe8/0x108
  show_stack+0x18/0x28
  dump_stack_lvl+0x50/0x6c
  dump_stack+0x18/0x24
  device_links_driver_bound+0xa4/0x4b4
  driver_bound+0x48/0x1c4
  really_probe+0x244/0x374
  __driver_probe_device+0xa0/0x12c
  driver_probe_device+0x3c/0x218
  __driver_attach+0x110/0x1ec
  bus_for_each_dev+0x104/0x160
  driver_attach+0x24/0x34
  bus_add_driver+0x154/0x270
  driver_register+0x68/0x104
  __platform_driver_register+0x24/0x34
  init_module+0x20/0xfe4 [max77779_pmic_pinctrl
e09198e651272bc5df70245355346d6eb1ba3a8f]
  do_one_initcall+0xdc/0x360
  do_init_module+0x58/0x23c
  load_module+0xffc/0x1130
  __arm64_sys_finit_module+0x260/0x300
  invoke_syscall+0x58/0x114

It looks like what happens is that immediately after device_add()
calls bus_add_device() there's a possibility of another thread
inserting the module holding the device driver. That means that the
driver can start probing much earlier than we expect.

I've posted an RFC patch to fix this. If folks are interested, please revie=
w it:

https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabc=
ead688d0d8c17@changeid

Given the stack crawl I got, I'm fairly certain that this will fix the
problem, but I'll also let reboot tests run over the weekend to
confirm.

-Doug

