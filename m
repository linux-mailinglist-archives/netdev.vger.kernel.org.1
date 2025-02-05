Return-Path: <netdev+bounces-163007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC30A28BF4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D83A8BD2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8FB13B58F;
	Wed,  5 Feb 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BcC7hO1u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77AB12EBEA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762791; cv=none; b=t+juWEdQNMUCM5UFaF1keWwetJ+BC548rUEAnviZv1h3ZC6F7fodbo6eLQYOG/eLhGa2dESYstM8s+kGZyW3pWZbccUxYP9ktYK/k1g3r7wiMDCbSJZh0vNAKOTMbXkzQt1w/5hiGpmWaP7l3xDtDZvgKNqr0UKiKjFioZU8czY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762791; c=relaxed/simple;
	bh=zxZyQDwkxeWY7hwckFiQEB6/rUzxtSBGwXbxLWw5UM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SFknS/wJr7BpTMfXoORxwepfiRZ45vk9llec6VJ24RnC7pbxFnG0lzTdxxrB77w/cly62m589e0t+Cvwvq2cy+2J7uHN9sCdbqRNdNpCqTE074ie4jbbeSgNITgPkrmA77QV7ypnOCJqoTxRsR1Sk/JjZquIndFpt1RzzSJSyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BcC7hO1u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5fuNIBReuoMPO+s5xcuTEEEkepURytlmljp0eUz+LWw=; b=BcC7hO1ut/o8BAobW9jA3FXphM
	hkF91rElKoHlQfc4Er+M3jlXeBSRKItP9Mbiz5pRmR31Gr+tsCvGvhUoZ4gdPTTMwNQhcGqTrL/En
	qqT0PGtIZckO1mY8v8ZG5sGU2r4G9DSyvVnVVKq/bGeiq1YuAwACzxWemresep9yIJMdNW8RMtYlz
	ivEPOTl1xHN+OTNdHbl3kR3lip9N1bNxHIvBKGvmApldfUDspbTl1I//zBrar3RFUjtAyc9VMBF+z
	1HJ7HsPRmMcZbXIqdPevrEadkyjKQBHciI/v7PMI9d9XBXsS4EH1xs1nXSoPpxyOVGGrsarkQyzaF
	BPUlE4WQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33644)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tffcz-00079d-2o;
	Wed, 05 Feb 2025 13:39:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tffcw-0002SH-2i;
	Wed, 05 Feb 2025 13:39:38 +0000
Date: Wed, 5 Feb 2025 13:39:38 +0000
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
Subject: [PATCH net-next 0/14] net: stmmac: yet more EEE updates
Message-ID: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
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

Continuing on with the STMMAC EEE cleanups from last cycle, this series
further cleans up the EEE code, and fixes a problem with the existing
implementation - disabling EEE doesn't immediately disable LPI
signalling until the next packet is transmitted. It likely also fixes
a potential race condition when trying to disable LPI vs the software
timer.

 drivers/net/ethernet/stmicro/stmmac/common.h       |  14 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |  13 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  30 ++---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  96 +++++++--------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   9 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  49 ++++----
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  21 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 133 ++++++++-------------
 9 files changed, 153 insertions(+), 224 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

