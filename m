Return-Path: <netdev+bounces-123866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB530966B22
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE501F23423
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F21BFE0F;
	Fri, 30 Aug 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cZbzZPrA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171413D60E;
	Fri, 30 Aug 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052086; cv=none; b=fw7OB6OXaZc69AhSYhtLPTwTLTAsGU+TByu8npJY3SrAzc5sM/m3Sx55xmLyDHsvzSXS4ZQwPUKw05MQbFj796mGe28JP1kZOqmOCPM9aLwWXA/0MSdLJp0E8LusnrH23Uk2TMPlCmz45LhbXVHzZdQxBbNkbjre6ID8MxeQw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052086; c=relaxed/simple;
	bh=Q82ym79uYg7X8I9tkET9sBPh5W+r79KqmYB7BOUjrYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Om22mFqI+JZnaUkfpXSa4UOlnWUY+FB60QNUM6Atn2tbCs+dfV9Ij9Z3DaXZqjdWJ2kS4tcXVD0HnQqWXwH3EmLhRKpTLWw04dtIrXGXU9JJhmQl3aosZUj2Q/SDaZgxAyaEfNFszBtHEOGJPEoPcb02nu6s61DC0pQC6Yppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cZbzZPrA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nlSRRJPy5Y/nvSGgNo8LGfd03y58qST4jCBIfpLyAlM=; b=cZbzZPrA83+6VP8QY1GzOWqCjM
	eJ2hkcIFpfpn9E1GKfZnCBXtpGd7Z9jE5QlZdp/mkwfo6g2/pEMYY0ocTYa4lZkAB7K7wgeYi6szz
	vV3hyPIHlCcRUS7zXZJaJhD/kxp9fYjFRrC/UeEvfm3Zo9NVzQexOLNAxwelEjNAmKlg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8qa-006AIn-MK; Fri, 30 Aug 2024 23:07:56 +0200
Date: Fri, 30 Aug 2024 23:07:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 4/7] net: ethernet: fs_enet: drop unused
 phy_info and mii_if_info
Message-ID: <a6eeb9e1-09f0-47a4-bf78-d59037398078@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
 <20240829161531.610874-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829161531.610874-5-maxime.chevallier@bootlin.com>

On Thu, Aug 29, 2024 at 06:15:27PM +0200, Maxime Chevallier wrote:
> There's no user of the struct phy_info, the 'phy' field and the
> mii_if_info in the fs_enet driver, probably dating back when phylib
> wasn't as widely used.  Drop these from the driver code.

There might be an include of linux/mii.h you can also drop?

	Andrew      	   

