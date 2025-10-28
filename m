Return-Path: <netdev+bounces-233676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA1C173AE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C731C25D32
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BDA3596F5;
	Tue, 28 Oct 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhoVxn/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815534C992
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691831; cv=none; b=hw86x7kSRuBSwlZcHWtjeMVIuYUID0MBLJMwQW4iO4lA17viEpDDfZlF3EVSj9DzNjOcvPWO3/gYm7lPUfC/gtxuvhS2WDQXEZ2NUDyKrakSsJdi/+B0SLI/d3T0aQU8jVLNmpz4ZK+XbtNPEBcPLbY9deh2tKzcwPy4AyyYTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691831; c=relaxed/simple;
	bh=rUN46dlX6cDC+rD87Yyu780bggvqp6lH3ddCFJgz04A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH6uQ6rznuJBQNp7JIm9M+/+Mkh9+Qcz9bay7K+gqcVEUeK7oXqcfR+uBKVOlDeBLUjeHPV6erIq+OmrroStihbiJRtQsnwe1P6skvc3QqR0pHNHpSYy9A+9/r3mE9tGzg4x2wCaTwngoWGGY6kdENI9X9A2Z+y2bant1qytllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhoVxn/N; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so39045275e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761691828; x=1762296628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUN46dlX6cDC+rD87Yyu780bggvqp6lH3ddCFJgz04A=;
        b=EhoVxn/NymQZ2w+CwppEij76AIX74iAGUb43mbjQ1RuqHMocn0D1cDLslhdZPuNCzN
         85h+TG5YPdykvz9ubW78As6xAnOnIkjGgqXPyr3c/cq40d/uUcjb0qsyAC6Sp7rL9KuN
         5SNGBDmTwSV9q8tkmuga85zyjzckajHSzBJFB8+lekRPXKd3WdElOD8kuzbr0/nklOX6
         4MbL8dIjwk44ItMvZ/so7tUskfXzf8lonRYJqIJcLzYFxc81EAKXsh5pdEHYGYA5WvmP
         fsoAWLuNzHd8LmiLvrEndiyu5jk1fsgnpNNxBCIHECcnERbSBPATI0xc6a3fIEtHP96d
         yqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691828; x=1762296628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUN46dlX6cDC+rD87Yyu780bggvqp6lH3ddCFJgz04A=;
        b=YWSeVWCs0fKuN8KpfhplDVo+WngDNpl4y/qDGYwl/5oEPw5wqFp5o480GdK1OZsoPp
         Wt2IOseYK9imea9U9n+dPN+syV/dxaqkHs/UC3Vyp82KvjZ5v2G9wqHDYW6/bKth9SZz
         yoFGUi+2eZsrKHTyHVNVAlBluEFHeG92KSsJpWXFdXkNAw/Tg4rr7y99w/lP9kUYGjRz
         A7V5BGSfuXTEUoSCHqQZOB77aLuOYCKyqhgScdMEELAIPma/B7rWLwEgRsfUPzeFN0+r
         krn4qG01j84aMqecmVOz15TG9p2HJycFvwwRjKnaj8YIJYZownKtzAtLDL00rGyY8hm2
         ZGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9sfIsyzUtCsKTnVp6sXo/oAljMd6SMmTa/tu0TvtonSW4aSfggcYf3XZEH0h/x8Mlh/Wdccc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMfs/8hEMgkaPcXYh0enVrvOIPkkFX36ODefeZVVeKc9WtTPa
	PmSEkQ1MwoEqsQZ+FIVDF55D9nBSRW3wy68EWJLeuTyN5ZX8yMoNh37fISfWZwKFBG6w1XdqMcE
	X3tGbB9ORKKCziwlUMPPRuh6k2ZEud8g=
X-Gm-Gg: ASbGncv0jNMgvgnvv/xWN9MTcfbFieN4XbRN4qRvw21ODy2LlrAV5uIAtFiUT8B4CD/
	/NjtEfMtkRoJJc2mYZTXAeCqVpxrj3Xnq+WWhu8EQPpMjIndA1krPE7mq1mOn7f5Sf0FieLttK0
	DOQDSdVrMPi2+LLZlxFmj59B48i2VE9w+WmH526QJ83i3QyZXuNXa5L1ZNpC/JU8IL2ezITsAnY
	Opg49QFfbyw3N5ne4eEOLxVMoQRLYXhR0LU3wbts70wYOU9K5gKo06iPCVAvhoARoz419DLzUqu
	F6J37MM55PeLMeELUg==
