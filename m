Return-Path: <netdev+bounces-210503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19555B13A25
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A6A1896EC3
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88087262FD3;
	Mon, 28 Jul 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiGFFLRX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8C262FCC
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703908; cv=none; b=OdYoQjE7oLd/b9tcAKKfmHhUoAgYEl50wrB1MxUKprrFX7PxZtO/ROfRE/RagnPx9zsODrUftm53LNyjdHIM3nPd+xSyvhWCFyBbjetQCubhPvSfQuo5TpsVBD98vQX4ow5Td+EukqAF0k5tg+SGuYNkTtR9kZ8U6+gArGOFZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703908; c=relaxed/simple;
	bh=i7aKOq5KQVfB2/q14tophkJxPE1KTHjxLov6PFKAuzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HLG0TsWGkHbaCZnOnqjknj70GgqedDW9dftsb0X5bmRaj3yLSZGbrn1VIYuLWDippUXReE1kk+ewV+YdWdC4RSGpLdm0cMVqz3iqUJ/Yek6e8YONqVa51R5UtyMDBqWp3ZUhI05xeypc//u8FDAV1KrDJLOx2a0hYZi7GNAp1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiGFFLRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D697C4CEF8;
	Mon, 28 Jul 2025 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753703908;
	bh=i7aKOq5KQVfB2/q14tophkJxPE1KTHjxLov6PFKAuzw=;
	h=From:Date:Subject:To:Cc:From;
	b=UiGFFLRXph6DIdO80VKAEFr2r6lwmFgP4INSrr85ATz85g79zqF06Rx5g03sDaGVU
	 L0Sqmb0Na8c0PN/ylDtMv7CEuixYli5AI70nU37zR0mneU4ZoxIvL/KbSddUBvKAo+
	 nECOR9/VZf1Wr77gN7+KYaQxpcHA3vfqVh9MnO6XAMxBnKcb3cLgG9pjtQv3WiWimA
	 NS+vhowSnmqMzmFYkMG4l7ZOcyNthPkXqLJgxaF9ZV7m2b07DezwEJKj52Mdj8BwJR
	 x5jxgsme08NjPMBzs5cuV/muESj8VaPzUoWHnXKtF8hb/LLwJvFN966vXYXNC2U+O9
	 FG2ierM9a/5AQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 28 Jul 2025 13:58:08 +0200
Subject: [PATCH net] net: airoha: Fix PPE table access in
 airoha_ppe_debugfs_foe_show()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-airoha_ppe_foe_get_entry_locked-v1-1-8630ec73f3d1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM9lh2gC/x3NQQqDMBBG4avIrA2kwaL1KkWGqL86VJIwkdIi3
 r2hy2/z3kkZKsjUVycp3pIlhoJbXdG0+bDCyFxMzrq7bV1nvGjcPKcEXiJ4xcEIh355j9MLs2k
 tGowj8OgaKpWkWOTzPzyH6/oBWBGJdXEAAAA=
X-Change-ID: 20250728-airoha_ppe_foe_get_entry_locked-70e4ebbee984
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

In order to avoid any possible race we need to hold the ppe_lock
spinlock accessing the hw PPE table. airoha_ppe_foe_get_entry routine is
always executed holding ppe_lock except in airoha_ppe_debugfs_foe_show
routine. Fix the problem introducing airoha_ppe_foe_get_entry_locked
routine.

Fixes: 3fe15c640f380 ("net: airoha: Introduce PPE debugfs support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h         |  4 ++--
 drivers/net/ethernet/airoha/airoha_ppe.c         | 18 ++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index a970b789cf232c316e5ea27b0146493bf91c3767..cf33d731ad0db43bca8463fde76673b39a4f6796 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -615,8 +615,8 @@ int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
 void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
-struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
-						  u32 hash);
+struct airoha_foe_entry *
+airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash);
 void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
 				    struct airoha_foe_stats64 *stats);
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 0e217acfc5ef748453b020e5713ace1910abc4a8..4dbf2bf187d02e3e8b9d2b966036c3aa58c867b1 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -498,9 +498,11 @@ static void airoha_ppe_foe_flow_stats_update(struct airoha_ppe *ppe,
 		FIELD_PREP(AIROHA_FOE_IB2_NBQ, nbq);
 }
 
-struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
-						  u32 hash)
+static struct airoha_foe_entry *
+airoha_ppe_foe_get_entry(struct airoha_ppe *ppe, u32 hash)
 {
+	lockdep_assert_held(&ppe_lock);
+
 	if (hash < PPE_SRAM_NUM_ENTRIES) {
 		u32 *hwe = ppe->foe + hash * sizeof(struct airoha_foe_entry);
 		struct airoha_eth *eth = ppe->eth;
@@ -527,6 +529,18 @@ struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 	return ppe->foe + hash * sizeof(struct airoha_foe_entry);
 }
 
+struct airoha_foe_entry *
+airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
+{
+	struct airoha_foe_entry *hwe;
+
+	spin_lock_bh(&ppe_lock);
+	hwe = airoha_ppe_foe_get_entry(ppe, hash);
+	spin_unlock_bh(&ppe_lock);
+
+	return hwe;
+}
+
 static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
 					 struct airoha_foe_entry *hwe)
 {
diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
index 05a756233f6a44fa51d1c57dd39d89c8ea488054..992bf2e9598414ee3f1f126be3f451e486b26640 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
@@ -67,7 +67,7 @@ static int airoha_ppe_debugfs_foe_show(struct seq_file *m, void *private,
 		u32 type, state, ib2, data;
 		bool ipv6 = false;
 
-		hwe = airoha_ppe_foe_get_entry(ppe, i);
+		hwe = airoha_ppe_foe_get_entry_locked(ppe, i);
 		if (!hwe)
 			continue;
 

---
base-commit: afd8c2c9e2e29c6c7705635bea2960593976dacc
change-id: 20250728-airoha_ppe_foe_get_entry_locked-70e4ebbee984

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


