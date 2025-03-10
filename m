Return-Path: <netdev+bounces-173620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DBA5A313
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CE6188549A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602ED23958E;
	Mon, 10 Mar 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GT+I4lub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE2239584
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631632; cv=none; b=cbkegISNdO0CpSKfe5N2Db9kEs4KhYUm7t8pLxwb+/Ha5ZnwoXXoF3G8kRlMduZM4PdLhzqR/9030A5fSO+jpbKuhiynoaM+xeIl2Hqe72MJWeLZpESsxhmeMUC4AJ7T8YeJjJqMRK5j41S2anrIU5OyCaYKGcCH4Sj9yPIq8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631632; c=relaxed/simple;
	bh=hDSwCR2EJ6zQS5CrB+qdsWway5Jl4Jb6uHgrm5IZsLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzVHwUpSCbisgQSIBHyJBsHwQqcNR3qMiJ073ZKX/oKcOmcouPYUn7FOJqRmLtsoBekjocmmo1Uv554NrNfZ4kkK49yX5TzheJPrgWhE0V6x1AiB8hNzJb6GYiuyJMwlzeSM5x6eA9d88bdsnqNn1ONT6orHQTnrfoNFy2R2kxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GT+I4lub; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f9832f798aso477958b6e.2
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631629; x=1742236429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LubyWzyrz7Pvfzr8t/ugRh41HCzGBkSyMKSZcdamIc=;
        b=GT+I4lub2SKqQ2kvyWOPS6ZQ0km7+rnJ+KY9EjQrfkdj6sftLGBfd41Cd4vAjZgFe9
         GIdOxYl+b3uzi1HWGnLwdkjkBRQvl2JJExXj0iV0xORqRFMDsYPLEyzxcbspe7q+KbyQ
         yKvl21DrHHM1CPQKRnVG4Kbosm3i8/oksMfyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631629; x=1742236429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LubyWzyrz7Pvfzr8t/ugRh41HCzGBkSyMKSZcdamIc=;
        b=waYmfZZ81VnrDSNP2zdW6ySVJyihNMiuWUqPsAa9Cm+nF4qxO5N1iXykelKJ/2A/AS
         HhXj+9hpS0P0bSG2Zr6nsohlHrrz5yHEJLpaQVDy3R7wPTHYkDlEePSwnt8kVPAz/dLC
         mUD7OMqgB0cb/IsLqqo5t+t7a/vPDxbyhwJRmI4gayePIc0F5OIV0wuhnP35hfMxkYg5
         uPeSNmNz1OyQGY+OnfnmCiWUbKlUaVnROrndaUCiLJDaBIlrWiQaE+pDdiEt3hp4yotT
         N+h/WBJq4QMi11wijyQhGs/BQJYb4GW0/mtlBa4ViiW33WLOG2JCLV9/X3judQw2eA03
         jnug==
X-Gm-Message-State: AOJu0YyzVRngNYefc/R2pNZI2YSPhx8yIA6X9lDWveX3XrPazX10wuj5
	yyTmt+N1xwAAwZOIc8nStXmE9CBXMutb2C87CtbRcsxRElTQ37oeh8wNJlpmB8nUP696jIN+L1w
	=
X-Gm-Gg: ASbGncsuphQOPDKBt1syLxCdb9S+W8OxJBL646dvHzib0JCWIhhnEhQOi1Hg22s9jHm
	XFcJoDy8VTmHbynb96IH9+QpIBHs6SR2NZ+447v21EnJgFfwQ8Vakx7G+rv/Kg1SGq0/zUm7zwq
	QPfbaJfLazCiRt5uPFVgv/THjmCWO31nZV11mT5dKVjsEe1Aj2KvsuTHUU2eDEt8r3rtxK9T9gx
	ATIsQTfX3gErU6FS71rEhtz/Emq16U9qOIMPraVRuErOiCNb/lXrvjg19GqIT0hLQhgmb6MIF1P
	REoBfmeDW/q2syEjkRPGtiz5cCKKGKWZ+4JiFhvXKJvkQekgzb0gcdsypmfgw5CMYnP0TSuGn44
	uQUpFBWWVo7bcucwQJvDx
