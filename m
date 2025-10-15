Return-Path: <netdev+bounces-229490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DABDCDDF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784D93BACE4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE9313E3F;
	Wed, 15 Oct 2025 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr61Q9Ko"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607562BE7A0;
	Wed, 15 Oct 2025 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512544; cv=none; b=pe6Ku231Wbz8Jz4ByTBwCEjcGOo8Ppfx1u9Y6iDjNDwkbuwARx+o9254gK9+q3JjTymiyc2Ef5A80hxlsygXGO5MYm1pbTbDEbnQwUflJN3sIpK3jTF7dmmVUwe9lIKuKSG5LVWc/YqoJnlHmXvKL8xEqAllMVXGmYtdBx+NaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512544; c=relaxed/simple;
	bh=SnFDIbmnt8sluvd1jGzJK+WzdlpMgL5Rv5kEFz5BeJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDt3Olrc+s40qWzSIHBJbNsLINpO+KDI0RGV67kQPNe3Y+T4qtoxk9rrkq5mdlhNqKLQuQn5Oe9Ek7BDvoRg+fYn0YS5tuQBBnYY7ZD80gA2dKnrJ15muD2aQt6B1c0IYeFcUKmk4kjoZtlTCDDfbL/Rbo2kGRgr4pT6ecw+n60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr61Q9Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF16C4CEF9;
	Wed, 15 Oct 2025 07:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512543;
	bh=SnFDIbmnt8sluvd1jGzJK+WzdlpMgL5Rv5kEFz5BeJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kr61Q9KoiVaGOxduL2VCbrovxobkMcWlMxnoMvCmQjJMdhNfiY8v2CtJNRVkkdzOO
	 bQGD/BMtZbbQ/jIQL7TvjpZRDw32B+3NsW1JTSffh8322vGBtzpZw/jCDfRp5RgGMX
	 agXh6yChwYHN/MT2addaMAA3e7AuX/vOtQOupCId1PslJQCtyYJAnIkQs7kZsh3z3B
	 YYgCgUI7tQuikFYIuqeTzCMLxjMDtqT3kS6VUVEnPFnq7WfvL+HcPAqQstE5P3pjkW
	 vu5lZLNUn0w+RRvIo0MC2edjHiAp9BdQNniZlG8CHhE+gt738+ySxoNA2Av0gEeEzo
	 i67tqbaJ+BtQA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:05 +0200
Subject: [PATCH net-next 05/12] net: airoha: Generalize
 airoha_ppe2_is_enabled routine
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-5-064855f05923@kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
In-Reply-To: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Rename airoha_ppe2_is_enabled() in airoha_ppe_is_enabled() and
generalize it in order to check if each PPE module is enabled.
Rely on airoha_ppe_is_enabled routine to properly initialize PPE for
AN7583 SoC since AN7583 does not support PPE2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 32 +++++++++++++++++++++-----------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 drivers/net/ethernet/airoha/airoha_ppe.c | 17 ++++++++++-------
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 32015c41b58df68a0fe87bb026ee0a6d44ea6ec9..99e7fea52c6db9c4686fcef368f21e25f21ced58 100644
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
index 303d31e1da4b723023ee0cc1ca5f6038c16966cd..68b0b7ebf0e809bb1905f80ac544fb87027ec62f 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -56,9 +56,12 @@ static int airoha_ppe_get_total_num_stats_entries(struct airoha_ppe *ppe,
 	return 0;
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
@@ -127,7 +130,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 						 AIROHA_MAX_MTU));
 	}
 
-	if (airoha_ppe2_is_enabled(eth)) {
+	if (airoha_ppe_is_enabled(eth, 1)) {
 		sram_num_entries = PPE1_SRAM_NUM_ENTRIES;
 		if (!airoha_ppe_get_num_stats_entries(ppe,
 						      &sram_num_stats_entries))
@@ -525,7 +528,7 @@ static int airoha_ppe_foe_get_flow_stats_index(struct airoha_ppe *ppe,
 		return err;
 
 	*index = hash;
-	if (airoha_ppe2_is_enabled(ppe->eth) &&
+	if (airoha_ppe_is_enabled(ppe->eth, 1) &&
 	    hash >= ppe_num_stats_entries)
 		*index = *index - PPE_STATS_NUM_ENTRIES;
 
@@ -620,7 +623,7 @@ airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
 		u32 val;
 		int i;
 
-		ppe2 = airoha_ppe2_is_enabled(ppe->eth) &&
+		ppe2 = airoha_ppe_is_enabled(ppe->eth, 1) &&
 		       hash >= PPE1_SRAM_NUM_ENTRIES;
 		airoha_fe_wr(ppe->eth, REG_PPE_RAM_CTRL(ppe2),
 			     FIELD_PREP(PPE_SRAM_CTRL_ENTRY_MASK, hash) |
@@ -698,7 +701,7 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 
 	if (hash < PPE_SRAM_NUM_ENTRIES) {
 		dma_addr_t addr = ppe->foe_dma + hash * sizeof(*hwe);
-		bool ppe2 = airoha_ppe2_is_enabled(eth) &&
+		bool ppe2 = airoha_ppe_is_enabled(eth, 1) &&
 			    hash >= PPE1_SRAM_NUM_ENTRIES;
 
 		err = npu->ops.ppe_foe_commit_entry(npu, addr, sizeof(*hwe),
@@ -1292,7 +1295,7 @@ static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe,
 	int i, sram_num_entries = PPE_SRAM_NUM_ENTRIES;
 	struct airoha_foe_entry *hwe = ppe->foe;
 
-	if (airoha_ppe2_is_enabled(ppe->eth))
+	if (airoha_ppe_is_enabled(ppe->eth, 1))
 		sram_num_entries = sram_num_entries / 2;
 
 	for (i = 0; i < sram_num_entries; i++)

-- 
2.51.0


