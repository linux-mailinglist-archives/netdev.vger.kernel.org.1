Return-Path: <netdev+bounces-165757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA7A33478
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4F83A8BC9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FF14AD2B;
	Thu, 13 Feb 2025 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NdDUiqIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4714A605
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409222; cv=none; b=YA5IcLvH3JKQjZvajYPNLiHDKlU+m3D2o8fJRvgp1DNInpWFwAFgwFgoFktIt3kqFJhaPyOn8ERPGOwXtAJ3XAaOzN5cWNzAVGzMATG8mRbeppgv6Y3tGd0XUtTwQ4qpUALIcq6mZLYMMz0AEDnP7uw16LBjymftgy/RXenPrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409222; c=relaxed/simple;
	bh=IXKovOctHJnLdiAOUUqeOrUEhuY/G8oC4zb+ENO9NYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnnNUd655fYWpCkbrp93DY5jAK2rqdoNXvSDnAJWf2PbF6EmnXM2WB4VINuEQSak+rTX3CVMoGUHhffOlFobNXXfqFCfAaZEEEtKbR/lHHUGP2icIOTPcBWurP015jWwJQLJf/1+TLXfvoLaRm+LmTh0Mc3QXBKyDNFpPmw8XyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NdDUiqIx; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72700b5056bso75565a34.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409220; x=1740014020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/WGpVdKkhB4PCRJWhKILMrZMw+zO2YjcWfapXVtE7s=;
        b=NdDUiqIxzHXSY9+dsDy7vke7tqbKpr55bGQ80TNF9vsslrnWWbb1PlO+sJCpPj/JXE
         ShBXHPrO2EXjGAPKKq11IicARm8GzToYbbPVfDLQK8xCXKiFbJkMQgUu1HcNzGhZdwdA
         5rV4oyhYdfAc4+tlIy9Ur0Njw0kCXu52xD+0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409220; x=1740014020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/WGpVdKkhB4PCRJWhKILMrZMw+zO2YjcWfapXVtE7s=;
        b=mXm5fPq7ckrWReG09AH6u1E57EtMZ3RS81PbeZyBVLtKsAqLT0WP/Canbp7hp0gw6n
         CGNqGtH3epzNu0CILOYJAKg5qQr7QZeD8tm2ACBmTpsxg22ucd2iIYiTWGU4gmTiw64d
         OaP+iVBaoSeptLz4NMebH8ySC/nDaAlGoUqZdlSxLIlF+jbP9nkvVqntExttUquTZ+a7
         5gWGwG9q4WjXzZmdZCDMlpgTIdbPDhlm9wjOOZTsT+4E48p/h8KOdvZwbAH0/h6mHfcn
         2b6qInVJwtHq3wap16+ysOCbt1JvzgGPcv6JMhibyHHICy7R3NEmAEZxXJAUfkAIuisc
         F5oA==
X-Gm-Message-State: AOJu0Yym5a+HnwMfXSGqf2/46maS22DiaTDKc58V6g+uM8uHc4MgQKf7
	4Z0HFdLYaDx5n/ap8VWawWZL9Ubu3jQoiYoq45OEq6Sg4BVmiNpRn2zb7fvm/g==
X-Gm-Gg: ASbGnctToQFRGH/H/emzRyWP6ssNkuRBlqpTW85CXKlPPSAouwJvMhaXGcBby+17A6A
	NqDeLLGOgo6s1gyeXrxtApxzlgHGnjBXEGroI6+MpTSewCreWMambxVkXE/unqKwkQRBPBeVAAa
	BDHs/Vsoa6lW4yOLqCKgggpCvhXZ1eYcg2n2XtgnPJ8731x8ltJKNeoJLrg5WkE+A2fngT1upoO
	1MSjwexbKV3iGqsU1caz8LCW06wSlK+Uq51coydnLEE8L44nfRMKUP9gYjjnKxQL1vLZ5k3CvhW
	Zn+AXaJ4yTILfLbh/6l763MHWwiEfAAsyFsufKdut4Gu5W0FzY77dM/bTHrso2xIfds=
X-Google-Smtp-Source: AGHT+IEoDImTiKmjDyWclHRHK7JTX+CsMIjl7XEmp8Kyyzz7Va4GUD6fWPwMUwlE6EAC8lh8HwCRzA==
X-Received: by 2002:a9d:6009:0:b0:71d:e923:6d2f with SMTP id 46e09a7af769-726feef7e2cmr679939a34.13.1739409220494;
        Wed, 12 Feb 2025 17:13:40 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:39 -0800 (PST)
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
Subject: [PATCH net-next v5 09/11] bnxt_en: Refactor TX ring free logic
Date: Wed, 12 Feb 2025 17:12:37 -0800
Message-ID: <20250213011240.1640031-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new bnxt_hwrm_tx_ring_free() function to handle freeing a HW
transmit ring.  The new function will also be used in the next patch
to free the TX ring in queue_stop.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 33 +++++++++++++----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 04980718c287..2d0d9ac8e2c4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7368,6 +7368,23 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
+static void bnxt_hwrm_tx_ring_free(struct bnxt *bp,
+				   struct bnxt_tx_ring_info *txr,
+				   bool close_path)
+{
+	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = close_path ? bnxt_cp_ring_for_tx(bp, txr) :
+		       INVALID_HW_RING_ID;
+	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
+				cmpl_ring_id);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
 static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
 				   bool close_path)
@@ -7447,20 +7464,8 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	if (!bp->bnapi)
 		return;
 
-	for (i = 0; i < bp->tx_nr_rings; i++) {
-		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
-		struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
-
-		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
-			u32 cmpl_ring_id = bnxt_cp_ring_for_tx(bp, txr);
-
-			hwrm_ring_free_send_msg(bp, ring,
-						RING_FREE_REQ_RING_TYPE_TX,
-						close_path ? cmpl_ring_id :
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
-		}
-	}
+	for (i = 0; i < bp->tx_nr_rings; i++)
+		bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path);
 
 	bnxt_cancel_dim(bp);
 	for (i = 0; i < bp->rx_nr_rings; i++) {
-- 
2.30.1


