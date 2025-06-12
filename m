Return-Path: <netdev+bounces-196985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB1AD73B0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234181884EFA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C025B2E3;
	Thu, 12 Jun 2025 14:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396EA253B67
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737797; cv=none; b=Idrof3hmq6VUhB5CLbjUK8rcFSQUPKxo2yT8Cz3QZpd3XVCFG6KLzQsTFJ6u9H0f1RZJLoM0yh3sW7bIsVYGhjW44Gb2lEY2EcLnxe6PQiuq4nYGUVw2yEX9A0kCZJgZYYhTZHTbmmenu/9pZEmXTapeSiulmT4VIy5zuqGmjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737797; c=relaxed/simple;
	bh=fQ4LxAZsa4WZr7runtQggvEmU2rQ7E01a9lhK4ivd8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=equLcjcp2SsCWMwieaqRkSIGXOUde5oQdKqVoESpQW0yGsQT9wE3aB4gZQC06lta4azB5C07Z8U1WZl5KfCqbZdTMcOt06/bbkFB1H8XWjueunXCJFaiEv858Hxzq58q/08uM2iNYsnNNFZD0jF/2+Qc6RbXEA2kMd3itRTnx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e75c:5124:23a3:4f62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id E9ECE66BC1E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B5F994264CF
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 347D7426437;
	Thu, 12 Jun 2025 14:16:19 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 65aecce6;
	Thu, 12 Jun 2025 14:16:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 12 Jun 2025 16:16:03 +0200
Subject: [PATCH net-next v2 10/10] net: fec: fec_enet_rx_queue(): factor
 out VLAN handling into separate function fec_enet_rx_vlan()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-fec-cleanups-v2-10-ae7c36df185e@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=fQ4LxAZsa4WZr7runtQggvEmU2rQ7E01a9lhK4ivd8k=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoSuEvRz8uDo/weDp9hJlKrn7e8rgO6n7cTJi3Z
 DC1zYCtfUOJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaErhLwAKCRAMdGXf+ZCR
 nDChCACT4wUJSs2PGa5EAnIDee4f8oGrR6Oe1nd7+OAR8AhejVXzu3hmiQ7G7trRkI3LAJRJlNX
 lMCEtL7MgsLIOo6hR63Ly+GCXv+MRpy5N7m2Pv5alb2nAYStlozFIShEArmAhIrVgoPbXNYa9NJ
 FTfZK0Hhps6Tb0at+YBvBfBQlFPpTyKGpNF2aTUmFH2gTPlKUAKF6gngzOrQBXBNu/owVum3xEA
 S7KSx+UFVyS7D5Nrr32pIZz96QpbcFA8GBVghDZ/G2TaWdq1drGXFBERvJ+IneI4sm6K3vPV3Sn
 XQKQFzIkEfErfVpY+Cr4H2zXx5sJVGcus+j/My+WbpzgB82p
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In order to clean up of the VLAN handling, factor out the VLAN
handling into separate function fec_enet_rx_vlan().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 021cf7c2dcf6..24dd1b280da0 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1707,6 +1707,22 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 	return ret;
 }
 
+static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
+{
+	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
+		const struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
+		const u16 vlan_tag = ntohs(vlan_header->h_vlan_TCI);
+
+		/* Push and remove the vlan tag */
+
+		memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
+		skb_pull(skb, VLAN_HLEN);
+		__vlan_hwaccel_put_tag(skb,
+				       htons(ETH_P_8021Q),
+				       vlan_tag);
+	}
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1853,19 +1869,9 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			ebdp = (struct bufdesc_ex *)bdp;
 
 		/* If this is a VLAN packet remove the VLAN Tag */
-		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
-		    fep->bufdesc_ex &&
-		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
-			/* Push and remove the vlan tag */
-			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
-			u16 vlan_tag = ntohs(vlan_header->h_vlan_TCI);
-
-			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
-			skb_pull(skb, VLAN_HLEN);
-			__vlan_hwaccel_put_tag(skb,
-					       htons(ETH_P_8021Q),
-					       vlan_tag);
-		}
+		if (fep->bufdesc_ex &&
+		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
+			fec_enet_rx_vlan(ndev, skb);
 
 		skb->protocol = eth_type_trans(skb, ndev);
 

-- 
2.47.2



