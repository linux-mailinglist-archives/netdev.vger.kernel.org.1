Return-Path: <netdev+bounces-199044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBFAADEB49
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FAD3B43BF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E32E974D;
	Wed, 18 Jun 2025 12:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88C2E716B
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248046; cv=none; b=kidXxyVhFT6OWBznEuzIq5/wv3qNS7XaFYWzJQwJjWhUbGN+61kuyGbbUgTCqMyl6zTVAA8sCs+6shkwpTSdZy+S5tBD6QhdDLDnGgTWN9xx0ri1Ne6Pz6w7Rkd/B22fgrOT5tHyyMU2wFVggZfbZdjF2HSRW90D6AFbGCsa/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248046; c=relaxed/simple;
	bh=PMHgw81XIjkNeSXXll/6bz9Ldxq3m67MxfOiZzQjVBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+NX4yySnYQCuJ2IuJdu/F1E+iLZab5Js9tZcRfUNxZkELyLlKQpVnjhC+poIsvTB3FlYSl8TV3AxfxOSV/P1EwJ6jD8uh/1mDfFHCvhGueZbEsl+7nQguF8864DcGV+7s8ne0Qch5rk7uhqxFI/+Q3iuhPcdVaCcoOEdV4yCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 4F3CD66FD10
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:00:38 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0FA1642B5E2
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:00:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2A35642B527;
	Wed, 18 Jun 2025 12:00:30 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b7be5052;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:11 +0200
Subject: [PATCH net-next v4 11/11] net: fec: fec_enet_rx_queue(): factor
 out VLAN handling into separate function fec_enet_rx_vlan()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-11-c16f9a1af124@pengutronix.de>
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
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=PMHgw81XIjkNeSXXll/6bz9Ldxq3m67MxfOiZzQjVBc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpaYjb2JWZO8kIHnOfp7gBUnRqDhgsRyzGUj
 VoR9B7PbSqJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqWgAKCRAMdGXf+ZCR
 nMKjB/4xBAVWZp3BXyWtzQ6eCDsmjQfRkrCPp/XxunVoQLzdqKi7NTYRBoTcfq3IxppHa50pewJ
 WKlJe79myDdO9SdD2zNBtZALu5FwYrgsmV7aqQlvit3awPdmxX0rk1OCR3N4pBf8PFgKMXlMhPE
 IPSckb00+pTWPJF7h+Cd8YWO+eCaxajwEWKfUittCXPopSNe8Umi/xZvWf8KR1iRpohAzL/8Uo6
 D/SrkRkurA/NSUteXMow9aBHkbn/veIpKhAoW7CdCLc0da5MgiMDGRkI/GhAdli3syl9tZz25oM
 RR6mLdKyJSsvicJDyO9wihl3lOfA3p3KmgWprYYuyb2iOLuN
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
index 6797aa1ed639..63dac4272045 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1706,6 +1706,22 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
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
@@ -1852,19 +1868,9 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
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



