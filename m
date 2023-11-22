Return-Path: <netdev+bounces-50204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBA7F4E90
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6201C209CC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A69C4F1E7;
	Wed, 22 Nov 2023 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wUKDfOc8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86483
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BF8LIow8S2YwEB6A4VJN2w9mgjS/WdejDLJug/cnkH4=; b=wUKDfOc8kMlrvbyiKq4+ovgIIC
	hVw5Lae0b0TxRs9oCt/TC6Z2GTnIBEKWXKpmIGKiew8TicN4N2QahDXUmSAGfhGS8+Uu1q978rfcs
	Zh8BJM97YHzzcs5HUm9sjw2AvFJ3fJ7uHkLIU22sits6QaMmaHBU3lWNy5V9/7KWRP2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5qxa-000tei-Cm; Wed, 22 Nov 2023 18:24:22 +0100
Date: Wed, 22 Nov 2023 18:24:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/5] net: wangxun: add flow control support
Message-ID: <7b82a7a0-3882-4c6c-903e-1b43d8a7fc34@lunn.ch>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-2-jiawenwu@trustnetic.com>
 <6218df6e-db11-4640-a296-946088d32916@lunn.ch>
 <ZV4ssdbQyxtYgURN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4ssdbQyxtYgURN@shell.armlinux.org.uk>

> However, if autoneg is supported, but pause autoneg is disabled, there
> is still the need to update the PHY's advertisement so the remote end
> knows what's going on, as documented in the user API:
> 
> " * If the link is autonegotiated, drivers should use
>   * mii_advertise_flowctrl() or similar code to set the advertised
>   * pause frame capabilities based on the @rx_pause and @tx_pause flags,
>   * even if @autoneg is zero. ... "
> 
> You are correct that when !pause->autoneg, tx_pause/rx_pause are to be
> used in place of the negotiated versions.
> 
> Also... when getting the pause parameters, tx_pause/rx_pause _should_
> reflect what was set for these parameters via the set function, *not*
> the current state affected by negotiation.

All good reasons to just use phylink which handles all this for you.

    Andrew

