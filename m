Return-Path: <netdev+bounces-146450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F889D37BA
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3417A1F22FF1
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648719CC31;
	Wed, 20 Nov 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3RpsbYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54115DBBA
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096616; cv=none; b=n987qsbYquofz70t6EyBgDyAT4erbCbUia3rMvRRq9rCHD+efeo1A7M6uw/qtItpzBxEoktxHORKJGM8VwY4z7s9SYkYTaO/yXaumMm44rz2BBLPYEPFD38imRC8Le8uh9FEpG28tXuHOUwduzVsaquNXHDxfY2PMa2JrarWncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096616; c=relaxed/simple;
	bh=32YDIHQA8qQP4BBmzI+sqfTHJ25Ff3DCUPnLrJSJaN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0OizC9RG2Ufa20CGg0FGKzHwgtBZAIJjL68fRFHXlIdf5w5dB3FAaLF5Xq9h4CCfRy4SEleWUQi1in7kxvwJRLSlRNDPNpm6O7ic74Xc09GUMdBpP0dOhR+frXRGfZFUa//qO0QsfrO0XcLo58fut+FahwL1Sxaqg39CBqunpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3RpsbYH; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a77562332aso9248065ab.3
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732096614; x=1732701414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B69pex7HTUI2SrZp5P49JsJXWsva+CVoUziz4Z9MYIE=;
        b=b3RpsbYHqAClrdqdd0mugTbjDNx9tlMvJVHEojchvFqOjcQYEoG0wyozyRdcrUEo3t
         s7oCYj/KO9Z2kWUgEF9etc/et162Zfi4GK+4bVc3l10YJNIFXFZCX6+C1CMLQJHtzzjR
         wJTsJgPlpZRxvDiqEbMYNiOdt9Ft0VFsO4GR70CDP/z5I0gvK8wba43k03PhzNWcnjyN
         5CRsehKqWYbllS1soQzkAmHDhXsdXRLFrlmaiCTh+Ngsv8tu1EyE3uEtfFpqPev97pME
         7INvtsA31dAlLvZFGJapw7tq9aSWChg+nO1WVgmO/v3yxsh9bT8gl0aSzIOJNQDiXbTU
         KTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096614; x=1732701414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B69pex7HTUI2SrZp5P49JsJXWsva+CVoUziz4Z9MYIE=;
        b=Og0CHoJ8ZYXLntZDEewf2qIMWkKhnqlQe2zdzNFh5Qa/iyJrvJQfRz4MQXTgrbubGa
         WTTDOoFGdR2o8Ti3MaEcBVgntf+j4ypzTdDkRRg9e5Iywy8z1WnLotGzM6nJASKeetoO
         3/TzhvWlS9h41CKpa0Zla7via4XALG6Mi41ofC25j+ywp7192rdtipNwYWuzJjkvBxh9
         izKJDMVBDkMA7rXnhi7PuDosiCuZq3h4TRCQV9oydgMiBEqG4xI3mgXHTp6XxzT30WQi
         zwe/duFHYLcKdrfby52x9vY40rJTRne2p9Kg/gKjshUnyJbd5RCqdeLfOMh1dWgXhmJ0
         VKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXAlSJTiNLF3mtZM9pp7PtlHbh+Be1Im7YzGeJNJM0vd4/g0uO4sMgbgaD/bURS15rqk+o0rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ24AHW0d8WgkBqs42Oh+kmRvaVibpZNdjH4reYMo5D9YfubAe
	TihAdjZuURCEGDihZD49ccEqo+t/mGiyaV8dAVrkDWJt1co3PceeqLf+hbA+3ggZ+na6Rkb8JBH
	KqQF9liphq2Mtoky2LtTu7l4Q8Yh6KiV2
X-Google-Smtp-Source: AGHT+IGqd6UiuK89t6fgU7MpNm28/r/B1egD87u9dvSm9yqfx8INNbPbGGGke3nIFFU1e6FxTyqcjkawhZ88GytUpcU=
X-Received: by 2002:a05:6e02:1521:b0:3a7:820e:3388 with SMTP id
 e9e14a558f8ab-3a7865a67edmr21286265ab.20.1732096613808; Wed, 20 Nov 2024
 01:56:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com> <2422c3c6-7ea4-4551-839b-7cbbdaadf499@linux.intel.com>
