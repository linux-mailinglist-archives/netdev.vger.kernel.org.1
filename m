Return-Path: <netdev+bounces-242297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7369C8E7D0
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 994444E8D94
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE1331A52;
	Thu, 27 Nov 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z6HPxH7X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79035695;
	Thu, 27 Nov 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250248; cv=none; b=WivTg7NOgOKMkRQIE7dPFtGR5xNhH+76MI9uUaRJv46RnreAveY8x0gbSXHf0l9s1ciHPOnEwB04lscfp1d2BF/fP56VlUJJVffrP4fzO7GeOSsWBvq4Mt0xzX0hVyMtNKSU6QKOowKrhLMJBiSW9NcmTFa0Rm1n9CsDBJrRZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250248; c=relaxed/simple;
	bh=XVshO5fwex/FWJdbvLDHA7GTxSigtdmElE27ZLpbIyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc5Pu7rOtWV4hPhCS3411m4e2ADckydob1vHvUrB6oWnDVaf4P6U0SpHw4LhmCutAqpR4A2FfQuD/2Nzzb3vNKls6X03Xi1K5R7jc1G6rAxvOaAZk0Dandwb/vfrTuYwXOGAHRRgfsB0IODEd2qFR+X5cYxEC39pUeMInJZL9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z6HPxH7X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F2ElVsdrp+lG3pazHvx7/VtoAiVWvnMpN0u2nWWuwxo=; b=Z6HPxH7XDec96l4g0YNkCIIWxE
	DUXqJ0NvhNC8LaVWAcrUuD0yHOZYKVobGLlqCiuhMP+584AOyyOOmNDfslYV9JBcTR6+OSqan0Fxd
	tPeqS7CBt4u1ueNelksvAOzLjXA+HeyAR8zIfklfFY4ryirclJlGf4jM4vCfAmp4a0Mx2lv+QCxLP
	6ZSvnMqVHmOtdBGA1MhkL5vtH/wcbuoEEjsQqgzcO3vpWeQeBNjwI72snA1VUucW8lYW8XK6kfX0/
	qsbPM+k2krYCbHMKPQDNkE1vEuqC8oWfE6r2tS8ApeQftMQ5nxq4gIlx/QHdZdnYC80dDd406M7CB
	z+wPRlbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60740)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOc4z-000000005Js-0DVp;
	Thu, 27 Nov 2025 13:30:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOc4w-000000002hl-1UOE;
	Thu, 27 Nov 2025 13:30:34 +0000
Date: Thu, 27 Nov 2025 13:30:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Robert Marko <robimarko@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ansuelsmth@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: aquantia: check for NVMEM deferral
Message-ID: <aShSesEATBaKnO0A@shell.armlinux.org.uk>
References: <20251127114514.460924-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127114514.460924-1-robimarko@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 27, 2025 at 12:44:35PM +0100, Robert Marko wrote:
> Currently, if NVMEM provider is probed later than Aquantia, loading the
> firmware will fail with -EINVAL.
> 
> To fix this, simply check for -EPROBE_DEFER when NVMEM is attempted and
> return it.
> 
> Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
> Signed-off-by: Robert Marko <robimarko@gmail.com>

As aqr_firmware_load() is called from the probe function, returning
-EPROBE_DEFER from here is fine.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

