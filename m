Return-Path: <netdev+bounces-136323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD609A1537
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF80A283738
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257E1D7E4A;
	Wed, 16 Oct 2024 21:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529E1D618A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115556; cv=none; b=Kz+s/aqAzf+8Vngw+HeVshHKN+FZ+7xvyJeRUPcPOqvdD4jxMTvoDUe2pRaILulxL7KS2yWLREEZBIzQgvxURG1LHfqOuyv6qL5cR3fh2M1SbUldBw65X/f/xmWpGSjXT7vQLXMwD3Z67cszWSfgjrNuORDpKbbReoC3DmmRXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115556; c=relaxed/simple;
	bh=PQKfRdtWTAXIoydlgwBAzBYY+iXP63O77c6zthztjaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLGhJvVlGhvBXK2mtfDdc9yDKEu5m7iPjUzTsoX8DQHEGv2wZhoMg8RUEYMOcef843W+ICt+0dRVnJmqPIaFa4kV5XvB7PJv+q57aon/D6sEPw1iI8FS6UvxbSrYDzImNN4JAnnEyWYrl5A16TIeir651BWxubjO3m2XHJ2s6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003SJ-Pq
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwQ-002OVD-Qb
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 712FC354934
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7FCC4354889;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 21637288;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:56 +0200
Subject: [PATCH net-next 08/13] net: fec: fec_probe(): let IRQ name reflect
 its function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-8-de783bd15e6a@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3400; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=PQKfRdtWTAXIoydlgwBAzBYY+iXP63O77c6zthztjaI=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWJdz6WPFmpuJICJRNYxZ0KdNuJR/sWUfgxB
 D0rz1IkzxSJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1iQAKCRAoOKI+ei28
 b45PB/95196jockvrCj++TeD3Deyrjep2aMyesqXSzHsOAPmOGnzeG15CitaHzVyHAMlJBugVgv
 w4E9+/4itXm/PLyDPYoiaqz+g88u/LNU86m4cCuxFPgtGZuMu/AsoNvJOVH2HamuRIbTzGY88UM
 nbbjxzmt+7aSrnHfS5e0djP5uvTznt+bPQqz0R+yytmFmdGBspz9jNWxHbyFjT0f1tokRMq3C/s
 60wgFI5zTzht19p81U8fX4XJ6HXgP/CrdmWhkrzeXEZ1/ZLuKrSlPhC2jaFBDJfr4dUy4Jsy+nQ
 LKbS9dtKMJojYzTMoo8sHI2n3zpkOZ48BeNYz0AdGBiI4eGu
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The FEC IP core in the i.MX7 and newer SoCs has 4 IRQs. The first 3
correspond to the 3 RX/TX queues, the 4th is for processing Pulses Per
Second. In addition, the 1st IRQ handles the remaining IRQ sources of
the IP core. They are all displayed with the same name in
/proc/interrupts:

| 208:          0          0          0          0     GICv3 150 Level     30be0000.ethernet
| 209:          0          0          0          0     GICv3 151 Level     30be0000.ethernet
| 210:       3898          0          0          0     GICv3 152 Level     30be0000.ethernet
| 211:          0          0          0          0     GICv3 153 Level     30be0000.ethernet

For easier debugging make the name of the IRQ reflect its function.
Use the postfix "-RxTx" and the queue number for the first 3 IRQs, add
"+misc" for the 1st IRQ. The postfix "-PPS" specifies the PPS IRQ.

With this change /proc/interrupts looks like this:

| 208:          2          0          0          0     GICv3 150 Level     30be0000.ethernet-RxTx1
| 209:          0          0          0          0     GICv3 151 Level     30be0000.ethernet-RxTx2
| 210:       3526          0          0          0     GICv3 152 Level     30be0000.ethernet-RxTx0+misc
| 211:          0          0          0          0     GICv3 153 Level     30be0000.ethernet-PPS

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 9 ++++++++-
 drivers/net/ethernet/freescale/fec_ptp.c  | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f124ffe3619d82dc089f8494d33d2398e6f631fb..c8b2170735e599cd10492169ab32d0e20b28311b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4492,8 +4492,15 @@ fec_probe(struct platform_device *pdev)
 		goto failed_init;
 
 	for (i = 0; i < irq_cnt; i++) {
+		const char *dev_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-RxTx%d%s",
+						      pdev->name, i, i == 0 ? "+misc" : "");
 		int irq_num;
 
+		if (!dev_name) {
+			ret = -ENOMEM;
+			goto failed_irq;
+		}
+
 		if (fep->quirks & FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ)
 			irq_num = (i + irq_cnt - 1) % irq_cnt;
 		else
@@ -4508,7 +4515,7 @@ fec_probe(struct platform_device *pdev)
 			goto failed_irq;
 		}
 		ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
-				       0, pdev->name, ndev);
+				       0, dev_name, ndev);
 		if (ret)
 			goto failed_irq;
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 8722f623d9e47e385439f1cee8c677e2b95b236d..0ac89fed366a83bcbfc900ea4409f4e98c4e14da 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -749,8 +749,11 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	 * only the PTP_CLOCK_PPS clock events should stop
 	 */
 	if (irq >= 0) {
+		const char *dev_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						      "%s-PPS", pdev->name);
+
 		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
-				       0, pdev->name, ndev);
+				       0, dev_name ? dev_name : pdev->name, ndev);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
 				 ret);

-- 
2.45.2



