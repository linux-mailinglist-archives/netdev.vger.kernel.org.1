Return-Path: <netdev+bounces-182317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7EEA887C5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C323A6F28
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBEA2741AF;
	Mon, 14 Apr 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PcXZCXdb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761914B945
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645896; cv=none; b=n5MDyFT/4T6wDkpyRSLgQuJhxOPOamQGGKu195bVOy36SOik3XzghMdDoQgfnjtYD51BhPNdr9BNkEyCjZr8ynKyNCukP0wV52CFBiMiF8ASAWHSV/02PdijxkDVd2/7QkUlldpNthSmkNSWeG6eiOXNUAPdPxJo6ZwJWOKNmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645896; c=relaxed/simple;
	bh=J1ajjji685NK+fXFimQZxDabOoRmU/cD77vTN7SlJrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aSX/lyreRrIL6qZZ8AuvaY+rghYPWK4kuv3vkrL2yV+kqIY3tvBITwdXsoXZl2ARj4mR036dIVsUqml8Lpi6PAdPaEuyaK2EFg9OO0aNdHZzReS8atI5EX7irUlA8hLzgTOxArI5tnoUkKPlYBue0lxM+9wtPrfV1UyyKqLjjXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PcXZCXdb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DOjKltCz1QNVwOIoEShbQiGKzqPC0dP5/3g+O8TKjp0=; b=PcXZCXdbGGiG4woiG67mKrNeg6
	SIYWqpQjaE7qfLvDSK+hNYZDmZwySIWvwbbRvvxoA7+5bVHE3A6H/Ncgg8XtnnxjOuZxDFGDxugX0
	Dpr2I2T6V5Hu05lFmPP32g2UmEFhgpn3SsjDdFw2UrnzyRZpUR2lW4EH4iuhCdf3nirJb+FT+XIZ2
	5QKA41xIB1Yo6WOAUuLrSG0eV9oo55BQ93gq/WxjidY5u3pyTalFwrcMW0vb6oza8fN01+OO7vC+X
	Ermi3eIhqanEdJYrjKZHETEtiBKnyi7hR5+ivf7QPyhxhpGkIcb/6A8JtuL4g7dHbV9ddcQLSYPsB
	3z59kyYA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34436)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4M5j-0006nt-2b;
	Mon, 14 Apr 2025 16:51:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4M5e-0007sk-10;
	Mon, 14 Apr 2025 16:51:18 +0100
Date: Mon, 14 Apr 2025 16:51:18 +0100
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: ingenic: cleanups
Message-ID: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Another series for another stmmac glue platform.

Convert Ingenic to use the stmmac platform PM ops and the
devm_stmmac_pltfr_probe() helper.

 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 46 ++++------------------
 1 file changed, 8 insertions(+), 38 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

