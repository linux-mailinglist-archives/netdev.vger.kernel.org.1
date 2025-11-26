Return-Path: <netdev+bounces-242087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99575C8C22A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EA3B3569AB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE93431EE;
	Wed, 26 Nov 2025 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b8FjInK7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDB342CB5
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194275; cv=none; b=pjwO/EaGFV3WwqkGsoDMuo1Gdn9RKnsGfMUt8nFHZNHrwxzRVF0MUSpbPd+7U69tnqbPamLFF64LW4TosZTKGYof+K2NEfCT+Jz7Pn9BOsMWg3ZvUvTFwB0Sq0EKGbGTI3OMBdm0VTa9bBDzZastN2ZaKMXVKukTx/IGMXep6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194275; c=relaxed/simple;
	bh=zHwbSdMpIh6W8flQgX95eZkWbijbnZIC4G2DbX8oa1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei35RAreb4AcWoZb3k3PwMerlJVenodF1WZYvsQz6sEFNfY7FTvpQnu9rGHKMBVuB/Wwsr7VU7oJLoKhyVNt5KXRFOwu1TqGYswf7jpZ4rBjZGlO5WSJ+HyPCToN8TtahqXU3kVWSdiCOs3jhul7+Gfevitb6+8URF2dtcGvSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b8FjInK7; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2981f9ce15cso2409775ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194273; x=1764799073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJyYh4hoPwMCiOEyFBp4tpQwRbShgvSldDS4LPpPtFk=;
        b=mTsHvijjJaFWOjrUrpcRgi4gwUylC8BBOEYrOkUsLDfjzZPUgXVolzMeGKL4XnepVx
         NSEwti7NIcTPBPKchiouYtkiaQBM7+d3PbCgoBOyr3lqBBdpuvN8DBasHKco6fcnGdRT
         UbTHMUcQaTIXMMHhvvxRIFO/qXzr6GVBv40jRlQ7+6KCnGrhPeZVPWsXJRdIqXje5DTY
         Xn3y1ava72bFQnHbbb29tGGRga0Q+6uUSEL31qOwMseZhJASRPNRusMEq1kgHws9NCyG
         PP6QyMbw2Ny5YuUglitBAGlpYMJMTnZ6msJ7hMbJbVtDdmfCT/DSUT0fUHJKZVF3dSO0
         IheQ==
X-Gm-Message-State: AOJu0YwfYbYr8tUIKBp2GZaclBH/Q0aNK4E02ii3UgZW8ilD47N9+QyN
	rIpryMvnExh5DLMwlAbDGoPQmU7NbEpTRXDEEONHRsfIPPvfTDP5Jj95gmi7YItMIErz9hlhwj/
	XWpEOJCGBNGJPSqhPUByVUA3Va5mJFvbZQOuLOdhmTMtvQ3BHa9ugkeSIQh9MV8fpfCA37N+lbm
	pr5Qkb8QcQkdSVDix/iAatLUUX58GO3Jm5cJGiINCThIvjkO4CAJn5dWHCJEfc1OfYz6jqqKD5C
	NNvymnCywM=
X-Gm-Gg: ASbGncvxi+VxZo7W6687n038pFZ69veMoXzNlHE7zoDpiVPh7kthc5f3XC3rCpKTcWg
	WkI1KluyudiuT8/9yegO0vNMR5kiGXW38RukTBJT4FwcS2RVcMSnpFIGKwg6dSv+knk5ZMcfT8A
	bDFyvfxhqy2sk5EZF0NkbcSPidophvgq9avio7TdG5c0gCC9jns4jB84nZE//DUjs/TEdhGtDcz
	zmdqmiGxJc45AgF0Xg7a77u3ZU4VDOiI25H1ilbg7ks9QjJk3nIHr9/Hru4LU5CmmxqVg6ctLrs
	as9FNu3FlLp4Hi+pUL9eOxBuAFO2boPspcFBNNKBTGYWURRXRinwwhBbDzVphpX9+1HVFP9mdZP
	tfjZU2/mpocvmYoejLBJCqW12oOFOajjfDCloOS+YLjhdwD0IRHvo2SN8k6Q1oq5IkbFQz/BuP3
	6YgoaT5SK8Vn6zQWK25+YsZL5gijZYVwoRZLt2NfrPUSOz
