Return-Path: <netdev+bounces-222707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF8B5577E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37016567660
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2A2C15A9;
	Fri, 12 Sep 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il4SPeqr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC52C11E8
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708080; cv=none; b=RmdxvL8JA5QHFumtE50clfxtVNzm6dgOla8GilssN5LGEjGdMTFWKisl9CQrMI+Vioyqm3Cv+k/UdbjxNKKZS+MOZpDivHbwTiWFnXs6F+YjEtrp+fid5AbQSyEDGJtgktrP8B+aftqILCGlF3jmTt6te08bSLNlhBkhnR7mpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708080; c=relaxed/simple;
	bh=2Q/aU1rbzP7aNYiCUB804ZS4adzBL35QahbS9UPimuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrGsk8ae2ijFynORLEfbgDaKQCC+DgmCLygHMaiLTphCnkBuzadDe5Zz5cb72w0unkytK4Lpbo32F51HgxzdkrHNJV0iFblkWfuiCnAO3sVTkekdrkmqtSkGpkL1EOfTKK4lsVCy6N21I8smr50oLivMGKDOf5YopDsG2ZajAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il4SPeqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE332C4CEFC;
	Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708080;
	bh=2Q/aU1rbzP7aNYiCUB804ZS4adzBL35QahbS9UPimuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Il4SPeqraXfZyKUh1SSA0xWthuUZJj72S9o5E3L/gqyH2nJKSpsqO52oeAWWfF+kf
	 GBqhasogW2RSu4og8DMkRbFzK9CVddZq5UP6DtaFj76JRuYLAo1zFD9RnVqUsGvWph
	 gF+HZc7q94sDJzWqhHoorbtnlxG/J84LiDwDScBRpDcHXTs9sUf5irIRgiliIufkLE
	 JkHOcKcP5mezQxSEV1NigGb6oyROBN9Fu6kP3kgKHETq4VRjo4q80wgVZus1q68js8
	 sgSELpPCu36+snWP2M3+4D/EYViyICiORtxa6lKLyTyiwBsyhPzIP/Ebp28Ua3JZjv
	 BdjsvGsEW2MlA==
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
Subject: [PATCH net-next 3/9] eth: fbnic: factor out clearing the action TCAM
Date: Fri, 12 Sep 2025 13:14:22 -0700
Message-ID: <20250912201428.566190-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912201428.566190-1-kuba@kernel.org>
References: <20250912201428.566190-1-kuba@kernel.org>
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


