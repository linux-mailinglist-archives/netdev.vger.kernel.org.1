Return-Path: <netdev+bounces-132246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7A49911D9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8728E281F9A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1591ADFED;
	Fri,  4 Oct 2024 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z61CC6BS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35994437F;
	Fri,  4 Oct 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078860; cv=none; b=oSHIe/b/HAed2TtXdBaHbOUdcjqRNHZE/vFdk4lU3T8DBmpBZwqn3SVjHAzoK2ZU1/tfIuqU8OrtiV0YbFVNUplfemZY4dBf87Zr9RplZ51hSy/3naDCiY4Rm9rM0vWcl66uZGcyfpcoRp0ximng2AWNDasvTGQDBH5nPGcwVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078860; c=relaxed/simple;
	bh=QYhCKYEdje0YKkGMSKrvhG1SF7esORww/WLXCkxdLAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMiPqPOClg+IxnMqAgDjIY6e0qt/addEY1IPUYUyViSYAeEk3VL/gd6yKHNKK5kQKKvY01qDuV4SSY3U/KEdzLR30mUIaLPVbIzuGUZB8wKJI9UhZtNFqjla4tpIlZtDvbmHV/0j6vWeXbbnSTRF1acDlcUpvRT6er2PACsIwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z61CC6BS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JLygzdQhdQx3wTUVeJnHL1UoH3P4/3pCuvGrl1aILz8=; b=Z61CC6BSo78e6xjLzo1w+aX9il
	FNExjchlegUpFfSiV/OlnMyJohlk/A4kntlKa5MBXlSYRkhEOO5yLTjnjVJ7lOlA1nOYh6yV3q5u/
	+4K14Bg42NDxd/RYaz90LdMbzmlcfk9WpybRp2NHI0ovSc9SOprwKPBzjr4wyBO2J1wvFItfPNVzb
	Pia5Fb/PYzyK96+c99B7aBXjfHKh/3rEBd5mXqBy8H20Iuu1Ijzsl61IS6HM+KAC+h1OP52d1DHME
	lsnV/oQc+v5kgh8vFcwRvsB/gWq0sa62yknhh2lDW6TjboDM2CxPHKk9b4SKbpyZoHa1iznGg2Hwy
	DaQ0CUrg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52426)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swqFT-0002nC-0N;
	Fri, 04 Oct 2024 22:54:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swqFP-0001WX-2F;
	Fri, 04 Oct 2024 22:54:03 +0100
Date: Fri, 4 Oct 2024 22:54:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: Qingtao Cao <qingtao.cao@digi.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/1] net: phy: marvell: make use of fiber
 autoneg bypass mode
Message-ID: <ZwBj-3t6S3SL9Fyu@shell.armlinux.org.uk>
References: <20241004212711.422811-1-qingtao.cao@digi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004212711.422811-1-qingtao.cao@digi.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 05, 2024 at 07:27:11AM +1000, Qingtao Cao wrote:
> 88E151x supports the SGMII autoneg bypass mode and it defaults to be
> enabled. When it is activated, the device assumes a link-up status so
> avoid bringing down fibre link in this case

Please can you stop posting new patches while there is still discussion
going on.

I'm simply going to NAK this patch, because you haven't given any time
for discussion to conclude on your previous offering, and I see no
point in even bothering to read this while the whole subject of
whether AN bypass should be used is still unsettled.

Please wait for discussion to conclude before posting new patches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

