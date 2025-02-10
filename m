Return-Path: <netdev+bounces-164669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E6A2EA2E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E5C3AAD93
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199531E04AE;
	Mon, 10 Feb 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IIPUEr4L"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333A1E412A
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184879; cv=none; b=MkvJw8K8uQXbNoXC5EKhK33Dm3JC5Ude+GCN2BHg+7pNHtagbq8VqqS2kIc30jjVOyqdAXfkPPH2QotCxE0/CuN023qTsJpOgc7wF0R9yox9pzyHTDzkldqBzXWbLlhhK2Q680LmanlP+1h6obuK3bUQmcK980XL2rlhuadIbS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184879; c=relaxed/simple;
	bh=nbgxpj0FpG6244JGxtTAv08/AJLwWyI+yts9EPSfmo4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=T8VAHIsC4AMm510+X8T4+zpkSL7kSRmRTdsTj7cyYVoyXui4xpZxOACFxjc5x4yaTo3VaSbNRSvJAmq4+uYkOjeqTX+OkahpGS2eN2MLPI1B+RMOg+jpjFob+7rmno6WzElcysH/fantgHl4QwI3lOUP0L/2goKfkad2ohoeurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IIPUEr4L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QjfjNKm/xo2FxoguYUayqpH53OkqmwqZ6YW5PTiaRAA=; b=IIPUEr4L3IgtOhBNXZtGenJJVI
	eQo3OKeAEn1hUThqzRoxL8uBoQ2liFLUK4UIbUAwf2g0KyZSp62IYr8glaGYynSZgqi1K+SgJB/b9
	jc8R95hLyNCtGLjmJTaR7xnldCBI4WWT7dPVYg/rFIsKbJ3sHfBewzHwle4vFNxwtzoTr/395NY84
	5rNBxjc0WtzHIqOvG8qTBUkvzoYR4b7GhfzR2Vc8MEgmgZze10S8e8m3wJslEgSD/t2C37mSlNczy
	dNgTXuht0j4ELoIH+We2ggRMKwikDQ7QvVrz83qMHICSHPKWbTubvfFRdLemtDGqjSjE0RyeEKcyc
	ZHVsLThA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52130 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thRQs-0006Wp-0W;
	Mon, 10 Feb 2025 10:54:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thRQY-003w7U-IG; Mon, 10 Feb 2025 10:54:10 +0000
In-Reply-To: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
References: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 7/8] net: xpcs: clean up xpcs_config_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1thRQY-003w7U-IG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:54:10 +0000

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


