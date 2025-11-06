Return-Path: <netdev+bounces-236284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC40C3A8EF
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FA34237C7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13530C61B;
	Thu,  6 Nov 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A844+6e0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BBB2E8B91
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428094; cv=none; b=M6bddKAm/NADXYP/kMbDaW5p+qpmgAw6bTygpxB2ANffLGWk0IBzxihjiX5i5mhKsvJidgJ6E73CbrLvAQQrcfDJGSeDL+HwUEfEZIPLnCCzXszRClabNJ0DMycEKhTwezZQYe4oBVzROr8orUtnPXqNjQdsEdvYLCPSZIKD0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428094; c=relaxed/simple;
	bh=MhMnHpD+Eh60yI9FeGR7C1RNAO+CGWh+yPMhfluGnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gKEi+iuanKTM3TG4HkIPgfMz2+6VOl6UYr7JQzj0oCzYIfb4fP+3ZdY6AeuX4WP10yiHDNtNt+d873j/21NyVsA01+9p/KDL7xzog1DckW6Te33sre9cwPSDWMGk+lYzU673gs+GqZxtBSmTggLxtB3IvgHLzoCir4B04sNKpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A844+6e0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2o51kKX3Zg0nj9Zi/x6rawFH6AzzpVCUPueof5Bfs3c=; b=A844+6e05ltMFBKMZI5HRVZVGa
	RMTLYIKVezGUWrP5bWudLcWi1Oe/YJEdZLNMflmUErBhkHMYybl8bXe27+mtpG9Em+KR3L23Oos0x
	Xa1+sUuQBri1FRwT63V5GJZl4Yl9MjXdTV03OK/LElezBwg+XIPDNg8onVHCWzhvzRZaImavCsh8q
	xVi3q7zTcNT6Lxgn0XJ7k67HGIoLgg78l/vgf7O1mnw9GkuQkh5W2PwfhD7Xw1RZyd19PY0LigthL
	IfCQOwiySNT1a5jxO+g5kxv6UptagpJJV5KOmS+FTlT2M0EPfIRvjdYavP9ipkZhkdLGht75H8yaZ
	6M/5p+0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGy3R-000000004ts-3ykw;
	Thu, 06 Nov 2025 11:21:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGy3P-000000006bb-2NHW;
	Thu, 06 Nov 2025 11:21:23 +0000
Date: Thu, 6 Nov 2025 11:21:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 0/9] net: stmmac: lpc18xx and sti: convert to
 set_phy_intf_sel()
Message-ID: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series converts lpc18xx and sti to use the new .set_phy_intf_sel()
method.

 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    | 42 ++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    | 50 ++++++++--------------
 2 files changed, 42 insertions(+), 50 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

