Return-Path: <netdev+bounces-170707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345FA49A51
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8331891AC1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B9E25E471;
	Fri, 28 Feb 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zlYoCj6p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82E1D88DB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748485; cv=none; b=UrAvcU9BrxBfzv54o/EayYp7/VeBtJUlLtwCQQkW2G2WYaarNnCT6YGqPpWe2EF8uQYpPvOJ9eff2snYfQHcOV+V5V15RDJlKOG48ywv6hxlc9H2h5WnM5v/r6xopVSOPUr+0oUZ0specLjJBStN9An2ERhNnam54oarUY0eX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748485; c=relaxed/simple;
	bh=FwmjenOu1K9mMi2VqRbwapt4b8ZQXy8NtpjR6zVT6xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPwwuZEynaDDjt5T+GZMn5jMICKBIXC+Ig+NhtOYjdXOfFo+b7D7r09wSb3pgrZFaFPcGvfVmblMbS9PuOVjuFy+yzngWZOotV5tueH/nzQ44NKxnGPIUVhOwyikzoM2TrfBCbBLlgJL+SsdKSsaManqoUmdCw6by9qPz8qquaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zlYoCj6p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=98hCqnM7PvtH1WOmu6PCfn1BDMnhpvymPcyHlxtBppg=; b=zlYoCj6pLOyE34hE3h5gS2SFIK
	RCJGF2jbyFEXUXJ6qcVFmP9+QrXW/tC8XEvP4rHVeOGo5cXXSCckCy7ldTLGJp6Os2YKM33YobwmT
	YJKjAfercPP9677cfJpruUJdD9onvYv+ZrK9iZD6S+mr2U26K12K5EpHZGv1vR9+O9ZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to0CD-000wqV-7Y; Fri, 28 Feb 2025 14:14:29 +0100
Date: Fri, 28 Feb 2025 14:14:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 1/5] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <7706823a-a787-4c7e-a6ac-9a4feaf76dee@lunn.ch>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
 <E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>
 <20250228153122.00007c75@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228153122.00007c75@gmail.com>

On Fri, Feb 28, 2025 at 03:31:22PM +0800, Furong Xu wrote:
> On Thu, 27 Feb 2025 15:05:02 +0000
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Phylink does not permit drivers to mess with the netif carrier, as
> > this will de-synchronise phylink with the MAC driver. Moreover,
> > setting and clearing the TE and RE bits via stmmac_mac_set() in this
> > path is also wrong as the link may not be up.
> > 
> > Replace the netif_carrier_on(), netif_carrier_off() and
> > stmmac_mac_set() calls with the appropriate phylink_start() and
> > phylink_stop() calls, thereby allowing phylink to manage the netif
> > carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
> > methods.
> > 
> > Note that RE should only be set after the DMA is ready to avoid the
> > receive FIFO between the MAC and DMA blocks overflowing, so
> > phylink_start() needs to be placed after DMA has been started.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
 
> XDP programs work like a charm both before and after this patch.
> 
> Tested-by: Furong Xu <0x1207@gmail.com>

Thanks for testing this.

Could you give a little details of how you actually tested it?

The issues here is, when is the link set admin up, requiring that
phylink triggers an autoneg etc.

For plain old TCP/IP, you at some point use:

ip link set eth42 up

which will cause the core to call the drivers open() method, which
then triggers phylnk.

The carrier manipulation which this code replaces seems to suggest you
can load an XDP program while the interface is admin down, and that
action of loading the program will implicitly set the carrier up.

Did you test loading an XDP program on an interface which is admin
down?

	Andrew

