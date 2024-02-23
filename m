Return-Path: <netdev+bounces-74638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F2C8620E3
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4801C23B2F
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DF66B25;
	Sat, 24 Feb 2024 00:00:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rmail.be (mail.rmail.be [85.234.218.189])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546218057
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.234.218.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732852; cv=none; b=E2OidELPv1phZr3ABuhdQ69dcTYNNAzxvIHB0U8g0wF9HBB/fd9DsdXGaPXLzHTA6gk20on+/Zm4b3LuhV1YV1eFO1KXBKRlzPn9SwV52g8VGsmj5UgxApI2OJrPpv/rUz42SM357MrVzoV4LVAFm43cGJ9S/SiFhCYV+5qz2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732852; c=relaxed/simple;
	bh=sCMg+XFVoO30zy6nhSsC1exKfGXpSA0P16dw/HmwtAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njwStY8YhE5lfwgYM3KhQ823o7TJUrEcpgOleOi16C6z779CFLnF3JLJhk+as/NfuXQfqagV9Q19xDwawykneplLf+JZhEtA3LHdARxSKjuFb61DLcdVBV2OEa4BvDRPnkUfLIKrhKjDkhbt5Lnj2jfjtPLD03vqWJStqk1SpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be; spf=pass smtp.mailfrom=rmail.be; arc=none smtp.client-ip=85.234.218.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rmail.be
Received: from localhost.rmail.be (unknown [10.238.9.208])
	by mail.rmail.be (Postfix) with ESMTP id 98B944ABB7;
	Sat, 24 Feb 2024 01:00:47 +0100 (CET)
From: Maarten Vanraes <maarten@rmail.be>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Maarten Vanraes <maarten@rmail.be>
Subject: [PATCH] net: bcmgenet: Reset RBUF on first open
Date: Sat, 24 Feb 2024 00:53:02 +0100
Message-ID: <20240224000025.2078580-1-maarten@rmail.be>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Elwell <phil@raspberrypi.com>

If the RBUF logic is not reset when the kernel starts then there
may be some data left over from any network boot loader. If the
64-byte packet headers are enabled then this can be fatal.

Extend bcmgenet_dma_disable to do perform the reset, but not when
called from bcmgenet_resume in order to preserve a wake packet.

N.B. This different handling of resume is just based on a hunch -
why else wouldn't one reset the RBUF as well as the TBUF? If this
isn't the case then it's easy to change the patch to make the RBUF
reset unconditional.

See: https://github.com/raspberrypi/linux/issues/3850

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Maarten Vanraes <maarten@rmail.be>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

This patch fixes a problem on RPI 4B where in ~2/3 cases (if you're using
nfsroot), you fail to boot; or at least the boot takes longer than
30 minutes.

Doing a simple ping revealed that when the ping starts working again
(during the boot process), you have ping timings of ~1000ms, 2000ms or
even 3000ms; while in normal cases it would be around 0.2ms.

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 2d7ae71287b1..58995772cc00 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3282,7 +3282,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 }
 
 /* Returns a reusable dma control register value */
-static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
+static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
 {
 	unsigned int i;
 	u32 reg;
@@ -3307,6 +3307,14 @@ static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
 	udelay(10);
 	bcmgenet_umac_writel(priv, 0, UMAC_TX_FLUSH);
 
+	if (flush_rx) {
+	    reg = bcmgenet_rbuf_ctrl_get(priv);
+	    bcmgenet_rbuf_ctrl_set(priv, reg | BIT(0));
+	    udelay(10);
+	    bcmgenet_rbuf_ctrl_set(priv, reg);
+	    udelay(10);
+	}
+
 	return dma_ctrl;
 }
 
@@ -3370,8 +3378,8 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
-	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	/* Disable RX/TX DMA and flush TX and RX queues */
+	dma_ctrl = bcmgenet_dma_disable(priv, true);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
@@ -4237,7 +4245,7 @@ static int bcmgenet_resume(struct device *d)
 			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 
 	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	dma_ctrl = bcmgenet_dma_disable(priv, false);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
-- 
2.41.0


