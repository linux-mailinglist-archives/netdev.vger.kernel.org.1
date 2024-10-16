Return-Path: <netdev+bounces-136328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2019A153B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A7A282EE0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73FE1D88AD;
	Wed, 16 Oct 2024 21:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885241D6193
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115557; cv=none; b=T/1C5X9o3KYtbX6N59M6SDPtyBSB6Hl1mnbdUppyFwWM/9h3eN4UpB4KpJ/8QNZ5kUL+qBf8XPF+gG2SriWdGCTil9csTOfw6HNh+mGERM20wg4vuXsjtYZa/93NAaNVcv7VB20R2f0Zz67IqCtU4wDx/Ni4xjJeP3LLw1+j+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115557; c=relaxed/simple;
	bh=MLw/OjJP6cNXgUpE4sPWYT6eX3+hx3P7ZwIqHofemPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gm3trKYxLDonCgg7jpCD2TeAaZcCBEBY+qjx/Z0PqvopZrPMjERFJvseRmN0YBHg+yOIAd8tR9Kn/OctmvmXqILxjiLFo01ShZSPqse8HXvSwIeDhkJFcBi1Hh1mgiExGaEru/oqSRKfYHQMUKUI+mF858lk9aws5IIVO6EhddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003Si-KA
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwR-002OVc-2G
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AC91335493A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1449935489A;
	Wed, 16 Oct 2024 21:52:21 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2489b82c;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:52:01 +0200
Subject: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue(): factor out
 VLAN handling into separate function fec_enet_rx_vlan()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-13-de783bd15e6a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=MLw/OjJP6cNXgUpE4sPWYT6eX3+hx3P7ZwIqHofemPU=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWRgqGybH94bTPvg7nSPQVDwSx23chmG6x6L
 rSto0ZM+8CJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1kQAKCRAoOKI+ei28
 b1KIB/0Qcyrj8IXmsPuKwCaj7/dfZALaen5kPt+GX0j437FFoKpmt/VE7xkLdO5pLY2u/4QxnpZ
 tEFXCn3jALofRZxBK1ghVuoj6BlbRIcJ7/KCfcz1G8s/+wLBwQlycxzyGcqhP4X8b47Ifje5GX2
 tl0Tl2fFCtoN2yOQBaM6hEW2zKFtJWdSLN17HpBgKFyOgulmUgdJDZs/7Ipcc+LHlICtX7XLPlE
 Kbpo0vg6jkYkM3EpVXXJt9vwQfapOEiTpSFGgpErUAItNwGTenEheKQoRQxIgCJDQ4DjScAOT9l
 hvm/L2UmgfqSEJ6JaKbeEfEeV/1rzvjOBQH/cq94alqczwjL
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

In order to clean up of the VLAN handling, factor out the VLAN
handling into separate function fec_enet_rx_vlan().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d9415c7c16cea3fc3d91e198c21af9fe9e21747e..e14000ba85586b9cd73151e62924c3b4597bb580 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1672,6 +1672,22 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 	return ret;
 }
 
+static void fec_enet_rx_vlan(struct net_device *ndev, struct sk_buff *skb)
+{
+	struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
+
+	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
+		/* Push and remove the vlan tag */
+		u16 vlan_tag = ntohs(vlan_header->h_vlan_TCI);
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
@@ -1812,19 +1828,9 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
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
2.45.2



