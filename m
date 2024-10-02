Return-Path: <netdev+bounces-131205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7866698D36C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C56282563
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69F1CFECA;
	Wed,  2 Oct 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A7eWEjDK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0A1CF7CA;
	Wed,  2 Oct 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872706; cv=none; b=sq5CldFckGXC7dsUg0HvaBVJYR1QMozvE9DBB1Thx1X/rwaENZq/5mgPapGTyPyaFnVHOjSGTXOTdvBQOfLrr2HcV9v9EzyalxaJhGsP0f8WtJRk0CyzV20W2zexqfmZwryuzQKgrfnsKQXhPZxCbMF6iln0PWvr6wHep6HOCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872706; c=relaxed/simple;
	bh=bIgYgaDxCRpic7zCnzzXqvFd9B/7m/11LPKFwTY6ET8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHaIPYSC1x9NNw27DiXiLpuVOYfTqYp1e/HnaNm8Oz4GtuSH8xIkDPPy1TYajIBWcFX17pAQTYx/JphaGdtmd2hYpZib3L6j6IAjuKMrH7GdXr6LASFQAB+icKxKexDq7swtfhWbb/egXrR46LnfF02Ha4TlxGcpgmtmOlRm0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A7eWEjDK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PKNG/9X/O/N8D/B78+WZtm8YmH9dOPeVEWznmY//3KU=; b=A7eWEjDKVd8yxjcY823Ca+4yx8
	cXl/4ccVoQXGtsoYzFKDzderpAiz8iaGQxz/8AzIlZXvU9kXGkv3HSRqbt6HDV5NmHKkrAlBwyaOf
	SOcVcxKbUp2/5iBWEBtsVN61Cyna1rAuL4ddwJa6HnW3eobk4+3B5XUDOT6RqBCzyd9A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svycV-008r7c-4B; Wed, 02 Oct 2024 14:38:19 +0200
Date: Wed, 2 Oct 2024 14:38:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: Fix enabled status mismatch
Message-ID: <965905ef-cc00-49fa-bee9-2b45d6155108@lunn.ch>
References: <20241002121706.246143-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002121706.246143-1-kory.maincent@bootlin.com>

On Wed, Oct 02, 2024 at 02:17:05PM +0200, Kory Maincent wrote:
> PSE controllers like the TPS23881 can forcefully turn off their
> configuration state. In such cases, the is_enabled() and get_status()
> callbacks will report the PSE as disabled, while admin_state_enabled
> will show it as enabled. This mismatch can lead the user to attempt
> to enable it, but no action is taken as admin_state_enabled remains set.
> 
> The solution is to disable the PSE before enabling it, ensuring the
> actual status matches admin_state_enabled.
> 
> Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> FYI: Saving the enabled state in the driver is not a viable solution, as a
> reboot may cause a mismatch between the real and software-saved states.

This seems O.K. to me.

I'm assuming the controller has turned the configuration state to off
to stop the magic smoke escaping? Is there any sort of notification of
this?  Does it raise an interrupt? Sometime in the future we might
want to add a netlink notification about this?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

