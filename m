Return-Path: <netdev+bounces-222911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98CB56EB2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B6517B144
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C39233145;
	Mon, 15 Sep 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PNQWBwGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC6212548
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905569; cv=none; b=fK9IuNM5GTTjxZ/kmBx1kfQ7a1JKJzFDksGKWqg/3e2HyhHRXjzdgAVoC0cXkNDxBl2JtbCe4+PWqhy+CCogaYHvH3HHDCdpmgzuY+p+fxekb0YdZuUQnwFoKvVMfKgbxTEuCNwGGjKCOw6P/NcxgUxGDhhGsthyAxZ21NKf8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905569; c=relaxed/simple;
	bh=3JY0Fh2Mj8lLUYnsip4Cp1sHrpq7cmtvvX59Qga5kIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqYw1TG13DCLBzLUIXteqCIbA2L7gdnvY1zRH+iPmICooq2/xjd+khgsCIRJ6TnQeXwznPDjLaHQ0E3HcheuONJAXbk/yAsLN/dQOSyLmiMSeZ/xelcaMHlNN6aroi9+B+5m7Ci7H0BnFfhBiPmrXPs61rzTNAWzBvJxN5P7CqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PNQWBwGl; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-24b13313b1bso24468085ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905567; x=1758510367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUEIX0FP9Dl4IxlF6+h5nDbwqqrS0Xlw4YysY3ryNrg=;
        b=UVo1tA5XwfTF9gYaNXEn491bM4mqamymQ0FPPO7OaLLgoX4v5hOVtphit4JhfaSMGS
         WaHH3Uy2dmkoYc+4lQWTnbmj5DOfm2Kdm+g/bHn9Wm7ZiMxVbSqdnzYbNStl2LfS4Ki4
         B5Vb2KplSYeu70O7eY8fmn2OQL3zQav5Igs1nq7oWU13jna05Gld0UnDqfHFQ68vA4qP
         H0PjdtF/2CMMdxDjrsZ4rFORR63v+6t2HZcGoxWKpENNCxAMBkOy3FyUfP5lVEygYL0l
         4dm/bl7gkr3PmgsG+wEDCOxH9KDfqNVUxmQEX3lb9C/9f5YP8C7FPkNE9eKalXKPTrQq
         d/8A==
X-Gm-Message-State: AOJu0YyDKv4DcBffAb/OluYE+HzW7K8dIWBASDEWJoGIrBZESGDl2VNk
	ejK6rCuNQMFCcK1pZ5EjrAm37+PFWsrMDlU4A0hpHqFy7DOJd+jUPKoXwURTb4beu6Uuk0ucmZn
	d8WUpiL7SjyzfDOJ30ZFdgS3wghS+lr6jHdsYm9D65x6wKdOozSOPOb9raJp0ucpy5hfR9wdOeX
	ndhSYHApbkli9ZamFQDN8WmA7N2xCBX08GMNzDJiHwK2/X7QSSoIkDqFgvWxSYRgdoSaKRsWBY1
	YKEv5OkfGo=
X-Gm-Gg: ASbGncsVklk5Q87SiVOxDQT4vn/4S+DilyWfEQ3vuTXPH6SFiwi7J6DRw+S5DNDUnzE
	7I/ZX0sX7q6Zvo7keolLLIiQs6bQPUI+mmcbVSPGJLzazSHuuJCSOIsIGvn0D48IlqkvCBmjQ5b
	ofkcjtHkIG9q4fMw+lDU88y1YTN/duiXEzy36wXdr2EXAiVs+OGxa84BMRYJ1NVPgeck56W++8W
	jwdNSRSnvFe08TqhSUebD+10LXWjIwKqKCZqtTBEvv4b+hTU5AC0LIwA4f/usQ0j1kMY0CsRYm2
	Fm9JzrJn1id4bkV3K//AJmbQhJrYJXRh+Ktta45467CiAqMXsE1KZ0uhIya9EKz7ci5CiuWWSxl
	1rlpNO9eBvBfKEKGPN/umdx7jtr8KqKoqKZ8cfjg3LYfn0yJgMtftNLWpANSR8DiWgYfvAVwcuD
	5wnQ==
