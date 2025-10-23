Return-Path: <netdev+bounces-232041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4366C004B1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD011A669BF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DFF3093D2;
	Thu, 23 Oct 2025 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="spOAYPTm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAE309EEC
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212274; cv=none; b=UGuH04YrSLbg/LrhOHKv2KX+5l0J5/eq+oQc5d3ZaMG3xF3jzx/lKbli4Nm9OJg8WnWK0DFEbWBjIQL3tDv1GB7ZrkfwLDwSETe2eRm1UCJzS3ygci3gdV+AEf2aGOR4v5/lhYkfoAUdp5jbm2Mmiy7YZrbHI8WF8BYzpACygIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212274; c=relaxed/simple;
	bh=OR0wFvhjcp7Vvey28ae5bbDlH2VMGtdluJ1s7NiaF2g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CIRGhSKLLZxiAdtoDQeT3HlMFwdXD7DQeBjLBOB5L9W1wD005JOcBeFQXV/r4RfnNzeWhEhJBy4Uj9kAACZSGBTEDPTU6ZfnaEIjYElgtRxzBG0RcGlEQxFu9knS1l2KBZV2lBxf2IT/TN8ykks1oZqE3TxyU+cret2Fe7TJiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=spOAYPTm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XQpp6e12o8o5ca/C4/8QrzOHzPoPBqTK/7krBrQ1u+c=; b=spOAYPTmYdcCD1O9L6qeYTCkAB
	LGOta14RwmzdNgChlKUtHMzU5a24jCcDkuLD24/XDmdHoo7U0+J9fYLsC0wLuN4Ne3yhKYsBN2eF4
	J8UJZsDE0buCkreT0prTb+eZX3owwTf/kaS4BQFk66TOGJIff55dYHSEOun5sj1JO3djv7O/mlLER
	zRN0nWghPt8FGJ4ABx4IaPAgfVI0aEN6fTDP0Xe7KGWPESdyDT7PgwBNEQal38HbYOUj4WcndXXjl
	MBO5FmmFdTVHO2Z9JfBMKMjcMKt+hYTTjcLvkO+ZxjagC0hzZ1gbOfEw7038CjIQwNITdiIRm455m
	edYiYuvQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53284 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrlR-0000000065s-2R6g;
	Thu, 23 Oct 2025 10:37:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrlQ-0000000BMQA-33N7;
	Thu, 23 Oct 2025 10:37:44 +0100
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
Subject: [PATCH net-next 5/8] net: stmmac: use FIELD_GET() for version
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
Message-Id: <E1vBrlQ-0000000BMQA-33N7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:37:44 +0100

Provide field definitions in common.h, and use these with FIELD_GET()
to extract the fields from the version register.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 3 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 31254ba525d5..a89fe25f1837 100644
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
index c156edb54ae6..78362cf656f2 100644
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


