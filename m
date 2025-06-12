Return-Path: <netdev+bounces-196983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE20AD7382
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276A3163BD2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9EA25A331;
	Thu, 12 Jun 2025 14:16:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D6253935
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737796; cv=none; b=bJbKmzy1uplXbqukSICuTBOim5X+P3p2n5nKYRozuDXXAsUvb58jGkhmNx3eJKB72G9+pElFZaqt6pWhLmm90+u0f62UrHcf6vPybtwuwP2wb2fHl1GMDyFtiSScib0TKwGW8Qgsbu2x0XHaIK7U0kWtGd4CVtX4Tp8McM+nhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737796; c=relaxed/simple;
	bh=KcSHw1b30IZrtNMUrCtQ6+yKA56AmY/dp9ME1hDmxyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzWf26K9RPDu6lui8ll7Tzpj6dbBsIL7uC7sM1IduR3uC3fBncwjohKG+jCKzVGAm1FRkXflUAAI19OX0+vcmRmrzDETu7PBsW6oagTLt69Kr4t7tWQ+vcbU6vInhwkwHf2YQRxjEz+xbFE/wTiVVwZwhtrNqY57mbkDP+ILxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e75c:5124:23a3:4f62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id C676566BC18
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8EAE44264CA
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C82C742642D;
	Thu, 12 Jun 2025 14:16:18 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 445b6bb7;
	Thu, 12 Jun 2025 14:16:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 12 Jun 2025 16:16:00 +0200
Subject: [PATCH net-next v2 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-fec-cleanups-v2-7-ae7c36df185e@pengutronix.de>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
In-Reply-To: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=KcSHw1b30IZrtNMUrCtQ6+yKA56AmY/dp9ME1hDmxyU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoSuEpFhwQUjyuruadsyF86whxVy4NTFg7Z7ysd
 NxXeVkc+1GJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaErhKQAKCRAMdGXf+ZCR
 nNXcB/9ulSM9ha3AJbDn7/PRdbxjWITgGjRa+5wsops1wQjhWz7+dnAUI0H16zzy/5AS44J8dC1
 wWgNkLImEGj1nm4FYbKMZIUsQm43bj8YPEwwcUgSqPI5UYg3PKB3QaQN6MORWURLJO7Ja2pGqAK
 IUbb2dcF1M4buUEARxrW8W/jYQgMxlXZkyvhWAj+bjU1HQU+K/FeQicBn0wOzI+Zo16+wFXBNCp
 jvsUo7MNLk1xGu8oaI4v5kb/UD1WtIifPfvrxoO/RlwiVDR+YZfCj2VNuuxgnTgryR6pYXvPshq
 EQ+fi38ngGRVixBt8EdjOndsWa4UlM//PxQJ7Hx3FW4rs0L5
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Use the provided helper function skb_vlan_eth_hdr() to replace manual VLAN
header calculation for better readability and maintainability.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6b456372de9a..f238cb60aa65 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1860,8 +1860,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		    fep->bufdesc_ex &&
 		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
 			/* Push and remove the vlan tag */
-			struct vlan_hdr *vlan_header =
-					(struct vlan_hdr *) (data + ETH_HLEN);
+			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
 			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
 
 			vlan_packet_rcvd = true;

-- 
2.47.2



