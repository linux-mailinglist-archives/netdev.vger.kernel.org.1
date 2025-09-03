Return-Path: <netdev+bounces-219559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E74B41F46
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C161BA43D5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0F283FEF;
	Wed,  3 Sep 2025 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Zl1bFRhO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F712EBDEB
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903156; cv=none; b=nrbyAFdEZQrq28W1vYEp9Qw26xowGYcMX+R1cBpQZQSv8qgs9UJVishWrEvnRfkd5hCU8hzV0njRB7RrAGTS9yKNBgupC2HUMbK641EpishAd52jMzMOMgbsvE6Je2I8pALgJJdHaGQTMyNnBw4c50CnVWMZef1m1QsDryv9p94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903156; c=relaxed/simple;
	bh=HEsGniwmV5QsjFIWcmXsTO4+MfdUNIBdIRBDJkAaf6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HpT7xqTfQADzShs2nSD4LqGigg70uuw91ylzraBztgNxTaSeFVv7GmFJyvKb6+DgKpP/MWs7HmA0FloYV92cemMJWrbTJadTifJvBF8a6m7pP8xtn4CW3rzh8z2UAYqeNB2tpALNlwdVtQyEQ2QPdfEr7DKM32omcmz4ZZsorVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Zl1bFRhO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W+sciWiR28uADtG6s3fwkiLGHUUGtxaudPakgT3DJGo=; b=Zl1bFRhOamEGMrHA+bo7k+o762
	0u/R00gR0xWdO2HeF9tBwY9CBh2rUhRn1qbituq9p0/4JGY+2vkr4OHoPm55QTBob/kpA02m+8wZD
	tqIFGTKqtslw8jaOTQq1NJubBgSPR/nffsMBZKd6NNLqUs/Ury8OLbpd0F55u41+LmvzES6OJvmHC
	iy6U2Bh1h6ehxykRGaeVWS/L68HzW1UdhKpiZDYIfLUgRf8f6effcLsmA9nTS/qajznPlYv/7R/u+
	fmVfOF1pY2jX7ITIypQo+SDg0NT834XM7XP8n76KM5JgH08P2YcQ68SvLwNLUCswp9DmZXDqvQjl9
	YYDNuLoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50700)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1utmlR-000000000Ud-0vu5;
	Wed, 03 Sep 2025 13:39:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1utmlN-000000000XG-1Ry3;
	Wed, 03 Sep 2025 13:38:57 +0100
Date: Wed, 3 Sep 2025 13:38:57 +0100
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
Subject: [PATCH net-next 00/11] net: stmmac: mdio cleanups
Message-ID: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
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

Clean up the stmmac MDIO code:
- provide an address register formatter to avoid repeated code
- provide a common function to wait for the busy bit to clear
- pre-compute the CR field (mdio clock divider)
- move address formatter into read/write functions
- combine the read/write functions into a common accessor function
- move runtime PM handling into common accessor function
- rename register constants to better reflect manufacturer names
- move stmmac_clk_csr_set() into stmmac_mdio
- make stmmac_clk_csr_set() return the CR field value and remove
  priv->clk_csr
- clean up if() range tests in stmmac_clk_csr_set()
- use STMMAC_CSR_xxx definitions in initialisers

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   5 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  82 -----
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 342 ++++++++++++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   5 +-
 6 files changed, 204 insertions(+), 235 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

