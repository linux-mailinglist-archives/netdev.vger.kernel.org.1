Return-Path: <netdev+bounces-173621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F46BA5A314
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5D03A778F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE5235BF3;
	Mon, 10 Mar 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="czjrhssW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A323959D
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631633; cv=none; b=SO0jJVw92HY7plYuzPCZlfcls+R5oszDhThDVhvnkgMmhvjBUtjTr/EF1QsEcLJqd8qZLkYbTxghUeDC6McvNKMy7CyXR83FoC7xglNuGDE1LnELqkn3nOBSJ2oS9ZzJJdVRnv6pTHN6iaqIHuD3PfqadXMRifWx/yXSnAxeuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631633; c=relaxed/simple;
	bh=bTQY8uS+1LYiQ0iWn4H7rJxDNlUKUFObncvvxLaNiEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS8pJFBoQB1EyEXmRj1xE9pIDq/5m1Uw5a6jV6yB00wx3z5XDrUAGKoLKWTQOTK0XwN1j6xy1brL2t1pcNv1dQDk0JDPRZw23EvnrvDfp6k/+evQgJxe2rFX5on6GecO/AJbOjJmMzLaAw+dDmxEbHGM7QPmZiC5HcP/Xo12jQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=czjrhssW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f6eaa017d0so1339547b6e.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631630; x=1742236430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQcYm+RNG7NKCnYHBSP17FJo0lK3F8vXn56lJD0Wb0c=;
        b=czjrhssWBvdu9hpg/zORC+qUOOViI3eVictkf0u88k49mlXtlmqSgbZdBqxyjUWeir
         btVN7YMguzs4NFxaqBUwyVYWXN/RUI9xgdLHcNK1SDEyB+YCQiMFGI3JvDxDaiZdrTnq
         PBAgdrw7eqHPiJMuZ2jkN/y3R7ueGE+/8dcZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631630; x=1742236430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQcYm+RNG7NKCnYHBSP17FJo0lK3F8vXn56lJD0Wb0c=;
        b=GTxTRgKywhBANQRG9QfWG2x0cEoqZBvJdE4K/Hxg2VqBk7wPipHqGuByEGp78Q0SK/
         o1aWKN6Cje3nA+Yz3zS9m4+cdf2W2zEvldvNhMGDsfc2lm0SMFSZCCrcf2KT1fNXX1Dw
         ohCpQiEi8lclPtT79816t0xaMw5tl5q6pAfNK0GElEL9ydqDerY5eg93eL8tD9U6o9rQ
         wGtv84fhCmTzfeqX+ZfC4KavNrteW1AWPUryEi6ipf9f+WZMXqrfDSziy8HRhAQMfuSL
         4DvPaEzeRIhFngcayKddgnsa9ajGDPhfqQJGzCXQ2WYw3cKXqgepljmHgXdxOap6droN
         cM5g==
X-Gm-Message-State: AOJu0YwQcuCb/y/D5p+wV/+ZCzdMHI69zs6t1DiGKXtmGXS4kboj0gD8
	syiRFs21pXgLkeP82yr5TxB207JG5Y76JKq1nJKyetT8Wilc9ngKnXtQc4aUZw==
X-Gm-Gg: ASbGncu7rB/sd0R4GCU8FUV0sWyKakT2LfBMG2Mf+xTK86XJTTGF8XhiQ1/msRYCWlR
	1bPTK6xZLcgMDi/NBV8yiSpet2tGzsRVydYFOGF2+6vTyjwjieO5s1KO1Oy4en2dRi8G69Nfp0F
	nD20qvCljCS7Ei693X5hVtMgpLELKyHhSCBOaiZCzKgjOqNLrb3Qdw6oM19f8Z/m8RVx7y+wcDf
	7wxY6eLL3K2hCwCUAYXvO9mo72oASYIbhaIr1recATl6a31wJzaVsaU0vYu//fCzAbPMMqqQN5Q
	1nx7u/O7er2ktCgkn1VVMjJp+4DuARM9iWVlJCmhvwEvLVLq38d3i5E0qNno4sWhvborKAE344W
	xSPIz9V5239bgtN0n7aPs
X-Google-Smtp-Source: AGHT+IHSOYWY78MSYdtpCChweWwqo+GbEE0ONJtmap4ONc1LiduQMFPXfxdzovh7dl3yrHFFZP4RyA==
X-Received: by 2002:a05:6808:612:b0:3f6:aad5:eaba with SMTP id 5614622812f47-3f6aad5f162mr4086877b6e.7.1741631630624;
        Mon, 10 Mar 2025 11:33:50 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:33:50 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 2/7] bnxt_en: Refactor bnxt_hwrm_nvm_req()
