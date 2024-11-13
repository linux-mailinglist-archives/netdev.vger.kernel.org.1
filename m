Return-Path: <netdev+bounces-144322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A99C68D2
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D0282764
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A916E179958;
	Wed, 13 Nov 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KRSqo7Ik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC2184549
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476409; cv=none; b=jfTTltLQZCFXn4NwfJbo+cGo72UgVI331S7m4FdrmplVAKujgwxEkL7hPtMPprZV9v3JqGHpda4sHp1MJOyCcrEnZywGXuWQhcEFtCCF5FJ2ZcgPFLureoP3l/cn7QfL5VHF3Ue9NmA1C+gGwGUEAHbPYxG1Al2GAltO/eQvmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476409; c=relaxed/simple;
	bh=JrY786zWQp16Bu3Rpm+WgoD2NekurY530EIqN/dVnbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyIYxUnVKqyqhaU5dcNIiJvkJjWvs5Ops1RimYTDqaOcwN/kx1KmK3MSuYr7Kw1NoqvE/5D9X2St1xYckwHxeRrSSU/faxR2lFvnIewl3La+zl5swvWC4Tj47gtso5x2/K/vwItgipS3sYvsuxTxUesYEFDJKgI0I/KnVaWlqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KRSqo7Ik; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-512259c860eso2462541e0c.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476407; x=1732081207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5I/Omefwav243Sm9OSf4ZaosNZkxs0R/8amkvBUuSA=;
        b=KRSqo7IkHPUQPSFA+MzRt9BXF9aVvEEo9+rJnE2kwGFNhr08Trv/3Qx2O77rw5fVuX
         yP0zTfA0XHdBd09G4IJKrmffQFhktnI9vVXsGs9XywFO+PYR+ZTa7GgxYri7BRlmgvap
         hmsrX+sxOOB1gc/ze77iMoJKRmQJ38MZtOgaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476407; x=1732081207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5I/Omefwav243Sm9OSf4ZaosNZkxs0R/8amkvBUuSA=;
        b=wx86CPrVhCtW44xtpUTePgr3IqI7qjs2m9DAiJ3xkjtYwbjqBmnq8dxnqZ1i6TwHLs
         i5hJd+Fzh5DYm2rfXf7pIYi6IG7JLdJFKDQyiA6nfEI7tYRID/GG9EeBd5T1vj46U4Mv
         tZW+dMptZ5VXbuv58zi+WcfH88qsxdEn/tj+CrMUm/tlXBA/oo+eUZw90SX8KhkqCiXZ
         u09jEv/5Yh/nKrU8aenZ0D9EyH1l6/hUyD8yO+XMGxWJIUjR5dq9CmLlqEBLAofMfFb/
         wuVREt7Z5gJlys2VJSaBFDZAunM4Nugt0F+c4XjIpHDrqT1J/WPpk7C5v77P8QylAGpT
         fj0w==
X-Gm-Message-State: AOJu0Yw30iNfZdSIvZxVMgE438dpcOOPEBDJZ9qcTQc7jS8qkGEgQnZk
	fxkS2kXpE7fOcVv0Lch4qNBxzmwRdnYbpruVxUW4t6JVa4y9LT95anTFbN4J4BcAs/9OuTIZ/Ak
	=
X-Google-Smtp-Source: AGHT+IHSeHEE6vQnX1De0szd1IJXSrFM183/EZT2Lt9cw0nnP1Vpb4RwX3TSJUeLJLTdekR2stdB6w==
X-Received: by 2002:a05:6102:3a09:b0:4a4:9363:b84c with SMTP id ada2fe7eead31-4ad46861ea9mr1988425137.6.1731476406659;
        Tue, 12 Nov 2024 21:40:06 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:40:05 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	hongguang.gao@broadcom.com,
	shruti.parab@broadcom.com
Subject: [PATCH net-next 09/11] bnxt_en: Add 2 parameters to bnxt_fill_coredump_seg_hdr()
Date: Tue, 12 Nov 2024 21:36:47 -0800
Message-ID: <20241113053649.405407-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241113053649.405407-1-michael.chan@broadcom.com>
References: <20241113053649.405407-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

