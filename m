Return-Path: <netdev+bounces-215932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A01B30FAE
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D463AF745
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614472E2F09;
	Fri, 22 Aug 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtkfEI/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7026F46E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845906; cv=none; b=pfYHNwzKpfRaBAHWPwHpdpTqOVEmsbYJh85aiptHCicwahpUXo9ncJymLRfTjO/witGcnW0U4sVEeBkBt9C+aXmLMQ9mMSTBpghMt3GNGyoEmcR1PfTT8QObzvmQqeGvpYnaWdg2MGsBe4h/6k/qhDE5tjusou1LMPUBlU9jc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845906; c=relaxed/simple;
	bh=w/49P1fsxsCnjye+tvLaBU+tqs0N5X2BxumxjwIXPC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkNHyvmOhO+zCTiQQK4CUsL17lmlEtclTnSkF7Q+cc7/EESd4+9Ko5VtX7T0L33G3dVMIiz/hOqrTYiPyvXV5MD55suTlmjNBFMlCW/JPavlZe/A6d7EK2BcBfdo68a1DNdF0xr97zqwr8sVMLB24vgp9Rzulrwoj4ZlFZemn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtkfEI/+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so12978565e9.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755845900; x=1756450700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/z8aFKRkcvfaA1Ailj7aQQL2KJFMbgEkI2B7ZgSPdZA=;
        b=RtkfEI/+B/Hy3O1eT8olnsmfzTFxXIagZ5CFJNEyjTbnoMSTAF6bXxgNHuwTbr1crp
         /tdWPb8LeaYRiQPTU7/NY7XZltQUVZZRcCuI9MFeUmXxoAVx+mYjzgTqP2tUT8Z9hing
         +Vpf8OVEx30FU6FiF4aCBG+Bxa6AeaQK0QTyV96dkVwBBf+qEdm5sG+i5U06zdtVrrbW
         BXodVogcE3o5vp2jYetID66oBDMolX+fIF2N4dLQvpoDJXwRL+eInp0fYVh7ir5mO9NP
         RR+DX43HYEuyy2Z5qX7PCCKdarTqNykU8xygK+DSEBk9udghRxi2XtSPE/RY+wY+cq8u
         AsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845900; x=1756450700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/z8aFKRkcvfaA1Ailj7aQQL2KJFMbgEkI2B7ZgSPdZA=;
        b=avDsHu884YJxbnWzmnWqsvBlNUE/p+NDTpgxyh3nUp+U8Da4jeAWfU6myXG+WkfRYd
         WwfmvbRkbctTrkCLxXk2CMBGDjU7b7a8fv7QzxK/ZZGMKeWpI+WpMkaq8CyZbUdAzYEk
         gncOLjRuuoZtFZKA97hTWqvUCfN8ktRYYopdMTZBg63mTfgoViaaaz1/6vSDES1AAVYV
         0FbzB5eMD/tCop/utjZsiukSh6Eg7OVDLUJBhX/SnZib2uJWDSgFqd3bSY1Y31JRuWUJ
         hXPgfjM7ud+HGQlwCNVMj8xASGXTuEreeI+Ofbz4wZZV46DQbDU2YuKp2mz2p1HKxs9Q
         9ryw==
X-Gm-Message-State: AOJu0YwbBngykrNuziI0s5UPoqAEJ2Z/LfVoZO3ZsdpN0aL2AyPz7t+6
	1xxHSXBU78pugAieqFCGrGOHJZ0jsen2I/XCxikyU58wAS1O2rsE2XSg
X-Gm-Gg: ASbGncvVuj0O64cw4nVlkiA4td84R7gSZgyP5M/A2yKePT8GSTLdQ32c8XHEfdhgDzy
	o5edEIwpgkJjuK8bGL8hm710Je9xDZJ7QH+ZguYMwhFJPv7vXsFi04TC8iomaVrJFqyEP56KXxN
	9a7CYS44Ht7uQ27uKy404Hta7Qq4sYw+UHoILCvkbWJBd0uDEPpkuQFVNYjFbHS/k4MvUYMNOGD
	PwwSKfo3gXkVYNJ5A0P4hD/Dc2dq+XhPxdn1F1chaY5MGhg3fp3qD4N4b89jA9l9mrm9IQGS+bB
	8YO0nY7wA9WvEQpb5R25wkH9KlGyg2NAkwN0eXqSaYzw7Nv+5ECVwh0z3Ut4YH+ssIGBIsZILPs
	XuUTg5qhnJZTz4wE/NAQU
X-Google-Smtp-Source: AGHT+IEjf50nJdfN5EBuS+VuI6MGMbiOVjlrGPvGgMe/scnau3zSe6eX8zSX/097L1idLZR8ErRpng==
X-Received: by 2002:a05:600c:c87:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-45b5179ebb2mr14859635e9.12.1755845899551;
        Thu, 21 Aug 2025 23:58:19 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:65a:1400:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dea2b9sm25045215e9.15.2025.08.21.23.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:58:19 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:58:17 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Ilya Evenbach <ievenbach@aurora.tech>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] [88q2xxx] Add support for handling master/slave in
 forced mode