X-Google-Smtp-Source: AGHT+IGMZ/5tXQ0ox0tlQzfFuGqVDm6K43Tg5LPct8hhdwL83V9AZpb6leKQuKcNfa7hgkHrAPT+1O/V0U8bCRM6kt0=
X-Received: by 2002:a05:6000:2c01:b0:426:d619:cac7 with SMTP id
 ffacd0b85a97d-429aefbdc4fmr513781f8f.36.1761691828261; Tue, 28 Oct 2025
 15:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
 <c06dc4a6-85b4-41e9-9060-06303f7bbdbc@bootlin.com> <b1a3229b-50cc-4f99-a5fd-54335f1a8f83@lunn.ch>
In-Reply-To: <b1a3229b-50cc-4f99-a5fd-54335f1a8f83@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 28 Oct 2025 15:49:52 -0700
X-Gm-Features: AWmQ_bkU58qTGhJE5QTDp2pZfnYdxL5Z9QVASap46QbZlbCiKkzEYktiVgUW4bI
Message-ID: <CAKgT0Uda5RJxDkfjXGaVtLGNtRxjd95PLsHLtyjqR6CoH0jg=w@mail.gmail.com>
Subject: Re: [net-next PATCH 3/8] net: phy: Add 25G-CR, 50G-CR, 100G-CR2
 support to C45 genphy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, kuba@kernel.org, 
	kernel-team@meta.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:40=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 28, 2025 at 08:32:03AM +0100, Maxime Chevallier wrote:
> > Hi Alexander,
> >
> > On 24/10/2025 22:40, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexanderduyck@fb.com>
> > >
> > > Add support for 25G-CR, 50G-CR, 50G-CR2, and 100G-CR2 the c45 genphy.=
 Note
> > > that 3 of the 4 are IEEE compliant so they are a direct copy from the
> > > clause 45 specification, the only exception to this is 50G-CR2 which =
is
> > > part of the Ethernet Consortium specification which never referenced =
how to
> > > handle this in the MDIO registers.
> > >
> > > Since 50GBase-CR2 isn't an IEEE standard it doesn't have a value in t=
he
> > > extended capabilities registers. To account for that I am adding a de=
fine
> > > that is aliasing the 100GBase-CR4 to represent it as that is the medi=
a type
> > > used to carry data for 50R2, it is just that the PHY is carrying two =
2 with
> > > 2 lanes each over the 4 lane cable. For now I am representing it with=
 ctrl1
> > > set to 50G and ctrl2 being set to 100R4, and using the 100R4 capabili=
ty to
> > > identify if it is supported or not.I
> >
> > If 50GBase-CR2 isn't part of IEEE standards and doesn't appear in the
> > C45 ext caps, does it really belong in a genphy helper ?
>
> I agree with you here. We should not pollute our nice clean 802.3
> implementation. If the Ethernet Consortium had defined how these modes
> are represented in MDIO registers, we could of added helpers which
> look at the vendor registers they chose to use. We have done this in
> the past, for the Open Alliance TC14 10BASE-T1S PLCA. But since each
> vendor is going to implement this differently, it should not be in the
> core.
>
> > You should be able to support it through the .config_aneg() callback in
> > the PHY driver.
>
> It is probably a little more than .config_aneg(), but yes.
>
> I assume FB/META have an OUI for their MAC addresses? I _think_ the
> same OUI can be used for registers 2 and 3 in MDIO. So your fake PHY
> can indicate it is a FB/META PHY and cause the FB/META PHY driver to
> load. The .get_features callback can append this 50GBase-CR2 link
> mode. The .read_status() can indicate if it is in use etc. And you can
> do all the other link modes by just calling the helpers. I assume you
> are currently using the genphy_c45_driver? That can be used as a
> template.

Yeah, I was already starting down some of this path as I was going to
have to provide a FB/META PMA ID in order to work with the XPCS driver
in terms of handling the config.

I can probably look at pushing the fixes to get the handling of the
PHY ID sorted out and then look at adding a new driver to handle the
50R2 without touching the genphy code for now.

