Return-Path: <netdev+bounces-235241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE203C2E364
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 057B84EB3D7
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B32C324F;
	Mon,  3 Nov 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FqWv3sI3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB0298CBE;
	Mon,  3 Nov 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207709; cv=none; b=Mwn9FXUZJkL1W38ZRb46MGKHTlSU0pty1Ry2rCS1S72+4O1JM7YtrniofMaNInGPwXWqI/pdotcZ8q23RgZn3QNC24Yuk3f1x906Ey2Xxk9+M9/mOzzPs/VhwM6k1wispn4lrNAX7zpt/PYB/q4Vb0Xt6imnY3cE0gxeBb8ivsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207709; c=relaxed/simple;
	bh=8kGjZCL0fsC0IzU1KWL9+7TW19SLakagJFGX9tdo68Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXzMTqQDzcW6zJqfZTgdix4bt2GrF39EJIXTsfprCsrr5gUJCFSO9NeigNJHAg/Rl72NeUULsO4P2s09DWFYf28OAvekIThaAmtcZ1ElYz46kmwS0ip8loUp6nBEmfM+a0IIdILn9CSy6b0Tsf69aFeSluEhhqNRFJ20jZRwYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FqWv3sI3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rb9ynyy4HDFtrAv+/34MIaxXu8RI/q3vAQI+7eq7iq0=; b=FqWv3sI3MH5inb663N7N9l+5/b
	PGYmI4g3TxhPy6lU3iVQEVNBm0MJ6D5fN+M2I9hfj4G6tQrMwEOnwdY1EBxS66JgReKkOh8OxMteb
	+boPzHgNsRAJVYj+XWQ9vPuN7aNfkGJ4J2BRjI1WkJiscQ2q/+X04iVlX+DJ0ilLen/w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG2ih-00CpAg-NB; Mon, 03 Nov 2025 23:08:11 +0100
Date: Mon, 3 Nov 2025 23:08:11 +0100
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
Subject: Re: [PATCH net-next 1/2] net: ethernet: Allow disabling pause on
 panic
Message-ID: <e4f6a025-136d-4c66-bea3-6916daa52b52@lunn.ch>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
 <20251103194631.3393020-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103194631.3393020-2-florian.fainelli@broadcom.com>

> +	/*
> +	 * In panic context, we're in atomic context and cannot sleep.
> +	 * We try to call set_pauseparam directly. If it would sleep,
> +	 * that's a driver bug, but we proceed anyway since we're panicking.
> +	 * The driver's set_pauseparam implementation should ideally handle
> +	 * atomic context, but if it doesn't, we can't do much about it
> +	 * during a panic.
> +	 */
> +	ops->set_pauseparam(dev, &pause);

I'm not sure i like that. Many driver writers get pause wrong. I've
been encouraging them to use phylink, since it does all the business
logic for them. There are around 18 drivers doing this. They are
likely to first get a splat from ASSERT_RTNL() and then hit a
mutex_lock()/unlock.

Could you take a look at phylink_ethtool_set_pauseparam(), and if we
are in a panic context, at minimum turn it into a NOP?

    Andrew

