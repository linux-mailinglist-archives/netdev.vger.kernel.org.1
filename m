Return-Path: <netdev+bounces-234647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E19DC250F8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975CF1B20B8F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2834A786;
	Fri, 31 Oct 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OQfzmTJf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C434A77F;
	Fri, 31 Oct 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914651; cv=none; b=Z9pANp93mFWaM19v7vAXNM8l+l6Z6wfMYBp+jzf7dN6mWLg0dmGIe03soX91Ap9qjN5ZGof9aZ5iK8fTsgX7yCjHzZHc4wjWDQtdjajQ8guxiA4F0ZF+RGQGJn2dMBVRvZC5yq+6xn7zgnJ353BCwtdAG+6LQEqInWwyX1Z4zdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914651; c=relaxed/simple;
	bh=0lHrH2OeUdBNMRkuy48s9W6OB58NUesLG0pn4Ff3d2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jveIqWrQjwhdEqXOEe7YcJCyuDsyiTEFP0mB6liqd8HDCaFJ26JMHtc7+TroEs9Y2Bue+3Vei6X/FJr6UphmK8wUzEYJMZnEC0zg7NgjYXurP5WD3VlqHn4Y5IeXkBOqFVZ3bbGVvMt5Nibdi8gaQhkFIDIXLWvlAotkOOHBJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OQfzmTJf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2DtW5Hfe73up2P6J00tK78FRvf/3zihm0Np1q799QV0=; b=OQfzmTJfQXNTh62MJNFYXla/eI
	gRusMiaVCqvTM7nc8yVmQAEA6pbDkUqOLUgaXL1F3JQXgdtI+XYwtlFKrSlvf5EHlpWcf7bJlmfyu
	rmt/sallaaZ5d6EhoOn/wj+M3ZPWbZ6TYRWuR13BGPu2QdJmNQ6w4McMHekppaLvT/QY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEoTo-00Cb8E-91; Fri, 31 Oct 2025 13:43:44 +0100
Date: Fri, 31 Oct 2025 13:43:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: spacemit: Implement emac_set_pauseparam properly
Message-ID: <c180925d-68fe-4af1-aa4f-57fb2cd1e9ca@lunn.ch>
References: <20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn>
 <2eb5f9fc-d173-4b9e-89a3-87ad17ddd163@lunn.ch>
 <ee49cb12-2116-4f0d-8265-cd1c42b6037b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee49cb12-2116-4f0d-8265-cd1c42b6037b@iscas.ac.cn>

On Fri, Oct 31, 2025 at 03:22:56PM +0800, Vivian Wang wrote:
> 
> On 10/31/25 05:32, Andrew Lunn wrote:
> >> [...]
> >>
> >> -		emac_set_fc(priv, fc);
> >> -	}
> >> +	phy_set_asym_pause(dev->phydev, pause->rx_pause, pause->tx_pause);
> > It is hard to read what this patch is doing, but there are 3 use cases.
> 
> Yeah, I guess the patch doesn't look great. I'll reorganize it in the
> next version to make it clearer what the new implementation is and also
> fix it up per your other comments.
> 
> > 1) general autoneg for link speed etc, and pause autoneg
> > 2) general autoneg for link speed etc, and forced pause
> > 3) forced link speed etc, and forced pause.
> 
> Thanks for the tip on the different cases. However, there's one bit I
> don't really understand: Isn't this set_pauseparam thing only for
> setting pause autoneg / force?

Nope. You need to think about how it interacts with generic autoneg.

       ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]

       ethtool -s devname [speed N] [lanes N] [duplex half|full]
              [port tp|aui|bnc|mii] [mdix auto|on|off] [autoneg on|off]

These autoneg are different things. -s is about generic autoneg,
speed, duplex, etc. However pause can also be negotiated, or not,
using -A.

You can only autoneg pause if you are doing generic autoneg. So there
are three combinations you need to handle.

With pause autoneg off, you can set registers in the MAC immediately,
but you need to be careful not to overwrite the values when generic
autoneg completes and the adjust_link callback is called.

If you have pause autoneg on, you have to wait for the adjust_link
callback to be called with the results of the negotiation, including
pause.

phylink hides all this logic. There is a link_up callback, which tells
you how to program the hardware. You just do it, no logic needed.

	Andrew

