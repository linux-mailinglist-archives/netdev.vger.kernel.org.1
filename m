Return-Path: <netdev+bounces-129261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF797E890
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6977F1F217F2
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7A1946D0;
	Mon, 23 Sep 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TKRGVGFT"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C71946B4;
	Mon, 23 Sep 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083487; cv=none; b=p5i1yQUSWOka9ns6u4JjwZWzPZRq+1DyKZ2imkFVIsOblqDc8s6zwXz6tdZtM8dvIZksXP5P2QZuKfLQ02ajZEqxwVDUJmDru9t0/TgmHXTAXFcyZKYplfxGZbq5/WCmBY2kEb1KI8HA+ZfhrG9chtWjmG1GLh4qeaKy9+6k8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083487; c=relaxed/simple;
	bh=P85uniBbpjbAiAEhXQw8DDYhZFYlWYcMIcwcq4CiTRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nu9oeFJaqrblK8Y0FU0+n/6I0o5cvRiO3OWmxKZMHLZlJp6j3gM10cmo8TC1GJ26pj6rvh+uayjjN7eL3jqFJ2IjHkPu/cyyTWQO4pggR/ZNGtu56rrt/jBcL4NBWqXpXooSW1QgKKflEwlvC5uLL/mCvZKUU473EMG3gsMuHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TKRGVGFT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 03579A03FB;
	Mon, 23 Sep 2024 11:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=GkwqSLjc8C5KqC+YUWvBsBhbeWnsg8Xr9Cj8nXEsTT4=; b=
	TKRGVGFTN3TrDC/U+9xw/q420/nykHzM1UTN5f6XFyYXi7BH/qQJo49yxzR9vljE
	6caQV6eYFnCRYv3d4WWd85icMR3qH6Y2kucyZgeFXhQ90fzfsJxIPlgqPW8mqgbI
	vjx0SHYlvnF0dq/g4v9UKvUkf7q4w6p+zhqiKwEHvUpxAs72B4oPQgdgiLoPUaHl
	wRXpmto+seZ4zH1EADs5pTVp2vsuS0kF44MgBQx64tTrx26nOEfCpeK9U7RKqRos
	WsJ9n/tQc358DHxfV1x3DjzGVmHulo9PQuDup7pyHGeplOcSvD7+GZWpkZ6z/Ng5
	9EGvR+W8vTmOXPFmhmGZZPcPK8cPqQHJkgnKthal24z8Qiv4tpDe+WIh5xEAtuXa
	Z8VmZMOcfp3WiAWfiV59tAt+mVc/YBp0Sz535UxjxxCtD5nOoFdz4KhGKoydjHPf
	82EKS4N1yX7lz7fVnPSrqe0DaCWokQmJqKJk90b2x0xfCjcodPmRmB1rMl2dT8XT
	5gFH3HJWBMiCqN25PSW8KUxBYEDYDXgvTjonBnXO5OugpoKnPwj6fm7pfWFbwZQz
	NCpnRsE49Wh3xWIN2yxG8TTp2EjYgHqHkWy70eQS33QtFbXgyBmeHUb27EgwEtQy
	m1VSDplJ9Ek594RQC7kkM15iS5UFVxxFA5jH5PfQImY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: "David S. Miller" <davem@davemloft.net>, Frank Li
	<Frank.Li@freescale.com>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
Subject: [PATCH net 1/2] net: fec: Restart PPS after link state change
Date: Mon, 23 Sep 2024 11:23:46 +0200
Message-ID: <20240923092347.2867309-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1727083475;VERSION=7976;MC=574309015;ID=151752;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948546C7466

On link state change, the controller gets reset,
causing PPS to drop out. Re-enable PPS if it was
enabled before the controller reset.

Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
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
index acbb627d51bf..6c6dbda26f06 100644
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
index 4cffda363a14..54dc3d0503b2 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -764,6 +764,18 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
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



