Return-Path: <netdev+bounces-235800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA30C35D3F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6015D6200C5
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813EC2E88B3;
	Wed,  5 Nov 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Dowh7Dim"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F01F5437
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349194; cv=none; b=cxmyCEI+r/RjwtcPOj6wq998Y/s8pFxwvFkwzGDguaPXWVr4ceUF02+ZXQGKPdZuPsgPYa3pqm7RfJUULXMGBnHFz3jKyoibEbFWDqH0ikYj9/FjK0vhJkn73RYuDkEnkvzkvrUt/GsQ1mvJ8iKUz8lbMVeMuKPevNMffcT1aEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349194; c=relaxed/simple;
	bh=vgUwB4+OupFGo8Ok6mzcL9vuyU+zJ/9sw7c4eBQi9sk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=UImo/EvpEriys74n9+UXzDMsxpbv5JJZcF34ecmXVaLHJfaLWJi7awT8EPUWYHDE/fUNSaDp5xXvsuWo8obQNGCeTn570QCjNqZX3Yj+7y8hto+HFJenh+BKStRs6/veBsaSysDj1mRLaV6Ev61buF8U3KyyGU47jDV+fcNXhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Dowh7Dim; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RV2Kcd9Kteghpl7hZuqvVfyvxIDyd7jGMl9t2h0yvHU=; b=Dowh7DimFwjM9fcbSeovkBUgyg
	zVXufS554KbQ3xaWFmXGpsX+fcldau1Jd4KQMwtqVt9hpmbPQ5nwrBoDbxLjzVsc+KmkWSmRbFPVI
	z7hGN35RYY2BhLwS+4CJgyJKhfyx2jq3fkrGMLjEman4sGu9/iwkQD88I9TK4MfZwQzpEJdCRmZ3B
	YNe1GzdGP+kOA8KTwTCjpV5ypAd7HMs6LHoFtNNpC/bVUpQAg6/96NlMGetkh6LE0NPAtyDFCZJto
	xvGVYQiVO/r7yvrECp21UOvbxmSBHcqsnZjiN5C6OzacIyH2h2qeNNAEDQtY3NBPqD9lpC+4J5NWr
	JbRo60UA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44758 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGdWq-000000003S8-2B6N;
	Wed, 05 Nov 2025 13:26:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGdWp-0000000Clna-18SE;
	Wed, 05 Nov 2025 13:26:23 +0000
In-Reply-To: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
References: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 03/11] net: stmmac: ingenic: use PHY_INTF_SEL_xxx to
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
Message-Id: <E1vGdWp-0000000Clna-18SE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Nov 2025 13:26:23 +0000

Use the common dwmac definitions for the PHY interface selection field.

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


