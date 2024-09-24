Return-Path: <netdev+bounces-129500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10070984253
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDB91F213B9
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472015B102;
	Tue, 24 Sep 2024 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DiK4pdk+"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D21552F5;
	Tue, 24 Sep 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170664; cv=none; b=p/kDPBq2Whqz90nLmUXHQH66/sfNUUbpOmxvKIhKQ5aNDKfVtSkwIX1WmrC6uDFGxrwkT0CUuuU3+8nJvlcf7zPZus/ESrTxw9O/ipVpjT5/GAFthpCJIQzOjmvABMPpiHx7+6coW/mwkoKmSxZhufhsRtZcOxTgbv+FT/vL1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170664; c=relaxed/simple;
	bh=RK5zRI6Tvzjb2KbqBd0rOSqIVx56/Y1TYuy+mD614d4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZquzhTg6cWe5A1IalGcLADysTS8TYMfD8DwzfKtelaF5uq7+hDtG4oP+TzfZI7LMdUsoEhYJGbQyX4fgSjOh214ZyScJc1jKw3qpCr12tewPmgkD8OYFwBFbIw7Bz2PXksAZj2N3yUQFcyvRVXMN1MHTnWC+MqtlRON2V+HiePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DiK4pdk+; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5CB19A0B11;
	Tue, 24 Sep 2024 11:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=vkHGElBASM42oNMJ60X5DKQUSY9n6Gq/8H4y4oxZgaM=; b=
	DiK4pdk+Z5RpdD+Dk5hDx5BwmXGnuJ3sDjB7ZYPBAr/3v9nwXpUW2Gh0vBZfgLKC
	g5dox+fBZPfz9/8471VOEGwJZxuDkzbjjfwIxdarexbYmWQgdA9k+Zgh5wsYZ/0V
	mer7cKqybA3F6JSsH2W08GZvAON0kJ+KJZJb6ybq9Ancb1OW5Dl74UM+gQwaqExM
	cZWd4TJIE+lpGT+sM5yuSiAlRnZF4d+4TPoNRQO3eFiB2uJ+wahdY/RlVBb3lov2
	mQFjxwWABXvhlnWHHTEg5c1lzK7UF+JVZkJ0yr0qNmMBs5nKAMktZssoXNqVAyLY
	SiUuHxEcdTILKAPeJjRLrM23+50lghfAIdkgokv3ghbpl66qsqpQd4+NsxyTQohv
	4U0yutM0y8gu/pf9sfjHPrLLELg1PcPFw/F6n7+RaN2vlNzi399YhcSizODhNsy2
	hcS5L0qpY6hcLfRtsTdaZwZRWZW2psXPMuQ+cICg0oWqKpGlTHzwTw2QGNckIFR+
	xjfEfW7AgTePMBHsgvBAlqIujd/TfSNWSfxi9jOI2EPcBqSHjwQkfd+NtTGT+B0L
	lIUeq26PNbhK0rwVcbm4XP1F1hhVfBE4/56yd2AcqMJFrLEwTeBJRtfblCybynDg
	wF0/DyNo7HGgVfHoWG7sR7ix6c+hABhLCyqPwjBm8Sk=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
Subject: [PATCH net 1/2] net: fec: Restart PPS after link state change
Date: Tue, 24 Sep 2024 11:37:04 +0200
Message-ID: <20240924093705.2897329-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1727170651;VERSION=7976;MC=414325616;ID=164865;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948546C7764

On link state change, the controller gets reset,
causing PPS to drop out. Re-enable PPS if it was
enabled before the controller reset.

Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    - store pps_enable's pre-reset value and clear it on restore
    - acquire tmreg_lock when reading/writing fep->pps_enable

 drivers/net/ethernet/freescale/fec.h      |  6 +++++
 drivers/net/ethernet/freescale/fec_main.c | 11 ++++++++-
 drivers/net/ethernet/freescale/fec_ptp.c  | 30 +++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a19cb2a786fd..0552317a2554 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -691,10 +691,16 @@ struct fec_enet_private {
 	/* XDP BPF Program */
 	struct bpf_prog *xdp_prog;
 
+	struct {
+		int pps_enable;
+	} ptp_saved_state;
+
 	u64 ethtool_stats[];
 };
 
 void fec_ptp_init(struct platform_device *pdev, int irq_idx);
+void fec_ptp_restore_state(struct fec_enet_private *fep);
+void fec_ptp_save_state(struct fec_enet_private *fep);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index acbb627d51bf..31ebf6a4f973 100644
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
@@ -1244,8 +1246,10 @@ fec_restart(struct net_device *ndev)
 	writel(ecntl, fep->hwp + FEC_ECNTRL);
 	fec_enet_active_rxring(ndev);
 
-	if (fep->bufdesc_ex)
+	if (fep->bufdesc_ex) {
 		fec_ptp_start_cyclecounter(ndev);
+		fec_ptp_restore_state(fep);
+	}
 
 	/* Enable interrupts we wish to service */
 	if (fep->link)
@@ -1336,6 +1340,8 @@ fec_stop(struct net_device *ndev)
 			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
 	}
 
+	fec_ptp_save_state(fep);
+
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
 	 * instead of reset MAC itself.
@@ -1366,6 +1372,9 @@ fec_stop(struct net_device *ndev)
 		val = readl(fep->hwp + FEC_ECNTRL);
 		val |= FEC_ECR_EN1588;
 		writel(val, fep->hwp + FEC_ECNTRL);
+
+		fec_ptp_start_cyclecounter(ndev);
+		fec_ptp_restore_state(fep);
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 4cffda363a14..df1ef023493b 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -764,6 +764,36 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	schedule_delayed_work(&fep->time_keep, HZ);
 }
 
+void fec_ptp_save_state(struct fec_enet_private *fep)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	fep->ptp_saved_state.pps_enable = fep->pps_enable;
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+}
+
+/* Restore PTP functionality after a reset */
+void fec_ptp_restore_state(struct fec_enet_private *fep)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	/* Reset turned it off, so adjust our status flag */
+	fep->pps_enable = 0;
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+
+	/* Restart PPS if needed */
+	if (fep->ptp_saved_state.pps_enable) {
+		/* Re-enable PPS */
+		fec_ptp_enable_pps(fep, 1);
+	}
+}
+
 void fec_ptp_stop(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
-- 
2.34.1



