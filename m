Return-Path: <netdev+bounces-182887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EAEA8A465
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED50189E81A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB88268C79;
	Tue, 15 Apr 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m2W1M6XJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CB29B76C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735371; cv=none; b=LcWWDRrpbfWdGLS03CBLMdSl1+y2DarbNNr0Ztg3kLXkTAXTGvyKnLNfKXWYGA/6GwFHiN3T0IiVavmoK9VBK6z3zA+GaHpJJG1Aq+4l/592ZMGYXTAOCOymNtHk86ahceZZABdP/RI+v7F1l+mYXMf0LlHbVcztHnlVT3yFZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735371; c=relaxed/simple;
	bh=2Ayr8VIkdEKY+1ZB78PZRxVClNeUvC840qH2MzO9wLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TMHPZDsAgBFAMy7/ys23J6YuYSIZ1ni6TtJzz5wwaz6zZDV89kMnjIepUdXhjiW9fIQ8Dw16EC4ay96BBsKjSipMXp+4Swos5tzvQzY3fNzjE0aMFM5RlpRPgE08G4eqW5M4s48MjyYnQa7A1HIJ7UiWpxlIHYIn7QClvsTP5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m2W1M6XJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k5sn0c6EnK9MQwe7/DFbVJ/3yq40vsmcM6FfsWqie5M=; b=m2W1M6XJOPCYLAtdn5g6aK359J
	RlC0Ip1UHsog4S2oa/AZA0jnCbVWilrDXYZDfYbLvfNabQM9rBnvY6DtnH8/mElHn42/yxo0eyQVI
	IO/QpL/cYgBaPZPF9xZq6piwT1CM34R2Pim9+5WogOPDC+VeiM7GSFQx7mirZMk7+PXhj+LRkv/W3
	Dr4GeQt40Kefw4YhUZyrayEBbhuv7Lg+enVZykW+zV1/8EeA7mX5qQdKsIVLap/i4qmdhUukX+OgJ
	hsq3QslBcvX22lapOZ2jdVMCsmpzbErIHBO5b5pk60BOOoxgqWGrPjfoFnbEtaBydBQTAp6WTXmz4
	AYPr3gpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56610)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4jMv-0008Vb-2y;
	Tue, 15 Apr 2025 17:42:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4jMt-0000X2-0r;
	Tue, 15 Apr 2025 17:42:39 +0100
Date: Tue, 15 Apr 2025 17:42:39 +0100
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
Subject: [PATCH net-next 0/3] net: stmmac: sti cleanups
Message-ID: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Clean up the STI platform glue code.

- IS_PHY_IF_MODE_RGMII() is just a duplicate for
  phy_interface_mode_is_rgmii(), so use the generic version that we
  already have.

- add init/exit functions that call clk_prepare_enable(),
  sti_dwmac_set_mode() and clk_disable_unprepare() as appropriate,
  converting to devm_stmmac_pltfr_probe().

- the custom suspend/resume ops do basically what the generic ones
  do with init/exit functions populated, but also add runtime and
  noirq ops. Update STI to use the generic ops.

 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 88 ++++++++-----------------
 1 file changed, 29 insertions(+), 59 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

