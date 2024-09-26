Return-Path: <netdev+bounces-129970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF89874C1
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4AA1F210BC
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9844595B;
	Thu, 26 Sep 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxy1ktTs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0951C6B2
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358600; cv=none; b=SmKhLSINb16X8rj0tvY7jg1E1gmxTrgkK3XMqqMFMI7IERvFUt2mzq4SKDrVDkYMdumymz/qVGwvW+EpCd1gjy4jLN61BLVepe87dZBWgWA8L5qT1g5+SPy+zlopgByuYpqbF6IIdeYH/XQkJjkTTLcmwD4G6M3aYUjbd9o0+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358600; c=relaxed/simple;
	bh=jdiu3tnQR4C2QgW69DkW1cElZy+xhi8+1vS4+Qwojjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnlcByv5b/SXs/QuKi5TKv2H9TNAHPT8O0oJ3D1mQVbEmEb/BYR9K2/eN6yFnVPkaWaiR2JWnyZs6VFXLaAcLKnZmR3cnuIprjmbW2D9Xk97EjlQMD8qxIOQwjXBWgrLvlYGhJr1zB53xdehlcwxE//VUt0B56Ni2l32Sw5FKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxy1ktTs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a866902708fso12771066b.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727358597; x=1727963397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+zzLjRllKvgaQXPsb5e4jFYVKK2ubkPN9j82GqItdI=;
        b=Lxy1ktTsau0OG1VHs3mmFhT01sP3wYZCt5I8d9WcPtRtRXGZoYpjLuvx21EF1ZrQYL
         UpEw+yul/RCpzngv1hWs9xnxKWpdQ9eyNIXnsUwp/YGEJhHYyDJ22EnjNo92kYS7i1r2
         5OeMlGruJz5ZdYu0kpMTMyjj4l/RQRkCllW1RPEE6nqpBb+CdZy8+ZJs+tBLGtSW88xZ
         2DVOAQDE/4sMb8FNYeWeKxmF7VrxXFJpTFfGa1jyPp+TozgOpFTEsUg6RLEUDVVTRaqE
         1btn4ay4ywL8LsJ+PdDI6rCNQNoe+MLGcHAfLgkMJjzmpJufh4gcWORV+WYubiDqWXC9
         EfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727358597; x=1727963397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+zzLjRllKvgaQXPsb5e4jFYVKK2ubkPN9j82GqItdI=;
        b=hlufiWzFRgw1bBd6vT/c0FUQ+2/FAIlCDGgn0Ovf5CyGgciYvMQDNEEJc1N1+X2h7s
         ibCxnxq423DCJu93i23pcsc9mtAVcf4+CC3EgGaLeZy9llxOUVrOVNuSN6hsPLlGpYNv
         IVGnbYuqrBG1ZnvOdxYoQH7vt88UVRSjxIvUvGu55Rn+eLh/bro192xmt2r3usDB6VtQ
         QsNHqFpkVMBsoVPZD3uchEqXMziRykBuGbC+y3tLiuc/kFbBgSQK5kd1izZqrN1wIlWk
         QasNrwv6oGOZ7tJQO4DplvPGEZzTRBttfRqtz+s40seRzCLZCsgKIGKHntBcwRHi8heb
         AKTg==
X-Forwarded-Encrypted: i=1; AJvYcCUI4M6hBOWXntyO7ubqGCotJaxZybarYesVoqJqw+UwiOv5z8vWF3VSlXcv09oSiTUo635DXSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSF195OnYydFdEiwpz0v5LsPGxtHv8IK7RvLbmxekcu28HKRRc
	NsxNWsf0DszkPmpEi0KG1zNNlSOxh9KnVKEk3W2AZOvHC/RLUVkx
X-Google-Smtp-Source: AGHT+IFpnlRuaodvuzoE0X+W5IOt9tpTDOpsyXF7kzVQoQXrBi+0dHlWnNst0pRaJ2gCgm9xWycbmA==
X-Received: by 2002:a17:906:d550:b0:a8a:9054:8396 with SMTP id a640c23a62f3a-a93b267b48fmr114945166b.7.1727358596598;
        Thu, 26 Sep 2024 06:49:56 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f79c3sm359701666b.176.2024.09.26.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:49:55 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:49:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC 00/10] net: pcs: xpcs: cleanups batch 1
Message-ID: <20240926134952.atabwkzfal44r3lk@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <20240925134337.y7s72tdomvpcehsu@skbuf>
 <ZvVIZ8cp4T/wO5Kh@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvVIZ8cp4T/wO5Kh@shell.armlinux.org.uk>

