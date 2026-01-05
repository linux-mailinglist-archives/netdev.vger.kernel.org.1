Return-Path: <netdev+bounces-247205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF8CF5BEE
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A882300C37B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B56B311979;
	Mon,  5 Jan 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RVG4ekcg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94373311C2C
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650355; cv=none; b=Ye21D29w1vX+xSq1MoqKihgqQSvlX2XQ5AmrTY7umlpEfkh3j3zwFfiw71ZTbYSo+UX/Qn4cS0nrF+4goD7Aiz4CdGnsr7RlAjo73Isgu/uvQ539M/BPiO257m9EDur4E+N8JlTQrRAUX7pTXY5rngL97BSqNJPOg47d/eV0cF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650355; c=relaxed/simple;
	bh=PVxoNc9Ym0KPAibQbUBj+ryEVtivjFIiWY5blHoKiI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jws3hD0BFAIGVMhO2ewx0a78w85k+9FjBrJyp3ns7fqjNY8qXKkWL1T0mpkm49PD+W0vZ2lnmWxKgU3ncfRFc4JehxCPWtZFagedYjYioXuw9cUWUlg3waOKhbS1Ey1De9NpM7UnsaFH8bY4eyqWtJ0L3Ws9JENY29i71/XH6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RVG4ekcg; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-790647da8cbso5171207b3.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650352; x=1768255152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dKkTfp4yqc7hnxNWGt19GxArJB2WSPjJHfQ5HOkq3U=;
        b=i3yE3e4p9POhSuAJJvJwk9FjEhnclKB2MooRGLWdrmtL1BTw4YGebNVBKMPxJQywqQ
         rzhiFEIpzVZ9vZbh4CuXmsfC+U77ykZgKF4c/GbOoDi72aLpVCouLC7+oPnKsfbUyULY
         9WWBZqpPt65RTsNnF6lldz5mfQrJk+oL7Q9T0Z4KDpYVUJrWx9BSP/Df/H0h/IXtZh9e
         rSVchg1p6HLlN4ZNSAoevytlcWZQixTjtGhjAca59PoEio649skmDT+z7cMLQJQjzumn
         mJ6fIQTCxILYOwBod0j1IwjO610e0laTHNfHa46jwVfHEvrb7ZwrOvIgR5XRSAvQaTCi
         RY2Q==
X-Gm-Message-State: AOJu0YwKhJ9O4iymr/eNvGCM1LNZHVc0vQ9YyZ+Qv1zaD8Z6uN9KZqOZ
	wuxJMyErHt47L/nfcNJg832X2q/kh58B4JaGRvk4XV19juZh85JteY8YUKd/GdOalqavYEx+Jkg
	3BzlPgihEnMTw/WrsFxyUDXeFiwzzlnaj9o0cFi41JbXiCpVeXhJyGjlwHJYnTCgFGQzn1Rs0x0
	7OfDbtrFcDjzUYXgWNNFpWPbTupRdsq/X6CLjiIxPg3TVMpZbdD0oTTSb7IHwLoiCNoNxH/FhYp
	aDkaG/3wDw=
X-Gm-Gg: AY/fxX5kGBM3QZZJhfGWfegQ/a2k4IOBOIjnkX6cCIBbopNZGYzywG/JYSixAO1Vfoy
	Fn4Ou9/TG3UVa57JiwwfHBDfeGve6i3yOziJq6nw/Z2hRFtF8KJJBinfv+FbOjzBQmZpzyBKxfN
	c9PqTxodxmXesupYaud2cRvRLZn7OqqjukA2BkAA1XtSIy+so5gPPcUOiKpK0ziUY7LZX8BsMET
	De/8yQX89HimwvjdkkyXprayuhBL4IP5gNDDw1N+p29OXSwBsSVt1///yHDQ5SIizbyuIRzQR6T
	wSkDfaR+5h3kRyw7mTZRqnQearru/3u5pIhYFM2B0wd5o8k74n7XEAomjb742oXyxF0EP0ZZcDE
	OxvbV3SaDM4PmTuFs5+FoFubi/fMwaVtYkFuFrh0LQT/UaWiDEEatyDqC305Jyal08sbx/h/PmF
	TTCIFOAF0A2u7UbZaeJBtlfr0C5oSJtJB4SQuwUWVD9g==
X-Google-Smtp-Source: AGHT+IGfn306qXsQPLEj6lTtoPQiMh2V5OuryxVrHdPT3sHd264K2jw7Z8mkX5aAeuQ5QdD98v1npUVcvPdt
X-Received: by 2002:a05:690e:4192:b0:641:718:8a04 with SMTP id 956f58d0204a3-6470c8d4d2cmr873829d50.56.1767650352498;
        Mon, 05 Jan 2026 13:59:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa56400esm106417b3.6.2026.01.05.13.59.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:59:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-888825e6423so6660006d6.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767650351; x=1768255151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dKkTfp4yqc7hnxNWGt19GxArJB2WSPjJHfQ5HOkq3U=;
        b=RVG4ekcghHFUiCb2/eI5Cq2b+X4vVtIotgtjEhUGK1mGfJsRcJbNdstOiBS6NGie6K
         Cf4gK7n6eFQCwd8cqq6PmOEo3xPf5wqjk2RRfWcIbmALg1XJcCwrdfySUf0TXvLweWwm
         ENe0HuBFfDaVNanLWZ8yniWKQ2QvPRFraeMzk=
X-Received: by 2002:a05:6214:268b:b0:88f:cc7d:6848 with SMTP id 6a1803df08f44-89075e29250mr15034906d6.26.1767650351554;
        Mon, 05 Jan 2026 13:59:11 -0800 (PST)
X-Received: by 2002:a05:6214:268b:b0:88f:cc7d:6848 with SMTP id 6a1803df08f44-89075e29250mr15034756d6.26.1767650351115;
        Mon, 05 Jan 2026 13:59:11 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm1882051cf.3.2026.01.05.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:59:09 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 2/6] bnxt_en: Add PTP .getcrosststamp() interface to get device/host times
Date: Mon,  5 Jan 2026 13:58:29 -0800
Message-ID: <20260105215833.46125-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260105215833.46125-1-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
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
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>

v2: Add check for x86 support

v1: https://lore.kernel.org/netdev/20251126215648.1885936-8-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 47 +++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..9ab9ebd57367 100644
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
index a8a74f07bb54..75ad385f5f79 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -882,6 +882,49 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
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
+	return get_device_system_crosststamp(bnxt_phc_get_syncdevicetime,
+					     ptp, NULL, xtstamp);
+}
+
 static const struct ptp_clock_info bnxt_ptp_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "bnxt clock",
@@ -1094,6 +1137,10 @@ int bnxt_ptp_init(struct bnxt *bp)
 		if (bnxt_ptp_pps_init(bp))
 			netdev_err(bp->dev, "1pps not initialized, continuing without 1pps support\n");
 	}
+	if ((bp->fw_cap & BNXT_FW_CAP_PTP_PTM) && pcie_ptm_enabled(bp->pdev) &&
+	    boot_cpu_has(X86_FEATURE_ART))
+		ptp->ptp_info.getcrosststamp = bnxt_ptp_getcrosststamp;
+
 	ptp->ptp_clock = ptp_clock_register(&ptp->ptp_info, &bp->pdev->dev);
 	if (IS_ERR(ptp->ptp_clock)) {
 		int err = PTR_ERR(ptp->ptp_clock);
-- 
2.51.0


