Return-Path: <netdev+bounces-232042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE9C004B7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8421A66C5B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1495309DA1;
	Thu, 23 Oct 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e511UzWh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF63090E4
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212279; cv=none; b=gxasmloSM1c1/Yh9/2s4dqL1dCNFEhLiaGEuRg2HwGhyMtzlVKeBWO0m9EVzGQFDbzHkkVi4vO3olIgfkPBrUGpM6Was9+6bVKi5AGDOUPeGKl3mNXb8Nmll/gmh2m26GzbqCHha6nveKkNk+nxsrKdS75Nx6Wrz83Y+Y2giAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212279; c=relaxed/simple;
	bh=rw8Z/Ce2Gr5ljalmZ1LacFxIRDskE56mRoKUxCZ7G0g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MZWJVHL6dxGGLmnBjaGvBKb3aLerUAnqdALNo89zfTTJGKbBpfASl9umOYfoE386ift6PdXMx9EoqfuJHnS3kCNeW4wQLX5oa0XwsAM4OUXQumNpnqcpLMYNF+Y3DIEZ2T7c39PTxMdLGE7NT4Uv3VVc+fyfuCulrsCxiyEZaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e511UzWh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DKgvUFVBctlLYMwtQ/LsBxRzCiL9WjkZr3ppPZuy/1o=; b=e511UzWhGw9Z4YFHpA5AnwH1u2
	aMJcrFr+CwvRXz7BEpVBcZvXID6yDG3MDKiDFY12WHjHR0FWCpuNgZ2WeCLr/2ucoOxoymTYkhbCJ
	dsGQFRXE34tlAfA9kE0ZKVOiD21CN8iZMY6bUTtPaKaz3gizj00/CTYx0p3ElDN4Ni8g0F13yd66n
	Sid9mxMDpAElTz28Q63AAb1euv+7D12/z6ttryJyDR1+hFRl54WGXW3dLnnNijZiJLPZYERVvlKtr
	8vkXcxn0kOOtf5TGjedW6T/KailUTEu4Ei5gbWyd32NFmPHbUW8TC057cgnSN1N/19gRyNaNsMhXH
	ojMy4IaQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50822 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrlW-0000000066D-4AKK;
	Thu, 23 Oct 2025 10:37:51 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrlV-0000000BMQG-3WuD;
	Thu, 23 Oct 2025 10:37:49 +0100
In-Reply-To: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 6/8] net: stmmac: provide function to lookup hwif
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrlV-0000000BMQG-3WuD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:37:49 +0100

Provide a function to lookup the hwif entry given the core type,
Synopsys version, and device ID (used for XGMAC cores).

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 40 +++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 78362cf656f2..6c5429f37cae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -299,6 +299,30 @@ static const struct stmmac_hwif_entry {
 	},
 };
 
+static const struct stmmac_hwif_entry *
+stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
+{
+	const struct stmmac_hwif_entry *entry;
+	int i;
+
+	for (i = ARRAY_SIZE(stmmac_hw) - 1; i >= 0; i--) {
+		entry = &stmmac_hw[i];
+
+		if (core_type != entry->core_type)
+			continue;
+		/* Use synopsys_id var because some setups can override this */
+		if (snpsver < entry->min_id)
+			continue;
+		if (core_type == DWMAC_CORE_XGMAC &&
+		    (dev_id ^ entry->dev_id))
+			continue;
+
+		return entry;
+	}
+
+	return NULL;
+}
+
 int stmmac_hwif_init(struct stmmac_priv *priv)
 {
 	enum dwmac_core_type core_type = priv->plat->core_type;
@@ -306,7 +330,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	struct stmmac_version version;
 	struct mac_device_info *mac;
 	bool needs_setup = true;
-	int i, ret;
+	int ret;
 
 	stmmac_get_version(priv, &version);
 
@@ -337,18 +361,10 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		return -ENOMEM;
 
 	/* Fallback to generic HW */
-	for (i = ARRAY_SIZE(stmmac_hw) - 1; i >= 0; i--) {
-		entry = &stmmac_hw[i];
-
-		if (core_type != entry->core_type)
-			continue;
-		/* Use synopsys_id var because some setups can override this */
-		if (priv->synopsys_id < entry->min_id)
-			continue;
-		if (core_type == DWMAC_CORE_XGMAC &&
-		    (version.dev_id ^ entry->dev_id))
-			continue;
 
+	/* Use synopsys_id var because some setups can override this */
+	entry = stmmac_hwif_find(core_type, priv->synopsys_id, version.dev_id);
+	if (entry) {
 		/* Only use generic HW helpers if needed */
 		mac->desc = mac->desc ? : entry->desc;
 		mac->dma = mac->dma ? : entry->dma;
-- 
2.47.3