X-Google-Smtp-Source: AGHT+IFs6Vts/R/Mpwi2gyu4EjGySHiobrV8+v4Jjl37ghYsvO0c43oXOS6KkhPNejTQYkZpF3sPyw==
X-Received: by 2002:a05:6808:250e:b0:3f8:e55c:16d6 with SMTP id 5614622812f47-3fa2c1ad8c3mr347866b6e.28.1741631629554;
        Mon, 10 Mar 2025 11:33:49 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:33:48 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vasuthevan Maheswaran <vasuthevan.maheswaran@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH net-next 1/7] bnxt_en: Add support for a new ethtool dump flag 3
Date: Mon, 10 Mar 2025 11:31:23 -0700
Message-ID: <20250310183129.3154117-2-michael.chan@broadcom.com>
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

From: Vasuthevan Maheswaran <vasuthevan.maheswaran@broadcom.com>

When doing a live coredump with ethtool -w, the context data cached
in the NIC is not dumped by the FW by default.  The reason is that
retrieving this cached context data with traffic running may cause
problems.  Add a new dump flag 3 to allow the option to include this
cached context data which may be useful in some debug scenarios.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Vasuthevan Maheswaran <vasuthevan.maheswaran@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 9 ++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  | 5 +++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e85b5ce94f58..e93ba0e4f087 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2697,6 +2697,7 @@ struct bnxt {
 #define BNXT_DUMP_LIVE		0
 #define BNXT_DUMP_CRASH		1
 #define BNXT_DUMP_DRIVER	2
+#define BNXT_DUMP_LIVE_WITH_CTX_L1_CACHE	3
 
 	struct bpf_prog		*xdp_prog;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 7236d8e548ab..5576e7cf8463 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -159,8 +159,8 @@ static int bnxt_hwrm_dbg_coredump_list(struct bnxt *bp,
 	return rc;
 }
 
-static int bnxt_hwrm_dbg_coredump_initiate(struct bnxt *bp, u16 component_id,
-					   u16 segment_id)
+static int bnxt_hwrm_dbg_coredump_initiate(struct bnxt *bp, u16 dump_type,
+					   u16 component_id, u16 segment_id)
 {
 	struct hwrm_dbg_coredump_initiate_input *req;
 	int rc;
@@ -172,6 +172,8 @@ static int bnxt_hwrm_dbg_coredump_initiate(struct bnxt *bp, u16 component_id,
 	hwrm_req_timeout(bp, req, bp->hwrm_cmd_max_timeout);
 	req->component_id = cpu_to_le16(component_id);
 	req->segment_id = cpu_to_le16(segment_id);
+	if (dump_type == BNXT_DUMP_LIVE_WITH_CTX_L1_CACHE)
+		req->seg_flags = DBG_COREDUMP_INITIATE_REQ_SEG_FLAGS_COLLECT_CTX_L1_CACHE;
 
 	return hwrm_req_send(bp, req);
 }
@@ -450,7 +452,8 @@ static int __bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf,
 
 		start = jiffies;
 
-		rc = bnxt_hwrm_dbg_coredump_initiate(bp, comp_id, seg_id);
+		rc = bnxt_hwrm_dbg_coredump_initiate(bp, dump_type, comp_id,
+						     seg_id);
 		if (rc) {
 			netdev_err(bp->dev,
 				   "Failed to initiate coredump for seg = %d\n",
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9c5820839514..e031340bdce2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5077,8 +5077,9 @@ static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
-	if (dump->flag > BNXT_DUMP_DRIVER) {
-		netdev_info(dev, "Supports only Live(0), Crash(1), Driver(2) dumps.\n");
+	if (dump->flag > BNXT_DUMP_LIVE_WITH_CTX_L1_CACHE) {
+		netdev_info(dev,
+			    "Supports only Live(0), Crash(1), Driver(2), Live with cached context(3) dumps.\n");
 		return -EINVAL;
 	}
 
-- 
2.30.1


