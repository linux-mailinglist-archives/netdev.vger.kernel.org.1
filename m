Return-Path: <netdev+bounces-95741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194D8C338F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 21:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC24E1F21656
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9722E1F941;
	Sat, 11 May 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oyssqWJV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740322EF2;
	Sat, 11 May 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715456174; cv=none; b=RTf6lUj8h41SgHX8p+bfTx6DTzvjqikX9Cf4PNhfmLQW3mLcCrXl8TjDk4P25Okb+UsooP8ksVTNpCSqwDmfdb4Lwv81CaZEt76cd6zrYUqBEqf07+f8Kegq7vtKkZJyizQcIfKmVq6L6GLvt9BM47dsc7FuCySOBHm5wx8GJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715456174; c=relaxed/simple;
	bh=wMJUi+PdPrEvDZsHqJBjhH22jQJVIEnVe/PE9a7184s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOxpqdZZdxsSYjz44YqP6cxniF66fp7+MVZdqyojNbC3ry1NhTifMXg//M/gZxHKRN5oK6u+Byn5J5mTIGu1pVbjFzbI4DvhKjIIbxdBU6L7MktQzjb/JI7b45yYhw8sKL7MNZi0Lz2r0COc40015qbgxlXoLTKzpi62Vn4ftlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oyssqWJV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UhzC2A5F+60yg0XstH3Un8KpZ2vRh/COyryc8bX0waQ=; b=oyssqWJVeI5Ri0T49GLxy0iG/X
	3+CF8s1rSfsaI4Gly7VlZ4jCM5gZEyxPBvHjsK+85sOHVvrn/k7hJLbrSZk4GyY1Iyou6cZzzirbE
	zN260LiOw52OaMTBKxTdmuO78um56s2V6PV2mz9sKKR8rwM4JJkvMFE9jhM77so/WS7rdLgBodsp5
	PevmfYcKunputGrn8mBCkEsNgwh7u2HWJcP+XxR8R2qj5/SWJZ7ED46F01VAAdR0Ok/CteWOZ4zoO
	Y96f9dzpHM4yvcBc8uU+2ayTynAZZZFoXrjXBrRiCDMw1FFVyCBy+x7ts041yIjKO1w+GeOBb3EI8
	DV4yZT5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50740)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s5sVq-0000Bo-1J;
	Sat, 11 May 2024 20:36:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s5sVq-0004Vb-LV; Sat, 11 May 2024 20:36:06 +0100
Date: Sat, 11 May 2024 20:36:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <Zj/IpqjWCD9fOMBM@shell.armlinux.org.uk>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
 <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk>
 <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 11, 2024 at 07:50:03PM +0200, Andrew Lunn wrote:
> And now you mentions legacy Fixed link:
> 
> +MODULE_DESCRIPTION("Broadcom 10G Automotive Ethernet PCIe driver");
> 
> This claims it is a 10G device. You cannot represent 10G using legacy
> fixed link.

While it may be a 10G device, it seems the fixed-link specification
in the driver is set to 1G !

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

