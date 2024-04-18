Return-Path: <netdev+bounces-89433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7558AA436
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5A9B20F03
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5761836EE;
	Thu, 18 Apr 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ag7Yf/BH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DE15E215
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473069; cv=none; b=lrksuFSZeAtFURHXyz0C5vD/58OVyQa9S+kD7gRaoaNtLMfHBLl1Uc4Za4NU7NKu7Hyh6ke/yp63bjsm9nKCW006D/WR6GSS/MW434+3dq0rFLNa4kJUJkeZ1q4ojL/m6KIxIVnbeXk2HyyBCvYj1U1c8PR0uhJfZSOkUqHipEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473069; c=relaxed/simple;
	bh=8Rp73D/siHckBQuoNo9ejMxkw40jtmo0b7xKhwLI/SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEFWioYUx84G38j9el66mNUN1uqyR06AHxkrAYmlngkZbZ3gGXsIHx9vikMzqTJuila4D+qhwviyfkASbuRzgOizxdV6PXILO9Wz3vDDqe4OwlWxhUwEInhXFGxzF3bkVdMboC4ejgsJwbIQOglkPYlMP6QyIvY1pjJ+Go8bTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ag7Yf/BH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LyrfKxnG7KT35jhSG9L5es3skdSQE45RhCHMPyVswAc=; b=ag
	7Yf/BH7Au/Ch4dk6nMkI5nTAORm7S0BUIVC0d5FUFnSzlcspfheWHs1q+DQ1DA8P23Z6LfkHMMFQi
	0IFKdnMC8AI3nMcM6NE9XxtewZgLT0/IvzcLXwxlHXc9NY9LErKeEQgmlgY+WId7VOZbeozQadop/
	F8KVl64Q4mXuzu4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxYcK-00DOQO-1R; Thu, 18 Apr 2024 22:44:24 +0200
Date: Thu, 18 Apr 2024 22:44:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Peter =?iso-8859-1?Q?M=FCnster?= <pm@a16n.net>, netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net] net: b44: set pause params only when interface is up
Message-ID: <a38a8279-1e06-4e9f-894e-c7a3cda15ae6@lunn.ch>
References: <871q72ahf1.fsf@a16n.net>
 <e5d3c578-6142-4a30-9dd8-d5fca49566e0@lunn.ch>
 <87wmou5sdu.fsf@a16n.net>
 <CACKFLi=geVU6TSciS37ZvGuKn0xzrk2ifsuytvPGubsqNMNk_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=geVU6TSciS37ZvGuKn0xzrk2ifsuytvPGubsqNMNk_g@mail.gmail.com>

On Thu, Apr 18, 2024 at 01:40:00PM -0700, Michael Chan wrote:
> On Thu, Apr 18, 2024 at 1:27 PM Peter Münster <pm@a16n.net> wrote:
> >
> > On Thu, Apr 18 2024, Andrew Lunn wrote:
> >
> > > Please include a Fixed: tag indicating when the problem was added.
> >
> > Hi Andrew,
> >
> > I’m sorry, I don’t know, when the problem was added. I only know, that
> > there was no problem with OpenWrt < 23.X. But I don’t know why. Perhaps
> > the behaviour of netifd has changed from 22.X to 23.X.
> >
> > So I guess, that the problem is there since the creation of
> > b44_set_pauseparam(), but it has never been triggered before.
> >
> > So what should I do please with the Fixed: tag?
> >
> 
> It looks like this dates back to the beginning of git.  So I guess it should be:

Yes, i came to the same conclusion.

> Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)

Agreed.

	Andrew

