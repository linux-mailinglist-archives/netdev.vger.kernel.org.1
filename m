Return-Path: <netdev+bounces-230390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7ABE76C9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78CAA3419DA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFC311C3B;
	Fri, 17 Oct 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMVSSLZi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED022D7D2E;
	Fri, 17 Oct 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692004; cv=none; b=e58jVWbkVEJIAUPS+E1uzhiulQl30pLNC9pg8bhu675VNTEcVtXzT39v+5atdwkcsyMzhVLuMGJdKtU5VyvdPBfdfbRyGJI3FMbqENkOEfa+fmrzAQDMLiPmzr2yJK/d9PLeRpQGS/d2r/GTewHVQSAIsUvIVT0i2xl2PJcdydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692004; c=relaxed/simple;
	bh=9eaP1roVILFvRVEW4CJKZph/rJGgGj6vCMuzQwQpE+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUP44+J5xQR9LDBSdyJZVb0Zu35QLOvVuW/zfTn0Ejbvja0hNIcilCgW5SMm7hoZM0T2+bXqDMWbUxZ0aC0WqOJupMw1eHgJlulwRFD7/fz5TqbUhgXVVxVpzOLKDhoJLpr/Q7dYv8iZHSmHw+w4u25pRCvVjmCq/L9TAMz52s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMVSSLZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93A0C4CEF9;
	Fri, 17 Oct 2025 09:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692004;
	bh=9eaP1roVILFvRVEW4CJKZph/rJGgGj6vCMuzQwQpE+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nMVSSLZipq6064Yp/KKf1oHOXWvKGqR63eC3y3/cq36kk26GbAYhzSwDBZMN/0XRv
	 8ReFum3eLaOn0V4Ri7eH6ZUe69LiAfr5C7DT9+1/O/R4yjOlgGMJ+IEHHYI+Z1WouV
	 IM6H0QUH6S2CYIoDcoLzH+WzwWh7pecwikmWPXQKSmEGD3822aOM1Kd/urLKOFPToI
	 Yh+gXIOk/pT5+27lX8YxjqLVLAtqe5bzT6zQKb0CwB5+vKelpKkecSgEfeK54wo2NW
	 om2JmFouQnFrwadM3ZzJPHAZE/X7EK6Fn2886EKapBkG0+iaDu4p++6FcC+HAkaYJL
	 TYEGI72QupM8g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:14 +0200
Subject: [PATCH net-next v3 05/13] net: airoha: Generalize
 airoha_ppe2_is_enabled routine
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-5-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Rename airoha_ppe2_is_enabled() in airoha_ppe_is_enabled() and
generalize it in order to check if each PPE module is enabled.
Rely on airoha_ppe_is_enabled routine to properly initialize PPE for
AN7583 SoC since AN7583 does not support PPE2.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 32 +++++++++++++++++++++-----------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 drivers/net/ethernet/airoha/airoha_ppe.c | 17 ++++++++++-------
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c9cebe6752eb524e58cfa30f937372d6d3baea1c..dea856ddf242d2c4ec3ca44796fc6deb2d784904 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -297,8 +297,11 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 	int q;
 
 	all_rsv = airoha_fe_get_pse_all_rsv(eth);
-	/* hw misses PPE2 oq rsv */
-	all_rsv += PSE_RSV_PAGES * pse_port_num_queues[FE_PSE_PORT_PPE2];
+	if (airoha_ppe_is_enabled(eth, 1)) {
+		/* hw misses PPE2 oq rsv */
+		all_rsv += PSE_RSV_PAGES *
+			   pse_port_num_queues[FE_PSE_PORT_PPE2];
+	}
 	airoha_fe_set(eth, REG_FE_PSE_BUF_SET, all_rsv);
 
 	/* CMD1 */
@@ -335,13 +338,17 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 	for (q = 4; q < pse_port_num_queues[FE_PSE_PORT_CDM4]; q++)
 		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_CDM4, q,
 					 PSE_QUEUE_RSV_PAGES);
-	/* PPE2 */
-	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_PPE2]; q++) {
-		if (q < pse_port_num_queues[FE_PSE_PORT_PPE2] / 2)
-			airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_PPE2, q,
-						 PSE_QUEUE_RSV_PAGES);
-		else
-			airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_PPE2, q, 0);
+	if (airoha_ppe_is_enabled(eth, 1)) {
+		/* PPE2 */
+		for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_PPE2]; q++) {
+			if (q < pse_port_num_queues[FE_PSE_PORT_PPE2] / 2)
+				airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_PPE2,
+							 q,
+							 PSE_QUEUE_RSV_PAGES);
+			else
+				airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_PPE2,
+							 q, 0);
+		}
 	}
 	/* GMD4 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_GDM4]; q++)
@@ -1762,8 +1769,11 @@ static int airoha_dev_init(struct net_device *dev)
 			airhoha_set_gdm2_loopback(port);
 		fallthrough;
 	case 2:
-		pse_port = FE_PSE_PORT_PPE2;
-		break;
+		if (airoha_ppe_is_enabled(eth, 1)) {
+			pse_port = FE_PSE_PORT_PPE2;
+			break;
+		}
+		fallthrough;
 	default:
 		pse_port = FE_PSE_PORT_PPE1;
 		break;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index cb7e198e40eeb2f44bd6e035cc7b583f47441d59..81b1e5f273df20fb8aef7a03e94ac14a3cfaf4d5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -627,6 +627,7 @@ static inline bool airoha_is_7581(struct airoha_eth *eth)
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
+bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 			  u16 hash, bool rx_wlan);
 int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 22ecece0e33ef4d7c9b1e2d6c5c9e510e3e0c040..505a3005f7db1c7804454177bf5b8a6aff54ef3f 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -50,9 +50,12 @@ static int airoha_ppe_get_total_num_stats_entries(struct airoha_ppe *ppe)
 	return num_stats;
 }
 
-static bool airoha_ppe2_is_enabled(struct airoha_eth *eth)
+bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index)
 {
-	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(1)) & PPE_GLO_CFG_EN_MASK;
+	if (index >= eth->soc->num_ppe)
+		return false;
+
+	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(index)) & PPE_GLO_CFG_EN_MASK;
 }
 
 static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
@@ -120,7 +123,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 						 AIROHA_MAX_MTU));
 	}
 
-	if (airoha_ppe2_is_enabled(eth)) {
+	if (airoha_ppe_is_enabled(eth, 1)) {
 		sram_num_entries = PPE1_SRAM_NUM_ENTRIES;
 		sram_num_stats_entries =
 			airoha_ppe_get_num_stats_entries(ppe);
@@ -518,7 +521,7 @@ static int airoha_ppe_foe_get_flow_stats_index(struct airoha_ppe *ppe,
 		return ppe_num_stats_entries;
 
 	*index = hash;
-	if (airoha_ppe2_is_enabled(ppe->eth) &&
+	if (airoha_ppe_is_enabled(ppe->eth, 1) &&
 	    hash >= ppe_num_stats_entries)
 		*index = *index - PPE_STATS_NUM_ENTRIES;
 
@@ -613,7 +616,7 @@ airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
 		u32 val;
 		int i;
 
-		ppe2 = airoha_ppe2_is_enabled(ppe->eth) &&
+		ppe2 = airoha_ppe_is_enabled(ppe->eth, 1) &&
 		       hash >= PPE1_SRAM_NUM_ENTRIES;
 		airoha_fe_wr(ppe->eth, REG_PPE_RAM_CTRL(ppe2),
 			     FIELD_PREP(PPE_SRAM_CTRL_ENTRY_MASK, hash) |
@@ -691,7 +694,7 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 
 	if (hash < PPE_SRAM_NUM_ENTRIES) {
 		dma_addr_t addr = ppe->foe_dma + hash * sizeof(*hwe);
-		bool ppe2 = airoha_ppe2_is_enabled(eth) &&
+		bool ppe2 = airoha_ppe_is_enabled(eth, 1) &&
 			    hash >= PPE1_SRAM_NUM_ENTRIES;
 
 		err = npu->ops.ppe_foe_commit_entry(npu, addr, sizeof(*hwe),
@@ -1286,7 +1289,7 @@ static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe,
 	int i, sram_num_entries = PPE_SRAM_NUM_ENTRIES;
 	struct airoha_foe_entry *hwe = ppe->foe;
 
-	if (airoha_ppe2_is_enabled(ppe->eth))
+	if (airoha_ppe_is_enabled(ppe->eth, 1))
 		sram_num_entries = sram_num_entries / 2;
 
 	for (i = 0; i < sram_num_entries; i++)

-- 
2.51.0


