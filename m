Return-Path: <netdev+bounces-189687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71418AB338C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B918E189E3C6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539E265CCD;
	Mon, 12 May 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvniRrJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BB1A239B;
	Mon, 12 May 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042043; cv=none; b=hxsAojdD7HhhfFdgYLcjV81J9IT+uYjd+ETBCfKLSzU+likjoK060GiMchcsS3eGlVAX2NZeS37CjeOngoom9IDEFqDwcMAGtbm7sehEca/JAs/t/TIZ5bAF0jlEUIvoY/KtTNfECK5KyrDt5IEL5ljmf0z1vZJzw4JKJv2oBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042043; c=relaxed/simple;
	bh=tOe2lgKCbgqYYIMOtKeKhAwAOjWlZcBSaNqvUehU9UQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6p8I+cUU5brPmx9am+fvUELFnNQJAM6vjykXqrSqZPz62tbdwQ3YJoveR2frxla21EhV7gCa6ckDeQtupC19TwIsRsiRrY9Q6hfjFpbFsB7UDvu8VilSefLvnFMo0n5A4RoXsg9yJqax/xiJmm7eOk13tAHb6IyKwUaCads62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvniRrJ1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1d8c09683so2201419f8f.0;
        Mon, 12 May 2025 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747042039; x=1747646839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EP5ciUrJhx2qjL/YTEW+Ro+6nfUBpD7HupJKLYyZ5WU=;
        b=HvniRrJ1lLMp75VJvD7FHd4Z30I4++nF6Eg8lJY6u8S2cem1NWxRyzeLjPyEuVx3WO
         oqA0i9EPDPWk5CXYq2Ju/A0hyXrgs+Cq6XP3rXumIlmXBHIQQB9i2FOUnlGt2icLm3RI
         2kmjgLKPBxDuG3qLblWSqaruZl2HkOjhkjutbL6t+l7rfhzSAYvAll3pfYdMXXyXPuxV
         31mmNsoDskGhZgXFUwEKDSP0dgL2wY5YTXMYZrihdKYtAf5cFSfiQTGEo0+B0eNJfRfG
         NbjlHtgng97hz75t/FXNk3fliV21FJk4EJlfzE5vIPZJXdNhJtlTtAZxCb1aIaHfcnys
         nTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747042039; x=1747646839;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP5ciUrJhx2qjL/YTEW+Ro+6nfUBpD7HupJKLYyZ5WU=;
        b=i0CtRlaaPSeu2DXST+OALX2fRF9wPZHNok6YbNU/43tWrXgQOaUwMjKyC3sE7m8rH5
         1QD0S+iJQLwY9xDRpCytFpWNU4322/r2mRLrdIdwHFVMHS/sMj9LBAJfZgMweHzTtigD
         gb7yZKPXC2YqKbEp01qnSslQcYm9l5gKdBZ+/GW2AWtiyelRwgZoe7OD6/IdEviNPZk8
         TsXNkdlXqwHBAcqIg+39f519hgbDRgniOAgCFWkHJ7c+R5PbnskVEdE+VDiayjDL3eQC
         i5LxhyeY0s3jPI14ABcF2LlvmbSlzKQypeKxMWh2BO+txHhcx136534pqhkI8Cls5MqP
         j2jg==
X-Forwarded-Encrypted: i=1; AJvYcCXYeX0Bl7w0zL+ZWRkJ+TVnD9c94RaHtpvaPejwYcXKK/nEf5lHKPmCUXmDEo9NBt5ahXNlprIHzT55nUb6@vger.kernel.org, AJvYcCXbnIM24LBRn5XXUyM3JPlbh/S0F93wF7rMSIJUaqH6HTFZhoKFhraVIP3P55s3IWZ6lXtq0rPcwTBY@vger.kernel.org, AJvYcCXyZhrxQDtub657LQnRja1DDTJ5jTVEeo/KbrT+vTTAvqqAZorCr7rN/PhsLbyHnk+X0LLiS9At@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQcvm3F3aZJbkBdLaBSicRRYZA9DaJ2tP6/1PY+sKfopWuftq
	JmxqHqk2RIzEZkhtnAHXKMU8mCqMoEek+rpxo1Qw6pUNHpBJ9EmO
