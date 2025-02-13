Return-Path: <netdev+bounces-166032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D557FA34024
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCAD1885073
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AD22172B;
	Thu, 13 Feb 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jexDaHo3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4523F420
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452789; cv=none; b=b3myPRcrFHFSJI3JuFR/Cr/8jspcbBWzA11Pju8UTWLPKXrubHBe8d3ENZFTHExfMJ9wtTy4tlBblf2wJX9mldW26j72r4+FZ4aX7lPip9wTp0wRxDlMF31nDFEKrmRP/lruoy41S0Jj+e7BIPUmFb1DXQPelmFH/pkVrVBofhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452789; c=relaxed/simple;
	bh=5VQJd/qvOVwkHapwS3DKqNckQ7lnmB1LyNGK9xCYxhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2j5jA/Uds3pAcRVib7oMjsbMXbA/WV8PcmhwSscPGVry8bjKw6CfCZlsHBaQxTSTzLb5LofWvsWsW6VE64aryBvm0hEWJnDx9vSDvy1MlISkvAQDIoMrQ7itzW/txjAjha2C11snS2+MLdIcx41+dyizsvdJgun/O7YwH5c2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jexDaHo3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=19plCeMMB6kb9wCe2AbHiDtctEzTkE/sViJQx6Llods=; b=jexDaHo3GElPt3n99BjdoP+agg
	zdaXKpwYv7GzvJWwWBGKh4NCBUciLysmo3PJwt4kOG/kyPQV6eeO2QexU67RDYKJM1ag/2XY6tAg/
	Vp6vgRrmhlHHPYwmgLiNf5yj3E/L/sB+3Qnj0WcWBHe8VHvLLDkXPBwl4g1UimEtszII=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiZ7v-00DkFh-95; Thu, 13 Feb 2025 14:19:35 +0100
Date: Thu, 13 Feb 2025 14:19:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] r8169: add PHY c45 ops for MDIO_MMD_VEND2
 registers
Message-ID: <40a4262e-1398-4b59-bba5-24276fcc8fab@lunn.ch>
References: <ca05b98a-5830-4637-be72-c11d7418647a@gmail.com>
 <fa252e7d-b4de-4734-9224-a0924a17e198@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa252e7d-b4de-4734-9224-a0924a17e198@gmail.com>

> +static int r8169_mdio_write_reg_c45(struct mii_bus *mii_bus, int addr,
> +				    int devnum, int regnum, u16 val)
> +{
> +	struct rtl8169_private *tp = mii_bus->priv;
> +
> +	if (addr > 0)
> +		return -ENODEV;
> +
> +	if (devnum == MDIO_MMD_VEND2 && regnum > MDIO_STAT2 )
> +		r8168_phy_ocp_write(tp, regnum, val);
> +
> +	return 0;

We don't expect writes to random registers. So returning EIO or ENODEV
for MMD other than VEND2 might help find bugs. Also, it seems like a
write to regnum <= MDIO_STAT2 would be a bug, since those registers
don't exist?

	Andrew

	

