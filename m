Return-Path: <netdev+bounces-123868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE3C966B26
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130821C22017
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56831BFDEA;
	Fri, 30 Aug 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R6G6RBdL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD3175D3A;
	Fri, 30 Aug 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052135; cv=none; b=i2UIYNteSRqibtqWX6rBICdwgdLZvIqQJliJZnV40jetOZtvitts1IWpEwSVqQ1+UsBaK2YvdxaiWSLRy6xYmA7Hp73J+1iqx1zDwdeRILo+WGBZCplDcQdKmBpcXJQa38m1XWm6MmlrViXpx4Z3jOA0g3URgS08jbiTQEPKFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052135; c=relaxed/simple;
	bh=zq0fj4ZmcsIyiSqxs7MoyJ4KyvzrT/FVBYeO3cSklds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjIFvwgs+BuULOPGhPr4yxHRn8V9caKMwJ+SUYncSaTakFM97+aq6B97W5MEl3sJ/CGEXVtpkeyGmvFUHVE9SRxFew06Nc2dPoGfZgeOYM7Cjr8JFpwSZ9n014c2/31tzqGMaObLehMCqIqgPMvSxMuZ0sePKmLeult+d2KZmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R6G6RBdL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gb6Pua4+8qmxqMEF4Vk4GZvcFYXa7AIs24hySnHa/ko=; b=R6G6RBdL3mLd/omM3HVHj0sO3o
	1hS8E8rRq0e9MQpdhQ4ebSWo7V5KSNf7/7U9vs67Z0HW/Eklikg4jZtMdFe4iYFcmlkWrxkv3cKC9
	ac7A06OkeBFufwAKOcWf3djGO6nbTu19dzMwtf3A7AlHHKI+I6u7gTzP9mOlZNAyOpuc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8rO-006AJh-Ek; Fri, 30 Aug 2024 23:08:46 +0200
Date: Fri, 30 Aug 2024 23:08:46 +0200
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
Subject: Re: [PATCH net-next v2 5/7] net: ethernet: fs_enet: fcc: use macros
 for speed and duplex values
Message-ID: <102be9c5-96d0-4e8a-ac1f-0a00b1c4257d@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
 <20240829161531.610874-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829161531.610874-6-maxime.chevallier@bootlin.com>

On Thu, Aug 29, 2024 at 06:15:28PM +0200, Maxime Chevallier wrote:
> The PHY speed and duplex should be manipulated using the SPEED_XXX and
> DUPLEX_XXX macros available. Use it in the fcc, fec and scc MAC for fs_enet.
> 
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

