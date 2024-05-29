Return-Path: <netdev+bounces-99030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F478D379B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BE61F24543
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3268711CAB;
	Wed, 29 May 2024 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Irq/mhY9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D751758B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989345; cv=none; b=t7mH/xmP5jubgMdflv+RT7oSN6l92lxFUz3MvWxCFtCfCyJcxyXo8+zIOEUbJaeZ4YAm7tektOBhvhr83SHuii6W+JDX1baWMTJsLQBe1M15IDOrUJ+gGHNgar8a/XNNAjasciH3QrHrGH4kVAFd7FPMDSuSyG4NxPiGVOYPMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989345; c=relaxed/simple;
	bh=sapcyCU+XXejfsnnHoRwizhR/PrjFhmC5v6KoyeA90I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C85QGt54PbJOznu/+1PFMZ8Y8kzq8p/2MpCkcxAXIMwLcbpA3D5ilwHF/iSsaMuALwmVQskjbI0E9EeAL9F+pVAjvaXvdRD56CVtisV6QqANofShu5BXBOZkTnn3sHQOKKvW7nOy9QywrCN6BrpA1Sokx+V6ZapUbGYhReUztaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Irq/mhY9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BDYEhepQA/d2FZ56BctnoAn7J3hrIwALy9fmhbjaYl0=; b=Irq/mhY9oMmIKSYt8KYRcpNoWI
	Tu6uA1dOIDvk44vXrQbgz8vwQCIxdLVpc9xD9jeJVpUufdEaZhPHp0sIX0wNRrV3HSjWxd/bcQY95
	2EY0cywXA03kIKmfTlEg0HCDSFH4Xl7C2HjPUCKMveyqJ6cC2XWj+OcHRpj7jLL2lm+n/c3D4UM92
	spEQw2vcGA/OxQwux39bDI+S3Dmcan0L5hf1Btbam7jZYQx+I4UdZv+8Gw7Dq8D7NWblVSf0il9+d
	ApbaVENFAL4DHzrWAt3g31qs8kvcLnsEiF9lI5SPqp8cjR/K88jjbkIvF86JuIoVMCjlAPk1CeNBr
	1X+f/oTQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50668)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCJMC-00069W-2P;
	Wed, 29 May 2024 14:28:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCJMA-0004Eb-Nb; Wed, 29 May 2024 14:28:42 +0100
Date: Wed, 29 May 2024 14:28:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH net-next 0/6] net: phylink: rearrange ovr_an_inband support
Message-ID: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
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

This series addresses the use of the ovr_an_inband flag, which is used
by two drivers to indicate to phylink that they wish to use inband mode
without firmware specifying inband mode.

The issue with ovr_an_inband is that it overrides not only PHY mode,
but also fixed-link mode. Both of the drivers that set this flag
contain code to detect when fixed-link mode will be used, and then
either avoid setting it or explicitly clear the flag. This is
wasteful when phylink already knows this.

Therefore, the approach taken in this patch set is to replace the
ovr_an_inband flag with a default_an_inband flag which means that
phylink defaults to MLO_AN_INBAND instead of MLO_AN_PHY, and will
allow that default to be overriden if firmware specifies a fixed-link.
This allows users of ovr_an_inband to be simplified.

What's more is this requires minimal changes in phylink to allow this
new mode of operation.

This series changes phylink, and also updates the two drivers
(fman_memac and stmmac), and then removes the unnecessary complexity
from the drivers.

This series may depend on the stmmac cleanup series I've posted
earlier - this is something I have not checked, but I currently have
these patches on top of that series.

 drivers/net/ethernet/freescale/fman/fman_memac.c  | 16 ++++++----------
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 15 ++-------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  4 ++--
 drivers/net/phy/phylink.c                         | 11 ++++++++---
 include/linux/phylink.h                           |  5 +++--
 include/linux/stmmac.h                            |  2 +-
 6 files changed, 22 insertions(+), 31 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

