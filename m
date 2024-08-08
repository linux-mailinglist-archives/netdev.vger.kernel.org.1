Return-Path: <netdev+bounces-116694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797E094B61F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2EF1C21D25
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3E13D63E;
	Thu,  8 Aug 2024 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="T90OgOvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D413664E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094125; cv=none; b=Su2a+Q6+0cj3la+NxtT7xpcirYQXWjm4wi3fK1XjHby5T85ZUJYZqKYciIoHu1SgZz92gcNRHim2A1QIcVPrORyl8nXU5aPP+1EJ2glMvZQH2K/3DgQc7vW46HJ0sC2KVs/gMV9jd3ibjwJkbGJiKuE0fKpwZbg/lBF29G0xYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094125; c=relaxed/simple;
	bh=IzTtcrrOD4bk1M34srROcg6zRAjCB6jQILbfOESuSTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpWBfpkcT38rG/7dGbSdwiImQD5gGwDVs3CZhC/Law1jVtfJTPKkD+w1o3t2OEEYG34viqH/6WuAnD9YaLCO1HwKBj50doZ+Vsz+spXdn8lF+2uV+Nc2awYYHO7NsDuje5vqGcCATb7UUyxGd+R/MKvIcUVLi34C/VIjXswD+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=T90OgOvG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc587361b6so5916255ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1723094123; x=1723698923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30bOu+E333/nxCpo+sEAcMBEHaQACesKxcBjqzLsJZQ=;
        b=T90OgOvGEGfMqD7Z9k6OTmpHRYwUtH7t1TFxuM+5laxDqdr6S+yd5QX99pLwayJHdJ
         7QwxOpWqGh12zq44Whq51emimBThJz7D0AQiRZQICBbqCD/wg/iEhlOCIvCADjczrMV2
         FK7hv/wkkXognU4lW8Ug270rfS6xXopV8WQv+ryjWoM55Be+VH8kKjLxT2U7I5xfIUvh
         iDVoOO3lKuTx4Jnc0rLqE3KeKTyetXI3QX6o/8hVMfO4jPDZOQ3O0g2OwjWyoUMpKBpV
         lorlxZ+kkzEAelBvCJ/mR3pAeNwCQw3COV/gGbAOFbYlmysYSLq/KTy6xCObGc62C/Xi
         NZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094123; x=1723698923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30bOu+E333/nxCpo+sEAcMBEHaQACesKxcBjqzLsJZQ=;
        b=EqhKw45i7AUagxHvUwhl5Vcb7UCVJ9kAFxv8CBgGjteT/Tr1d0p6WqSfds1W1BHelK
         dNTAGt/ZqNsMltVQg1/Mgct9TK+3ylBv44IUIdWlS0BBByobjK2QUcjIijbOqnRtIo6/
         uhinax7RuaCqvFF4lWEsobWrVjymjY1JaOo5kPjkwRPfbvnVcsqoFKLZms10Wi+FJTrz
         nYL6nfwo0KXSacufUB47NFy13dtT5YhqJ/pNhkOPUZ2HfZQ47xDKH1xfUhvK2p2i0hLH
         OpWQJOphVv6OYfpGizHWOkhhDHdlPai0ODcUc9ifkyTCo0UW1T33oBQJZjOIJWNXxMKf
         YihQ==
X-Gm-Message-State: AOJu0Yw9qGEwSP10TlGK2/f4ktLLQeAqnUcJXrF95tmpfVM/yaWrRiZm
	u0t0jXvJZgaklVWbxzz6lm/XnMMnhqmtNx9x6ScCG4Rir0ltiupvxE1fAoqle9WVdD5wBsgPJHh
	z
X-Google-Smtp-Source: AGHT+IGi851EIbI9hpVN0nouwymJQMyGnzsCLd+4hcYCDqx9NMrc6eucM5Hpu8jezOr7GA1LcElmaw==
X-Received: by 2002:a17:902:cf09:b0:1fc:6a13:a39c with SMTP id d9443c01a7336-200952247e6mr7329785ad.1.1723094123572;
        Wed, 07 Aug 2024 22:15:23 -0700 (PDT)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f58702sm115714985ad.103.2024.08.07.22.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 22:15:23 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v3 2/6] bnxt_en: Add support to call FW to update a VNIC
Date: Wed,  7 Aug 2024 22:15:14 -0700
Message-ID: <20240808051518.3580248-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808051518.3580248-1-dw@davidwei.uk>
References: <20240808051518.3580248-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

Add the function bnxt_hwrm_vnic_update() to call FW to update
a VNIC.  This call can be used when disabling and enabling a
receive ring within a VNIC.  The mru which is the maximum receive
size of packets received by the VNIC can be updated.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 20 ++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 23f74c6c88b9..93d377ce48cb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10088,6 +10088,26 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
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
-- 
2.43.5


