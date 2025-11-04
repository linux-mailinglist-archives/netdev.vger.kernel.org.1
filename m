Return-Path: <netdev+bounces-235363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699EEC2F49A
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 05:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1713B5530
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF25287258;
	Tue,  4 Nov 2025 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IWAefwEg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6472C15B0;
	Tue,  4 Nov 2025 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229712; cv=none; b=DMkgawzBkKGi/RKnZOE8U98ZX3kNSX9tBnYCcnxiYnVJAo6raBBBiS+YcfhH0tQS/vmsWNW0tW+8PZ6+1kGF22CMoFXJERnGxaYcurQD/PrIVnd6KizxgEsiKV8JT7mQOjPe+xcBKV7sIbnjWa8SIbCRly2jUXFpnDfiBN2pNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229712; c=relaxed/simple;
	bh=HINJ92Fix8YGS05+tBCK2cz2ShWEKya9gzoFaCuclvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5jPTxtV/nQS/vlpnAohnOHE7luZ193a0q3k898Jpu7DxgmR6CSmEx/loB3IlIeLHVesivGFK2IVl/vJ7giKDul2GWtzBj+z83QZK84BcQMkWwkfjCx+tXPx2mtfczisLsUeraOwfDaaW5Qy+eURetNmOxsauf6ODFgsF7CLAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IWAefwEg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kA36MZQZridlFafQzkjIBFnLtTLKyL05C4SQ4npm2NE=; b=IWAefwEg1Brj5XqQ7wu5qZ1DSP
	IPLsrkjMFylHbx/u1Z+fyWs7SPVnghicXoK6tUXCNh6aRnon8KQdtT2/NiAtVoRK41/V7XT1tQMnJ
	OMcXFQl9XOjFY7+uxg7PXIfZcASSwqpR70jbaHoJxAfXgpgAFRWwtBFDOJvXg6GNs5PM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG8Rb-00Cr0M-NS; Tue, 04 Nov 2025 05:14:55 +0100
Date: Tue, 4 Nov 2025 05:14:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	Doug Berger <opendmb@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Antoine Tenart <atenart@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: bcmgenet: Support calling
 set_pauseparam from panic context
Message-ID: <1f270218-32c1-476b-a237-2c2458b17998@lunn.ch>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
 <20251103194631.3393020-3-florian.fainelli@broadcom.com>
 <f9a32e33-9481-4fb7-8834-b36d88147dc2@lunn.ch>
 <1ce81ce5-1c09-4663-915b-16ee58e19035@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce81ce5-1c09-4663-915b-16ee58e19035@broadcom.com>

On Mon, Nov 03, 2025 at 03:00:21PM -0800, Florian Fainelli wrote:
> On 11/3/25 14:19, Andrew Lunn wrote:
> > > @@ -139,7 +141,8 @@ void bcmgenet_phy_pause_set(struct net_device *dev, bool rx, bool tx)
> > >   	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->advertising, rx);
> > >   	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->advertising,
> > >   			 rx | tx);
> > > -	phy_start_aneg(phydev);
> > > +	if (!panic_in_progress())
> > > +		phy_start_aneg(phydev);
> > 
> > 
> > That does not look correct. If pause autoneg is off, there is no need
> > to trigger an autoneg.
> > 
> > This all looks pretty messy.
> 
> That is pre-existing code, so it would be a separate path in order to fix,
> though point taken.

Yes, i just noticed it in passing, a separate issue.

And by messy, i was meaning all the conditional locks. A new ethtool
op would avoid all that, and the new op is also really simple.

	Andrew

