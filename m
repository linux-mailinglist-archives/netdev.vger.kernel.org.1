Return-Path: <netdev+bounces-233669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173CAC17307
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B413A48B9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A75350A0F;
	Tue, 28 Oct 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWtabPrz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1B2D1319
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690434; cv=none; b=o6oWgxOy2STt0qT/DQebmodMGQZLNNLDY65xwOAP+lmdBP1xW70DQgw9hvdSUACyfzpMxHSQuhImFcIBULDM6xhs+5/VJOyHc93zHRfKyBV4rmUbgnoNlrYdGTBk9X8bh6igvTN09N1anBjIqfl+uQUtGQQe9WspdNGcKs2yMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690434; c=relaxed/simple;
	bh=Vax0uhYjtlCldXGhRSibY1kPvEN9H0YEloYOWZtOirI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb2/iLYswKbTUBF1ov1oBxXxPbEVaysvhWD1Yc4fvF3MKg93YgdfMBB07QkUpayY0DzGxGNy4xHybJZsSznpntld7v2kDhkJXGfFkjTIv8syhYdivqtfnoTJGc+1sJiBiQb5c4xn3L6Fht8IEUcPemUL0Ct+ozyOaDoZe66IX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWtabPrz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710665e7deso34655455e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761690431; x=1762295231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLV8zsdLhFT5u4037T/84AIdxKJ9R91MjLZrwze9hhQ=;
        b=LWtabPrzgNZSPx+u5rXM59MCikuHBeeMxlNPJ/R8YSPft3iTPEklA6ngvninO0e1Kx
         QVGdwynNAJQEinU4q20uSy4te0j6HY7+AjMMXgonP+kC6KU1bigsEa2KCrrmZxjm7Soz
         uaSYe9ThuXCfdwIMQLaj6UPn9iW18icPw/OQeVIvjS3PO9m7KZKawcWC4Dc6MmoCMBCt
         AQvTevVchsXC8LZxXw7WrDlrgOFYp3xdjVg18Wv6eoaBgPbZNZgrgxH1KWwYzdp64jrF
         ppa14t96JWUJA4VWcsyjTqArbTmBileCUfWlOMKDnlwDERjwbx1tenals/v7glsxbSbp
         /V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761690431; x=1762295231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLV8zsdLhFT5u4037T/84AIdxKJ9R91MjLZrwze9hhQ=;
        b=NC67+r63nBiU/8ZASkd8RiB2krnWHlJvaYaDfMwcQpzPbvGspFnSy4sR4B1hMF08Wz
         DwJxgo0xuY2X5Hq8teAXD7Qfmfuc0LwsZYeadgMmH2s/wMvH5Ia/vyxThMXGyY1v3kgM
         0lIu+IaWN6jqRzBXXI2GFC/rAC24FzAXfb9lWbBHJr2Jp303UFo1MHAHD8nI9fk/iPX0
         xFA/84RsUGMRQIUo/oB2yB1qQXXJYaS83q16qUDEL1z82zl98IeYcM5ui31zN+CFfaAE
         M9U9aRMUCrNNmXNWxyHNHOBGZlVCIO2V5sso1BTPY64Ri1XRH9rRbmimFYnaFd6Crter
         +5Bg==
X-Gm-Message-State: AOJu0YyGVOt1GSyx25PQcgmR/PR3PfSsHGcDfdKJe/WbzYQhERo1qZKv
	4xwZn69jjSSPuGti+ES6bC5efpIQpvkwXw/jR3wsHCFsy2XyVGYirZKeUKet2eCjAeGBEGSCsZ1
	oqvliSrlthxyjzX9WzA45Gjks68KzCRs=
X-Gm-Gg: ASbGncsqi5HBaaFrPVuauV5qauqWHn8zLyzUq6A3Q4vch27ZFUs+X3TdRfasEazM1ca
	P+GSUefOpMPzMv/2J7P8iyxEqokG583hcRxMXxRJNhp7Xcs0p3fU5jxaNDNRdjNWAZteQ/rDuQ1
	1jcKvFzcEDwOhB00I6EwGzPygAdaoPpHeUhA31IjTt5LgUAr69qBlXGSpASfke52t0HOAFH1Igp
	AnAUKg/0GEV6PTRzO/7Z+PBAj44qvwfop8J5ONtqaB1hdAvBrrqC7XRushvMmi9gCTM+IoK45zb
	d5yFqbHXf2a9NR5Skg==
X-Google-Smtp-Source: AGHT+IGoL2ayjiPpveokQTD/CS3hqVaiWFlvYc5dECjQr14Vfs/y5NsJj78mq2O1ZIXmgBtRfN3T4pdpcUKrGere2aA=
X-Received: by 2002:a05:6000:430d:b0:427:526:1684 with SMTP id
 ffacd0b85a97d-429aef78ff5mr568108f8f.25.1761690430971; Tue, 28 Oct 2025
 15:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>
 <0d66967f-e75f-4723-99f4-164abfe8b9ff@lunn.ch>
