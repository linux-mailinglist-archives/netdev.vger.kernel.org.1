Return-Path: <netdev+bounces-215014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8665DB2C9E8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1014163BC3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE827F4C7;
	Tue, 19 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZjSqN/nP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE927AC4D
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621601; cv=none; b=pCsZJMtFCnHTR/7ZGSe0jH3Y/I0Od9CUIXAAl7211i4JJYLVRvj0C4i+Ix2mNL23LB7dK5CqQOIW1oUYX6JS5+Iq6Fr7uWPpi+RQidFpd3x0PnkG2+hyOWG3yZNZsA+4d9wI+xJtQ0NjqCIQfG4NuspU7iJGnlscmcotjq2kZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621601; c=relaxed/simple;
	bh=JEnSesI1ZmjzewiCutGoXxGpJxUCwI6q21pbettn7To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtSlwqhfqG44inyJyEUTYcmNodiVAXeR34lPuMF/NwJgO0zp7V/4R1TJXf2kaVrlFSQ6jmb0MkY4WnOH7mjf94IYsX0Ju2bNyLyTuJpKil2aqqIpfp1B0jLxNdoTtYJmAyAiV+/Wk1hNOTAg5Pa6x7edmqhrmFpAxLlFynv2HLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZjSqN/nP; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-71d60504db9so45567927b3.2
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621599; x=1756226399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUYeyDPNEToZZOTsiS/IvJ9vCF5TpeKFPAnteO+zoZo=;
        b=ozQPOalHigw1mhhCnyU3CDdvJTytZ9m/N7rGySEZgZg1GfrvMjzpQejwoS9TSiWmog
         kTjIWEUxoIA/feNWHb7hpPc6LrJLFvhRy5pPYa0aNlaDXInmJZ5dmIhbqKzsbZ/9NTjS
         GzUQP3BvABLF7vzUl6Sm3/cyVZYUH6qFQudMSOHi/i/oxbl1Q9H/+FNCQbn7g9tU9LjN
         jC1GCH86rCWHhTbXlAoFC+dJGe1iwEZ7/cayrNRMMK8780W+HyxVxF4XiK10ukSIbtvH
         KRdpWP8/1gYp/cr4M/GllnpACKMWuDBN4I9+noqTbRFm2n+pgjbhifyznvmgiSW3EM68
         4fvw==
X-Gm-Message-State: AOJu0YyU2EvXYf8jEAcs5GVij6Bj40CFe5ic1b91n0rv4CSb2jMwAz1W
	lUWX+bg0tzkKIRGwg97Ei3Sav6BWPbQ/QNW+hpyseAcM3YEwkdpHTqHzjfCT+PNt09AvgmiN4hW
	n2oJ/xl0P2Y/nnxpgbA9cQMyczoDfCP1x6RTczp4JHb+D9OwW9fYhfK3HFae4cIbFNhNKLPF95O
	Eb86G003I5NmnJQ3fcioEWizEZ3Tp+qVXeF0N8F7W7yoWYPueYLago3FiM/DUXJpNaSw7lE5ksL
	6AwIfhP9gE=
X-Gm-Gg: ASbGncuc1RJhyWXG+quMD0pxmG1gqglNNIp2nBnkWYkFSp4kKMu0aMSDy+ZxCdxXukj
	q5gaU9uGpb4wgn7AgW3vu5PvAU2aCWHp+sXVYVQJqJc1O7OmXRSBa/FYiRjYS/6gAVS4OGFkzn/
	NSGhL3vm5fPmq84Fyr03QiIvd6PwoPY2YiZHMc5F2+yI/QJLIHpseCGgTjAqtnQwIJ759gG+t/R
	3ADRR8vDjp83+MZBUn7Pg/NXdR9PMsz2HkXHvPCxUIK2XkMnWdtU10L5YHlhn82/bGVzNfM5Ypu
	DDNG5sdmtDZ1WnAozL2+1jdyVxVX7OnAJ7otBVZv8OmJfFNVqQgUhHbo2r/BR4dcH8n+gihYunu
	T4LZaphkamdinCxglTMYsxCXf0svyu3yQDsRZD+89OkiGL6hZW1Tvfxj6+b2MIvC4IQmbbmVH4Q
	GbJQ==
X-Google-Smtp-Source: AGHT+IFEIPpCH0ZRaQH4Z7wD2gc3PxEyzq5IUrAH1JNlx8Uxbc0gHQyn2mO8ZzCET9s8kWB1sNqP8btruR/x
X-Received: by 2002:a05:690c:260a:b0:71f:9a36:d341 with SMTP id 00721157ae682-71f9d7a0fc2mr32730927b3.51.1755621598983;
        Tue, 19 Aug 2025 09:39:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71e6f848837sm8981907b3.31.2025.08.19.09.39.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:39:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870324a51so1659175485a.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755621597; x=1756226397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUYeyDPNEToZZOTsiS/IvJ9vCF5TpeKFPAnteO+zoZo=;
        b=ZjSqN/nPu20hDSiQu2wa9BBIqKuUYpHPL2uALEVd0K42eD7wMqBgGZgoWrKukwlLrw
         3Rs7pTe0FvWhTjE+CcLfcDv+VSk9Y6Wwte4mfyikiRU/WSVCkTyrSXz1GppmSMSEGEs/
         GaNl3emjlt/rybRYsZEkpjuydpqbzTlsIV4p4=
X-Received: by 2002:a05:620a:470e:b0:7e9:f820:2b8e with SMTP id af79cd13be357-7e9f8205e59mr226724585a.79.1755621597311;
        Tue, 19 Aug 2025 09:39:57 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:7e9:f820:2b8e with SMTP id af79cd13be357-7e9f8205e59mr226720785a.79.1755621596671;
        Tue, 19 Aug 2025 09:39:56 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e19b14dsm791908085a.39.2025.08.19.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:39:55 -0700 (PDT)
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 2/5] bnxt_en: Refactor bnxt_get_regs()
Date: Tue, 19 Aug 2025 09:39:16 -0700
Message-ID: <20250819163919.104075-3-michael.chan@broadcom.com>
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

Separate the code that sends the FW message to retrieve pcie stats into
a new helper function.  The caller of the helper will call hwrm_req_hold()
beforehand and so the caller will call hwrm_req_drop() in all cases
afterwards.  This helper will be useful when adding the support for the
larger struct pcie_ctx_hw_stats_v2.

Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Update Changelog

v1: https://lore.kernel.org/netdev/20250818004940.5663-3-michael.chan@broadcom.com/

Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
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


