Return-Path: <netdev+bounces-132812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3815993463
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4FF1F231CF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C171DC1B8;
	Mon,  7 Oct 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="i2fQcyeM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC721DC1A3
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320745; cv=none; b=PXYWnq6QrkXqOD1CMQb3wLVsslsEQxB0KZxcdyC4qRb6TqU5WVaaxmN1sBqipRrfc6//04McNEGpRPf+SJCY2mYoH/wZ1KlIZ6Kc6mV5ioNCYQALYxkNAV0YRNt1LMyPNNG//km7QZsdJE0zahqT/wtPOMOyQSEv4tpf8LSTBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320745; c=relaxed/simple;
	bh=ku71r9i61BzmUfTIu9lGZ5P96BMqj32LH3VYnoO9FDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta0Nl8ry3g2U7G9tTBxQAABOxQsx/Voe+VGS+IKpbNrRR9mvmLsqSkNbMg7RqeuL7npGHZly0CoMiDNl2Lh+g2j8dNdRETsreVkSIpRkVSTPhPkVHaPqXt9gKL/3aSNaBw3bGE+xDPeb3Ju03TRralPW+nl1ZvSdzCzvzHMm4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=i2fQcyeM; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6dbc9a60480so38926737b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1728320742; x=1728925542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku71r9i61BzmUfTIu9lGZ5P96BMqj32LH3VYnoO9FDs=;
        b=i2fQcyeMWU2DIMGzyPTaEw9jek7aBaAmYFOloFFGJUJm8zzn0h/cctf6beMQL1sgm0
         9peazS7aBAjswukkGyh7GeLWFFkMox4T/uxy0xvmHK1jYQppsb/2bzPyHzE4AT5Gfi/I
         Z3HoS55X/IsDkBP+5J/ZWG1qPJhIwktmETHl0p+GOiZ0mh4HXV7F5MXUcY6IK4hUucE/
         sax56mAVTlVVog9GO5RWcvuQgvY2HwFqPQ1urfpKUdZvqPXeQlN1O9NG7gicJf3SAmGJ
         KuVbPZgFznKJCoNGu/njEgrakA9iRhTNQaIADqTYNGreSTkQm41sPDKZ0AGConxmPPf7
         MA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320742; x=1728925542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku71r9i61BzmUfTIu9lGZ5P96BMqj32LH3VYnoO9FDs=;
        b=OF03ULBzmFEV6ATX6u0qQsmQLWpY+WgKIXCZm+PwgoA88OLVs4zZbxZKliUIaVXeW1
         J5O0tQrQWyur9FxyIvu5fxnbhTluA3aEuwJ7FCdaW35HonMEaIQjJ1YfX9Jjq4CQgRHo
         p53yG7EvLe6lqA13L8zLZcGPD9YVIxKe/ByjOSuGslHiEgLJltQ3ExQWPMQlWLQ2Lwnn
         8PymrCRGnYglTImtduW4J41jvHADeFg+TtEQC9T8Y7g0MJixJuyRtAVLIJZ0k/Sh8n9A
         X+pt8QecSEVd3X95UmA4Jlf/QIIEXk3KkKr3AVZz3ymx8I7reQZVsjdK55NULzU5sMUu
         Z6CA==
X-Forwarded-Encrypted: i=1; AJvYcCXly4tZMiR8s9Jun4psHHE2WBhEYyI8bZXlfJhkp2dBDNdzUn4L1roYVaR/ASzUvnzetOvOSaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAdCkqL/5osalUGcGppj98p0Eomx1JNMJ+qc/lQPALcU0GBvb
	w6833WrPvuWm1s54+aVS33nvzi3O7aYctdzqtPcMHATObtq80/Js/GUVHPzlGu84JlGloSWczpG
	ArT0aBz03ZipaiC1VXmOv5+/xTq9AM40VcW5ytSQDdAFBJNe/YjM=
