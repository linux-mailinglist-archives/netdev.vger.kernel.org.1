Return-Path: <netdev+bounces-176927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86963A6CB48
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE362188BFF8
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0E22E3E3;
	Sat, 22 Mar 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zyo0ATEK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAA70809;
	Sat, 22 Mar 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658553; cv=none; b=T0zJY3yZSfAexsqmFsfufdtDZtCfEhrYg3oPm1i5bwHUR0GN28g1InfeC+B31VOEqdg6gL0fXxqiO8/fHBWRLYvsKcniFliq9cDAEXpZCqSl0TP/Cy5PvZOA72dvM+coOQeUXNc1wygvMWzUC787ylwSDgeveWyM56ykosIBx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658553; c=relaxed/simple;
	bh=m1HwHlq45K8OiNhxw4yShMdLp4O25FjuLcAaMuSi1ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzSza3a0R2JinPjo19qGPQPAHbmWGhPymj6qkhp1yFVBDTnzbNgEgpMk1i5c0FLhN4oU1HRVKEjAUlHlUlS/BhfxZTqmk28/MKgeoGxhEo86EW7HGIKUE+CieFE4Bu5WM5/YzACLfzUImccyU+J4CW8nl9ulI270nfEIPiqK4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zyo0ATEK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pQR5o3OwQ8NpWVYSwTulEE8EvTmtbo438aEVUbRkWRg=; b=Zyo0ATEKrzLdgORgVuZPn/eM0o
	FhzsQZLPUTTMkQcDOt4E/S9PyIdp1simvRxik55XjP9nnsn8CB38z/fIhQaGxvhJumugyWzagepgo
	niYU28Z1cneeo1umYA216cqgf0F3nKm9vNtwjh5Ejrw7Cvqo0DSXb81G0PgFoqDjVGDw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tw15p-006jc0-JI; Sat, 22 Mar 2025 16:49:01 +0100
Date: Sat, 22 Mar 2025 16:49:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/7] net: phy: Add swnode support to
 mdiobus_scan
Message-ID: <676cc9cb-6f6c-45c3-9f6d-e73747661de6@lunn.ch>
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
 <20250322-tn9510-v3a-v7-1-672a9a3d8628@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-tn9510-v3a-v7-1-672a9a3d8628@gmx.net>

On Sat, Mar 22, 2025 at 11:45:52AM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> This patch will allow to use a swnode/fwnode defined for a phy_device. The
> MDIO bus (mii_bus) needs to contain nodes for the PHY devices, named
> "ethernet-phy@i", with i being the MDIO address (0 .. PHY_MAX_ADDR - 1).
> 
> The fwnode is only attached to the phy_device if there isn't already an
> fwnode attached.
> 
> fwnode_get_named_child_node will increase the usage counter of the fwnode.
> However, no new code is needed to decrease the counter again, since this is
> already implemented in the phy_device_release function.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

