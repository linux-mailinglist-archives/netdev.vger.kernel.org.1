Return-Path: <netdev+bounces-98896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923038D31B6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473E9283008
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA8215D5A3;
	Wed, 29 May 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jdRa0V1s"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA815DBC6
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972043; cv=none; b=sE7rmI3PSEDQ5K04uAPoMOF9TAlQ4JCM0PJdrpH4LIPo+ZGR5tcbumsM0d4/IR+kSAN64JrzTM9qp8In1VcqmpGVElRKxPYkRLhCqcWrCoWSrnRGY/fJmN58iENDjG+UH5SJClnGmWl7dLUGLAwwHFvJ7phc0+v9YrYONSSNQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972043; c=relaxed/simple;
	bh=l4aSK9quj4qxt++jToETyFfkoc5MaQ7H7xgC3bI+xxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+iMhtFd9Vz9niaezOEVYAXTLGngyUI1QEnL8FyaTldfxjr8LZX6R2C8vNggTH6Quu8opxIVIurF3VqIgxGiVJ9j1p3tCXzHcH7SGSskXFj94z1zuaWny9nWyCNLPSPEWgxytwfMELdPfmT5oES6ukAgO1Kur7x2g7DCxPlV3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jdRa0V1s; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WBthTXF0tvM8P+3l/Pr3VnSW0fJqfhQ6w5OUBDLvGXo=; b=jdRa0V1sN+VDzhVS8kCjLjkIWd
	T0sYAhjp9LxuBKngzUjWFhqA3LU9ZIiuUg0QdTeiDNDezt9aMbTnKCeFvktKl7cfb0J7v5UxYlS+c
	4g4QPhRjwP8k32yGfi6rIJA+44OdIEmei51tN11Hz08g0eVs9uZX7ERNVfBJdwTfdDjDSbIgZ86jc
	b7vA5X2pHklEAK/oxjCLUpo4M8im+BxohncFfuVFMm/gQC82Vj0UYV6fd5lCEwelzad5mBDlSi3ef
	rlDbGKFh7Hv/uif+lSu7yZVtxShXstk6QETs7lf1IW3QtWzfIkCIvkoSTGfc3QqXy+IhiZxDVOglP
	ExTzue0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53862)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCEr3-0005lJ-1G;
	Wed, 29 May 2024 09:40:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCEr2-000458-1F; Wed, 29 May 2024 09:40:16 +0100
Date: Wed, 29 May 2024 09:40:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH net-next v2 0/6] net: stmmac: cleanups
Message-ID: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
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

Changes since v1:
 - Fix patch 1 "Drop TBI/RTBI flags" which didn't transfer correctly
   between my internal trees!
 - Update patch 5 to address all the asm/io.h in stmmac
 - Add Andrew Halaney's reviewed-by
 - Add patch 6 cleaning up qcom-ethqos phy speed setting

 drivers/net/ethernet/stmicro/stmmac/common.h       |  2 --
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 24 +++++++-------
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  8 +----
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  8 -----
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  6 ----
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  3 --
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 38 +++++-----------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   | 17 ----------
 12 files changed, 26 insertions(+), 88 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

