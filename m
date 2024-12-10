Return-Path: <netdev+bounces-150485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3C9EA69A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5A7285D1F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAE51BEF8B;
	Tue, 10 Dec 2024 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYOgPVb9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F419D070
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801284; cv=none; b=WvjvBZMLQ6oNxkCpXfm/bLa7acyN6kAN/eqJsyzZElEJtPSPEUoDPBAAX/62jeRCYFf5q7dVWVY8nEF/f9Z5TW6T154X+3mlePrHfjXGhsJHGzyn4rqptKhXYUxdQmOzq1oy4+pVaBjlk9KCrgazGcojfo/P3N7e2GC9RV61U2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801284; c=relaxed/simple;
	bh=k0UIX8zK+nussM2hP1dIk0m+VLQXYXtmDUL5Gi+e22Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEoZ14REbN0QDctcC+XdEluIXQmm/aV8rugYDb0tRexuzzydyFOTZx4l6X+HIg0GpqZg2GFoDV9H3jmh444mdxLANq/tKCNpO+NXBNLgKsBvIWehkku0J2ydW9grJ+5T9+P+81jdJuha+8pCgvh4hFG6YVFs0E70rR0v7S+8Y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYOgPVb9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0aASkSBPxKvRbqPpf7SCoNH0WF1VkAgfnSfPnzUa07o=; b=tYOgPVb9ZPlJoNncVyzZqnZibf
	lq/msi7wiazkvn/ucPAnWmzgDT0iZZeVghFLhpxWMDCRV1kcW0B/xmDf0738poOO8ARqC2XXybnE/
	FvKWjsjEJwcBWMPCo287/J3Tt9Uu2N6XpzxLXiBMFqs86NTS59U5GoBi9wGWx1Z4dfW0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqui-00FkcY-OO; Tue, 10 Dec 2024 04:27:56 +0100
Date: Tue, 10 Dec 2024 04:27:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 08/10] net: mvpp2: add EEE implementation
Message-ID: <ed170443-b764-4a5c-b0a8-84a740d78c65@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefx-006SN7-U2@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefx-006SN7-U2@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:53PM +0000, Russell King (Oracle) wrote:
> Add EEE support for mvpp2, using phylink's EEE implementation, which
> means we just need to implement the two methods for LPI control, and
> with the initial configuration. Only SGMII mode is supported, so only
> 100M and 1G speeds.
> 
> Disabling LPI requires clearing a single bit. Enabling LPI needs a full
> configuration of several values, as the timer values are dependent on
> the MAC operating speed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

