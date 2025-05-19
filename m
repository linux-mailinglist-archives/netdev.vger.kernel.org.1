Return-Path: <netdev+bounces-191637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC8ABC894
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5DE4A30A1
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D221ABA3;
	Mon, 19 May 2025 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NYqHZwZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD6219A8A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687413; cv=none; b=KoHc/xWKCyUItJ9wSBwA/mkBnDEyGaB2Nqzb21qowGFI9pqg9Fw8JNzPI0+obTUvD5EscVj2FlsE1fwHyAXgW9jtUZh0dv2zWBmcGEc3nghgwbKr/o6pA6yenxQCjKkDITQUGiNC+DfEJn8GoOIb8+/DE6vttEyqN14GGbJNZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687413; c=relaxed/simple;
	bh=R99D+TjDvvaElkVY18PciuXnCUkWo01iD6uhTNkwwpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX7EZoqcnY5SNiSQS2AEwGGbdsBQwkImwYgXrGWU9Af68KmyZwrO9u4rJLLodbcvm7bPGKKjjDBD7M83AmOeQFBNxzow4gM944Va/5/zOzBq5YY6kK6zPJEATBICGmlRc3V1WUjslk4Bi9g7kJ22jvuYDJUvAqhyi7jh2eKjMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NYqHZwZ/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231fc83a33aso23940235ad.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747687410; x=1748292210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8jvEYYdra86ICXXvCsyRdo8WF9hSbvzHFjw4OUL5Z0=;
        b=NYqHZwZ/VCsW4CCnbcQ0NShCY6QPVid/qfFCotarM9PRbRzTeh2aFyyWx2EL5GEdBz
         c31xVf655IbnVtfFn7VkkQwCKwLFb1Q2gVj8fmgX9JXdxSyY7cZkmVwTcBx4erhVaMR/
         FmzWa6b43bGpyk1oxuFxfVh9aDQYy1OGMa/2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687410; x=1748292210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8jvEYYdra86ICXXvCsyRdo8WF9hSbvzHFjw4OUL5Z0=;
        b=BE/t+QHyR9MMENt7WjSqB3J8jnvcDWFZEpoEe0HOc5Ts6ehUfv9U6+mJAegerQxy0M
         2RRTCO4Z51wCUCXQWAhD/fL21dtpGdOpqMXgnGfg8yz2/SbpfRhQfnv9bycl58RwlaW+
         wb9L41KE5JuggB5/GXTneiBNhlk1fU+XfDnrfFi9tU+8g7V9dmQIvMKOi0lNeTrEpvBJ
         n4r0Hl2W174V6JA6e3zepilJMSj1s8LIHp4FPG4uL/ZIjkbtFDKXVpkN0GsG6mPigZ+U
         6ulQxKJ10sIZ+5PLfeI61vuCfwJrEFNKl+9k8JPKJo/GQUcylNNeufK8J+M1KyQJliH2
         x5zA==
X-Gm-Message-State: AOJu0YyPvCntRkfnX5rJqcxrloEL8fsIUtUovPWD0yNsxfzcE2kLrRm8
	Rz9QIgqhFJd4GC6RO6KDYSC+34NjpYov5uLI9PDyTsUs3rDeu0c/aY8UJ9Nol+qbFA==
X-Gm-Gg: ASbGncstTmFCYwBjJiRe0K6v63usm3NiQcBVE9+shRC1R0zQegAXRUr+X0hRcDIDnk2
	pDFrqIh44z6X0HQ52LFa0usLTFYqQG8s48yV0cE4HxsdylHAbrPnz8PzagwcO9mE5q5V0tNrm9h
	VKVyBT14yfUVyhJriTHgh8cjZaxBeY1xhG2uGCp57ScCbla2tuSttSFpzW4qA/eE0aS6/ymzolv
	8vlkLLMJkAzLpHs1Fy+bRfynI74OL1rOSsUDpDW7QRVJ24tZUzhlWdUcra20mCguXPFczvWpdtw
	Lvs+jrlIghGVoIH6nY6W2PlFX9sIgdKfuA8vEapjJ66D7JRYOLrZ1rjieJjs8/zwiMRC/AF5zGU
	PiA6rfG2P7pG7HWr9xBB4a1QtAbg=
X-Google-Smtp-Source: AGHT+IEh6KswOqcEonXce0xGSuAIEwsM9Gc8zH6pNliPTxDDCLzjuKQdysXI8ID5hcX2xZVXjhG6eA==
X-Received: by 2002:a17:903:2301:b0:231:d160:adec with SMTP id d9443c01a7336-231de351d48mr193443145ad.11.1747687410318;
        Mon, 19 May 2025 13:43:30 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe887sm64190955ad.88.2025.05.19.13.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:43:29 -0700 (PDT)
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
Date: Mon, 19 May 2025 13:41:30 -0700
Message-ID: <20250519204130.3097027-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250519204130.3097027-1-michael.chan@broadcom.com>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
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

Fixes: 5ac066b7b062 ("bnxt_en: Fix queue start to update vnic RSS table")
Reported-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 27 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a45c5ce81111..71e428710a26 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10758,6 +10758,24 @@ static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 	return 0;
 }
 
+static int bnxt_set_rss_ctx_vnic_mru(struct bnxt *bp, u16 mru)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+	int rc;
+
+	xa_for_each(&bp->dev->ethtool->rss_ctx, context, ctx) {
+		struct bnxt_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
+		struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+
+		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru);
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
@@ -15904,6 +15922,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_vnic_info *vnic;
 	struct bnxt_napi *bnapi;
 	int i, rc;
+	u16 mru;
 
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
@@ -15953,16 +15972,15 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
+	mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
-		rc = bnxt_set_vnic_mru_p5(bp, vnic,
-					  bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
+		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru);
 		if (rc)
 			return rc;
 	}
-
-	return 0;
+	return bnxt_set_rss_ctx_vnic_mru(bp, mru);
 
 err_reset:
 	netdev_err(bp->dev, "Unexpected HWRM error during queue start rc: %d\n",
@@ -15987,6 +16005,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 
 		bnxt_set_vnic_mru_p5(bp, vnic, 0);
 	}
+	bnxt_set_rss_ctx_vnic_mru(bp, 0);
 	/* Make sure NAPI sees that the VNIC is disabled */
 	synchronize_net();
 	rxr = &bp->rx_ring[idx];
-- 
2.30.1


