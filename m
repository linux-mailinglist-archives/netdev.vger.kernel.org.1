Return-Path: <netdev+bounces-234353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0868C1F96E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96464646A9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CF5350D7F;
	Thu, 30 Oct 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtZlMuIi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AD3546EC
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820510; cv=none; b=ky/qRU/PrDGML4ROYfJT8ApgmyCiE96qRHM0EC5SSVxgz6BO5SUKvWbDYzJ77x5qlDeAUY6obJSZ20a5JvES77miMoWl5cy0CLXYzW2UZa0/H4UobWCDiw7aRD0h+yOvVwiiIVaVSGPZJRxA43lR41skfLyUgRslPghY60o6ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820510; c=relaxed/simple;
	bh=SZ6e+WXbvMDAvZNixEY7qjyYrMagzCDzDbDS4AZsWI8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQpnr7SsiN595bBZ9POOo5QlZKW+4sSr95XNxyPdQRxAyoh7gk5Fn7ys2MOe1MrBKFLTc54/vXesjrkPhTEPWTBFM86dNiBYWvr/l4fKGjupR1diCBwlh6vo6LrRZAJqZCqWJ38IpraheG81c+21hmOdf8WQdOytkCq7fVqNS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtZlMuIi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so883963f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761820507; x=1762425307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsPngKrFqfEFSGok7TSQm60g/euZJ7JcyyRZuGnNgBg=;
        b=KtZlMuIif2oarcFs92tXATxx4V7/B2kyFZnLCbwukioJ/zxndUSBEBo+k1Wia0WfFX
         HaJ0gSTUZL/8E2nlm3Uz2Bcc+0guuxaWWbvq+AbCx/YVpubmOu1xJuU5vgayPMBP04UI
         fxwqLaiR0GyH1jiVtsctCLh2zRhwEBLdy4ItGg7AnRed31i+lTkjmyBbzsJy2v97l+qE
         rmukQ50y6al50QS56HjIa3APOp6ThaP6Y2l+EbMqmCoMxYP7yV5V/5AFO++69v+yEWFt
         ac5Vtg+7zxyZqjS400+SKvbJ5wmK6mVwu7iuAKsi9kF6nQloDKaiNUROEq+D8WN0D2MX
         tX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820507; x=1762425307;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsPngKrFqfEFSGok7TSQm60g/euZJ7JcyyRZuGnNgBg=;
        b=CtYu4KqsiRqML1xxinA7UWXAkVQxfOD0ZH/w5BgUBXntedO/Brn3vfx7NWJJ1chE+J
         i5nqHNeXujKGF9g3nwvykD3VowNrqbXZiFGtyd7MwEa3yUq3STBQEm7PBSAtmTvsG8SE
         epAkrb8P1nBEVLB//BjSwaa5jYMSU3H5U8Rl/9mP645OpDKdoPIpxfuUl+nh5PCioJct
         0Ndz+QvoId0+NunySRma5c7kgZE3Mjfrwtv4EcZ/PYcJq2mqveBp66Ph+2NoEKULEgCU
         FijqeS9pbYKzG1ADQe6JzHKmkfw0hP+d5A72opOg1Qp3UhEpdzxyOGGHEFi2oynNcYT4
         K9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUE6uu08DSSfU9iOgmWh+DrlboaAG4jdYgEa2lvxVjO3REcfKlDQ65zfF/TPIiE5tkNV+IzpyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHmn6pATUPBw/WCnyGwf4vcmy2AySk+cPtwBcnnAsBxly0ccP
	rvt4yyjimKTcj77dklmXyttBnbB1nShhjqXTaHr0vxXUEZlQDafYusWm
X-Gm-Gg: ASbGncvlhOqs9xHiLtJ9GBcVncqYeWCFdiqVfnDdkLIO/XnMDKOyxzmmtqvO4HbxSdS
	uqFjJV6LLVxW3q4AYiWtRQEoe7YJqRwChA+HeQgSzALQwVfkkn9ynt5QPkFjBkP804wJjGBhEcX
	aFRgwMQN9VEkv9S8TYZ8OMWx7p+LGHgKO2QxzzCKvNq7gkd7MdJUDWl5zUWA8QcT4hCpUHzld89
	ETF3Rb4nBQiBqEFOdIATAig6bkGOWE5Ozom2vcGJjMj1P4qTGdbfJiXJoiuDkMlokHZnzXV5F5h
	/nOTvb47nsTm2CLP2xWWhvFFWwUsD+U4iY4U0EKcIrywGUXO/PeAT4jCvIrb8k1tUtOGS65OPoN
	vP2YZGksOvGFuJuTA+6Dn/FADIUhcxfuWdXiBZ4k5rNBXY69jKJj4y+LH4UZqUBg+n0AFO+35tV
	BG5khRlXd5PHoVs/a1VFKVAKKZPDgW
