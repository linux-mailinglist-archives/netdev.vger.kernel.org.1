Return-Path: <netdev+bounces-101360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9648FE431
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C151F25528
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD6194A74;
	Thu,  6 Jun 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1QzHfej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580614A63D;
	Thu,  6 Jun 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669462; cv=none; b=kWFbnpKPvi4kbTOr+D7Lr/DrwgN1snpFSspyvQEV1nkLWHAV7mQjIbtHpMsMW1xL1j94VRem9MNCi+sMZqXzhq5VvyioVyTFEDL1aBcKkwM+Jj/jWbDEPq3Sp3D8uc4Id1iYc59L4vcsJbRu5n/7SIJiPCyjQ3Ngk9OX+SKBgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669462; c=relaxed/simple;
	bh=jXP98eqTfqlOOkOkRS3yoSSeqjWdml2lIS+e5MX9x9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvEIwkIy4ZME1wZFZ1A++fjElP82+gz1fy9RcbsmBfmTL8AN19NLpdFqLKSJpZ77uT6wjH+80RKTXASsx4iwW59J3RSzG3LDwikfpaehHeWmgKkUFeX3aRNcymijYQo0IV8iCWVS+ORmVGIO5B4HgQVRZiSh7nUVVOUDQHQ3MEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1QzHfej; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b894021cbso1062500e87.0;
        Thu, 06 Jun 2024 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717669459; x=1718274259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4WnoT1fe4t4g6laaxr/UqBSAP7voCUP3G6EsC2u08s=;
        b=h1QzHfejJpeDBZyXNvTCjxf8M68khwT6VqL6PEnLvBCMeKVffipgbf1+NOMJ7YA+4Q
         imh0TrWLALSMm92BqsOYF17SmpIXr6OP3pTaFuy89YtmBt4SAPRV6r+tmY9blWvOodoE
         wZMb/+WKG3NKNjpwGZBBENyCzqToP2mej4QjQ9TMgn7BR7rNmAgvGQuI6fU+uGhrcdJU
         X6FFKKoqsw4jHdCgpFJqbEUQtTjUOT5Lq0PghUVgqx/u4mxeMTxgBjk2iucy61Ht8GCE
         tM0Ma1k0EyYe8p1vH6dlyG/VlD6TeRVUnyWeCuMu20DVspgA/aeALSsWp/4LmD46SG0b
         pN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717669459; x=1718274259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4WnoT1fe4t4g6laaxr/UqBSAP7voCUP3G6EsC2u08s=;
        b=KS0R5esXjHvQiD7ccL/s4Oo5cO6foHWhIUOYCr20M35J8jJRQL813fORcuG+kJd4Sq
         51teCV1hpTiowcuuk1MirktGpslYziyeTHZFdrTVs5mxKY/C9RvVI81R8w1unRcWMRTZ
         43Y/ID4MDqZ6dCmu6qWOU8vCOhr5Xog2rVQ5heRjm4dg8rFxDf4Dy2LV3X5gyiTrdX+g
         kKQ/xiFgfYFZVLOChrVBS5lnxrdGnhHu/MQ/ifFdU1aESxkNFXru3vvMEVtaGvs+PUNn
         eq8wad9XqW+wRXHNhWqSZh3m6bO0Gs3erulAubUzapQyoMo+BoWV6b0bVHprrKSIb8VS
         erNw==
X-Forwarded-Encrypted: i=1; AJvYcCW0g3EAS4km2v0Sq6PyXDgTTUjV+HoVpZQGWBZ7wvTlRjKiAp1A4bkQ8esLqkZz3KOqLUVzrAt9wFVQ7l9v/HOJn3USP//t7uwUhB9SdN/urh5jTUMR7I+C92aYsbYmRNQPCn3zm7WlBzpE/4avwxKCtp33w6SeDTRagZYWWiJehg==
X-Gm-Message-State: AOJu0YyP3ByC4TeJR0UeCtj5lIcXU0IE1wVr5in5O1LZOxWiOe/S8xGI
	GPci8GFqK9gTyV464/9PSZWO3Xxa5HjFdfeyIXgECDBwPFVDvJq9
