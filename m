Return-Path: <netdev+bounces-38201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F367B9C18
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 11:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D453281B49
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0410794;
	Thu,  5 Oct 2023 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M0LkLNBP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02620E3
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:16:55 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E102A252
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cDEEYXUhMsvTrOnhl9uoogQe1VpoH6EccOfKxVkkpII=; b=M0LkLNBPuk9jzv2UQDAk8Hz6CK
	zWD3AUsNP36d2ZIGhV3B8TVwLwRVnMBcdfh05vMuuEqyOES87xWT4tKvna9T5WBAPDcrDcwyGifbd
	gAuq3jqHVjRhGGGVZzD2HUsvjUpVqooXFTiYUDFtIuKTKNqnalApVzt30/Awy/a2jGr0+0ub5IuKQ
	jGRQwOknDolkuDJMZaDFhrpTMcYGCc+E9o9JZ+6Mzw4UKWX8mAzNPyINWhNDttRZYlblZNCT4oGgd
	NVGi1RfU6X842mRwVUBYIGfye3oQwJZKcZBqCh46XkiXZQjvw48xHqNrhlReewy2d3tiiMpMKe1n8
	d0znqzpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33938)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qoKTP-0003jh-1m;
	Thu, 05 Oct 2023 10:16:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qoKTQ-0001tL-By; Thu, 05 Oct 2023 10:16:48 +0100
Date: Thu, 5 Oct 2023 10:16:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org
Subject: Re: What is the purpose of the first phylink_validate() call from
 phylink_create()?
Message-ID: <ZR5/ADvrbMKcKBSy@shell.armlinux.org.uk>
References: <20231004222523.p5t2cqaot6irstwq@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004222523.p5t2cqaot6irstwq@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 01:25:23AM +0300, Vladimir Oltean wrote:
> Hi Russell,
> 
> In phylink_create() we have this code which populates pl->supported with
> a maximal link mode configuration and then makes a best-effort attempt
> to reduce it to what the physical port actually supports:
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 3951e5af8cb5..1e89634ec8ae 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1677,10 +1677,6 @@ struct phylink *phylink_create(struct phylink_config *config,
>  	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
>  	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
>  
> -	bitmap_fill(pl->supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
> -	linkmode_copy(pl->link_config.advertising, pl->supported);
> -	phylink_validate(pl, pl->supported, &pl->link_config);
> -
>  	ret = phylink_parse_mode(pl, fwnode);
>  	if (ret < 0) {
>  		kfree(pl);
> 
> However:
> 
> - in MLO_AN_FIXED mode, the later call to phylink_parse_fixedlink() will
>   overwrite this pl->supported and pl->link_config.advertising with
>   another set
> 
> - in MLO_AN_INBAND mode, the later call to phylink_parse_mode() will
>   also overwrite pl->supported and pl->link_config.advertising
> 
> - with a PHY (either in MLO_AN_INBAND or MLO_AN_PHY modes),
>   phylink_bringup_phy() will overwrite pl->supported and
>   pl->link_config.advertising with stuff from the PHY
> 
> Of these 3 cases, phylink_bringup_phy() is the only one which
> potentially does not come immediately after phylink_create().
> So, the effect of the phylink_validate() from phylink_create() will be
> visible only when it's not overwritten, for example when phylink_connect_phy()
> (or one of variants) isn't called at probe time but is delayed until
> ndo_open().
> 
> Since mvneta calls phylink_of_phy_connect() from mvneta_open() and I can
> test that, I'm comparing the "ethtool" output produced before running
> "ip link set dev eth0 up", in 2 cases:
> 
> - With the phylink_validate() from phylink_create() kept in place:
> 
> $ ethtool eth0
> Settings for eth0:
>         Supported ports: [ TP    AUI     MII     FIBRE   BNC     Backplane ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>                                 1000baseKX/Full
>                                 1000baseX/Full
>                                 100baseT1/Full
>                                 1000baseT1/Full
>                                 100baseFX/Half 100baseFX/Full
>                                 10baseT1L/Full
>                                 10baseT1S/Full
>                                 10baseT1S/Half
>                                 10baseT1S_P2MP/Half
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  Not reported
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Half
>         Auto-negotiation: off
>         Port: MII
>         PHYAD: 0
>         Transceiver: internal
>         Supports Wake-on: d
>         Wake-on: d
>         Link detected: no
> 
> - And with it removed (the diff from the beginning):
> 
> $ ethtool eth0
> Settings for eth0:
>         Supported ports: [  ]
>         Supported link modes:   Not reported
>         Supported pause frame use: No
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  Not reported
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Half
>         Auto-negotiation: off
>         Port: MII
>         PHYAD: 0
>         Transceiver: internal
>         Supports Wake-on: d
>         Wake-on: d
>         Link detected: no

You've found the exact reason for it - so that we report something that
seems at least reasonable to userspace, rather than reporting absolutely
nothing which may cause issues.

The original code in mvneta would've done this:

int mvneta_ethtool_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
{
        struct mvneta_port *pp = netdev_priv(dev);

        if (!pp->phy_dev)
                return -ENODEV;

        return phy_ethtool_gset(pp->phy_dev, cmd);
}

Thus making the call fail if the device wasn't up - and that may be
an alternative if we're expecting a PHY but we have none.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

