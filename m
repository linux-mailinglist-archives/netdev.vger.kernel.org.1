Return-Path: <netdev+bounces-226109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD6B9C3EC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B58326F94
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25575287252;
	Wed, 24 Sep 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+A4o40D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EF1EF39F
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748506; cv=none; b=eSl3VLIqc2NTc50gbPBUgFcCffcdPiJ6IKlwQ0sVsZapRQCAkzXbV2kjCiYL+ctRbJPBO6UBhQSyvR+LLA3PbyrDoptnIfRtqBMsxH/tPcMUscFlcrzgl+6zzI3gvtKDT6ldADM0MVjDRwPeAZCuL2HLawaZic+yupzFxOa0lqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748506; c=relaxed/simple;
	bh=C/wfjUCsdiaeeAQq1JlkTgcHiBcnmTP3fACu65+WKFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AbUFhL+NJWy34LUohG6w18M3eKAuD2E2KkBHWrg2ilABxVROMJCyccau9advUFJ67BW8lTatL9N8nJ2fNUz8RkVd7gCV7N9EyrqJPNjwRqYXtfrDzvfMuaj5ummGrjKmuKjryunSzN0GlZA0Pt0QUekgy7UWEx++OcDmx4I5+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+A4o40D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC18C4CEE7;
	Wed, 24 Sep 2025 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758748505;
	bh=C/wfjUCsdiaeeAQq1JlkTgcHiBcnmTP3fACu65+WKFU=;
	h=From:Date:Subject:To:Cc:From;
	b=I+A4o40DPLh/cpYaOKT8T4ZD/DpeVn/rGxCVzSz/W2Hp1FqiCmv2s0AnnyFXEGF5x
	 Vflk0QFRxYyueXTEeHS8CAr9STokDoYDb9t1vYQ0AAGtAl6pFuc+03cmupjgrwE6ho
	 /p8ahHbLhb70/N8uL01dj/6bP+9AFvmykRJ7QVbvuEmIDqSb89WL6qEmrgBxGaYbYS
	 MIRCiVBUGgyELcHYJvu34697Ofu89Qp6fXS6sFFqGWRmBdBrnLpB0p9wx6sV1f/izs
	 +oBO57FNZrtN1Nbn5bCqXILNdV9BryOAfIDa/ZI9Qt7cwHa1h22qpAmnIwBgVSDN37
	 TPpEYYBFZ5uvA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 24 Sep 2025 23:14:53 +0200
Subject: [PATCH net-next] net: airoha: npu: Add a NPU callback to
 initialize flow stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-airoha-npu-init-stats-callback-v1-1-88bdf3c941b2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAExf1GgC/x3NQQqDMBBA0avIrDugMZXEqxQXY5zWoRIlkxZBv
 LvB5dv8f4ByElboqwMS/0VljQXNo4IwU/wwylQMpjbP2huLJGmdCeP2Q4mSUTNlxUDLMlL4Yjs
 Ftq2zXecdlMiW+C37PXgN53kBc0rawHAAAAA=
X-Change-ID: 20250924-airoha-npu-init-stats-callback-3dce43846698
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce a NPU callback to initialize flow stats and remove NPU stats
initialization from airoha_npu_get routine. Add num_stats_entries to
airoha_npu_ppe_stats_setup routine.
This patch makes the code more readable since NPU statistic are now
initialized on demand by the NPU consumer (at the moment NPU statistic
are configured just by the airoha_eth driver).
Moreover this patch allows the NPU consumer (PPE module) to explicitly
enable/disable NPU flow stats.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c  | 24 ++++++------------------
 drivers/net/ethernet/airoha/airoha_ppe.c  | 19 +++++++++++++------
 include/linux/soc/airoha/airoha_offload.h |  7 ++++---
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index e1d131d6115c10b40a56b63427eec59ea587d22a..8c883f2b2d36b74053282bc299f0a0572b2e0e71 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -379,15 +379,13 @@ static int airoha_npu_foe_commit_entry(struct airoha_npu *npu,
 	return err;
 }
 
-static int airoha_npu_stats_setup(struct airoha_npu *npu,
-				  dma_addr_t foe_stats_addr)
+static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
+				      dma_addr_t foe_stats_addr,
+				      u32 num_stats_entries)
 {
-	int err, size = PPE_STATS_NUM_ENTRIES * sizeof(*npu->stats);
+	int err, size = num_stats_entries * sizeof(*npu->stats);
 	struct ppe_mbox_data *ppe_data;
 
-	if (!size) /* flow stats are disabled */
-		return 0;
-
 	ppe_data = kzalloc(sizeof(*ppe_data), GFP_ATOMIC);
 	if (!ppe_data)
 		return -ENOMEM;
@@ -542,7 +540,7 @@ static void airoha_npu_wlan_irq_disable(struct airoha_npu *npu, int q)
 	regmap_clear_bits(npu->regmap, REG_IRQ_RXDONE(q), NPU_IRQ_RX_MASK(q));
 }
 
-struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
+struct airoha_npu *airoha_npu_get(struct device *dev)
 {
 	struct platform_device *pdev;
 	struct device_node *np;
@@ -581,17 +579,6 @@ struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 		goto error_module_put;
 	}
 
-	if (stats_addr) {
-		int err;
-
-		err = airoha_npu_stats_setup(npu, *stats_addr);
-		if (err) {
-			dev_err(dev, "failed to allocate npu stats buffer\n");
-			npu = ERR_PTR(err);
-			goto error_module_put;
-		}
-	}
-
 	return npu;
 
 error_module_put:
@@ -643,6 +630,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->dev = dev;
 	npu->ops.ppe_init = airoha_npu_ppe_init;
 	npu->ops.ppe_deinit = airoha_npu_ppe_deinit;
+	npu->ops.ppe_init_stats = airoha_npu_ppe_stats_setup;
 	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
 	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
 	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 78473527ff508919fa60a464917617cb882aac20..691361b254075555549ee80a4ed358c52e8e00b2 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1243,12 +1243,11 @@ static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe,
 
 static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
 {
-	struct airoha_npu *npu = airoha_npu_get(eth->dev,
-						&eth->ppe->foe_stats_dma);
+	struct airoha_npu *npu = airoha_npu_get(eth->dev);
 
 	if (IS_ERR(npu)) {
 		request_module("airoha-npu");
-		npu = airoha_npu_get(eth->dev, &eth->ppe->foe_stats_dma);
+		npu = airoha_npu_get(eth->dev);
 	}
 
 	return npu;
@@ -1257,6 +1256,7 @@ static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
 static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu = airoha_ppe_npu_get(eth);
+	struct airoha_ppe *ppe = eth->ppe;
 	int err;
 
 	if (IS_ERR(npu))
@@ -1266,12 +1266,19 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (err)
 		goto error_npu_put;
 
-	airoha_ppe_hw_init(eth->ppe);
-	err = airoha_ppe_flush_sram_entries(eth->ppe, npu);
+	if (PPE_STATS_NUM_ENTRIES) {
+		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
+					      PPE_STATS_NUM_ENTRIES);
+		if (err)
+			goto error_npu_put;
+	}
+
+	airoha_ppe_hw_init(ppe);
+	err = airoha_ppe_flush_sram_entries(ppe, npu);
 	if (err)
 		goto error_npu_put;
 
-	airoha_ppe_foe_flow_stats_reset(eth->ppe, npu);
+	airoha_ppe_foe_flow_stats_reset(ppe, npu);
 
 	rcu_assign_pointer(eth->npu, npu);
 	synchronize_rcu();
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 1dc5b4e35ef9eaa1d06072a6b6dad52902468f79..6f66eb339b3fc6e130c24bf04f7daa898314f1e2 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -181,6 +181,8 @@ struct airoha_npu {
 	struct {
 		int (*ppe_init)(struct airoha_npu *npu);
 		int (*ppe_deinit)(struct airoha_npu *npu);
+		int (*ppe_init_stats)(struct airoha_npu *npu,
+				      dma_addr_t addr, u32 num_stats_entries);
 		int (*ppe_flush_sram_entries)(struct airoha_npu *npu,
 					      dma_addr_t foe_addr,
 					      int sram_num_entries);
@@ -206,7 +208,7 @@ struct airoha_npu {
 };
 
 #if (IS_BUILTIN(CONFIG_NET_AIROHA_NPU) || IS_MODULE(CONFIG_NET_AIROHA_NPU))
-struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr);
+struct airoha_npu *airoha_npu_get(struct device *dev);
 void airoha_npu_put(struct airoha_npu *npu);
 
 static inline int airoha_npu_wlan_init_reserved_memory(struct airoha_npu *npu)
@@ -256,8 +258,7 @@ static inline void airoha_npu_wlan_disable_irq(struct airoha_npu *npu, int q)
 	npu->ops.wlan_disable_irq(npu, q);
 }
 #else
-static inline struct airoha_npu *airoha_npu_get(struct device *dev,
-						dma_addr_t *foe_stats_addr)
+static inline struct airoha_npu *airoha_npu_get(struct device *dev)
 {
 	return NULL;
 }

---
base-commit: 5e3fee34f626a8cb8715f5b5409416c481714ebf
change-id: 20250924-airoha-npu-init-stats-callback-3dce43846698

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


