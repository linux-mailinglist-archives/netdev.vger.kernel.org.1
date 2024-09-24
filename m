Return-Path: <netdev+bounces-129499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD597984251
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EED1C22815
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849C15665E;
	Tue, 24 Sep 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="RH1UbJYp"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB051422C7;
	Tue, 24 Sep 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170662; cv=none; b=fNu5+xCfNf9syLepaHKlhURv2KFXTl6BwcMg/87+UJP3+OUgWgxo1VM0FbcjNsVzywV2QfJNK24Y5nYBKF4VyUEz1Kh6HAQj5y/X/o6VaNAvqmtPf4LK0ZBEq+m1lkR4jAkUBOyvoak2jVMXMji5dpecyKujgNh+PoByeay3rV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170662; c=relaxed/simple;
	bh=yTTNa2QMtuCCueY2sh3DWgOl3ij0zht4q8WPO6UaB6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaPIWsEWY7QCizZVooshLOSsfCOCGcpOS5ZglGZ53WtPVjwH+aPsJm55IDSMFF8X/bI3zIgH++RdOiILmyrXyMYpUtLLX7xCuYEM7DNjJglpEz1eYecfJ2620YWXi7dSWBTKUB+Idw/uQXTRA+acGFgXv22JaC34LJMMOmMzmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=RH1UbJYp; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id F12DCA0C05;
	Tue, 24 Sep 2024 11:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=RM2Bx6e9nFaFc6AnqSX0
	YhK80LFLycZfvGoIpk5yHlk=; b=RH1UbJYpqUZFXNWJGntasiGmHvgl6chT6ZNn
	+HrXPcCWo8fxTHq6TGSM34BuyqA/sDbThVnQuCX9modOEmpGUk3c8AyZKatd0Jtr
	C3a9E+MuIn3hocSqIkLrqnR6gJMGG5Wt7iLHwR2YuG6zGuw1+MUmbTHuAQvnRVpn
	o5zIOXoUY1pxM5//fM5f/SMZgM8Kih1yfnmlK860tX/b1KGSOnEvCqqHf74ac0F1
	Rp8uuZIu3SIreFf5y4CITw246Mt0NlN8O7T9t+tjN2XP9jlZj81iuPBR3MvxJZoz
	k658DQdPpC2rS4ubCPWwDYqfuTsdrf/+Gat1R+9ReMEzKhrS62THYK0h6lCPd6so
	+vrftuRLfc42jRxuG0RNUd5UPbDGM8HI6qfIjHn6hvggqTyQbTBh+/rqWRfK8xuN
	6ylHF1tEjtipqe0b+US00J6oiNnSTKmzZ5q1Q3KgQdsyUoMRR078UUZZ538Atntt
	A82HL7fwLbMSRsIc7Gm7Vvlhh1DiarzdcgfDtQG/NqyLfvlEZ6AkPtBNMGGQCzD/
	UBXkkUQwU3l8m03tv4vup0749Bls88/wm+z/pmMx83t+lQCXlCUOO+lwOwdSRe1T
	0uy/NI+yAPVaF6/pv7KWvRk9CsihNjliKmP1HccsSFTxW4Ae6IyGNsi6xgz683iL
	z+VxYwQ=
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
Date: Tue, 24 Sep 2024 11:37:06 +0200
Message-ID: <20240924093705.2897329-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924093705.2897329-1-csokas.bence@prolan.hu>
References: <20240924093705.2897329-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1727170658;VERSION=7976;MC=678376640;ID=205351;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948546C7764

On link-state change, the controller gets reset,
which clears all PTP registers, including PHC time,
calibrated clock correction values etc. For correct
IEEE 1588 operation we need to restore these after
the reset.

Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec.h     |  3 +++
 drivers/net/ethernet/freescale/fec_ptp.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 0552317a2554..1cca0425d493 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -693,6 +693,9 @@ struct fec_enet_private {
 
 	struct {
 		int pps_enable;
+		u64 ns_sys, ns_phc;
+		u32 at_corr;
+		u8 at_inc_corr;
 	} ptp_saved_state;
 
 	u64 ethtool_stats[];
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index df1ef023493b..a4eb6edb850a 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -767,24 +767,44 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 void fec_ptp_save_state(struct fec_enet_private *fep)
 {
 	unsigned long flags;
+	u32 atime_inc_corr;
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
 	fep->ptp_saved_state.pps_enable = fep->pps_enable;
 
+	fep->ptp_saved_state.ns_phc = timecounter_read(&fep->tc);
+	fep->ptp_saved_state.ns_sys = ktime_get_ns();
+
+	fep->ptp_saved_state.at_corr = readl(fep->hwp + FEC_ATIME_CORR);
+	atime_inc_corr = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_CORR_MASK;
+	fep->ptp_saved_state.at_inc_corr = (u8)(atime_inc_corr >> FEC_T_INC_CORR_OFFSET);
+
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 }
 
 /* Restore PTP functionality after a reset */
 void fec_ptp_restore_state(struct fec_enet_private *fep)
 {
+	u32 atime_inc = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
 	unsigned long flags;
+	u32 counter;
+	u64 ns;
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
 	/* Reset turned it off, so adjust our status flag */
 	fep->pps_enable = 0;
 
+	writel(fep->ptp_saved_state.at_corr, fep->hwp + FEC_ATIME_CORR);
+	atime_inc |= ((u32)fep->ptp_saved_state.at_inc_corr) << FEC_T_INC_CORR_OFFSET;
+	writel(atime_inc, fep->hwp + FEC_ATIME_INC);
+
+	ns = ktime_get_ns() - fep->ptp_saved_state.ns_sys + fep->ptp_saved_state.ns_phc;
+	counter = ns & fep->cc.mask;
+	writel(counter, fep->hwp + FEC_ATIME);
+	timecounter_init(&fep->tc, &fep->cc, ns);
+
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	/* Restart PPS if needed */
-- 
2.34.1



