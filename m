Return-Path: <netdev+bounces-115080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3A94508A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491391F22FB9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828FD1B3F0A;
	Thu,  1 Aug 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VH09Hc1J"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC41B4C40;
	Thu,  1 Aug 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529656; cv=none; b=RRPJCxRL7TedGtmzQic50u/x+CUudLFiXfveOr1IFe2jlqal9WuSWKE5xmm8nApVjfvyVqwIac8bS1h9zYPu5nH9eHDZjegrdhtI2q3uBSVrY2eXITvh8xVgJEZCeVNGCdahnj0q8Iju1ro9CMq1euMP7BCLRmjPOFt8S/wLOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529656; c=relaxed/simple;
	bh=85lEfZGFGtKacm6T6GGUk2axAv1kVb0DRt+P+fCrrNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDltEJAgf/1BNRaF360mGR35HPkWLGyZIICe8/hBdbMKcBW+LhCr4Y/Zdjh1IWJTN8fKRGcPyhUZlOK9Uv8JhcYSgEE0oJB4Z6OzRzvSQuuHsK8jTJ0VG/ZjlQbt/ALG/Z95nmF6LF+lTY5IVUqLBRk8dtWxTDEX2cNeYR8lFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VH09Hc1J; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JNJOrniznUjJP2PwHWDrNIrfxViCx8pIHviDdSoTjdo=; b=VH09Hc1JgTMtRDzCbs+t0YXpRV
	UEMt8WsSYcketWLWCuKQ3c+H5GKvFhKraVTkvV0c90u6amUyG52rdqhmFDxWHNqeIIm4CNfWQI1qA
	e3lS1Xb0VMYqo83d3I2ZvJRSKMA6PSANGAcXtUzQCJjMP+Wu5JTtW/Z+vdhvfIG5SQjDkfADfCE05
	TLXTzgNm6ybFQNF4yVENbjRKzwXTHWV1rKn7ZEF3hcmgubKn6RjQQaD3FK/qRCCNofdmeKlweoPoT
	EBZ9yfw6Q8f8NNgSkGoWWX1fU0h+tpjS5BOaZg0P3skPc596QDf5dtcdP172/0VAMjSHgjQD5sktS
	0D493zYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50084)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZYe5-0003Vk-1i;
	Thu, 01 Aug 2024 17:27:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZYe8-0007EP-It; Thu, 01 Aug 2024 17:27:20 +0100
Date: Thu, 1 Aug 2024 17:27:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew@lunn.ch, horms@kernel.org, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	Bryan.Whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
 <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 01, 2024 at 04:33:13PM +0530, Raju Lakkaraju wrote:
> > > +     if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> > > +             phydev = phy_find_first(adapter->mdiobus);
> > > +             if (!phydev) {
> > > +                     if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> > > +                           ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> > > +                             phydev = fixed_phy_register(PHY_POLL,
> > > +                                                         &fphy_status,
> > > +                                                         NULL);
> > 
> > I thought something was going to happen with this?
> 
> Our SQA confirmed that it's working ping as expected (i.e Speed at 1Gbps
> with full duplex) with Intel I210 NIC as link partner.
> 
> Do you suspect any corner case where it's fail?

Let me restate the review comment from V2:

"Eww. Given that phylink has its own internal fixed-PHY support, can we
not find some way to avoid the legacy fixed-PHY usage here?"

Yes, it may work, but fixed-phy is not supposed to be used with phylink.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

