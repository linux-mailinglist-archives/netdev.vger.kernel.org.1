Return-Path: <netdev+bounces-156353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3729A06282
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC053A2868
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95DA1FF1CB;
	Wed,  8 Jan 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xx+nhyy3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193182594BC
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354898; cv=none; b=EqMTdaW8CJE0J92WHQXkHTIMv4eoPXoNvr5RF/JrHRTB92Fhj7V/8GhGI6MZJrKZlbQGKBAEP5Z6E1NFmdE3qeVGX43R5RykxJZGlgU1u4qbh3loL2k/HsN2QI1rVq2pHN8ImwKFzEqSyWYFqDONOrvLa/Kb3rQ8AsDXAn0jeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354898; c=relaxed/simple;
	bh=ueUBqw4Yf79jq6zPR72a415E/zlOxQMLu2ZFkVLJwnE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Pm9H+8K77cDfTbO3J5ODLevOiN46D3CicMBl7RfDsHAHwP4RMPqgAM9DPv7n4E52eL/clUFrCqMPDHM+4UMS0y8iENNkXdldduVkQvlxjLovTVOGz4GOP42YThBGiOWNa5HK1WW5GzrRzHFX2UC2CsCQmbPoI/0Sojr4vldEq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xx+nhyy3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lGXo6iOaeIiwSHl5ozXwsyA28mb00cTSXuiV4cJArrM=; b=Xx+nhyy3RsyqionMFc4LxEqzmJ
	KV6RnyfiNlm2Vtj5nxoh3B8MFZ7qt5ZPN6iM2wLjRvKjeu+Ev2fk2mDPC0/mOT61mqfhe1xJZEJ9Q
	J9KWZ54yzKEOyIo5w2LarprDA9R9zxu1mP3Jd7LzIexEOnuAvIM1O1v7o4YhFl26mnp2keB6xyZFE
	OxIWMfJMMNei8w3fNLJw4LFAIO63oa4NaYjLh92T6t7JlBKuGmtCLsBIQYf4PZMVLBUnp7Do9Nx1f
	b7vnArflTvrdLj1yWmLLNt6j/Tbr8MqRQerzAGrzS5/SyAvRyAcOBVhZYPXq6chUhIt7mRVgUtniX
	RNmfqySA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47636 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZE0-0000v7-0Z;
	Wed, 08 Jan 2025 16:48:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZDh-0002K3-6y; Wed, 08 Jan 2025 16:47:49 +0000
In-Reply-To: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 04/18] net: stmmac: use unsigned int for eee_timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZDh-0002K3-6y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:47:49 +0000

Since eee_timer is used to initialise priv->tx_lpi_timer, this also
should be unsigned to avoid a negative number being interpreted as a
very large positive number. Note that this makes the check for negative
numbers passed in as a module parameter redundant, and passing a
negative number will now produce a large delay rather than the
default. Since the default is used without an argument, passing a
negative number would be quite obscure. However, if users do, then
this will need to be revisited.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index afdf992cd91a..94cd58c636d9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -111,8 +111,8 @@ static const u32 default_msg_level = (NETIF_MSG_DRV | NETIF_MSG_PROBE |
 				      NETIF_MSG_IFDOWN | NETIF_MSG_TIMER);
 
 #define STMMAC_DEFAULT_LPI_TIMER	1000
-static int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
-module_param(eee_timer, int, 0644);
+static unsigned int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
+module_param(eee_timer, uint, 0644);
 MODULE_PARM_DESC(eee_timer, "LPI tx expiration time in msec");
 #define STMMAC_LPI_T(x) (jiffies + usecs_to_jiffies(x))
 
@@ -194,8 +194,6 @@ static void stmmac_verify_args(void)
 		flow_ctrl = FLOW_OFF;
 	if (unlikely((pause < 0) || (pause > 0xffff)))
 		pause = PAUSE_TIME;
-	if (eee_timer < 0)
-		eee_timer = STMMAC_DEFAULT_LPI_TIMER;
 }
 
 static void __stmmac_disable_all_queues(struct stmmac_priv *priv)
-- 
2.30.2


