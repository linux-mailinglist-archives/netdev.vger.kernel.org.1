Return-Path: <netdev+bounces-232237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FDCC030FE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9436A3AF95E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08427FB35;
	Thu, 23 Oct 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SD0V44Ow"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485725B663
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245331; cv=none; b=Fbtg3yTSWl6Mmzpw26SEs3LyMynmnx2bg2EsQGZ2isqpI0kjCHxWQJuvo0r3r6Hq1WzJJfq+G1uGRtMzfgqia5y+wJHV4vkpe6rvBQjF+UEMn2sa38y5JgI5P5b8FYfO+zCFumdbv6cxlIWOu/XUEv1nocB6JBjNE6MCkjmUsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245331; c=relaxed/simple;
	bh=l6jpr7blCXabEpCK+GiMPcOf6UV1zMVqosCndjhSm9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXF+cFVLbbK6B68B9wdT3H/a+kHbnjl8lOb61kjaQnQA6GDCn9b1oilqxz8V9nBoIOW+l5sbtk3UDr5THHvgva6kXWRjxRO3lUc/Ak0Sl2xf9vPlmzjUqSgYN6XpDSg7uv6ngcCu0NDXiytm+3LX0VPcX3htTkszYmsSnM0iLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SD0V44Ow; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dmrDaKJro0x6uhv0aX4t5TErGN6XmKXzJPQ4bv4O+kU=; b=SD0V44OwJuHyQEhu8AOl6G0Vjo
	BovurPklLLT2nXo7An4OkfFG0n/DkebAT4QQZHtY01RUIjrt3nNhsOHdi/B1Bavw9iAeqF/22RXi1
	4Mnbq2FDVc8dN88XolvvVZbsvoRYxQLXbiaBtwcMgKp9FdkXnKysM5npMifSmdZCIkaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0Mc-00BuaX-FK; Thu, 23 Oct 2025 20:48:42 +0200
Date: Thu, 23 Oct 2025 20:48:42 +0200
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
Subject: Re: [PATCH net-next 4/8] net: stmmac: move stmmac_get_*id() into
 stmmac_get_version()
Message-ID: <ea5b3aff-a145-488c-9da6-da4805ef1b84@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlL-0000000BMQ4-2Zlg@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrlL-0000000BMQ4-2Zlg@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:37:39AM +0100, Russell King (Oracle) wrote:
> Move the contents of both stmmac_get_id() and stmmac_get_dev_id() into
> stmmac_get_version() as it no longer makes sense for these to be
> separate functions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

