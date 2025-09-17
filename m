Return-Path: <netdev+bounces-223851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414EB7DA11
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3431BC28A6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9CE3019BF;
	Wed, 17 Sep 2025 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H2nUkk24"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBED302CDC
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082177; cv=none; b=IS1KODp6XcK9VhVX/JBpiQM9GFnSXGJbLuJQFwp7mevz1IsyUZn+E3wXaIZhHz3EdcgbzgNXUMls/wGT0Q5pMU5TC3Ovo23kheU1vUDYuKB+pzZpgdJ76+Po+wx4GXWr7QNf5YDWzKlLSU9RqYSxxNn81iHRI0sVjk9VjKMMoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082177; c=relaxed/simple;
	bh=3JY0Fh2Mj8lLUYnsip4Cp1sHrpq7cmtvvX59Qga5kIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnhyMU6joJwFdGqVfWL8K9fzV66Erejdsg6c0kDi9eNbJJvt8Ofdar4NxG6KyXMxjlHSt1JCtTbRotcftsRcLqwENEqRauD1+NZM7cTcL7utZTGxgsCo7HmYSObjIBk9ByfRlCZIalizPl3Bpr3o5HRo7crVeAWJRI402AZHUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H2nUkk24; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-88cdb27571eso196585039f.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082175; x=1758686975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUEIX0FP9Dl4IxlF6+h5nDbwqqrS0Xlw4YysY3ryNrg=;
        b=g6lzUiZknT5WneTevwJYprX/jlLbtgA+/+22tNtAWvapfQeRed/Dm8tgGJfPj6gVtv
         iqD1sFwth/nblcnzj2xvcYB0mjUsaBTG1nECO6Sif95Vy9Y2VRJoTi+lRIN6E54ISSiw
         ooQ7h3DnV4gJCwWWnkmQehPgefFb9z1C+2QcWZt58vQlaNzAXLv2bAcy1owJMrvgCU+g
         duTAe1iq9AGebo9hbY2OajnZBO1j3XPUjXXSaVBrzJ60A3a87Iuur2jVBnFm0fuivSJd
         afygfC1SMDOd1z9BvDJR8V6Nl2NUtF6uPdOdrerFr4SvF62maIhKMMP+hEehqQajmybf
         xlyw==
X-Gm-Message-State: AOJu0YyP26f9LLQ21rCqEMxH+s2Opcle1umETVE/+Af0oaKc1D/hmBW7
	DEwKRNro6jBxOQOkGP5VP78varLQUkz0Q5DBkud+30UMMQSqRIbleyU1pXGeh/bor6kPVJYhUWW
	0VJu0xkSdo+SlcmHDwsd32L5PLciaAwQ1v38wDUpQHDQW3aeaO8rMqZ3bTuZDCuV2cEq0ucleMk
	vtbV4oKD0RsLrkJRmjXdO7dcacetzNi6OPyzVZxyP+TirmpNfWwda045X7aL7Uir9sa4FYXDwSc
	ukBh/spuOU=
X-Gm-Gg: ASbGncurtONvCFCUg42Awv6u/1nlf31KBCL6IdmbGz60HFrOSQg0oeWEOLtG8TOfRUo
	sDbuwS4+MVs4QgP9/t3LUamrrXUcIuOo7lv+BzYGJo+8Koewd9iPTYwg7pl4nTCSi2pTuGoD0rs
	gfCVZ8wvlrphnEA6XrScSEwVWjQKVZu6rtjGDx2qsL4Irc7mxj/L0bQJI/M6MfNaDTr8rwcY3GV
	pN3jl1u/zvrL+nrf5ru6iQwGLGaOxJq0Qjm5sBbDDSYgBjyhScBt+AAiJDFDzt6sOB6V8dz6kkp
	lIiIk0IWzbEqY+CMCnUvuvZBZmqL+VMghIIzqBKdrJ7rDvSAJV7T/+kP5XHk9nBP6IUNg49lyXC
	WhUGsqhcVE8Qa1T9j0RrE0THLrQhwP9chVbccGOOUd07G0uIr6U3VqaU8olmL2Ft7ETgnnZOJAa
	07Zw==
X-Google-Smtp-Source: AGHT+IFUlkb3C+Glf9u4hxqu0nO7XLq9SBtXeRki9vTIOWRFvH1ngxDUM3geMGk1M8mo69tNwsvjmjzG8RyQ
X-Received: by 2002:a05:6602:60c8:b0:887:1062:5efb with SMTP id ca18e2360f4ac-89d27ddf8edmr129729939f.13.1758082175280;
        Tue, 16 Sep 2025 21:09:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5166abc0d53sm605502173.28.2025.09.16.21.09.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737e673so7954092a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082174; x=1758686974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUEIX0FP9Dl4IxlF6+h5nDbwqqrS0Xlw4YysY3ryNrg=;
        b=H2nUkk24SSBHMzFRtUnlT/gng47Vtmd/Uh/DiggxlgeN8ZLkPwh63EVK+nuy7uv/GZ
         bUk25dOD3gkNT24ju5KNICv5lcPKcetp5ul1ZKU9JCr8iX+qnLBCH72Ppm1Gm9DvHD1J
         g94WHxwqpjE5OjVv2IF3b4ja+DHEWNU0h5f3U=
X-Received: by 2002:a05:6a21:3086:b0:263:7cc6:1c3b with SMTP id adf61e73a8af0-27ab730a7bdmr840741637.60.1758082173631;
        Tue, 16 Sep 2025 21:09:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:3086:b0:263:7cc6:1c3b with SMTP id adf61e73a8af0-27ab730a7bdmr840718637.60.1758082173239;
        Tue, 16 Sep 2025 21:09:33 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:32 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 10/10] bnxt_en: Implement ethtool .set_tunable() for ETHTOOL_PFC_PREVENTION_TOUT
Date: Tue, 16 Sep 2025 21:08:39 -0700
Message-ID: <20250917040839.1924698-11-michael.chan@broadcom.com>
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


