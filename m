Return-Path: <netdev+bounces-223850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E977B7D845
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCF12A7EFD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190622FB091;
	Wed, 17 Sep 2025 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JK6EALv4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5B3019BF
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082176; cv=none; b=kCtTW4Tgiqf4XJMEGxJedEZM/7lZCVOKFHehPuipa0Tb0mquPsaFDSmGWTPAoJu/6mZulBuFE7+cD6UEuJ6dI3dlohfJqFV64iiB3AQGMtTgaPzRyEXLppGxcrfWn6ML6wkYNREzCg2AIp0M9zJonyDl5LxxFnj3OKAjZh5QBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082176; c=relaxed/simple;
	bh=KxTog2HVSQ9+2z6H+r7eL7DPQUe9cFHspa+iv5tBujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiT0yLs1sw726cjUrZRZ4yiq4BAvtCRUEEyIICbraTpVeyx7hjvoJZAIe6aPGWNMznKhxCSE29kmLCA55yczhsATEtnkIs95xY61SvpV0PKteJkfRBDXNYOCdgN1LQnu1tcvp75GjqSdp+Nf2oRKBCSPPxsc/2gR9h5Nj46PDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JK6EALv4; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-72ce9790acdso54188217b3.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082173; x=1758686973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hmjGD8FU+/JHUYZb/3Aq3By4o4CfUNUbyYirjX1nnk=;
        b=Yo8Dye9ILl2b9+rJEGMjYsYkgSYcx+XOSylYFpMke9ZrfuA38jeFEBstMFAHqVGIkx
         5Lt+DTF+8tCRPbCnQuEew2K1MxjKAmG9guFZpJML98jqaHnQFnPOKt/lZGYiAETXFzWL
         TC2X2FBwqlXa2guQH7FZ6nylbs/rGgY+qOp9pHA4jAJaodOTgeKYFWfquR054Yk7nDtC
         OBhhnsfwqDLK+B8YRECc0akot6xE5ylcnah6DNCxwqzCZIyHO0lNGxvjSjzRakYlqJGb
         0dDtEiJ2lZsdw0itQt+62dTAkCfFgHGnl9gJxMJyckM2Ca3vEB7Umi98X6917lzW3Qp5
         RyPg==
X-Gm-Message-State: AOJu0YzGbczd3EvxsUkWJtdzE9xm3b97VctVC2OA0o13u8RKiznB3OUb
	HD6xk24/kqQhCZF9C7+N4SXaPIEj/QsJRigGj7dBve1kXFq2NxHaggMT9mcx1BS07dI7bV9Z8dw
	GF7FcLeIMYArdn5sCKY2TbdVxP9b/JLo3U5v9mNhPatlvNWj1BxfwmWPtttjrK8EiMLDxW+Yxvq
	wMeTR2rEkkBVfZs203iyPqHwXpKgubpgNGN/7BRv6a7X23FAz2w47fPz1FKFBzhezk7syzGSHgO
	ODpwdoCQJ4=
X-Gm-Gg: ASbGnctIsgH+C6rBAueJNB2PsH1cPx8/DiqmFfzPUYyRxCe/RkBH4MYHyVoCzUR9Dz5
	aGyWiDkCrsUCyI3QLKeFfmeGHrhBLTi19FJY0cvCKy+L3fp0HreouK9JohhbYCL71DVLKM9twqM
	nRx3Fbenukri1S+/PAyrnGRj/ilndW55zRc+n0Do3cPHQKki37vEPZLcKF7asSh9/E4o6bYsGSc
	OXtOwr4AcbUkM+9xuKURBoQr0dXDdG3yqqbrfjtuhqNsPYj6+zIrH/dsgi4jV4RRXrTwTnKp1gK
	feFEow4oAtPS7EBT8HATtQXf3SYuq/CQOwwbM2j4/CuYLEs+Hma59YiGbZv34SlzHl6AkFbsyiX
	0EpKNGdYfFSu8A+KZ9Z7Vi1C3ygyP+23jfnz2jx7lE7xmw9DeMnqq482FCVk5KtZhwf/+rOBLSL
	MM0g==
X-Google-Smtp-Source: AGHT+IHg74AAfR3COV2efmqP2qNmMUIdx8bFH0X91EFdT3M1hcBWOlPH1TxYOWN09va5n5zM0m9QQ1x5NPrK
X-Received: by 2002:a05:690c:7281:b0:731:6570:132 with SMTP id 00721157ae682-73891b87069mr5926517b3.35.1758082173350;
        Tue, 16 Sep 2025 21:09:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-72f7760d5bdsm9948207b3.19.2025.09.16.21.09.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32df881dcc5so3925060a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082172; x=1758686972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hmjGD8FU+/JHUYZb/3Aq3By4o4CfUNUbyYirjX1nnk=;
        b=JK6EALv4nDelKgNaTzAdegNrbu0M2EmIVVJE02wCYjEOu1jgKBb4qe+jHD/hJaCvqq
         l5jNJTib1S94MkrK0d+I7r5JKGUkifnsk4Y5JGZJm+kL7rV8gwIsAYsoTwHDbREIQg5V
         EzB7Rj/St2pkP8zzDzTwQglXp/jZvjwuN0LS0=
