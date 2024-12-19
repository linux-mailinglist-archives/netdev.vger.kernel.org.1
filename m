Return-Path: <netdev+bounces-153448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30009F8034
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C8C16A283
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B761922F1;
	Thu, 19 Dec 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H2r1hJJf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF601917E4
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626762; cv=none; b=DV/j9NN0q+Bof61acA+DrhFZaWB5KEj/ylzUJCaw3T9pB5dC8ZFJrpXPHKgZJobZDpCFPEU+an2y+h7tdhfcxuh7IHRfXvbIPPBC95xSut+PVuBCweTCYMxIU6uxSfOOMZ5EiCs6Szz9tA2jnY+9S5x97Ws90NY0dX3R1GhtOTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626762; c=relaxed/simple;
	bh=aOyUkm8lYAFSmOChy3fjdO5lxCJ21jriyhb2PaZaJ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz+ANH+6rGxDuMP6EHGbTTU0u6E3oE0uRrt8nAHxo7306m0T7go+yirbt416mX2F4WnPJOPLX8DeICqPGs/l7te3/aIQJDR22D78cdnUCb9dmNg5/vekYftrJn5dTvnhxJ2W0ABZdnlBCR/mlHNG8TmpM7h2bBeTAxGKB9pyQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H2r1hJJf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mKQgOsVIimzzPyCoVOBSHq/FXMN9gWsrOCGDS89SJbM=; b=H2r1hJJfvE9t8jyAQJ392o+Fd5
	+OSnU7j3IyeDKgvtI8nrfCHMnexqq+nAQa429XxROeVwXyYddOsH95TSOiiPE+/uApKa8jmCD58SD
	glCRgzWtnyL4JIglLx93Lifu3X0EpboiT/OJlKpNK0Hci9aJFHg1So16v5Cz445J2jAE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJer-001gW4-1F; Thu, 19 Dec 2024 17:45:53 +0100
Date: Thu, 19 Dec 2024 17:45:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/7] net: tn40xx: prepare tn40xx driver to
 find phy of the TN9510 card
Message-ID: <b9de39d9-76d5-42d0-b9f1-01bacc259692@lunn.ch>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
 <20241217-tn9510-v3a-v3-6-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-tn9510-v3a-v3-6-4d5ef6f686e0@gmx.net>

On Tue, Dec 17, 2024 at 10:07:37PM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Prepare the tn40xx driver to load for Tehuti TN9510 cards, which require
> bit 3 in the register TN40_REG_MDIO_CMD_STAT to be set. The function of bit
> 3 is unclear, but may have something to do with the length of the preamble
> in the MDIO communication. If bit 3 is not set, the PHY will not be found
> when performing a scan for PHYs. Use the available tn40_mdio_set_speed
> function which includes setting bit 3. Just move the function to before the
> devm_mdio_register function, which scans the mdio bus for PHYs.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

