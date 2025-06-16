Return-Path: <netdev+bounces-197991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F43ADAC74
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958ED3ADBC7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3941DDC33;
	Mon, 16 Jun 2025 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jA1v1SZH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF0273800
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067672; cv=none; b=WG9zCg1FGwJ9uBCIhI/4oC749X/oru76XLrHrzpnRpJteaLvbmZiNQs5IoGdiJPJGYwyMzjnr0uEiittyx+KSvZHW1HKi69PCCPhknjNfxwW3HSS9ZbELV7iCpzVk/XSelJUCNql456otsHETwbgruaHu9IcFVDoGDD+LAWwohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067672; c=relaxed/simple;
	bh=TeuDfGrqxE1wEoeRq2mMpLnft3EZNF1Gv0HsAPKKQMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUrfwdGrAX/QP2zUiLQvgmr3YlwTWZci6qZvwltYEbbcj0JMRIJddJ91HHFWdNSHEGUVRiuBjaHbZ/QtwAgxLpR6upJcOYlyFfCcy6vxL/PpaUWHSTsNBWYFLKMTh+YSLmD/hLWT9wuF2eALFF4bjb2KylYRMOBogME8QIFVVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jA1v1SZH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hfGwEVo597H5qvOz4t3j8JqGPt+oqPQYB+PbLZI/V/0=; b=jA1v1SZHH4lVUpVJf/FVTnYmjO
	pWSouBY+1VGcKJiSJkTWfm32V0bG15p7BA0YrSKu/4Z3bpNRVqg1TjbeG3evh6tlPTVxcH5RYKzYG
	9ye4MKUP6Rge9BYKhDi2XXI47sb0vzepkAmE1c2zf56OR86Sl593fzYRRy/aaVikp9XNIB9EV5928
	fUnlDXHzDhrjemhefpqyeT1AoIaciQtjMC8ROC9XUBjwo8YNSoDzBxy+P55dsKOFN1wGlMDKs2cjo
	kX3RNB8KzgbfvawkSM+9ZAX55Wgty+dPiF8EI6V7SeRIPeI7jtyg/L5MiBDLa6SQmU3FWyhZK/6MA
	td4hyIOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46578)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uR6Xp-0003Y6-1a;
	Mon, 16 Jun 2025 10:54:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uR6Xo-0004ik-1P;
	Mon, 16 Jun 2025 10:54:24 +0100
Date: Mon, 16 Jun 2025 10:54:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: phy: remove phy_driver_is_genphy_10g
Message-ID: <aE_p0OouhgmOEuhH@shell.armlinux.org.uk>
References: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
 <49b0589a-9604-4ee9-add5-28fbbbe2c2f3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b0589a-9604-4ee9-add5-28fbbbe2c2f3@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jun 14, 2025 at 10:32:47PM +0200, Heiner Kallweit wrote:
> Remove now unused function phy_driver_is_genphy_10g().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

