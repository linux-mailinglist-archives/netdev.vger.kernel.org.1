Return-Path: <netdev+bounces-113856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F096D940181
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994A11F23016
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2618A940;
	Mon, 29 Jul 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pN1IFQv/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7123D9E;
	Mon, 29 Jul 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294447; cv=none; b=uxGHbU0k688bnVoIyG3+nT60ggRCGBl4T9klC0GsRNXlfn9TOh4CxBZP0KflUIsiL45XgOzd/1+B31UogQPGRP19O+Qaiwx/pVivmQ9wH/397jg1GhBIlBhPMJqjBILmI/fmjhbrP2VOU4Ub3mcVFs4YsYUIaOiW5O/SlZ6WuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294447; c=relaxed/simple;
	bh=wu+76dIXyDeWK9VV1oFB1QDq+zw5F419Q/W4teBOHyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuphLahGG2VxkBzLbC//eXdUX7RbyTaqx0pyT1t25odSAx3AwMzGKiZroSL42Rt+3L9CPhqLwhMm38hw6fGvuz70exvzp+3aw827MtEzVtCE3Xrje/w9GFUx06/m/jm01tydx23D25mCce+iv6KpovJunxeYOVuuidozGtTtaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pN1IFQv/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uvnDSeCoxZ/VdHvGtaR7kxUowgWr+OFf2PPbTw4dlaI=; b=pN1IFQv/DExrElxT9wTgStYUYk
	CO/arUWdotT7JbZ6usdTuFHPLr7uUDj6+CoukqBL59CalRKL2mytqdRZ5BjHyK+V4EVmKbntu+ubw
	ijPqMiPPCb2BdCQpmAEDAKMUAAYgchqFAkQKAyGMIisv9HTOOXjAiXJqu4VogIPsqN9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYZSX-003W3h-73; Tue, 30 Jul 2024 01:07:17 +0200
Date: Tue, 30 Jul 2024 01:07:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/9] net: dsa: vsc73xx: use mutex to mdio
 operations
Message-ID: <bf450358-1286-453e-9601-17bb2077ee88@lunn.ch>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
 <20240729210615.279952-6-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729210615.279952-6-paweldembicki@gmail.com>

On Mon, Jul 29, 2024 at 11:06:11PM +0200, Pawel Dembicki wrote:
> vsc73xx needs mutex during mdio bus access to avoid races. Without it,
> phys are misconfigured and bus operations aren't work as expected.

This is adding much more than a mutex.

The mdio core already has a mutex, so there should not be multiple
parallel operations going on. So i don't think the mutex itself is the
fix. It is more likely to be a change in the timing. Which in itself
is not good. Maybe use your new vsc73xx_mdio_busy_check() with one of
the helpers in include/linux/iopoll.h

    Andrew

---
pw-bot: cr

