Return-Path: <netdev+bounces-235308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4772C2E987
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB3A634C6B3
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156D1A5B9D;
	Tue,  4 Nov 2025 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkWur/qE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E629405
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216050; cv=none; b=GJD4U7aHQ/DvUfMiPFA01Fo3DD7vktgw1ma2MRoOCco3kMVMAQBvpmOFuzqvDQSDRWIrLorH2YrkdyP3QVuCuQRLIsEQvDAR2hcKneZPiE86FjrtShznj3fiJDhTfkA/3Jnza8r92bo+dF2+ciYlPcm1JFnEYS1pSSDzYzDwlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216050; c=relaxed/simple;
	bh=jFJzHcA+X8LkHNbuVmZxGh+3mvTDvWnafWb05x9a0Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3lxahdGAwVjuo4Rbr3h/2CyIFmg3IjkTVkMdXFrmr4VSWmViNrHURbWubVSuX7FFPtsqQNFWVQR10wTP0pgWEiOn1lBkPr/jjJwBOyL0PfoTR/sU0JoMJaG7V292VMWss65K+lHqV123xjUZvMSVE/UHSH4d2hUEj0kvu0qTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkWur/qE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b72691b4so4439329f8f.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762216047; x=1762820847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQck65QFj/6B7pNqaZP0yviObfenPFAfFag69gzgWSo=;
        b=mkWur/qERgkD/67+SiTi8r7cBzXNuICLynVJn8J3eMPRjoiv6smpYrnxSAiB3Y9ftX
         OamsWzV20FIyZQt2+IWxPwPG+0m9eXBCg5nx48FtVIP4gjfCXhvq2ooDhkxXJDjAB8b5
         y33w8wiFLYtrrBoZta4w2Pevsvfuius1UpM/UNPV7QHUNvWPst4jxyG3dNi5Rmlhgi1B
         0uITt/UCdlG2gYix5q/NUJOlYGZ1caMAtcCgQCWZPUF/EJ0r7x+FGxgemJONnurCyPy2
         wuMG4WfZT9zMy+0T8iEFlTWQ1rtgWPYTZYWb9O/5JO0arCkGxPM5b2OqTmcPwud7BeKA
         VMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216047; x=1762820847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQck65QFj/6B7pNqaZP0yviObfenPFAfFag69gzgWSo=;
        b=RrkDb6VF47hlKbrJ6jhCokJXaZ0GUyuUtHv+trDkpZIkee2gu3lLc+0aHjC6HlMUFQ
         YHzu+YOcyTqOGam4cksXDHxwVlMr87ggsWTWRzU5bDgWI4sJoa8dX/sd8YGZ12Mgm2jY
         c5cz7F/lBmFFXjnsdbKuvbg5X/Uy0RoqWsAL0sRmRQfI61A7/AyFVyGzpRmzB+scLCMu
         RcLrRep/UEkE8zFkB0PGLxhu9rPUAWVhvIKdYQtgWbD+JHk7aJ6ZhaLn1/eH+e1iUZRv
         FfRla7zsx/ztFzezoG0wupDqCfyqegwIBEcCYAKy7U58McYb1lC2xoOxGRfOk7uieEmF
         QMnA==
X-Gm-Message-State: AOJu0Yypl+oBTdTnDUeJEqx50hRGLrSrxYolWqC2iZFlsq7+OsOI6yxa
	uMhPt85icoABNAkHzoPAx+pnZ1veIUBQ7/cV3FAfL7g5D+M4S4nhpd4zVKI3AClfc1bVdmVj6AO
	miGs4oLSS4t4X4pVARyDclN1rYBpZu3o=
X-Gm-Gg: ASbGncs6qrbGp9G7IoOPWAtdZYQTbetOhk4aq9ErLEvcHbDhJ74JVI/jWp8vlw366K4
	G0DkZ75+RiNCjIoz/drsQUQH0NfdS+iNCr9e0ExU54r0SwLRPhL9wqJrx066J8b7RTsQavUKwzl
	DXzx/HWmcgv4q3nDdb8yQo47+KPDNFGfTm9ISKEghAYwT6fJcvKutqVqSi6T0CPyj0T9YfC42cR
	5AdQtiBY2vuyrmHI4cj/Jtgn9Ntk6rlOFShJH15CNaFh6kx8OasVrotPGopCBtvIwKtC07iAE6q
	Negz0eEAk0Ad6/b4/g==
