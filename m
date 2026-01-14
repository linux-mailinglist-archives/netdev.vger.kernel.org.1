Return-Path: <netdev+bounces-249869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4FBD1FF60
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EAA23049198
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B4D2C159A;
	Wed, 14 Jan 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v9kfuXaK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596692D77F7;
	Wed, 14 Jan 2026 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405805; cv=none; b=H3h/wfIx5z38xvnIMHBLIjdQkp5bmP1lxfrYypohcSLRSrpGMJ+mkfJYegDK2ud6JWSbNBstq0xgzRD2Frjc4XSCQDqpZjhG3bnT5d6BmfSeb4b64pybHuTsp+sIv1rslCto2dbeOp/2PwWX9ZQEP+4rnk5rpJ1p4EL+oKgyT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405805; c=relaxed/simple;
	bh=OeSDAJI/bjJ60crAGDq98vsBzZqcEpglb+5NDC0JzF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiQO5wuwQud/Thj6WHWstvxzPZaK5OFPND6NFKGnNzqMmdnvAATnE3Me3rhVcRrrMJr5A6FGmaYSt15QEejfEU1U6i7Dl+YRkpGgHTA771ufjNLr/UUwdwd9ylT1yPBX+P6smax4sdqF5hEhy0wG7+DudgDqb6xQNvQs48A1ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v9kfuXaK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3MwXa/ICy6eTNMiYusHqgT+W35ycbQKAPOWz/OHAJ8o=; b=v9kfuXaKeDUzwifeWjMppAFgyf
	2AJQxzNG2MXkCroXsG70fr67XXaboxSAKehO40fsM8sUdwoUb3V9zockUzgbFD2Kk6VkbwOyCa6ZJ
	a5CRkdiiG6L9X392sNvyw3dH76jSncsN8RDyiEjo+KLSNblj0Td4zcm1N5Oz6PV3YiS8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vg37q-002oXD-Mc; Wed, 14 Jan 2026 16:49:38 +0100
Date: Wed, 14 Jan 2026 16:49:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	kernel@dh-electronics.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,PATCH] net: stmmac: stm32: Do not suspend downed
 interface
Message-ID: <3df848c5-eca8-4a57-ab35-004e59d5f719@lunn.ch>
References: <20260114081809.12758-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114081809.12758-1-marex@nabladev.com>

On Wed, Jan 14, 2026 at 09:17:54AM +0100, Marek Vasut wrote:
> If an interface is down, the ETHnSTP clock are not running. Suspending
> such an interface will attempt to stop already stopped ETHnSTP clock,
> and produce a warning in the kernel log about this.

>  static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
>  {
> +	struct net_device *ndev = dev_get_drvdata(dwmac->dev);
> +
> +	if (!ndev || !netif_running(ndev))
> +		return 0;
> +
>  	return clk_prepare_enable(dwmac->clk_ethstp);

The commit message might be missing some explanation. The
suspend method enables the clock, not disables it.

	Andrew

