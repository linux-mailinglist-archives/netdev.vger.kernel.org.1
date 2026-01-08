Return-Path: <netdev+bounces-248243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A27D059B0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27676306CCF5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5131AF3D;
	Thu,  8 Jan 2026 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nrre1lte"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41531D72D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897375; cv=none; b=XR6a6ts6o8aJOkmmVHxlo/P9xlrkwhRS3pKDz8cZZ5aFQKUHgR3Z5hYTayo9Q9JLUzhpubrphzMS13jtLuHPWyNRZuHgfDsyuzTE3YYRGhvynWoA2ecKmCQkcC0yOvCuDFILARlGyX6A6QRMK7xz6Dh60Xmr3sLCWJwLVNXSFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897375; c=relaxed/simple;
	bh=ul1Ac3V/B60/F2WMkTXYIjv0mwsahIkaQoG0gRQ6OjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3CMEdOJkiJlqDMbkvXX7ymYo8IesaWzRBoJpHV7YRjIRy3qLkO5U1YQtUc3q5FnwAHBMgxhRMjR+uv/3Tz8DJoyOWi5Vhc/yrYK1OliPljK7774H6XTV4g6dKspC6eMrekhCqg8EPS2ZsIGos6ckprDemB+i26bbpCwFwyAC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nrre1lte; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-122008d4054so578556c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897373; x=1768502173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te25MviDlrxzlq2B2duHSN+1gL9C//NivqToMQtg1Ow=;
        b=n9kc4J487ZP3J/jgMKxEMgYzgKQNwyLr+XhAtXpwOF02WogkOvB3KS9kSNrbl3vsQS
         lQWiQonmvu41GJcR23BDguq5GIBegvzykqHPy1oFqRHyKvCpYhVAl5k2L19k0nAvU6G3
         QaRStS89QGeERz9oM7A1bliRoOElv1DtnvxR0QbosaWa2429qbTm1j3mdozdfRfmtP8z
         5L+lWEbQakQMybbj4Gp3w/sdCEJcuj+IHEMmA7Ola8it79njxY1Z3IE6pEUdDz+I1Djt
         Uhf0goalLbGcLwYDqqH8YI4pj8a2trXupm9gRYUtecj7onuNrSfkKHN+4kzx4XoTbii6
         +0Kw==
X-Gm-Message-State: AOJu0YwWguzsDAcMvQJzwwr6G7Hu1neQMXGS3unnR8lbKZ2Ta9t7JcQP
	YAkS4ux2HCG3ylZ+8jK1UnOfrqeIiPaSpoYHzdmcX3vDmA+GwPPqYrfmOJo/4Vt/tUOjd5EUZ17
	LWSQyPhOWMxqf3KOWeItfrqfSqMdxBr2mztSWNT/I/tVz23mu+INTSjZGISkKHP8Ayz/hDEadAf
	VwdYEdljFu6PE75UmA/J9gpx/d5DSPn9yqHi5TtfWWvlpD2TF1m2sR9dZAsooDPB8eV8YGCW48V
	VC90N0CTTM=
X-Gm-Gg: AY/fxX4RsMYAqT6ypghvO9ANJmj2JXXEIhUjvDpezPc39tKcaC4hIi1fNpFjHfF0FCh
	Oy9vRBqOWRZ6gt+xow0MjtuKXKk5s8qbJ8EuIq9rZzwbqBmGxkY7uqprvO2eiSflVYD4taB0eok
	y1rcwRVv8BtJaYVFZd+Hw+SlToZIDcAuR/9eZBW5zNnY49uOPkXaqDVL/4zU6hO9F/DTgsOUiuR
	BMKXeMZT5FN1oyUSHjr55B9ofplW5uXt7t9r84U/9gM0XFEWcaoKgznhxcfLBd/K99hhWr6lKT8
	L+Eig88EgKJhcv3WqyvUss/WPrrvxKiaz8jy6z0708FKD25a80EBswY7VAFyR+NRNHmB1XdvBrT
	JOwQlPBp40APL9Xuavd3gpBdw7jNevxyfyEtIOfidTrZWuKcKguP4z2VuaUE1ca9pAe+EdPCfRJ
	xRA1jneKWFNej8OOFCMlxeh7D20e7jTmXO9Jydt6MwVg==
X-Google-Smtp-Source: AGHT+IHMBiyQFdWK1FHBwO7MjjF5BybPE03WM5ch2ZdyUdbM65Rl7Z8Ky04juZJlYM3euDQp7pzRde8zso+u
X-Received: by 2002:a05:7022:2216:b0:11f:1e5b:2dd6 with SMTP id a92af1059eb24-121f1b4514amr9778622c88.17.1767897372553;
        Thu, 08 Jan 2026 10:36:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f2489521sm1950291c88.3.2026.01.08.10.36.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:36:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a34f64f5eso71370746d6.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767897371; x=1768502171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te25MviDlrxzlq2B2duHSN+1gL9C//NivqToMQtg1Ow=;
        b=Nrre1lte5k9xTrkIp0Qg26ywJmFTNMSU1DasGmagLZ6thDPOpxPno/CgZhip9mxiju
         qd9kUxUlpyjfvupFVSFTVYVMNidXDDC5Oc7Yx0pH1Tc63N+GOLPCoUESwjzbCacZBcpY
         R43FmQULNOCIHo/jvPmudKJMmkByQVFLoCAmA=
