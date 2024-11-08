Return-Path: <netdev+bounces-143305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4939C1E3B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5C4282364
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053E31E907A;
	Fri,  8 Nov 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rP0lj+JO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC58137E;
	Fri,  8 Nov 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073354; cv=none; b=iEW0UZIWNvEu6g6vZMbUux4PZdL2AA/8/QpAAz0Ed7XakFAQxXG5N6a7evVY/cB7uxuecQb7W+X8kGY+CTRsW7lltWPXKyAncjShKOGmu5AhdVjB1rUYqiBxzE+pwfdowVFeyTe9/2Sk16KYUZag6TlIGQqbuemg1yGuj7Z3O0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073354; c=relaxed/simple;
	bh=sPl0xH/rU5MR87CzD0UWeh48pO+XSsnrBK1DNGW4z80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba2AFD/+0XMuMkME8qTwYBwHCLdhpnebmsvoW4maNclb8Hw4CMRmWQFmiFbC9sy7X2Hm2LetYOAmxHJ69yLQjvB9V2Wg2kMulrliAGyzN3pil16dgteX3vlb5d0j+mTGtkLiZV8Hi3B5rhL2fNYVbmq/jMZc0C0k3Kpa/wL1L/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rP0lj+JO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2PsP6fH5txDMvDlc3c+WMtD2cJ/wi0SKqkHs3W/eFdE=; b=rP0lj+JOMDGwwHCIind6kgu2cS
	AY3N7HyzPwY4bkVUhKzCuvNGjHaSFts3QbWZHVwAe4ekgbKG+vJwrG9bd4+ob6Sba8hBPNKi4Vf8s
	bYCVmGtQO8GsCW6STmX0PYgMggGtz9Qe8gWTxum/IiGybTKkAV93OJIZ9a7gEcmFQEaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9PFi-00CbHF-Cg; Fri, 08 Nov 2024 14:42:18 +0100
Date: Fri, 8 Nov 2024 14:42:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
Message-ID: <93e02466-b4a0-48fd-beb0-c93b1008ff08@lunn.ch>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>

> This is achieved by temporarily updating the fdb entry with the new
> port, setting a new notify roaming bit, firing off a notification, and
> restoring the original port immediately afterwards. The port remains
> unchanged, respecting the sticky flag, but userspace is now notified
> of the new port the host was seen on.

This sounds a bit hacky. Could you add a new optional attribute to the
netlink message indicating the roam destination, so there is no need
to play games with the actual port?

I'm not too deep into how these all works, but i also wounder about
backwards compatibility. Old code which does not look for
FDB_NOTIFY_ROAMING_BIT is going to think it really has moved, with
your code. By using a new attribute, and not changing the port, old
code just sees a notification it is on the port it always was on,
which is less likely to cause issues?

And do we want to differentiate between it wants to roam, but the
sticky bit has stopped that, and it really has roamed?

	Andrew

