Return-Path: <netdev+bounces-182892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F9A8A488
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7AE1901630
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515142820B7;
	Tue, 15 Apr 2025 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1HAhl8l/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2D218AC3
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735893; cv=none; b=IMZM6jvr1Zaaxq9jARe8tfp9vKeel9gbbmSwXioWerhn08DhDnfLE22psbareDwojOHjCyML2KHRGPygluhom2Roozl6+UT1+Kj27eIlLmLyfWgX+8BE/W6PO4+ZUgTxBm9a2G/MlnMb2X7w4KfYBQWKLxDVtNZ6p/NbHvI2Eis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735893; c=relaxed/simple;
	bh=MtUER0SedHtkRT2yqcHTn2W+0wXmxbuWr6UGgnvEMX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATLMWw8iELJxHaGu+nJH+V98bfqP4cJoPWy2BPlczH4qJOBCQ1m1/HxrCiTHs8EWEtrCn9MzhTvpQBUz+i6opCddwqqCsIqE1+KPudaLlc8DpWCIbAAAILYGQhsc3QKAspxxUXZ5VL3WJthSIuKqYns1qUPUOVNOf0DOAelYzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1HAhl8l/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XBB1BlM2ZSZNNZTolYC0ypXeC8yVZSlnTfMScG9hK94=; b=1HAhl8l/XHJQy6NLH84HpJMGps
	I1FFBDGGv1jZinKFmrkQ1bORirjMQ0fvzhw6BfKWq5DInpGXQsZCMkB9XA5kFZbTi0xhWycvgrPsE
	jnX6wAkQ1OVEC08NyDD8Rg7YmmiCBu2AelClQ8jYdQYv+2w7zSal25x6nDhHnLeuKK14=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4jVD-009USO-Cc; Tue, 15 Apr 2025 18:51:15 +0200
Date: Tue, 15 Apr 2025 18:51:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: sti: use
 phy_interface_mode_is_rgmii()
Message-ID: <1a6fa56c-c4f4-4bb2-8715-d9acddc3cef0@lunn.ch>
References: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
 <E1u4jMd-000rCG-VU@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4jMd-000rCG-VU@rmk-PC.armlinux.org.uk>

On Tue, Apr 15, 2025 at 05:42:23PM +0100, Russell King (Oracle) wrote:
> Replace the custom IS_PHY_IF_MODE_RGMII() macro with our generic
> phy_interface_mode_is_rgmii() inline function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

