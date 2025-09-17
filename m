Return-Path: <netdev+bounces-223849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30590B7DDA8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24963A30CF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CA0302CB6;
	Wed, 17 Sep 2025 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E1Y3kMPa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24722F90D5
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082174; cv=none; b=Jdl5S4L4S20BYZGxhUtHya0AO27Ttj3lnhSHFKhCYmBh4GVYsHuBV1+HMkEGJL78G0YDYcZTqXTOQP+6/CaLf6klgwqq7u4aObK9Yd+mc87rjr24bs2Mav89/bITBp45azjwMFrv0ObpQwPdGals0jMIMFD7OddLehaL1lvFemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082174; c=relaxed/simple;
	bh=k8wwPdUoz0JWECzGSE5B1fxL0m5m2t59pI9A0O3iYIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+FWl/udc50CZ90UJ5pHQNo3HKhPYqaY//b702lY891pHu/3TffES5rMgyFOgQRfI1tSdqO7bvH0E0H8C5iNi7urVeK9KJQZi9l4dsOy2PvZkJftM7yqvrsy4oW3uqQHsml9ioErGN8ASWsg1/uoDt2zkPq0+2V12wKBVwjDZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E1Y3kMPa; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-421eecb573dso27358825ab.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082172; x=1758686972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlVsfk6aY0ZazEyY31q+iUDbMBToFztjgPELDebNpBE=;
        b=YvubKSdJqq5dmmC0pVzvymzA3Q8BvQ71ZJOdjvjys0gF4Iu8vIJniGxpUCa0c6fxyK
         KLI2fkP19R/0xMiFv42NqpEr2gzUHVVC45nyJU0//RoBnaN7WU0UU7XgwHkUqQXs3vZv
         SiTw7dykzi5j+G4PaEXpxH92lzUG8VYrroqNWKhSB9nk4w6W8Pq4n/iWQQOuwqPdEwHa
         d0wkqy1LkJlXMf7zBV/qdqOuyA4GJTcVrnj5iWPLL+IWh+lNDqznGMwBZwW3ZctUI7vJ
         2/7G3ePyfLSng15K5cRCWZ19UutRh88uzwmLxz8ihMF8/rLDne1DVD8kwoUgqwK3gGyU
         Uo1g==
X-Gm-Message-State: AOJu0YxA30/rLMZZ2QBXxh0WDneyevmvn/+UlsB/6jK8J9TPWp7WRhbY
	wT+88u2XhLFsH6SVHN8qwkWviyP19ODZYibY3+eGhQATSdIZVhAfPefrCgIFSXqs1UZ7rpKPROx
	eds/2UIB5TAc8JOXOHvNnt6i9SI6Y+ikH/RrbwpHlON93lkwI4hR0hn4riVTYxcinF4IQhgyfzB
	RXE/k1wxIb2TdYAnCgy5vcO8P/J5WnUmVaNgRMT7YP66m8tnTfamv9MXfz2L5yBhFTHlwlfPDXU
	ZnGh76evQc=
X-Gm-Gg: ASbGncvKTd4VL66CgbqxNubGmDcjni562L/yG7wfZZ+X8VpM60RotpXxmteo2TrfHSt
	b8w6vHsFyxBVRbAcOqFI3mUjeKzxXXrL4n4wtULIXYZXgJwnekpN6I8293H2AJziebV5RikYbAY
	gOFTGxy7dy5J7HqTBHDtofJuB/R4pqvdmXrTNaETuZ9Xe0wLQmvwrrmnuQ0nAVR5lxi1bh7/c4Y
	tPW2MEZaXF5Dt3v9agEUwhJatwIRwsRElU5f7srJPj8L1xjyc24I4ovPcAXxbnqVv55+pBy4h1T
	h0bzXD1ZqBS/uFSa11XrgxFiHHSjKgxrJjSCFqKqbvluih1xsFuJkki0t+SHz8rl3XitOke/gaI
	g8CbYBUvQ4O8L1Br9WVG+AcaWgQRTU3ol6MM4dneVc3Ye++QouvNSXhbiRz1hGjJUKqiwzrOxf3
	j00g==
X-Google-Smtp-Source: AGHT+IEgTNtDZM6E56KjchqkCwstDKxMQbiaRTXyLmLDtR6KtwMRfl5Rj3//isK7nx8mzvnylXVfOmOfq5QD
X-Received: by 2002:a05:6e02:3783:b0:3eb:5862:7cef with SMTP id e9e14a558f8ab-4241a53d465mr7543045ab.22.1758082172010;
        Tue, 16 Sep 2025 21:09:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-511f2ec14bdsm1319416173.4.2025.09.16.21.09.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32df881dce2so5264128a91.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082170; x=1758686970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlVsfk6aY0ZazEyY31q+iUDbMBToFztjgPELDebNpBE=;
        b=E1Y3kMPaRdBPYl0e9IcXExszrhk7/mYVXh2Rq9vm0r7Ip9b+GdxcnJg4o43+/9m2Px
         2zxieUqiYsPbuSNDi4yy6Mg1nut1wjJAzunQglHN+0NaVb0b+K5dmxHCytDagrSRNCs9
         KEdBpP97/8sq7X1E1OTMF5rH4n3KtNnvvQE4k=
X-Received: by 2002:a17:90b:268b:b0:32e:32e4:9775 with SMTP id 98e67ed59e1d1-32ee3ed1932mr954518a91.12.1758082170319;
        Tue, 16 Sep 2025 21:09:30 -0700 (PDT)
X-Received: by 2002:a17:90b:268b:b0:32e:32e4:9775 with SMTP id 98e67ed59e1d1-32ee3ed1932mr954502a91.12.1758082169898;
        Tue, 16 Sep 2025 21:09:29 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:28 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 08/10] bnxt_en: Use VLAN_ETH_HLEN when possible
Date: Tue, 16 Sep 2025 21:08:37 -0700
Message-ID: <20250917040839.1924698-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Replace ETH_HLEN + VLAN_HLEN with VLAN_ETH_HLEN.  Cosmetic change and
no functional changes intended.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4ffc4632991b..c49a4755a94d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6838,7 +6838,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
 	req->lb_rule = cpu_to_le16(0xffff);
 vnic_mru:
-	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	vnic->mru = bp->dev->mtu + VLAN_ETH_HLEN;
 	req->mru = cpu_to_le16(vnic->mru);
 
 	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
@@ -16086,7 +16086,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
-	mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	mru = bp->dev->mtu + VLAN_ETH_HLEN;
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 1d8df44c3f9e..80fed2c07b9e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -741,7 +741,7 @@ static int bnxt_hwrm_func_cfg(struct bnxt *bp, int num_vfs)
 				   FUNC_CFG_REQ_ENABLES_NUM_VNICS |
 				   FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS);
 
-	mtu = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	mtu = bp->dev->mtu + VLAN_ETH_HLEN;
 	req->mru = cpu_to_le16(mtu);
 	req->admin_mtu = cpu_to_le16(mtu);
 
-- 
2.51.0


