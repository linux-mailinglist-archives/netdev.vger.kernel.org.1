Return-Path: <netdev+bounces-223161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A021FB58148
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF880174231
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AC323027C;
	Mon, 15 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrM5S16k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20022F16E
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951597; cv=none; b=X8OcV2eoSTmdJ3GBVDUlDiy+pNsgW170kVCVchmYCuxMQSS15vzxWuyQjBGK2i3TrnIqruyipTZ+4HQ0aW8btg5fzm1f4gkNJpISIr+AWx6AX1J94DoDSaEip7+DYN04UbVQftxM52elujgLx+EF5sexa+b5e0GANTULIFBTsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951597; c=relaxed/simple;
	bh=2Q/aU1rbzP7aNYiCUB804ZS4adzBL35QahbS9UPimuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayPjhis0+9mJ44Bb4rS0Q4yYBFZociUX3MCCukifbgTzmQKa91DA9WvoMiAZ5YfDwNruYhxNr0j75faRm/ZCjLsGXKbNhiBdOutI/wmt2c8Eg5ZTHB2Rn+lH6b6JibDeym59mFYuhcUBVg3MOpnQ2Ywi8SUoXKT+/k1jpfrzBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrM5S16k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A21AC4CEF7;
	Mon, 15 Sep 2025 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951596;
	bh=2Q/aU1rbzP7aNYiCUB804ZS4adzBL35QahbS9UPimuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrM5S16kPyGOuE6nkxTLj6Gf2XWBF6HhF3MyY366XzUb7c4mciAssmu4PRk6n5YnQ
	 5OntlwaXAHvCRVaCU4Sb6RC91muMygXjNmz/MdeFx9AuEqAmt+G3Zs48gjhE92MXzk
	 +krKfYR4FKCzVBvbvQJyKIzHBKwtuvgcSiCuJjSX9qK3pIg031rdvc39i4Ne6cpGqQ
	 kbF+kJnQ6LzywcGjz3vYLhGSDC6Onz2L8Vdt+2GylzNPK0DjCN/s+46EDYQ8mwm9vs
	 5WcqQ/Yhlm9k/OQ2HkyLZuUFQJ96PGlD/T4IrIqQshdqLrOWh/3JZJXax1WWh4atNR
	 fs6cdA6fQ3TuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/9] eth: fbnic: factor out clearing the action TCAM
Date: Mon, 15 Sep 2025 08:53:06 -0700
Message-ID: <20250915155312.1083292-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915155312.1083292-1-kuba@kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll want to wipe the driver TCAM state after FW crash, to force
a re-programming. Factor out the clearing logic. Remove the micro-
-optimization to skip clearing the BMC entry twice, it doesn't hurt.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c | 36 ++++++++++++---------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 4284b3cb7fcc..d944d0fdd3b7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -1124,13 +1124,25 @@ void fbnic_write_ip_addr(struct fbnic_dev *fbd)
 	}
 }
 
-void fbnic_clear_rules(struct fbnic_dev *fbd)
+static void fbnic_clear_valid_act_tcam(struct fbnic_dev *fbd)
 {
-	u32 dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
-			      FBNIC_RPC_ACT_TBL0_DEST_BMC);
 	int i = FBNIC_RPC_TCAM_ACT_NUM_ENTRIES - 1;
 	struct fbnic_act_tcam *act_tcam;
 
+	/* Work from the bottom up deleting all other rules from hardware */
+	do {
+		act_tcam = &fbd->act_tcam[i];
+
+		if (act_tcam->state != FBNIC_TCAM_S_VALID)
+			continue;
+
+		fbnic_clear_act_tcam(fbd, i);
+		act_tcam->state = FBNIC_TCAM_S_UPDATE;
+	} while (i--);
+}
+
+void fbnic_clear_rules(struct fbnic_dev *fbd)
+{
 	/* Clear MAC rules */
 	fbnic_clear_macda(fbd);
 
@@ -1145,6 +1157,11 @@ void fbnic_clear_rules(struct fbnic_dev *fbd)
 	 * the interface back up.
 	 */
 	if (fbnic_bmc_present(fbd)) {
+		u32 dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
+				      FBNIC_RPC_ACT_TBL0_DEST_BMC);
+		int i = FBNIC_RPC_TCAM_ACT_NUM_ENTRIES - 1;
+		struct fbnic_act_tcam *act_tcam;
+
 		act_tcam = &fbd->act_tcam[i];
 
 		if (act_tcam->state == FBNIC_TCAM_S_VALID &&
@@ -1153,21 +1170,10 @@ void fbnic_clear_rules(struct fbnic_dev *fbd)
 			wr32(fbd, FBNIC_RPC_ACT_TBL1(i), 0);
 
 			act_tcam->state = FBNIC_TCAM_S_UPDATE;
-
-			i--;
 		}
 	}
 
-	/* Work from the bottom up deleting all other rules from hardware */
-	do {
-		act_tcam = &fbd->act_tcam[i];
-
-		if (act_tcam->state != FBNIC_TCAM_S_VALID)
-			continue;
-
-		fbnic_clear_act_tcam(fbd, i);
-		act_tcam->state = FBNIC_TCAM_S_UPDATE;
-	} while (i--);
+	fbnic_clear_valid_act_tcam(fbd);
 }
 
 static void fbnic_delete_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
-- 
2.51.0


