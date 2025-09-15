Return-Path: <netdev+bounces-222904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E794DB56EAB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C1918955E9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A9229B18;
	Mon, 15 Sep 2025 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U2XbmzH3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110472264CC
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905558; cv=none; b=CoAx3m2h/S3JDhb47DTPIJD8PSXtBV3KEaeBgaJmLQbB63kY+3sW+C8c514bes6AByqcSxTAIk7oSjHOYVfV3yVR5/QkCqeoKs/aNzcqeq1Ky+i0pDRLgCcis0xmY26PzgGfMUZWlm+p79eFrK0ZrX2dx0HLdrIwRune8shlFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905558; c=relaxed/simple;
	bh=wyJqVpApGwBcpjbXnqK7N50zqTET/RmkA+d88JEmx4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ2VIi9Ti/YKO7u3vNWSrCwcHis16c78ZZP4lXs6akiBXaYq+BL4RrKfEutdu9oTz6Dm+t2rvMoMREBux5k6hM7zHh+9CjFdC8HpVjB5KZXOAqYCTKPWK2OXWnZwzrDvnI7kG9UfLl451W4YlSXtSvWvF07TZFJWLav+G/x8xLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U2XbmzH3; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b5488c409d1so2317192a12.1
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905556; x=1758510356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t75UMJ2RXGCTMaNfHUvlkJU+e7mSmcuYev01pyYMfzE=;
        b=sv+Jl2d6c5PVzGR44hVSmeI0C5v1P2336q7vaP0nUCS5vq880s62IoBsINomxiu12+
         AGFJt6ifXFUjR7xoBWywawjfHDyT6vBeEAXSUhVm8VdxLDV6ogY4xYRiG3misaRD3FjY
         rpD7qgJFYDxEhaR9CPcK4LotnziTlTEP7NHbDlL3fYm42Qhg45ydDDK4v3ebMa5aDX1r
         1NtohZIcDPA0Vu+c/47kkg91VNzHnVRUrEF7p8sNXEoXLhQG87e9gYq/6C+qK6UwMSgG
         Lbes2XsldrCkRt/OJDL6JjCVrG2ZW6iK6s+FQqftnYFrzNt1BcpqiSi6iJ7C1loXfAyD
         1TsQ==
X-Gm-Message-State: AOJu0Yyzs7mS5Y9VexwFcQCdF27/yWZvh5s5RBLE0TSlp0rkdHAAIuhl
	C25wWKgpiRTBfxJruwHyvBytxmrMxWVToCHjzrMN7vwf6XflEOJ3l1HGHiL8FZeajl+ICOSCAqY
	iYgEB05/lK6rYir+2//oCteWOBnllYuSgRCTw+jAaF4kIHGGRGsQOSmbOAwnyLtaJA7SyaPRAxU
	D/rRq0Ekl3JSPP3yVYDZ0YAsyKP4wxrOPNcOL55x3KSohMdkjfM5pmz5YW+Tq0wODAr5NOa5J4r
	Of7dpa3jOM=
X-Gm-Gg: ASbGncvsQUUMt02axzKymmSgs6Kwtf2dRkSjAY4pgwyJ5VobemSzGHvfw7lr6R5Suen
	TQfo3g0uNEZ0Q6/zKOYdQA6TZeXsG9zczPvSnPi5jOz8hUuefGjxlB9pVOTqV+apBPo/lBN+YLl
	9h4t3Eu9f5x+jRTHvuJ7zMA5hpKdx1TPHRPMMB0b7oLFIWeW2XCIBhuG3MwICFBVkYKPWDSK+tr
	UIwFxPoB+Bvx9mIycLs55WZcQQvN1Xdt+rcngcOe1ZdoLmgO4B5EZGP0M8GFxjrWLItEmoBxjPj
	1x2NSQYh+oW5FEomI7FTkOo+LoIevE/Oebtrrv5HcJ195bpWwF1FSPUKOX5rHCFf8grIMgohcYV
	e54Ft7YiEHibN5Pac4dG84H5RIUfba4FeSriF9k7ANILOqg1wzQfLNcb/umbzgztcD1VSypoFnN
	gOWg==
