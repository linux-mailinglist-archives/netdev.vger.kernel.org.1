Return-Path: <netdev+bounces-194096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338FFAC7516
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E417E4A5F3D
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F237C1519AC;
	Thu, 29 May 2025 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fthOJ5f2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B18632C;
	Thu, 29 May 2025 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748478677; cv=none; b=pLxp5o0eLaahaXUMpu58vOgt5jlBx7BP0PKyyd8wmm57WQJt8vH96ikg9aPbjSytHTyOh1o7gdxxutbMuyme+82g7KFNaijzoATTsENEj3u6jrkQWFKHxhpHbW1W45+Y2d8wSwClku48J9KBaA0Y2PN9fSz8u1Or6D8/jJtmRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748478677; c=relaxed/simple;
	bh=q44z5Bd9/8IILONn0/cL0CaXO9i2aVCCm5R3K/3l5Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqxzs/049lp+K+iuPTr9zosjiSO8+tq7mCWsdYsYNh/zeOxWgZLnCCys0hQrU92DFsbzfKXQnGDbA4N7ttpZ+I8lIYoXlDPnzkitSwsYGznRjL+hBVCrRkIq39ZOK6DfpYt4Nzmnn/7wgmRvBkHWN01JD1lmQDxpD+QOoJ1gRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fthOJ5f2; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4c6cf5e4cd5so222062137.2;
        Wed, 28 May 2025 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748478675; x=1749083475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q44z5Bd9/8IILONn0/cL0CaXO9i2aVCCm5R3K/3l5Mo=;
        b=fthOJ5f2cLj3EfNnO1///vhDK3KILjyVO1Q5mH7lZcj/2Jsd9mRlaZ/bsL5IdYWFLq
         Acj8txVbBUJpkLJSFjcBelII3APH7CdFhkkmViysG+kiwtf11tb9fW2kxTOQ4gFUM/P2
         iu3VO7WXLFEFPf8mga67SnVxeCLEr45+NnK7YSi9aPSiGzo9+8ou2FBTNx98vSJyDUfy
         253I4uM+PFNRtx875O0vuAM4isfYT7AZzcPJr/X8oTPN7XlFE85zY1Q0CqiVCCPdrhVR
         9fwnNYtZ/cutZ5y0qHoWNFBJhJhaU0n3b0mpFS9uOR4IQBmot9LQx+6enjza8WoY49xW
         GAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748478675; x=1749083475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q44z5Bd9/8IILONn0/cL0CaXO9i2aVCCm5R3K/3l5Mo=;
        b=N/91TC1/kLw0qrdvvTlroSrBbFNtXTN2ayVJ98kPA79m/CzDhrhdL2BbxXP1LdJ+2F
         Gv4AB43cxOtZnlWHSDta2zPtrw/JsUDNRkLXSnuwJ8RuksVtb//bznUjmM+zEU0URDX4
         qtI6Tf0G++4SB8zSOd0DiTzBIsFwFDvUkFCAU2psIRr0rscbG/BOrzTsMC0Bs1KJEzCO
         Kj+WRBYEQG2Y/VY3wNSZKxmj9wdRW3dffdqKw/LbAhhQ1orEdNNDipBDNsCT1fM3pzLs
         KQglmZe/1qywdKvVKReE7HaSN7tdr19eO6zo63PAYQCqAYj+ldPwDNeXAqc6NCro0s/9
         EyZw==
X-Forwarded-Encrypted: i=1; AJvYcCWitC6s2/mHF0sxrff558jeIhwy5+4paiqEvqMS/eMr8rlq/GlKly2Q2A7kGg9ZB4xvvwFtmVhM@vger.kernel.org, AJvYcCXBt9GvS3Qs1/24fREy3EQ3WlbkAVQaJN6SQ1pFpNcKrXIVkb16M0E5x27uU4JmrRtN8kGNN9WQRKcsrR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWDUODJWiJYQulz/Hebxc5aVJzjhZ+UfysTswsUBltRSX2wMM
	FkLAMY+D0d/2TGN5He+ySjxndM8g83SnfT0DLwVCBL3CR6PJeWlofAxXlvfOjjDcOS2grh3sdxt
	IXeOJWTOBpZDMZYGoTx4tv5k32Q3QCU4=
X-Gm-Gg: ASbGncsuxV+sRKSoT9hGh+sDrUTpQG3caYXPZrtsn2rizb0IM2T0SRbtBhuM/01gSb3
	qUvUWddQHVGn4oVUeW3a+c/thgJ9xk0gQi9LgqlCXja3fQtKDWqbJAN6ZXLOO/70h6fGZ2kMzm9
	uSaj1tXefBkvjEgqzKkU6hmCcci6+bO4u/1w==
