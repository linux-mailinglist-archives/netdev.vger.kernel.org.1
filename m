Return-Path: <netdev+bounces-296687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rzd+LcIIJ2o6qgIAu9opvQ
	(envelope-from <netdev+bounces-296687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:24:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB9659AE6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:24:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YDCUd4Tp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296687-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1075832131AA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242D36D506;
	Mon,  8 Jun 2026 18:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A13793BA
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 18:04:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941884; cv=none; b=W9Yo8X9l0g/R3Uxmr4tlg/iyecujFcXmzBiE/cd0qDMj+e/C1XG36SfrM2DVfQ//qA+DT5JlA44CSDclnR46l6K71vFptSymJq3ujf25PRgswiKsZZQcvNi4b4j0Vu4dMtquk8Tu81uhNa7prYscrHqf3bWCjkG8wke3ZhEgvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941884; c=relaxed/simple;
	bh=ECvG9MEeHquSxUFtO/W80PgeS6bSajjTcx8EEQ9d3Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CuD/n7Yo8p/ORQ2GWDxrKh1LyLCwrsnnSndEKNTj0wYOhoueohwYl7ibHrOv47O2fht/WHUTBnruf8WABIkVFV8QypbM0s6egZMMwtvW4fq9wzCY5uQHFV3oqOARRZi7PZ7b6ne34dnF5bmFs9/dbAUjbOYToy0PA60PCtmUxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDCUd4Tp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927401F00893;
	Mon,  8 Jun 2026 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941883;
	bh=g0aExmTQOMa5yWFytUw//Zp2hu374sm0csU8o0Sy1Sg=;
	h=From:Date:Subject:To:Cc;
	b=YDCUd4TpWLUG7dLjvmigOzUdaMDyfM+X3EGOs+y4T6AG7ITu9aWUEKPxqJ7fpWMmB
	 AkTOtokH3WKfR/ciUzzkxf0exwsbBj4xfv6f5j8phrppR0EnIlqLCffR63TTVgkYkC
	 w0KSKt2+U8pD69mq2l6fmjPt9kDf+lSKvo5A5crUzCEpS7G168B/Z1IcwXVmuW3RRX
	 ZnfgZeYoznRjHGG9ikgvi8XNAVTNak/9yKtooG+krQDRX0cF4UhhUNdECo/cPitFVd
	 b+mDLLg3xjrLbepFMDNuyjMt9KNjvHoIi2Oiubw2ukcw7IS8bZRbUjUpITMuUM2qz0
	 4pewGSELUTmUg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 08 Jun 2026 20:03:49 +0200
Subject: [PATCH net-next v3] net: airoha: defer GDM3/GDM4 WAN mode and GDM2
 loopback to QoS offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-airoha-ethtool-priv_flags-v3-1-3e8e3dc3f715@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQrDIBAF0KuEWdeiNsSkq96jlGLsGKVBg4qkh
 Ny94qrdlDIw8PnMmw0iBosRzs0GAbON1rsSTocGlJFuQmIfJQOnvKNliLTBG0kwmeT9TJZg813
 Pcopk7KQUVJXVUyj3S0Bt12pfwWEiDtcEt9IYG5MPr/o0s9r/4WdGGGkpG7kaNA6aXZ4YHM5HH
 6bKZv5JiV8UL5RouRJSMmQ9/6L2fX8DKO31xhgBAAA=
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296687-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13FB9659AE6

GDM3 and GDM4 ports require GDM2 loopback to be enabled for hardware
QoS offload to function. Without it, HTB and ETS offload on these ports
do not work.
Previously, GDM3/GDM4 ports were automatically configured as WAN with
GDM2 loopback enabled during ndo_init(). Move this setup to be performed
on demand when QoS offload is created or destroyed. GDM3 and GDM4 now
default to LAN mode at init time, while GDM2 is always WAN.
Hook airoha_enable_qos_for_gdm34() into TC_HTB_CREATE so that requesting
HTB offload on a GDM3/GDM4 LAN port switches it to WAN mode and enables
GDM2 loopback, with proper rollback on failure. Hook the counterpart
airoha_disable_qos_for_gdm34() into TC_HTB_DESTROY to restore LAN mode
when the offloaded qdisc is torn down.
Add airoha_disable_gdm2_loopback() as the teardown counterpart of the
existing airoha_enable_gdm2_loopback().
Move QDMA TX/RX DMA enable from airoha_dev_open() to airoha_probe() and
the corresponding disable from airoha_dev_stop() to airoha_qdma_cleanup(),
removing the per-QDMA atomic refcount that was needed for the open/close
path. DMA is now always active from probe to remove.

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v3:
- Do not introduce ethtool private flags support to configure LAN/WAN
  for GDM3/4 and rely on tc qdisc offload for it instead.
- Set GDM3/4 ports as LAN by default.
- Move QDMA TX/RX DMA enable from airoha_dev_open() to airoha_probe()
  and the corresponding disable from airoha_dev_stop() to airoha_qdma_cleanup().
- Link to v2: https://lore.kernel.org/r/20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org

Changes in v2:
- Rework airoha_dev_set_wan_flag routine
- Enable GDM_STRIP_CRC_MASK in airoha_disable_gdm2_loopback()
- Do not always reset REG_SRC_PORT_FC_MAP6 in
  airoha_disable_gdm2_loopback() but use the same condition used in
  airoha_enable_gdm2_loopback().
- Link to v1: https://lore.kernel.org/r/20260606-airoha-ethtool-priv_flags-v1-1-401b2c9fe9f1@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 177 ++++++++++++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h  |   2 -
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 3 files changed, 131 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..9bfb1e5b2b54 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1516,6 +1516,10 @@ static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
 {
 	int i;
 
+	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+			  GLOBAL_CFG_TX_DMA_EN_MASK |
+			  GLOBAL_CFG_RX_DMA_EN_MASK);
+
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
 		if (!qdma->q_rx[i].ndesc)
 			continue;
@@ -1806,11 +1810,6 @@ static int airoha_dev_open(struct net_device *netdev)
 	}
 	port->users++;
 
