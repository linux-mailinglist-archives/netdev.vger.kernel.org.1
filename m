Return-Path: <netdev+bounces-233703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4DC17779
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF31D404153
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE311CAF;
	Wed, 29 Oct 2025 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hwG5/lej"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210D1CAB3
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696227; cv=none; b=HYrQ50T2msuOj2Ne5z1dy5W2+poae5B47JSBKacrBu5EWBq46DFr9DlCCV6AWgC5lIaMPO6pi+JD9RjNO4PZwdMY/X3hSwWQMDi4eoD4+pBHFctyJ3E5AfPKKZgiodRGHQE5refeI4el22hw+aUZK36pmllPaxqGufQpiGeUwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696227; c=relaxed/simple;
	bh=hdeHOWbnsT6IIbKs3JDAq/I3OQBtPni43GsVdXfE+DI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=K5ISHMiIzLzmd3aEauw5n40Dt/lkfOWBla46v9KzMpSpl/ObhwTuAsuemXc7nYitdFalQOY5wTfaLSWPHDSDSCX2wxTnv8YmAToVQScLQoyDk9GKqTz6Oi/dHkOWbEHkEjbno9wCsH1udRpJTYXZEaO36OzUI+FqpPGUqBQsm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hwG5/lej; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=thLpG7fs2ihD+ToFoNCiunRlF5bc6gkGMjFRZXn8QW8=; b=hwG5/lej+RLBb0WH/WtAVdrPlL
	+AG7J0+Ab6qAdIbf8nNos1pMlyZUTXRdm0CpJsZ7t1DSF3UWBv4SlbNDn/C3Zp2NJMdTjKqr1pOMm
	uB/zAb42K6Ytr9CPsfylGzqVE/jkA46yZ5qeilvCsokPAw837WnW5qzjKKdU4kc+GE1A7yZCsJ2XW
	N5nKM9bB2Bs9LfU3ou04TUShQYnsXcTfuasFgkw/Kaz9atcsgMN7s2L4Wg/s437EInJt3s7zJjmO2
	J6Tg03zlHYoQn213gpCUI0cKMjLJ8uMXVI8FNE6SslgboYXQa0Dt/XhsALk27bzhxZKoWMUlM54Bs
	Vg7gMKQQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56198 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vDtf7-000000003hx-2XQC;
	Wed, 29 Oct 2025 00:03:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vDtf6-0000000CCCL-1cQA;
	Wed, 29 Oct 2025 00:03:36 +0000
In-Reply-To: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
References: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 6/8] net: stmmac: provide function to lookup hwif
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vDtf6-0000000CCCL-1cQA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 Oct 2025 00:03:36 +0000

Provide a function to lookup the hwif entry given the core type,
Synopsys version, and device ID (used for XGMAC cores).

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 40 +++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 26cc1bc758bf..892cef79c4d1 100644
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
 
@@ -339,18 +363,10 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	spin_lock_init(&mac->irq_ctrl_lock);
 
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


