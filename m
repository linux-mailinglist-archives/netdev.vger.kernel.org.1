Return-Path: <netdev+bounces-108214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8658991E641
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CB71C21C69
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37F16E862;
	Mon,  1 Jul 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YX1D+n0y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC516DEDB;
	Mon,  1 Jul 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853790; cv=none; b=Mnh8XurJfliXgNWb06EIURPSbdds6nqYPO0eXWvqyiJ1vZM3ESPR4shDf/3cZS2wREcLNVk2C0LxO8j50zQVKDzSA8X7nU26PqqGVCzL2Zb2Tf4FkA5oLpNZNIMAWPcGLOmch+v4vWuCDAvNtDiUy7ik6W9FnWAXlRQ5QENv7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853790; c=relaxed/simple;
	bh=dQkhVsO4fjep5bz5yxh8YYyV7YRAO/BUP/DL0UhJJbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OswhJSAflEbgO5ZujrEFBFGcVLkROH5FTs2d1aHn/3C+Fyq9tY6V5PpvxiieZIw0+/p4M+hZkslAay1tB8PLb+bnunBbKtakaccuhS7nT+qlN3fNBH8uPfB6VDkBeLmioSnbrqWOM1TcZvQ5seoYYWe2xJKZ8G9uWBhkIcqOBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YX1D+n0y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p/89mPRQ0gX+pUOoSRTlrwC6hJIOaY6TbRnTSm81D10=; b=YX1D+n0yoylmEMjNfwK9WwVmsy
	HzTJOj09BrXXePwyBmzHL7XPAg148FCKIQZieGdM+hrD8H/OB46FCR8jDVAlLrCARvHX2gmMYKdm1
	h2UB7TyG4x3KVhE+HkxyrK3JYp0/xyRhd5N8mvlQcFAwPYMy6rUrVAsIGDKHiAXgSm0g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOKX6-001ZHa-S3; Mon, 01 Jul 2024 19:09:40 +0200
Date: Mon, 1 Jul 2024 19:09:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net: phy: dp83869: Fix link up reporting in
 SGMII bridge mode
Message-ID: <289c5122-759f-408a-a48a-a3719f0331f9@lunn.ch>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-6-a71d6d0ad5f8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-dp83869-sfp-v1-6-a71d6d0ad5f8@bootlin.com>

> +			if (dp83869->mod_phy) {
> +				ret = phy_read_status(dp83869->mod_phy);
> +				if (ret)
> +					return ret;

Locking? When phylib does this in phy_check_link_status(), we have:

	lockdep_assert_held(&phydev->lock);

I don't see anything which takes the downstreams PHY lock.

Is this also introducing race conditions? What happens if the link
just went down? phy_check_link_status() takes actions. Will they still
happen when phylib next talks to the downstream PHY? It is probably
safer to call phy_check_link_status() than phy_read_status().

   Andrew