X-Received: by 2002:a05:6214:5d8a:b0:890:2504:5450 with SMTP id 6a1803df08f44-89083cbc95amr92416306d6.19.1767897371087;
        Thu, 08 Jan 2026 10:36:11 -0800 (PST)
X-Received: by 2002:a05:6214:5d8a:b0:890:2504:5450 with SMTP id 6a1803df08f44-89083cbc95amr92416026d6.19.1767897370707;
        Thu, 08 Jan 2026 10:36:10 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c2897sm15973721cf.32.2026.01.08.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:36:10 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 5/6] bnxt_en: Use a larger RSS indirection table on P5_PLUS chips
Date: Thu,  8 Jan 2026 10:35:20 -0800
Message-ID: <20260108183521.215610-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260108183521.215610-1-michael.chan@broadcom.com>
References: <20260108183521.215610-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The driver currently uses a chip supported RSS indirection table size
just big enough to cover the number of RX rings.  Each table with 64
entries requires one HW RSS context.  The HW supported table sizes are
64, 128, 256, and 512 entries.  Using the smallest table size can cause
unbalanced RSS packet distributions.  For example, if the number of
rings is 48, the table size using existing logic will be 64.  32 rings
will have a weight of 1 and 16 rings will have a weight of 2 when
set to default even distribution.  This represents a 100% difference in
weights between some of the rings.

Newer FW has increased the RSS indirection table resource.  When the
increased resource is detected, use the largest RSS indirection table
size (512 entries) supported by the chip.  Using the same example
above, the weights of the 48 rings will be either 10 or 11 when set to
default even distribution.  The weight difference is only 10%.

If there are thousands of VFs, there is a possiblity that we may not
be able to allocate this larger RSS indirection table from the FW, so
we add a check to fall back to the legacy scheme.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 ++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9ab9ebd57367..9efdc382ebd7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6558,6 +6558,9 @@ int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (!rx_rings)
 			return 0;
+		if (bp->rss_cap & BNXT_RSS_CAP_LARGE_RSS_CTX)
+			return BNXT_RSS_TABLE_MAX_TBL_P5;
+
 		return bnxt_calc_nr_ring_pages(rx_rings - 1,
 					       BNXT_RSS_TABLE_ENTRIES_P5);
 	}
@@ -8068,6 +8071,11 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	bp->rx_nr_rings = rx_rings;
 	bp->cp_nr_rings = hwr.cp;
 
+	/* Fall back if we cannot reserve enough HW RSS contexts */
+	if ((bp->rss_cap & BNXT_RSS_CAP_LARGE_RSS_CTX) &&
+	    hwr.rss_ctx < bnxt_get_total_rss_ctxs(bp, &hwr))
+		bp->rss_cap &= ~BNXT_RSS_CAP_LARGE_RSS_CTX;
+
 	if (!bnxt_rings_ok(bp, &hwr))
 		return -ENOMEM;
 
@@ -9558,6 +9566,10 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	hw_resc->min_stat_ctxs = le16_to_cpu(resp->min_stat_ctx);
 	hw_resc->max_stat_ctxs = le16_to_cpu(resp->max_stat_ctx);
 
+	if (hw_resc->max_rsscos_ctxs >=
+	    hw_resc->max_vnics * BNXT_LARGE_RSS_TO_VNIC_RATIO)
+		bp->rss_cap |= BNXT_RSS_CAP_LARGE_RSS_CTX;
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		u16 max_msix = le16_to_cpu(resp->max_msix);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2a2d172fa6ed..476c5684a1eb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1369,6 +1369,8 @@ struct bnxt_hw_resc {
 	u32	max_rx_wm_flows;
 };
 
+#define BNXT_LARGE_RSS_TO_VNIC_RATIO	7
+
 #if defined(CONFIG_BNXT_SRIOV)
 struct bnxt_vf_info {
 	u16	fw_fid;
@@ -2412,6 +2414,7 @@ struct bnxt {
 #define BNXT_RSS_CAP_ESP_V6_RSS_CAP		BIT(7)
 #define BNXT_RSS_CAP_MULTI_RSS_CTX		BIT(8)
 #define BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP	BIT(9)
+#define BNXT_RSS_CAP_LARGE_RSS_CTX		BIT(10)
 
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
-- 
2.51.0