X-Google-Smtp-Source: AGHT+IHs0dt8RJhkrwyjzf8P2pUXp2lvlcDpTSLSooyI47elo3QIoGkq4OSEAKkje/Hds1Kq+zTdvoIKR60O
X-Received: by 2002:a17:902:eccf:b0:246:92f5:1c07 with SMTP id d9443c01a7336-25d27333967mr106633225ad.51.1757905556177;
        Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-265c4769cccsm2913615ad.41.2025.09.14.20.05.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54d1ae6fb3so226186a12.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905553; x=1758510353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t75UMJ2RXGCTMaNfHUvlkJU+e7mSmcuYev01pyYMfzE=;
        b=U2XbmzH3aBYxqUYkxVE9CpYp1LnZrbeSH9QIBndamYzJh92j+3yEMqMeNqi7TNKT9s
         tPQ4r1aKq2rr+sQJ5BatXTWmRdWUiaVrl3lHhjPKJ1xtU/uVoJAH2YhGPwk3YtJ4oGWr
         BZB7v1CIiLpud4XvFPi+efIefnLVvSB3bseVM=
X-Received: by 2002:a17:902:d2d1:b0:25c:4b44:1f30 with SMTP id d9443c01a7336-25d26e486d3mr142931235ad.45.1757905553380;
        Sun, 14 Sep 2025 20:05:53 -0700 (PDT)
X-Received: by 2002:a17:902:d2d1:b0:25c:4b44:1f30 with SMTP id d9443c01a7336-25d26e486d3mr142930975ad.45.1757905553022;
        Sun, 14 Sep 2025 20:05:53 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:52 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 04/11] bnxt_en: Improve bnxt_hwrm_func_backing_store_cfg_v2()
Date: Sun, 14 Sep 2025 20:04:58 -0700
Message-ID: <20250915030505.1803478-5-michael.chan@broadcom.com>
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

Optimize the loop inside this function that sends the FW message
to configure backing store memory for each instance of a memory
type.  It uses 2 loop counters i and j, but both counters advance
at the same time so we can eliminate one of them.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a74b50130cc0..38a2884f7c78 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9098,7 +9098,7 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 {
 	struct hwrm_func_backing_store_cfg_v2_input *req;
 	u32 instance_bmap = ctxm->instance_bmap;
-	int i, j, rc = 0, n = 1;
+	int i, rc = 0, n = 1;
 	__le32 *p;
 
 	if (!(ctxm->flags & BNXT_CTX_MEM_TYPE_VALID) || !ctxm->pg_info)
@@ -9128,20 +9128,20 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 	req->subtype_valid_cnt = ctxm->split_entry_cnt;
 	for (i = 0, p = &req->split_entry_0; i < ctxm->split_entry_cnt; i++)
 		p[i] = cpu_to_le32(ctxm->split[i]);
-	for (i = 0, j = 0; j < n && !rc; i++) {
+	for (i = 0; i < n && !rc; i++) {
 		struct bnxt_ctx_pg_info *ctx_pg;
 
 		if (!(instance_bmap & (1 << i)))
 			continue;
 		req->instance = cpu_to_le16(i);
-		ctx_pg = &ctxm->pg_info[j++];
+		ctx_pg = &ctxm->pg_info[i];
 		if (!ctx_pg->entries)
 			continue;
 		req->num_entries = cpu_to_le32(ctx_pg->entries);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->page_size_pbl_level,
 				      &req->page_dir);
-		if (last && j == n)
+		if (last && i == n - 1)
 			req->flags =
 				cpu_to_le32(FUNC_BACKING_STORE_CFG_V2_REQ_FLAGS_BS_CFG_ALL_DONE);
 		rc = hwrm_req_send(bp, req);
-- 
2.51.0


