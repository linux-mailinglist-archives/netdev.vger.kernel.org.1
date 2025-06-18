Return-Path: <netdev+bounces-199040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E20ADEB33
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691D81BC003D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E62E8DFF;
	Wed, 18 Jun 2025 12:00:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF672BD58F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248045; cv=none; b=bQJyc9Fr8btyfCDD1ICts1kjlEba7lCgIIBoxhpNdk5t9EsBDq/e/c27d0ENQ1VLY8SIyV4nyeIAU4ShMlruFXGdIHBOKANyREkrB1lpGDqJgiRVlkPUXdh5xKL7TaGpAUp+Hd7bOzRLfWqE/9wLvUyr+yCVvVLLcjVWz91PluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248045; c=relaxed/simple;
	bh=HLPx1m+m8OBpx0jIA9w5+WqHbeIWeNqmWWt4rHfMWgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2nQts7Do3bLtFEcdD4wx2YPHbQ5eVYUCbJflWdKA42ADtz9BR40/LjmpofeYMd37FV8XmdnenbVuFzlp+yfOy2u8fyrgpg7y8fuz2zLYEEEhST1hx9ILgvf8S5279xgPQ7tiZ4Zu21SbKctmPF5miS8PQpQC+aLtIk6eHWujH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 340A766FD0E
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:00:38 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 02FF942B5E1
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7442542B514;
	Wed, 18 Jun 2025 12:00:29 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a4e44d1b;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:06 +0200
Subject: [PATCH net-next v4 06/11] net: fec: fec_restart(): introduce a
 define for FEC_ECR_SPEED
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-6-c16f9a1af124@pengutronix.de>
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
In-Reply-To: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HLPx1m+m8OBpx0jIA9w5+WqHbeIWeNqmWWt4rHfMWgo=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpNDiZE0Sr1rTttZvnuVsD1qKnX9uYiRl1Mf
 +XLQBf/xEeJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqTQAKCRAMdGXf+ZCR
 nEK3B/9DeIeJwg6n4mToTOv9cyYpKhOAwh9a71Lg+P3v85jYE6HD6yXL10poW2xOwaQRGY5Lxtz
 NGjUpJTT8Is/rB4rEihyVLNCzQly9bo/XIs6kiq/Up+yZ+2YS5gEGFsrT8zzLncoulu66IH+/b2
 i8W0GzbMkz2lqg2imanhYDEUkp3KDcZo7L6Zr9zJuvK3/y5ORMyiup4mA/m606XzhOQi52ffnIZ
 BY94E+k0isWE2y8jQTpUW/E8QY9Xr/okIZ/kYrhSqIz1YhxB6IH5SRirZGQUDMalnzcuvQ1nYyi
 NmJoD4EQ4S0qBfB76pkrDzqw1+TMgE4R/Ljzr6ngTQQ4G85f
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Replace "1 << 5" for configuring 1000 MBit/s with a defined constant to
improve code readability and maintainability.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 083b7e07a9d1..e4fc1baf114d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -275,6 +275,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_ECR_MAGICEN         BIT(2)
 #define FEC_ECR_SLEEP           BIT(3)
 #define FEC_ECR_EN1588          BIT(4)
+#define FEC_ECR_SPEED           BIT(5)
 #define FEC_ECR_BYTESWP         BIT(8)
 /* FEC RCR bits definition */
 #define FEC_RCR_LOOP            BIT(0)
@@ -1206,7 +1207,7 @@ fec_restart(struct net_device *ndev)
 		/* 1G, 100M or 10M */
 		if (ndev->phydev) {
 			if (ndev->phydev->speed == SPEED_1000)
-				ecntl |= (1 << 5);
+				ecntl |= FEC_ECR_SPEED;
 			else if (ndev->phydev->speed == SPEED_100)
 				rcntl &= ~FEC_RCR_10BASET;
 			else

-- 
2.47.2



