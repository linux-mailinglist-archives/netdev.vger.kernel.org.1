Return-Path: <netdev+bounces-232540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230AC06526
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5DB3BE0CB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0298D316196;
	Fri, 24 Oct 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nrh8Jo4W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D67313290
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310177; cv=none; b=PQFZGHmel9HeLiCgRcKTByvuCNpBt0Zzs9v6JwN1pNYdYAv74z3AR9lBCk1J3/es1HDSFpIOrhFJOGnGKBHlNzaPsAUCsKQo2lj/O+u6gDIKEh3D3iKLaLrBFX3AhiKyN8HOC/06GW7P8yNJTugTRBupORl7PaiRpr+cWJtskx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310177; c=relaxed/simple;
	bh=IFAc864vA3DRUyvpmWl+kSOq8eHax4g8DPHsDpNpfdI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YNJdFRXHxXZ7hYpn2CP8CEUK7oVEJJHYkql/UB56/EGEmKDO1p2zH7jopqV2W/QycgY7+YqA3IMRY0cdTwCTceLeCNrSFuCEBM3V4jwJlcsEMbbN63Qs9RcwdygE75Z4IP5bB67ndOA5182fqRzfvL7RDKyCmGvYsl3DTb1ApnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nrh8Jo4W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GYa1n3ROase+LapnQKxZJAF4u1UpN7+HlpMRVAW9AtM=; b=nrh8Jo4WbpxCA0qRREq3GkVlYx
	tjn6ZR60er7PJ5xvRh21mh69WQEdto5Q7L3qME2oATTnBsj9d6oh+VMkQgB+CNkKWl4cCW5rA+AGB
	K9Z8cJrKBgbgOBj35VSbTWdqz9d3mVy8phE+EVXFHUjEQ7SU3b4mNzTJjLryhjo+xaK+BxScWDnUh
	fJfAgPeeWa3In8IjF3x6BeASzWowoJ2M2/j+DddpGAgRcD5udxgshJ/tHAdbxYc8g4JA+ibpxYaPb
	HXhyDCq4ybydl+HbRLa00cngy+JbEnjXM+RaiIDmRZj911szCjT34wWjcz9RCxoFD4env+D9qYBye
	H04eqKDg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56360 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vCHEU-000000007au-1vC4;
	Fri, 24 Oct 2025 13:49:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vCHET-0000000BPU4-2f0F;
	Fri, 24 Oct 2025 13:49:25 +0100
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
Subject: [PATCH net-next v2 5/8] net: stmmac: use FIELD_GET() for version
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
Message-Id: <E1vCHET-0000000BPU4-2f0F@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Oct 2025 13:49:25 +0100

Provide field definitions in common.h, and use these with FIELD_GET()
to extract the fields from the version register.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


