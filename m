Return-Path: <netdev+bounces-197042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB428AD769E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC6B3A262C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8525F2BEC3B;
	Thu, 12 Jun 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TlKf7MXF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41742BEC34;
	Thu, 12 Jun 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742506; cv=none; b=kPPLvBUduug+DQBzJXMSY5QZAIRYNhFiX4djksplRQZiieJ+BbHty/3Ci5i0ydjYYXDj5ZwUcFXsz0NKNNdR+V8VT7xCYGl4WUS2ttpWYZssCTyVvVyTsOC5RH7bjU8lT4YVjRyKgSYDfPntvhZGowB9spmArwnUeCQSN2Vobvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742506; c=relaxed/simple;
	bh=oR30sMB3apJLZroHpS5Z433ClkjUIogihHlAImD2zDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyJlQBY9Ts7nv+hEnl16omCVIDjJmD8VGb2sHWjGVUqgZgFYDuB1EAl6rDI4xX8UI6e4KOk5pVmF/A8cs9R8ByDIF1HE6FpSGehg8LTWsCTintS7+HOECqZNOPMq0u91Ei9pi6cRk7bZH0HZu47B18peewQijM6tVL7N4nYDF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TlKf7MXF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=14HKFxr1P9LFfEJfHXTUwEKl/fFHkZOWWgIfViNx+dE=; b=TlKf7MXFyCZ1/8tD3RwLc0sjFJ
	ODIdJLeuQZAsFh46Zcly9ukIXre0EO14RWpTz42tEct9/otLDVBw7dKa6L+HttQr5+aob0iNwz8Ar
	pVT/aFEgY7B2+ttH+2qAx83pRq1b0TSgBd+78zGJTQCa4CWzxkZzB0szRaI55p3rwGUE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPjx9-00FYpp-3b; Thu, 12 Jun 2025 17:34:55 +0200
Date: Thu, 12 Jun 2025 17:34:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83tg720: switch to adaptive
 polling and remove random delays
Message-ID: <e2e91c7e-c201-4fbc-9e5e-e967b6c52e8b@lunn.ch>
References: <20250612104157.2262058-1-o.rempel@pengutronix.de>
 <20250612104157.2262058-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612104157.2262058-4-o.rempel@pengutronix.de>

On Thu, Jun 12, 2025 at 12:41:57PM +0200, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Now that the PHY reset logic includes a role-specific asymmetric delay
> to avoid synchronized reset deadlocks, the previously used randomized
> polling intervals are no longer necessary.
> 
> This patch removes the get_random_u32_below()-based logic and introduces
> an adaptive polling strategy:
> - Fast polling for a short time after link-down
> - Slow polling if the link remains down
> - Slower polling when the link is up
> 
> This balances CPU usage and responsiveness while avoiding reset
> collisions. Additionally, the driver still relies on polling for
> all link state changes, as interrupt support is not implemented,
> and link-up events are not reliably signaled by the PHY.
> 
> The polling parameters are now documented in the updated top-of-file
> comment.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

