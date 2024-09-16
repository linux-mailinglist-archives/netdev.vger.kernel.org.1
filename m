Return-Path: <netdev+bounces-128546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E27997A469
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354C92816A0
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F47158540;
	Mon, 16 Sep 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="o76mrSwP"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743D158523;
	Mon, 16 Sep 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498063; cv=none; b=EN8WiJX5KrMoKuqoHyPQJ2Pozas8tW239hdAFbsFY1Y3KcIkIrieLHa4hm2aQCQGmyd9tGYN5IS57VwcRsl88XeNBwUNk7rNy47Ow1QkTTI09NHOxVJK8sQ/i9iuOrLrdYfRX/oNqAH2dAN6FoR3MxRyZw/AlOppu3CLt+30oEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498063; c=relaxed/simple;
	bh=6I9a7nP2zYprgQf2O4EoUzf4gNKSlVPnrSybFPBcGVQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ij6vu/K8r0NMAcfcD4yvaTohQwL3eLuHkXwlv/fbochxKGKi7XK4Xz24rYfDCvULJYQ16OALmwekanfPCRV9PUO1DCyzEgNbMIOWQendbzRd94vt8AQlyHrSMd70QqQ5OgLvb/QILK8NFOhoBnqF2Jsn4FFCiC2VexRqVGmMzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=o76mrSwP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DADA5A0E23;
	Mon, 16 Sep 2024 16:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=OHtLpc0jptucADL1fWAYQWFof1vNDR+20l0BSvKWjJA=; b=
	o76mrSwP3C9m5KB75ud8ogoYM012vNi+OzlI5+lFXVqqW4ZvrFL/itmOGA4YJaJK
	9vXUvv47uhm2o8N0ZAhntD0u8+Lg7IUOdbuhj5pCisSXT5w2/Ybigmvf2P1R3SJA
	euZlLdyuuuPuiCr9uQwp0qaz/WS6lGJKV34sxMzPXCWTRPQeYyuN6bLfkNA+A9vJ
	EUE/4gF1mISq6fNIWc2caYD9VZXWOOhiZ1GUV8ScOBWbRxH9BaFsXjeR6a3osjqn
	DRjNydha7R0TH6w1m73E+jCdEOGbNnSu1+GGPvB2iKe8JEPU4BxzWPS3QAkmn8Rw
	6duacmsE0ytOsYNriTWZwKVasrN6hn5jDrP5SvMO/SKWO/d7hjEQK326A9M9Hi7P
	yktffo9MxNcKQeBZuJ0d1xMdGrv34L/i7t6hP79fN8CD7396BWyIQYwDfR63PLxB
	yv3NbqsAJ68n8FbskrOsO/1gjSosbyv9GrSs7uu5eCr1OczDsKk61zp/AJhTcCDP
	474hdCpM6tHskc1Q3uMBN1pyitNs4uhGj+//TFqKWjJ1GFABQ6xe76zN30H0MBdS
	5yonWbvT2a7Te3Rya7oK7Lt9gz7ogarlfZ49qjF1faeUL+4hTy4EufNVJ26JDQLU
	0wtUf5LRrcwlxJ22zUCQl7igoxUCn9o5aKGjetU0Nu0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH 1/2] net: fec: Restart PPS after link state change
Date: Mon, 16 Sep 2024 16:19:30 +0200
Message-ID: <20240916141931.742734-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1726497464;VERSION=7976;MC=1215988020;ID=72335;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948546D7162

On link state change, the controller gets reset,
causing PPS to drop out. Re-enable PPS if it was
enabled before the controller reset.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c |  7 ++++++-
 drivers/net/ethernet/freescale/fec_ptp.c  | 12 ++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a19cb2a786fd..afa0bfb974e6 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -695,6 +695,7 @@ struct fec_enet_private {
 };
 
 void fec_ptp_init(struct platform_device *pdev, int irq_idx);
+void fec_ptp_restore_state(struct fec_enet_private *fep);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a923cb95cdc6..531b51091e7d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1244,8 +1244,10 @@ fec_restart(struct net_device *ndev)
 	writel(ecntl, fep->hwp + FEC_ECNTRL);
 	fec_enet_active_rxring(ndev);
 
-	if (fep->bufdesc_ex)
+	if (fep->bufdesc_ex) {
 		fec_ptp_start_cyclecounter(ndev);
+		fec_ptp_restore_state(fep);
+	}
 
 	/* Enable interrupts we wish to service */
 	if (fep->link)
@@ -1366,6 +1368,9 @@ fec_stop(struct net_device *ndev)
 		val = readl(fep->hwp + FEC_ECNTRL);
 		val |= FEC_ECR_EN1588;
 		writel(val, fep->hwp + FEC_ECNTRL);
+
+		fec_ptp_start_cyclecounter(ndev);
+		fec_ptp_restore_state(fep);
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index e32f6724f568..c5b89352373a 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -770,6 +770,18 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	schedule_delayed_work(&fep->time_keep, HZ);
 }
 
+/* Restore PTP functionality after a reset */
+void fec_ptp_restore_state(struct fec_enet_private *fep)
+{
+	/* Restart PPS if needed */
+	if (fep->pps_enable) {
+		/* Reset turned it off, so adjust our status flag */
+		fep->pps_enable = 0;
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



