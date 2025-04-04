Return-Path: <netdev+bounces-179409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F13A7C671
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 00:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FE417CED0
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEEB19D8A4;
	Fri,  4 Apr 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9LWTOlH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578AAD58
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743806838; cv=none; b=NG5MpxD2+iQVuQeuKjdrqoVHQMLkVPsNWCZHq04tQ11OEqtDguueGj596mYc81Xl/qpYBxL3irwfEDC1/k667FoG4jbtC1C+Bkcy6hf8CM39fWFcED5pY0LUNDhCkadIpGocVtgdEjWd51wEk8RtLyhiVvwpT7sy3CZ2Tel8yJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743806838; c=relaxed/simple;
	bh=sFxcgYNvwgchrDGRA03IlKE0w+90pHKs4qD6AQ37/E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+Jb2PgID4p9UwerQe/M/wtP4gIlO4RnoFrMvEmZH88PR72BQOLCb+5yRO+/XCo58NieJ4P2D8/XGg5/x232JynvIovaBvK5EPLJs70/cOWs2EdCmsijSqLFVgK0oIH+crZJX+505SRV0MBCD+Jz32AehCFGZM92h8q3z/Jllso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9LWTOlH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso2286252f8f.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743806835; x=1744411635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFxcgYNvwgchrDGRA03IlKE0w+90pHKs4qD6AQ37/E8=;
        b=Q9LWTOlHtpeN7XSs1qXUKZTg+sL6W/sbt0S5RED+DRuM+6SyeygPX3Ml/hpJAtAucv
         V/TwfRt36NGOub+a7GxzYIv7AvqtD347p7OESkccoOOw4GS1N5yrpx8T8NEM7b3kQi3H
         zgfi9aS/muVd0BayGGp+Z+2RPafwzL0lXyLjB3NhD9eQ/Y+WE11jChxYoneT7e6TL+3X
         zlXwCYy7krBMxfF/u8EIWDyBO89T1shWufBuNxuDARVf32hZIO+Am0MXSW1enpWJHG3t
         zNLxj+xfFyqq6ZbgXDgSGE2bqdaBsX/hj2QlgAVqE/erz0L0v7SSXm+8LsybddsWeSdq
         GbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743806835; x=1744411635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFxcgYNvwgchrDGRA03IlKE0w+90pHKs4qD6AQ37/E8=;
        b=H+Co5bgJqhZk6rOIMs5xyT06Dl48j9xnEj5rbSo3XqddAbjMvPs3E5zze78Op3WKRZ
         9Ec4rfZCpqLW45AWDTXAhf6Kv/A5BEAR2OK8b/Asw+aM6wfGZqXP5rI4HA9mtHCqfg8W
         AWVj8vQsElTT4BfJzq49hd/80evEUj8ATk2enM0G4DQlJww8E3RvO3PxBSKeseCONWXO
         OrP0Oa4yoWIKN8TPdhxlv8pkLVc/r2z78x1waUoiGYS6g0Vt5cbkbABS1W4I0pLb4dmf
         mGsYW7XbZXtErXbmhGJ3Ccw4NEXYEWLU7NSXEO/NZgP4dpFYcGCAid5WI4vJ3webdoe0
         8Zuw==
X-Forwarded-Encrypted: i=1; AJvYcCX94etJ1JhGm+pqwYTENqO48ubsha3z+XdWmLR7ubSBPamn5grPtUPGaAAJ770tor5etlYWK18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+ms52ZR+qGFR0Sad3GeSs9O00xlIAaHxDZ5eelck3g33ZZvN
	JFlBcYHOCAa36VJ7DRjPSekDog7ePnqPF+Z/03sOc1mNhGiBtA6bO5mB57VI/Yc0Ftb+DoObriR
	PySyateZHXSqpe3l9XTDZ1ZtABAM=
X-Gm-Gg: ASbGncsuqW++Zek8t4S0SQVzSoJx14NvC6njiYOS5MRH1KZO/GFPiUzQqMg9/Usn+/L
	rqm4Do2hJrxbMoNGnIRVGQ1h8T9Q691RR8lrBhJTtdyKRw2KYWHnZsyuHm+36Nn5SPY/Caa4UIN
	BUXfHz7jodQbR08WTqrucBwWQny32u99XTXWbQHQ1B1T+JktsOfUg4B7wysQA=
X-Google-Smtp-Source: AGHT+IG1Hhoghe0IzIKo7RuR/x5399u/eutk0IObjtYrxt3iVtdk59+I6txyCFOd2WAoaMwD8P2Oh7ZAxUknHLPphJA=
X-Received: by 2002:a05:6000:4027:b0:39c:12ce:105c with SMTP id
 ffacd0b85a97d-39cb35a180amr4134099f8f.6.1743806834864; Fri, 04 Apr 2025
 15:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk> <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch> <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk> <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <3087356b-305f-402a-9666-4776bb6206a1@lunn.ch>
