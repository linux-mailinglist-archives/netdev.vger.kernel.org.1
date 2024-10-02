Return-Path: <netdev+bounces-131326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47098E16C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA141C20D00
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0A1D12E3;
	Wed,  2 Oct 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="15aKT5jC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E11D0F62;
	Wed,  2 Oct 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888485; cv=none; b=R4rZWf2o92KRFkB4NfmJp/BJmTogkckpWRwZB2cB2XtwkVc9/cxVODJnfVreOvZnqcSaRCGpmmaqBvyX7dCQeHP23fa+0w16HTiFho6VompUo99GSiTdHh2Rcy5PO5FC+05uqVipZf34TJ4VwZvhImlE4q00aB1WIvAsZBi0LoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888485; c=relaxed/simple;
	bh=EYujpKQbNzUkfBCCsHNvUSCiAKiRzvNKI9WW/srC5E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIadwY4palmzrecClxFnIooySMw/QfV94MdlXGPF5Jc207xFXJoXDnp5f6lNOQTsHWNcGmxeijgozUMJONZ6ygdsU6lZ52s6W2XT7R49d4ZJZm6cCFE7r1a1pC7Sy/VFbYuGJOHDUkAI2oxSTb74d0biTsYuN4ccUeaCM9Wj4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=15aKT5jC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ydOeNRKB43UBwyJvuLLLoFIUKNtePMnZkhXz5aYLf5U=; b=15aKT5jC8QhbCq4Ikan76yWAIW
	cUKL04mp/Ib4LVJBZULEMp/Nn0GW7IekjWiFoTi2DZ2Lq7faJxXFXTx2zCyp8t3BCe5SPn+ZMhOOT
	GGSTd6SkF3pdhlzhEj/dim7EI5rgQjMsjyVY4Zq5BdrxZiXEUJIBnpC9ynOPi9/6rP/I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw2j1-008shp-Oe; Wed, 02 Oct 2024 19:01:19 +0200
Date: Wed, 2 Oct 2024 19:01:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ingo van Lil <inguin@gmx.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dan Murphy <dmurphy@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH net] net: phy: dp83869: fix memory corruption when
 enabling fiber
Message-ID: <2595456f-c55a-4de6-be2d-8d544f453b18@lunn.ch>
References: <20241002161807.440378-1-inguin@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002161807.440378-1-inguin@gmx.de>

On Wed, Oct 02, 2024 at 06:18:07PM +0200, Ingo van Lil wrote:
> When configuring the fiber port, the DP83869 PHY driver incorrectly
> calls linkmode_set_bit() with a bit mask (1 << 10) rather than a bit
> number (10). This corrupts some other memory location -- in case of
> arm64 the priv pointer in the same structure.
> 
> Since the advertising flags are updated from supported at the end of the
> function the incorrect line isn't needed at all and can be removed.
> 
> Fixes: a29de52ba2a1 ("net: dp83869: Add ability to advertise Fiber connection")
> Signed-off-by: Ingo van Lil <inguin@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

