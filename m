Return-Path: <netdev+bounces-102209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7026F901EC3
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1311F24EEE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C09E757F5;
	Mon, 10 Jun 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MuHTmKe8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6F282EA
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013903; cv=none; b=bGNAw3dgWNeCfAdM4K/z4oX+quA62gIItezCHMlzrqNa31+eM19JJf8GipFIJYiTnLyidHRUslnhiuDl4Vd4EbBvL8pO1qoV/vBzW6tS/of2773oUsahWCKCm3F37ng6oNlzVGp1OFmrCu/uvnuNDhbtXK8c2wuhEZGHbBYhwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013903; c=relaxed/simple;
	bh=FZpDLIaQNYYC+V/79I1F+1i2/6aon2ON8wkYcedYZGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wymj4KThiJULpiLL06afa/fO25grldsb+ohnpqqkF6MaeogTJ40MPrs7ZXJmfTvuQX56v+nvad0u3SCqLktlAIMfWjY50sFHW1nWhar3CJ969gTPZ2ZUxEqC8XQ5Hty0SN3qni5xrgHsOz6Gxm1uxmySJJIwX5q/12mULcEeO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MuHTmKe8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kUI3gByTEw2joAvwT8/bC/QAenRjydIn8iJvHCGbts0=; b=MuHTmKe8nR1rPKATuaeMG/HlPC
	y7+FlhlFcOhQMzscoI/hw++PFUDaw/ryLc32g7hkWDJDmnDz7L9n5MuCYfUJPlFqnvkDCU+DJO8Ph
	Qt/QwFdDOauamWyAnyauqzzPPlwYiZbe67op8A03BW4t5zIvMv8UEokafQ4luEhpnNyqTl91Yxn2z
	jRndqriTWqhBPZQiF5P342oFbqXUIyq6OG/AS4zRGtjR84U2xJnNAOsOHQ94oEfNqwfDz/qKzPEZr
	t4bjpmfHAmsvarlEFQB3G7J3Qg6u0Meplr27rsHkUORSAg8kgWafCvTZKQVVQHAB4W828zal4igDT
	R6PDzXsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51484)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGbtU-0001Gp-2T;
	Mon, 10 Jun 2024 11:04:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGbtW-0006mi-BK; Mon, 10 Jun 2024 11:04:54 +0100
Date: Mon, 10 Jun 2024 11:04:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 5/6] net: tn40xx: add mdio bus support
Message-ID: <ZmbPxgG7vqEyhxEc@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <20240605232608.65471-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605232608.65471-6-fujita.tomonori@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 06, 2024 at 08:26:07AM +0900, FUJITA Tomonori wrote:
> +static int tn40_mdio_get(struct tn40_priv *priv, u32 *val)

I think this would be better named "tn40_mdio_wait_nonbusy()" because
that seems to be this function's primary purpose.

> +static int tn40_mdio_read_cb(struct mii_bus *mii_bus, int addr, int devnum,
> +			     int regnum)
> +static int tn40_mdio_write_cb(struct mii_bus *mii_bus, int addr, int devnum,
> +			      int regnum, u16 val)

I think it would be better to name these both with a _c45 suffix (which
tells us that they're clause 45 accessors) rather than using _cb
(presumably for callback which tells us nothing!)

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

