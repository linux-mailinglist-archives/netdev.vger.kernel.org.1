Return-Path: <netdev+bounces-205428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DFAFEA4F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0400316F4A9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE822DAFB4;
	Wed,  9 Jul 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PgdVTFIW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84132BE7D9;
	Wed,  9 Jul 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068017; cv=none; b=m1+GipWvICqq0pxlT4fswFUBf7DURhkvhKfNGF1NUUeQ4mvZDwWT9pIh+l6EEPax1N0OFif8owWU4aoiztxqyhpDvi8F2zjAFVuxztl1Dw16vAfj+ozWSFHyhyvH+DozNFPiy52Qurkg2sLrX5cy5hLPfZB+qAIxD+Tf24UDkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068017; c=relaxed/simple;
	bh=EAjyN1mnuQEc2DPAj9sCbgFnm9w066/f8wIgUKYYUdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGJbpcvBZauk1bKGWpqwUbBqotTvWcy68ww+0eV2tKrUI2fzFxAahp+7pkk2Olex8aVdyA/9ejt9XJNKR7dUhp/VMIo2BrUlQAXgRHcEni5xoMfAr6ZIXmfS1OZKnlL2L2kmJ/xSC3V+kJ96z9kMvpXt3urbJtzG3Xk26gSwQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PgdVTFIW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/GZOP1kf5dBhxXZChg6bf018g5kHcCt9ChDwuA2ncBI=; b=PgdVTFIWg8Ltwdn7UXhgdbd7WQ
	3oyHzL8fIi/r2E4SRo7qRg0IYkGHNAF1OmoakW4a6MvSW9vu61zW2lZMQ70axfr4Z4vWeZvUmyDmj
	M7kJfeKRGKcwDsbIwGnFWe67zjN5xfQzv1YNXhJ18ZBoLiXiLehNayNhACc/VjqyxVQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZUvV-000wfY-Is; Wed, 09 Jul 2025 15:33:33 +0200
Date: Wed, 9 Jul 2025 15:33:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <fbb2da18-0929-4c61-a940-6a3d4fbea3e2@lunn.ch>
References: <20250709132425.48631-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709132425.48631-1-buday.csaba@prolan.hu>

On Wed, Jul 09, 2025 at 03:24:24PM +0200, Buday Csaba wrote:
> Some PHYs (e.g. LAN8710A) require a reset after power-on,even for
> MDIO register access.
> The current implementation of fwnode_mdiobus_register_phy() and
> get_phy_device() attempt to read the id registers without ensuring
> that the PHY had a reset before, which can fail on these devices.

This is specific to this device, so the driver for this device should
take care of the reset.

To solve the chicken/egg, you need to put a compatible in the PHY node
listing the ID of the PHY. That will cause the correct PHY driver to
load, and probe. The probe can then reset it.

We have to be careful about changing the reset behaviour, it is likely
to break PHYs which currently work, but stop working when they get an
unexpected reset.

    Andrew

---
pw-bot: cr

