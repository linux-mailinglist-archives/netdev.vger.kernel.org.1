Return-Path: <netdev+bounces-196980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EFDAD73A5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6529188B190
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA2253F08;
	Thu, 12 Jun 2025 14:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B58248881
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737795; cv=none; b=XgO0MNNV1hJAHmIRZG3ty8wSbAUXBT4JwSc0R/ycb0Fq/rfM1crAITlBhtIpVe/cqAsjJot5exDyHTECq9eGDF84sCTB8EHc+e2qbbeLZux72WkQB4myJ3xgt5GgsI7HK1tCUQktTNw/rXdCpM4kHvxJUHkQZW9+utxZrvnau6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737795; c=relaxed/simple;
	bh=zKJRpSi2K5E1hgAylyDDCR9zp/mZ0SixP6YUKJVnqJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZwzYg1IL+NVouFsEZhrVkAy1Kjhm6+o5bX4jRHlS0iLqJuYQbt75e4cC8Mcj3l0UPewRn8nieXUcA1haGfJFR+xiRFKEzqIdWAK1tftdT2lr5ZE0ytK6dmkHfzKlnvvpAwdgDvP1AtIKFtZ+1baqQWDhGCbQN55S4NaiAA049M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e75c:5124:23a3:4f62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 6E7CD66BC0D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 38F4F4264C0
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B1CB542642A;
	Thu, 12 Jun 2025 14:16:18 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1051a142;
	Thu, 12 Jun 2025 14:16:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 12 Jun 2025 16:15:59 +0200
Subject: [PATCH net-next v2 06/10] net: fec: fec_enet_rx_queue(): use same
 signature as fec_enet_tx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-fec-cleanups-v2-6-ae7c36df185e@pengutronix.de>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
In-Reply-To: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zKJRpSi2K5E1hgAylyDDCR9zp/mZ0SixP6YUKJVnqJc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoSuEnlRyb0Zeg815xIKiHuoyDT7Z6JY9SgdOZA
 aK2Pm8BHXeJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaErhJwAKCRAMdGXf+ZCR
 nONHB/9BnzhHd2KAM/sZCYIbLa/W9+DNf25YI2icNtavevPsKl12cQm9uc0T7B4ilWwiVjUAhln
 EntT5UX8730glezJAOcm5mPqD+sp9eOQAZBs20ABovdu3FaV1Vv77iocuwS8ZM8TCruWq3FwiWN
 jOYeyT0VYUKGat3lsfGPwL8osmMamqlx0bD27UFC5l6XbJZP/tzE2yiEjml2XtLq0PwwDDMPPxr
 61zJEJ3X/63uvGAaYrdunAxwJFJxJv6nx9CFMjSbKyPzJoYtDwPPcjhtetwpJY/WBf+x/SDsc5w
 SuAvtKs5m+Omj2LNGkbkVcl3DE0zzNwEEv2Rx20VKres5rEv
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

There are the functions fec_enet_rx_queue() and fec_enet_tx_queue(),
one for handling the RX queue the other one handles the TX queue.

However they don't have the same signature. Align fec_enet_rx_queue()
argument order with fec_enet_tx_queue() to make code more readable.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 21891baa2fc5..6b456372de9a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1713,7 +1713,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
  * effectively tossing the packet.
  */
 static int
-fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
+fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct fec_enet_priv_rx_q *rxq;
@@ -1940,7 +1940,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, budget - done, i);
+		done += fec_enet_rx_queue(ndev, i, budget - done);
 
 	return done;
 }

-- 
2.47.2