In-Reply-To: <3087356b-305f-402a-9666-4776bb6206a1@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 4 Apr 2025 15:46:38 -0700
X-Gm-Features: ATxdqUGZU7v3VOiNmoPhvFkVamEp5PwJCSdlnDr-wNav7_L1lbdiuB64H1lq69M
Message-ID: <CAKgT0UfG6Du3RepV4v0hyta4f5jcUt3P1Bh7E2Jo2Cn4kWJtGw@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 9:33=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Part of the issue is that I think I may be mixing terms up and I have
> > to be careful of that. If I am not mistaken you refer to the PHY as
> > the full setup from the MII down to the other side of the PMA or maybe
> > PMD. I also have to resist calling our PMA a PHY as it is a SerDes
> > PHY, not an Ethernet PHY.
>
> For us, a PHY is something like:
>
> https://www.marvell.com/content/dam/marvell/en/public-collateral/phys-tra=
nsceivers/marvell-phys-transceivers-alaska-88e151x-datasheet.pdf
>
> https://www.ti.com/lit/ds/symlink/dp83867ir.pdf
>
> It has an MII interface one side, and a Base-T interface the other,
> where you connect magnetics and an RJ-45.

I'm familiar with that stuff, although I was dealing with it closer to
20 years ago back when I was working on e1000/e1000e/igb.

> It gets a bit more complex with devices like the Marvell 10G PHY,
> which can be used as an MII to MII converter typically used to convert
> the MII output from the MAC to something you can connect to an SFP
> cage.
>
> PHYs are not necessarily soldered to the board, they can also be
> inside SFPs. Copper 1G SFPs typically use a Marvell m88e1111 PHY.
>
> Just to add more confusion, Linux also has generic PHYs, which came
> later than PHYs, drivers/phy. A SERDES interface can be pretty
> generic, and can be used for multiple protocols. Some SoCs have SERDES
> interfaces which you can configure for USB, SATA, or
> networking. Generic PHYs hand this protocol switch. For some, you even
> need to configure the subprotocol SGMII, 1000BaseX, 2500BaseX.

Yeah, we heard about that a month ago at netdev. We are likely going
to have to convert our PMA over to that, but it looks like there has
already been some precedent for that.

> All this terminology has been driven mostly from SoCs, because x86
> systems either hid all this in firmware, or like the intel drivers,
> wrote there own MDIO and PHY drivers inside there MAC drivers.

Admittedly with my background being Intel my first preference was to
essentially place all of that code in the MAC driver, thus why
everything for now is ending up in fbnic_mac.c. I might have to think
about splitting some of that up before I submit the patches.

> So for a long time we talked about MII, GMII, RGMII, which are
> relatively simple MII interfaces. Things got more complex with SGMII,
> 1000BaseX, 2500BaseX, 10GBaseX since you then have a PCS, and the PCS
> is an active part, performing signalling, negotiation, except when
> vendors broke it because why run SGMII at 2.5 times the clock speed
> and call it 2500BaseX, which is it not...

That is some of my confusion about XLGMII. I'm wondering if I should
call it that or not since the documentation refers to our PCS as using
XLGMII but everything seems to indicate it is clocked at 1.25x to get
it to 50G. Then in addition the PCS is referring to RXLAUI for the
lower end of the link which I opted to just call LAUI since in our
case we are running at the 50G speeds anyway so that is probably the
correct term for it.

> We needed something to represent that negotiation, so drivers/net/pcs
> was born, with a lot of helpers for devices which follow 802.3
> registers.
>
> So for us, we have:
>
> MAC - PHY
> MAC - PCS - PHY
> MAC - PCS - SFP cage
> MAC - PCS - PHY - SFP cage

Is this last one correct? I would have thought it would be MAC - PCS -
SFP cage - PHY. At least that is how I remember it being with some of
the igb setups I worked on back in the day.

> This is why i keep saying you are pushing the envelope. SoC currently
> top out at 10GbaseX. There might be 4 lanes to implement that 10G, or
> 1 lane, but we don't care, they all get connected to a PHY, and BaseT
> comes out the other side.

I know we are pushing the envelope. That was one of the complaints we
had when you insisted that we switch this over to phylink. If anything
50G sounds like it will give the 2500BaseX a run for its money in
terms of being even more confusing and complicated.

If anything we most closely resemble the setup with just the SFP cage
and no PHY. So I suspect we will probably need that whole set in place
in order for things to function as expected. That was one of the
reasons why I was thinking of using fixed-link as a crutch to get the
driver up initially while we enable the 3 new interface modes. The
only spot where they seem like they will matter is just to the PCS
since the link_up function is essentially just passed the speed, and
as far as the MAC config function it is mostly just setting up pause
frames, MTUs, and fairly mundane items unrelated to the lower levels
of the link.

