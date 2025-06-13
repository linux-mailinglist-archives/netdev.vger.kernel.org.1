Return-Path: <netdev+bounces-197669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F9AD9896
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2387F3BCF38
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005228F53F;
	Fri, 13 Jun 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BHxuyeFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EF28ECF1
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856792; cv=none; b=faBb/CmkdyX2rVSpa5xtX9T9HVgoryTcg9KU0cB0i8HTLsDNtI85HzCKAWafvxX9R+pM1srF7oxt98KJ6pY3galjGT561E1RwL4BIw04A/7y0YypLaPBUC1zhmncYfv+h1fh5CJdLUwmqWhAmmltqhRUJd0zEj7Lzi7iKYgHef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856792; c=relaxed/simple;
	bh=m5oYX3vbTzUQ3Ht6+BVE6GOrth/Ag+qECMeBixWesgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWcRs2F9sJ74Kd1mHYf/jsUZ7WCQKp5Y7H+Hx9NzXpSF7oa+Lovz2VqNq2OxJ2dhNW055mwzZleO/xTijIc2ettAXt6UCSYugsWtxcczeghtXYzBcebIPitmYeprsOxOePpZLEA/giAufnFUYozlKwEIsOlyDeuSrC/ggq93Dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BHxuyeFP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso431351a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749856790; x=1750461590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVJFf6Tk8f/73lfuF7ShZFKGZgbpogEA9SEqPZaBvXY=;
        b=BHxuyeFP+dn2ZsZak4s3MZ/qcLCYIzJm2oLvClCl7VD/TtVoV6MumUek+uI916Bnkl
         Oo1LMnOumcB2GQHm79qftDQANF/G26GRM2v8JCilTvRaLWgnueenyBR/lj3r6aEf8dVL
         V+x/prr7lVk46pIssarjx2jkXMt1Odn1Kiwps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749856790; x=1750461590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVJFf6Tk8f/73lfuF7ShZFKGZgbpogEA9SEqPZaBvXY=;
        b=Xz7qmKnCNnyFlooeBxyU7qbabJwn0bUWIoXxUrfvSR+oQ9e8FWx9In4cC5uJdKAbjX
         k3VTbatcKWTtE+/GSgP7uLWYMA3vmvZCRZouyISqjAJDWnd7rYohNV+MATd2tnujrTJK
         xtpgkXolR7EhDMod65eLtPr6pdfL/JDnP9sOiwMAuIoUv+hl77/e5KRxgLY4ShLvj2oV
         Vdn848XRn1PTcU/L7XTGfxIb9OME2gG1Nx0pBefoGY+MwqIDxrBAue1cyVbjFMGY3X/p
         1nbAeSLYKnG6FyubwV7dTQms79UOP+XEu0XqWUAt9WUFc9AMQyDZG1PdtBAoRiwua7oI
         /BGA==
X-Gm-Message-State: AOJu0Yxc8g2yuySLmMZDnh/FKWL8uGbrkz+IQSiGYHF0D6Q2UD3jJHcA
	+o/XL+eEdcNNNO8chrjzEj7AIU43YZ1ruxiWOYg7dzrDxQCQwrze3FGA7Xoa166Yeg==
X-Gm-Gg: ASbGncuNa7okfzdvSPOPCCswdZKnDFcDluoy4unlPy1OtDpca78g6xhqYy/uFREP7wT
	4GiwlgCWi5ZLjZ2SFwa4OwZ50Q3hZAQy1Oc0Ut4/adKVpCfFFBYDIVqCq+wE2pSNFYphfUCjKoe
	JVZOvgIXaMVTGEYUlQd+EhG30QvmB3O5rczPS3OB4yc9cZydGp1mC1GtRJazkCWghLmsXPWE2Lv
	d3XsCDF3rV3ozJx78uWsiGPRpPfvl+J6i9NhK5ifnSNM6D0BPf2FKyWpelGdKiNeBEX8voiM992
	0CzTOyyROuEI97lf1SfNYL1lxrjCsdfGvla5MeSDIgwv9iFOrlj3e3zi+HTgOS1UwA8Bv9WtdQ6
	bnE6G4DCg19uB2zW5ZH9ZMh7sAZqZx3KJeI96Gw==