X-Received: by 2002:a17:90b:5348:b0:32b:d8bf:c785 with SMTP id 98e67ed59e1d1-32ee3f141cbmr969562a91.20.1758082171927;
        Tue, 16 Sep 2025 21:09:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5348:b0:32b:d8bf:c785 with SMTP id 98e67ed59e1d1-32ee3f141cbmr969540a91.20.1758082171435;
        Tue, 16 Sep 2025 21:09:31 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:30 -0700 (PDT)
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
Subject: [PATCH net-next v2 09/10] bnxt_en: Implement ethtool .get_tunable() for ETHTOOL_PFC_PREVENTION_TOUT
Date: Tue, 16 Sep 2025 21:08:38 -0700
Message-ID: <20250917040839.1924698-10-michael.chan@broadcom.com>
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

Return the current PFC watchdog timeout value if it is supported.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 18 +++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 ++++++++++
 include/linux/bnxt/hsi.h                      | 40 +++++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c49a4755a94d..d59612d1e176 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14748,6 +14748,23 @@ static bool bnxt_fw_pre_resv_vnics(struct bnxt *bp)
 	return false;
 }
 
+static void bnxt_hwrm_pfcwd_qcaps(struct bnxt *bp)
+{
+	struct hwrm_queue_pfcwd_timeout_qcaps_output *resp;
+	struct hwrm_queue_pfcwd_timeout_qcaps_input *req;
+	int rc;
+
+	bp->max_pfcwd_tmo_ms = 0;
+	rc = hwrm_req_init(bp, req, HWRM_QUEUE_PFCWD_TIMEOUT_QCAPS);
+	if (rc)
+		return;
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send_silent(bp, req);
+	if (!rc)
+		bp->max_pfcwd_tmo_ms = le16_to_cpu(resp->max_pfcwd_timeout);
+	hwrm_req_drop(bp, req);
+}
+
 static int bnxt_fw_init_one_p1(struct bnxt *bp)
 {
 	int rc;
@@ -14825,6 +14842,7 @@ static int bnxt_fw_init_one_p2(struct bnxt *bp)
 	if (bnxt_fw_pre_resv_vnics(bp))
 		bp->fw_cap |= BNXT_FW_CAP_PRE_RESV_VNICS;
 
+	bnxt_hwrm_pfcwd_qcaps(bp);
 	bnxt_hwrm_func_qcfg(bp);
 	bnxt_hwrm_vnic_qcaps(bp);
 	bnxt_hwrm_port_led_qcaps(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c0f46eaf91c0..06a4c2afdf8a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2426,6 +2426,8 @@ struct bnxt {
 	u8			max_q;
 	u8			num_tc;
 
+	u16			max_pfcwd_tmo_ms;
+
 	u8			tph_mode;
 
 	unsigned int		current_interval;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2830a2b17a27..d94a8a2bf0f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4399,6 +4399,23 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 	return 0;
 }
 
+static int bnxt_hwrm_pfcwd_qcfg(struct bnxt *bp, u16 *val)
+{
+	struct hwrm_queue_pfcwd_timeout_qcfg_output *resp;
+	struct hwrm_queue_pfcwd_timeout_qcfg_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_QUEUE_PFCWD_TIMEOUT_QCFG);
+	if (rc)
+		return rc;
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (!rc)
+		*val = le16_to_cpu(resp->pfcwd_timeout_value);
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
 static int bnxt_set_tunable(struct net_device *dev,
 			    const struct ethtool_tunable *tuna,
 			    const void *data)
@@ -4431,6 +4448,10 @@ static int bnxt_get_tunable(struct net_device *dev,
 	case ETHTOOL_RX_COPYBREAK:
 		*(u32 *)data = bp->rx_copybreak;
 		break;
+	case ETHTOOL_PFC_PREVENTION_TOUT:
+		if (!bp->max_pfcwd_tmo_ms)
+			return -EOPNOTSUPP;
+		return bnxt_hwrm_pfcwd_qcfg(bp, data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/linux/bnxt/hsi.h b/include/linux/bnxt/hsi.h
index 8c5dac3b3ef3..23e7b1290a92 100644
--- a/include/linux/bnxt/hsi.h
+++ b/include/linux/bnxt/hsi.h
@@ -6751,6 +6751,46 @@ struct hwrm_queue_dscp2pri_cfg_output {
 	u8	valid;
 };
 
+/* hwrm_queue_pfcwd_timeout_qcaps_input (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_queue_pfcwd_timeout_qcaps_output (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	max_pfcwd_timeout;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* hwrm_queue_pfcwd_timeout_qcfg_input (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_qcfg_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+};
+
+/* hwrm_queue_pfcwd_timeout_qcfg_output (size:128b/16B) */
+struct hwrm_queue_pfcwd_timeout_qcfg_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	pfcwd_timeout_value;
+	u8	unused_0[5];
+	u8	valid;
+};
+
 /* hwrm_vnic_alloc_input (size:192b/24B) */
 struct hwrm_vnic_alloc_input {
 	__le16	req_type;
-- 
2.51.0


