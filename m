Return-Path: <netdev+bounces-232038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD944C0049F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2083F3AA118
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D432FC009;
	Thu, 23 Oct 2025 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CdN6Ceka"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA953093AE
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212258; cv=none; b=mboCxTWQQzg9ShCgvH+NBDQtiNC3F5mb07CVrfBbISUQKPHLyTa+82zv6CMxyrFy13uwtug8XuxwzDvQWbJTHLM5v53BXufz2zNlloD35NE7zTVlU4ArOYbZ/5LdIGSkDRtWiFZA9wK6jG/0zTN2GCytvE8XlL+eWSaAdoeKGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212258; c=relaxed/simple;
	bh=mSvANulbTb2iz7GmLuYuROqChjMJITyDfu6eGj7HUQk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TsCoatmXEKXqwqdQFuw3cf8lJ6W3bX1IYaamAiuDT86yQUYfCrbRB3CeSoAGvYKuZqGAn4g/CgeOMVe7SQZqIJKJOaunwLhrCL6CpekGyvyT2OTOUY8JnUDNsTUmM9Ov9+xbuEauSYO0LtVmAyVf5V7l0XCAf4NC6sUShwuzlbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CdN6Ceka; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4IR15YmOi30IOFo+C5GF3Vg22Y2q6B0Iun6RgdkPXEg=; b=CdN6Ceka+/zjQIEZ8kYbkAcKqA
	REh4YekMIC8ImXyLWn0Es2/GWoS6q2jsC49Y0B06JerTuFKvhxrJjlED/URWgtNUPqMVjXBmKXOUM
	QJyuCJelnd3IKKXy3ubjQnwhPgGkQwCCwj1nvOKu7LPX08iTAwVXuuItWPsG4yhTXLOaH0wqwNoTb
	0ciV4iAHofBCXhoH591b8E0pyxxT0wDfOZq7q8fXVoZhc9mTsC0m2xYruUdrETBbn4XwhcUq6eKnY
	i+hO/8Iljq98bLJQA4fCxxcElvxlGELI3sn2LQb8urgAadM0kNIMSyphn4pxypsD/TsgYIbeRGQSO
	7czPVxMA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37978 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrlC-0000000064v-0l63;
	Thu, 23 Oct 2025 10:37:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrlB-0000000BMPs-1eS9;
	Thu, 23 Oct 2025 10:37:29 +0100
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
Subject: [PATCH net-next 2/8] net: stmmac: simplify stmmac_get_version()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrlB-0000000BMPs-1eS9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:37:29 +0100

We can simplify stmmac_get_version() by pre-initialising the version
members to zero, detecting the MAC100 core and returning, otherwise
determining the version register offset separately from calling
stmmac_get_id() and stmmac_get_dev_id(). Do this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 44e34b6ab90a..7ee304e3599a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -49,18 +49,22 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 			       struct stmmac_version *ver)
 {
 	enum dwmac_core_type core_type = priv->plat->core_type;
+	unsigned int version_offset;
 
+	ver->snpsver = 0;
 	ver->dev_id = 0;
 
-	if (core_type == DWMAC_CORE_GMAC) {
-		ver->snpsver = stmmac_get_id(priv, GMAC_VERSION);
-	} else if (dwmac_is_xmac(core_type)) {
-		ver->snpsver = stmmac_get_id(priv, GMAC4_VERSION);
-		if (core_type == DWMAC_CORE_XGMAC)
-			ver->dev_id = stmmac_get_dev_id(priv, GMAC4_VERSION);
-	} else {
-		ver->snpsver = 0;
-	}
+	if (core_type == DWMAC_CORE_MAC100)
+		return;
+
+	if (core_type == DWMAC_CORE_GMAC)
+		version_offset = GMAC_VERSION;
+	else
+		version_offset = GMAC4_VERSION;
+
+	ver->snpsver = stmmac_get_id(priv, version_offset);
+	if (core_type == DWMAC_CORE_XGMAC)
+		ver->dev_id = stmmac_get_dev_id(priv, verison_offset);
 }
 
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
-- 
2.47.3


