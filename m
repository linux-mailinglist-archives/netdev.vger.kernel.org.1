Return-Path: <netdev+bounces-182776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D142A89E47
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8B77AC644
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716B427B509;
	Tue, 15 Apr 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OXqLhMk8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38081C6FF5;
	Tue, 15 Apr 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720615; cv=none; b=TpI9VsZ3gz0ZlNtRgrpZjR/N+PqSRfLY0gfXmiqVJcPB8y8TvqiwIBlbchasqjcf3xOl+RDPs1/683EyBTZikHXGzmyBiLi/yeeaGmgEEKmouru2syUGS7JjCtFOr54iujO8If2dHEC+HlU7/F/S087vJCyIRsOaJMi1lJtcxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720615; c=relaxed/simple;
	bh=MFKp0JFua78cCnp7Q+5fuLMpaUIPI7NiwpH0Pb2CbaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktnCU+dG6BHBtfSnCWyXSLPHfvuS9wgP/yHudig970xiaTLBNJUu8/Zf71bY0cmvYmdfyhg8WUrUYV+KPsOiJJsfoENnM13Fj4JB/c3InldZZjXy2CoZtmNXDiBRrB2hlmfEBgdC/aoUfKKPJ240yF2l4S0Rwzsw6BThgzri2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OXqLhMk8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GPNiIlieapZoa46LoynP5gB/dPNgvWO+FuJDZy8OfVk=; b=OXqLhMk89NX7IsWktAk0TKrnlh
	qvejs4yXNbyT0wjzLCVTa7hge8pRXl6btT7di2hXoXnKqLfsVC4Vwlq42AR/ub+NmQnV2O2iWKdRK
	cEilp20/wewe/jCj6gfqhPC3xIiCHx4M+Z2LtaWSiCKWl31HD76xxAdX8hkAi7Z8pk9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4fWp-009RBl-RQ; Tue, 15 Apr 2025 14:36:39 +0200
Date: Tue, 15 Apr 2025 14:36:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH net-next] net: stmmac: sun8i: use stmmac_pltfr_probe()
Message-ID: <c26c4edc-0b8c-4493-bda6-2d0530929c3d@lunn.ch>
References: <E1u4dKb-000dV7-3B@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4dKb-000dV7-3B@rmk-PC.armlinux.org.uk>

On Tue, Apr 15, 2025 at 11:15:53AM +0100, Russell King (Oracle) wrote:
> Using stmmac_pltfr_probe() simplifies the probe function. This will not
> only call plat_dat->init (sun8i_dwmac_init), but also plat_dat->exit
> (sun8i_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
> results in an overall simplification of the glue driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