Date: Mon, 10 Mar 2025 11:31:24 -0700
Message-ID: <20250310183129.3154117-3-michael.chan@broadcom.com>
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

bnxt_hwrm_nvm_req() first searches the nvm_params[] array for the
NVM parameter to set or get.  The array entry contains all the
NVM information about that parameter.  The information is then used
to send the FW message to set or get the parameter.

Refactor it to only do the array search in bnxt_hwrm_nvm_req() and
pass the array entry to the new function __bnxt_hwrm_nvm_req() to
send the FW message.  The next patch will be able to use the new
function.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 63 ++++++++++---------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index b06fcddfc81c..3c0af8ca50ae 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -1019,37 +1019,19 @@ static int bnxt_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 
 }
 
-static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
-			     union devlink_param_value *val)
+static int __bnxt_hwrm_nvm_req(struct bnxt *bp,
+			       const struct bnxt_dl_nvm_param *nvm, void *msg,
+			       union devlink_param_value *val)
 {
 	struct hwrm_nvm_get_variable_input *req = msg;
-	struct bnxt_dl_nvm_param nvm_param;
 	struct hwrm_err_output *resp;
 	union bnxt_nvm_data *data;
 	dma_addr_t data_dma_addr;
-	int idx = 0, rc, i;
-
-	/* Get/Set NVM CFG parameter is supported only on PFs */
-	if (BNXT_VF(bp)) {
-		hwrm_req_drop(bp, req);
-		return -EPERM;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(nvm_params); i++) {
-		if (nvm_params[i].id == param_id) {
-			nvm_param = nvm_params[i];
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(nvm_params)) {
-		hwrm_req_drop(bp, req);
-		return -EOPNOTSUPP;
-	}
+	int idx = 0, rc;
 
-	if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)
+	if (nvm->dir_type == BNXT_NVM_PORT_CFG)
 		idx = bp->pf.port_id;
-	else if (nvm_param.dir_type == BNXT_NVM_FUNC_CFG)
+	else if (nvm->dir_type == BNXT_NVM_FUNC_CFG)
 		idx = bp->pf.fw_fid - BNXT_FIRST_PF_FID;
 
 	data = hwrm_req_dma_slice(bp, req, sizeof(*data), &data_dma_addr);
@@ -1060,23 +1042,23 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 	}
 
 	req->dest_data_addr = cpu_to_le64(data_dma_addr);
-	req->data_len = cpu_to_le16(nvm_param.nvm_num_bits);
-	req->option_num = cpu_to_le16(nvm_param.offset);
+	req->data_len = cpu_to_le16(nvm->nvm_num_bits);
+	req->option_num = cpu_to_le16(nvm->offset);
 	req->index_0 = cpu_to_le16(idx);
 	if (idx)
 		req->dimensions = cpu_to_le16(1);
 
 	resp = hwrm_req_hold(bp, req);
 	if (req->req_type == cpu_to_le16(HWRM_NVM_SET_VARIABLE)) {
-		bnxt_copy_to_nvm_data(data, val, nvm_param.nvm_num_bits,
-				      nvm_param.dl_num_bytes);
+		bnxt_copy_to_nvm_data(data, val, nvm->nvm_num_bits,
+				      nvm->dl_num_bytes);
 		rc = hwrm_req_send(bp, msg);
 	} else {
 		rc = hwrm_req_send_silent(bp, msg);
 		if (!rc) {
 			bnxt_copy_from_nvm_data(val, data,
-						nvm_param.nvm_num_bits,
-						nvm_param.dl_num_bytes);
+						nvm->nvm_num_bits,
+						nvm->dl_num_bytes);
 		} else {
 			if (resp->cmd_err ==
 				NVM_GET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST)
@@ -1089,6 +1071,27 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 	return rc;
 }
 
+static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
+			     union devlink_param_value *val)
+{
+	struct hwrm_nvm_get_variable_input *req = msg;
+	const struct bnxt_dl_nvm_param *nvm_param;
+	int i;
+
+	/* Get/Set NVM CFG parameter is supported only on PFs */
+	if (BNXT_VF(bp)) {
+		hwrm_req_drop(bp, req);
+		return -EPERM;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(nvm_params); i++) {
+		nvm_param = &nvm_params[i];
+		if (nvm_param->id == param_id)
+			return __bnxt_hwrm_nvm_req(bp, nvm_param, msg, val);
+	}
+	return -EOPNOTSUPP;
+}
+
 static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
 				 struct devlink_param_gset_ctx *ctx)
 {
-- 
2.30.1


