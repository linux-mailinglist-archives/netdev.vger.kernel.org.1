Return-Path: <netdev+bounces-214428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECEB295EF
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF341962D0C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 00:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179EE2192F1;
	Mon, 18 Aug 2025 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gpV1LAPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB09463
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755478238; cv=none; b=jnv61CH+NdvX9gAvWpnGXzIUhjChfDQW5umPXyBoFUuu0NX+PAkmw09Cwmobg9PiT4Pzp7WWbythl9NDx8xmY1SZt+qAWiAWPqeMlPZrRMhCBoEaoGUS+mP1wZLsaFK+wCcxM9t4+5IQWcQfvVsfeZBg8aIPxEHyEQv0Mk+WaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755478238; c=relaxed/simple;
	bh=TlnP9ET5oKtKO4qDphsYF55fSvPeCc/Jpxtjbjndfqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY4mfG7Rbr0BoVhlgXHhs2v0twmIjUC1CJO/IZIe+huEaaCx+NCYbk0ngAea8wm8Rzl4kfFl98hWkzfPj0RurJIHtusn/Xae84uT2SfY3clCDxM6cK1Hsc5700PWOleuD2r929NjL0TLX4VWzIr32tEzrVsOvMth/k75EJQkCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gpV1LAPU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70a9f55ea73so41718596d6.2
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755478235; x=1756083035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYn89AxEgcOC/i1rzCxpgUQQFZpwK8pvUPo/Fek1vXE=;
        b=gpV1LAPU8qdV6r0i8zTNZJWExh8YlBLmX3onaxrwl6hmrhLiMv2EYCs2yoFmtfLqFO
         /nV/nOjJ+YvfbkMhZ5hgH8oXcravIOzclUyPO6YxPhwHL2GDxJgivkbCgIOk8Uu7CYpq
         AOsbRZNWmhbWHj+gt8RVkg5VxK0JFp1ArHPFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755478235; x=1756083035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYn89AxEgcOC/i1rzCxpgUQQFZpwK8pvUPo/Fek1vXE=;
        b=veQ3AFy3NbVpKWL4p1OP0NsM6/nDAGLGtqkvBDztv4ovPegSF1ntQwBzA9I+CBLu61
         BOcC+7tHDpBnBezy63XzjPAr22nMu67STFrJTAO4Du2I4VoJdrlSiMEzdVoM/OA5+TKI
         ooroo8PXdXlM2aQNry4PORM528lAawKZzsFrnnk5WCoTPlwLkhNJZ3/ejS2EyS+OVKbC
         C0OxB+eIYj8sEopcl+GTZP938dE6Fu450guqAz8znew1XS94T1ExqWSgP797a2WUCmqA
         5DJxJ2H8tRxjCH5cK9cg1GOcrWszcHXYef2ivqDnwukNSPwA4J5kiFEy151gH5LQCUkN
         b+Tg==
X-Gm-Message-State: AOJu0Yxi5HFatOAH5vNlkq5AEZXBTJKGWHUI/jwQYQ53BNIOSpSzKRqF
	vhwDzBTBebfGstIB/FOTZ0yLPo1xgrFy7y1Gxt7BhpkCDOiUFFIKGS4o/SSaWvZmjw==
X-Gm-Gg: ASbGncunRK6D0jmwOdBMaojt1TpxAYL59xZPwFXRabYHIyS1L6gfrNGkN0QxGAL08W2
	/tne8areLccC/JR3KmEw4cfueF0vo74ZLKUK91l3MP9PTHUqYHYpzGdhQUo1rjBkHMotRMh3UYQ
	IdBvS9GUs8JsiC4foOgDZrlGhiL9Xozze6cbVDsOIis5ZO5WTgUofb2lZv0WWvUGu3UFGXMvyq2
	V3DWANCReBufR/aTAkD2tJ46VFBg5Cbzwlwv2M67UGAGYXO6LncHkpvYkUc5u0M2HCyFwA9KIPj
	yYQsqf/awmQPh+yMcPNxAmTUCm+Hp9BqEIG3GuMkdfksWNtcTR7vprlhOsiCGTaZ3UrJzn0mVxn
	degzYl40U7nAAONEViv5JSUIExjxsc4tn/nqZL6wbRM624aQDDBPKeg1QUwrgp9rfJygWKPH+nb
	hwbxW+J2C+
