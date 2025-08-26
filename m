Return-Path: <netdev+bounces-216800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BEAB35454
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB22422DF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCDD2F6560;
	Tue, 26 Aug 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VuOKlDha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3C2882D7
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189239; cv=none; b=fzHCchG3tOoJdgwiTt2fHswxZN9sx3QlUbD7jRzieemC6A/mZyS7XMS1bPZSGPhgOsMFbdIEVr0rQjjSSdaUCOmegXjFcqJH3h0QeHsZkLstDK+v/QfPs+kJaG5SUGfF5wVt7PzOAUqHa9UziDoRGtXnGsxnSy6PP7lerN8N09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189239; c=relaxed/simple;
	bh=OdwXwwbCU5fHvuN0L5iu3ZVAIdZq9hq+Cbn2jIXkqjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzZFLlf86loYOEPd0HfT5AVDOpo4aY55aXvAYGlylmA04W1B3wfNK9TAEcoq957YjHVQ3WGvo7c/KbHdB6E1tUEiM1NrYWfeYk97F5wMw4llWdDPDXP/1asfELSlGqKyCsbMlCB7lq9AGV/QskxhyRYNdInxFMO0STmzlWnuE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VuOKlDha; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-30cceb07f45so3359397fac.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189237; x=1756794037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoR+gqx8oECrEElXGnqOHBHQF88CEE1za8gExAMJp7Q=;
        b=DOLW6WpNMUGTuVOdWwMpNa3O5ZicBJRa//x597ZseOeGCwU8VvX5F9KYjv5VrZA0eb
         BUqoL3YcUa5KR4oSPyz2ql3glTlaR94i0lIDCK/kOxHedTWd6KzCKvaI2rlfSCNQLbs2
         3FwijvXZH8oKUXlABI1MKC4tKeRixf/8g3HRYDU4p82Y4RTVa+3pc5Le0Jwhj7+61kq1
         8wG46GThgUDiRbVTpo5+1/ucWiIIW/nb6Nc7Hi8eSj+aBJzPw8a1XTqx65VQMX6YLkzQ
         /NKPzTcS8AEoWrlmZdyNe5xAv/0meACnhvjzutDS1DB/FBrpMGHAFhDJRa97kRvFdUBG
         vuDg==
X-Forwarded-Encrypted: i=1; AJvYcCUsrK1Txl7wjgiMNgY2f11xucq3AcvV6asI+8zmwhwwLvj0NvUxI5OAz30BYeHZpTkTGATDOt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXs+Ne/s4lejkatcItBsBBb+m/pv0yyEVWh5q6WTLNuC6uUqj
	qfC9Lvo89EuZvb7y9eqhHxwWW6H3rIVhYGkJUF+5jKOuqtCOHlgOZX36fHKLfB2Fb827bQ6xPIy
	g66HXuOnYFjZAWlyGLs+FZRA2MdsZBZeKPHDigCMkTpYXOp9rNt3DRrDmaoQzrG3ubS8ViTDgJZ
	RVB/yer9Hrx6kvn20eT9gEtz2XHcum/hTHXh6Q9PouzLnKu52DXhoVFZSyr4BxTxMOA3lU9GyjO
	PXEsPoH65rDYGSYocXYtaII
X-Gm-Gg: ASbGncvkuLqT3kyKyXQY1ndgYbd0+6e1rnBDRopqs8dcSVTCq11dYOHe6hS+BMYXZP9
	6rf0zPZ3SAAFWdmgGg0nzsMkXp97s3Ca/oIm7Z8dPu+Xx6a7VbqzciI6HLawHqJvmxD6FnJwR07
	n9/ku4b9R45JCBjOs6PmDPKZznXel19S9y1NCGi/J1PKpi5NZgoCM0YRL8UOTduCYlQs5VdQ4Ib
	aHyamiVQotNO0VQngKjxuY0q0qhHih0ZQi8xnyLvrL4IEL01ITEQBf7V35eR39I+s2AzXCRbEyI
	aJOVW0L6cCnhGE5utwdcqTdq3HOajP74la0FsIKcBRvzVpRzFhC0v3u+ldB2T+y+lM4BVz4xZ71
	8Re/6MIBbNPi9686RzWMiJ2awIwDx3fWmB8MMiJVtC9MdMB/wD+1qFHxl2uo/Bq5fq0dnPn/8Uz
	WDtrKAo+hZRTvzdZY=