In-Reply-To: <2422c3c6-7ea4-4551-839b-7cbbdaadf499@linux.intel.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 20 Nov 2024 10:56:43 +0100
Message-ID: <CAFSsGVtCPyto3DHD5bL9H6AOiDKQXcxS34nGtyM7gEKBepQFkA@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: phy: ensure that genphy_c45_an_config_eee_aneg()
 sees new value of phydev->eee_cfg.eee_enabled
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:11=E2=80=AFAM Choong Yong Liang
<yong.liang.choong@linux.intel.com> wrote:
>
>
>
> On 17/11/2024 4:52 am, Heiner Kallweit wrote:
> > This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
> > eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg(=
)
> > (called from genphy_c45_ethtool_set_eee) not seeing the new value of
> > phydev->eee_cfg.eee_enabled.
> >
> > Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC su=
pport EEE")
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> > v2:
> > - change second arg of phy_ethtool_set_eee_noneg to pass the old settin=
gs
> > - reflect argument change in kdoc
> > ---
> >   drivers/net/phy/phy.c | 24 ++++++++++++++----------
> >   1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index 8876f3673..2ae0e3a67 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -1671,7 +1671,7 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
> >    * phy_ethtool_set_eee_noneg - Adjusts MAC LPI configuration without =
PHY
> >    *                         renegotiation
> >    * @phydev: pointer to the target PHY device structure
> > - * @data: pointer to the ethtool_keee structure containing the new EEE=
 settings
> > + * @old_cfg: pointer to the eee_config structure containing the old EE=
E settings
> >    *
> >    * This function updates the Energy Efficient Ethernet (EEE) configur=
ation
> >    * for cases where only the MAC's Low Power Idle (LPI) configuration =
changes,
> > @@ -1682,11 +1682,10 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
> >    * configuration.
> >    */
> >   static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> > -                                   struct ethtool_keee *data)
> > +                                   const struct eee_config *old_cfg)
> >   {
> > -     if (phydev->eee_cfg.tx_lpi_enabled !=3D data->tx_lpi_enabled ||
> > -         phydev->eee_cfg.tx_lpi_timer !=3D data->tx_lpi_timer) {
> > -             eee_to_eeecfg(&phydev->eee_cfg, data);
> > +     if (phydev->eee_cfg.tx_lpi_enabled !=3D old_cfg->tx_lpi_enabled |=
|
> > +         phydev->eee_cfg.tx_lpi_timer !=3D old_cfg->tx_lpi_timer) {
> >               phydev->enable_tx_lpi =3D eeecfg_mac_can_tx_lpi(&phydev->=
eee_cfg);
> >               if (phydev->link) {
> >                       phydev->link =3D false;
> > @@ -1706,18 +1705,23 @@ static void phy_ethtool_set_eee_noneg(struct ph=
y_device *phydev,
> >    */
> >   int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_kee=
e *data)
> >   {
> > +     struct eee_config old_cfg;
> >       int ret;
> >
> >       if (!phydev->drv)
> >               return -EIO;
> >
> >       mutex_lock(&phydev->lock);
> > +
> > +     old_cfg =3D phydev->eee_cfg;
> > +     eee_to_eeecfg(&phydev->eee_cfg, data);
> > +
> >       ret =3D genphy_c45_ethtool_set_eee(phydev, data);
> > -     if (ret >=3D 0) {
> > -             if (ret =3D=3D 0)
> > -                     phy_ethtool_set_eee_noneg(phydev, data);
> > -             eee_to_eeecfg(&phydev->eee_cfg, data);
> > -     }
> > +     if (ret =3D=3D 0)
> > +             phy_ethtool_set_eee_noneg(phydev, &old_cfg);
> > +     else if (ret < 0)
> > +             phydev->eee_cfg =3D old_cfg;
> > +
> >       mutex_unlock(&phydev->lock);
> >
> >       return ret < 0 ? ret : 0;
>
> Hi Heiner,
>
> I hope this message finds you well.
>
> I noticed that the recent patch you submitted appears to be based on the
> previous work I did in this patch series:
> https://patchwork.kernel.org/project/netdevbpf/cover/20241115111151.18310=
8-1-yong.liang.choong@linux.intel.com/.
>
> Would you mind including my name as "Reported-by" in the commit message? =
I
> believe this would appropriately acknowledge my role in identifying and
> reporting the issue.
>

Reported-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

Hope this is enough for patchwork and/or the maintainers to pick up this ta=
g,
w/o resubmitting the patch.