X-Gm-Gg: ASbGncvNe/QlmdneEIkqDU55TsFN21KHlcI1bdCme56IuIlXPBWjHfLzQAInwpZErpJ
	G8rCA76oEh84i2Q4DcQw+A/zfPzJ6Ewl8hqNbYdstItRP7cuRdeOkZLImv98GWmq7TaK0owWyV7
	85W13wo2MYGbHukVaj8iLoqy1AcVRZUjMfLs9o7xBIoNWrNt/g1rGm7KG2iayqo3dGlK8BxRX+C
	pYEn0EYSJQvsAVmdJn75xodLaH6hMXNJ7rFPZTlXf9EHvSyFjRRK0SJxJXQiUgpMqOFFsSO7QJ3
	P5U5SnpSbfqYUX38eCLvE1TIr/C150HtP5MZghYvygyLcz5AQPB7vy/p+RZjpy7ya4fEurvmLie
	ItsgTc7k=
X-Google-Smtp-Source: AGHT+IEIx2dngjb6axDv4lWuQJCqhwKHcwmf+wk9ypXMGeGlR42a1KIrb2TLCO+LYY/WGRgWY7SQ1Q==
X-Received: by 2002:a05:6000:430d:b0:3a0:b378:a4eb with SMTP id ffacd0b85a97d-3a1f6487e1amr9306477f8f.40.1747042038492;
        Mon, 12 May 2025 02:27:18 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d96csm11933224f8f.69.2025.05.12.02.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:27:17 -0700 (PDT)
Message-ID: <6821bef5.5d0a0220.319347.d533@mx.google.com>
X-Google-Original-Message-ID: <aCG-8mJYlQoa_4ls@Ansuel-XPS.>
Date: Mon, 12 May 2025 11:27:14 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [net-next PATCH v4 11/11] net: airoha: add phylink support for
 GDM2/3/4
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-12-ansuelsmth@gmail.com>
 <aCG9q6i7HomgilI6@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCG9q6i7HomgilI6@lore-desk>

