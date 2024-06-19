Return-Path: <netdev+bounces-104793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869DD90E672
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D51F23882
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB24770F5;
	Wed, 19 Jun 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SjIPIWMR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1047E761;
	Wed, 19 Jun 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787703; cv=none; b=hO51t29GQl/DxnanDKUpQR4yiYTmYLbQUoDY7oVhq3tWqGuXbJvihxk7GuSCUwx4bIQ65gEwnhfBd0Gng9CRpIXUcoAeLFhFM30w/tOyP55HTT/jBfx5Asq4LlPwN/teQC08zJ05QcD/9SaWnx6L70rSLooA3AXbPhLnPf03/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787703; c=relaxed/simple;
	bh=LtDl5ULPvDoxdyA3nd3WRB5TWa6PaIXk0L+2IqC17bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FruwBUuJJX+5iagFSh+/TxZ1/5T4Qww2wM+BJE5pklzbcFEc9Nkm3lVS+Tzk/ko08ZJRBtTbP6nY/XZbddflX0LHn8qhZPj2iW4WrEL1dJo108fNYwkahmtUNtWm7viXp84dpF2l4JSDDGWgwKyUDZbwi1ZGYG+8YUgml9FTjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SjIPIWMR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DCK/d6LsdyqUObs9myr+jxM6HgEQAvSWILmG4c5rbI0=; b=SjIPIWMR6vYDO11xAvVomGVBP+
	4ZtUNpBPCLFYDtIO9jLFDYSpnmIWE75y/J3uWdxKSy5NgBL53BGWosYGNbSpqKWjMLx9ij/3vcFWV
	s5+5kCH643kbFX7cnIUZi+e4suDVbn29yUTywKZ4FNCsNE6WUrYE5tGeal8RH3koM8IUubZR2aQi4
	BZKniTbI4je0tj3mQRGMBI/AQjkAbmqYfGHFZ/Ti3gWsShmsmgWiIRaA9rFL/uFfIhqPew3ej/AwY
	86EsvXOOXZBxA+iEI2BgqW06rR8VMusGNwxRY1S8UYHlc5tiCFmViZlzT81SQCH/GKVo1hsWWX9ZA
	aZfP0o7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42546)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sJrC2-00082o-0w;
	Wed, 19 Jun 2024 10:01:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sJrC3-0006cy-7R; Wed, 19 Jun 2024 10:01:27 +0100
Date: Wed, 19 Jun 2024 10:01:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v7 3/5] net: phy: mediatek: Add token ring
 access helper functions in mtk-phy-lib
Message-ID: <ZnKeZ91TOYvSyjuN@shell.armlinux.org.uk>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
 <20240613104023.13044-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613104023.13044-4-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 13, 2024 at 06:40:21PM +0800, Sky Huang wrote:
> +/* Difference between functions with tr* and __tr* prefixes is
> + *   tr* functions: wrapped by page switching operations
> + * __tr* functions: no page switching operations

Please don't align "tr" like this  the lack of __ doesn't stand out with
this formatting.

> +void __tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
> +		 u8 data_addr, u32 mask, u32 set)
> +{
> +	u32 tr_data;
> +	u16 tr_high;
> +	u16 tr_low;
> +
> +	__tr_read(phydev, ch_addr, node_addr, data_addr, &tr_high, &tr_low);
> +	tr_data = (tr_high << 16) | tr_low;
> +	tr_data = (tr_data & ~mask) | set;
> +	__tr_write(phydev, ch_addr, node_addr, data_addr, tr_data);
> +}
> +EXPORT_SYMBOL_GPL(__tr_modify);

These __tr_* symbols will be visible to the entire kernel, so they
should be more specific to ensure that they won't clash in the future.
Maybe __mtk_tr_* ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