Message-ID: <20250822065817.GA4907@legfed1>
References: <57412198-d385-43ef-85ed-4f4edd7b318a@lunn.ch>
 <20250820181143.2288755-1-ievenbach@aurora.tech>
 <20250820181143.2288755-2-ievenbach@aurora.tech>
 <20250821080205.GA5542@legfed1>
 <CAJmffrpUTzH0_siTUZodX7Gu5JPRvkgUb+73CgXSWu1QSzegSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJmffrpUTzH0_siTUZodX7Gu5JPRvkgUb+73CgXSWu1QSzegSA@mail.gmail.com>

Hi Ilya,

Am Thu, Aug 21, 2025 at 01:53:04PM -0700 schrieb Ilya Evenbach:
> I am using 88Q2221, This PHY has a bug - MDIO_PMA_EXTABLE is not properly
> implemented (reads as 0x20).
> As a result, genphy_c45_baset1_able() returns false, and master/slave is
> not set up or read properly in forced mode.

That is not 88Q2221 specific, please have a look at function
mv88q2xxx_config_init which solves this issue:

/* The 88Q2XXX PHYs do have the extended ability register available, but
 * register MDIO_PMA_EXTABLE where they should signalize it does not
 * work according to specification. Therefore, we force it here.
 */
phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;

> I will try to clean up this patch to better utilize generic functions.
> 

What you are trying to do is adding support for 88Q2221 which has the
same phy_id as the 88Q2220 but needs a different(additional) setup to
work properly(init sequence, ...).
Please change your commit message then.

