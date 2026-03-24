Return-Path: <netdev+bounces-270951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FkUK7RZwmnQbwQAu9opvQ
	(envelope-from <netdev+bounces-270951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:30:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E73059BC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3078A30E74E5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88232BF5C;
	Tue, 24 Mar 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BZFuNgKc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE2372B57
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344106; cv=none; b=IldewwFEV3uZIEuMNF2AcbhY/KXVJv/E6m3EaRnHiQg7OyCTGaJYqhZxgwmwMQEat7f0dsiYD9AYeWlfisjf8SeNhEYhxGEshAa0x/k/DnKgIDLnlp0FLXWhk1Y7X3bxQg2JLVSL3pGAMszuxLhLuFw1ci36DCtMBU3GYEg5jCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344106; c=relaxed/simple;
	bh=AyRiTGcPXYmu3RZtu7TRaFSdrS/g+khupPFj0y8aDjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUKxZG8mRDt+jzQXnKkfE2qbpfWHaY23nFZWdeqoD50WqbJjAhEBFewF4eolWgSvP4L5hArFU2IUqsxFrgMAZ6vbTG4gDGT9e+qdY9x117JKRv288cLGwWt4hWslkANEETuww9mEuV2HDB1gmR0GEDYDs9uhQWCjTHBG+jRO3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BZFuNgKc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4863E1A2FBF;
	Tue, 24 Mar 2026 09:21:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C16B6011D;
	Tue, 24 Mar 2026 09:21:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAF8C10451116;
	Tue, 24 Mar 2026 10:21:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774344091; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2MaJGVLz8R3aV7CXG66GxuSg5iwkZ6E8Ug7Y4Ilvlj8=;
	b=BZFuNgKc93q5zEqH9mzxnRoQqutfe7rG1jo52LFXE7ApKnSpBMhC0YodgvKmQ0v4A6n020
	RfdyqJDpz+CipOpRWNoHZ4x8J0i478dY/k2gRgRQTTkjiV9wPjmTK5LPY5e1HMJQzof1I/
	Vc5m1E2LhTEi8P+iNdZalfHXhKF9tBSja1k5tkf/BMTREPQRStBRtG+AOlAT0lLPKhUSIY
	1J9TjHoFxGty2NFiRlOxTFObB32ZLQ5tUx9UgC89SwpErxwXRBC3zeNinQvYitT3FVNEf0
	ka0cSclctExJrh2CUsFibU0uX64f3Xe6wnCJcyXq3KATXXogQZM8wwNZ8WFk/A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 4/5] net: stmmac: dwmac-socfpga: get the phy_mode with the dedicated helper
Date: Tue, 24 Mar 2026 10:20:59 +0100
Message-ID: <20260324092102.687082-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-270951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 519E73059BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We enable/disable the sgmii_adapter in the .fix_mac_speed() ops based on
the phy_mode used in the plat_data. We currently get it with :

socfpga_dwmac
  ->dev
    ->drv_data
      ->netdev
        ->priv
	  ->stmmac_priv
	    ->plat
	      ->phy_interface

where we can get it with :

socfpga_dwmac
  ->plat_data
    ->phy_interface (done by socfpga_get_plat_phymode)

Use that helper here.

Note that we are also being passed a phy_interface_t from the
.fix_mac_speed() callback, provided by phylink.

We can handle that in the future when dynamic interface selection is
supported. We'd need to guarantee that we have a Lynx PCS to handle it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 629074dbbc15..ae40de2ed8eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -89,9 +89,9 @@ static void socfpga_dwmac_fix_mac_speed(void *bsp_priv,
 					unsigned int mode)
 {
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)bsp_priv;
-	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dwmac->dev));
-	void __iomem *splitter_base = dwmac->splitter_base;
 	void __iomem *sgmii_adapter_base = dwmac->sgmii_adapter_base;
+	phy_interface_t phymode = socfpga_get_plat_phymode(dwmac);
+	void __iomem *splitter_base = dwmac->splitter_base;
 	u32 val;
 
 	if (sgmii_adapter_base)
@@ -117,9 +117,8 @@ static void socfpga_dwmac_fix_mac_speed(void *bsp_priv,
 		writel(val, splitter_base + EMAC_SPLITTER_CTRL_REG);
 	}
 
-	if ((priv->plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	     priv->plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) &&
-	     sgmii_adapter_base)
+	if ((phymode == PHY_INTERFACE_MODE_SGMII ||
+	     phymode == PHY_INTERFACE_MODE_1000BASEX) && sgmii_adapter_base)
 		socfpga_sgmii_config(dwmac, true);
 }
 
-- 
2.49.0


