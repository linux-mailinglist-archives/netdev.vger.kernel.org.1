Return-Path: <netdev+bounces-247207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207CCF5C1A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7816830F4117
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA483126D8;
	Mon,  5 Jan 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XVizX5k8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF14311C21
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650359; cv=none; b=j2EWqEsbOPpa30BjswXnF20QzngzLVXbzSWnrvntQmrFaybZUSq/cWeL+raJ9qIOYi7ubbFlLYCDIKC3Q9QxlqYMlmpzQUPZ2MLQJCEQUd11VZuxZw8BM/sJMO4WyMXjnxH1aKU25Bx4agEJ4e+IPfJFZByrIKTI67dIyjpbtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650359; c=relaxed/simple;
	bh=MElSNsMyL0QjYJjRfdQZnWTbJ/B15mT7IzbVc+sS90g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHNkO6QIDGUkXCYX/OQlSmnf0L+o9v/cMhwFt17XWZlkJ7xiwdajgYhdVMhAH1/DSXBsxjBY+PDx7KV8jam8/r2cKz6fXyTkTFdOvV0QGxsGqjIkJPJwZqIbVOiupkJEthkd+Ea4+vrg/tl6nxsC5aP+YTai2nyswJ01MRFX0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XVizX5k8; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso3543965ad.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650357; x=1768255157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3ELeCpDaSbQrwRYrtN0w3AXxnc5irV437hDC1oO8AI=;
        b=FMNUVyGPqCN8xEaO34pU6NedBCWG7U1bnMuL2UrSjGUhVkZZqX35nu70Ypz9NeVNWi
         C4cOc6HdelQrrx1CSVmITnqcwuz4svApOlxiZjkR0/tfGJn4pyeEIzRJp+Wtju1QFJSz
         kSDOKRnHbhWumNT/MCLyy8Ww7yMTEKE6KPd1J/yjgMlZnKyD1QR2nhCaRRpAmP8f+06Y
         CUUlqJRSfkKoRvOVtaM7Bav7liWVAnvIqxezCjn3wh8V9olAuQJif3FfPYXdiU5PDt+v
         SI8EbhBySnkId7nS7czesWY+1E9Od7LylFuvfFlEu27E57VFZwV9THEnJHEj3NBwtmhT
         Hq1w==
X-Gm-Message-State: AOJu0YzfPmAnRUJGqMq9hLfRn+IYR4/XwDBX+vj9inQX3L7WkmADoABG
	/VJ+ybcbdJ20FMWvmkfMB/vwj4MSTKfVdEh6iHf5Vj7APLKcq07F+DVccbAt98UuIq8ZbnV6jWy
	PWG6duwSm8onKcxu1reOCyHbEP1UEJl5pUi+SHTwpls1zN6TFGRlg6pCs0/eruxt7VvGSAyhIDe
	67GxoRYtZ0vb47HLS0DQiapICpXS0UFMyzFRRAZ8dW5/2l0pEUvpdxk2WWbqq38HPbUtViZCUPl
	IUWbi2CxCQ=
X-Gm-Gg: AY/fxX7rNmBwr7lVtTWMImS2ryHh4YpSP0SMwEf18xF3qTEZjNJD2McPmmEyfjcBipV
	KTsKzWQ49/KSE791kqCkww4pqzt9i9LarUjiQdCKZZpOyWhLBpcmSs1dz7y6ihwyLzSc2uFn4Uj
	yutej+Om+FmgXl2MBoKbffAs36z/qMuBnRwP54G5vilGu+Uovvu7WqplFCmUZi9dp3USCcNeYOT
	QSniXaWuOBuRSqAyOauqI6z+OCdlfJ3MLbx/jzE48ePYFX3ssNVb1T10mWrT6Zm933YIwQH90wi
	DKX9S2/uJoeoMudMpCtUSkxFVzIwnDVXu4UsH99oF5o/xXd6rPx62o6Mwwb7AwDwKFGlM+o8YT8
	BjNV5zL7RHL28Ozqvw5VWs/t1030po6dJyjNYrP992E9zNS3O2ueKjQG/D6hK0+vAYG+43faRYZ
	6JZsuwWVodiQqnh1a6goixNQ4oaUJQg0OJB/6OFmSBWA==
