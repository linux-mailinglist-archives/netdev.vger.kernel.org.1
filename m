Return-Path: <netdev+bounces-197035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB3AD7684
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFEF7B4BBD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1829A331;
	Thu, 12 Jun 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yjg2uiYF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C91EE033;
	Thu, 12 Jun 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742435; cv=none; b=Dgoz3WcFQiAWoNX3qv2cp0qFTiEDsFSHzBJxkPpKdwEy0vWoEf9njWHA9oyAA+LQbXXYkLHRMsDDE5YgzGsVOnosYv1qqwFQrsD/soeJXTe8+drAeeA9htLe/pbZFYM86lFvZhZiyjy/pZq2khPYOfr9WHikEWop7IqX3bTfZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742435; c=relaxed/simple;
	bh=+DNCBvsfLjxRPcow0XfuYtQhzO3eWDE97Zuk75d8x6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnjg4LNdrRfSdQJGqIlgQyFtVa5zT2SuzIwS4GK3QWOiMg0SwsvSHMVsuy8Swk/lVcdP05P3kA59JVstC1CRLXAWRQkdjG3+pzHss/ruids2tV0+LfUCHGX4/6Z/Um2Cf32LhxVqn/prq/uyM338Y+Evc2qyKuPZGyAW48kAPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yjg2uiYF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2PkK9SwGCsq/VV6HXTKETbkasnoCs7bg2c1XGqVetyE=; b=Yjg2uiYFPI4G4aNQhtnPjs3hv7
	Qt4m3D8vw6uOtFoTfAZGbZhDcI2vPaikPoiNCRY6D/JOvC84RjsldtJe+f+6FbdDPyjeJGUhUTi91
	2G2ARm2bWtdWuftfNPgVcrnTV+/l/yujW7nMoSDJkFnUM2WhkcB6+5ruP6bxfQiaAMHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPjw0-00FYnj-Bv; Thu, 12 Jun 2025 17:33:44 +0200
Date: Thu, 12 Jun 2025 17:33:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: dp83tg720: implement soft
 reset with asymmetric delay
Message-ID: <5a74859d-5364-475b-992d-62c074f7dcef@lunn.ch>
References: <20250612104157.2262058-1-o.rempel@pengutronix.de>
 <20250612104157.2262058-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612104157.2262058-2-o.rempel@pengutronix.de>

On Thu, Jun 12, 2025 at 12:41:55PM +0200, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Add a .soft_reset callback for the DP83TG720 PHY that issues a hardware
> reset followed by an asymmetric post-reset delay. The delay differs
> based on the PHY's master/slave role to avoid synchronized reset
> deadlocks, which are known to occur when both link partners use
> identical reset intervals.
> 
> The delay includes:
> - a fixed 1ms wait to satisfy MDC access timing per datasheet, and
> - an empirically chosen extra delay (97ms for master, 149ms for slave).
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