X-Google-Smtp-Source: AGHT+IH8fDWnz6fFbj3RcnldVnxbwcB7+Xx6u2guuXu/3qGJuw6K0uI0aYrD9FOjCpmVFM1RgfmcXw==
X-Received: by 2002:ad4:5ba6:0:b0:707:1322:6ae1 with SMTP id 6a1803df08f44-70ba78378eemr126476676d6.0.1755478235358;
        Sun, 17 Aug 2025 17:50:35 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm44987526d6.49.2025.08.17.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:50:34 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>
Subject: [PATCH net-next 2/5] bnxt_en: Refactor bnxt_get_regs()
Date: Sun, 17 Aug 2025 17:49:37 -0700
Message-ID: <20250818004940.5663-3-michael.chan@broadcom.com>
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

Separate the code that sends the FW message to retrieve pcie stats into
a new helper function.  This will be useful when adding the support for
the larger struct pcie_ctx_hw_stats_v2.

Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 43 +++++++++++--------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 68a4ee9f69b1..2eb7c09a116f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2074,6 +2074,25 @@ static int bnxt_get_regs_len(struct net_device *dev)
 	return reg_len;
 }
 
+static void *
+__bnxt_hwrm_pcie_qstats(struct bnxt *bp, struct hwrm_pcie_qstats_input *req)
+{
+	struct pcie_ctx_hw_stats_v2 *hw_pcie_stats;
+	dma_addr_t hw_pcie_stats_addr;
+	int rc;
+
+	hw_pcie_stats = hwrm_req_dma_slice(bp, req, sizeof(*hw_pcie_stats),
+					   &hw_pcie_stats_addr);
+	if (!hw_pcie_stats)
+		return NULL;
+
+	req->pcie_stat_size = cpu_to_le16(sizeof(*hw_pcie_stats));
+	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
+	rc = hwrm_req_send(bp, req);
+
+	return rc ? NULL : hw_pcie_stats;
+}
+
 #define BNXT_PCIE_32B_ENTRY(start, end)			\
 	 { offsetof(struct pcie_ctx_hw_stats, start),	\
 	   offsetof(struct pcie_ctx_hw_stats, end) }
@@ -2088,11 +2107,9 @@ static const struct {
 static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 			  void *_p)
 {
-	struct pcie_ctx_hw_stats *hw_pcie_stats;
 	struct hwrm_pcie_qstats_input *req;
 	struct bnxt *bp = netdev_priv(dev);
-	dma_addr_t hw_pcie_stats_addr;
-	int rc;
+	u8 *src;
 
 	regs->version = 0;
 	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_REG_ACCESS_RESTRICTED))
@@ -2104,24 +2121,14 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	if (hwrm_req_init(bp, req, HWRM_PCIE_QSTATS))
 		return;
 
-	hw_pcie_stats = hwrm_req_dma_slice(bp, req, sizeof(*hw_pcie_stats),
-					   &hw_pcie_stats_addr);
-	if (!hw_pcie_stats) {
-		hwrm_req_drop(bp, req);
-		return;
-	}
-
-	regs->version = 1;
-	hwrm_req_hold(bp, req); /* hold on to slice */
-	req->pcie_stat_size = cpu_to_le16(sizeof(*hw_pcie_stats));
-	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
-	rc = hwrm_req_send(bp, req);
-	if (!rc) {
+	hwrm_req_hold(bp, req);
+	src = __bnxt_hwrm_pcie_qstats(bp, req);
+	if (src) {
 		u8 *dst = (u8 *)(_p + BNXT_PXP_REG_LEN);
-		u8 *src = (u8 *)hw_pcie_stats;
 		int i, j;
 
-		for (i = 0, j = 0; i < sizeof(*hw_pcie_stats); ) {
+		regs->version = 1;
+		for (i = 0, j = 0; i < sizeof(struct pcie_ctx_hw_stats); ) {
 			if (i >= bnxt_pcie_32b_entries[j].start &&
 			    i <= bnxt_pcie_32b_entries[j].end) {
 				u32 *dst32 = (u32 *)(dst + i);
-- 
2.30.1


