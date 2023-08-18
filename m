Return-Path: <netdev+bounces-28783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16429780AE1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366021C20EF7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B347182B3;
	Fri, 18 Aug 2023 11:14:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227BA52
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:14:48 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D535B8
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:14:42 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692357280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5RWtMebPINc9nlpUdigpR3AXP20xj3BkWdGCH5BcDhc=;
	b=PYyJTQZtcWaCylg0JZVHYt/1SsAmfXrwCU9WLhiCEngNvVuugWZ+WoQoaXmA1rol+opcWa
	X/AXYrtkHzvKeectvEwcDIaDNHqQGkmwIpnlWeSsWHyD5FjblgYIwRf/OutoMCNLFNrY/G
	sNGRQGSO2ucZlFx5jAE5xIh0DvtciVn/OQTrlvxdjUsEChFtIIhUyPA67rT3Ii7jpWCi8R
	TlrAJG5S5Hs3CJyyzZMTHi3mZJeN0FOUZSqxp5dOEX/Mcn/rY/G/zyOxoBencn6EZo78Q2
	eslBbSHg5qhsp13QOqg6l6fmVFlfK+Fdu61jQhOWMY+8Q0zBgjfir3fvlBOj4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692357280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5RWtMebPINc9nlpUdigpR3AXP20xj3BkWdGCH5BcDhc=;
	b=kOzWYmUbnD5Psdigr7xXFuQ9b3CmrdXdCYPwICda/4OsOplVnkpsNrVL7oEWe4V3yyzpmD
	huzdn2fjuKp3bDDA==
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Johannes Zink <j.zink@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next] stmmac: intel: Enable correction of MAC propagation delay
Date: Fri, 18 Aug 2023 13:14:01 +0200
Message-Id: <20230818111401.77962-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All captured timestamps should be corrected by PHY, MAC and CDC introduced
latency/errors. The CDC correction is already used. Enable MAC propagation delay
correction as well which is available since commit 26cfb838aa00 ("net: stmmac:
correct MAC propagation delay").

Before:
|ptp4l[390.458]: rms    7 max   21 freq   +177 +/-  14 delay   357 +/-   1

After:
|ptp4l[620.012]: rms    7 max   20 freq   +195 +/-  14 delay   345 +/-   1

Tested on Intel Elkhart Lake.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 979c755964b1..a3a249c63598 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -627,6 +627,7 @@ static int ehl_common_data(struct pci_dev *pdev,
 	plat->rx_queues_to_use = 8;
 	plat->tx_queues_to_use = 8;
 	plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
+	plat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
 
 	plat->safety_feat_cfg->tsoee = 1;
 	plat->safety_feat_cfg->mrxpee = 1;
-- 
2.39.2


