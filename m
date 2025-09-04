Return-Path: <netdev+bounces-219891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1137B439C4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857F0680B8A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96852F83C4;
	Thu,  4 Sep 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZdR2EzMX"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800272A1B2;
	Thu,  4 Sep 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984841; cv=none; b=JiRx/qlnGZIWkfIjC+2Er7x97Sgxu1Y0ZrcP9lwVYQaVUey71mCfbNJihRxmHeW10FTSdL4YBWMGXcM4NeTy9fxwQISyzhZonujZznXpNZblAgteUBfTyb6EshLgy4memwWuoINsnEDj8W7lmY+DzNDxiLrDUHvaxsf6FsSQWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984841; c=relaxed/simple;
	bh=VX1Qorr4cLCVKxPq56XPUJlujQHb0CreFY/Z5gKIYUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwRr/w4diFbu4WSc9edg+MeILlVOz2vyRVB7JZY72PQyEBMKlRNNuvjKvsX5rpCDaGBIq/QO43gD1kFiZOZYGhF6DpiiJ4ocn7Z0mHRTlyGPE0aB2lDsGqKBalL0ifXtdflOd2kQCBDEjPo5ox9I0HdogfGpS+lA2KmdkiB6cnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZdR2EzMX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1919520575;
	Thu,  4 Sep 2025 13:20:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiYsnYBqwS5a; Thu,  4 Sep 2025 13:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756984837; bh=VX1Qorr4cLCVKxPq56XPUJlujQHb0CreFY/Z5gKIYUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZdR2EzMXKNwMV0GD4t+UBqKkew284HTouolI5UMo3Nzd8iCtUBbc/XUbI8E39Cmxd
	 U6mxlFG727uVHvXfbvpDNK5TP58JclnlusDCngy9wBIFwF4lp7jtkCuKKLgUudAySd
	 tF63jMXOwagGkOyOBNun2B1ceVUfRR/7nkWxrIVx4sdBepH91ZPRkBDsZLVnPR4qCO
	 vFn0uecDRhRw7CF3vKHEht6yk/+RlYEEEQRybNW/Lg1ixSRPBVpaXs9Cqc2JRyRQiV
	 37w/UvDUU7ZvZnIf7Lec27pnDu1/rCWKbBo3vaL9n30qr5wOAdycsW6f0i07gDAwKE
	 mJ0WBo+ZnQAsQ==
Date: Thu, 4 Sep 2025 11:20:28 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLl1_AjVZus5wx0M@pie>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <20250904103443.GH372207@horms.kernel.org>
 <aLluvYQ-i-Z9vyp7@shell.armlinux.org.uk>
 <b0f9d781-6b8f-49dd-bfa1-456a26d01290@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f9d781-6b8f-49dd-bfa1-456a26d01290@rock-chips.com>

On Thu, Sep 04, 2025 at 06:58:12PM +0800, Chaoyi Chen wrote:
> 
> On 9/4/2025 6:49 PM, Russell King (Oracle) wrote:
> > On Thu, Sep 04, 2025 at 11:34:43AM +0100, Simon Horman wrote:
> > > Thanks, and sorry for my early confusion about applying this patch.
> > > 
> > > I agree that the bug you point out is addressed by this patch.
> > > Although I wonder if it is cleaner not to set bsp_priv->clk_phy
> > > unless there is no error, rather than setting it then resetting
> > > it if there is an error.
> > +1 !
> > 
> > > More importantly, I wonder if there is another bug: does clk_set_rate need
> > > to be called in the case where there is no error and bsp_priv->integrated_phy
> > > is false?
> > I think there's another issue:
> > 
> > static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
> > {
> > ...
> >          if (plat->phy_node) {
> >                  bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);

This is the only invokation to of_clk_get() in the driver. Should we
convert it to the devres-managed variant? And rk_gmac_remove could be
simplified further.

> > ...
> > 
> > static void rk_gmac_remove(struct platform_device *pdev)
> > {
> > ...
> >          if (priv->plat->phy_node && bsp_priv->integrated_phy)
> >                  clk_put(bsp_priv->clk_phy);
> > 
> > So if bsp_priv->integrated_phy is false, then we get the clock but
> > don't put it.
> 
> Yes! Just remove "bsp_priv->integrated_phy"
> 

Cheers,
Yao Zi