X-Google-Smtp-Source: AGHT+IFG095fC3FxIkcr8wXE/8rgaYSmXktT8c+7Ug5Ck8RJXbeQXCBHRZraCpMc7Swq4SZENwhJZHvYWPtIc5+DC5Q=
X-Received: by 2002:a05:6102:a51:b0:4db:e01:f2db with SMTP id
 ada2fe7eead31-4e67dd1919bmr264553137.0.1748478674832; Wed, 28 May 2025
 17:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
 <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk> <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
 <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch> <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>
 <1e6e4a44-9d2b-4af4-8635-150ccc410c22@lunn.ch> <CADvTj4r1VvjiK4tj3tiHYVJtLDWtMSJ3GFQgYyteTnLGsQQ2Eg@mail.gmail.com>
 <0bf48878-a3d0-455c-9110-5c67d29073c9@lunn.ch> <CADvTj4qab272xTpZGRoPnCstufK_3e9CY99Og+2mey2co6u5dg@mail.gmail.com>
 <0c7a1602-61d3-4840-83f2-72a74ffd52b8@lunn.ch>
In-Reply-To: <0c7a1602-61d3-4840-83f2-72a74ffd52b8@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 May 2025 18:31:03 -0600
X-Gm-Features: AX0GCFvqUXpScx-Ym-AQvb--BAqo5_tl8KEywhB2ivVxb9ECD-mfCTp-d4WPAIs
Message-ID: <CADvTj4q96aGsPi6wfMaxTnC-52-Svu_K6raj=LWyOJd+DniEUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, wens@csie.org, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:47=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Or, as Russell suggested, you give the bootloader both .dtb blobs, an=
d
> > > it can pick the correct one to pass to the kernel. Or the bootloader
> > > can patch the .dtb blob to make it fit the hardware.
> >
> > This is what I'm really trying to avoid since it requires special
> > handling in the bootloader and therefore will result in a lot of broken
> > systems since most people doing ports to H616 based boards will only
> > ever test against one PHY variant.
>
> Which in some ways is good. They will then issue four letter words at
> Allwinner, and go find a better SoC vendor.

No, they won't, because the vendor that actually buys from Allwinner
also uses the BSP and doesn't care as long as the BSP works.

>
> > > > > Do you have examples of boards where the SoC variant changed duri=
ng
> > > > > the boards production life?
> > > >
> > > > Yes, the boards I'm working for example, but this is likely an issu=
e for
> > > > other boards as well(vendor BSP auto detects PHY variants):
> > > > https://www.zeusbtc.com/ASIC-Miner-Repair/Parts-Tools-Details.asp?I=
D=3D1139
> > >
> > > Mainline generally does not care what vendors do, because they often
> > > do horrible things. Which is O.K, it is open source, they can do what
> > > they want in their fork of the kernel.
> >
> > That's not really true IMO, mainline implements all sorts of workaround=
s
> > for various vendor hardware quicks/weirdness.
> >
> > > But for Mainline, we expect a high level of quality, and a uniform wa=
y
> > > of doing things.
> >
> > Sure, and I'm trying to do that here rather than do some super hacky
> > unmaintainable bootloader based device tree selector.
> >
> > > This can also act as push back on SoC vendors, for doing silly things
> > > like changing the PHY within a SoC without changing its name/number.
> >
> > It won't here, because Allwinner doesn't care about non-BSP kernels.
>
> It can be indirect pressure. There are some OEMs which care about
> Mainline. They will do their due diligence, find that user report
> Mainline if flaky on these devices, and go find a different
> vendor.

There are zero OEMs in my industry that provide hardware with
any mainline support at all. The vendors are outright hostile to 3rd
party firmware and put significant effort into preventing 3rd party
firmware. The OEMs will view the lack of mainline support as a bonus
unfortunately as they like everything locked down.

> There will be some OEM which get burnt by this mess, and when
> they come to their second generation device, they will switch vendor
> and tell the old vendor why. It could well be Allwinner can support
> their bottom line without caring about Mainline, so really don't
> care. But Mainline can help point OEMs away from them to those which
> are more Mainline friendly.

The OEMs in my industry will not change due to a lack of mainline
support, they have no interest in mainline support, they only care
that their products work well enough to sell, and since there is
little competition

> We also need to think about this as a two way street. What does this
> SoC bring to Mainline? Why should Mainline care about it?

The H616 is used in a number of development boards(orangepi and
such) and TV boxes, having decent mainline support at least allows
downstream integrators to have a chance at improving the situation
regardless of vendor cooperation, maybe the SoC vendor will
eventually care if people are actually using mainline kernels more.

> It has some
> major design issues, do we want to say that is O.K? Do we want other
> vendors to think we are O.K. with bad designs?

I mean, it's a second source issue for the PHY, less of an outright
design issue and more likely was just some cost optimization.

If we excluded all vendors with bad designs then Linux would have
far less hardware support.

> Worse still, this is
> stmmac, which lots of vendors already abuse in lots of different
> ways. Russell has put in a lot of effort recently to clean up some of
> that abuse, and we are pushing back hard on new abusers.
>
> If you can hide this mess away in the bootloader, it just looks like a
> regular device, we are likely to accept it. If you try to do something
> different to the normal for PHYs, we are very likely to reject it.

I'm confused, the kernel isn't the bootloader so how can it be accepted
by the kernel if the implementation is not in the kernel? Linux supports
plenty of weird hardware so I really don't see why having a quirk for
this specific board is such a problem as long as the quirk doesn't
introduce maintainability issues.

