Return-Path: <netdev+bounces-268687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AxwA5iFuWkPJAIAu9opvQ
	(envelope-from <netdev+bounces-268687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:47:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD252AE6A1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E370930C74CC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8438376BCA;
	Tue, 17 Mar 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAuhEv65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158B3EC2C2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765669; cv=none; b=RCstJYFvR/oSXHXh/xDlJukLjbKiNRE6sSP0gBbj6a5PZ3OW1jJLQ1v31rAHfFR+/uGUea6ceWQ68XhoQwzFQA3NOyyLCs82IlBy2uAZI+D2uMNXiYgJXD35uWt61PiXqklK9x78mX5KLO2V2+qZoh6pZJ18RUrjZFCiT2vIbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765669; c=relaxed/simple;
	bh=aKk8CwjQFlvDFGw19/B1mbkHRei2+NpV9NvGcu75TQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RJ0XJHaotZWS3Go2YtSMvkR4gXuqpegv6JUp232GRyMExtan+u/7eBIVRiJqKxCEjg++3S6kgk9hJwwxRj712v6S7Dyjno1f5fXWs00k4Tkm9ta4hrxDR4Q4RQEwgMDNOHCIEz+OokSt/V95qV48BXmkMBXqWnqfCcDJyGMsaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAuhEv65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCF5C4CEF7;
	Tue, 17 Mar 2026 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765669;
	bh=aKk8CwjQFlvDFGw19/B1mbkHRei2+NpV9NvGcu75TQI=;
	h=From:Date:Subject:To:Cc:From;
	b=mAuhEv65MyTHCKNdGkZ+qb4On/+XKTu4aKKsqOqDXq2CiqVhg9MU8l3l3431xdrtK
	 stDTJ2hgDsKuWjgpT9V4CHVuNOYjBInGhP5R76bQAB+mSftaupDgtOC9+uRqnANElX
	 G1kX6rNSoA41Xkg4rUK1pzW1L/6EoF17o4USUOnEqOjLtXO7sKpZiwlJuimVenhrB+
	 847vvC82phUw222+bD+GwqMpHuSJJErZhwZsk5HMJTOSY65GLBdM86uiAn72gz0yAL
	 sXWxzTz9alQLmoQqkrh8IJ7F202Qaz8NiFt/RgfGoCjcizUGnZvFE01kKLGlNHOEMt
	 1MMv2AaHGreaQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 17 Mar 2026 17:40:47 +0100
Subject: [PATCH net-next] net: airoha: Reset PPE cpu port configuration in
 airoha_ppe_hw_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-airoha-fix-ppe-def-cpu-v1-1-338533d8e234@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBQFrxJ/3QczqOgq0cL0WX9johVBdPek5
 cDMPJSRBJnG6qGES7LsoUBTV2Q3E1awuMKkle5U2/RsJO2bYS83xwh28GzjyUoPyvedc3ZZqMQ
 xoSj/eKKAgwPug+b3/QA9fqV9cgAAAA==
X-Change-ID: 20260317-airoha-fix-ppe-def-cpu-0280f76ddcbb
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268687-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FD252AE6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Before this patch, the PPE cpu port configuration used for a specific GDM
device was set just running ndo_init() callback during the device
initialization. The selected PPE cpu port configuration depends on the QDMA
block assigned to the GDM port. The QDMA block is selected according to
the GDM port LAN/WAN configuration as specified in the commit
'8737d7194d6d ("net: airoha: select QDMA block according LAN/WAN
configuration"). However, the user selected PPE cpu port configuration can
be different with respect to the one hardcoded in the NPU firmware binary.
The hardcoded NPU PPE cpu port configuration is loaded initializing the PPE
engine running the NPU ops ppe_init() callback in airoha_ppe_offload_setup
routine (this is executed at runtime by the netfilter flowtable
infrastructure during flow offloading).
Reset the PPE cpu port configuration in airoha_ppe_hw_init routine in
order to apply the user requested setup according to the device DTS.
Please note this patch is fixing an issue not visible to the user (so we
do not need to backport it) since airoha_eth driver currently supports just
the internal phy available via the MT7530 DSA switch and there are no WAN
interfaces officially supported since PCS/external phy is not merged
mainline yet (it will be posted with following patches).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 28 ++++++----------------------
 drivers/net/ethernet/airoha/airoha_eth.h  |  2 ++
 drivers/net/ethernet/airoha/airoha_ppe.c  | 23 ++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_regs.h |  7 +++----
 4 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index b4563b5d53bbf174d45548a5efc6fdfb79d33c19..21a866e3cc05522104c0a7dc49a6b7a3c9f42165 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1755,8 +1755,7 @@ static int airoha_dev_init(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_eth *eth = port->eth;
-	u32 fe_cpu_port;
-	u8 ppe_id;
+	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
 	port->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
@@ -1774,28 +1773,13 @@ static int airoha_dev_init(struct net_device *dev)
 			if (err)
 				return err;
 		}
-		fallthrough;
-	case AIROHA_GDM2_IDX:
-		if (airoha_ppe_is_enabled(eth, 1)) {
-			/* For PPE2 always use secondary cpu port. */
-			fe_cpu_port = FE_PSE_PORT_CDM2;
-			ppe_id = 1;
-			break;
-		}
-		fallthrough;
-	default: {
-		u8 qdma_id = port->qdma - &eth->qdma[0];
-
-		/* For PPE1 select cpu port according to the running QDMA. */
-		fe_cpu_port = qdma_id ? FE_PSE_PORT_CDM2 : FE_PSE_PORT_CDM1;
-		ppe_id = 0;
 		break;
-	}
+	default:
+		break;
 	}
 
