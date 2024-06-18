Return-Path: <netdev+bounces-104339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B973090C338
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BFA1F22CF8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EC1CD32;
	Tue, 18 Jun 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="V3TF+ZGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AC53A9
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689932; cv=none; b=qqXahclOiGAID8kPVDMwRf2yiHXHjUNN2zKU9vjs6952p2kICP5nqHRsfGkFR5NqfIuzWh5g7rgbKxvMFPYDyYD5lU0SoKV9cusXxLw9phBZqs3XYjhBov7H0L1y2L0C5C3yroXbZsbN35uDaZyLX3VFuloH65W//1RoN9FZgPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689932; c=relaxed/simple;
	bh=du2b3PfuNUykAkmTF2Zv9pyJvNRomoqAfo8fS8nU7Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG0KaVhzuqDOrbPbZki4tENF6PpZX85suXkddb2MX68BQUhmIlu/79h39xKjSXTUiDiGkTaV+rbJpk0uL/1n00eZGXXnA7K8BlVD/MCeSI0uoSVdjcrEtkBH8wFvqwQLjFOE2dS+WSZKAsPEw4RZ1K+K2+Cg5SqCS1goYgTh9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=V3TF+ZGj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c722e54db8so227533a91.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718689930; x=1719294730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msOxcyV8VjH6q5sS4BAiMymQqdsZXLK1ahhPrbf9XKI=;
        b=V3TF+ZGjJIR7Dt+YehvB13WQ2tUbLVa1C6tFJCTjIat5varcPccIL5G9P3K4DZInyP
         +usSXBetqmdCdwQ8I0o7sZJHZeGDVK+eUuo8K7eV2iRYVolVnDFvDJN/npwm/nTjnoUB
         ZXMg5qPpMOkLTMioCOPs33Y3JeuuqJbddGqNj19WwgIX1ow7eCPSqsiXR9w1Neozi1rX
         Yu4cbbmT0dNuK7cSlaCHU3astZhuyNuGYOvFovGeHUjB2hNeN7JGVIc/KuxSlrvZpd+k
         yCpnIid7gtx2i+BBo6OR2vBbiNvFRvNUeqWEb68PuglKrkOwIWjZgUznPSNmMk2ouNrn
         Q9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718689930; x=1719294730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msOxcyV8VjH6q5sS4BAiMymQqdsZXLK1ahhPrbf9XKI=;
        b=wuInXtv10pfR6FdjJXCxHNd05UOz1vHOcObkeGDot/Z0m1oxigAbTkt4jrjkJzWj/m
         h9DCw10nMJqWnp4hF8tNkREIFGum62HaPKmDda9Hx796hez9BtgNYYBaGwpo/bhJi476
         8f6//picOS8qTeXoYB0EeTSg62s3tA76s0VrqH0kXzq5RiePMCxseMrVNlbOKxw9UawY
         XfsyZjQ0dX2D/IxFa2fzksj2ASpHJVUNUekDlAVU5rowqhrtZzOEpCzGOruOfpiI6Zzd
         QgshfXh//FuPvjR8lgmrmDOFRHj+mjORDllVzerQuFhI23vxqzjmiACNWmaxVE1cNV01
         pDfA==
X-Forwarded-Encrypted: i=1; AJvYcCWsV41687cjKbH/xMrSe8mdD7j4et1g7XIkZThyY1Qti/o/GGUUFAms6ZTgnkIXSTb/lPpbXRDq4ueoWV63MNsrhsa3vsHi
X-Gm-Message-State: AOJu0Yz4Bt7KUhHphUBaw08nA1fAE0LN4SEtogR16Tv1IK9oW4/jDyhd
	Jl7VQ5BKd+cbFglRMA4IsyUETg2A9Fk2lOmTceyexdvkfrpk+22O9HNzPqs0Thk=
