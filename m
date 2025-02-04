Return-Path: <netdev+bounces-162321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D165CA268D6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1731886684
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322678F2D;
	Tue,  4 Feb 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CrWwLPvc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C263595F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630021; cv=none; b=kPRPeKyD4nUIZMJK4p4GVuFfASnVg4VFZAGZsc47WcZ/cBIis0L2Mhh/F9zzgCQzefvIEOqMJIwsSIsQmYdJy54ubtngCGd/0zlsVGw2FKiN5BI47IR9EOULn1uMDXp2EAGHATa+hnhOdC06xjdISidq2Y5DulKJH7orbHYd6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630021; c=relaxed/simple;
	bh=N4tPBq96MNEhuP9E/BsZZBcc9KAk6IUhpymzyYeQMxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJJfagmcnRTsVa2M1gz6t80V5p6WMUhg8VARYnhtTUDUP9pw4Ot4Q/blmFPJlEPC7fM6XrGxITZA6IAt88xIjmcpi2KuY7B5wZe0acJ0ajrMdJZa+vpfspo90Nrlw9LRk0xV0/VCJqcDMsKN8znIV8+UdTnCTMJX9ZAYKrMRmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CrWwLPvc; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e1158fe3eso2796791a34.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630018; x=1739234818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAnNmS1PpxNhoASBZ/NEPmOmzVWH3c4fcg+geDwoOGo=;
        b=CrWwLPvcE7+XDPJU4wQNdbI7E754J/qeTBr8UwOSJTfYKOOFq2PlQ4O2ZLiy8h6lJd
         9CEBwxBR+XQagQV9LnIcsOVO0Gtdi967p6a2/4OQfGGWYAbbePtIUtfxt9gpwhet6eIL
         yim9KVPce35W917iuscW2UxeigwpBvj+tEf5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630018; x=1739234818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAnNmS1PpxNhoASBZ/NEPmOmzVWH3c4fcg+geDwoOGo=;
        b=pfav8CQi6KTBxByEUDvQcck6x4P9FbLpLAUM1oAdN1rRHyQYyZE4fV0TzYYikt31oP
         zovQNQwTZzwLQ5Xveoq3nSwFFusYnct/GqccWhohO9F9h6DAw5oU6IR+mN86SThmmjQf
         ETn/C1b90BjUnZv1VlCsZjnu8R5KpabTid4ira+biEMS5IJHkgHoWzaagGeTlDQdbeTA
         oEz5i2UEwbZipFRgxSysZ0Xkj/sURXDl9KevAxt5GDQxXysD6BjIV8B2wXe2Je0Yn4kU
         ERUqesFXvr/sArAO80+D364YxRENDXtLmKFbVjwdx4ALAC1fwj3yx8ZlPRPV2ZVvTa6f
         TKYQ==
X-Gm-Message-State: AOJu0YzOpHGupAhJSOpmojdUsECO+si8BC7vkB0g5ecwHyprzB1vG4nE
	Qa9kMYds+pzDHzzh6kc9Nj1bBVq9PiOx1dT7K4e3yZb9zSJbOJn/7HQjWa7vbw==
X-Gm-Gg: ASbGncs4zHdjH9nxZJBmj3jF1moD/Y4Zq0GmX+/LFN9skE6oeno2it+dEQ65estgbUj
	f6RASa0W2oSWjD6jqrb5DnCuLGAmEib9bZ1IHAFP0lhFGdIQVgrkHebDdyRedhIx7CQqfcK2Zxn
	0CWvopeFyBaA5JPHP0I1x68M/IPQZAtrFT/xnrRZzU3t4M39+8lwyzbG+/CUI2ZV2eXuMSFkBH/
	foqBpbNrlrOVULZ+CFqd8t7x6+Oz+6XzonpUGv5aN7aS9jbYS/6HK93Lo4UC9o2HY928cSLAv1R
	pDQWrRHetnsfdMtvTU5iRHaUCI9lf3IE+JHHut4PHCBBhnRYL3MuGkYc02NOkEkD9yw=
X-Google-Smtp-Source: AGHT+IHzbVoC66FITBEoH5rqpeQDqv9W1GLcH+LZzTue32V/O/JFE0t2EY07BqGZQfHTk+Su9VEniA==
X-Received: by 2002:a05:6830:9c4:b0:71e:31a:7521 with SMTP id 46e09a7af769-726568ddd6dmr15518865a34.20.1738630018488;
        Mon, 03 Feb 2025 16:46:58 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:46:57 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v3 03/10] bnxt_en: Refactor TX ring allocation logic
Date: Mon,  3 Feb 2025 16:46:02 -0800
Message-ID: <20250204004609.1107078-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>
References: <20250204004609.1107078-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new bnxt_hwrm_tx_ring_alloc() function to handle allocating
a transmit ring.  This will be useful later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Use const for a variable
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0e16ea823fbd..8ab7345acb0a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7218,6 +7218,20 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 	return 0;
 }
 
+static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
+				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
+{
+	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+	const u32 type = HWRM_RING_ALLOC_TX;
+	int rc;
+
+	rc = hwrm_ring_alloc_send_msg(bp, ring, type, tx_idx);
+	if (rc)
+		return rc;
+	bnxt_set_db(bp, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
+	return 0;
+}
+
 static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 {
 	bool agg_rings = !!(bp->flags & BNXT_FLAG_AGG_RINGS);
@@ -7254,23 +7268,17 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		}
 	}
 
-	type = HWRM_RING_ALLOC_TX;
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
-		struct bnxt_ring_struct *ring;
-		u32 map_idx;
 
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
 			if (rc)
 				goto err_out;
 		}
-		ring = &txr->tx_ring_struct;
-		map_idx = i;
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = bnxt_hwrm_tx_ring_alloc(bp, txr, i);
 		if (rc)
 			goto err_out;
-		bnxt_set_db(bp, &txr->tx_db, type, map_idx, ring->fw_ring_id);
 	}
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
-- 
2.30.1


