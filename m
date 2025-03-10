Return-Path: <netdev+bounces-173622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE17A5A317
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CE91886123
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784A23AE8B;
	Mon, 10 Mar 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GcsUS+wi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87261235BF4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631636; cv=none; b=s1N4+CXVT810oYpOTuTq2uua0VCk0/eYxNGZ+xZXTb9Gk0dhfXP6Kawfk8VHuuWPjDLjV6sRazCGAOlr2aDt91iPsZqiGTt/J86hepREKu358XEQAzGgC3KwxBhoJthXWFhMDjiomeY2pF0xIZyIKkHsiytR7beT1nDMErLxLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631636; c=relaxed/simple;
	bh=0kCosAWUNYDhOko0P47IhiB1D35KseYi4HvQHsi5DWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeBim/q5s+CiiG9WpgD3JhlcTjslvMyM8y7hnt2pGTSLzPmK+O2XvXYqA36vgKxmXqxXgml/L4eT5e10lyfJri/LZsZIsl9jLq35Sb1c7Lxvj3XwLmat5hYmArT9K6+PO5G1ANrU4PP/SoayIhM0nEghyqoAMEbm6i0ZheJpvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GcsUS+wi; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f6aab81647so1247309b6e.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631633; x=1742236433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZFPBdPBNv499Vkhna3146EthQda91AMmoS83ru5sdU=;
        b=GcsUS+wiurLORlkniHS8C/Qp+lHkxwmedGKS6FJ4ADYSfUY8SekEZE8nbXyRX2V6Ww
         5dvccVJ/DB+YDgBMKbh4ptVwZ1Y5V+2I9eDlPIGn7HdgBTchl/++pjs6NqnG+Rkxnh01
         MKbtyjrxkjppqBZLzXD8FzcpUFJk5eElDUS/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631633; x=1742236433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZFPBdPBNv499Vkhna3146EthQda91AMmoS83ru5sdU=;
        b=e9YCIYBiwiFIM6Al+4FjFdrqL9MWXD4aw3IQhR0v79JBIxXj3uoyYNprG7c2boriNt
         0uU+g70AQmu86hU6sLOMripkWEDubHwrVWxSfNsJjI2ySMCEh9fxX7YFu22F2zNMMUKg
         swRBBpNqkhp18bmdANpGaTSrPNpJgzD8ObIKh0agBfhuTam6VBNg14g+0PeBKQqcDm8c
         EVJpdyWsvwSHhD9FkseGbDjbW+fNtWTYqgGS3i40GUCmaphL5I1CWQbuCTAfl5jkN4FZ
         V/CrLFnHDWKIcoB9S+lbvUtE1IIpIvCXD9j6rD2Kw6mqo9PCoHbtKMgCQkuA5zxyGljw
         rhcQ==
X-Gm-Message-State: AOJu0YzMApXG8rhi1Y3E67/kJX73GEGSy2aLzyIwY+Rk8Xl6wpE5sEcR
	3A7YFnypv5AoNcaiU670PUWsVj5pJYWs7bddw3PEBbwO/MK/VMsDplWmV3QLG17xXl/YncCJK4A
	=
X-Gm-Gg: ASbGncuKJ1TYHKHRsniZM7fw9e/8cQioP+AM9g7/t1FVCqpmpQZRG0nfq3f5CCHQKLC
	YdPtEwzWFOeARpKJSKI1QTGaekWQBnLFBw4x9u4/P7JtJmWJT2nMUm0vIfBAoYtUco53lN5l8p2
	LCWwB6Hb/TLbo/1HzLsNC19/0TW8MA2WqTiEXvZgJW/e3ktfG20Gqtan7mloyi9TKb9OEncE5hB
	tJ8f9Q4prCZBempVZx7zVENVJf0SOTOsJPrTZ10bk0CoHE3Ro+F+xi2jrxpEva4mU2X9ntu2z4Q
	CvhUuKNqtE7iSHd0RCKCajdMeND169NpaefLHHZOoEqu9PmzkS7TNXi8VEq5legu2eieWXGQ2Ja
	5CUlBOV/9GtuLBMyMhIvW
X-Google-Smtp-Source: AGHT+IGBqS1id6EOVnTgtrzIrXI2YK79YrqDlJV/y+MJTs+ei9eZFl4Kk8HvV12icISp6icd7/6iEA==
X-Received: by 2002:a05:6808:2013:b0:3f8:c486:9b27 with SMTP id 5614622812f47-3f8c4869e0emr2739408b6e.22.1741631633409;
        Mon, 10 Mar 2025 11:33:53 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:33:52 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 3/7] bnxt_en: Add devlink support for ENABLE_ROCE nvm parameter
