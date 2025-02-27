Return-Path: <netdev+bounces-170364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4AA4857D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE791882087
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D31B87FB;
	Thu, 27 Feb 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1WXalsEp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEB1B3955
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674405; cv=none; b=mo+eoyNez8fLOZktV0xv201CK1R84H2uPi8ZI8xikzi1Z5ngx4l1gs6kOtck4anSEXIOela2r0+h8179oj8o71r3epQq9MxV1OUw4xY79eCvR1nNXFr3C4AolsHNmX7YV0BgI9rSYpmA2RT2tGGo85BYQL3NDZSXbdGHduPgI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674405; c=relaxed/simple;
	bh=c914o7krR20HY/HANDdBtPxRh6uu0KWI1bYuAmJWn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ8VfD0H4yx6+jsa67Ozh8xKezmV65HUa8YM8/0KeErkdW9wPh6bdm3PhGxcLLDgQE5VW4WC2BBNDdAtcJFi5OzrOvhYLG5lXRPrb+aOCbuF66P4BKwkreGnABPpvIeM4nfoIwAnPoQK60c7GM4EHTGgWnCSkdl3hLNXBr+uW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1WXalsEp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pUdhhDhSvMAHkRpP1SRq17crgbNFJ8ekY404R3cVTuQ=; b=1WXalsEpDVasGFFkI5zqtDfCKs
	Fpwmz2P6bR6aUb/sWCI/cUtltxoy95vsnKLTYAY46x0RVtakvrLOIYbEuIlpJ4L/9OYrytNXGsCXe
	i9jHi1+TVmvZEZEP+XPpuk4InmSqTCVduKsdFQXZRc3lff1dkxa0OhEEORAYqxIyEokU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tngvM-000efO-5k; Thu, 27 Feb 2025 17:39:48 +0100
Date: Thu, 27 Feb 2025 17:39:48 +0100
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
Subject: Re: [PATCH RFC net-next 1/5] net: phylink: add config of PHY receive
 clock-stop in phylink_resume()
Message-ID: <d02d6ef2-6a84-49b5-b493-a868aa7237b2@lunn.ch>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
 <E1tnf1H-0056Kz-To@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnf1H-0056Kz-To@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 02:37:47PM +0000, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

