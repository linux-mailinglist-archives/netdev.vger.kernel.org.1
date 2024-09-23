Return-Path: <netdev+bounces-129262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D3597E892
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408F1281CB0
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB1194C67;
	Mon, 23 Sep 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hifkAG4O"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6069F194A6B;
	Mon, 23 Sep 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083490; cv=none; b=HUGuuwdFpm2xAEC2EdnZpP4VmkspwzZogvWC4sxVqKJNxEL5k9N0LVWBT8sfFVjHHMipH8tMPLxD+G6Uq0ne7WbBOuGakal11aT5S7kUmpdnec4K5v722z2aqKcrBE9BTHOxTgmT+ENSbGvSS8sYXsBrob3ECgF2TSIOK2xdoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083490; c=relaxed/simple;
	bh=6Rte3PyrhZs+j32pYSYLb0k55LfwAfzjlW+LYGza6NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G77D9Sx3qt9HViSWzIkmcY4W0ZHYW+ZHA9T+8STiGePzs0AavCUmc9V6YayzwWseSCz/GSa924s8zYNAP3lZ08ku/2HPglPUoq061Xz/rDJb2yNY+HCor4oMJry6dbGpCaEVi86mjz/rg9qPkOnKZkm4zSrxKdokZII2BFm4Xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hifkAG4O; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B8722A06C6;
	Mon, 23 Sep 2024 11:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ogsXffhzydOhG3mdvX0B
	yhOZWftk1um1Vz/tH8zngCk=; b=hifkAG4OxFZdOYod01dZhg6talcoohz+oPSV
	+jKKuezsqSj4OTDxiU8F1pqpIz+StQGtrlOSTRFjZ4RGkK6AzU9QB5pT7rFdpbVB
	hk6oEwuR4d5B39I72BIFCBkUrby4diOGwrXtgY8vOzB5vVFzcQnFndwR358MJfm2
	LPyA/Z2kHIMbCBXFj2e9pPbunePXC4qj8a+u33FdmQKe9TWqV53bUTjIW4OYG1Jp
	AlwlHzQVAzQlMF3dwMKocyRqaRp3ItZMKHn0P/3/z8ljSVDbQRmhrK3MBaRoBoDb
	Z1NpgD9mnp9bxz9IXIf7oulqpci5Uvp/eX54lgcqQv4Ss47OC3vCs0qXb7fPixRI
	DOjiWa27+1ivwp73ZYcEtWP4VQjlemYGVY1GFS6p92PiBRnq8ZBz+1nptuGqO9MK
	l7CVYEyyuFxRPSemXxRxY/PTIGFEG+9dpEUXofEIJFr7PbpftpsU00lbbjtiHi7r
	r9di94WuUeb3cvR9RTYExBsf2BSys759zJxVRCkR80MTmd+u8/LMl6jbjukWEvm4
	r9Q2sDcIgHpEMsMdMT56XCIqT0P40IdJiO1KDJGm9gvPe8pFqxra/4UhPkjCrEgp
	+S7W6V/1Hp3y2ttG1EWq91I5lL/NqgWIWi+nUwDb60JfBn03nbrkYFsVSQkt3K19
	4bZZm84=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
Subject: [PATCH net 2/2] net: fec: Reload PTP registers after link-state change
Date: Mon, 23 Sep 2024 11:23:48 +0200
Message-ID: <20240923092347.2867309-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923092347.2867309-1-csokas.bence@prolan.hu>
References: <20240923092347.2867309-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1727083485;VERSION=7976;MC=1880781835;ID=151753;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948546C7466

On link-state change, the controller gets reset,
which clears all PTP registers, including PHC time,
calibrated clock correction values etc. For correct
IEEE 1588 operation we need to restore these after
the reset.

Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
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
index 6c6dbda26f06..31ebf6a4f973 100644
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
index 54dc3d0503b2..5d9c1040b4b3 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -764,9 +764,44 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
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



