Return-Path: <netdev+bounces-198606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20300ADCD4A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1393BAF91
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29012EA474;
	Tue, 17 Jun 2025 13:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD442E7642
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166742; cv=none; b=e/2xTCxinbf8fiWyr1fo/udaqJr8ANY/F/BBF6wpsiwBwu6aw8gjwbm8GG2o8ayEd8NY8WxEGFGIT57cyf86BpEsZFZ23nCzE9HPUbPrc/4Q6OAY52zbFKYUcFjpomnLigegUhFGakOvCftWLZ6LL9S2qnEBFBMkwU7Pak8KRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166742; c=relaxed/simple;
	bh=sem55EClJLo7e0sBEpRg90jWZ80rps5L0scKJuN10gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLuwQApUFULuP1rvkV2u0SqkAo1LWSjGLjabfnHuhJj0zK/GHLqwnRG4u6jicX8D3U/2KubIL5NHToU3lkQioKjs5/MxpG4WxzKuDakrZoDUxviyPICQWXTN1a+PyyZGbM78ogL72PpeGuoBqvtF39dOcEQZgudSolSU5dOeA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e2bf:c3f2:96ab:885d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 744C766ED73
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:29 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3C12042A85C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0B73D42A7AF;
	Tue, 17 Jun 2025 13:25:22 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 57c6960e;
	Tue, 17 Jun 2025 13:25:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 17 Jun 2025 15:24:57 +0200
Subject: [PATCH net-next v3 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-fec-cleanups-v3-7-a57bfb38993f@pengutronix.de>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
In-Reply-To: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=sem55EClJLo7e0sBEpRg90jWZ80rps5L0scKJuN10gc=;
 b=owGbwMvMwMXIU5J6/+eEiXMYT6slMWQE5uyQ4los48S4VWeh96Xveq8bLe3KPBIvlc9+Vnruy
 5JPD/0+dTIaszAwcjHIiimyzP/Nc2N9+or4P6I5n2EGsTKBTGHg4hSAiVS7sf+V3/9vXUFK8Uov
 sfadzXtl8rnSvyq+6qi2mJ8b/kjAKkKqWDLSY6vZ+/rVJzhzd6q2dM0TZRRW8PvP3hrrwfbk3J/
 ZX/3W/OOeu2r7pOxbUls6bpQzcmuvOxWy7N+9A2qLNd0ZFl9w6M/dMddCyyqEe+OKnecFXLufGg
 dmPY9c6Pc5uSWffb/WtZy/tl+8+r8FHLCQyxMty/6XqcEd7NKhJWqg4rV09uHVvEGedyadUXig+
 15ZImifsvWGyMs8JfLZ05na7Vg+T+K+2NvNdK9oB3/ilvXMpwIXGBxvc5JQEl/AfDk2UylRgDE0
 sZDLxEPOPmp37pzst9/Yb+vqTeqeftj4kfB9xv0JTAJzAQ==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

For better readability and maintainability, use the provided helper function
skb_vlan_eth_hdr() to replace manual the VLAN header calculation, and change
the type of vlan_header to struct vlan_ethhdr to take into account that the
Ethernet header plus VLAN header is returned.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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



