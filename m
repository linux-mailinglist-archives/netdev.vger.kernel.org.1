Return-Path: <netdev+bounces-179352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C442FA7C16B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FFF3B4C16
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8B20ADC0;
	Fri,  4 Apr 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn2wgnGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E49145B0B
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783553; cv=none; b=gwP8ZabfHFxjD094yxHA4P/mHjaBXxHNqRMsHKSr2CU+YJcd0qgo48pLWUbqFAyrxqKmewByx7OfPmqXfKu/m8syTTbHglmi08HrzjNvHeWdHkAcexlPBwnha6euZlbSMwnCw7BTCRs9sI/SX5+daGLwo9FwKr18hzGyHBu17ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783553; c=relaxed/simple;
	bh=ZfzHHTN6KBiBko5SAsYLLbhdZj1Ih1qcGgZde0yCjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bskwhtm8RBOfXwsdBX5Aqh3nCM02FPxGWg9R5HSRH+Uho7+Xj4i6w/wBKqG6BBEnp8UKdUHfYx4FfBDMoEpeefLOENgSNk0dZ5BI3UmElQEExygUAarhoXwI/6h3IEfqKtxt01FwZxsdnP6Fnqj9uxCpcz3f/70cCWjWLTWur4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn2wgnGq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso21179025e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743783546; x=1744388346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfzHHTN6KBiBko5SAsYLLbhdZj1Ih1qcGgZde0yCjK8=;
        b=Bn2wgnGqchDGh3lILwrjs6a8H+9PmSAJ2s9a7rOeCFn13UnMtfpLTvfSMj57YN2quk
         s/oJhgGJaxp9m8GDeYEwEALDegwb3E2U4SzhmywzZbeKx6EEOnkpcvVr+YXpMbbdcRzp
         3ZXqt8AV6awy4zoLw1AOj1ot9zVk8OxZQVYChaWgpy4NCHgKd1a2SRlqy0/TjgY/d5Bn
         /kGSsMNSbTicqfzJqPLETUt9VJCKQVZgaygKiFp8RPtvx+zxcFjEaCJ4kpRIYCDvOfm2
         vywWKZ1FHs7RaOOeILV4WMzMPlYk8rPv3QEb/lui5b3jiBVhIe6V5eez+UOiwbVxL2Du
         DCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743783546; x=1744388346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfzHHTN6KBiBko5SAsYLLbhdZj1Ih1qcGgZde0yCjK8=;
        b=eNIo1eaGUgu0l/b8cvBZIDfL7C4k78ZwIrLVOkn0i1Vb0wgEfBY2DNUSWaKBal2IgN
         fXvLX5bewB1nWFXoJVlo4yWrLzYnP3ub/9+593NPJgRhwDD4L3PdJmTvRBaoZcRARBmz
         OJ9mxkXgBHQ9NGi/0NAzWjHTiVs6ZQY8YEEHfs8frGTX4Q+cAUbBmnC4eLH5XJrQYfIU
         MYPaHWy79CjvwpelJHwdNR+ODTMDzu+E4SCojVmO4Hjv8qnt5IQ2kitCmp1CugEX+B6R
         QIf40V/b855HbLPLKU4QUa63EFD2uuFlpWZ14RAAe7PoAIZAqZfxqYbhuecfjhhoDPb+
         N0gg==
X-Forwarded-Encrypted: i=1; AJvYcCUT3XelfxP/7KUbCKey/5x60js8uH5M2P2F4i6JzFu3aJ+bc5BGOs7LHvlUJetpwbvpWG9nu0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtZC17HbFv3otpj74FMwQZFiqR8vMRNypik+6D8B0pXXOdO9P
	5utr3iMN+DuOl5MYv7hhLdjswYxOKaL5aavUYj/IC1/F0nIe4JC0V2V7jYw2Se+Ow4j2+bdoh8E
	PQzYKP/SYU9+pq29TRL1MlbJs0Rs=
X-Gm-Gg: ASbGnctsh1T+QKzZ25rRRx+EUVZwodWojnbqCWJWL3L9Bf2ueuV27YiXzidYwNQ2mU9
	Pgd6qmAdLtwCa9IsfEjgXqW5F0hipGnFIw1hOxTuENS3bd3sxGMMlWL+/qQEPM28HQcx/zNTovR
	Nz384EtIseivXIZmc+pL5Eh4U3tfSnjohhnXIpviivvVEE+Tx5AuddO5euv7k=
X-Google-Smtp-Source: AGHT+IFHHn9gcAd+p89gx2X25GYrtt2pgXu6w7LBdv1BeAi2ftjluivY6wV8IZdD6BeFeRu5NyTx+Y4IEB2UpDYnBYc=
X-Received: by 2002:a05:6000:220f:b0:391:a43:8bbd with SMTP id
 ffacd0b85a97d-39cba933185mr3878786f8f.21.1743783546587; Fri, 04 Apr 2025
 09:19:06 -0700 (PDT)
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
 <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk> <8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
 <Z--HZCOqBvyQcmd9@shell.armlinux.org.uk>
