Return-Path: <netdev+bounces-102200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB481901DF5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD4280F00
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CE5FBB1;
	Mon, 10 Jun 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C4phnXKb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138118C31
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011192; cv=none; b=W4kq/+ooY/raVa0vsG5Sr+qzYjBXJUR6SjeJcIKer8MpksGque7RHYPpUiEkGkzCNfvok9MFcnTRuBo0G4ycVz9CJdYJOxVUACYwOcITxxPhpel4cnO5LGmmxJsf/84ihyLDXdD5BPGurJLXDapZIiipeEDzTFs774XCSZ/yL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011192; c=relaxed/simple;
	bh=+B9NMS1D/KHSoiuNcFdBMfzE4koZ2NNkKDKOfzCgdeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MASm0l36gaCjmqEfgFZIxDxf9ZuO6NhlqjvFxDJsI0A8PGyXPXena264FS044s1TjotaFGfUhQnUPUhQryEjAooyr6DbeHua6BLI0D9PufTk9gf2KSzoPosL8yw6PuXTSqF6yo3dnVE91QcNec10+DF4JkY4K7+n/bA1vF0x2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=C4phnXKb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ikVClAmxiAK9GuPcVRzMsjEeJjGHTMRE/DJvy6XjAFY=; b=C4phnXKbiu0jdrPxeKv5kQMRzD
	lNLth5EKWGiks2RnT1wVBw6i9ySdrmULlZ+zY4CESU/2rlSzHzWfIsO9MRjIev/icitJ7EKRLZ2EB
	9KlRhcDI73yfuZswh2dk6z/1zV2zf7IJ6upCFdZ4bVookr6sAVHY+10XuM6gEPEcq4SygNSVEfGp+
	UaoKj1XjrcqIDkgojFp9IAoQq7ETrK9QNAc0unA/q5iXhqPbLgrdm/0HFdJ4zYi3h9mBkrqrfdJil
	k9O0TQHtBLJvuvPkwIycBvO8apzm5nt/Jf0B8DEv1iSStkKf1R1GN5oG66P8smsRv7CSPnYguGJfw
	LGnSy8kg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46210)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGbBh-0001Dt-1o;
	Mon, 10 Jun 2024 10:19:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGbBj-0006lP-8Y; Mon, 10 Jun 2024 10:19:39 +0100
Date: Mon, 10 Jun 2024 10:19:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 05, 2024 at 03:05:43PM -0500, Andrew Halaney wrote:
> On Fri, May 31, 2024 at 12:26:25PM GMT, Russell King (Oracle) wrote:
> > @@ -335,8 +303,12 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
> >  
> >  	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
> >  
> > -	if (intr_status & PCS_RGSMIIIS_IRQ)
> > -		dwmac1000_rgsmii(ioaddr, x);
> > +	if (intr_status & PCS_RGSMIIIS_IRQ) {
> > +		/* TODO Dummy-read to clear the IRQ status */
> > +		readl(ioaddr + GMAC_RGSMIIIS);
> 
> This seems to me that you're doing the TODO here? Maybe I'm
> misunderstanding... maybe not :)

Please trim your replies.

These two lines come from Serge - please ask him why it's marked as a
TODO. I assume he has a reason. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

