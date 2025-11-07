Return-Path: <netdev+bounces-236688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE95C3EF39
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F240B3AEED4
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA030FC03;
	Fri,  7 Nov 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zHDDpuht"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30B30F7FB
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504134; cv=none; b=QWsVkN2E5RvI4rqm2nfQtHT7fynkM6wB+kXJG495mZ8iuWNQTyqleIs82LhVaPGfSw4+y1DijrPQp1HxAn+jskukEYGAbW5+OoXnBKKc54m4Y2nVyW2kbLhE8ypZSkpNjP1lTreaUVnNfzgeN3WhGCPlP2njWnopGesBDjqDLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504134; c=relaxed/simple;
	bh=0pRu7E34mKZD0b8Cypvh5ckQH2tIAb0rfdYFAY4culM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pRUll7kS6r8QmWPlpeBWMSn72c8Z6G/ftO5zoQrhTk+DevsWEzuOxiV1UsPV5vbfm3TYj12G2v3n0WQNbcpYFUPuh8yobFh3APtHe2VBLc/HX9LT6fcl78k7hfYiJwndK4IQPiltE6e7yAnt6AHBWlAE0VI0/oZ1cH/hW83IZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zHDDpuht; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0LyqkunqlwPyREzM/Ps1cP/Qnf7gUD00sr/ZoFVgZeU=; b=zHDDpuhtzwTGjBaPDffscCbDYW
	LZW/ZqNMCUeCqxhsXX47JxOqD6u5TEbNm4pmmMBaU5wiXXrNYlXPauhXSbaqzHBpI0oMnU76wew6J
	v4xEJAMtDwMCnXseOMy5N7Vf2W2k4fLfYMzySkOLHeGONyEfgPB3cUjq6uUcaKqzshaJ/YrO84KcW
	T5cuX/qkkdWjFOp//0dvgpr1RhLStAWEi0LUaRcBcoSiegoQxpnrFaXAUHf5vq68zb0INX/8QpKP7
	zKccvnuuNWcwE3Ai6B2kW8pZLi5AXKo6nBC1qovfiDDHr5yspZ9x9nPYk1DtENsYqCr3cqDHNkdGb
	kpYEFj+A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35522 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vHHpu-00000000697-073w;
	Fri, 07 Nov 2025 08:28:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vHHpt-0000000Djr1-0wwr;
	Fri, 07 Nov 2025 08:28:45 +0000
In-Reply-To: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
References: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 03/11] net: stmmac: ingenic: use PHY_INTF_SEL_x to
 select PHY interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vHHpt-0000000Djr1-0wwr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 07 Nov 2025 08:28:45 +0000

Use the common dwmac definitions for the PHY interface selection field.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index c6c82f277f62..5de2bd984d34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -35,10 +35,10 @@
 #define MACPHYC_RX_DELAY_MASK		GENMASK(10, 4)
 #define MACPHYC_SOFT_RST_MASK		GENMASK(3, 3)
 #define MACPHYC_PHY_INFT_MASK		GENMASK(2, 0)
-#define MACPHYC_PHY_INFT_RMII		0x4
-#define MACPHYC_PHY_INFT_RGMII		0x1
-#define MACPHYC_PHY_INFT_GMII		0x0
-#define MACPHYC_PHY_INFT_MII		0x0
+#define MACPHYC_PHY_INFT_RMII		PHY_INTF_SEL_RMII
+#define MACPHYC_PHY_INFT_RGMII		PHY_INTF_SEL_RGMII
+#define MACPHYC_PHY_INFT_GMII		PHY_INTF_SEL_GMII_MII
+#define MACPHYC_PHY_INFT_MII		PHY_INTF_SEL_GMII_MII
 
 #define MACPHYC_TX_DELAY_PS_MAX		2496
 #define MACPHYC_TX_DELAY_PS_MIN		20
-- 
2.47.3


