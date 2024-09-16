Return-Path: <netdev+bounces-128579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4997A708
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BD6284048
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5015921D;
	Mon, 16 Sep 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lz56ntB8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF552E646;
	Mon, 16 Sep 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508984; cv=none; b=QTFKPi+CCAl8f42K8ndoCzHgK0OB+tyZ74Od1slc8Tkt9EOklxqAWW789s42FWFUj4Ug6HfcVRt98W1MDhGtMa27N64fl0MIwlVC0zR6sYz6zBFH73f3UKb9C0fVvHdI/8Q7cv9ymyBLt4ospWrNdZOX12GgswrW4SUHCZ47xKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508984; c=relaxed/simple;
	bh=FAkdbfBEpHa/VNwdzAS1q8vl8bKy+r0ZzWEdVRDH+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRLwB4CV5oo1cCMZbQv1qs1xwR0fQmNgH/OZlCzJ/xLxrs1r5jWf5gRg5wzCFqSHw1x22DvJQIadyY8FG/wJ8975SPM2lX2w8dgS0LWrl5NZZXBWh3FiQuTh13yEYyl2+06JCdsQIsIJvYgS7AeAXLHBp4psvy17hDeg8944uK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lz56ntB8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SbEcTwTiZECfedSamHPXD2T6PDmIOEI7aJtQ5uqY4i4=; b=Lz56ntB8+9y7vM0XQ6VRkP4Gne
	yz7GbtAcc6mdafpNcoT44OAYl1GkrpFHkqkntHaxt6Nr+aR12f1n4MCSeRpdo3M6Lzz+OLGd2qZlK
	nmMww7Iplk/cUYDv/V1pAVeZVMUGp+AjiJow1QoEvxJfiIz9XyfrrreUYvphKgdAsHy73nXPA1vSN
	gF8YD4P+2h5633/EFAF2WQ/2+2yrwTryRA5AOd8nuytOjNF7o7AGbA8RcsIRuFuBrEJ1WZ9zWsflc
	5oMBUDTCq9YOStps6zVMKaivD0rHJ42nS/VD65WrpMQf8TciWVjH0DkQ1bjWs5UpnM48A90umfM9P
	PdDKRoZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49730)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqFqt-0006G8-30;
	Mon, 16 Sep 2024 18:49:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqFqp-00079e-2c;
	Mon, 16 Sep 2024 18:49:27 +0100
Date: Mon, 16 Sep 2024 18:49:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 4/8] net: ethernet: fs_enet: only protect the
 .restart() call in .adjust_link
Message-ID: <Zuhvp5Y3w5Ukdb0C@shell.armlinux.org.uk>
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
 <20240904171822.64652-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904171822.64652-5-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 04, 2024 at 07:18:17PM +0200, Maxime Chevallier wrote:
>  /* generic link-change handler - should be sufficient for most cases */
> -static void generic_adjust_link(struct  net_device *dev)
> +static void fs_adjust_link(struct  net_device *dev)

As you're changing the function name, I think getting rid of the double
space in 'struct  net_device' would be worthwhile.

Thanks.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

