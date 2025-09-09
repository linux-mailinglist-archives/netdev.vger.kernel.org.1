Return-Path: <netdev+bounces-221177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C6B4AB92
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBAA54E2369
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1031CA43;
	Tue,  9 Sep 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrrU21x/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4232C235F;
	Tue,  9 Sep 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416885; cv=none; b=d+xy1cUxgQn5FH0oLcLv/5UTADxNRV0mTpuuMPdxJIxqXKlROfz2Aa7LUJ7bEwg7R40SPb1t6atvyNFeEZCS2WakAhoEOXlsS0uzyvK4HCWrrOfkdeSVu9f+LSCHujaPeTo2s5/AbrEB4iW8ziQqkWoaUg7WhshUsn6VNJtdhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416885; c=relaxed/simple;
	bh=WbvmOTYMPTf6nebmJG54eP4dr6DF3IyR39kg9dBowho=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvsGrVi/l5r2t0GMtWjxTaVWfO7nFS3VnJvhbTwYoXNcL1ll7vMgTTFt1UJVKKAeERn7RLKmA/j5G4DMXOC3l44tnK5c3J8tQ1EMfWQvJb4VZzdOC/JhvBfHILWaGdjrS7Uvgh0l7yKJ5ue1o9p1Q5E6U4Cchp9mNpzeGyI2LQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrrU21x/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de56a042dso15035085e9.3;
        Tue, 09 Sep 2025 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757416882; x=1758021682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lRUpNDwLIvh2WOyXhRrF4YeiOcekU77uShvfMHahTds=;
        b=CrrU21x/bVohGzRymm+nWpOWoxErUh6yqC7FdyS5v7nHwNGxEPgjq1ayrPC53u4tEy
         vFXBThTFB3uxZisXZ0XiHhT/uUwISU2m9Q9I3dusUCQfoNRwmJNMZFt9dh/OfhON6x5v
         k+uFX/qMKvIXc+1V1Qyt3jMFhCe1Lp/hx11jIf6OQYsU23+wWrbGrjP/lEz21Hi62B3B
         w5lwJ745eTdRtRQxQRQ9Xe1f0SuoDiTSE/gDAU3R0ioSySwd31uQEzWDQQAw6QW1PFYp
         b9NgyGA/PJMKub565kANH+r1SMweWnT05xFT9nExvwQjn+pugLZJUAiW1cTXIcxM856O
         Wwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416882; x=1758021682;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRUpNDwLIvh2WOyXhRrF4YeiOcekU77uShvfMHahTds=;
        b=AG8J0B0eUpunX3ncjXMPawZ8ExhHElv37H7Utuda5f3u0x8wMS5gSNX9KijhMYyrUk
         2pDl4T+8PoMR9ZqQEYUQNET77LWr0y+Ve05Dy5SWLbuPrpZ8mVSCPZRwLujJnff7xGrF
         tuE/uBdZ287hAXkzM4x1LaBoQs5cIjlkLCFUDYHGhA5lWbcnNmFeBYReUa7CSH/dlkm1
         bPEE+WptJ+pM1/FcxzroKDpJPW9fmvkCw1ztxfH/ng6hl2X5VcKopGTgvXJGVJK/smGT
         Y6G2JmmgxOO1FF1Pi5MSASNz+XbLHxwQoqfegaYBj/ivlyClcDyzZoaimoMbmqhKDLFC
         ZJMg==
X-Forwarded-Encrypted: i=1; AJvYcCXBiJvQwqCkeGHtflMuZdF+1XRMttdI60YqD1PfgYjPykLX79e9VGV6ygbTS5cMSCJQGbr/XGhB6YdfPI/l@vger.kernel.org, AJvYcCXgIav+4msEkFVcK3ouXufevFY+5jfARWcloQZsLX839u/t0CqbTDtS1q8NwbtXWVbwdKZ3bJAH@vger.kernel.org, AJvYcCXyjTVnXWKF+AN16f3rMJ60nJf9zvRr0GxsmqSXbepgY6MzQ9mOiqr2A4PFO3D+RXc1uJntx8jN85U2@vger.kernel.org
X-Gm-Message-State: AOJu0YwDN3MZl75+HyGT+k3PJ6dekTObZdXCT/CDiqksCaJkTHgF93J0
	Po440LWKZsdx5KaDjpCl3u5jOxYhEmROVW0ZibjbB9j1b4XrnhLSrcu0
