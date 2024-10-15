Return-Path: <netdev+bounces-135890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C499F895
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301C0B2136B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421671FBF4E;
	Tue, 15 Oct 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="mcRfG5qa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED51F582F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026295; cv=none; b=a/TBhEyd3ANxSVlmc+7BcxAqBxq3svm1+W4whJ8QyLmgXIicZGGpg+jVL7//AK8mxYAevyrZlRbzrDkSi36y4UkiqbwHu8CrAs39dGb1dzFla+X/J/qTBL2XfHbGUjlkQzArCYyERdU2ZdPa90cy8lgo1Dy64Pqd6rQMbJ5i/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026295; c=relaxed/simple;
	bh=zT0nCGbUs6GQL3x+J3RS9+mj4BSonnPhxWcD75B+TrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGina0HmGLlQcEUj+wsiQ1ce2RKRI+NsxS3bKYzIEemxPxzaKrGa33Fn4hl1x+/JxBe7eQKFRxneme8OUXhDCgTqHuBAk62qDTwM+YL8SMIG3V6zfo52i4hmaBpLZ9P4gFFRqnKV5ZxIvcwA/wCHeOQKKWbVCpLPtUdh05joTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=mcRfG5qa; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so3922818276.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1729026292; x=1729631092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToZPK88KWBXsHpBzgS7HGSIabqX2813JKy9iAtzVQYQ=;
        b=mcRfG5qaqEDSdJW8OBy2M7yGcldzlfEK3sEmJ+VyqOCO8NH3fwdLlbRImjXYamTUVg
         UoiNP6nfQiiCYxFLK1Dd7hdLbESzgYyIcrq/ngvKowVzQhlcA6N4t/tC/jiZf6RuZXBx
         8fO6tnoy1tnS5Qgo+Nj/cR8tbPSZmqTOxxsi0sDQhSvW23ljuKfRc0p/O391UmV8+Mlt
         eDGUXa4Ur520/ieoMXMHsDmkNuDp0tzFow0BUlAbLWKlAOmdOYnJgtCAnigDJmOj+sV9
         y4qZB7vvd3LvQauVOBimFX8QfidXrcgexegFFYaRK8NWPRiQFlltdmTbnm5L3zVMHHmN
         /UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026292; x=1729631092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToZPK88KWBXsHpBzgS7HGSIabqX2813JKy9iAtzVQYQ=;
        b=XeqRKZK28tFtBR/T3ALnipLMe67mtca3wlwM1pkYDigszFhw7WofJjq0Er2N1own1b
         jOZtIVeFL5mlKoNATE53bm3rbiy9/LM7E1+julWYzCv3v3xYk7EuhB7tE8Z8zXE2CJZi
         L2Src29vr+lSpo3XQ6+OZ6ynncq5IGAC3I8jy3ti3ce+kqYSRHfiZ8HeFJPMnKTgdUyi
         WiF7BV6LlLFVr65aguQkpn/WJ6RxTuIWpCrmYMfJYY1D5eXAqeO1HfPxjFUOecGqahuW
         AzhYVyEse7Xacby3Lx+E4/vRauwE8q0x8gDPGn1YXDYsAx1uCqgx4OitjP1KAOvrxDUt
         G94A==
X-Forwarded-Encrypted: i=1; AJvYcCWf/z+XNE38iALNc4JVS1yx315qSQn7C6hBRr6RLLRYMfxL5EYzoY3bkcmGuJPhuZU90YYzf5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXfyVIQygDqnl9kiHOZPCue8WTMHzuAKsHYcDqhGDuceX94hm
	jJ18l0bh1g408mBeBrvAEcV3d/ZGX3iuLUMsBOgZiDQM6+nhrWQwgjGhF4fy2NIuI8j/vO+eWk6
	ZOAFMPeGYEwZwuJDg5+xTeXQHjSu2ZQosJeF6SQ==
X-Google-Smtp-Source: AGHT+IFfuqTbgppzNExdeMLg6EEca8KoCbP9TBNY3PTiaiEc2Vyiet9kqiI/+PLRD056KzMrBN/GBjlHYa6fKvwqvUM=
X-Received: by 2002:a05:6902:160f:b0:e1d:9b03:8812 with SMTP id
 3f1490d57ef6-e2931ddc566mr8554841276.57.1729026291971; Tue, 15 Oct 2024
 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007174211.3511506-1-tharvey@gateworks.com> <ZwQqokf15iMEIrAf@pengutronix.de>
In-Reply-To: <ZwQqokf15iMEIrAf@pengutronix.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 15 Oct 2024 14:04:41 -0700
Message-ID: <CAJ+vNU0BGaLco2g9mTf4eDyY4-u9P0HWeK-TUzsb8JPsZs3Ymg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: phy: disable eee due to errata on various KSZ switches
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:38=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> On Mon, Oct 07, 2024 at 10:42:11AM -0700, Tim Harvey wrote:
> > The well-known errata regarding EEE not being functional on various KSZ
> > switches has been refactored a few times. Recently the refactoring has
> > excluded several switches that the errata should also apply to.
> >
> > Disable EEE for additional switches with this errata.
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
> > for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE.
> >
> > This was apparently realized much later and commit ("54a4e5c16382 net:
> > phy: micrel: add Microchip KSZ 9477 to the device table") added the
> > PHY_ID_KSZ9477 to the PHY driver but as the errata was only being
> > applied to PHY_ID_KSZ9477 it's not completely clear what switches
> > that relates to.
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
> > disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID).
> >
> > Fixes: 08c6d8bae48c ("net: phy: Provide Module 4 KSZ9477 errata (DS8000=
0754C)")
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v3: added missing fixes tag
> > v2: added fixes tag and history of issue
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/m=
icrochip/ksz_common.c
> > index b074b4bb0629..d2bd82a1067c 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -2578,11 +2578,19 @@ static u32 ksz_get_phy_flags(struct dsa_switch =
*ds, int port)
> >               if (!port)
> >                       return MICREL_KSZ8_P1_ERRATA;
> >               break;
> > +     case KSZ8795_CHIP_ID:
> > +     case KSZ8794_CHIP_ID:
> > +     case KSZ8765_CHIP_ID:
> > +             /* KSZ87xx DS80000687C Module 2 */
> > +     case KSZ9896_CHIP_ID:
> > +             /* KSZ9896 Errata DS80000757A Module 2 */
> > +     case KSZ9897_CHIP_ID:
> > +             /* KSZ9897 Errata DS00002394C Module 4 */
> > +     case KSZ9567_CHIP_ID:
> > +             /* KSZ9567 Errata DS80000756A Module 4 */
> >       case KSZ9477_CHIP_ID:
> > -             /* KSZ9477 Errata DS80000754C
> > -              *
> > -              * Module 4: Energy Efficient Ethernet (EEE) feature sele=
ct must
> > -              * be manually disabled
> > +             /* KSZ9477 Errata DS80000754C Module 4 */
> > +             /* Energy Efficient Ethernet (EEE) feature select must be=
 manually disabled
> >                *   The EEE feature is enabled by default, but it is not=
 fully
> >                *   operational. It must be manually disabled through re=
gister
> >                *   controls. If not disabled, the PHY ports can auto-ne=
gotiate
> > --
>
> Similar fix is already present in net:
> 0411f73c13afc ("net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9=
896/KSZ9897.")
>
> But your patch provides some quirks for KSZ87xx  and some extra comments
> which are nice to have too. Can you please rebase your patch on top of
> latest net.
>

Hi Oleksij,

Yes, I can submit an update.

Best Regards,

Tim

