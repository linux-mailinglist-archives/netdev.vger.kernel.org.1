Return-Path: <netdev+bounces-170365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04A3A48565
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE393A45F2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BC1B21AC;
	Thu, 27 Feb 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PbygpNzG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C41C36
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674457; cv=none; b=XiZp+VDWQYLHgCAjD2+RDxR0QGu5UWu9JkOW0L4Usb0xM9SqPD7OEMX/HomlxZVq4Uh6Cyh/QlwGGnN8jhSY4QuggJxuW8RqnwjrtyePw7mkYsb8ItITiKRGLe0yorVIESOyCXkHdwzftQQj0G/Ngbh6VFH6bbaRMXMWwros+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674457; c=relaxed/simple;
	bh=MaaN4HW6LMAvvms5cZBtqsXq+ct4xeTEHry/UnpaJDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCTy4XdoU9LntOG1dxfGcU4PozpwZiE9Qu4yxlGu/+j5g2/pqZl1PJSD5NAEngh9CTYVJdrDEip6/c+G8W2yYKuj7L+V0rjEXvsmQ6D8DqT2gUpflJN0jRnyIWXct0aPrnv45LVlZA+fyc7SbKtALUCFck2duw9VH3NQ755tlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PbygpNzG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C2N8OHLgj4P9XJtd6/4SwaIpkmO2sCL/Gv53HEvD6is=; b=PbygpNzGqrz38DKGk6RjWo2YUv
	KUC/Nczi5YHbe6jcI9FROcL7Ur0Hx4JOmQ9PNFkwf1a5MwK6SAUvaYmk2btAVNqvwT3HxJGLUv2p2
	doMO7W5y0a8SZnQd2DyMZXKgDVu/EtO6ncNCGtKQsm2Xhz+0iiG2p8a/MDjdk6qnFhOY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tngwJ-000egZ-TX; Thu, 27 Feb 2025 17:40:47 +0100
Date: Thu, 27 Feb 2025 17:40:47 +0100
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
Subject: Re: [PATCH RFC net-next 2/5] net: phylink: add
 phylink_prepare_resume()
Message-ID: <63d53c33-f440-45bf-9fc8-15f5162e5cf5@lunn.ch>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
 <E1tnf1N-0056L5-2X@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnf1N-0056L5-2X@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 02:37:53PM +0000, Russell King (Oracle) wrote:
> Add a resume preparation function, which will ensure that the receive
> clock from the PHY is appropriately configured while resuming.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

