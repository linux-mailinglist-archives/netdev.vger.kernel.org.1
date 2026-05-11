Return-Path: <netdev+bounces-286613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHonG++0AWr2igEAu9opvQ
	(envelope-from <netdev+bounces-286613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:52:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0B950C43F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6DF2300383B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8A3DC4AE;
	Mon, 11 May 2026 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppQ2ea5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0ED3DB645;
	Mon, 11 May 2026 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496615; cv=none; b=d469wIFHgn+WCMnmPoVXtXSRZJYosOopH6XdNpKatCQAr+7GztEa2wGT1G1TPbUI2f6LuY4Ah3hRSkf/0Kmwb13jzvIEKCEEeDzq7Y2KCmKdhhBd2Kfn443nVmCWb6rpfMKfL9Als2GBvE2USDsXUcwwJ+1Ow3+8ptFDJOfdDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496615; c=relaxed/simple;
	bh=ANRAGlFa3UZi71IVWNXkiTzcg/j83rNOKzag+S8gWNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHkD488eH+J+dVvsng+D9RJ8TkyYVBJYQHWdLyycoaXfXux5R2PtxtYmI6yoaUXaKoNrY4WD/ZjfmhdtSBKGC4DgFOiuAl3JedonePwEeXQDqHcI69WjVKFdZwTYOM/P5PnwmKNmuhrfojwCmUqtxG3qapkTJ3sKKsS4Dqv7IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppQ2ea5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7D1C2BCFC;
	Mon, 11 May 2026 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496615;
	bh=ANRAGlFa3UZi71IVWNXkiTzcg/j83rNOKzag+S8gWNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ppQ2ea5LrcLjQpZMl01MaxfZrV2wLm8vppZBRp7kvZokAt9TdVXJTfbCyYXVW0m9R
	 MPUru/hCWUwqhRMrqfbYMv0F3H9r4eJMgFho/GdmbnPDwj5j9FM2ywgYe9Me0fxrOd
	 dKCSlgRM/X+H19Ibn9rHwMX9zwi85Nu/mWjG/cv6tonPvPpax3F9Lwf1y4vMRNK9U8
	 VhUOEJP/nPd6opLLsnkpy8e4fZNDT0nGb30i10ZdyIiFtpQgLUkv6gsMRqKuA5vYs0
	 hB5pp9FR7ZnMhE+rKqPCSaDau9FG3R68TJHhFjcGw+sikZ6pCHxVSavlQ2PKNeEqby
	 IvtB0SpDVyh3w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 May 2026 12:49:35 +0200
Subject: [PATCH net-next v6 09/12] net: airoha: Do not stop GDM port if it
 is shared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-airoha-eth-multi-serdes-v6-9-c899462c4f75@kernel.org>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
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
X-Rspamd-Queue-Id: 8A0B950C43F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286613-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Action: no action

Theoretically, in the current codebase, two independent net_devices can
be connected to the same GDM port so we need to check the GDM port is not
used by any other running net_device before setting the forward
configuration to FE_PSE_PORT_DROP.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 53 +++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 4efd36779453..aed182c7a5e1 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1718,8 +1718,8 @@ static int airoha_dev_open(struct net_device *netdev)
 	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
+	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma = dev->qdma;
-	u32 pse_port = FE_PSE_PORT_PPE1;
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
@@ -1733,10 +1733,20 @@ static int airoha_dev_open(struct net_device *netdev)
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
+		 * multiple net_devices wht different MTUs to share the same
+		 * QDMA block.
+		 */
+		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
+			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
+			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
+			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	}
+	port->users++;
 
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -1759,6 +1769,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_qdma *qdma = dev->qdma;
+	u32 len = 0;
 	int i;
 
 	netif_tx_disable(netdev);
@@ -1766,8 +1777,23 @@ static int airoha_dev_stop(struct net_device *netdev)
 	for (i = 0; i < netdev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(netdev, i);
 
-	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
-				    FE_PSE_PORT_DROP);
+	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
+		if (!port->devs[i])
+			continue;
+
+		netdev = port->devs[i]->dev;
+		if (netif_running(netdev))
+			len = max_t(u32, len, netdev->mtu);
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
@@ -1919,13 +1945,18 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
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