In-Reply-To: <Z--HZCOqBvyQcmd9@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 4 Apr 2025 09:18:30 -0700
X-Gm-Features: ATxdqUF_0J1f9bdTsIw4XIm_1VB-D0LCUl5auXW7IeFvo7yz5rm2Pe10EleLCtY
Message-ID: <CAKgT0UeJvSSCybrqUwgfXxva6oBq0n9rxM=-97DQZQR1kbL8SQ@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 12:16=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Apr 04, 2025 at 03:46:01AM +0200, Andrew Lunn wrote:
> > On Fri, Apr 04, 2025 at 12:26:15AM +0100, Russell King (Oracle) wrote:
> > > On Thu, Apr 03, 2025 at 02:53:22PM -0700, Alexander Duyck wrote:
> > > > How is it not a fixed link? If anything it was going to be more fix=
ed
> > > > than what you described above.
> > >
> > > I had to laugh at this. Really. I don't think you quite understand th=
e
> > > case that Andrew was referring to.
> > >
> > > While he said MAC to MAC, he's not just referring to two MACs that
> > > software can program to operate at any speed, thus achieving a link
> > > without autoneg. He is also talking about cases where one end is
> > > fixed e.g. by pinstrapping to a specific configuration including
> > > speed, and using anything different on the host MAC side results in
> > > no link.
> >
> > Yep, this is pretty typical of SOHO switches, you use strapping to set
> > the port, and it never changes, at least not without a soldering iron
> > to take off/add resistors. There are also some SOHO switches which
> > have a dedicated 'cpu port' and there is no configuration options at
> > all. The CPU MAC must conform to what the switch MAC is doing.

I don't think you guys understand my case well either. You seem to
think I am more flexible than I actually am in this setup. While I do
have the firmware I can ask about settings all it provides me with is
fixed link info. I can't talk to the link partner on the other end as
it is just configured for whatever the one mode is it has and there is
no changing it. Now yes, it isn't physically locked down. However most
of the silicon in the "fixed-link" configs likely aren't either until
they are put in their embedded setups.

I would argue that "fixed-link" is there for setups where the kernel
cannot reasonably expect to be able to understand what the link is
supposed to be through other means. It is provided usually through
device tree or ACPI because it is hard coded into the platform
configuration. In our case the configuration for that is stored in the
EEPROM and provided to us through the firmware. For any production
system we have that is fixed and locked so there is no deviating from
it unless you want to lose the link and RMA a server.

I think the part you guys might be getting confused by is that we have
2 use cases, production and development. In the production case we
will likely just want to use fixed-link or something like it.
Basically our platforms are put together one way and connected to one
switch and there is no deviating from it. The FW will configure the
PCS and PMA beforehand as they have to do so to enable the BMC. They
are as essentially locked down in terms of config as many of the
embedded systems you work on. If we break the link the BMC goes
offline we essentially bricked the platform. In the development case
we want to be able to test all the bits and pieces and for that we
need to be able to change the configuration and such. What I am trying
to do is have one driver that can support both instead of doing what
every other vendor does to avoid this pain which is to do one release
driver and one internal development/test driver that never sees the
light of day.

> From the sounds of it, Alexander seems to want to use fixed-link
> differently - take parameters from firmware, build swnodes, and
> set the MAC up for a fixed link with variable "media" type. So
> it's not really fixed, but "do what the firmware says". I can't see
> that being much different to other platforms which have firmware
> that gives us the link parameters.

Yeah, the use case is a bit different. Instead of asking ACPI I am
asking my device firmware what the link config is and then have to set
things up based on that. So the main difference is what FW is having
to be asked. Once I add the interface modes I can go that route
instead of fixed-link I suppose.

Essentially what I am doing is using fixed-link as a crutch to handle
the fact that the kernel wouldn't be able to understand the config
data I am presenting as it doesn't have the phy_interface_t to support
it yet by swapping in PHY_INTERFACE_MODE_INTERNAL and relying on the
configuration that was done by the FW to setup the link. The driver
code as I have it now would probably only be fixed-link for the first
half dozen patches or so until all the other code to enable the
correct handling of the interfaces is up.

> Presumably in Alexander's case, the firmware also gives link up/down
> notifications as well, so it seems to me that this isn't really a
> fixed link at all.

The FW doesn't provide the link up/down. It just tells us if the link
is there or not. Part of the issue is that the module is abstracted
away by the firmware. So it knows what is plugged in and we have to
support it. Fortunately for us though there is nothing for us to
config on the QSFP.

