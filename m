Return-Path: <netdev+bounces-214429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD4B295E9
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C6E4E574E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 00:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6154758;
	Mon, 18 Aug 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ShywdiSL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B521B9C0
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755478239; cv=none; b=M8YQ09AatdRAfYMlK8Fn2PBeUVA6ggnBeSDQP7kwMr8nNjYO1Z2iVjw1ywSxwpP1WRMCrAXVYAAapUfqvx0sE0nDLTM4pr/1VA86Kg2SZCuxXAg80QLd1QNJgxg29NKUjbPw3DL9kN4pIbS6O3qAzz5/9/1ieDZcizRIMXEUDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755478239; c=relaxed/simple;
	bh=hmDtnYfC5iSgpaCH1kwhGbZX8SQ83SJhz1n/6Ulkkd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2tinY2VUu4nN9bn8qhJebgJe5lTFZOmcqHj6hcUo5Ywk8BjsrLkBaJH9W+4uS8ot/e2ClHQAAr+qeQrLOK1Ia+0Hh6GhLu2kwO10Qqu11CVJC8NnIwa5KkyC1utUww+x9gzcIur5v3PC+NWVu6eB6UgnSoiptN9erIYRNcww7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ShywdiSL; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a927d4aaaso32384916d6.1
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755478237; x=1756083037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bcjcebf6wKpjZgD4mxqreZIYz3NesKBJfZl4B6a7ubs=;
        b=ShywdiSL4hGxVnRA7V4d60ZoPJICvYyXtQ0JxPTUXpEoVzhR251Lcv0KD51WjzqyHi
         NX/joRSEH121tCYwWSbbJO49/1rwdIPadb0ih46EPzDssVoOG5Cy+Mcx1AaztJlbJUh7
         BywDAVrxAtSdVwCTrXQWcIHoG3LIwgvhE8DOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755478237; x=1756083037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bcjcebf6wKpjZgD4mxqreZIYz3NesKBJfZl4B6a7ubs=;
        b=VAjlTL/11P15WHH/0/ekj8Vf/aOW8wzPwuKUYP325id+WBsXfdhHq/ZZwlK1EpkSM6
         P2+MrHyYVDx0VAzHFy+6RmalOljyDG6uCb9Pzsv5Ypbo7KdIg7V+UrORGPRzst361kbu
         a14QW2WtFfRUe4qCp8VL2u+crbhVKQIXxBjCNSiZFNVyQ98taFH5jPykzc4mx5aC/viN
         K4kC6QKBoD2GXPXU56bWTiQ2lJwC8DLABlY2uSQfYDvw3qXO1miZqgDP3wsvraSIb0Qd
         +luIvYVY+Ke8pKKL7CRFxFR6xSlxKsRYxfVDGkEW2KZThxl9fxncpHxYGniQLnH5MMvK
         rswA==
X-Gm-Message-State: AOJu0YzKiIohr3lBAlD7TXFktR6b5c80EHLzW/tekuOOEcVX39/vwA/h
	7Y2xWGD3PqISdUETPN/Oknp2yd1J8dAyo3swckD37xipFH40gwDVopMM+gfLkTnYRQ==
X-Gm-Gg: ASbGncvaX3b6sT1P6XQuHPN3jfsOtguU8fGZt/R+xrutntyWmsm3cUGHLybkWYuN1j+
	EckV2CZVUX9F4w4zUyAr/pPcfeWphUhC4pQZhqJmIKgrS99QeP/t6uiDuBbovNjljn7u2s0cW5v
	LVboTrN0q/gW+YPf6iaE/pLF7nTGIUFQcVusfsRwZF1OCPjnpiDR/wsNhNfnWbWP8daHlqrbgKa
	Vn4wAtLw6NlLy8szralmonFLxYvxpiRGDUijnLbx2nN5xcbPDKt+afzNsnYkWui5THnUtt7bQG6
	tvFQdLPRiTwcliL2sBvh+kcPiGJy8IfOqEmGxzOHPC6sYi2cQzXWOOsvhDmd09sMroLXugjKAzw
	Sz47D6pJ3TgVNZB7saz68oX+zd5zQCuFi/gh006e2bABPLEXVCzs5l2w63WDi9vRh9+49+VDSm6
	1z6A==
