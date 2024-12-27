Return-Path: <netdev+bounces-154357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98C9FD42C
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874211884463
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FECD155330;
	Fri, 27 Dec 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="T5zqRcNt"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856CC2F2;
	Fri, 27 Dec 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735302638; cv=none; b=t5O4xLMHUy8z+nPzOjENUxjZVilNJBembiQrAcCR5gR2jh22x+I6DB2Nnnldiwib9NinKeN5+8vG+PzrmgcRWuUSuZd5JpL6gwixbb/1Ed49e4qcazd2O8H7CJy7Kb85g91MWBZc+j2geW/LpVcJjODAJMncDHT22LjeEaBbFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735302638; c=relaxed/simple;
	bh=XOPOMlgycx706hOrUeA/Z7DfAwMRzaUeVy2qY0Vrtbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pM91TDLzVoFPRMlADBwy8VgLrKcBltbH2wmILI8Aa5f8XXqgFwsr0ESO4npFNYZDXzF/dWWceWOvwE+3HsPkDSYrVRBOWOTP4sv4MfEQK9TOPVLwvOlVYd3zyHwVby4npUqeob+tiRfq44ldZWejuS+h/aH5kHsCmAwv8Ks43+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=T5zqRcNt; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id B8E16518E79B;
	Fri, 27 Dec 2024 12:30:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B8E16518E79B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1735302626;
	bh=V9uAzyOW0rhNK0flbiE7LEduf+iZecCXoEjMxs+oTZY=;
	h=From:To:Cc:Subject:Date:From;
	b=T5zqRcNtwlxCxaLXe1KsNRlaIp5zVIPnZQGlb7dmzUscVx4YDphmUaiWpQebZApss
	 vev3RBvkuxmQFX7vot1bwPuaZAIzr8Hew5WibESICpe7i6mzRMZHT57VHRE45Kfuie
	 3baUVdb74UYPYK8m858f+Nd8nHd5I6yxRXNZK+hQ=
From: Vitalii Mordan <mordan@ispras.ru>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: [PATCH net]: bcmsysport: fix call balance of priv->clk handling routines
Date: Fri, 27 Dec 2024 15:30:07 +0300
Message-Id: <20241227123007.2333397-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of clk_prepare_enable to ensure that priv->clk has
been successfully enabled.

If priv->clk was not enabled during bcm_sysport_probe, bcm_sysport_resume,
or bcm_sysport_open, it must not be disabled in any subsequent execution
paths.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 31bc72d97656 ("net: systemport: fetch and use clock resources")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 42672c63f108..bc4e1f3b3752 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1933,7 +1933,11 @@ static int bcm_sysport_open(struct net_device *dev)
 	unsigned int i;
 	int ret;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		netdev_err(dev, "could not enable priv clock\n");
+		return ret;
+	}
 
 	/* Reset UniMAC */
 	umac_reset(priv);
@@ -2591,7 +2595,11 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 		goto err_deregister_notifier;
 	}
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not enable priv clock\n");
+		goto err_deregister_netdev;
+	}
 
 	priv->rev = topctrl_readl(priv, REV_CNTL) & REV_MASK;
 	dev_info(&pdev->dev,
@@ -2605,6 +2613,8 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_deregister_netdev:
+	unregister_netdev(dev);
 err_deregister_notifier:
 	unregister_netdevice_notifier(&priv->netdev_notifier);
 err_deregister_fixed_link:
@@ -2774,7 +2784,12 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
 	if (!netif_running(dev))
 		return 0;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		netdev_err(dev, "could not enable priv clock\n");
+		return ret;
+	}
+
 	if (priv->wolopts)
 		clk_disable_unprepare(priv->wol_clk);
 
-- 
2.25.1


