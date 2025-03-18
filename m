Return-Path: <netdev+bounces-175578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FBA66717
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5101664E0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FA185B4C;
	Tue, 18 Mar 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch2Z9JrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C950175D47;
	Tue, 18 Mar 2025 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267724; cv=none; b=IyVEpTgrp5k+j8kG/QEwzUIIeiAbEPqNvQa7yy2nJy6skOEKdkqBFg0yjpjOPG7wZAeViMn3bugP1q0kmmhewYsTpp8GEv0RBKEGQdFCz898N0r9poUkTPcd1fR185nnErbiwplj2GP+cQuRzkhC7MyawIKTqObKiNV1A9JePU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267724; c=relaxed/simple;
	bh=8cVF16i3e4q/XBqEUIvF82XXiNo90HepfEkG/2wEU58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CckXgEy7ljV/XWuM+njGhB3KzrptvWCznghpBgsu+3Go02yVG4LXqbBMFNSH3YW+0bSlba9FVnkjYxYL2PGI0zgPvO4/1RYH5PNsiF0YKyrZ5fycUUySE9GIQsdvI+nEIxIwEQD+gIzmL3Ct+GseBRw1Rn22eR23uqSodFWqLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch2Z9JrF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso93859866b.0;
        Mon, 17 Mar 2025 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742267721; x=1742872521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz+8nPOl91ht+Ope/gao9ixAA3wVpZiHHol9RlFYqeE=;
        b=Ch2Z9JrFOuo6zw4Dxo8q3/piKtkGOPszolakJWYNv5aeyuc+5kxMQaEFa05NptZlIr
         6teGvYWJ9IbW8YihkVBD+1EzVyOxoFI8eg92q1GLSMIcQyrPvrQL6LuQPUcmIRn5qGjm
         U3DcNp7tgIV0trNdEYHqSCjemM0seF6N6bWMJ8fwxwoi3tN66pz7CpHqDG66SafvXRbT
         j57KurzFAdLr80TILeWldsh4uS0Ak2PBgdhm+9b0lSydVJ/RMT9lBU2MriZIZSW+92oz
         w6y9IDaihKLbTEY1mEa8F00LbaHnEty9CphzZxFln0t2rCRlcG+hWn6s94PDgvICuzOS
         3B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742267721; x=1742872521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz+8nPOl91ht+Ope/gao9ixAA3wVpZiHHol9RlFYqeE=;
        b=aXHbFhnoAo0ramlFywS0DpPA4J6mSXltHAAww7LgybNQbP0YD9Yic4b4b4yaBMCo6n
         hcYtkiddt1x/3yPcNMXmpc5WH+twmyJBInFqJBA472okGvMjF4Ofqwf6i8f+9BpT/355
         CVE0Ahp/NVQ49SqOZqrCl0QuPlfF7N+pwBkd/yWmzzU5UrF1ZcVdPs6DTV8aHut5f80k
         uKh3O/b4gw9Zdt/bLo5k3qB1WyA8CsHOHxfg6CdC/QvsUsZiaqxkSf9oEBR3ncSEzTVN
         pq2wlia5XWJjxeMe9ZXLustg94n2P3NLkSOOLTHf6MzYP/F2MI0/EbAWOJ247pYwYwjm
         spZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWikxkKHA4eaHqhjf5K/wEWZ1nEHTPaog9kil/pszxDIFjwmFFmIWNC6nrQXzkKJ/d2DqLvqx55ZighiYI=@vger.kernel.org, AJvYcCXF41d8Kl6dB+FGZ8Lchu3T3PKEPG8QJ6W3OuONBcOCBwVi5aLxCLz6T9zcC6oUFx9EzH94lyEx@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMQkTpq8B3XN0+Kv8TldvpNQbJcOoTk+jsCSElRFY9CyIxYqO
	ztROQ/P/+Arg1kjViXesZogmqi0+vToHwb3vTGREWQMxxkYOSfCHWzxWhsIim6WoCsdRvwv1d5B
	MlwhtYPo6n4q5Bf5D5vwWRiX1XoQ=
X-Gm-Gg: ASbGncuFRvpY7U1CsNcb6zYVNdRLqbqfxnRoOht+Vi92qvqvKswj7it0C0//5iWe8jv
	zGc/0xb1Rs4KXf8gLWZoKpTWAU1nVMUt8g8/1UkaV4F68+KULeR7Vdl2dW6NZIMjvmrADLGoezR
	7rWvDQ/f8pKkFCvPa3Xp5qXyW3a/U=
X-Google-Smtp-Source: AGHT+IGhGwpPjAfGVcF+sOoVXVaRZyXYuSygnlXEwmlEulXyHcFu5xGSPio58ZwosgfEOwonIGQ9ZrAzmQnSssDKG9c=
X-Received: by 2002:a17:907:c27:b0:ac3:4370:f6d2 with SMTP id
 a640c23a62f3a-ac34370f77bmr999085366b.4.1742267721000; Mon, 17 Mar 2025
 20:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317063452.3072784-1-JJLIU0@nuvoton.com> <Z9f4W86z90PgtkBc@shell.armlinux.org.uk>
 <9391fb55-11c4-4fa9-b38f-500cb1ae325c@broadcom.com> <Z9gjylMFV5zFG-i5@shell.armlinux.org.uk>
