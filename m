Return-Path: <netdev+bounces-123264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B12964563
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CAB1C24CF8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAFD1ABEAF;
	Thu, 29 Aug 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e0P3AuXO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7661AB530;
	Thu, 29 Aug 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935620; cv=none; b=REc/C+46xxHQMHqPYaY91nIoEoebrS/qylPbpXPGLOl2nicmNgdHfUfb3/hTlAyOBNEaBC+axfCQIZrCAxaajvxzSYOq64WsSsYfFQOo5JE8E+eTfFH2nSavc/cqv8/SsRvJV49GbCGySEjoNTEwAYWX3aHbmQrwxc/BMp0KwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935620; c=relaxed/simple;
	bh=Oq8nxUfpNDwgKleng1j8/+AF3qcMu74H3fGZd4bWY3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHxHZmRuies3DimyETGVCydz/hPIpQK9tx0hLJruEezfu/K49xn5LbzcRi0mOKXSCsRRDXT6AsO0m4wfmFAmOvWGIB/0RiTjXmM4yBZbdur03gHZ7l/tAVWHlqSnK+dGkXig4pJXous8A9OaI1vXRG47Gb/JFwxc3jKf0SgD/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e0P3AuXO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+U3E/oe1eaYC5ux06BtbIDVN6znZGIAxDu2IHziTnU4=; b=e0P3AuXOsvlN4MV4b1JNjYzRGW
	F/+zEk+2LAPjt7CVekG5HGaKh0sRfDB5D+UI2R59k3664F0/dOzmss+cTbWG6NaCevGExU+KGkVBH
	SCgyhn5uXer/N9raqghFZWKvhJHHksOxOUfGiiV1R5G5Fn0/l4f/R5TLSl9ndop2uT2o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjeXt-00624P-SS; Thu, 29 Aug 2024 14:46:37 +0200
Date: Thu, 29 Aug 2024 14:46:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, ansuelsmth@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH net-next v3 01/13] net: stmmac: dwmac-sun8i: Use
 for_each_child_of_node_scoped()
Message-ID: <6169002c-eba4-44c1-8e30-4fff308b61c5@lunn.ch>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
 <20240829063118.67453-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829063118.67453-2-ruanjinjie@huawei.com>

On Thu, Aug 29, 2024 at 02:31:06PM +0800, Jinjie Ruan wrote:
> Avoid need to manually handle of_node_put() by using
> for_each_child_of_node_scoped(), which can simplfy code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Your Signed-off-by: should always be last. I've posted this comment to
quite a few patches to netdev over the last couple of days. Are you
not reading the list?

With that corrected, please add my:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr

