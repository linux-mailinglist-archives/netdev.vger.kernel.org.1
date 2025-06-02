Return-Path: <netdev+bounces-194593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E24ACACD8
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEEB19607A3
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262A210F44;
	Mon,  2 Jun 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUmVoqvu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7292040AB
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861759; cv=none; b=kqizbMvzDIha2IOB0PoC1KwKuJC57eLNSOOFAZwTNh5DWenPXI0rI6nekAPEXWxHYPCPnUiC+25aJRHez2Bo7i073xYguzmdktNtIst9VnoLzZNAMD55I0kpZVAzmC7UMAfRwzars8JLROe6kpxYKt7Kj6fvjSF8r0OZeZh1t0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861759; c=relaxed/simple;
	bh=PrBbFcr2EBu1yUqwrgyaEHmUBSZuBJoF7PE+74RIxeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQZTpVhCwKHXrP4p7pYvbKzWL4srO6/Ho+ULXR86VpLJL0OGp0i2oKqN7gM1zAH6/0Yx1NA5KK3iRW89NTLTGXLRP8SEGZR3qKHgOYnobhnB+LnWbOsE2wIWlFpTkRehfAZ1kvyCbYFuzY6kD3JjQH5PXMQt2fOuIC1rLxlObxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUmVoqvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87755C4CEED;
	Mon,  2 Jun 2025 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748861758;
	bh=PrBbFcr2EBu1yUqwrgyaEHmUBSZuBJoF7PE+74RIxeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TUmVoqvua15gca87BMsqcfsLiRv1wpGwYTU9gCImh9v1/CG8Pv6dpuCxiH0Nkahx7
	 RwwAncmpCha/IY6rDIjMux9gBk7FNnmj3/jiQKbwfO+8lllpL+oYMEW76RsuTfo0qZ
	 sJ88IOsOOlrTOcu0OluCRSGYcO1L7jvEwhm/RKLwK3pBaCzz1rYBiwLgJEJ2l4MaUw
	 rFpQsvsxA7gC+Bg2TwEoncCOhiD9EG3UKKDiW8NX3B8jUjodzT5v9kmzoQPb3W71ae
	 9MpJ5TIC94CwghjBAavABIWYFRFCXFUyx/ntbhhU37fWjNOPbKKeE+Be80qJbjffOF
	 2899ewUQ/c5Gg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 02 Jun 2025 12:55:37 +0200
Subject: [PATCH net v2 1/3] net: airoha: Initialize PPE UPDMEM source-mac
 table
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-airoha-flowtable-ipv6-fix-v2-1-3287f8b55214@kernel.org>
References: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
In-Reply-To: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

UPDMEM source-mac table is a key-value map used to store devices mac
addresses according to the port identifier. UPDMEM source mac table is
used during IPv6 traffic hw acceleration since PPE entries, for space
constraints, do not contain the full source mac address but just the
identifier in the UPDMEM source-mac table.
Configure UPDMEM source-mac table with device mac addresses and set
the source-mac ID field for PPE IPv6 entries in order to select the
proper device mac address as source mac for L3 IPv6 hw accelerated traffic.

Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  |  2 ++
 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_ppe.c  | 26 +++++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_regs.h | 10 ++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d1d3b854361e443d414876f79f59b3c64cbcbe16..a7ec609d64dee9c8e901c7eb650bb3fe144ee00a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -84,6 +84,8 @@ static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
 	val = (addr[3] << 16) | (addr[4] << 8) | addr[5];
 	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
 	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
+
+	airoha_ppe_init_upd_mem(port);
 }
 
 static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index b815697302bfdf2a6d115a9bbbbadc05462dbadb..a970b789cf232c316e5ea27b0146493bf91c3767 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -614,6 +614,7 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
 int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
+void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
 struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 						  u32 hash);
 void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 12d32c92717a6b4ba74728ec02bb2e166d4d9407..a783f16980e6b7fdb69cec7ff09883a9c83d42d5 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -223,6 +223,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 	int dsa_port = airoha_get_dsa_port(&dev);
 	struct airoha_foe_mac_info_common *l2;
 	u32 qdata, ports_pad, val;
+	u8 smac_id = 0xf;
 
 	memset(hwe, 0, sizeof(*hwe));
 
@@ -257,6 +258,8 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 		 */
 		if (airhoa_is_lan_gdm_port(port))
 			val |= AIROHA_FOE_IB2_FAST_PATH;
+
+		smac_id = port->id;
 	}
 
 	if (is_multicast_ether_addr(data->eth.h_dest))
@@ -291,7 +294,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 		hwe->ipv4.l2.src_mac_lo =
 			get_unaligned_be16(data->eth.h_source + 4);
 	} else {
-		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, 0xf);
+		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, smac_id);
 	}
 
 	if (data->vlan.num) {
@@ -1238,6 +1241,27 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
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