Pass the component ID and segment ID to this function to create
the coredump segment header.  This will be needed in the next
patches to create more segments for the coredump.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 20 +++++++++----------
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  7 +++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 4e2b938ed1f7..4dfc26cfc979 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -165,11 +165,12 @@ static int bnxt_hwrm_dbg_coredump_retrieve(struct bnxt *bp, u16 component_id,
 	return rc;
 }
 
-static void
+void
 bnxt_fill_coredump_seg_hdr(struct bnxt *bp,
 			   struct bnxt_coredump_segment_hdr *seg_hdr,
 			   struct coredump_segment_record *seg_rec, u32 seg_len,
-			   int status, u32 duration, u32 instance)
+			   int status, u32 duration, u32 instance, u32 comp_id,
+			   u32 seg_id)
 {
 	memset(seg_hdr, 0, sizeof(*seg_hdr));
 	memcpy(seg_hdr->signature, "sEgM", 4);
@@ -180,11 +181,8 @@ bnxt_fill_coredump_seg_hdr(struct bnxt *bp,
 		seg_hdr->high_version = seg_rec->version_hi;
 		seg_hdr->flags = cpu_to_le32(seg_rec->compress_flags);
 	} else {
-		/* For hwrm_ver_get response Component id = 2
-		 * and Segment id = 0
-		 */
-		seg_hdr->component_id = cpu_to_le32(2);
-		seg_hdr->segment_id = 0;
+		seg_hdr->component_id = cpu_to_le32(comp_id);
+		seg_hdr->segment_id = cpu_to_le32(seg_id);
 	}
 	seg_hdr->function_id = cpu_to_le16(bp->pdev->devfn);
 	seg_hdr->length = cpu_to_le32(seg_len);
@@ -287,11 +285,13 @@ static int __bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 	start_utc = sys_tz.tz_minuteswest * 60;
 	seg_hdr_len = sizeof(seg_hdr);
 
-	/* First segment should be hwrm_ver_get response */
+	/* First segment should be hwrm_ver_get response.
+	 * For hwrm_ver_get response Component id = 2 and Segment id = 0.
+	 */
 	*dump_len = seg_hdr_len + ver_get_resp_len;
 	if (buf) {
 		bnxt_fill_coredump_seg_hdr(bp, &seg_hdr, NULL, ver_get_resp_len,
-					   0, 0, 0);
+					   0, 0, 0, BNXT_VER_GET_COMP_ID, 0);
 		memcpy(buf + offset, &seg_hdr, seg_hdr_len);
 		offset += seg_hdr_len;
 		memcpy(buf + offset, &bp->ver_resp, ver_get_resp_len);
@@ -346,7 +346,7 @@ static int __bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 		end = jiffies;
 		duration = jiffies_to_msecs(end - start);
 		bnxt_fill_coredump_seg_hdr(bp, &seg_hdr, seg_record, seg_len,
-					   rc, duration, 0);
+					   rc, duration, 0, 0, 0);
 
 		if (buf) {
 			/* Write segment header into the buffer */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
index a76d5c281413..f573e55f7e62 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
@@ -68,6 +68,8 @@ struct bnxt_coredump_record {
 	__le16 rsvd3[313];
 };
 
+#define BNXT_VER_GET_COMP_ID	2
+
 #define BNXT_CRASH_DUMP_LEN	(8 << 20)
 
 #define COREDUMP_LIST_BUF_LEN		2048
@@ -118,6 +120,11 @@ struct hwrm_dbg_cmn_output {
 #define BNXT_DBG_CR_DUMP_MDM_CFG_DDR	\
 	DBG_CRASHDUMP_MEDIUM_CFG_REQ_TYPE_DDR
 
+void bnxt_fill_coredump_seg_hdr(struct bnxt *bp,
+				struct bnxt_coredump_segment_hdr *seg_hdr,
+				struct coredump_segment_record *seg_rec,
+				u32 seg_len, int status, u32 duration,
+				u32 instance, u32 comp_id, u32 seg_id);
 int bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf, u32 *dump_len);
 int bnxt_hwrm_get_dump_len(struct bnxt *bp, u16 dump_type, u32 *dump_len);
 u32 bnxt_get_coredump_length(struct bnxt *bp, u16 dump_type);
-- 
2.30.1