On Mon, May 12, 2025 at 11:21:47AM +0200, Lorenzo Bianconi wrote:
> > Add phylink support for GDM2/3/4 port that require configuration of the
> > PCS to make the external PHY or attached SFP cage work.
> > 
> > These needs to be defined in the GDM port node using the pcs-handle
> > property.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c  | 155 +++++++++++++++++++++-
> >  drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
> >  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
> >  3 files changed, 169 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > index 16c7896f931f..3be1ae077a76 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/of_net.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/tcp.h>
> > +#include <linux/pcs/pcs.h>
> >  #include <linux/u64_stats_sync.h>
> >  #include <net/dst_metadata.h>
> >  #include <net/page_pool/helpers.h>
> > @@ -79,6 +80,11 @@ static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
> >  	return port->id == 1;
> >  }
> >  
> > +static bool airhoa_is_phy_external(struct airoha_gdm_port *port)
> > +{
> > +	return port->id != 1;
> > +}
> > +
> >  static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
> >  {
> >  	struct airoha_eth *eth = port->qdma->eth;
> > @@ -1613,6 +1619,17 @@ static int airoha_dev_open(struct net_device *dev)
> >  	struct airoha_gdm_port *port = netdev_priv(dev);
> >  	struct airoha_qdma *qdma = port->qdma;
> >  
> > +	if (airhoa_is_phy_external(port)) {
> > +		err = phylink_of_phy_connect(port->phylink, dev->dev.of_node, 0);
> 
> nit: even if it is not strictly required, in order to align with the rest of the
> codebase, can you please stay below 79 columns?
> 
> > +		if (err) {
> > +			netdev_err(dev, "%s: could not attach PHY: %d\n", __func__,
> > +				   err);
> 
> same here
> 
> > +			return err;
> > +		}
> > +
> > +		phylink_start(port->phylink);
> > +	}
> > +
> >  	netif_tx_start_all_queues(dev);
> >  	err = airoha_set_vip_for_gdm_port(port, true);
> >  	if (err)
> > @@ -1665,6 +1682,11 @@ static int airoha_dev_stop(struct net_device *dev)
> >  		}
> >  	}
> >  
> > +	if (airhoa_is_phy_external(port)) {
> > +		phylink_stop(port->phylink);
> > +		phylink_disconnect_phy(port->phylink);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2795,6 +2817,115 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
> >  	return false;
> >  }
> >  
> > +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> > +			       unsigned int mode, phy_interface_t interface,
> > +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> 
> ditto.
> 
> > +{
> > +	struct airoha_gdm_port *port = container_of(config, struct airoha_gdm_port,
> > +						    phylink_config);
> 
> ditto.
> 
> > +	struct airoha_qdma *qdma = port->qdma;
> > +	struct airoha_eth *eth = qdma->eth;
> > +	u32 frag_size_tx, frag_size_rx;
> > +
> > +	if (port->id != 4)
> > +		return;
> > +
> > +	switch (speed) {
> > +	case SPEED_10000:
> > +	case SPEED_5000:
> > +		frag_size_tx = 8;
> > +		frag_size_rx = 8;
> > +		break;
> > +	case SPEED_2500:
> > +		frag_size_tx = 2;
> > +		frag_size_rx = 1;
> > +		break;
> > +	default:
> > +		frag_size_tx = 1;
> > +		frag_size_rx = 0;
> > +	}
> > +
> > +	/* Configure TX/RX frag based on speed */
> > +	airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG,
> > +		      GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> > +		      FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> > +				 frag_size_tx));
> > +
> > +	airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG,
> > +		      GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> > +		      FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> > +				 frag_size_rx));
> > +}
> > +
> > +static const struct phylink_mac_ops airoha_phylink_ops = {
> > +	.mac_link_up = airoha_mac_link_up,
> > +};
> > +
> > +static int airoha_setup_phylink(struct net_device *dev)
> > +{
> > +	struct airoha_gdm_port *port = netdev_priv(dev);
> > +	struct device_node *np = dev->dev.of_node;
> > +	struct phylink_pcs **available_pcs;
> > +	phy_interface_t phy_mode;
> > +	struct phylink *phylink;
> > +	unsigned int num_pcs;
> > +	int err;
> > +
> > +	err = of_get_phy_mode(np, &phy_mode);
> > +	if (err) {
> > +		dev_err(&dev->dev, "incorrect phy-mode\n");
> > +		return err;
> > +	}
> > +
> > +	port->phylink_config.dev = &dev->dev;
> > +	port->phylink_config.type = PHYLINK_NETDEV;
> > +	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +						MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD |
> > +						MAC_5000FD | MAC_10000FD;
> 
> over 79 columns
> 
> > +
> > +	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), NULL, &num_pcs);
> > +	if (err)
> > +		return err;
> > +
> > +	available_pcs = kcalloc(num_pcs, sizeof(*available_pcs), GFP_KERNEL);
> 
> I guess you can use devm_kcalloc() and get rid of kfree() here.
>

I forgot to answer to this in the previous revision. No devm can't be
used there available_pcs is just an array allocated for phylink_config.

Phylink then copy the data in it and doesn't use it anymore hence it
just needs to be allocated here and doesn't need to stay till the driver
gets removed.