X-Google-Smtp-Source: AGHT+IEXgagVJIMcGuCZmMlbbJo6+MgKdRHmMeMz2UFTrOOz1oC48fGuhIdiLdx/J1AWED/ug0gaaHuK3Ji7
X-Received: by 2002:a17:902:f712:b0:295:82c6:dac0 with SMTP id d9443c01a7336-29b6bf3b620mr228823835ad.36.1764194273029;
        Wed, 26 Nov 2025 13:57:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29b5b24c6ecsm24272535ad.60.2025.11.26.13.57.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8826fb20ef0so7620976d6.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194272; x=1764799072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJyYh4hoPwMCiOEyFBp4tpQwRbShgvSldDS4LPpPtFk=;
        b=b8FjInK7t5Ant2gmAP72NmSl+6QMAnDbrtK1B5hV+6KKOcWUNAsYjyNxeMYfwp3Acq
         oPuT73kshebwrMfFoLxdXBSZ7g4XNuGsltVHLkIn6d55xK2JhwvHzIRtF6GqiLy4NnUZ
         DneXbJnhd3lq3G0qsjp7KtuIX3cnrIX+BXlKk=
X-Received: by 2002:a05:620a:28c9:b0:8b2:9741:ca69 with SMTP id af79cd13be357-8b33d481674mr2628503985a.80.1764194271676;
        Wed, 26 Nov 2025 13:57:51 -0800 (PST)
X-Received: by 2002:a05:620a:28c9:b0:8b2:9741:ca69 with SMTP id af79cd13be357-8b33d481674mr2628501585a.80.1764194271250;
        Wed, 26 Nov 2025 13:57:51 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:50 -0800 (PST)
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
Subject: [PATCH net-next 7/7] bnxt_en: Add PTP .getcrosststamp() interface to get device/host times
Date: Wed, 26 Nov 2025 13:56:48 -0800
Message-ID: <20251126215648.1885936-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

.getcrosststamp() helps the applications to obtain a snapshot of
device and host time almost taken at the same time. This function
will report PCIe PTM device and host times to any application using
the ioctl PTP_SYS_OFFSET_PRECISE. The device time from the HW is
48-bit and needs to be converted to 64-bit.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 46 +++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1dddd388d2d6..aa079c8aa935 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9691,6 +9691,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_EXT_HW_STATS_SUPPORTED;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_PTP_PPS_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_PTP_PPS;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_PTP_PTM_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_PTP_PTM;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_PTP_64BIT_RTC_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_PTP_RTC;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_HOT_RESET_IF_SUPPORT))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f5f07a7e6b29..08d9adf52ec6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2518,6 +2518,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
+	#define BNXT_FW_CAP_PTP_PTM			BIT_ULL(44)
 
 	u32			fw_dbg_cap;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index a8a74f07bb54..2ac231c991b4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -882,6 +882,51 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 	}
 }
 
+static int bnxt_phc_get_syncdevicetime(ktime_t *device,
+				       struct system_counterval_t *system,
+				       void *ctx)
+{
+	struct bnxt_ptp_cfg *ptp = (struct bnxt_ptp_cfg *)ctx;
+	struct hwrm_func_ptp_ts_query_output *resp;
+	struct hwrm_func_ptp_ts_query_input *req;
+	struct bnxt *bp = ptp->bp;
+	u64 ptm_local_ts;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_FUNC_PTP_TS_QUERY);
+	if (rc)
+		return rc;
+	req->flags = cpu_to_le32(FUNC_PTP_TS_QUERY_REQ_FLAGS_PTM_TIME);
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (rc) {
+		hwrm_req_drop(bp, req);
+		return rc;
+	}
+	ptm_local_ts = le64_to_cpu(resp->ptm_local_ts);
+	*device = ns_to_ktime(bnxt_timecounter_cyc2time(ptp, ptm_local_ts));
+	/* ptm_system_ts is 64-bit */
+	system->cycles = le64_to_cpu(resp->ptm_system_ts);
+	system->cs_id = CSID_X86_ART;
+	system->use_nsecs = true;
+
+	hwrm_req_drop(bp, req);
+
+	return 0;
+}
+
+static int bnxt_ptp_getcrosststamp(struct ptp_clock_info *ptp_info,
+				   struct system_device_crosststamp *xtstamp)
+{
+	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
+						ptp_info);
+
+	if (!(ptp->bp->fw_cap & BNXT_FW_CAP_PTP_PTM))
+		return -EOPNOTSUPP;
+	return get_device_system_crosststamp(bnxt_phc_get_syncdevicetime,
+					     ptp, NULL, xtstamp);
+}
+
 static const struct ptp_clock_info bnxt_ptp_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "bnxt clock",
@@ -897,6 +942,7 @@ static const struct ptp_clock_info bnxt_ptp_caps = {
 	.gettimex64	= bnxt_ptp_gettimex,
 	.settime64	= bnxt_ptp_settime,
 	.enable		= bnxt_ptp_enable,
+	.getcrosststamp = bnxt_ptp_getcrosststamp,
 };
 
 static int bnxt_ptp_verify(struct ptp_clock_info *ptp_info, unsigned int pin,
-- 
2.51.0