X-Google-Smtp-Source: AGHT+IESaUzzzN97jkFB4AyHPl8jIeK4DpYfr+xMeimLxz4XvTZuV9U4wyHB6rScPa52l5uDwp+EVw==
X-Received: by 2002:a05:6000:2c05:b0:428:3e7f:88c3 with SMTP id ffacd0b85a97d-429b4c9ee77mr2317234f8f.50.1761820506460;
        Thu, 30 Oct 2025 03:35:06 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm31832354f8f.21.2025.10.30.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:35:06 -0700 (PDT)
Message-ID: <69033f5a.df0a0220.25fede.548f@mx.google.com>
X-Google-Original-Message-ID: <aQM_WCsuEDykB4e1@Ansuel-XPS.>
Date: Thu, 30 Oct 2025 11:35:04 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/2] net: airoha: add phylink support for GDM1
References: <20251023145850.28459-1-ansuelsmth@gmail.com>
 <20251023145850.28459-3-ansuelsmth@gmail.com>
 <aP00w4CQdeX9GIJA@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP00w4CQdeX9GIJA@shell.armlinux.org.uk>

On Sat, Oct 25, 2025 at 09:36:19PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 23, 2025 at 04:58:49PM +0200, Christian Marangi wrote:
> > In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
> > that is an INTERNAL port for the Embedded Switch.
> > 
> > Add all the phylink start/stop and fill in the MAC capabilities and the
> > internal interface as the supported interface.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/Kconfig      |  1 +
> >  drivers/net/ethernet/airoha/airoha_eth.c | 77 +++++++++++++++++++++++-
> >  drivers/net/ethernet/airoha/airoha_eth.h |  3 +
> >  3 files changed, 80 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
> > index ad3ce501e7a5..3c74438bc8a0 100644
> > --- a/drivers/net/ethernet/airoha/Kconfig
> > +++ b/drivers/net/ethernet/airoha/Kconfig
> > @@ -2,6 +2,7 @@
> >  config NET_VENDOR_AIROHA
> >  	bool "Airoha devices"
> >  	depends on ARCH_AIROHA || COMPILE_TEST
> > +	select PHYLIB
> 
> This looks wrong if you're using phylink.
> 
> >  	help
> >  	  If you have a Airoha SoC with ethernet, say Y.
> >  
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > index ce6d13b10e27..deba909104bb 100644
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
> 
> phylink_start() _can_ bring the carrier up immediately. Is the netdev
> ready to start operating at the point phylink_start() has been called?
> This error handling suggests the answer is "no", and the lack of
> phylink_stop() in the error path is also a red flag.
>

So I guess the correct way is to move start at the very end of dev_open.

> > @@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
> >  		}
> >  	}
> >  
> > +	phylink_stop(port->phylink);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2813,6 +2817,18 @@ static const struct ethtool_ops airoha_ethtool_ops = {
> >  	.get_link		= ethtool_op_get_link,
> >  };
> >  
> > +static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
> > +			phy_interface_t interface)
> 
> I'd write this as:
> 
> static struct phylink_pcs *
> airoha_phylink_mac_select_pcs(struct phylink_config *config,
> 			      phy_interface_t interface)
> 
> but:
> 
> > +{
> > +	return NULL;
> > +}
> 
> Not sure what the point of this is, as this will be the effect if
> this function is not provided.
> 

Sorry I was confused with the other OPs that are mandatory or a kernel
panic is triggered if not defined. (for example the MAC config)

> > +
> > +static void airoha_mac_config(struct phylink_config *config,
> > +			      unsigned int mode,
> > +			      const struct phylink_link_state *state)
> > +{
> > +}
> > +
> >  static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
> >  {
> >  	int i;
> > @@ -2857,6 +2873,57 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
> >  	return false;
> >  }
> >  
> > +static void airoha_mac_link_up(struct phylink_config *config,
> > +			       struct phy_device *phy, unsigned int mode,
> > +			       phy_interface_t interface, int speed,
> > +			       int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +}
> > +
> > +static void airoha_mac_link_down(struct phylink_config *config,
> > +				 unsigned int mode, phy_interface_t interface)
> > +{
> > +}
> > +
> > +static const struct phylink_mac_ops airoha_phylink_ops = {
> > +	.mac_select_pcs = airoha_phylink_mac_select_pcs,
> > +	.mac_config = airoha_mac_config,
> > +	.mac_link_up = airoha_mac_link_up,
> > +	.mac_link_down = airoha_mac_link_down,
> > +};
> 
> All the called methods are entirely empty, meaning that anything that
> phylink reports may not reflect what is going on with the device.
> 
> Is there a plan to implement these methods?
> 

Yes. For the internal port there isn't much to configure but when the
PCS for the other GDM port will be implemented, those will be filled in.
This is really to implement the generic part and prevent having a
massive series later (as it will be already quite big and if not more
than 10-12 patch)

Hope it's understandable why all these empty functions.

-- 
	Ansuel

