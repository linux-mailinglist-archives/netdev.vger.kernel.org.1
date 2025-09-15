Return-Path: <netdev+bounces-222910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872CB56EB1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B0D17B1AD
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026D215F5C;
	Mon, 15 Sep 2025 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CIojWejn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBC22F75B
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905567; cv=none; b=NSeUhF61N35tzA/anvMGeIB9GiG3v2GkhExuKHuBUMxXMx271QS5e2BaoYF1P1g5nhVqKOdcuJfN8GxtQq1z93jjlTGAL1gmX+ZfSfdgWDN/NO8Sp+Slbscu/JFrwnNYRZHShF+KWQBqSYSwo50NnFygz6ES15TBd1byQegOXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905567; c=relaxed/simple;
	bh=wtkL5DHqFURGVN+d+i91d+vz0NScfo12n6jAYJ4agko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMeBIqilKw5gfTSqQ/lIXVWHfqjmv4Ij4Zll5wGZmu0UQqNN3QDk7BOvr/XcMf7dHTfFrb4l9NsxDtC7KS6yO7d25E21/zQ7TPYt5peyJEbqfVY10GQr/T+p1xQ3dAQ9Zl+XYAimICy8Z6M0MNNar0llR9Qp8ZkxOjVdn1MJ7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CIojWejn; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-559cd5166bbso262268137.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905564; x=1758510364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZVd3+ZhKxHycnqwGZkQtACeRnTx3QVNbbfGQy/YVTE=;
        b=bLf19NmfsRmIJL7OQBsNUDCQ1B10DASH8f5EcQadHKcdl2TWbBY3KtUM/6YT3KQ64Q
         ryMYXqFmoZF2eoHEmJqncLZRKgcMCgc3TkuhsZZG55GW2tgrupkwCClpEI/qW89DtJ2K
         1SlQZMRanlCfpnb3irWFwzWbk7ktaO8iiFxYfRaWrFsilCiJWGwz+0Q+iTeYp7hmFc9l
         x/A+j97EIcEcNqb+yGqmXxSWKV5LSrBQH5wBnSQKGRwU+cOQRndM0vThG0BgObfQ1Ssb
         SrWTcBJtwjH58Fv2SgJIUPKPptEwJQOadsD1Oy8vqmhXwsdXv3GHMLk5CbglLZKDVIl7
         NCbw==
X-Gm-Message-State: AOJu0YymX1iamqgN42Puh8SlXb56PVOCqOCOejM9Lbl++o4MZ34yfATD
	NUZhVfzsWiTTcIUbfBd96DIh9gJwWag1RJZR6ziZV3r1TyUpuLxzkhdCMGewSwmnnFLm3UtsHNK
	eHqCSFT4LwWmM7VHbjuFw4ALeCYTCY/ZudpuA8hJW+R8b2Aghqxz+2wCCBy+Ljt/KhShLMI/YvW
	b5ngqzdUJFMbUlx5dbCiDJrjQt2TlregRim6NpVwfXxOD1pCt8QFDV9W1mY/84P+KQIDBIujFTh
	q9jx/u0+EY=
X-Gm-Gg: ASbGncuPaqkppJpeX2uX78wbuaUch5DTjmU+9QJEP0aLHbgHwbfvj2tJwv+BW8Plh+p
	L7lAGdVxE0wJhZRTyMS97vQNzEoFGiNRzULmfPBcnem7NztHaUqjU8pgR/OLyFy0aNoLz9C1hlU
	y/rMCkXLDTvr0KMlSM5nwN//wFCtwnKvxWTPKdNDYZWKlsdXPmc01zj2D9tXAkBWloi13kHPkux
	ksevRu2aXkiVR4a+uJBw2ec8TspSBriftbu8nAXVayweew4TeILW+HF1ZIAgR7f4rs4zLUcvnsj
	N2HiwK5df72f2xB1CA+tz7YuGvfsGr9s2L2qCALz8tGilAqMDTP58a7DogqOr+flH09XAlFbNQO
	Ar1PTKbtmdXaIHYga1kLFzsk9BjRJalVoYIJSGCsguJ0YI5yjx2JBsmxhB4ZFGGkACv9a6RfmFR
	A=
X-Google-Smtp-Source: AGHT+IGVV22inbZS7TWnKRiIlhtE0p2V191nrM4PUU092aZAxCRK9IwsI1+jeHnyRVKWBeDiGp2T9oylkJNi
X-Received: by 2002:a05:6102:b12:b0:520:a44f:3dd6 with SMTP id ada2fe7eead31-5560a3ff4dfmr3461749137.8.1757905564599;
        Sun, 14 Sep 2025 20:06:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-55377959e3bsm971294137.4.2025.09.14.20.06.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:06:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2621fab9befso12401665ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905563; x=1758510363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZVd3+ZhKxHycnqwGZkQtACeRnTx3QVNbbfGQy/YVTE=;
        b=CIojWejn9qRjP4jBeO613C3SlwFB0DIIwZbQF1W3hAUMCP3LcUuYqSPRFGKXjJ7E36
         j22o/iMMcNJhbmHxa9qIT/soEIRVMAuJihRTqez2iqkZZc3U3Z2uCLvrjjOvgNNcJFyC
         u7CR8LyQpIZlusvP/Sl7trePazDrFWkBKNPkQ=
X-Received: by 2002:a17:903:2f06:b0:24e:47ea:9519 with SMTP id d9443c01a7336-25d2771f10dmr115122645ad.47.1757905562643;
        Sun, 14 Sep 2025 20:06:02 -0700 (PDT)
X-Received: by 2002:a17:903:2f06:b0:24e:47ea:9519 with SMTP id d9443c01a7336-25d2771f10dmr115122335ad.47.1757905562179;
        Sun, 14 Sep 2025 20:06:02 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:06:01 -0700 (PDT)
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
Subject: [PATCH net-next 10/11] bnxt_en: Implement ethtool .get_tunable() for ETHTOOL_PFC_PREVENTION_TOUT
Date: Sun, 14 Sep 2025 20:05:04 -0700
Message-ID: <20250915030505.1803478-11-michael.chan@broadcom.com>
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
index f63e5dd429db..47579dc7e080 100644
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


