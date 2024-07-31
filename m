Return-Path: <netdev+bounces-114596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B24942FE2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7C1B27114
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBB1B0123;
	Wed, 31 Jul 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="dba+sRbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14F4369A
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431749; cv=none; b=NkD4/RQtUj3t8UehpKI/j/3pkmTFfCf9xXghGIx1pYgQA9v4dNn5jbwoRSGbH8coLr3I2xmzS6qJAOhFbw/WqzafRM09h+VG41JyfUt/AuQc+JTO+yoyEYjM91hboh8ikLjRe+4Q15pkiTiOCBTaEB6JbN4tYv89z5Lqgw20sfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431749; c=relaxed/simple;
	bh=OGp1/miJhRdYorPHp/x7QtdybzfAitsP3q0qYSuWOhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyTJ+WTcLMuRqAvj1b6gndQZX1ZfD5kUAmwFgJ9dxaYALMhTEOUo77J4MQ4OlVcyNV1kb+3P1IiMF2hPfxu09x2sIqwzfZYlQPzGAAYOWetRc7g3Gl9vx5omrT9pVBGA6No1we2T9IEd63I5nFikXGAR7axM4jK3wmH5BWCrj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=dba+sRbq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so806089a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722431747; x=1723036547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGQp1DrDWAPch6PwECH96r+ViRGpUT3tNGLOlIDiv8w=;
        b=dba+sRbqnNPXgoRjVk1Fzpm7u/YiFqod00AfQ5hwAcZHhWZ2f23XVUKUeGljbUanh4
         zVfq/cidXk2t8btTOUbEOZ5i5b4PYsZKxwmey5WPtOtiZ1SyuQGPV5si3NvVzVERF7wO
         h5MVwN5X9phtbY21RUCV+Gee8kX+EnBDMGXSK3J6Fy7SXaf3qXZAWZbMNrQX31//DJmC
         v2MyFhvYZ8wykTtHTsGhL/aV8KoPr+4VLwxky6QAYZeD6eXEdaYBkDV/HDoyYG/sQTr1
         DeG9r06wZbcKZ3q+FGvnD2nR1hxkFOr3ci2AX+03vT28uNGjcziQfHCF/uCgfMoQ8wyD
         bd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431747; x=1723036547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGQp1DrDWAPch6PwECH96r+ViRGpUT3tNGLOlIDiv8w=;
        b=PjVVV8mrQxR0/8cWPRHmFmn2w/pCT7+MU/+jYZCzc4aAQx/Tvbshjq0TwjDKsIUCyh
         iCSFXzwzNtE8tIGd0TelCbdlgJuWpY0CC6Fahx2XLFKC+8sUdKq30C9LZPZLiPhPbIUF
         6AySEYL901eB5UG5IYSDUhCXXjHv8s6xb1CrpNjvQTAhqm9nsGpn4nELNMCz/for6izU
         A+mwve0vmJId7OZk3HbyAmrJz8Ux69rjCIrcMgi5k4C1+gS9b7vItYWKj4baMwOqK4an
         GjOmzaUC6j4AYNXUO/wq6CXtAc6bJmzF3WOtJzz50JZFGCk2mmHKnJLCkbaS+UgqZgro
         lFfA==
X-Gm-Message-State: AOJu0YyImLT2ulQ52jBmvvy91Ih28W2iXjmFhyDwB74vC2iHsXt8ArUj
	ZJPZ02NBCHERvDcQFfD8Fk6wbwBH5Dmi1DzfhSwoiEF32CeXZk+ev93YbLYL9BfJw0ducDBvT0I
	2kGA=
X-Google-Smtp-Source: AGHT+IFuwYShzSiZ0BmKL53X2OHzAVgWUqE39TF0r/lK1kQt142jBql63t/6lwsirJuCpODysDal5w==
X-Received: by 2002:a17:90b:1c85:b0:2c8:2236:e2c3 with SMTP id 98e67ed59e1d1-2cfcab89df6mr8722592a91.17.1722431747424;
        Wed, 31 Jul 2024 06:15:47 -0700 (PDT)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc451415sm1301857a91.22.2024.07.31.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:15:47 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v2 1/4] bnxt_en: Add support to call FW to update a VNIC
Date: Wed, 31 Jul 2024 06:15:39 -0700
Message-ID: <20240731131542.3359733-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731131542.3359733-1-dw@davidwei.uk>
References: <20240731131542.3359733-1-dw@davidwei.uk>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 20 ++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 37 +++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ffa74c26ee53..52998065956e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10086,6 +10086,26 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
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
index 6bbdc718c3a7..5de67f718993 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1250,6 +1250,7 @@ struct bnxt_vnic_info {
 #define BNXT_MAX_CTX_PER_VNIC	8
 	u16		fw_rss_cos_lb_ctx[BNXT_MAX_CTX_PER_VNIC];
 	u16		fw_l2_ctx_id;
+	u16		mru;
 #define BNXT_MAX_UC_ADDRS	4
 	struct bnxt_l2_filter *l2_filters[BNXT_MAX_UC_ADDRS];
 				/* index 0 always dev_addr */
@@ -2838,6 +2839,8 @@ int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
 int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_qcaps(struct bnxt *bp);
 int bnxt_hwrm_fw_set_time(struct bnxt *);
+int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			  u8 valid);
 int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index f219709f9563..933f48a62586 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -6510,6 +6510,43 @@ struct hwrm_vnic_alloc_output {
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