In-Reply-To: <Z9gjylMFV5zFG-i5@shell.armlinux.org.uk>
From: Jim Liu <jim.t90615@gmail.com>
Date: Tue, 18 Mar 2025 11:15:09 +0800
X-Gm-Features: AQ5f1JqrCuozrar-Wau3wKdPaM3garPvIPXN5tPufplw4m7cBiwsaE4NS9x_w1A
Message-ID: <CAKUZ0+GV1J0VxU8Eycv2eCNs2yKvJ9YTob27n+G4Jy-TJhhLZQ@mail.gmail.com>
Subject: Re: [v2,net] net: phy: broadcom: Correct BCM5221 PHY model detection failure
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, JJLIU0@nuvoton.com, andrew@lunn.ch, 
	hkallweit1@gmail.com, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, giulio.benetti+tekvox@benettiengineering.com, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell King  & Florian Fainelli

Very thanks for your comment.
Our EVB uses BCM5221A4K so the id is 0x004061e4
If using the new kernel, the condition in the if statement prevents
the PHY from functioning.
So I followed the driver 's style to modify this condition and use
BRCM_PHY_MODEL().

After checking the net framework I see phydev_id_compare can be used.
It is a good feature for all phy drivers.
but now I just followed the driver style to modify it.

I think Perhaps this obvious error should be addressed first.
And the next step is to  transition Broadcom or other drivers to use
the net framework functions.

Maybe i can add this modify in patch

#define BRCM_PHY_MODEL(phydev) \
-       ((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
+       ((phydev)->phy_id & (phydev)->drv->phy_id_mask)

 #define BRCM_PHY_REV(phydev) \
-       ((phydev)->drv->phy_id & ~((phydev)->drv->phy_id_mask))
+       ((phydev)->phy_id & ~((phydev)->drv->phy_id_mask))


Feel free to provide any suggestions to improve v3.


Best regards,
Jim

On Mon, Mar 17, 2025 at 9:29=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 17, 2025 at 06:18:17AM -0700, Florian Fainelli wrote:
> > On 3/17/2025 3:24 AM, Russell King (Oracle) wrote:
> > > On Mon, Mar 17, 2025 at 02:34:52PM +0800, Jim Liu wrote:
> > > > Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PH=
Ys.
> > > >
> > > > Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 p=
hy")
> > > > Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> > >
> > > Looking at BRCM_PHY_MODEL() and BRCM_PHY_REV(), I think there's more
> > > issues with this driver. E.g.:
> > >
> > > #define BRCM_PHY_MODEL(phydev) \
> > >          ((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
> > >
> > > #define BRCM_PHY_REV(phydev) \
> > >          ((phydev)->drv->phy_id & ~((phydev)->drv->phy_id_mask))
> > >
> > > #define PHY_ID_BCM50610                 0x0143bd60
> > > #define PHY_ID_BCM50610M                0x0143bd70
> > >
> > >          if ((BRCM_PHY_MODEL(phydev) =3D=3D PHY_ID_BCM50610 ||
> > >               BRCM_PHY_MODEL(phydev) =3D=3D PHY_ID_BCM50610M) &&
> > >              BRCM_PHY_REV(phydev) >=3D 0x3) {
> > >
> > > and from the PHY driver table:
> > >
> > >          .phy_id         =3D PHY_ID_BCM50610,
> > >          .phy_id_mask    =3D 0xfffffff0,
> > >
> > >          .phy_id         =3D PHY_ID_BCM50610M,
> > >          .phy_id_mask    =3D 0xfffffff0,
> > >
> > > BRCM_PHY_REV() looks at _this_ .phy_id in the table, and tries to mat=
ch
> > > it against the revision field bits 0-3 being >=3D 3 - but as we can s=
ee,
> > > this field is set to the defined value which has bits 0-3 always as
> > > zero. So, this if() statement is always false.
> > >
> > > So, BRCM_PHY_REV() should be:
> > >
> > > #define BRCM_PHY_REV(phydev) \
> > >     ((phydev)->phy_id & ~(phydev)->drv->phy_id_mask)
> > >
> > >
> > > Next, I question why BRCM_PHY_MODEL() exists in the first place.
> > > phydev->drv->phy_id is initialised to the defined value(s), and then
> > > we end up doing:
> > >
> > >     (phydev->drv->phy_id & phydev->drv->phy_id_mask) =3D=3D
> > >             one-of-those-defined-values
> > >
> > > which is pointless, because we know that what is in phydev->drv->phy_=
id
> > > /is/ one-of-those-defined-values.
> > >
> > > Therefore, I would suggest:
> > >
> > > #define BRCM_PHY_MODEL(phydev) ((phydev)->drv->phy_id)
> > >
> > > is entirely sufficient, and with such a simple definition, I question
> > > the value of BRCM_PHY_MODEL() existing.
> >
> > If I were to make a guess, BRCM_PHY_MODEL() might have existed to ease =
the
> > porting of a non-Linux PHY driver to a Linux PHY driver environment at =
a
> > time where the subsystem was not as mature as it is now.
> >
> > In the interest of a targeted bug fix, I would be keen on taking this p=
atch
> > in its current form and follow up in net next with a removal of
> > BRCM_PHY_MODEL() later on.
>
> Note that commit 32e5a8d651c0 ("tg3 / broadcom: Add code to disable rxc
> refclk") is still wrong (which introduced BRCM_PHY_REV().)
>
> Given its age, I would suggest that the commit I reference above was
> not properly tested, and *possibly* fixing the bug might actually
> cause a regression on TG3.
>
> Also, the original commit description (which references RXC) which is
> supposed to be synchronous to the received data, but the code talks
> about CLK125 which is *technically* a different clock.
>
> We know that the current driver logic works, even though it doesn't
> do what the original author of the code wanted it to do.
>
> Taking these three points together, I don't think it would be wise
> to fix the logical error (and actually test the revision field).
> Instead, I think getting rid of the always-false if() and simplifying
> the code would be better to avoid causing a possible regression on
> TG3.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

