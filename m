Return-Path: <netdev+bounces-232541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B8C0652F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F4C1A68133
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF331984D;
	Fri, 24 Oct 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HdJRBB/y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6542313290
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310181; cv=none; b=FVxP7Z46M93sLwVCyuWs3+BuV9mT9r7T9yoLxg7udeLpe9wFW5iFcZarA44Rjvte6FjuXu9hewCIJSgOw3tKc03l+a12d/Dryp/q1a/oNA1QibQt8/nSuOE/hsCQaAVGUfxB1+UzeZX0crA/6ypKPtJ2IYZolO3h6NVpuIg+ahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310181; c=relaxed/simple;
	bh=xjAnbCmogQwElOy4vkOiJQykPFvJC4MwYBEH1hpEnik=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TV3w4Lk0r02WaqmTv08fYV14xeU/HuGDsVH6jYIuM85C58FtHdq6eXe7cjcj4N2Yd0dcj1nzYNwqsKiedeJY8YHHYRYyReAHZ9D4C8kYcpNWn8eVt5oAWDTqZUjPN/HMZg8Cx3KWIqMHceFoUTxD9481P3PrmV1Y0UJS4ARhCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HdJRBB/y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0s1zIVITkzDpoY2z+wXfYlssug2rKvdJy5wzSEv5dRc=; b=HdJRBB/y4JVbxYtTEQ0nrxZx15
	Cw4T+CAzxs2uyFjk9o2txXFqwBSb1FGDIadAzRS3SywHIZKTlNYEMBfxTzfllyMrZwXrSRYvcenQs
	uidAvbSsbLyJ6ktNRGHA+0CwxSWMOxTukTzvyeh4b1eAEPP09zuX8s68aOAHTNf8pIEFMoBMz+2Mm
	//jGw1ktBn5XYhK5Ucsc0C9pwRKGx7AsiCnsG4SLNHvbnjhNSWUw2BLq6z6frOcUBrEuMXDBJE9MN
	tNcn4dP+VAUDcKWwbcM5B7frDlPNEZxyp/3lp9HQW5XQgwtjfMiIYG8eNhcaV8XFIioacfM7mPoWW
	xOAcoieA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50602 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vCHEa-000000007bC-0iR8;
	Fri, 24 Oct 2025 13:49:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vCHEY-0000000BPUA-38qC;
	Fri, 24 Oct 2025 13:49:30 +0100
In-Reply-To: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 6/8] net: stmmac: provide function to lookup hwif
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vCHEY-0000000BPUA-38qC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Oct 2025 13:49:30 +0100

Provide a function to lookup the hwif entry given the core type,
Synopsys version, and device ID (used for XGMAC cores).

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