X-Google-Smtp-Source: AGHT+IHINJFxI6ttSS2G3JvNxWRiYzSBSX+EpNSmkNv0tXlndOM0zYE1jkJ8RYj/QYPZduubSYa187LokIMAsEyZC+k=
X-Received: by 2002:a05:6000:2f86:b0:429:8daa:c6b4 with SMTP id
 ffacd0b85a97d-429bd6860d5mr10563325f8f.21.1762216046705; Mon, 03 Nov 2025
 16:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218926115.2759873.9672365918256502904.stgit@ahduyck-xeon-server.home.arpa>
 <2fabbe4a-754d-40bb-ba10-48ef79df875c@lunn.ch> <CAKgT0UeiLjk=9Ogqy1NU-roz4U32HXHjVs8LqRKEdnPqYNcBjQ@mail.gmail.com>
 <9628b972-d11f-4517-97db-a4c3c288dbfa@lunn.ch>
In-Reply-To: <9628b972-d11f-4517-97db-a4c3c288dbfa@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 3 Nov 2025 16:26:50 -0800
X-Gm-Features: AWmQ_bmc6oR3QdpiKUXUj3w2XuCIEQHLfOQFnSzSSWYqaEiUxnhoglGbiO3prIQ
Message-ID: <CAKgT0UcxyBCZw3TV97EAXi1KQLCX=O+=4ATzR3xyLYFySQG1Sw@mail.gmail.com>
Subject: Re: [net-next PATCH v2 09/11] fbnic: Add SW shim for MDIO interface
 to PMA/PMD and PCS
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 1:49=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Nov 03, 2025 at 12:18:38PM -0800, Alexander Duyck wrote:
> > On Mon, Nov 3, 2025 at 10:59=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > The interface will consist of 2 PHYs each consisting of a PMA/PMD a=
nd a PCS
> > > > located at addresses 0 and 1.
> > >
> > > I'm missing a bit of architecture here.
> > >
> > > At least for speeds up to 10G, we have the MAC enumerate what it can
> > > do, the PCS enumerates its capabilities, and we read the EERPOM of th=
e
> > > SFP to find out what it supports. From that, we can figure out the
> > > subset of link modes which are supported, and configure the MAC and
> > > PCS as required.
> >
> > The hardware we have is divisible with multiple entities running it
> > parallel. It can be used as a single instance, or multiple. With our
> > hardware we have 2 MACs that are sharing a single QSFP connection, but
> > the hardware can in theory have 4 MACs sharing a QSFP-DD connection.
> > The basic limitation is that underneath each MAC we can support at
> > most 2 lanes of traffic, so just the Base-R/R2 modes. Effectively what
> > we would end up with is the SFP PHY having to be chained behind the
> > internal PHY if there is one. In the case of the CR/KR setups though
> > we are usually just running straight from point-to-point with a few
> > meter direct attach cable or internal backplane connection.
>
> We need Russell to confirm, but i would expect the SFP driver will
> enumerate the capabilities of the SFP and include all the -1, -2 and
> -4 link modes. phylink will then call the pcs_validate, passing this
> list of link modes. The PCS knows it only supports 1 or 2 lanes, so it
> will remove all the -4 modes from the list. phylink will also pass the
> list to the MAC driver, and it can remove any it does not support.

In the drivers the limiting would be done based on the interface at
the PCS level.  The way I added the 25G, 50G, and 100G features was
based on the interface type, so that interface type would be what puts
a limit on the number of lanes supported.

In the actual hardware though the limiting factor is that the PMA/PMD
is only 2 lanes. The PCS actually supports 4 lanes and is just being
subdivided to only use 2 of them per MAC.

