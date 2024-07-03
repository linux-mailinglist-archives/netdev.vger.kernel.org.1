Return-Path: <netdev+bounces-108948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2869264D8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4481F23374
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919417E8EE;
	Wed,  3 Jul 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bRYjgpAd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173A17DA20
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020584; cv=none; b=A7PhHDdfFQcyECYMBL7QRpCtE4MO+M8tQXj1pSDGgHO+5WFeWFqvk/DcOc5yERUo/ZNddp2DMBR8BwmbWu/rDDi7FMMMFR0u/LixI01qE7xNiBveeQBTliwtZuaTsVSPFyF6Wfe2ySbZJBKhjsK8Pq5YlJCPAVFwFiFcgYqy2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020584; c=relaxed/simple;
	bh=ewjQh76q7uIZPFukcxFMktGm6uxyAJyFoxhHqgDz0mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC+6/S9YZWKsArYGxfkWkzlAeCnbJ57kVRT9+G6R+g+JThwC51T1J0BWYiq/bWQfb/J2OcoYpGAuczulaPGgUrZTon8dhzUdqu7+ywXsUiCU6/lJxBygYmoMmGVOqg/smRhIOZacbWYuy5KegR1Crx65tzsk/abCBtpPWyAPMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bRYjgpAd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bxdhcDkewYwFgdY9moFLwqTQeQ72WrSVSCnn/Qtj+g8=; b=bRYjgpAd2CbzTLCPi2oBZpNy7k
	EZE1fgvHZXhRHtL/fa1FEh08CuKByhK0YqmxEJz5f53fhxt2AsSFLha5EECM4kJMMMHd3pEe2Lnxq
	RGRwAKbk2o91SfSqGgX8ZFUfO3M+W+KFCs4U0gzjurm9Dlv6VDht8b8Z4IrZ4oiuc6wCSqJIB1jVn
	y2rW9i4q4QltPoazXWepaUN/aGLEQ2iL/RsrX8U49bOHQBnHGj7B1FDbmXcOF2rRCd/oU5FYL3JNN
	LywtHiJ+GbUzXvZcQEQK1fEQFIq53beSP7R9N0etiXOwfJSeoGB7nBkqDdHwld6Asnj8yT5E9BuO0
	dKWKFWhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58946)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sP1v9-0005lY-2W;
	Wed, 03 Jul 2024 16:29:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sP1vA-00031J-Af; Wed, 03 Jul 2024 16:29:24 +0100
Date: Wed, 3 Jul 2024 16:29:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Halaney <ahalaney@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac4: fix PCS duplex mode decode
Message-ID: <ZoVuVDhCDxr/wKKE@shell.armlinux.org.uk>
References: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>
 <c26867af-6f8c-412a-bdd4-5ac9cc6a721c@lunn.ch>
 <xgqybykasoilqq2dufnffnlrqhph2w2tb7f3s4lnmh3urbx4jd@2e7nl2qkxtrb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xgqybykasoilqq2dufnffnlrqhph2w2tb7f3s4lnmh3urbx4jd@2e7nl2qkxtrb>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 03, 2024 at 06:07:54PM +0300, Serge Semin wrote:
> On Wed, Jul 03, 2024 at 04:06:54PM +0200, Andrew Lunn wrote:
> > On Wed, Jul 03, 2024 at 01:24:40PM +0100, Russell King (Oracle) wrote:
> > > dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
> > > register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
> > > rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.
> > 
> > This appears to be the only use of
> > GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK. Maybe it should be removed after
> > this change?
> 
> There is a PCS-refactoring work initiated by Russell, which besides of
> other things may eventually imply dropping this macro:
> https://lore.kernel.org/netdev/20240624132802.14238-6-fancer.lancer@gmail.com/
> So unless it is strongly required I guess there is no much need in
> respinning this patch or implementing additional one for now.

Nevertheless, a respin is worth doing with Andrew's suggested change
because this patch will impact the refactoring work even without that
change. We might as well have a complete patch for this change.

(Besides, I've already incorporated Andrew's feedback!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