X-Google-Smtp-Source: AGHT+IHOqEJIhLriX1eyfyArZi0FEAxsAgrFYIx8uirL92Y/sBsaBYXB79IOo60S/BoM3SinPxu3IA==
X-Received: by 2002:a17:90a:df91:b0:2c2:c96c:5390 with SMTP id 98e67ed59e1d1-2c4db13505cmr11479829a91.1.1718689930191;
        Mon, 17 Jun 2024 22:52:10 -0700 (PDT)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75d20b4sm12333557a91.7.2024.06.17.22.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:52:09 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/3] bnxt_en: Add support to call FW to update a VNIC
Date: Mon, 17 Jun 2024 22:52:00 -0700
Message-ID: <20240618055202.2530064-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618055202.2530064-1-dw@davidwei.uk>
References: <20240618055202.2530064-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

Add the HWRM_VNIC_UPDATE message structures and the function to
send the message to firmware.  This message can be used when
disabling and enabling a receive ring within a VNIC.  The mru
which is the maximum receive size of packets received by the
VNIC can be updated.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 37 +++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7dc00c0d8992..ebcf393f06dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6452,7 +6452,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
 	req->lb_rule = cpu_to_le16(0xffff);
 vnic_mru:
-	req->mru = cpu_to_le16(bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
+	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	req->mru = cpu_to_le16(vnic->mru);
 
 	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
 #ifdef CONFIG_BNXT_SRIOV
@@ -9912,6 +9913,26 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	return rc;
 }
 
+int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			  u8 valid)
+{
+	struct hwrm_vnic_update_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_VNIC_UPDATE);
+	if (rc)
+		return rc;
+
+	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
+
+	if (valid & VNIC_UPDATE_REQ_ENABLES_MRU_VALID)
+		req->mru = cpu_to_le16(vnic->mru);
+
+	req->enables = cpu_to_le32(valid);
+
+	return hwrm_req_send(bp, req);
+}
+
 int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	int rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bbc7edccd5a4..af4229026ed6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1221,6 +1221,7 @@ struct bnxt_vnic_info {
 #define BNXT_MAX_CTX_PER_VNIC	8
 	u16		fw_rss_cos_lb_ctx[BNXT_MAX_CTX_PER_VNIC];
 	u16		fw_l2_ctx_id;
+	u16		mru;
 #define BNXT_MAX_UC_ADDRS	4
 	struct bnxt_l2_filter *l2_filters[BNXT_MAX_UC_ADDRS];
 				/* index 0 always dev_addr */
@@ -2804,6 +2805,8 @@ int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
 int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_qcaps(struct bnxt *bp);
 int bnxt_hwrm_fw_set_time(struct bnxt *);
+int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			  u8 valid);
 int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index 06ea86c80be1..abb1463b056c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -6469,6 +6469,43 @@ struct hwrm_vnic_alloc_output {
 	u8	valid;
 };
 
+/* hwrm_vnic_update_input (size:256b/32B) */
+struct hwrm_vnic_update_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	vnic_id;
+	__le32	enables;
+	#define VNIC_UPDATE_REQ_ENABLES_VNIC_STATE_VALID               0x1UL
+	#define VNIC_UPDATE_REQ_ENABLES_MRU_VALID                      0x2UL
+	#define VNIC_UPDATE_REQ_ENABLES_METADATA_FORMAT_TYPE_VALID     0x4UL
+	u8	vnic_state;
+	#define VNIC_UPDATE_REQ_VNIC_STATE_NORMAL 0x0UL
+	#define VNIC_UPDATE_REQ_VNIC_STATE_DROP   0x1UL
+	#define VNIC_UPDATE_REQ_VNIC_STATE_LAST  VNIC_UPDATE_REQ_VNIC_STATE_DROP
+	u8	metadata_format_type;
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_0 0x0UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_1 0x1UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_2 0x2UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_3 0x3UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4 0x4UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_LAST VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4
+	__le16	mru;
+	u8	unused_1[4];
+};
+
+/* hwrm_vnic_update_output (size:128b/16B) */
+struct hwrm_vnic_update_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
 /* hwrm_vnic_free_input (size:192b/24B) */
 struct hwrm_vnic_free_input {
 	__le16	req_type;
-- 
2.43.0