X-Google-Smtp-Source: AGHT+IHn0pq+U5Q1m/zauaL5pNsFQx1dekVQFNL7pgA4VTxBNexjYjqErBf2hQdnbf9I4qxvDcoanVYohwdu
X-Received: by 2002:a17:903:1b0c:b0:2a0:8be7:e3db with SMTP id d9443c01a7336-2a3e2d8e30cmr9993165ad.15.1767650357055;
        Mon, 05 Jan 2026 13:59:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c3bc07sm457395ad.8.2026.01.05.13.59.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:59:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f35f31000cso5820841cf.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767650355; x=1768255155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3ELeCpDaSbQrwRYrtN0w3AXxnc5irV437hDC1oO8AI=;
        b=XVizX5k8Ugo5kKyvK/LfDTBWgAu8lNNBZNmXpcxEssLvzVVMjA7+qnCZU4KImkl93G
         fUFE8fvHX7JA20tyX941DSi8mOab3LBoIl1qFjNoWcdu3SLpiSCzK1/J1qE6aFAgGTNz
         S46eGhv9Rb+fIrfu5hK1sRHB6uFBg5UvlKmsc=
X-Received: by 2002:a05:622a:909:b0:4ee:bff:7fcb with SMTP id d75a77b69052e-4ffa76a1997mr15476751cf.1.1767650355580;
        Mon, 05 Jan 2026 13:59:15 -0800 (PST)
X-Received: by 2002:a05:622a:909:b0:4ee:bff:7fcb with SMTP id d75a77b69052e-4ffa76a1997mr15476501cf.1.1767650355184;
        Mon, 05 Jan 2026 13:59:15 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm1882051cf.3.2026.01.05.13.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:59:14 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 4/6] bnxt_en: Defrag the NVRAM region when resizing UPDATE region fails
Date: Mon,  5 Jan 2026 13:58:31 -0800
Message-ID: <20260105215833.46125-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260105215833.46125-1-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

When updating to a new firmware pkg, the driver checks if the UPDATE
region is big enough for the pkg and if it's not big enough, it
issues an NVM_WRITE cmd to update with the requested size.

This NVM_WRITE cmd can fail indicating fragmented region. Currently
the driver fails the fw update when this happens. We can improve the
situation by defragmenting the region and try the NVM_WRITE cmd
again. This will make firmware update more reliable.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index af4ceb6d2158..a5ed6dd42bfc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3848,9 +3848,25 @@ static int nvm_update_err_to_stderr(struct net_device *dev, u8 result,
 #define BNXT_NVM_MORE_FLAG	(cpu_to_le16(NVM_MODIFY_REQ_FLAGS_BATCH_MODE))
 #define BNXT_NVM_LAST_FLAG	(cpu_to_le16(NVM_MODIFY_REQ_FLAGS_BATCH_LAST))
 
+static int bnxt_hwrm_nvm_defrag(struct bnxt *bp)
+{
+	struct hwrm_nvm_defrag_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_NVM_DEFRAG);
+	if (rc)
+		return rc;
+	req->flags = cpu_to_le32(NVM_DEFRAG_REQ_FLAGS_DEFRAG);
+	hwrm_req_timeout(bp, req, bp->hwrm_cmd_max_timeout);
+
+	return hwrm_req_send(bp, req);
+}
+
 static int bnxt_resize_update_entry(struct net_device *dev, size_t fw_size,
 				    struct netlink_ext_ack *extack)
 {
+	struct bnxt *bp = netdev_priv(dev);
+	bool retry = false;
 	u32 item_len;
 	int rc;
 
@@ -3863,9 +3879,19 @@ static int bnxt_resize_update_entry(struct net_device *dev, size_t fw_size,
 	}
 
 	if (fw_size > item_len) {
-		rc = bnxt_flash_nvram(dev, BNX_DIR_TYPE_UPDATE,
-				      BNX_DIR_ORDINAL_FIRST, 0, 1,
-				      round_up(fw_size, 4096), NULL, 0);
+		do {
+			rc = bnxt_flash_nvram(dev, BNX_DIR_TYPE_UPDATE,
+					      BNX_DIR_ORDINAL_FIRST, 0, 1,
+					      round_up(fw_size, 4096), NULL,
+					      0);
+
+			if (rc == -ENOSPC) {
+				if (retry || bnxt_hwrm_nvm_defrag(bp))
+					break;
+				retry = true;
+			}
+		} while (rc == -ENOSPC && retry);
+
 		if (rc) {
 			BNXT_NVM_ERR_MSG(dev, extack, MSG_RESIZE_UPDATE_ERR);
 			return rc;
-- 
2.51.0


