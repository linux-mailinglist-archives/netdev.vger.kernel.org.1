Return-Path: <netdev+bounces-98512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DE8D1A30
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F07B283F3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FC16ABEA;
	Tue, 28 May 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gKQhmYIF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2A13F431
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896924; cv=none; b=j6MiKkrQ4NkStEh91v7Wgh43E4p3rt2RneJBueuq1hdNtJVFVvnMQTJjpv8xCAp3SgTvYj2DbCZVeNMSVh/bw4ikLMqzPIymZ5nSrtBCfXDSWPzwo842IshJQjV2zkfoHO0s5STlu9Cho1BcS4u/32y05vtA6amBkV19wNdjKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896924; c=relaxed/simple;
	bh=hWY/xC3re3+zgoYfXGyPTecbQZmzAJqeGBrm9SEz5Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xkne1uekWScGwDV7xcuxxbrRrNFl43CPv8d2161IzfG8SRucWMdJ/gi+NoGlz6NJdHy2bVbC5hT4JQAXJ/KJZ/ga6tebTajAU2kuqrX80z2nitSOz6DqAR/s6RnLkE6OiHCi/g3/h6/vIRVE33KPOrulcZhUKuHKRjpBiU5f06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gKQhmYIF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iW37ByRUheosSAi4h2AMUwhdo6LLFgx25HP6KevTozY=; b=gKQhmYIFgsZd3z8qvGmWoSn5Ri
	fS0GEik5xOLBYbNQnlni+NNIIaM7hTRSYyY7ZlXbGLTBer0Dc9Y42TklaoXDNkh4lOpJOB9ys+GNR
	hZGtpN36gmjfx/PZzMRm9AHoU93uAsR0VfmC/fPSOvoGY/juMS/y9xO1B7tGGJWXSDwlIuxIwKdnz
	IkvfrTLeTOmMvwNX21KpnxmP1wodbxdEXsIyLBHCJtui7bucuvQqGfpFh2CyCpTEi9xl7g2paXQsF
	Sik7P1Leg4JnZghIocRwOgjYKqDClLYO8nm6APZDGoWnnLmHZ5yVRVDvbdMxxkN3L1epIQCbnH49P
	fWWeHqhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58444)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBvJT-0004hP-1g;
	Tue, 28 May 2024 12:48:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBvJS-0003EW-QH; Tue, 28 May 2024 12:48:18 +0100
Date: Tue, 28 May 2024 12:48:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/5] net: stmmac: cleanups
Message-ID: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
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

This series removes various redundant items in the stmmac driver:

- the unused TBI and RTBI PCS flags
- the NULL pointer initialisations for PCS methods in dwxgmac2
- the stmmac_pcs_rane() method which is never called, and it's
  associated implementations
- the redundant netif_carrier_off()s

Finally, it replaces asm/io.h with the preferred linux/io.h.

 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |  8 +-------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    |  8 --------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c  |  6 ------
 drivers/net/ethernet/stmicro/stmmac/hwif.h           |  3 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  8 +-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h     | 17 -----------------
 6 files changed, 2 insertions(+), 48 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