-	airoha_fe_rmw(eth, REG_PPE_DFT_CPORT0(ppe_id),
-		      DFT_CPORT_MASK(port->id),
-		      __field_prep(DFT_CPORT_MASK(port->id), fe_cpu_port));
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_ppe_set_cpu_port(port, i);
 
 	return 0;
 }
@@ -1898,7 +1882,7 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
-static int airoha_get_fe_port(struct airoha_gdm_port *port)
+int airoha_get_fe_port(struct airoha_gdm_port *port)
 {
 	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_eth *eth = qdma->eth;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8cfa94ec084a16d6b2d3c94c404f25904c1150e3..7df4dbcd8861856c54c2a38bc89c69180ac2f6dc 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -646,9 +646,11 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 	return eth->soc->version == 0x7583;
 }
 
+int airoha_get_fe_port(struct airoha_gdm_port *port);
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
+void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id);
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 			  u16 hash, bool rx_wlan);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index ec5ce41dad80827c8b467b8be112eebd14914744..7666b1d2f4f6ea758683181ab90d6fffb7bcd19d 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -85,6 +85,20 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
 }
 
+void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id)
+{
+	struct airoha_qdma *qdma = port->qdma;
+	u8 fport = airoha_get_fe_port(port);
+	struct airoha_eth *eth = qdma->eth;
+	u8 qdma_id = qdma - &eth->qdma[0];
+	u32 fe_cpu_port;
+
+	fe_cpu_port = qdma_id ? FE_PSE_PORT_CDM2 : FE_PSE_PORT_CDM1;
+	airoha_fe_rmw(eth, REG_PPE_DFT_CPORT(ppe_id, fport),
+		      DFT_CPORT_MASK(fport),
+		      __field_prep(DFT_CPORT_MASK(fport), fe_cpu_port));
+}
+
 static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 {
 	u32 sram_ppe_num_data_entries = PPE_SRAM_NUM_ENTRIES, sram_num_entries;
@@ -147,7 +161,9 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 
 		airoha_fe_wr(eth, REG_PPE_HASH_SEED(i), PPE_HASH_SEED);
 
-		for (p = 0; p < ARRAY_SIZE(eth->ports); p++)
+		for (p = 0; p < ARRAY_SIZE(eth->ports); p++) {
+			struct airoha_gdm_port *port = eth->ports[p];
+
 			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
 				      FP0_EGRESS_MTU_MASK |
 				      FP1_EGRESS_MTU_MASK,
@@ -155,6 +171,11 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 						 AIROHA_MAX_MTU) |
 				      FIELD_PREP(FP1_EGRESS_MTU_MASK,
 						 AIROHA_MAX_MTU));
+			if (!port)
+				continue;
+
+			airoha_ppe_set_cpu_port(port, i);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 29878b954c77c79ae45e63357840a10c23c517f2..436f3c8779c102e900139e9f015816ebeb64eb98 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -312,10 +312,9 @@
 #define REG_PPE_HASH_SEED(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x244)
 #define PPE_HASH_SEED				0x12345678
 
-#define REG_PPE_DFT_CPORT0(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x248)
-#define DFT_CPORT_MASK(_n)			GENMASK(3 + ((_n) << 2), ((_n) << 2))
-
-#define REG_PPE_DFT_CPORT1(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x24c)
+#define REG_PPE_DFT_CPORT_BASE(_n)		(((_n) ? PPE2_BASE : PPE1_BASE) + 0x248)
+#define REG_PPE_DFT_CPORT(_m, _n)		(REG_PPE_DFT_CPORT_BASE(_m) + (((_n) / 8) << 2))
+#define DFT_CPORT_MASK(_n)			GENMASK(3 + (((_n) % 8) << 2), (((_n) % 8) << 2))
 
 #define REG_PPE_TB_HASH_CFG(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x250)
 #define PPE_DRAM_HASH1_MODE_MASK		GENMASK(31, 28)

---
base-commit: 8737d7194d6d5947c3d7d8813895b44a25b84477
change-id: 20260317-airoha-fix-ppe-def-cpu-0280f76ddcbb

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