X-Google-Smtp-Source: AGHT+IGVpltE0lmcl1QhANnuQ3pRyplFIkNYyABkUbLbuXozPfoWtf/PH0NxVem48ZMyqAjJMvLxrg==
X-Received: by 2002:a05:6214:3002:b0:709:ee6f:1488 with SMTP id 6a1803df08f44-70ba7a5ec4emr112444856d6.6.1755478237029;
        Sun, 17 Aug 2025 17:50:37 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm44987526d6.49.2025.08.17.17.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:50:36 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 3/5] bnxt_en: Add pcie_stat_len to struct bp
Date: Sun, 17 Aug 2025 17:49:38 -0700
Message-ID: <20250818004940.5663-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818004940.5663-1-michael.chan@broadcom.com>
References: <20250818004940.5663-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

Add this length field to capture the length of the pcie stats structure
supported by the FW.  This length will be determined in
bnxt_ethtool_init().  The minimum of this FW length and the length
known to the driver will determine the actual ethtool -d length.

Suggested-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 37 ++++++++++++++-----
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 40ae34923511..25ca002fc382 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2543,6 +2543,7 @@ struct bnxt {
 	u16			fw_rx_stats_ext_size;
 	u16			fw_tx_stats_ext_size;
 	u16			hw_ring_stats_size;
+	u16			pcie_stat_len;
 	u8			pri2cos_idx[8];
 	u8			pri2cos_valid;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2eb7c09a116f..abb895fb1a9c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2061,17 +2061,11 @@ static void bnxt_get_drvinfo(struct net_device *dev,
 static int bnxt_get_regs_len(struct net_device *dev)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	int reg_len;
 
 	if (!BNXT_PF(bp))
 		return -EOPNOTSUPP;
 
-	reg_len = BNXT_PXP_REG_LEN;
-
-	if (bp->fw_cap & BNXT_FW_CAP_PCIE_STATS_SUPPORTED)
-		reg_len += sizeof(struct pcie_ctx_hw_stats);
-
-	return reg_len;
+	return BNXT_PXP_REG_LEN + bp->pcie_stat_len;
 }
 
 static void *
@@ -2107,6 +2101,7 @@ static const struct {
 static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 			  void *_p)
 {
+	struct hwrm_pcie_qstats_output *resp;
 	struct hwrm_pcie_qstats_input *req;
 	struct bnxt *bp = netdev_priv(dev);
 	u8 *src;
@@ -2121,14 +2116,15 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	if (hwrm_req_init(bp, req, HWRM_PCIE_QSTATS))
 		return;
 
-	hwrm_req_hold(bp, req);
+	resp = hwrm_req_hold(bp, req);
 	src = __bnxt_hwrm_pcie_qstats(bp, req);
 	if (src) {
 		u8 *dst = (u8 *)(_p + BNXT_PXP_REG_LEN);
-		int i, j;
+		int i, j, len;
 
+		len = min(bp->pcie_stat_len, le16_to_cpu(resp->pcie_stat_size));
 		regs->version = 1;
-		for (i = 0, j = 0; i < sizeof(struct pcie_ctx_hw_stats); ) {
+		for (i = 0, j = 0; i < len; ) {
 			if (i >= bnxt_pcie_32b_entries[j].start &&
 			    i <= bnxt_pcie_32b_entries[j].end) {
 				u32 *dst32 = (u32 *)(dst + i);
@@ -5273,6 +5269,26 @@ static int bnxt_get_ts_info(struct net_device *dev,
 	return 0;
 }
 
+static void bnxt_hwrm_pcie_qstats(struct bnxt *bp)
+{
+	struct hwrm_pcie_qstats_output *resp;
+	struct hwrm_pcie_qstats_input *req;
+
+	bp->pcie_stat_len = 0;
+	if (!(bp->fw_cap & BNXT_FW_CAP_PCIE_STATS_SUPPORTED))
+		return;
+
+	if (hwrm_req_init(bp, req, HWRM_PCIE_QSTATS))
+		return;
+
+	resp = hwrm_req_hold(bp, req);
+	if (__bnxt_hwrm_pcie_qstats(bp, req))
+		bp->pcie_stat_len = min_t(u16,
+					  le16_to_cpu(resp->pcie_stat_size),
+					  sizeof(struct pcie_ctx_hw_stats_v2));
+	hwrm_req_drop(bp, req);
+}
+
 void bnxt_ethtool_init(struct bnxt *bp)
 {
 	struct hwrm_selftest_qlist_output *resp;
@@ -5281,6 +5297,7 @@ void bnxt_ethtool_init(struct bnxt *bp)
 	struct net_device *dev = bp->dev;
 	int i, rc;
 
+	bnxt_hwrm_pcie_qstats(bp);
 	if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER))
 		bnxt_get_pkgver(dev);
 
-- 
2.30.1


