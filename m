Return-Path: <netdev+bounces-232239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FDFC0313F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57803B12FB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599B34BA32;
	Thu, 23 Oct 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="288TDzpZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697B34B689
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245483; cv=none; b=kq76Ot/q/MjJ4FVO3Y9xDJpHC38L2rhab2tcfGgtUTb+IPS1R1HNFLoVyVejd+1Le/ektSH4fjj64SZneUrU3b1OJcO/ftEKyZc/Ibvznwwk+GGHKtJ+z0rbWu/Am6MlLapR8ZhzDol70fnAx6DaHSDtbj0XLU4p4x87vBlZP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245483; c=relaxed/simple;
	bh=cyyr7bRTRYRQr8AiGsqXqWla1mPfJbBTFF8RlU7TqMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGh7OjyATCHQw1mf/+Hlrc9bZcXLuGWNSkVOWr97JXUXl6cJV6lZMPjyceiND35XLTLHH7brhm55CEz7fsuCT1FNCUq9EZlJL90Ep+E63oCjkqiHXXAM6je5uIDUFI5xSj1WTMPoG+jOGZH18AGP22ZM26ek03i7QlA0r6p3XHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=288TDzpZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Imtfjv6ozCla3tj9/fUxCprWInsmyrRWdm7p+iTQCJM=; b=288TDzpZCmhUsvHKFbzcxMQzHi
	21uxLNDcy74IOZKNdBIeNEUAyu+w5x6c+BbenRa5FxjwzbKkOapZtKd8NHXYnPuArSgyc9dWG3bpu
	+StLVPnRipEpM7m1R+8Xs4DjcQkGssoTivGPI5AqVT/Ac+ZePW6yvxbdSyJbCkKZJpFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0P3-00Bud4-6k; Thu, 23 Oct 2025 20:51:13 +0200
Date: Thu, 23 Oct 2025 20:51:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 6/8] net: stmmac: provide function to lookup hwif
Message-ID: <13c82898-eaee-4210-998c-e73efadcd31a@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlV-0000000BMQG-3WuD@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrlV-0000000BMQG-3WuD@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:37:49AM +0100, Russell King (Oracle) wrote:
> Provide a function to lookup the hwif entry given the core type,
> Synopsys version, and device ID (used for XGMAC cores).
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