X-Google-Smtp-Source: AGHT+IHzek0bASzQp75RAUINOlHseaQJtCjY9uNHzdeiAN5S6Jr56tmBMEaoo5d9hiKeBOznMZK8aO4XwY46NVwATz8=
X-Received: by 2002:a05:690c:4243:b0:6dd:fcb7:9d10 with SMTP id
 00721157ae682-6e2c6ff9619mr80639297b3.14.1728320742510; Mon, 07 Oct 2024
 10:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004213235.3353398-1-tharvey@gateworks.com>
 <a9467e93-3b35-4136-a756-2c0de2550500@lunn.ch> <CAJ+vNU2Hdo-J8HxVXG63AEauBXUdnuRViwmMmE1mNj30NcyF8A@mail.gmail.com>
 <ad44d06a-4d30-4696-bace-1a78a8bcfca6@lunn.ch>
In-Reply-To: <ad44d06a-4d30-4696-bace-1a78a8bcfca6@lunn.ch>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 7 Oct 2024 10:05:31 -0700
Message-ID: <CAJ+vNU0HJcZoq90FKPuuYwBCT0XyQzqRFZu+ybHguR0zbifKKg@mail.gmail.com>
Subject: Re: [PATCH] net: phy: disable eee due to errata on various KSZ switches
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>, 
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>, 
	Tristram Ha <tristram.ha@microchip.com>, Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 9:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Oct 07, 2024 at 09:38:59AM -0700, Tim Harvey wrote:
> > On Sat, Oct 5, 2024 at 9:46=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Fri, Oct 04, 2024 at 02:32:35PM -0700, Tim Harvey wrote:
> > > > The well-known errata regarding EEE not being functional on various=
 KSZ
> > > > switches has been refactored a few times. Recently the refactoring =
has
> > > > excluded several switches that the errata should also apply to.
> > >
> > > Does the commit message say why?
> > >
> > > Does this need a Fixes: tag?
> > >
> >
> > Hi Andrew,
> >
> > Good question. I couldn't really figure out what fixes tag would be
> > appropriate as this code has changed a few times and broken in strange
> > ways. Here's a history as best I can tell:
> >
> > The original workaround for the errata was applied with a register
> > write to manually disable the EEE feature in MMD 7:60 which was being
> > applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.
> >
> > Then came commit ("26dd2974c5b5 net: phy: micrel: Move KSZ9477 errata
> > fixes to PHY driver") and commit ("6068e6d7ba50 net: dsa: microchip:
> > remove KSZ9477 PHY errata handling") which moved the errata from the
> > switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
> > however that PHY code was dead code because an entry was never added
> > for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE. So even if we add a
> > 'Fixes: 6068e6d7ba50' it would not be fixed.
> >
> > This was apparently realized much later and commit ("54a4e5c16382 net:
> > phy: micrel: add Microchip KSZ 9477 to the device table") added the
> > PHY_ID_KSZ9477 to the PHY driver. I believe the code was proper at
> > this point.
> >
> > Later commit ("6149db4997f5 net: phy: micrel: fix KSZ9477 PHY issues
> > after suspend/resume") breaks this again for all but KSZ9897 by only
> > applying the errata for that PHY ID.
> >
> > The most recent time this was affected was with commit ("08c6d8bae48c
> > net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)") which
> > removes the blatant register write to MMD 7:60 and replaces it by
> > setting phydev->eee_broken_modes =3D -1 so that the generic phy-c45 cod=
e
> > disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID)
> > so its still broken at this point for the other switches that have
> > this errata.
> >
> > So at this point, the only commit that my patch would apply over is
> > the most recent 08c6d8bae48c but that wouldn't fix any of the previous
> > issues and it would be unclear what switch was broken at what point in
> > time.
>
> O.K, so its a mess :-(
>
> Lets look at this from a different direction. Which stable kernels do
> you actually care about? Is 6.6 enough for you? Do you need 6.1? 4.19?
>
> You should use a Fixed tag which goes back far enough for you. The
> patch itself might not apply that far back, but once you get it merged
> and backported as far as it does go, you can submit ported versions
> for older kernel, referencing the original fix commit hash number.
>

Yes... a mess. The difficulty everyone likely has with something like
this is they really can only test what they have as it's not super
clear each switch has for a PHY ID. It also wasn't really obvious to
me what switches had this errata (I just went through every switch in
the list of supported models in enum ksz_model and looked up their
errata which fortunately was public).

6.6 is good enough for me. I will resubmit with a fixes for the most
recent commit as well as include the above history in the commit as
well.

Best Regards,

Tim

