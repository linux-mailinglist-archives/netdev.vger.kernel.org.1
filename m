Return-Path: <netdev+bounces-288587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +POIAxgICGqVVgMAu9opvQ
	(envelope-from <netdev+bounces-288587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:00:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078455A67E
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A4C303A91C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F8335AC31;
	Sat, 16 May 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crq2yQPm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13933355055;
	Sat, 16 May 2026 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778911070; cv=none; b=SLtVWuKcHZX823zPiwJgpF0FN4or0mpMvpi9ZHkZcM+fPYNtn1FjLTkKV1ZxOu1BJ2889JQEPDl5rsUuBTlyyvcBm0QRGLbDAdJi5jerzNhB0Kg0sfsN9WViFCbcksUcD5jgpb26FyvvFh67zbbd/7I4swsTMNhOQxt2SjRMqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778911070; c=relaxed/simple;
	bh=wF2pJ3vMaKwyQTxGa3rV9B1A+KQihqa1V6eUSBBEtp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZAS1yneKqXOp1OkF4i+8oqRVriVIXMVI+982R4NlmsxqYoy/H/1zDlAY4wdAG4dsYZiMUAfirrGJvuStZotLYmQLvdG+bP4p5UXRZLUNRd68eI8UABRJQYF75KuDJ7JO50qiWCdyeDldkBLVBEjJcyJ0+Cwj37TvBwwKvX8/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crq2yQPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA35C2BCB8;
	Sat, 16 May 2026 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778911069;
	bh=wF2pJ3vMaKwyQTxGa3rV9B1A+KQihqa1V6eUSBBEtp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=crq2yQPmfBMfPcGY7dG/4DYfpN1y/zHdAzI7fsbNN2rOjbRKh8Dj5Sk95N23Ul8em
	 B2TFadys3kY2WOO1uYV0zfHKqyB8v3SHDhVs8eJHZceTWrRuFd4VJ+Guxp4qxKV/ju
	 nDFwRc146SM0RX+YLGlnk7o06Ha6OEOOVBd0x/5U5yv8vSxbUYen+QWbiINpuTfOyt
	 R2Fk9sBfA2gNXs6jOiCf3jyfW806x4fTn4dLo8PrRWPX76+Y0DdVOe0XaB3CBPanDp
	 hS87kvpJVNqbgtWgOvZufYlzctARxJomyeLWDmBgY0aaONpmv/kWBHXo1QTwv/C2RL
	 uc3fczlMZiQmA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 16 May 2026 07:57:10 +0200
Subject: [PATCH net-next v7 08/10] net: airoha: Do not stop GDM port if it
 is shared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-airoha-eth-multi-serdes-v7-8-99e0093303e2@kernel.org>
References: <20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org>
In-Reply-To: <20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6078455A67E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288587-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Theoretically, in the current codebase, two independent net_devices can
be connected to the same GDM port so we need to check the GDM port is not
used by any other running net_device before setting the forward
configuration to FE_PSE_PORT_DROP.
Moreover, always set in GDM_LONG_LEN_MASK field of REG_GDM_LEN_CFG
register the maximum MTU of all running net_devices connected to the same
GDM port.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 55 +++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8558790eca64..c70e3ace38e2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1716,8 +1716,8 @@ static int airoha_dev_open(struct net_device *netdev)
 	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
+	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma = dev->qdma;
-	u32 pse_port = FE_PSE_PORT_PPE1;
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
@@ -1731,10 +1731,20 @@ static int airoha_dev_open(struct net_device *netdev)
 		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 				GDM_STAG_EN_MASK);
 
-	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
-		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
-		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
-		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	cur_len = airoha_fe_get(qdma->eth, REG_GDM_LEN_CFG(port->id),
+				GDM_LONG_LEN_MASK);
+	if (!port->users || len > cur_len) {
+		/* Opening a sibling net_device with a larger MTU updates the
+		 * MTU of already running devices. This is required to allow
+		 * multiple net_devices with different MTUs to share the same
+		 * GDM port.
+		 */
+		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
+			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
+			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
+			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	}
+	port->users++;
 
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -1757,6 +1767,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_qdma *qdma = dev->qdma;
+	u32 len = 0;
 	int i;
 
 	netif_tx_disable(netdev);
@@ -1764,8 +1775,25 @@ static int airoha_dev_stop(struct net_device *netdev)
 	for (i = 0; i < netdev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(netdev, i);
 
-	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
-				    FE_PSE_PORT_DROP);
+	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
+		struct net_device *n;
+
+		if (!port->devs[i])
+			continue;
+
+		n = port->devs[i]->dev;
+		if (netif_running(n))
+			len = max_t(u32, len, n->mtu);
+	}
+	len += ETH_HLEN + ETH_FCS_LEN;
+	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
+		      GDM_LONG_LEN_MASK,
+		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+
+	if (!--port->users)
+		airoha_set_gdm_port_fwd_cfg(qdma->eth,
+					    REG_GDM_FWD_CFG(port->id),
+					    FE_PSE_PORT_DROP);
 
 	if (atomic_dec_and_test(&qdma->users)) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
@@ -1917,13 +1945,18 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
 static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	u32 cur_len, len = ETH_HLEN + mtu + ETH_FCS_LEN;
 	struct airoha_gdm_port *port = dev->port;
-	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
 	struct airoha_eth *eth = dev->eth;
 
-	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
-		      GDM_LONG_LEN_MASK,
-		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	cur_len = airoha_fe_get(eth, REG_GDM_LEN_CFG(port->id),
+				GDM_LONG_LEN_MASK);
+	if (len > cur_len || !port->users ||
+	    (port->users == 1 && netif_running(netdev)))
+		airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
+			      GDM_LONG_LEN_MASK,
+			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+
 	WRITE_ONCE(netdev->mtu, mtu);
 
 	return 0;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fc49f0049983..32633d84f7d2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -555,6 +555,7 @@ struct airoha_gdm_dev {
 struct airoha_gdm_port {
 	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
 	int id;
+	int users;
 
 	struct airoha_hw_stats stats;
 

-- 
2.54.0


