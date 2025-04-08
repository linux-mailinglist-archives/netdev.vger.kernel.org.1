Return-Path: <netdev+bounces-180445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A46A8153E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996F74A4A98
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA97723E358;
	Tue,  8 Apr 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xVK+ncVX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305F41DA60F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138706; cv=none; b=eh5hlsOYxNIxFR/QwGO+xSnS+3/5chN1N9bQwQzg8vtBGHxAmj2/beqLjtNulJsfL3rihHhMDHqkyR4faudToi7vV+QjXlXSGxVo/tdcTOzcrb9aF1te6GtX9To7LeBNw1FjjxTzhgdTgVdG3VmwkVzJmmDnLp1RuBkY6yjn3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138706; c=relaxed/simple;
	bh=rNe4ynFqGQU/T8c0VCnXAfOMZsl2s6uQwqORsmiruCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtJb/HrppKv1uVCf7uZ0ILHYGFKssrPpZlJhX6rohdoO1rMT4NipAkUnSSvj39mRJQoGRVZvp40DCSOrggxRE8BSR+Zs4yBxcI+IZQ9SYsA4XNdx52Ovi5kk+VEEhng2QNTXHFPineQaOHgfxeJ6RPxPd66AatFOUf6s/qMxLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xVK+ncVX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L6ofuAtc7jkiEuSMNWEw5n9/rP+htmQbYTekNSwGVi8=; b=xVK+ncVXKeJCmefB4rPZck/cSm
	CXrBTn3k8K77hBbH4X/Rj+n+ntnZ3htDymrzcsCiuXRQveYSdz6uxi7r8lit/b/atttbS23+SEhGA
	QekG2m4mAOy0GlNlgQzwEnNs4yez634VlXU1GUn7NRYN3pp/KlqwS4bAFEYrVESNQj6A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2E9J-008RJh-SC; Tue, 08 Apr 2025 20:58:17 +0200
Date: Tue, 8 Apr 2025 20:58:17 +0200
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 5/5] net: stmmac: remove GMAC_1US_TIC_COUNTER
 definition
Message-ID: <a244ef6b-da5f-4727-8277-9b0f9b800029@lunn.ch>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
 <E1u1rgd-0013h1-Fz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rgd-0013h1-Fz@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 07:59:11PM +0100, Russell King (Oracle) wrote:
> GMAC_1US_TIC_COUNTER is now no longer used, so remove the definition.
> This was duplicated by GMAC4_MAC_ONEUS_TIC_COUNTER further down in the
> same file.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

