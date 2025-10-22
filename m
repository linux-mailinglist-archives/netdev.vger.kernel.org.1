Return-Path: <netdev+bounces-231710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA365BFCFA3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C968E354B3F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64950253356;
	Wed, 22 Oct 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieo4gqk/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870224CEE8
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148334; cv=none; b=UY8LlbVSueGRGt0NuelOQi85txZfT7oGCmb2oK5S6ug6/Ja7PoWt3sH3GeBeY0Ea51/iaaM9rblQUlUj0Yn+4t0vyoOcU60/vrPK4pTmCnb3yOe3RxGdjy1M73aFffv1J49mD4LL5qdBk6vzsrS4Jm2EbdvXP8+8BixuI6rmzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148334; c=relaxed/simple;
	bh=M2ad4TNbqndSNU6O9h8RDvtINbP3SwSMD9zdf7PJ/kE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMhXjavgIR8Y15dJl/YtYdtFBMwJEcB9xpp2RM2GyrXu8sjOG0mWbIVamqFakH4IUUde/l3igCkH+zgSSjPgNvffaBLb2b4WhNRkKDCZMWcmq1MEM1hJL20JbF8qeroQ0k+sHVaSs0/oS5nybZW3aaDvhtPeyZ5VpIyxJ2/iOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieo4gqk/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47117e75258so36492565e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148329; x=1761753129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g5kr/bQI82p4aOoVx3CaPnWuXCBcZLFYX+TGL7tLi7A=;
        b=ieo4gqk/ezt/NQKIRYTfCey9E2IEWA0CMN3eXndRKhikzxwDhZ+BG2cz0cdRsEGtiY
         2DgbzUXfRytZXFQlwsTzVD359XPFGKHZB7Im+bhbDTOU3ho2Hk5NX7MY2Y89pCZcmewV
         WwlyDqJiAwGl0+7rx7qmh5ECjFUPyL/Npf/wE3KGliaTbUIT0vIE9b8qebqF5z9QzKSd
         DaiG91G4QETwwdkD8empu3Yehmi/Xv3W5W879N8JKKcAqus3QNNo3pVYO9viiMZV/onm
         TXTq/5m03J4aewn9iahL4EUhwQKY0mr0yvLo97p1syLnScMY3EjtLiaiBqFDWKb5OvJL
         joMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148329; x=1761753129;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5kr/bQI82p4aOoVx3CaPnWuXCBcZLFYX+TGL7tLi7A=;
        b=tRBgm8r6515pOXoAr3uz4uWD2dXhBd2VfIOav3zdhMo5EOw/JIw/2RhpMF2MqWsufX
         6igwdYhGCXGsHZOL/Af/QljYhfVCr6XkjIgH3bk28Wx20Yj7bgPfvHHeCHKG3DZeCmYg
         x7heYQB39a3LLq1YQnTs12UzzsYffghSwEXl07HDYierrjAP3oCTvqjxvY2r20vZVVV7
         WLjiEs2gu3ZpEXe92qw0oB+rh1CJ1YBEEvEVVvhSulNzeEWhvgoslmsVo5nhyf9vYx+v
         VLB5vvFRgNtJjdmktT2UTvxGrClmGmpZrGj4zy6XrUs8GATCFOjk+WhUNOydz7hBAvE+
         WL0A==
X-Forwarded-Encrypted: i=1; AJvYcCVYzwioHKg+AVuwUCQZKHnR50gH9XPYkQehyaLAH72/GiAaGWN2yNWGJXJBzL6AqlkSnbC95Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnshOL4ekdO21IeCwPUIgARLKomyMv3OoUfaPlSI/reSn0zFB8
	IPbTcEplLJzFBtvNlBMgiTKvcyxfp6w+HIKrkCv9/95RayZuqL+HUgVy
X-Gm-Gg: ASbGncsOUMr0n8GaTEx8LLB5yHSlt7BPW5fIN9MuhNtodkvfTqSI13R1JhX86hOWjUM
	lYXIQM/amYtfgMJSyGgtNaHayFpWPpjJnwEcb4S4eaXo2ZfHiiaMs/cnhPNdd55LlAPc/Xq/mGn
	OIEGi+4X+6cyc77YThLUT8mGIjAdd2fEUp1GQHV3l0Ok6cfOxoJowb4fxr6MNAX3U8oICXGMhHe
	PnXSEJcWaq+M9TfryXPe3V4PZJam7+tfuD7MBV1YUhbds7QRmoCpsrggRCu4fPbKcmOukwUjGVK
	XSgGcoNvXJx7FfdJqxtGpZlinNQImTlATdpZNMldduALiR6uWwg73p71JXmeTmLYuu9Hchgrjak
	PgPjxYuxeklfaN+OJgLDId8SjSyJLkgegwTLrUxJcluf64dMODZpa+9b9jD+qSOGZIF1qpOn7M2
	p3LTmpcUGI0UwzTbt9tfEg1OEqdcfNHdnKJTtXk/4q8ZVFXtJJgw==
X-Google-Smtp-Source: AGHT+IF2VkMFb1grUIsz9Ob5/VnZ+J8LZJM9Q4gOUJAoOT2z3iABDCrdKLQP3lhX3uW6IN4Sf6xW5Q==
X-Received: by 2002:a05:600c:8b0d:b0:46e:39e1:fc27 with SMTP id 5b1f17b1804b1-4711787442amr156532835e9.5.1761148329287;
        Wed, 22 Oct 2025 08:52:09 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm26175138f8f.31.2025.10.22.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:52:08 -0700 (PDT)