X-Google-Smtp-Source: AGHT+IErcG4R+4YrSwkbJOdehc4PVrmvKzPIoP0ieyvRzO5fn2yzegCEC5jsmWISP4PwhC7srhSkkxDTPBlQ
X-Received: by 2002:a17:903:1aa3:b0:248:7018:c739 with SMTP id d9443c01a7336-25d26079f41mr126728335ad.28.1757905566220;
        Sun, 14 Sep 2025 20:06:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2605c561de9sm7162485ad.9.2025.09.14.20.06.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:06:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581953b8so42671205ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905564; x=1758510364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUEIX0FP9Dl4IxlF6+h5nDbwqqrS0Xlw4YysY3ryNrg=;
        b=PNQWBwGl8VOzvibwOtJPEj9SOkInJy9sCCvw7DrSfcmxCCEkpJ7sYpeia0Q8qIsfzr
         gnm/HaflViDbkRY05wQZ5dqf9zMYMoadk4ClPZ7IUuZv0V00eLN+K7UWpXqELe60/9ld
         WpqRfTnaC4qgTeS4inCKdPpEHedNKdIa5m5y4=
X-Received: by 2002:a17:903:1b10:b0:252:50ad:4e6f with SMTP id d9443c01a7336-25d27038fcdmr145663785ad.54.1757905564439;
        Sun, 14 Sep 2025 20:06:04 -0700 (PDT)
X-Received: by 2002:a17:903:1b10:b0:252:50ad:4e6f with SMTP id d9443c01a7336-25d27038fcdmr145663455ad.54.1757905564000;
        Sun, 14 Sep 2025 20:06:04 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:06:02 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 11/11] bnxt_en: Implement ethtool .set_tunable() for ETHTOOL_PFC_PREVENTION_TOUT
Date: Sun, 14 Sep 2025 20:05:05 -0700
Message-ID: <20250915030505.1803478-12-michael.chan@broadcom.com>
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

Support the setting of the tunable if it is supported by firmware.
The supported range is 0 to the maximum msec value reported by
firmware.  PFC_STORM_PREVENTION_AUTO is also supported and 0 means it
is disabled.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 24 ++++++++++++++++++-
 include/linux/bnxt/hsi.h                      | 21 ++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index d94a8a2bf0f9..be32ef8f5c96 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4416,12 +4416,25 @@ static int bnxt_hwrm_pfcwd_qcfg(struct bnxt *bp, u16 *val)
 	return rc;
 }
 
+static int bnxt_hwrm_pfcwd_cfg(struct bnxt *bp, u16 val)
+{
+	struct hwrm_queue_pfcwd_timeout_cfg_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_QUEUE_PFCWD_TIMEOUT_CFG);
+	if (rc)
+		return rc;
+	req->pfcwd_timeout_value = cpu_to_le16(val);
+	rc = hwrm_req_send(bp, req);
+	return rc;
+}
+
 static int bnxt_set_tunable(struct net_device *dev,
 			    const struct ethtool_tunable *tuna,
 			    const void *data)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	u32 rx_copybreak;
+	u32 rx_copybreak, val;
 
 	switch (tuna->id) {
 	case ETHTOOL_RX_COPYBREAK:
@@ -4434,6 +4447,15 @@ static int bnxt_set_tunable(struct net_device *dev,
 			bp->rx_copybreak = rx_copybreak;
 		}
 		return 0;
+	case ETHTOOL_PFC_PREVENTION_TOUT:
+		if (BNXT_VF(bp) || !bp->max_pfcwd_tmo_ms)
+			return -EOPNOTSUPP;
+
+		val = *(u16 *)data;
+		if (val > bp->max_pfcwd_tmo_ms &&
+		    val != PFC_STORM_PREVENTION_AUTO)
+			return -EINVAL;
+		return bnxt_hwrm_pfcwd_cfg(bp, val);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/linux/bnxt/hsi.h b/include/linux/bnxt/hsi.h
index 23e7b1290a92..47c34990cf23 100644
--- a/include/linux/bnxt/hsi.h
+++ b/include/linux/bnxt/hsi.h
@@ -6771,6 +6771,27 @@ struct hwrm_queue_pfcwd_timeout_qcaps_output {
 	u8	valid;
 };
 
+/* hwrm_queue_pfcwd_timeout_cfg_input (size:192b/24B) */
+struct hwrm_queue_pfcwd_timeout_cfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	pfcwd_timeout_value;
+	u8	unused_0[6];
+};
+
+/* hwrm_queue_pfcwd_timeout_cfg_output (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_cfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
 /* hwrm_queue_pfcwd_timeout_qcfg_input (size:128b/16B) */
 struct hwrm_queue_pfcwd_timeout_qcfg_input {
 	__le16	req_type;
-- 
2.51.0


