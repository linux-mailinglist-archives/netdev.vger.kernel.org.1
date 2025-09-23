Return-Path: <netdev+bounces-225580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231A7B95A57
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147A818A873E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDD322552;
	Tue, 23 Sep 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G+O7iS2V"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BC32255A
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626779; cv=none; b=h7i46xSNLh+OQfKcs/xm0kb5PhR7o8pzBFVvAxIJ04CaXF5ZudLZtMLSwFnhVRNVOnmQ5PqqHffQ8xgZV3jtXkVkAcfFL/ncsINhIRrYb3ADw72LMvASLLegcW23dq+bA1Dm8JLu86rBuMeGPvy/YtfkieVgzbIX8zbRfpR7kRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626779; c=relaxed/simple;
	bh=PhKxErV1s3+BPyYa4DaScAbcVMQWR03Lym+aTATVUbo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uiVmKonSZeW5p2lP9N7KjPOWEDgEaT9vtzA8Ri6MvtJWzq/u6COiRUxX4gQb2+RmqmXmfhrJxatFei8yi++DLcrL8DuBGzRD3snJgktQzYVajwN9I1wolDqhoj0yKsO6qUqKNDFsxSuuSpMwyz9PAD5CusU07SPowgqW42DYFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G+O7iS2V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tCpqzQGO7r4Lt40+0awVktocqJSSgzZ+p7YBEBNue2k=; b=G+O7iS2VT85kDkAUX1as4e5m7i
	d99dOb2XqMAFeVLNnb953OUhwGUKqpQpZVYgZrxnPOqFArY0+SzcWsEDc3DvphL9ODbP8tQcOCJ7O
	TK54Uh7jaryGQHOZM3U5AJZEM4SpSOK9kVs1XsLPmyV/8I8fBxnxXUaLDUOZ5qo2R1FsaYiwUyH9s
	B37iafufFT5GBhid+8H8cMr9cmAezoIwfONPDSx8WCNAndF923VMzuUL5xlM37E39isJcur/h0rID
	qdh8IWAOkuSJQJliCSWVp4ncaXhEKcdLJkqheMdLBqBSJfwesiV7ewZ61w+fTjsYATsIr32tS+cQZ
	6P7hVYHg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50756 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v119u-0000000078c-2Zi7;
	Tue, 23 Sep 2025 12:26:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v119t-00000007744-2SxG;
	Tue, 23 Sep 2025 12:26:09 +0100
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/6] net: stmmac: move PHY attachment error message
 into stmmac_init_phy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v119t-00000007744-2SxG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 23 Sep 2025 12:26:09 +0100

Move the "cannot attach to PHY" error message into stmmac_init_phy()
so we don't end up with multiple error messages printed when things
go wrong. Drop the function name from the message, and use %pe to
print the error code description rather than just a number.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3b47d4ca24ca..8831bbda964c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1157,7 +1157,10 @@ static int stmmac_init_phy(struct net_device *dev)
 		ret = phylink_fwnode_phy_connect(priv->phylink, fwnode, 0);
 	}
 
-	if (ret == 0) {
+	if (ret) {
+		netdev_err(priv->dev, "cannot attach to PHY (error: %pe)\n",
+			   ERR_PTR(ret));
+	} else {
 		struct ethtool_keee eee;
 
 		/* Configure phylib's copy of the LPI timer. Normally,
@@ -3939,12 +3942,8 @@ static int __stmmac_open(struct net_device *dev,
 		priv->tx_lpi_timer = eee_timer * 1000;
 
 	ret = stmmac_init_phy(dev);
-	if (ret) {
-		netdev_err(priv->dev,
-			   "%s: Cannot attach to PHY (error: %d)\n",
-			   __func__, ret);
+	if (ret)
 		return ret;
-	}
 
 	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
-- 
2.47.3


