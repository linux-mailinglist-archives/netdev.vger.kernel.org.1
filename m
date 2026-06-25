Return-Path: <netdev+bounces-301873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J4kNE6vPPGqDsggAu9opvQ
	(envelope-from <netdev+bounces-301873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:50:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 957966C323B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gp9yjb3F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301873-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301873-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12EC43020D4B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA563C0A1C;
	Thu, 25 Jun 2026 06:49:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309A3C0A0E
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:49:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370184; cv=none; b=QLTenN0aLtfK5R5x6c2fCMMl/qJHLM6FPVJch4xh/H8VS9D6eTmuvun9uUFucCrDgj/jN30lwqH1wWGDjGpQstWFcRgXdrQvYrieoobC7AK8e2UVyof5k691YdL1BII76D4zUiNtJG6WbZN5WHJA5i0bezkAC6XYeiPFjkozNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370184; c=relaxed/simple;
	bh=YEh4KEopn+BBTAN8eeYkgcguLs0jsSPOzQW+aRfuO/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kpKAtDBYscV40OGH0WTjm8L2OuDuHJo4sY6TqEzerQwxnBN8pSzTu1MHk8bE/aFNXkM63HxSuU+IOiMiSBm6Jm0/0Qx1RhdijA9LIl1P+0oTeTL84jWCcnG9U+TJVKQ8TKkQT4XXZ0vfnTHuln7Kr1R9Ew+2PR+KKi1LQ9KA9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp9yjb3F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADAE1F000E9;
	Thu, 25 Jun 2026 06:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782370183;
	bh=Zj+Zplq1yfDDVsNBzweX6gGEWViKIQwgogzX9mKUtB0=;
	h=From:Date:Subject:To:Cc;
	b=gp9yjb3FYyBxWYwSnk0ILJpTbBiJgizO7zysGIrBMG5BIQ+Bdpe2FreV3/n99WTdB
	 4bfrFLHDkaCz4h9fd6X40qRWyOPJ+6vAUUIe7zBvfTiMg37oD+/iUt/gimJ+O7A98W
	 lrMKjP/a9JegsB0rFB7abm7CBkvuIWgsyTsF+JoKLoaorsKOJMGt/kKUa9rjzbxKl5
	 zb/vtwlfLxiX2r2Zw6mZbfo8OKQG20iZrYGQjMRM4j0jIeGQZxw8SHh6QxGR0GqKVm
	 phzetlonD6Cj+N8BburxYXV0zfOh2ijwMduUAFsFipy2X7mM+gBtay/Mp6VgiEtGTD
	 l1KLRMJesStbQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 25 Jun 2026 08:49:23 +0200
Subject: [PATCH net] net: airoha: fix max receive size configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-airoha-fix-rx-max-len-v1-1-45b9b827358d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAQBAAf0X7bMvpLPkVeTgstjjak67k310ep
 2bmgcAqHKDNHlC+JcjhE5g8g3F1fmGUKTGURUkFmQad6LE6nCWiRtxdxI09VjVVdiAyZAlSeyo
 n4/924PmC/n0/vw1/8mwAAAA=
X-Change-ID: 20260618-airoha-fix-rx-max-len-57654b661646
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 957966C323B

Set the GDM maximum receive size to AIROHA_MAX_RX_SIZE unconditionally
during hardware initialization instead of updating it according to the
configured MTU. This avoids dropping incoming frames that exceed the
current MTU but could still be processed by the networking stack, which
is able to fragment the reply on the TX side (e.g. ICMP echo requests).
Move the per-port MTU configuration to the PPE egress path where it
belongs, and set the tx frame size running airoha_ppe_set_xmit_frame_size()
to dynamically track the maximum MTU across running interfaces sharing
the same PPE instance.
Fix the PPE MTU register addressing to pack two port entries per
register word and add WAN_MTU0 configuration for non-LAN GDM devices.

Fixes: 54d989d58d2a ("net: airoha: Move min/max packet len configuration in airoha_dev_open()")
Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 68 ++++++++++---------------------
 drivers/net/ethernet/airoha/airoha_eth.h  |  2 +
 drivers/net/ethernet/airoha/airoha_ppe.c  | 39 +++++++++++++-----
 drivers/net/ethernet/airoha/airoha_regs.h |  9 ++--
 4 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 932b3a3df2e5..3f451c2d4c24 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -178,10 +178,15 @@ static void airoha_fe_maccr_init(struct airoha_eth *eth)
 {
 	int p;
 
-	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++)
+	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++) {
 		airoha_fe_set(eth, REG_GDM_FWD_CFG(p),
 			      GDM_TCP_CKSUM_MASK | GDM_UDP_CKSUM_MASK |
 			      GDM_IP4_CKSUM_MASK | GDM_DROP_CRC_ERR_MASK);
+		airoha_fe_rmw(eth, REG_GDM_LEN_CFG(p),
+			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
+			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
+			      FIELD_PREP(GDM_LONG_LEN_MASK, AIROHA_MAX_RX_SIZE));
+	}
 
 	airoha_fe_rmw(eth, REG_CDM_VLAN_CTRL(1), CDM_VLAN_MASK,
 		      FIELD_PREP(CDM_VLAN_MASK, 0x8100));
