Return-Path: <netdev+bounces-180232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7226A80BB6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F71BC40C7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D31C5F0E;
	Tue,  8 Apr 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wt9TlUss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFB1C5F08
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117445; cv=none; b=dZPqERwr51LhaJudN6hQr5r8aw6d8xcPMtTBOualBb86/rvP2UTiQFVOGMJcpvJWMPxiO9VCre8LqNXs4xEDGBhoiPco31zj7FaQp3eHHkpdHJQDy5wzQOffzmcl4kFxfJJPekS5JTuY6nf1weG0yQoLZ124OAsz41g/l1w80T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117445; c=relaxed/simple;
	bh=tz+bfRiFhpi1Vw9bXip/ozFdm0ccAPNiviHCc0CnDU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnsrY9/3Ie6jC+hvGtz2hcaSZ6ZnJfYH3kUtQFHUU84Nia6mxh0v1kReSv+cMnJWrkSaicVgCRgDoVMhqB7BnHcUZrGmcn/rDdWXk0DX7s1w/W0IGVFQW9Ej5RlWBnegvovxIToUtwFBXxyb2/7kHr+0gc9nQn7xA8qZTBJrPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wt9TlUss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RMK/yH8vtY9JB9PL98uNHWoExGdbmiSXaviteRsYr9U=; b=wt9TlUssAAzTom2YI5g4jj6jao
	qvhMKYYF248LEQi6kjkaUHjkNJNsvn4qizo8j+Fz8jgqgblUfnAioPC1DK2I3ACnTnTcnnkZClzo4
	RG5Rm4ARm6CjKlkIvCz+Su6dLDjblITiifbmd9rMgLp3/dhsXI4eAz/b1Z3rDk0uCBUc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u28cK-008OEc-Mr; Tue, 08 Apr 2025 15:03:52 +0200
Date: Tue, 8 Apr 2025 15:03:52 +0200
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: provide stmmac_pltfr_find_clk()
Message-ID: <96479c3b-70db-4f6e-bb7c-b1ced14463c3@lunn.ch>
References: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk>
 <E1u1rMq-0013OH-PI@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rMq-0013OH-PI@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 07:38:44PM +0100, Russell King (Oracle) wrote:
> Provide a generic way to find a clock in the bulk data.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

