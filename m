Return-Path: <netdev+bounces-210566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2DEB13F23
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9275F16AE78
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2215273D7C;
	Mon, 28 Jul 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ryFjVsuY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF562727F6
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717596; cv=none; b=U0TF1LkwOdma824ZY6PJOK5KS/M1EU5eeJWmT1xGnBPms1h+wDIwFLKdFf4fl/qRCG2CCteK7p7aaUh9tRWt7lGenVvSfs0bVYvgGDiQUqyL5ZkHyjbDttCI5uJEGS1+VvxEKoXKz7jMJXnKI3VLy31hRuJzB9mVaRjm3bMdaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717596; c=relaxed/simple;
	bh=6Q0vhCt65Dubqf3oaQJ+Ph5BxvqVghjYykhQk8yjTa4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ppYMVDylMt29tsBMYLGow2edzbCXJUBIyrCqPRfsuOdtdQouzy1SduukBmhYltZWeSua0QxwN2MMnfnKFNPFr7soVaVryXBt7Zld7T3030dGJqmcK/H7ShRQEj9fcX/abzZupzZYS7ivm8OAxIZCUmEMkiEVu6RXhIDljSnlh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ryFjVsuY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qiasyHW8eYHcGSr/FVeeF5VMI/eVubqybz/H7IzQDig=; b=ryFjVsuYIpcaRU2hz/cU1trPw/
	EPHp0HZvGRtqq1aYEOtxMaBjxQO30JQN8+zwKN+uxmJdcMg1iejmnfwbtwwruvOookBFg2RfYBUuY
	CpOQfhGZjSaFVQV2BRsbOpWCIC1SRq2RqVpMm6FtPf8p85Cso+UEOLqJo3+hmSWJWCGN9bmbbEtfP
	JFFD+nlARb5X8QHWjCeXMccaUNOyDLUv7F6upft2xchHmFDnfqjq0zm0Ki55dv/rqns/sUI0eWz9d
	PdwSkCpXMJzO2G48990FIWdRMuyjalrYdtO5VN/WFC6zT9J6GzAWaYJTHwJOEMGqD5vcGpoNYfElm
	hCbsJObA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37866 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ugQ3W-0000UG-0c;
	Mon, 28 Jul 2025 16:46:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ugQ2o-006KD9-EB; Mon, 28 Jul 2025 16:45:42 +0100
In-Reply-To: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 3/7] net: stmmac: remove redundant WoL option
 validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ugQ2o-006KD9-EB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 28 Jul 2025 16:45:42 +0100

The core ethtool API validates the WoL options passed from userspace
against the support which the driver reports from its get_wol() method,
returning EINVAL if an unsupported mode is requested.

Therefore, there is no need for stmmac to implement its own validation.
Remove this unnecessary code.

See ethnl_set_wol() in net/ethtool/wol.c and ethtool_set_wol() in
net/ethtool/ioctl.c.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index dda7ba1f524d..cd2fb92ac84c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -803,7 +803,6 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	u32 support = WAKE_MAGIC | WAKE_UCAST;
 
 	if (!device_can_wakeup(priv->device))
 		return -EOPNOTSUPP;
@@ -816,15 +815,6 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
-	/* By default almost all GMAC devices support the WoL via
-	 * magic frame but we can disable it if the HW capability
-	 * register shows no support for pmt_magic_frame. */
-	if ((priv->hw_cap_support) && (!priv->dma_cap.pmt_magic_frame))
-		wol->wolopts &= ~WAKE_MAGIC;
-
-	if (wol->wolopts & ~support)
-		return -EINVAL;
-
 	if (wol->wolopts) {
 		pr_info("stmmac: wakeup enable\n");
 		device_set_wakeup_enable(priv->device, 1);
-- 
2.30.2