X-Google-Smtp-Source: AGHT+IGD1+RWYMQNl7g5DBJNyh/Rk7DFAJoyKbW8svrOWxknhhhPq+wBqdzF9X+G+AnjMD2oSbecGw==
X-Received: by 2002:a05:6512:108a:b0:52b:c9a:148 with SMTP id 2adb3069b0e04-52bab4b7c95mr3439377e87.14.1717669458562;
        Thu, 06 Jun 2024 03:24:18 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e2054sm152799e87.49.2024.06.06.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:24:18 -0700 (PDT)
Date: Thu, 6 Jun 2024 13:24:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/10] net: pcs: xpcs: Add fwnode-based
 descriptor creation method
Message-ID: <7bcu77pbw3fsgcua2owbjqgjwuxagplexltgkilozmeihg6574@6m5iizhtj2de>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-9-fancer.lancer@gmail.com>
 <20240605174920.GR791188@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605174920.GR791188@kernel.org>

Hi Simon

On Wed, Jun 05, 2024 at 06:49:20PM +0100, Simon Horman wrote:
> On Sun, Jun 02, 2024 at 05:36:22PM +0300, Serge Semin wrote:
> > It's now possible to have the DW XPCS device defined as a standard
> > platform device for instance in the platform DT-file. Although that
> > functionality is useless unless there is a way to have the device found by
> > the client drivers (STMMAC/DW *MAC, NXP SJA1105 Eth Switch, etc). Provide
> > such ability by means of the xpcs_create_fwnode() method. It needs to be
> > called with the device DW XPCS fwnode instance passed. That node will be
> > then used to find the MDIO-device instance in order to create the DW XPCS
> > descriptor.
> > 
> > Note the method semantics and name is similar to what has been recently
> > introduced in the Lynx PCS driver.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Hi Serge,
> 
> Some minor nits from my side flagged by kernel-doc -none -Wall
> 
> ...
> 
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> 
> ...
> 
> > @@ -1505,6 +1507,16 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
> >  	return ERR_PTR(ret);
> >  }
> >  
> > +/**
> > + * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
> > + * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
> > + * @addr: device MDIO-bus ID
> > + * @requested PHY interface
> 
> An entry for @interface should go here.

Right.

> 
> > + *
> > + * If successful, returns a pointer to the DW XPCS handle. Otherwise returns
> > + * -ENODEV if device couldn't be found on the bus, other negative errno related
> > + * to the data allocation and MDIO-bus communications.
> 
> Please consider including this information as a Return: section of the
> Kernel doc. Likewise for xpcs_create_fwnode().

Sure.

> 
> > + */
> >  struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
> >  				    phy_interface_t interface)
> >  {
> > @@ -1529,6 +1541,44 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
> >  }
> >  EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
> >  
> > +/**
> > + * xpcs_create_fwnode() - Create a DW xPCS instance from @fwnode
> > + * @node: fwnode handle poining to the DW XPCS device
> 
> s/@node/@fwnode/

Holy mother, so many typos in the kdoc part. I should have been more
attentive. I'll fix all of them in v2. Thanks.

* Special thanks for mentioning the scripts/kernel-doc I'll be using
it from now on.

-Serge(y)

> 
> > + * @interface: requested PHY interface
> > + *
> > + * If successful, returns a pointer to the DW XPCS handle. Otherwise returns
> > + * -ENODEV if the fwnode is marked unavailable or device couldn't be found on
> > + * the bus, -EPROBE_DEFER if the respective MDIO-device instance couldn't be
> > + * found, other negative errno related to the data allocations and MDIO-bus
> > + * communications.
> > + */
> > +struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
> > +				   phy_interface_t interface)
> 
> ...