@@ -1831,13 +1836,24 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	spin_unlock(&port->stats_lock);
 }
 
+static void airoha_dev_set_xmit_frame_size(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	airoha_ppe_set_xmit_frame_size(dev);
+	if (!airoha_is_lan_gdm_dev(dev))
+		airoha_fe_rmw(dev->eth, REG_WAN_MTU0, WAN_MTU0_MASK,
+			      FIELD_PREP(WAN_MTU0_MASK,
+					 VLAN_ETH_HLEN + netdev->mtu));
+}
+
 static int airoha_dev_open(struct net_device *netdev)
 {
-	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma = dev->qdma;
+	u32 pse_port = FE_PSE_PORT_PPE1;
+	int err;
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
@@ -1851,19 +1867,7 @@ static int airoha_dev_open(struct net_device *netdev)
 		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 				GDM_STAG_EN_MASK);
 
-	cur_len = airoha_fe_get(qdma->eth, REG_GDM_LEN_CFG(port->id),
-				GDM_LONG_LEN_MASK);
-	if (!port->users || len > cur_len) {
-		/* Opening a sibling net_device with a larger MTU updates the
-		 * MTU of already running devices. This is required to allow
-		 * multiple net_devices with different MTUs to share the same
-		 * GDM port.
-		 */
-		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
-			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
-			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
-			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
-	}
+	airoha_dev_set_xmit_frame_size(netdev);
 	port->users++;
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
@@ -1875,30 +1879,6 @@ static int airoha_dev_open(struct net_device *netdev)
 	return 0;
 }
 
-static void airoha_set_port_mtu(struct airoha_eth *eth,
-				struct airoha_gdm_port *port)
-{
-	u32 len = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
-		struct airoha_gdm_dev *dev = port->devs[i];
-		struct net_device *netdev;
-
-		if (!dev)
-			continue;
-
-		netdev = netdev_from_priv(dev);
-		if (netif_running(netdev))
-			len = max_t(u32, len, netdev->mtu);
-	}
-	len += ETH_HLEN + ETH_FCS_LEN;
-
-	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
-		      GDM_LONG_LEN_MASK,
-		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
-}
-
 static int airoha_dev_stop(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
@@ -1909,7 +1889,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 	airoha_set_vip_for_gdm_port(dev, false);
 
 	if (--port->users)
-		airoha_set_port_mtu(dev->eth, port);
+		airoha_ppe_set_xmit_frame_size(dev);
 	else
 		airoha_set_gdm_port_fwd_cfg(qdma->eth,
 					    REG_GDM_FWD_CFG(port->id),
@@ -1962,10 +1942,6 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
 		      LBK_GAP_MODE_MASK | LBK_LEN_MODE_MASK |
 		      LBK_CHAN_MODE_MASK | LPBK_EN_MASK);
-	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(AIROHA_GDM2_IDX),
-		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
-		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
-		      FIELD_PREP(GDM_LONG_LEN_MASK, AIROHA_MAX_MTU));
 	/* Forward the traffic to the proper GDM port */
 	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
 					       : FE_PSE_PORT_GDM4;
@@ -2098,7 +2074,7 @@ static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 
 	WRITE_ONCE(netdev->mtu, mtu);
 	if (port->users)
