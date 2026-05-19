Return-Path: <netdev+bounces-289344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKvIDnAqDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:16:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEC57B0E8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA194310E792
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61793F889E;
	Tue, 19 May 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVVqeNW8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B893F871B;
	Tue, 19 May 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181120; cv=none; b=a0skErrWUBwAik8Ghf1wDVNrJWjLB7/KIwf4wXe5RSA3vIsYlwRHqotMVzaPe4wOTFJaGb4s6DA8is1KqHcefCkH7xooPliDclqbmX2VwdTLsqDtQ6fzghzWrxqeAfNDR8NIRNAFaVIpxOJzGUPoucMv9058Os2eIEEm7boLOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181120; c=relaxed/simple;
	bh=o5jH716Kj3cKBagYc+7f5tGkAVkaF3Ot0LbOg7UfEdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aHV9GuxJVhskVxxXspBOpGF3CTLw0B4Ej6+Dprb9s+YGhf0UYpubeiERBfvPnJY7H0SvHSeIRkj9VuYo5E5aYYXWR5y/Mu5KAvX2XZbPsc3A5DkSQscjKsMh3iOmPWQC1UCyU5iKq9EUPl3Lhohst8oLR1uKFQy6mL/SuU5nI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVVqeNW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9E9C2BD05;
	Tue, 19 May 2026 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181120;
	bh=o5jH716Kj3cKBagYc+7f5tGkAVkaF3Ot0LbOg7UfEdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WVVqeNW8uqgppgMG0pEh4lrp2MKSlZ0QzTl8q/WRWRSHtRoRl2NxtK+De6P5tNOHl
	 oFxYRba68vi1EB4R2q67jyLRLYXUkg0LzqM7A1tcpQeaqlhygK2GjiyDJ/qsV653Y+
	 WC78QT6uGzbLYTwsXbou1t26DPzW5/Br8fbG8SmwAdTzqeJjbe4kZ3BjcuPADwe8Tf
	 UlM9wwnAJKj2SVyw0kXBYabA7DsencXNmu6UsSuyA8ct4kR2cNFYESCb8hqPuPafG9
	 iksIHynSeVpa2TZ7qxkxrHBQj+KT9ZzWo55kiCOc3hEuW9h9CQjp8KmaLEIgJnbrLX
	 jKnFJoShUZ4Yg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 May 2026 10:57:51 +0200
Subject: [PATCH net-next v8 08/10] net: airoha: Do not stop GDM port if it
 is shared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-airoha-eth-multi-serdes-v8-8-6bd70e329df6@kernel.org>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289344-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,airoha.com:email]
X-Rspamd-Queue-Id: 3BFEC57B0E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/airoha/airoha_eth.c | 59 +++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8d36ab6cd785..15ad5a7edd43 100644
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
@@ -1752,6 +1762,30 @@ static int airoha_dev_open(struct net_device *netdev)
 	return 0;
 }
 
+static void airoha_set_port_mtu(struct airoha_eth *eth,
+				struct airoha_gdm_port *port)
+{
+	u32 len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
+		struct airoha_gdm_dev *dev = port->devs[i];
+		struct net_device *netdev;
+
+		if (!dev)
+			continue;
+
+		netdev = dev->dev;
+		if (netif_running(netdev))
+			len = max_t(u32, len, netdev->mtu);
+	}
+	len += ETH_HLEN + ETH_FCS_LEN;
+
+	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
+		      GDM_LONG_LEN_MASK,
+		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+}
+
 static int airoha_dev_stop(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
@@ -1764,8 +1798,12 @@ static int airoha_dev_stop(struct net_device *netdev)
 	for (i = 0; i < netdev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(netdev, i);
 
-	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
-				    FE_PSE_PORT_DROP);
+	if (--port->users)
+		airoha_set_port_mtu(dev->eth, port);
+	else
+		airoha_set_gdm_port_fwd_cfg(qdma->eth,
+					    REG_GDM_FWD_CFG(port->id),
+					    FE_PSE_PORT_DROP);
 
 	if (atomic_dec_and_test(&qdma->users)) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
@@ -1918,13 +1956,10 @@ static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
-	struct airoha_eth *eth = dev->eth;
 
-	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
-		      GDM_LONG_LEN_MASK,
-		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
 	WRITE_ONCE(netdev->mtu, mtu);
+	if (port->users)
+		airoha_set_port_mtu(dev->eth, port);
 
 	return 0;
 }
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


