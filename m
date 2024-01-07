Return-Path: <netdev+bounces-62237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BF6826512
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD367281F62
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45413AD9;
	Sun,  7 Jan 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5lemnllt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8813FE4
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MhRuu5ZmxxI+GMK2BFzMJGJjsVh6BZcZ9pxEmY8hZzA=; b=5lemnlltD92CewNzNzqc2sobhA
	RDvi7jrPXrzvnZTQWK3M7gpCV0xukx4WwDxbRs/Jx5skwhnfpbZrezOBlIzZVqqlJlr0jbItoTQma
	KJ+OxO1ivyv+R6+IMP5C3Itu33VoY9yQZtzfiHvmPNX2gYoTRm2sv/vOE0qFiuUHaiFk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMVvY-004Zq0-Ms; Sun, 07 Jan 2024 17:23:08 +0100
Date: Sun, 7 Jan 2024 17:23:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 RFC 2/5] ethtool: switch back from ethtool_keee to
 ethtool_eee for ioctl
Message-ID: <533a25a0-e1a1-447a-a0ea-7fad0e02c28a@lunn.ch>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
 <ba3105df-74ae-4883-b9e9-d517036a73b3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3105df-74ae-4883-b9e9-d517036a73b3@gmail.com>

>  static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
>  {
> -	struct ethtool_keee edata;
> +	struct ethtool_keee keee;
> +	struct ethtool_eee eee;
>  	int rc;
>  
>  	if (!dev->ethtool_ops->get_eee)
>  		return -EOPNOTSUPP;
>  
> -	memset(&edata, 0, sizeof(struct ethtool_keee));
> -	edata.cmd = ETHTOOL_GEEE;
> -	rc = dev->ethtool_ops->get_eee(dev, &edata);

With the old code, the edata passed to the driver has edata.cmd set to
ETHTOOL_GEEE.

> -
> +	memset(&keee, 0, sizeof(keee));
> +	rc = dev->ethtool_ops->get_eee(dev, &keee);

Here, its not set. I don't know if it makes a difference, if any
driver actually looks at it. If you reviewed all the drivers and think
this is O.K, i would suggest a comment in the commit message
explaining this.

	   Andrew

