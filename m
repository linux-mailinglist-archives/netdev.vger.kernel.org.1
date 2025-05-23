Return-Path: <netdev+bounces-193143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3AAC2A67
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725A41B65AE3
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C0225404;
	Fri, 23 May 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQlpxyoV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76848204C36
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028235; cv=none; b=Iasb1K55lqkX73ftGGayw3FYx8KRuBMGfhLyZoKYLPDGFL6PUx6lOylk7fe75przEpc8MxlHczG5J2GP0Rrr876kW9AdkmXVJvhB8FyTDs+aCi4GggQxHr+HPk3uCjzp7BQ4Gbd/8wBOyMgqhM/Q5MjS50qRoBM4vJ6cscj4/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028235; c=relaxed/simple;
	bh=JwKn1O3kNUXJMQphDvf1a17ESEWoK4upyuPLEp6UUG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ueFtAeIIFX5bO+JSpTQl99tioc5UHMtbLASVo0nZPMI6Z8bniwOBWSc51ajXAqWQGmPepHtFYo1Vp9r5whaHJ+pz6Lak3X0JBH9s24Lr8EHU7YzYgZQIhDBSV2T/ouqCz8z6bMYG8C2lpd/vuAunQFyP5sESdlyf4dKSzgN3thQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQlpxyoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FB3C4CEE9;
	Fri, 23 May 2025 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748028235;
	bh=JwKn1O3kNUXJMQphDvf1a17ESEWoK4upyuPLEp6UUG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uQlpxyoVHYlh3skX6Bs/mlYYomsoDpTJS6i6Xjikv7EUpl8br5LuhTRBuEZEgBGAz
	 3KK0BnovzHNpnA6tEZvNwk+C0Nxeq9tLx0ODwI3wgJVfWH8JmqRjVvLdQPhRO8x3qR
	 7hkSKuF80VZM5189FPC2KA+Lo0Ly0KMytXQ5UM/KQvzVkfRPPt4a6CRKynOzNr7gOu
	 D4lXEDLWRRVJ2Mp/tBjV7mfz5q+7TTHQsa88ImvNbvEjewH0QRLw+nuwyUiw3cP5+J
	 p9vxwYj9X+1K2xFTRdsfr4n6wX1q4AebLNncn8zkFeiV3hcl4X8Ux2CN5tD+En22pE
	 V36DLOO8/3blg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 23 May 2025 21:23:30 +0200
Subject: [PATCH net-next 1/2] net: airoha: Initialize PPE UPDMEM source-mac
 table
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-airoha-flowtable-pppoe-v1-1-8584401568e0@kernel.org>
References: <20250523-b4-airoha-flowtable-pppoe-v1-0-8584401568e0@kernel.org>
In-Reply-To: <20250523-b4-airoha-flowtable-pppoe-v1-0-8584401568e0@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

UPDMEM source-mac table is a key-value map used to store devices mac
addresses according to the port identifier. UPDMEM source mac table is
used during IPv6 traffic hw acceleration since PPE entries, for space
constraints, do not contain the full source mac address but just the
identifier in the UPDMEM source-mac table.

Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  |  2 ++
 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_ppe.c  | 25 ++++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_regs.h | 10 ++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 0d627e511266d94e079e8a87d2f812fb14b4ad07..e4c67c7bbf215d448640f978cd0d9d50abd73644 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -92,6 +92,8 @@ static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
 	val = (addr[3] << 16) | (addr[4] << 8) | addr[5];
 	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
 	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
+
+	airoha_ppe_init_upd_mem(port);
 }
 
 static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 531a3c49c1562a986111a1ce1c215c8751c16e09..a951246c0171e14497b510d3029fc0a7f891efe6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -611,6 +611,7 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
 int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
+void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
 struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 						  u32 hash);
 void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 2d273937f19cf304ab4b821241fdc3ea93604f0e..1d5a04eb82a6645e2b6a22ff4e694275ef1727d8 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -223,6 +223,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 	int dsa_port = airoha_get_dsa_port(&dev);
 	struct airoha_foe_mac_info_common *l2;
 	u32 qdata, ports_pad, val;
+	u8 smac_id = 0xf;
 
 	memset(hwe, 0, sizeof(*hwe));
 
@@ -251,6 +252,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 		else
 			pse_port = 2; /* uplink relies on GDM2 loopback */
 		val |= FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT, pse_port);
+		smac_id = port->id;
 	}
 
 	if (is_multicast_ether_addr(data->eth.h_dest))
@@ -285,7 +287,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 		hwe->ipv4.l2.src_mac_lo =
 			get_unaligned_be16(data->eth.h_source + 4);
 	} else {
-		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, 0xf);
+		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, smac_id);
 	}
 
 	if (data->vlan.num) {
@@ -1232,6 +1234,27 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
 	airoha_ppe_foe_insert_entry(ppe, skb, hash);
 }
 
+void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
+{
+	struct airoha_eth *eth = port->qdma->eth;
+	struct net_device *dev = port->dev;
+	const u8 *addr = dev->dev_addr;
+	u32 val;
+
+	val = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
+	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
+	airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
+		     FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
+		     PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
+
+	val = (addr[0] << 8) | addr[1];
+	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
+	airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
+		     FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
+		     FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
+		     PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
+}
+
 int airoha_ppe_init(struct airoha_eth *eth)
 {
 	struct airoha_ppe *ppe;
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index d931530fc96fb00ada36a6ad37fa295865a6f0a8..04187eb40ec674ec5a4ccfc968bb4bd579a53095 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -313,6 +313,16 @@
 #define REG_PPE_RAM_BASE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x320)
 #define REG_PPE_RAM_ENTRY(_m, _n)		(REG_PPE_RAM_BASE(_m) + ((_n) << 2))
 
+#define REG_UPDMEM_CTRL(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x370)
+#define PPE_UPDMEM_ACK_MASK			BIT(31)
+#define PPE_UPDMEM_ADDR_MASK			GENMASK(11, 8)
+#define PPE_UPDMEM_OFFSET_MASK			GENMASK(7, 4)
+#define PPE_UPDMEM_SEL_MASK			GENMASK(3, 2)
+#define PPE_UPDMEM_WR_MASK			BIT(1)
+#define PPE_UPDMEM_REQ_MASK			BIT(0)
+
+#define REG_UPDMEM_DATA(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x374)
+
 #define REG_FE_GDM_TX_OK_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x280)
 #define REG_FE_GDM_TX_OK_BYTE_CNT_H(_n)		(GDM_BASE(_n) + 0x284)
 #define REG_FE_GDM_TX_ETH_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x288)

-- 
2.49.0


