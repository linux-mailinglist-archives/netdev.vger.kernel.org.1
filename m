Return-Path: <netdev+bounces-193168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57267AC2B48
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF92A544549
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1B1F582F;
	Fri, 23 May 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="srUrA/yO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49729A0;
	Fri, 23 May 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035079; cv=none; b=n+/e4ePYCMYrSOHI01flIkjMOGTTn1SqCKivtn6i0HtT9pf8IhjnXc/B10z8+E5p0L2W1Zvykj7XwLvdjAhKo/JMve5iuL3q9cP2OcIF/lTTueBIKy15VbVBkIUsb8z02zPNhMwhznDavHybDTuVNQ6fxIBKEgKLrcxMcDU+M/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035079; c=relaxed/simple;
	bh=hUAZlqsNrpUoo3ZjKqaxHRKK4SrkbxwdCQGEpnHA0S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3bDDrBp2KGYefXl5OTNB6ArzOf3F+pV+9q+NfbDFXZtzX97ESOUw2a72AXl/77ErVDaBKwXU+wZul2mZsbR630NEEWmfhHqqsjVsnS/po7acU2Ad85aFXdezXeQbOzSScgqpeXuFuB243ZvYGqOCGY6G8x+uBKX4oYD2ZqE2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=srUrA/yO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qtMwyunyZHUGki0/msWUmMjaw//FVxv4LMC9Zxm9w9U=; b=srUrA/yOxD6vdygmwl5R+px0tM
	kpDn6yIxCraoaaTc3IoGiAmoPAn4S7aHzRg/Lx4OV0Nsu33HvPKLOy5MJJHgvyrlOT4kH8H1tMcz8
	9Q0KGx0QahHgwLBnr3XsLNoBdYxOHvDHZb4CRk+k57+CrBSN4R2XWJCNQUm45yWP2MIg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIZlz-00DeRV-1m; Fri, 23 May 2025 23:17:47 +0200
Date: Fri, 23 May 2025 23:17:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net-next] net: usb: lan78xx: constify fphy_status
Message-ID: <7321c133-70cb-406f-8668-c7bd5bfb1a5a@lunn.ch>
References: <af1ddf74-1188-46ab-83c3-83293ae47d63@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1ddf74-1188-46ab-83c3-83293ae47d63@gmail.com>

On Fri, May 23, 2025 at 09:51:58PM +0200, Heiner Kallweit wrote:
> Constify variable fphy_status.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

