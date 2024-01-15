Return-Path: <netdev+bounces-63545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB782DCFF
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 17:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8375E282CE3
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05331179A7;
	Mon, 15 Jan 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0oDtFnne"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793F18E08
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ARkUFJSHHpgTPbgdcxb88NAqZDa/XREoLWqmWYp5MTM=; b=0oDtFnnetPFI3tMN61QoYObsm/
	/peeQYyTUcLg3UVk7i0qBRmgCyP0cvxWwM7zC4LYxYdedFFE1b2nD9lkbrh9ZclZqv6OqYV9IyqVS
	H3lK5kk76URAeTV3gzYuVav7NzcjHp3sVxaHCG6+6i0c6O7EPO2JUHVVL2ukdyvmpq8auqVVTPpim
	3+ZqSvuXNM5Y/H7vKDELEsJnsTcwdO31bHZ0iO9ilTxlwqEDX0Yait4wZtxEaz5gCl1zxnYsGbqAq
	l4YInpKFey7rtGC0Cqixvz070//bELxXo2BOkU4EGeIbxJQQ0JhVlNbzG1Yj6gaUf7OzhtQXkcd8a
	e6s0CCcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41372)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPPUS-0002Xi-19;
	Mon, 15 Jan 2024 16:07:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPPUQ-00034V-Lt; Mon, 15 Jan 2024 16:07:06 +0000
Date: Mon, 15 Jan 2024 16:07:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: sfp-bus: fix SFP mode detect from bitrate
Message-ID: <ZaVYKgCPZaidGimU@shell.armlinux.org.uk>
References: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
 <20240115165848.110ad8f9@device-28.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115165848.110ad8f9@device-28.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 15, 2024 at 04:58:48PM +0100, Maxime Chevallier wrote:
> Hello Russell,
> 
> On Mon, 15 Jan 2024 12:43:38 +0000
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> 
> > The referenced commit moved the setting of the Autoneg and pause bits
> > early in sfp_parse_support(). However, we check whether the modes are
> > empty before using the bitrate to set some modes. Setting these bits
> > so early causes that test to always be false, preventing this working,
> > and thus some modules that used to work no longer do.
> > 
> > Move them just before the call to the quirk.
> > 
> > Fixes: 8110633db49d ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> I don't have modules to trigger the bug, however the fix looks OK to me.
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

In case there's interest:

        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-
wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x00 0x00 0x00 0x00 0x20 0x1
0 0x01 0x00 0x00
        Transceiver type                          : FC: intermediate distance (I
)
        Transceiver type                          : FC: Longwave laser (LL)
        Transceiver type                          : FC: Single Mode (SM)
        Encoding                                  : 0x01 (8B/10B)
        BR, Nominal                               : 1300MBd
...
        Laser wavelength                          : 1550nm
        Vendor name                               : FiberStore
        Vendor OUI                                : 00:00:00
        Vendor PN                                 : SFP-GE-BX
        Vendor rev                                : A0

which is the module I use for my internet connectivity between the
critical internal systems and the rest of the planet... so the regression
got noticed when I upgraded the kernel on Friday!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

