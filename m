Return-Path: <netdev+bounces-244014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48ACAD534
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 14:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1538C302819A
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3A178372;
	Mon,  8 Dec 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ko9nLS11"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89911CA9;
	Mon,  8 Dec 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201640; cv=none; b=VQVN7NbtIbFg/CaHfZ9ko5js55lbSmWyc8umCS7twXxKP1KTQHZYYm36BX+KWBDbUd61cXznirvs/T762MgjB5828NVZ494j/haq/nQzvjw720g4T06vIt6dc1RQqsINkX2FYcvmE9izqJVT/puD95XRUSzJJ6MqqI0dl76VcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201640; c=relaxed/simple;
	bh=BixCg0FwJGLbz+Ld0NlKlqiBPAQag+qVD1dy3b/ixzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTuQljhgl9grAARb5seznEZY8j/gRZl2BhMfX143XernIRya4bTUje1h3XOIHMhqHwD4Z1bO+k42JrJlVtfyE4/eJzb0k6sDTJMPBvhkU6D7g9NSsxWeF4vTgOZ94xkoYBd4ABrSza86pdzJ1AMTSf/6iQfw+9Khm+XtsATE6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ko9nLS11; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A/sml+u6a8CEZsJFpF3d5AMtMazVBG0Mrdny6cktA2Q=; b=ko9nLS11fjpRJtP5ZP4Kif3Ed7
	pWgzCrQ8dYO8fzp2in8a69Z7yuhGG0c7SMlpivS1hnC3oWaXuUR/tuVW5V3Ikbmu9SPJazlbMl4jb
	Wt7nNgjpMPpM/7L8Irnqv8ubW3bdbxVwoIjVU0392LbCuhcWZFpq/OIxA0K00Tu8WG9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vSbZf-00GNYB-T0; Mon, 08 Dec 2025 14:46:47 +0100
Date: Mon, 8 Dec 2025 14:46:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Potin Lai <potin.lai@quantatw.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <57860c7c-2294-4ea6-a998-8bc92dda2ed2@lunn.ch>
References: <20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com>

On Mon, Dec 08, 2025 at 02:49:56PM +0800, Jacky Chou wrote:
> The Aspeed MDIO controller may return incorrect data when a read operation
> follows immediately after a write. Due to a controller bug, the subsequent
> read can latch stale data, causing the polling logic to terminate earlier
> than expected.
> 
> To work around this hardware issue, insert a dummy read after each write
> operation. This ensures that the next actual read returns the correct
> data and prevents premature polling exit.
> 
> This workaround has been verified to stabilize MDIO transactions on
> affected Aspeed platforms.
> 
> Fixes: 737ca352569e ("net: mdio: aspeed: move reg accessing part into separate functions")

That seems like an odd Fixes: tag. That is just moving code around,
but the write followed by a read existed before that. Why not:

commit f160e99462c68ab5b9e2b9097a4867459730b49a
Author: Andrew Jeffery <andrew@aj.id.au>
Date:   Wed Jul 31 15:09:57 2019 +0930

    net: phy: Add mdio-aspeed
    
    The AST2600 design separates the MDIO controllers from the MAC, which is
    where they were placed in the AST2400 and AST2500. Further, the register
    interface is reworked again, so now we have three possible different
    interface implementations, however this driver only supports the
    interface provided by the AST2600. The AST2400 and AST2500 will continue
    to be supported by the MDIO support embedded in the FTGMAC100 driver.
    
    The hardware supports both C22 and C45 mode, but for the moment only C22
    support is implemented.
    
    Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: David S. Miller <davem@davemloft.net>


    Andrew

---
pw-bot: cr

