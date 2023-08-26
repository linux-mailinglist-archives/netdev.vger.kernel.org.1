Return-Path: <netdev+bounces-30879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874197898BD
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860A11C208DB
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2660101D3;
	Sat, 26 Aug 2023 19:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA904C151
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 19:01:46 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4EE4B
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 12:01:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b974031aeaso30286771fa.0
        for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693076503; x=1693681303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjx31P2LOtZyDGEPab19XWTZreTskP8FhK51/PO/d54=;
        b=kpBWD7sl/M3yLXwzcq2uwFOjqS6WmYUzUGtZ81oF/H/WNmCRYQPCGDsfGdrkpd1cgn
         9bdwT9KAButJdCfOkhRB5gDS4uuCvmQVhVspF9zcOq5ElIsWDVCrALJfIikubeumaivT
         dG0fOIZ7NAQ2y/ygEHnB/NbHtYlattqsNGjA8m6eSmOY6lXF3etJ6T3ar3sQcBEE97Hj
         EaSpq8SBTiQbq/767JVZvRAYCqlSF9EJUVnO/mqWmgts5p9brgcP73dR3u1Ko6hff7P7
         U6utRmIb4T2qRkeldF2c8U44xXLxRPYHP2yK/ERlnBuUgT+lZiHrI9ftF7/cOxcB1TwE
         Nizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693076503; x=1693681303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjx31P2LOtZyDGEPab19XWTZreTskP8FhK51/PO/d54=;
        b=kD/5OByt3OmX14F7KIhN8F9jb1j7gD/XKf0dcs0Gq/VLYp10WZxvrok2J50lLyYyCL
         dXHYvCgrF7iynra7z0ZzhH7eWAlqTuYHZMgtIuC4OaYgvtwH3MzVAZyOzcuW40HelNRs
         zBXevso0bto4YEEmLsUii8La8tFrVKDMZJ0VrbVSSo+pYdZfrw2N/WUO8XabeStyyLNE
         mqBF6tcMSCEx+o5JSzHi6YbuOyDAdVPn4gMxXkz8Pc5cMN6kI++tRETrtLojEM0n5bgY
         mAul/4LETVVwGygkm5HtfawQUbjgfDpu1nn2JA+eNiNiSz1emH2jwSdpp/sfw6cvimft
         N9dA==
X-Gm-Message-State: AOJu0YzbANr0YtoeHRPQNM9LPnnyUNZS0l86dU9VKPoFlqv69e5AwDKG
	S3cgF3esnetS8Lcq+huBEds=
X-Google-Smtp-Source: AGHT+IFx/KOtyNp+rwbc1cwhJ/nDV1vdBbxBCGXcpklWzuBdLo+Y9rB5znltnx+CmDXr1k5GEZLsFg==
X-Received: by 2002:a2e:9d96:0:b0:2bc:ce85:2de2 with SMTP id c22-20020a2e9d96000000b002bcce852de2mr11119882ljj.37.1693076502852;
        Sat, 26 Aug 2023 12:01:42 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id u26-20020a2e2e1a000000b002ba15c272e8sm902809lju.71.2023.08.26.12.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 12:01:42 -0700 (PDT)
Date: Sat, 26 Aug 2023 22:01:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Feiyang Chen <chenfeiyang@loongson.cn>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 08/10] net: stmmac: move xgmac specific phylink
 caps to dwxgmac2 core
Message-ID: <uw56ervtsa2uoovtsmoidkcfflhnwuv7cgj23qdebag3gry42n@inwwdqlbazg6>
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
 <E1qZAXd-005pUP-JL@rmk-PC.armlinux.org.uk>
 <rpwsyyjdzeixx3f7o3pxeslyff7yc3fuutm436ygjggoyiwjcb@7s3skg627mid>
 <ZOoRiVZiAyf7pArp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOoRiVZiAyf7pArp@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 03:51:53PM +0100, Russell King (Oracle) wrote:
> On Sat, Aug 26, 2023 at 04:32:15PM +0300, Serge Semin wrote:
> > On Thu, Aug 24, 2023 at 02:38:29PM +0100, Russell King (Oracle) wrote:
> > > Move the xgmac specific phylink capabilities to the dwxgmac2 support
> > > core.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 10 ++++++++++
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 ----------
> > >  2 files changed, 10 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > index 34e1b0c3f346..f352be269deb 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > @@ -47,6 +47,14 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
> > >  	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
> > >  }
> > >  
> > > +static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
> > > +{
> > > +	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
> > > +						 MAC_10000FD | MAC_25000FD |
> > > +						 MAC_40000FD | MAC_50000FD |
> > > +						 MAC_100000FD;
> > > +}
> > > +
> > >  static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
> > >  {
> > >  	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
> > > @@ -1490,6 +1498,7 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
> > >  
> > >  const struct stmmac_ops dwxgmac210_ops = {
> > >  	.core_init = dwxgmac2_core_init,
> > 
> > > +	.phylink_get_caps = xgmac_phylink_get_caps,
> > 
> > This doesn't look correct. DW XGMAC doesn't support 25/40/50/100Gbps
> > speeds.
> 
> So the reason this got added is to keep the code compatible with how
> things work today.
> 
> When priv->plat->has_xgmac is true, the old code in stmmac_phy_setup()
> would enable speeds from 2.5G up to 100G, limiting them if
> priv->plat->max_speed is set non-zero.

Indeed. I didn't consider it has been coded like that long before this
discussion.

> 
> The table in hwif.c matches when:
> 	entry->gmac == priv->plat->has_gmac,
> 	entry->gmac4 == priv->plat->has_gmac4 and
> 	entry->xgmac == priv->plat->has_xgmac
> 
> The entries in the table which patch on has_xgmac = true contain the
> following:
> 
>                 .mac = &dwxgmac210_ops,
>                 .mac = &dwxlgmac2_ops,
> 
> Therefore, to keep things compatible, I've effectively moved this
> initialisation into the new .phylink_get_caps method that is part of
> those two ops, and since they have has_xgmac true, this means that
> all these speeds need to be set.
> 
> We do this without regard to max_speed, which we apply separately,
> after the .phylink_get_caps method has returned.
> 
> So, the code is functionally identical to what happens in the driver,
> even if it is the case that xgmac210 doesn't actually support the
> speeds. If those extra speeds that the hardware doesn't support were
> present before, they're present after. If those extra speeds are
> limited by the max_speed, then they will be similarly limited.

> 
> While it may look odd, since the specifications for Synopsys are all
> behind closed doors, all I can do is transform the code - I can't
> know that such-and-such a core doesn't actually support stuff. So
> my only option is to keep the code bug-compatible.
> 

If I see odd things and have no specs at hand I normally dig into the
git log in order to find a respective commit, then get to finding the
corresponding lkml discussion which may have some clue of possible
oddness justification. In this case the problematic part was added in
the commit 8a880936e902 ("net: stmmac: Add XLGMII support"). So before
having the XLGMAC support added the DW XGMAC had had standard speeds
support. Seeing there were no discussion concerning that part of the
code within the review it was very likely wrong to add the higher
speeds support to the DW XMGAC controller. But of course with no
databook at hand it gets to be still an assumption but with high
probability to be true though.

> I think all I've done here is make it glaringly obvious what the old
> code is doing and you've spotted "but that isn't right!" - which is
> actually a good thing!
> 
> Feel free to submit patches to correct the functionality as bugs in
> the driver become more obvious!

I see your point. Ok I'll add such fix to my extensive collection of
the STMMAC driver bug-fixes.) I'll send it out to the community
eventually when I get to have more spare time for review.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

