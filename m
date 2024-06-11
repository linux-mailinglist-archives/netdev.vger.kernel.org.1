Return-Path: <netdev+bounces-102424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B206902E6D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D3EB2183D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64E516F900;
	Tue, 11 Jun 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="US9BabTF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6E16F8F5
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073209; cv=none; b=qmOyH6NlATx2VWjRNhygGzQC8HViTKv3PC82pDoChv9WglBFAdZiblr1tDFmDetDfZskGuqX4BFf/V6HyAauFDuFNr/WxjRiho1CdrXOuq2b/Bhc6PVKSBUR+o/9rYBpe9GGEbiHX1KePpx3S1cnuTbrDqFTy5bg3KaYbqJKAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073209; c=relaxed/simple;
	bh=ZYiFy4CK1PcF4WT/NBFQLu/AyYn4DY3wG81HGkdX4RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUjtDeSyd1sgJnGkdSs30I76hYfhCizBm8zeLn7qhs9wzHmlMKARC5+LLNkjlOe8st2PmW0FNzIDe+oz2Py69QeJqbky3WVuT7yLn/HHhU5FbfLmoOJAjDQp6uslOFuEJaFd0KWKs31UNg9Qst6tr+zvshZVGALJPxoIJ4uNxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=US9BabTF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f6a045d476so552271b3a.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718073207; x=1718678007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGcTN3m/FpOGu02+GuBw+yIPNHlDUBbcXeKF+qBtQus=;
        b=US9BabTFjhrAYkug8ykNM8UuqOG2UKnSXUrrgUWTDHzZEm8ooteahOA3TZsv6nmzdC
         tsXE+w7WTDEHxci9j4JRoQPCh9gRtf0L8nfjdjxbs0AbnJ5thMFQ5f3mwvzb8HF6od5m
         TDWuEArq5iNPvJzF29ET7OizB8Mp0wXoSMd01L1nqG0vI2ZdD4Ox+odAUL+JGbNcfCGt
         gLLzbKfACdHU4w0bvA0qcnOcc5tMrmB1NrVCXX/ZyyhOuxo0YXJlWOK7GH8WDGPECDEU
         gfQfTUKK4/LI+35GcaKvIruIkWtxVJynvJyru/d74l5vuLYxvA5xT50roKHqmeALESpi
         ydlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073207; x=1718678007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGcTN3m/FpOGu02+GuBw+yIPNHlDUBbcXeKF+qBtQus=;
        b=sxUCGs31fsEFC8B6Do8PwKjPYgfzF7wvi4BhXMpuP2RbykZ6fx1b3Wmf4TMCH7AGKj
         GN925P4seQjR2ZnEIT/kN7rLFOMaH7jkHPrTfCCFnPfGJV9PC7bqWzEt0kek0rnR+1K8
         aM2z6nRBgyVfOreDg85sNqeCOJUAk65jq2q2jpKKH60RL9/H5r8TzAyiz3XPvh/caLDp
         0akgJGOME6kO47D16LnqWknfrq7EYCZuNScJnb5/hiZBZz3hiUn+8uQem9765UgA7ZYg
         4RJXBuR2ETAerE6Qw861Km7hXWxti+xJwhvJ9iHXWE4vg6jh/jy8eAec7jhwu7d/swL9
         ZB2w==
X-Forwarded-Encrypted: i=1; AJvYcCWtNh87K0DmdVrriKhJ3+9D/n+gFq567TzTAs3VfpMmGlV6P8q1X3bGK8GMGHk6Tk+keMua2Z0NoyvUmkGiyAjZ8fzUr6Ux
X-Gm-Message-State: AOJu0YzxmzO9Fe5vqxmTRWJi52BZm2rEEej01QdvFJrV4bq2vdmoYfjl
	XNqRpR3T7E0p6K6cWDBg8cW3AeypW89GlomGjhbRh5fzHapX3HbzFA96ry9n2+Q=
X-Google-Smtp-Source: AGHT+IGaVfMHo67LuAy8r2HjlET2se7jGH9l2BR/4zoJ/6/obgN0dGrYmhnawRLsXOL6akTLe+rzaQ==
X-Received: by 2002:a05:6a20:da86:b0:1b6:98ba:8df5 with SMTP id adf61e73a8af0-1b698ba8ef5mr5632834637.21.1718073207258;
        Mon, 10 Jun 2024 19:33:27 -0700 (PDT)
Received: from localhost (fwdproxy-prn-004.fbsv.net. [2a03:2880:ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041d383a46sm5300592b3a.93.2024.06.10.19.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 19:33:26 -0700 (PDT)
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
Subject: [PATCH net-next v1 1/3] bnxt_en: Add support to call FW to update a VNIC
Date: Mon, 10 Jun 2024 19:33:22 -0700
Message-ID: <20240611023324.1485426-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611023324.1485426-1-dw@davidwei.uk>
References: <20240611023324.1485426-1-dw@davidwei.uk>
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
index 656ab81c0272..fb989dd97db9 100644
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
@@ -2753,6 +2754,8 @@ int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
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


