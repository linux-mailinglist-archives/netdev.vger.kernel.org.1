Return-Path: <netdev+bounces-231709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7BCBFCF5E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87C894E622B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34CE23ED5B;
	Wed, 22 Oct 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPqQGRIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2423B615
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148120; cv=none; b=UBoub0Xx1w0GWwc85UkHNFPBE2wpVQ42GMNgDiK1lGeCFyMjIKc5NAMyzNSLnOqxsdaF1ge+wFu+h0bSGyzGP+jMzKj4NNIoG7P2KaUkvzqREb4vPSGCQCuItK+Fw+ePqwQ7x2Kryp/oFHb+SOvWXYQlJFcPW+S3OnsP1YbaKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148120; c=relaxed/simple;
	bh=8NETNIzuboOpJbg4ntKwpRaVfdFSebUPtGY6GIFfbZ8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUHqF5ycLwmxoG5p+QnKNjG7f9nqfMSjjOZ/v/7m4yz6BviqoFmioKRm1RXbMRBLjyXs8WchKL8EJ9/nqWro6uV3d2MAzLUebT6PI2GEwa3LjtHgcVGbmZy7GusNdvZzPOZ2Z2gfqlled2ZoCI7ToESRziV0ut9K+PodD9+n4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPqQGRIb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42706c3b7cfso2438635f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148117; x=1761752917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XWO4yOCaMUYjGeCQQA0uyhzhbdrG4m6pu8cUif/JpM0=;
        b=mPqQGRIbo+1CjtS1Sa3gaVbW8i7CH10lFrgZIBwiz24ApAxIAVQuTWUwdjaltggExH
         w+EOF5R4KSyOOxSWnsvmCetp0NwR833AedjNbSPCO2NCTRGVJvN6f9wnsXqs4UYBjgeQ
         zq6F9ftYO8yB6H9rk2zo1cRbFCWgPqos+hP0mrc+HLn+aOVf+FM5YTPtf1PdMyLEWrDC
         OxEXijuL1t2oYWjH6uCij/rL9XcQ739OO0hMZrsIf6nZFMPMBhMTmzgoFTZLlbH64RIQ
         1PhhfgT6gAKi9rsi5O6ZkKMr02kytKpII3KEUr6mlw1omZlP0gaJUx73c+FMVeTBwG2W
         wLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148117; x=1761752917;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWO4yOCaMUYjGeCQQA0uyhzhbdrG4m6pu8cUif/JpM0=;
        b=fyQGNNmlgEYnei0uNUN2ZgrhlHkL6vt9jAbNKnkuKcIzBZbHI/v4eePYXN9LVquAtX
         wIBc/3zJ/IuqRoElYCghHaArdz8IJplj5TCUmPXoHVCkUcnI3Q7AYXelEGQIRpiFTTh2
         5+v8k5cpKHyxcZdyKKk0oFtwVKWjuE+ZPyXwpYQLvdq1dAlGXpU2QLtrp9aziUa7Dyy/
         i9GnaiqvpSNVM8fD4EcMZEaTEKKID/p1S1O53ECwkyVoAgY9uJBVll8Pq/ByPqWLIfYk
         tnw/1jlRjW2w53THcG5c2RCTBicCojjAr4Ka+AZTQCDt5uRpGZ9HdUoVk4kNNohiPa/F
         /rsA==
X-Forwarded-Encrypted: i=1; AJvYcCU1+5crZbyNccJOkufcKS4n4GtTgtYB6KMEnGatAeuT4lmnNgMbteB7vIbtoCEfjCOVUoQq7FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iOWkVAbXXc/DzI9BEkSY6zxAExIu+q2QUjsw/Ouq36nQLTSU
	rRRfm9K/2jlEXXWQl2QGpmjue8ZaZADFWEaJHQG0pDpCgb3kP4wYzMcE
X-Gm-Gg: ASbGncum96nMcKZMIdM5ri2eP9SBk3nn6zig7RrkOOx+XvGI9NZF1esxIyB9qMWIwod
	3OynolHho/si/zDAs1m8SCIKLnviKbuvbU26JKBunURIEXi07IuAbAJHWcf67SXcel5NLBTH43H
	iJrRf+/3HoRjF3KWNU4mdl1aF7Jth08UPLasBge22FwOQXJ3GUmN+cZ8aVAfwFoi0jMgnV+PwDy
	AsC4x170RiXT+KzKEt1n32Bx/TUemknRpoX7RfPOiUcScJjx8iodXjhPtbrMVqeMZ4zoH0MALYy
	iKOijGunKJe1clvd+Qg8eEkIyompoBgWQrRg2TiFTju7bHOCSMSPhanuzl5tHXb7eC7fOJtyYCw
	3UvfEUiZP/xK/GJiGHu8fX+btbXaRP5I9y1SU+eA3TY0MNs7BDs87lqvHjc2ITHOQ0dgd/kOmDA
	PZR02sWWAIYZw52cT3ivhcQKWq7hr1li+W88baSbg=
X-Google-Smtp-Source: AGHT+IHAoVbOJakh16O5eBX5PTSAHI2xQcrVoDpyDPxM5ZW2+gUYAv5HKBvRB8LcVZCJLd8co8c93A==
X-Received: by 2002:a5d:5d01:0:b0:428:55c3:cecc with SMTP id ffacd0b85a97d-42855c3d3femr1634009f8f.37.1761148116971;
        Wed, 22 Oct 2025 08:48:36 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm25309390f8f.36.2025.10.22.08.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:48:36 -0700 (PDT)
Message-ID: <68f8fcd4.df0a0220.60f68.1bc1@mx.google.com>
X-Google-Original-Message-ID: <aPj80atNusRChjjG@Ansuel-XPS.>
Date: Wed, 22 Oct 2025 17:48:33 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Horman <horms@kernel.org>
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
 <aPj8J5ntvDGLPYaY@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPj8J5ntvDGLPYaY@horms.kernel.org>

On Wed, Oct 22, 2025 at 04:45:43PM +0100, Simon Horman wrote:
> On Tue, Oct 21, 2025 at 09:33:12PM +0200, Christian Marangi wrote:
> 
> ...
> 
> > +static int airoha_setup_phylink(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_port *port = netdev_priv(netdev);
> > +	struct device *dev = &netdev->dev;
> > +	phy_interface_t phy_mode;
> 
> Hi Christian,
> 
> phy_interface_t is an enum and thus may in practice be unsigned...
> 
> > +	struct phylink *phylink;
> > +
> > +	phy_mode = device_get_phy_mode(dev);
> > +	if (phy_mode < 0) {
> 
> ... if so, this condition will always be false.
> 
> I suspect the correct approach here is to change the type of phy_mode to int.
> 
> Flagged by Smatch.
>

Thanks a lot for pointing this out. Also I'm a bit confused of why
device_get_phy_mode changed the args deviated from the of variant that
return int and required an additional arg for the interface...

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
> 
> ...
> 
> -- 
> pw-bot: cr

-- 
	Ansuel

