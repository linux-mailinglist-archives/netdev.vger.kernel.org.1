Return-Path: <netdev+bounces-233702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342AC17773
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B6C3B666E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7F1EEE6;
	Wed, 29 Oct 2025 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aGlJKFKn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA620322
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696221; cv=none; b=Kz4bV2AQeeNG0vveObf6QKVyI/u84vgjDKeYXi1qz9Rgjlx/U7VGOy4vNCKEfu4wwlv+1YR2yy5AmG2KvZ+vdxVYwwZ10l9SgwBEV/qHA4YmBvU1sad6XiqYuKOMxT2x9uD1TYouuDmZ0HmNg/cFMkzen0f1dBLxNHiO+6+r/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696221; c=relaxed/simple;
	bh=p4/gAeR2lRI7P24av0IyuuIjQb70grFLbIwzG7/3OoU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hqdITQPVtO3fSoKBEvGDWpVdbkExR/Nfi8TwyqtLiHeWhmC0fW7szXQ4lJWiZWDjRISsYjUNRMZCmzlnXI7l3VwQv6qvG22536kkGtP9eZdmV1GtI8sQ1L6a977GQtiVeubps3emjZIcoidECuWBNgRSCe/gd8Vlny03TcSFK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aGlJKFKn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uVOviFkfkbKPyjvpv7hyyD+FIA0rORZkYCZY4pIXb8s=; b=aGlJKFKn6/8tudMxY0RPFwQhRX
	rMB63JtKkfIWplWP4sRQ5y/yW80r8siy1DpfMpO3yJHVbJOSoQ1n2JENloIjQs+MbWJpwzYDQdeRz
	XwV5BSyvdUrTQ4Yr4gwoJBnTmZx5kZ9aOy29U5jq6I4KyRG7tJMUCX+6lqcok/WUCQFlLhS71raiw
	LLKPItQ/JhYYgdZE29su9OO3oLjWga4REEXduqtCww88fqXq8DVxl8Pnec0EJcHlVvsSz6i0tU6DG
	U2p5rCc6uv0u0jy9zG2iO2UpkB4NQmgSD1XJImvbCFnYIwtEhtbHzG8fjIdAEzboKn37+n2CAmGQf
	rd4WdAKA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56182 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vDtf2-000000003hc-13Yk;
	Wed, 29 Oct 2025 00:03:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vDtf1-0000000CCCF-0uUV;
	Wed, 29 Oct 2025 00:03:31 +0000
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
Subject: [PATCH net-next v3 5/8] net: stmmac: use FIELD_GET() for version
 register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vDtf1-0000000CCCF-0uUV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 Oct 2025 00:03:31 +0000

Provide field definitions in common.h, and use these with FIELD_GET()
to extract the fields from the version register.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 3 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 553a8897b005..27083af54568 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -26,6 +26,9 @@
 #include "hwif.h"
 #include "mmc.h"
 
+#define DWMAC_SNPSVER	GENMASK_U32(7, 0)
+#define DWMAC_USERVER	GENMASK_U32(15, 8)
+
 /* Synopsys Core versions */
 #define	DWMAC_CORE_3_40		0x34
 #define	DWMAC_CORE_3_50		0x35
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index a4df51a7aef1..26cc1bc758bf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -43,12 +43,12 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 	}
 
 	dev_info(priv->device, "User ID: 0x%x, Synopsys ID: 0x%x\n",
-		 (unsigned int)(version & GENMASK(15, 8)) >> 8,
-		 (unsigned int)(version & GENMASK(7, 0)));
+		 FIELD_GET(DWMAC_USERVER, version),
+		 FIELD_GET(DWMAC_SNPSVER, version));
 
-	ver->snpsver = version & GENMASK(7, 0);
+	ver->snpsver = FIELD_GET(DWMAC_SNPSVER, version);
 	if (core_type == DWMAC_CORE_XGMAC)
-		ver->dev_id = (version & GENMASK(15, 8)) >> 8;
+		ver->dev_id = FIELD_GET(DWMAC_USERVER, version);
 }
 
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
-- 
2.47.3


