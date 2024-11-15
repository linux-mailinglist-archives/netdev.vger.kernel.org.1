Return-Path: <netdev+bounces-145315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109A9CEF30
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA4B35D88
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B0D1D5AB7;
	Fri, 15 Nov 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hawGX/Jl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6EF1D5AA4
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683789; cv=none; b=RxjwrpgTDfcL04l45mGNz0YkQHRNG9pqf0Xh9iSFYM+ME/+e2QOmUx1J0lqql2ygnW7QfG1uKy7UUbgu3pyq4em+Mff+CZ9roMl+GLk4HMFuwY8r+DFJNgDNRtatZUU/wSCtA6q6OB1K1hYrZPVsX5tp7CAiWSGuLd+VorVlkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683789; c=relaxed/simple;
	bh=JrY786zWQp16Bu3Rpm+WgoD2NekurY530EIqN/dVnbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR/RadMi0Kizt0CRFxsm+aHOTSsUhbroEIR9fmfE8JvF5iSqLffwjjvAxk0joaWp3UBCv8noNbQGdW2PrecYTUJB+s1ahqhzjpPkuCHlxrObIdozbbPWmztVUbDTp3oRB6dMWJgMr0jg2/f6ewIoPh6ZS7vIW/Dg+E54c9fAZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hawGX/Jl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20caea61132so18034135ad.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683786; x=1732288586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5I/Omefwav243Sm9OSf4ZaosNZkxs0R/8amkvBUuSA=;
        b=hawGX/JlHJ36bYoUT+sQNOt2U8/jX6zMYfsRB3NYlgUVlg+2tMG/QKjDhYNozuEU3i
         aPiNTSPnkKd4QGouBJypCkHCDpcR6c/B81cWQq6ZOtYR2/MqriSSZQKYhpZDrxvlwmKm
         zFG7P+h1fgd4a/7TVvRWeAl1BovdL7QQK1hJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683786; x=1732288586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5I/Omefwav243Sm9OSf4ZaosNZkxs0R/8amkvBUuSA=;
        b=sHSPrALyhj8ashjEvssJ3mQC/RUM/65FHcXW3KqqTZ8kpj2hOG6TTUV/iUj6LgYq1F
         Pt4Pdd56kE6LCMD1ILyWB8izJakJKzeHqJdddW0lsbgJGASuLxS6XP2JXb6jfPIJjkj3
         eIGCOG71F0QgclMELXJ+NPG3a91En2m9lUyK+0xcNNzy9qDxE7s1i7glZgJWXJacGrWo
         FXE9BQHphQCZOLZvysHmRleR3PonoXjazVtEeWk97LL41V44gDriGaUI/bgwZXvDs7aJ
         pukvMC/7Qno5t0YIxgn0YlKlbWTjyYzbc6fSgpgIXoXrf9UstgRyfEX+1QtJSFujyhOo
         6oIw==
X-Gm-Message-State: AOJu0Yz+fLo/GEPMMWUT01R8nIjMXKK/Bh1BtuPCjRhg37mq12zyofY8
	Bdpx/jRQDCPUUpZyan+pXMKkSzS2O+we7pmo46b9I/OuTMhyG+YUpl7XJvoBs/Kp8eRbk5qwJrw
	=
X-Google-Smtp-Source: AGHT+IECbKIUyzyLhe+uhBtWQImdjcpxzRFOMw8r8b/QfEEoa/X2r1T1CWOH+YOL7KLaodlxB2kujQ==
X-Received: by 2002:a17:902:dad0:b0:20e:57c8:6abd with SMTP id d9443c01a7336-211d0f0bfe6mr40409325ad.52.1731683786010;
        Fri, 15 Nov 2024 07:16:26 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:25 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	shruti.parab@broadcom.com,
	hongguang.gao@broadcom.com
Subject: [PATCH net-next v2 09/11] bnxt_en: Add 2 parameters to bnxt_fill_coredump_seg_hdr()
Date: Fri, 15 Nov 2024 07:14:35 -0800
Message-ID: <20241115151438.550106-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241115151438.550106-1-michael.chan@broadcom.com>
References: <20241115151438.550106-1-michael.chan@broadcom.com>
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