-	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
-			GLOBAL_CFG_TX_DMA_EN_MASK |
-			GLOBAL_CFG_RX_DMA_EN_MASK);
-	atomic_inc(&qdma->users);
-
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    airoha_ppe_is_enabled(qdma->eth, 1))
 		pse_port = FE_PSE_PORT_PPE2;
@@ -1863,19 +1862,6 @@ static int airoha_dev_stop(struct net_device *netdev)
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
 
-	if (atomic_dec_and_test(&qdma->users)) {
-		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
-				  GLOBAL_CFG_TX_DMA_EN_MASK |
-				  GLOBAL_CFG_RX_DMA_EN_MASK);
-
-		for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-			if (!qdma->q_tx[i].ndesc)
-				continue;
-
-			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-		}
-	}
-
 	return 0;
 }
 
@@ -1960,6 +1946,49 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 	return 0;
 }
 
+static int airoha_disable_gdm2_loopback(struct airoha_gdm_dev *dev)
+{
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
+	int i, src_port;
+	u32 pse_port;
+
+	src_port = eth->soc->ops.get_sport(dev->port, dev->nbq);
+	if (src_port < 0)
+		return src_port;
+
+	airoha_fe_clear(eth,
+			REG_SP_DFT_CPORT(src_port >> fls(SP_CPORT_DFT_MASK)),
+			SP_CPORT_MASK(src_port & SP_CPORT_DFT_MASK));
+
+	airoha_fe_set(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+		      GDM_STRIP_CRC_MASK);
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    FE_PSE_PORT_DROP);
+	airoha_fe_clear(eth, REG_GDM_LPBK_CFG(AIROHA_GDM2_IDX),
+			LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK);
+	pse_port = airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
+						 : FE_PSE_PORT_PPE1;
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    pse_port);
+
+	airoha_fe_rmw(eth, REG_FE_WAN_PORT, WAN0_MASK,
+		      FIELD_PREP(WAN0_MASK, AIROHA_GDM2_IDX));
+
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_fe_clear(eth, REG_PPE_DFT_CPORT(i, AIROHA_GDM2_IDX),
+				DFT_CPORT_MASK(AIROHA_GDM2_IDX));
+
+	/* Enable VIP and IFC for GDM2 */
+	airoha_fe_set(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
+	airoha_fe_set(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
+
+	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth))
+		airoha_fe_wr(eth, REG_SRC_PORT_FC_MAP6, FC_MAP6_DEF_VALUE);
+
+	return 0;
+}
+
 static struct airoha_gdm_dev *
 airoha_get_wan_gdm_dev(struct airoha_eth *eth)
 {
@@ -2002,40 +2031,14 @@ static int airoha_dev_init(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 
-	switch (port->id) {
-	case AIROHA_GDM3_IDX:
-	case AIROHA_GDM4_IDX: {
-		struct airoha_eth *eth = dev->eth;
-
-		/* GDM2 supports a single net_device */
-		if (eth->ports[1] && eth->ports[1]->devs[0])
-			break;
-
-		if (airoha_get_wan_gdm_dev(eth))
-			break;
-
-		fallthrough;
-	}
-	case AIROHA_GDM2_IDX:
-		/* GDM2 is always used as wan */
+	if (port->id == AIROHA_GDM2_IDX) {
+		/* GDM2 is always used as WAN */
 		dev->flags |= AIROHA_PRIV_F_WAN;
-		break;
-	default:
-		break;
 	}
 
 	airoha_dev_set_qdma(dev);
 	airoha_set_macaddr(dev, netdev->dev_addr);
 
-	if (!airoha_is_lan_gdm_dev(dev) &&
-	    (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)) {
-		int err;
-
-		err = airoha_enable_gdm2_loopback(dev);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
@@ -3008,6 +3011,79 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 	return 0;
 }
 
+static int airoha_enable_qos_for_gdm34(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
+	u32 pse_port;
+	int err;
+
+	if (port->id != AIROHA_GDM3_IDX &&
+	    port->id != AIROHA_GDM4_IDX) {
+		/* HW QoS is always supported by GDM1 and GDM2 */
+		return 0;
+	}
+
+	if (!airoha_is_lan_gdm_dev(dev)) /* Already enabled */
+		return 0;
+
+	/* Verify the WAN device is not already configured */
+	if (airoha_get_wan_gdm_dev(dev->eth))
+		return -EBUSY;
+
+	dev->flags |= AIROHA_PRIV_F_WAN;
+	airoha_dev_set_qdma(dev);
+	err = airoha_enable_gdm2_loopback(dev);
+	if (err)
+		goto error_disable_wan;
+
+	err = airoha_set_macaddr(dev, netdev->dev_addr);
+	if (err)
+		goto error_disable_loopback;
+
+	pse_port = airoha_ppe_is_enabled(dev->eth, 1) ? FE_PSE_PORT_PPE2
+						      : FE_PSE_PORT_PPE1;
+	airoha_set_gdm_port_fwd_cfg(dev->eth, REG_GDM_FWD_CFG(port->id),
+				    pse_port);
+
+	return 0;
+
+error_disable_loopback:
+	/* Restore previous LAN configuration */
+	airoha_disable_gdm2_loopback(dev);
+error_disable_wan:
+	dev->flags &= ~AIROHA_PRIV_F_WAN;
+	airoha_dev_set_qdma(dev);
+
+	return err;
+}
+
+static void airoha_disable_qos_for_gdm34(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
+	int err;
+
+	if (port->id != AIROHA_GDM3_IDX &&
+	    port->id != AIROHA_GDM4_IDX) {
+		return;
+	}
+
+	if (airoha_is_lan_gdm_dev(dev)) /* Already disabled */
+		return;
+
+	err = airoha_disable_gdm2_loopback(dev);
+	if (err)
+		netdev_warn(netdev,
+			    "failed disabling GDM2 loopback: %d\n", err);
+
+	dev->flags &= ~AIROHA_PRIV_F_WAN;
+	airoha_dev_set_qdma(dev);
+	airoha_set_macaddr(dev, netdev->dev_addr);
+	airoha_set_gdm_port_fwd_cfg(dev->eth, REG_GDM_FWD_CFG(port->id),
+				    FE_PSE_PORT_PPE1);
+}
+
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
@@ -3016,6 +3092,8 @@ static int airoha_tc_htb_destroy(struct net_device *netdev)
 	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
 		airoha_tc_remove_htb_queue(netdev, q);
 
+	airoha_disable_qos_for_gdm34(netdev);
+
 	return 0;
 }
 
@@ -3040,7 +3118,7 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
 {
 	switch (opt->command) {
 	case TC_HTB_CREATE:
-		break;
+		return airoha_enable_qos_for_gdm34(dev);
 	case TC_HTB_DESTROY:
 		return airoha_tc_htb_destroy(dev);
 	case TC_HTB_NODE_MODIFY:
@@ -3414,6 +3492,11 @@ static int airoha_probe(struct platform_device *pdev)
 	if (err)
 		goto error_napi_stop;
 
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_qdma_set(&eth->qdma[i], REG_QDMA_GLOBAL_CFG,
+				GLOBAL_CFG_TX_DMA_EN_MASK |
+				GLOBAL_CFG_RX_DMA_EN_MASK);
+
 	return 0;
 
 error_napi_stop:
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..cd0706a0c07f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -526,8 +526,6 @@ struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
 
-	atomic_t users;
-
 	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
 
 	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..4e17dfbcf2b8 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -376,6 +376,7 @@
 
 #define REG_SRC_PORT_FC_MAP6		0x2298
 #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
+#define FC_MAP6_DEF_VALUE		0x1b1a1918
 
 #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
 

---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


