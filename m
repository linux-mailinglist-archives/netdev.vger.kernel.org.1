Return-Path: <netdev+bounces-137274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830729A548E
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FF1C20FFA
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E961925B8;
	Sun, 20 Oct 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2q6StgT1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B042209B;
	Sun, 20 Oct 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435646; cv=none; b=nBo0QNW3NCdGI7eh5rGOLoXjiCXxVgfPK3fDfWKSKRG9PLWpqGhFBpfBHgCIqVJC0Pq2byEb1KYRQf/P6QO+zxZT6HalYIesRxAhLulhEpZeb9Jiw3+2Em0Ms7c8wOdDSJLdjnx/KMRRsPBs0grt3VF9/xKchsEKbcwdw1OWEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435646; c=relaxed/simple;
	bh=bdHe8oVf66Ft+GmEmF4nt9Sks7q1UbxWLdKl81fEQ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csOGLYQPeXd1jKhQU+JsG/eUqKXuJBGaeCWgN3ZKNL9vBgntWN8eMnMQfD06GFw2xghj3VJUsklxp3LhR1golkEzskCPBps03hVPFklrjob0hDb7AycAX5ukTzLo2U3kvUEZN00a7CMhD3SdVchXDuHhHahf4eK7hK+PKaUwygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2q6StgT1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zmyo1fTWbthMVmNxF8nKhGsgsGfAfxJZkUfU7Y5L4X8=; b=2q6StgT1ePMGCGk9pFg3okb6/v
	KU0nneBoZwQWzTg2s12nlTNyNhQSFRV5GmT6zXZSbAyVL10DQHJnnrKGP19XYsWvC6HlMzNdP/ydQ
	b6m/1jvXX5vZ59lNVdglNcmZ2J5h7+5R7Q1klB7Moql5qRLCqsOIYnUy2GrMomhm1tks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2XD1-00AeUw-TC; Sun, 20 Oct 2024 16:47:07 +0200
Date: Sun, 20 Oct 2024 16:47:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: fix unreleased
 fwnode_handle in setup_port()
Message-ID: <612445d2-d7c8-4bda-a070-e2c0ebbf3d4e@lunn.ch>
References: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
 <11c644b5-e6e5-4c4c-9398-7a8e59519370@lunn.ch>
 <f148a61d-4ad5-4f62-b1f0-d216e1873067@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f148a61d-4ad5-4f62-b1f0-d216e1873067@gmail.com>

On Sun, Oct 20, 2024 at 12:21:07AM +0200, Javier Carrasco wrote:
> On 19/10/2024 23:59, Andrew Lunn wrote:
> > On Sat, Oct 19, 2024 at 10:16:49PM +0200, Javier Carrasco wrote:
> >> 'ports_fwnode' is initialized via device_get_named_child_node(), which
> >> requires a call to fwnode_handle_put() when the variable is no longer
> >> required to avoid leaking memory.
> >>
> >> Add the missing fwnode_handle_put() after 'ports_fwnode' has been used
> >> and is no longer required.
> > 
> > As you point out, the handle is obtained with
> > device_get_named_child_node(). It seems odd to use a fwnode_ function
> > not a device_ function to release the handle. Is there a device_
> > function?
> > 
> > 	Andrew
> 
> 
> Hi Andrew,
> 
> device_get_named_child_node() receives a pointer to a *device*, and
> returns a child node (a pointer to an *fwnode_handle*). That is what has
> to be released, and therefore fwnode_handle_put() is the right one.
> 
> Note that device_get_named_child_node() documents how to release the
> fwnode pointer:
> 
> "The caller is responsible for calling fwnode_handle_put() on the
> returned fwnode pointer."

O.K. I just don't like asymmetric APIs. They often lead to bugs, just
look wrong, and make reviewers ask questions...

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

