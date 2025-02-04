Return-Path: <netdev+bounces-162322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F8BA268DD
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A8A7A2930
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F982890;
	Tue,  4 Feb 2025 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LWFkKAKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405286325
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630024; cv=none; b=FDATK26dgEHYEfvZlHkXKU2TGdFMRxEqu2OhebeVOJhV41EY1dg2Xy0NaOg1H3YaxGmj4XhZakGCQRlmVwxX5dC+WnHQWLf3MZe7M7UXRoHl8MBunJEHmXaxKCkxlSg+YxSkI7pkEux6pgke2xBp2f11pCAW68OfLaI9jU0iXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630024; c=relaxed/simple;
	bh=3Wv6fRui6JUppkVHVPDhuyoEourXEdFIz2Ar68Mhcgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FltBt+qCIyZdOCv3mTvXe5GCRfrA2mq+wtv/d47iZbVWCatRXYFqnjqJPHWOOo2+HtsXGEDhu3eWSGto0hOtwG937tgS5Y+HSb03a2TrOxFO4zK/9Mn+LalReordlz02YpyEGWfy6nUPGCQzMupxcYqgtnGBp4ZXAsYfkzl8hyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LWFkKAKR; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a3939a758dso1566459fac.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630021; x=1739234821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYbE7VuTl9BMV8ls+ftV23iDp1ujBGiTUNoHs2AfpuI=;
        b=LWFkKAKRaQPvMlEltatdS09YvNO/BJDYrx6zEmAmAWc3bAuM1WBa2FrII5Gz7VIcGC
         CPm8mXWsQGAIRRysDX+IGLDtKiuKIT3a2zt29se+68+ocJFl0lSxPoCyZKIYDbnSE/6A
         CtJzTx2G/AGrPm3zQ0Y3ifOhsHgzD+xn5kXjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630021; x=1739234821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYbE7VuTl9BMV8ls+ftV23iDp1ujBGiTUNoHs2AfpuI=;
        b=FuCNErdnttKF46PungZ2YcuqJ4oEFRxA7PBP3klsaPB8807HSSk76/j3v7J8K+KLIY
         iWMBQWIOzvosjkqGUkk0sIQ7ZNGeGZ5Z2iGdq1Ax+zMFl6IPBBHbwzdWeGXUzyCqZuOA
         CHcfadSgYvZEf4KEUgyFJnSIaymhaz9zFgJTNz8WN9GHxbuMJMaczKQ2ZXEIxGkLRM7F
         2MEc3Nb5vGggn5axMWxepqM7StsVdLOgZCRmG+q27UpdkkOpt1jMRM0GaSFg5I6w8wJF
         9+b03dhS7j/w+nuC2EBJkHGAZ5UguViY314UPJwRYz+L7FUxryJDXI6O014CE0AFVw2v
         3f/Q==
X-Gm-Message-State: AOJu0YxKIfJGkoV1YxWlNOTYicjAZUp2d87KcoEvTCk2h+0rFD6wXxIf
	f2Sv7Vv9K8Ks9xRTv9kJBaxo3wxU+D5CPxFkAqLlDokCRamOTyjcR1I3uvPAzQ==
X-Gm-Gg: ASbGncv8H9P+sfYe86BP4ZVMBNfuHXHXd2VObWU7l66AFAKdLjtrlzSjtB6b/Vmf0yP
	B5RRG07cEaPXlGR31hmSP78ezUN1/hYlAexQaSiQjJYSEsScAoRuXy2oqcnhjglFTXAryveVtst
	B/zyYRhSLIoXwMeUxaU8PdOE51okFcufHHJrJyR34Fc2c5a01GuzY5S60YF9W3s6x3W+diXq4nX
	h2zCb5YjyxO2C5UrJZGNEaG2STfi1EygMISfeaJmI0iOk/0eF5aIfQNrzNmaCe4D/yKp22IE3ua
	JBhrTmOfeBNCqg2JW9ZrfjG9ldOJo7GDR4q6+HMNUmGPtf7r2ibn8bOKoM6wwhWT/Bo=
X-Google-Smtp-Source: AGHT+IFs7Wnm4/yCIWBcp9XvtKd8KRmQT7M2ZZR0ZAzFRjOdhc2hjOEJziq0glsf+Xxh3gYJRQKezQ==
X-Received: by 2002:a05:6870:899c:b0:29e:7dd8:92b1 with SMTP id 586e51a60fabf-2b32f2db995mr13856570fac.24.1738630021344;
        Mon, 03 Feb 2025 16:47:01 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:47:00 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v3 04/10] bnxt_en: Refactor completion ring free routine
Date: Mon,  3 Feb 2025 16:46:03 -0800
Message-ID: <20250204004609.1107078-5-michael.chan@broadcom.com>
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
index 8ab7345acb0a..52d4dc222759 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7405,6 +7405,20 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
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
@@ -7450,17 +7464,9 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
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


