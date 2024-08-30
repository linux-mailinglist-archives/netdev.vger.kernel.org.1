Return-Path: <netdev+bounces-123865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F0966B20
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850BB2818F4
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB71BF817;
	Fri, 30 Aug 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rsrvr1TM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52F1BFE0F;
	Fri, 30 Aug 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052006; cv=none; b=cbCximzSK2zuJmXspcYuMOlIQICtwmJX3iEajyo9TOXm2Cix5nO67iySPGA4uHS1+LQnYsOvtbL53LYDonVKoDFH/3FycVwiIWoLKswtyvLJ+bpQtZdEBW4CdLR391WLuUMAhluZGad0KczGgQx9zmtXxWTrdSp118pAL83ABps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052006; c=relaxed/simple;
	bh=H0NQ5ZmehNIgYltPpSmZIYymrt2njEkOB2G8BxeekeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoOrQPpKCCzceU7hUu5Xz/u2NLjB9csAGcdjVBEaOrlfPxHd3FvSqd2tS/vEJ0evjWzuIWW8E+8G2C9yC7UA9Dec5sY6Iwjio5LvzecPBQcDulTLUXU8ZV3zyqIzWNop/bvMkQvR0x7dV2pXJehYf/Lt2+YOFl9/+YtLyl1bhGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rsrvr1TM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mFZyqa+CojbUYnJNo0CayNqKOThSnfiFIOpByRbiXS4=; b=Rsrvr1TMQ72S2YVb/HKmtvr2yn
	FvO9q3VA7D2my2HVJb41qeIe2zEOrT1UmPteEZiy2g8+kr4mrr4B1v7R+clHjkg7USBGmQCK8+tn7
	kZk92hRXHeY+z0DuNIvFcqiI7uNbQaTIkZUPSmZnmoviK06hSU5RuqmJ0pLO/+0xSY74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8pJ-006AI1-7y; Fri, 30 Aug 2024 23:06:37 +0200
Date: Fri, 30 Aug 2024 23:06:37 +0200
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
Message-ID: <470013f7-39d3-4bd1-b13c-96f851db234d@lunn.ch>
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
> 
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