X-Google-Smtp-Source: AGHT+IHXPufwXklic0UrEtwY4CU/PLsJlzTRxqDWnpZSARv/bEMZ13EMtektwLSHLH//PH4UUGELKJ/iVCPl
X-Received: by 2002:a05:6870:f14a:b0:314:b635:d7ab with SMTP id 586e51a60fabf-314dce188b5mr7591603fac.45.1756189236689;
        Mon, 25 Aug 2025 23:20:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-314f7c8f940sm972145fac.25.2025.08.25.23.20.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174c667aso4352858a12.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189235; x=1756794035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoR+gqx8oECrEElXGnqOHBHQF88CEE1za8gExAMJp7Q=;
        b=VuOKlDhaZqqz5iNzR5UvQyXFALT2ZuKrxt82McFSKdTB+qv5PJbSuCogmcMZ+Wyyd7
         QHJqWZFisKawI4t9QDg3rx6UBhPyTxOD8qVhHm/SGoJbbT17IjvwBNjxgTrRW4kLK8kL
         FWEdvcm8qmAdcf2uxzpelgcYDDAhDl4iKs/fA=
X-Forwarded-Encrypted: i=1; AJvYcCW9GzdL/BwezY4Vjl3CPuFTFgoCz3kiXK2OPoNK8T4F86ACj5Q1lR/AcAw3L1UcjX5ajfFEntY=@vger.kernel.org
X-Received: by 2002:a05:6a20:6a26:b0:233:b51a:8597 with SMTP id adf61e73a8af0-24340d027b3mr19891744637.35.1756189235028;
        Mon, 25 Aug 2025 23:20:35 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a26:b0:233:b51a:8597 with SMTP id adf61e73a8af0-24340d027b3mr19891705637.35.1756189234627;
        Mon, 25 Aug 2025 23:20:34 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:34 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH V2 rdma-next 01/10] bnxt_en: Enhance stats context reservation logic
Date: Tue, 26 Aug 2025 11:55:13 +0530
Message-ID: <20250826062522.1036432-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

When the firmware advertises that the device is capable of supporting
port mirroring on RoCE device, reserve one additional stat_ctx.
To support port mirroring feature, RDMA driver allocates one stat_ctx
for exclusive use in RawEth QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 8 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..751840fff0dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9601,10 +9601,10 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 {
+	u32 flags, flags_ext, flags_ext2, flags_ext3;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	struct hwrm_func_qcaps_output *resp;
 	struct hwrm_func_qcaps_input *req;
-	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	u32 flags, flags_ext, flags_ext2;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_QCAPS);
@@ -9671,6 +9671,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
 
+	flags_ext3 = le32_to_cpu(resp->flags_ext3);
+	if (flags_ext3 & FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_MIRROR_ON_ROCE;
+
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
 	    BNXT_FW_MAJ(bp) > 217)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fda0d3cc6227..fa2b39b55e68 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2507,6 +2507,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
+	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 
 	u32			fw_dbg_cap;
 
@@ -2528,6 +2529,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED)
 #define BNXT_SW_RES_LMT(bp)		\
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
+#define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 61cf201bb0dc..f8c2c72b382d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -100,6 +100,12 @@ void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
 		if (BNXT_PF(bp) && !bp->pf.port_id &&
 		    bp->port_count > 1)
 			bp->edev->ulp_num_ctxs++;
+
+		/* Reserve one additional stat_ctx when the device is capable
+		 * of supporting port mirroring on RDMA device.
+		 */
+		if (BNXT_MIRROR_ON_ROCE_CAP(bp))
+			bp->edev->ulp_num_ctxs++;
 	}
 }
 
-- 
2.43.5