X-Gm-Gg: ASbGncuivnz5LI+jrD/AdIGktsw307Gvhg+4jqVom7Ubf5Z9nWXuxV90g8jDZNKa8Ta
	cAWKzdePJGVGGYCXOR8WhepzREteCfFVNkv8kc7kCXk6FLiL1zU9QY11sCH/fsKXwgta3mOP7mG
	2GYKAsPlj6dROdHNqsLDJPN0/RQwqO4Sfcl7puSrKG0QTeB9/NovpCpnIT1ZP1Lq2VCGjU+M8ey
	joVGqkclbiIyzWm1ZUWDSSFqA047XwLk2C+NY0rTkUf24dOfeZtNE4A044DnlbDYb0oYNtZXTo9
	dgMhyr7xCBfiPTIriA92GzJRxzdik/o6NssvHa8Jme/dLaxk64PAiMu4yIuDpX6rYFiLV4rRewr
	ekyQgTFRLuSLMDPewxc8b7ZnyQZbWrBPiRai7mCtJOU8a4f91hYel7mlDO4pdmgKXYggol+GxVN
	n7EIgE
X-Google-Smtp-Source: AGHT+IGw+CAsxSqqDDZ/FQQyvb/2SG9TMRuD7Xnj3H8EyLSvjgZxnQG3oLScOKpM5QtJRUCbg4+2rA==
X-Received: by 2002:a05:600c:4751:b0:45b:7b54:881 with SMTP id 5b1f17b1804b1-45dddea644cmr95621485e9.1.1757416881472;
        Tue, 09 Sep 2025 04:21:21 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm232791575e9.7.2025.09.09.04.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:21:21 -0700 (PDT)
Message-ID: <68c00db1.050a0220.7d5a6.50b8@mx.google.com>
X-Google-Original-Message-ID: <aMANrtmXgWoM_ZdE@Ansuel-XPS.>
Date: Tue, 9 Sep 2025 13:21:18 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v16 06/10] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-7-ansuelsmth@gmail.com>
 <aL_uqX90oP_3hbK6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL_uqX90oP_3hbK6@shell.armlinux.org.uk>

On Tue, Sep 09, 2025 at 10:08:57AM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 09, 2025 at 02:43:37AM +0200, Christian Marangi wrote:
> > +static void an8855_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				    struct phylink_config *config)
> > +{
> > +	struct an8855_priv *priv = ds->priv;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	switch (port) {
> > +	case 0:
> > +	case 1:
> > +	case 2:
> > +	case 3:
> > +	case 4:
> > +		__set_bit(PHY_INTERFACE_MODE_GMII,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +			  config->supported_interfaces);
> > +		break;
> > +	case 5:
> > +		phy_interface_set_rgmii(config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +			  config->supported_interfaces);
> > +		break;
> > +	}
> > +
> > +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +				   MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
> > +
> > +	ret = regmap_read(priv->regmap, AN8855_CKGCR, &reg);
> > +	if (ret)
> > +		dev_err(ds->dev, "failed to read EEE LPI timer\n");
> > +
> > +	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
> > +	/* Global LPI TXIDLE Threshold, default 60ms (unit 2us) */
> > +	config->lpi_timer_default = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) *
> > +				    AN8855_TX_LPI_UNIT;
> 
> You're not filling in config->lpi_interfaces, which means phylink won't
> LPI won't be functional.
> 

Thanks for pointing this out, I notice lpi_interfaces is also not set on
other DSA driver that were converted to the new EEE handling, for
example mt7530.

I assume EEE is also half broken there and the required change wasn't
notice at times?

-- 
	Ansuel

