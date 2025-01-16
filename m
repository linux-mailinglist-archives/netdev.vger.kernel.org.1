Return-Path: <netdev+bounces-159022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9365A14234
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD9797A36BB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43122FDF0;
	Thu, 16 Jan 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PHepvNnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BF22CA1C
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055487; cv=none; b=M8pB0i9xh11jq+kWHcXlBWP21ZukGydYvKAalWtUEo8bnbjXtYQhI4a5jkU74QKG9TFa1b7xPiXqKf/tZTAg9FsYGAHyTa9ie+hmPOFJ7fPwyL0q/gMNjF9VpzOtDdo3QdJlwngscjaB1fvoBR9E+VQ8gTIUQS7fwssktFXgbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055487; c=relaxed/simple;
	bh=zwvVimlxSj0lf1E/xv6A7KRpaBcncJxnRjfJ4DaYiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS4MCSqm5M0KadYbetQD2Cisq+FEwgPked5uURlm6Wf1mJ0hZNHnNDMx0PiEDpeLlAlYSiQSpa8N4ZYUVHsG2q6EydOZXxd+uUvbgKaPDfA29hSvu5xnoCjM8vs5bpONf6IQtab0M1kQiWiCR9AnoMrlulaVi2IKAQCIVoDrzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PHepvNnT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso1860777a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055485; x=1737660285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzT7L0pBJwMFpbqS/PGk/DppfYIumlSl7PzO2A3MJaM=;
        b=PHepvNnT4oHgVyhX827gtSt0zAxKWobSe2dmhBXaECxWl+aA4iwzP6Q5IN/u4H5xHr
         A+u06RImnVgd/anYHZc4Q+2VwY6wif0/k4n1fuiBd6nGHw871w9fQDaO4O/RPCMd6sG+
         tf21IeK1YfGpLJCMRNmnYwyYnckNGp9rM/qBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055485; x=1737660285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzT7L0pBJwMFpbqS/PGk/DppfYIumlSl7PzO2A3MJaM=;
        b=IZLA8+rnBpJFf5qGivXU83g54mKBLs2qQ09WWCokylVdgGLCqHCM0i6ifxtcMKl0rt
         uf0oDQBPclX7DCA/d8KhNgScTc3szmw27Ybkm9TMTsiUMtyxjlgwlx6fRVL3tEHyQXIj
         Nki9T/Lkbs8zoYwN50AswqYeRf5cXkAQCO2U8jsndhqWrLuo9mnXKwK+rZyvxZa8aSlN
         +W3crg4YmrodTAcUd8/rOz/eQ50HHdF58tnEx3ftgKutILAglKD5V4cjp1QKQj0UDQ5k
         XW8oU575l+wDSRgaE/Ku1JXysKARAqsotaZw5/OMiKWyKUXCMh0vV8gcuQb1GWV6ZSb7
         DPZQ==
X-Gm-Message-State: AOJu0YwifOcVazFgZTVuWrGl/LBLEmC0K7pcpZOsGaIgPfcFglTFmGI3
	jXPdoc7mkJGwGyZWwSgi6UkHwI+kratlBzkKZJL6XM32CPeWKOALNK7KA3zQ9w==
X-Gm-Gg: ASbGnctMR2SX/QCmNVAY/OYAXTJTGLojKDb8fSmRjcqC9m+9l1RdsNNHhQ3MTxcovRV
	oZ/tA/hxxIEAjTSoFY/gapw/YbebUPVWDEJ3tbD4ym4uenuwPlAF5QUf/7z6KlRyInybNaix8C4
	LEtTSE/kVlhra+Yz+sLRUZEInaSUXxKckahcAlq+pZqxh2p+/afP7eqa3XBRQzWeqEJmEW77giN
	hiLyvDbzWl51kFr4+L1Q46bH6MGt/c+6cSklZO4jLjmEA6mmy9ww264cfESbBhqTGsPS3MS2BP/
	oBw+PIhpYN3mV7O/VPmSl144GT1QRQ/S
X-Google-Smtp-Source: AGHT+IGTgO+GvPJZ8z0dkBKl8qrn+4ET+Wu5VgiUbooSk8gQhQzdvJNPrG8gOPukxKAa6ME5QfteuQ==
X-Received: by 2002:a17:90b:538e:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2f548f580femr48749524a91.29.1737055485495;
        Thu, 16 Jan 2025 11:24:45 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:44 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 04/10] bnxt_en: Refactor completion ring free routine
Date: Thu, 16 Jan 2025 11:23:37 -0800
Message-ID: <20250116192343.34535-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250116192343.34535-1-michael.chan@broadcom.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Add a wrapper routine to free L2 completion rings.  This will be
useful later in the series.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 042d394c8235..c651fe42cd57 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7383,6 +7383,20 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
+static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
+				   struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_ring_struct *ring;
+
+	ring = &cpr->cp_ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
 static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 {
 	u32 type;
@@ -7428,17 +7442,9 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 		struct bnxt_ring_struct *ring;
 		int j;
 
-		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++) {
-			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
+		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++)
+			bnxt_hwrm_cp_ring_free(bp, &cpr->cp_ring_arr[j]);
 
-			ring = &cpr2->cp_ring_struct;
-			if (ring->fw_ring_id == INVALID_HW_RING_ID)
-				continue;
-			hwrm_ring_free_send_msg(bp, ring,
-						RING_FREE_REQ_RING_TYPE_L2_CMPL,
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
-		}
 		ring = &cpr->cp_ring_struct;
 		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
 			hwrm_ring_free_send_msg(bp, ring, type,
-- 
2.30.1


