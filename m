Return-Path: <netdev+bounces-49370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2617F1D83
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC32B21939
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC9358B2;
	Mon, 20 Nov 2023 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU2x/az6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224C291;
	Mon, 20 Nov 2023 11:46:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083f61322fso19549355e9.1;
        Mon, 20 Nov 2023 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700509591; x=1701114391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W6xLiIL3r8NkHQ19cq/0NuP6fOQ+M4GE4JYubtr8bqA=;
        b=FU2x/az63z2E53up8A2kLQDBLjwEMBYxPD+xiupzlAqvVkuSc5HLJeiEgnoEqhNhS0
         5PQWtynH/LzWJSp0lhL2Z6ASEfVQ1VoxNcojGbODeYaTM7dnlZ/KCJxqeD2K+7U+pOiX
         y4Ircum34/oyeoewFh0VzFxaYEcq6Afa6X++QgyeYIaniRKJoxmWCqpGPwJ/qse6fSFz
         zQJpgg+dlNRNR/wYr8FvfzENYBBchruL7efn5ZUgif4s93LJCHGGxoMm87T/uYbAHBHu
         bi7fFR14uhPBR4d20dYUa1oiCaIuriSPCCNk7Jjh4RjnBZCNlPRGXEtA+qLGHlsgmxjx
         7c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509591; x=1701114391;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6xLiIL3r8NkHQ19cq/0NuP6fOQ+M4GE4JYubtr8bqA=;
        b=u7CQ783TMQHe19bZAVKJJIAo+RvEK3pBb5W10Li89RpmGNigl0W0JwGxhbwWrSYHeg
         PTJ2vyCan+YZmjaLoKKJNT/NJCVF1J+1DsXD9cwQT1Uu6hA8sXJiL5goDJd9fk9c/HMR
         RbP01zf/vUsi0MSWDi6U88YgngfwOX62PEyqKruB9N2s1GasECllupjwPE4bV++wqccU
         3pJvAHGO/c5UKaQY/NpyrviLsNJuZ7M++1LGRPl1Sv7QP8xKqQIoJdVvZbKwaSZbnHUa
         yetg9f5CjmjAzjVlXX7ZlFMrbk4MeNglKNx70/1rs6HrdeAFrpZ3w6CoflHd1uIxksDE
         3wkw==
X-Gm-Message-State: AOJu0YzdjESbbzmUPLmyySLILf17PvxnlEtdefhtw9OfB3Zp9/H5F5QB
	Uy7xCtwPr8XbOprSGzTcTCs=
X-Google-Smtp-Source: AGHT+IFSg+ZnL0z9VAvckLpjCUM2jyc9h2ZByNy9AXGfouqS2J8opclQ7yaQzYlUeMFCdOOjRytUmA==
X-Received: by 2002:a05:600c:198b:b0:408:53ac:141f with SMTP id t11-20020a05600c198b00b0040853ac141fmr6758532wmq.24.1700509591268;
        Mon, 20 Nov 2023 11:46:31 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00401e32b25adsm14703913wms.4.2023.11.20.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:46:30 -0800 (PST)
Message-ID: <655bb796.050a0220.750ad.21a4@mx.google.com>
X-Google-Original-Message-ID: <ZVuOGF8aa005de6l@Ansuel-xps.>
Date: Mon, 20 Nov 2023 17:49:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY
 if defined for PHY
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
 <ZVuUP797C4PLzJsP@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVuUP797C4PLzJsP@lzaremba-mobl.ger.corp.intel.com>

On Mon, Nov 20, 2023 at 06:15:43PM +0100, Larysa Zaremba wrote:
> On Mon, Nov 20, 2023 at 02:15:40PM +0100, Christian Marangi wrote:
> > soft_reset call for phy_init_hw had multiple revision across the years
> > and the implementation goes back to 2014. Originally was a simple call
> > to write the generic PHY reset BIT, it was then moved to a dedicated
> > function. It was then added the option for PHY driver to define their
> > own special way to reset the PHY. Till this change, checking for ret was
> > correct as it was always filled by either the generic reset or the
> > custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> > phy: Stop with excessive soft reset"), as the generic reset call to PHY
> > was dropped but the ret check was never made entirely optional and
> > dependent whether soft_reset was defined for the PHY driver or not.
> > 
> > Luckly nothing was ever added before the soft_reset call so the ret
> > check (in the case where a PHY didn't had soft_reset defined) although
> > wrong, never caused problems as ret was init 0 at the start of
> > phy_init_hw.
> > 
> > To prevent any kind of problem and to make the function cleaner and more
> > robust, correctly move the ret check if the soft_reset section making it
> > optional and needed only with the function defined.
> > 
> > Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/phy_device.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 2ce74593d6e4..478126f6b5bc 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -1235,14 +1235,13 @@ int phy_init_hw(struct phy_device *phydev)
> >  
> >  	if (phydev->drv->soft_reset) {
> >  		ret = phydev->drv->soft_reset(phydev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> >  		/* see comment in genphy_soft_reset for an explanation */
> > -		if (!ret)
> > -			phydev->suspended = 0;
> > +		phydev->suspended = 0;
> 
> Are you sure 'suspended' should not be cleared, if soft_reset fails?
> 
> >  	}

Idea is not change current implementation... And before this, suspended
was cleared only with reset not failing.

> >  
> > -	if (ret < 0)
> > -		return ret;
> > -
> >  	ret = phy_scan_fixups(phydev);
> >  	if (ret < 0)
> >  		return ret;
> > -- 
> > 2.40.1
> > 
> > 

-- 
	Ansuel

