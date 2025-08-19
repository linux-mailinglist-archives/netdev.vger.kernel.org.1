Return-Path: <netdev+bounces-215015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AEEB2C9E1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB0E728035
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8706327AC4D;
	Tue, 19 Aug 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P2JZ+n+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6D27FD5B
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621603; cv=none; b=HF0AOIiiMuVVInOowAG+hM2HgHwLiSb3GDhdo4D9bQMPOJL0CyKXVuMrBZSRj6WLGp4BGuB5UggU8/zm98KhTzHbTMfvD3e/TkUfhrerYdMpcu12JdRXW0afRzar+TODVXRiPclqxj/Fay8dY5eabLW+4bS68J0VDdOD7iv3oXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621603; c=relaxed/simple;
	bh=hmDtnYfC5iSgpaCH1kwhGbZX8SQ83SJhz1n/6Ulkkd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyWVtWLRcjdtsjuosgzWIibeU8GZWQQHpKPwklumwoJtKiDEQvrmbzP6bGrF7GGZefksKuLjcbQAV/Ot2U1K4r3/zrNMWoxxeHUOopPtJ4yySqLES7/KhTLtbEs03AYcOtdgw+HmGTjRVT3CLWj8U4ldD95iO0sWlawSMSFXKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P2JZ+n+V; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2445826fd9dso64893565ad.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621601; x=1756226401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcjcebf6wKpjZgD4mxqreZIYz3NesKBJfZl4B6a7ubs=;
        b=O+CEhJofhI8agmO1QKxWnT1KFIAnmU+dbX69k1Xqlwfi3/4bUAAv9g27y8ayUbRqnA
         +PCPlj8ujWdQ/8tosJfbPAjpruR0dDvwkX0oQ+nXIQza1F2urFEo0134pMzoldTcGT8l
         qyvJWM6fd2NmR9X7/Faa7tFzn+70Jbc9oXhi6kAfknQGucMEvnIVo7YEvF/a+zVFVORx
         tTS18lo6eXTfGQWM45I56MEBjiRuZVTVqnVEVRLfUAZLUyL1c4St/kE42GqypZXkMW32
         g8E7HaUWusIlhxB5iKFf9CzSumz0uSnsSPPuw+HAUHs8+I/MJn/GB5dlkt7K8/NOhMXp
         0nPg==
X-Gm-Message-State: AOJu0YxlQw9a7EQnK0uBvGrulNgUshXAg6O3U76kF+/Ir0rsd75Tt624
	rElwWzbngw5o2S9iu5AghxfcCgwWV78QvogAxUnJLpV543q96Oo1I1hMEZCl6yjko1LdcQg8mBq
	6WFsvnJdDfAm2/6xwiQylSYB8pQ6Lw68fENFB8B5hDJ4TuAbViPn5KVy7Km3a8+BlQCPp/3zzTt
	rhHezqMtEW5d7QMTkkUJQq3yUkanExCklVnCbJmfrzuR+M9WJqsTTaYbOEYNDaKiHOlVaWpwH3n
	lTFkMf/uj4=
X-Gm-Gg: ASbGncsjCjFPU7KdX0CAL6oJAT2LA7Bc/aWUd/NVuIteXTiINj4svpudgztqvi35dL7
	YOS+GqDApHWXVIhhWWWWRV5/qFIBzMEW8AR7RxCeEJU4b/XFOul78UYltxrgviOowjX2kRnntD8
	0awy5m/gjsi/zMOgyi2NESmvLodLKQtZeYoDw0BJuzFKYSw0PBxJtCIudfNy8X2nlX8YvMkEv8m
	sheWzalPgrzzLnn6pJfL8ZU77cYy6jzSUSpu/S/nunFLefNuVYzm+oEzyA3IPVXz+oJNPLtAc/6
	HoU5l3oKvTn1dYb1AEACkeB0Olo4MauWESL1fGAEiHM5doqoXd7mWAs5OGHdzH1BkvIDjWxT5fy
	ER1BBQEz3Cq18y/dyQzwS6VP9acWyKMMKoSrsR0eHW6HqDzv2sr9wOzeYw71GRlgh2fD/o7VqtM
	ELSw==
X-Google-Smtp-Source: AGHT+IFpresKNgh7PCFrjcc5MHBDVyiDgZxDF9si7q7T3b1MgHsbFJZYis/0abjznXjzvJ5ZZtxkzDuiXQ4w
X-Received: by 2002:a17:903:2389:b0:240:5c38:756b with SMTP id d9443c01a7336-245e030b78bmr35120105ad.14.1755621600855;
        Tue, 19 Aug 2025 09:40:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed491150sm170115ad.58.2025.08.19.09.40.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:40:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b1292b00cfso38715421cf.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755621599; x=1756226399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bcjcebf6wKpjZgD4mxqreZIYz3NesKBJfZl4B6a7ubs=;
        b=P2JZ+n+VckQ0O90cn0ClBEBzf97Wyo9kqxSEhHtQi1UD+OISKNyyhjhBE6+IrA5J9F
         3Fmf17FrrDfHwanEyHiWP5sbAZKBuwtPodw6lVT+SJL0QV2dF8xmLMZZ4kivjrWE3U6I
         4J9Zf/8BP77XSBF3TiGuPtTgcnXyK42fDydgI=
X-Received: by 2002:a05:622a:5585:b0:4b1:dd3:e39a with SMTP id d75a77b69052e-4b286f2b4edmr38199931cf.61.1755621599406;
        Tue, 19 Aug 2025 09:39:59 -0700 (PDT)
X-Received: by 2002:a05:622a:5585:b0:4b1:dd3:e39a with SMTP id d75a77b69052e-4b286f2b4edmr38199611cf.61.1755621598913;
        Tue, 19 Aug 2025 09:39:58 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e19b14dsm791908085a.39.2025.08.19.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:39:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] bnxt_en: Add pcie_stat_len to struct bp
Date: Tue, 19 Aug 2025 09:39:17 -0700
Message-ID: <20250819163919.104075-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250819163919.104075-1-michael.chan@broadcom.com>
References: <20250819163919.104075-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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


