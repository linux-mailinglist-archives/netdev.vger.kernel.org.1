Return-Path: <netdev+bounces-183276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044FA8B8FB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3795344471F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679C2472BD;
	Wed, 16 Apr 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mgSMLOlh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E22238D21
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806424; cv=none; b=FMI4SyktIYNk7foOQV3ra1VGAi0T3PKZoj0fc+xcmQZz9FqhhLhmWtBxC1zG0Ihy9MoAt3MKMhrVHN70zLrjgEzHjcvYqqvUZhIMmkI1twvLhVbXYsvW7zapd8iMx03SqfE990TGfFkDgIzWjW8joNdssf85A+gkmuQ5AZ4xYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806424; c=relaxed/simple;
	bh=V6izAHQQ/aFGEufAytUILpMd8Pzj1r5SUFVRFYSY7zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7JU/UmpwuNzMS1xA6L7KML0NPFtFHrVpdT2teAei6EOSFBkPvx6mC6arhr+OBDfbx/bIh+OXuh9oM0pPthPvPcYuPnXkxiFM1pRcMZgZEbliFjXuKcvMIvye6L+uDvVJzVronRr6vy4rdJ2zVuY2QGhvcxEDkbwU7gd54cw40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mgSMLOlh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ba507aXTM3D8ftU0jPTQuQNiOze5+4Icq9H3hf/0NV0=; b=mgSMLOlhTuiR9KcCbEN9rF9OYH
	BGzS262MmzMm1ApgIhhwL29QbNdj43lxNz8m/wTVa96nRhW3UbTFJrSksghnjx/MCeTp4sgF5+Plq
	pPU4NhtryO9bp/yWA2zy2kFKccsqCIORBrviAR6eOb/aHAsfo6bzKFhk88JDz9dh3E9c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u51qq-009cJ9-RQ; Wed, 16 Apr 2025 14:26:48 +0200
Date: Wed, 16 Apr 2025 14:26:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: use PHY clock-stop
 capability
Message-ID: <1dc50e53-73de-4fed-a088-1b4cc728f70f@lunn.ch>
References: <E1u4zi1-000xHh-57@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4zi1-000xHh-57@rmk-PC.armlinux.org.uk>

On Wed, Apr 16, 2025 at 11:09:33AM +0100, Russell King (Oracle) wrote:
> Use the PHY clock-stop capability when programming the MAC LPI mode,
> which allows the transmit clock to the PHY to be gated. Tested on the
> Jetson Xavier NX platform.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

