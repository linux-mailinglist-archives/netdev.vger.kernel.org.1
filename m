Return-Path: <netdev+bounces-46059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045A7E1081
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 18:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4CBB20EC0
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F520B33;
	Sat,  4 Nov 2023 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VDvbA59S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09516111BB
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 17:42:39 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BFF2
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FCJq7TaRmsG2qurEfg27ONPNnKiEZtNNZAWyX3UvhJA=; b=VDvbA59S3uwtGvQJ862RsAIMP0
	DvZU4oHu+IbtZhuIaUSm8d7R6hqq9are5Hay/tpvd6qVhHIJ8YxkQiYLciAS3b4fWkgZMvmuz+v7F
	cQLSEpzHAKfheJKnEsC4xrDrwe5k9ckylytlqARsKsQ81pFdiYoGZ+ZptTniumOsJZXOJb8l1yXn9
	JqBzSpsePEA0XL6xJSH7iufkesewrr+p9drShd1EZOHAGlW32p3kdhmeTK3RPBDKCguRgMgYhok1/
	oJ0qad6jyaZ7eBC5mVrJHPfIKARXtJ0uxX61o0z/z6ud0OraqSMiypPuzZd46RhzMoT1vE9mjD4SL
	SXqmz50g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qzKfH-0006WS-1R;
	Sat, 04 Nov 2023 17:42:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qzKfI-00044t-O1; Sat, 04 Nov 2023 17:42:32 +0000
Date: Sat, 4 Nov 2023 17:42:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] leds: triggers: netdev: add a check, whether device is up
Message-ID: <ZUaCiGVPwcuTtjYW@shell.armlinux.org.uk>
References: <20231104125840.27914-1-klaus.kudielka@gmail.com>
 <0e3fb790-74f2-4bb3-b41e-65baa3b00093@lunn.ch>
 <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>
 <970325157b7598b6367c293380cace3624e6cb88.camel@gmail.com>
 <53f3e4ff-2afd-4acb-8cd4-55bdd1defd0d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f3e4ff-2afd-4acb-8cd4-55bdd1defd0d@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 04, 2023 at 05:46:44PM +0100, Andrew Lunn wrote:
> On Sat, Nov 04, 2023 at 05:32:19PM +0100, Klaus Kudielka wrote:
> > On Sat, 2023-11-04 at 16:27 +0100, Klaus Kudielka wrote:
> > > 
> > > phylink_start() is the first one that does netif_carrier_off() and thus
> > > sets the NOCARRIER bit, but that only happens when bringing the device up.
> > > 
> > > Before that, I would not know who cares about setting the NOCARRIER bit.
> > 
> > A different, driver-specific solution could be like this (tested and working):
> > 
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -5690,6 +5690,7 @@ static int mvneta_probe(struct platform_device *pdev)
> >         /* 9676 == 9700 - 20 and rounding to 8 */
> >         dev->max_mtu = 9676;
> >  
> > +       netif_carrier_off(dev);
> >         err = register_netdev(dev);
> >         if (err < 0) {
> >                 dev_err(&pdev->dev, "failed to register\n");
> > 
> > 
> > Would that be the "correct" approach?
> 
> Crossing emails.
> 
> Its a better approach. But it fixes just one driver. If we can do this
> in phylink_create(), we fix it in a lot of drivers with a single
> change...

... and I think we should.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