> > +	if (!available_pcs)
> > +		return -ENOMEM;
> > +
> > +	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), available_pcs,
> > +				       &num_pcs);
> > +	if (err)
> > +		goto out;
> > +
> > +	port->phylink_config.available_pcs = available_pcs;
> > +	port->phylink_config.num_available_pcs = num_pcs;
> > +
> > +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> > +		  port->phylink_config.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > +		  port->phylink_config.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +		  port->phylink_config.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> > +		  port->phylink_config.supported_interfaces);
> > +
> > +	phy_interface_copy(port->phylink_config.pcs_interfaces,
> > +			   port->phylink_config.supported_interfaces);
> > +
> > +	phylink = phylink_create(&port->phylink_config,
> > +				 of_fwnode_handle(np),
> > +				 phy_mode, &airoha_phylink_ops);
> > +	if (IS_ERR(phylink)) {
> > +		err = PTR_ERR(phylink);
> > +		goto out;
> > +	}
> > +
> > +	port->phylink = phylink;
> > +out:
> > +	kfree(available_pcs);
> > +
> > +	return err;
> > +}
> > +
> >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> >  				 struct device_node *np, int index)
> >  {
> > @@ -2873,7 +3004,23 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> >  	if (err)
> >  		return err;
> >  
> > -	return register_netdev(dev);
> > +	if (airhoa_is_phy_external(port)) {
> > +		err = airoha_setup_phylink(dev);
> 
> This will re-introduce the issue reported here:
> https://lore.kernel.org/netdev/5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr/
> 

I'm confused about this. The suggestion wasn't that register_netdev
might fail and I need to destroy phylink? Or the linked patch was merged
and I need to rebase on top of net-next?

I didn't include that change to not cause conflicts but once it's merged
I will rebase and include that fix.

> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	err = register_netdev(dev);
> > +	if (err)
> > +		goto free_phylink;
> > +
> > +	return 0;
> > +
> > +free_phylink:
> > +	if (airhoa_is_phy_external(port))
> > +		phylink_destroy(port->phylink);
> > +
> > +	return err;
> >  }
> >  
> >  static int airoha_probe(struct platform_device *pdev)
> > @@ -2967,6 +3114,9 @@ static int airoha_probe(struct platform_device *pdev)
> >  		struct airoha_gdm_port *port = eth->ports[i];
> >  
> >  		if (port && port->dev->reg_state == NETREG_REGISTERED) {
> > +			if (airhoa_is_phy_external(port))
> > +				phylink_destroy(port->phylink);
> > +
> >  			unregister_netdev(port->dev);
> >  			airoha_metadata_dst_free(port);
> >  		}
> > @@ -2994,6 +3144,9 @@ static void airoha_remove(struct platform_device *pdev)
> >  			continue;
> >  
> >  		airoha_dev_stop(port->dev);
> > +		if (airhoa_is_phy_external(port))
> > +			phylink_destroy(port->phylink);
> > +
> >  		unregister_netdev(port->dev);
> >  		airoha_metadata_dst_free(port);
> >  	}
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> > index 53f39083a8b0..73a500474076 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -498,6 +498,9 @@ struct airoha_gdm_port {
> >  	struct net_device *dev;
> >  	int id;
> >  
> > +	struct phylink *phylink;
> > +	struct phylink_config phylink_config;
> > +
> >  	struct airoha_hw_stats stats;
> >  
> >  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> > diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
> > index d931530fc96f..54f7079b28b0 100644
> > --- a/drivers/net/ethernet/airoha/airoha_regs.h
> > +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> > @@ -357,6 +357,18 @@
> >  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
> >  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> >  
> > +#define REG_GDMA4_TMBI_FRAG		0x2028
> > +#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> > +#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > +#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> > +#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > +
> > +#define REG_GDMA4_RMBI_FRAG		0x202c
> > +#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> > +#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > +#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> > +#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > +
> >  #define REG_MC_VLAN_EN			0x2100
> >  #define MC_VLAN_EN_MASK			BIT(0)
> >  
> > -- 
> > 2.48.1
> > 



-- 
	Ansuel