> It also sounds like you need to ask the firmware about
> provisioning. Does this instance have access to 1 or 2 lanes? That
> could be done in either the PCS or the MAC? The .validate can then
> remove even more link modes.

The way the hardware is setup we always have 2 physical lanes. Where
we need to decide on using one or two is dependent on which mode it is
we are wanting to use in software and what our link partner supports.
For example, on one of our test setups we just have a QSFP-DD loopback
plug installed and we can configure for whatever we want and link up
and talk to ourselves.

That actually presents a number of challenges for us as the SFP driver
currently doesn't understand CMIS, and again we are stuck having to
emulate the I2C via the driver as it is hidden behind the FW
interface. This is one of the reasons why we end up currently with the
FW telling us what the expected link mode/AUI currently is.

> > To
> > support that we will need to have access to 2 PCS instances as the IP
> > is divisible to support either 1 or 2 lanes through a single instance.
>
> Another architecture question.... Should phylink know there are two
> PCS instances? Or should it see just one? 802.3 defines registers for
> lanes 0-3, sometimes 0-7, sometimes 0-9, and even 0-19. So a single
> PCS should be enough for 2 lanes, or 4 lanes.

I'm thinking the driver needs to know about one, but it needs access
to the registers for both in order to be able to configure the
multi-lane setup. The issue is that the IP was made so that the vendor
registers for both lanes need to be configured identical for the 2
lane modes in order to make the device work. That is why I thought I
would go ahead and enable both lanes for now, while only connecting
one of them to the driver.

If we had multiple MACs both of the PCS lanes could have been used in
parallel for the 1 lane setups, however since we only have one MAC it
ends up running both lanes. Since that was the case I thought I would
stick to what would have likely been the layout if we had multiple
MACs which was to expose both lanes as separate PHYs, but only map the
device on the first one. That said, if need be I could look at just
remapping the PCS for the second lane as a MDIO_MMD_VEND1/2. I would
just have to relocate the RSFEC registers for the second lane and the
PCS vendor registers to that device.

> > Then underneath that is an internal PCS PMA which I plan to merge in
> > with the PMA/PMD I am representing here as the RSFEC registers are
> > supposed to be a part of the PMA. Again with 2 lanes supported I need
> > to access two instances of it for the R2 modes. Then underneath that
> > we have the PMD which is configurable on a per-lane basis.
>
> There is already some support for pma configuration in pcs-xpcs. See
> pcs-xpcs-nxp.c.

I was dealing with different IP from different vendors so I didn't
want to throw the PMD code in with the PCS code. I suppose I could do
so though if that is what you are suggesting, I would essentially just
be up-leveling it to the PMA interface.

As it stood I was considering adding an MMD 8 interface to represent
the PMA on the PCS since that would probably be closer to what we
actually have going on where the PCS/FEC/PMA block on top is then
talking to the PMA/PMD which is then doing the equalization and
training before we send the data over the Direct Attach Copper cable.

I had chosen the phydev route as it already had a good way of handling
this. I was thinking the phydev could essentially become a fractional
QSFP bus as it will likely be some time before we could even get
support for a standard QSFP bus and CMIS upstream.

> > The issue is that the firmware is managing the PMD underneath us. As a
> > result we don't have full control of the link. One issue we are
> > running into is that the FW will start training when it first gets a
> > signal and it doesn't block the signal from getting to the PCS. The
> > PCS will see the signal and immediately report the link as "up" if the
> > quality is good enough. This results in us suddenly seeing the link
> > flapping for about 2-3 seconds while the training is happening. So to
> > prevent that from happening we are adding the phydev representing the
> > PMD to delay the link up by the needed 4 seconds to prevent the link
> > flap noise.
>
> So it seems like you need to extend dw_xpcs_compat with a .get_state
> callback. You can then have your own implementation which adds this 4
> second delay, before chaining into xpcs_get_state() to return the true
> state.

Seems like I might need to plug something into the spot where
xpcs_resolve_pma is called. The code as it stands now is just taking
the interface and using that to determine the speed after checking the
PCS for the link. I wonder if I should look at having this actually
look at the PMA if there is one and then just determine the speed
based on that.