-		airoha_set_port_mtu(dev->eth, port);
+		airoha_dev_set_xmit_frame_size(netdev);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index d7ff8c5200e2..0c3fb6e5d7f1 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -23,6 +23,7 @@
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_MTU			9220
+#define AIROHA_MAX_RX_SIZE		16128
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_QOS_CHANNELS		4
 #define AIROHA_NUM_QOS_QUEUES		8
@@ -676,6 +677,7 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
 bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 			     struct airoha_gdm_dev *dev);
 
+void airoha_ppe_set_xmit_frame_size(struct airoha_gdm_dev *dev);
 void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport);
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 42f4b0f21d17..e7c78293002a 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -97,6 +97,33 @@ void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport)
 		      __field_prep(DFT_CPORT_MASK(fport), fe_cpu_port));
 }
 
+void airoha_ppe_set_xmit_frame_size(struct airoha_gdm_dev *dev)
+{
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
+	int i, ppe_id, index;
+	u32 len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
+		struct airoha_gdm_dev *d = port->devs[i];
+		struct net_device *netdev;
+
+		if (!d)
+			continue;
+
+		netdev = netdev_from_priv(d);
+		if (netif_running(netdev))
+			len = max_t(u32, len, netdev->mtu);
+	}
+	len += VLAN_ETH_HLEN;
+
+	ppe_id = !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
+	index = port->id == AIROHA_GDM4_IDX ? 7 : port->id;
+	airoha_fe_rmw(eth, REG_PPE_MTU(ppe_id, index),
+		      FP_EGRESS_MTU_MASK(index),
+		      __field_prep(FP_EGRESS_MTU_MASK(index), len));
+}
+
 static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 {
 	u32 sram_ppe_num_data_entries = PPE_SRAM_NUM_ENTRIES, sram_num_entries;
@@ -115,8 +142,6 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
 
 	for (i = 0; i < eth->soc->num_ppe; i++) {
-		int p;
-
 		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
 			     ppe->foe_dma + sram_tb_size);
 
@@ -166,15 +191,6 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 		airoha_fe_wr(eth, REG_PPE_HASH_SEED(i), PPE_HASH_SEED);
 		airoha_fe_clear(eth, REG_PPE_PPE_FLOW_CFG(i),
 				PPE_FLOW_CFG_IP6_6RD_MASK);
-
-		for (p = 0; p < ARRAY_SIZE(eth->ports); p++)
-			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
-				      FP0_EGRESS_MTU_MASK |
-				      FP1_EGRESS_MTU_MASK,
-				      FIELD_PREP(FP0_EGRESS_MTU_MASK,
-						 AIROHA_MAX_MTU) |
-				      FIELD_PREP(FP1_EGRESS_MTU_MASK,
-						 AIROHA_MAX_MTU));
 	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
@@ -196,6 +212,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 				 airoha_ppe_is_enabled(eth, 1);
 			fport = airoha_get_fe_port(dev);
 			airoha_ppe_set_cpu_port(dev, ppe_id, fport);
+			airoha_ppe_set_xmit_frame_size(dev);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..6fed63d013b4 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -327,9 +327,8 @@
 #define PPE_SRAM_TABLE_EN_MASK			BIT(0)
 
 #define REG_PPE_MTU_BASE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x304)
-#define REG_PPE_MTU(_m, _n)			(REG_PPE_MTU_BASE(_m) + ((_n) << 2))
-#define FP1_EGRESS_MTU_MASK			GENMASK(29, 16)
-#define FP0_EGRESS_MTU_MASK			GENMASK(13, 0)
+#define REG_PPE_MTU(_m, _n)			(REG_PPE_MTU_BASE(_m) + (((_n) / 2) << 2))
+#define FP_EGRESS_MTU_MASK(_n)			GENMASK(13 + (((_n) % 2) << 4), ((_n) % 2) << 4)
 
 #define REG_PPE_RAM_CTRL(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x31c)
 #define PPE_SRAM_CTRL_ACK_MASK			BIT(31)
@@ -377,6 +376,10 @@
 #define REG_SRC_PORT_FC_MAP6		0x2298
 #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
 
+#define REG_WAN_MTU0			0x2300
+#define WAN_MTU1_MASK			GENMASK(29, 16)
+#define WAN_MTU0_MASK			GENMASK(13, 0)
+
 #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
 
 /* QDMA */

---
base-commit: fd1269e454089abda0e4f9e5e25ecd02a90ab009
change-id: 20260618-airoha-fix-rx-max-len-57654b661646

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


