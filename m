Return-Path: <netdev+bounces-212576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B0B214DD
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1D016AE51
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF82D94A3;
	Mon, 11 Aug 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CqEi4Bfg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5610F2
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938279; cv=none; b=iwkXVcLqqvvDN7ZXq2aRrLlb8WeuffdBiZ31vscBQdBEg3QYa/eRDYFG8l7cXDzF+AbgvoV/Vb/EZqWoVEIk1ISEFP4n9nmCuML1m0+Ckoa9fP1lVUAkYMgOlwKw72hmZ2GBOONHgLm/VYe0cZxas6cbKFwaAJvPyfus6Olgo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938279; c=relaxed/simple;
	bh=8HSqQlrGrMM0PJpPq+KiIAFU3qHqzXV8hYwUxX+ZOMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dh31L4mOK2rXzOeA7fDCsg6ZPTPXyAj7dqwKGAuPL96pG9A6Zs3uw4g5TB9cQmVow+IhxIigbYUeS6vzL10FpyZzcwz/4yn6s/qaMn6K4jWaYM3mOXiLwArznENGZ4h0EVmkMCZ8CAgrN5xIDJ/+z2/pXQkd3VuaXCqatdjK7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CqEi4Bfg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a/zRgNd+k/l8rezaEo/b4GJ3tZC8LPU16UMqdrMXbbY=; b=CqEi4Bfg8Ylv8LU/VebBnS+0Wq
	El4pVziTBNoVZ1PqTcs/LEXfvkzNNgUkKCDV6RziIpI2Ma3xYjHntpIPBaVFyZACRtsGzqZ8pB82r
	rXYijs014y9SxWbK2h0QkcLy4noAdMxpphjXTTmtS/zBUoLkRL9p6BVPtXoDQ5/wnS/HrddCyFpY1
	AKi4qJZNWrNCd1c+v73WfHtC4wb2BPzJvJAyk9Z+gsYZI0/uEcMxMVuou+KGbnPFfpP1fctqfoiZ7
	d/EktjuSq8wT4c9C1sxd7NGaZl+lbJ6MjhooUrXkc1TgQAl5A28F48xVkOmgO/hN6AbuB6iDsscXs
	HZcqrkEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ulXbs-0003aE-1L;
	Mon, 11 Aug 2025 19:51:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ulXbn-0003vT-0R;
	Mon, 11 Aug 2025 19:50:59 +0100
Date: Mon, 11 Aug 2025 19:50:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/9] net: stmmac: improbe suspend/resume architecture
Message-ID: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
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

This series improves the stmmac suspend/resume architecture by
providing a couple of method hooks in struct plat_stmmacenet_data which
are called by core code, and thus are available for any of the
platform glue drivers, whether using a platform or PCI device.

As these methods are called by core code, we can also provide a simple
PM ops structure also in the core code for converted glue drivers to
use.

The remainder of the patches convert the various drivers.

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  | 74 ++++++++++------------
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 73 ++++++++++-----------
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 10 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 58 ++++++++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 68 +++++++-------------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 12 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 73 ++++++++++-----------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 64 +++++++------------
 include/linux/stmmac.h                             |  2 +
 10 files changed, 195 insertions(+), 241 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

