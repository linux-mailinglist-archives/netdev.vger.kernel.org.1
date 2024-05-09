Return-Path: <netdev+bounces-95026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857048C1432
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D511C21D2D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06255E40;
	Thu,  9 May 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ig2l67xS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65D56B67
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276419; cv=none; b=Kj2H48wk9B2CG3k+HqXma77TfqwpNtEJHMP96ps98op9gML2H+3jLJJgNsCsDYb+JZCUXOiw+P83S/rUwFPTRrL2YP9yZ9lBrce8H1hB0eNxYku+a1SYbGtprvqEbEz2gp0rwtvsMMBphauqjC52vJyTQ7tq0icue+WWuh88i2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276419; c=relaxed/simple;
	bh=+JJ3OgJl4Lh3xvKOAMjBnHajAacDL9RZkh7lLjWbwrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t82byU5k0SHm30BrzchZvcZYxyZG2Dz2B0t+lp27nVHMaqJ67LlLhI3/JvjvqHZa5oMbM3jILE9s+zujD4U7Xn2IsLNoBDLoEN5K5DEa0mNToevwu1Q46aAmULoKZx0hZtRjNH+vZvIySV+DvptyBfwA9T73KBN5a3Xr4OCJykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ig2l67xS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B06353FB75
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715276415;
	bh=ainzmkdiFZatTBBNnswuHUf0cvHV/VEu7RERUQouf94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Ig2l67xSccdbNwpLvNgrcRvD18UzVb8iUO9nOXi2imeXtTKAU7iJEwrwBWb4isPQ7
	 BEwz2NaJ0UKx3JpaGeBvQ+tTwt+V2Y4igGplO5YOhqjA1OX9jSLbjPUxGVLSGaa9zj
	 L3E6hJKGKXBMMGwF57lTy8hkgwqE+WQU3JtipHPYAeu0AEGXD1Ba+bWwgCizG+MxK3
	 ZL+ZQcPSZ1Od2y53lJGbZ5byXra8r8j0/P29/30gFs0XZihEWTZYPu9IBvQl4akm5Q
	 gOjxzFlDKuW0AOQGjUJWobQJiLbCugB0u58roMUz5rqxDWARz3zkytkHQgCSbwLsDF
	 0smyerdBWMCIg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34dc66313b3so779366f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276414; x=1715881214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ainzmkdiFZatTBBNnswuHUf0cvHV/VEu7RERUQouf94=;
        b=CjMfYV/4VAzVKJps06ql/3HOc27chTZBw0e5JeAu8+HCgkI0m9+Gv9uUbZ2h4dr8mb
         zEQBpv1McGz9UH3ZgyCQzt/O8C5DS0ImNE9FhHcmr+SbqD15DSjQI4V0AjkROvkK7xKu
         qUHPsQhIUqTilFQiMP+OgZSJK0hKtAzrkiWQTgGPn3GRZDqyLsp8ZFW0tNQDSChT8gLY
         58ueM4aC6lHPnRdD2tQStulI/Ct0LH7XSmwSUSyC+6uGIM0BhdgQuu7/unhEUb/aMR8B
         /Lblx9K+7XBfezhJd3+n49hp1+IhdnYp2owNpTAv19X4HhcvGHS9Xjl7vg56C5U3ZPeq
         2m0A==
X-Forwarded-Encrypted: i=1; AJvYcCUCzaaXBXrrpSa0R6VxLOvcgVYm7rZ2RSDguXauUxbSM3zng7hsQ1mI3h2q1J7oZxock6V3mrQkw+jdu5pLwBiI7SE6f3fb
X-Gm-Message-State: AOJu0YybYHWtlY+2Rd1BulLoP7Mpa1ZxSg/u8xNSktpK7jrF4m13T9YW
	NAqIEcM1Sm+NjdOny6dGjpz4uosPW5erqVvWkptaYjQyCCPjCQiOzEnDF/nTenBxWv629VqNpDZ
	+guPdpqO5gTefM1q6tgJOG787MevesyKqHDmVRBgwgrdwLom2jShnBy/QlOxTv5uCrF8wVrexQc
	41XH1Nx1TBChu4rGAc8opuHZFxWjQgeG3icYUrsg13QT3H
X-Received: by 2002:a5d:45d1:0:b0:349:ffed:792d with SMTP id ffacd0b85a97d-3504a7372a1mr278056f8f.30.1715276414424;
        Thu, 09 May 2024 10:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGadpoJUBLPLrGbKTI6NrhfHgQFMupVGgJHWXb6ctPt9UXT1JRQDQhiYxpWoe+IrnBQi24ZmA5VglKX5yH9fA4=
