Return-Path: <netdev+bounces-121108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1995BB82
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28156B28509
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201D1CCEC9;
	Thu, 22 Aug 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="160SO6eO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D81487F9;
	Thu, 22 Aug 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343194; cv=none; b=D1jKWts8OcAbWrh2t9x3L+m1jP/v/c5tfETMCU/v/4VTsZ5Aa+GXWhY7dexrLSlXQ4HtBD509j1rK83GltYsP0mHD3hAbUcX8E8huI4uPOrMi5BaMTiYkqQpDmghql+VgVLOychR6kmDJRzj+NxPsUjG0tyBeOT671TKqSUUXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343194; c=relaxed/simple;
	bh=gQWNOb//RYrpQZlZ1I4cKZSM/D/A6UaSyk7VBdey7LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFHpYRMBBMPR2FgqI2EK3GgLGf1qSAyZ5VinsFz3K+bjHEgzVNCUDc4TqheGL+D7ZXz0hlALVHUn71DK/5Q7Z8XZMJ4Z4B1SrpbJZaMyDm6pAwqc2lbGCu+qKjJJTY6wHWJ8w2k3QkZXkeA2Y7TspQc1e9cSoZklgdylmjmmuiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=160SO6eO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LzqzqZPgFTc0ft8eu5I+nzlZRP0VfxE+JMNsWuvF/WE=; b=160SO6eONh0We/lArSumkynIk+
	v43dobgxIkR7syktd9QhKRBbVpWvJVfDlxrm3KzV/Yfe4lyO59TqYO8dvoqu5lZ8B1WBwTfRYtReP
	yJv30YGDXHMTJ/K+XAuKFXG4FvcpCeu6r+Gby4iYRuF/V0pbvnq9xTPriAFH1Eeq3g/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shAQo-005RwN-Pt; Thu, 22 Aug 2024 18:13:02 +0200
Date: Thu, 22 Aug 2024 18:13:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
Message-ID: <7f8679f7-5450-438c-98d7-06ca09cebbcd@lunn.ch>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
 <20240822093334.1687011-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822093334.1687011-4-shaojijie@huawei.com>

> +void hbg_phy_start(struct hbg_priv *priv)
> +{
> +	if (!priv->mac.phydev)
> +		return;
> +
> +	phy_start(priv->mac.phydev);
> +}
> +
> +void hbg_phy_stop(struct hbg_priv *priv)
> +{
> +	if (!priv->mac.phydev)
> +		return;
> +
> +	phy_stop(priv->mac.phydev);

Can this condition priv->mac.phydev not be true? The mdio bus setup
and connecting to the PHY seems to be unconditional. If it fails, the
driver fails to probe.

	Andrew

