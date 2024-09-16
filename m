Return-Path: <netdev+bounces-128547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DF97A46A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C5F281E2B
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2A15854D;
	Mon, 16 Sep 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mTewCl10"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732717571;
	Mon, 16 Sep 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498063; cv=none; b=gUJ4kbLOl9rmry0pIMMW4NspoWL+BLEpUkQaXZz0KpE5uPYpYzREA9wMYHPB8LP0LqJxTH+uYDVGv0pYS2YgYBxyvTKBLBatFTK4NVd9JD/n9g163itn1+IFmDZjliNIx0LIiVCh8q+QGBNBrBl5E15M94uFIg/PDQ0MPQkfUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498063; c=relaxed/simple;
	bh=DdXPtKASiB/Z1oqLYOog7mKuDd06mrWJKbbPksmbAxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyN6J1EBgf6AXr+u5diK6ert/srweTb1QUEIb9hvDnhUxXfMPDM0FKZYS0FpWnigRqsfkgeEvzySg5J6C1qGVZDRtu8qVX6yCRmI+3lFJR3g3xFqCMWKq/XflkZRSy2yuudUu1uCmi3nxkExGVNWpb1z1xQ7hGHTrlem/wP7cL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mTewCl10; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 036BBA0F58;
	Mon, 16 Sep 2024 16:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=EHqROyUJoru7508xp0hT
	cD02iqc88j/P5NaR7xrfbYI=; b=mTewCl10SV4kGSP++0kvsSOkuLROL1INHS8M
	ZrGDX6Bnnc5RIlLVz67zGAPCIa4V5CmkYpWz/N+m1KqxgqS5XwbR0w5X6CmGcRMp
	VR1KNIRHxP0Q4LuncE4L4Exn+09KZzdT6s3LCcUDdbw2lMcFTqhgPUqHZqEeUTQs
	ZOQMdEBXTh/caeq5P1D4pXFJChN2k1y16qJnN/KJ+siveeCcqjkM7iQINSBUWpWd
	WWXiLbDF+8/HFETjLZ+qrOkv82uOwYfTbdGQafy3VLZFli5Yz8rrvzNmyISQkddC
	Q+Xmh9ZymkQXXwZsTBOX1prpwtlr2N9gliWnE8PqU0iL2B6n/3ALbg99vziJ2CP+
	U+4phsqAoZKTAxwqhn+deabwUG4RZElinL+hzwShMzuEckveoDEnq7SlY2JG5FNE
	9gVbP9mV8MO2UXyYFaoUJQVBeHQjlfcRWDtEdNesZeK6norYSmLd3VZDSbfOW5Af
	WdFfow28FPeEHJ83QeMNq/K8y8P9MQ6YszdWinmM1kD8I9xgNiJ3EklPyNipXnHZ
	DMvZIacXRLESFGBCSYc8tS9D52B/9YGmOx21XfB+brdx4pI8roAfkIPCN/kRLyAl
	82egyibGqZvFoQ4GlEHHxfb38eDodFAHx+sVF54aIRHxePJ4yEvNpwAynnI/dFWD
	TzJA4Z0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH 2/2] net: fec: Reload PTP registers after link-state change
Date: Mon, 16 Sep 2024 16:19:31 +0200
Message-ID: <20240916141931.742734-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916141931.742734-1-csokas.bence@prolan.hu>
References: <20240916141931.742734-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1726497466;VERSION=7976;MC=1468624255;ID=72336;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948546D7162

On link-state change, the controller gets reset,
which clears all PTP registers, including PHC time,
calibrated clock correction values etc. For correct
IEEE 1588 operation we need to restore these after
the reset.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec.h      |  7 +++++
 drivers/net/ethernet/freescale/fec_main.c |  4 +++
 drivers/net/ethernet/freescale/fec_ptp.c  | 35 +++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index afa0bfb974e6..efe770fe337d 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -691,11 +691,18 @@ struct fec_enet_private {
 	/* XDP BPF Program */
 	struct bpf_prog *xdp_prog;
 
+	struct {
+		u64 ns_sys, ns_phc;
+		u32 at_corr;
+		u8 at_inc_corr;
+	} ptp_saved_state;
+
 	u64 ethtool_stats[];
 };
 
 void fec_ptp_init(struct platform_device *pdev, int irq_idx);
 void fec_ptp_restore_state(struct fec_enet_private *fep);
+void fec_ptp_save_state(struct fec_enet_private *fep);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 531b51091e7d..570f8a14d975 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1077,6 +1077,8 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
+	fec_ptp_save_state(fep);
+
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
 	 * instead of reset MAC itself.
@@ -1338,6 +1340,8 @@ fec_stop(struct net_device *ndev)
 			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
 	}
 
+	fec_ptp_save_state(fep);
+
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
 	 * instead of reset MAC itself.
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index c5b89352373a..8011a6f3c4be 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -770,9 +770,44 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	schedule_delayed_work(&fep->time_keep, HZ);
 }
 
+void fec_ptp_save_state(struct fec_enet_private *fep)
+{
+	unsigned long flags;
+	u32 atime_inc_corr;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	fep->ptp_saved_state.ns_phc = timecounter_read(&fep->tc);
+	fep->ptp_saved_state.ns_sys = ktime_get_ns();
+
+	fep->ptp_saved_state.at_corr = readl(fep->hwp + FEC_ATIME_CORR);
+	atime_inc_corr = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_CORR_MASK;
+	fep->ptp_saved_state.at_inc_corr = (u8)(atime_inc_corr >> FEC_T_INC_CORR_OFFSET);
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+}
+
 /* Restore PTP functionality after a reset */
 void fec_ptp_restore_state(struct fec_enet_private *fep)
 {
+	u32 atime_inc = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
+	unsigned long flags;
+	u32 counter;
+	u64 ns;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	writel(fep->ptp_saved_state.at_corr, fep->hwp + FEC_ATIME_CORR);
+	atime_inc |= ((u32)fep->ptp_saved_state.at_inc_corr) << FEC_T_INC_CORR_OFFSET;
+	writel(atime_inc, fep->hwp + FEC_ATIME_INC);
+
+	ns = ktime_get_ns() - fep->ptp_saved_state.ns_sys + fep->ptp_saved_state.ns_phc;
+	counter = ns & fep->cc.mask;
+	writel(counter, fep->hwp + FEC_ATIME);
+	timecounter_init(&fep->tc, &fep->cc, ns);
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+
 	/* Restart PPS if needed */
 	if (fep->pps_enable) {
 		/* Reset turned it off, so adjust our status flag */
-- 
2.34.1