Date: Mon, 10 Mar 2025 11:31:25 -0700
Message-ID: <20250310183129.3154117-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250310183129.3154117-1-michael.chan@broadcom.com>
References: <20250310183129.3154117-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add set/show support for the ENABLE_ROCE NVM parameter to
enable/disable RoCE for a PF.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Co-developed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: Jiri Pirko <jiri@resnulli.us>
---
 Documentation/networking/devlink/bnxt.rst     |  2 ++
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 32 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.h |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/networking/devlink/bnxt.rst b/Documentation/networking/devlink/bnxt.rst
index a4fb27663cd6..9a8b3d76d11f 100644
--- a/Documentation/networking/devlink/bnxt.rst
+++ b/Documentation/networking/devlink/bnxt.rst
@@ -24,6 +24,8 @@ Parameters
      - Permanent
    * - ``enable_remote_dev_reset``
      - Runtime
+   * - ``enable_roce``
+     - Permanent
 
 The ``bnxt`` driver also implements the following driver-specific
 parameters.
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 3c0af8ca50ae..56b9012903b4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -675,6 +675,8 @@ static const struct bnxt_dl_nvm_param nvm_params[] = {
 	 NVM_OFF_MSIX_VEC_PER_PF_MAX, BNXT_NVM_SHARED_CFG, 10, 4},
 	{DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
 	 NVM_OFF_MSIX_VEC_PER_PF_MIN, BNXT_NVM_SHARED_CFG, 7, 4},
+	{DEVLINK_PARAM_GENERIC_ID_ENABLE_ROCE, NVM_OFF_SUPPORT_RDMA,
+	 BNXT_NVM_FUNC_CFG, 1, 1},
 	{BNXT_DEVLINK_PARAM_ID_GRE_VER_CHECK, NVM_OFF_DIS_GRE_VER_CHECK,
 	 BNXT_NVM_SHARED_CFG, 1, 1},
 };
@@ -1128,6 +1130,32 @@ static int bnxt_dl_nvm_param_set(struct devlink *dl, u32 id,
 	return bnxt_hwrm_nvm_req(bp, id, req, &ctx->val);
 }
 
+static int bnxt_dl_roce_validate(struct devlink *dl, u32 id,
+				 union devlink_param_value val,
+				 struct netlink_ext_ack *extack)
+{
+	const struct bnxt_dl_nvm_param nvm_roce_cap = {0, NVM_OFF_RDMA_CAPABLE,
+		BNXT_NVM_SHARED_CFG, 1, 1};
+	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
+	struct hwrm_nvm_get_variable_input *req;
+	union devlink_param_value roce_cap;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_NVM_GET_VARIABLE);
+	if (rc)
+		return rc;
+
+	if (__bnxt_hwrm_nvm_req(bp, &nvm_roce_cap, req, &roce_cap)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to verify if device is RDMA Capable");
+		return -EINVAL;
+	}
+	if (!roce_cap.vbool) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support RDMA");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int bnxt_dl_msix_validate(struct devlink *dl, u32 id,
 				 union devlink_param_value val,
 				 struct netlink_ext_ack *extack)
@@ -1192,6 +1220,10 @@ static const struct devlink_param bnxt_dl_params[] = {
 			      BIT(DEVLINK_PARAM_CMODE_PERMANENT),
 			      bnxt_dl_nvm_param_get, bnxt_dl_nvm_param_set,
 			      bnxt_dl_msix_validate),
+	DEVLINK_PARAM_GENERIC(ENABLE_ROCE,
+			      BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      bnxt_dl_nvm_param_get, bnxt_dl_nvm_param_set,
+			      bnxt_dl_roce_validate),
 	DEVLINK_PARAM_DRIVER(BNXT_DEVLINK_PARAM_ID_GRE_VER_CHECK,
 			     "gre_ver_check", DEVLINK_PARAM_TYPE_BOOL,
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
index b8105065367b..7f45dcd7b287 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
@@ -41,8 +41,10 @@ static inline void bnxt_dl_set_remote_reset(struct devlink *dl, bool value)
 #define NVM_OFF_MSIX_VEC_PER_PF_MAX	108
 #define NVM_OFF_MSIX_VEC_PER_PF_MIN	114
 #define NVM_OFF_IGNORE_ARI		164
+#define NVM_OFF_RDMA_CAPABLE		161
 #define NVM_OFF_DIS_GRE_VER_CHECK	171
 #define NVM_OFF_ENABLE_SRIOV		401
+#define NVM_OFF_SUPPORT_RDMA		506
 #define NVM_OFF_NVM_CFG_VER		602
 
 #define BNXT_NVM_CFG_VER_BITS		8
-- 
2.30.1