On Thu, Sep 26, 2024 at 12:41:27PM +0100, Russell King (Oracle) wrote:
> On Wed, Sep 25, 2024 at 04:43:37PM +0300, Vladimir Oltean wrote:
> > Hi Russell,
> > 
> > On Mon, Sep 23, 2024 at 03:00:26PM +0100, Russell King (Oracle) wrote:
> > > First, sorry for the bland series subject - this is the first in a
> > > number of cleanup series to the XPCS driver.
> > 
> > I presume you intend to remove the rest of the exported xpcs functions
> > as well, in further "batches". Could you share in advance some details
> > about what you plan to do with xpcs_get_an_mode() as used in stmmac?
> 
> I've been concentrating more on the sja1105 and wangxun users with this
> cleanup, as changing stmmac is going to be quite painful - so I've left
> this as something for the future. stmmac already stores a phylink_pcs
> pointer, but we can't re-use that for XPCS because stmmac needs to know
> that it's an XPCS vs some other PCS due to the direct calls such as
> xpcs_get_an_mode() and xpcs_config_eee().
> 
> When I was working on EEE support at phylink level, I did try to figure
> out what xpcs_config_eee() is all about, what it's trying to do, why,
> and how it would fit into any phylink-based EEE scheme, but I never got
> very far with that due to lack of documentation.
> 
> So, at the moment I have no plans to touch the prototypes of
> xpcs_get_an_mode(), xpcs_config_eee() nor xpcs_get_interfaces(). With
> the entire patch series being so large already, I'm in no hurry to add
> patches for this - which would need yet more work on stmmac that I'm
> no longer willing to do.

Ok, but I guess that the (very) long-term plan still is that direct
calls from the MAC driver into symbols exported by the PCS are no longer
going to be a thing, right?

> > 	if (xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73))
> > 
> > I'm interested because I actually have some downstream NXP patches which
> > introduce an entirely new MLO_AN_C73 negotiating mode in phylink (though
> > they don't convert XPCS to it, sadly). Just wondering where this is going
> > in your view.
> 
> To give a flavour of what remains:
> 
> net: pcs: xpcs: move Wangxun VR_XS_PCS_DIG_CTRL1 configuration
> net: pcs: xpcs: correctly place DW_VR_MII_DIG_CTRL1_2G5_EN
> net: pcs: xpcs: use dev_*() to print messages
> net: pcs: xpcs: convert to use read_poll_timeout()
> net: pcs: xpcs: add _modify() accessors
> net: pcs: xpcs: use FIELD_PREP() and FIELD_GET()
> net: pcs: xpcs: convert to use linkmode_adv_to_c73()
> net: pcs: xpcs: add xpcs_linkmode_supported()
> net: mdio: add linkmode_adv_to_c73()
> net: pcs: xpcs: move searching ID list out of line
> net: pcs: xpcs: rename xpcs_get_id()
> net: pcs: xpcs: move definition of struct dw_xpcs to private header
> net: pcs: xpcs: provide a helper to get the phylink pcs given xpcs
> net: pcs: xpcs: pass xpcs instead of xpcs->id to xpcs_find_compat()
> net: pcs: xpcs: don't use array for interface
> net: pcs: xpcs: remove dw_xpcs_compat enum
> 
> which looks like this on the diffstat:
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |   2 +-
>  drivers/net/pcs/pcs-xpcs-nxp.c                    |  24 +-
>  drivers/net/pcs/pcs-xpcs-wx.c                     |  51 +--
>  drivers/net/pcs/pcs-xpcs.c                        | 521 +++++++++-------------
>  drivers/net/pcs/pcs-xpcs.h                        |  42 +-
>  include/linux/mdio.h                              |  40 ++
>  include/linux/pcs/pcs-xpcs.h                      |  19 +-
>  7 files changed, 303 insertions(+), 396 deletions(-)

Ok, I don't see anything major on the clause 73 autoneg front. Which I
guess is good? (because at least there aren't competing ideas in flight
about phylink's role for this operating mode)

The bad part is that some user-visible functional changes in xpcs will
most likely be in order. So will probably not be able to be converted
without someone with both access to the 10G hardware and the motivation
to do so (and this might make the conversion unreachable for me too).

For example, without having seen the content of your patch list,
I can only assume linkmode_adv_to_c73() is based on the ethtool
link modes that _xpcs_config_aneg_c73(), mii_c73_mod_linkmode() and
phylink_c73_priority_resolution[] treat.

But I'm already objecting that 2500baseX shouldn't be in those tables.
There should have been a new 2500base-KX ethtool mode, which is one
of the amendments to 802.3-2018 called 802.3cb-2018.

I also have other objections to XPCS's implementation of C73, but I
don't think this is the right context to point them all out. The gist
is that at least for this area, I don't think it would be a good idea
at all to base core phylink support based on what XPCS has/does.

I guess what I'm saying is that taking a break from stmmac until the
groundwork in the core has been laid out through some other vector also
seems like the best idea to me.

Would you be interested in seeing an alternative implementation of
clause 73 support (for the Lynx PCS), this time centered around phylink_pcs,
even if it doesn't touch stmmac/xpcs? As a side effect of that work, it
would maybe provide a long-term avenue of avoiding the xpcs_get_interfaces()
and xpcs_get_an_mode() direct calls, as well as a more consolidated
framework for C73 in XPCS to be reimplemented by somebody. (warning,
this implementation will be quite large, so the question is also about
your time/energy availability in the near future).

