Return-Path: <netdev+bounces-223769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED7B7CCF5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AAD3BE623
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC722EF65F;
	Tue, 16 Sep 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv6gHLXd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3F2EE272
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064492; cv=none; b=OEcyGJgJ7hm09zH7OCpxqYrU9pz6MdAfJlod5h2D2HdjIW37MlozlJ/upiritbXkvA/oOJ1CqlFdSuC+z3oo46/TZfX1Pf2KvICfrNufcQiUgc/iq0XaBK/yL5P8C6W9l3LBJd2V0+GIdQHAvMS871Y3bS+JwBXrnspH9eaB1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064492; c=relaxed/simple;
	bh=WRAcoSF4c5EY+6aHAdxSvxV0Fokp/QgLcDUL+UkhxE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiROfENwdorOXL4iYwRGZqYTTmSCP7bVOpBzkdhcD//Q/3+HmaB+8sHCtpvKyC5b3uNYSx2zBkwbpXsolfKhoeoBCatKHwK5YlVHnJZ4Lw84IV1cvDQMAusXzKC/bVbb8k3lcTPmJ2P9rw0mRuaD7E0o7BfsUv9q5XSmOcw31TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv6gHLXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92393C4CEFA;
	Tue, 16 Sep 2025 23:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064492;
	bh=WRAcoSF4c5EY+6aHAdxSvxV0Fokp/QgLcDUL+UkhxE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sv6gHLXdAnTCbriPIOTYUfvlA+hJcRkvAI+jLJgatVMuXC+EsJZKT4PaJ+AtscIPR
	 unWMHoo8RXpcca2HZJcRhDZmdJwVxn6F2Y8lelYGF7ijZdASGTuGjEzlgj+1biXUyB
	 +R7jrnmTt9eiTNwQo/SXDZzsOL4+vUe95yBmQGvMNJjxzA6Htw76fLtYDeC0YIDzek
	 B66zaKYYhRgLGHbpwH1Zlv9bzSI/gVIQlMSPcPOsIYjKp08MRC6ulZm6gAma1CSeYj
	 WXq3mYfACqaKOAWEnSLBIr71mb9h6sWvXp3mB8Yvdxlo9h9HiFOx0TiCI6ttxi5cRe
	 3BCYBT326OgxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	lee@trager.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 3/9] eth: fbnic: factor out clearing the action TCAM
Date: Tue, 16 Sep 2025 16:14:14 -0700
Message-ID: <20250916231420.1693955-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916231420.1693955-1-kuba@kernel.org>
References: <20250916231420.1693955-1-kuba@kernel.org>
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

Reviewed-by: Simon Horman <horms@kernel.org>
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


