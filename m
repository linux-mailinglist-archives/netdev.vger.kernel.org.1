Return-Path: <netdev+bounces-243817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9D7CA7E50
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D5A6304A294
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA36330311;
	Fri,  5 Dec 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZiHuQbX/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E9319616;
	Fri,  5 Dec 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943617; cv=none; b=os3CRVGQ12mhyAHOJk9QTjDB+xWyl6V3VnZQqFki30AYPNv4C1PI5lglRB4cgjIjuoWHV4NgC0uWXUYjUY0k8rXcCcvc5JRG5XlU4hFqC7S/MVWCjwS4VnUllVh//a44eTVqz2z6q+vEQcS0io2PNcj9jLZugW5g02AW28JwDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943617; c=relaxed/simple;
	bh=UOqH8Pgv3EzTvbTukbx9fZOecEB6mrh7kK4nDWEJni8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdYAgpkUXP6UbeODmU4ooM34j9UB/Zi+Mekv5nUXHvt/QiwoCslY3XGlL+kffcS9POrMh0eUXfRdide6t5R9snYF2EuA1eTGjRVwo4/PktdEVh3dvIKlOORvWlhh1aYLa7SGwElWjOQyZyv88MMcltDgujmPqx43zd9gsX1a/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZiHuQbX/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/EvESmofZY44K41THRYIfRe9NSFRKf7LEDzNSzxwtCA=; b=ZiHuQbX/LCxe+MDXq656Q0uRPX
	RYkVP/VFC0rHOg4rmw07enXvLrPOQDbbkw979m4KBlJT4lk4Kcv7XY44iXOZLjTuRLD2ofdW0ZPep
	yRnmyvScZ6PggQ7+o9ZX4Kt1VIyHwI/Msgk3yefWDI3hAM/N/QvUZkWcJ1d7BhiX6ENw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRWSA-00G5zS-9c; Fri, 05 Dec 2025 15:06:34 +0100
Date: Fri, 5 Dec 2025 15:06:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <fe18129d-6194-4172-a0bf-36fed13721cb@lunn.ch>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
 <aTLkl0Zey4u4P8x6@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTLkl0Zey4u4P8x6@makrotopia.org>

On Fri, Dec 05, 2025 at 01:56:39PM +0000, Daniel Golle wrote:
> On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> > On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > > Despite being documented as self-clearing, the RANEG bit sometimes
> > > remains set, preventing auto-negotiation from happening.
> > > 
> > > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > > delayed_work emulating the asynchronous self-clearing behavior.
> > 
> > Maybe add some text why the complexity of delayed work is used, rather
> > than just a msleep(10)?
> > 
> > Calling regmap_read_poll_timeout() to see if it clears itself could
> > optimise this, and still be simpler.
> 
> Is the restart_an() operation allowed to sleep?

This would typically be an MDIO operations, since PCS are often on an
MDIO bus. And MDIO is expected to sleep. Also, regmap is using a lock
to prevent parallel access, and i expect that is a sleeping lock, not
a spinlock.

If you want to be sure, put in a might_sleep() call, and build the
kernel will sleep in atomic debug enabled. You will get a splat if i'm
wrong.

	Andrew