In-Reply-To: <0d66967f-e75f-4723-99f4-164abfe8b9ff@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 28 Oct 2025 15:26:34 -0700
X-Gm-Features: AWmQ_bnaDXTMv_Grv4YhCdI8_HcXPezwyaJYgUS4pw7zlTWli-6twjmG9_LM7nE
Message-ID: <CAKgT0UcW9qhXd0JjRiJo=RVautsOa9grsWiee+OwT=1Agiib0w@mail.gmail.com>
Subject: Re: [net-next PATCH 7/8] fbnic: Add SW shim for MII interface to PMA/PMD
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int
> > +fbnic_swmii_read_pmapmd(struct fbnic_dev *fbd, int regnum)
> > +{
> > +     u16 ctrl1 =3D 0, ctrl2 =3D 0;
> > +     struct fbnic_net *fbn;
> > +     int ret =3D 0;
> > +     u8 aui;
> > +
> > +     if (fbd->netdev) {
>
> Is that even impossible? I don't remember the core code, but usually
> the priv structure is appended to the end of the net_device structure.

In the case of fbnic it is possible as the fbd is appended to the
devlink structure. So it exists before the netdev does.

> > +             fbn =3D netdev_priv(fbd->netdev);
> > +             aui =3D fbn->aui;
> > +     }
> > +
> > +     switch (aui) {
> > +     case FBNIC_AUI_25GAUI:
> > +             ctrl1 =3D MDIO_CTRL1_SPEED25G;
> > +             ctrl2 =3D MDIO_PMA_CTRL2_25GBCR;
> > +             break;
> > +     case FBNIC_AUI_LAUI2:
> > +             ctrl1 =3D MDIO_CTRL1_SPEED50G;
> > +             ctrl2 =3D MDIO_PMA_CTRL2_50GBCR2;
> > +             break;
> > +     case FBNIC_AUI_50GAUI1:
> > +             ctrl1 =3D MDIO_CTRL1_SPEED50G;
> > +             ctrl2 =3D MDIO_PMA_CTRL2_50GBCR;
> > +             break;
> > +     case FBNIC_AUI_100GAUI2:
> > +             ctrl1 =3D MDIO_CTRL1_SPEED100G;
> > +             ctrl2 =3D MDIO_PMA_CTRL2_100GBCR2;
> > +             break;
> > +     default:
> > +             break;
>
> If it is something else, is that a bug? Would it be better to return
> -EINVAL?

The problem with returning an error is that it causes other code to do
weird things. I figure we are better off just not returning a speed in
that case.

> > +     }
> > +
> > +     switch (regnum) {
> > +     case MDIO_CTRL1:
> > +             ret =3D ctrl1;
> > +             break;
> > +     case MDIO_STAT1:
> > +             ret =3D fbd->pmd_state =3D=3D FBNIC_PMD_SEND_DATA ?
> > +                   MDIO_STAT1_LSTATUS : 0;
> > +             break;
> > +     case MDIO_DEVS1:
> > +             ret =3D MDIO_DEVS_PMAPMD;
> > +             break;
> > +     case MDIO_CTRL2:
> > +             ret =3D ctrl2;
> > +             break;
> > +     case MDIO_STAT2:
> > +             ret =3D MDIO_STAT2_DEVPRST_VAL |
> > +                   MDIO_PMA_STAT2_EXTABLE;
> > +             break;
> > +     case MDIO_PMA_EXTABLE:
> > +             ret =3D MDIO_PMA_EXTABLE_40_100G |
> > +                   MDIO_PMA_EXTABLE_25G;
> > +             break;
> > +     case MDIO_PMA_40G_EXTABLE:
> > +             ret =3D MDIO_PMA_40G_EXTABLE_50GBCR2;
> > +             break;
> > +     case MDIO_PMA_25G_EXTABLE:
> > +             ret =3D MDIO_PMA_25G_EXTABLE_25GBCR;
> > +             break;
> > +     case MDIO_PMA_50G_EXTABLE:
> > +             ret =3D MDIO_PMA_50G_EXTABLE_50GBCR;
> > +             break;
> > +     case MDIO_PMA_EXTABLE2:
> > +             ret =3D MDIO_PMA_EXTABLE2_50G;
> > +             break;
> > +     case MDIO_PMA_100G_EXTABLE:
> > +             ret =3D MDIO_PMA_100G_EXTABLE_100GBCR2;
> > +             break;
> > +     default:
> > +             break;
>
> So the intention here is to return 0, meaning the register does not
> exist, as defined by 802.3 for C45? Maybe add a comment?
>
> I'm just wondering how robust this is. Maybe at a dev_dbg() printing
> the regnum?

I will look at adding it. Probably have it output the regnum and the value.

> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int
> > +fbnic_swmii_read_c45(struct mii_bus *bus, int addr, int devnum, int re=
gnum)
> > +{
> > +     struct fbnic_dev *fbd =3D bus->priv;
> > +
> > +     if (addr !=3D 0)
> > +             return 0xffff;
> > +
> > +     if (devnum =3D=3D MDIO_MMD_PMAPMD)
> > +             return fbnic_swmii_read_pmapmd(fbd, regnum);
> > +
> > +     return 0xffff;
>
> For C45 you are supposed to return 0 if the register does not exist. It s=
ays:
>
>    45.2 MDIO Interface registers
>
>    If a device supports the MDIO interface it shall respond to all
>    possible register addresses for the device and return a value of
>    zero for undefined and unsupported registers.
>
> > +static int
> > +fbnic_swmii_write_c45(struct mii_bus *bus, int addr, int devnum,
> > +                   int regnum, u16 val)
> > +{
> > +     /* Currently PHY setup is meant to be read-only */
> > +     return 0;
>
> -EOPNOTSUPP? WARN_ON_ONCE()?

It will cause stuff to blow up. There are several writes that are done
that can be safely ignored. The issue is if I start returning an error
I get no phy at all.

> If it does happen, i assume that means your assumptions are wrong?
> Don't you want to know?

I had based the logic on the fixed_phy approach
(https://elixir.bootlin.com/linux/v6.18-rc3/C/ident/fixed_mdio_write).
Basically it just returns 0 and doesn't do anything in response to
writes. Seems like we do the same thing for phylink assuming we aren't
passing it to an actual phy in the phylink_mii_read/write calls.

