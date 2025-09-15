Return-Path: <netdev+bounces-222909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27EB56EB0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94DB18955E4
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ADD22F16E;
	Mon, 15 Sep 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="evUWrsjO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982E2367AC
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905566; cv=none; b=rfTgdYX/G1TTkNAWbUIHCiSDhSYIyl7ac4IqNL3q83iHk+Yo+xB8uX7cj0/kMi1GZ12pCGK7Ln7vLoiUczoq4VUqrMHFkI8uW9zWdCwKx2oB/9EkSwC7YoB5gtDTE+iMzH2d6QEZtf+/urkhWG3hXc+K7maKPkh5b1jp98y7xHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905566; c=relaxed/simple;
	bh=LzuxOO7MUsz9QeWcAv8CL6k9NX9Zk0+3wU4IrOTgU00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCDIpw2gnFPHS1TVHnVF1Df19rVp3mYUA+Og9FKJpBy678a28CXQZW4eqfTsJ/ixezh9z6rX1lbCC0eBOntMYZ+x/R/u3ZcJxS4mMyMnoBUGOJT9T1W4fz6KTXqZHirK3qW8cJirKcQFlfbcdjBS0lzVhLt0mzfrulxuPUYVM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=evUWrsjO; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-88762f20125so302950239f.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905564; x=1758510364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGwiH9q/1gsZh2ntFuSvxj+ApHIpi+jE8hURCuHY8Eo=;
        b=m7wVRCTve/72RQpE0tX6eiDl9V0vbBw6Pt5qlb4XV2u1wqWGNDKjX/blzEBsW/oRh7
         Pg+s2GPnLE0BKg03tQl2doSnsKngHM/5tnbvwAtwHRLew/DF5bwVazLqXpQiAvFIdHrP
         n1K0k33DKiH0SqXkWtoDy40uzgSiDVheDO98GwwyKREciufKPopqGPo1+6LgTLT84Nox
         ghtnt1UHrFlqCrdzqhlvZLD2xdJZLedQDH107FdB0GcvxhRxQByiWOVMR5Ua8HthXnjG
         y+0s1kOMSc12Yt/MEKVSiRLUKF/VpEntihQCNrFTp9Jelms9EjKuuBfaQUvqKcOFGxrN
         zT0Q==
X-Gm-Message-State: AOJu0YzGJCHdujGaHjG3JUEzy4QaRF5H1A+5bxh6grSgAj9/Ief0RGYY
	1qMMTPtUl8IV1dUmAJFaQ3/aadqJQkOhpyFcifR+VQGTxYRZde5Uat+84IBJU4tx59VhNGhuatv
	79PQF2Md9QstKv0oKehsPZKVyEavF/MCstZLU1URVOSuiChNur6/s6hQ0qn1piIWQHv2aDO13L3
	vjy1DWZ5icizwncRAYYP1VKgx3T36cawMew58mXvH7+zalg66TBQXiXtsUfKXGk+vbsntgtcgGE
	/g3xC+PPdk=
X-Gm-Gg: ASbGncvMzgEx4dnOsgqoLsTyDQQ4gkjLLnxbw213eDoOQNLsTNeL8Do+5jF7Sqzu9aB
	FaENfcuRrd0ZsOMYoj18XRiRMqpCb/AgQdCzGsg2BI1D98a5Ma38ML6bZE7BqB4t+R2qtN2vKzt
	UzGFb6w39FRI7rzmfW7UAE3R2eYRCMOLMiDf7bKEShEHohpUmtUVeTcmaAXQx5IpF9HPFPdOD4l
	B1nRtO2JWxQIiX6VEUkjI2AfoN/mUZxH5AeHI8P1BiD0hTckkBfnuwSqRlH5CReu7bMezPaCP8s
	4RMtV/DvRDIv/gDnOTDMsT6DgxT9tm9woVdG2ROy0m8NiZ/A/YTjwBQX/dS1HrXcfqIYWj760ID
	Hr1cgNA+lnkRq1y4ucCy1hEjpHsh8MYlVv1KDf0AIGzflJRcJHhG+e8hy/RJxvlwRh3FZ5Tunyd
	c=
X-Google-Smtp-Source: AGHT+IEz6K1aje4lIK5k11uJmrzJ/GoQBkXIcIb/vmkwd6Iz3/WAGFADGH3bFDHPZVk0/x9yvEzpz1zisMto
X-Received: by 2002:a05:6602:4804:b0:887:6eb:2282 with SMTP id ca18e2360f4ac-89033c6b647mr1268862839f.13.1757905564132;
        Sun, 14 Sep 2025 20:06:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-88f2fcb5810sm70239139f.11.2025.09.14.20.06.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:06:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ca417fb41so35713565ad.1
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905561; x=1758510361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGwiH9q/1gsZh2ntFuSvxj+ApHIpi+jE8hURCuHY8Eo=;
        b=evUWrsjO6nKPdvH5NlfVmxjo1quGzi6ax6C+QMHBrqil01PWbZrsSLu/M/xMUKRGRm
         hOe+uimVvZLXFr2wQtvGL/yCeSXnHQTTEPV/Ujjcy3qfE7UpsVRIG83taFclV/95/eRu
         qLulDHV7KL2jskSyBJwq0UMA/YGRXpE2DBGCg=
X-Received: by 2002:a17:902:d590:b0:25c:ceca:9493 with SMTP id d9443c01a7336-25d26a5b6afmr145731355ad.49.1757905561199;
        Sun, 14 Sep 2025 20:06:01 -0700 (PDT)
X-Received: by 2002:a17:902:d590:b0:25c:ceca:9493 with SMTP id d9443c01a7336-25d26a5b6afmr145731115ad.49.1757905560830;
        Sun, 14 Sep 2025 20:06:00 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:06:00 -0700 (PDT)
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
Subject: [PATCH net-next 09/11] bnxt_en: Use VLAN_ETH_HLEN when possible
Date: Sun, 14 Sep 2025 20:05:03 -0700
Message-ID: <20250915030505.1803478-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250915030505.1803478-1-michael.chan@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
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
index 207a74450e38..f63e5dd429db 100644
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


