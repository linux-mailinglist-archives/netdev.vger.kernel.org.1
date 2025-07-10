Return-Path: <netdev+bounces-205941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B4B00DF8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C536582FA4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394928FA9F;
	Thu, 10 Jul 2025 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BUciwmCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875228467C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183619; cv=none; b=jjVt1W2wuDmuBeq4BLk4tNCrnHQCnj5AY5cGmf0AVG9b4iV8chphkj360tOhl5110UpO5/mHXubzceyKhKEP3XrY3SIKXcbQv/dbzZXmj0VqiAIN+3G/e29DynI6kyYa4cbnlJHhB3zSVRDLdKJpIJ2BEoFDM41iMR9iDYfprV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183619; c=relaxed/simple;
	bh=DXlGjeBMBB1BEu+78tPimnnoh+f8Dt7w1xnI2laiqBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Npfjw6lMaPp/lOWnd/Ql4XKsiN4M4C/SIJXmEy7rkBxI1BvV5vNySLs+PdrU4FUZy95kpukkByFy5Y3Uz4Jk+pIILtAWFstGBMFwsZDzkkYKqhc0I7s6AxWtF4+V/aZsN1oeulzCY01FnLAAq3ehBKmcOA5QLybzELnzu0ZLBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BUciwmCj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso1730564a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752183617; x=1752788417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idWePfMViSaZmqDrEHIk5fcqvAmTJXDm9pwItl8nJKM=;
        b=BUciwmCjRdy/UdNtkJKJqAL+fWEfdoEfLdntpD3GXGfa4tw7x484ENXz6HYgzHClr4
         iiCYFA7gQ4qowIcw9LzSPrL8so6Hpp2YEWCd0mqlHGaMPt+s9jdsbXKZaFH4oY7Zv00W
         mWOlIOSp7n2u/gJAu1EIWaSzZqf8JxJWN2H54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183617; x=1752788417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idWePfMViSaZmqDrEHIk5fcqvAmTJXDm9pwItl8nJKM=;
        b=TTVRLblttyuk2MMFPk3YBfVkhgAZzrtVhTX84VuElOX+RDyFcC580PtmthwupN8jP9
         psZ5by/lzvOrvtEOINRed8uVS6f2Q9Xj7g1tN0tuPnVIbQ8k5ppU/s9vXaqYTePZCg5A
         pVGWdzDhw/LA+swSUsWQYFPbXjUWpWWYtwOhto2F3sg1+2jKTbqztrneOqvaf4b4iyXi
         kDciYwTe9kZA32YxYOqckQUXEHD/rUjZ9SgA/STY5u2FcM3qJkHEmDTItkCJDn3HwC6C
         gaz1yKKKdSOnuTcs/9+tR447UO1AREn0KLTXAcCJcvNWAAu5OZ3NDD1DJW+t3BytebiO
         UIUw==
X-Gm-Message-State: AOJu0YxCwGx1VBi+Y4ZaM81aKj/hEcNytMr4xnV3GnwrESqWxmdYRKFR
	ooM4wUr5V09Kot6Wr4MCVDryoPHmAqeBRII/1sn9add+FOcb8Ci3RsSfNns3AEP2Bg==
X-Gm-Gg: ASbGncvkETed+WmU6Iek+m1+JbCPJpM0/E8sdFk1C875BgGFVjLAOlewvg9Yp+nv3oA
	oDKc+eibw3/sbeQxeXfKLfLGWTIWkZ06uDVFuMNAuxghRUq0IBgYKWLqFK/k1baze+JCkrsm/gL
	fX3K62aTElIqImc+fqCJhkgrGDc+T5kxTXsXomZe54rTBvAvGefVDajfIbFL7dkTjoM6uY+54rR
	OSpOkmQi42lVOaAgnuInHzWS6mPRihO2Uio5pOIwc/1Z+1i1nmfIyHMO5h+S3RRZGzSOKHH9hle
	Vb8/zJXWzgZx3FPFtP0oUBjyJlOOylqr3gQX1NvhypYjLsWBwskBCqkRl5CZS7oOww265huHzYd
	BtpTTzaxuSUKd4NhoUL9TQhpojBci4Y1KsJbZVw==
X-Google-Smtp-Source: AGHT+IE6joLn0UiMfheKpJ/jmunHrFhCNd7j29UyeIGQN7015XElbSdbKonszJbX4soOCe/3k42HfA==
X-Received: by 2002:a17:90b:558f:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31c4f5af641mr237625a91.28.1752183616946;
        Thu, 10 Jul 2025 14:40:16 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e9581d8sm3358208a91.6.2025.07.10.14.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:40:16 -0700 (PDT)
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
Subject: [PATCH net 2/3] bnxt_en: Flush FW trace before copying to the coredump
Date: Thu, 10 Jul 2025 14:39:37 -0700
Message-ID: <20250710213938.1959625-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710213938.1959625-1-michael.chan@broadcom.com>
References: <20250710213938.1959625-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

bnxt_fill_drv_seg_record() calls bnxt_dbg_hwrm_log_buffer_flush()
to flush the FW trace buffer.  This needs to be done before we
call bnxt_copy_ctx_mem() to copy the trace data.

Without this fix, the coredump may not contain all the FW
traces.

Fixes: 3c2179e66355 ("bnxt_en: Add FW trace coredump segments to the coredump")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_coredump.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index ce97befd3cb3..67e70d3d0980 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -368,23 +368,27 @@ static u32 bnxt_get_ctx_coredump(struct bnxt *bp, void *buf, u32 offset,
 		if (!ctxm->mem_valid || !seg_id)
 			continue;
 
-		if (trace)
+		if (trace) {
 			extra_hlen = BNXT_SEG_RCD_LEN;
+			if (buf) {
+				u16 trace_type = bnxt_bstore_to_trace[type];
+
+				bnxt_fill_drv_seg_record(bp, &record, ctxm,
+							 trace_type);
+			}
+		}
+
 		if (buf)
 			data = buf + BNXT_SEG_HDR_LEN + extra_hlen;
+
 		seg_len = bnxt_copy_ctx_mem(bp, ctxm, data, 0) + extra_hlen;
 		if (buf) {
 			bnxt_fill_coredump_seg_hdr(bp, &seg_hdr, NULL, seg_len,
 						   0, 0, 0, comp_id, seg_id);
 			memcpy(buf, &seg_hdr, BNXT_SEG_HDR_LEN);
 			buf += BNXT_SEG_HDR_LEN;
-			if (trace) {
-				u16 trace_type = bnxt_bstore_to_trace[type];
-
-				bnxt_fill_drv_seg_record(bp, &record, ctxm,
-							 trace_type);
+			if (trace)
 				memcpy(buf, &record, BNXT_SEG_RCD_LEN);
-			}
 			buf += seg_len;
 		}
 		len += BNXT_SEG_HDR_LEN + seg_len;
-- 
2.30.1


