Return-Path: <netdev+bounces-182267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CDA885B1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466907A7717
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0527F75D;
	Mon, 14 Apr 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C0R7sCDs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7AA2798F2
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641811; cv=none; b=ssf4kWCysBap+ctKEbjR0YVi6rmIimg8UdPGdausNR7zLnrs67NKZm6dXczOblEr7HBzi9ND7ubAixQtGxiuxKuvz3IHZWzqKfYjP8Rh4pEhtp1QJXMak1rkNMI08mvso9hpRKWSiCuCSlvyTHleYN8tAn667alwOY7e7msjFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641811; c=relaxed/simple;
	bh=BxXUZjpivNfbFwEbrqCFeCAHAEGbL7LW5Vs5Uqk8ooQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDLe1v1V7T+OoRSDmCBCIMoclJnU8bycae4/lDVqDZ07IznHkN1B5raFVCTJ0np++wvNoFVMildyEf+/QznBYeMcuO/UU2CEFX7qCKTdYvfkki6Vu0eqIYJPGexgz8g+EK4s3LJMp9H6E8WVsDB/AFavhhHd/Wb+mnS9jz9Ae+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=C0R7sCDs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FNA1zxNgRzVAYOYdkpbodnjhqInFluzcIiosE3gBtSU=; b=C0R7sCDsQVUCPijiChHskc1/HN
	io1CdXZ6cJsbEj0GePEh9tlrQW9Ar7x9j22JXkofY/fJesdzJyMGkvFYm7VcAS4YJ7ww/I+qtJdo5
	ODFMxFGMFdKiLzaKgscMhbKvpAr2Pt2nRu6BopVQT/pa3eXp3cETlrje87o3iNDxU7jzLZThliKOf
	z64uSi77GH86+WDgJYFTs6U5XtRtHK2OcKUZsGzLYs4Pyfgm80PHF45PEahO8ees2AeDYo/ms4gWb
	584k32Q77Bl+sofaGSnj3ymHWBSxRC9HKmPJar0DnN7/g2bs7cDqsQrDFnfztluDpXHE6rG7/mRWl
	hankRLzw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4L1v-0006iR-3A;
	Mon, 14 Apr 2025 15:43:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4L1u-0007qB-1J;
	Mon, 14 Apr 2025 15:43:22 +0100
Date: Mon, 14 Apr 2025 15:43:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 1/5] net: mvpp2: add support for hardware
 timestamps
Message-ID: <Z_0fCjkiry0AKS7j@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3LtP-000COv-Ut@rmk-PC.armlinux.org.uk>
 <20250414145150.63b29770@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414145150.63b29770@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 14, 2025 at 02:51:50PM +0200, Kory Maincent wrote:
> On Fri, 11 Apr 2025 22:26:31 +0100
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Add support for hardware timestamps in (e.g.) the PHY by calling
> > skb_tx_timestamp() as close as reasonably possible to the point that
> > the hardware is instructed to send the queued packets.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> > ---
> >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c index
> > 416a926a8281..e3f8aa139d1e 100644 ---
> > a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c +++
> > b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c @@ -4439,6 +4439,8 @@
> > static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
> > txq_pcpu->count += frags; aggr_txq->count += frags;
> >  
> > +		skb_tx_timestamp(skb);
> > +
> >  		/* Enable transmit */
> >  		wmb();
> >  		mvpp2_aggr_txq_pend_desc_add(port, frags);
> 
> Small question for my curiosity here. Shouldn't we move the skb_tx_timestamp()
> call after the memory barrier for a better precision or is it negligible?

Depends what the wmb() is there for, which is entirely undocumented.

mvpp2_aggr_txq_pend_desc_add() uses writel(), which is itself required
to ensure that writes to memory before the writel() occurs are visible
to DMA agents. So, the wmb() there shouldn't be necessary if all
that's going on here is to ensure that the packet is visible to the
buffer manager hardware.

On arm64, that's __io_wmb(), which becomes __dma_wmb() and ultimately
"dmb oshst". wmb() on the other hand is a heavier barrier, "dsb st".
This driver ends up doing both, inexplicably.

It would help if people would document what purpose a barrier exists
for.

Without knowing what the wmb() is there for, I wouldn't like to move
it the other side.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

