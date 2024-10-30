Return-Path: <netdev+bounces-140558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C559B6F8F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 22:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C267284ECD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53AB1E0B66;
	Wed, 30 Oct 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EKYDfn3V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740C1CF7BB;
	Wed, 30 Oct 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324820; cv=none; b=AWvpNkaEqRArjjEbLmaVvEYFubkY3e/UzuAkCaxRcSBWUaqb8+PbisGEJgGVfehkMHSjnisqkanBr8UOPmAhJ9UWi1BHMSPQ8Acc6Nfpcp5waYauH2e+lJVMHg9AUhhSW2WdfmGon2Pt7R7+8/3ROcts6nF67GMN/xP/ekSptx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324820; c=relaxed/simple;
	bh=dYnaVemO5OPTP+WAPRmhR/5ZR2REs2aQhH/k1Bn2TOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt/9or9crq2buu696AW4a2t+FBO7CyxdoCwoyJadVMQcu94/ZPlNpXumTxH7sOo2fdjH+KAvfkOWj+AyoJL+baizTQhSfGBDXI/2dJAV0tSteTg8LZr3T6QNioa8JvVv8vMmjXLD/vO+tIlmbRCgajlL352JuOnbKDVfo0Y7Ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EKYDfn3V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eaav/kHiULYtRFO7qGHqUzM2GyuXCQUp8En/mARPwCQ=; b=EKYDfn3Vh58p9C5n1lAe40Lvqf
	ucFYM5n2r+44VJfBuIUPFlcpOTPfwsyXCjnQX9eaegFSdB4v4LkAe5m1ur3BuhS9bT5jjp3qf0Ffk
	kpaQjznr4/fcD0MP0DPukyvCULZA2pTqtP9rT+KPXq9goFjH8pZaBjua6XOujBirCyjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6GWd-00BjVC-67; Wed, 30 Oct 2024 22:46:47 +0100
Date: Wed, 30 Oct 2024 22:46:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 2/5] net: phy: mediatek: Move LED helper
 functions into mtk phy lib
Message-ID: <7cb014a6-ec64-4482-b85c-44f29760d186@lunn.ch>
References: <20241030103554.29218-1-SkyLake.Huang@mediatek.com>
 <20241030103554.29218-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030103554.29218-3-SkyLake.Huang@mediatek.com>

> +void mtk_phy_leds_state_init(struct phy_device *phydev)
> +{
> +	int i;
> +
> +	for (i = 0; i < 2; ++i)
> +		phydev->drv->led_hw_control_get(phydev, i, NULL);
> +}

This does appear to be the same as what it is replacing, but it also
seems odd.

Why is an init function doing a get? I assume it is to do with setting
priv->led_state? But led_state is not used in setting *rules, which is
what led_hw_control_get() is all about. So maybe in a follow up patch,
move the actual init code out of led_hw_control_get()?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

