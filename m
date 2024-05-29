Return-Path: <netdev+bounces-98901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D08D31BE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B16D1F28712
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ECF15CD66;
	Wed, 29 May 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GcUiRXcL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F015DBC6
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972069; cv=none; b=ZWGat86Jj2lY5Zyn+KCN8bYEkyqIXButIMalUCwRWmC9t3f1c+HQ+u4GZMkjUORUmxOJVDMYNNHTgM+ziZ6hNRd09dxOswQ40Z6JaNFW+hl2I6xHP9Rg60GgyhosQJWeivlkWvj2ELMtZzYC6Vi8DYY+mnTsft4TLUaha8D/aK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972069; c=relaxed/simple;
	bh=Y++sjtBtdnYG7+V7+AxuRFjFhusNKr0Zl/4zDrhhFr0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nW5TbHnKjs0tfOocBGoVbRdrcV92TgMiGBKozg98Aynj110Qtie0MnGNHDfdHZrnEIBVnl65XKAuecvYaHYlmwDnHE51lLHHP/B1cowXVVHzvUjeVZ8rTB+IABKK3A3oJtlpNBBByUbYBmg9ZmNdMjSMZUVSQ/tl1N67b89W8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GcUiRXcL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CRzgpilBFSC5lzaqoJO87wTAs2Vs+6Dv0y8UzcSb65I=; b=GcUiRXcLuG1yjIAN6lkbkqxbIm
	bL0kdUTArRd1DrCXVta7yM72ZkLwAk6ldIuWrdB54pGP6HySc3xWxRYaqmnT7CwgP4ul6FNkLZYmi
	MHysEyrhLCK2t8wnp+00SkO84W6IS3M6M9FTLy+CyKb5WrnIAtJpbeAvd+17HpQIjk6PbO0DlWAlX
	4fIQcEx8/7h6wfsXzA8dUkOA7Lk5AGAywOGg9A7xgtS/Xv4LK2Idoc6VfnvSVY+TpZWxA4Yl7058Z
	mDTffNAuCjKxXdaW58Yv1ArK9yoNEBTE9SqQ+QyIPllFlc7Sa6fzPwvnC6VZyASkZYv3ttkQpuOzC
	ULdU7jew==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57994 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCErc-0005mV-2K;
	Wed, 29 May 2024 09:40:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCEre-00EOQ3-SR; Wed, 29 May 2024 09:40:54 +0100
In-Reply-To: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 5/6] net: stmmac: include linux/io.h rather than
 asm/io.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCEre-00EOQ3-SR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 09:40:54 +0100

Include linux/io.h instead of asm/io.h since linux/ includes are
preferred.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index d0c7c2320d8d..d413d76a8936 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -15,7 +15,7 @@
 #include <linux/crc32.h>
 #include <linux/slab.h>
 #include <linux/ethtool.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index daf79cdbd3ec..adccdd816ea9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -12,7 +12,7 @@
   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 *******************************************************************************/
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include "dwmac1000.h"
 #include "dwmac_dma.h"
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index 7667d103cd0e..14e847c0e1a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -15,7 +15,7 @@
 *******************************************************************************/
 
 #include <linux/crc32.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include "stmmac.h"
 #include "dwmac100.h"
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index dea270f60cc3..b402fb54f613 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -14,7 +14,7 @@
   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 *******************************************************************************/
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include "dwmac100.h"
 #include "dwmac_dma.h"
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 542e2633a6f5..18468c0228f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -11,10 +11,10 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/mii.h>
 #include <linux/phylink.h>
 #include <linux/net_tstamp.h>
-#include <asm/io.h>
 
 #include "stmmac.h"
 #include "dwmac_dma.h"
-- 
2.30.2


