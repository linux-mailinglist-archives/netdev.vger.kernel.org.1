Return-Path: <netdev+bounces-249744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6861DD1D0D4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6737A300E464
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA837C10D;
	Wed, 14 Jan 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="RS5oaMfH"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0B37C0FB;
	Wed, 14 Jan 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378704; cv=none; b=Y8Qsk39w2q+AnPaLTdpH7awOV2Zup1NuPZhrF7Lc1pUmw321ptZ2qixMdOJ1hxTEFNZrEvsuB4ILmkdGtv4vBV0jAa7Bh0HoTI9ymxw6kgbN3L2K68y1mLFRCK0hybneJVYPOzl2Aqazm5E393VJdP9Q07c1iyGIMVysKeiuYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378704; c=relaxed/simple;
	bh=0mEAToH2+/NIe8z8dtVBaB654C7G+O5ZHE7HywovVIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvpgKOXpKHjm6Tq+Oxkhp0X6immc6XUu2GiHHtHG8Vm3BYxY1tKHGBMLr/yLo7sKthFfHGQ/rt4Wz+w3UyyCjEXFiq3jvfSI4mZzVjeArlt+wmll66Puole+om7AVaft5ZYfu4YUg0ZNT2UmjDkIp+qaZzHPUh5V99p0bFctw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=RS5oaMfH; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5221810DFEC;
	Wed, 14 Jan 2026 09:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768378696; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Ajwkw9+NGX/WfC1IKpsfCbjnOybGHKbfekZPQpU9How=;
	b=RS5oaMfHKR7qffACVNzlScaYa5fCYSMQRLi8g9avCRUkSiD8P4vVzwIeg/1n3RVaoBkSRw
	yM53bftxByHwsxuGfEoT9WjDMYgUZqKUFjevFUGx/MpPkkVJ805UcJ8no/IHA7mmjYaRco
	//tEIasJFXW0QmVZrFmbmGL+zRQRiMODy4ZkcBIpoOjcVMfnaWI1CgiXpmHmwXEl2bHmXP
	XW3B09lTcnYg3CT62Tw71+Hz8b2R9x5uQVh/HJwpY6fzlJHNB/e+ZxK81xptzWUl3tAe5H
	gvpTwovD9QcMLxlD0y2fyjrfIXv7LmOGd0H3PZyYSS8wVaDey1smjxhdvW41kA==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kernel@dh-electronics.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [net-next,PATCH] net: stmmac: stm32: Do not suspend downed interface
Date: Wed, 14 Jan 2026 09:17:54 +0100
Message-ID: <20260114081809.12758-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

If an interface is down, the ETHnSTP clock are not running. Suspending
such an interface will attempt to stop already stopped ETHnSTP clock,
and produce a warning in the kernel log about this.

STM32MP25xx that is booted from NFS root via its first ethernet MAC
(also the consumer of ck_ker_eth1stp) and with its second ethernet
MAC downed produces the following warnings during suspend resume
cycle. This can be provoked even using pm_test:

"
$ echo devices > /sys/power/pm_test
$ echo mem > /sys/power/state
...
ck_ker_eth2stp already disabled
...
ck_ker_eth2stp already unprepared
...
"

Fix this by not manipulating with the clock during suspend resume
of interfaces which are downed.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index e1b260ed4790b..5b0d111afcac3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -618,11 +618,21 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 
 static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
 {
+	struct net_device *ndev = dev_get_drvdata(dwmac->dev);
+
+	if (!ndev || !netif_running(ndev))
+		return 0;
+
 	return clk_prepare_enable(dwmac->clk_ethstp);
 }
 
 static void stm32mp1_resume(struct stm32_dwmac *dwmac)
 {
+	struct net_device *ndev = dev_get_drvdata(dwmac->dev);
+
+	if (!ndev || !netif_running(ndev))
+		return;
+
 	clk_disable_unprepare(dwmac->clk_ethstp);
 }
 
-- 
2.51.0


