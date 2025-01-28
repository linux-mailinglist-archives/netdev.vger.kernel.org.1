Return-Path: <netdev+bounces-161383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C17A20D99
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7773A845A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752D1D63E6;
	Tue, 28 Jan 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nT5Dv/is"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B931CF5E2
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079340; cv=none; b=GcyfbLYz6SZu5sJ8IFk5a1qo3kxUs4lTFxzKMFE4JkQ9s7iOOY3VB9F6FkscGXAo/eOdfwOE+dPeDE26nGVwQNEQSwuKPy4ghRwQD7Oq0Lq9r4Iazmyuh9W1fqNy2koqDgoNidU1A0aOq4CkyXvDg+aZhx0Ta2JoXUR7ylk6S1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079340; c=relaxed/simple;
	bh=nbgxpj0FpG6244JGxtTAv08/AJLwWyI+yts9EPSfmo4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ND4PuHvi2csQdQWOrYo7DamWTB/+3H3mihlVcB2JYEPUTPxBoauGONSyjj0uMV4CUhTS6DTVu5jCdjFbjJCfHUQRkhqKfBqn22iqOHi6MdSbi0oC7ZeHqHe/1cshuJx8XX248D8thVyinT0yA7cnFuBT7N5U5KJbbPSp1pwdYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nT5Dv/is; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QjfjNKm/xo2FxoguYUayqpH53OkqmwqZ6YW5PTiaRAA=; b=nT5Dv/isQyqg2A6Zpg5uYzZgJV
	GJgeT+5RxL5VFevCe7+etGRGUz0qWi3s/wBMlrtc0EVIQDuOlxdTZaYiLXsXWWwNBz7HQinSj7pxx
	f2kjB4IFBIa+Xq66IJqhnK4xSfq1xGuqO1FcUGJ+BKidPxrRI3q1CGob+pjrkdKm/ZicxKoRaOjH2
	dLYychnTrxIu8VEabL7f4GDHgCuhSBe+mD1OnRh2U64+3bBiBMh944L7gbLlY+w8I46ehYvzRNjkV
	Th9YXbyRPR8phuCyUM+l0BVFct+jMkhHUltRse7/EKgUlc74BxyJbx8wkc5GM4tBDej5cTZ51tLs9
	abt1woqA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59942 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnpb-0007YU-28;
	Tue, 28 Jan 2025 15:48:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnpI-0037I6-CA; Tue, 28 Jan 2025 15:48:32 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 21/22] net: xpcs: clean up xpcs_config_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnpI-0037I6-CA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:48:32 +0000

There is now no need to pass the mult_fact into xpcs_config_eee(), so
let's remove that argument and use xpcs->eee_mult_fact directly. While
changing the function signature, as we pass true/false for enable, use
"bool" instead of "int" for this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 6a28a4eae21c..cae6e8377191 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -602,8 +602,7 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		__set_bit(compat->interface, interfaces);
 }
 
-static int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
-			   int enable)
+static int xpcs_config_eee(struct dw_xpcs *xpcs, bool enable)
 {
 	u16 mask, val;
 	int ret;
@@ -618,7 +617,7 @@ static int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		      DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
 		      DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
 		      FIELD_PREP(DW_VR_MII_EEE_MULT_FACT_100NS,
-				 mult_fact_100ns);
+				 xpcs->eee_mult_fact);
 	else
 		val = 0;
 
@@ -1197,14 +1196,14 @@ static void xpcs_disable_eee(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
-	xpcs_config_eee(xpcs, 0, false);
+	xpcs_config_eee(xpcs, false);
 }
 
 static void xpcs_enable_eee(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
-	xpcs_config_eee(xpcs, xpcs->eee_mult_fact, true);
+	xpcs_config_eee(xpcs, true);
 }
 
 /**
-- 
2.30.2


