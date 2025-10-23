Return-Path: <netdev+bounces-232040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297CEC004AE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AB11A66B21
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A53090D6;
	Thu, 23 Oct 2025 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ib+UnU65"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAE3093A8
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212269; cv=none; b=gsgEPLHPy7yQIEF+/oJVI/LiuNFPX16Ahos/kjPSV51/0byirIXHIKq90KoNl9Kc3kNh9sj6YF9WZy38zHfpCVCR1LMW8rJnrCcnaNwmAketMjBuFJB6IQEspcyv7TyzJa4QwrEcSX+BUNroHJs5SXCt6KnQLcvzfqtiDHc91IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212269; c=relaxed/simple;
	bh=bYOdDcRvWVnqluNm866Ud3caZwk8qtPri8N+BRuxsk8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Ups7Dlj8jeH+9nHG9UL9oCOcEjO5D68QoNWo6rPew1i9w+l9rqkZvnSroPXSFFyjRbEUT9hzNswv3TYwh8PvnjLfGUalzXCpjgOzxVK/8rKwWfgavGAnED0OfiHhGw59tqwD2iBbwNnbByymrcY4tBe8Wu402hATGffhuwq1/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ib+UnU65; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A1wvuOZT4tI8K196PYO4I+xxIuiyng5VUqBfHYf3Qao=; b=ib+UnU65NZ75YBlcJpGFAzYl0F
	nvXoxGCSfLSydHOARb9OeQZkQ0f60KCce6UWfyaUqHpJ0O8hwSHdcryBEkpTu2PBCdrvzvsOieBwo
	8iGeDYa7aVrNAPUeDepYd26KsPZrY1ztZgjkPgmew+21HoL94HgwuD2tgwOxWEa7O1qgShsJs/FMi
	/VNNvIPuu8BqNORcLCi2LS3YPh8lfKhvyq7QpJohZ04si4Wn8GYEC4rV+q2FwBqYzsycfwi++Nubf
	1OvGZJVZgg4wu2pbiVwZusEQhoJquIzZ7AabQlQ6T0hSma+WJKsJx/p0haF1iDwnwVH6XGife/Rqb
	v1W3DTjQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53282 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrlM-0000000065X-30IK;
	Thu, 23 Oct 2025 10:37:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrlL-0000000BMQ4-2Zlg;
	Thu, 23 Oct 2025 10:37:39 +0100
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
Subject: [PATCH net-next 4/8] net: stmmac: move stmmac_get_*id() into
 stmmac_get_version()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrlL-0000000BMQ4-2Zlg@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:37:39 +0100

Move the contents of both stmmac_get_id() and stmmac_get_dev_id() into
stmmac_get_version() as it no longer makes sense for these to be
separate functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index c446fafdd804..c156edb54ae6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -18,19 +18,6 @@ struct stmmac_version {
 	u8 dev_id;
 };
 
-static u32 stmmac_get_id(struct stmmac_priv *priv, u32 reg)
-{
-	dev_info(priv->device, "User ID: 0x%x, Synopsys ID: 0x%x\n",
-			(unsigned int)(reg & GENMASK(15, 8)) >> 8,
-			(unsigned int)(reg & GENMASK(7, 0)));
-	return reg & GENMASK(7, 0);
-}
-
-static u32 stmmac_get_dev_id(struct stmmac_priv *priv, u32 reg)
-{
-	return (reg & GENMASK(15, 8)) >> 8;
-}
-
 static void stmmac_get_version(struct stmmac_priv *priv,
 			       struct stmmac_version *ver)
 {
@@ -55,9 +42,13 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 		return;
 	}
 
-	ver->snpsver = stmmac_get_id(priv, version);
+	dev_info(priv->device, "User ID: 0x%x, Synopsys ID: 0x%x\n",
+		 (unsigned int)(version & GENMASK(15, 8)) >> 8,
+		 (unsigned int)(version & GENMASK(7, 0)));
+
+	ver->snpsver = version & GENMASK(7, 0);
 	if (core_type == DWMAC_CORE_XGMAC)
-		ver->dev_id = stmmac_get_dev_id(priv, verison);
+		ver->dev_id = (version & GENMASK(15, 8)) >> 8;
 }
 
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
-- 
2.47.3