> On Thu, Aug 21, 2025 at 1:02 AM Dimitri Fedrau <dima.fedrau@gmail.com>
> wrote:
> >
> > Hi Ilya,
> >
> > Am Wed, Aug 20, 2025 at 11:11:43AM -0700 schrieb Ilya A. Evenbach:
> > > 88q2xxx PHYs have non-standard way of setting master/slave in
> > > forced mode.
> > > This change adds support for changing and reporting this setting
> > > correctly through ethtool.
> > >
> > > Signed-off-by: Ilya A. Evenbach <ievenbach@aurora.tech>
> > > ---
> > >  drivers/net/phy/marvell-88q2xxx.c | 106 ++++++++++++++++++++++++++++--
> > >  1 file changed, 101 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/phy/marvell-88q2xxx.c
> b/drivers/net/phy/marvell-88q2xxx.c
> > > index f3d83b04c953..b94d574fd9b7 100644
> > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > @@ -118,6 +118,11 @@
> > >  #define MV88Q2XXX_LED_INDEX_TX_ENABLE                        0
> > >  #define MV88Q2XXX_LED_INDEX_GPIO                     1
> > >
> > > +/* Marvell vendor PMA/PMD control for forced master/slave when AN is
> disabled */
> > > +#define PMAPMD_MVL_PMAPMD_CTL                                0x0834
> >
> > Already defined, see MDIO_PMA_PMD_BT1_CTRL.
> >
> > > +#define MASTER_MODE                                  BIT(14)
> >
> > Already defines, see MDIO_PMA_PMD_BT1_CTRL_CFG_MST.
> >
> > > +#define MODE_MASK                                    BIT(14)
> > > +
> > >  struct mv88q2xxx_priv {
> > >       bool enable_led0;
> > >  };
> > > @@ -377,13 +382,57 @@ static int mv88q2xxx_read_link(struct phy_device
> *phydev)
> > >  static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
> > >  {
> > >       int ret;
> > > +     int adv_l, adv_m, stat, stat2;
> > > +
> > > +     /* In forced mode, state and config are controlled via PMAPMD
> 0x834 */
> > > +     if (phydev->autoneg == AUTONEG_DISABLE) {
> > > +             ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
> PMAPMD_MVL_PMAPMD_CTL);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             if (ret & MASTER_MODE) {
> > > +                     phydev->master_slave_state =
> MASTER_SLAVE_STATE_MASTER;
> > > +                     phydev->master_slave_get =
> MASTER_SLAVE_CFG_MASTER_FORCE;
> > > +             } else {
> > > +                     phydev->master_slave_state =
> MASTER_SLAVE_STATE_SLAVE;
> > > +                     phydev->master_slave_get =
> MASTER_SLAVE_CFG_SLAVE_FORCE;
> > > +             }
> > > +             return 0;
> > > +     }
> > >
> > > -     phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> > > -     ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
> > > -     if (ret < 0)
> > > -             return ret;
> > >
> > > -     if (ret & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
> > > +     adv_l = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_L);
> > > +     if (adv_l < 0)
> > > +             return adv_l;
> > > +     adv_m = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_M);
> > > +     if (adv_m < 0)
> > > +             return adv_m;
> > > +
> > > +     if (adv_l & MDIO_AN_T1_ADV_L_FORCE_MS)
> > > +             phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
> > > +     else if (adv_m & MDIO_AN_T1_ADV_M_MST)
> > > +             phydev->master_slave_get =
> MASTER_SLAVE_CFG_MASTER_PREFERRED;
> > > +     else
> > > +             phydev->master_slave_get =
> MASTER_SLAVE_CFG_SLAVE_PREFERRED;
> > > +
> > > +     stat = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
> > > +     if (stat < 0)
> > > +             return stat;
> > > +
> > > +     if (stat & MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT) {
> > > +             phydev->master_slave_state = MASTER_SLAVE_STATE_ERR;
> > > +             return 0;
> > > +     }
> > > +
> > > +     stat2 = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT2);
> > > +     if (stat2 < 0)
> > > +             return stat2;
> > > +     if (!(stat2 & MDIO_MMD_AN_MV_STAT2_AN_RESOLVED)) {
> > > +             phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> > > +             return 0;
> > > +     }
> > > +
> > > +     if (stat & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
> > >               phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
> > >       else
> > >               phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
> > > @@ -391,6 +440,34 @@ static int
> mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
> > >       return 0;
> > >  }
> > >
> >
> > Is there a issue with the function you are trying to fix ? Seems that
> > you copied some generic functions into it.
> >
> > > +static int mv88q2xxx_setup_master_slave_forced(struct phy_device
> *phydev)
> > > +{
> > > +     int ret = 0;
> > > +
> > > +     switch (phydev->master_slave_set) {
> > > +     case MASTER_SLAVE_CFG_MASTER_FORCE:
> > > +     case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> > > +             ret = phy_modify_mmd_changed(phydev, MDIO_MMD_PMAPMD,
> > > +                                          PMAPMD_MVL_PMAPMD_CTL,
> > > +                                          MODE_MASK, MASTER_MODE);
> > > +             break;
> > > +     case MASTER_SLAVE_CFG_SLAVE_FORCE:
> > > +     case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> > > +             ret = phy_modify_mmd_changed(phydev, MDIO_MMD_PMAPMD,
> > > +                                          PMAPMD_MVL_PMAPMD_CTL,
> > > +                                          MODE_MASK, 0);
> > > +             break;
> > > +     case MASTER_SLAVE_CFG_UNKNOWN:
> > > +     case MASTER_SLAVE_CFG_UNSUPPORTED:
> > > +     default:
> > > +             phydev_warn(phydev, "Unsupported Master/Slave mode\n");
> > > +             ret = 0;
> > > +             break;
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> >
> > This function does the same as genphy_c45_pma_baset1_setup_master_slave.
> > Please use the generic function. Besides you are introducing register
> > PMAPMD_MVL_PMAPMD_CTL which is MDIO_PMA_PMD_BT1_CTRL.
> >
> > >  static int mv88q2xxx_read_aneg_speed(struct phy_device *phydev)
> > >  {
> > >       int ret;
> > > @@ -448,6 +525,11 @@ static int mv88q2xxx_read_status(struct phy_device
> *phydev)
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > +     /* Populate master/slave status also for forced modes */
> > > +     ret = mv88q2xxx_read_master_slave_state(phydev);
> > > +     if (ret < 0 && ret != -EOPNOTSUPP)
> > > +             return ret;
> > > +
> > >       return genphy_c45_read_pma(phydev);
> > >  }
> > >
> >
> > Why ? This function is only used in case AUTONEG_ENABLE.
> >
> > > @@ -478,6 +560,20 @@ static int mv88q2xxx_config_aneg(struct phy_device
> *phydev)
> > >       if (ret)
> > >               return ret;
> > >
> > > +     /* Configure Base-T1 master/slave per phydev->master_slave_set.
> > > +      * For AN disabled, program PMAPMD role directly; otherwise rely
> on
> > > +      * the standard Base-T1 AN advertisement bits.
> > > +      */
> > > +     if (phydev->autoneg == AUTONEG_DISABLE) {
> > > +             ret = mv88q2xxx_setup_master_slave_forced(phydev);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else {
> > > +             ret = genphy_c45_pma_baset1_setup_master_slave(phydev);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > >       return phydev->drv->soft_reset(phydev);
> > >  }
> > >
> >
> > I don't see any reason why genphy_c45_config_aneg isn't sufficient here.
> > In case AUTONEG_DISABLE, genphy_c45_pma_setup_forced is called and calls
> > genphy_c45_pma_baset1_setup_master_slave which is basically the same as
> > mv88q2xxx_setup_master_slave_forced.
> > In case AUTONEG_ENABLE, calling genphy_c45_pma_baset1_setup_master_slave
> is
> > wrong, please look how genphy_c45_an_config_aneg is implemented.
> >
> > Please take other users of the driver into CC, they did a lot of
> > reviewing and testing in the past. If there is some issue with the
> > driver, they should know:
> >
> > "Niklas Söderlund" <niklas.soderlund+renesas@ragnatech.se>
> > "Gregor Herburger" <gregor.herburger@ew.tq-group.com>
> > "Stefan Eichenberger" <eichest@gmail.com>
> > "Geert Uytterhoeven" <geert@linux-m68k.org>
> >
> > Which device are you using, and why did you need this patch ? Is there
> > any issue you are trying to fix ? On my side I did a lot of testing with
> > the different modes and never experienced any problems so far.
> >
> > Best regards,
> > Dimitri Fedrau