Message-ID: <68f8fda8.5d0a0220.3519eb.41e3@mx.google.com>
X-Google-Original-Message-ID: <aPj9phaGLkU3JMm3@Ansuel-XPS.>
Date: Wed, 22 Oct 2025 17:52:06 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: airoha: add phylink support for GDM1
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
 <20251021193315.2192359-3-ansuelsmth@gmail.com>
 <2a9e1ecc-2f33-432b-bf77-e08ce7ccd0ce@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a9e1ecc-2f33-432b-bf77-e08ce7ccd0ce@bootlin.com>

On Wed, Oct 22, 2025 at 09:42:11AM +0200, Maxime Chevallier wrote:
> Hi Christian,
> 
> On 21/10/2025 21:33, Christian Marangi wrote:
> > In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
> > that is an INTERNAL port for the Embedded Switch.
> > 
> > Rework the GDM init logic by first preparing the struct with all the
> > required info and creating the phylink interface and only after the
> > parsing register the related netdev.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 108 ++++++++++++++++++++---
> >  drivers/net/ethernet/airoha/airoha_eth.h |   3 +
> >  2 files changed, 99 insertions(+), 12 deletions(-)
> 
> You also need to select PHYLINK in Kconfig
> 
> > 
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > index ce6d13b10e27..fc237775a998 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1613,6 +1613,8 @@ static int airoha_dev_open(struct net_device *dev)
> >  	struct airoha_gdm_port *port = netdev_priv(dev);
> >  	struct airoha_qdma *qdma = port->qdma;
> >  
> > +	phylink_start(port->phylink);
> > +
> >  	netif_tx_start_all_queues(dev);
> >  	err = airoha_set_vip_for_gdm_port(port, true);
> >  	if (err)
> > @@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
> >  		}
> >  	}
> >  
> > +	phylink_stop(port->phylink);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2813,6 +2817,17 @@ static const struct ethtool_ops airoha_ethtool_ops = {
> >  	.get_link		= ethtool_op_get_link,
> >  };
> >  
> > +static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
> > +							 phy_interface_t interface)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
> > +			      const struct phylink_link_state *state)
> > +{
> > +}
> > +
> >  static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
> >  {
> >  	int i;
> > @@ -2857,6 +2872,55 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
> >  	return false;
> >  }
> >  
> > +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> > +			       unsigned int mode, phy_interface_t interface,
> > +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +}
> > +
> > +static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
> > +				 phy_interface_t interface)
> > +{
> > +}
> > +
> > +static const struct phylink_mac_ops airoha_phylink_ops = {
> > +	.mac_select_pcs = airoha_phylink_mac_select_pcs,
> > +	.mac_config = airoha_mac_config,
> > +	.mac_link_up = airoha_mac_link_up,
> > +	.mac_link_down = airoha_mac_link_down,
> > +};
> > +
> > +static int airoha_setup_phylink(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_port *port = netdev_priv(netdev);
> > +	struct device *dev = &netdev->dev;
> > +	phy_interface_t phy_mode;
> > +	struct phylink *phylink;
> > +
> > +	phy_mode = device_get_phy_mode(dev);
> > +	if (phy_mode < 0) {
> > +		dev_err(dev, "incorrect phy-mode\n");
> > +		return phy_mode;
> > +	}
> > +
> > +	port->phylink_config.dev = dev;
> > +	port->phylink_config.type = PHYLINK_NETDEV;
> > +	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +						MAC_10000FD;
> > +
> > +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +		  port->phylink_config.supported_interfaces);
> > +
> > +	phylink = phylink_create(&port->phylink_config, dev_fwnode(dev),
> > +				 phy_mode, &airoha_phylink_ops);
> > +	if (IS_ERR(phylink))
> > +		return PTR_ERR(phylink);
> > +
> > +	port->phylink = phylink;
> > +
> > +	return 0;
> > +}
> > +
> >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> >  				 struct device_node *np, int index)
> >  {
> > @@ -2931,19 +2995,30 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> >  	port->id = id;
> >  	eth->ports[p] = port;
> >  
> > -	err = airoha_metadata_dst_alloc(port);
> > -	if (err)
> > -		return err;
> > +	return airoha_metadata_dst_alloc(port);
> > +}
> >  
> > -	err = register_netdev(dev);
> > -	if (err)
> > -		goto free_metadata_dst;
> > +static int airoha_register_gdm_ports(struct airoha_eth *eth)
> > +{
> > +	int i;
> >  
> > -	return 0;
> > +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> > +		struct airoha_gdm_port *port = eth->ports[i];
> > +		int err;
> >  
> > -free_metadata_dst:
> > -	airoha_metadata_dst_free(port);
> > -	return err;
> > +		if (!port)
> > +			continue;
> > +
> > +		err = airoha_setup_phylink(port->dev);
> > +		if (err)
> > +			return err;
> > +
> > +		err = register_netdev(port->dev);
> > +		if (err)
> > +			return err;
> 
> The cleanup for that path seems to only be done if
> 
>   port->dev->reg_state == NETREG_REGISTERED
> 
> So if netdev registration fails here, you'll never destroy
> the phylink instance :(
> 

Oh ok I was with the (wrong) assumption that register_netdev always set
the state to REGISTERED but checking the actual function it's totally
not the case.

Wonder if there is a better method to check it but I guess making the
requested changed from Lorenzo should indirectly handle this BUG.

> 
> 

-- 
	Ansuel

