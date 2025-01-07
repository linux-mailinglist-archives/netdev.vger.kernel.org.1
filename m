Return-Path: <netdev+bounces-155949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F150A04658
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E8C16656C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A91F63C5;
	Tue,  7 Jan 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="00xPUazQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BA125B9
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267344; cv=none; b=guAsH4pYQdksbLRj2N0nOiKYmCstCDmHeQ9+eUq/jTpOHUwGXDosMQXVd8z3fE8c7iPOofMX5EKZ66iZrzKpM3ouG0mH1NmohLeF7cidoh0Fgv3WnWqAWu65qzWr87q8kjwPXwRpACqHo0AMTvPe1pqqf+z2kkEugYOwNt49dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267344; c=relaxed/simple;
	bh=sbAs2CmxwWEzymxoPNoHVxqKt6sQqnxILJzEDQ+mbRQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=W7Y964K4aFSJhdGSyR67c/aZg1ijhzQps53S3vZvwFwLWVAYM9MfCnxKJssac5+p1wtYWVwROz6+wSPxNRmPl71cYkSSBHzt7bTtK4JYOYLWjP0fW6YW2g5KwgGtmHVEVOtPFBT4roCXIPfLS5mjVMsLc2G9wmgsPh/Pyx0yGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=00xPUazQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tyoVehIX0KvqvNNqrOunqnbcASeMfHXCgtKkR1jpJa4=; b=00xPUazQdabqN+75wqaVT+hcbs
	tU+/JJpP0n2WjpG5GSQGEaX9HsUkSIQ4Lz3lsw8Lqx7+zQVOi1+lVGsRpcUEEjaiwN4p8VCsvcKoc
	GPycaUQWUJXCUJIrAUh3/TGhgxKKWJG4unuMQP/sRr8Zf+TCj6Xw41HJePVpnzP/fsD9lBnZ+6Gcq
	oMfhXeeIQX4h3gAu0TV51Fv58cjz7SH2NdnLFtaLROXIi2HI1AQarkCXw+zzB02cVcIuDf9aGs/Sx
	s+LzfliIUWpCOfd4kFL8sa6GjVLhv3gveklU+cjVEqFKDN5Zfciqe0ciWvLaXyIRG85Gz0b8VQg82
	o4strbLw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58282 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCRm-0007lj-2M;
	Tue, 07 Jan 2025 16:28:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCRj-007Y3H-Hm; Tue, 07 Jan 2025 16:28:47 +0000
In-Reply-To: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 04/18] net: stmmac: use unsigned int for eee_timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCRj-007Y3H-Hm@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:28:47 +0000

Since eee_timer is used to initialise priv->tx_lpi_timer, this also
should be unsigned to avoid a negative number being interpreted as a
very large positive number. Note that this makes the check for negative
numbers passed in as a module parameter redundant, and passing a
negative number will now produce a large delay rather than the
default. Since the default is used without an argument, passing a
negative number would be quite obscure. However, if users do, then
this will need to be revisited.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dbe5635398b3..96393e6feda0 100644
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