X-Google-Smtp-Source: AGHT+IE3HhRcNUnxLm4J28IeCCXBvkSftDPILp/8HnVRr08qGmKxJylGGUHD+2tuWvs352bgH1uaIg==
X-Received: by 2002:a17:90a:dfc4:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-313f1c0bcbbmr2264196a91.11.1749856789699;
        Fri, 13 Jun 2025 16:19:49 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7832asm20165105ad.140.2025.06.13.16.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:19:49 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts on queue reset
Date: Fri, 13 Jun 2025 16:18:41 -0700
Message-ID: <20250613231841.377988-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250613231841.377988-1-michael.chan@broadcom.com>
References: <20250613231841.377988-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

The commit under the Fixes tag below which updates the VNICs' RSS
and MRU during .ndo_queue_start(), needs to be extended to cover any
non-default RSS contexts which have their own VNICs.  Without this
step, packets that are destined to a non-default RSS context may be
dropped after .ndo_queue_start().

We further optimize this scheme by updating the VNIC only if the
RX ring being restarted is in the RSS table of the VNIC.  Updating
the VNIC (in particular setting the MRU to 0) will momentarily stop
all traffic to all rings in the RSS table.  Any VNIC that has the
RX ring excluded from the RSS table can skip this step and avoid the
traffic disruption.

Note that this scheme is just an improvement.  A VNIC with multiple
rings in the RSS table will still see traffic disruptions to all rings
in the RSS table when one of the rings is being restarted.  We are
working on a FW scheme that will improve upon this further.

Fixes: 5ac066b7b062 ("bnxt_en: Fix queue start to update vnic RSS table")
Reported-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

v2: Reduce scope of traffic disruptions.

v1: https://lore.kernel.org/netdev/20250519204130.3097027-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 56 +++++++++++++++++++++--
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index dfd2366d4c8c..2cb3185c442c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10780,11 +10780,39 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	bp->num_rss_ctx--;
 }
 
+static bool bnxt_vnic_has_rx_ring(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+				  int rxr_id)
+{
+	u16 tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
+	int i, vnic_rx;
+
+	/* Ntuple VNIC always has all the rx rings. Any change of ring id
+	 * must be updated because a future filter may use it.
+	 */
+	if (vnic->flags & BNXT_VNIC_NTUPLE_FLAG)
+		return true;
+
+	for (i = 0; i < tbl_size; i++) {
+		if (vnic->flags & BNXT_VNIC_RSSCTX_FLAG)
+			vnic_rx = ethtool_rxfh_context_indir(vnic->rss_ctx)[i];
+		else
+			vnic_rx = bp->rss_indir_tbl[i];
+
+		if (rxr_id == vnic_rx)
+			return true;
+	}
+
+	return false;
+}
+
 static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
-				u16 mru)
+				u16 mru, int rxr_id)
 {
 	int rc;
 
+	if (!bnxt_vnic_has_rx_ring(bp, vnic, rxr_id))
+		return 0;
+
 	if (mru) {
 		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
 		if (rc) {
@@ -10800,6 +10828,24 @@ static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 	return 0;
 }
 
+static int bnxt_set_rss_ctx_vnic_mru(struct bnxt *bp, u16 mru, int rxr_id)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+	int rc;
+
+	xa_for_each(&bp->dev->ethtool->rss_ctx, context, ctx) {
+		struct bnxt_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
+		struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+
+		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru, rxr_id);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 {
 	bool set_tpa = !!(bp->flags & BNXT_FLAG_TPA);
@@ -16002,12 +16048,11 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
-		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru);
+		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru, idx);
 		if (rc)
 			return rc;
 	}
-
-	return 0;
+	return bnxt_set_rss_ctx_vnic_mru(bp, mru, idx);
 
 err_reset:
 	netdev_err(bp->dev, "Unexpected HWRM error during queue start rc: %d\n",
@@ -16030,8 +16075,9 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
-		bnxt_set_vnic_mru_p5(bp, vnic, 0);
+		bnxt_set_vnic_mru_p5(bp, vnic, 0, idx);
 	}
+	bnxt_set_rss_ctx_vnic_mru(bp, 0, idx);
 	/* Make sure NAPI sees that the VNIC is disabled */
 	synchronize_net();
 	rxr = &bp->rx_ring[idx];
-- 
2.30.1


