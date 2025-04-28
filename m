Return-Path: <netdev+bounces-186590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D51A9FD5A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CBC1743E7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659D213E7E;
	Mon, 28 Apr 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UUQdI6Ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15822147EA
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881188; cv=none; b=stvmXA8HNwyo/SNN1BFB5l+wNGc3F8Rx22arS76COac60/pAIVE8bxmCzNDAkO1JQEw0H58RPYDnGhnAA03yY7hjCBzRkiI68E6L5hLNiSyXO4woijJQoqifz5HTL6SYoH2wNgIkNv95OEBYVtFqNIz6265m4KJwFB4EN55Tjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881188; c=relaxed/simple;
	bh=RS7kxD9bGcaZlohLXX7CdpJBw+mRTmDp3aL7u6by1Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeMiwydUiAPrn4NkhBN5p/hvHy/CZdO2U09kbpTNO31t5CWOmAD28pNdT110CZhT3FBVo9IqjmrGne7CGSvqLxAgYCbIsXEOGHur5xi7SucwJPijaaD7GrLSlKISOyRG1yqzgKK+AptULLe2Y3qMvuIGM4bR1GQxfIc/CPd2thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UUQdI6Ci; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73712952e1cso5749215b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881186; x=1746485986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/Fj2lziC2fCK6yEmJRcDnu1EO2oNWh6h/OQdmv3/vk=;
        b=UUQdI6Ci0Z2jU6lgEiMQL7nBNgBQfL1P7ZZ8bIXcayLZ30mm2nFUseF1IZIUxqNLXH
         xcDL0VnGBQEZgKmNRygTv5/OvmrxVsS8ZOnRyN/Auul/ElQKX9ptSDtbhsK22FB+txif
         fda2zSguc9JjH8m4h8fx5VEP0EOEM2ZL96uoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881186; x=1746485986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/Fj2lziC2fCK6yEmJRcDnu1EO2oNWh6h/OQdmv3/vk=;
        b=eGXhXu3Q+YIMd1cWH6urW4Z4o5D3bqIOj4ONGHjExf95zQTD6ERFBnCzRZyzlWJDd1
         U6okgk/2uJ5dBFntnRcK6bNGPbZFdXqXRfQna1NtjQdn5avdoxV7/Ifj7qupa39zWhuj
         JcF3haanSFEd8qSGF0Ra1bgC9JvkCldBMKliK9Bj4ktf9IUrVmmOc2IaqsclhrCJIMRV
         lPTU3cdKh2Z5CVF6hyKcm1J7Ow49osRlfBmIucVSAgR9bsRULAJXTG0mMNSR2w08jvoW
         ZSD2tPRol60ZgvOGX9oV2Ee80sLZPZQgoqdMdfRxlk/kLW/TIxxmFOi7f7brPodCkAlg
         mULQ==
X-Gm-Message-State: AOJu0YwF7oUiWRqQhCmd026ETadokU/0n37gzTh9AvoUAbcMEjAxp3H6
	pILC9tBWZ5Ir6j5HQqrFwSecPDJVW0zPf7IzqhuqCtEsRk5M1SQPS4W1AmYOnQ==
X-Gm-Gg: ASbGncsyyxWZXWPa4zRTpJDypK5t7Nt/KF+FkM226mvhNspviPFvq1Q4QWZY9pafbqC
	PBVWXnXg1pUtg9+ofVouzlj0g/BNtO0sIlRkX3hnL3vg1cIXA4d7QnVzr4bTkIxDjEZ+zfXvnzS
	Os8GNnJeLblSDSDQXh74cmPOizA6UsQXmcNCfO55FWHJifXk9+RGLIZ8A0wicdNs6xWClXvljN5
	28055WSZo3VNZ0r8A8CMXCIPcOA56fLe7Au4WqRyJYbMScR4p9q+oly8m9VBEIM6iwmqWMIQBxy
	4RElkCBJLFXTWBGpDzqL7c6XqPNJixVzWBAh0rXb6J+ilVCLoXN5kG8k87rJGX2efO7qgfhHjNQ
	axnOXmgYXWnx8+3U/
X-Google-Smtp-Source: AGHT+IFxeMQjROjtSgoLS8zDG/WJCPeb6eX9NMxlEfNQ+bD841VJUh0ETid3kLh4D9pn4+kXZlW8Ng==
X-Received: by 2002:a05:6a00:114f:b0:730:9502:d564 with SMTP id d2e1a72fcca58-73ff72e3083mr14363270b3a.14.1745881186078;
        Mon, 28 Apr 2025 15:59:46 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:45 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 6/8] bnxt_en: Fix coredump logic to free allocated buffer
Date: Mon, 28 Apr 2025 15:59:01 -0700
Message-ID: <20250428225903.1867675-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250428225903.1867675-1-michael.chan@broadcom.com>
References: <20250428225903.1867675-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

When handling HWRM_DBG_COREDUMP_LIST FW command in
bnxt_hwrm_dbg_dma_data(), the allocated buffer info->dest_buf is
not freed in the error path.  In the normal path, info->dest_buf
is assigned to coredump->data and it will eventually be freed after
the coredump is collected.

Free info->dest_buf immediately inside bnxt_hwrm_dbg_dma_data() in
the error path.

Fixes: c74751f4c392 ("bnxt_en: Return error if FW returns more data than dump length")
Reported-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 5576e7cf8463..9a74793648f6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -116,6 +116,11 @@ static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
 				memcpy(info->dest_buf + off, dma_buf, len);
 			} else {
 				rc = -ENOBUFS;
+				if (cmn_req->req_type ==
+				    cpu_to_le16(HWRM_DBG_COREDUMP_LIST)) {
+					kfree(info->dest_buf);
+					info->dest_buf = NULL;
+				}
 				break;
 			}
 		}
-- 
2.30.1


