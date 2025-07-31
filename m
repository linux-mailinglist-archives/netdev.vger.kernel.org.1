Return-Path: <netdev+bounces-211168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C51BB16F95
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19C7625A06
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDAC2BE035;
	Thu, 31 Jul 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZi6JGbZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4391FC7CB
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957767; cv=none; b=QvufnwnmB/rNi0AwC7Q0EW66JiyHtgAnNsQDAkJ41PZpQpbyY1FKRXyXVL43e8Qi0xwID2OavR8CcYO9rn9tkARH5RA3X5AZIG9KeUrf7zeA4VPaXWrrmYRTtVfaHALo9ac3clhwhyhKVjuyI9yqtqp9xeLT1elnoGURKck3Z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957767; c=relaxed/simple;
	bh=YfUsBUo4ovzeXnKYZGrQHH7bnuk3EN5LYkXrLstAfJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AxdkIKIsgs9+z6EGfuR0VtduQn4Rr1xEKobS5ok9qnctL7BSbaerg+szUq3HoDzt9VSzxJNt91b+f3Y8cV4B2yHrYn3EkpQo+gZwKMmNMva+Gcl6ZNPbpGvM0dCvOxsGI/bLdaCbovVfqxq/fatpHf0uiEdb6tkexApBTd2O7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZi6JGbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49203C4CEEF;
	Thu, 31 Jul 2025 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753957766;
	bh=YfUsBUo4ovzeXnKYZGrQHH7bnuk3EN5LYkXrLstAfJo=;
	h=From:Date:Subject:To:Cc:From;
	b=pZi6JGbZxBuFXF8FG2gBNppKNgyyp9C4ewQvFvHrJYPhIxPkrHkqRYIPRlXWzJMDQ
	 ODbTXPslfRYLVBbL42GfZXWpn8iEvhT2UqQ2JqgMcSwIuDDyyOowwKwBXwauVA5tkn
	 k/0Si4p6+6sbX3+ZsEws7nxovanj8fnCdPqF6evll26KXRee5kewEKuEg5WhhdXi5F
	 5+cYDCAKNL32t+w0/dboTEXSrF45Ih1KxyID8G8bS2Otg5K0QP6uNVhPGUJZV50yI/
	 Ly3rDVYjFPzhzpMIsR0+nBjRoB8RcnjKzJNGvJcRT/SuV4x1n3CC7UXXn0Uj4+TpJ8
	 sX9PpZRYfRwXw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 31 Jul 2025 12:29:08 +0200
Subject: [PATCH net v2] net: airoha: Fix PPE table access in
 airoha_ppe_debugfs_foe_show()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-airoha_ppe_foe_get_entry_locked-v2-1-50efbd8c0fd6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHNFi2gC/42NTQ6CMBQGr0K6tqYtKOjKexjS8PMBL5CWvBIiI
 dzdyglczixmdhHAhCCeyS4YKwXyLoK5JKIZKtdDUhtZGGVuKjeFrIj9UNl5hu08bI/Fwi282ck
 3I1qZK2Soa+BRZCJWZkZHn/PwLiMPFBbP2zlc9c/+31611LK4pwpNnnZpq18j2GG6eu5FeRzHF
 xA3CGXPAAAA
X-Change-ID: 20250728-airoha_ppe_foe_get_entry_locked-70e4ebbee984
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
X-Mailer: b4 0.14.2

In order to avoid any possible race we need to hold the ppe_lock
spinlock accessing the hw PPE table. airoha_ppe_foe_get_entry routine is
always executed holding ppe_lock except in airoha_ppe_debugfs_foe_show
routine. Fix the problem introducing airoha_ppe_foe_get_entry_locked
routine.

Fixes: 3fe15c640f380 ("net: airoha: Introduce PPE debugfs support")
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Use locked postfix for the routine that is running holding the
  ppe_lock spinlock
- Link to v1: https://lore.kernel.org/r/20250728-airoha_ppe_foe_get_entry_locked-v1-1-8630ec73f3d1@kernel.org
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c354d536bc66e97ab853792e4ab4273283d2fb91..47411d2cbd2803c0a448243fb3e92b32d9179bd8 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -508,9 +508,11 @@ static void airoha_ppe_foe_flow_stats_update(struct airoha_ppe *ppe,
 		FIELD_PREP(AIROHA_FOE_IB2_NBQ, nbq);
 }
 
-struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
-						  u32 hash)
+static struct airoha_foe_entry *
+airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
 {
+	lockdep_assert_held(&ppe_lock);
+
 	if (hash < PPE_SRAM_NUM_ENTRIES) {
 		u32 *hwe = ppe->foe + hash * sizeof(struct airoha_foe_entry);
 		struct airoha_eth *eth = ppe->eth;
@@ -537,6 +539,18 @@ struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 	return ppe->foe + hash * sizeof(struct airoha_foe_entry);
 }
 
+struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
+						  u32 hash)
+{
+	struct airoha_foe_entry *hwe;
+
+	spin_lock_bh(&ppe_lock);
+	hwe = airoha_ppe_foe_get_entry_locked(ppe, hash);
+	spin_unlock_bh(&ppe_lock);
+
+	return hwe;
+}
+
 static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
 					 struct airoha_foe_entry *hwe)
 {
@@ -651,7 +665,7 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 	struct airoha_flow_table_entry *f;
 	int type;
 
-	hwe_p = airoha_ppe_foe_get_entry(ppe, hash);
+	hwe_p = airoha_ppe_foe_get_entry_locked(ppe, hash);
 	if (!hwe_p)
 		return -EINVAL;
 
@@ -703,7 +717,7 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 
 	spin_lock_bh(&ppe_lock);
 
-	hwe = airoha_ppe_foe_get_entry(ppe, hash);
+	hwe = airoha_ppe_foe_get_entry_locked(ppe, hash);
 	if (!hwe)
 		goto unlock;
 
@@ -818,7 +832,7 @@ airoha_ppe_foe_flow_l2_entry_update(struct airoha_ppe *ppe,
 		u32 ib1, state;
 		int idle;
 
-		hwe = airoha_ppe_foe_get_entry(ppe, iter->hash);
+		hwe = airoha_ppe_foe_get_entry_locked(ppe, iter->hash);
 		if (!hwe)
 			continue;
 
@@ -855,7 +869,7 @@ static void airoha_ppe_foe_flow_entry_update(struct airoha_ppe *ppe,
 	if (e->hash == 0xffff)
 		goto unlock;
 
-	hwe_p = airoha_ppe_foe_get_entry(ppe, e->hash);
+	hwe_p = airoha_ppe_foe_get_entry_locked(ppe, e->hash);
 	if (!hwe_p)
 		goto unlock;
 

---
base-commit: 759dfc7d04bab1b0b86113f1164dc1fec192b859
change-id: 20250728-airoha_ppe_foe_get_entry_locked-70e4ebbee984

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


