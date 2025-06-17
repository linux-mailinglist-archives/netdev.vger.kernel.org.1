Return-Path: <netdev+bounces-198601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84BADCD20
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE33162734
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278A2E92A8;
	Tue, 17 Jun 2025 13:25:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B272E4269
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166741; cv=none; b=hSbwwLV9qN/sbUJW26Ldig1XqUK1J2dw4Yt9StN9L19BllR5jE5mxj1IXj7JUFcr84SFIwT21I3SEg6wUts8SOisQe8c6n63uxE5eGHWA9BjO+yWfg3/AmFD1HeLNn5abYgbQ28P8zIgny83qrwclN2uUTAFOQbW+rtHDXuHrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166741; c=relaxed/simple;
	bh=LyJrLbbVnlKXsSbL7xyqgKeGY8RTbecxMuFSWf+ZNo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XT9Ruf+nbmYQHM06SXKTxSfubxzJOuvO4p3UOBTWHh75HfBBpzrfod+FExqhWTgRansfRFVZBaO0cnX6ojRlDBhNXSMhxQ9EKq1qo7tzp+llpgOCcMqepTSrrLPOOGty0dMYL6PtixW3pG5miyA+strjvjWAl7BdrZUilvlQawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e2bf:c3f2:96ab:885d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 49A9366ED6F
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:29 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 17CF342A857
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 412B942A7B4;
	Tue, 17 Jun 2025 13:25:22 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8cdc6968;
	Tue, 17 Jun 2025 13:25:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 17 Jun 2025 15:24:58 +0200
Subject: [PATCH net-next v3 08/10] net: fec: fec_enet_rx_queue(): reduce
 scope of data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-fec-cleanups-v3-8-a57bfb38993f@pengutronix.de>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
In-Reply-To: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=LyJrLbbVnlKXsSbL7xyqgKeGY8RTbecxMuFSWf+ZNo4=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUWy6MlbPd68yDK91m2mt0VGDy2zEs0zIwzzd+
 dSE636IOjGJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFFsugAKCRAMdGXf+ZCR
 nNq+B/9+/DWTvo5vsLnqp4DIBunmLsCexvien5LkGa6hYQGOBuRZKJwcTUZ/ttIUrrdSZe9G+wO
 JRi5MJ2BMCEwAGEvjpIoYtf5Fd3qwH47oIRo6L7d7qXGoS7AL7BOSBzItcqSbRs7SHKrPqekJZl
 D4hB30+rxNDX4xY8BCKtdDVlwgdNDK0Gt4vx/Kxaw5mqcOpyLu6CkxF+O57mDJ/OCShjrww+pyI
 RrswSZ4oOIvoDmMCzQsark8AhkWlsejTnAt3KKV99awekHtZK6li5ZPVQXfsJK2wh+yCFghp91K
 iwxYCk0MdnsMmmiJCiu6w8RbIDsiErvCflSvHJJBIMU+QiYR
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In order to clean up of the VLAN handling, reduce the scope of data.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f238cb60aa65..bc547be59dae 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1721,7 +1721,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	unsigned short status;
 	struct  sk_buff *skb;
 	ushort	pkt_len;
-	__u8 *data;
 	int	pkt_received = 0;
 	struct	bufdesc_ex *ebdp = NULL;
 	bool	vlan_packet_rcvd = false;
@@ -1844,10 +1843,11 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		skb_mark_for_recycle(skb);
 
 		if (unlikely(need_swap)) {
+			u8 *data;
+
 			data = page_address(page) + FEC_ENET_XDP_HEADROOM;
 			swap_buffer(data, pkt_len);
 		}
-		data = skb->data;
 
 		/* Extract the enhanced buffer descriptor */
 		ebdp = NULL;
@@ -1865,7 +1865,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			vlan_packet_rcvd = true;
 
-			memmove(skb->data + VLAN_HLEN, data, ETH_ALEN * 2);
+			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
 			skb_pull(skb, VLAN_HLEN);
 		}
 

-- 
2.47.2



