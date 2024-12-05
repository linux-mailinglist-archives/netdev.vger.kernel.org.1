Return-Path: <netdev+bounces-149363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0089E5440
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CE016777E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2420C473;
	Thu,  5 Dec 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fP0Cj2o4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99A20C03B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399025; cv=none; b=H3DxTV4W/OmAd1hNFZ6di9sKzDhTjaUMAQVUIeBJTyCeFzcX1o1FdECviqmIAQWcitBWswz1tJm+S564qc66FWwcLtL2PNcCuonNpmoIgP0LzUKrZ1xQXcM/tjOkkaxFTNT48/SR3IY6ZjvL6CZe0llIsru1mKX2MHUBu8U+HU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399025; c=relaxed/simple;
	bh=AGqsmNMMuWurGEt71KuEJZlFuqyNw+4tzsUwJL52sw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh3Eod5DIn/zFPIWPR/L+lJGZNtgBbGNCvFEeFFq9CBeoND0c4C1TpP+HIkN3Wn/Z7uj0OKD3TM0aN2cyeqxmDOCnl9lkhIXLLR1SdiOz1zKz20z1mci+5BBFY3Kou3sOROIwtg8vCYiP5E/jRXK/G5XQTjAvWGXDJ4a+luQi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fP0Cj2o4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xnrJKa2eaFDeMC9q927an5e8rR8hhTWQ+UojrZJy2TM=; b=fP0Cj2o4LUeDV1eqU8gjkIcKqk
	2lNp94SSThXKhoQ524oIlz8vmjBIfAVhPC7vgVQlps5Oc41WH/JJFZHYIXxSntmbldk3CmL+1nRUc
	s+zL5bvzN0YjsTDl9lsneDqAtqqOQ8l/QaepyEZOhSXomDmpBYW1wMElwWBFyl8/0zxwxAhvZaTAJ
	Qfk7pJhLZOPRhsqP6Nynqc36tRt+VvMThgVQlo4qg+X6ZaZFfMJmO2WB/t672INyHFXY7t9VXzF+K
	v1WMnVunjlWUnlLiNxNPI5B26eI3v4+1Hurf7TEeyDwukXDL1NPGrBhx0vwWKmxn9tMUvHstJldFn
	Su6dAijg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40284)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAGf-0004es-0X;
	Thu, 05 Dec 2024 11:43:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAGd-0006Va-0x;
	Thu, 05 Dec 2024 11:43:35 +0000
Date: Thu, 5 Dec 2024 11:43:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell: use
 phydev->eee_cfg.eee_enabled
Message-ID: <Z1GR530iX-mfBSbB@shell.armlinux.org.uk>
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
 <E1tJ9J2-006LIh-Fl@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tJ9J2-006LIh-Fl@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 05, 2024 at 10:42:00AM +0000, Russell King (Oracle) wrote:
> Rather than calling genphy_c45_ethtool_get_eee() to retrieve whether
> EEE is enabled, use the value stored in the phy_device eee_cfg
> structure.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I seem to have missed adding Heiner's r-b given in the RFC posting:

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