X-Received: by 2002:a5d:45d1:0:b0:349:ffed:792d with SMTP id
 ffacd0b85a97d-3504a7372a1mr278029f8f.30.1715276414106; Thu, 09 May 2024
 10:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503101836.32755-1-en-wei.wu@canonical.com>
 <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch> <514e990b-50c6-419b-96f2-09c3d04a2fda@intel.com>
 <334396b5-0acc-43f7-b046-30bcdab1b6fb@intel.com> <cc58ecfc-53f1-4154-bc38-e73964a59e16@lunn.ch>
In-Reply-To: <cc58ecfc-53f1-4154-bc38-e73964a59e16@lunn.ch>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Thu, 9 May 2024 19:40:02 +0200
Message-ID: <CAMqyJG2Xnn7VtT1CrCXK7ojuUmP+ig8uwB30uK3nprPo5hLiUQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: fix link fluctuations problem
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Sasha Neftin <sasha.neftin@intel.com>, 
	netdev@vger.kernel.org, rickywu0421@gmail.com, linux-kernel@vger.kernel.org, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	anthony.l.nguyen@intel.com, pabeni@redhat.com, davem@davemloft.net, 
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>, "naamax.meir" <naamax.meir@linux.intel.com>, 
	"Avivi, Amir" <amir.avivi@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"

> En-Wei, My recommendation is not to accept these patches. If you think
> there is a HW/PHY problem - open a ticket on Intel PAE.

> I concur. I am wary of changing the behavior of some driver
> fundamentals, to satisfy a particular validation/certification flow, if
> there is no real functionality problem. It can open a big Pandora box.
OK. Thanks for your help. I think we can end this patchset now.

> It is normally a little over 1 second. I
> forget the exact number. But is the PHY being polled once a second,
> rather than being interrupt driven?
If I read the code correctly, the PHY is polled every 2 seconds by the
e1000e watchdog. But if an interrupt occurs and it's a
link-status-change interrupt, the watchdog will be called immediately
and the PHY is polled.

> What does it think the I219-LM is advertising? Is it advertising 1000BaseT_Half?
> But why would auto-neg resolve to that if 1000BaseT_Full is available?
I'm also interested in it. I'll do some checking later to see what's
advertising by us and the link partner.

> Agreed. Root cause this, which looks like a real problem, rather than
> apply a band-aid for a test system.
OK. I think there is a clue which is related to auto-negotiation. I'll
work on it later.

Thank all of you for your help, I really appreciate it.

On Thu, 9 May 2024 at 15:46, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, May 09, 2024 at 12:13:27PM +0300, Ruinskiy, Dima wrote:
> > On 08/05/2024 8:05, Sasha Neftin wrote:
> > > On 07/05/2024 15:31, Andrew Lunn wrote:
> > > > On Fri, May 03, 2024 at 06:18:36PM +0800, Ricky Wu wrote:
> > > > > As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
> > > > > Intel I219-LM reports link up -> link down -> link up after hot-plugging
> > > > > the Ethernet cable.
> > > >
> > > > Please could you quote some parts of 802.3 which state this is a
> > > > problem. How is this breaking the standard.
> > > >
> > > >     Andrew
> > >
> > > In I219-* parts used LSI PHY. This PHY is compliant with the 802.3 IEEE
> > > standard if I recall correctly. Auto-negotiation and link establishment
> > > are processed following the IEEE standard and could vary from platform
> > > to platform but are not violent to the IEEE standard.
> > >
> > > En-Wei, My recommendation is not to accept these patches. If you think
> > > there is a HW/PHY problem - open a ticket on Intel PAE.
> > >
> > > Sasha
> >
> > I concur. I am wary of changing the behavior of some driver fundamentals, to
> > satisfy a particular validation/certification flow, if there is no real
> > functionality problem. It can open a big Pandora box.
> >
> > Checking the Bugzilla report again, I am not sure we understand the issue
> > fully:
> >
> > [  143.141006] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Half
> > Duplex, Flow Control: None
> > [  143.144878] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Down
> > [  146.838980] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full
> > Duplex, Flow Control: None
> >
> > This looks like a very quick link "flap", following by proper link
> > establishment ~3.7 seconds later. These ~3.7 seconds are in line of what
> > link auto-negotiation would take (auto-negotiation is the default mode for
> > this driver).
>
> That actually seems slow. It is normally a little over 1 second. I
> forget the exact number. But is the PHY being polled once a second,
> rather than being interrupt driven?
>
> > The first print (1000 Mbps Half Duplex) actually makes no
> > sense - it cannot be real link status since 1000/Half is not a supported
> > speed.
>
> It would be interesting to see what the link partner sees. What does
> it think the I219-LM is advertising? Is it advertising 1000BaseT_Half?
> But why would auto-neg resolve to that if 1000BaseT_Full is available?
>
> > So it seems to me that actually the first "link up" is an
> > incorrect/incomplete/premature reading, not the "link down".
>
> Agreed. Root cause this, which looks like a real problem, rather than
> apply a band-aid for a test system.
>
>       Andrew

